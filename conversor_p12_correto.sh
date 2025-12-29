#!/bin/bash

echo "========================================"
echo "   CONVERSOR P12 PARA PEM - VERSÃO SEGURA"
echo "========================================"
echo ""

# Verificar se o openssl está instalado
if ! command -v openssl &> /dev/null; then
    echo "ERRO: OpenSSL não está instalado!"
    echo "Instale com: sudo apt install openssl"
    exit 1
fi

# Listar arquivos .p12 disponíveis
echo "Arquivos .p12 encontrados no diretório atual:"
echo "--------------------------------------------"
ls -la *.p12 2>/dev/null || echo "Nenhum arquivo .p12 encontrado"
echo ""

# Pedir nome do arquivo
echo "Digite o nome COMPLETO do arquivo .p12 (com .p12):"
read -r p12_file

# Verificar se arquivo existe
if [ ! -f "$p12_file" ]; then
    echo "ERRO: Arquivo '$p12_file' não existe!"
    echo "Certifique-se de digitar: $p12_file.p12"
    exit 1
fi

# Nome do arquivo de saída
pem_file="${p12_file%.p12}_converted.pem"

echo ""
echo "⚠️  IMPORTANTE: Este certificado pode exigir tratamento especial"
echo ""
echo "Escolha o método de conversão:"
echo "1) Método padrão (sem -nodes)"
echo "2) Método sem criptografia (com -nodes)"
echo "3) Extrair partes separadamente"
read -r -p "Opção [1/2/3]: " metodo

case $metodo in
    1)
        echo "Método 1: Exportação padrão (pode pedir nova senha)"
        openssl pkcs12 -in "$p12_file" -out "$pem_file"
        ;;
    2)
        echo "Método 2: Exportação sem criptografia da chave privada"
        openssl pkcs12 -in "$p12_file" -out "$pem_file" -nodes
        ;;
    3)
        echo "Método 3: Extrair certificado e chave separadamente"
        openssl pkcs12 -in "$p12_file" -clcerts -nokeys -out "certificado_${p12_file%.p12}.pem"
        openssl pkcs12 -in "$p12_file" -nocerts -out "chave_${p12_file%.p12}.pem" -nodes
        echo "✅ Certificado e chave extraídos em arquivos separados"
        exit 0
        ;;
    *)
        echo "Opção inválida, usando método padrão..."
        openssl pkcs12 -in "$p12_file" -out "$pem_file"
        ;;
esac

# Verificar resultado
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ CONVERSÃO BEM-SUCEDIDA!"
    echo "Arquivo: $pem_file"
    echo ""
    echo "📄 Visualizar conteúdo (primeiras 10 linhas):"
    head -10 "$pem_file"
else
    echo ""
    echo "❌ FALHA NA CONVERSÃO"
    echo ""
    echo "Possíveis causas:"
    echo "1. Senha incorreta"
    echo "2. Certificado corrompido"
    echo "3. Certificado exige método específico"
    echo ""
    echo "📋 Para ver erro detalhado, execute manualmente:"
    echo "openssl pkcs12 -in \"$p12_file\" -info"
fi
