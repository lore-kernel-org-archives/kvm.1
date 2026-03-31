Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DB3ED5DD
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950395; cv=none; b=ISb85Joow9qr6xELPIs09brLpvtJOaWLsRCEVwKfrOzmUCBE9w1tFW0ZZAdJF/76U64CmACmdV5svu7g8FToccUpJoavvCbu2LcC5WuUc+RB73aQXyfK0rC7tkSVr85AeufO0ZRSIJ9ubGbM1nygobcRIbjGK4qvJF6pldHwmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950395; c=relaxed/simple;
	bh=LEucAejffe3SCX1dTTSNEI6iLjp8Gtq1WK31zyi61Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KD9o8uZ3giLTJ+ZZ4H+GqUbPY1F6q6Q2YtccQqAl9qIKFD7nsATeJvl9TJ1LxXt/0TEvWH5+bVRKEkgv5j9FTM9FhoR2EWz/+UUyls16Q3kTegFcGPtIM6Was7sOVm9uN9qHLbVk3/GE9R+GikHDbedzAjaicGwgw6MbpAaERGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Cbu/bocu; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Cbu/bocu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mA
	ML65gwGw/hBVTTFnvPtutWm8H1pcKIMUoFmnKDgNc=; b=Cbu/bocuJu6KXLNbF3
	fie46PjArZnh+G+sM1zG6asm1f5YjaYf5+cZGjp0R8Qjm9/i9zaMlArQ3mpBwIBJ
	Z5qjCA3SCRcWY3OJfwfdAP+/sjXM3GnM/+7E0M7rLKZE0xxS1994qP21CqrYMyiW
	ZrSdva/HSzcaSq+fCo3kR+0OY=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wB3yHHol8tpiBESCg--.11028S2;
	Tue, 31 Mar 2026 17:46:18 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: kvm@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH kvmtool] riscv: Add BFloat16 extensions support
Date: Tue, 31 Mar 2026 17:46:14 +0800
Message-Id: <20260331094614.123614-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3yHHol8tpiBESCg--.11028S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr48CFyfuFy5tFyxWw1fCrg_yoW5GFW8pF
	n7A3s3KrWrXas09a4Iqr98Gw15Xw45u395Gw42krs7Jry5Aryftrn5G3W3ua1DJayv9FnI
	vF1kWrW0vr4rAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3Oz-UUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0gptGWnLl+qNFAAA3q

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Expose the BFloat16 extensions (Zfbfmin, Zvfbfmin, Zvfbfwma) to KVM guests
when available in hardware.
Add command-line options to disable each extension individually.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 riscv/fdt.c                         | 3 +++
 riscv/include/kvm/kvm-config-arch.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/riscv/fdt.c b/riscv/fdt.c
index 510641e..2368c19 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -55,6 +55,7 @@ struct isa_ext_info isa_info_arr[] = {
 	{"zcf",		KVM_RISCV_ISA_EXT_ZCF},
 	{"zcmop",	KVM_RISCV_ISA_EXT_ZCMOP},
 	{"zfa",		KVM_RISCV_ISA_EXT_ZFA},
+	{"zfbfmin",	KVM_RISCV_ISA_EXT_ZFBFMIN},
 	{"zfh",		KVM_RISCV_ISA_EXT_ZFH},
 	{"zfhmin",	KVM_RISCV_ISA_EXT_ZFHMIN},
 	{"zicbom",	KVM_RISCV_ISA_EXT_ZICBOM},
@@ -79,6 +80,8 @@ struct isa_ext_info isa_info_arr[] = {
 	{"ztso",	KVM_RISCV_ISA_EXT_ZTSO},
 	{"zvbb",	KVM_RISCV_ISA_EXT_ZVBB},
 	{"zvbc",	KVM_RISCV_ISA_EXT_ZVBC},
+	{"zvfbfmin",	KVM_RISCV_ISA_EXT_ZVFBFMIN},
+	{"zvfbfwma",	KVM_RISCV_ISA_EXT_ZVFBFWMA},
 	{"zvfh",	KVM_RISCV_ISA_EXT_ZVFH},
 	{"zvfhmin",	KVM_RISCV_ISA_EXT_ZVFHMIN},
 	{"zvkb",	KVM_RISCV_ISA_EXT_ZVKB},
diff --git a/riscv/include/kvm/kvm-config-arch.h b/riscv/include/kvm/kvm-config-arch.h
index d3e1f56..d56f9ba 100644
--- a/riscv/include/kvm/kvm-config-arch.h
+++ b/riscv/include/kvm/kvm-config-arch.h
@@ -123,6 +123,9 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('\0', "disable-zfa",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZFA],	\
 		    "Disable Zfa Extension"),				\
+	OPT_BOOLEAN('\0', "disable-zfbfmin",				\
+		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZFBFMIN],	\
+		    "Disable Zfbfmin Extension"),			\
 	OPT_BOOLEAN('\0', "disable-zfh",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZFH],	\
 		    "Disable Zfh Extension"),				\
@@ -195,6 +198,12 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
 	OPT_BOOLEAN('\0', "disable-zvbc",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZVBC],	\
 		    "Disable Zvbc Extension"),				\
+	OPT_BOOLEAN('\0', "disable-zvfbfmin",				\
+		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZVFBFMIN],	\
+		    "Disable Zvfbfmin Extension"),			\
+	OPT_BOOLEAN('\0', "disable-zvfbfwma",				\
+		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZVFBFWMA],	\
+		    "Disable Zvfbfwma Extension"),			\
 	OPT_BOOLEAN('\0', "disable-zvfh",				\
 		    &(cfg)->ext_disabled[KVM_RISCV_ISA_EXT_ZVFH],	\
 		    "Disable Zvfh Extension"),				\
-- 
2.34.1

