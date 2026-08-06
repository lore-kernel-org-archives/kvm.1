Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1E429036
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052458; cv=none; b=JBMGzewT7zXIWXJ+M3ykKTglVp5E/oxbxZOR0f148soTX70KB4BWaXPVoWLNIM40m7TBI/ImP1XHQaNkQxB71yZwuG+tf021slYi+kXpJCHgB9osbgD2VAqojYxc2lm6TSOAkTcJGHh/zy7zkj5gq8yONnTSrxDGs5bm86jloiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052458; c=relaxed/simple;
	bh=YXvxBbhrwBIqcRqu7EKMvZk9hvjNwBNYInFYiCi5wRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uC8qzGru0SuL2OqHhWHUEXn8caXDTEzXO0y4vZD7/wxuKk3w+FFqowZte1rnuWqUN+3WcapRKp+ELD9QIUeb3IxvVC7dmMGJtrVhI+85FwF4dvnJb30mAfUlH2DBUJ55SUT4CLRU6CGPPqiTl20aJCGK//XSBfM2Ks1h8YE27g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/2TIBff; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/2TIBff"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e048a801dso3547114b3a.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786052456; x=1786657256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rEEwTcg7bv7FkGEAqkUfC5yUVJEh4P3MKarrm6QtyZY=;
        b=e/2TIBffTAf1F/sIz6Vmg4Ta/254Zztm2NGBoJzFXzHopCtue/wZP0KHMFEd5seYoU
         MKEqG5/ipPrZzoTflckM0Rj3AjgZczv/6lEZIv4dAc7kW+/K0fcfeb1crfbNwN2UO70R
         +0jIHLZyktYs91+ah5ThuUJoeObVraPBy8Ep2XQV3l38x1B9QtHh/dCZOBcyVF+2RLoi
         kgz7sr5WWIeB0/2xnS+DS/ELJH0fm+Ibp6MAbweByXkpO8fgb56y+JS3xkxN0iTJWWFz
         wkR95b9fSe5Ka1MOqh1fRUfEfUa8FL+uoBXs1IBTDFcdHda3Ju2FjtSlB+pxD9Mf0j5s
         wPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052456; x=1786657256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rEEwTcg7bv7FkGEAqkUfC5yUVJEh4P3MKarrm6QtyZY=;
        b=T7ewygOzfunAj5RdD8rOW8Gflus7CK1W+xC90Vw4aKRPOFBPBPRfw+ktevxEKuSPO5
         3G9Sy2xBtFMJg8I1KEg41FZZsJYrO8aaskf5UWCjSupKpkVGxleP5Gbv1HshT0yyIPkz
         jSdRre8Ur4bKCYiK99DAjj4Pa0B6zDomBu0TyxpTEyqji/AD2OTopUsx3JiLPJiKDcGb
         oJiJsFXGFBckBPwpk/r4XVrVVOKxJwKoKTKUcxQdKL/4gCNCbvv82Vc4mMkNKGWMyWUi
         z3aMQZ2SSoHkCO7c2kLVBDLMTwHfia/i8tQ8BICRo1oQJ4/aK2nORpQnKaQL3fG8U1E9
         Fa3w==
X-Gm-Message-State: AOJu0YzIvKg8hrXr+GivavrjaWT+rfjL6O83uiFpMAYN1IHber36auuL
	4s10KNHENSlBGcc2RBj8JaJ1ORhZPE3+Ykb0VY6+2jYpEmTjb3n1kXXnZwEmx8UGObh2xhN6cZJ
	hMz05zA==
X-Received: from pfn34.prod.google.com ([2002:a05:6a00:a222:b0:84a:31b0:7544])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c81:b0:845:cdc1:a803
 with SMTP id d2e1a72fcca58-84f2dfc4763mr19978858b3a.11.1786052455960; Thu, 06
 Aug 2026 14:40:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 14:40:48 -0700
In-Reply-To: <20260806214050.78058-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806214050.78058-3-seanjc@google.com>
Subject: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against unexpected
 root invalidation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Move kvm_tdp_mmu_map_private_pfn()'s reload of the MMU into its tight loop
so that an unexpected root invalidation has a better chance of being
handled gracefully, even though it should be impossible for the vCPU's root
to be invalidated after the initial reload.  As is, encountering an invalid
root is *guaranteed* to put the task into an infinite loop (albeit a
breakable loop that honors NEED_RESCHED).

Add a WARN to try and detect bugs that break KVM's expectations, along with
a comment to explain why it should be impossible for the root to be
invalidated.

Cc: Kai Huang <kai.huang@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 621b0a42f2a1..c6cac893cbad 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
 		return -EPERM;
 
-	r = kvm_mmu_reload(vcpu);
-	if (r)
-		return r;
-
 	r = mmu_topup_memory_caches(vcpu, false);
 	if (r)
 		return r;
@@ -5199,10 +5195,21 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
 			return -EIO;
 
+		r = kvm_mmu_reload(vcpu);
+		if (r)
+			return r;
+
 		cond_resched();
 
 		guard(read_lock)(&kvm->mmu_lock);
 
+		/*
+		 * Because slots_lock is held, it should be impossible for roots
+		 * to be invalidated after the initial MMU reload.  WARN, but
+		 * continue and re-reload the MMU to try and keep the VM alive.
+		 */
+		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
+
 		r = kvm_tdp_mmu_map(vcpu, &fault);
 	} while (r == RET_PF_RETRY);
 
-- 
2.55.0.679.g6767b8d81c-goog

