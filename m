Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189B33CEB92
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442025; cv=none; b=jGsyn11s/XY/Thjte8PV9WqYjBOpWfnmOAgwfGNGtdswzdrT7erR259ZzseysJwNoMfvycySUkwD8HIzRjihTXjzixqySdr6fAn99BXv+biTHimWrM7gLQ1N0Wjg0Ixavcu6W0Shmp8AfjIw/oeTa3Z2q/DA5EB8d8H0AqBqmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442025; c=relaxed/simple;
	bh=PgvW4MiFnfBH9/7PE1Egee3DCvENYUCtSHGurAuOmJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yshq2mGCymJbGvtU+/iKpYgjkCWpJceIh3plUo7b6QzPJUGlA0JrCZZQOnRAJKQlYMXS6v99VvY9bFcF6t/RWiG4OZWlsGg/pMozdZWWUKJ9oXodbbJo5iYu9t1N6k9oU+YmOqRap6s9uxGg7ith03DPZJAt8Xl6CDQ+epGkBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq+eBbUe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq+eBbUe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0b9328c4aso24166045ad.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 16:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780442023; x=1781046823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bw7Vrp5oUh2WDw5s8GOf1exSRNbvtmX+nqV+speIpOA=;
        b=hq+eBbUeHssOS8qpK6nx0mfjKpaBOHUCrR9IWTZVqHViZNfk18uk3dJqDvbIVlte9I
         g0Vw+TVGgv6z8ATbigkopKTbDAEb5W6Sbuj1Ey+pavdOzc9zZRX1Ybn6Ok5MRN/ICddi
         8LfArHYLGE2revvSQ/ZsB9kZzcV9qolSAAS4jr5nvJ8Lvdd4hY80XPtsbd9Hs8q1WV7B
         vkBC3Es/lFVPs9fUYR6xTT2SlKU7HYafHesXfZ6m8O7/OhcDt2T9b8mVvlMZOyEQx136
         VwrkbZxbyVfoccSK8o3zayE26DEV4JrUVLgQmsvgdKO1qkuqwsBavlwrHPnq2W9G4Sm/
         8Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780442023; x=1781046823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bw7Vrp5oUh2WDw5s8GOf1exSRNbvtmX+nqV+speIpOA=;
        b=DKzlAu6G9OtoM2pfvByTC2ulNY77zbxW5PSovxrh4MMBiveU5kUyVAd8tkUJC4mPSh
         sIVUfvUSrFjp9E9k3SjRFTX8vPtTFQEWMRJftU6v4xrN+Gl7/qquUm8NzUYDteAeDuy9
         0GflLyuS6bzeWtYy0A910cOD8ujF8ibM2M6BNP6ubz3XZ920tLdMybfS3yRhqOJDwTwc
         nFBCc4OsTWRASSg8nQ08cs4MDjdkF7x09GR7SVI4l3O/IKHvWguVSLwTZ509IvmNmsY8
         10SdK9z1puKv098J12TfDwcB7UlkuqbPEiWonYcwtMlhTdnXdhCvIqco6X5YiRMRMtXd
         9LbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Q15n8nduuBjLjGoj9Mx60LqLmQq6eXJceUZQ3muan5EgMp6OXm77ybx9go868rnMitoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxVVYDkCnuUqPbSRYjWliBsbLESr4Rao1VlCJAXomLNh0Nw+j
	xFWO42B/4KpUJnr1RQsiGGYtMw0numlQu8t0lSQaCYzsb6vRc7+fwiaW
X-Gm-Gg: Acq92OG7riAZsL4Q6dFrMXD/E4b4Rvqi+b5Eeco7869lshSlpNMDmA5wl+UCWh6/GSB
	UWoR4jvgIMhwW8k/Bk5EH88JRQS6JHB4Abff1iprqjt5a3jUAg2D2nzZOBk1V0mua7VsHWSRPX7
	qBpn/6iJxKATfZkHmPMDMy/DHL//Ak9X2Xdj9WZySR5EDQQZu22nl1/yc5/Y9NkuzK0wQ6+nLfX
	YN8WmHNJsRN6p8DT2fvtgHGZiYf74Kh/SX4g5stwd/t6ynyQidgIFih67jphaMfTYpQB3gRip+0
	vSAB/KzsDhpNpl+r9E8Y3RO76VcD/oHpuI8Z2wz4siBZZBH+HkrCS6GGQ8xzdlpdbwdS+UrKFwx
	/2SRRER10nbxuvmSjzcr8+y8tHC8lADqekDiVNks0QNc1T6u5oAU9x/m7MYDuNI4Phc0C6b4HL4
	nJFJ/cmGlbfg==
X-Received: by 2002:a17:903:3887:b0:2bd:9061:d544 with SMTP id d9443c01a7336-2c1644b829bmr7231515ad.34.1780442023354;
        Tue, 02 Jun 2026 16:13:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2dfsm3302965ad.75.2026.06.02.16.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:13:43 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 03 Jun 2026 07:12:00 -0400
Subject: [PATCH v3 05/15] riscv: Add Ziccamoa, Ziccif, Ziccrse, and Za64rs
 to cpufeature and hwprobe
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-rva23u64-hwprobe-v2-v3-5-5529a7b28384@gmail.com>
References: <20260603-rva23u64-hwprobe-v2-v3-0-5529a7b28384@gmail.com>
In-Reply-To: <20260603-rva23u64-hwprobe-v2-v3-0-5529a7b28384@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Shuah Khan <shuah@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 sophgo@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Charles Jenkins <thecharlesjenkins@gmail.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7482; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=Na9bFIsZ8mb2+W6E0yz8lnHt52zKy2GggwDCAN9B4OQ=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhiwFHpYDV7Q6rjApZxi8aVcwzHh95MBPLnYlnt93QgOXp
 WtMsZDvKGVhEONikBVTZDl8tCV76yufaN/nnD9g5rAygQxh4OIUgImEP2P4X/zhZfPf0vRNZdNi
 NlhETbs/v81O8P3vyORlSvk1ypuWMzIyXF/BlOCX3rBne7EIv/+WULmlqV/XLtySJXhuzmKphqV
 LmQE=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

Add Ziccamoa, Ziccif, and Za64rs to riscv_isa_ext[] so they can be
parsed from devicetree/ACPI ISA strings. Ziccrse is already present
in cpufeature; this patch only adds its hwprobe exposure.

Expose all four extensions via hwprobe through new bits in
RISCV_HWPROBE_KEY_IMA_EXT_1 (RISCV_HWPROBE_EXT_ZICCAMOA, _ZICCIF,
_ZICCRSE, _ZA64RS), so userspace can probe each of these
RVA23U64-mandatory extensions individually.

Rationale for the validation dependencies added for Ziccamoa and Za64rs:

1) Ziccamoa depends on Zaamo.  The RVA23 profile prose was updated
post-ratification to spell out the Zaamo reference: commit
2b218613752d in riscv/riscv-profiles ("Improve description of
Ziccamoa (#224)") reworded the rva23-profile.adoc (and other profiles
that include Ziccamoa) text from "must support all atomics in A" to
"must support all atomics in the Zaamo extension" [1].

2) Za64rs depends on Zalrsc. The unprivileged ISA manual src/zars.adoc,
integrated in commit ebe06adc22cd ("Integrate profiles as Volume III
(#2771)"), defines Za64rs as: "The Za64rs extension requires that the
reservation sets used by the instructions in the Zalrsc extension be
contiguous, naturally aligned, and at most 64 bytes in size" [2].

Link: https://github.com/riscv/riscv-profiles/commit/2b218613752d63287286b5ae801b820cbd8cc10c [1]
Link: https://github.com/riscv/riscv-isa-manual/blob/main/src/unpriv/zars.adoc [2]
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v3: Indent the added hwprobe.rst entries to match the normalized style; no other change.
v2:
- Rebased to v7.1-rc2.
- Reworded subject and expanded commit message.
- Validation added for Ziccamoa depending on Zaamo and Za64rs depending
  on Zalrsc.
---
 Documentation/arch/riscv/hwprobe.rst  | 16 ++++++++++++++++
 arch/riscv/include/asm/hwcap.h        |  3 +++
 arch/riscv/include/uapi/asm/hwprobe.h |  4 ++++
 arch/riscv/kernel/cpufeature.c        | 21 +++++++++++++++++++++
 arch/riscv/kernel/sys_hwprobe.c       |  4 ++++
 5 files changed, 48 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index fa2810bfc1477..b1b2d8803e5c2 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -405,3 +405,19 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZICCLSM`: The Zicclsm extension is supported,
     as defined in the RISC-V Profiles specification starting from commit
     b1d80660 ("Updated to ratified state.")
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCAMOA`: The Ziccamoa extension is supported,
+    as defined in the RISC-V Profiles specification starting from commit
+    b1d80660 ("Updated to ratified state.")
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCIF`: The Ziccif extension is supported,
+    as defined in the RISC-V Profiles specification starting from commit
+    b1d80660 ("Updated to ratified state.")
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCRSE`: The Ziccrse extension is supported,
+    as defined in the RISC-V Profiles specification starting from commit
+    b1d80660 ("Updated to ratified state.")
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZA64RS`: The Za64rs extension is supported,
+    as defined in the RISC-V Profiles specification starting from commit
+    b1d80660 ("Updated to ratified state.")
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e8f4a7dd96a93..0acb7a01ecc0f 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -113,6 +113,9 @@
 #define RISCV_ISA_EXT_ZICFILP		104
 #define RISCV_ISA_EXT_ZICFISS		105
 #define RISCV_ISA_EXT_ZICCLSM		106
+#define RISCV_ISA_EXT_ZICCAMOA		107
+#define RISCV_ISA_EXT_ZICCIF		108
+#define RISCV_ISA_EXT_ZA64RS		109
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 6819df159c51e..58d1e86e47ae7 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -117,6 +117,10 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_IMA_EXT_1		16
 #define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 0)
 #define		RISCV_HWPROBE_EXT_ZICCLSM	(1ULL << 1)
+#define		RISCV_HWPROBE_EXT_ZICCAMOA	(1ULL << 2)
+#define		RISCV_HWPROBE_EXT_ZICCIF	(1ULL << 3)
+#define		RISCV_HWPROBE_EXT_ZICCRSE	(1ULL << 4)
+#define		RISCV_HWPROBE_EXT_ZA64RS	(1ULL << 5)
 
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1fb595581adcf..b9538e69fa1b3 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -90,6 +90,24 @@ static int riscv_ext_f_depends(const struct riscv_isa_ext_data *data,
 	return -EPROBE_DEFER;
 }
 
+static int riscv_ext_zaamo_depends(const struct riscv_isa_ext_data *data,
+				   const unsigned long *isa_bitmap)
+{
+	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZAAMO))
+		return 0;
+
+	return -EPROBE_DEFER;
+}
+
+static int riscv_ext_zalrsc_depends(const struct riscv_isa_ext_data *data,
+				    const unsigned long *isa_bitmap)
+{
+	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZALRSC))
+		return 0;
+
+	return -EPROBE_DEFER;
+}
+
 static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
 				     const unsigned long *isa_bitmap)
 {
@@ -502,6 +520,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv_ext_zicbop_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(ziccamoa, RISCV_ISA_EXT_ZICCAMOA, riscv_ext_zaamo_depends),
+	__RISCV_ISA_EXT_DATA(ziccif, RISCV_ISA_EXT_ZICCIF),
 	__RISCV_ISA_EXT_DATA(zicclsm, RISCV_ISA_EXT_ZICCLSM),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
@@ -516,6 +536,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
+	__RISCV_ISA_EXT_DATA_VALIDATE(za64rs, RISCV_ISA_EXT_ZA64RS, riscv_ext_zalrsc_depends),
 	__RISCV_ISA_EXT_DATA(zaamo, RISCV_ISA_EXT_ZAAMO),
 	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 9cf62266f1890..b15ac9adf7920 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -206,6 +206,10 @@ static void hwprobe_isa_ext1(struct riscv_hwprobe *pair,
 		 */
 		EXT_KEY(isainfo->isa, ZICFISS, pair->value, missing);
 		EXT_KEY(isainfo->isa, ZICCLSM, pair->value, missing);
+		EXT_KEY(isainfo->isa, ZICCAMOA, pair->value, missing);
+		EXT_KEY(isainfo->isa, ZICCIF, pair->value, missing);
+		EXT_KEY(isainfo->isa, ZICCRSE, pair->value, missing);
+		EXT_KEY(isainfo->isa, ZA64RS, pair->value, missing);
 	}
 
 	/* Now turn off reporting features if any CPU is missing it. */

-- 
2.43.0

