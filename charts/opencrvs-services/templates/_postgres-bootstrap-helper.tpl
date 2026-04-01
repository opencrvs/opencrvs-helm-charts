{{/*
Return normalized postgres roles as YAML list.
Each item:
- name
- secretName
- usernameKey
- passwordKey
*/}}
{{- define "postgres.normalized.roles" -}}
{{- $roles := list -}}
{{- range $roleName, $roleCfg := .Values.postgres.roles }}
  {{- $roles = append $roles (dict
      "name" $roleName
      "secretName" $roleCfg.secretName
      "usernameKey" (default "username" $roleCfg.usernameKey)
      "passwordKey" (default "password" $roleCfg.passwordKey)
    ) -}}
{{- end -}}
{{- toYaml $roles -}}
{{- end -}}

{{/*
Return normalized postgres databases as YAML list.
Each item:
- name
- create
*/}}
{{- define "postgres.normalized.databases" -}}
{{- $databases := list -}}
{{- range $dbName, $dbCfg := .Values.postgres.databases }}
  {{- $databases = append $databases (dict
      "name" $dbName
      "create" (default true $dbCfg.create)
    ) -}}
{{- end -}}
{{- toYaml $databases -}}
{{- end -}}

{{/*
Return normalized postgres schemas as YAML list.
Each item:
- database
- schema
- appRole
- migratorRole
- ownerRole
- runMigrations
*/}}
{{- define "postgres.normalized.schemas" -}}
{{- $schemas := list -}}
{{- range $dbName, $dbCfg := .Values.postgres.databases }}
  {{- range $schemaName, $schemaCfg := $dbCfg.schemas }}
    {{- $schemas = append $schemas (dict
        "database" $dbName
        "schema" $schemaName
        "appRole" $schemaCfg.appRole
        "migratorRole" $schemaCfg.migratorRole
        "ownerRole" $schemaCfg.ownerRole
        "runMigrations" (default false $schemaCfg.runMigrations)
      ) -}}
  {{- end -}}
{{- end -}}
{{- toYaml $schemas -}}
{{- end -}}

{{/*
Return normalized postgres customAccess entries as YAML list.
Each item:
- role
- database
- schema
- schemaGrants
- tables
- views
*/}}
{{- define "postgres.normalized.customAccess" -}}
{{- $items := list -}}
{{- range $entry := .Values.postgres.customAccess }}
  {{- $items = append $items (dict
      "role" $entry.role
      "database" $entry.database
      "schema" $entry.schema
      "schemaGrants" (default (list) $entry.grants.schema)
      "tables" (default (dict) $entry.tables)
      "views" (default (dict) $entry.views)
    ) -}}
{{- end -}}
{{- toYaml $items -}}
{{- end -}}

{{/*
Return normalized postgres customGrantSql entries as YAML list.
Each item:
- role
- database
- sql
*/}}
{{- define "postgres.normalized.customGrantSql" -}}
{{- $items := list -}}
{{- range $entry := .Values.postgres.customGrantSql }}
  {{- $items = append $items (dict
      "role" $entry.role
      "database" $entry.database
      "sql" $entry.sql
    ) -}}
{{- end -}}
{{- toYaml $items -}}
{{- end -}}