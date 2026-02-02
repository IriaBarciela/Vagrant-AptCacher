# Vagrant-AptCacher

## Arquitectura del Sistema

El entorno se compone de **5 máquinas virtuales** basadas en Debian Bookworm:

1.  **Router (R-INT):** Actúa como puerta de enlace. Configurado con `ip_forwarding` y reglas de `nftables`.
2.  **APT-Cacher (APT-C):** Servidor dedicado a cachear paquetes `.deb` para optimizar las descargas de toda la red.
3.  **Clientes (1-3):** Nodos finales configurados para salir a internet a través del Router y usar el servidor de caché.

## Especificaciones Técnicas

* **SO:** Debian Bookworm (64 bits).
* **Red Privada:** `172.16.1.0/24` (Internal Network: `E-ATP-CACHER-LAN`).
* **Provisionamiento:** Shell scripting automatizado para la configuración de:
    * Interfaces Bridge y rutas estáticas.
    * Reglas de Firewall con **NFTables**.
    * Servidor Web **Apache** y **Apt-Cacher-NG**.
    * Tareas programadas con **Crontab** y **Anacron**.

## Despliegue

### Requisitos Previos
* [VirtualBox](https://www.virtualbox.org/) instalado.
* [Vagrant](https://www.vagrantup.com/) instalado.
