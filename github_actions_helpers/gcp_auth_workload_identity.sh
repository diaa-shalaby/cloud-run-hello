# Credits: https://github.com/google-github-actions/auth?tab=readme-ov-file#direct-wif

export PROJECT_ID="cloudpilotsinterview"
export REPO="diaa-shalaby/cloud-run-hello"
export WORKLOAD_IDENTITY_POOL_ID="projects/409164299281/locations/global/workloadIdentityPools/github/providers/cloud-run-hello-repo"

# TODO: replace ${PROJECT_ID} with your value below.
gcloud iam workload-identity-pools create "github" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="GitHub Actions Pool"

# TODO: replace ${PROJECT_ID} with your value below.
gcloud iam workload-identity-pools describe "github" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --format="value(name)"

gcloud secrets add-iam-policy-binding "my-secret" \
  --project="${PROJECT_ID}" \
  --role="roles/secretmanager.secretAccessor" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${REPO}"
