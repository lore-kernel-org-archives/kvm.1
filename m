Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306351DDEE
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789859; cv=none; b=iRgdeRi5CJd5H4oliQxLLyn9ARjC73yY/Vg08bboX4qlQ8QN92BZNLH8kJ4+NMCHivcFMcRf/y/Ek/KuzXbI6yQqGzjD5crJHsLvuZfTN9CrPj9A1ODKROEk/EopKIGxFJGyda6KiCjOYVwjvaKJ4dwTKtrjHxFoa6k0BNXUz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789859; c=relaxed/simple;
	bh=UWacRjQlh4d1Fl+CPKlFch02V++rzThfMQRQNDA+XJ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ETyu1GEIO6IAJjUwSQzu2Daazg0RodgbbqWu13qAlE8Sb6yjJdHl8a8W54UzczGSZRlUHqwGuzRX82H69g6FxYLlWhAETx62kCYhlC+nIreb60Btwr6f3lj7SGrAA4wITwUqVi4RCwqFxB9EBb62qaEvsiiVEaKXI2czJ6nHg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tAQHe8tC; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tAQHe8tC"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d94a158dc8so80232215ad.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789857; x=1791394657; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cNqhwEq/5Wo22YWPaJRBan5K+YDcXnVOo2pVSItBxtg=;
        b=tAQHe8tCaJ35eQMJPMrcgv54jXRQREc8Fa0KLmDrMf6fyVsYtieqymTHMRW1nlL8qj
         uln/05Vo9oHhfM8KZePpxyF5T21nXa0Sl8HSLXsZ5j0C39460OwmfQRYSyncVn+G3Jei
         tf7eacP0qJavkzioaM/XdzxuswThKAp/OpWBzRK64FPYLmUEOAj+EWiYhwCxmnX0IE5A
         AePZhLeS9TnzcJpsBATnFfMgGfYRX3dnV0tYqzCoYYErHo2c3q2vIadu6G9nRdudSFQM
         J+NGXzOE9UuRD/2lFVeJ7mqA7M55mhN0IBrH5GbM+jJJTxmmT2KBrPOfKKpXDnStUc/e
         DU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789857; x=1791394657;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cNqhwEq/5Wo22YWPaJRBan5K+YDcXnVOo2pVSItBxtg=;
        b=KG5qC8fI34Zze2nSC2wBJbreOs7H2a4SiagUdrjFvAbbfMXe2+GP25oRXOe6fmGfGX
         Mx2Gso84ZNaSZ1/dT2KyiXKVfjCHNa9yG8dUxaBvqXSNS0SasxGG7JDUhFrc2oWDs6ne
         a5c06kdSIHnz0s4XZHDIH+DAibljrhUCTmY7LkH3c9XGUCakCj0xDCeK0rABE35B85Il
         OUqWJ1zOWIicsJMpXyjHoFPu4WdAAiVZrT0K3PFGS9WAINSUy8BtPSqZxTWH2Xa7p85W
         o0GrDwkFvCLv+FlHGimKi16oVSboMoLSBeHRV0rYOZfP0pzA1BMu7NYKLQJZ7nM81Y24
         PcGQ==
X-Gm-Message-State: AFq9FYIxzxsKy4AWL86ggWBmGEyI4FoM59I76bWMkc9UJk8UXNUgNwy4
	j24WyAvtKM0B/vMbi03i5tIphSlIRKyHt6g22TkAYMCKA86y2QW08AwzCQeOf4nmawsChoxRywB
	iE1Cu+w==
X-Received: from plec2.prod.google.com ([2002:a17:902:f302:b0:2e1:2dd1:e080])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19c3:b0:2d6:f988:398f
 with SMTP id d9443c01a7336-2e2e498a3d6mr18024015ad.12.1790789856985; Wed, 30
 Sep 2026 10:37:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:14 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-1-seanjc@google.com>
Subject: [PATCH v3 00/21] KVM: x86: Fix nested TSC scaling edge cases
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Amirmohammad's fix to saturate L2's TSC frequency when stacking scale up/down
ratios across L1+L2 yields a final scaling ratio that can't be plugged into
hardware.  The actual fix is functionally the same as v2, but I rewrote the
comments and changelog to try and make them more approachable to KVM developers
(AI has a habit of generating extremely verbose, "mathy" descriptions of bugs
and fixes).

Patch 2 fixes a flaw pointed out by Sashiko.

Patch 3 fixes an off-by-one issue in KVM_SET_TSC_KHZ that is a complete
non-issue in practice, but confused the heck out of me and made writing the
testcases unnecessarily annoying.

The rest of the pile extends and cleans up the nested TSC scaling test to
validate the saturation fixes, and to test all four combinations of scaling
L1+L2 up+down (the existing code testing only L1 down, L2 up).

v2: https://lore.kernel.org/all/20260723182159.2320033-1-amirmohammad.eftekhar@cispa.de

Amirmohammad Eftekhar (1):
  KVM: x86: Saturate L2's TSC frequency if it exceeds hardware supports

Sean Christopherson (20):
  KVM: SVM: Fallback to the default TSC ratio if KVM tries to use a bad
    multiplier
  KVM: x86: Allow userspace to set KVM's max supported guest TSC
    frequency
  KVM: selftests: Use KVM's pRNG to randomize L1's TSC ratio in TSC
    scaling test
  KVM: selftests: Drop redundant VMWRITE of TSC_MULTIPLIER_HIGH
  KVM: selftests: Drop unnecessary use of PRIu64 in nested TSC scaling
    test
  KVM: selftests: Randomize L2's scale factor in nested TSC scaling test
  KVM: selftests: Rename TSC freq checkers in nested TSC scaling test
  KVM: selftests: Extract guts of nested TSC scaling test to helper
    function
  KVM: selftests: Track L2 multiplier, not scale-up factor, in nested
    TSC test
  KVM: selftests: Print out the failing L{0,1,2} level in nested TSC
    scaling test
  KVM: selftests: Allow +/- 1 tolerance if expected TSC frequency is
    <100
  KVM: selftests: Use KVM's reported TSC KHz as L0's frequency (sanity
    checked)
  KVM: selftests: Explicitly pass TSC frequencies to guts of TSC scaling
    test
  KVM: selftests: Sanity check KVM's default TSC freq in nested TSC
    scaling test
  KVM: selftests: Test L1 "up" and L2 "down" in nested TSC scaling test
  KVM: selftests: Verify that KVM saturates L2 TSC freq on
    {under,over}flow
  KVM: selftests: Test non-zero TSC offset on SVM in nested TSC scaling
    test
  KVM: selftests: Randomize L2's TSC offset in the nested TSC scaling
    test
  KVM: selftests: Use GUEST_SYNC2() in nested TSC scaling test
  KVM: selftests: Spell out UCALL in nested TSC scaling test's enums

 arch/x86/kvm/svm/svm.c                        |   9 +
 arch/x86/kvm/x86.c                            |  62 ++++-
 .../kvm/x86/nested_tsc_scaling_test.c         | 232 +++++++++++-------
 3 files changed, 209 insertions(+), 94 deletions(-)


base-commit: b378201ccd5280d0fff89bbe55e1eb00620ec0d5
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

