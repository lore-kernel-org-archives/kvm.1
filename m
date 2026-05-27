Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525C44DB61
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905061; cv=none; b=dbR/avcyVVoUUK96WgG2NISuXj/OZ+LYye/04fVZNNS92oBgy4WQxf9GWNSf/UkCYLUdmKcRsBhV0C3vqDKFS38I4MV05olk/Re/F5y0J7OeL/9ORUV/5+8XSUyIeep3wNhTpJNkOaRPjlHZu3TNiorrXEyKIJ2x51lzXFIqUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905061; c=relaxed/simple;
	bh=swNVelda627qc3z4bKAEYKO0QjjO6vvg7DSoxbTOwAg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IUEwbJGD6HMuHxsH7OapUqIPIwNrDT+LOOvANTS4DxIHC0ydwYPaTRVHKet/37eyOpr3v1irRB5cVX2itAwAZPBUpEs9i8425Fi5kxtT1DGIGnLCNqIjpy88rPfdg6i3Trxh55kFPR4/S5ehgiMEXiOjz7T6/kCsvS7RUUlsrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iy1E/XmM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iy1E/XmM"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828659ecd4so5268126a12.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905059; x=1780509859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaD8KzprIDcOFrsVsyMp7JkiJkNf528fVJXZ8keV86I=;
        b=Iy1E/XmMUmp4XLMxFllJlPeHyBWAt15frr/dmGjf1hC47sM++MfXxhghv7Zd7i2d9Q
         rPcWngp3mrhCN/UbGxXnZQVY41El4ADWh+c4zBjTlrhph71KiIc01UKY3jZyUTc8GgVQ
         7slSkYe7QxRMk+vPPgJVuEJZytReUq9lCgyOkAkD5linnGw7m0oWiJETH02iBEi1SyUJ
         jokP/kQCcNhIYdlEewhOZFdkDcnwhUVd1PRHle3/4bKDXM1oSVznTX0hDAModpLJPBtP
         h18tGmK3uwsnUGKojkvwSCwmeZ79fZNA1AT+0v8IzqyLvBuF1lg//QQp82AFjA2IAFB3
         kQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905059; x=1780509859;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaD8KzprIDcOFrsVsyMp7JkiJkNf528fVJXZ8keV86I=;
        b=VearaS00gByExRgYYJXgdBtzgEpDjlUek11ckDUNCD/LrBZIG6GLlbQ5Nuv+vpU4mn
         iZEELnlVCdw4+DEFa57F2qguZ4zzPlfKYuJ0YBUammW8eNTOnGnc4yVIGr6t8NCEDWPh
         2kOXVeKi91hJYwCwPTN0rEGpjXvPPbS0uD/Nn0Q/UWJmmXQU0cBE4/sKoMZkCYfUTnBE
         Z20yA7s0q0y1UHifgqDTzE3S9l3M0XPP21zbvG2qEeMWP0uE7i/o2P3z8v3ICNerg1jt
         XoqQgQkm3Q/7obpyMvTrtIDwSlthmXLhSpsG/L9n1gwU/sLgN1YIwlObKxsUsb3yWOFa
         MdDA==
X-Gm-Message-State: AOJu0Yzul8YtwrS+7ZemB0d4SKRHTgSagtpoDz6u/2gY670Ij5zuKnN4
	rGvK6hXDs8+Kufk88VqO7cAKoNo+/D+pooezIENKeGu4bJlhWoYtfxzj0hW7t0PgwfIe9Pj57Jd
	0KknMjQ==
X-Received: from pfbfa21.prod.google.com ([2002:a05:6a00:2d15:b0:838:f05:69ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:9a85:0:b0:835:3f51:730e
 with SMTP id d2e1a72fcca58-8415f5cb2abmr21335220b3a.13.1779905059309; Wed, 27
 May 2026 11:04:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 May 2026 11:04:16 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527180417.4119289-1-seanjc@google.com>
Subject: [kvm-unit-tests GIT PULL] x86: random smattering of changes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a rather random set of changes that have been accumulating over
the last few months.

Note, the SKINIT nSVM intercept test fails on some Turin CPUs, but allegedly
only on pre-production hardware?  I assume/hope such hardware isn't commonly
available, and so didn't bother trying to handle it in upstream KUT.

The following changes since commit 9eb6c57313060d34f7e5b2ac6f90bb5873bbe2ff:

  Merge branch 'mbec' into HEAD (2026-05-12 13:03:25 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/kvm-unit-tests.git tags/kvm-x86-2026.05.27

for you to fetch changes up to c10d4616e2ad5d95553b2f0c389b4546dfacd76f:

  x86/vmx: Remove the superfluous vmx_cet config entry (2026-05-27 08:59:46 -0700)

----------------------------------------------------------------
KVM-Unit-Tests x86 changes:

 - Track SVM's EXIT_CODE as a 64-bit value, to verify KVM does the same.

 - Add nSVM tests for unsupported instruction intercepts.

 - Serialize the (v)CPU after WRMSR(TSCDEADLINE) to prepare for APIC timer
   virtualization.

 - Disable PKU in the vCPU model when running the nVMX access tests to make
   the runtime somewhat reasonable.

 - Extended the VMOVDQA test to cover VMOVNTDQA as well.

 - Add test coverage for ENTER + emulated MMIO.

 - Misc fixes, cleanups, and minor coverage enhancements.

----------------------------------------------------------------
Isaku Yamahata (2):
      x86: Replace NOP with CPUID after WRMSR(TSCDEADLINE) to serialize deadline timer
      x86: tscdeadline_latency: Remove unnecessary nop

Jim Mattson (1):
      x86: nVMX: Add retry loop to advanced RTM debugging subtest

Kevin Cheng (2):
      x86/svm: Add missing svm intercepts
      x86/svm: Add unsupported instruction intercept test

Maxim Levitsky (1):
      Skip PMU portion of vmware_backdoors test if PMU is not enabled.

Sean Christopherson (9):
      x86/cstart: Delete "local" version of save_id() to fix x2APIC SMP bug
      x86/debug: Fix macro definitions for DR7 local/global enable bits
      x86/svm: Track and handle exit code as an unsigned 64-bit value
      x86: Disable PKU in vCPU model for vmx_pf_{vpid/no_vpid/invvpid}_test
      x86/xsave: Extend VMOVDQA testing to also cover VMOVNTDQA
      x86/debug: Verify DR6 is always empty on an INT1/ICEBP #DB
      x86/apic: Verify LVT timer register mode reads back what was written
      x86/emulator: Add testcases for ENTER + emulated MMIO
      x86/vmx: Remove the superfluous vmx_cet config entry

 lib/x86/asm/debugreg.h    |   5 +-
 lib/x86/msr.h             |   1 +
 lib/x86/processor.h       |  11 ++
 x86/apic.c                |   8 +-
 x86/cstart.S              |   7 --
 x86/debug.c               |  34 +++---
 x86/emulator.c            |  66 ++++++-----
 x86/emulator64.c          |  64 ++++++++++
 x86/svm.c                 |  22 +++-
 x86/svm.h                 |  98 +++++++++++++---
 x86/svm_npt.c             |   4 +-
 x86/svm_tests.c           | 290 ++++++++++++++++++++++++++++++----------------
 x86/tscdeadline_latency.c |   1 -
 x86/unittests.cfg         |  31 ++---
 x86/vmexit.c              |   3 +-
 x86/vmware_backdoors.c    |  18 ++-
 x86/vmx_tests.c           |  76 +++++++++---
 x86/xsave.c               |  36 +++++-
 18 files changed, 559 insertions(+), 216 deletions(-)
