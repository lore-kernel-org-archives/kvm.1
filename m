Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539946;
	b=aKiAanGYsOBJl2oWsnPrJkw7nF+G3oaqXtq85Zk304yKT4rwPPQPxfISrvmiawceWLK0
	 fUFnfb47Ryvw2z2fie2F/o66LWHtPKIDIofeoJOht7pZ+qNlt1pXIH/s8hzltmoS08uG5
	 sb0TozRKFvqE+rrjKI1Qt+Ac/9tUB/8c7+0TdfSmcu4qkjKFMFK0I5a2WNavVWnT+C5ho
	 HeA8BSAzlxAIthKYpB12I1E2U80d6BK7VBZIDeNNtZ9HH0h8fU6zBLqHRBvdDr+fsmjlp
	 WVZrye4l8zb4uBiLyAon7we1Y1XVT7OuREj6m9D2oa+s6I5UlYh9UdCqlFqLRI2lRMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=3LRr5Ug7Hink3TzszKDpLdeff6jWIBq0xQg53IvpWZU=;
	b=DUdJL5rdzRKhRxD7Q/5qzspPQuaKKlBKKEpIzSSTL+nXyXWc/jkhbfqFJD9TYV27tP3/
	 c0mJDXkrT4C0zwz92P8Yl1RjvPHYSRmJCkN3R/lhA/OhwatJhHQI+byRex0IqLT0ewk9o
	 P6eKC6BHXLClND8KhxlTGGLhCQFE4o26ghUFrVoUcOVtzqv5R87Kre8Ao5rgPYudbrL+c
	 SRM4d0PsmIdGiTlhPYp1MX9VzB7lZMg27nkTkAXiIEphPQ7iilh1AJh8/K6tlvRejCK3p
	 5CHsaQd/2FN/jX0vAVcnmcZejv7xubsqtoPCPfot/eaJ3pwfFXnxIGlgZ6o3Wr9Cb4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="p6J/uWtX";
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08432606A31A
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 23:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08432606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p6J/uWtX
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso85232a12.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 16:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792539945; x=1793144745; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LRr5Ug7Hink3TzszKDpLdeff6jWIBq0xQg53IvpWZU=;
        b=p6J/uWtXe3YADJDhsZLO9crjXArT8fBzfARh7sryf2DiCIPHzPnfNHh5r3rpD2syu0
         vdOzVvxcdWHbnHDQkvqcODlncCvHqkxVdVbAaBDVqGqYg7jIW+NUdqRKUMkj/unAmqv+
         nfaoG9cUSK/jWyulKy4p8tvfmLYiPj04Z6tYrcER+YrrJx2s6Esto+o6qB5AU/KPNRBk
         z1JJC0hLdHumFLH4JHSZ55YUhpX8utlAHW4gmlSGCzfl/wqatD4u2BdC3efE7k1oBug9
         OrCgPk6NWWVpYqHIhqArXwrh1pReXt1FN5ucFFMmfRO0IPk1Mr/TDsBWJ5rBILdfVHmd
         2l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539945; x=1793144745;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LRr5Ug7Hink3TzszKDpLdeff6jWIBq0xQg53IvpWZU=;
        b=tYJ2Wybn9WnW/6p6cFDgmyDOk8I6oymj26JtYk84sRxHQox4fO8vh9eme/9SJuyw0p
         IcoqyTiYG3BerCXwxGkOKsrGWEIXVsR9VlKpEPFa2d2crLqSBcDmaltYuR4R2z4pCz7q
         xX+E70LixFZNmvE92IjHlhW+P9YRBmbvCwPWWWKW0H/d5+Sswc/eVtltCiVs2oSUJViB
         B2sfcsMm3ZQMC6hZqAJDFF02AXiCo5/sD5bpG+SFeYFF1UE57eIpwzALJRbAQdM5AAFo
         YCWn1T7rr3xFRskaWBrbMvitBzAyxWpJ8Tq4mjZ9Bh4bOdRfay2p6rTxksr4Ba9reMeL
         +Mpg==
X-Forwarded-Encrypted: i=1; AKwUvBwkzXRWxq0638FR9sRa07xim01MRfBzhGXGjD8ic3+KmIxzvXAR64Zks6Yr+NA2S7O4cjI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaFyNbJuT01X+1xuhb32RMnMhMFCqFJgKOa++23Qa2tXQnQoWo
	aQ0AV4qj9QfnDkwiFriPhXLIw9vjJKpmA95eIXxA4xZbI5V9D690ydYeygxQPT3h3t4jLYos+m6
	Odqr5Cjf7T0v4Ow==
X-Received: from pgib22.prod.google.com ([2002:a63:e716:0:b0:cd5:f9fc:b96f])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2d0b:b0:3e2:86b6:9c05 with SMTP id adf61e73a8af0-3e287e65d1bmr301507637.37.1792539945129;
 Tue, 20 Oct 2026 16:45:45 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:45:26 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020234535.3182385-1-jmattson@google.com>
Subject: [PATCH 0/4] KVM: x86: Honor userspace MSR filter changes for
 passed-through LBR MSRs
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

When userspace installs a new MSR filter, KVM raises
KVM_REQ_RECALC_INTERCEPTS to rebuild the MSR intercept bitmaps.  However,
both SVM and VMX cache the desired interception state for the LBR MSRs,
and skip updating the bitmap when the cached state hasn't changed.  The
cached state doesn't account for the filter, so a filter that denies
access to LBR MSRs that are already passed through never takes effect,
i.e. the guest can continue to read and write the MSRs without exiting
to userspace.  Conversely, if a filter forced interception when the
LBRs were passed through, relaxing the filter leaves the MSRs needlessly
intercepted.

On SVM, the bug was introduced by commit 3fa05f96fc08 ("KVM: SVM: Fix
redundant updates of LBR MSR intercepts").  On VMX, it goes all the way
back to commit 9254beaafd12 ("KVM: vmx/pmu: Reduce the overhead of LBR
pass-through or cancellation").  The comment in
vmx_recalc_msr_intercepts() claiming that LBR MSRs "cannot be filtered
by userspace" is at odds with both kvm_msr_allowed() and the
KVM_X86_SET_MSR_FILTER documentation, which exempt only the x2APIC MSRs.
It's also at odds with the filter actually being applied when the LBRs
are first passed through.

Patches 1 and 2 fix SVM and VMX, respectively.  Patch 3 adds a selftests
helper to request permission for a dynamic XSAVE feature without
skipping the test if the feature is unavailable.  Patch 4 adds a test
that primes as many of KVM's passthrough paths as is practical (LBRs,
SPEC_CTRL, XFD, APERF/MPERF, etc.), and then cycles through every
possible transition between "allow all," "deny reads," "deny writes,"
and "deny both," verifying that every denied access (and only denied
accesses) exits to userspace.

Without patch 1, the new test fails on an AMD Genoa host with lbrv=1:
both RDMSR and WRMSR of all four LBR MSRs (0x1db-0x1de) are still passed
through after the first deny-all filter is installed.  Similarly,
without patch 2, the test fails on an Intel Ice Lake host: both RDMSR
and WRMSR of MSR_LBR_SELECT, MSR_LBR_TOS, MSR_LBR_NHM_FROM,
MSR_LBR_NHM_TO, and MSR_LBR_INFO_0 are still passed through after the
first deny-all filter is installed.  With the full series, the test
passes on both hosts.

The selftest is intentionally broader than the LBR MSRs, in the hope of
catching future "skip the update if nothing changed" optimizations that
forget about userspace MSR filters.  Intel PT MSRs aren't covered, as
priming them requires the guest to be actively tracing.

Jim Mattson (4):
  KVM: SVM: Always update LBR MSR intercepts on full MSR intercept
    recalc
  KVM: VMX: Refresh LBR MSR intercepts on full MSR intercept recalc
  KVM: selftests: Add a helper to request XSAVE permission without
    skipping
  KVM: selftests: Verify MSR filter changes apply to passed-through MSRs

 arch/x86/kvm/svm/svm.c                        |  28 +-
 arch/x86/kvm/svm/svm.h                        |   6 +
 arch/x86/kvm/vmx/pmu_intel.c                  |  20 +-
 arch/x86/kvm/vmx/pmu_intel.h                  |   7 +-
 arch/x86/kvm/vmx/vmx.c                        |   6 +-
 arch/x86/kvm/vmx/vmx.h                        |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   4 +
 .../testing/selftests/kvm/lib/x86/processor.c |  33 +-
 .../kvm/x86/msr_filter_update_test.c          | 392 ++++++++++++++++++
 10 files changed, 478 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/msr_filter_update_test.c


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.56.0.212.g129ede20d9-goog

