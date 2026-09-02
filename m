Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CC440A34
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390578; cv=none; b=Nx7BA10Qk7Wc6D6vsqt5q2GfkB6qAeaEV2ZQVcnEgv12gpawN1RFRh7Q3pYRLN9j8knl7QLMwgyuvXwOtjeJsIzynrbNoT9LpzXdUuUiH5y1LTKSxN4zYOdjTJr9YHHVSMKcZQl6bx5ecwCHVW4X0JQtnd3ei7iX8y+1qAiTfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390578; c=relaxed/simple;
	bh=60b++oU64bR3hdczm3nMl9QKb4QsVVNXlpRRHAGyvtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ze+ox+VyGWcWz8Yt/FSQogfpDTq8LgEtYQ5VUGXzK/Ah89rQD5jgfOmhRzyWEFKqSuz1H4Ah9QiJTVizvdVnCp1wdl1CvClY3lIa2VT8wZMxmgYHDmcQOPsyictSEnOM5Z9U8UqgFhHTjpsvD2Whn8OzF9P1Y588i1RFWFKhSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+LPnc0M; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+LPnc0M"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so2340827a91.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788390575; x=1788995375; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qSDddEMP3f6RmPvCgvYdnz8wn2o/zSc7XyEc9xD4eok=;
        b=B+LPnc0ME/KGFsZDRHIdM/dXiFCiw2HxN9Nwc9VjQRVVqEkLnN2ry/p52AvyG40giz
         WeXO5zMl6AkBCbxJJcvUcza+/CycXHxMBMbVK2cfCuZr1zZVVTlZht5KNt1lkapvufjk
         aMlAMErpTV/4tHhOcol3xFb33ou3L6RkwXMcUfxqdgRa7cVL1ajln5g83XtrQh3g4V54
         JgEw1S5WZRL2NPMLsy8Re/yeALcMc6TrAIAq8Ak2G7gpLgxDxPNrTTUo2H7fMOFfYtRo
         i4VxEPj33nP/3F8E9+IvT+QzZMwsBcLysqfEI8mfJy5l7S736EeKme8E9HJntdkVFo3n
         hffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390575; x=1788995375;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSDddEMP3f6RmPvCgvYdnz8wn2o/zSc7XyEc9xD4eok=;
        b=nIwGFQ9st/WdeNPZLguyilgNkzZ+AKo6QnNlMgbNZnpsjiwda9Skb7YK+qx0yVqPGc
         uJ4uL+bk+4d0/AaEnmQln9JcNEnriBegm5hLR/3atD+fVa5yN9O7e4WtMlc0E7Hhwlbf
         w0/EgPCleXHk5VmjosIAlplBvrm5YyhkH6eyLiHqJHJn5CdCZ7XUYeWOcY529Cuc6f3j
         tL2W1XlASQKp0SMhW4DD0NLc4ucRKJqR3U9bzpkmM+6B5jyp4h5eKoN0h4L0FGk2SUQz
         KKynqb4uMaMLbxw8A5J9uvcSOz5a2DgdMAl7J9/Y/1BJUW/AjNgQrFF7VC8BuQIZQHv+
         axGQ==
X-Gm-Message-State: AFuF++kFkUH5wi95AC466lXCRspNGa5zsTYtAQ6kc2h+7sJbOQMiYpbW
	KuMlAhUkfKmF6CQ1oQ/bD7jyM7D78grwNypcT6I93xvPQLYVk23m7lsxlqkxpcE+LWgwcXPx1lK
	Vk5ShPA==
X-Received: from pjzp12.prod.google.com ([2002:a17:90b:10c:b0:398:df3f:7569])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cc:b0:396:b98b:a3c2
 with SMTP id 98e67ed59e1d1-39aedf1b1ecmr11061480a91.8.1788390574817; Wed, 02
 Sep 2026 16:09:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 16:09:30 -0700
In-Reply-To: <20260902230932.2760127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902230932.2760127-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902230932.2760127-2-seanjc@google.com>
Subject: [PATCH v3 1/3] KVM: x86/mmu: Use KVM's max TDP level to determine
 need for 32-bit TDP root
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When checking to see if KVM needs to allocate a TDP PAE root that's 32-bit
addressable, query KVM's overall max TDP level, not the vCPU-specific TDP
level, as the logic is specific to using NPT on 32-bit hosts.  Querying the
vCPU's alleged TDP level is flawed and confusing, as KVM selects between
4-level vs. 5-level based on the guest's MAXPHYADDR, and MAXPHYADDR isn't
yet configured (via CPUID) when the vCPU is being created.

I.e. as is, it would *appear* that KVM is violating its own rules with
respect to changing guest CPUID (see kvm_mmu_after_set_cpuid()).  In
practice, the flaw is benign as the goal is purely to see if KVM needs to
use PAE-paging; whether KVM will use 4-level vs. 5-level is irrelevant.

More importantly, avoiding kvm_mmu_get_tdp_level() during vCPU creation
will allow hardening KVM's handling of S-EPT mirror root level.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..c9a684151420 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6834,7 +6834,7 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, struct k
 	 * other exception is for shadowing L1's 32-bit or PAE NPT on 64-bit
 	 * KVM; that horror is handled on-demand by mmu_alloc_special_roots().
 	 */
-	if (tdp_enabled && kvm_mmu_get_tdp_level(vcpu) > PT32E_ROOT_LEVEL)
+	if (tdp_enabled && kvm_mmu_get_max_tdp_level() > PT32E_ROOT_LEVEL)
 		return 0;
 
 	page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_DMA32);
-- 
2.55.0.970.g62bdec98f9-goog

