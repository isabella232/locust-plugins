#!/bin/bash
ds=(10878 14423 14422 15419);
for d in "${ds[@]}"; do
  echo -n "Processing $d: "
  j=$(curl -H "Authorization: Bearer $GRAFANA_CRED" $GRAFANA_HOST/api/gnet/dashboards/$d | jq .json)
  curl -H "Authorization: Bearer $GRAFANA_CRED" -XPOST -H "Accept: application/json"\
    -H "Content-Type: application/json"\
    -d "{\"dashboard\":$j,\"overwrite\":$GRAFANA_OVERWRITE,\"inputs\":[{\"name\":\"DS_LOCUST\",\"type\":\"datasource\", \"pluginId\":\"postgres\",\"value\":\"$DS_NAME\"}]}"\
    $GRAFANA_HOST/api/dashboards/import; echo ""
done
