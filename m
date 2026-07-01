Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80048A2DA
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910461; cv=none; b=J7qc84rIub1mzHWQtYf8NSn7Tw5uo/Dn/LtBigZ4MJenRs09nuC7t/8SJbMt1tvPtDhRki/KozwalmH5sKnvnghbHOP+py4XVn4de4KdeNqwdB+zva7jbEtDQtIaJkzu3hURCMSYkJ5IMUow16LaeAAUKgQlvDSkzyZi970cunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910461; c=relaxed/simple;
	bh=If9Vv8oTlPVOiMHTe3lA0EFHDNlAsYSdgct+20oWDfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVNYGp2xlrcBB/JRge+ruDFUmQdqmSOG1oqRDQBt3Nj6/rLIpkzbOFtqmhyZapgA/lr5r/M8puMkza6f5aWxIY0w+2BkJwh93JD/A95/uyJgB5uptYA9d7m/8stEmGnWJ/4lRxWvFGdmI8jKRfcs0E4BbmAAJKIF7tNnG+0s8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onCpQb62; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onCpQb62"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso453528b3a.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782910458; x=1783515258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8K/a6AEhCKKl6b6WVU/a0dv3ErkxxiYJVhxQewlVnUE=;
        b=onCpQb62oVzoqj7SaWqeqVvEU62INX4ny9LrLeyUHkwwpS1nLmYOjrcJuDZ8dhHdJG
         yw0SZBVp4krYG+CKkREsJcPn/hM05Y4yB8/fVF3SKlSIk95hXRppTHuTQT3L4o4U94p2
         mgyvlzx1KYe6zidfI0mGpFyXNEAwjEB1CfmrnUgvoMucgDvF8L1CKbBaZ2vio0gyE5BY
         9uJscJ6jBj66Hpp/tc3ao/2P/u6PASHE3hoJMviehE4Vk3DCq8nIK5+ar2s//vj5FPT8
         SSziUzZu/EYT7GDdzfhWM5xewzztwHLwzj/upbY20/rfnp2vJQr80Zx4j0kgl32nQ5u0
         U7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910458; x=1783515258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8K/a6AEhCKKl6b6WVU/a0dv3ErkxxiYJVhxQewlVnUE=;
        b=ngIbasph5BoRuqf/b3cs20Rr1TyXm/NlaCfFelTilyTc2w4ZMpIPFsCfG9rX1wg21V
         bOwCB9gzePibDRbYvD5TQbqbaocP0G9zDg+6jffmQKVMb8/jB2TVaTI2CNNo93BYW7mY
         k1q5wWes8hmj01C462OfWQj2YKgoMkUcxuQDAY87crmuqfrdKe9YPi85GEo1OdXkINlf
         y75uP4y6otmcjAcoDA6RCik3v/ZlMzWJ6gI5px7mfXcFLWoqqeHvd8E1ygD+CgNiIFyM
         dcFV6IZLgNiek+PFOpo/1W1m6RJTbXB6mlHFLA2zjEVAergaE+rv5uxog4iFtc/Yoxnv
         u5kQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IQcayutWylSKuxfyx0iOX8nGuS7F0FQGYBscC/2Z0IUFlsg3AcePUE+IlSzn50LghPps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZnKTU/kR2a8UA6xKuiZNsvPXe5FDK/k1ZoZkQ9iPDie3po8Wu
	9Ee01Ybb3vGnR02ZNH8B8k9bld0PkOX31P5OPda/xqun+RkE5Zf/YfGn
X-Gm-Gg: AfdE7cnQaIr83XyzIF4Y/HS4eEu5+Yauug0s6ZOPgnMV+0DB4l8Bl4Qro8SyUnhJn69
	K6/gjmPNg8JANQ/RbqdWOGlRtcR2XZHR9UPDoVBZenjU8emSYuDiuxGtpx1Lhvi/QiL8Pua+ns4
	SddvDqlicOqwNc5FthwUg3vQtP+eZsTnmXk0Y6luOWRH4kM7gyWqIXlWdo4KLmbwWLg1R3c8HOf
	w+cr1AL7x2NJI/69F/wGQFE6IACaDI71kdi0lf6YnJ2lRmxCOVJxKT1e5G8KRsT6JTlMjH940or
	9Yai1zo5fmhIXDiywiyzpFLHlNZ3PG3119SmuEIMVYGy+zgaK/bguTR0iw6r0lGOjPVP0UWNBMo
	cl7Hzy0Q2lYcVHVX7MpYyzz9qVjj9PNcF4T3GcxkZEx9zDf81AWlpA6Q4DuJ/EAUui7GqJqyMzl
	8PqtzW0DJDQ8s5w69Rc3Mj
X-Received: by 2002:a05:6a00:27ac:b0:847:99b4:d005 with SMTP id d2e1a72fcca58-847c097d0bdmr1329287b3a.61.1782910457611;
        Wed, 01 Jul 2026 05:54:17 -0700 (PDT)
Received: from [127.0.1.1] ([120.244.9.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm3999403b3a.49.2026.07.01.05.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:54:17 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 01 Jul 2026 08:52:23 -0400
Subject: [PATCH v5 10/17] riscv: Add Zic64b to cpufeature and hwprobe
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-rva23u64-hwprobe-v2-v5-10-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Jesse Taube <jtaubepe@redhat.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Guodong Xu <docular.xu@gmail.com>, 
 Qingwei Hu <qingwei.hu@bytedance.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5679; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=v3bkflKvhJMLJLs8CMo44CCLgRBUGW+Y8dK7sdakiYs=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixX3tazczNXzLhx5cH0q81iznKfxGu/tW0t8p6zlUOwv
 dw+dkF1RykLgxgXg6yYIsvhoy3ZW1/5RPs+5/wBM4eVCWQIAxenAEwkV5iR4ci3HSE7VJ8F1Efe
 bXjOnabyreTLwwt7b655ZlGtNKm5HqjiwzttdxH9y3MqV0nEMPKERs4+p1MXPcOKKSz56MzUxA/
 MAA==
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

From: Qingwei Hu <qingwei.hu@bytedance.com>

Zic64b mandates 64-byte naturally aligned cache blocks and is a
mandatory extension of the RVA22 and RVA23 profiles.  Allocate a
RISCV_ISA_EXT_ZIC64B id, parse "zic64b" from the ISA string with a
validate callback that requires each cbom/cbop/cboz cache block size to
be 64 bytes when it is present, and export it through hwprobe.

Link: https://lists.riscv.org/g/tech-unprivileged/topic/question_about_zic64b_and/119631059
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
Co-developed-by: Guodong Xu <docular.xu@gmail.com>
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v5:
- Collected Reviewed-by from Andrew Jones and Conor Dooley.
v4:
- Credit Qingwei Hu's earlier Zic64b cpufeature patch: set him as
  author, with Co-developed-by (Guodong Xu).
- Validate only the cbom/cbop/cboz block sizes that are present; Zic64b
  does not imply the CMO extensions (Conor, Qingwei, Greg).
- Add a Link: to Greg's confirmation on the tech-unprivileged list.
- Add the missing blank line before the ZIC64B hwprobe.rst entry
  (Andrew).
- Did not carry Andrew Jones's v3 Reviewed-by: the validation was
  rewritten (present block sizes only) and the patch is now authored by
  Qingwei, so it warrants a fresh review.
v3: New patch.
---
 Documentation/arch/riscv/hwprobe.rst  |  4 ++++
 arch/riscv/include/asm/hwcap.h        |  1 +
 arch/riscv/include/uapi/asm/hwprobe.h |  1 +
 arch/riscv/kernel/cpufeature.c        | 19 +++++++++++++++++++
 arch/riscv/kernel/sys_hwprobe.c       |  1 +
 5 files changed, 26 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index fc68dea397aae..32a14331eb9de 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -425,3 +425,7 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_B`: The B extension is supported, as defined
     in version 1.0 of the Bit-Manipulation ISA extensions, and implies the
     presence of the Zba, Zbb, and Zbs sub-extensions.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZIC64B`: The Zic64b extension is supported,
+    as defined in the RISC-V Profiles specification starting from commit
+    b1d80660 ("Updated to ratified state.")
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 58523b3a1998a..36572c1ff438a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -117,6 +117,7 @@
 #define RISCV_ISA_EXT_ZICCAMOA		107
 #define RISCV_ISA_EXT_ZICCIF		108
 #define RISCV_ISA_EXT_ZA64RS		109
+#define RISCV_ISA_EXT_ZIC64B		110
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 430dc49a82863..36ec8ab470423 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -122,6 +122,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZICCRSE	(1ULL << 4)
 #define		RISCV_HWPROBE_EXT_ZA64RS	(1ULL << 5)
 #define		RISCV_HWPROBE_EXT_B		(1ULL << 6)
+#define		RISCV_HWPROBE_EXT_ZIC64B	(1ULL << 7)
 
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 9eee53b264de1..4c3bf813af052 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -136,6 +136,24 @@ static int riscv_ext_zicbop_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_ext_zic64b_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
+{
+	/*
+	 * Zic64b mandates 64-byte naturally aligned cache blocks; cross-check the
+	 * cbom/cbop/cboz block-size (when declared) device-tree properties to
+	 * avoid inconsistency.
+	 */
+	if ((riscv_cbom_block_size && riscv_cbom_block_size != 64) ||
+	    (riscv_cbop_block_size && riscv_cbop_block_size != 64) ||
+	    (riscv_cboz_block_size && riscv_cboz_block_size != 64)) {
+		pr_err("Zic64b detected in ISA string, disabling as a CBO block size is not 64 bytes\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int riscv_ext_f_validate(const struct riscv_isa_ext_data *data,
 				const unsigned long *isa_bitmap)
 {
@@ -506,6 +524,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET(b, RISCV_ISA_EXT_B, riscv_b_exts),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_V, riscv_v_exts, riscv_ext_vector_float_validate),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_H),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zic64b, RISCV_ISA_EXT_ZIC64B, riscv_ext_zic64b_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv_ext_zicbop_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index dcc102bf8f183..3e80e5551ae0d 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -211,6 +211,7 @@ static void hwprobe_isa_ext1(struct riscv_hwprobe *pair,
 		EXT_KEY(isainfo->isa, ZICCRSE, pair->value, missing);
 		EXT_KEY(isainfo->isa, ZA64RS, pair->value, missing);
 		EXT_KEY(isainfo->isa, B, pair->value, missing);
+		EXT_KEY(isainfo->isa, ZIC64B, pair->value, missing);
 	}
 
 	/* Now turn off reporting features if any CPU is missing it. */

-- 
2.43.0

