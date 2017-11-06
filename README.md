# bxcr

bxcr is a small Apprenda Cloud Platform environment that can be brought up using Vagrant.

## Prerequisites

These are the versions this has been tested on, but it _should_ work with any recent version of Vagrant and VirtualBox
* Vagrant 2.0.1
* VirtualBox 5.2

You should have at least *16 GB* of RAM available to run these boxes.

## Usage
1. Clone this repository.
2. Run `vagrant up` from the root of the code checkout. If this is your first time running it, it may take some time as Vagrant must pull a few gigabytes of base images.
3. To add a Linux node to your Apprenda Cloud, run `vagrant up apprenda-linux`.
4. To add a Kubernetes cluster to your Apprenda Cloud, run `vagrant up apprenda-k8s`.
5. Add entries to your system hosts file to enable you to access the VM by name:  
```
172.16.0.10     apprenda.bxcr
172.16.0.10     www.apprenda.bxcr
172.16.0.10     apps.apprenda.bxcr
```
6. Log on to your new instance at `https://apps.apprenda.bxcr`. The default account is `bxcr@apprenda.com` with a password of `password`.

## Notes

* "Why did Chef randomly fail to install something on Windows?" Let us know the details, but you can generally re-run the provisioning step with `vagrant provision` to retry.

* To avoid your browser complaining about not trust, you can install `/certs/root.cer` into your system store.

* For information on how to use Apprenda, please see our documentation at https://docs.apprenda.com. 

* Information on using Vagrant can be found at https://www.vagrantup.com/docs/index.html.

* You can SSH to either the Windows or Linux machine by using `vagrant ssh` and the machine name, for example, `vagrant ssh apprenda-windows` or `vagrant ssh apprenda-linux`. For a graphical session, you can `vagrant rdp apprenda-windows`. The machine username and password for both nodes is `vagrant`.

## Questions or Problems?

Please file a GitHub issue for any questions you may have, or problems you encounter using `bxcr`.

## Contributing

We gladly accept pull requests! Requests will be reviewed by our team. We encourage you to use this as a base for further automation with your own ACP installs.