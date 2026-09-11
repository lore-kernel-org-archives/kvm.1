Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3E4CC632;
	Fri, 11 Sep 2026 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162980; cv=none; b=j1rdCViECImjelFqGGIUkhsWLtR/NTlkp0TGs/XLQC+a8XqHMZKdHC6bQ2nJIP7uzNdgIVdVkwXLNnv+3soq+FyfGyn9NWjNfCkGQmtMHnJ1FkkdeTfaNDTsjq769L1wVovRoA39OSq3W+DwFM89GnpI+/2kj78wYGPj5Iz0Zi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162980; c=relaxed/simple;
	bh=STdr0QsW6MK5iHNJx3NyfDEnkdQFYbtOgLt5RoCUHiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maksI+rHeUF97gT4iyqZnqrtI4ERK1lPidhRxdCjerPZxtLzKmKj9Mi3y2uMWAYIQqmAmNOdhOLkrUwP2SoXkbeaV5VCuZesUShe6nPwCU1k0T02CyEyZAM4WPsAVUg9XKsxPXJzw5cJjPOwqVMHXAtMgFCxP87z+aQw7EifWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOy5h2nn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOy5h2nn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162978; x=1820698978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=STdr0QsW6MK5iHNJx3NyfDEnkdQFYbtOgLt5RoCUHiQ=;
  b=KOy5h2nnzaxGEc+S2G5SI+/lgprcXMvhZtJZMXhgKBJaSz6MC10N8gBA
   UCt8tfxhiA7juq8yvWTj3swYhSqY+CaSOcJlpUmtPAhzUsod/Gtni9hLF
   oFpYpeQpuvDxKj/iLOUvSFE4ICYHziXRgc5HbRnfChKrZv593AoScaZGR
   Ho+TmttUle1dj8DZ7QYxlWuB3kUL8lrxTcSj5H1wsyORkHXyRKaIXkDUK
   k+NR7PM3+MxCna4bWBJwDYOHXWU/TTHIp4dQVKudkofBIH3Ls3RnDHTtR
   3g3xPXJucxFuYHF5Dikem0cwcXLP31mnWsUPUOtUHUKN/TH8HjfCMdF74
   w==;
X-CSE-ConnectionGUID: p8N9+brJTHGAY7i3o42nZw==
X-CSE-MsgGUID: XLCGEhbYTRyNyc7b17QvxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572827"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572827"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:42:57 -0700
X-CSE-ConnectionGUID: 8n2f3RnnRraSKwGQIzpeGA==
X-CSE-MsgGUID: zcWRFngiQXuJ5mfMOPj64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004230"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:42:56 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 20/28] KVM: nVMX: Enable support for secondary VM exit controls
Date: Fri, 11 Sep 2026 14:36:50 -0700
Message-ID: <20260911213659.2025974-21-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Add support for secondary VM exit controls in nested VMX to facilitate
future FRED integration.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Add MSR_IA32_VMX_EXIT_CTLS2 to emulated_msrs_all[] for live
   migration. (Chao Gao)
 - Reject vmcs12's secondary VM exit controls that KVM doesn't advertise
   to L1 in MSR_IA32_VMX_EXIT_CTLS2.
---
 arch/x86/kvm/msrs.c             |  1 +
 arch/x86/kvm/msrs.h             |  2 +-
 arch/x86/kvm/vmx/capabilities.h |  1 +
 arch/x86/kvm/vmx/nested.c       | 29 ++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/nested.h       |  5 +++++
 arch/x86/kvm/vmx/vmcs12.c       |  1 +
 arch/x86/kvm/vmx/vmcs12.h       |  3 ++-
 7 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 9eabb7b02cb5..3260bddb5f52 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -317,6 +317,7 @@ static const u32 emulated_msrs_all[] = {
 	MSR_IA32_VMX_PROCBASED_CTLS2,
 	MSR_IA32_VMX_EPT_VPID_CAP,
 	MSR_IA32_VMX_VMFUNC,
+	MSR_IA32_VMX_EXIT_CTLS2,
 
 	MSR_K7_HWCR,
 	MSR_KVM_POLL_CONTROL,
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index 7cc182a15b3b..845d2cbe80e5 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -31,7 +31,7 @@ static inline void kvm_pr_unimpl_rdmsr(struct kvm_vcpu *vcpu, u32 msr)
  * associated feature that KVM supports for nested virtualization.
  */
 #define KVM_FIRST_EMULATED_VMX_MSR	MSR_IA32_VMX_BASIC
-#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_VMFUNC
+#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_EXIT_CTLS2
 
 /*
  * KVM's internal, non-ABI indices for synthetic MSRs. The values themselves
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 95d22a54f856..9cca65b226fd 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -36,6 +36,7 @@ struct nested_vmx_msrs {
 	u32 pinbased_ctls_high;
 	u32 exit_ctls_low;
 	u32 exit_ctls_high;
+	u64 secondary_exit_ctls;
 	u32 entry_ctls_low;
 	u32 entry_ctls_high;
 	u32 misc_low;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..6576935b9d43 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1596,6 +1596,11 @@ int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 			return -EINVAL;
 		vmx->nested.msrs.vmfunc_controls = data;
 		return 0;
+	case MSR_IA32_VMX_EXIT_CTLS2:
+		if (data & ~vmcs_config.nested.secondary_exit_ctls)
+			return -EINVAL;
+		vmx->nested.msrs.secondary_exit_ctls = data;
+		return 0;
 	default:
 		/*
 		 * The rest of the VMX capability MSRs do not support restore.
@@ -1635,6 +1640,9 @@ int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u32 msr_index, u64 *pdata)
 		if (msr_index == MSR_IA32_VMX_EXIT_CTLS)
 			*pdata |= VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR;
 		break;
+	case MSR_IA32_VMX_EXIT_CTLS2:
+		*pdata = msrs->secondary_exit_ctls;
+		break;
 	case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
 	case MSR_IA32_VMX_ENTRY_CTLS:
 		*pdata = vmx_control_msr(
@@ -2576,6 +2584,9 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 		exec_control &= ~VM_EXIT_LOAD_IA32_EFER;
 	vm_exit_controls_set(vmx, exec_control);
 
+	if (exec_control & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS)
+		secondary_vm_exit_controls_set(vmx, __secondary_vm_exit_controls_get(vmcs01));
+
 	/*
 	 * Interrupt/Exception Fields
 	 */
@@ -3040,6 +3051,11 @@ static int nested_check_vm_exit_controls(struct kvm_vcpu *vcpu,
 	    CC(nested_vmx_check_exit_msr_switch_controls(vcpu, vmcs12)))
 		return -EINVAL;
 
+	if (nested_cpu_has_secondary_vm_exit_controls(vmcs12) &&
+	    CC(vmcs12->secondary_vm_exit_controls &
+	       ~vmx->nested.msrs.secondary_exit_ctls))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -7152,7 +7168,8 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
 		VM_EXIT_HOST_ADDR_SPACE_SIZE |
 #endif
 		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
-		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_LOAD_CET_STATE;
+		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_LOAD_CET_STATE |
+		VM_EXIT_ACTIVATE_SECONDARY_CONTROLS;
 	msrs->exit_ctls_high |=
 		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
 		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
@@ -7165,6 +7182,16 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
 
 	/* We support free control of debug control saving. */
 	msrs->exit_ctls_low &= ~VM_EXIT_SAVE_DEBUG_CONTROLS;
+
+	if (msrs->exit_ctls_high & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
+		msrs->secondary_exit_ctls = vmcs_conf->vmexit_2nd_ctrl;
+		/*
+		 * As the secondary VM exit control is always loaded, do not
+		 * advertise any feature in it to nVMX until its nVMX support
+		 * is ready.
+		 */
+		msrs->secondary_exit_ctls &= 0;
+	}
 }
 
 static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index c6de848bd9ce..371fc3498b12 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -247,6 +247,11 @@ static inline bool nested_cpu_has_save_preemption_timer(struct vmcs12 *vmcs12)
 	    VM_EXIT_SAVE_VMX_PREEMPTION_TIMER;
 }
 
+static inline bool nested_cpu_has_secondary_vm_exit_controls(struct vmcs12 *vmcs12)
+{
+	return vmcs12->vm_exit_controls & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS;
+}
+
 static inline bool nested_exit_on_nmi(struct kvm_vcpu *vcpu)
 {
 	return nested_cpu_has_nmi_exiting(get_vmcs12(vcpu));
diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
index 1ebe67c384ad..9d64a89aff00 100644
--- a/arch/x86/kvm/vmx/vmcs12.c
+++ b/arch/x86/kvm/vmx/vmcs12.c
@@ -66,6 +66,7 @@ static const u16 kvm_supported_vmcs12_field_offsets[] __initconst = {
 	FIELD64(HOST_IA32_PAT, host_ia32_pat),
 	FIELD64(HOST_IA32_EFER, host_ia32_efer),
 	FIELD64(HOST_IA32_PERF_GLOBAL_CTRL, host_ia32_perf_global_ctrl),
+	FIELD64(SECONDARY_VM_EXIT_CONTROLS, secondary_vm_exit_controls),
 	FIELD(PIN_BASED_VM_EXEC_CONTROL, pin_based_vm_exec_control),
 	FIELD(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control),
 	FIELD(EXCEPTION_BITMAP, exception_bitmap),
diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
index 21cd1b75e4fd..bb2f406be63d 100644
--- a/arch/x86/kvm/vmx/vmcs12.h
+++ b/arch/x86/kvm/vmx/vmcs12.h
@@ -71,7 +71,7 @@ struct __packed vmcs12 {
 	u64 pml_address;
 	u64 encls_exiting_bitmap;
 	u64 tsc_multiplier;
-	u64 padding64[1]; /* room for future expansion */
+	u64 secondary_vm_exit_controls;
 	/*
 	 * To allow migration of L1 (complete with its L2 guests) between
 	 * machines of different natural widths (32 or 64 bit), we cannot have
@@ -261,6 +261,7 @@ static inline void vmx_check_vmcs12_offsets(void)
 	CHECK_OFFSET(pml_address, 312);
 	CHECK_OFFSET(encls_exiting_bitmap, 320);
 	CHECK_OFFSET(tsc_multiplier, 328);
+	CHECK_OFFSET(secondary_vm_exit_controls, 336);
 	CHECK_OFFSET(cr0_guest_host_mask, 344);
 	CHECK_OFFSET(cr4_guest_host_mask, 352);
 	CHECK_OFFSET(cr0_read_shadow, 360);
-- 
2.43.0

