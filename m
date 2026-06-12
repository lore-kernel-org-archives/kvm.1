Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED353A9632
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292554; cv=none; b=QGsosEC+RK7KtvK6J0AQK7975Lu+heqNe3YoEUdODmVuuDhTrsX8imDhlBx0CQetafGxD2FYehiwSSWyRcWPacg9TGPMw1MBhwcR9rf8FvnwEdaYhEH+CiNdwp57vrtoqY+hvBFTB8DwMxSpYXH9lantZKbz00E9t16WNNKo0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292554; c=relaxed/simple;
	bh=5kGKr+m+2SakCtheR8UcEY2IRqG2QSoWSyyeWDBZdSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTqd9MYA0JfJn9WfFHBqVP7U7PP34Sx0hJAMX2Rnz6pCD2ZfzcQJDqTWS03/crw7O8IdFMDR9A1RvP7F9KsIMGivLnfmx0BDl+RvdlWGeAwD/jf/VXFIvq4QLlWSW9js0N5EvoYKhC53gSl7fC+SSwAZT6EK2sYiKUyyv1YpDSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8Zfw3qF; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8Zfw3qF"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4856ecace68so1349811b6e.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292552; x=1781897352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlOJEoz94FuxFi6Nw0eWYLZk82W0XKPPEF+zFyUMrwY=;
        b=s8Zfw3qF9fCxp9p7wpSOuKQkcv4zEmEt2xL78cUcoOCUv3UUoG6ZGmxN4s1xwHf5d9
         px/Q+Jq516VmQSk/8eGvkZJyyDShxJrS+vWluXgkDa9pdSm410JYJtistYfHrlr00j7w
         lIuLZRbb1jxT6NQXwQPfYa3x5B/ms6F19YzmT7Ds+nAhEhRPwwOrdX7BwLalcL+AFHl3
         Ur/+kKRGC63xJCrmadjRoRtM1CuBeImL9BYHCyt8jDSi4hYVfVUzJVhfWACfPJ58EECo
         bdG+H2dPGfhFzZ2pIrTIl4RXnr0IowvMjW0/3JbVQ+tw69f0WbNQAOKMGLoFB92f0WBM
         /u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292552; x=1781897352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlOJEoz94FuxFi6Nw0eWYLZk82W0XKPPEF+zFyUMrwY=;
        b=QtDRfcIK5N8SX9jeeauPq4MZ++yXxzaRnTNtPmCQGv6hH1pRkX1/Ox+a9jBtziAaSN
         1A+VFahh4YV7C503S+qxDGH93RzqqU4qXz1MlRgqPoP9KqLIdmq2/EisufWeRO2D12D3
         7WCaZ9DxUsCPiuQHhxN/Z+IqYHycNnsL7VtQf4y2SADbhY48H0yJAF1BT/QIAfo9x573
         +xHq3s1f4uXLsGmxQjuK8E04oKtj1jEQe5KVrRueu6WqBuaH6AflluUQ8X7fhj8AfztY
         8oEv5j2mfT7WodDLJAQHZIXSNfLRNR5Wy87kvdbJ8mAmxL8HCC004ozSTBWGuXOGENv5
         Rd2Q==
X-Gm-Message-State: AOJu0YzWMDrW9dQ/e+lfoD38tFgsf+8atXi+1sk+1lTyHFK6hQsWjE1k
	BWzmnCS6hj7+sNRVe/Cd3Gk0Ea6dIGtcP68l9HVpMy3kcNpuFp3xNKVR1PZPSJTjXQ/KXNbfmx9
	po/fx2MZ/VCCcVNhmp4i6WI8547SqmrvN5YiF0YgB5gV04G2xAxjhs+hc1sc/kRQGULkSTCAAan
	xpbf06/6t/+7BgXMpP1buFI4Hd0Unw2cAA9OZ1f7Pqr/sj42PjAcuh57TAwEc=
X-Received: from ilb5-n2.prod.google.com ([2002:a05:6e02:5305:20b0:500:2417:f074])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1913:b0:486:45c7:34c5 with SMTP id 5614622812f47-487419e6d1emr682785b6e.17.1781292551319;
 Fri, 12 Jun 2026 12:29:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:28:49 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-2-coltonlewis@google.com>
Subject: [PATCH 01/21] arm64: cpufeature: Add cpucap for HPMN0
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
counters reserved for the guest.

This required changing HPMN0 to an UnsignedEnum in tools/sysreg
because otherwise not all the appropriate macros are generated to add
it to arm64_cpu_capabilities_arm64_features.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kernel/cpufeature.c | 10 +++++++++-
 arch/arm64/kvm/sys_regs.c      |  3 ++-
 arch/arm64/tools/cpucaps       |  1 +
 arch/arm64/tools/sysreg        |  6 +++---
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6d53bb15cf7bb..096545a6e4043 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -77,7 +77,7 @@
 #include <linux/percpu.h>
 #include <linux/sched/isolation.h>
 
-#include <asm/arm_pmuv3.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
@@ -560,6 +560,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
@@ -2965,6 +2966,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
 	},
+	{
+		.desc = "HPMN0",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HAS_HPMN0,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
+	},
 #ifdef CONFIG_ARM64_SME
 	{
 		.desc = "Scalable Matrix Extension",
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index fa5c93c7a1352..c52873a6f91ed 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -3326,7 +3326,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		    ID_AA64DFR0_EL1_DoubleLock_MASK |
 		    ID_AA64DFR0_EL1_WRPs_MASK |
 		    ID_AA64DFR0_EL1_PMUVer_MASK |
-		    ID_AA64DFR0_EL1_DebugVer_MASK),
+		    ID_AA64DFR0_EL1_DebugVer_MASK |
+		    ID_AA64DFR0_EL1_HPMN0_MASK),
 	ID_SANITISED(ID_AA64DFR1_EL1),
 	ID_UNALLOCATED(5,2),
 	ID_UNALLOCATED(5,3),
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 811c2479e82d6..f8fb4a6395428 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -42,6 +42,7 @@ HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
 HAS_ICH_HCR_EL2_TDIR
 HAS_HCR_NV1
+HAS_HPMN0
 HAS_HCX
 HAS_LDAPR
 HAS_LPA2
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 6c3ff14e561e6..2d5cbc8ced114 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1679,9 +1679,9 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
-Enum	63:60	HPMN0
-	0b0000	UNPREDICTABLE
-	0b0001	DEF
+UnsignedEnum	63:60	HPMN0
+	0b0000	NI
+	0b0001	IMP
 EndEnum
 UnsignedEnum	59:56	ExtTrcBuff
 	0b0000	NI
-- 
2.54.0.1136.gdb2ca164c4-goog

