# Helper supports Kubernetes Gataway API: HTTPRoute
# TODO:
# 1. Implement traefik IngressRoute
# 2. Implement Kubernetes Ingress
{{- define "ingress-helper" -}}
{{- $service_name := .service_name }}
{{- $ingress_mode := .Values.ingress.mode }}
{{- $port := index .Values $service_name "port" }}
{{- if eq $ingress_mode "gateway" }}
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: {{ $service_name }}
spec:
  parentRefs:
    - name: {{ .Values.ingress.gateway.name }}
      namespace: {{ .Values.ingress.gateway.namespace }}
  hostnames:
    - {{ $service_name }}.{{ .Values.hostname }}
  rules:
    - matches:
        - path:
            # FIXME: Add with section to render multiple paths
            type: PathPrefix
            value: /
      backendRefs:
        - name: {{ $service_name }}
          port: {{ $port }}
{{- end }}
{{- end }}