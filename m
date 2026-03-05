Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EB3C3BE9
	for <kvm@vger.kernel.org>; Thu,  5 Mar 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739059; cv=none; b=MJ9kls+ftrkIUjE+2Cxv52HUfaQn5nIqw2MbchQ9mfKchebrseE9ziJOM3ypKhrnN3+u4x18AUoogwjwwBtvY72mU859+ytgCOnDrflU4xXCbINt/9n3xdzvCShNhvJeQDVP/naiZm12aK5eodTFyflwQGw43Ev3juXsNNLUcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739059; c=relaxed/simple;
	bh=yA95gkOE4t9PwHAyzG4TvsXtYQDX6bXnChl0a0dTVLE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aBFeBMT7aRnflqwHdPGYflAgJi8VDMdGUQB+G7P2s7oXJUjAyxn+fa/6zdkadP2Ix1XOm0zOwStaWcZ4AhdVP/PT6KUrjou/TiONKisTk0tmmDtWnRQk8cgOtT7FH8EwUdDVxpio8wzIsdi8P4E8t0tq5rWJb01MMZo0CduYiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfNHyv7m; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfNHyv7m"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae61939fa5so79032465ad.0
        for <kvm@vger.kernel.org>; Thu, 05 Mar 2026 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772739057; x=1773343857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDFPsOZmn5xrrcLNeUFRi+SA57UNTjbvnubUmG/QNUk=;
        b=JfNHyv7mdmx3GSVkN19kH08NoexPdyr1PEYphdtdmxmLa2mpGDbma3o6Zu+IVlKCtR
         40gBSd9mZ+cfdBQOFP/VQ9jCfpmCmsBfN9CjjWPVSWRnfYZtsV0SdcqJun0HBuVI/5Q7
         Ksh3Mgiln4LZNipoPvTZHDFBeCQwe2h8Kf9Gz4nHm05hJY5aXTMmmfb/MwAmC9wWEXDQ
         tkZCx6K/yBQT/SUeJULedMaKgOues+89oo5T6iabFO15t86lrgzrnvYPbuOTcRWgrBba
         NknLN7nW4cbFoM4NCtk+ETi7yjGQZ9HUJFWeIOgK0OyW8gRJIBomi5M96N/irFzFjmfq
         0qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739057; x=1773343857;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SDFPsOZmn5xrrcLNeUFRi+SA57UNTjbvnubUmG/QNUk=;
        b=NRBVHLh0LEZnQMYzx6ey1pTL6FE800FzC/Vh2ayOPIJt2aygHu5tzkOUMPK+TjHCIo
         E61Q/mr/zK1pDt8IPCbnA9tandKenGA+75e3Pirawop5VPb1eN0zo35BZl5F4Tfe/NZn
         F+bd5CEr518c6g4Pmq+jD6WtSc5nmql6p0Wq+XuRlE5K64kwZ1X0DE29n6eTOxRKlmZ/
         cix9QR3csS33h/gfyveE0NBUZJoIxu7HkcHzD4Tpe7PfJKAp8emBWlmIbZPKBmUV5rpR
         iRUHV5BMGDbcpsS41oc1cdRfNdys3x6FbamVln7wWPP7/MIjAOy/0L7tmwF8ZZIafDXD
         rRNA==
X-Gm-Message-State: AOJu0Yzve6E9E0zUJ7oH9Rxaapw+9p0yi8YpN1+sY/UfBSKqvhdJpogS
	SUH5sgpq0dlbafXxNU1jajIM548uictCdbBU8x12v9hVWoO6lD0NthulERJjCSgRtTEapQtr1dX
	EyCtgxQ==
X-Received: from plsk6.prod.google.com ([2002:a17:902:ba86:b0:29f:1738:99f3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef49:b0:2ae:4fc7:8053
 with SMTP id d9443c01a7336-2ae6ab6ae41mr65903015ad.46.1772739057151; Thu, 05
 Mar 2026 11:30:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  5 Mar 2026 11:30:51 -0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305193053.1643463-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 (and a PPC) fixes for 7.0-rc3+
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please pull a larger-than-normal set of fixes for 7.0.  The PMU fix from
Namhyung is the only one that absolutely _needs_ to get into 7.0 (only beca=
use
no one cares about PPC e500).  The rest are fairly urgent stable@ fixes (an=
d
most of 'em _just_ missed the merge window).

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808=
:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.0-rc3

for you to fetch changes up to 3271085a7f1030ba9897cab60452acd370423ff1:

  KVM: PPC: e500: Rip out "struct tlbe_ref" (2026-03-03 12:29:07 -0800)

----------------------------------------------------------------
KVM x86 (and PPC e500) fixes for 7.0-rc3+

 - Synthesize features into KVM's set of supported CPU caps if and only if =
the
  feature is actually "enabled" by the kernel.

 - Validate _all_ GVAs when processing a range of GVAs for a PV Hyper-V TLB
   flush, not just the first GVA.

 - Fix a brown paper bug add_atomic_switch_msr().

 - Use hlist_for_each_entry_srcu() when traversing mask_notifier_list to fi=
x a
   lockdep warning (KVM doesn't hold RCU, just irq_srcu).

 - Ensure AVIC VMCB fields are initialized if the VM has an in-kernel local
   APIC (and AVIC is enabled at the module level).

 - Update CR8 write interception when AVIC is (de)activated to fix a bug wh=
ere
   KVM can run with the CR8 intercept in perpetuity.

 - Add a quirk to skip the consistency check on FREEZE_IN_SMM, i.e. to allo=
w L1
   hypervisors to set FREEZE_IN_SMM to provide some amount of backwards
   compatibility with setups where L1 was freezing PMCs on VM-Entry to L2.

 - Increase the maximum number of NUMA nodes in the guest_memfd selftest to
   64 (from 8).

 - Fix a PPC e500 build error due to a long-standing wart that was exposed =
by
   the recent conversion to kmalloc_obj(), and rip out the underlying uglin=
ess
   that led to the wart.

----------------------------------------------------------------
Carlos L=C3=B3pez (1):
      KVM: x86: synthesize CPUID bits only if CPU capability is set

Jim Mattson (1):
      KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_FREEZE_IN_SMM_CC

Kai Huang (1):
      KVM: selftests: Increase 'maxnode' for guest_memfd tests

Li RongQing (1):
      KVM: x86: Fix SRCU list traversal in kvm_fire_mask_notifiers()

Manuel Andreas (1):
      KVM: x86: hyper-v: Validate all GVAs during PV TLB flush

Namhyung Kim (1):
      KVM: VMX: Fix a wrong MSR update in add_atomic_switch_msr()

Sean Christopherson (4):
      KVM: SVM: Initialize AVIC VMCB fields if AVIC is enabled with in-kern=
el APIC
      KVM: SVM: Set/clear CR8 write interception when AVIC is (de)activated
      KVM: PPC: e500: Fix build error due to using kmalloc_obj() with wrong=
 type
      KVM: PPC: e500: Rip out "struct tlbe_ref"

 Documentation/virt/kvm/api.rst                 |  8 ++++++++
 arch/powerpc/kvm/e500.h                        |  6 +-----
 arch/powerpc/kvm/e500_mmu.c                    |  4 ++--
 arch/powerpc/kvm/e500_mmu_host.c               | 91 ++++++++++++++++++++++=
++++++++++++++++++++++-----------------------------------------------
 arch/x86/include/asm/kvm_host.h                |  3 ++-
 arch/x86/include/uapi/asm/kvm.h                |  1 +
 arch/x86/kvm/cpuid.c                           |  5 ++++-
 arch/x86/kvm/hyperv.c                          |  9 +++++----
 arch/x86/kvm/ioapic.c                          |  3 ++-
 arch/x86/kvm/svm/avic.c                        |  8 +++++---
 arch/x86/kvm/svm/svm.c                         | 11 ++++++-----
 arch/x86/kvm/vmx/nested.c                      | 22 ++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.c                         |  2 +-
 tools/testing/selftests/kvm/guest_memfd_test.c |  2 +-
 14 files changed, 100 insertions(+), 75 deletions(-)
