Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9C2571D7
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318171; cv=none; b=YZ9XUoqaGFEwLlaHx5fFbdWMGKyubxwHgfgJbxhIEXlAWxxdHhs20yfZzFmbeytak7AS+2pvq0qlFjySGv66dUoUorYccIxBJii89RjNSJW8f4PVxpHoV+rFAR1QRL4iDnT2TV2eBTa//NSZEQqR/O4ms0Vk3Rd8LJo4MVTI5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318171; c=relaxed/simple;
	bh=7VXCIwC2WWUfEqw69jVC3pzRqurBPdrZhwh/T5OjC7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EkXoxj8XO8y3e8Ie1C8ZIiOrXuIOoKJzf5lAwokXJ+6C7hnOszVUA4SzRNSM5YQkVo2DaozCPwaGPvSm5cipqh52/ML/V6y01SiqTApW+vBMgvIzbb1KFbxg9DasoHugx1++8Pg4hWtOUAPPb2kz5YVVHtQV+d0gt9CqStx5WFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BwoGYC2Y; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BwoGYC2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KL
	SGc0GvhmbsivmRghIIGbHrdgspzaAG1AOSXQ7eJck=; b=BwoGYC2YlEhOEZfSnD
	tKe6T5kSoOXmc8WF3SvLK6xiKjvqtOeIDRNnWzMZSvkfEt31mWv424521oDPeen1
	kCS4OW87kmCs7dutAT82kxCBhqcbH69bCbkTUB4aRTuYAsFBhbt6/VQJhlquTjIb
	Zi5x+kI2sx6gqtPfhfNgb3MBQ=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3IXW28MFp8kcxBA--.14867S2;
	Tue, 24 Mar 2026 10:02:31 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: kvm@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH kvmtool] riscv: Add Zicbop extension support
Date: Tue, 24 Mar 2026 10:02:27 +0800
Message-Id: <20260324020227.214445-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3IXW28MFp8kcxBA--.14867S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrW8XF17uF1kJFyxtr45Awb_yoW5CrWDpF
	sIy3y3KrWrJws0k392gryDuw15Xw4Uu39xK34j9r4fJF9xAry7Jr1DJa43uFsrJay0qry3
	ZFWvgFy7Zr4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3Oz-UUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC8xk14GnB8Lly9AAA3Y

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

When the Zicbop extension is available expose it to the guest.
Also provide the guest the size of the cache block through DT.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 riscv/fdt.c                         | 12 +++++++++++-
 riscv/include/kvm/kvm-config-arch.h |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/riscv/fdt.c b/riscv/fdt.c
index eba9387..510641e 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -58,6 +58,7 @@ struct isa_ext_info isa_info_arr[] = {
 	{"zfh",		KVM_RISCV_ISA_EXT_ZFH},
 	{"zfhmin",	KVM_RISCV_ISA_EXT_ZFHMIN},
 	{"zicbom",	KVM_RISCV_ISA_EXT_ZICBOM},
+	{"zicbop",	KVM_RISCV_ISA_EXT_ZICBOP},
 	{"zicboz",	KVM_RISCV_ISA_EXT_ZICBOZ},
 	{"ziccrse",	KVM_RISCV_ISA_EXT_ZICCRSE},
 	{"zicntr",	KVM_RISCV_ISA_EXT_ZICNTR},
@@ -195,7 +196,7 @@ static void dump_fdt(const char *dtb_file, void *fdt)
 #define CPU_NAME_MAX_LEN 15
 static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
 {
-	unsigned long cbom_blksz = 0, cboz_blksz = 0, satp_mode = 0;
+	unsigned long cbom_blksz = 0, cboz_blksz = 0, cbop_blksz = 0, satp_mode = 0;
 	int i, cpu, pos, arr_sz = ARRAY_SIZE(isa_info_arr);
 
 	_FDT(fdt_begin_node(fdt, "cpus"));
@@ -249,6 +250,13 @@ static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
 					die("KVM_GET_ONE_REG failed (config.zicboz_block_size)");
 			}
 
+			if (isa_info_arr[i].ext_id == KVM_RISCV_ISA_EXT_ZICBOP && !cbop_blksz) {
+				reg.id = RISCV_CONFIG_REG(zicbop_block_size);
+				reg.addr = (unsigned long)&cbop_blksz;
+				if (ioctl(vcpu->vcpu_fd, KVM_GET_ONE_REG, &reg) < 0)
+					die("KVM_GET_ONE_REG failed (config.zicbop_block_size)");
+			}
+
 			if ((strlen(isa_info_arr[i].name) + pos + 1) >= CPU_ISA_MAX_LEN) {
 				pr_warning("Insufficient space to append ISA exension %s\n",
 					   isa_info_arr[i].name);
@@ -305,6 +313,8 @@ static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
 			_FDT(fdt_property_cell(fdt, "riscv,cbom-block-size", cbom_blksz));
 		if (cboz_blksz)
 			_FDT(fdt_property_cell(fdt, "riscv,cboz-block-size", cboz_blksz));
+		if (cbop_blksz)
+			_FDT(fdt_property_cell(fdt, "riscv,cbop-block-size", cbop_blksz));
 		_FDT(fdt_property_cell(fdt, "reg", cpu));
 		_FDT(fdt_property_string(fdt, "status", "okay"));
 
diff --git a/riscv/include/kvm/kvm-config-arch.h b/riscv/include/kvm/kvm-config-arch.h
index 6d9a29a..d3e1f56 100644
--- a/riscv/include/kvm/kvm-config-arch.h
+++ b/riscv/include/kvm/kvm-config-arch.h
@@ -135,6 +135,9 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('\0', "disable-zicboz",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZICBOZ],	\
 		    "Disable Zicboz Extension"),			\
+	OPT_BOOLEAN('\0', "disable-zicbop",				\
+		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZICBOP],	\
+		    "Disable Zicbop Extension"),			\
 	OPT_BOOLEAN('\0', "disable-ziccrse",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZICCRSE],	\
 		    "Disable Ziccrse Extension"),			\
-- 
2.47.3

