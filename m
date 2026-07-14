Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827D37B00F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009395; cv=none; b=gQ67ZTCrvfcN9AVqo0H3GGLiFhdXteO5Q5PJeqNO+7wT1uJzijo8Bfsdjc0A8oXQ4A6CL48zmAfY5H4eric9yY38xCTGEiHSl12HFFmgpN5sibYCTSoPyfF3PM8O/aQIdzVou2b+gdNiBfqNq1iYRjaXWK8BzpWBVfjOFTx3l5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009395; c=relaxed/simple;
	bh=33oIHAJX6KHW3q87Bf5Q79aww1a9vWn9rrfba7EQyuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iaxPBRfiV7xKgxB7zwZQNWw9k2Uut9itip90/e7XWStRKbpKVwfEJ0gH96fbuHyNKdmFhb0Lil0Okk0iKktWnqP2dQFiNOKmjleTajNtbO+nYhfl5awiKDChrnivm0TbUxskFqqFuj/R4s/73n1MqKtnArPxe5Vea7cD1m7wxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PbXHIdLy; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PbXHIdLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=N1
	2KAyS3X4cQTcq6kRocx0a46HDsoD37GfqGuV7SvkA=; b=PbXHIdLy10xIWTkAxr
	oMO0TH2xwmUGauf8nldrDSK8Gc+2n76hU1M3rOlVit1DIPbvSzsIHqLCT4LExHNz
	dKY1T5GX3GaS2H0NRfhFGj9Z+3ZPGZM/2EX8W+co4gm1t0rsScCEP8UjLoHj7Gv5
	wabHoTR3rB7Cm5EgxIKAgmy9U=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3ufae0lVq1deZHA--.12353S2;
	Tue, 14 Jul 2026 14:09:34 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: kvm@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH kvmtool] riscv: Add extensions support after v7.1 update
Date: Tue, 14 Jul 2026 14:09:31 +0800
Message-Id: <20260714060931.82182-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgB3ufae0lVq1deZHA--.12353S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1kKr4UtrW3CF47ZF17Awb_yoW5ur4Dpr
	n5A3sxKrWrXasI9a4xKr95Gw15Xw45Z393Gw429rn7try3CryftFs5G3W3ua1DJay0vr1a
	vF1kWr1Ivr4SyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtR6cUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0R7Ld2pV0p4NSgAA3H

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Expose the Zclsd, Zilsd and Zalasr extensions to KVM guests.
Add command-line options to disable each extension individually.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 riscv/fdt.c                         | 3 +++
 riscv/include/kvm/kvm-config-arch.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/riscv/fdt.c b/riscv/fdt.c
index 2368c19..1eb45fc 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -41,6 +41,7 @@ struct isa_ext_info isa_info_arr[] = {
 	{"svvptc",	KVM_RISCV_ISA_EXT_SVVPTC},
 	{"zabha",	KVM_RISCV_ISA_EXT_ZABHA},
 	{"zacas",	KVM_RISCV_ISA_EXT_ZACAS},
+	{"zalasr",	KVM_RISCV_ISA_EXT_ZALASR},
 	{"zawrs",	KVM_RISCV_ISA_EXT_ZAWRS},
 	{"zba",		KVM_RISCV_ISA_EXT_ZBA},
 	{"zbb",		KVM_RISCV_ISA_EXT_ZBB},
@@ -53,6 +54,7 @@ struct isa_ext_info isa_info_arr[] = {
 	{"zcb",		KVM_RISCV_ISA_EXT_ZCB},
 	{"zcd",		KVM_RISCV_ISA_EXT_ZCD},
 	{"zcf",		KVM_RISCV_ISA_EXT_ZCF},
+	{"zclsd",	KVM_RISCV_ISA_EXT_ZCLSD},
 	{"zcmop",	KVM_RISCV_ISA_EXT_ZCMOP},
 	{"zfa",		KVM_RISCV_ISA_EXT_ZFA},
 	{"zfbfmin",	KVM_RISCV_ISA_EXT_ZFBFMIN},
@@ -69,6 +71,7 @@ struct isa_ext_info isa_info_arr[] = {
 	{"zihintntl",	KVM_RISCV_ISA_EXT_ZIHINTNTL},
 	{"zihintpause",	KVM_RISCV_ISA_EXT_ZIHINTPAUSE},
 	{"zihpm",	KVM_RISCV_ISA_EXT_ZIHPM},
+	{"zilsd",	KVM_RISCV_ISA_EXT_ZILSD},
 	{"zimop",	KVM_RISCV_ISA_EXT_ZIMOP},
 	{"zknd",	KVM_RISCV_ISA_EXT_ZKND},
 	{"zkne",	KVM_RISCV_ISA_EXT_ZKNE},
diff --git a/riscv/include/kvm/kvm-config-arch.h b/riscv/include/kvm/kvm-config-arch.h
index d56f9ba..7f7d0e2 100644
--- a/riscv/include/kvm/kvm-config-arch.h
+++ b/riscv/include/kvm/kvm-config-arch.h
@@ -81,6 +81,9 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('\0', "disable-zacas",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZACAS],	\
 		    "Disable Zacas Extension"),				\
+	OPT_BOOLEAN('\0', "disable-zalasr",				\
+		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZALASR],	\
+		    "Disable Zalasr Extension"),			\
 	OPT_BOOLEAN('\0', "disable-zawrs",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZAWRS],	\
 		    "Disable Zawrs Extension"),				\
@@ -117,6 +120,9 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('\0', "disable-zcf",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZCF],	\
 		    "Disable Zcf Extension"),				\
+	OPT_BOOLEAN('\0', "disable-zclsd",				\
+		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZCLSD],	\
+		    "Disable Zclsd Extension"),			\
 	OPT_BOOLEAN('\0', "disable-zcmop",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZCMOP],	\
 		    "Disable Zcmop Extension"),				\
@@ -165,6 +171,9 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('\0', "disable-zihpm",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZIHPM],	\
 		    "Disable Zihpm Extension"),				\
+	OPT_BOOLEAN('\0', "disable-zilsd",				\
+		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZILSD],	\
+		    "Disable Zilsd Extension"),			\
 	OPT_BOOLEAN('\0', "disable-zimop",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZIMOP],	\
 		    "Disable Zimop Extension"),				\
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

