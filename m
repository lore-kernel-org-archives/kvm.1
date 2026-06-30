Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AD330305
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858377; cv=none; b=j4UcbpoRYYJnL6/AVwYhMrsPXb7eRrYB58PrNQO1idxtEXVph0LW9FVNQ45kTEleRhYLWJOLic0l7rK6LDbI39JEjEVSfv4vJyiymvSgB+NZSGMQWMpmUBjIbPZXcB8+JSEvMjPfgX2i8VrZCW/uMupTUlUY1TSXzeAOdiEr3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858377; c=relaxed/simple;
	bh=bYSYglutk7WzJK1Yg3UwtS9Rp+ZdbMM40xUyebxGg2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vs9UtzcFzemJLbEqlH/eadFTwOVt1qP3D8zv0wj580cKoCM6LLBsOa8a9EBDwJu5FYNLhapgZumqQ3oBviYoNFgrDKyUqck4fLzbMbtlmGbaYV5MmcX4xcvRuhuz0Ul3aMwvfwh2s/4CTYAZ1idJuJ1e8fflnwHc+qTukJC9tNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V832BY8i; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V832BY8i"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c804e38cb1so335255ad.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858373; x=1783463173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=abPQgznniE40OQygz3m+aNbp6o3yFWHavZfRYfyBL8M=;
        b=V832BY8i1L7xkmAlyEFxewyHZ+nTHF/AKbqk8CRPdlmPGAErQ9RyypAbTIXn/7QsA3
         E+AIdFTnJh/Iz716XwTA0iRjNBRuNUzaAy0/dSBFBWOkwozkWwpzWy+JwB5jLLSPiZW5
         CGOtfu2bje33Lm0IuSIAT70liIFSY2Hg6EctQSwm/0TfHmDuAuvbOj5FaT8HIlCcKc/G
         v4vdDVb5Rlf7g9g6mePEqEyHiiaAiB6AQe4kziaYfb1/mRW4CC1yR+LalgfsZOTpuij5
         6Xkn53PBsbkarBD1oOqfsJuNt7qnoh454mSMiU9b0whS0pJCayZ1LzsCD7yL8rqLgGaC
         hVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858373; x=1783463173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abPQgznniE40OQygz3m+aNbp6o3yFWHavZfRYfyBL8M=;
        b=j89ezDOOtG/wgkgpFod44nTEOemKIxo4w4vQ1Ah3ZH6CMfGeLa8mp3IfYXY0NdSk2y
         Qk+bP0tqnjSXM07YiGlJg938FM8WtFXawyiCog8oxOboEy42w4nljlBetMdUkLwOcNI5
         M4Op5TNgwuf7wNOLaNbzL0WjAX3tcavrDUuXuuWaAAbF1tbLe056MAx9tnq1IwrCsWWi
         Pom/wcHDVEjj1DbPuC1dkk+hkDTqrWxwurJKZb2OG1EBisbaQ4OTiORvX5lf0sD2ZlP+
         Yd/fZW5j670wkrycuiTEhd6Rbkkarn3Fn/RldJY2o9ID6Nr68WkTvJGxin08InhFiyHp
         wO4g==
X-Gm-Message-State: AOJu0YzN+rRAzNx4cMSvsL0PUm99j+DbTrnOlxkLMis+oXLMBU5ZQJu6
	aIvcfHMps3veLp0ofEsnlNbN3E1wK9/9titZbupMSs0weRbpxqgOycm1IQ95IZhruZfqVzO3jY6
	9JWxcfg==
X-Received: from plbma16.prod.google.com ([2002:a17:903:950:b0:2c7:a802:500b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc87:b0:2ca:b8d:e65f
 with SMTP id d9443c01a7336-2ca5a52faedmr22753865ad.1.1782858373216; Tue, 30
 Jun 2026 15:26:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:25:59 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-5-seanjc@google.com>
Subject: [PATCH v3 04/12] KVM: Rename .gmem_invalidate() to .gmem_reclaim_memory()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename .gmem_invalidate() to .gmem_reclaim_memory() as the hook is called
when a folio is freed, which is far too late and lacks sufficient
information for KVM to actually invalidate its usage of the memory.

Keep guest_memfd's trampoline, even though it would be trivial to wire up
.free_folio() directly to an arch callback, to avoid bleeding guest_memfd
internals into arch code (specifically, avoid referencing folios in arch
code).

Opportunistically guard kvm_x86_ops.gmem_reclaim_memory() with an ifdef to
ensure the callback will actually be called, e.g. so that non-SEV code
doesn't try to wire up a callback without enabling
CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE.

No functional change intended.

Cc: Ackerley Tng <ackerleytng@google.com>
Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
 arch/x86/include/asm/kvm_host.h    | 4 +++-
 arch/x86/kvm/svm/sev.c             | 2 +-
 arch/x86/kvm/svm/svm.c             | 4 +++-
 arch/x86/kvm/svm/svm.h             | 3 +--
 arch/x86/kvm/x86.c                 | 4 ++--
 include/linux/kvm_host.h           | 2 +-
 virt/kvm/guest_memfd.c             | 2 +-
 8 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 83dc5086138b..acae9f6d6c5e 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -147,7 +147,9 @@ KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
-KVM_X86_OP_OPTIONAL(gmem_invalidate)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+KVM_X86_OP_OPTIONAL(gmem_reclaim_memory)
+#endif
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b517257a6315..5e8603deb252 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1901,7 +1901,9 @@ struct kvm_x86_ops {
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
-	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+	void (*gmem_reclaim_memory)(kvm_pfn_t start, kvm_pfn_t end);
+#endif
 	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 };
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 30792adcfc8e..4465e75494f2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5136,7 +5136,7 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 	return 0;
 }
 
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void sev_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end)
 {
 	kvm_pfn_t pfn;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..6be0000ab386 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5460,9 +5460,11 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
 
+#ifdef CONFIG_KVM_AMD_SEV
 	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_reclaim_memory = sev_gmem_reclaim_memory,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
+#endif
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d077783c287e..cf7c1a437f38 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,7 +1009,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
 int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void sev_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end);
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
index 0626e835e9eb..6b9a1b0b1460 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10592,9 +10592,9 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void kvm_arch_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end)
 {
-	kvm_x86_call(gmem_invalidate)(start, end);
+	kvm_x86_call(gmem_reclaim_memory)(start, end);
 }
 #endif
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..d777eaadbcd2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2607,7 +2607,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void kvm_arch_gmem_reclaim_memory(kvm_pfn_t start, kvm_pfn_t end);
 #endif
 
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 86690683b2fe..db0fcc38b145 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -530,7 +530,7 @@ static void kvm_gmem_free_folio(struct folio *folio)
 	kvm_pfn_t pfn = page_to_pfn(page);
 	int order = folio_order(folio);
 
-	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
+	kvm_arch_gmem_reclaim_memory(pfn, pfn + (1ul << order));
 }
 #endif
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

