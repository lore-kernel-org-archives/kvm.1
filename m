Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACD38654F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426160; cv=none; b=ecZo/c6ApTXOVMHVSOeWNW2W0M0TGvhkYGhXiiD3CXoPHWCbCxZLK4zi4VV5rDMh37ME9jI7UMsac8plpRxLSwAqAalAvC0uMD8ubHB2Y+WtpzJbs/wX3x2nW27Yah6fqDWGa+JiYVmEMwJ4cf8H3KThBnAUSIAdt6xDpOwuY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426160; c=relaxed/simple;
	bh=srv7vFiH046kGF3f3LQX0f60FTXO8wnoJ9H8KLUrjZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MFU6/rLQN4QvLTOcbOUnIJGSCgzju7iGIjbC79Ee8e4gS8vUBSrixR8luEX5vrEVvjYQvxkfPliHW61gjPkx3NhiyLSEwbKdbuvpYoITfln+Oi8pEhV5t7zyUFMt3N1k6ki1zt8dC/l6zWljE+YB+CnLyP7Gd8pS+Q255UxAvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnVqiqfO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnVqiqfO"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c891ed872ddso167054a12.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426157; x=1783030957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SiYg0gyFMIOMLK0hbaugxjbdZ5LjE3WVtjbzhR70NnU=;
        b=BnVqiqfOQMVFYWBR8RI1mhJEE4EETBbq889UOPIga3p9e5rsrR0Dcp03nApt1c9Oxp
         Apoy83Q+KQbKGwRi43OFrWbf5HMUr19Rkmuk9blhDSGeDt1zXCyeoTlgKBNNqK8TqliS
         RAuGRqE+ovnFTQQxH79J3c6OOHgYO2tRAhGXzTZ9rGkSGGTxZPRDRu4yI4G1aswKyK4M
         NLMBdrZ5Onk6rso49JR/vwyhwHhjRTZduyj9VKcyicVdEBT6yVbaz1c/wQ0IEA5sbnGt
         1VjSAp9gGjJQDdDntSJBOFw/L3JDvaDGEbUqIjwr8jTbV+QJmsEMyw3Qehhjum+ayIkM
         +mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426157; x=1783030957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiYg0gyFMIOMLK0hbaugxjbdZ5LjE3WVtjbzhR70NnU=;
        b=Si9u1KfVTA3DNaVDsHtvSRnoUE38pCFP7l+v/ayjs/8UmZxzqvV/kjj0NP8XtHkRWe
         arHv0JPi2svsLf3WYnKIpsboxpsyfDj5MKcWas3i400iC2UnzVQdIktB9AAPv/oWQjhE
         uSTWbNtufqEW7M368sIG3DTH/eDkq8r+9C49Xdh7SKIJevKzAsO73JywIb/zi3VgP58M
         pTCvXNj1nKMEbX4LlHpBCzHw7spvyNnBtHskYLCl5V6a4ll9ILbXW8x535CJlgfjhPuE
         KgO3aW2NSuRhTj71yIPyk+PtD0LBAijF/nShsQj0T7xcnPskGpA9G2DVOXKfARVDgXR5
         lSAg==
X-Gm-Message-State: AOJu0Yy1yt2HIf3KN9e6R/5ZFzNR4QyU5yQmiktUe7VKEpglI/Vz6T0n
	+1pY+tmW/6tDF9wrCUh5uKn9iiQ3XxPjbgVIyw2EIenKp/SItPWF3sU2/j22j+jO/sE82FlsJXH
	OfHm5rQ==
X-Received: from pgbdp9.prod.google.com ([2002:a05:6a02:f09:b0:c88:c1c9:47c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7116:b0:3b4:813d:dae
 with SMTP id adf61e73a8af0-3bd4ad2d7aemr5281927637.16.1782426156601; Thu, 25
 Jun 2026 15:22:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:22:26 -0700
In-Reply-To: <20260625222229.3367197-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625222229.3367197-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625222229.3367197-5-seanjc@google.com>
Subject: [PATCH 4/7] KVM: Rework .gmem_invalidate() into .gmem_free_folio()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>
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

Cc: stable@vger.kernel.org
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

