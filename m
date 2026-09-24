Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29A22A80D
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209557; cv=none; b=J8/5TDvxMOr/TYyEYGiiOZ+rhILXcUDjnRSCxTe+7ZFDqjA60grouWIFlzU4IvpKJOtLM7tLquGSkyKHSaeRdX6EP1+v2kQq/o62kVf0wgwtJpdiIDeuJAepVgYDHKv5fC+MMlpqTmNRo74tSsilMVzjidy77+g4G9+//dbqUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209557; c=relaxed/simple;
	bh=4ajVkW9GhUI8CLs5yIzSmsEsADCXv50C+31NCJbRVE0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xg69Gg4vBkaqpaczxKrFMBitfC38hFAlrmey+VH5ZGdTb9O9GyBeqxTDmIadtC3NljpHW0XzBUkF0bdAnFiW0hdc7s26P7bBYr8CyKc1VMM8JgyLMJHoymF1d1abaZlVNpfjxVFdD4kRpkNJ9OR2FrgADxT2b1pNA5OfkpO3GeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4j1krse; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4j1krse"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a43fc3527so337964b3a.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790209554; x=1790814354; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YzBPrFBcgioUiIiLPclBDF4e43rDN4tNSy+eTZNoRc0=;
        b=U4j1krse83+yelZ/cN+geM0vfr7dgqTIukpDGoYM7v/N5FoeXU9q5TuchOcYbeFOO7
         2gmYfX/jSsfqi+NIQJkxcIKxsLhS0iyutVgvNOkK/cWgosDQbrSjB5LDR2C8f2Ib0Xtt
         LhWFcLri0dVvH0Vd2Do4T71L3ATSdYNK3xfBRzRtsz7V1HD8pOQL4GS1QvVZbAUHM7iJ
         s2KeZHJB2Nn1YUN1KQI35j2ETHBqwDtIenfgOJcifPMf9Q/tDQT1rz2IqOkOLoWo+DCl
         vmp08iad0QW2P+LmxkkJnV3bLFQTdHP8/8aemDI89vhuG7rP5mj8YbUxLWV0dy6OE/q3
         HkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209554; x=1790814354;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YzBPrFBcgioUiIiLPclBDF4e43rDN4tNSy+eTZNoRc0=;
        b=o/E3B6K/cY3166tM+mBp/OFGp5MRGu2zt0uvKu0cNXfg+MDdxHvKdDAUEYgf2p0AY2
         tA43UImBubnKuf260EbKszI/i3agWjFuFphSCp5+Q1OYg//g5+6tDUQFFOVKfm4MheX9
         2gdXluVPfwCS+FqW+n93qijIBoTTSWVA7FhoxhAaUlJnkofSnTY39sDXWTyOMVTjMKxf
         Erli0LnoE7+euHVqNA/m8E1vTGJgIaehQOsxwwGAlH8SYbViM2kr4hlf837GQvebJ2BO
         l5Znmo/UN/aS3b33lzCcni8GeT6VmTxWc8bCmt8BQinfaQbIVsZGULLsrogZ/EEAY+Uk
         kYRA==
X-Gm-Message-State: AFuF++nHS40Mrq1KC3seoD1i1zNzNVbmlmFfsCeTXb/Z6yBj7aWILGaQ
	7KO+zcjhaLAnLk7OfGFmubUpwLkrbKTf7bnYTtB54C5LIukpd1TXZIceBDpW5Ngzbhh2O64HE78
	O1+JJEfqJR6YyZA==
X-Received: from pgbdr14.prod.google.com ([2002:a05:6a02:fce:b0:cc4:56ea:7ae7])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e93:b0:3dd:85ba:acc with SMTP id adf61e73a8af0-3de0e91d9dfmr607147637.31.1790209554294;
 Wed, 23 Sep 2026 17:25:54 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:25:41 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <cover.1790208413.git.jmattson@google.com>
Subject: [PATCH v2 0/4] KVM: x86: Honor EFER_LMSLE_MBZ
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	yosry@kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

v1 was a single patch that made KVM reject EFER.LMSLE=1 when the guest's
CPUID enumerates EFER_LMSLE_MBZ, CPUID.80000008H:EBX[bit 20].  Review turned
up two more things: KVM's *own* enumeration of the defeature is wrong today,
and the new guest-CPUID check needs an escape hatch so that userspace can
still set the bit on a host where KVM doesn't advertise it.

The motivation, as discussed in the v1 thread, is to be able to defeature a
virtual Rome, i.e. to set EFER_LMSLE_MBZ even though Rome itself supports
long mode segment limits, so that the vCPU can be hosted on Milan and later.
The opposite direction isn't interesting; in general you can't host
generation N+1 on generation N.

Patch 1 fixes KVM's enumeration of the defeature.  Today KVM passes
hardware's EFER_LMSLE_MBZ through as-is, i.e. leaves the bit clear on Intel
and on AMD with kvm_amd.nested=0, which tells userspace that long mode
segment limits *are* available.  But KVM allows EFER.LMSLE if and only if
nested SVM is supported, so on exactly those hosts KVM then rejects
WRMSR(EFER) with EFER.LMSLE=1.  Set EFER_LMSLE_MBZ whenever KVM refuses
EFER.LMSLE; the bit means precisely "EFER.LMSLE must be zero".  Note, this
is guest visible for userspace that reflects KVM's supported CPUID into the
guest.

Patch 2 is v1, plus the partial-emulation hunk Sean suggested so that
userspace can set EFER_LMSLE_MBZ on a host that does support LMSLE.  It
also masks EFER_LMSLE out of the value consumed by efer_trap().  Under
SEV-ES, EFER writes are *trapped*, not intercepted.  Rejecting the write
would inject a #GP *and* leave EFER.LMSLE set, which is strictly worse than
honoring a write that hardware allowed.

Patches 3 and 4 rename svm_nested_clear_efer_svme to svm_nested_efer_test
and add coverage for the defeature.

Tested on Rome, which supports LMSLE and so actually exercises the emulated
path, and on Skylake.

v1: https://lore.kernel.org/all/20260918154530.4129698-1-jmattson@google.com

Jim Mattson (4):
  KVM: x86: Advertise EFER_LMSLE_MBZ when KVM disallows EFER.LMSLE
  KVM: x86: Honor the guest's EFER_LMSLE_MBZ
  KVM: selftests: Rename svm_nested_clear_efer_svme to
    svm_nested_efer_test
  KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeature

 Documentation/virt/kvm/api.rst                |  25 ++
 arch/x86/kvm/cpuid.c                          |  20 ++
 arch/x86/kvm/msrs.c                           |  12 +-
 arch/x86/kvm/svm/svm.c                        |  21 +-
 arch/x86/kvm/vmx/vmx.c                        |   7 +
 arch/x86/kvm/x86.c                            |   9 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +-
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/svm_nested_clear_efer_svme.c      |  50 ----
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 273 ++++++++++++++++++
 10 files changed, 366 insertions(+), 54 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_efer_test.c


base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

