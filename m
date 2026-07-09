Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291C3FADFD
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630207; cv=none; b=i2sZ4wyZbU7fA1XRhS2ikc2/2Qi3BC4vM1LeivBiu+BY+9EoYMXALMU5c7dC1nhat3ErCzU+2t+z6hoo0JyM+GwoeWdByEMHA5UtFLKxkb30NxQPcnT/4gRWEHEod40tMUUCi1u716iWMDjOWDt2OcQPUZ1MTzQ0ADgd1DEkMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630207; c=relaxed/simple;
	bh=07QeSXO+hJvXB+GaPRlf5A1Dnc7GvIhSEjbPcCRxLcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OSyp688nLFcpIqQjaW5zIQAI6+sKTRHdUqO3q2meomtOCf+6AwuDepkhhU7/2HdWEsRqEkX9sgs2kTdvquZz0hEjmhgNaEtNplBqqWenDdWGYu9MwEiilmhRpfpph5PwA2EZDES1KSFeCUq+n7Zsd3nZMRvV/zYLRR75HR/4IHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyIp7NLo; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyIp7NLo"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84870e7f498so177708b3a.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630205; x=1784235005; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eWwGK1OVRhFcRszDO790DqRWd3xEPKc8ZiiormbS2ls=;
        b=QyIp7NLopNHRFOGnRNuDlawVVkmQT6AksXDJOM0uDDMtMsw4fWfhuxVMHGpJEwJohK
         k+wjfpIKcEWxb1iIE9wmisMGiOTtVsBaO8wJphG6sz3Y60sDmaDfB6YUnFwVJsI/04xr
         de5+3R/s5b1NXLoVt9ypMJ/Uw2BPKN6gxMc+QBBoUCVu6hRv0AsOQ52XZ8r81p8+5iwE
         Jccb4mrQ1ysk/NrGsBBYRJbRJ07Kvjbv13kjszKrGEyuxNZy1qFZjbjDkCqg1E7quPbM
         YU6SMiho3L0uhfg41EFSuX/LsDltSIRrVBgXhk25TEq+CS4o0NZxFTRocAvXy4e/71nP
         j6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630205; x=1784235005;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eWwGK1OVRhFcRszDO790DqRWd3xEPKc8ZiiormbS2ls=;
        b=aJ5hKoET7hAV20TwN4kj0eFtxta7mhRuSyVpgFZ7WnacOiG9uAA/tI1gx0lq+wYobY
         BjamUZhKVCyPv15FmsXoVH+EZlWsTOzlngQu7xFu0pncHl6Yd4H7aWTP5gyUL9T6SptB
         UTZ+EZIraLmGVx4TsUnZGx0oDhnqe8riPB/SIIDoF6bLjiZeQj1EJFkc05v4BYmWARHw
         h/pxQnbT3OCIksLE6rAGnzAihMcW8i3BxtO+FSpIw1mfBweXCn5I6AH5qH0uh5VbbQn0
         NHIHGbMk8fDQ2floDaxXVcaFZ8H6QoOJru8jaQIDBrb3OWlMtGIZTyHpBUBdB1vFl14X
         3qUw==
X-Gm-Message-State: AOJu0Yz/hm95whoIC5YY5miKdy66kx2DY/LwKAHTUA2u/Zcp1EDO/Fl9
	gdP34aa1Pw8g+/f0jzwFBOb3J1s7P8CSSr8zAptVcRBIhGromoNZ1S+8/Fw6QqJa6Q4M07zgkcJ
	yPKg3+g==
X-Received: from pfbna42.prod.google.com ([2002:a05:6a00:3e2a:b0:845:38af:5fa5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:85a2:b0:848:5b1e:aec2
 with SMTP id d2e1a72fcca58-8485b1eb01amr3653779b3a.54.1783630204920; Thu, 09
 Jul 2026 13:50:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:43 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-14-seanjc@google.com>
Subject: [PATCH v4 13/18] KVM: guest_memfd: Pass GPA, not GFN, to prepare() hook
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Pass a GPA instead of a GFN to kvm_arch_gmem_prepare() so that the GFN/GPA
can be made optional in the future, i.e. so that guest_memfd can pass
INVALID_GPA.  This will allow reworking the hook into a general .convert()
hook, i.e. so that it can be used for both "make private" and "make shared"
operations, at which point guest_memfd may not have a corresponding GFN,
e.g. when converting memory back to a shared state when a folio is freed.

Opportunistically swap the ordering of @pfn and @gpa params for
kvm_x86_ops.gmem_prepare() to match that of kvm_arch_gmem_prepare().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/svm/sev.c          | 3 ++-
 arch/x86/kvm/svm/svm.h          | 2 +-
 arch/x86/kvm/x86.c              | 4 ++--
 include/linux/kvm_host.h        | 2 +-
 virt/kvm/guest_memfd.c          | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1f8ef0e1566a..24a7a9e6910a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1904,7 +1904,7 @@ struct kvm_x86_ops {
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+	int (*gmem_prepare)(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order);
 #endif
 	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a7584b7ed6dc..dfe93679a832 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5112,9 +5112,10 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
 	return false;
 }
 
-int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
+int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
+	gfn_t gfn = gpa_to_gfn(gpa);
 	kvm_pfn_t pfn_aligned;
 	gfn_t gfn_aligned;
 	int level, rc;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 130205defffa..58390df36af0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,7 +1009,7 @@ int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
-int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order);
 void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5a5fd6211d23..cc1404bef8cb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10590,9 +10590,9 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
+int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order)
 {
-	return kvm_x86_call(gmem_prepare)(kvm, pfn, gfn, max_order);
+	return kvm_x86_call(gmem_prepare)(kvm, gpa, pfn, max_order);
 }
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c00fc1740ce5..542e5d50849e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2573,7 +2573,7 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
+int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order);
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 659b8dbe0b30..7ad656e30f9f 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -66,7 +66,7 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	kvm_pfn_t pfn = folio_file_pfn(folio, index);
 	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
-	int rc = kvm_arch_gmem_prepare(kvm, gfn, pfn, folio_order(folio));
+	int rc = kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn), pfn, folio_order(folio));
 	if (rc) {
 		pr_warn_ratelimited("gmem: Failed to prepare folio for index %lx GFN %llx PFN %llx error %d.\n",
 				    index, gfn, pfn, rc);
-- 
2.55.0.795.g602f6c329a-goog

