Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEE47AF66
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093403; cv=none; b=SLhqKR39mHWhr0FNvCj/ZZnI8HfLztQPoolpihctoptq3yZgmBPnrMcGoe9S1wL/KVT58j+rlBnnYwsfJpOf+KM3f/RgKCtFlRVSK5bpBLk4T1WmHo9FWjbmU1qMV0vZWWAPyvli+fdGfZ1ltAw6iaGl4tWfvZnGWTyDTk0OrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093403; c=relaxed/simple;
	bh=VRgMRhtjVBgYv8JI3E7pVGBY+7qN4gb9G0f1N7S5p40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mfKzY2Z1/UoNdYCvf/MqMq81xA/n26lG0dEDcGNutR/cOZtXjvd+WGDc2juduGdj6c5L/Q9aP+C99QR/O2Ndu4rnm0xgfpdqISlEUrP2aY4ybGPncLAu1h7eTIvGafM10yV2qo4S5o5t9wkHrkyy1UpwXx1icUH4JGm5vJvrsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgJSYYSO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgJSYYSO"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c857befe561so361826a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093401; x=1780698201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I88SBvpclb3TmLRZLMUOgTRAM1nkrimTOG6pLdh+qCU=;
        b=GgJSYYSOubVg4zFTvJ1NBy+h3cHgCqWM9FGd1jS1RogF/qE6TB2AqKFjEtu5y7vPrd
         vRgaMw/MmhiILgx+lOESGCw07u/O8EhpvTfDMzMOb7hpWTvaHVRuV2y42l1jUm9VJI5s
         L7I8XBqNRsyQPHa9m4StBv5fX17VGhZXac0T/Y7xTx2q6dfz23ot690xWm5UTwbV+Yu8
         ZQRlFRBoS2m8iFevguzTt9b0JDqwhTLBzmLSGouoynufiFi9UoIO/73rA6Sg10NwFcpE
         VUaMLGtAz9BwV4ognyKWRLpi5en35N3HKen+zef0GB6FYe85idYUEIfI35TR1YlEFLCy
         kuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093401; x=1780698201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I88SBvpclb3TmLRZLMUOgTRAM1nkrimTOG6pLdh+qCU=;
        b=nvV7uyY2xmcNfLZtUf8939NQcV5FEiH1FuZdWdceH98uE52IdzMUAuocoC9ZnzwPdX
         It3JKZ2mYFM/ufXi+s5ekUE1BYDtkxObqFZL6w2TRYjIbiOUelvaIPK2SnGP2+x8WLBj
         O/dTgvwtEnX53Cs8VICKZes8bI69VHiKXx6opNL3hPfviBstwexxjMnck1bN2uxnGYMg
         ARL1y97WOmUASTVrYJqoUghmMPVZN1SWqa6jpXaS3p8QgRKwNpVCElsv+sy3JRNrPAXT
         xuJi7xMEcjxLiqW5FFl2hZTTn2rGY8lsrrDxLuAfauSYAFFuV0wfeWqzRQQOKDIvwOaR
         SUTA==
X-Gm-Message-State: AOJu0YzVICuW6wCQu6sz3rm2dN6i2FFdEq/ni7RXddnuQTty6l10cAAK
	1AYprQHi8kq1JinhWB7EZpf0GNfd+cqaARmoANdEgui7J/zQY4uO70vE67fmaSfhN1LbxWcfZRN
	VWHDLfQ==
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:c81:5509:27fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a107:b0:398:c0ba:9ceb
 with SMTP id adf61e73a8af0-3b427c3f5b8mr1270452637.12.1780093400506; Fri, 29
 May 2026 15:23:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:14 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-32-seanjc@google.com>
Subject: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move a pile of MMU helper declarations into mmu.h, as they are very much
KVM x86 internal APIs and not intended to be exposed to arch-neutral KVM,
and certainly not to the broader kernel.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 70 --------------------------------
 arch/x86/kvm/mmu.h              | 71 +++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1143140592df..f217403e18fc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -161,12 +161,6 @@
 #define KVM_HPAGE_MASK(x)	(~(KVM_HPAGE_SIZE(x) - 1))
 #define KVM_PAGES_PER_HPAGE(x)	(KVM_HPAGE_SIZE(x) / PAGE_SIZE)
 
-#define KVM_MEMSLOT_PAGES_TO_MMU_PAGES_RATIO 50
-#define KVM_MIN_ALLOC_MMU_PAGES 64UL
-#define KVM_MMU_HASH_SHIFT 12
-#define KVM_NUM_MMU_PAGES (1 << KVM_MMU_HASH_SHIFT)
-#define KVM_MIN_FREE_MMU_PAGES 5
-#define KVM_REFILL_PAGES 25
 #define KVM_MAX_CPUID_ENTRIES 256
 #define KVM_NR_VAR_MTRR 8
 
@@ -2153,38 +2147,6 @@ enum kvm_intr_type {
 	((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
 	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
 
-void __init kvm_mmu_x86_module_init(void);
-int kvm_mmu_vendor_module_init(void);
-void kvm_mmu_vendor_module_exit(void);
-
-void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
-int kvm_mmu_create(struct kvm_vcpu *vcpu);
-int kvm_mmu_init_vm(struct kvm *kvm);
-void kvm_mmu_uninit_vm(struct kvm *kvm);
-
-void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
-					    struct kvm_memory_slot *slot);
-
-void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu);
-void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
-void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
-				      const struct kvm_memory_slot *memslot,
-				      int start_level);
-void kvm_mmu_slot_try_split_huge_pages(struct kvm *kvm,
-				       const struct kvm_memory_slot *memslot,
-				       int target_level);
-void kvm_mmu_try_split_huge_pages(struct kvm *kvm,
-				  const struct kvm_memory_slot *memslot,
-				  u64 start, u64 end,
-				  int target_level);
-void kvm_mmu_recover_huge_pages(struct kvm *kvm,
-				const struct kvm_memory_slot *memslot);
-void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
-				   const struct kvm_memory_slot *memslot);
-void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
-void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
-void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
-
 /*
  * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
  *			userspace I/O) to indicate that the emulation context
@@ -2334,25 +2296,6 @@ static inline int __kvm_irq_line_state(unsigned long *irq_state,
 void kvm_inject_nmi(struct kvm_vcpu *vcpu);
 int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
 
-bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-				       bool always_retry);
-
-static inline bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu,
-						   gpa_t cr2_or_gpa)
-{
-	return __kvm_mmu_unprotect_gfn_and_retry(vcpu, cr2_or_gpa, false);
-}
-
-void kvm_mmu_free_roots(struct kvm *kvm, struct kvm_mmu *mmu,
-			ulong roots_to_free);
-void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu);
-gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
-			      struct x86_exception *exception);
-gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
-			       struct x86_exception *exception);
-gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
-				struct x86_exception *exception);
-
 bool kvm_apicv_activated(struct kvm *kvm);
 bool kvm_vcpu_apicv_activated(struct kvm_vcpu *vcpu);
 void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu);
@@ -2385,19 +2328,6 @@ static inline void kvm_dec_apicv_irq_window_req(struct kvm *kvm)
 	kvm_inc_or_dec_irq_window_inhibit(kvm, false);
 }
 
-int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
-		       void *insn, int insn_len);
-void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg);
-void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
-void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			     u64 addr, unsigned long roots);
-void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
-void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd);
-
-void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
-		       int tdp_max_root_level, int tdp_huge_page_level);
-
-
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
 #endif
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index d30676935fff..a6b871253bd7 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -15,6 +15,13 @@ extern bool tdp_mmu_enabled;
 extern bool __read_mostly enable_mmio_caching;
 extern bool eager_page_split;
 
+#define KVM_MEMSLOT_PAGES_TO_MMU_PAGES_RATIO 50
+#define KVM_MIN_ALLOC_MMU_PAGES 64UL
+#define KVM_MMU_HASH_SHIFT 12
+#define KVM_NUM_MMU_PAGES (1 << KVM_MMU_HASH_SHIFT)
+#define KVM_MIN_FREE_MMU_PAGES 5
+#define KVM_REFILL_PAGES 25
+
 #define PT_WRITABLE_SHIFT 1
 #define PT_USER_SHIFT 2
 
@@ -96,6 +103,38 @@ static inline bool mmu_has_mbec(struct kvm_mmu *mmu)
 
 u8 kvm_mmu_get_max_tdp_level(void);
 
+void __init kvm_mmu_x86_module_init(void);
+int kvm_mmu_vendor_module_init(void);
+void kvm_mmu_vendor_module_exit(void);
+
+void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
+int kvm_mmu_create(struct kvm_vcpu *vcpu);
+int kvm_mmu_init_vm(struct kvm *kvm);
+void kvm_mmu_uninit_vm(struct kvm *kvm);
+
+void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
+					    struct kvm_memory_slot *slot);
+
+void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu);
+void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
+void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
+				      const struct kvm_memory_slot *memslot,
+				      int start_level);
+void kvm_mmu_slot_try_split_huge_pages(struct kvm *kvm,
+				       const struct kvm_memory_slot *memslot,
+				       int target_level);
+void kvm_mmu_try_split_huge_pages(struct kvm *kvm,
+				  const struct kvm_memory_slot *memslot,
+				  u64 start, u64 end,
+				  int target_level);
+void kvm_mmu_recover_huge_pages(struct kvm *kvm,
+				const struct kvm_memory_slot *memslot);
+void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
+				   const struct kvm_memory_slot *memslot);
+void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
+void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
+void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
+
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
 void kvm_mmu_set_mmio_spte_value(struct kvm *kvm, u64 mmio_value);
 void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
@@ -107,6 +146,19 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
+
+int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
+		       void *insn, int insn_len);
+void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg);
+void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
+void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			     u64 addr, unsigned long roots);
+void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
+void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd);
+
+void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
+		       int tdp_max_root_level, int tdp_huge_page_level);
+
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
@@ -121,6 +173,25 @@ void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu);
 void kvm_mmu_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 			 int bytes);
 
+bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
+				       bool always_retry);
+
+static inline bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu,
+						   gpa_t cr2_or_gpa)
+{
+	return __kvm_mmu_unprotect_gfn_and_retry(vcpu, cr2_or_gpa, false);
+}
+
+void kvm_mmu_free_roots(struct kvm *kvm, struct kvm_mmu *mmu,
+			ulong roots_to_free);
+void kvm_mmu_free_guest_mode_roots(struct kvm *kvm, struct kvm_mmu *mmu);
+gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
+			      struct x86_exception *exception);
+gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
+			       struct x86_exception *exception);
+gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
+				struct x86_exception *exception);
+
 static inline int kvm_mmu_reload(struct kvm_vcpu *vcpu)
 {
 	if (kvm_check_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu))
-- 
2.54.0.823.g6e5bcc1fc9-goog

