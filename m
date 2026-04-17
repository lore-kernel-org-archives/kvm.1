Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68771375F7B
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411165; cv=none; b=lTwWO2m+rCQeBRndgqls8nVv5jMkeeK2r8MUPvUIqWsrVI8tJXiuw9u++4LtZbpK9+66p0snTjpfIndmz0cSOd7gqhyHRYfP/cGgUxxUmj0lm5/D4aaKZz32vJe1kc68cMA/k+xC0bd3vNSnZmTURixXRuD80CTo5eQbXyNahoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411165; c=relaxed/simple;
	bh=uu/RBgPWPqCHA39BBdq3+zo1OyV3nj5DsZ7jEmyfUls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5zu/NnuYNIWbcCM1mV3OZEj4l3oMd7Weh8Z7dzZw0BG4WRFyLM9fXKp+a3UoSy4xu5ficbxDL5ttt29wL3oqYoV4M5svCnpmvqU2rfLAwpi6fVZuWLUezEUdVpPNfupI0k7o/WKBV98PLhFEmmsMB9s3E76kuMliOOvnsDrcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNQGuB+R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNQGuB+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411165; x=1807947165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uu/RBgPWPqCHA39BBdq3+zo1OyV3nj5DsZ7jEmyfUls=;
  b=hNQGuB+RMMZkfvm8beZCDC6nD9KGnFmiYWeRP2qrLJoqzmDyATsLcqrL
   +GuI14MaRepSVIL2iae/UuFYmRI1k43/h3+YfTCeccqa5g1mcxhD5XrEy
   mw4vdMh/TiiKQdndhTuhIWvWjyjlyAH0NA0CUkA1XBu0HD7b5Qc+AGZWQ
   NzDJaqTqcUrGsuzCtXdWOhTA41N/yec4eBv4sR2Zu11LltLbquixT7UFW
   oZa66EbVcfEWy8nuUjV7kVBgVXV8YV9odn0FczgqN5UxZdNNAf1mCchBi
   RQgcThN03YuKW8tDhK3vhfnbOZG3zOcyZNBaG5Z+j+ZBhqFFTHqkQxmFA
   g==;
X-CSE-ConnectionGUID: Wbm9KA05QVyLh1YCx8fyGQ==
X-CSE-MsgGUID: 3DdHyapHR/qCcIYmNYP87g==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070270"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070270"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:44 -0700
X-CSE-ConnectionGUID: 5GP8cnNqTDeBddsLt0v1/w==
X-CSE-MsgGUID: qixOna7+R8WQ7ziGoN3kVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285030"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:42 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 19/27] KVM: x86: Track KVM PV CPUID features for paranoid mode
Date: Fri, 17 Apr 2026 15:36:02 +0800
Message-ID: <20260417073610.3246316-20-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track KVM's PV CPUID features to the kvm_cpu_caps so that they can be
covered by paranoid CPUID verification.

Define KVM_PV_FEATURE_* constants in reverse_cpuid.h, mirroring the UAPI
KVM_FEATURE_* bit positions, and add a new PV_F() macro to initialize PV
features within kvm_cpu_cap_init() for the new added CPUID_4000_0001_EAX.

PV_F() marks it as emulated, since PV features are entirely software
defined. Also, teach raw_cpuid_get() to return 0 for the
KVM_CPUID_SIGNATURE base without WARNing, as PV features have no hardware
backing and querying raw CPUID for them is expected to be a no-op.

Note KVM PV CPUID base could be relocated to resolve the conflict with
other virtualization enhancements (e.g., HyperV is also enabled by
userspace), the KVM PV CPUID verification in CPUID paranoid mode will be
skipped in this case in a future patch.

Ignore EAX and EBX of leaf 0x40000010 (tsc_khz and apic_bus_freq), which
are allowed multi-bit fields.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            | 41 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.h            |  3 ++-
 arch/x86/kvm/reverse_cpuid.h    | 22 ++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2ec4d92e3e79..f6d79e8496c3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -850,6 +850,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_8000_001F_EBX,
 	CPUID_8000_0021_EBX,
 	CPUID_8000_0022_EBX,
+	CPUID_4000_0001_EAX,
 	NR_KVM_CPU_CAPS_PARANOID,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS_PARANOID - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c75e7859cc2c..789ec9eb7aaf 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -887,6 +887,18 @@ do {									\
 	KVM_VALIDATE_CPU_CAP_USAGE(name);			\
 })
 
+#define PV_F(name, overlay_mask)							\
+({											\
+	BUILD_BUG_ON(__feature_leaf(KVM_PV_FEATURE_##name) != CPUID_4000_0001_EAX);	\
+	BUILD_BUG_ON(kvm_cpu_cap_init_in_progress != CPUID_4000_0001_EAX);		\
+											\
+	kvm_cpu_cap_emulated |= pv_feature_bit(name);					\
+	for (int i = 0; i < NR_CPUID_OL; i++) {						\
+		if ((overlay_mask) & BIT(i))						\
+			kvm_cpu_caps[i][CPUID_4000_0001_EAX] |= pv_feature_bit(name);	\
+	}										\
+})
+
 /*
  * Undefine the MSR bit macro to avoid token concatenation issues when
  * processing X86_FEATURE_SPEC_CTRL_SSBD.
@@ -1586,6 +1598,35 @@ void kvm_initialize_cpu_caps(void)
 		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP, F_CPUID_DEFAULT);
 		kvm_cpu_cap_clear(X86_FEATURE_RDPID, F_CPUID_DEFAULT);
 	}
+
+	kvm_cpu_cap_ignore(KVM_CPUID_SIGNATURE, 0, 0,
+			   BIT(CPUID_EAX) | BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_DEFAULT | F_CPUID_TDX);
+
+	kvm_cpu_cap_init(CPUID_4000_0001_EAX,
+		PV_F(CLOCKSOURCE, F_CPUID_DEFAULT),
+		PV_F(NOP_IO_DELAY, F_CPUID_DEFAULT | F_CPUID_TDX),
+		PV_F(CLOCKSOURCE2, F_CPUID_DEFAULT),
+		PV_F(ASYNC_PF, F_CPUID_DEFAULT),
+		PV_F(PV_EOI, F_CPUID_DEFAULT),
+		PV_F(PV_UNHALT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		PV_F(PV_TLB_FLUSH, F_CPUID_DEFAULT | F_CPUID_TDX),
+		PV_F(ASYNC_PF_VMEXIT, F_CPUID_DEFAULT),
+		PV_F(PV_SEND_IPI, F_CPUID_DEFAULT | F_CPUID_TDX),
+		PV_F(POLL_CONTROL, F_CPUID_DEFAULT | F_CPUID_TDX),
+		PV_F(PV_SCHED_YIELD, F_CPUID_DEFAULT | F_CPUID_TDX),
+		PV_F(ASYNC_PF_INT, F_CPUID_DEFAULT),
+		PV_F(MSI_EXT_DEST_ID, F_CPUID_DEFAULT | F_CPUID_TDX),
+		PV_F(HC_MAP_GPA_RANGE, F_CPUID_DEFAULT),
+		PV_F(MIGRATION_CONTROL, F_CPUID_DEFAULT),
+		PV_F(CLOCKSOURCE_STABLE_BIT, F_CPUID_DEFAULT),
+	);
+
+	if (sched_info_on())
+		kvm_cpu_cap_set(KVM_PV_FEATURE_STEAL_TIME, F_CPUID_DEFAULT);
+
+	kvm_cpu_cap_ignore(KVM_CPUID_SIGNATURE | 0x10, 0, 0,
+			   BIT(CPUID_EAX) | BIT(CPUID_EBX), F_CPUID_DEFAULT | F_CPUID_TDX);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_initialize_cpu_caps);
 
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 0b90344a8b98..535377e519b5 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -270,7 +270,8 @@ static __always_inline u32 raw_cpuid_get(struct cpuid_reg cpuid)
 	 * defined, as this and other code would need to be updated.
 	 */
 	base = cpuid.function & 0xffff0000;
-	if (WARN_ON_ONCE(base && base != 0x80000000 && base != 0xc0000000))
+	if (base == KVM_CPUID_SIGNATURE ||
+	    WARN_ON_ONCE(base && base != 0x80000000 && base != 0xc0000000))
 		return 0;
 
 	if (cpuid_eax(base) < cpuid.function)
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 1bdb05aaa852..03a88ab3585d 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -79,6 +79,26 @@
 /* CPUID level 0x6 (ECX) */
 #define KVM_X86_FEATURE_APERFMPERF	KVM_X86_FEATURE(CPUID_6_ECX, 0)
 
+/* CPUID level 0x40000001 (EAX) */
+#define KVM_PV_FEATURE_CLOCKSOURCE		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 0)
+#define KVM_PV_FEATURE_NOP_IO_DELAY		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 1)
+#define KVM_PV_FEATURE_MMU_OP			KVM_X86_FEATURE(CPUID_4000_0001_EAX, 2)
+#define KVM_PV_FEATURE_CLOCKSOURCE2		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 3)
+#define KVM_PV_FEATURE_ASYNC_PF			KVM_X86_FEATURE(CPUID_4000_0001_EAX, 4)
+#define KVM_PV_FEATURE_STEAL_TIME		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 5)
+#define KVM_PV_FEATURE_PV_EOI			KVM_X86_FEATURE(CPUID_4000_0001_EAX, 6)
+#define KVM_PV_FEATURE_PV_UNHALT		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 7)
+#define KVM_PV_FEATURE_PV_TLB_FLUSH		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 9)
+#define KVM_PV_FEATURE_ASYNC_PF_VMEXIT		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 10)
+#define KVM_PV_FEATURE_PV_SEND_IPI		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 11)
+#define KVM_PV_FEATURE_POLL_CONTROL		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 12)
+#define KVM_PV_FEATURE_PV_SCHED_YIELD		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 13)
+#define KVM_PV_FEATURE_ASYNC_PF_INT		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 14)
+#define KVM_PV_FEATURE_MSI_EXT_DEST_ID		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 15)
+#define KVM_PV_FEATURE_HC_MAP_GPA_RANGE		KVM_X86_FEATURE(CPUID_4000_0001_EAX, 16)
+#define KVM_PV_FEATURE_MIGRATION_CONTROL	KVM_X86_FEATURE(CPUID_4000_0001_EAX, 17)
+#define KVM_PV_FEATURE_CLOCKSOURCE_STABLE_BIT	KVM_X86_FEATURE(CPUID_4000_0001_EAX, 24)
+
 struct cpuid_reg {
 	u32 function;
 	u32 index;
@@ -168,6 +188,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_001F_EBX] = {0x8000001f, 0, CPUID_EBX},
 	[CPUID_8000_0021_EBX] = {0x80000021, 0, CPUID_EBX},
 	[CPUID_8000_0022_EBX] = {0x80000022, 0, CPUID_EBX},
+	[CPUID_4000_0001_EAX] = {0x40000001, 0, CPUID_EAX},
 };
 
 /*
@@ -239,6 +260,7 @@ static __always_inline u32 __feature_bit(int x86_feature)
 }
 
 #define feature_bit(name)  __feature_bit(X86_FEATURE_##name)
+#define pv_feature_bit(name)  __feature_bit(KVM_PV_FEATURE_##name)
 
 static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned int x86_feature)
 {
-- 
2.46.0

