Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D03806CD
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782515667; cv=none; b=rA21w9l+jy4YbcTZwS2DYtkQ1cZoIbVLLFxVe5PtBt00emrwrwvJQuxcxVHw2KcjvUWMk2P+nycnSWEucgaqZrwgAeaoGVo65fzlEqpUWiMZRSgUIMtVmOQxnuDIKJXAp3iDHgxudCzAuih4QJhjNxWcHHrbFTCUIjAkHa3bBTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782515667; c=relaxed/simple;
	bh=sAc/bn8QwX6Z1dIQa0ktTwAsxTUk5vCaI6FUqQSPSRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AmQB3aVdBKW/0SEXOq6/+O42zXGa1Y4GzZ1NGBzEOMMUFC0znS24r8BK89GGqcjROqzgIyq5J/IN27RvCeHI4/+xD16V4RQDgYKGPEkBycZjj00BEAJtxjwk4J0LTPc/50FSh/5KUj0S0mBdB8hQenAWwM8Aro1TxQF8rkPB+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmqYR6Bt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmqYR6Bt"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37fb9d7b524so146423a91.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782515664; x=1783120464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/LCeSqgDwBXy6Gd5ib4w9MILItWS/FT6KwRzyU9NXwQ=;
        b=vmqYR6Bt7LPvH8mNNKFNIbXWTpPiqiki2YWhCEyJkwV4WVRub1+YBJmVGGtA1fSwG9
         1XKvQOXr4yCxJdgzsDQFaDS6LKVFNx2K/rd/TCcY6QSfGUanU8UHqfXyOC1FYidLeqNv
         Z6hXoqPZIsOfZLWMvrGWL/O7AdTbP9b0F+ypvoTMFlrkwT34ii5PfLE//USpqy2encWT
         wG67j/DTLHovPmYQ2ebLUUPrZ92mo61kGqXwpn1Om+QwziyqyjuHo5OqqaOdLudQByAd
         x6FrLsFGTxNf4Bi1cJJ/udxkDGHmF+viiVbQ6eFcRggA3+9OBwoG6qRHr6PIUEWIAMDZ
         ajKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782515664; x=1783120464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LCeSqgDwBXy6Gd5ib4w9MILItWS/FT6KwRzyU9NXwQ=;
        b=gbIiYsYbJMcMl2G2IKx8YpkzdTSCqb6z7sOse3LzZYRj25RFzN6J4Q0o+4Rvgn7LvI
         2Ebdn+LmI9ZDR72GfDPQ40Jg1p2jU1+QMyYaKzewj41ZTrhO2fYlVUbM4dupzTaUeeCt
         RFYf39r7qMuHwtIKCMZ/AW6cuXwq/icDBf34puBMiTcj6F/7AZAUjQoTJ4JQ3/kQ2VUY
         O6jMmpGX2Bzsm8uMw3kR8npeHCDCLxeHrCAl5Vlj/Xq7eyizI1syX50yCjopMgxRnLBs
         IgD6xR20aXLhVr3X788qEVttQoJYUebIcxYg2Z9qEspxuxTpYzYoZfOCEOkyKfcdAsEE
         IViA==
X-Gm-Message-State: AOJu0YyTd6V9qdte0uL76VZTttvryKsTBALYCA8PKy4Z0OyUFLHdNZC2
	ClKahY/G+dR0KqF1ZKf0U3fa97NFqq3pflxJHPgT0fH3uJQHZrXIrVdNHkXShyrmCsfGumXPEMr
	nq7a09g==
X-Received: from pjbbv24.prod.google.com ([2002:a17:90a:f198:b0:37c:5da3:8742])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acd:b0:36b:93f7:a903
 with SMTP id 98e67ed59e1d1-37dfa25a0d4mr8849038a91.18.1782515663690; Fri, 26
 Jun 2026 16:14:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 16:14:11 -0700
In-Reply-To: <20260626231416.3943216-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626231416.3943216-5-seanjc@google.com>
Subject: [PATCH v2 4/9] KVM: Rework .gmem_invalidate() into .gmem_free_folio()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename .gmem_invalidate() to .gmem_free_folio() as the hook is called when
a folio is freed, which is far too late and lack sufficient information for
KVM to actually invalidate its usage of the memory.  Drop guest_memfd's
trampoline and just wire up .free_folio() directly to the arch callback so
that the chain of events is clear and obvious.

Opportunistically guard kvm_x86_ops.gmem_free_folio with an ifdef to
ensure the callback will actually be called, e.g. so that non-SEV code
doesn't try to wire up a callback without enabling
CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE.

No functional change intended.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  4 +++-
 arch/x86/include/asm/kvm_host.h    |  4 +++-
 arch/x86/kvm/svm/sev.c             |  4 +++-
 arch/x86/kvm/svm/svm.c             |  4 +++-
 arch/x86/kvm/svm/svm.h             |  3 +--
 arch/x86/kvm/x86.c                 |  4 ++--
 include/linux/kvm_host.h           |  2 +-
 virt/kvm/guest_memfd.c             | 13 +------------
 8 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 83dc5086138b..e36eba952705 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -147,7 +147,9 @@ KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
-KVM_X86_OP_OPTIONAL(gmem_invalidate)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+KVM_X86_OP_OPTIONAL(gmem_free_folio)
+#endif
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..dd542c7a7376 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1901,7 +1901,9 @@ struct kvm_x86_ops {
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
-	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+	void (*gmem_free_folio)(struct folio *folio);
+#endif
 	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 };
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 30792adcfc8e..3d90aa723dc2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5136,8 +5136,10 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 	return 0;
 }
 
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void sev_gmem_free_folio(struct folio *folio)
 {
+	kvm_pfn_t start = page_to_pfn(folio_page(folio, 0));
+	kvm_pfn_t end = start + (1ul << folio_order(folio));
 	kvm_pfn_t pfn;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..6f1823e820a4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5460,9 +5460,11 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
 
+#ifdef CONFIG_KVM_AMD_SEV
 	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_free_folio = sev_gmem_free_folio,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
+#endif
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d077783c287e..2f8215810a08 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,7 +1009,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
 int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void sev_gmem_free_folio(struct folio *folio);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
@@ -1039,7 +1039,6 @@ static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, in
 {
 	return 0;
 }
-static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
 static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
 {
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..adc1e1b244c7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10592,9 +10592,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void kvm_arch_gmem_free_folio(struct folio *folio)
 {
-	kvm_x86_call(gmem_invalidate)(start, end);
+	kvm_x86_call(gmem_free_folio)(folio);
 }
 #endif
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..e5b47a5e4cea 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2607,7 +2607,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void kvm_arch_gmem_free_folio(struct folio *folio);
 #endif
 
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 86690683b2fe..1618acc3ca64 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -523,23 +523,12 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-static void kvm_gmem_free_folio(struct folio *folio)
-{
-	struct page *page = folio_page(folio, 0);
-	kvm_pfn_t pfn = page_to_pfn(page);
-	int order = folio_order(folio);
-
-	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
-}
-#endif
-
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-	.free_folio = kvm_gmem_free_folio,
+	.free_folio = kvm_arch_gmem_free_folio,
 #endif
 };
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

