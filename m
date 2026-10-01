Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C55304CD
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886183; cv=none; b=INNptPiK+eAclmgG+ficFQSxEmwJ59vG5koikfyRjWZU0JvFHiWs/2Mpdhp/x8tRH7OXpvaKnhiuPPU+tkdmUavB4FhJeXIjHWS7/nf8cynr9qrA7SRgGuqAPYLfT8mOkvRameLt2lFKubIyfOCoZ5+AQb0ZDpU6HZ5TfVgpC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886183; c=relaxed/simple;
	bh=JGW66+fksOuAWcuF65JwSbi50K49sA9rXZLskdwcSRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EgF0VbBm8IumaT/l0Kxj2Ax9G6401kcYeqDwSt5NBU3YoX/KVqsEJzC7Yt65zDVPx/051xWIsYFhbv6L8ENSIAUsfe7ZsyJw2/8waNXyYw1cc5AaBoDCZ7ZsYrImANr+s7kw8PkMyTUu+VvTX9+/TRlRXyZnuHRQsTEKvWcwhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a1u+shPQ; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1u+shPQ"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so15169272a91.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886171; x=1791490971; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y0J6VXN5lFwBxZJKWuWa6CerLz6QV8Oo4iFC23tHaiM=;
        b=a1u+shPQQB9GrSNmIHtBrmFcqPgo6H0FIG3rkVTy8sPR1w41/LR2jxSn4vlMBBr9W8
         NodlnAH0TAGYwW1fIw8YSenNQIsvfg7HS4e7+FruEhv0pGQGblEHE6UwV/5UR7QHHGMm
         D1bYHskx90mD3tO1Jb5mCRC7k7zRuM8fJs9pejf2X3AnG94XfnFXmkEYEVlxDquUgJga
         nPwuzCsEhWuLEhyPrSYFxOijMjgs9Qgf+uP9WJfeUi9BYKWw5vdxage9cTUdYZh4xs7E
         NsXBaA7W2eQgRUYgs5WOaaws+a3UcmoclJDiL1JqiOPTxZTL5oROakYqpvKL3aDtDIrs
         L9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886171; x=1791490971;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y0J6VXN5lFwBxZJKWuWa6CerLz6QV8Oo4iFC23tHaiM=;
        b=YiidgDqE5nGn6kfTZ/XhsjiupBMbspv/Cw6VnQbth9mqimzbSx+vSb1Qm8Dl488WhI
         +oyxun6fbbSDjfgDSWB/3kBYRD1DjMQXTjHAWCBcROEjRNsKDRd3UhZiRMKLcaCfhII6
         CVrg5oHjZYkoHe6loeilgsnKRli1xkd/2OE9ICqMDERMM4gPNSFDjxF5kPrQwGXZSnZX
         dMW+11ACP+D9XbKNyk/OJXVVA4NlYjnNlH8dmAHfT36bJKfvBKFLVxxiCck0xJ0Bpdwp
         g71TokHgEL+KMaN+PMs4j09RC2RK2D6OrYnXcY8SKargITl4IUrB8kIBdk3P2+AwjZle
         8xNw==
X-Forwarded-Encrypted: i=1; AKwUvBzeIdtcR+mKkLBOfLxg2kFN1WkloSgvEG4dSH+102hpoPdHoMmV65iw3Tqj7aDVpGa2YPw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRWB6ETYuXiGDc+BoyC4BXtrsqpEO4ps2hIU5BeeYRJ8BIjjva
	aD+eYPjyWZB91Bh1jZe5XLtYLqxvPO6VUUNeoP+kaDmumhJHbfOf75y9PGVkWrWwGBwkCvQmYDD
	OgorWNg==
X-Received: from pjye1.prod.google.com ([2002:a17:90a:ee01:b0:3a4:fd38:2765])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e4f:b0:3a0:e163:fbba
 with SMTP id 98e67ed59e1d1-3a6ce9ae034mr628788a91.16.1790886170475; Thu, 01
 Oct 2026 13:22:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:31 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-8-seanjc@google.com>
Subject: [PATCH v2 07/10] KVM: WARN and reject guest-based uaccess if VM is dying
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN and reject user accesses to guest memory if the associated VM is dying
even if the current address space happens to be the correct address space.
Accessing guest memory after the last reference to the VM has been put may
be "fine" from a safety perspective, but it's still a KVM bug.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2a88e4ce145e..0ee81754d730 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1352,7 +1352,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return !WARN_ON_ONCE(current->mm != kvm->mm);
+	return !WARN_ON_ONCE(current->mm != kvm->mm ||
+			     !refcount_read(&kvm->users_count));
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

