# Installing and using Docker

## What is Docker?
<style>
p { text-indent: 2em }
</style>
<p> Docker is an incredibly useful piece of software. Docker describes itself "simply", saying that it "is a containerization technology that enables us to cleanly abstract an environment configuration to a file (or set of files), and run it in a protected, isolated environment on a host."<sup><a href="https://runnable.com/docker/what-is-docker">[1]</a></sup> </p>

<p> In even simpler terms and within the context that you will be working with it, Docker essentially allows users to create separate environments where all your dependencies are set up. This is advantageous for a number of reasons: adding dependencies is made much easier, as is managing their versions. But perhaps the most immediately obvious benefit is the reduced time needed to set yourself up to work on the app!
</p>

<p> Docker builds <strong> containers </strong> (the isolated environments your code will run in) from <strong> images </strong>(essentially the blueprint for the containers). When you're setting up an app using Docker, you will typically have to run only a couple of commands, one to build the containers, and one to setup databases (some projects may require you to run more, but they should all be relatively simple). But first, you need Docker installed on your machine.
</p>

## Installing Docker

### Windows (10 or later)

To use docker on your windows machine you will need Microsoft's Hyper-V.

These steps are taken from the <a href="https://runnable.com/docker/install-docker-on-windows-10"> official Docker Installation Guide</a>.

<ol>


    <li>Double-click Docker Desktop for Windows Installer.exe to run the installer.</li>

    If you haven’t already downloaded the installer (Docker Desktop Installer.exe), you can get it from <a href="https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe">download.docker.com</a>. It typically downloads to your Downloads folder, or you can run it from the recent downloads bar at the bottom of your web browser.

    <li>Follow the install wizard to accept the license, authorize the installer, and proceed with the install.</li>

    <li>You are asked to authorize Docker.app with your system password during the install process. Privileged access is needed to install networking components, links to the Docker apps, and manage the Hyper-V VMs.</li>

    <li>Click Finish on the setup complete dialog to launch Docker.</li>

</ol>


### Mac (2010 models or later, El Capitan 10.11 or later)

<a href="https://download.docker.com/mac/stable/Docker.dmg">Download Docker's DMG file.</a>

<ol>
<li>Double click the dmg file. Drag the whale icon (his official name is Moby) to the Applications folder.</li>
<li>Double click Docker.app.</li>
<li>You should see a small whale icon in your tool bar.</li>
</ol>

### Using Docker Containers.

<p> Now that Docker is installed, we can begin to use containers. This is a typical procedure to start a Dockerized app. After you clone down your desired git repo and ensure that the Dockerfile and/or docker-compose.yml file.</p>

<ul>Some basic commands:
 <li>To build a new container: `docker-compose up -d`</li>
 <li>To see built containers: `docker-compose ps`</li>
 <li>To stop containers: `docker-compose stop [CONTAINER]`</li>
 <li>To remove all containers: `docker-compose down`</li>
</ul>
