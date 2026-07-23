Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC03F3282
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840901; cv=none; b=mdtHzksXIBTFmADL0KQr9xZwvYAAzzEYN4CkBDdsK9C4oPRxMaQ0AvzccSdmprIlUklG/REYD5oKt/2UqCvFZS30KiNlVPaIaVmY2ya+tKwk3Skmu5brw6JRC/A62xY9POR+v50dzlU2hl/IpL+e+0RjDXXfcSavCv1gAuP6HHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840901; c=relaxed/simple;
	bh=G//MEJCqsmjh7Rp6WQ8wb0efVl8+cMi6HZp1dDFLbwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxXbsQnXPBInB1MhhCm1geHXZBTyhTjNiikFngQhQ2lq8BQbQ2RX/GNhy0S4f9iF7loauXEwxhp3OG8PnLjibTTdbrZEsKgiQsHa5OWEG1Jl0fl4XDpDb/rFqgFrUrOOLlKYdEpzCE84qtc1NdTq8reVMR02sNzBmJTSLprNG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hi1PUmCQ; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hi1PUmCQ"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso794544a12.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840893; x=1785445693; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VZYYFhSomkX55F7ie02z2KuczZjPonoKIc0palUsjIM=;
        b=Hi1PUmCQM/39FmLNafJlLqC2x6ugFDZq8DBbc/I6k69a9EV9cGV73JJqvcU1cOtw+T
         kRWU/f0MgoAr4E4fd5MHYfZ++0ZzFEvRmLUr8dE2XOe0YRegWJBxY73yahyuA0DSb6/f
         r/n0qfR5WqVQQJVCICYF1Afr6yNIXe3oeqHkBzWXaB2EBooDvZW0K8sKocF/o11dNDz1
         31yXF1TpWOaDl/SpxjwZkG4uqA44E1btSUv+aaZsKwZRevcdqbEIwxIKxvPsmnjXyLuX
         U3+r6GNYocXzlns3Q7vO0RdH5vhDGa0CtiPZJKGJX97kYpCIP2pP0G+hrJaHIY6OtI5M
         hy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840893; x=1785445693;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VZYYFhSomkX55F7ie02z2KuczZjPonoKIc0palUsjIM=;
        b=lerxZtcY9dIReoj6kS/zLhBQ7A8YZGifcG27LWOCvSOPzxepDtWSU4YLiHWaBSUOss
         RDyXjzp/LGW81hZBpD8XscznAxr/t/6ceWF/VDyYo5pZSAcQtj8VFd8l8udSp272Svrh
         rz0JFMl+0wbqzSZeen3ID+g7KmsvmJJfhy7XaRlEjjnEPrA3G7EL9jH2zqeQn4GDvsUV
         ZJh31y9MVxFzRLKP8O4kYfdmjVxL0jUIzaLYQ+UkgCyHkLIQEk/TVnRKEDRuvFithtZj
         ropnRT9b9AJKCmbZveAMcG99YJ1aCzfRZkj8nK94Ra3euZbjHkOL1S8cxt0uI27+7WNK
         848g==
X-Gm-Message-State: AOJu0YwzZfyDttu2f1ejC1MH/r8U3xqW2JFv4kqlkNmTb7UKYDiyagqC
	Qte/QB5PIWz98zNbQD002KUI7wdrX/01sE43UQE9b4JpKpL80LGBuvGGW38SnJavw8zx5+jynk1
	mhhWqqA==
X-Received: from pjbgq9.prod.google.com ([2002:a17:90b:1049:b0:38f:6c:9fd9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c4:b0:381:25ce:bcc2
 with SMTP id 98e67ed59e1d1-38ec6401dd8mr4703624a91.6.1784840893393; Thu, 23
 Jul 2026 14:08:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:03 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-2-seanjc@google.com>
Subject: [PATCH v6 1/9] KVM: guest_memfd: Pass the number of pages instead of
 the end pfn into .invalidate()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Pass the number of pages to "invalidate", i.e. reclaim, instead of the end
pfn, as a first step towards aligning the function prototypes between the
de facto "to private" and "to shared" arch hooks.  Eventually, the goal
is to end up with kvm_gmem_arch_make_{private,shared}(), and in both cases,
providing the number of pages makes the call sites slightly nicer, and also
avoids any confusion over whether the end pfn is inclusive or exclusive.

Opportunistically rename "start" to "pfn", again to align with the expected
signature of make_private() (which needs to pass a starting gfn as well, at
which point the "start" becomes noise).

No functional change intended.

Cc: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/svm/sev.c          | 8 ++++----
 arch/x86/kvm/svm/svm.h          | 2 +-
 arch/x86/kvm/x86.c              | 4 ++--
 include/linux/kvm_host.h        | 2 +-
 virt/kvm/guest_memfd.c          | 6 +-----
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 58f156ae31e7..8c96999f49a0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1727,7 +1727,7 @@ struct kvm_x86_ops {
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
 #endif
-	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
+	void (*gmem_invalidate)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 82b983484af2..e6987351dc04 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5161,16 +5161,16 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 	return 0;
 }
 
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
 {
-	kvm_pfn_t pfn;
+	kvm_pfn_t end = pfn + nr_pages;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return;
 
-	pr_debug("%s: PFN start 0x%llx PFN end 0x%llx\n", __func__, start, end);
+	pr_debug("%s: PFN start 0x%llx PFN end 0x%llx\n", __func__, pfn, end);
 
-	for (pfn = start; pfn < end;) {
+	while (pfn < end) {
 		bool use_2m_update = false;
 		int rc, rmp_level;
 		bool assigned;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index af25e4b56212..cf8fb3d6a100 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1010,7 +1010,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
 int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1f5dc685f049..65bcad3d0264 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10627,9 +10627,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
 {
-	kvm_x86_call(gmem_invalidate)(start, end);
+	kvm_x86_call(gmem_invalidate)(pfn, nr_pages);
 }
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9db6eb4023c4..911c3f08b3a2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2614,7 +2614,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 171a9da1b685..ca1d93fb2495 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -530,11 +530,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 static void kvm_gmem_free_folio(struct folio *folio)
 {
-	struct page *page = folio_page(folio, 0);
-	kvm_pfn_t pfn = page_to_pfn(page);
-	int order = folio_order(folio);
-
-	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
+	kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio));
 }
 #endif
 
-- 
2.55.0.229.g6434b31f56-goog

