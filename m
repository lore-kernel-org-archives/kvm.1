Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA643431E76
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070640; cv=none; b=nDmfUu/3J7s+WLBTTlufVuZpw26yLq//o6QMaUgEhyw9XiuArQXbr/kFwKl9Tw78l1yjIBDg6LbgyXEG8IijKmdFCdzpOTGK7SiEe+JOsX44lkVMxrnJo7QlUv8h31lgVvGxv4a3sq+rN340WjY/z1iLsgsD4KNkZnuzIvl08nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070640; c=relaxed/simple;
	bh=5BavKoMCQbuceEXAWAGaZ0PeXfjVBMYWYfqEIVIko9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ubxtTlzF8pQadz4CzeaD8yU52BS/DmFBOIqnveLy8YoUXLupMxe+OdvPRgvRHIB8c5oRS3QHY91FOjTOyu9/4hTODq2NNJm2blVy/loNTRBpHJ6WmDYvLFZCdsvpYPvk78VR4IkK/85F7JR6+1/YMtkb6TCaohGZsloiOQ3pNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9JKDnVQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9JKDnVQ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ca124bf0189so73692a12.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784070634; x=1784675434; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oeBsN3Sd3KvkDRZPV9BJqhIhlZVgRgMQPPG+mndlRJY=;
        b=L9JKDnVQm94p4wkHGvr/0E45fVHrq599FxrdUdcxJUx+GWnSgOJWspEBu3kipQ0Vt9
         w+wHtFR8tiyjDpPbzGt33SlYXfOhLArgw+w/N9d1/HnlM89YmQCY+nHB7Q4Ky4XL/O4p
         uRJ6kteidlpPjAnVEB7EGxIt0xhuBZbMncEqWcjGuJQYHguJyLaccWpl4fpRFImEssn3
         gOml2GzPBCKYCDGCsSBQ3Mi9EvhUJ1Lz9xE0tkKDtQmmMhnrAeoSMWs+x6bLixtCxKkA
         jxFkxoXHsTHW3ABTQaPmmdGNXn7EiKfdDZKVd4FnzYK16WKGrxOtI+OHndWZRHGA6qtn
         oqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070634; x=1784675434;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oeBsN3Sd3KvkDRZPV9BJqhIhlZVgRgMQPPG+mndlRJY=;
        b=VSKeyTe4UbMUbQhKlEhvuxg0zYTCXf9+ShAMwwrROfCe+rhQV3g/lMh0IOXoJ1PKfx
         FBODUXbs70tNvnQFX3lnequ0C2H8nGvRKzTNjrC3YJGTWWqUbLFy7T4iWhzce7MxLSVB
         8RvUx6Om68p6V7ir2TYMUVh1y3W0U2QszrC2tGDqVs2MQf9/n1RcuXC47tQG44kjoD3i
         w0yMvcmi3U9MAMkwqwa2KtJc1wHO6sNAxOt01mCgtDQ+cxNmGKg2/3GaGTn6EKk1eRAB
         lI493LszeCytqDEgsdOR0biWB7QIDYI0VekSvzSnRobVZVidCiThv2ipD/vqyurLgJ+e
         riuw==
X-Gm-Message-State: AOJu0YwKxpTAgbJPR4vjic3fImFdpJzDmHjqXdB3L2fKiUPq35xOUVCl
	swfD+E7jfTPgzv7YfFcptWJig8CxhZ8KcX3MykoSV57w1OMaFtMXv6HBfFmgQ5Mg+W/O6m7+YtP
	e24eSzA==
X-Received: from pjtl4.prod.google.com ([2002:a17:90a:c584:b0:37d:8595:7a08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a43:b0:385:3ab:fecb
 with SMTP id 98e67ed59e1d1-38dc8070474mr12486550a91.4.1784070633929; Tue, 14
 Jul 2026 16:10:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 16:10:15 -0700
In-Reply-To: <20260714231015.3337831-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714231015.3337831-8-seanjc@google.com>
Subject: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook into
 a more generic CONVERT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework guest_memfd's "prepare" hook into a more generic "convert" flow in
anticipation of supporting in-place conversion, at which point KVM will use
the hook for both to-private and to-shared conversions, not just to
"prepare" PRIVATE memory.

Opportunistically rename kvm_gmem_prepare_folio() to kvm_gmem_make_private()
to better reflect its role.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/kvm/Kconfig               |  2 +-
 arch/x86/kvm/x86.c                 |  8 ++++----
 include/linux/kvm_host.h           |  6 +++---
 virt/kvm/Kconfig                   |  2 +-
 virt/kvm/guest_memfd.c             | 12 ++++++------
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 76ce691de2f8..1764bad03b17 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -146,7 +146,7 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
-#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
 KVM_X86_OP_OPTIONAL_RET0(gmem_convert)
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f60fec14c61a..08c4af487fa1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1724,7 +1724,7 @@ struct kvm_x86_ops {
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
-#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
 	int (*gmem_convert)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 			    kvm_pfn_t nr_pages, int max_order, bool to_private);
 #endif
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e509d50c247c..11017f49b94a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10619,11 +10619,11 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return !kvm_arch_has_private_mem(kvm);
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
-			  kvm_pfn_t nr_pages, int max_order)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+int kvm_arch_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+			  kvm_pfn_t nr_pages, int max_order, bool to_private)
 {
-	return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, true);
+	return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, to_private);
 }
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0a06234a8a8b..fdbd697d0337 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2579,9 +2579,9 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
-			  kvm_pfn_t nr_pages, int max_order);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
+int kvm_arch_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+			  kvm_pfn_t nr_pages, int max_order, bool to_private);
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
index 0f6745f3b919..173a7ed008d1 100644
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
 
@@ -90,8 +90,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	gfn = ALIGN_DOWN(gfn, nr_pages);
 	index = kvm_gmem_get_index(slot, gfn);
 
-	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
-				     nr_pages, folio_order(folio));
+	return kvm_arch_gmem_convert(kvm, gfn, folio_file_pfn(folio, index),
+				     nr_pages, folio_order(folio), true);
 #else
 	return 0;
 #endif
@@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		folio_mark_uptodate(folio);
 	}
 
-	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
+	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
 
 	folio_unlock(folio);
 
-- 
2.55.0.141.g00534a21ce-goog

