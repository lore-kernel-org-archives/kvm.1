Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0A3F410E
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473202; cv=none; b=c0fvtwZRkOkR+e70rEkjV5m2GEyEJQYL/MbunjEvujLAphp4ahcGsEidNlBxj1rxHd3CB8XpXufNUiz9S/xiplsZTzlNi/G4FJPJqol+VPMhZqnPMkop4rlygQzwljq6xRl74JmQTuKEWb0ZbEje7rhmEKdpi3QvpKRKKXdJIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473202; c=relaxed/simple;
	bh=z5p8zlSV47o/gjXKZEG4K6hFjdVK9QxiHf0gUP5CT5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNGIoEWL280EODxsfnJyDhTCoweqb3SrKt5+j6qPXB2ENHsUHjQ01pdwSjD+yXn1fQOQbMWZvHU0dEBw3d06+pWlAVo+5rjGMLZht2hqSX+WuqiwsfxwzYZW0Dak5Pxry/X1C0Q3Nw702jgGIUlRzDZnGHwx1V4IN9pFQH6B3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYmYipe/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sGFnI+5V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYmYipe/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sGFnI+5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENEuZa7My5usXn5D2jfKTuVzxaRr1sti56rTOiPeclU=;
	b=HYmYipe/wbLkE9ebJMsmR8iYXAxhWj28la+BEvXxOjAc2gwEQgPIJ96ZiXyS6AVheYu1x4
	9tJdtuAmWqTMQpUwCm+ZoOMbna8D9O3Yi7T296ljDNHIB1JDza1zOaVKVrlybampf52HFr
	1eCkIRPCmuFeHUK9z5FMSlzLZCRYmcw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-61M3A8s3M1eE9VZ0x9L01w-1; Fri, 26 Jun 2026 07:26:39 -0400
X-MC-Unique: 61M3A8s3M1eE9VZ0x9L01w-1
X-Mimecast-MFC-AGG-ID: 61M3A8s3M1eE9VZ0x9L01w_1782473198
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b2f22ea2so7195795e9.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473198; x=1783077998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENEuZa7My5usXn5D2jfKTuVzxaRr1sti56rTOiPeclU=;
        b=sGFnI+5VHhZJHXqIlwhkhM3Acwql92SngKUvdoGKnP2Mb9Ja77oURDOMP7IELF2nLU
         uus/hqpi53rdgM5u31x9ZPQQxBW2u2+sfbltvBImB2VMToMl8VsuDsr4rA9duVZv/qOz
         c/LNYpOc9AbMTOSSY4JnVwt6nIE7LWxwbC3lfefWayFrEHQH4X37k74ScmFJ20imxyKn
         dZLqhz9MhUnz9urXplDCuo50n7xtYS8sjsIV8J/XS+cukzcddDH5Vx8gb8FQ1kRmDhmN
         oRM4InWzSMP1xLYBuFJ3OQqdols/7n+FEr6ssn12dFYkCc7B2AdYL4t652TYJHyfBPG7
         w8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473198; x=1783077998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENEuZa7My5usXn5D2jfKTuVzxaRr1sti56rTOiPeclU=;
        b=VnPSnhBY66W2XAbGmeNiH3Zc6DzXkOUVRUG00dbwo6GNu8QaqBFEhh8wXzyby+MO8U
         OVGnVK5IKmNQiK32grYVEQ6mVYdo2VC2v6YRIudx888wfrLiDLpvndSle+Q4rstvh3B5
         JYlZzVmPYwoFOVeL4qoCV0GRtnUXUH+V7b47IY7GB7w/+46fTha3gNq5Z3U7NKHuVY8o
         OHTka9TfxFuAe9ySTsWp+UVwn9+ol5jkOLQFUdfsFw4Ne8oxkrck8ypu+twgLrJIp+1a
         EwkzkDv0fyqdrXxpQS6EsWWt0YXlfl5eLpr89yvL/M2HmeBEhEqYSb8q2Ma0fC/5/iwe
         qNGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8y5MLUY4K2Zg5oTkkMR2bQGXrWg/pSCSVQl/t/vVeFE04MWw8zjgaPeSaPYGEEzPxtNbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1HokGM7j4QhlXWdDvCe3GUNvBNvjxzVxde9DQFqFOEcRn/10
	V17E1HjCNqEnPgpVrRpZu8RQf7/RTa4nEed9FLsZNlSy3vyYj9BgTCHHiW7+OR62iTOVcryZmH9
	oIwqAW/6/+NlTbBnH5HDR4UouFF81+oObnriTRWwaFQGqXgxOtBfRXdlgarSVAA==
X-Gm-Gg: AfdE7cmz7vq9Mq5H1fgOcFrWv1p99QG3JE8tV/9LfM/hnbH37+89t4XNOd9DHNSyQxa
	etHxGwC3pQWUOkqt21ep4yDy8JlIH0WkzgfLYC1Z3+jVttq/6NdKKcVt4fbAfD95unl4YMA5ybE
	5xB0I52bJwik5SL9Fi9FawiRHF9PqGriJ3Hflk7JjAWnHoVHSJys0eRJ6nbKVvZq7LqlvvqFDxT
	7e+ClJTRJwllwCf2Q8X/5kdlXBYYrKBPwdf9knWC3Mt1N8GOH2QuZ7IbLOffOxsoOBYRmCAIKS0
	PRQtQDPHxtKU7Tm+OEbfhEg/vOu+9oyprcoFr/FA09S78qoVomvaM6o7y7H6DJ+X/K5gS+3MEEl
	tijx2vpt1nrixiSLxh3/BCRAnLD4O+gf/wUF14i70iurizDawE5BKAP8UnKkwPLml0cCXWLStGh
	walWwA+HXR4Fr0B1cc
X-Received: by 2002:a05:600c:c3c1:10b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-4926683fc06mr71944955e9.10.1782473198087;
        Fri, 26 Jun 2026 04:26:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c3c1:10b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-4926683fc06mr71944675e9.10.1782473197666;
        Fri, 26 Jun 2026 04:26:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c02088dsm37606275e9.0.2026.06.26.04.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y 01/17] KVM: x86/mmu: Capture 'mmu' in a local variable when allocating roots
Date: Fri, 26 Jun 2026 13:26:18 +0200
Message-ID: <20260626112634.1778506-2-pbonzini@redhat.com>
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

commit b37233c911cbecd22a8a2a80137efe706c727d76 upstream.

Grab 'mmu' and do s/vcpu->arch.mmu/mmu to shorten line lengths and yield
smaller diffs when moving code around in future cleanup without forcing
the new code to use the same ugly pattern.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210305011101.3597423-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 58 ++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 13bf3198d0ce..c2c76419af0c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3234,7 +3234,8 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
 
 static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 {
-	u8 shadow_root_level = vcpu->arch.mmu->shadow_root_level;
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	u8 shadow_root_level = mmu->shadow_root_level;
 	hpa_t root;
 	unsigned i;
 
@@ -3243,42 +3244,43 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 
 		if (!VALID_PAGE(root))
 			return -ENOSPC;
-		vcpu->arch.mmu->root_hpa = root;
+		mmu->root_hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
 		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level,
 				      true);
 
 		if (!VALID_PAGE(root))
 			return -ENOSPC;
-		vcpu->arch.mmu->root_hpa = root;
+		mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
-			MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
+			MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
 					      i << 30, PT32_ROOT_LEVEL, true);
 			if (!VALID_PAGE(root))
 				return -ENOSPC;
-			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
+			mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
-		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
+		mmu->root_hpa = __pa(mmu->pae_root);
 	} else
 		BUG();
 
 	/* root_pgd is ignored for direct MMUs. */
-	vcpu->arch.mmu->root_pgd = 0;
+	mmu->root_pgd = 0;
 
 	return 0;
 }
 
 static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 {
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 pdptr, pm_mask;
 	gfn_t root_gfn, root_pgd;
 	hpa_t root;
 	int i;
 
-	root_pgd = vcpu->arch.mmu->get_guest_pgd(vcpu);
+	root_pgd = mmu->get_guest_pgd(vcpu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
 
 	if (mmu_check_root(vcpu, root_gfn))
@@ -3288,14 +3290,14 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * Do we shadow a long mode page table? If so we need to
 	 * write-protect the guests page table root.
 	 */
-	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
-		MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
+	if (mmu->root_level >= PT64_ROOT_4LEVEL) {
+		MMU_WARN_ON(VALID_PAGE(mmu->root_hpa));
 
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
-				      vcpu->arch.mmu->shadow_root_level, false);
+				      mmu->shadow_root_level, false);
 		if (!VALID_PAGE(root))
 			return -ENOSPC;
-		vcpu->arch.mmu->root_hpa = root;
+		mmu->root_hpa = root;
 		goto set_root_pgd;
 	}
 
@@ -3305,7 +3307,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * the shadow page table may be a PAE or a long mode page table.
 	 */
 	pm_mask = PT_PRESENT_MASK;
-	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
+	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
 		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
 
 		/*
@@ -3313,21 +3315,21 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		 * with 64-bit only when needed.  Unlike 32-bit NPT, it doesn't
 		 * need to be in low mem.  See also lm_root below.
 		 */
-		if (!vcpu->arch.mmu->pae_root) {
+		if (!mmu->pae_root) {
 			WARN_ON_ONCE(!tdp_enabled);
 
-			vcpu->arch.mmu->pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
-			if (!vcpu->arch.mmu->pae_root)
+			mmu->pae_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+			if (!mmu->pae_root)
 				return -ENOMEM;
 		}
 	}
 
 	for (i = 0; i < 4; ++i) {
-		MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
-		if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
-			pdptr = vcpu->arch.mmu->get_pdptr(vcpu, i);
+		MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
+		if (mmu->root_level == PT32E_ROOT_LEVEL) {
+			pdptr = mmu->get_pdptr(vcpu, i);
 			if (!(pdptr & PT_PRESENT_MASK)) {
-				vcpu->arch.mmu->pae_root[i] = 0;
+				mmu->pae_root[i] = 0;
 				continue;
 			}
 			root_gfn = pdptr >> PAGE_SHIFT;
@@ -3339,9 +3341,9 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				      PT32_ROOT_LEVEL, false);
 		if (!VALID_PAGE(root))
 			return -ENOSPC;
-		vcpu->arch.mmu->pae_root[i] = root | pm_mask;
+		mmu->pae_root[i] = root | pm_mask;
 	}
-	vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
+	mmu->root_hpa = __pa(mmu->pae_root);
 
 	/*
 	 * When shadowing 32-bit or PAE NPT with 64-bit NPT, the PML4 and PDP
@@ -3350,24 +3352,24 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * on demand, as running a 32-bit L1 VMM is very rare.  The PDP is
 	 * handled above (to share logic with PAE), deal with the PML4 here.
 	 */
-	if (vcpu->arch.mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
-		if (vcpu->arch.mmu->lm_root == NULL) {
+	if (mmu->shadow_root_level == PT64_ROOT_4LEVEL) {
+		if (mmu->lm_root == NULL) {
 			u64 *lm_root;
 
 			lm_root = (void*)get_zeroed_page(GFP_KERNEL_ACCOUNT);
 			if (!lm_root)
 				return -ENOMEM;
 
-			lm_root[0] = __pa(vcpu->arch.mmu->pae_root) | pm_mask;
+			lm_root[0] = __pa(mmu->pae_root) | pm_mask;
 
-			vcpu->arch.mmu->lm_root = lm_root;
+			mmu->lm_root = lm_root;
 		}
 
-		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->lm_root);
+		mmu->root_hpa = __pa(mmu->lm_root);
 	}
 
 set_root_pgd:
-	vcpu->arch.mmu->root_pgd = root_pgd;
+	mmu->root_pgd = root_pgd;
 
 	return 0;
 }
-- 
2.54.0

