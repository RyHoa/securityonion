base:
  '*':
    - patch.needs_restarting
    - ntp.soc_ntp
    - ntp.adv_ntp
    - logrotate
    - docker.soc_docker
    - docker.adv_docker
    - sensoroni.soc_sensoroni
    - sensoroni.adv_sensoroni

  '* and not *_eval and not *_import':
    - logstash.nodes

  '*_eval or *_helixsensor or *_heavynode or *_sensor or *_standalone or *_import':
    - match: compound
    - zeek

  '*_managersearch or *_heavynode':
    - match: compound
    - logstash
    - logstash.manager
    - logstash.search
    - elasticsearch.index_templates

  '*_manager':
    - logstash
    - logstash.manager
    - elasticsearch.index_templates

  '*_manager or *_managersearch':
    - match: compound
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/elasticsearch/auth.sls') %}
    - elasticsearch.auth
    {% endif %}
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/kibana/secrets.sls') %}
    - kibana.secrets
    {% endif %}
    - secrets
    - soc_global
    - adv_global
    - manager.soc_manager
    - manager.adv_manager
    - soc.soc_soc
    - soc.adv_soc
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}

  '*_sensor':
    - healthcheck.sensor
    - soc_global
    - adv_global
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}

  '*_eval':
    - secrets
    - healthcheck.eval
    - elasticsearch.index_templates
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/elasticsearch/auth.sls') %}
    - elasticsearch.auth
    {% endif %}
    - kibana.secrets
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/kibana/secrets.sls') %}
    - soc_global
    {% endif %}
    - elasticsearch.soc_elasticsearch
    - manager.soc_manager
    - soc.soc_soc
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}

  '*_standalone':
    - logstash
    - logstash.manager
    - logstash.search
    - logstash.soc_logstash
    - elasticsearch.index_templates
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/elasticsearch/auth.sls') %}
    - elasticsearch.auth
    {% endif %}
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/kibana/secrets.sls') %}
    - kibana.secrets
    {% endif %}
    - secrets
    - healthcheck.standalone
    - soc_global
    - kratos.soc_kratos
    - elasticsearch.soc_elasticsearch
    - manager.soc_manager
    - soc.soc_soc
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}

  '*_heavynode':
    - elasticsearch.auth
    - soc_global
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}

  '*_idh':
    - soc_global
    - adv_global
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}

  '*_searchnode':
    - logstash
    - logstash.search
    - elasticsearch.index_templates
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/elasticsearch/auth.sls') %}
    - elasticsearch.auth
    {% endif %}
    - soc_global
    - adv_global
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}
    - data.nodestab

  '*_receiver':
    - logstash
    - logstash.receiver
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/elasticsearch/auth.sls') %}
    - elasticsearch.auth
    {% endif %}
    - soc_global
    - adv_global
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}

  '*_import':
    - secrets
    - elasticsearch.index_templates
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/elasticsearch/auth.sls') %}
    - elasticsearch.auth
    {% endif %}
    {% if salt['file.file_exists']('/opt/so/saltstack/local/pillar/kibana/secrets.sls') %}
    - kibana.secrets
    {% endif %}
    - soc_global
    - adv_global
    - manager.soc_manager
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}

  '*_workstation':
    - minions.{{ grains.id }}
    - minions.adv_{{ grains.id }}
