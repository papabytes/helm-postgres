{{/*
Expand the name of the chart.
*/}}
{{- define "microk8s-postgres.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "microk8s-postgres.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "microk8s-postgres.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "microk8s-postgres.labels" -}}
helm.sh/chart: {{ include "microk8s-postgres.chart" . }}
{{ include "microk8s-postgres.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Postgres Selector labels
*/}}
{{- define "microk8s-postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.postgresImage.deploymentName }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
PgAdmin Selector labels
*/}}
{{- define "microk8s-pgadmin.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.pgadminImage.deploymentName }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "microk8s-postgres.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "microk8s-postgres.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
