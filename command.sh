# Create image
docker build -t ubuntu-ssh-enabled .

# Create containers
docker run -itd --name node-server1 ubuntu-ssh-enabled
docker run -itd --name node-server2 ubuntu-ssh-enabled

# Get ip containers
docker inspect -f '{{ include.social.linkedin }}' node-server1
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' node-server2

# Check connectivity
ansible node-server* -m ping -i inventory

# Run main playbook
ansible-playbook main.yml -i inventory

# Clean up
docker stop node-server1 node-server2 && docker rm node-server1 node-server2
docker rmi ubuntu-ssh-enabled

