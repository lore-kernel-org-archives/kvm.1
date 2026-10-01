Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B0B5304C7
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886179; cv=none; b=M+1bfnaSqQyYzpMnQNYha3lcBfBB6Xnm9vqIQ7ZM1n2cvNvF8IdLtTFpEyI5lEB5+vreUXifIacCzDs23Er/NnTGqAQeG6cxudxlhapZE3xJnD80vihbT+DM2jaSLkW9DWJwiHcUBgOuoO7I1X3o6N14ImbIgU5QDuNsTIDCmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886179; c=relaxed/simple;
	bh=xWmI4R5U22NJjAIxqajbiTM9PPBEDTvKud9hixV72Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=htXhTw81T0OcK8niV99ZV6wvqd9A9oxgUJBqxD2MVoB/eDiF7FSGSBb3zMCrjyPxLu38VBLvmaoPyfTki3OQNIfbw2pzW6fURLPsTgW5aiI6ucnghupgGDAY9Rs66E7pdcjMBhihdVuPnGZXN/qZBjHs7Y9AStUq2kWc8sYDh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bD9lELGM; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bD9lELGM"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39533bb224cso9512457a91.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790886169; x=1791490969; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=odUI0VjKINbAApKe2J4PsRbiL/cueYQz4jU79+gDb2k=;
        b=bD9lELGMDXUxOUCnN5VTR+kguxiy+a8p0DtnBvKnx+TRRLdsK8NtV08MJdN5zLFJHV
         puBaSLMjzeJXWY0PBe0g787BILr3O/1n8r4MUpIMakD/PkVRs4kgREytGddJ84LuQH2/
         IjHCKOElIBOh1kQZuDEKxhz0SIpnurmSZ8eaElvXdZqgBjAOXVhbdiSZJMneaf2aCdf8
         oTcEU4KmlA+rUZWz2BpH02B9VcPbsm7GAzL+3Q3j+nl1g7PCLCZgbNImSRS32gt7rEDg
         qUNJVIQFBmDkNSYFxFjF1fzWrc67sYb/23YP7wsTkG5X61aTIw6PiPLyNDOTKq9oYWcd
         yqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886169; x=1791490969;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=odUI0VjKINbAApKe2J4PsRbiL/cueYQz4jU79+gDb2k=;
        b=0z/h3gI7EjsQmxCFwwnh5AvK60VxwxHFwSAA2G9QmhIG+to7og2ITp5w2LGbUgtiSL
         DHWjTM7u2r+5+ecYipYfx3Fcf0W8bH3AoJqIVjIxF4tD8yDrfcUSdR7poiRqP5sUQS/+
         vj91AjMHYlfilaAL1W2Rw3IESE3ck0d014kCrUYyO9B60UMOiP2f3+NGQQ7rYhS1Frxu
         yyPxXMGl//ozJ46ZhYWW2EeHh3trC/pr53F1B9lSnUSzGCDSDfvjapLw5VzKOC/uqDwS
         8pGSLZVVcf/jOYPqg1yw0DkB9/PhmBxM3tmbYQ0tRVBnH3vURQjVDQgb5g0Wttt4KU8R
         ge5g==
X-Forwarded-Encrypted: i=1; AKwUvBwvzFelmXpI7KCkNtdmkSsNIb5vgp3Mh3jfFLfNQXCYL9LFEksWsMPvpZwBOGbK3PUq8I0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1GPViRVyPQ8f/sUF/EiI5Hn0ZX2V1HkJshHPZprOOOplWduCR
	dhv3YoDW6kyU9k6LTHmZ66Q33B+nq+Z91WvWuA/c7U4JHecr8QanJp8q3Qx9Ht5F1piojFzoRzc
	id+YN/A==
X-Received: from pjxd7.prod.google.com ([2002:a17:90a:c247:b0:3a2:a95e:c620])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268a:b0:39e:2e79:7ce7
 with SMTP id 98e67ed59e1d1-3a6ce3b937amr517701a91.6.1790886169237; Thu, 01
 Oct 2026 13:22:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Oct 2026 13:22:30 -0700
In-Reply-To: <20261001202234.3794060-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001202234.3794060-7-seanjc@google.com>
Subject: [PATCH v2 06/10] KVM: WARN if KVM attempts to do guest-related
 uaccess with "wrong" process
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that memslots are torn down before kvm_arch_destroy_vm(), i.e. now that
the massive, unaudited path that is known to have at least one rogue access
to guest memory should be short-circuited before attempting to access user
memory, WARN if KVM attempts to do a user access to guest memory with the
wrong address space.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b37cf275ef79..2a88e4ce145e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1352,7 +1352,7 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 
 static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *kvm)
 {
-	return current->mm == kvm->mm;
+	return !WARN_ON_ONCE(current->mm != kvm->mm);
 }
 
 #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)				\
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

