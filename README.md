- when you demo creating a docker image on your dev machine, mention that
it is an arm64 arch and that the task definition specifies this as a setting.
If you do not want to specify this setting in task defn then you have to use "docker build --platform ".

I also create the ECR repo manually , no template for that...yet


- make sure CW log group exists befpre /ecs/my-nginx-task

- execute cluster template first
- task definition second
- service last (takes time, since ALB)
