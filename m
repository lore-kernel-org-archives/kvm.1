Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611F3ECBD9
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070639; cv=none; b=ub8VulKyngc9ij+wUn+ZjfS0o0njTbh5wAgX+Ip/4UafbLhDNLJJKToPQIdK1Z0q7mBDv0OIwsmfofkt/VUGF7OK04xP8eRxfXxCXNs0/2FbdlIrsvzTu/g2ekc9wirAu5dlJfjJXF6gdGzSi8Uzr4rp6pORWhU7UZ8LmSwHURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070639; c=relaxed/simple;
	bh=bVhGd3IOp8vlefiVeBZZ00Lcbxo+PpE+3BfB/TZdw7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QFyVbbaiSkctGBo06Jv4Gz77xauQL9632kp6WN6ZKo73lo/xvdkhqMbV681UOCTvLGKWjuL/7VUKX/aNno0ZdbR1R/pt5LiDuHdw4Ckdwz2+0K6QjoxJh+T5KvzthyoPGbqEid6Ga4IjIW9tKPAalP/JfG0EtiyMuPKugc2Y9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kT/zUCvA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kT/zUCvA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc73f47bdcso85761575ad.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784070633; x=1784675433; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hTmnUCl/X0Wb9Nf3KvfF5kvI/1LtjOR8yNrn0+TOgsU=;
        b=kT/zUCvAeryYDra0XrE0YgSlzmRhLvWxuqh9YiAoqoSkODpfNu3/JVJo0K4TVX3KM7
         nRSCOStNGyH6s3ngR20LcBBGUVkCAi3O2qlV5VOB0lNKW/28JRCqeqrAgvsYnaaxneKz
         f8D2Zb4dIdAbwEX1zCCLIsZTjP4GHXVxT7/WgWzht1DYWfWlxH4PkG4wX8al9vPWjk0W
         fVP2+GUMxaciY6lml6PPa+JnGqb8ppl2c/ecVwUCoSpvgciPQwlov1hjzo9IHsvwGWhU
         geub8duNj4z6Ob3JikpySg28B53V6bpmcC4vY70qBq3LAhEDHnMlGO+6/M9TR8aNeSDa
         NFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070633; x=1784675433;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hTmnUCl/X0Wb9Nf3KvfF5kvI/1LtjOR8yNrn0+TOgsU=;
        b=UFhTyaHDepJp4SZAZLScpbEakFI4qFdRWg41n/vjD/OB+ltvs0QAq3D7XuwpfQscw3
         futvR2TSyfxf/ItxzVmEZSgzYzk+KJzjL4NJAm9HIV+n3/zubvwQYn4csaQkj8zGwU1i
         3qwozeikmP1xrkZ/t22P1pYiIVYsSvzKp6sdJRmMTTiFSJSC8qtXdp/DlRPSVCeTLPkr
         QUPXkXYsW57Phd34HegTYMCT6OBGVYdfmvTO/y1Uv6Ic477g0ojhILjaJwrHTNwtiv0e
         T86yB2+R8wVqBscNz3s+MG5thrt7GWb7TvrROO7tlWZxPfK/4KJLJXqehSzZvRdPbnQV
         /1Xg==
X-Gm-Message-State: AOJu0YyjAbRTlYcKmzznPbv+m6fhpPA/f49E9A6jgtJQ54aLpCRlv7JC
	F3lqotSzQLjauhh/Zi/JnRZdAmdaks6MPDzCOtd8zGnS1TK/IgXfmfMagLqTstpiPUU+jQ9xDRv
	3dGyY7Q==
X-Received: from plblb6.prod.google.com ([2002:a17:902:fa46:b0:2ca:d7b4:a3b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48e:b0:2c6:8d95:fd6d
 with SMTP id d9443c01a7336-2cef136496amr44193965ad.21.1784070632861; Tue, 14
 Jul 2026 16:10:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 16:10:14 -0700
In-Reply-To: <20260714231015.3337831-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714231015.3337831-7-seanjc@google.com>
Subject: [PATCH v5 6/7] KVM: x86: Combine .gmem_prepare()+.gmem_invalidate()
 into .gmem_convert()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Smush x86's prepare() and invalidate() hooks into a common convert() flow,
as they are effectively two sides of the same coin for SNP: they're invoked
when private/shared memory is about to made accessible/visible to the guest
or host.  I.e. prepare() is really "make private", and invalidate() is
really "make shared".

Using a single hook will yield more intuitive code when in-place conversion
comes along.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  5 ++---
 arch/x86/include/asm/kvm_host.h    |  7 +++----
 arch/x86/kvm/svm/sev.c             | 21 ++++++++++++++++++---
 arch/x86/kvm/svm/svm.c             |  3 +--
 arch/x86/kvm/svm/svm.h             |  5 ++---
 arch/x86/kvm/x86.c                 |  4 ++--
 6 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 736129db272a..76ce691de2f8 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -146,10 +146,9 @@ KVM_X86_OP(vcpu_deliver_sipi_vector)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
 KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
+KVM_X86_OP_OPTIONAL_RET0(gmem_convert)
 #endif
-KVM_X86_OP_OPTIONAL(gmem_invalidate)
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
 #endif
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e7df537d36d5..f60fec14c61a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1724,11 +1724,10 @@ struct kvm_x86_ops {
 
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-	int (*gmem_prepare)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
-			    kvm_pfn_t nr_pages, int max_order);
+#if defined(CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE) || defined(CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM)
+	int (*gmem_convert)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+			    kvm_pfn_t nr_pages, int max_order, bool to_private);
 #endif
-	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index adc58138fdd0..b00623b2f26a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5114,8 +5114,8 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
 	return false;
 }
 
-int sev_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
-		     kvm_pfn_t nr_pages, int max_order)
+static int sev_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+				 kvm_pfn_t nr_pages, int max_order)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	kvm_pfn_t pfn_aligned;
@@ -5165,8 +5165,9 @@ int sev_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	return 0;
 }
 
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+static void sev_gmem_make_shared(kvm_pfn_t start, kvm_pfn_t nr_pages)
 {
+	kvm_pfn_t end = start + nr_pages;
 	kvm_pfn_t pfn;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
@@ -5228,6 +5229,20 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 	}
 }
 
+int sev_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+		     kvm_pfn_t nr_pages, int order, bool to_private)
+{
+	if (to_private) {
+		if (WARN_ON_ONCE(!kvm || gfn >> (kvm_host.maxphyaddr - PAGE_SHIFT)))
+			return -EIO;
+
+		return sev_gmem_make_private(kvm, gfn, pfn, nr_pages, order);
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
index 91286d46d13a..8c5018c65dc5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5438,8 +5438,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
 
-	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_convert = sev_gmem_convert,
 	.gmem_invalidate_range = sev_gmem_invalidate_range,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 #endif
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e35419456648..57f692b5d709 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,9 +1009,8 @@ int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
-int sev_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
-		     kvm_pfn_t nr_pages, int max_order);
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+int sev_gmem_convert(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+		     kvm_pfn_t nr_pages, int max_order, bool to_private);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d484d8b509b1..e509d50c247c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10623,14 +10623,14 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 			  kvm_pfn_t nr_pages, int max_order)
 {
-	return kvm_x86_call(gmem_prepare)(kvm, gfn, pfn, nr_pages, max_order);
+	return kvm_x86_call(gmem_convert)(kvm, gfn, pfn, nr_pages, max_order, true);
 }
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages, int max_order)
 {
-	kvm_x86_call(gmem_invalidate)(pfn, pfn + nr_pages);
+	WARN_ON_ONCE(kvm_x86_call(gmem_convert)(NULL, -1ull, pfn, nr_pages, max_order, false));
 }
 #endif
 
-- 
2.55.0.141.g00534a21ce-goog

