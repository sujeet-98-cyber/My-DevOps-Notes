# ELK Stack Setup on Kubernetes (ECK)

## 📥 Step 1: Clone / Create Files

Either:

* Clone from Git repository
  **OR**
* Manually create the above YAML files

---

## ⚙️ Step 2: Install ECK (Elastic Operator)

```bash
kubectl create -f https://download.elastic.co/downloads/eck/2.2.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.2.0/operator.yaml
```

---

## 🏗️ Step 3: Deploy ELK Stack

### 1. Create Namespace

```bash
kubectl apply -f namespace.yaml
```

---

### 2. Deploy All Components

```bash
kubectl apply -f elasticsearch.yaml
kubectl apply -f kibana.yaml
kubectl apply -f filebeat-rbac.yaml
kubectl apply -f filebeat.yaml
kubectl apply -f logstash-config.yaml
kubectl apply -f logstash.yaml
kubectl apply -f ingress.yaml
```

---

## ✅ Step 4: Verify Deployment

```bash
kubectl get pods -n elk
```

Expected:

* Elasticsearch → Running
* Kibana → Running
* Filebeat → Running
* Logstash → Running

---

## 🔐 Step 5: Get Elasticsearch Password

```bash
kubectl get secret -n elk quickstart-es-elastic-user \
-o=jsonpath='{.data.elastic}' | base64 --decode; echo
```

---

## 🌐 Step 6: Configure DNS / Hosts

### On Local Machine:

Edit hosts file:

```bash
C:\Windows\System32\drivers\etc\hosts
```

```bash
<INGRESS-IP> elk.local
```

Example:

```bash
172.16.106.41 elk.local
```

---

### On Kubernetes Master Node:

```bash
vi /etc/hosts
```

Add:

```bash
172.16.106.41 elk.local
```

---

## 🚀 Step 7: Access Kibana

Open in browser:

```bash
https://elk.local
```

---

## 🔑 Login Credentials

* **Username:** elastic
* **Password:** (use command from Step 5)

---

## ⚠️ Notes

* Kibana requires **HTTPS** (self-signed certificate)
* Accept browser warning to proceed
* Ensure ingress controller is running

---

## 🎯 Outcome

You will get:

* Centralized logging (Filebeat → Logstash → Elasticsearch)
* Visualization via Kibana Dashboard

---

## 🛠️ Troubleshooting

```bash
kubectl get pods -n elk
kubectl logs -n elk <pod-name>
kubectl describe pod -n elk <pod-name>
```

---

## 📌 Access Summary

| Component     | URL                  |
| ------------- | -------------------- |
| Kibana        | https://elk.local    |
| Elasticsearch | Internal (ClusterIP) |
| Logstash      | Internal Service     |

---

## 🚀 Completed ELK Stack on Kubernetes using ECK
