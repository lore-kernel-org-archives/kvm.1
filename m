Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6F4219FF
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093412; cv=none; b=jwSGBXHfoqemTEAB2q6n2oWdURzpsJQCv2JpqDvudbRR0MEACD3Q/5q5aND+MStroO0nqHy1Hzyu4sn/YowXoZwZMx64KiYROYRmO1Y42qTRtTa1cbmeuZZGSrMj5g9y3/x3IjlqIPNDp5vgNXaBHEnB7T9adhuiWZIFQCC6VaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093412; c=relaxed/simple;
	bh=3ZYHUkj+oeXdrJoTlTtZXI4J3QdrnBWue6cHmIfCYIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X2PggCa3USS8kf7W3WlKeSPCYc3eq8Cq2QXd+7M+8slguPyw/vlTnKZTQR8VDK8FUjwrMhyzNwuqHyBXOZqukrJlpTl/CY3MF+AOQt80nlMEOJ8QKLVKs38FZ8s3BEEGtaApekT3F0/A3IrWgB1yIEDcl6jDMnkLGqKWw7cBvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7aiZImd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7aiZImd"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso3445429a91.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093410; x=1780698210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MH2p3W+wH0SgE7RS7gaDUYjHN6A3fmfpRXwInongdJ8=;
        b=S7aiZImdreHym8ZOuL/bM5HVkDWygCQzKsYCBAkhTXjqIkn/ddepRqcBjNZrJkEdnR
         yVnoXLmmRZw4Pq4lJkh/4dj1Jt+SHA/A1TyuyChNvgzit5GmBR98h7xosIBYIL7k8qnH
         NDWJf3UFuiHz8NlvwvlSIubPJuDVpXVk3gEHasTskpEN430nf8gT0AVosFnyh8LHZnP9
         BMOnJ94R26dJ+gie/O2WSkxRmo0LD+gRYZuHKthN5sAoTrZO9ZxWR11OOl5OeJSUU8As
         4suOMrLQpNIO0j6KDDpFn525wAzhxY+rsiwoqunXcQYxt5E3CeebYrXWgvW0mH52Zxbf
         3/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093410; x=1780698210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MH2p3W+wH0SgE7RS7gaDUYjHN6A3fmfpRXwInongdJ8=;
        b=rwKiZ7Bv+YWLZZCxYij3lT2bN6amNvfHZ346veTIvHG+m0E9ugzbFvgYeuQvaUkhUa
         QsZWnb6epNNMJKGSgnfX3G3wI2UbYCwNf4zrpzB+pLclTfDBTFCMs605J6mNp6p5xAJf
         hXCKNzNrLnuYWYHq6N5/qT8mAaWfHkBFIahFXy0/ht2nbQmr/IwAHcoQjq/qTBB02vgU
         jRbTz/BGiKrD8yVwlv8wmg5H187CQs8E4i0gNQ5tdD6/7yGluIMMlX9i9pyXmZXMA8xa
         JREIvGx9RQc33FLZQ4MIQijtqCJkT52oMmSuC6OWDlcxOTXS70ghBgKX9rl87y+tvIki
         aO/w==
X-Gm-Message-State: AOJu0YxK/VHrzPnFoy+HoMxeBQqlHkW4zqyQlZ1bLXwog0kPGvp7tOww
	+NG43ir1enwpFWk8gVdnz9SlZV4AHZ5oe7snOrXMSrpXjtyk1yJmggjESflaIUB7vdLZGRNoepM
	pfLS2dQ==
X-Received: from pgnp18.prod.google.com ([2002:a63:7f52:0:b0:c85:a9c:435f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d4d:b0:36b:a2cc:485b
 with SMTP id 98e67ed59e1d1-36c501f4cd3mr977167a91.21.1780093409985; Fri, 29
 May 2026 15:23:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:22 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-40-seanjc@google.com>
Subject: [PATCH v3 39/40] KVM: x86/mmu: Move kvm_mmu_do_page_fault() from
 mmu_internal.h => mmu.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move kvm_mmu_do_page_fault() into mmu.c, as there are no users outside of
mmu.c, and the function typically isn't inlined by the compiler anyways.
This will allow moving the EMULTYPE_xxx definitions into x86.h without
having to include x86.h in mmu_internal.h, i.e. will help preserve the
goal of making x86.h KVM x86's "top-level" include.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 67 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/mmu/mmu_internal.h | 66 --------------------------------
 2 files changed, 66 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f217e71c3af0..2796230ec398 100644
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
2.54.0.823.g6e5bcc1fc9-goog

