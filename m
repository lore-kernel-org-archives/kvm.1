Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F83F20E8
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840905; cv=none; b=iN2eWLBquocOo7p7Sx/M0zJgkuJfbljDKv8TdzVxrobJzpQk8smIA8Sn4Y2EyGb1Msk0tZEu45qroXLMLTZR6HeI/NfjAYj35Ooy7uj7RNH3e/VGO+YQ8vKyIBK061YRxrL6lXrlAAAE7cnVV0H72PfxzmnqQKgixtzhRrfpCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840905; c=relaxed/simple;
	bh=JiSaDV5yWnAv3ZiiVbLmjykB1IeykF5uy/37V+6g1TQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iwAHMN3c/3LoofS5cLewUADirL3vZezNGxauc1UkZ4smUGwhb1rcyaEI1de6oS7lZOLiXz7XRAKuVJo0c2Zc5KWVsRPnmH4TN5zEhlfcyor92Cj1OlmBM1HG+IWDmFV+OwZUQ0k5pWJXsHelgf0jOASSqMoaQnkYGztpaxQr8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6qy91Tf; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6qy91Tf"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8486c3411c8so1532034b3a.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840896; x=1785445696; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QzXefiH2phYC6PDa/Gx8/J3gGYE+/+w/H2tI/BUHUDc=;
        b=p6qy91Tfgs7Wl/jVbGg3Bc6IDurF30HbbfvXpsnXeuNlc6EBuAKMS9kB2uLbqlsOWb
         R347bMANmCJ+bpO0/XP7LvcBd/tC85SMO+QQz+KvfA98/bZbBR/9Wlo28GQ3mmm9Dqu1
         JlyQa5O4PLVmsx+bY4v1pRXdHd44yF210TWH2q2fRNK73BodTKqsvxZKLsMr7QtCD62V
         Ns8lqU+R81NibGMR7LfH9Vx+6lPMJoOZA60nENti00g6fSw218i7pshJBQJBoOE6k3+d
         +hF0roOkCYSmp4/v8mlbuQlAj7szFDZll+AAkzelSUVhb7bX24K9glDtImSYxQjl0eFw
         gKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840896; x=1785445696;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QzXefiH2phYC6PDa/Gx8/J3gGYE+/+w/H2tI/BUHUDc=;
        b=slI9VXGmBlUDcgl2lJo8Kh89+oMkZa4oe05RO3rfU5GW7SKi7pYA1WCLvvZJEDOdXD
         8yuyHncdwEyUKqRbVAVBNyhgGh9/4dy33rCN9K16m/39X84SzvSh4pVGVMQ46RcvBovO
         13Nxxu4LORFwPKuiViPiPFuKshdfDA48SpKoB+jD1lkg5Y+q4CByXPDN4CK5/N7GuaVR
         bdfQyePRa1Xz3jwgqURG4X2OFV4RaKfrQH+hgumzDWHaxa6mhBYPfN8krwadqcdcpEXF
         8kUtx0DZJ35Md9BRlMfL29iV9Ey+ha5TBL53cv66TpZFt+jiXEvkKULGAhYN+JA7LF7y
         RI9g==
X-Gm-Message-State: AOJu0YxsOQdw9JIPKnAbEx3BfSTzjkHmsVzcBTWW16A82lyi9L2dSyxV
	6uH+G3f3su5rDYqeEvrGQjkVFCYoEn9SENmeSUciuxK/c+CnQUHa6K1SPX5rau31GjYg6/o0pG1
	qvgJT/g==
X-Received: from pgbbg23.prod.google.com ([2002:a05:6a02:117:b0:c99:aff5:708e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9148:b0:3c3:83e6:c6e6
 with SMTP id adf61e73a8af0-3c44b1ee701mr5062081637.55.1784840895621; Thu, 23
 Jul 2026 14:08:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:05 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-4-seanjc@google.com>
Subject: [PATCH v6 3/9] KVM: x86: Rename kvm_x86_ops' gmem_invalidate() to gmem_make_shared()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_x86_ops's gmem_invalidate() hook to gmem_make_shared(), as the
hook doesn't invalidate anything, and so that KVM doesn't need to add yet
another vendor callback to support "convert to shared" once in-place
conversion comes along.

Opportunistically wrap the ops declarations with a GMEM_RECLAIM guard so
that attempting to wire up a .gmem_make_shared() hook without selecting
CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM will result in a build failure.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 4 +++-
 arch/x86/include/asm/kvm_host.h    | 4 +++-
 arch/x86/kvm/svm/sev.c             | 2 +-
 arch/x86/kvm/svm/svm.c             | 2 +-
 arch/x86/kvm/svm/svm.h             | 2 +-
 arch/x86/kvm/x86.c                 | 2 +-
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 736129db272a..210cb95d0a0b 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -149,7 +149,9 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 #endif
-KVM_X86_OP_OPTIONAL(gmem_invalidate)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+KVM_X86_OP_OPTIONAL(gmem_make_shared)
+#endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
 #endif
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8c96999f49a0..4dc8a03c829a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1727,7 +1727,9 @@ struct kvm_x86_ops {
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
 #endif
-	void (*gmem_invalidate)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+	void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
+#endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e6987351dc04..4aa8330d5b2d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5161,7 +5161,7 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 	return 0;
 }
 
-void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
+void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
 {
 	kvm_pfn_t end = pfn + nr_pages;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 91286d46d13a..b8c9967dd0de 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5439,7 +5439,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
 
 	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_make_shared = sev_gmem_make_shared,
 	.gmem_invalidate_range = sev_gmem_invalidate_range,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 #endif
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index cf8fb3d6a100..b2acb5ab7c26 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1010,7 +1010,7 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
 int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
-void sev_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
+void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 71c1f3e9044e..249267ed2a9d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10629,7 +10629,7 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
 {
-	kvm_x86_call(gmem_invalidate)(pfn, nr_pages);
+	kvm_x86_call(gmem_make_shared)(pfn, nr_pages);
 }
 #endif
 
-- 
2.55.0.229.g6434b31f56-goog

