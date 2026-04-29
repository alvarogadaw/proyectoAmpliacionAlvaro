Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  # Acceso a WordPress desde el navegador del host
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Configuración de la máquina virtual
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  # Provision: instala Docker, Docker Compose y despliega WordPress
  config.vm.provision "shell", path: "provision.sh"
end
