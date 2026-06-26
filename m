Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655C3F58D8
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473214; cv=none; b=kssggqkNGX09RID7l16HduzjMDnI+OAwLuyq7OhLzyimoIZ4KOgrvmWiuJKOFvdVPGEeWvWM+k90K7zdZWoauIqV8ofDMTdyds+TkeHE8E09nzrtbVNW1SLuvCLPCOG0VBp1fk4/W0y4EV1UxdrDCInHSQl3iVawaou1l/wegng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473214; c=relaxed/simple;
	bh=hm1d5HfYmLvZEG3jBh5ZSp16HGGdwgQTufSKNBQkAjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3ntfM6nM9brjITY74A7cPmbeJFPnSLdipK2uEMo+x0jxdFiivyj0rtMTGHmhQJQZ0buFpnQpi8BfyPUHScCi91vaD+O/W/a9U+IiwTDXM6MdcNOP2DEn7kkgmXJ5cv5tmQ7TMcT2MLm7xgZwXBDg6k6RCndYa1sJv5C3OSbVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agWY2bFG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Suacvc0x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agWY2bFG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Suacvc0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7jUj/WYhpwqBuo+wix2BnJk6EgwJ/lk0dvKuGJAH7g=;
	b=agWY2bFG7hUGX57+G51NKAPRphoPctx4rRuRpcVQ+j69Qq7GI8LoMoEQ1SR6l3FC4V/pjc
	P99HF+tRfWaxP3UaWgGmROk8TjJvkBFrgZgPvl43tHKvb1gjo5MaTU0soeJgttbCERGqIq
	IS+J6oHsvcjgqxSPpT1Z0+uJUPK2ceU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-24qbk4aLOeWcK29k0NsmWw-1; Fri, 26 Jun 2026 07:26:47 -0400
X-MC-Unique: 24qbk4aLOeWcK29k0NsmWw-1
X-Mimecast-MFC-AGG-ID: 24qbk4aLOeWcK29k0NsmWw_1782473206
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-492488f8583so9042535e9.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473206; x=1783078006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7jUj/WYhpwqBuo+wix2BnJk6EgwJ/lk0dvKuGJAH7g=;
        b=Suacvc0xXWW9xTg5ENJmYkLRpZUBmKbztwr3fks4P+LcgHliCQEi91Ey1kmN/uRJS/
         PIenF56olbNTRyHqxlDm5bo+Nte3e+k3fqrWsMi65jA6IQ/zLPHH139tltGRtyP5U7DA
         QB8yqdS4tsTHrjveLOmj1wj7ZNFFqeKdtY54iFG1G5R4/wwm2CizJpQjOZxKdOMGbkuI
         0g0Q7w6UYG13GnX+g0xyMJf8dEvo+orQFWrx9Zr9CvX6yIOAUIb+6sf8AXBrwZSxFIXZ
         rLTbE9Zblasxo60ZpxhRNZfFFgTFA7p4Nkg8+9zXGOWUTTsLvoMJoXgZyF67SuVglNZl
         NKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473206; x=1783078006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7jUj/WYhpwqBuo+wix2BnJk6EgwJ/lk0dvKuGJAH7g=;
        b=amsxT9K3eAoc4xRaQ9PNXYhP3Xt2pw0RgSRyV/eUnDm18/s2uUdyEF5dwQ9pzcFGEP
         Z73el80nQuzjsTB6ZABTSv6FGApwbsxMQ0eHFf891oYyKh+R01+Acg0prBuwyP6G+glx
         tHSsFPSW4BbblzOage5J/5ZjjGk99k7IHYZIPumqfqYS55981cYNeCyqegT/oURm4wL5
         ndxZOXtiPbBCFK6xtpPY3PggzmnNbyinUqjo8ucNmoyHxCa9SN87PS3dgfA5zllXvcpz
         COq57j9sym8C8MAfv68iLxioa11WwO6eL5LO9PVGkTLxcnOG+6IloiP6P9wCN/VPvNML
         hqxA==
X-Forwarded-Encrypted: i=1; AFNElJ8PtXrm6OKV/CF+4uK3JQDX6ZVn7NpbCqNISWewPzHDLtB8p4sUZBUmuWV/KHy/y4CNv7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/qot3g7QlmynHMoEVELCPJpcp3SbUxqm5Sk1dJ6r6kmBAwuT
	D15Dq3QDzgv04PD7hRDF0JWd/7f3Er4CN5K1wVLQLtq1FNPqJiYjkt+J1vvvt+tkEMzwOPZAARk
	+/mwSHqgQz959jfapXYkTC4Vi7qrGk/7/GyLh9kb5L/WU6G2k8y0VWw==
X-Gm-Gg: AfdE7cmyDTkz0WyyohyzeXeE4OHlf/sbGixcPcGMQrJN1mOCKNSAaNHCDwVGI5BC91+
	8+I3+UgzKVtmMhs336yr9NgCCk3M5IWqhEJOGCMHtQfYfh4L4ulSWmKfgGsMVDv9htsFTcclQxS
	EoEMUq2zVBhfCC2pAGiC9mjYg/f0ARF2GwPZTGPvpCh/yeza6/z10kvuNQL2jl80ZM8l5DYbDI3
	FFYGx7WCw4f/cHx7DLsLb09+t+ZbTVSz2V2grg6RSq8BO8kI5aUIwR0euHiUydcnZzUZRseWeUW
	w+K7Msh6BNW3yBEhengRzfcr0CL63LsJgMp2cCvEz0EJ1p1kBT9xXg7sih+wGIHcUYQg2Wyc3VG
	6EdXex2dGTir0QLy+k0poRte8ub27AQX45xiuupnm7IehsjKkKB/4OFGkBmB75Elnr//yZlxq1M
	knQpwDxCJTDjvUQxB9
X-Received: by 2002:a05:600c:c04b:10b0:492:418b:b5e1 with SMTP id 5b1f17b1804b1-492668b02damr73052515e9.37.1782473205644;
        Fri, 26 Jun 2026 04:26:45 -0700 (PDT)
X-Received: by 2002:a05:600c:c04b:10b0:492:418b:b5e1 with SMTP id 5b1f17b1804b1-492668b02damr73052005e9.37.1782473205153;
        Fri, 26 Jun 2026 04:26:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269071e49sm71464395e9.10.2026.06.26.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Ben Gardon <bgardon@google.com>
Subject: [PATCH 5.10.y 04/17] KVM: x86/mmu: Ensure MMU pages are available when allocating roots
Date: Fri, 26 Jun 2026 13:26:21 +0200
Message-ID: <20260626112634.1778506-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 6e6ec58485746eb64487bd49bf5cd90ded3d2cf6 upstream.

Hold the mmu_lock for write for the entire duration of allocating and
initializing an MMU's roots.  This ensures there are MMU pages available
and thus prevents root allocations from failing.  That in turn fixes a
bug where KVM would fail to free valid PAE roots if a one of the later
roots failed to allocate.

Add a comment to make_mmu_pages_available() to call out that the limit
is a soft limit, e.g. KVM will temporarily exceed the threshold if a
page fault allocates multiple shadow pages and there was only one page
"available".

Note, KVM _still_ leaks the PAE roots if the guest PDPTR checks fail.
This will be addressed in a future commit.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210305011101.3597423-7-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c     | 50 +++++++++++++++-----------------------
 arch/x86/kvm/mmu/tdp_mmu.c | 23 ++++--------------
 2 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a506c0818e77..9b1f63b5e86e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2440,6 +2440,15 @@ static int make_mmu_pages_available(struct kvm_vcpu *vcpu)
 
 	kvm_mmu_zap_oldest_mmu_pages(vcpu->kvm, KVM_REFILL_PAGES - avail);
 
+	/*
+	 * Note, this check is intentionally soft, it only guarantees that one
+	 * page is available, while the caller may end up allocating as many as
+	 * four pages, e.g. for PAE roots or for 5-level paging.  Temporarily
+	 * exceeding the (arbitrary by default) limit will not harm the host,
+	 * being too agressive may unnecessarily kill the guest, and getting an
+	 * exact count is far more trouble than it's worth, especially in the
+	 * page fault paths.
+	 */
 	if (!kvm_mmu_available_pages(vcpu->kvm))
 		return -ENOSPC;
 	return 0;
@@ -3219,16 +3228,9 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
 {
 	struct kvm_mmu_page *sp;
 
-	spin_lock(&vcpu->kvm->mmu_lock);
-
-	if (make_mmu_pages_available(vcpu)) {
-		spin_unlock(&vcpu->kvm->mmu_lock);
-		return INVALID_PAGE;
-	}
 	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
 	++sp->root_count;
 
-	spin_unlock(&vcpu->kvm->mmu_lock);
 	return __pa(sp->spt);
 }
 
@@ -3241,16 +3243,9 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 
 	if (vcpu->kvm->arch.tdp_mmu_enabled) {
 		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
-
-		if (!VALID_PAGE(root))
-			return -ENOSPC;
 		mmu->root_hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
-		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level,
-				      true);
-
-		if (!VALID_PAGE(root))
-			return -ENOSPC;
+		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level, true);
 		mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
@@ -3258,8 +3253,6 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
 					      i << 30, PT32_ROOT_LEVEL, true);
-			if (!VALID_PAGE(root))
-				return -ENOSPC;
 			mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
 		mmu->root_hpa = __pa(mmu->pae_root);
@@ -3295,8 +3288,6 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
 				      mmu->shadow_root_level, false);
-		if (!VALID_PAGE(root))
-			return -ENOSPC;
 		mmu->root_hpa = root;
 		goto set_root_pgd;
 	}
@@ -3315,6 +3306,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 	for (i = 0; i < 4; ++i) {
 		MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
+
 		if (mmu->root_level == PT32E_ROOT_LEVEL) {
 			pdptr = mmu->get_pdptr(vcpu, i);
 			if (!(pdptr & PT_PRESENT_MASK)) {
@@ -3328,8 +3320,6 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 
 		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
 				      PT32_ROOT_LEVEL, false);
-		if (!VALID_PAGE(root))
-			return -ENOSPC;
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
@@ -3393,14 +3383,6 @@ static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static int mmu_alloc_roots(struct kvm_vcpu *vcpu)
-{
-	if (vcpu->arch.mmu->direct_map)
-		return mmu_alloc_direct_roots(vcpu);
-	else
-		return mmu_alloc_shadow_roots(vcpu);
-}
-
 void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 {
 	int i;
@@ -4872,7 +4854,15 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 	r = mmu_alloc_special_roots(vcpu);
 	if (r)
 		goto out;
-	r = mmu_alloc_roots(vcpu);
+	spin_lock(&vcpu->kvm->mmu_lock);
+	if (make_mmu_pages_available(vcpu))
+		r = -ENOSPC;
+	else if (vcpu->arch.mmu->direct_map)
+		r = mmu_alloc_direct_roots(vcpu);
+	else
+		r = mmu_alloc_shadow_roots(vcpu);
+	spin_unlock(&vcpu->kvm->mmu_lock);
+
 	kvm_mmu_sync_roots(vcpu);
 	if (r)
 		goto out;
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 073514bbb5f7..5cba2e85ce04 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -152,22 +152,21 @@ static struct kvm_mmu_page *alloc_tdp_mmu_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 	return sp;
 }
 
-static struct kvm_mmu_page *get_tdp_mmu_vcpu_root(struct kvm_vcpu *vcpu)
+hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 {
 	union kvm_mmu_page_role role;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_page *root;
 
-	role = page_role_for_level(vcpu, vcpu->arch.mmu->shadow_root_level);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	spin_lock(&kvm->mmu_lock);
+	role = page_role_for_level(vcpu, vcpu->arch.mmu->shadow_root_level);
 
 	/* Check for an existing root before allocating a new one. */
 	for_each_tdp_mmu_root(kvm, root) {
 		if (root->role.word == role.word) {
 			kvm_mmu_get_root(kvm, root);
-			spin_unlock(&kvm->mmu_lock);
-			return root;
+			goto out;
 		}
 	}
 
@@ -176,19 +175,7 @@ static struct kvm_mmu_page *get_tdp_mmu_vcpu_root(struct kvm_vcpu *vcpu)
 
 	list_add(&root->link, &kvm->arch.tdp_mmu_roots);
 
-	spin_unlock(&kvm->mmu_lock);
-
-	return root;
-}
-
-hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
-{
-	struct kvm_mmu_page *root;
-
-	root = get_tdp_mmu_vcpu_root(vcpu);
-	if (!root)
-		return INVALID_PAGE;
-
+out:
 	return __pa(root->spt);
 }
 
-- 
2.54.0

