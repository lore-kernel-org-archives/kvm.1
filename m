Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B83043BE
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093270; cv=none; b=nS5EqGT3ae3B8xD+kxvdG0TWgVSF5wi5+xmqM7hBpQMmYJ3pTyfu1LBEh9z6U+646I/GF3XnsphmT1osY3YRvOIvc6+5hlyBB2v5IS8TB2dyIjdE1XehFm5GFVD0ifi9HhAItzSymzGDIdvVSFc3GzEoGJraX+kiho26Lm+qkMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093270; c=relaxed/simple;
	bh=egDmVC+L4CnhwGoGFYN17GS2xkBTIlCAIgU9BuFEpXk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BlavahdHSbJQAPxhFqBlXDlXpwPQaiH+Babu0ahHpcnXHzFv1wSyivJB/j/l4XCfIEvKKD1RrBdQaUDiXriK1OEN5v90sgPB4kctsHLWZKEg+FSPn3xwGuPT1/ne5feMCxPxhe9i2O6JL3iiLQzRwLJuWgzTPjJHyF0PRz+3djk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHGEDSDA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHGEDSDA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso1562283a91.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778093269; x=1778698069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdAMN9DNgVhTpc3Wteu3bMAqEiO2nA16VLDVhLyXKOc=;
        b=FHGEDSDArSw7pXHt26Xo7v3pz9y/Q+b0V6SNTFf1BxTK/iWX4QzIU96VclFk6t+9sY
         AMiDwdXpZRMtQz/gCKslHGPvAqhX9BBcunwryoSiLthdl3xemQXhCF6yjPmrGKBHDwt8
         iTLIV4KGBn/3Adon7vBG4ze3GzUIXgMNnVGXNmJuVQ35JE4GsKa2vR/8PRW7t2sZGZFK
         nnpa0BeFHaKffJTc8tzKjO3LksnY3f/NXDxC8A8squyRgvlIgKu3Bn/YADAn7yp5glst
         Xqo7bZ5WN2lGH1gdneBi7XJWgHmysVeUIa8Z4Z3I+LoFJJib0EDok4KuB1/b/qOziHjV
         fQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778093269; x=1778698069;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdAMN9DNgVhTpc3Wteu3bMAqEiO2nA16VLDVhLyXKOc=;
        b=iK4lfYx0lOm09lHAC59t25xUtpRCGOEiP47qz+tT2jUfbytcFOH06jnJHuTNsBQoHq
         e9Oms+qnqalU7kyRBdkoePJURakeOHR4vvedafKX1GpL1KHoClpjN98sYHl7mBIBo8/M
         m842RC54aBCtC9m4SvEQJYFfogJEulPszFCHJjkbxaIt8ZvZM/0/tuBi+hqHA3Ne3whL
         9XH/S+ZVy9gTMIUbLGWKmUBAgfbNnELd720VSF+o33s0aXsOaxi7Ir1puxL1YaEElpuZ
         agGSvUHcYxHVpVXGJtJbzeQOODY75vEzc/UaeCxDUAY+OFww3lhuY2OzdTMveWk7lM0q
         nSew==
X-Gm-Message-State: AOJu0Yyo5w/pLYNin9ks96RcduZJEl/UePQ8oMwxurfSy3V3/qC9VHs2
	EdNVN6V474lLCgkgwGRH7oa4w6f+CDYL/s7J+muru9KV41LNtdwM5Odd4fMcKCKGfs5yZ2M21TO
	TJ2UUJg==
X-Received: from pgbcr5.prod.google.com ([2002:a05:6a02:4105:b0:c74:1130:c2ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12ce:b0:3a0:c285:e511
 with SMTP id adf61e73a8af0-3aa5a2e8018mr4662391637.24.1778093268622; Wed, 06
 May 2026 11:47:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 May 2026 11:47:41 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506184746.2719880-1-seanjc@google.com>
Subject: [PATCH v2 0/5] KVM: SVM: Fix x2AVIC MSR interception issues
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix a variety of bugs in SVM's handling of x2APIC MSR passthrough for x2AVIC,
where KVM disables interception for MSR accesses that aren't accelerated by
hardware (pointless and suboptimal), and also does NOT disable interception
for practically any of the "range of vectors" MSRs, i.e. IRR, ISR, and TMR.

Found by inspection when reviewing a TDX patch to fix a bug where KVM botched
the "range of vectors"[*] (I was curious how other KVM code handled the ranges;
wasn't expecting this...).

Note, I tagged all of this for stable, but I could be convinced these fixes
shouldn't be sent to LTS trees.  Patch 3 in particular doesn't truly fix
anything, though I definitely don't like relying on poorly documented behavior.

Note #2, the diff stats are misleading due to the hacks, the "real" stats are:

  arch/x86/kvm/svm/avic.c | 51 ++++++++++++++++-----------------------------------
  1 file changed, 16 insertions(+), 35 deletions(-)

[*] https://lore.kernel.org/all/20260318190111.1041924-1-dmaluka@chromium.org

v2:
 - Actually iterate over the mask of readable regs. [Naveen]
 - Rewrite the changelog for patch 3 to more accurately capture what happens,
   and to avoid conflating "unaccelerated" with "fault-like". [Naveen]
 - Massage the changlog for patch 1 to describe the observed behavior of
   DFR and ICR2.
 - Test the #VMEXIT (or not) behavior with hacks (patches 4 and 5).

v1: https://lore.kernel.org/all/20260409222449.2013847-1-seanjc@google.com

Sean Christopherson (5):
  KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM actually
    supports
  KVM: SVM: Always intercept RDMSR for TMCCT (current APIC timer count)
  KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs that are
    accelerated
  *** DO NOT MERGE *** KVM: x86: Hack in a stat to track guest-induced
    exits (for testing)
  *** DO NOT MERGE *** KVM: selftests: Add hacky test to verify x2APIC
    MSR interception

 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/kvm/svm/avic.c                       |  51 ++--
 arch/x86/kvm/svm/svm.c                        |  81 +++++++
 arch/x86/kvm/vmx/vmx.c                        |  79 +++++++
 arch/x86/kvm/x86.c                            |   2 +
 .../testing/selftests/kvm/include/x86/apic.h  |  84 ++++++-
 .../selftests/kvm/x86/fix_hypercall_test.c    |   2 +-
 .../selftests/kvm/x86/xapic_ipi_test.c        |   4 +-
 .../selftests/kvm/x86/xapic_state_test.c      | 217 ++++++++++++++++++
 9 files changed, 476 insertions(+), 46 deletions(-)


base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.54.0.545.g6539524ca2-goog

