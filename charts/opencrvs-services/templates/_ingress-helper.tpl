
{{- define "ingress-helper" -}}
{{- $service_name := .service_name }}
{{- $port := index .Values $service_name "port" }}
{{- $container_port := index .Values $service_name "container_port" | default $port }}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: {{ $service_name }}
  name: {{ $service_name }}
spec:
  ports:
    - port: {{ $port }}
      targetPort: {{ $container_port }}
  selector:
    app: {{ $service_name }}
{{- end }}
