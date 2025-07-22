{{/*
Expand the name of the chart.
*/}}
{{- define "karpenter-nodepool.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "karpenter-nodepool.fullname" -}}
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
{{- define "karpenter-nodepool.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "karpenter-nodepool.labels" -}}
helm.sh/chart: {{ include "karpenter-nodepool.chart" . }}
{{ include "karpenter-nodepool.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "karpenter-nodepool.selectorLabels" -}}
app.kubernetes.io/name: {{ include "karpenter-nodepool.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels for NodePool resources
*/}}
{{- define "nodepool.labels" -}}
{{- include "karpenter-nodepool.labels" . }}
{{- end }}

{{/*
Common labels for EC2NodeClass resources
*/}}
{{- define "labels" -}}
{{- include "karpenter-nodepool.labels" . }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "annotations" -}}
{{- if .Values.globalAnnotations }}
{{- toYaml .Values.globalAnnotations }}
{{- end }}
{{- end }}

{{/*
Common selector terms for EC2NodeClass resources
*/}}
{{- define "ec2NodeClass.commonSelectorTerms" -}}
{{- if kindIs "slice" . }}
{{- toYaml . | nindent 4 }}
{{- else }}
{{- toYaml (list .) | nindent 4 }}
{{- end }}
{{- end }}
