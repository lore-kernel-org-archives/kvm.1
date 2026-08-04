Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740543C73D1
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877251; cv=none; b=aqgcidz7+J9O0SSQDOQYA+JMBIZ4TqGr3eom/gBl5+iHZQ1f/F3LqP3KPUomC8eg4hf0HBAwFzLvTpzoAZmB7X3qHTRkJiAKLnkMvdvpVy4n9FPzox0054Natk/UWGDtOihAHqTC5friDKWN4HIMqVSVj/aA3nxUN49NWMD5RZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877251; c=relaxed/simple;
	bh=OjMPFaCqIgrWzTBXeilssj79ZP8+mzPKddW3RhC43O4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qFXfWLYfsriJgvTQ3yaNot+XFkjIs5SRDyjcXNaAYtv3pvrzRkFr/jHCln4vtl5uznbIxNHAQLeh3tjfkbGNlaDsu1eb434T94WPCR7TJzNm7c65jOjyQj6OTMLPymd7/tVe3SBVRa/rF1K2uVvDl5tYBbIvY5j+Y24UChc0NsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APzQibDE; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APzQibDE"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848d21bbb55so414672b3a.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 14:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785877249; x=1786482049; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3i3TcWKLRQF+gyvl9R4u/4p1LucwwR0F1GEdHIhJ5Fk=;
        b=APzQibDEFFp6JtgAVsslj7QPTLhavmmx1tP0NCvj31A8kLzyiJlUybj5a4khspB1BW
         8nCI26Xgka2MDiFIvx6ZokK4HPeWVEmd2LwuUvVdjIeTFRJn4EtsXsTS6afwDYRstPxG
         XhpqAC7I2H5QN3veQS/wVUkKnoQsQsLoEMc9LmdiSH1O/D4Fog+t0LrqQCAhzYksUIKE
         eKi6IALlgGCIBhXlQSMbetNICE1LiITgXoHfBEnKCTaQssHMyWyQ0o5Dv2mC3KbWb4Ct
         LgRDffdx7K22jH1LG/IuC/v0mMUkUtX+3/Ab1xoClo0ktXRbqUMUEn6b+r+6A7ipiSOc
         dmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785877249; x=1786482049;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3i3TcWKLRQF+gyvl9R4u/4p1LucwwR0F1GEdHIhJ5Fk=;
        b=CmOzt6VHi3+DA0RsSqIvggkFSms93I/+CjkGHkw45ZbK0z+U8DI2Pd1z0UCbjN8gAf
         6EMyXKhHO1VR3RFmwIr3gTVlo+dqxn6crkPhgVT8P2+cxU3wzQxi3/fRTtFs8yOm4iA3
         +ozaDVKkYr+zCP9Mk/kdZZyVqMSpIvB+q0IL3quaUStR4pfHD7k91pv5AFEpRg+W8lwh
         RjV2l5+FlA1POtd7M8brDMTTvPIMVpkVepIcEqD5apqYJ8T2BAurtQv4SIX5yZenlWgI
         Pyx8dCKYMDlXcBiFVjNJh5yrRCQH6JxNbL8yvSFQgcMaT8ZozCPxsOifhMLYkugfRj8x
         k9sQ==
X-Gm-Message-State: AOJu0YyhdRmvFwOrUF9FCg20o/Va8ulxKb237C6h/jdyls7DZ3+sxfP9
	fwyleYJzR4ADkx/nz9I+P7bD/UwCFsqAuaeT6r2RzOC+Rhf000k84dzgMo6f3Kb8B1ECPpdjIGR
	bkVUcsQ==
X-Received: from pfbgo18.prod.google.com ([2002:a05:6a00:3b12:b0:848:48a0:41e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cd6:b0:848:4754:28e4
 with SMTP id d2e1a72fcca58-84f2dff6972mr1505038b3a.15.1785877248575; Tue, 04
 Aug 2026 14:00:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 14:00:44 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804210046.3413149-1-seanjc@google.com>
Subject: [PATCH v3 0/2] KVM: selftests: Reduce PMC test runtime by ~17x
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reduce the runtime of the PMU counters test on an Emerald Rapids system from
~85 seconds to ~5 seconds by (a) testing one random GP counter in the arch
events test instead of every GP counter and (b) creating one large VM per
"major" test and then running each subtest with a different vCPUs, versus
creating a new single-vCPU VM for every subtest.

AFAICT, there aren't any bugs anywhere in the VM creation flow, there's just
a lot of work to be done.  And VM creation isn't even that slow, but creating
something like 1000+ VMs for the test adds up.

v3:
 - Allocate an array of vCPU pointers, not an array of vCPUs. [Sashiko]
 - Fix a copy+paste goof that caused the GP counters test to always run with
   the maximum number of GP counters. [Sashiko]
 - Fix a (benign) off-by-one error in the arch events tests. [Sashiko]

v2:
 - Fail hard.  Pretend this version doesn't exist.
 - https://lore.kernel.org/all/20260804204048.3401810-1-seanjc@google.com

v1: https://lore.kernel.org/all/20260804173437.3339269-1-seanjc@google.com


Sean Christopherson (2):
  KVM: selftests: Test one random GP counter in PMU arch events testcase
  KVM: selftests: Create one VM with many vCPUs for each major PMU
    counters test

 .../testing/selftests/kvm/include/test_util.h |   4 +-
 tools/testing/selftests/kvm/lib/test_util.c   |  22 +-
 .../selftests/kvm/x86/pmu_counters_test.c     | 229 ++++++++++--------
 3 files changed, 149 insertions(+), 106 deletions(-)


base-commit: 2dfab80a305700a45bd947350dae253ba4e30c41
-- 
2.55.0.571.g244d577d93-goog

