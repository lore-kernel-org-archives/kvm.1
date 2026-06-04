Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C333C183;
	Thu,  4 Jun 2026 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540187; cv=none; b=hSN8C5NV44iEG5uga0aIkPNE3BiOk2hbwjbr2LRuTVJExiRyC4B561tbv7YbqRZxBuWFK/V0QTiAbN/aKXetZhuxEeC46+rrXfrOGIuKc+6FxfqF602myMpX8Be2sRwLMck/PjNkKRCNY57zT6askMKqJm7u2uwmO3TqiSeA/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540187; c=relaxed/simple;
	bh=P0FQ6WFdA7o8rBHTD3kg5sOtx8g75kGcjIE4dhaHyvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCm9GHlZhI5MYz0kDARxlGfvVKCP8XJfV6fwIKcF4w2/Owr/IvS2fKqICC4dY39L/NGdijQzxIlxtehA/azJXMwryMIwGpsbsvrbX/V5BUWv7YVl2SoNRMc8xKU/jwq5vMqfc9mndpEonC7kYjOToExLgCzzwred479ZSvx5x0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwJyh6ns; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwJyh6ns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780540186; x=1812076186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P0FQ6WFdA7o8rBHTD3kg5sOtx8g75kGcjIE4dhaHyvY=;
  b=LwJyh6ns8G6EuaL9+qleKnePvDBThwOgAOXzJDqPkloGLw0o+M3DG3yL
   rfpRtG4SIS7GbvWnRVhJlaxMRI2h7nQYQH5vfavfIFRSWRwYf0g8KzuYS
   kh5CmjpURjjV39W60IvBezE32UxQc3gQbH6wabkk5LuuSAhKqf+b+UztQ
   Za3vWYBnOrpXAWWYQm4Nlq0WJRmfuy75O+1r/Il9/58vmSCmN9XyoeYqG
   osC7bC8zMo4m6Pomd2G1PaCH8H9d+EfG+WupX2LwyBkBYbe6fc1DmKQvl
   qwPUw/h3C4ywNMSc4Ij6jS3TAmrNncs0xMHStdcRraiZSF7ctVZtrGgPm
   A==;
X-CSE-ConnectionGUID: c32aV1fiRE2DBX3IaBjOfA==
X-CSE-MsgGUID: 90NnRnqHTD6KZEKw5S4Txg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92045241"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92045241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:46 -0700
X-CSE-ConnectionGUID: RyYaxhUfRqa8w+23+xZmQA==
X-CSE-MsgGUID: 4icEnwJ1T624mO5SKqBO+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="239940487"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:43 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH v2 1/4] KVM: x86: TDX: Track supported configurable CPUID bits
Date: Thu,  4 Jun 2026 10:33:11 +0800
Message-ID: <20260604023314.3907511-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build an allowlist for TDX directly configurable CPUID bits that are
supported by KVM.

The TDX module reports a set of CPUID bits that the VMM can directly
configure for a TD, but KVM cannot blindly trust and expose all
module-supported bits to userspace. Certain features imply additional
architectural state (such as one or more host state clobbering MSRs)
that KVM must explicitly manage across host/guest transitions to
prevent host state corruption.

To safely manage this, track the specific subset of configurable CPUID
bits that KVM supports by initializing multi-bit fields statically and
populating individual feature bits dynamically during TDX hardware
setup.

For better readability and maintainability, define a macro
tdx_cpu_cfg_cap_init() to initialize the feature bits.

Subsequent patches will use this allowlist to consistently filter
KVM_TDX_CAPABILITIES and reject unsupported userspace input through
KVM_TDX_INIT_VM. This ensures that any newly introduced TDX configurable
CPUID bits remain hidden from userspace until KVM explicitly implements
the required virtualization support.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 174 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ffe9d0db58c5..e0567088ebf5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -52,6 +52,178 @@
 	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
 		     a1, a2, a3)
 
+#define TDX_CPUID_IGNORE_INDEX	BIT(0)
+struct tdx_supported_cpuid_reg {
+	u32 function;
+	u32 index;
+	u8 flags;
+	u8 reg;
+	u32 mask;
+};
+
+/*
+ * Multi-bit fields are statically initialized, feature bits are initialized
+ * in tdx_initialize_cpu_cfg_caps().
+ */
+static struct tdx_supported_cpuid_reg tdx_kvm_supported_cpuid[] __ro_after_init = {
+	{ 0x1, 0, 0, CPUID_EAX, GENMASK_U32(27, 16) | GENMASK_U32(13, 0) },
+	{ 0x1, 0, 0, CPUID_EBX, GENMASK_U32(23, 16) },
+	{ 0x1, 0, 0, CPUID_ECX, 0 },
+	{ 0x1, 0, 0, CPUID_EDX, 0 },
+	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EAX, ~GENMASK_U32(13, 10) },
+	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EBX, GENMASK_U32(31, 12) },
+	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_ECX, GENMASK_U32(31, 0) },
+	{ 0x4, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EDX, GENMASK_U32(2, 0) },
+	{ 0x7, 0, 0, CPUID_EBX, 0 },
+	{ 0x7, 0, 0, CPUID_ECX, 0 },
+	{ 0x7, 0, 0, CPUID_EDX, 0 },
+	{ 0x7, 1, 0, CPUID_EAX, 0 },
+	{ 0x7, 1, 0, CPUID_EDX, 0 },
+	{ 0x7, 2, 0, CPUID_EDX, 0 },
+	{ 0x18, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EDX, GENMASK_U32(25, 14) },
+	{ 0x1E, 1, 0, CPUID_EAX, 0 },
+	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EAX, GENMASK_U32(4, 0) },
+	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_EBX, GENMASK_U32(15, 0) },
+	{ 0x1F, 0, TDX_CPUID_IGNORE_INDEX, CPUID_ECX, GENMASK_U32(15, 0) },
+	/* See comments in td_init_cpuid_entry2() for CPUID 0x80000008 EAX[23:16]. */
+	{ 0x80000008, 0, 0, CPUID_EAX, GENMASK_U32(23, 16) | GENMASK_U32(7, 0) },
+	{ 0x80000008, 0, 0, CPUID_EBX, 0 },
+};
+
+#define TDX_F(name)					\
+({							\
+	tdx_cpu_cfg_caps |= feature_bit(name);		\
+})
+
+#define tdx_cpu_cfg_cap_init(_func, _index, _reg, feature_initializers...)		\
+do {											\
+	u32 tdx_cpu_cfg_caps = 0;							\
+											\
+	for (int i = 0; i < ARRAY_SIZE(tdx_kvm_supported_cpuid); i++) {			\
+		struct tdx_supported_cpuid_reg *r = &tdx_kvm_supported_cpuid[i];	\
+											\
+		if (r->function == _func && r->index == _index && r->reg == _reg) {	\
+			feature_initializers						\
+			r->mask |= tdx_cpu_cfg_caps;					\
+			break;								\
+		}									\
+	}										\
+											\
+	WARN_ON_ONCE(!tdx_cpu_cfg_caps); 						\
+} while (0)
+
+/* Only for TDX directly configurable CPUID feature bits */
+static void __init tdx_initialize_cpu_cfg_caps(void)
+{
+	tdx_cpu_cfg_cap_init(0x1, 0, CPUID_ECX,
+		TDX_F(MWAIT),
+		TDX_F(TSC_DEADLINE_TIMER),
+		TDX_F(AVX),
+		TDX_F(F16C),
+	);
+
+	tdx_cpu_cfg_cap_init(0x1, 0, CPUID_EDX,
+		TDX_F(MCE),
+		TDX_F(MTRR),
+		TDX_F(MCA),
+		TDX_F(SELFSNOOP),
+	);
+
+	tdx_cpu_cfg_cap_init(0x7, 0, CPUID_EBX,
+		TDX_F(BMI1),
+		/* HLE */
+		TDX_F(BMI2),
+		TDX_F(ERMS),
+		/* RTM */
+		/* CQM */
+		/* RDT-A */
+		TDX_F(AVX512F),
+		TDX_F(AVX512DQ),
+		TDX_F(ADX),
+		TDX_F(AVX512IFMA),
+		TDX_F(AVX512PF),
+		TDX_F(AVX512ER),
+		TDX_F(AVX512CD),
+		TDX_F(AVX512BW),
+		TDX_F(AVX512VL),
+	);
+
+	tdx_cpu_cfg_cap_init(0x7, 0, CPUID_ECX,
+		/* PREFETCHWT1 */
+		TDX_F(UMIP),
+		/* WAITPKG */
+		TDX_F(AVX512_VBMI2),
+		TDX_F(GFNI),
+		TDX_F(VAES),
+		TDX_F(VPCLMULQDQ),
+		TDX_F(AVX512_VNNI),
+		TDX_F(AVX512_BITALG),
+		/* TME */
+		TDX_F(AVX512_VPOPCNTDQ),
+		TDX_F(LA57),
+		TDX_F(RDPID),
+		TDX_F(CLDEMOTE),
+	);
+
+	tdx_cpu_cfg_cap_init(0x7, 0, CPUID_EDX,
+		TDX_F(AVX512_4VNNIW),
+		TDX_F(AVX512_4FMAPS),
+		TDX_F(FSRM),
+		TDX_F(AVX512_VP2INTERSECT),
+		TDX_F(SERIALIZE),
+		TDX_F(TSXLDTRK),
+		/* PCONFIG */
+		/* IA32_CORE_CAPABILITIES */
+	);
+
+	tdx_cpu_cfg_cap_init(0x7, 1, CPUID_EAX,
+		TDX_F(SHA512),
+		TDX_F(SM3),
+		TDX_F(SM4),
+		/* RAO_INT */
+		TDX_F(AVX_VNNI),
+		TDX_F(AVX512_BF16),
+		TDX_F(CMPCCXADD),
+		/* PERFMON */
+		TDX_F(FZRM),
+		TDX_F(FSRS),
+		TDX_F(FSRC),
+		/* FRED */
+		TDX_F(LKGS),
+		TDX_F(WRMSRNS),
+		TDX_F(AMX_FP16),
+		TDX_F(AVX_IFMA),
+		TDX_F(LAM),
+		TDX_F(MOVRS),
+	);
+
+	tdx_cpu_cfg_cap_init(0x7, 1, CPUID_EDX,
+		TDX_F(AVX_VNNI_INT8),
+		TDX_F(AVX_NE_CONVERT),
+		TDX_F(AVX_VNNI_INT16),
+		TDX_F(PREFETCHITI),
+		/* UMSR */
+		/* UIRET loads UIF */
+		TDX_F(AVX10),
+	);
+
+	tdx_cpu_cfg_cap_init(0x7, 2, CPUID_EDX,
+		TDX_F(DDPD_U),
+		TDX_F(MCDT_NO),
+	);
+
+	tdx_cpu_cfg_cap_init(0x1E, 1, CPUID_EAX,
+		TDX_F(AMX_FP8),
+		/* AMX-TRANSPOSE */
+		TDX_F(AMX_TF32),
+		TDX_F(AMX_AVX512),
+		TDX_F(AMX_MOVRS),
+	);
+
+	tdx_cpu_cfg_cap_init(0x80000008, 0, CPUID_EBX,
+		TDX_F(WBNOINVD),
+	);
+}
 
 bool enable_tdx __ro_after_init;
 module_param_named(tdx, enable_tdx, bool, 0444);
@@ -3493,6 +3665,8 @@ int __init tdx_hardware_setup(void)
 		return r;
 	}
 
+	tdx_initialize_cpu_cfg_caps();
+
 	KVM_SANITY_CHECK_VM_STRUCT_SIZE(kvm_tdx);
 
 	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));
-- 
2.46.0

