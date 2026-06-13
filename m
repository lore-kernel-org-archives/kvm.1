Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CE29CE9
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309037; cv=none; b=kuw9Oojs3Q1KNhoBkHkK2njLW7GwncffXIWiBNAl8EqRcAflaDM74MrnHdEGBTgy5FcUoaQ+R8nmwaOfRJCXtp6ymlDHK9BRsbDFNODjWPN+LeLpo2cNe+fiGO2u6s8TqCsd9KGtVflY5bprTuRbhRRO+E0DaFO3wOzK7YLiPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309037; c=relaxed/simple;
	bh=SpbXriFnA8jS4mm/nuqsE13R7s0mODcLo0KYsXzUNKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gxiNPRN5uSM55QKP5Ah3dTalLdr57/GMwBc3RSCIMZJkZ+yviciB8jQdTAkavEzKI5jQGzaf/+E+aWTZ3sdi7rL9np8ukcSKyhEvGwV3IcZxCi0tQpIXZcPTF3wT8HS8UVeeSE9C5HDt8cxxtRHAehruvkzZcGER6mg6vNp+knk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J213h4uE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J213h4uE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84245e2bb00so1451737b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309035; x=1781913835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jW3InBtbJTamSq1vh7k36Zu2fGMa95lp4jF8Ehrzmto=;
        b=J213h4uE68D/Vps8HRANHXmZKCa0IZ9/6EIArdY3TU40TOcnRaTDQrhK7/xnWjE6tp
         6fbB58PwJczFLYYX2i4CiBEuD/lvZVC56rOw0NJiYtNuhRSctmuBGsf68azk4H50xIDK
         St4t/wywVvQxonf0o46a1nylOvWOLkavfw2429zWKd4vOUMcetW4hEsQfUAs3VMvHl0x
         u9/vCIxqdVuM4q5PHeSplqdoUHgwSgACFRElZT7GcrZcRmNzm9WuR6nUPA+1oP5rPylj
         GtkrS4GLOioS50SY/bc9fPK0xRvzf9SLby794MiXdoTSU+rYi61Cajs9A7duRBSP4RrC
         m4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309035; x=1781913835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jW3InBtbJTamSq1vh7k36Zu2fGMa95lp4jF8Ehrzmto=;
        b=Wm31oNENIjwKCmTEL7dFLmP0SfxXz21Hbv9jb2WnK7RY2xZv4m44hTEqxfW1YE40vE
         ee8ijgght/Hj6Hp29MAh7oGp79G983n4ALPJXZtV1acNAWfr1WX3eTHfL8wy0d97qrzD
         /oRUGURqJwRqisOY1StnewUmgElVMR5zAJhcPgfJkOyeORbzsg7IzQQL7I7KqwvN1E6R
         uGOvdajOMidev7irxZSqdYyy5+xLGGrsqOpF3LUMmBZ6ypyM/LqiPb/MwijDPolFQkNK
         J55BxSaGAR+lgDhpKbnxjPGB/xEwPrxbxjdZxsCSjmJjQyKKtQlvMQDW3EQQBfRWsBdD
         1G0A==
X-Gm-Message-State: AOJu0YzaQl25MJxFMnd/tIEgIo/9PevYEWjX7T6wlwTRgW10vE/Qg+8C
	fihFJaSz5rTRdOmqBNyIQS82S3DlD4Z7azLInfdVokF7jLlWa4Gr27R1+/wQuOY6z2D0mM/NIdU
	+THzxhA==
X-Received: from pfw3.prod.google.com ([2002:a05:6a00:a263:b0:82f:4d28:b8c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8884:0:b0:83e:f228:b112
 with SMTP id d2e1a72fcca58-8434cf44981mr5919094b3a.34.1781309034816; Fri, 12
 Jun 2026 17:03:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:14 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-16-seanjc@google.com>
Subject: [PATCH v4 15/30] KVM: x86: Move register helper declarations from
 kvm_host.h => regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Relocate declarations of Control/Debug Register, EFLAGS and RIP helpers
from x86's kvm_host.h to regs.h, to continue trimming down kvm_host.h.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 19 -------------------
 arch/x86/kvm/regs.h             | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 153ed5611c2e..cc96a9acaf88 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2186,8 +2186,6 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
 void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
 
-int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
-
 /*
  * EMULTYPE_NO_DECODE - Set when re-emulating an instruction (after completing
  *			userspace I/O) to indicate that the emulation context
@@ -2312,24 +2310,12 @@ void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 		    int reason, bool has_error_code, u32 error_code);
 
-void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0);
-void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4);
-int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
-int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
-int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
-int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
-int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
-unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
-unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
-void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
 int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
 
 int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
-unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu);
-void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
 
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr);
@@ -2366,8 +2352,6 @@ static inline int __kvm_irq_line_state(unsigned long *irq_state,
 void kvm_inject_nmi(struct kvm_vcpu *vcpu);
 int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
 
-void kvm_update_dr7(struct kvm_vcpu *vcpu);
-
 bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				       bool always_retry);
 
@@ -2521,9 +2505,6 @@ u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc);
 u64 kvm_calc_nested_tsc_offset(u64 l1_offset, u64 l2_offset, u64 l2_multiplier);
 u64 kvm_calc_nested_tsc_multiplier(u64 l1_multiplier, u64 l2_multiplier);
 
-unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu);
-bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsigned long linear_rip);
-
 void kvm_make_scan_ioapic_request(struct kvm *kvm);
 void kvm_make_scan_ioapic_request_mask(struct kvm *kvm,
 				       unsigned long *vcpu_bitmap);
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 1fd12388250b..30ef08d60a74 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -16,6 +16,18 @@
 
 static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 
+void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0);
+void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4);
+int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
+int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3);
+int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
+int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
+int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
+unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
+unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
+void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
+int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
+
 static inline bool is_long_mode(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
@@ -425,7 +437,12 @@ static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
 	return kvm_x86_call(get_segment_base)(vcpu, seg);
 }
 
+unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu);
+bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsigned long linear_rip);
+
+unsigned long kvm_get_rflags(struct kvm_vcpu *vcpu);
 void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
+void kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 
 void kvm_x86_vcpu_ioctl_get_sregs2(struct kvm_vcpu *vcpu,
 				   struct kvm_sregs2 *sregs2);
@@ -436,6 +453,7 @@ void kvm_run_sync_regs_to_user(struct kvm_vcpu *vcpu);
 int kvm_run_sync_regs_from_user(struct kvm_vcpu *vcpu);
 
 void kvm_update_dr0123(struct kvm_vcpu *vcpu);
+void kvm_update_dr7(struct kvm_vcpu *vcpu);
 int kvm_vcpu_ioctl_x86_get_debugregs(struct kvm_vcpu *vcpu,
 				     struct kvm_debugregs *dbgregs);
 int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
-- 
2.54.0.1136.gdb2ca164c4-goog

