{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "service.name" -}}
{{- required "A valid name is required!" .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "service.labels" -}}
{{ include "service.selectorLabels" . }}
app.kubernetes.io/version: {{ required "A valid image tag is required!" .Values.image.tag }}
app.kubernetes.io/component: {{ include "service.name" . }}
app.kubernetes.io/part-of: {{ required "A valid system name is required!" .Values.partOf }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "service.chart" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Environment Variables
*/}}
{{- define "service.env" -}}
{{- range $key, $value := .env }}
- name: {{ $key }}
  value: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Ingress hosts
*/}}
{{- define "ingress.hosts" -}}
{{- range .hosts }}
- host: {{ .host}}
  http:
    paths:
      {{- include "ingress.paths" (dict "paths" .paths) | indent 6 }}
{{- end }}
{{- end }}

{{/*
Ingress HTTP paths
*/}}
{{- define "ingress.paths" -}}
{{- range .paths }}
- path: {{ .path }}
  pathType: {{ .pathType }}
  backend:
    service:
      name: query-service
      port:
        name: service
{{- end }}
{{- end }}
