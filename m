Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2433D6EE
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876051; cv=none; b=coH+A9aka3aMmGzsdXNmbgxmnMyX8CAzoGqLIde908OWixKRKFY1IJEXdaUxQkxqHhoumAsuh7sbMqDNTk7wkunB/coFrOuwXNtaRyaWVnjtizdGrilk8xqUEkU0kYE/PUQJPGQLHJXrvspelpIEsoLPSy+dQhTZ/WbPDuyRlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876051; c=relaxed/simple;
	bh=yY1Mpq7+HQcdxnNGqSRw80/p6XpaoUN2PR5r6n3LNXg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u0TEB55+Tc1UChDb+g3vHPkXMqwyanp8mzhSRSgM8jEkPZyM6Zf7PBSAAbGjTZyo75nXukFul6R49XC0Ex3BzvvFm1LmFRcwPAXwA7EaZm67vpmnda8oqjWSVx9e1oFPOhUXRl04sO4yIdT9fw2ELqK4QwYvJ0iRSDslcoNbHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJFC8Brs; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJFC8Brs"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so2227945ad.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785876049; x=1786480849; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxIFeqc2Yzh1ChTUj7HUy+JGGjqck9dRWTDEibqXtcc=;
        b=pJFC8BrsCjweGChMtzqx6/FbSCrkzGZ1ExO8rwpqx5ShmEq7HFn/OYAr9UQE1PdpYc
         RIewkxRb89tRQ7/BMpqPOw3OTRcqGBkD6W44KLBRhM972RrXSfXarxumltUyDednAfwA
         FbGYke+EU3VSPMYu8piLiOdRtMVgGVE3YUMorC536WaPI2SaaMV2lN9oPUkkJnIDrDnC
         atII+PF+K/mDlyNuNal7bFcikBcP2xtb/CIyi6k93I7LVltBEpV2x/furZyiFClTvHZi
         tlIqtFINCuKqUGnRcr2LzoSv4r1sl1jsH6D5tvEELVlRH8L9TrwK/LFk9PTNqfGXCOq2
         jScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876049; x=1786480849;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LxIFeqc2Yzh1ChTUj7HUy+JGGjqck9dRWTDEibqXtcc=;
        b=JJIp6/0q0bdRlGwufFdPnwoNX9WYwAAu7xuM1YRdem9PorwlC9hnGTk5XHPp/wNXhA
         tWvaxGq1ebDVjahBd+y91/Ua3tbiNd1MGdp/TKlho8EbVArfvxS4KIZuf/zEXa02VoAv
         AlzrNSHvdClHUdCMMQgWw2bwtJvilRc16U+alll9jjVCOdcGCRIh7ZwjoTRH7rUwb4Yv
         sH1XztQjD9mRf138PyfjQv2CpkqHN5td7FUObIOfMl6mHDY/du6Ifl4Q1EAJfcc3DjXq
         ysGbRLTYkEHk2G64RtW9nNuIbDIhbJiASKplP05wmPS65APH1LJYquRRLC0S2rie87zc
         WkKw==
X-Gm-Message-State: AOJu0YwcXUq04FwXt4zhaPlA0CiyqbDKKvvmK6vjsl98O/QHfFeMh3Zi
	COqM/uNPYy0itqA7eadkQM6dUcAFZMt6kNJAq6qGHM+Fk+uofQIya3e2c8LfFZmHDyG7mlhugMB
	FXjsQ3g==
X-Received: from pgvz8.prod.google.com ([2002:a65:6648:0:b0:c9a:c533:8316])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6915:b0:3c6:3c5b:f2e1
 with SMTP id adf61e73a8af0-3cb86028b71mr1574046637.32.1785876049199; Tue, 04
 Aug 2026 13:40:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 13:40:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804204048.3401810-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: selftests: Reduce PMC test runtime by ~17x
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

v2:
 - Allocate an array of vCPU pointers, not an array of vCPUs. [Sashiko]
 - Fix a copy+paste goof that caused the GP counters test to always run with
   the maximum number of GP counters. [Sashiko]

v1: https://lore.kernel.org/all/20260804173437.3339269-1-seanjc@google.com

Sean Christopherson (2):
  KVM: selftests: Test one random GP counter in PMU arch events testcase
  KVM: selftests: Create one VM with many vCPUs for each major PMU
    counters test

 .../testing/selftests/kvm/include/test_util.h |   4 +-
 tools/testing/selftests/kvm/lib/test_util.c   |  22 +-
 .../selftests/kvm/x86/pmu_counters_test.c     | 230 ++++++++++--------
 3 files changed, 150 insertions(+), 106 deletions(-)


base-commit: 2dfab80a305700a45bd947350dae253ba4e30c41
-- 
2.55.0.571.g244d577d93-goog

