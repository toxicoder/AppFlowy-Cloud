# Deploying AppFlowy-Cloud in a Homelab Environment

This guide will walk you through deploying AppFlowy-Cloud using Docker Compose in a homelab environment.

## Prerequisites

- A server with Docker and Docker Compose installed.
- Git installed on your server.
- Basic knowledge of the command line.

## 1. Clone the Repository

First, clone the AppFlowy-Cloud repository to your server:

```bash
git clone https://github.com/AppFlowy-IO/AppFlowy-Cloud.git
cd AppFlowy-Cloud
```

## 2. Configure Your Environment

AppFlowy-Cloud is configured using a `.env` file. A template is provided as `deploy.env`.

1.  **Copy the environment file:**

    ```bash
    cp deploy.env .env
    ```

2.  **Edit the `.env` file:**

    Open the `.env` file in a text editor. You will need to set the following variables:

    - `FQDN`: Set this to the domain name or IP address of your server.
    - `POSTGRES_PASSWORD`: Set a strong password for the database.

    You can also configure other options, such as SMTP for email or OAuth providers for authentication. For more details on these, see the [Authentication documentation](./AUTHENTICATION.md).

## 3. Start AppFlowy-Cloud

Once you have configured your `.env` file, you can start AppFlowy-Cloud using Docker Compose:

```bash
docker compose up -d
```

This command will download the required Docker images and start the AppFlowy-Cloud services in the background.

## 4. Verify the Deployment

You can check the status of your containers to ensure everything is running correctly:

```bash
docker ps -a
```

You should see several containers running, including `appflowy-cloud`, `gotrue`, `postgres`, and `nginx`.

## 5. Access AppFlowy-Cloud

You can now access the AppFlowy-Cloud web interface by navigating to the domain name or IP address you set in the `FQDN` variable in your web browser.
