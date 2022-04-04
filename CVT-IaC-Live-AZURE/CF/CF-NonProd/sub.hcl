locals {
    subscription_id = data.sops_file.secrets.data["azure.azsubscription_id"]
}
