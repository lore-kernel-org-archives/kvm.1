Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059193F7AB5
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506620; cv=none; b=u+tAWgj1R+XalKrg+T+E0ntUtHxzxjUnM8ezohPviKtdocPzFJFmnRMcywpP2U7YGnrt0IUqg8dLl8jJPzZGc88XAbVKIHLTRkGnJBrmDkQQ93phkEcVqftRdQ7GsgIX4hYxmPLEzBZ7GbS6V/7EVVd0S8OIlDwWucO+4+lbOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506620; c=relaxed/simple;
	bh=whd16pCFeGY44GyJW+gzwJ/lv8fgLbx7xRERQKHo7V4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjaPvRjoDy3C2guOI+xgHmZFp1fCOT+mdvD3sGDsuGQq3oMtu0koc+9VCY12XRVS6DarwhCad4A8rtg1v/McsYIvbTh8JpbpVyPNxlDm9nHiGXKhTZ4eB4YxX1TyiXaMJNi2VpVG8oo/Ijn1LPi0TnYV24MT0zF1ZhfWPe+AEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=GxGJcaL+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="GxGJcaL+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so2147483a91.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 06:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778506618; x=1779111418; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPones0CMg69Qw/g7AOw3hQVfu6a1CKbNx1fE/9O+eU=;
        b=GxGJcaL+mlu4G62Am+0sNS1ahInYiHktF47U/VWzgsFwKfTvYqPQDs59PDoR2+cgHU
         aMzgUCXU+gRPUgmmfJ6Cn8WP0U1zNcYIKUZmYl3YE4tOT7WaFU8+QD0aEnUPmSwouqAO
         F0IhAuMrg1wfwB/m9MuU4zirxHrABgKC5CCsPOS0cdUemxYvayKYq6H5o94GtuhoTyEn
         2WR7g75obLtOA0sMCap8h0xYwjLoInCD+/4lqpaW+5iDFXraGnyE+xU37C4WvWwGREUn
         X/T8sHRnxy34O/jg3puunUCOL0bxo1dx/JBRyfVdPxzXqzo2lXlBOONE6BHG1VK+cMwk
         1dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506618; x=1779111418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPones0CMg69Qw/g7AOw3hQVfu6a1CKbNx1fE/9O+eU=;
        b=r8bOPsYbkSgN5G1WaFzwLoAgOBxevchzODAOYzv4FeqxRbsm/+RqJLIXl8+ZzRBB4x
         3Gj0fEW/7EJSVMUgI/BaWW4rCZtWJIPkZlWu8WJM4NfExq2RTqBYlO6y5HVmPi+Dhak5
         jGveUtMLhvSQPMfkKJkXtlQkgDr1UuqvoMW8rR5NaQl1cmenraoWLM8rRvTlPBWAt8Yh
         hh+2mCp0udFqtrwslseXl1Z1O8V7HoBr/rMO7F1g5L2NYd64ccl8FS9HeIlshWxp5m38
         oLWEsB499Xo3XUMNkrPH2Crdy+WFkFcymaKrdYFcJ+rnfey03c9KOdVUAi3lADgH4iYs
         6EIw==
X-Forwarded-Encrypted: i=1; AFNElJ/1ci8NdBmCGQbEIAxKZw6Z8r8jhGwFmLt//InV35hUoCnjYfcQwVKpA6jSoNFpcWAj8w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYm8+O6o6B0dRtrFwRotXDZyc0lSb+HIatauuicKlau+5iciXG
	Cssn9TB+wNHq2cyDk49+36pVl9MNA2Ucbo3Gjx9g3BWisPoZ7MzCQ/5CpBAuaySSJRA=
X-Gm-Gg: Acq92OH9xW5XXwmjvOsjKGhrmuYMFOyzQhTpGALOmXllOvpeXZGCCLrc3AZAI+LUCdt
	HbVzgU7aRQxNaGZMfxfzN2mznQy2p7v3GBOU3nBvg/wfIx1leAFK7sNl0EJwzV+dD2PdftCOHX3
	G2DdusJlbisnEf8XKtOV2eqa9pJakfTIlHJQQzqWuKQ2nkgK/IWIKOA49FQmMAdu0/cOOFDKDVt
	uXhX6bXve7aqpzooDb2lRzdvbtBJoZ8/UB5GwBXHjJuZD8ZFqa9ZfOn8a2kgZMXQ/xjMcYmX8o2
	5Un31UP+ue3FtModWfzaSE/5yoo8ilBXMs53is3PAawKuGn5+C/j5B8cicK0ZCYdLS8xEuoUbqt
	nQeREAgbcrIRLXCtqFIOjKEnEsvPOZKBnZt+tK8Gjs3n0+B0R5Hnmz7LKdGf9E7Is+qmDSigYhT
	pybQeSISbsHU5RSgDgDskMHj7nNBxLTSq7fIE1bamDZew=
X-Received: by 2002:a17:90b:560d:b0:366:4adc:c51a with SMTP id 98e67ed59e1d1-3664adcc836mr14871897a91.11.1778506618357;
        Mon, 11 May 2026 06:36:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be3daafesm3034326a91.8.2026.05.11.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:36:58 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 11 May 2026 21:34:50 -0400
Subject: [PATCH v2 05/10] riscv: Add Ziccamoa, Ziccif, Ziccrse, and Za64rs
 to cpufeature and hwprobe
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-rva23u64-hwprobe-v2-v2-5-21c5a544f1dc@riscstar.com>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
To: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
 Deepak Gupta <debug@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, linux-doc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1

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
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
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
index 05f746061f679..73f50dc1ce7a2 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -399,3 +399,19 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZICFISS`: The Zicfiss extension is supported,
        as defined in version 1.0 of the RISC-V Control-flow Integrity (CFI)
        extensions specification, ratified 2024-07.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCAMOA`: The Ziccamoa extension is supported,
+       as defined in the RISC-V Profiles specification starting from commit
+       b1d80660 ("Updated to ratified state.")
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCIF`: The Ziccif extension is supported,
+       as defined in the RISC-V Profiles specification starting from commit
+       b1d80660 ("Updated to ratified state.")
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCRSE`: The Ziccrse extension is supported,
+       as defined in the RISC-V Profiles specification starting from commit
+       b1d80660 ("Updated to ratified state.")
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZA64RS`: The Za64rs extension is supported,
+       as defined in the RISC-V Profiles specification starting from commit
+       b1d80660 ("Updated to ratified state.")
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
index 4b4a8157277a3..46ea2cbcf881a 100644
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

