Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBFC4C2265
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803278; cv=none; b=Bf2E+wdCwXBme2Js95Wto9CLNQtIegYI8WvLDFki8OwayZvM2H2NEaseWTCgwmnFUVsK/WnNKUrPblG+0P+cu0fNLkbcJXxv/iBGs4rFFSMyB+1NoMdXaNE5X9xv5j6bpo1iteF79QdxzKzj1GPmOrmIcYtGrxonYSFwtxNIOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803278; c=relaxed/simple;
	bh=kyL0V6+s1/0Cc1tWgeNznfyjxTtjaqPX+cRgWuvKQg8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WqOPCGX9PzzNF/+uxa0CQOeIrRtlYofJ0JZ7MT1fhoFSxEPh9YRvCZVdI720auxZHB18nPuR405jSNaY8jfzUlCoaCQiWFeLk6wNs7Geqkomk+ZapBJ5w2BGeA/amT7X0NrbmOKDrwYMqqehiqxf+MIPrM/D47IN26aJeQXKilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0TBzmML; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0TBzmML"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db8e9fe9c7so59208985ad.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790803277; x=1791408077; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6PCtUJ+K+nwnHK2PZdNlCixf0kMmn+Me7NObDzwChM=;
        b=C0TBzmMLUhhe0Qo+3kza9sq9eu02terPrIcZ//ICbcPCdCw3dNVLjSidWGQ6LIO2ur
         pql08t2gcDLapEmKeHQV6h4JDsPHxkHUKPV1rDqixOeN2p4QofmQ/oG20AfcicnWPr2E
         j7MdxLYAW1N5JiU9170H+d3M/QeBB1GhMaIQnSmvE84A4dol0L3+jGGjIjlY0liziZIq
         ecYpKj+kW7ey/Ypk4OIZTyy+Rwn9jcsKTbBLKIBmpL8M+dXumJV5sZQ2bRQXMCOaUc/h
         FraNXLF1mq3q/mskpOPeTRQpFZtKOpRz0hJIssyUTXDbldpZIMNUNrISZ6kkGdeTJUD/
         69/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803277; x=1791408077;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V6PCtUJ+K+nwnHK2PZdNlCixf0kMmn+Me7NObDzwChM=;
        b=UvXg87H2ZMsKbUl49VePK5m9Q2vdSX2/6fzWSpCAyQ+kj+N+zW/oAzohPQp9m+QWyI
         wRcBMLEU5Y9WlPsJCWepQL3H3xa9zqPSqtHlYja9SE9nzsxawAx6JCVEFSda988izQZa
         3oD53EvtA4xeIGMU05LhrPi5kvdEQy26Luqv9554z99ZwIHk9/idO+itw3pS2OaGf5Bb
         r7SvzaeJGxDikHamGEmH/v2RCc2Rz/AMMZ/wG0f1xfNmdhtXOqSTiW6wRKxzlsNnou+u
         D6nMsHCzzCEMg4lYkBEN0vAOh8amhKY77rsfz/Iq3AQ7ps+rz+aQ4PtuePRgTCuo2x5C
         le0g==
X-Gm-Message-State: AFq9FYJh1No5YaW3EDeEb8a+eqi4FkVcRluznC7gEoBanWkq7HJ7idZ7
	eaAn5hIqAsUDfiacKTumbr7Cc6DauTOj/vorN/5zM92jeejukXSDAeO0JPh51HGNyOigCm8XCa0
	qjRQnsw==
X-Received: from pltt11.prod.google.com ([2002:a17:902:d14b:b0:2dd:5124:d17e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f603:b0:2e2:e28a:75a1
 with SMTP id d9443c01a7336-2e2e4b30f12mr20075305ad.62.1790803276429; Wed, 30
 Sep 2026 14:21:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 14:21:09 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930212114.3500045-1-seanjc@google.com>
Subject: [PATCH v4 0/5] KVM: x86: Honor EFER_LMSLE_MBZ
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Jim's series to try to clean up the EFER.LMSLE_MBZ mess (and what a mess it is).
I (still) didn't touch the KVM patches, and barely touched the selftests, i.e.
Jim's testing from v2 should still hold.

v4:
 - Go with a less fancy kvm_is_nested_virtualization_enabled(), because KVM
   sucks (and not in an ironic Primus Sucks! way). [Sashiko]

v3:
 - https://lore.kernel.org/all/20260930002140.3174449-1-seanjc@google.com
 - Slot in a patch to add kvm_is_nested_virtualization_enabled() instead of
   open coding the check and relying on the X86_FEATURE_SVM cheak to make
   sure it's kvm_amd.ko under the hood (the patch is constructed so that it
   will trigger a noisy conflict with the in-fligh
   host_cpu_is_intel_compatible).

v2: https://lore.kernel.org/all/cover.1790208413.git.jmattson@google.com

v1: https://lore.kernel.org/all/20260918154530.4129698-1-jmattson@google.com


Jim Mattson (4):
  KVM: x86: Advertise EFER_LMSLE_MBZ when KVM disallows EFER.LMSLE
  KVM: x86: Honor the guest's EFER_LMSLE_MBZ
  KVM: selftests: Rename svm_nested_clear_efer_svme to
    svm_nested_efer_test
  KVM: selftests: Add coverage for the EFER_LMSLE_MBZ defeature

Sean Christopherson (1):
  KVM: selftests: Add module param API to check if nested virtualization
    is enabled

 Documentation/virt/kvm/api.rst                |  25 ++
 arch/x86/kvm/cpuid.c                          |  20 ++
 arch/x86/kvm/msrs.c                           |  12 +-
 arch/x86/kvm/svm/svm.c                        |  21 +-
 arch/x86/kvm/vmx/vmx.c                        |   7 +
 arch/x86/kvm/x86.c                            |   9 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +-
 .../selftests/kvm/include/x86/processor.h     |  14 +
 .../kvm/x86/svm_nested_clear_efer_svme.c      |  50 ----
 .../selftests/kvm/x86/svm_nested_efer_test.c  | 266 ++++++++++++++++++
 10 files changed, 372 insertions(+), 54 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86/svm_nested_clear_efer_svme.c
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_efer_test.c


base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

