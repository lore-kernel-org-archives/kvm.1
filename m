Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175203;
	b=aklEiU4AV/lc4BbCXK0AkqX13vC2CDqtPkaIhwkAmUHi/MS21ELKUbGlvuFgfwhPSv02
	 TOX98423BmEH8FHd6Qwyl6ql3m6w76gJXxvJs4wg4FcL0SvnbeRuf/45ViD+mPbEZGhKe
	 BRovA8eE7CCsVv/I+UiDMnAdob8CBPSZVzy6rS8FiDBxCHXwAx9k7EgPBHyskDXVFb4n1
	 upEOH0S8RO0APyqGkNAqmI03pbyWrfoAfBM0lIWQGgqZSBGMqHtQ9pfm3smkpOz8JSudZ
	 8P7Gcs9aMEx8Tb0PUtvmzcSV0swbVcF8GWtfrqiShglu+NaGUW+Rmao8yOgb30yHYNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175203;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=deLTHC8pN8Uy8mnH0c/FIGQmtyBl2XAmGjdIVK7307E=;
	b=DJCXUJyPjU7/KiBKbiC03B3h1x9eqAhiPm6WK5IC8d58XUYyvL1d1c7UjhROsXxuxTDx
	 eiCTrXXiFOkykFnCCBtVT5kaf41FOA5kqKfHXAXZWRW2+OfA85Fa1nu1tiwr4YofoxPBg
	 +Phf8mWFuGSCuNvEGojCJ/9xLLsx/ds2QBUfCunrthBpU264oDouvLS8fZWSR0AS65Dz/
	 z6PgZziUtFevPSNif4F6SiGdBFriqyzAhIzr7dEuAB7gluSGq0R4fnm5wXVw/YEwpHMbJ
	 xSIlNyi1Aol4Ol+7RsUUstWg8E/Xb8yIUl0HcNG7R89L0e0Rxq2T4sOQeJCYEFSp5vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J95cT2qP;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231BA606A320;
	Wed, 28 Oct 2026 08:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 231BA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J95cT2qP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793175203; x=1824711203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lHgBwC8tk8fXBanPswA3KG3Vvg6p5HLBXBJTHYnbSrE=;
  b=J95cT2qPcTaTsNBUpeHX6F0JVOEtCN7lZbEXK8EAE14ciAA/KrR/h+tO
   KSdUG/LLkxbLsPBel535Y1FT7xuwPRb89Qv+2uC5JLWdWJ6IOAHhW8HTz
   51oPpm7/V+RHPnaGj5PifobA+RENg3aC49uZK/HcqZkOUoQkuEpUt5uM6
   DGNvGt5sJ9mEKIuOWyu32MWmKUTm8G5OSNngAwkOL6NHaOQzy6uzISh8P
   ASQq3HFpv4Gu5Ug4Fk5dTGm7D+1Ib0P1/WGZ18/t8IZj5eqR5W35IHlh9
   UMGvUpbaRKXOrN5aKnF6bpmV/DbkkkNzM3MbFzUZkH0sFE3FQCllngsVr
   g==;
X-CSE-ConnectionGUID: 80mgpg9NTFaPsF0Lo6j0RA==
X-CSE-MsgGUID: ZKHRdLDFQqWXV66fJz9oAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1902907"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1902907"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:19 -0700
X-CSE-ConnectionGUID: hpe5ohEUS4uZOJ4WFFMSdg==
X-CSE-MsgGUID: fvOA6EonQv+JAD/lFz2r0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5118488"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:14 -0700
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
Subject: [PATCH v6 1/4] KVM: TDX: Track configurable CPUID bits allowed by KVM
Date: Wed, 28 Oct 2026 16:16:54 +0800
Message-ID: <20261028081658.1228484-2-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
References: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
CPUID feature bits that KVM supports, and initialize it during TDX
hardware setup.

The TDX module reports the CPUID bits that the VMM can directly configure
for a TD, but KVM can't blindly expose every reported bit to userspace.
Some features imply additional state, e.g. MSRs, that KVM must context
switch across host/guest transitions to avoid corrupting host state.  The
existing hardcoded denylist can't account for such features introduced by
future TDX modules.

Aside from a few fixed-1 bits required for basic TDX support, features
that can clobber host state are either directly configurable or controlled
by TD ATTRIBUTES/XFAM, which KVM already validates.  Thus, an allowlist
covering only the directly configurable bits is sufficient.

Organize tdx_cpu_cfg_caps[] like kvm_cpu_caps[] so that the allowlist can
be built with feature-name based initializers.  Directly configurable bits
that aren't feature flags will be handled when building the per-register
masks for KVM_TDX_CAPABILITIES.

Sort the directly configurable CPUID feature bits into three categories:

 1) Features that KVM supports and tracks in kvm_cpu_caps[].  Use
    TDX_CFG_F() so that they are also capped by kvm_cpu_caps[].

 2) Features that KVM supports, or can safely allow, but doesn't track in
    kvm_cpu_caps[], i.e. MWAIT and HT.  Use TDX_CFG_INDEPENDENT_F().

 3) Features that are obsolete or unsupported by KVM, and thus excluded,
    i.e. EST, TM2, CID, SDBG, XTPR, DCA, PN (PSN), ACPI, ACC (TM), PBE,
    HLE, RTM, CQM (RDT_M), RDT_A, PREFETCHWT1, WAITPKG, TME, PCONFIG,
    CORE_CAPABILITIES, RAO_INT, FRED, and AMX-TRANSPOSE.

Excluding the features in category 3 shouldn't break userspace, as
userspace is expected to consult KVM_TDX_CAPABILITIES for the configurable
bits before invoking KVM_TDX_INIT_VM.  Nor should it break guests, as the
features are either obsolete or unsupported by KVM, and in the latter case,
a guest relying on them would already have run into problems.
CORE_CAPABILITIES is a special case; it will be allowed separately to
accommodate its legacy fixed-1 definition.

Future changes will use tdx_cpu_cfg_caps[] to filter KVM_TDX_CAPABILITIES
and to reject unsupported CPUID input to KVM_TDX_INIT_VM, so that directly
configurable bits introduced by future TDX modules are neither advertised
to nor configurable by userspace until KVM explicitly opts in.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
v6:
- Rebased on patch series "x86/cpuid: KVM: TDX CPUID fixes"
  https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com
- Collected RBs. (Rick, Chao, Nikolay, Xiaoyao)

v5:
- Simplify the commit message for excluded bits. (Xiaoyao)
- Use TDX_CFG_INDEPENDENT_F() instead of TDX_CFG_EXTRA_F(). (Xiaoyao)
- Avoid using "patch" in the commit message. (Rick)
- Remove comments for host clobbering features KVM doesn't support yet.
  (Xiaoyao)
- AMX_COMPLEX should be added for CPUID_7_1_EDX instead of CPUID_1E_1_EAX,
  it was a wrong fix in v4 to add it for CPUID_1E_1_EAX.
- Exclude XTPR since TDX/KVM doesn't actually virtualize the feature and
  guests don't need it.
- Move the TDX CPUID allowlist code next to the other CPUID helpers.

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
 arch/x86/kvm/vmx/tdx.c | 153 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 3fc68b00ccd02..b71460805c573 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -58,6 +58,8 @@ bool enable_tdx __ro_after_init;
 module_param_named(tdx, enable_tdx, bool, 0444);
 
 static const struct tdx_sys_info *tdx_sysinfo;
+static u32 tdx_cpu_cfg_caps[NR_KVM_CPU_CAPS] __ro_after_init;
+static_assert(ARRAY_SIZE(tdx_cpu_cfg_caps) == ARRAY_SIZE(kvm_cpu_caps));
 
 void tdh_vp_rd_failed(struct vcpu_tdx *tdx, char *uclass, u32 field, u64 err)
 {
@@ -118,6 +120,155 @@ static u32 tdx_set_guest_phys_addr_bits(const u32 eax, int addr_bits)
 	return (eax & ~GENMASK(23, 16)) | (addr_bits & 0xff) << 16;
 }
 
+#define TDX_VALIDATE_CPU_CAP_USAGE(name)			\
+	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) !=	\
+		     tdx_cpu_cap_init_in_progress)
+
+/* For features that are dependent on kvm_cpu_caps[]. */
+#define TDX_CFG_F(name)					\
+({							\
+	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
+	tdx_cfg_caps |= feature_bit(name);		\
+})
+
+/*
+ * For features that are not dependent on kvm_cpu_caps[], e.g. MWAIT.
+ * Use this version only when there is a justification.
+ */
+#define TDX_CFG_INDEPENDENT_F(name)			\
+({							\
+	TDX_VALIDATE_CPU_CAP_USAGE(name);		\
+	tdx_cfg_caps_independent |= feature_bit(name);	\
+})
+
+#define tdx_cpu_cfg_cap_init(leaf, feature_initializers...)		\
+do {									\
+	const u32 __maybe_unused tdx_cpu_cap_init_in_progress = leaf;	\
+	u32 tdx_cfg_caps_independent = 0;				\
+	u32 tdx_cfg_caps = 0;						\
+									\
+	feature_initializers						\
+	tdx_cpu_cfg_caps[leaf] = (tdx_cfg_caps & kvm_cpu_caps[leaf]) |	\
+				 tdx_cfg_caps_independent;		\
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
+		TDX_CFG_INDEPENDENT_F(MWAIT),
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
+		TDX_CFG_INDEPENDENT_F(HT),
+	);
+
+	tdx_cpu_cfg_cap_init(CPUID_7_0_EBX,
+		TDX_CFG_F(BMI1),
+		TDX_CFG_F(BMI2),
+		TDX_CFG_F(ERMS),
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
+		TDX_CFG_F(AMX_COMPLEX),
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
+#undef TDX_CFG_INDEPENDENT_F
+
 #define TDX_FEATURE_TSX (__feature_bit(X86_FEATURE_HLE) | __feature_bit(X86_FEATURE_RTM))
 
 static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
@@ -3539,6 +3690,8 @@ int __init tdx_hardware_setup(void)
 		return r;
 	}
 
+	tdx_initialize_cpu_cfg_caps();
+
 	KVM_SANITY_CHECK_VM_STRUCT_SIZE(kvm_tdx);
 
 	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));
-- 
2.46.0

