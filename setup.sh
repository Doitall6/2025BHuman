#!/bin/bash

# BHuman 代码部署自动化脚本
# 使用方法: ./setup.sh

set -e  # 遇到错误立即退出

echo "======================================"
echo "BHuman 代码部署自动化脚本"
echo "======================================"



echo ""
echo "[步骤 1/5] 克隆2025代码..."
echo "检测到未克隆代码，开始克隆..."
if [ ! -d "BHumanCodeRelease/.git" ]; then
    echo "检测到未克隆代码，开始克隆..."
    git clone --recursive https://github.com/bhuman/BHumanCodeRelease.git
    cd BHumanCodeRelease
else
    echo "代码已存在，跳过克隆步骤"
    cd "BHumanCodeRelease"
fi
echo ""
echo "[步骤 2/5] 下载createRobot.sh到主目录..."
wget http://212.64.83.115:5244/d/ye/createRobot.sh
chmod +x createRobot.sh
echo "createRobot.sh 下载完成"
echo ""
echo "[步骤 3/5] 编译项目..."
cd Make/Linux && pwd

echo "正在生成构建文件..."
./generate
echo "正在编译..."
./compile

echo ""
echo "[步骤 4/5] 下载root-2022-11-18.ext3.gz到Install目录..."
cd "../../Install"
wget http://212.64.83.115:5244/d/ye/root-2022-11-18.ext3.gz

echo ""
echo "[步骤 5/5] 运行deploy脚本生成opn文件..."
cd "../Make/Common"
./deploy Develop -i -nc -w SPL_A

cd ../../ && ./createRobot.sh
