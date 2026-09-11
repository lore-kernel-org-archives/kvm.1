Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C575497B89;
	Fri, 11 Sep 2026 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163017; cv=none; b=TuQ9dmEjjWEDSlRgQ+dn7/miI6iEHALrS5lklNe7KkACydo13y0HThXkR1HVMJy+LGhaD2+ivOGhG62O69CSTzw+iZoc1nUg4YpxYCHjwqCXM1QY3JnH1R3jYzzNIVuS3JdN1r0ESNX7ws0fvBFzVn2uKLWyiAOCkaw0IccIZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163017; c=relaxed/simple;
	bh=wwygfbCSXr4RW1gAi7ShHCivUHSxX9lkjMwzOGhDuR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0gx+WuPc7/qGRv/vBvEGkCq6IgV/rcI3VOt3R4azMI0WbEG7x8+2uDk65jB9rjqB+TcJtURvnVr54PSp/7aWBW9APzUwdNBmeOAHlfNylWYKGt5CCRWu3wpSi5l05fsOHU16YF5gFxV5ssNyfl/EpIkitdUpQG80WAHMSNnSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blHvtuxj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blHvtuxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789163014; x=1820699014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wwygfbCSXr4RW1gAi7ShHCivUHSxX9lkjMwzOGhDuR0=;
  b=blHvtuxjkscOdVDjiQ+jzpkfhJWll2WeTT4FFhurG+XNeXZWvLCMw0IJ
   tOnwC4ZPhK2kKvXzJeNZEiqt83FAERYQ4N5A4upEHnomxoRQNXU50o821
   yXh5/NAiKvFwn3pwXZNJske3sm8hrsoOpRQ6ERne5EPUXdeTaubVyIqkd
   /Zz20TMi6Xc3Y+gQQs5TPp47baHQstMDkn6HQHbMnIfUHE3PtqeiT8aU8
   f2tfY5nifWuaHpek+lIwitRXHoFRZQBdOmVqFOOUXtlWZlLZl9CjjmH5l
   IfoObM+i3zlnNkR9E+qAnCAGRB9g4E6R+bR1yWRBQLOGdIjl/MEzFy7Dz
   A==;
X-CSE-ConnectionGUID: LB7O/fhNQe68vJA42UgVBw==
X-CSE-MsgGUID: tK5d7VmXRb2TjEp2O9Auhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572910"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572910"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:43:34 -0700
X-CSE-ConnectionGUID: X+b7zeVSSrOSAD8PBLv5xg==
X-CSE-MsgGUID: JTqZ9NtVTPGL2WAB1TQpYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004312"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:43:33 -0700
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
Subject: [PATCH v10 24/28] KVM: nVMX: Validate FRED-related VMCS fields
Date: Fri, 11 Sep 2026 14:36:54 -0700
Message-ID: <20260911213659.2025974-25-sohil.mehta@intel.com>
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

Extend nested VMX field validation to include FRED-specific VMCS fields,
mirroring hardware behavior.

This enables support for nested FRED by ensuring control and guest/host
state fields are properly checked.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Use has_nested_exception to describe the event being injected rather
   than the CPU capability, for consistency with has_error_code (Chao).
 - Restructure the interruption-information checks into a switch on the
   interruption type (Chao).
 - Add a CC() statement to the reserved interruption type check so a
   VM-entry failure can be correlated with a specific check (Chao).
 - Reject the nested-exception bit (bit 13) for interruption types other
   than hardware exception, and fold in the nested-exception capability
   check.
 - Bound the "other event" vector explicitly instead of relying on a
   default arm.
 - Reject a zero VM-entry instruction length when injecting SYSCALL or
   SYSENTER if the vCPU doesn't enumerate zero-length instruction
   injection.
---
 arch/x86/kvm/vmx/nested.c | 119 +++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/vmx/nested.h |   5 ++
 2 files changed, 111 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 83e846fb3fc8..3e0a1ed6440d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3111,6 +3111,8 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 					  struct vmcs12 *vmcs12)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	bool fred_enabled = (vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE) &&
+			    (vmcs12->guest_cr4 & X86_CR4_FRED);
 
 	if (CC(!vmx_control_verify(vmcs12->vm_entry_controls,
 				    vmx->nested.msrs.entry_ctls_low,
@@ -3128,22 +3130,11 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		u8 vector = intr_info & INTR_INFO_VECTOR_MASK;
 		u32 intr_type = intr_info & INTR_INFO_INTR_TYPE_MASK;
 		bool has_error_code = intr_info & INTR_INFO_DELIVER_CODE_MASK;
+		bool has_nested_exception = intr_info & INTR_INFO_NESTED_EXCEPTION_MASK;
 		bool urg = nested_cpu_has2(vmcs12,
 					   SECONDARY_EXEC_UNRESTRICTED_GUEST);
 		bool prot_mode = !urg || vmcs12->guest_cr0 & X86_CR0_PE;
 
-		/* VM-entry interruption-info field: interruption type */
-		if (CC(intr_type == INTR_TYPE_RESERVED) ||
-		    CC(intr_type == INTR_TYPE_OTHER_EVENT &&
-		       !nested_cpu_supports_monitor_trap_flag(vcpu)))
-			return -EINVAL;
-
-		/* VM-entry interruption-info field: vector */
-		if (CC(intr_type == INTR_TYPE_NMI_INTR && vector != NMI_VECTOR) ||
-		    CC(intr_type == INTR_TYPE_HARD_EXCEPTION && vector > 31) ||
-		    CC(intr_type == INTR_TYPE_OTHER_EVENT && vector != 0))
-			return -EINVAL;
-
 		/*
 		 * Cannot deliver error code in real mode or if the interrupt
 		 * type is not hardware exception. For other cases, do the
@@ -3167,8 +3158,28 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 		if (CC(intr_info & INTR_INFO_RESVD_BITS_MASK))
 			return -EINVAL;
 
-		/* VM-entry instruction length */
+		if (CC(intr_type == INTR_TYPE_RESERVED))
+			return -EINVAL;
+
+		/*
+		 * Only for hardware exceptions and when the CPU enumerates
+		 * VMX nested-exception support, bit 13 (indicating a nested
+		 * exception) has value 1. Otherwise it is reserved.
+		 */
+		if (CC(has_nested_exception &&
+		       (intr_type != INTR_TYPE_HARD_EXCEPTION ||
+			!nested_cpu_has_nested_exception(vcpu))))
+			return -EINVAL;
+
 		switch (intr_type) {
+		case INTR_TYPE_NMI_INTR:
+			if (CC(vector != NMI_VECTOR))
+				return -EINVAL;
+			break;
+		case INTR_TYPE_HARD_EXCEPTION:
+			if (CC(vector > 31))
+				return -EINVAL;
+			break;
 		case INTR_TYPE_SOFT_EXCEPTION:
 		case INTR_TYPE_SOFT_INTR:
 		case INTR_TYPE_PRIV_SW_EXCEPTION:
@@ -3176,6 +3187,28 @@ static int nested_check_vm_entry_controls(struct kvm_vcpu *vcpu,
 			    CC(vmcs12->vm_entry_instruction_len == 0 &&
 			    CC(!nested_cpu_has_zero_length_injection(vcpu))))
 				return -EINVAL;
+			break;
+		case INTR_TYPE_OTHER_EVENT:
+			if (CC(vector > 2))
+				return -EINVAL;
+
+			switch (vector) {
+			case 0:
+				if (CC(!nested_cpu_supports_monitor_trap_flag(vcpu)))
+					return -EINVAL;
+				break;
+			case 1:
+			case 2:
+				if (CC(!fred_enabled))
+					return -EINVAL;
+				if (CC(vmcs12->vm_entry_instruction_len > X86_MAX_INSTRUCTION_LENGTH))
+					return -EINVAL;
+				if (CC(vmcs12->vm_entry_instruction_len == 0 &&
+				       !nested_cpu_has_zero_length_injection(vcpu)))
+					return -EINVAL;
+				break;
+			}
+			break;
 		}
 	}
 
@@ -3262,9 +3295,27 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	if (ia32e) {
 		if (CC(!(vmcs12->host_cr4 & X86_CR4_PAE)))
 			return -EINVAL;
+		if (nested_cpu_load_host_fred_state(vmcs12)) {
+			if (CC(vmcs12->host_ia32_fred_config & FRED_CONFIG_RESERVED) ||
+			    CC(vmcs12->host_ia32_fred_rsp1 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->host_ia32_fred_rsp2 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->host_ia32_fred_rsp3 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->host_ia32_fred_ssp1 & GENMASK_ULL(2, 0)) ||
+			    CC(vmcs12->host_ia32_fred_ssp2 & GENMASK_ULL(2, 0)) ||
+			    CC(vmcs12->host_ia32_fred_ssp3 & GENMASK_ULL(2, 0)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_config & PAGE_MASK, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_rsp1, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_rsp2, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_rsp3, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_ssp1, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_ssp2, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_ssp3, vcpu)))
+				return -EINVAL;
+		}
 	} else {
 		if (CC(vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE) ||
 		    CC(vmcs12->host_cr4 & X86_CR4_PCIDE) ||
+		    CC(vmcs12->host_cr4 & X86_CR4_FRED) ||
 		    CC((vmcs12->host_rip) >> 32))
 			return -EINVAL;
 	}
@@ -3447,6 +3498,48 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	     CC((vmcs12->guest_bndcfgs & MSR_IA32_BNDCFGS_RSVD))))
 		return -EINVAL;
 
+	if (ia32e) {
+		if (nested_cpu_load_guest_fred_state(vmcs12)) {
+			if (CC(vmcs12->guest_ia32_fred_config & FRED_CONFIG_RESERVED) ||
+			    CC(vmcs12->guest_ia32_fred_rsp1 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_rsp2 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_rsp3 & GENMASK_ULL(5, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_ssp1 & GENMASK_ULL(2, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_ssp2 & GENMASK_ULL(2, 0)) ||
+			    CC(vmcs12->guest_ia32_fred_ssp3 & GENMASK_ULL(2, 0)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_config & PAGE_MASK, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_rsp1, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_rsp2, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_rsp3, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_ssp1, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_ssp2, vcpu)) ||
+			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_ssp3, vcpu)))
+				return -EINVAL;
+		}
+		if (vmcs12->guest_cr4 & X86_CR4_FRED) {
+			unsigned int ss_dpl = VMX_AR_DPL(vmcs12->guest_ss_ar_bytes);
+
+			if (CC(ss_dpl == 1 || ss_dpl == 2))
+				return -EINVAL;
+
+			switch (ss_dpl) {
+			case 0:
+				if (CC(!(vmcs12->guest_cs_ar_bytes & VMX_AR_L_MASK)))
+					return -EINVAL;
+				break;
+			case 3:
+				if (CC(vmcs12->guest_rflags & X86_EFLAGS_IOPL))
+					return -EINVAL;
+				if (CC(vmcs12->guest_interruptibility_info & GUEST_INTR_STATE_STI))
+					return -EINVAL;
+				break;
+			}
+		}
+	} else {
+		if (CC(vmcs12->guest_cr4 & X86_CR4_FRED))
+			return -EINVAL;
+	}
+
 	if (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE) {
 		if (nested_vmx_check_cet_state_common(vcpu, vmcs12->guest_s_cet,
 						      vmcs12->guest_ssp,
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index dc5a1e9cb4e9..551121824128 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -334,6 +334,11 @@ static inline bool nested_cpu_has_no_hw_errcode_cc(struct kvm_vcpu *vcpu)
 	return to_vmx(vcpu)->nested.msrs.basic & VMX_BASIC_NO_HW_ERROR_CODE_CC;
 }
 
+static inline bool nested_cpu_has_nested_exception(struct kvm_vcpu *vcpu)
+{
+	return to_vmx(vcpu)->nested.msrs.basic & VMX_BASIC_NESTED_EXCEPTION;
+}
+
 /* No difference in the restrictions on guest and host CR4 in VMX operation. */
 #define nested_guest_cr4_valid	nested_cr4_valid
 #define nested_host_cr4_valid	nested_cr4_valid
-- 
2.43.0

