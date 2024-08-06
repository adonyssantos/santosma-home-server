# Server setup automation with Ansible

Ansible is a configuration management tool that allows to automate the configuration of multiple servers.`

## Installation

```bash
sudo apt update
sudo apt install ansible
```

## Usage

```bash
ansible-playbook -i hosts setup.yml
```

- `hosts`: The inventory file with the hosts to configure.
- `setup.yml`: The playbook file with the tasks to execute.

## References

- <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html>
