Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219172;
	b=S7XdgCVpAlrrX0Gpz7VSUv9c0kHPBcAwwhGUE2Ad+DLlgEpYgpTwSY8VV6n0nXTDyUHi
	 ymjRDBTn/n0e6/KOB2gD56WnSaOvKKa0le29MfAuvc4yNkEMMSmiAX8s3HxYFXnXuov2l
	 npdeWQ6o5no9rj1Vyw7S0vWM9RA1yxQkHTQrhoIfXGB4jWxMQ81n5mIVKWfcbDqWExNXp
	 /EdxVXSFBtKPhiCx91Z9QAvzT4GKYI6sAachaIIcgHKnl+1s2gTNiIVHwHYfxZMwFtDqf
	 mGTKk8FDKd4ahAU7iEsvOHZ9zeONMrX1rwN/+EHLQok9WuXiXzlPRbM90+G8spTP+cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:Mime-Version:X-Mailer:
	 Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/qPpQQmO9ig1zLr2iGAaOV6msz38LBpEJQaB5Dd9wdE=;
	b=Q8gMJUDUn0h0JoLNapE/4U5yloxeRMGHMNrp9MkY1NkZaQD5hWkKszojxqIJxIqfbRGx
	 +MUcz4fiIUZaCUpLo4AoVdtIH2KACvmO5YWhNolGS+Lo6g0v81/k4J6FvhaR4XF1WVDSc
	 JWK/jwRkQtorGVuApbhJ9KkQC4K3eOBq1kXgUCbdC81M+nCfsHGCvE1ysKQd+CwkZM13S
	 pdHFFF1TU51pqIUqeEYnu7mUcaOTi1VjIyqkegOHX8CVDRRuTOnvftME+FLCOdYfJPKzj
	 zeSXF7sziPazce1HkkYfXBkic85eo/oX/XiQ6b6UXFjjhxHKgnt19xuw69anz5v8Ysg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a6T2S3a+;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66992606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66992606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a6T2S3a+
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-887c99013edso886191b3a.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793219171; x=1793823971; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/qPpQQmO9ig1zLr2iGAaOV6msz38LBpEJQaB5Dd9wdE=;
        b=a6T2S3a+yysI0CuKbksCQXxA9WbdF3tA6htelq1ZU9zBZ2sdzie/TADil2uKEHcsqG
         vxETDJuWb8TDtlVEkVGvPNvVTTLn4jZ8L+7LQlHpslF0j8XoAYNGDL13LZCBk9CipLLg
         pyIVlkDIiAUQXNKJkdJXQQSDCXPQtkyip+ZRZOi/a3IJOggbcTDAIOMsoz1caOU1G04o
         bdhUSqoDXJU6KKUGlYXwYTZVEFlMTkRvcboVPwuSehCu/QKGTQFF/LraNtQaTQvWRmEN
         Efr2p/h1r2ejTbHx8w6SZm04kAaSv8ffrrcYc5KnF+9JXR04jGXg+ujo7YMEU1JncQMq
         qaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219171; x=1793823971;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/qPpQQmO9ig1zLr2iGAaOV6msz38LBpEJQaB5Dd9wdE=;
        b=QpmRYSZ3987HHTdUN+bFVzZSFXuaa5Y3qNC5VQZ3o6Cwm8E5+StLWBPVnhK8icYL4J
         oU4d8hOjah9nqohH/ivO5CtLMmilSqL1uFoBwjjUdeZX4OM6LI9GXX/sQJErO4g43aJ3
         P4tI2rOWc8N/vD8oS3KatVyYsWTnDQmu9EfNrPrkdErzVArxF25Zp3mU/O/BwvD94ztW
         fsnolen8kRhbw95GtVSEn/GJ+fjDEpCX9iAVO6I/tdLzeiKsw7VURx4Swps3/6Y/OkZT
         rzpVve84qXYPwGzcZWwXwqdFzpgiPaxBcraHNuUh7QYouJubmjHiq6IqdV7DEULI5yUx
         boGg==
X-Gm-Message-State: AFq9FYIKlhcDziN9utQLatCU/gZ7VwO/BftF0Jifioljg8Rr0l7QS1RR
	3OS8cr5uDDi4qZn14cpStFq9iRTQaDbeyW+FgViDN0V9mmkKP/TsiEYoL43gZXvLfUjvk/wzMxm
	DcbZp6g==
X-Received: from pfn28.prod.google.com ([2002:a05:6a00:a21c:b0:89f:3d5c:8c07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918e:b0:3e2:257a:a61f
 with SMTP id adf61e73a8af0-3e9023b6729mr3014183637.59.1793219170423; Wed, 28
 Oct 2026 13:26:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 13:26:03 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028202607.1844883-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: x86/mmu: Add auto-prefetch to the TDP MMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Marangoni <mamarang@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Add auto-prefetch to the TDP MMU, where "auto-prefetch" means the existing
prefetch in the shadow MMU where KVM grabs the surrounding ~8 SPTEs on a page
fault, when possible.

Rather than implement yet another custom solution, reuse the core functionality
from KVM_PRE_FAULT_MEMORY.  Doing so has several benefits, and a few drawbacks.
The big benefits are code reuse, reduced maintainence burden improved test
coverage (auto-prefetching exposed a variety of pre-existing issues in the
pre-fault code), and support for any backing store (the shadow MMU's approach
only works for fast-GUP, i.e. only for refcounted struct page memory).

The big drawback is that using the pre-fault code is "heavier" than the custom
prefetching code in the shadow MMU.  In a nutshell, this approach can't achieve
the same performance uplift at least not without additional tweaking (which may
or may not be acceptable; I genuinely haven't thought at all about how we could
close the gap, mainly because it's not clear that we *need* to close the gap).

There are a few subjective decisions in here.  The main one I want to call out
is that I chose to treat async #PF prefetching as manual/explicit prefetching,
versus automatic prefetching.  Manual prefetching will do more invasive
operations like punch through dirty logging and wait for I/O, whereas automatic
prefetching avoids spurious dirty logging and tries to avoid waiting on "major"
faults.  This series preserves the existing behavior, but I spent enough time
waffling on whether or not that was the right choice that I wanted to call it
out here.

Sean Christopherson (4):
  KVM: x86/mmu: Rework gfn_to_memslot_dirty_bitmap() into auto-prefetch
    helper
  KVM: x86/mmu: Differentiate between manual and automatic prefetching
  KVM: x86/mmu: Add automatic prefaulting/prefetching for TDP MMU faults
  KVM: x86/mmu: Use the generic auto-prefaulting to do prefetch for
    direct MMUs

 arch/x86/kvm/mmu/mmu.c          | 156 +++++++++++++++++++-------------
 arch/x86/kvm/mmu/mmu_internal.h |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h  |   2 +-
 3 files changed, 97 insertions(+), 62 deletions(-)


base-commit: 7e60162b16f9da0d2fa83da5c1723b6853a0ac1d
-- 
2.56.0.313.g2479322e68-goog

