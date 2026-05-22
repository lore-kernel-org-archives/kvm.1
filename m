Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C790349CE0
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492425; cv=none; b=Og0MZ+r5oDepyV4JgTOkoAjOqRGgBpCSHfGJRBd3NBAhE4nBpgfd5NhHwKbNob6CP9s/jmq1hLgMxttunwvz6nofHw+5SaanbaYbe2QMi8iOzHWxV1Gyw4OrMHodr8fw02HJztGjA+yN5WfVZJ2ZIC5WoBZ74+lcP+NliprMlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492425; c=relaxed/simple;
	bh=8MlWHOjukcmjWK2KeybFLwuGeoKx2PMyQVOyJc69EUM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SAlWJ6bzPLTrt/0H4/TKIkl1IDEa14Y8T8PBcF77FBZMRRt0h2+mCwBaSzk+cISbbSye8J0fMNUIJBfk0OXcPAmkr+kzDfWKrQc3WPS7MjCNSuF/UBQZJBmcwT1MLh60ogvLAmiHK3yWc6iw99/08M5FvkJClaj9I1tF9jI75BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U17JOf7Z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U17JOf7Z"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baf7378ad0so81539315ad.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779492422; x=1780097222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlgWBoXP/F8tR7zMXfR7Xp/mpa9VMz4i1NV/txY8550=;
        b=U17JOf7ZA6uTayf3i7X720xkpIMUf7qDsSgzFAGcfg+jhrpzcSY2j8GqngRCp7QPtE
         O2t5IRrdVfLA5yh7HiseGVNewDcag9lWuhD27AMHgITTzAknHfdo29DNGkKG8cCJX4H0
         4CcWLNvypooqHDL4RUzFW0oXOw+C//4kp+zx9vPysvXJTdu9c7p3EC2hZ6yeTC3sgRAA
         dQhsyIUDWMT0otFW+KR2kNylSpfgN9IlCxEMk2h8+0Dc3KCMg3yiFxLpQ+J5KJeGYK4i
         +h9w0tQrz+VE5JUKJY+6/ZqAhf7bTObSdHi2Z9D7j+vyEm2RMMJnh2RAXN9opWBvR15F
         VPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492422; x=1780097222;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlgWBoXP/F8tR7zMXfR7Xp/mpa9VMz4i1NV/txY8550=;
        b=BDFPoYCFyLd+yxWp4TQASlM6ts37cmjZUl3gR36ibyNp7QN3TtLcKpm57UCuxRcHTJ
         NsCMwFD3GXKJHaARj8oH5UZxSXpZpyYUNMiDhxLri+zabRibBpydUWdIi+CZKGdnqI30
         SpeySMX37TgQexZQOB+UN0fBSeILM/dx884JOr0r/DDWyyeaG/7rzohsPA/ZFJKqMwrO
         /ownH/JY7sYN5IUY/2EERBdtmx8KLuvyRgA1K/nSIUTQyBOqCZpvjzkdCEvvxoc7O0g+
         lSCxnx6hIwFvE9X0MC9WqlAm5bQ2skxxWcmOkskg5hOyaAgjehGh1lsH4JZQNaGCzEUW
         RJyQ==
X-Gm-Message-State: AOJu0Yz9VJEAtwcQAW2w+svn8kWL4HT7ikM9IJrmJXTSP5jfEf/nK5MW
	ZxXIMF6gY1Px+08MU/WYhhwVAxqDjlXV8i3bUwFRBT8/jyuzKmvtFlbpg7+QgcrNqvBUlWDhDmr
	ORCWcGg==
X-Received: from plbmg4.prod.google.com ([2002:a17:903:3484:b0:2b2:3dc8:b460])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54e:b0:2bd:606d:b339
 with SMTP id d9443c01a7336-2beb05e415fmr60391865ad.21.1779492422437; Fri, 22
 May 2026 16:27:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 16:26:56 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522232701.3671446-1-seanjc@google.com>
Subject: [PATCH v4 0/5] KVM: X86: Fix nested TDP error code info
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Kevin's series to fix how KVM populates error information when injecting
nested page faults (NPF on SVM, EPT violations on VMX) to L1 during
instruction emulation.

See v3 for the full cover letter.

v4:
 - Pass @from_hardware directly instead of stuff a flag in x86_exception.
 - Use the bits in @access (thanks to MBEC+GMET) to get the fault stage.
 - Check the entire PFEC/EXIT_QUAL in the selftest.
 - Use hardware _or_ KVM information, never merge the two.
 - Name the selftest nested_tdp_fault_test.

v3:
 - https://lore.kernel.org/all/20260313071033.4153209-1-chengkev@google.com
 - Introduce hardware_nested_page_fault in struct x86_exception to
   distinguish hardware NPF/EPT exits from emulation-triggered faults
   as per Sean
 - For SVM, take PFERR_GUEST_FAULT_STAGE bits from hardware exit_info_1
   on hardware NPF exits, and from fault->error_code on emulation
   faults
 - For VMX, conditionally OR hardware exit qualification GVA_IS_VALID/
   GVA_TRANSLATED bits only for hardware EPT violation exits as per
   Sean
 - Replace #if PTTYPE != PTTYPE_EPT preprocessor guards in
   paging_tmpl.h with runtime kvm_nested_fault_is_ept() helper that
   checks guest_mmu as per Sean

v2:
 - https://lore.kernel.org/all/20260224071822.369326-1-chengkev@google.com
 - Split out the widening of the x86_exception error code into a
   separate patch as per Sean.
 - Added a WARN if both PFERR_GUEST_* bits are set and force the
   exit_info_1 to PFERR_GUEST_FINAL_MASK if this occurs.
 - Removed the selftest TDP helpers as per Sean
 - Added a patch to populate the EPT violation bits for VMX nested page
   faults as per Sean.
 - Expanded the added selftest to support VMX and also added a test
   case for write protected pages using the INS instruction.

v1: https://lore.kernel.org/all/20260121004906.2373989-1-chengkev@google.com

Kevin Cheng (4):
  KVM: x86: Widen x86_exception's error_code to 64 bits
  KVM: SVM: Fix nested NPF injection of PFERR_GUEST_{PAGE,FINAL}_MASK
    bits
  KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED
    bits
  KVM: selftests: Add nested page fault injection test

Sean Christopherson (1):
  KVM: x86: Tell ->inject_page_fault() whether or a fault came from
    hardware

 arch/x86/include/asm/kvm_host.h               |  20 +-
 arch/x86/kvm/kvm_emulate.h                    |   2 +-
 arch/x86/kvm/mmu/paging_tmpl.h                |  36 +-
 arch/x86/kvm/svm/nested.c                     |  38 ++-
 arch/x86/kvm/vmx/nested.c                     |  29 +-
 arch/x86/kvm/x86.c                            |  16 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   9 +
 .../selftests/kvm/x86/nested_tdp_fault_test.c | 313 ++++++++++++++++++
 9 files changed, 422 insertions(+), 42 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c


base-commit: 66939c1603bd5579e63278f9dc72cba5b79da9b5
-- 
2.54.0.794.g4f17f83d09-goog

