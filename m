Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B13264E3
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309059; cv=none; b=JRzVX6MmGyxbxTMz/Qz8o6n+dYumF6eYoFx1ABL/CX3cXkr3EVlaGhDKkl9lzA7PimJaBMgHNOOi2FLk1XwhhqzwtOyfyS953yL9onhZl3UwKTdAnpVdqr/6ICvpPPvhmy2y1wseV496QkRkEzOq5jcCU2N9lo7nIUGlCBlcNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309059; c=relaxed/simple;
	bh=b3fIBKO9IeDajV35cjBHysWd9QLM95PRu6/BYkRm+w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e3UQsuXaq2daLj9eEpsbnTm2y+XItgEkl/EGJ10vK3Z7qMyR3xq0QBsqOo+Vq3C4emgddWyjJZlsNNDnnfrdRLUyBGSpIo7535ebtgKSkhj7591+ouu3zjxqyUnbinRYqJnVClRwE6AhvGQWEqO1MIfA2GtKa9z3nh+/iXMavKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7edfGUb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7edfGUb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842208d5b0eso1211740b3a.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309057; x=1781913857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zP0m447lv97cwcHc7Z0rJACW3H7RJ3TtpSYRSJ54lEE=;
        b=C7edfGUbxNzQoMXcSvUQqB3c8MAc53UMJCcQt6IUGd0G4wt8B8Ob08HW7mNlMqS0Vv
         lfE6YwrJVjL3nPLD0Xl2Cu532qmvUo1z/uqhmZ31r8E28JFvgiZ1ASMJa3PC8NAFPTQ9
         1iieRCfifC2TMA/xa0fcyPPoKgh+C6yANfSeHyxLvbLwStoIgAo6w2UvqQcLjDKatnuG
         ket79aggiDb8Qg5cmvoEfA0vNfELq3C9db9RAukQp1f7uOEejoVfk7iQof9DKuhHkkvM
         AR6yjrXUbgy3+EDYDEJxWIchz4E3qy9iAmFu18gOsug4WAo+z/0LFw6R47SEKTLr6+EU
         Pw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309057; x=1781913857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP0m447lv97cwcHc7Z0rJACW3H7RJ3TtpSYRSJ54lEE=;
        b=dtOb0naF8qj4tXR6evyVpmlg1S6BbZuDh/yvEfJuu7b/1QgBdYKmNKXR1HbwmrvJOy
         WpvaBFYL2DE+U36SoWBS3NrB7ayMhHTDzyZM0u/6+pept81arClalaHSZcR8Ql9aSzWF
         WRQ91ze9ix7qg7AbdWYazIyZRmYbT1/Da2rZK+fFnRCRJbg74XKmtBb+FjWnk1C3x7dr
         zTFAFen460V+lHXWWYUEDolyRHg1I2natoYrBE60XKXDlAdhEk03R2YJOt1zsi+Ou/pH
         3HWA0lyy2r0/QrwA24iKMJmVgL1EfmjsaRS+X6U16Qp7gqPTQ4beYtRKGfqtgG1fGdhq
         ThZQ==
X-Gm-Message-State: AOJu0Yxsqr/JB6thMpKe4nKlrcgcNRmL0oWonDts6YucEbB0CF2JCVa7
	TBeqOx894v6YKoOEooJaZhl7Q2dbe1rjTkLzlDvnfwEOOUxjDG9IikOngekrMzeO1rKP0JKGEl2
	E1wqm/A==
X-Received: from pfbha13.prod.google.com ([2002:a05:6a00:850d:b0:835:3737:852a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab84:b0:841:4961:8d35
 with SMTP id d2e1a72fcca58-8434c9cbbbfmr5697063b3a.0.1781309056510; Fri, 12
 Jun 2026 17:04:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:29 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-31-seanjc@google.com>
Subject: [PATCH v4 30/30] KVM: x86: Move a pile of stuff from kvm_host.h => x86.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the majority of remaining KVM-internal declarations and defines in
kvm_host.h to x86.h, so that kvm_host.h only holds structure and function
definitions that need to be visible to arch-neutral KVM.

Land the emulator interfaces in x86.h, even though kvm_emulate.h *seems*
like a good home, as the interfaces and defines being moved are provided by
x86.c.  I.e. keep kvm_emulate.h as an interface to the emulator proper.

Note, any "misses" are likely unintentional.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 199 --------------------------------
 arch/x86/kvm/ioapic.c           |   1 +
 arch/x86/kvm/x86.h              | 197 +++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 199 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 878944aaea85..d6e1138af9e7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2074,9 +2074,6 @@ extern struct kvm_x86_ops kvm_x86_ops;
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 
-int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
-void kvm_x86_vendor_exit(void);
-
 #define __KVM_HAVE_ARCH_VM_ALLOC
 static inline struct kvm *kvm_arch_alloc_vm(void)
 {
@@ -2119,175 +2116,6 @@ enum kvm_intr_type {
 	((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
 	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
 
-/*
- * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
- *			userspace I/O) to indicate that the emulation context
- *			should be reused as is, i.e. skip initialization of
- *			emulation context, instruction fetch and decode.
- *
- * EMULTYPE_TRAP_UD - Set when emulating an intercepted #UD from hardware.
- *		      Indicates that only select instructions (tagged with
- *		      EmulateOnUD) should be emulated (to minimize the emulator
- *		      attack surface).  See also EMULTYPE_TRAP_UD_FORCED.
- *
- * EMULTYPE_SKIP - Set when emulating solely to skip an instruction, i.e. to
- *		   decode the instruction length.  For use *only* by
- *		   kvm_x86_ops.skip_emulated_instruction() implementations if
- *		   EMULTYPE_COMPLETE_USER_EXIT is not set.
- *
- * EMULTYPE_ALLOW_RETRY_PF - Set when the emulator should resume the guest to
- *			     retry native execution under certain conditions,
- *			     Can only be set in conjunction with EMULTYPE_PF.
- *
- * EMULTYPE_TRAP_UD_FORCED - Set when emulating an intercepted #UD that was
- *			     triggered by KVM's magic "force emulation" prefix,
- *			     which is opt in via module param (off by default).
- *			     Bypasses EmulateOnUD restriction despite emulating
- *			     due to an intercepted #UD (see EMULTYPE_TRAP_UD).
- *			     Used to test the full emulator from userspace.
- *
- * EMULTYPE_VMWARE_GP - Set when emulating an intercepted #GP for VMware
- *			backdoor emulation, which is opt in via module param.
- *			VMware backdoor emulation handles select instructions
- *			and reinjects the #GP for all other cases.
- *
- * EMULTYPE_PF - Set when an intercepted #PF triggers the emulation, in which case
- *		 the CR2/GPA value pass on the stack is valid.
- *
- * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
- *				 state and inject single-step #DBs after skipping
- *				 an instruction (after completing userspace I/O).
- *
- * EMULTYPE_WRITE_PF_TO_SP - Set when emulating an intercepted page fault that
- *			     is attempting to write a gfn that contains one or
- *			     more of the PTEs used to translate the write itself,
- *			     and the owning page table is being shadowed by KVM.
- *			     If emulation of the faulting instruction fails and
- *			     this flag is set, KVM will exit to userspace instead
- *			     of retrying emulation as KVM cannot make forward
- *			     progress.
- *
- *			     If emulation fails for a write to guest page tables,
- *			     KVM unprotects (zaps) the shadow page for the target
- *			     gfn and resumes the guest to retry the non-emulatable
- *			     instruction (on hardware).  Unprotecting the gfn
- *			     doesn't allow forward progress for a self-changing
- *			     access because doing so also zaps the translation for
- *			     the gfn, i.e. retrying the instruction will hit a
- *			     !PRESENT fault, which results in a new shadow page
- *			     and sends KVM back to square one.
- *
- * EMULTYPE_SKIP_SOFT_INT - Set in combination with EMULTYPE_SKIP to only skip
- *                          an instruction if it could generate a given software
- *                          interrupt, which must be encoded via
- *                          EMULTYPE_SET_SOFT_INT_VECTOR().
- */
-#define EMULTYPE_NO_DECODE	    (1 << 0)
-#define EMULTYPE_TRAP_UD	    (1 << 1)
-#define EMULTYPE_SKIP		    (1 << 2)
-#define EMULTYPE_ALLOW_RETRY_PF	    (1 << 3)
-#define EMULTYPE_TRAP_UD_FORCED	    (1 << 4)
-#define EMULTYPE_VMWARE_GP	    (1 << 5)
-#define EMULTYPE_PF		    (1 << 6)
-#define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
-#define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
-#define EMULTYPE_SKIP_SOFT_INT	    (1 << 9)
-
-#define EMULTYPE_SET_SOFT_INT_VECTOR(v)	((u32)((v) & 0xff) << 16)
-#define EMULTYPE_GET_SOFT_INT_VECTOR(e)	(((e) >> 16) & 0xff)
-
-static inline bool kvm_can_emulate_event_vectoring(int emul_type)
-{
-	return !(emul_type & EMULTYPE_PF);
-}
-
-int kvm_emulate_instruction(struct kvm_vcpu *vcpu, int emulation_type);
-int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
-					void *insn, int insn_len);
-void __kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu,
-					  u64 *data, u8 ndata);
-void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
-
-void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
-void kvm_prepare_unexpected_reason_exit(struct kvm_vcpu *vcpu, u64 exit_reason);
-
-int kvm_emulate_as_nop(struct kvm_vcpu *vcpu);
-int kvm_emulate_invd(struct kvm_vcpu *vcpu);
-int kvm_emulate_mwait(struct kvm_vcpu *vcpu);
-int kvm_handle_invalid_op(struct kvm_vcpu *vcpu);
-int kvm_emulate_monitor(struct kvm_vcpu *vcpu);
-
-int kvm_fast_pio(struct kvm_vcpu *vcpu, int size, unsigned short port, int in);
-int kvm_emulate_cpuid(struct kvm_vcpu *vcpu);
-int kvm_emulate_halt(struct kvm_vcpu *vcpu);
-int kvm_emulate_halt_noskip(struct kvm_vcpu *vcpu);
-int kvm_emulate_ap_reset_hold(struct kvm_vcpu *vcpu);
-int kvm_emulate_wbinvd(struct kvm_vcpu *vcpu);
-
-void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
-
-int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
-		    int reason, bool has_error_code, u32 error_code);
-
-int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
-int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
-
-int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
-
-void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
-void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
-void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
-void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
-			   bool has_error_code, u32 error_code);
-void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
-			   bool from_hardware);
-void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-				      struct x86_exception *fault,
-				      bool from_hardware);
-
-static inline void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-						  struct x86_exception *fault)
-{
-	__kvm_inject_emulated_page_fault(vcpu, fault, false);
-}
-
-bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
-
-void kvm_inject_nmi(struct kvm_vcpu *vcpu);
-int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
-
-bool kvm_apicv_activated(struct kvm *kvm);
-bool kvm_vcpu_apicv_activated(struct kvm_vcpu *vcpu);
-void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu);
-void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
-				      enum kvm_apicv_inhibit reason, bool set);
-void kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
-				    enum kvm_apicv_inhibit reason, bool set);
-
-static inline void kvm_set_apicv_inhibit(struct kvm *kvm,
-					 enum kvm_apicv_inhibit reason)
-{
-	kvm_set_or_clear_apicv_inhibit(kvm, reason, true);
-}
-
-static inline void kvm_clear_apicv_inhibit(struct kvm *kvm,
-					   enum kvm_apicv_inhibit reason)
-{
-	kvm_set_or_clear_apicv_inhibit(kvm, reason, false);
-}
-
-void kvm_inc_or_dec_irq_window_inhibit(struct kvm *kvm, bool inc);
-
-static inline void kvm_inc_apicv_irq_window_req(struct kvm *kvm)
-{
-	kvm_inc_or_dec_irq_window_inhibit(kvm, true);
-}
-
-static inline void kvm_dec_apicv_irq_window_req(struct kvm *kvm)
-{
-	kvm_inc_or_dec_irq_window_inhibit(kvm, false);
-}
-
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
 #endif
@@ -2304,11 +2132,6 @@ static inline unsigned long read_msr(unsigned long msr)
 }
 #endif
 
-static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
-{
-	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
-}
-
 #define TSS_IOPB_BASE_OFFSET 0x66
 #define TSS_BASE_SIZE 0x68
 #define TSS_IOPB_SIZE (65536 / 8)
@@ -2338,17 +2161,6 @@ enum {
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
 #endif
 
-void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
-
-u64 kvm_scale_tsc(u64 tsc, u64 ratio);
-u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
-u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
-u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier);
-
-void kvm_make_scan_ioapic_request(struct kvm *kvm);
-void kvm_make_scan_ioapic_request_mask(struct kvm *kvm,
-				       unsigned long *vcpu_bitmap);
-
 bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 				     struct kvm_async_pf *work);
 void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
@@ -2357,15 +2169,6 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
 			       struct kvm_async_pf *work);
 void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu);
 bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu);
-extern bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
-
-int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
-int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
-
-void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
-				     u32 size);
-bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
-bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
 
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
@@ -2387,8 +2190,6 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
 #endif
 }
 
-int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
-
 static inline bool kvm_arch_has_irq_bypass(void)
 {
 	return enable_device_posted_irqs;
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index f3f4a483ca15..b090c8696116 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -33,6 +33,7 @@
 #include "lapic.h"
 #include "irq.h"
 #include "trace.h"
+#include "x86.h"
 
 static int ioapic_service(struct kvm_ioapic *vioapic, int irq,
 		bool line_status);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index fd3d0a196526..3180046c713b 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -14,6 +14,9 @@
 
 #define KVM_MAX_MCE_BANKS 32
 
+int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
+void kvm_x86_vendor_exit(void);
+
 void kvm_spurious_fault(void);
 
 #define SIZE_OF_MEMSLOTS_HASHTABLE \
@@ -318,6 +321,8 @@ static __always_inline void kvm_request_l1tf_flush_l1d(void)
 #endif
 }
 
+void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
+
 void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
 
 u64 get_kvmclock_ns(struct kvm *kvm);
@@ -326,6 +331,10 @@ bool kvm_get_monotonic_and_clockread(s64 *kernel_ns, u64 *tsc_timestamp);
 int kvm_guest_time_update(struct kvm_vcpu *v);
 
 void kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 *user_value);
+u64 kvm_scale_tsc(u64 tsc, u64 ratio);
+u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
+u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
+u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier);
 u64 kvm_compute_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc);
 void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset);
 
@@ -363,10 +372,196 @@ int x86_decode_emulated_instruction(struct kvm_vcpu *vcpu, int emulation_type,
 				    void *insn, int insn_len);
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len);
+/*
+ * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
+ *			userspace I/O) to indicate that the emulation context
+ *			should be reused as is, i.e. skip initialization of
+ *			emulation context, instruction fetch and decode.
+ *
+ * EMULTYPE_TRAP_UD - Set when emulating an intercepted #UD from hardware.
+ *		      Indicates that only select instructions (tagged with
+ *		      EmulateOnUD) should be emulated (to minimize the emulator
+ *		      attack surface).  See also EMULTYPE_TRAP_UD_FORCED.
+ *
+ * EMULTYPE_SKIP - Set when emulating solely to skip an instruction, i.e. to
+ *		   decode the instruction length.  For use *only* by
+ *		   kvm_x86_ops.skip_emulated_instruction() implementations if
+ *		   EMULTYPE_COMPLETE_USER_EXIT is not set.
+ *
+ * EMULTYPE_ALLOW_RETRY_PF - Set when the emulator should resume the guest to
+ *			     retry native execution under certain conditions,
+ *			     Can only be set in conjunction with EMULTYPE_PF.
+ *
+ * EMULTYPE_TRAP_UD_FORCED - Set when emulating an intercepted #UD that was
+ *			     triggered by KVM's magic "force emulation" prefix,
+ *			     which is opt in via module param (off by default).
+ *			     Bypasses EmulateOnUD restriction despite emulating
+ *			     due to an intercepted #UD (see EMULTYPE_TRAP_UD).
+ *			     Used to test the full emulator from userspace.
+ *
+ * EMULTYPE_VMWARE_GP - Set when emulating an intercepted #GP for VMware
+ *			backdoor emulation, which is opt in via module param.
+ *			VMware backdoor emulation handles select instructions
+ *			and reinjects the #GP for all other cases.
+ *
+ * EMULTYPE_PF - Set when an intercepted #PF triggers the emulation, in which case
+ *		 the CR2/GPA value pass on the stack is valid.
+ *
+ * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
+ *				 state and inject single-step #DBs after skipping
+ *				 an instruction (after completing userspace I/O).
+ *
+ * EMULTYPE_WRITE_PF_TO_SP - Set when emulating an intercepted page fault that
+ *			     is attempting to write a gfn that contains one or
+ *			     more of the PTEs used to translate the write itself,
+ *			     and the owning page table is being shadowed by KVM.
+ *			     If emulation of the faulting instruction fails and
+ *			     this flag is set, KVM will exit to userspace instead
+ *			     of retrying emulation as KVM cannot make forward
+ *			     progress.
+ *
+ *			     If emulation fails for a write to guest page tables,
+ *			     KVM unprotects (zaps) the shadow page for the target
+ *			     gfn and resumes the guest to retry the non-emulatable
+ *			     instruction (on hardware).  Unprotecting the gfn
+ *			     doesn't allow forward progress for a self-changing
+ *			     access because doing so also zaps the translation for
+ *			     the gfn, i.e. retrying the instruction will hit a
+ *			     !PRESENT fault, which results in a new shadow page
+ *			     and sends KVM back to square one.
+ *
+ * EMULTYPE_SKIP_SOFT_INT - Set in combination with EMULTYPE_SKIP to only skip
+ *                          an instruction if it could generate a given software
+ *                          interrupt, which must be encoded via
+ *                          EMULTYPE_SET_SOFT_INT_VECTOR().
+ */
+#define EMULTYPE_NO_DECODE	    (1 << 0)
+#define EMULTYPE_TRAP_UD	    (1 << 1)
+#define EMULTYPE_SKIP		    (1 << 2)
+#define EMULTYPE_ALLOW_RETRY_PF	    (1 << 3)
+#define EMULTYPE_TRAP_UD_FORCED	    (1 << 4)
+#define EMULTYPE_VMWARE_GP	    (1 << 5)
+#define EMULTYPE_PF		    (1 << 6)
+#define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
+#define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
+#define EMULTYPE_SKIP_SOFT_INT	    (1 << 9)
+
+#define EMULTYPE_SET_SOFT_INT_VECTOR(v)	((u32)((v) & 0xff) << 16)
+#define EMULTYPE_GET_SOFT_INT_VECTOR(e)	(((e) >> 16) & 0xff)
+
+static inline bool kvm_can_emulate_event_vectoring(int emul_type)
+{
+	return !(emul_type & EMULTYPE_PF);
+}
+
+int kvm_emulate_instruction(struct kvm_vcpu *vcpu, int emulation_type);
+int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
+					void *insn, int insn_len);
+void __kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu,
+					  u64 *data, u8 ndata);
+void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
+
+void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
+void kvm_prepare_unexpected_reason_exit(struct kvm_vcpu *vcpu, u64 exit_reason);
 
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu);
 fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu);
 
+int kvm_emulate_as_nop(struct kvm_vcpu *vcpu);
+int kvm_emulate_invd(struct kvm_vcpu *vcpu);
+int kvm_emulate_mwait(struct kvm_vcpu *vcpu);
+int kvm_handle_invalid_op(struct kvm_vcpu *vcpu);
+int kvm_emulate_monitor(struct kvm_vcpu *vcpu);
+
+int kvm_fast_pio(struct kvm_vcpu *vcpu, int size, unsigned short port, int in);
+int kvm_emulate_cpuid(struct kvm_vcpu *vcpu);
+int kvm_emulate_halt(struct kvm_vcpu *vcpu);
+int kvm_emulate_halt_noskip(struct kvm_vcpu *vcpu);
+int kvm_emulate_ap_reset_hold(struct kvm_vcpu *vcpu);
+int kvm_emulate_wbinvd(struct kvm_vcpu *vcpu);
+
+void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
+
+int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
+		    int reason, bool has_error_code, u32 error_code);
+
+int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
+int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
+int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
+
+int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
+int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err);
+
+void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
+void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
+void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
+void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
+			   bool has_error_code, u32 error_code);
+void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
+			   bool from_hardware);
+void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+				      struct x86_exception *fault,
+				      bool from_hardware);
+
+static inline void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+						  struct x86_exception *fault)
+{
+	__kvm_inject_emulated_page_fault(vcpu, fault, false);
+}
+
+bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
+
+static inline void kvm_inject_gp(struct kvm_vcpu *vcpu, u32 error_code)
+{
+	kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
+}
+
+void kvm_inject_nmi(struct kvm_vcpu *vcpu);
+int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
+
+void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
+				     u32 size);
+int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
+
+bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
+bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
+
+bool kvm_apicv_activated(struct kvm *kvm);
+bool kvm_vcpu_apicv_activated(struct kvm_vcpu *vcpu);
+void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu);
+void __kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
+				      enum kvm_apicv_inhibit reason, bool set);
+void kvm_set_or_clear_apicv_inhibit(struct kvm *kvm,
+				    enum kvm_apicv_inhibit reason, bool set);
+
+static inline void kvm_set_apicv_inhibit(struct kvm *kvm,
+					 enum kvm_apicv_inhibit reason)
+{
+	kvm_set_or_clear_apicv_inhibit(kvm, reason, true);
+}
+
+static inline void kvm_clear_apicv_inhibit(struct kvm *kvm,
+					   enum kvm_apicv_inhibit reason)
+{
+	kvm_set_or_clear_apicv_inhibit(kvm, reason, false);
+}
+
+void kvm_inc_or_dec_irq_window_inhibit(struct kvm *kvm, bool inc);
+
+static inline void kvm_inc_apicv_irq_window_req(struct kvm *kvm)
+{
+	kvm_inc_or_dec_irq_window_inhibit(kvm, true);
+}
+
+static inline void kvm_dec_apicv_irq_window_req(struct kvm *kvm)
+{
+	kvm_inc_or_dec_irq_window_inhibit(kvm, false);
+}
+
+void kvm_make_scan_ioapic_request(struct kvm *kvm);
+void kvm_make_scan_ioapic_request_mask(struct kvm *kvm,
+				       unsigned long *vcpu_bitmap);
+
 void kvm_setup_xss_caps(void);
 
 /*
@@ -507,6 +702,8 @@ static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
 		vcpu->arch.apf.gfns[i] = ~0;
 }
 
+bool kvm_find_async_pf_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
+
 /*
  * Trigger machine check on the host. We assume all the MSRs are already set up
  * by the CPU and that we still run on the same CPU as the MCE occurred on.
-- 
2.54.0.1136.gdb2ca164c4-goog

