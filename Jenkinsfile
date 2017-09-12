#!/usr/bin/groovy
@Library('github.com/fabric8io/fabric8-pipeline-library@v2.2.311')
def utils = new io.fabric8.Utils()

def createKubernetesJson(config) {
	def expose = 'true'
	def yaml
    def requestCPU = '0'
    def requestMemory = '0'
    def limitCPU = '0'
    def limitMemory = '0'
    def icon = 'https://cdn.rawgit.com/fabric8io/fabric8/dc05040/website/src/images/logos/nodejs.svg'
    def imageName = config.imageName
    def version = config.version
    def port = config.port
	def list = """
---
apiVersion: v1
kind: List
items:
"""

def service = """
- apiVersion: v1
  kind: Service
  metadata:
    annotations:
      fabric8.io/iconUrl: ${icon}
    labels:
      provider: fabric8
      project: ${env.JOB_NAME}
      expose: '${expose}'
      version: ${version}
      group: quickstart
    name: ${env.JOB_NAME}
  spec:
    ports:
    - port: 80
      protocol: TCP
      targetPort: ${port}
    selector:
      project: ${env.JOB_NAME}
      provider: fabric8
      group: quickstart
    type: LoadBalancer	  
"""

def deployment = """
- apiVersion: extensions/v1beta1
  kind: Deployment
  metadata:
    annotations:
      fabric8.io/iconUrl: ${icon}
    labels:
      provider: fabric8
      project: ${env.JOB_NAME}
      version: ${version}
      group: quickstart
    name: ${env.JOB_NAME}
  spec:
    replicas: 1
    selector:
      matchLabels:
        provider: fabric8
        project: ${env.JOB_NAME}
        group: quickstart
    template:
      metadata:
        labels:
          provider: fabric8
          project: ${env.JOB_NAME}
          version: ${version}
          group: quickstart
      spec:
        containers:
        - env:
          - name: KUBERNETES_NAMESPACE
            valueFrom:
              fieldRef:
                fieldPath: metadata.namespace
          image: ${imageName}:${version}
          imagePullPolicy: IfNotPresent
          name: ${env.JOB_NAME}
          ports:
          - containerPort: ${port}
            name: http
          resources:
            limits:
              cpu: ${requestCPU}
              memory: ${requestMemory}
            requests:
              cpu: ${limitCPU}
              memory: ${limitMemory}
        terminationGracePeriodSeconds: 2
"""

    yaml = list + service + deployment

  echo 'using resources:\n' + yaml
  return yaml
  
  }

clientsNode(clientsImage:'fabric8/builder-clients:0.11'){
  def envStage = utils.environmentNamespace('staging')
  def envProd = utils.environmentNamespace('production')
  def newVersion = '1.0'
  def clusterImageName = "dockerhub.accenture.com/varun.dhanraj.mishra/${env.JOB_NAME}"

  // You probably have to change this to your git location
  git 'https://github.com/varundmishra/fabric8sb.git'

  stage 'Canary release'
  echo 'NOTE: running pipelines for the first time will take longer as build and base docker images are pulled onto the node'
  // if (!fileExists ('Dockerfile')) {
  //  writeFile file: 'Dockerfile', text: 'FROM node:5.3-onbuild'
  //}

  // newVersion = performCanaryRelease {}
  newVersion = getNewVersion {}

  container('clients') {

	 env.setProperty('VERSION', newVersion)
	 echo 'Building Docker Image'
  	 def newImageName = "${clusterImageName}:${newVersion}"	
	 //sh "cat /home/jenkins/.docker/config.json"
	 sh "docker build -t ${newImageName} . -f Dockerfile.springboot ."
	 //sh "docker build -t ${newImageName} ."
	 //sh "docker push"
	 sh "curl -v --unix-socket /var/run/docker.sock -X POST  -d \"\" -H \"X-Registry-Auth: eyAidXNlcm5hbWUiOiAidmFydW4uZGhhbnJhai5taXNocmEiLCAicGFzc3dvcmQiOiAiQWNjQGp1bDIwMTciIH0K\"  http:/v1.23/images/${clusterImageName}/push?tag=${newVersion}"
  }

  def rc = createKubernetesJson(
	port: 80,
	label: 'node',
	icon: 'https://cdn.rawgit.com/fabric8io/fabric8/dc05040/website/src/images/logos/nodejs.svg',
	version: newVersion,
	imageName: clusterImageName
  )
  
//    port = 80
//    label = 'node'
//    icon = 'https://cdn.rawgit.com/fabric8io/fabric8/dc05040/website/src/images/logos/nodejs.svg'
//    version = newVersion
//    imageName = clusterImageName


//  def rc = getKubernetesJson {
//    port = 80
//    label = 'node'
//    icon = 'https://cdn.rawgit.com/fabric8io/fabric8/dc05040/website/src/images/logos/nodejs.svg'
//    version = newVersion
//    imageName = clusterImageName
//  }

  stage 'Rollout Staging'
  kubernetesApply(file: rc, environment: envStage, version:newVersion)

  stage 'Approve'
  approve{
    room = null
    version = newVersion
    console = fabric8Console
    environment = envStage
  }

  stage 'Rollout Production'
  kubernetesApply(file: rc, environment: envProd, version:newVersion)

}