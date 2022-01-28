#!/bin/bash
sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d 
echo "wget y onboard..."
wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh && sh onboard_agent.sh -w $LOG_ANALYTICS_WORKSPACE_ID -s $LOG_ANALYTICS_WORKSPACE_KEY -d opinsights.azure.com
echo "su omsagent..."
sudo su omsagent -c 'python /opt/microsoft/omsconfig/Scripts/PerformRequiredConfigurationChecks.py'
echo "restart control..."
/opt/microsoft/omsagent/bin/service_control restart $LOG_ANALYTICS_WORKSPACE_ID
echo "done"