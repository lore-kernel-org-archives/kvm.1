Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC036B040
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385839; cv=none; b=OvRtYXVBG3C3/dmAWiqvs1Y1YDzddAQ8b4NKoAtceV90HNjAfZMjyBKH7UM+Safn8++LEjtHSLvyW8RIBphnslaIwOkP8FpwtwvyOvYS7IhaVnuEhSk2DbDmjaVum1ZHcIexh0SjkbyDsth2eqfxiAVBnTPfwgkQDX9z5v0o58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385839; c=relaxed/simple;
	bh=PjujR+DaN0kTLA2597jdvajJ2gnmxAARSFh8D0QJgnA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L0fIlVyp6luzochJEIQSeKCeARWJuK++OjP7Mh5qXUej7KlnbWVmI0obZH8UuxDD/CBVm/0EzV/tEM9nGjG5kg+8tpL58VxIc8oJsET7yjEA+7V9PKfo9R9yGB/xJeabH+ZuPx4THxapRfIqzEoCsiHJkgoH2WHMgK7514Prff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uv765RDs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uv765RDs"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7381a9a932so1014819a12.3
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773385836; x=1773990636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rwy1jTuY0ncWttYNxvv0qUnBD5tBQBgbJIWFU8yWqXQ=;
        b=Uv765RDsgt8ppUYWCzMmZ/k2WLaVSnBz4I4jL/61Fao22EsCkr+TB4o1WRSjhzpeHO
         tMyPPa+iRSNeMhoLRycjJomF2QlPIiO9dP9LeZ0WHpJq6ItIyNOQ8zZ75rAQFcgNuH1A
         jwSLPl2IBmnujrelBDixsy5dX1XmZ3p4Exp74mzgKrOCxP/pQibqPjmelsb5prFrd27+
         CrlapFx/fvvgdFPTKqYj4K7BV7ikk7hWkLHBPqQcTOSA2oJVA6A/f/CLods1aRVl/+rN
         p7km/75pg12xdaZ2E6OcJoiq0ly8sAs/mCXpU47hHsZF8qmQHKJlzW+f2pnXZ8HSwGRZ
         snwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385836; x=1773990636;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwy1jTuY0ncWttYNxvv0qUnBD5tBQBgbJIWFU8yWqXQ=;
        b=lvODW9Kae4lrHTFGQIPvIG+kLKsUz2QX9V/v8mETrhzjHjcrJvUY9VBFQas1iXUhGG
         hrKBrxwHDt7p4p3TkIH8HBYIPkyCajSjjsHi24cX24y4p4BR7gyoNddtFmzJ7ZCMff9j
         zy6DVJd7OVGf+s49VTB+ewVtsGPxPin/GAON/k9H7bjjUlD5SWL1bPv1s/lsjfucWHTg
         5XDpWf6+f5OLe/UqZvyMPRu+gYWhbLxujh7nQkQpz7C54Xly3Mv6RLH5XOM03NDyKdBu
         kcQLCmG9YvMwqxWHV4OfTeor14ZwDQoUnR/TZooW1+fCRid4ZfSkLEVryrpSApzF3aJO
         LX3w==
X-Gm-Message-State: AOJu0Yw/JlbWEQrR2pZvRF0wBtUlGEEj76OsznhHwcHiVcCekEcofuFX
	3L8voXb3lTCtYa52ijQAsA+jNHaD3GfzehjJpxtE07udkWHpyFYAvOYKCXRjHlHuToMtpNCvj5u
	ftCKjvNZ6ytBk0g==
X-Received: from pgmh22.prod.google.com ([2002:a63:5756:0:b0:c73:925e:484a])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7481:b0:398:7791:fb16 with SMTP id adf61e73a8af0-398ecd9c984mr1900224637.57.1773385835701;
 Fri, 13 Mar 2026 00:10:35 -0700 (PDT)
Date: Fri, 13 Mar 2026 07:10:29 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313071033.4153209-1-chengkev@google.com>
Subject: [PATCH V3 0/4] KVM: X86: Correctly populate nested page fault
 injection error information
From: Kevin Cheng <chengkev@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, yosry@kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes how KVM populates error information when injecting
nested page faults (NPF on SVM, EPT violations on VMX) to L1 during
instruction emulation, and adds a selftest to exercise these paths.

When a nested page fault occurs, L1 needs to know whether the fault
happened during the page table walk (on a PT page) or on the final
data page translation. Two issues exist today:

  1. SVM: The page table walker does not set
  PFERR_GUEST_{PAGE,FINAL}_MASK bits in the error code, and
  nested_svm_inject_page_fault() hardcodes the PFERR_GUEST_FINAL_MASK
  error code.

  2. VMX: nested_ept_inject_page_fault() OR's bit 7-8 from the original
  exit qualification, which has no relation to the synthesized EPT
  violation regardless of whether it was originally an EPT violation or
  not.

Patch 1 widens x86_exception.error_code from u16 to u64 so it can carry
the PFERR_GUEST_* bits (bits 32-33).

Patch 2 sets PFERR_GUEST_PAGE_MASK and PFERR_GUEST_FINAL_MASK in the
walker at the kvm_translate_gpa() failure sites, and updates
nested_svm_inject_npf_exit() to use the walker-provided error code.

Patch 3 makes the OR with the hardware exit qualification conditional on
whether the EPT was generated by hardware or not in
nested_ept_inject_page_fault(), and populates EPT_VIOLATION_GVA_IS_VALID
and EPT_VIOLATION_GVA_TRANSLATED in the walker alongside the NPF bits.

Patch 4 adds a selftest covering both SVM and VMX with three scenarios:
  - Final data page unmapped (final translation fault)
  - Page table page unmapped (page walk fault)
  - Final data page write-protected (protection violation)
  - Page table page write-protected (protection violation)

v2 -> v3:
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

v2: https://lore.kernel.org/all/20260224071822.369326-1-chengkev@google.com/

v1 -> v2:
  - Split out the widening of the x86_exception error code into a
    separate patch as per Sean.
  - Added a WARN if both PFERR_GUEST_* bits are set and force the
    exit_info_1 to PFERR_GUEST_FINAL_MASK if this occurs.
  - Removed the selftest TDP helpers as per Sean
  - Added a patch to populate the EPT violation bits for VMX nested page
    faults as per Sean.
  - Expanded the added selftest to support VMX and also added a test
    case for write protected pages using the INS instruction.

v1: https://lore.kernel.org/all/20260121004906.2373989-1-chengkev@google.com/

base-commit: bfd7f4adc1230373c25e1b787a6f1ee407eb0656


Kevin Cheng (4):
  KVM: x86: Widen x86_exception's error_code to 64 bits
  KVM: SVM: Fix nested NPF injection to set
    PFERR_GUEST_{PAGE,FINAL}_MASK
  KVM: VMX: Fix nested EPT violation injection of
    GVA_IS_VALID/GVA_TRANSLATED bits
  KVM: selftests: Add nested page fault injection test

 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/kvm/kvm_emulate.h                    |   3 +-
 arch/x86/kvm/mmu/mmu.c                        |  10 +
 arch/x86/kvm/mmu/paging_tmpl.h                |  42 +-
 arch/x86/kvm/svm/nested.c                     |  37 +-
 arch/x86/kvm/vmx/nested.c                     |   9 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/nested_npf_test.c       | 374 ++++++++++++++++++
 8 files changed, 448 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_npf_test.c

--
2.53.0.851.ga537e3e6e9-goog

