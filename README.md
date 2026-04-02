<p align="center">
  <img src="https://img.shields.io/badge/OpenSSL-005085?style=for-the-badge&logo=openssl&logoColor=white" alt="OpenSSL">
  <img src="https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white" alt="PHP">
  <img src="https://img.shields.io/badge/Security-Encrypted-yellow?style=for-the-badge" alt="Security">
</p>

<h1 align="center">🔐 Conversor de Certificados .P12</h1>

<p align="center">
  <strong>Script utilitário para extração de Chaves Privadas e Certificados Públicos a partir de arquivos PKCS#12 (.p12).</strong>
</p>

---

## 📝 Sobre o Projeto

Muitas APIs de pagamento e serviços de segurança exigem certificados no formato `.pem` ou `.key`, mas fornecem apenas o arquivo `.p12`. Este projeto facilita a conversão e extração desses arquivos de forma segura, utilizando o **OpenSSL**.

### 🛠️ O que este conversor faz?

- **Extração de Chave Privada:** Converte o `.p12` para `.key`.
- **Extração de Certificado:** Converte o `.p12` para `.crt` ou `.pem`.
- **Remoção de Senhas:** Opção para gerar arquivos sem senha para uso em servidores automatizados (Nginx/Apache).
- **Compatibilidade:** Ideal para certificados de APIs de Bancos e Gateways de Pagamento.

---

## 🚀 Como Utilizar

### Pré-requisitos
* **OpenSSL** instalado no sistema (Linux, macOS ou Windows via Git Bash).
* PHP (caso esteja usando o script wrapper contido no repositório).

### Comandos Básicos (Terminal)

Se você estiver usando o OpenSSL diretamente, aqui estão os comandos base documentados neste guia:

1. **Extrair a Chave Privada (Private Key):**
   ```bash
   openssl pkcs12 -in certificado.p12 -nocerts -out chave_privada.key -nodes
