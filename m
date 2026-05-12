Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850203EE1C1
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506608; cv=none; b=uqWsjzkuJMQz4LHPXxcK/g9Ajbg3nImaOl71O7wI9SMyVS2heUCt//9LoJvULj+pnDtyWre9XLj4isULNnKyh4+5ClxULjCXVWF9kZGgEyFPA3GAb+KYTLwoGA5HSjodZBLHjRHZMz/3on2o1/5imSejQzC5igEfl9JmYGNOSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506608; c=relaxed/simple;
	bh=0+c8LDQ9WvXUMHg33KZRBhsRl3ksSyJE/aJ36SybkBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWXuoi/EH6/G2rl3JiOz2p9lWWFXzJf81uHPG6nysYLAyJXtV0g51xSQgMOigCF/KJNU+Rzps5ewOnfyOnXJvpae9/rzfnlXlCYcT3MoDjx7yV9llooS0y+jX1Gqd48qNWaz8/4jNMWCk9OGfySpe79eI3PbosJD+ywS80URBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=GQmIPvme; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="GQmIPvme"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3660b84347dso2640812a91.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778506604; x=1779111404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErzzDRUYaWPgiVTNPtZyOXzvER5BN1XD/8DHKiXjVGk=;
        b=GQmIPvmecqP1uR0rR/YrO4JeXEcQAq/vmFs73lvq2A+ZNEScWsX0A4DY92cbmDzuxm
         h/PXjFQ2OswlEdrJUqbujOViidlNwc4CYRHDphueWlk+RuYsc0CWnDJv3KrSMJUiA9D0
         i0qFg+Ra17vnbb+Uz6Wzpyoa/hWQ7KTxFA9CNSQSfJG4ZBrsKdSZAPCHRVLiLpOf6UM/
         h8OZ+/YygAGcqnC51Acpj9aeY3DZ0qk64wnXf/Oz0BvodSPKXLc5JaQmn8T0M4CjmfdC
         1Jp0V9dRdAmMC617AX0T0fu7nC6zsK7pC+ln/FDsVNqgbWDvw1h6m7MHBqvH1s6bpcJW
         bxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506604; x=1779111404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ErzzDRUYaWPgiVTNPtZyOXzvER5BN1XD/8DHKiXjVGk=;
        b=k9LJZ5eOP/wfUzo1oQqBVagb1MYc2TSOQfjOXb75T/XOaOy8zNdEt0KTmn9wdgJEWf
         XjRpvN+ImLWC+97prauVlLmd+utAMRu2OYm7NTo8Ldq/jciX5MgilIuQaqs2T4vlzgHx
         mA+f9NbXMMEL2lR3U+ysTuPMHY04cdsyb2Mcs/i7l+pSCrhVajrnTdaeomv2Mq31gTov
         +XRGqrBkJnHEtghjlTVstEiq6wCLYEAyM5tMIEs0Zb80p8wop3RiH+B4dLAlILYs18gz
         sGvDMvGqofsHD110Je30YNq29BJhPFt4/rMr+2ATzoGToLaaiCLqA5TmsG5L6bxAQta+
         a5KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ps2mq9HFPH9FpqsO1TYrite2dGsidDN69nkTDbPxJuu6LQ1Kyv2gcYRH1q0tV3r7CGpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwMzrZwaV750uhwzIGPoH3jOyhxUwbOvd7u440eH0sfKULmMy
	wRuhKF8Th1K9BDvrIhZ+kpbbIQWX7xwNCkwuWH0JHRUyeFJZV3dCtmwo47HB7JkJV9I=
X-Gm-Gg: Acq92OFKe+Z4/TdKTjWRCYo7oidBzJosbQClsXmX/ohtcwGbj6hKgamhP9jYhqWPGQn
	BqRZ/lNcrmJ8Fw99MGeOtZ/HG1bER5hFSW0N19zuX4hbtMLvvSr8bhjeVDZH/7w840kgmyDznt9
	gJmkuP8RFLWizESxJtpqPENuVre1GGtVppFYVDjRCLiI/+IZ+KyYF0T0xFpClwmRQy7aPOYOk0s
	QpJ+ZSchRkYxnkMELocdz/NGZGEH71YIdwhPNE8h4CkWylWNNYI5NsxOQOPUtnPIF6uuW/XFCTT
	5y2z74zknKfm7aY9oZ5fM/8PlONWj4CgB3TGfa2zLvAJg5f7ovYgqWuQo15BGnfqkSCACbO3hDz
	LD8K+9Mz1XRSZiqR1/gaUZTt23QDTmvBqXoXiSdEBes1nQIcfb+Dwr/WHoCj36G88B3BKXECJ/f
	wVCNQIc2JcpGdY+Vi29FijhcY280PnxchN5E2LDggB2jg=
X-Received: by 2002:a17:90b:2dc6:b0:35f:bb33:d72c with SMTP id 98e67ed59e1d1-365ab9b8c48mr25135522a91.4.1778506603831;
        Mon, 11 May 2026 06:36:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be3daafesm3034326a91.8.2026.05.11.06.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:36:43 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 11 May 2026 21:34:48 -0400
Subject: [PATCH v2 03/10] riscv: Standardize extension capitalization
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-rva23u64-hwprobe-v2-v2-3-21c5a544f1dc@riscstar.com>
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
 kvm-riscv@lists.infradead.org, Guodong Xu <guodong@riscstar.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.1

From: Charlie Jenkins <charlie@rivosinc.com>

The base extensions are often lowercase and were written as lowercase in
hwcap, but other references to these extensions in the kernel are
uppercase. Standardize the case to make it easier to handle macro
expansion.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
[Apply KVM_ISA_EXT_ARR(), fixup all KVM use.]
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- Rebased onto v7.1-rc2.
- KVM_ISA_EXT_ARR() consolidation moved to its new upstream location
  (kvm/isa.c); host-side checks now use kvm_riscv_isa_check_host().
---
 arch/riscv/include/asm/hwcap.h     | 18 +++++++++---------
 arch/riscv/include/asm/switch_to.h |  4 ++--
 arch/riscv/kernel/cpufeature.c     | 32 ++++++++++++++++----------------
 arch/riscv/kernel/sys_hwprobe.c    |  4 ++--
 arch/riscv/kvm/isa.c               | 16 ++++++++--------
 arch/riscv/kvm/main.c              |  2 +-
 arch/riscv/kvm/vcpu_fp.c           | 20 ++++++++++----------
 arch/riscv/kvm/vcpu_onereg.c       |  6 +++---
 arch/riscv/kvm/vcpu_vector.c       | 10 +++++-----
 9 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 7ef8e5f55c8dc..44bf8c7d8acc5 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -10,15 +10,15 @@
 
 #include <uapi/asm/hwcap.h>
 
-#define RISCV_ISA_EXT_a		('a' - 'a')
-#define RISCV_ISA_EXT_c		('c' - 'a')
-#define RISCV_ISA_EXT_d		('d' - 'a')
-#define RISCV_ISA_EXT_f		('f' - 'a')
-#define RISCV_ISA_EXT_h		('h' - 'a')
-#define RISCV_ISA_EXT_i		('i' - 'a')
-#define RISCV_ISA_EXT_m		('m' - 'a')
-#define RISCV_ISA_EXT_q		('q' - 'a')
-#define RISCV_ISA_EXT_v		('v' - 'a')
+#define RISCV_ISA_EXT_A		('a' - 'a')
+#define RISCV_ISA_EXT_C		('c' - 'a')
+#define RISCV_ISA_EXT_D		('d' - 'a')
+#define RISCV_ISA_EXT_F		('f' - 'a')
+#define RISCV_ISA_EXT_H		('h' - 'a')
+#define RISCV_ISA_EXT_I		('i' - 'a')
+#define RISCV_ISA_EXT_M		('m' - 'a')
+#define RISCV_ISA_EXT_Q		('q' - 'a')
+#define RISCV_ISA_EXT_V		('v' - 'a')
 
 /*
  * These macros represent the logical IDs of each multi-letter RISC-V ISA
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920c..ff35a4d04f85a 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -60,8 +60,8 @@ static inline void __switch_to_fpu(struct task_struct *prev,
 
 static __always_inline bool has_fpu(void)
 {
-	return riscv_has_extension_likely(RISCV_ISA_EXT_f) ||
-		riscv_has_extension_likely(RISCV_ISA_EXT_d);
+	return riscv_has_extension_likely(RISCV_ISA_EXT_F) ||
+		riscv_has_extension_likely(RISCV_ISA_EXT_D);
 }
 #else
 static __always_inline bool has_fpu(void) { return false; }
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1734f9a4c2fd7..5cf463570229d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 static int riscv_ext_f_depends(const struct riscv_isa_ext_data *data,
 			       const unsigned long *isa_bitmap)
 {
-	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
+	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_F))
 		return 0;
 
 	return -EPROBE_DEFER;
@@ -146,7 +146,7 @@ static int riscv_ext_f_validate(const struct riscv_isa_ext_data *data,
 	 * Due to extension ordering, d is checked before f, so no deferral
 	 * is required.
 	 */
-	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d)) {
+	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_D)) {
 		pr_warn_once("This kernel does not support systems with F but not D\n");
 		return -EINVAL;
 	}
@@ -189,7 +189,7 @@ static int riscv_ext_vector_float_validate(const struct riscv_isa_ext_data *data
 	 * Since this function validates vector only, and v/Zve* are probed
 	 * after f/d, there's no need for a deferral here.
 	 */
-	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d))
+	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_D))
 		return -EINVAL;
 
 	return 0;
@@ -224,7 +224,7 @@ static int riscv_ext_zcd_validate(const struct riscv_isa_ext_data *data,
 				  const unsigned long *isa_bitmap)
 {
 	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
-	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d))
+	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_D))
 		return 0;
 
 	return -EPROBE_DEFER;
@@ -237,7 +237,7 @@ static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
 		return -EINVAL;
 
 	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
-	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f))
+	    __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_F))
 		return 0;
 
 	return -EPROBE_DEFER;
@@ -490,15 +490,15 @@ static const unsigned int riscv_c_exts[] = {
  * New entries to this struct should follow the ordering rules described above.
  */
 const struct riscv_isa_ext_data riscv_isa_ext[] = {
-	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i),
-	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m),
-	__RISCV_ISA_EXT_SUPERSET(a, RISCV_ISA_EXT_a, riscv_a_exts),
-	__RISCV_ISA_EXT_DATA_VALIDATE(f, RISCV_ISA_EXT_f, riscv_ext_f_validate),
-	__RISCV_ISA_EXT_DATA_VALIDATE(d, RISCV_ISA_EXT_d, riscv_ext_d_validate),
-	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
-	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
-	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, riscv_ext_vector_float_validate),
-	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
+	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_I),
+	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_M),
+	__RISCV_ISA_EXT_SUPERSET(a, RISCV_ISA_EXT_A, riscv_a_exts),
+	__RISCV_ISA_EXT_DATA_VALIDATE(f, RISCV_ISA_EXT_F, riscv_ext_f_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(d, RISCV_ISA_EXT_D, riscv_ext_d_validate),
+	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_Q),
+	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_C, riscv_c_exts),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_V, riscv_v_exts, riscv_ext_vector_float_validate),
+	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_H),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv_ext_zicbop_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
@@ -897,8 +897,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 * marchid.
 		 */
 		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
-			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
-			clear_bit(RISCV_ISA_EXT_v, source_isa);
+			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_V];
+			clear_bit(RISCV_ISA_EXT_V, source_isa);
 		}
 
 		riscv_resolve_isa(source_isa, isainfo->isa, &this_hwcap, isa2hwcap);
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 1659d31fd288f..f8f68ba781b45 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -88,10 +88,10 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	if (has_fpu())
 		pair->value |= RISCV_HWPROBE_IMA_FD;
 
-	if (riscv_isa_extension_available(NULL, c))
+	if (riscv_isa_extension_available(NULL, C))
 		pair->value |= RISCV_HWPROBE_IMA_C;
 
-	if (has_vector() && riscv_isa_extension_available(NULL, v))
+	if (has_vector() && riscv_isa_extension_available(NULL, V))
 		pair->value |= RISCV_HWPROBE_IMA_V;
 
 	/*
diff --git a/arch/riscv/kvm/isa.c b/arch/riscv/kvm/isa.c
index 1132d909cc25c..94077117d1136 100644
--- a/arch/riscv/kvm/isa.c
+++ b/arch/riscv/kvm/isa.c
@@ -17,14 +17,14 @@
 /* Mapping between KVM ISA Extension ID & guest ISA extension ID */
 static const unsigned long kvm_isa_ext_arr[] = {
 	/* Single letter extensions (alphabetically sorted) */
-	[KVM_RISCV_ISA_EXT_A] = RISCV_ISA_EXT_a,
-	[KVM_RISCV_ISA_EXT_C] = RISCV_ISA_EXT_c,
-	[KVM_RISCV_ISA_EXT_D] = RISCV_ISA_EXT_d,
-	[KVM_RISCV_ISA_EXT_F] = RISCV_ISA_EXT_f,
-	[KVM_RISCV_ISA_EXT_H] = RISCV_ISA_EXT_h,
-	[KVM_RISCV_ISA_EXT_I] = RISCV_ISA_EXT_i,
-	[KVM_RISCV_ISA_EXT_M] = RISCV_ISA_EXT_m,
-	[KVM_RISCV_ISA_EXT_V] = RISCV_ISA_EXT_v,
+	KVM_ISA_EXT_ARR(A),
+	KVM_ISA_EXT_ARR(C),
+	KVM_ISA_EXT_ARR(D),
+	KVM_ISA_EXT_ARR(F),
+	KVM_ISA_EXT_ARR(H),
+	KVM_ISA_EXT_ARR(I),
+	KVM_ISA_EXT_ARR(M),
+	KVM_ISA_EXT_ARR(V),
 	/* Multi letter extensions (alphabetically sorted) */
 	KVM_ISA_EXT_ARR(SMNPM),
 	KVM_ISA_EXT_ARR(SMSTATEEN),
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index cb8a65273c1f0..70640701310c8 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -85,7 +85,7 @@ static int __init riscv_kvm_init(void)
 	char slist[64];
 	const char *str;
 
-	if (!riscv_isa_extension_available(NULL, h)) {
+	if (!riscv_isa_extension_available(NULL, H)) {
 		kvm_info("hypervisor extension not available\n");
 		return -ENODEV;
 	}
diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
index 6ad6df26a2fd4..bb11e6757d349 100644
--- a/arch/riscv/kvm/vcpu_fp.c
+++ b/arch/riscv/kvm/vcpu_fp.c
@@ -21,8 +21,8 @@ void kvm_riscv_vcpu_fp_reset(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
 
 	cntx->sstatus &= ~SR_FS;
-	if (riscv_isa_extension_available(vcpu->arch.isa, f) ||
-	    riscv_isa_extension_available(vcpu->arch.isa, d))
+	if (riscv_isa_extension_available(vcpu->arch.isa, F) ||
+	    riscv_isa_extension_available(vcpu->arch.isa, D))
 		cntx->sstatus |= SR_FS_INITIAL;
 	else
 		cntx->sstatus |= SR_FS_OFF;
@@ -38,9 +38,9 @@ void kvm_riscv_vcpu_guest_fp_save(struct kvm_cpu_context *cntx,
 				  const unsigned long *isa)
 {
 	if ((cntx->sstatus & SR_FS) == SR_FS_DIRTY) {
-		if (riscv_isa_extension_available(isa, d))
+		if (riscv_isa_extension_available(isa, D))
 			__kvm_riscv_fp_d_save(cntx);
-		else if (riscv_isa_extension_available(isa, f))
+		else if (riscv_isa_extension_available(isa, F))
 			__kvm_riscv_fp_f_save(cntx);
 		kvm_riscv_vcpu_fp_clean(cntx);
 	}
@@ -50,9 +50,9 @@ void kvm_riscv_vcpu_guest_fp_restore(struct kvm_cpu_context *cntx,
 				     const unsigned long *isa)
 {
 	if ((cntx->sstatus & SR_FS) != SR_FS_OFF) {
-		if (riscv_isa_extension_available(isa, d))
+		if (riscv_isa_extension_available(isa, D))
 			__kvm_riscv_fp_d_restore(cntx);
-		else if (riscv_isa_extension_available(isa, f))
+		else if (riscv_isa_extension_available(isa, F))
 			__kvm_riscv_fp_f_restore(cntx);
 		kvm_riscv_vcpu_fp_clean(cntx);
 	}
@@ -89,7 +89,7 @@ int kvm_riscv_vcpu_get_reg_fp(struct kvm_vcpu *vcpu,
 	void *reg_val;
 
 	if ((rtype == KVM_REG_RISCV_FP_F) &&
-	    riscv_isa_extension_available(vcpu->arch.isa, f)) {
+	    riscv_isa_extension_available(vcpu->arch.isa, F)) {
 		if (KVM_REG_SIZE(reg->id) != sizeof(u32))
 			return -EINVAL;
 		if (reg_num == KVM_REG_RISCV_FP_F_REG(fcsr))
@@ -102,7 +102,7 @@ int kvm_riscv_vcpu_get_reg_fp(struct kvm_vcpu *vcpu,
 		} else
 			return -ENOENT;
 	} else if ((rtype == KVM_REG_RISCV_FP_D) &&
-		   riscv_isa_extension_available(vcpu->arch.isa, d)) {
+		   riscv_isa_extension_available(vcpu->arch.isa, D)) {
 		if (reg_num == KVM_REG_RISCV_FP_D_REG(fcsr)) {
 			if (KVM_REG_SIZE(reg->id) != sizeof(u32))
 				return -EINVAL;
@@ -138,7 +138,7 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
 	void *reg_val;
 
 	if ((rtype == KVM_REG_RISCV_FP_F) &&
-	    riscv_isa_extension_available(vcpu->arch.isa, f)) {
+	    riscv_isa_extension_available(vcpu->arch.isa, F)) {
 		if (KVM_REG_SIZE(reg->id) != sizeof(u32))
 			return -EINVAL;
 		if (reg_num == KVM_REG_RISCV_FP_F_REG(fcsr))
@@ -151,7 +151,7 @@ int kvm_riscv_vcpu_set_reg_fp(struct kvm_vcpu *vcpu,
 		} else
 			return -ENOENT;
 	} else if ((rtype == KVM_REG_RISCV_FP_D) &&
-		   riscv_isa_extension_available(vcpu->arch.isa, d)) {
+		   riscv_isa_extension_available(vcpu->arch.isa, D)) {
 		if (reg_num == KVM_REG_RISCV_FP_D_REG(fcsr)) {
 			if (KVM_REG_SIZE(reg->id) != sizeof(u32))
 				return -EINVAL;
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index bb920e8923c93..5cc7ddd4aa276 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -770,7 +770,7 @@ static inline unsigned long num_fp_f_regs(const struct kvm_vcpu *vcpu)
 {
 	const struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
 
-	if (riscv_isa_extension_available(vcpu->arch.isa, f))
+	if (riscv_isa_extension_available(vcpu->arch.isa, F))
 		return sizeof(cntx->fp.f) / sizeof(u32);
 	else
 		return 0;
@@ -799,7 +799,7 @@ static inline unsigned long num_fp_d_regs(const struct kvm_vcpu *vcpu)
 {
 	const struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
 
-	if (riscv_isa_extension_available(vcpu->arch.isa, d))
+	if (riscv_isa_extension_available(vcpu->arch.isa, D))
 		return sizeof(cntx->fp.d.f) / sizeof(u64) + 1;
 	else
 		return 0;
@@ -878,7 +878,7 @@ static inline unsigned long num_sbi_regs(struct kvm_vcpu *vcpu)
 
 static inline unsigned long num_vector_regs(const struct kvm_vcpu *vcpu)
 {
-	if (!riscv_isa_extension_available(vcpu->arch.isa, v))
+	if (!riscv_isa_extension_available(vcpu->arch.isa, V))
 		return 0;
 
 	/* vstart, vl, vtype, vcsr, vlenb and 32 vector regs */
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 62d2fb77bb9b9..f26108a4e601e 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -26,7 +26,7 @@ void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
 
 	cntx->vector.vlenb = riscv_v_vsize / 32;
 
-	if (riscv_isa_extension_available(isa, v)) {
+	if (riscv_isa_extension_available(isa, V)) {
 		cntx->sstatus |= SR_VS_INITIAL;
 		WARN_ON(!cntx->vector.datap);
 		memset(cntx->vector.datap, 0, riscv_v_vsize);
@@ -45,7 +45,7 @@ void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
 				      unsigned long *isa)
 {
 	if ((cntx->sstatus & SR_VS) == SR_VS_DIRTY) {
-		if (riscv_isa_extension_available(isa, v))
+		if (riscv_isa_extension_available(isa, V))
 			__kvm_riscv_vector_save(cntx);
 		kvm_riscv_vcpu_vector_clean(cntx);
 	}
@@ -55,7 +55,7 @@ void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
 					 unsigned long *isa)
 {
 	if ((cntx->sstatus & SR_VS) != SR_VS_OFF) {
-		if (riscv_isa_extension_available(isa, v))
+		if (riscv_isa_extension_available(isa, V))
 			__kvm_riscv_vector_restore(cntx);
 		kvm_riscv_vcpu_vector_clean(cntx);
 	}
@@ -154,7 +154,7 @@ int kvm_riscv_vcpu_get_reg_vector(struct kvm_vcpu *vcpu,
 	void *reg_addr;
 	int rc;
 
-	if (!riscv_isa_extension_available(isa, v))
+	if (!riscv_isa_extension_available(isa, V))
 		return -ENOENT;
 
 	rc = kvm_riscv_vcpu_vreg_addr(vcpu, reg_num, reg_size, &reg_addr);
@@ -180,7 +180,7 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
 	void *reg_addr;
 	int rc;
 
-	if (!riscv_isa_extension_available(isa, v))
+	if (!riscv_isa_extension_available(isa, V))
 		return -ENOENT;
 
 	if (reg_num == KVM_REG_RISCV_VECTOR_CSR_REG(vlenb)) {

-- 
2.43.0

