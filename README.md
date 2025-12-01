# BHuman 代码部署指南

## 环境准备与部署步骤

### 1. 克隆2025代码（过程中报错的话换个节点试试）

```bash
git clone --recursive https://github.com/bhuman/BHumanCodeRelease.git
cd BHumanCodeRelease
```

### 2. 下载createRobot.sh到主目录

```bash
wget http://212.64.83.115:5244/d/ye/createRobot.sh?sign=4Bl3ulmtewVjOmyeVI1TB4ve06RXNiaIyVAVsJQuyDQ=:0
chmod +x createRobot.sh
```

### 3. 编译项目

```bash
cd Make/Linux
./generate
./compile
```

### 4. 下载root-2022-11-18.ext3.gz到Install目录（生成opn镜像需要依赖这个镜像）

```bash
cd ../../Install
wget http://212.64.83.115:5244/d/ye/root-2022-11-18.ext3.gz
```

### 5. 运行deploy脚本生成opn文件

```bash
cd ../Make/Common
./deploy Develop -i -nc -w SPL_A
```

> 生成的opn文件位于：`Build/Image/Develop/` 文件夹

### 6. 创建机器人配置

返回主目录并运行：

```bash
cd ../..
./createRobot.sh
```

---

## 制作刷机盘

### 准备工作

如果没有第一个opn文件，需要先下载：

```bash
cd Install
wget http://212.64.83.115:5244/d/ye/nao-2.8.5.11_ROBOCUP_ONLY_with_root.opn
```

### 第一步：刷入基础系统

直接刷入即可，**无需格式化U盘**，刷机会自动覆盖：

```bash
sudo ./flash nao-2.8.5.11_ROBOCUP_ONLY_with_root.opn /dev/sda
```

> ⚠️ **注意**：请确认 `/dev/sda` 是你的U盘设备，避免误操作覆盖其他磁盘！

### 第二步：刷入BHuman系统

```bash
sudo ./flash ../Build/Image/Develop/bhuman.opn /dev/sda
```

---
## 修改代码后要删除Build文件夹然后重新编译，编译之后不用制作刷机盘，deploy脚本会更新，直接部署到机器人就行

## 注意事项

- 所有命令都需要在 `BHumanCodeRelease` 目录下执行
- 确保网络连接正常，以便下载所需文件
- 刷机前请务必确认U盘设备路径，避免数据丢失
- 编译过程可能需要较长时间，请耐心等待 


