Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109E43745A
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630213; cv=none; b=cEOauNbuSyAS2r3ew9KaYbNNXz+votOtPJKt+iU8hjEwLl3DR+0y+cNKY7M3jGW9B/mePUk5YSYY6oGbk/MPbmG+enVqFDuL/s8NeyBTmue21oGpqLCr9r7hYqMAH1/XNF9cfAbxOtshxKUyvmabBCtD7KXrPR20Rclx7fFpAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630213; c=relaxed/simple;
	bh=WWJRjDbDovVc4Mk/3iPQAF3E4yN+0LXexeDe7koAUPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZCvmbtnPwnzjUv3CbEH9x1tPsexMSQqIG5Y44jeLwoeDp+7KnT5Sxmblvfy46v3A6vgdhw67o1XsCmUnAi7/woFD4m+ZdK75L8h5BQS9Y6hp/rk8SqOkPcmIbHne296M3WyELqyhLuTXasR64Z8J5lSqbdka/m2FsziQGU0hQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPORVj3o; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPORVj3o"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc640dfde3so2630085ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630211; x=1784235011; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e4IXSdz9GBUc0vGIfVbsjvotd00iPerdMoERS/gjnjQ=;
        b=XPORVj3oyeVQQbGUxhCfXL3iob0l8aLdv2gV9XCmmJifza8IfgJqTuIVy59wcAxNTC
         MH9gca8viAxiX4tCASWJDegwcALHEsKRmnslkfIqdhtYIR9GbXcQOH+qdUGtI72HWqoA
         M5bxFQ0oon8u48lSZCSDrD5Qrwg+peGxkJoU4lqvw+xFOIL0Lvw74f471oEt9wcmM67m
         3E9hvo1TrlMCcK9+lh6F9QJdm3i2g8xqpipOFaluS9J0coxn/5hv1ypQEa0LeF84pmIA
         4TDmlEkmx9cdm+8d0/z/iQmnm0g/g8U6XhpjfsyDfXNF3yYm+E+Wr6mOxVGultYV6I9f
         ZtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630211; x=1784235011;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e4IXSdz9GBUc0vGIfVbsjvotd00iPerdMoERS/gjnjQ=;
        b=oozsFOjlw5Bs+JzW2cXVw0dPBgLN/Fmg7vgAh1BDU712ia9KRzwwOeR/SOW6H/QBPx
         2PuyUGlYbSACj+m1zbxkcP/KqXdat86rNFRF346dIXQxIy2/2HdJv8tErHBmhTrq7kzW
         eytcnnJBvhUOiylh0JnmLyLJRPKw9RI4JtTsPC8Qu4QYL4Ua3cBduOSq4EMeDpOLU8pU
         wNAv/JuZ9Itiz1o+w7Wo/7XSheob/YFsAu2IoBVugSi1KYkeVY3FzvjPTNiIMVQo/kKU
         Mm4O6K6gcDnGbUUiKGhgjt36/mvP7VS5LZ2yZ7qeN4gyicTGFtt2+gmbMBRmBK5de0+i
         V5Cg==
X-Gm-Message-State: AOJu0YzulcQwcfNHZkMy9rjY1oguHUjgTLU7gY6DuKHUSwyp7CyThUrc
	3EBWd5CtA4fJ/CbLAqKAjhLZkDaL0lXhtc2ZxSHQ+BjEmCVfcs3lrVqhpv6UhTaMT01Lw7POBv/
	tN2uxPA==
X-Received: from pltj2.prod.google.com ([2002:a17:902:76c2:b0:2ca:e496:5f17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf09:b0:2cb:2b53:559f
 with SMTP id d9443c01a7336-2ccea479f4cmr91787795ad.35.1783630210543; Thu, 09
 Jul 2026 13:50:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:48 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-19-seanjc@google.com>
Subject: [PATCH v4 18/18] KVM: guest_memfd: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Smush guest_memfd's prepare() and invalidate() hooks into a common
convert() flow, as they are effectively two sides of the same coin: they're
invoked when private/shared memory is about to made accessible visible to
the guest/host.  I.e. prepare() is really "make private", and invalidate()
is really "make shared".

Using a single API fixes the wart where invalidate() isn't actually doing
invalidation, avoids adding yet another gmem Kconfig, avoids having to come
up with a name to describe the "make shared" behavior, and will yield more
intuitive code when in-place conversion comes along.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  5 ++---
 arch/x86/include/asm/kvm_host.h    |  7 +++----
 arch/x86/kvm/Kconfig               |  2 +-
 arch/x86/kvm/svm/sev.c             | 21 ++++++++++++++++++---
 arch/x86/kvm/svm/svm.c             |  3 +--
 arch/x86/kvm/svm/svm.h             |  5 ++---
 arch/x86/kvm/x86.c                 | 15 ++++-----------
 include/linux/kvm_host.h           |  7 +++----
 virt/kvm/Kconfig                   |  2 +-
 virt/kvm/guest_memfd.c             | 25 ++++++++++++-------------
 10 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 736129db272a..6091987860bd 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -146,10 +146,9 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+KVM_X86_OP_OPTIONAL_RET0(gmem_convert)
 #endif
-KVM_X86_OP_OPTIONAL(gmem_invalidate)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
 #endif
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3e34435f7e4e..3b4311048926 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1903,11 +1903,10 @@ struct kvm_x86_ops {
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-	int (*gmem_prepare)(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
-			    kvm_pfn_t nr_pages, int max_order);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+	int (*gmem_convert)(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+			    kvm_pfn_t nr_pages, int max_order, bool to_private);
 #endif
-	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db..52e75d83a4d2 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -160,7 +160,7 @@ config KVM_AMD_SEV
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
 	select KVM_GENERIC_MEMORY_ATTRIBUTES
-	select HAVE_KVM_ARCH_GMEM_PREPARE
+	select HAVE_KVM_ARCH_GMEM_CONVERT
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3e7792afbab4..b7f0d688f699 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5112,8 +5112,8 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
 	return false;
 }
 
-int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
-		     kvm_pfn_t nr_pages, int max_order)
+static int sev_gmem_make_private(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+				 kvm_pfn_t nr_pages, int max_order)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	gfn_t gfn = gpa_to_gfn(gpa);
@@ -5164,8 +5164,9 @@ int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
 	return 0;
 }
 
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+static void sev_gmem_make_shared(kvm_pfn_t start, kvm_pfn_t nr_pages)
 {
+	kvm_pfn_t end = start + nr_pages;
 	kvm_pfn_t pfn;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
@@ -5227,6 +5228,20 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 	}
 }
 
+int sev_gmem_convert(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+		     kvm_pfn_t nr_pages, int order, bool to_private)
+{
+	if (to_private) {
+		if (WARN_ON_ONCE(!kvm || gpa == INVALID_GPA))
+			return -EIO;
+
+		return sev_gmem_make_private(kvm, gpa, pfn, nr_pages, order);
+	}
+
+	sev_gmem_make_shared(pfn, nr_pages);
+	return 0;
+}
+
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	struct kvm_vcpu *vcpu;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dd51df74c2dc..f462ac9bbc93 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5450,8 +5450,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
 
-	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_convert = sev_gmem_convert,
 	.gmem_invalidate_range = sev_gmem_invalidate_range,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 #endif
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 45a9e2d5417c..aa12e6a80e83 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,9 +1009,8 @@ int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
-int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
-		     kvm_pfn_t nr_pages, int max_order);
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+int sev_gmem_convert(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+		     kvm_pfn_t nr_pages, int max_order, bool to_private);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a167f42bb1af..f51303ff3a1e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10589,18 +10589,11 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return !kvm_arch_has_private_mem(kvm);
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
-			  kvm_pfn_t nr_pages, int max_order)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+int kvm_arch_gmem_convert(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+			  kvm_pfn_t nr_pages, int max_order, bool to_private)
 {
-	return kvm_x86_call(gmem_prepare)(kvm, gpa, pfn, nr_pages, max_order);
-}
-#endif
-
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
-{
-	kvm_x86_call(gmem_invalidate)(start, end);
+	return kvm_x86_call(gmem_convert)(kvm, gpa, pfn, nr_pages, max_order, to_private);
 }
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 469c22b551ee..eb5a3349381c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2572,9 +2572,9 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
-			  kvm_pfn_t nr_pages, int max_order);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+int kvm_arch_gmem_convert(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+			  kvm_pfn_t nr_pages, int max_order, bool to_private);
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
@@ -2608,7 +2608,6 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 794976b88c6f..53803c5777a4 100644
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
index 4082cde3f3fc..d780ea0494d2 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -66,10 +66,10 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
  * On successful return the guest sees a zero page so as to avoid
  * leaking host data and the up-to-date flag is set.
  */
-static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
-				  gfn_t gfn, struct folio *folio)
+static int kvm_gmem_make_private(struct kvm *kvm, struct kvm_memory_slot *slot,
+				 gfn_t gfn, struct folio *folio)
 {
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 	unsigned long nr_pages = folio_nr_pages(folio);
 	pgoff_t index;
 
@@ -90,9 +90,9 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	gfn = ALIGN_DOWN(gfn, nr_pages);
 	index = kvm_gmem_get_index(slot, gfn);
 
-	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn),
+	return kvm_arch_gmem_convert(kvm, gfn_to_gpa(gfn),
 				     folio_file_pfn(folio, index), nr_pages,
-				     folio_order(folio));
+				     folio_order(folio), true);
 #else
 	return 0;
 #endif
@@ -517,14 +517,13 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 static void kvm_gmem_free_folio(struct folio *folio)
 {
-	struct page *page = folio_page(folio, 0);
-	kvm_pfn_t pfn = page_to_pfn(page);
-	int order = folio_order(folio);
-
-	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
+	WARN_ON_ONCE(kvm_arch_gmem_convert(NULL, INVALID_GPA,
+					   folio_file_pfn(folio, 0),
+					   folio_nr_pages(folio),
+					   folio_order(folio), false));
 }
 #endif
 
@@ -532,7 +531,7 @@ static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 	.free_folio = kvm_gmem_free_folio,
 #endif
 };
@@ -802,7 +801,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		folio_mark_uptodate(folio);
 	}
 
-	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
+	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
 
 	folio_unlock(folio);
 
-- 
2.55.0.795.g602f6c329a-goog

