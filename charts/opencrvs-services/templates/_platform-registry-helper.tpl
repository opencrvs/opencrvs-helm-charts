{{/*
Usage:
image: {{ include "opencrvs.image" (dict "root" . "service" .Values.auth) }}

FIXME: Remove after v2.1

Legacy fallback to `.Values.image.*` (deprecated) can be removed
once all configuration files are migrated to use `platform.*`.

At that point, simplify helper input and resolution logic to:

image: {{ include "opencrvs.image" (dict
  "platform" .Values.platform
  "service" .Values.auth
) }}

and remove fallback to:
- .Values.image.tag
- .Values.imagePullSecrets

This will reduce complexity and make precedence rules explicit.
*/}}

{{/*
Build full container image reference for an OpenCRVS service.

Resolution order (highest priority first):
1. Service-specific image overrides (.service.image.*)
2. Platform defaults (.Values.platform.*)
3. Deprecated legacy fields (.Values.image.*) — temporary fallback

Expected service values structure:
<service>:
  image:
    name: <required>               # image name, e.g. ocrvs-auth
    tag: <optional>               # overrides platform.tag
    registry: <optional>          # overrides platform.registry
    repository: <optional>        # overrides platform.repository

Platform defaults:
platform:
  registry: ghcr.io
  repository: opencrvs
  tag: v1.x.x

Example output:
ghcr.io/opencrvs/ocrvs-auth:v1.9.11

Note:
- repository = namespace/org (NOT full image path)
- imagePullSecrets are handled at Pod spec level, not here
*/}}
{{- define "opencrvs.image" -}}
{{- $root := .root -}}
{{- $svc := .service -}}

{{- $tag := $svc.image.tag | default $root.Values.platform.tag | default $root.Values.image.tag -}}
{{- $registry := $svc.image.registry | default $root.Values.platform.registry -}}
{{- $repository := $svc.image.repository | default $root.Values.platform.repository -}}
{{- $name := required "service image.name is required" $svc.image.name -}}

{{- printf "%s/%s/%s:%s" $registry $repository $name $tag -}}
{{- end -}}
