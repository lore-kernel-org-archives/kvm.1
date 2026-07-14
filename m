Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E242DFEA
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070638; cv=none; b=DoHIgd/oiYwAFUx13Y3S8FrZAnaFquM+7dUm3r4eHmB+5YvpKop8CwgZFWMzCgBwbP1XqUtqQaC4ZJC6mIeiU98nBjNChlNyVv3Exe/C3sPegn7nvlGb+JDxy6NGXklGnQvhRm8Fnfj2xma2oU53CV9XHfOvbeBS+4EBCZlk/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070638; c=relaxed/simple;
	bh=A8l3MpZJ66tJyWlzL4z4qnKcCBtdsHxmv+D4XcQUlhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXTnODEQVy7m3d3Y0KywHDe7QgmMA7NwPsmcIbmfRkjGfhc1Nzu3QN3icTLXZLp42bZhfm9vcuWCAtdS6zANo1fKCKOOC6vLOjLaGumVEEj9KKrosaInKdVs/w297AaHfk5Mbcdw7KfM1qhMUI3oRUybMniBsOCGbp5V807nJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+9+yDdV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+9+yDdV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2caf4173b1cso27326465ad.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784070632; x=1784675432; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WbV659HPGvdEwoDP0ppeOEtMv4dB4rlQt/SLQHI4470=;
        b=V+9+yDdVpC8veDwgvAomvMFGVyg+mC8hd5LW/kj8DZsfOcAsVcGNelO148M+gZi1FN
         b5xB49xg1zg4sRa/1jybSiVDXONR3YO/sXwOSS8N9KkPBuTGM2di5qSa2jzNtpjrI/1w
         7mW9tC7O9sdpi6CVZMBKcdtBSY/NyCSrKrw2tkdAusPIfxitJzBvL8Wpfq2itkds8G7r
         bsy4wR+lKtAgRnGITbbrYysRSHFUPNhd2UAT7V7L118uaN5hmHQHn1IFX+dzqiiiPw10
         yRBjFbjB9gimVarqE3VuwxGQ6NeU83/QxOqVo0bA/qZd+TACprx5U/ZiHo+r0hfg4eTJ
         a9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070632; x=1784675432;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WbV659HPGvdEwoDP0ppeOEtMv4dB4rlQt/SLQHI4470=;
        b=RZE+PjeEniNLBRBnkQYS32HFm/6z7Z4XkfgrrPpIss1ht8ajV08U97RfkYM2S47+N2
         PgyzRKyfPZnjLUxLPXMNgNDBZxxSsOHFlcjN3AvMDUYifS7HX/Ssqsaei/4iM7rkIuRe
         oeHu4U6rJqlxXjq34mcb8FV8B2Z/BXxOAaIQBCycqyK1rN/1BBqimUcbQNhEXKhquD17
         pY4V9Cgvt0b8nHyd0qyu2l8PVJF3udZ1sYTTnR0LJGOnw53755LcWmQz+pIXulctFx5x
         +i+hNlPLiiczRSH2PCmbvNxszUHPAxvb6iRyX7UJceGRwl8q1TgMs+R0cPnUG8VVVmE/
         z/ZQ==
X-Gm-Message-State: AOJu0YyuiLTtIaKdTni4ulbuoZYjazXf4hT/N7m6YycH5Ub93du3MsDC
	rU2UCRABjJZVd1H1veMfC6IcWNS6xmKqdyOaaTLZPkF1T6l93laGaePdyfaSJ/rnMO3bmBPuj3b
	K0b58VQ==
X-Received: from pgmh3.prod.google.com ([2002:a63:5743:0:b0:c99:cbb4:1dcb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9187:b0:3bf:a698:ce40
 with SMTP id adf61e73a8af0-3c1108c1b22mr16240536637.58.1784070631711; Tue, 14
 Jul 2026 16:10:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 16:10:13 -0700
In-Reply-To: <20260714231015.3337831-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714231015.3337831-6-seanjc@google.com>
Subject: [PATCH v5 5/7] KVM: guest_memfd: Explicitly pass number of pages to kvm_arch_gmem_prepare()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Tweak the guest_memfd prepare() hook to explicitly pass the number of pages
to "prepare", so that the prepare() and invalidate() hooks can be combined
into a single convert() hook, and because the existing code is outright
broken if a guest_memfd folio is comprised of more than one page (which
can't happen, yet).  guest_memfd aligns the pfn down, and the SNP code
*tries* to create a corresponding huge entry, but if the RMP must use 4KiB
entries for whatever reason, KVM will only "prepare" the first pfn, and not
the actual pfn that needs to be converted/prepared.

Alternatively, @max_order could simply be repurposed as _the_ @order, but
that will fall apart when in-place conversion comes along, at which point
KVM will need to deal with conversions that aren't strictly bound to a one
folio.

WARN in the SNP code if the number of pages to prepare is anything other
than '1', i.e. if guest_memfd is trying to prepare/convert more than a
single 4KiB page, as sev_gmem_prepare() doesn't actually handle conversion
greater than order-0 folios.

Opportunistically swap the ordering of @pfn and @gfn params for
kvm_x86_ops.gmem_prepare() to match that of kvm_arch_gmem_prepare().

Fixes: b85524314a3d ("KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the memory is passed to the guest")
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/kvm/svm/sev.c          | 6 +++++-
 arch/x86/kvm/svm/svm.h          | 3 ++-
 arch/x86/kvm/x86.c              | 5 +++--
 include/linux/kvm_host.h        | 3 ++-
 virt/kvm/guest_memfd.c          | 7 ++++---
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 58f156ae31e7..e7df537d36d5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1725,7 +1725,8 @@ struct kvm_x86_ops {
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+	int (*gmem_prepare)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+			    kvm_pfn_t nr_pages, int max_order);
 #endif
 	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 82b983484af2..adc58138fdd0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5114,7 +5114,8 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
 	return false;
 }
 
-int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
+int sev_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+		     kvm_pfn_t nr_pages, int max_order)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	kvm_pfn_t pfn_aligned;
@@ -5125,6 +5126,9 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 	if (!sev_snp_guest(kvm))
 		return 0;
 
+	if (WARN_ON_ONCE(nr_pages != 1))
+		return -EIO;
+
 	rc = snp_lookup_rmpentry(pfn, &assigned, &level);
 	if (rc) {
 		pr_err_ratelimited("SEV: Failed to look up RMP entry: GFN %llx PFN %llx error %d\n",
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index af25e4b56212..e35419456648 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,7 +1009,8 @@ int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
-int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+int sev_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+		     kvm_pfn_t nr_pages, int max_order);
 void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 08d24c6fffa4..d484d8b509b1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10620,9 +10620,10 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
+int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+			  kvm_pfn_t nr_pages, int max_order)
 {
-	return kvm_x86_call(gmem_prepare)(kvm, pfn, gfn, max_order);
+	return kvm_x86_call(gmem_prepare)(kvm, gfn, pfn, nr_pages, max_order);
 }
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ee87ddd3294f..0a06234a8a8b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2580,7 +2580,8 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
+int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+			  kvm_pfn_t nr_pages, int max_order);
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f9a1d6d64f6c..0f6745f3b919 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -70,6 +70,7 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				  gfn_t gfn, struct folio *folio)
 {
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
+	unsigned long nr_pages = folio_nr_pages(folio);
 	pgoff_t index;
 
 	/*
@@ -85,12 +86,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * The order will be passed when creating the guest_memfd, and
 	 * checked when creating memslots.
 	 */
-	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
-	gfn = ALIGN_DOWN(gfn, folio_nr_pages(folio));
+	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, nr_pages));
+	gfn = ALIGN_DOWN(gfn, nr_pages);
 	index = kvm_gmem_get_index(slot, gfn);
 
 	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
-				     folio_order(folio));
+				     nr_pages, folio_order(folio));
 #else
 	return 0;
 #endif
-- 
2.55.0.141.g00534a21ce-goog

