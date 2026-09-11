Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52448663E;
	Fri, 11 Sep 2026 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162912; cv=none; b=f7hUDaviZ6iL0xJFE2UgZy9s8DZ2K3WxK4IiaqyypbjvctG2bdewC1u9RmmQ2tfqQHRj36UbxSMBqkvGHNAoxKB81L0X3NYTi9kNIpKBEkgCWpdFx0Gca/AIoadqzuLv1Ea2GYMxbXCGJxUU5C8kKceUnHg8poGq0m6yNqNJOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162912; c=relaxed/simple;
	bh=4xf8GdYdyRjE4wumPq1FX/osIPlad31Ti2Ie9a9xTWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX5mhbx0zDK16on8g7OQwRtx6N+ebUU+4kgHkME3g08IzNYzZDzWGMF+u26CEuPHTQhiixl4PpV4LWFsIZJZxV1KHVKXy4mlKplOCwwHYLYF9sg93NLGs8d6nWFriHZ3YM118Z6SW5QPTJ1O1f9AtxT3u+BBSio78dL4LApPPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5nJU1WT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5nJU1WT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162911; x=1820698911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4xf8GdYdyRjE4wumPq1FX/osIPlad31Ti2Ie9a9xTWI=;
  b=B5nJU1WTeG86t54ORZYy8ouH/WBvFe/0olt1FLyoaPO0b/3tZG0fin9g
   h19Yy7ocAnw/2Ja6N6jBg+bNyMdPZTeJoCXwhhYqjsee6HY0bWv7iskTN
   uGMTe5ZWxqzBs7rV7e/S7gfJyTohmW1DQckywFgrNSXXQIF++KZeThn65
   v7GRrkjTrZRlInOfsKBeT8tPjqd9x5yfuUV5zO94NbEbRT2q3JVznvC0Z
   Eg56XmKdIuDL+3MVd2wYxWM6JcTdxXdjqXWclJOdBUulMIVAMYpBSpUVE
   JU7QkAjnZmJjGf6jv9mJ+q3IabnAJUYSlW2YcY6G9hjwpnqPb3ONVq04p
   g==;
X-CSE-ConnectionGUID: yvToJSKoTlmG1/q7nIVRgA==
X-CSE-MsgGUID: kgiB825CQYuKbVyeARYanQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572689"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572689"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:41:50 -0700
X-CSE-ConnectionGUID: dZnMJZAPRtmUJ/nrw+yVFQ==
X-CSE-MsgGUID: g9gVpPMQTAK5lsBH0PpPRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004130"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:41:49 -0700
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
Subject: [PATCH v10 13/28] KVM: VMX: Virtualize FRED nested exception tracking
Date: Fri, 11 Sep 2026 14:36:43 -0700
Message-ID: <20260911213659.2025974-14-sohil.mehta@intel.com>
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

Set the VMX nested exception bit in VM-entry interruption information
field when injecting a nested exception using FRED event delivery to
ensure:
  1) A nested exception is injected on a correct stack level.
  2) The nested bit defined in FRED stack frame is set.

The event stack level used by FRED event delivery depends on whether
the event was a nested exception encountered during delivery of an
earlier event, because a nested exception is "regarded" as happening
on ring 0.  E.g., when #PF is configured to use stack level 1 in
IA32_FRED_STKLVLS MSR:
  - nested #PF will be delivered on the stack pointed by IA32_FRED_RSP1
    MSR when encountered in ring 3 and ring 0.
  - normal #PF will be delivered on the stack pointed by IA32_FRED_RSP0
    MSR when encountered in ring 3.

The VMX nested-exception support ensures a correct event stack level is
chosen when a VM entry injects a nested exception.

In addition, save/restore the nested flag of an exception during VM
save/restore and live migration to ensure a correct event stack level
is chosen when a nested exception is injected through FRED event
delivery across VM save/restore and live migration.

Note, like the other fields of struct kvm_queued_exception, the nested
flag is meaningful only while the exception is pending or injected. It
is not consulted otherwise, and so doesn't need to be cleared when an
exception is dropped.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
[ Sean: reworked kvm_requeue_exception() to simply the code changes ]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
v10:
 - Rename exception status member variable nested to is_nested (Sean).
 - Rename KVM_CAP_EXCEPTION_NESTED_FLAG to KVM_CAP_X86_FRED_EVENT, to
   include both FRED event nested flag and data.
 - Track the nested flag of an exception being queued in a local
   variable (so that a flag left over from a no-longer-live exception
   can't be folded into a new one).
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/include/asm/vmx.h      |  5 ++++-
 arch/x86/include/uapi/asm/kvm.h |  3 ++-
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 10 ++++++++--
 arch/x86/kvm/x86.c              | 18 +++++++++++++++++-
 arch/x86/kvm/x86.h              |  4 +++-
 7 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dd68db17fdae..994c354dc47b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -695,6 +695,7 @@ struct kvm_queued_exception {
 	u32 error_code;
 	unsigned long payload;
 	bool has_payload;
+	bool is_nested;
 };
 
 /*
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 4720619f09ac..7eb08f84a7e5 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -152,6 +152,7 @@ struct vmcs {
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
 #define VMX_BASIC_NO_HW_ERROR_CODE_CC		BIT_ULL(56)
+#define VMX_BASIC_NESTED_EXCEPTION		BIT_ULL(58)
 #define VMX_BASIC_NO_SEAMRET_INVD_VMCS		BIT_ULL(60)
 
 static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
@@ -451,13 +452,15 @@ enum vmcs_field {
 #define INTR_INFO_INTR_TYPE_MASK        0x700           /* 10:8 */
 #define INTR_INFO_DELIVER_CODE_MASK     0x800           /* 11 */
 #define INTR_INFO_UNBLOCK_NMI		0x1000		/* 12 */
+#define INTR_INFO_NESTED_EXCEPTION_MASK	0x2000		/* 13 */
 #define INTR_INFO_VALID_MASK            0x80000000      /* 31 */
-#define INTR_INFO_RESVD_BITS_MASK       0x7ffff000
+#define INTR_INFO_RESVD_BITS_MASK       0x7fffd000
 
 #define VECTORING_INFO_VECTOR_MASK           	INTR_INFO_VECTOR_MASK
 #define VECTORING_INFO_TYPE_MASK        	INTR_INFO_INTR_TYPE_MASK
 #define VECTORING_INFO_DELIVER_CODE_MASK    	INTR_INFO_DELIVER_CODE_MASK
 #define VECTORING_INFO_VALID_MASK       	INTR_INFO_VALID_MASK
+#define VECTORING_INFO_NESTED_EXCEPTION_MASK	INTR_INFO_NESTED_EXCEPTION_MASK
 
 #define INTR_TYPE_EXT_INTR		(EVENT_TYPE_EXTINT << 8)	/* external interrupt */
 #define INTR_TYPE_RESERVED		(EVENT_TYPE_RESERVED << 8)	/* reserved */
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 6a67832c59bb..659c8391d40e 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -369,7 +369,8 @@ struct kvm_vcpu_events {
 	struct {
 		__u8 pending;
 	} triple_fault;
-	__u8 reserved[26];
+	__u8 reserved[25];
+	__u8 exception_is_nested;
 	__u8 exception_has_payload;
 	__u64 exception_payload;
 };
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ea647938a2a6..7762db655b28 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4392,7 +4392,7 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
 		kvm_requeue_exception(vcpu, vector,
 				      exitintinfo & SVM_EXITINTINFO_VALID_ERR,
-				      error_code);
+				      error_code, false);
 		break;
 	}
 	case SVM_EXITINTINFO_TYPE_INTR:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 362bd4dda298..25c3301e137b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2008,8 +2008,13 @@ void vmx_inject_exception(struct kvm_vcpu *vcpu)
 		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
 			     vmx->vcpu.arch.event_exit_inst_len);
 		intr_info |= INTR_TYPE_SOFT_EXCEPTION;
-	} else
+	} else {
 		intr_info |= INTR_TYPE_HARD_EXCEPTION;
+		if (is_fred_enabled(vcpu)) {
+			if (ex->is_nested)
+				intr_info |= INTR_INFO_NESTED_EXCEPTION_MASK;
+		}
+	}
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
 
@@ -7501,7 +7506,8 @@ static void __vmx_complete_interrupts(struct kvm_vcpu *vcpu,
 
 		kvm_requeue_exception(vcpu, vector,
 				      idt_vectoring_info & VECTORING_INFO_DELIVER_CODE_MASK,
-				      error_code);
+				      error_code,
+				      idt_vectoring_info & VECTORING_INFO_NESTED_EXCEPTION_MASK);
 		break;
 	}
 	case INTR_TYPE_SOFT_INTR:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 01198aba27cf..94d684210cf6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -461,6 +461,7 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 				   bool has_error, u32 error_code,
 				   bool has_payload, unsigned long payload)
 {
+	bool is_nested = false;
 	u32 prev_nr;
 	int class1, class2;
 
@@ -487,6 +488,11 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 		vcpu->arch.exception.error_code = error_code;
 		vcpu->arch.exception.has_payload = has_payload;
 		vcpu->arch.exception.payload = payload;
+		/* #DF is NOT a nested event, per its definition. */
+		vcpu->arch.exception.is_nested = (nr != DF_VECTOR) &&
+						 (is_nested ||
+						  vcpu->arch.nmi_injected ||
+						  vcpu->arch.interrupt.injected);
 		return;
 	}
 
@@ -510,6 +516,9 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 
 		kvm_queue_exception_e(vcpu, DF_VECTOR, 0);
 	} else {
+		/* The new exception arrived while delivering the previous one. */
+		is_nested = true;
+
 		/* replace previous exception with a new one in a hope
 		   that instruction re-execution will regenerate lost
 		   exception */
@@ -538,7 +547,8 @@ static void kvm_queue_exception_e_p(struct kvm_vcpu *vcpu, unsigned nr,
 }
 
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
-			   bool has_error_code, u32 error_code)
+			   bool has_error_code, u32 error_code,
+			   bool is_nested)
 {
 
 	/*
@@ -563,6 +573,7 @@ void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 	vcpu->arch.exception.error_code = error_code;
 	vcpu->arch.exception.has_payload = false;
 	vcpu->arch.exception.payload = 0;
+	vcpu->arch.exception.is_nested = is_nested;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_requeue_exception);
 
@@ -3000,6 +3011,7 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 	events->exception.error_code = ex->error_code;
 	events->exception_has_payload = ex->has_payload;
 	events->exception_payload = ex->payload;
+	events->exception_is_nested = ex->is_nested;
 
 	events->interrupt.injected =
 		vcpu->arch.interrupt.injected && !vcpu->arch.interrupt.soft;
@@ -3060,6 +3072,8 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 	if (events->flags & KVM_VCPUEVENT_VALID_FRED_STATE) {
 		if (!vcpu->kvm->arch.exception_fred_state_enabled)
 			return -EINVAL;
+	} else {
+		events->exception_is_nested = 0;
 	}
 
 	if ((events->exception.injected || events->exception.pending) &&
@@ -3087,6 +3101,7 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 	vcpu->arch.exception.error_code = events->exception.error_code;
 	vcpu->arch.exception.has_payload = events->exception_has_payload;
 	vcpu->arch.exception.payload = events->exception_payload;
+	vcpu->arch.exception.is_nested = events->exception_is_nested;
 
 	vcpu->arch.interrupt.injected = events->interrupt.injected;
 	vcpu->arch.interrupt.nr = events->interrupt.nr;
@@ -8978,6 +8993,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 					   ex->has_payload, ex->payload);
 		ex->injected = false;
 		ex->pending = false;
+		ex->is_nested = false;
 	}
 	vcpu->arch.exception_from_userspace = false;
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..2d6bae66cfae 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -158,6 +158,7 @@ static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.exception.pending = false;
 	vcpu->arch.exception.injected = false;
+	vcpu->arch.exception.is_nested = false;
 	vcpu->arch.exception_vmexit.pending = false;
 }
 
@@ -502,7 +503,8 @@ void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
-			   bool has_error_code, u32 error_code);
+			   bool has_error_code, u32 error_code,
+			   bool is_nested);
 void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
 			   bool from_hardware);
 void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-- 
2.43.0

