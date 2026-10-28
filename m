Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219178;
	b=4W2z4tB5ur8VYvCObCcMMZMwYTcXh8expNJwBvmZuvlpcw+/ezrugRLP66q5z4svX6ce
	 4Xs4YZQG2M3+xBHDJtQ/8an/7Ufy1TOa4R72/AXICyqIKAkK3h6xgE2VaYG6BVPaqpAHY
	 B1S0tyXiyOFheOORDAIxqKFGuzgEnGkeJ9v398betGtXFsJHyQy1rZEJAAYt9LbXAEG3G
	 sE3UMf+caIq7FNNU4S7onoJfWm1t+KtcLWA013E27aCOftiMmyM3onUZM8lV9XmWVZHV8
	 2cRy5sp9EjcW+KJ967sk/5kpHOZj4kKyXn11XmIYLAgLewDqAu7iXRIjkRxNuDZvAmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DQPRF1RqEpntROrXpO4DTcTkPcIgq3OBHakNhIQaiCc=;
	b=tKfspil/FJCOkONWMPQwWb7fsYhxzMox4WflF6iQ/ibWEY7x0Q3Ux36V6e350bESQEeh
	 5nHks9euTkTHvB73FjFKeBPwc7abAdWqQgeLosa/Vrt72Z3ZR0zDpU5kTDrZoelT7bgVv
	 GxKOZ+DYC1FMie7icP9+lOeYHjvcHbi8V1ijfVEHQokPLq2XmhnbLWSvzpI2MsBNg0qda
	 7RsR7HlTUaAvbjxdJIigKLbvFI3QzN9TqkZE5gmG3A93LpkWB3WrA/HD7vFRTioJvrRTe
	 unuwYIjMhtB9orHkmvPXCtD+L5/YD9jnh+5qEXbJkPWWNis4iNbsTKaXbAoBmBoIiew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KhxD6YW7;
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FB60A260F
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 033FB60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KhxD6YW7
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd5fd34fee0so760433a12.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793219177; x=1793823977; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DQPRF1RqEpntROrXpO4DTcTkPcIgq3OBHakNhIQaiCc=;
        b=KhxD6YW7jsi2Rkd1zG7UJKzhHhXhWOkvdBGECq6LhP9JvIxx9OQP2ZgqXCibHf4Bv5
         B9ykKc/+47Dztkc7bvyNC7rglGN91slqpUXescK7j0coO5QbU65JeU7Ar7h1ZPjJxpE+
         XCv2mVF4MpqFolk9nr+B6Qd8GOmJRXgMlYEAHeJSgSDIPnNg1B3fL6UwM8gHOtklYtIl
         FMcxIgzRNlwo1ngeibPOFQwIQTXGWLNrrgLCKSBEduMFl7ltQ5OfdHc4hfwxJdRiDkNS
         to3p/Zz5uutSrNl/WMWLG/FJ2oWSkYLw5mOj5enzBkrImlCm24CUAoWk0w/ajJohMLzO
         SWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219177; x=1793823977;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DQPRF1RqEpntROrXpO4DTcTkPcIgq3OBHakNhIQaiCc=;
        b=zBYFBhGn7i7RFu3LrovzqpbG5SXT/dIEMbe6ApSUi7E2/YPKU+i9ct/2euX0uIeOJv
         eqXgk75Abhw/BNbeCyneaEBeVUfIW3Fm2cuXwFDEpCJgdgoAhRq/JitxCGqwZ+PmRXU5
         oCF71+E83uBvsFVj4VBa1OEnMilCZM6rYhRZX8mzbwoti02t3BJfONsND1XeNk+bisbo
         /V6HTpnZkNkwT668hHiVgRlGQehOfc5uScqJroK8syJHaV/6Ux2yPgL4khpe6DOuPoWO
         KtSfP5fCtkscXwV1MFbB+nLaRmaEIZsUn3FtE+TfxmdPboR8EtaZfPaOkTgQHXc7KfrW
         fW0g==
X-Gm-Message-State: AFq9FYJI8qSaKV1Agdd8F94ZX7FmPJTWKzxjWCDH7aJ+xf9tDve6+PEq
	ueWC2iWUzm3Gmf5iV274xS3g3wX2dMgMBolBOvbrB6PY3QcuiVqmjGnJ3PDzlzXMdhliNuauNoa
	9n9VCUw==
X-Received: from pgbm25-n1.prod.google.com ([2002:a05:6a02:6199:10b0:cca:c02e:bfe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4303:b0:3e1:5086:35cc
 with SMTP id adf61e73a8af0-3e9023258c6mr2732929637.39.1793219177098; Wed, 28
 Oct 2026 13:26:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 13:26:07 -0700
In-Reply-To: <20261028202607.1844883-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028202607.1844883-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028202607.1844883-5-seanjc@google.com>
Subject: [PATCH 4/4] KVM: x86/mmu: Use the generic auto-prefaulting to do
 prefetch for direct MMUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Marangoni <mamarang@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Use generic auto-prefaulting for direct shadow MMUs and drop the small bit
of custom prefetching that is unique to direct MMUs.  Direct shadow MMUs
are basically on life support, and the generic approach provides comparable
performance, plus it supported guest_memfd and PFN-backed memory.

Note!  Deliberately keep the core direct PTE prefetching logic, as it's
still needed to prefetch PTEs for direct shadow pages in indirect MMUs,
i.e. when the guest is using hugepages but KVM is not.

Opportunistically drop the double-underscores from direct_pte_prefetch()
now that only the version used by indirect MMUs exists.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c         | 48 ++++++----------------------------
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 2 files changed, 9 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c56a2eaa4646..7f8beb1b307b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -123,8 +123,8 @@ static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
 
 /*
- * The exact number of PTEs that can be prefetched for the shadow MMU, and the
- * default number of pages to prefault/prefetch pages for the TDP MMU.
+ * The exact number of PTEs that can be prefetched for indirect MMUs, and the
+ * default number of pages to prefault/prefetch pages for direct MMUs.
  */
 #define PTE_PREFETCH_NUM		8
 
@@ -3275,8 +3275,8 @@ static bool direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
 	return kvm_mmu_prefetch_sptes(vcpu, gfn, start, end - start, access);
 }
 
-static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
-				  struct kvm_mmu_page *sp, u64 *sptep)
+static void direct_pte_prefetch(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
+				u64 *sptep)
 {
 	u64 *spte, *start = NULL;
 	int i;
@@ -3301,33 +3301,6 @@ static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
 		direct_pte_prefetch_many(vcpu, sp, start, spte);
 }
 
-static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-
-	/*
-	 * Without accessed bits, there's no way to distinguish between
-	 * actually accessed translations and prefetched, so disable pte
-	 * prefetch if accessed bits aren't available.
-	 */
-	if (sp_ad_disabled(sp))
-		return;
-
-	if (sp->role.level > PG_LEVEL_4K)
-		return;
-
-	/*
-	 * If addresses are being invalidated, skip prefetching to avoid
-	 * accidentally prefetching those addresses.
-	 */
-	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
-		return;
-
-	__direct_pte_prefetch(vcpu, sp, sptep);
-}
-
 /*
  * Lookup the mapping level for @gfn in the current mm.
  *
@@ -3562,8 +3535,8 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_shadow_walk_iterator it;
 	struct kvm_mmu_page *sp;
-	int ret, access;
 	gfn_t base_gfn = fault->gfn;
+	int access;
 
 	kvm_mmu_hugepage_adjust(vcpu, fault);
 
@@ -3594,13 +3567,8 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	if (KVM_BUG_ON(it.level != fault->goal_level, vcpu->kvm))
 		return -EIO;
 
-	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, access,
-			   base_gfn, fault->pfn, fault);
-	if (ret == RET_PF_SPURIOUS)
-		return ret;
-
-	direct_pte_prefetch(vcpu, it.sptep);
-	return ret;
+	return mmu_set_spte(vcpu, fault->slot, it.sptep, access, base_gfn,
+			    fault->pfn, fault);
 }
 
 static void kvm_send_hwpoison_signal(struct kvm_memory_slot *slot, gfn_t gfn)
@@ -6685,7 +6653,7 @@ static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
 	if (error_code & (PFERR_RSVD_MASK | PFERR_PRESENT_MASK))
 		return;
 
-	if (!tdp_mmu_enabled || vcpu->arch.mmu->page_fault != kvm_tdp_page_fault)
+	if (vcpu->arch.mmu->page_fault != kvm_tdp_page_fault)
 		return;
 
 	nr_pages = min(nr_pages, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G));
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8e350095508c..baaab791f107 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -631,7 +631,7 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
 		return;
 
 	if (sp->role.direct)
-		return __direct_pte_prefetch(vcpu, sp, sptep);
+		return direct_pte_prefetch(vcpu, sp, sptep);
 
 	i = spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
 	spte = sp->spt + i;
-- 
2.56.0.313.g2479322e68-goog

