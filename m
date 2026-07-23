Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97113F329B
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840917; cv=none; b=Ehg4QtaxYRwdgkgFY1PKxYnkldKGT8+r8unExkTh0TbKhoa74xEq8JsdHs49M/YfAhv986d3hu4l3Ni/0tX/W8rAS2Jc9Nbk2yrnsQdUWJl364cAXn9StRZVzZYOYp6OVD6oujwPORAzufshIYC1c+SLKEt1KujK+ofqmEfQg8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840917; c=relaxed/simple;
	bh=C4UzjAkeQgNz3jhX9X1p1bArt+15GMFelgLpMLC9Vqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4YKyZe2TIax94tlXNh7O3rmZW8R/ZB4LcogT6s9O9p2JtLz7WRFjfQNfT30VSYU/+oz2AjFsVR0AYdHvfp/UDA634rDlbCBltRklfsx6CpfKY9G0j/cffEs/OHA6dYq8vjIStvHpw0yH8WHWIs3Ot35FUv3zJdqJfRK3fDg93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyjDxNtf; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyjDxNtf"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso755983a12.3
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840901; x=1785445701; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IDpiaOiDWkuaIgELS/orYZEj+Bt7gPfIn1c9ArEgIYg=;
        b=LyjDxNtfMdgPl74Et9LyFEUi8Cqazmtf1aZwaEaQ6EVp9QEi2wKZ0TZ7zfEKr3DsVP
         gphbZ9J71VI3KL4NePpJxJl59y4I/WmnzQlLL3BlF78+WJEg9pzTbEvjXaao/08f4Pf3
         fjvcXOy5GsG+O0voMenUm8u6a106Lgk3eHqO4YSmqgBB2+xCL+wSzLwbwYbV/WZZ1J1c
         9CLnIj+GY4Uvi74qYlQEVM3s3NOgG3LHqESPJLKqpHXb6ukaKg9zNLuuf0+0SBSWjUKL
         /pNnPT7TGYxysdFXPxNPKylAKdNeNC6tgWNjmjTSv7SEpc/osNFWalNcclqbSAw5ZjiV
         K34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840901; x=1785445701;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IDpiaOiDWkuaIgELS/orYZEj+Bt7gPfIn1c9ArEgIYg=;
        b=MGBBS6BK2OholtraqjQQM8+L6oj+byqw31WipjcsLnRSt2L+EbgQINzkVJrv0YGZZ5
         j6zXvSy/uF5mGWzul7kFJ4DJQIcBPDeodSAe6pfxHW407Pspeaxxx084nNwnPtkl4OSI
         7nzIo1z+n4M/24XVZAXu5JIG5o0nF4mHzyVXmzwEVeKk3V01+esXdRdR+1OASklz3a8f
         hc5owhb1Ld0UO5G9QLv0FMEj+64z5XgEUwppRFekDD6o4WoMPP80jbx5kSoJvxKrlNch
         LjeoFENzwdgri08OlaIKalZGPdFju9kt4C+upmUhU9fLGMRoGbqgyD9/6LyV/tGRo+Cn
         VRXw==
X-Gm-Message-State: AOJu0YwdCvOnVybjMZk/QogHWn4JbFuA7IaaNvKHrzzwSxiaFbdvrS0b
	e9iA8ypugwF+UPcHyXinBwmhRBS+N6IEWEMaaH2d/21R5gXQYP3SW9AyBjQSR313azSYSdmd1c+
	RdfyIJw==
X-Received: from pguo10.prod.google.com ([2002:a65:6a4a:0:b0:c9a:c533:831a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a8d:b0:3c3:af85:85e7
 with SMTP id adf61e73a8af0-3c44b078667mr5071012637.34.1784840901194; Thu, 23
 Jul 2026 14:08:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:10 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-9-seanjc@google.com>
Subject: [PATCH v6 8/9] KVM: guest_memfd: Explicitly pass number of pages to
 make_private() hook
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Tweak the guest_memfd make_private() hook to explicitly pass the number of
pages to align with the signature of the make_shared() hook, and because
the existing code is outright broken if a guest_memfd folio is comprised of
more than one page (which can't happen, yet).  The SNP code *tries* to
create a corresponding huge entry, but if the RMP must use 4KiB entries for
whatever reason, KVM will only convert the first pfn, and not the entire
range of pfns that will be mapped into the guest.

Alternatively, @max_order could simply be repurposed as _the_ @order, but
that will fall apart when in-place conversion comes along, at which point
KVM will need to deal with conversions that aren't bound 1:1 to a folio.
I.e. the number of pages to convert may not be exactly be a power-of-2 (and
folios don't strictly guarantee power-of-2 pages anyways).

WARN in the SNP code if the number of pages to prepare is anything other
than '1', i.e. if guest_memfd is trying to prepare/convert more than a
single 4KiB page, as sev_gmem_prepare() doesn't actually handle conversion
greater than order-0 folios.

Opportunistically swap the ordering of @pfn and @gfn params for
kvm_x86_ops.gmem_make_private() to match kvm_arch_gmem_make_private().

Fixes: b85524314a3d ("KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the memory is passed to the guest")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/kvm/svm/sev.c          | 27 +++++++++++----------------
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/x86.c              |  5 +++--
 include/linux/kvm_host.h        |  2 +-
 virt/kvm/guest_memfd.c          |  2 +-
 6 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4be57157136b..230267b2203b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1725,7 +1725,8 @@ struct kvm_x86_ops {
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
-	int (*gmem_make_private)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+	int (*gmem_make_private)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+				 kvm_pfn_t nr_pages);
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 	void (*gmem_make_shared)(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0ecba768c153..bf7f94d1d7f9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5090,15 +5090,7 @@ static bool is_pfn_range_shared(kvm_pfn_t start, kvm_pfn_t end)
 	return true;
 }
 
-static u8 max_level_for_order(int order)
-{
-	if (order >= KVM_HPAGE_GFN_SHIFT(PG_LEVEL_2M))
-		return PG_LEVEL_2M;
-
-	return PG_LEVEL_4K;
-}
-
-static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
+static bool is_large_rmp_possible(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
 {
 	kvm_pfn_t pfn_aligned = ALIGN_DOWN(pfn, PTRS_PER_PMD);
 
@@ -5107,14 +5099,14 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
 	 * PFN is currently shared, then the entire 2M-aligned range can be
 	 * set to private via a single 2M RMP entry.
 	 */
-	if (max_level_for_order(order) > PG_LEVEL_4K &&
+	if (nr_pages >= KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) &&
 	    is_pfn_range_shared(pfn_aligned, pfn_aligned + PTRS_PER_PMD))
 		return true;
 
 	return false;
 }
 
-int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
+int sev_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, kvm_pfn_t nr_pages)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	kvm_pfn_t pfn_aligned;
@@ -5125,6 +5117,9 @@ int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_ord
 	if (!sev_snp_guest(kvm))
 		return 0;
 
+	if (WARN_ON_ONCE(nr_pages != 1))
+		return -EIO;
+
 	rc = snp_lookup_rmpentry(pfn, &assigned, &level);
 	if (rc) {
 		pr_err_ratelimited("SEV: Failed to look up RMP entry: GFN %llx PFN %llx error %d\n",
@@ -5133,12 +5128,12 @@ int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_ord
 	}
 
 	if (assigned) {
-		pr_debug("%s: already assigned: gfn %llx pfn %llx max_order %d level %d\n",
-			 __func__, gfn, pfn, max_order, level);
+		pr_debug("%s: already assigned: gfn %llx pfn %llx nr_pages %llx level %d\n",
+			 __func__, gfn, pfn, nr_pages, level);
 		return 0;
 	}
 
-	if (is_large_rmp_possible(kvm, pfn, max_order)) {
+	if (is_large_rmp_possible(pfn, nr_pages)) {
 		level = PG_LEVEL_2M;
 		pfn_aligned = ALIGN_DOWN(pfn, PTRS_PER_PMD);
 		gfn_aligned = ALIGN_DOWN(gfn, PTRS_PER_PMD);
@@ -5155,8 +5150,8 @@ int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_ord
 		return -EINVAL;
 	}
 
-	pr_debug("%s: updated: gfn %llx pfn %llx pfn_aligned %llx max_order %d level %d\n",
-		 __func__, gfn, pfn, pfn_aligned, max_order, level);
+	pr_debug("%s: updated: gfn %llx pfn %llx pfn_aligned %llx nr_pages %llx level %d\n",
+		 __func__, gfn, pfn, pfn_aligned, nr_pages, level);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ad849edcacc7..a327bf751ecd 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,7 +1009,7 @@ int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
-int sev_gmem_make_private(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
+int sev_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void sev_gmem_make_shared(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e7865b28d37b..511830d1b6f3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10620,9 +10620,10 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
-int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
+int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
+			       kvm_pfn_t nr_pages)
 {
-	return kvm_x86_call(gmem_make_private)(kvm, pfn, gfn, max_order);
+	return kvm_x86_call(gmem_make_private)(kvm, gfn, pfn, nr_pages);
 }
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9cf01429281b..97cedf8b89c5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2581,7 +2581,7 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
-			       int max_order);
+			       kvm_pfn_t nr_pages);
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 466f611ad4b7..255860c472ee 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -77,7 +77,7 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slo
 	kvm_pfn_t pfn = folio_file_pfn(folio, index);
 	gfn_t gfn = slot->base_gfn + index - slot->gmem.pgoff;
 
-	return kvm_arch_gmem_make_private(kvm, gfn, pfn, folio_order(folio));
+	return kvm_arch_gmem_make_private(kvm, gfn, pfn, folio_nr_pages(folio));
 #else
 	return 0;
 #endif
-- 
2.55.0.229.g6434b31f56-goog

