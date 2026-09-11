Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332E486428;
	Fri, 11 Sep 2026 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162924; cv=none; b=So7YSo+g7lJTj4SEC6F9jS8nwYjJz093v4zvQPRlis720kyFv1sjzo16Vdy+5XMv8KmI5lNoreLSGFVXKmxvn1DuuatHJiEy/yXAx9BoYITVpqDG4FGwTvHU7NvgI6CMZ1tEQrezfh+UeyjCPDwVGQIBsNbABmT2PEX1Mc83fjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162924; c=relaxed/simple;
	bh=xUcMDZDichUi5tjRck2N6+/wFdKZRiuD+AU5NNUOLQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcwSq2hZV10ejPyBhgrCj7wus6hXF2EgZ8YrZS3OwcOZfz/Itn2o50H3iOFAI1dW58Z9rH53CaoG5fIwnyT+i5v2mhdMJVxwdz4rs/SGaXHK6jXIPmZ1kGS3ibAsaR+KZv3S1olglPSC+SGFjIA7iU3AwHCIn8sewKrRYKnVLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjOyPrkl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjOyPrkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162922; x=1820698922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUcMDZDichUi5tjRck2N6+/wFdKZRiuD+AU5NNUOLQo=;
  b=SjOyPrklOzSeu+2paPmha9nh4rqLe38XBgUjcyvRtcAj1GAORrISUNq8
   HZPwtyuk17X6CWkqZGYE8AVq29IOoW0YH0cpnJKLxyy+9CrKYXlh3yEKO
   X3pYA7kvAIzZAhUtcguAwzFr8ach0t/a+k7h5sEXB3AqAsMoLmGclnejg
   y18CKNT9cuVkh0XvUAZ/9dx89JRmmJPRF+nNg60jiSnBruBLF/6zFMDI3
   r7TNh6GOvO0XxVGuLx3HxwUpAIxkbDP3ixHq8EM7Its3MupdFHhlEuuZ5
   XdB7G41sGizc45BbDjBv/TC1E+Ptlayr8187zoLuOhGqVBfHQn4jq2JrX
   Q==;
X-CSE-ConnectionGUID: E2pOVRkDROWh0VmV4ZZrmQ==
X-CSE-MsgGUID: rbu1enZOSNSXmjBmVma0Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572702"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572702"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:42:01 -0700
X-CSE-ConnectionGUID: aBj4wUqaTwy2vLRLgK/Tqg==
X-CSE-MsgGUID: gI9yXVjhQ0GFX89L0zSaCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004153"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:42:01 -0700
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
Subject: [PATCH v10 14/28] KVM: VMX: Virtualize FRED event_data
Date: Fri, 11 Sep 2026 14:36:44 -0700
Message-ID: <20260911213659.2025974-15-sohil.mehta@intel.com>
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

Set injected-event data when injecting a #PF, #DB, or #NM due to
extended feature disable using FRED event delivery, and save
original-event data for being used as injected-event data.

Unlike IDT using some extra CPU register as part of an event
context, e.g., %cr2 for #PF, FRED saves a complete event context
in its stack frame, e.g., FRED saves the faulting linear address
of a #PF into the event data field defined in its stack frame.

Thus a new VMX control field called injected-event data is added
to provide the event data that will be pushed into a FRED stack
frame for VM entries that inject an event using FRED event delivery.
In addition, a new VM exit information field called original-event
data is added to store the event data that would have saved into a
FRED stack frame for VM exits that occur during FRED event delivery.
After such a VM exit is handled to allow the original-event to be
delivered, the data in the original-event data VMCS field needs to
be set into the injected-event data VMCS field for the injection of
the original event.

In addition, save/restore the event data of an exception during VM
save/restore and live migration to ensure it's properly saved and
restored across VM save/restore and live migration. Clear the
injected-event data field when injecting an IRQ or an NMI as no event
data is currently defined for them.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
[ Sean: reworked event data injection for nested ]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Reset event data in kvm_clear_exception_queue() (Chao).
 - Clear event data to 0 to prevent stale data leakage when injecting
   a hardware exception that doesn't require FRED event data.
 - Save/restore event data for properly restoring it for #PF (CR2), #DB
   (DR6) and #NM due to extended feature disable (IA32_XFD_ERR) (Chao).
 - Clear the INJECTED_EVENT_DATA VMCS field during NMI and IRQ
   injection. (Zhao)
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/include/asm/vmx.h      |  4 +++
 arch/x86/include/uapi/asm/kvm.h |  5 ++-
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 58 ++++++++++++++++++++++++++++++---
 arch/x86/kvm/x86.c              | 23 ++++++++++++-
 arch/x86/kvm/x86.h              |  3 +-
 7 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 994c354dc47b..21d12d86a18b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -696,6 +696,7 @@ struct kvm_queued_exception {
 	unsigned long payload;
 	bool has_payload;
 	bool is_nested;
+	u64 event_data;
 };
 
 /*
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 7eb08f84a7e5..6633988a84da 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -283,8 +283,12 @@ enum vmcs_field {
 	PID_POINTER_TABLE_HIGH		= 0x00002043,
 	SECONDARY_VM_EXIT_CONTROLS	= 0x00002044,
 	SECONDARY_VM_EXIT_CONTROLS_HIGH	= 0x00002045,
+	INJECTED_EVENT_DATA		= 0x00002052,
+	INJECTED_EVENT_DATA_HIGH	= 0x00002053,
 	GUEST_PHYSICAL_ADDRESS          = 0x00002400,
 	GUEST_PHYSICAL_ADDRESS_HIGH     = 0x00002401,
+	ORIGINAL_EVENT_DATA		= 0x00002404,
+	ORIGINAL_EVENT_DATA_HIGH	= 0x00002405,
 	VMCS_LINK_POINTER               = 0x00002800,
 	VMCS_LINK_POINTER_HIGH          = 0x00002801,
 	GUEST_IA32_DEBUGCTL             = 0x00002802,
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 659c8391d40e..c8a6149fcf63 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -369,7 +369,10 @@ struct kvm_vcpu_events {
 	struct {
 		__u8 pending;
 	} triple_fault;
-	__u8 reserved[25];
+	__u8 reserved0[11];
+	/* Aligned to a 64-bit boundary */
+	__u64 exception_event_data;
+	__u8 reserved1[6];
 	__u8 exception_is_nested;
 	__u8 exception_has_payload;
 	__u64 exception_payload;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7762db655b28..f254a5ff570d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4392,7 +4392,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
 		kvm_requeue_exception(vcpu, vector,
 				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
-				      error_code, false);
+				      error_code, false, 0);
 		break;
 	}
 	case SVM_EXITINTINFO_TYPE_INTR:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 25c3301e137b..cd041381b322 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2004,15 +2004,39 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
 
 	WARN_ON_ONCE(vmx->vt.emulation_required);
 
+	/*
+	 * Event data is strictly required only for #PF, #DB, and #NM (due to
+	 * extended feature disable) hardware exceptions under FRED, making it
+	 * straightforward to correctly populate for just these vectors.
+	 *
+	 * Conversely, trying to guarantee that event data is cleanly managed or
+	 * zeroed out across all other exception paths is highly complicated
+	 * and error-prone. A blanket fallback to 0 handles those cases safely.
+	 *
+	 * Therefore, set INJECTED_EVENT_DATA only if all the following are true:
+	 * - Guest has FRED enabled.
+	 * - Exception type is a hardware exception.
+	 * - Exception vector is #PF, #DB, or #NM.
+	 *
+	 * Otherwise, clear it to 0 to prevent stale data leakage.
+	 */
 	if (kvm_exception_is_soft(ex->vector)) {
 		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
 			     vmx->vcpu.arch.event_exit_inst_len);
 		intr_info |= INTR_TYPE_SOFT_EXCEPTION;
+		if (is_fred_enabled(vcpu))
+			vmcs_write64(INJECTED_EVENT_DATA, 0);
 	} else {
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
 		if (is_fred_enabled(vcpu)) {
 			if (ex->is_nested)
 				intr_info |= INTR_INFO_NESTED_EXCEPTION_MASK;
+			if (ex->vector == PF_VECTOR ||
+			    ex->vector == DB_VECTOR ||
+			    ex->vector == NM_VECTOR)
+				vmcs_write64(INJECTED_EVENT_DATA, ex->event_data);
+			else
+				vmcs_write64(INJECTED_EVENT_DATA, 0);
 		}
 	}
 
@@ -5328,6 +5352,14 @@ void vmx_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 			     vmx->vcpu.arch.event_exit_inst_len);
 	} else
 		intr |= INTR_TYPE_EXT_INTR;
+
+	/*
+	 * Interrupts define no event data, so clear any value left behind
+	 * by a previously injected exception.
+	 */
+	if (is_fred_enabled(vcpu))
+		vmcs_write64(INJECTED_EVENT_DATA, 0);
+
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr);
 
 	vmx_clear_hlt(vcpu);
@@ -5358,6 +5390,13 @@ void vmx_inject_nmi(struct kvm_vcpu *vcpu)
 		return;
 	}
 
+	/*
+	 * KVM doesn't virtualize the NMI-source reporting feature. So clear
+	 * any value left behind by a previously injected exception.
+	 */
+	if (is_fred_enabled(vcpu))
+		vmcs_write64(INJECTED_EVENT_DATA, 0);
+
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
 			INTR_TYPE_NMI_INTR | INTR_INFO_VALID_MASK | NMI_VECTOR);
 
@@ -7465,7 +7504,8 @@ static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 				      u32 idt_vectoring_info,
 				      int instr_len_field,
-				      int error_code_field)
+				      int error_code_field,
+				      int event_data_field)
 {
 	u8 vector;
 	int type;
@@ -7500,14 +7540,18 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 		fallthrough;
 	case INTR_TYPE_HARD_EXCEPTION: {
 		u32 error_code = 0;
+		u64 event_data = 0;
 
 		if (idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK)
 			error_code = vmcs_read32(error_code_field);
+		if (is_fred_enabled(vcpu))
+			event_data = vmcs_read64(event_data_field);
 
 		kvm_requeue_exception(vcpu, vector,
 				      idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK,
 				      error_code,
-				      idt_vectoring_info & VECTORING_INFO_NESTED_EXCEPTION_MASK);
+				      idt_vectoring_info & VECTORING_INFO_NESTED_EXCEPTION_MASK,
+				      event_data);
 		break;
 	}
 	case INTR_TYPE_SOFT_INTR:
@@ -7525,7 +7569,8 @@ static void vmx_complete_interrupts(struct vcpu_vmx *vmx)
 {
 	__vmx_complete_interrupts(&vmx->vcpu, vmx->idt_vectoring_info,
 				  VM_EXIT_INSTRUCTION_LEN,
-				  IDT_VECTORING_ERROR_CODE);
+				  IDT_VECTORING_ERROR_CODE,
+				  ORIGINAL_EVENT_DATA);
 }
 
 void vmx_cancel_injection(struct kvm_vcpu *vcpu)
@@ -7533,7 +7578,8 @@ void vmx_cancel_injection(struct kvm_vcpu *vcpu)
 	__vmx_complete_interrupts(vcpu,
 				  vmcs_read32(VM_ENTRY_INTR_INFO_FIELD),
 				  VM_ENTRY_INSTRUCTION_LEN,
-				  VM_ENTRY_EXCEPTION_ERROR_CODE);
+				  VM_ENTRY_EXCEPTION_ERROR_CODE,
+				  INJECTED_EVENT_DATA);
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);
 }
@@ -7645,6 +7691,10 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	vmx_disable_fb_clear(vmx);
 
+	/*
+	 * Note, even though FRED delivers the faulting linear address via the
+	 * event data field on the stack, CR2 is still updated.
+	 */
 	if (vcpu->arch.cr2 != native_read_cr2())
 		native_write_cr2(vcpu->arch.cr2);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 94d684210cf6..e10ac6b280f6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -431,9 +431,22 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
+
+		/*
+		 * FRED #DB event data matches DR6, but follows the polarity of
+		 * VMX's pending debug exceptions, not DR6.
+		 */
+		ex->event_data = ex->payload & ~BIT(12);
+		break;
+	case NM_VECTOR:
+		ex->event_data = ex->payload;
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = ex->payload;
+		ex->event_data = ex->payload;
+		break;
+	default:
+		ex->event_data = 0;
 		break;
 	}
 
@@ -493,6 +506,10 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 						 (is_nested ||
 						  vcpu->arch.nmi_injected ||
 						  vcpu->arch.interrupt.injected);
+		/*
+		 * Do not update the event data, as the current value may have
+		 * just been restored during a VM save/restore or live migration.
+		 */
 		return;
 	}
 
@@ -548,7 +565,7 @@ static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
 
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 			   bool has_error_code, u32 error_code,
-			   bool is_nested)
+			   bool is_nested, u64 event_data)
 {
 
 	/*
@@ -574,6 +591,7 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 	vcpu->arch.exception.has_payload = false;
 	vcpu->arch.exception.payload = 0;
 	vcpu->arch.exception.is_nested = is_nested;
+	vcpu->arch.exception.event_data = event_data;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_requeue_exception);
 
@@ -3012,6 +3030,7 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 	events->exception_has_payload = ex->has_payload;
 	events->exception_payload = ex->payload;
 	events->exception_is_nested = ex->is_nested;
+	events->exception_event_data = ex->event_data;
 
 	events->interrupt.injected =
 		vcpu->arch.interrupt.injected && !vcpu->arch.interrupt.soft;
@@ -3074,6 +3093,7 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 	} else {
 		events->exception_is_nested = 0;
+		events->exception_event_data = 0;
 	}
 
 	if ((events->exception.injected || events->exception.pending) &&
@@ -3102,6 +3122,7 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 	vcpu->arch.exception.has_payload = events->exception_has_payload;
 	vcpu->arch.exception.payload = events->exception_payload;
 	vcpu->arch.exception.is_nested = events->exception_is_nested;
+	vcpu->arch.exception.event_data = events->exception_event_data;
 
 	vcpu->arch.interrupt.injected = events->interrupt.injected;
 	vcpu->arch.interrupt.nr = events->interrupt.nr;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 2d6bae66cfae..43c5c08f5d5c 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -159,6 +159,7 @@ static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
 	vcpu->arch.exception.pending = false;
 	vcpu->arch.exception.injected = false;
 	vcpu->arch.exception.is_nested = false;
+	vcpu->arch.exception.event_data = 0;
 	vcpu->arch.exception_vmexit.pending = false;
 }
 
@@ -504,7 +505,7 @@ void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 			   bool has_error_code, u32 error_code,
-			   bool is_nested);
+			   bool is_nested, u64 event_data);
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
 			   bool from_hardware);
 void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-- 
2.43.0

