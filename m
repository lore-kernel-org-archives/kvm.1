Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41823AA51E
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570337; cv=none; b=Xhp6ChcxRV1f/sX8EHLNDhxH/6Jj+I8d+AoVtmqBftHkLiPtTD27apl4SYm4acnX5qGy1ydlqXt65kkA5RMk6H5j44QvzUQaVneUoomrWkZtqTsYesxhiaWgtYSBOaLOG6cyYz/4mSy76l5HuZ4f/SXsXV4SBSJkxy6ATvqc8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570337; c=relaxed/simple;
	bh=ylcaWb4pIEbR23ZdlLhwm8VMl+24KioGkoOEx84Mtfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KTwSl2TAtkj5LEIYWPBf0fbUl0KTfl/KZdSZOYHKuU9pzAQ2qyLyPTHfHsN0HiUIpvFeD+M4knuKtuTsmQa0EvOZZGRhk0UqtlJgI29DJ7MrTtzNg7gn6uDWwojMGwZVKtxtkE7Uq5fN41aW3ZBD2xCPj2xRXCyd5ECCzTVOO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZoR5hdv; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZoR5hdv"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so121796a91.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570335; x=1787175135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X7o1gTaJ70kPDKsVaJGjUbRIL4z0HeVAXl6OlfOxtPw=;
        b=GZoR5hdvCRDZLZ3Ec5zH+27HI6y1A2+t/LZfksGSsirVq3dga+KZxzClF0Hf60DNTp
         gW5qBRPmKVs4+7cwjZCmBC6UgHTgMg71d0rKoOiXepu8ljt2agPQycZtBRTjVapxIXVp
         4gA8/HsIX9hlJCblRdL6FUhPiclLnbwRQMeXBoUteSxiIi7U6C3AfWNlTfkTsvQLJxDX
         AM+r1uQ9LAhYV2KL5DqDCVBV+pNMI3F0ltb8FJKwceZW+JOqMp447bGf45tT1eXIXxb/
         yUDonLQdUEO1iyX1xVPUF80ZMnVb14Ckw9pTaaPhZW0qLXiI15yXkoyh2wjU025J5zEi
         MNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570335; x=1787175135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X7o1gTaJ70kPDKsVaJGjUbRIL4z0HeVAXl6OlfOxtPw=;
        b=a4PBoiAvENY1A+1KcORPDg51tvQ34tVHOdIRmIVC4FA7qJ4RcaXfDJs+89pcVFT5gU
         xLLnqNRDWoITZa9PFolp2RZ6lK0ICHiVhg0THnW0uX6XaVVNfoJ4I7Yz8IZ7kqXH6BPX
         1XV34orpQQoectWCpsV/ApPeUWVdf/JhCLP/iE8pRMbBrY7FfLa9K1lUEOkgyRBenTR5
         oUOQPLJJggjJtq6kdHLwHR55nOQi27NrfOTc82p3rZ2R+FHOfSvAuL0t8tR48D3JM6Da
         i1PgoXWO3MvTmrurc/4KES56xHK4r3UvgKstJhlkubGy2KBYIyPWcooIYdkwnOu6FQLe
         hqqA==
X-Gm-Message-State: AOJu0YwZl4QQ+iWr0OICLyYBbyDi9dlWpFpFCMoJw+aAbVvZ3ayRQGI6
	Tb9D499IKQPSc8m4bKqP3dpGeExuebW9Fktx2ReSqZ1pd/tj/OSLEoxWxskp8b9jFrjnOB8iyct
	2GRaviQ==
X-Received: from pjhk3.prod.google.com ([2002:a17:90a:4c83:b0:381:5fcd:c992])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3947:b0:393:1cf4:d972
 with SMTP id 98e67ed59e1d1-3931dfd3b39mr1565661a91.3.1786570334949; Wed, 12
 Aug 2026 14:32:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:32:01 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: MMU changes for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Two fixes for bugs in the lockless aging code, plus a related hardening in the
same code.

The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f370:

  Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-7.3

for you to fetch changes up to fb25ee778aae357da2c1a8dc1d240b6061482454:

  KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in the shadow MMU (2026-07-29 05:44:24 -0700)

----------------------------------------------------------------
KVM x86 MMU changes for 7.3

 - Fix a bug where KVM would walk a newly created rmap without holding the rmap
   lock (or mmu_lock) during aging.

 - Fix a bug where aging TDP MMU SPTEs could clobber FROZEN SPTEs.

----------------------------------------------------------------
Phil Rosenthal (1):
      KVM: x86/mmu: Consume the locked rmap value in the lockless rmap walk

Sean Christopherson (2):
      KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in TDP MMU
      KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in the shadow MMU

 arch/x86/kvm/mmu/mmu.c      | 58 +++++++++++++++++++++++++--------------------
 arch/x86/kvm/mmu/tdp_iter.h |  7 ++++++
 arch/x86/kvm/mmu/tdp_mmu.c  | 20 +++++++---------
 3 files changed, 48 insertions(+), 37 deletions(-)
