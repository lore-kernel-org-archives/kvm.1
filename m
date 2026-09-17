Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647D46D08C;
	Thu, 17 Sep 2026 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629695; cv=none; b=RS7552D5ymOCJHl21+3ISNB1ysuUWD7Z89F+h3X9OpgOpTc0G1fHwpQqqdauwozeHY5+Sj0LdwiWd6FDbUEVrv4xAq840zbQ96IoYpP78bMXGHlq3tBEuSCSxnazg+GmNAN5YjwFG74hkuWwlBXucnkQ70m/xwX8+/NYganQyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629695; c=relaxed/simple;
	bh=6X9vWFAJYhXEM3/Oimput5+0fsO5eVn90vKz882z0kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOeNlSw9LgErULwXFhGWdN3FXAv08iQEBKxyDb1GWjKKDhVZrmIfkhMAhhyNaL3SbIvQd4+WeIGzuu/uBzPMMsFXvHnJtAiejn5F2qIsfVSOA73ch57LpMQiQTD0BX4kZGnxE6+YkPc2ybfgH42rNwWVCdliQFZFkpTNg4mcWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CATVygy2; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CATVygy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789629691; x=1821165691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6X9vWFAJYhXEM3/Oimput5+0fsO5eVn90vKz882z0kM=;
  b=CATVygy2GjO2se4efCyesK7gg05JyjABZLInKTj/VN39HC6XJhWfQp7r
   baK9UZJ+69+dZSI6iAq/CICzZ37/0WM/DfOCJdLzzje+CMFCrOgFug+DH
   jxD4EWdRmjq3PcZ2wa+8Qmjj2DCtmC1Mxv6ApantMmfKh02m1+AbRZ0vM
   rmfApF8DvX83r8ZgSE/TY1lCewPWGLu2gflhQKRuoeKSqXpAx08vbcblQ
   y0JmLpSwr2PNBXUVZcuBMPqBXWeKekKskWfR8BvfJh22OQbvgR5kQ9Reg
   cwc2ZPlvGAD29piv6HaC30cuwQF6oq+mYNR3wrkyNKdvNgX2ypi+n/gRl
   g==;
X-CSE-ConnectionGUID: fkP1ibI4TMqxbUVa0o/9vQ==
X-CSE-MsgGUID: sUEVf9DhQ/W02hYOZjptpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="531838"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="531838"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:30 -0700
X-CSE-ConnectionGUID: iFcbTfoUToKAGGoiRP7Jiw==
X-CSE-MsgGUID: 0N6tVA+FQ5++Tn3tQdKRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1849257"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:27 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	tony.lindgren@linux.intel.com,
	kishen.maloor@intel.com,
	dedekind1@gmail.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v4 1/4] KVM: TDX: Track configurable CPUID bits allowed by KVM
Date: Thu, 17 Sep 2026 15:25:45 +0800
Message-ID: <20260917072548.2314491-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
CPUID feature bits that KVM supports, and build the masks during TDX
hardware setup via tdx_initialize_cpu_cfg_caps().

The TDX module reports the CPUID bits that the VMM can directly configure
for a TD, but KVM cannot blindly expose all reported bits to userspace.
Certain features imply additional architectural state, e.g. one or more
MSRs, that KVM must explicitly manage across host/guest transitions to
prevent host state corruption.  The existing hardcoded denylist cannot
account for new host state clobbering features introduced by future TDX
modules.

Except for a few fixed-1 bits required for basic TDX support, host state
clobbering features are either directly configurable or gated by TD
ATTRIBUTES/XFAM, which KVM already validates.  Tracking only the directly
configurable bits to build an allowlist is therefore sufficient.

Organize tdx_cpu_cfg_caps[] following kvm_cpu_caps[] so that the masks can
be built with similar feature-name based initializers.  Directly
configurable non-feature bits will be handled separately.

The allowlist is prepared to be consumed by later patches to filter
KVM_TDX_CAPABILITIES and to reject unsupported CPUID input to
KVM_TDX_INIT_VM, so that newly introduced TDX directly configurable CPUID
feature bits stay hidden from userspace until KVM explicitly opts in.

By default, intersect the allowlist with kvm_cpu_caps[] via TDX_CFG_F().
Requiring support for non-TDX VMs avoids committing to TDX-specific
behavior before general KVM support is established, and respects KVM's
logic around disabling certain features, since the reasons for disabling
them could apply to TDX as well.  Allow exceptions through
TDX_CFG_EXTRA_F() only with sufficient justification.

Add comments as placeholders for HLE, RTM, WAITPKG and FRED, which KVM
doesn't support for TDX yet.

Allow MWAIT, XTPR, and HT through TDX_CFG_EXTRA_F(), as these bits are
not advertised in kvm_cpu_caps[].  The remaining directly configurable
feature bits outside kvm_cpu_caps[] are left out of the allowlist:

  - Features forced to zero when #VE is reduced, or lacking KVM support
    for the associated MSRs: EST, TM2, SDBG, DCA, ACPI, ACC (TM), RDT_A,
    RDT_M, TME, PCONFIG, and CORE_CAPABILITIES.  Handle CORE_CAPABILITIES
    in a subsequent patch.

  - Features tied to IA32_MISC_ENABLE bits that a TD cannot set when
    TDCS.TD_CTLS.REDUCE_VE is set: CID and PBE.

  - Features that can clobber host state and lack KVM support for TDX:
    FRED.

  - Unsupported features: PREFETCHWT1 (Xeon Phi only), PSN (absent from
    TDX-capable CPUs), AMX-TRANSPOSE (never implemented on an Intel
    platform), and RAO_INT (defined only for future processors).

Filtering KVM_TDX_CAPABILITIES in a subsequent patch will intentionally
stop advertising the excluded bits as configurable, as the corresponding
features are unsupported or cannot be properly virtualized.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v4:
- Add XTPR and HT to the allowlist.
- Explain in the changelog why some directly configurable bits are not
  added to the allowlist.
- Improve comments/changelog. (Xiaoyao)
- Fix the bug that AMX_COMPLEX should be added for CPUID_1E_1_EAX instead
  of CPUID_7_1_EDX.

v3:
- Drop the new data structure in v2 and only track feature bits by
  following the organization of kvm_cpu_caps[], handle non-feature
  bits separately. (Sean)
- Use two versions of macros (TDX_CFG_F() vs. TDX_CFG_EXTRA_F()) to
  distinguish whether a supported TDX configurable CPUID bit should be
  checked against KVM's common cpu capabilities.
- Add AMX_COMPLEX since it has been defined in the CPUID virtualization doc.
---
 arch/x86/kvm/vmx/tdx.c | 164 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 8a3f88b79b83d..2b51a85c998e8 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -52,6 +52,168 @@
 	__TDX_BUG_ON(__err, #__fn, __kvm, ", " #a1 " 0x%llx, " #a2 ", 0x%llx, " #a3 " 0x%llx", \
 		     a1, a2, a3)
 
+static u32 tdx_cpu_cfg_caps[NR_KVM_CPU_CAPS] __ro_after_init;
+static_assert(ARRAY_SIZE(tdx_cpu_cfg_caps) == ARRAY_SIZE(kvm_cpu_caps));
+
+#define TDX_VALIDATE_CPU_CAP_USAGE(name)			\
+	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) !=	\
+		     tdx_cpu_cap_init_in_progress)
+
+/* For a feature bit that needs to be cap'ed by kvm_cpu_caps[]. */
+#define TDX_CFG_F(name)					\
+({							\
+	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
+	tdx_cfg_caps |= feature_bit(name);		\
+})
+
+/*
+ * For a feature bit that KVM allows for TDX guests even though it isn't
+ * advertised through kvm_cpu_caps[], e.g. MWAIT.  Use this version only when
+ * there is a justification.
+ */
+#define TDX_CFG_EXTRA_F(name)				\
+({							\
+	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
+	tdx_cfg_caps_extra |= feature_bit(name);	\
+})
+
+#define tdx_cpu_cfg_cap_init(leaf, feature_initializers...)		\
+do {									\
+	const u32 __maybe_unused tdx_cpu_cap_init_in_progress = leaf;	\
+	u32 tdx_cfg_caps_extra = 0;					\
+	u32 tdx_cfg_caps = 0;						\
+									\
+	feature_initializers						\
+	tdx_cpu_cfg_caps[leaf] = (tdx_cfg_caps & kvm_cpu_caps[leaf]) |	\
+				 tdx_cfg_caps_extra;			\
+} while (0)
+
+/*
+ * Initialize tdx_cpu_cfg_caps[], the list of CPUID features that KVM
+ * supports for TDX guests.  It covers only the directly configurable CPUID
+ * bits reported by the TDX module; features controlled by XFAM and
+ * ATTRIBUTES are handled separately.
+ */
+static void __init tdx_initialize_cpu_cfg_caps(void)
+{
+	tdx_cpu_cfg_cap_init(CPUID_1_ECX,
+		/*
+		 * KVM allows userspace to enumerate MONITOR+MWAIT support to
+		 * the guest, but the MWAIT feature flag is never advertised
+		 * to userspace for non-TDX VMs.
+		 */
+		TDX_CFG_EXTRA_F(MWAIT),
+		/*
+		 * XTPR can be exposed to a TD, but it never takes effect in
+		 * the underlying hardware when the TD changes
+		 * IA32_MISC_ENABLE[23].
+		 */
+		TDX_CFG_EXTRA_F(XTPR),
+		TDX_CFG_F(TSC_DEADLINE_TIMER),
+		TDX_CFG_F(AVX),
+		TDX_CFG_F(F16C),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_1_EDX,
+		TDX_CFG_F(MCE),
+		TDX_CFG_F(MTRR),
+		TDX_CFG_F(MCA),
+		TDX_CFG_F(SELFSNOOP),
+		/*
+		 * HT is a topology enumeration bit that KVM doesn't care
+		 * about, but userspace may want to expose it to the guests.
+		 */
+		TDX_CFG_EXTRA_F(HT),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_7_0_EBX,
+		TDX_CFG_F(BMI1),
+		/* HLE */
+		TDX_CFG_F(BMI2),
+		TDX_CFG_F(ERMS),
+		/* RTM */
+		TDX_CFG_F(AVX512F),
+		TDX_CFG_F(AVX512DQ),
+		TDX_CFG_F(ADX),
+		TDX_CFG_F(AVX512IFMA),
+		TDX_CFG_F(AVX512PF),
+		TDX_CFG_F(AVX512ER),
+		TDX_CFG_F(AVX512CD),
+		TDX_CFG_F(AVX512BW),
+		TDX_CFG_F(AVX512VL),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_7_ECX,
+		TDX_CFG_F(UMIP),
+		/* WAITPKG */
+		TDX_CFG_F(AVX512_VBMI2),
+		TDX_CFG_F(GFNI),
+		TDX_CFG_F(VAES),
+		TDX_CFG_F(VPCLMULQDQ),
+		TDX_CFG_F(AVX512_VNNI),
+		TDX_CFG_F(AVX512_BITALG),
+		TDX_CFG_F(AVX512_VPOPCNTDQ),
+		TDX_CFG_F(LA57),
+		TDX_CFG_F(RDPID),
+		TDX_CFG_F(CLDEMOTE),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_7_EDX,
+		TDX_CFG_F(AVX512_4VNNIW),
+		TDX_CFG_F(AVX512_4FMAPS),
+		TDX_CFG_F(FSRM),
+		TDX_CFG_F(AVX512_VP2INTERSECT),
+		TDX_CFG_F(SERIALIZE),
+		TDX_CFG_F(TSXLDTRK),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_7_1_EAX,
+		TDX_CFG_F(SHA512),
+		TDX_CFG_F(SM3),
+		TDX_CFG_F(SM4),
+		TDX_CFG_F(AVX_VNNI),
+		TDX_CFG_F(AVX512_BF16),
+		TDX_CFG_F(CMPCCXADD),
+		TDX_CFG_F(FZRM),
+		TDX_CFG_F(FSRS),
+		TDX_CFG_F(FSRC),
+		/* FRED */
+		TDX_CFG_F(LKGS),
+		TDX_CFG_F(WRMSRNS),
+		TDX_CFG_F(AMX_FP16),
+		TDX_CFG_F(AVX_IFMA),
+		TDX_CFG_F(LAM),
+		TDX_CFG_F(MOVRS),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_7_1_EDX,
+		TDX_CFG_F(AVX_VNNI_INT8),
+		TDX_CFG_F(AVX_NE_CONVERT),
+		TDX_CFG_F(AVX_VNNI_INT16),
+		TDX_CFG_F(PREFETCHITI),
+		TDX_CFG_F(AVX10),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_7_2_EDX,
+		TDX_CFG_F(DDPD_U),
+		TDX_CFG_F(MCDT_NO),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_1E_1_EAX,
+		TDX_CFG_F(AMX_COMPLEX_ALIAS),
+		TDX_CFG_F(AMX_FP8),
+		TDX_CFG_F(AMX_TF32),
+		TDX_CFG_F(AMX_AVX512),
+		TDX_CFG_F(AMX_MOVRS),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_8000_0008_EBX,
+		TDX_CFG_F(WBNOINVD),
+	);
+}
+
+#undef TDX_CFG_F
+#undef TDX_CFG_EXTRA_F
 
 bool enable_tdx __ro_after_init;
 module_param_named(tdx, enable_tdx, bool, 0444);
@@ -3487,6 +3649,8 @@ int __init tdx_hardware_setup(void)
 		return r;
 	}
 
+	tdx_initialize_cpu_cfg_caps();
+
 	KVM_SANITY_CHECK_VM_STRUCT_SIZE(kvm_tdx);
 
 	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));
-- 
2.46.0

