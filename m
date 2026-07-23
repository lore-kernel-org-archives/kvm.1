Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204213F3267
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840908; cv=none; b=MhlKnmmCDrNGAnuBbGlK49FqXq6DA+0nLA60COsllD5RA5qe+8aBRk8/ahQaNw/4m5OgLUBTiVtk9hOoD0fi0SxnzNPK//+03ANE4cop/Hz935HrwUY3smpB4D5bcHU0WApzorx0X+gAQOkUdmX6rPS2gOooMTG+JPZ4t68HhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840908; c=relaxed/simple;
	bh=qxZmM6gRP0uUjzvY2OwBMDJUInPix9yGcRlGW2gS354=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DOOlBvBdStU0mwZQ7YLStR3WHrDFZZHetWwz/kVngXbQa7oi3nhZrxdNJrl5USiD6x1GJZ4/iXG73exUe7ouviyi0h9tqWDpeky60+s9dmR028LlFiTtDJD9i8jgz28Gbeytq4xTXQS4DTGVXGivquovi0Ss6oz7CqBFReXW4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhEXoErM; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhEXoErM"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848544a8496so1250714b3a.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840900; x=1785445700; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CezFMo6AjWdBbkGqWYOJc/NxdnAR8Xr0R3EVd5Fryfk=;
        b=FhEXoErM7u4z8mksmeU3bXchybkchyPwYngnXVdsnblqkvMeJTgZYbEGOEoBtdq3ic
         f6p14J0XFmrIO08qDvIGYYUpAbElcj9VQGwlGsL+KtIpAh3PaWelQpsCyORcyKDgWA/2
         HEgAqBEU4N/rI4HbfTE0zFPLCTpFQbkJ1Cg2j7HWm61DyqXU8RIueJpARtmUjcQKudVQ
         vQ4HndA/p4Jjpt5Ks0L3mY+Je/mhPjyrD4ItGXfd3lybIFZZswcL3aTMUTr8PbJDFRAu
         XjW1gmkquFx54xLVbMui1S0eiucauNKjldwAT/aXQ4pveaJY2umxRWvPtQOxjpAbFew+
         QO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840900; x=1785445700;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CezFMo6AjWdBbkGqWYOJc/NxdnAR8Xr0R3EVd5Fryfk=;
        b=PNMflTnE3nhZKg3Uzj1aOCCBpwgyPpFIo80d2ducnaLU36eCLRIW5jftRFjfUu2KI7
         ocvS4sX82hiOCtdQXNW3mwpGCX88l5bKrdyK0NM/y+TREGHWr1vTSqFw5W1gUSn3ua2P
         BkcC5d3pKNm8Z2ceOwYUgvnids62kYtVC0QpUiqXj9RAgBWyY8FlRp3zJ2RUD3fsoazO
         huHOrEkGAp7QQNlUBwkK1nVUlu0kaUfJ4uOcR7P3VepJScfl8WwfxFlHwxeKs87rItng
         cEX7j4W11ktLaQ15D2pSg5Wxr3z/QYVdQF7Z1ZtIBR/WM+YDWHGQTYrLi9PB8mYyo1j5
         v6dw==
X-Gm-Message-State: AOJu0Yws8hO/PtY9oScDL9ByBDmhVB1iNhX05zsd6yXpjoJh2OuG/m3k
	SzKubeKcmCo2v7F/6ywW88q/r/dRGggjxBdDSnJ5eaH+nIqsOJHYBpaPqNg8XbMRl/8E4b1YapD
	EjCgDEQ==
X-Received: from pgbbz30.prod.google.com ([2002:a05:6a02:61e:b0:c93:5d65:8f45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c89:b0:848:86d6:298b
 with SMTP id d2e1a72fcca58-84e2b8d1207mr4895125b3a.29.1784840900107; Thu, 23
 Jul 2026 14:08:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:09 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-8-seanjc@google.com>
Subject: [PATCH v6 7/9] KVM: guest_memfd: Rename prepare() hook and Kconfig to
 make_private() / CONVERT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework guest_memfd's prepare() hook into a more accurate make_private(),
and rework its Kconfig from PREPARE to a more generic CONVERT.  This will
allow x86 to share (pun intended) a kvm_x86_ops.gmem_make_shared() hook
between the "convert to shared" and "reclaim" flows, which are one and the
same for SNP.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 4 ++--
 arch/x86/include/asm/kvm_host.h    | 4 ++--
 arch/x86/kvm/Kconfig               | 2 +-
 arch/x86/kvm/svm/sev.c             | 2 +-
 arch/x86/kvm/svm/svm.c             | 2 +-
 arch/x86/kvm/svm/svm.h             | 2 +-
 arch/x86/kvm/x86.c                 | 6 +++---
 include/linux/kvm_host.h           | 5 +++--
 virt/kvm/Kconfig                   | 2 +-
 virt/kvm/guest_memfd.c             | 4 ++--
 10 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 210cb95d0a0b..a4d872ddef9d 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -146,8 +146,8 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+KVM_X86_OP_OPTIONAL_RET0(gmem_make_private)
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 KVM_X86_OP_OPTIONAL(gmem_make_shared)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4dc8a03c829a..4be57157136b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1724,8 +1724,8 @@ struct kvm_x86_ops {
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+	int (*gmem_make_private)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 	void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index e0e7ad015839..538ed1e80332 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -160,7 +160,7 @@ config KVM_AMD_SEV
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
 	select KVM_GENERIC_MEMORY_ATTRIBUTES
-	select HAVE_KVM_ARCH_GMEM_PREPARE
+	select HAVE_KVM_ARCH_GMEM_CONVERT
 	select HAVE_KVM_ARCH_GMEM_RECLAIM
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4aa8330d5b2d..0ecba768c153 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5114,7 +5114,7 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
 	return false;
 }
 
-int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
+int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	kvm_pfn_t pfn_aligned;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b8c9967dd0de..d5a08f1db84b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5438,7 +5438,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
 
-	.gmem_prepare = sev_gmem_prepare,
+	.gmem_make_private = sev_gmem_make_private,
 	.gmem_make_shared = sev_gmem_make_shared,
 	.gmem_invalidate_range = sev_gmem_invalidate_range,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index b2acb5ab7c26..ad849edcacc7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,7 +1009,7 @@ int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
-int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
 void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 249267ed2a9d..e7865b28d37b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10619,10 +10619,10 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return !kvm_arch_has_private_mem(kvm);
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
 {
-	return kvm_x86_call(gmem_prepare)(kvm, pfn, gfn, max_order);
+	return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
 }
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0b5b9cb022ba..9cf01429281b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2579,8 +2579,9 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+			       int max_order);
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 617876993225..c3c0ee253fc7 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -107,7 +107,7 @@ config KVM_GUEST_MEMFD
        select XARRAY_MULTI
        bool
 
-config HAVE_KVM_ARCH_GMEM_PREPARE
+config HAVE_KVM_ARCH_GMEM_CONVERT
        bool
        depends on KVM_GUEST_MEMFD
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f64cd87ec8b0..466f611ad4b7 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -73,11 +73,11 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
 static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				    pgoff_t index, struct folio *folio)
 {
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 	kvm_pfn_t pfn = folio_file_pfn(folio, index);
 	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
 
-	return kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
+	return kvm_arch_gmem_make_private(kvm, gfn, pfn, folio_order(folio));
 #else
 	return 0;
 #endif
-- 
2.55.0.229.g6434b31f56-goog

