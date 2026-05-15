Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF33EF0CD
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884003; cv=none; b=YpTglwcNVK5vcgqeS27sK76bIi5grCrma+5zDIEdgLptvKZuyOxM2PkjYdVyWslE3LxfMcJa7aXM/zuDB4f0QQIfi4v45K4h+HztobFMonq6zHFsz550H8tC3MeEilmLh2UkkENEK1zURgBoAIhxAXqQRqwD4dXhbRaD+qLUMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884003; c=relaxed/simple;
	bh=Mk1PCxueh549nMMR9Whoc7v76lsaZLgd6oEYQ6d7fmk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Fdktj666/DRmMliTAURLGa/VlIV+5c+MnqDrJiyEAfe5W1qEjExmiIAfNCbl9rUMNa02Ay5ZcoIW0N9qlxbxAy6SWdSWGPgfG+lLvx55fWyCOBv0xaftTWIouyZyCn3Zzu6wsrc6i+st0FQejyO7k5gCjNF2qpBPhfSlRUlPRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iu5nN5Rt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iu5nN5Rt"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837c4eb3bdfso304340b3a.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884000; x=1779488800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RK/EsGylrjgEztr7/tBvnlXnW5qE4+oxTkxmZsB5ziQ=;
        b=iu5nN5RtjbHWlmP2k24WsIqVHZt2g6F0XsYNTxpxmmb1mEnZbh6h1cMrU/AI8N9Fjg
         WG8P3HFcMF7qreAJuzI7UhrsY4715O2EWRFebA6sHhc6QtSGPUpyDazblrDIL2nV+H0c
         431+7vxc9/vCzlv0z1kqdCFM8J51SDo+swzOXldixpJOVdL9MmXpUSE8/cBh7EwzrteK
         q13mOfBWfXn/hN2hDW82hSY/BLr/RpNp2PO4Esg9nq+O+YV0SNGamTrKylVPlfRH/+oy
         w0dnf9bngPjQqZ9XDvuyTDM3f7kF+hh0iZp7EpoKpsAimSOhHGdAFA25jUbggFQKVR/U
         rVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884000; x=1779488800;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RK/EsGylrjgEztr7/tBvnlXnW5qE4+oxTkxmZsB5ziQ=;
        b=dvynuFdqEXsD4I5/r92p3pDte0xW6gc+/4e/SOHKXXqyEdbEItv1ZUG65gkr7Ev87W
         ggdLHo/phI3zqt6GM55sN1as3dZPdTILXucXTtcEfv5vRDULD41U7pRaZ2hrOU8qF9FV
         Isfsau04M4BtxVTVGwDgufv7Uc2L/XayNZC3nip3BptyxAv49lEzhc9mjtCJ5hy71/XY
         y2VweGBjzMntsTtm62rVZO6qt6QD+KrzaUBrsBgoO81b+3gSs+Yf8HKZEvcZZr2qteg5
         m1Q3XG+NcyWMV151r37QLdaNHrv8pK45v85plsNaZazmki6C+4w049nR1Uhrw60UhoFm
         iEXg==
X-Gm-Message-State: AOJu0YyQndI9Sq2r7fkvUc6I1gynnOH0mImMq5a45DyFSAt0xYl6dSE2
	q2xP1urJBiBbvIKxdYz1n1x/sszUrX3IC45b8VtAN/fD7Wzz+f5zd5UJJy4uKkEgn37YwbE+3rx
	/6Z6JQg==
X-Received: from pfbik6.prod.google.com ([2002:a05:6a00:8d06:b0:835:394c:6e39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:348e:b0:839:dd77:3505
 with SMTP id d2e1a72fcca58-83f33c3920fmr6330949b3a.22.1778883999771; Fri, 15
 May 2026 15:26:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:28 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-1-seanjc@google.com>
Subject: [PATCH v3 00/10] KVM: x86: Improve #DB handling in the emulator
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Hou's series of fixes and cleanups related to #DB handling in the emulator.

v3:
 - Fix the GUEST_PENDING_DBG_EXCEPTIONS.BS consistency check issue by
   stuffing the VMCS during injection, not during emulation.
 - Drop a prep that is no longer necessary.
 - Massage a few shortlogs/changelogs.
 - Fix the selftest that takes an IRQ in the STI-shadow after IRET.
 - Fix an intermediate bug where kvm_queue_exception_e() was being used
   instead of kvm_queue_exception_p().

v2:
 - https://lore.kernel.org/all/cover.1766066076.git.houwenlong.hwl@antgroup.com
 - cleanup in inject_emulated_exception().
 - rename 'set_pending_dbg' callback as 'refresh_pending_dbg_exceptions'.
 - fold refresh_pending_dbg_exceptions() call into
   kvm_vcpu_do_singlestep().
 - Split the change to move up kvm_set_rflags() into a single patch.
 - Move the #DB and IRQ handler registration after guest debug testcases.

v1: https://lore.kernel.org/all/cover.1757416809.git.houwenlong.hwl@antgroup.com

Hou Wenlong (7):
  KVM: x86: Capture "struct x86_exception" in
    inject_emulated_exception()
  KVM: x86: Set guest DR6 by kvm_queue_exception_p() in instruction
    emulation
  KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when emulating MOV DR (in
    emulator)
  KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when checking for code
    breakpoints in emulation
  KVM: x86: Move KVM_GUESTDBG_SINGLESTEP handling into
    kvm_inject_emulated_db()
  KVM: selftests: Verify guest debug DR7.GD checking during instruction
    emulation
  KVM: selftests: Verify VMX's GUEST_PENDING_DBG_EXCEPTIONS.BS
    Consistency Check

Sean Christopherson (3):
  KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DBs
  KVM: x86: Drop kvm_vcpu_do_singlestep() now that it's been gutted
  KVM: selftests: Add all (known) EFLAGS bit definitions

 arch/x86/kvm/emulate.c                        |  14 +--
 arch/x86/kvm/kvm_emulate.h                    |   7 +-
 arch/x86/kvm/vmx/vmx.c                        |  35 +++---
 arch/x86/kvm/x86.c                            | 111 +++++++++---------
 .../selftests/kvm/include/x86/processor.h     |  19 ++-
 .../testing/selftests/kvm/lib/x86/processor.c |   2 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c     |   2 +-
 tools/testing/selftests/kvm/x86/debug_regs.c  |  83 ++++++++++++-
 8 files changed, 184 insertions(+), 89 deletions(-)


base-commit: b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887
-- 
2.54.0.563.g4f69b47b94-goog

