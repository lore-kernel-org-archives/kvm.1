Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695D31AAAF
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309057; cv=none; b=Gg1N+BadTOQDgfi61mjHDyIB7GWJXv28APtHGkYQSUP/QcL+6tUkb4DwQUyQNNUHXgNhw0I0QL9o60xF3/kqGfrftSzKq5njDo7n9/XL3V/jYny+rv8uW58+IVvFKnMS9KOQBYoHbtqDv80YCzaf5f8iK545/U3vhDtvX/Bfs+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309057; c=relaxed/simple;
	bh=/kxNLm+6QheCBKL24fFGAKm8kRACbAKun25SJx5QxEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mc0pBuTYTq/SKjU2a83yLqj8r29qhgRiPLMQ1G93Ph/5fYeK1YvBkkPiaLGOL/x215QBV+E/XOcdGUbCy8JbYzx3WytouzF9kMl2wGpC/WMFR9Wi1ELjaaK8aRjMLtT/3caNeshDtu4geVFOplOwsQ7XI3fwQxEUBB8O4oassj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P82k6OQb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P82k6OQb"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d6389bbf4so1589360a91.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309055; x=1781913855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wEiNgupOlsclCgZ98OjFntYmx3MqWe+epI59VzaClDw=;
        b=P82k6OQbEkmO+SJOp0Ox93PTE0TmS8JHi33YNAxtyxUkwh0mjUmg8OjDo8VAAp1mmb
         eQi/3XJ0Ar5ZlAQ1jCcYJHajZISaeMp/SN/U7JvhLKuJCSXV2+d/VltwI9hhkn+W2BWG
         d7r2YZWP/pYzQjtwn8jF20pRusWx3nGF6LX4jfonEzYapm6RIzgYjrSOr19FOgsCK9Ms
         PprQ3uvFeXuyxBIvz3UykI3auAF937jb5tYzxYVtIyGjZ7ofAcP9zcPohtGI88BKS/UP
         h4wT933846wcmBe2vllP48++lNGxjzI7BT09zioWRjNFYyyK7gVyY+WR2EWlkdrjjCuU
         MhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309055; x=1781913855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEiNgupOlsclCgZ98OjFntYmx3MqWe+epI59VzaClDw=;
        b=BJ0dq2knT1GnXgy/GAQ7hleVmm6n7N9OaKF/3TRdvMVCU/Kpzo+3YL84K+Kur7TnF4
         4r5jJ1w2BkavLzJ2/9nRnWA0cq8cGQSukZBAV+18qEEys1CJBlpiQj7smJYbsDBXZyzE
         M7xKlZnrXIKYUZooZm9kpaMj249+wAHWewpNJG8y5yrp1H+1b43B/SjdciXtRf57zPWF
         PorBlplhKaXU0D8j8wx9+TRlW97UBSVqTMkFnVjf72QD2APDrG4CDUxhdwTzKsNvYrgz
         6vJC7sjXVj/bulKAvIMO0TAP2HT8eLHL/W7SNbCEAS0V8Wto0+XPzoWKNjWrFMVlbxds
         Cr7g==
X-Gm-Message-State: AOJu0Yw9MzvcUTW+MuB44BIFhKfrzWJKIK8/22f3mRSXWaylmiy6u0QN
	Jkcsppb8Bog740btwL+69vq+0XXaZOW6E2DNI7H7OIjGrfWd/PKeSPXE6DSS5RwATprvSrUPv9/
	J0DOYmA==
X-Received: from plsl10.prod.google.com ([2002:a17:903:244a:b0:2bd:859d:8959])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c409:b0:2bc:b80f:6782
 with SMTP id d9443c01a7336-2c6641ef614mr19722585ad.11.1781309055174; Fri, 12
 Jun 2026 17:04:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:28 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-30-seanjc@google.com>
Subject: [PATCH v4 29/30] KVM: x86/mmu: Move kvm_mmu_do_page_fault() from
 mmu_internal.h => mmu.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_mmu_do_page_fault() into mmu.c, as there are no users outside of
mmu.c, and the function typically isn't inlined by the compiler anyways.
This will allow moving the EMULTYPE_xxx definitions into x86.h without
having to include x86.h in mmu_internal.h, i.e. will help preserve the
goal of making x86.h KVM x86's "top-level" include.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 67 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/mmu/mmu_internal.h | 66 --------------------------------
 2 files changed, 66 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index bc844ca9e01f..e74ac24e4ee3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4927,7 +4927,7 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 }
 #endif
 
-int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+static int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 #ifdef CONFIG_X86_64
 	if (tdp_mmu_enabled)
@@ -4937,6 +4937,71 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	return direct_page_fault(vcpu, fault);
 }
 
+static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
+				 u64 err, bool prefetch, int *emulation_type,
+				 u8 *level)
+{
+	struct kvm_page_fault fault = {
+		.addr = cr2_or_gpa,
+		.error_code = err,
+		.exec = err & PFERR_FETCH_MASK,
+		.write = err & PFERR_WRITE_MASK,
+		.present = err & PFERR_PRESENT_MASK,
+		.rsvd = err & PFERR_RSVD_MASK,
+		.user = err & PFERR_USER_MASK,
+		.prefetch = prefetch,
+		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
+		.nx_huge_page_workaround_enabled =
+			is_nx_huge_page_enabled(vcpu->kvm),
+
+		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
+		.req_level = PG_LEVEL_4K,
+		.goal_level = PG_LEVEL_4K,
+		.is_private = err & PFERR_PRIVATE_ACCESS,
+
+		.pfn = KVM_PFN_ERR_FAULT,
+	};
+	int r;
+
+	if (vcpu->arch.mmu->root_role.direct) {
+		/*
+		 * Things like memslots don't understand the concept of a shared
+		 * bit. Strip it so that the GFN can be used like normal, and the
+		 * fault.addr can be used when the shared bit is needed.
+		 */
+		fault.gfn = gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);
+		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
+	}
+
+	/*
+	 * With retpoline being active an indirect call is rather expensive,
+	 * so do a direct call in the most common case.
+	 */
+	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && fault.is_tdp)
+		r = kvm_tdp_page_fault(vcpu, &fault);
+	else
+		r = vcpu->arch.mmu->page_fault(vcpu, &fault);
+
+	/*
+	 * Not sure what's happening, but punt to userspace and hope that
+	 * they can fix it by changing memory to shared, or they can
+	 * provide a better error.
+	 */
+	if (r == RET_PF_EMULATE && fault.is_private) {
+		pr_warn_ratelimited("kvm: unexpected emulation request on private memory\n");
+		kvm_mmu_prepare_memory_fault_exit(vcpu, &fault);
+		return -EFAULT;
+	}
+
+	if (fault.write_fault_to_shadow_pgtable && emulation_type)
+		*emulation_type |= EMULTYPE_WRITE_PF_TO_SP;
+	if (level)
+		*level = fault.goal_level;
+
+	return r;
+}
+
+
 static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
 				 u64 error_code, u8 *level)
 {
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 73cdcbccc89e..c29002c60126 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -290,8 +290,6 @@ struct kvm_page_fault {
 	bool write_fault_to_shadow_pgtable;
 };
 
-int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
-
 /*
  * Return values of handle_mmio_page_fault(), mmu.page_fault(), fast_page_fault(),
  * and of course kvm_mmu_do_page_fault().
@@ -337,70 +335,6 @@ static inline void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 				      fault->is_private);
 }
 
-static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-					u64 err, bool prefetch,
-					int *emulation_type, u8 *level)
-{
-	struct kvm_page_fault fault = {
-		.addr = cr2_or_gpa,
-		.error_code = err,
-		.exec = err & PFERR_FETCH_MASK,
-		.write = err & PFERR_WRITE_MASK,
-		.present = err & PFERR_PRESENT_MASK,
-		.rsvd = err & PFERR_RSVD_MASK,
-		.user = err & PFERR_USER_MASK,
-		.prefetch = prefetch,
-		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
-		.nx_huge_page_workaround_enabled =
-			is_nx_huge_page_enabled(vcpu->kvm),
-
-		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
-		.req_level = PG_LEVEL_4K,
-		.goal_level = PG_LEVEL_4K,
-		.is_private = err & PFERR_PRIVATE_ACCESS,
-
-		.pfn = KVM_PFN_ERR_FAULT,
-	};
-	int r;
-
-	if (vcpu->arch.mmu->root_role.direct) {
-		/*
-		 * Things like memslots don't understand the concept of a shared
-		 * bit. Strip it so that the GFN can be used like normal, and the
-		 * fault.addr can be used when the shared bit is needed.
-		 */
-		fault.gfn = gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);
-		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
-	}
-
-	/*
-	 * With retpoline being active an indirect call is rather expensive,
-	 * so do a direct call in the most common case.
-	 */
-	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && fault.is_tdp)
-		r = kvm_tdp_page_fault(vcpu, &fault);
-	else
-		r = vcpu->arch.mmu->page_fault(vcpu, &fault);
-
-	/*
-	 * Not sure what's happening, but punt to userspace and hope that
-	 * they can fix it by changing memory to shared, or they can
-	 * provide a better error.
-	 */
-	if (r == RET_PF_EMULATE && fault.is_private) {
-		pr_warn_ratelimited("kvm: unexpected emulation request on private memory\n");
-		kvm_mmu_prepare_memory_fault_exit(vcpu, &fault);
-		return -EFAULT;
-	}
-
-	if (fault.write_fault_to_shadow_pgtable && emulation_type)
-		*emulation_type |= EMULTYPE_WRITE_PF_TO_SP;
-	if (level)
-		*level = fault.goal_level;
-
-	return r;
-}
-
 int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
 			      const struct kvm_memory_slot *slot, gfn_t gfn);
 void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
-- 
2.54.0.1136.gdb2ca164c4-goog

