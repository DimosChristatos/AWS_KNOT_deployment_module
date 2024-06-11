To deploy KNOT:
 - cd into the "eks" module
 - run "terraform apply"
    - This will create a basic eks configuration on aws
 - connect onto the cluster ( aws eks --region us-east-1 update-kubeconfig --name tf-cluster )
 - deploy knot (to avoid concurrency error => helmfile sync --concurrency 1)
 - on the aws console create route53 connect KNOT's ingress to your route53

 notes:
  * the eks module will ask for a role name and has some output, these are only used in the sample application below, you can add whatever as a role when deploying KNOT
  * don't forget about the concurrency bug
  * harbor's database for some reason can't right on the pgdata directory KNOT tries to create, as i work around you can edit the pod and change the path to "tmp/.../pgdata"

  To deploy sample application to prove that route53 should work:
   - after deploying the eks module as stated above
   - copy eks modules output onto "secret.tfvars"
   - run the application module by running "terraform apply --var-file="secret.tfvars"
   - manually run "ingress.yml"
   - on the aws console create route53 records that point onto the ingress from the previous step