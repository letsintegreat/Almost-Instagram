<p  align="center">
<a  href="https://flutter.dev"  target="_blank"><img  height="39"  src="https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png"  alt="Flutter Logo"></a> <a>&nbsp;&nbsp;&nbsp;</a>
<a  href="https://appwrite.io"  target="_blank"><img  width="260"  height="39"  src="https://appwrite.io/images/github-logo.png"  alt="Appwrite Logo"></a>
</p>

# Almost Instagram

A functional clone of Instagram made using Flutter and Appwrite.

## Features

- UI identical to Instagram (Pages: Launch, Login, Signup, Feed, Explore, New post, Profile).
- Authentication (Login & Signup).
- Post an image with caption.
- Users can see each others' posts.
- Appwrite is used to authenticate users, upload pictures, and store database of posts.

## Screenshots

| <img src = ".github\assets\SS-1.png" height = "500">   | <img src = ".github\assets\SS-2.png" height = "500">   |  <img src = ".github\assets\SS-3.png" height = "500">  |
|:-: |:-: |--- |
|  <img src = ".github\assets\SS-4.png" height = "500">  |  <img src = ".github\assets\SS-5.png" height = "500">  |   <img src = ".github\assets\SS-6.png" height = "500"> |
| <img src = ".github\assets\SS-7.png" height = "500">   |  <img src = ".github\assets\SS-8.png" height = "500">  | <img src = ".github\assets\SS-9.png" height = "500">    |
|    |    |    |

And no, these screenshots are not of the actual Instagram app lol

## Installation

### Appwrite

Appwrite backend server is designed to run in a container environment. Running your server is as easy as running one command from your terminal. You can either run Appwrite on your localhost using docker-compose or on any other container orchestration tool like Kubernetes, Docker Swarm or Rancher.

The easiest way to start running your Appwrite server is by running our docker-compose file. Before running the installation command make sure you have [Docker](https://www.docker.com/products/docker-desktop) installed on your machine:

### Unix

```bash
docker run -it --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume "$(pwd)"/appwrite:/usr/src/code/appwrite:rw \
    --entrypoint="install" \
    appwrite/appwrite:1.0.1
```

### Windows

#### CMD

```cmd
docker run -it --rm ^
    --volume //var/run/docker.sock:/var/run/docker.sock ^
    --volume "%cd%"/appwrite:/usr/src/code/appwrite:rw ^
    --entrypoint="install" ^
    appwrite/appwrite:1.0.1
```

#### PowerShell

```powershell
docker run -it --rm ,
    --volume /var/run/docker.sock:/var/run/docker.sock ,
    --volume ${pwd}/appwrite:/usr/src/code/appwrite:rw ,
    --entrypoint="install" ,
    appwrite/appwrite:1.0.1
```

Once the Docker installation completes, go to <http://localhost> to access the Appwrite console from your browser. Please note that on non-linux native hosts, the server might take a few minutes to start after installation completes.

For advanced production and custom installation, check out our Docker [environment variables](docs/tutorials/environment-variables.md) docs. You can also use our public [docker-compose.yml](https://appwrite.io/docker-compose.yml) file to manually set up and environment.

## Setting up appwrite project

### Flutter

To build and run this project:

1. Get Flutter [here](https://docs.flutter.dev/get-started/install) if you don't already have it
2. Clone this repository
3. `cd` into the repo folder
4. Run `flutter pub get` to get the dependencies
5. Run `flutter run-android` or `flutter run-ios` to build the app

(Please note that a Mac with XCode is required to build for iOS)

### Appwrite

To setup your Appwrite project:

1. Open your browser and go to your <http://localhost>
2. Create your account and login.
3. Click on `Create Project`.
4. Enter a Name and custom Project ID for your project and click create.

At this moment your Dashboard is ready to use.

### Setup Project Dashboard

We need to setup some collections and need to define its attributes so our app will be ready to use.

Firstly, in your appwrite console, head to Database tab. Click on Add Database, give it any name. After that add a new collection, this collection will store all the posts. Now, inside this collection, open Attributes tab. Add three string type required attributes with names: **username**, **caption**, **imageId**.

Secondly, head to Storage tab. Click on Add Bucket. This will store the images uploaded by users.

Now the setup on console is completed, and you need to make some changes in `lib/utils/api.dart`:

- **url**: This is the endpoint URL. If you are testing the app on an android studio emulator and appwrite is configured on localhost, then you don't need to change it. Otherwise, you will need to change the hostname to the URL that you set while initiating appwrite.

- **projectID**: can be found in project settings, in appwrite console.

- **databaseId**: can be found in collection settings, inside database tab, in appwrite console.

- **collectionId**: can be found in collection settings, inside database tab, in appwrite console.

- **bucketId**: can be found bucket settings, inside storage tab, in appwrite console.

**Now your Project is ready to run.**

## File Structure

```bash
.
├── android # android files
├── assets # assets (images)
├── ios # ios files
└── lib
    ├── models # Custom Models
    ├── screens
    │   └── home_tabs # Tabs for home screen
    ├── utils # Api info
    └── widgets # Custom widgets
```