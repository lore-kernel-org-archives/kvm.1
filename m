Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69B3A0E84
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986083; cv=none; b=XmjAToilbECl5axI430x71JwD5LVhYFX09egUVOtCeugaj9bUrpJggH/5GYwOKcrwg7VJngrd6n4txIwgWZ1hvcwLsmBEd715fvFAAN551guwDztVEUOA9twTFeZhJzke6PKS2NhLOMoiofZpHLgXdsx4sf4WdFbPwIWsSEEApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986083; c=relaxed/simple;
	bh=JOD+lzXay/71dtnNBEn5+gO2df/+z5eTXghDPdynl40=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HFrXmAQruanxyOU0qgMOOv7oGdJFFwSnEFrF8mY8l249LehySW1WE62E3tZMHIFkxRnGyYWbiB/+i9D5/TL0ykP2kFfQhaDHztBqLGc0IxtNPRnDjmEJDelJf7GOgL5dGd6BnIX8SnybWFf0qo3UliLgo5sK2oM3Zwe6qIiAsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhG173Jl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhG173Jl"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630753cc38so13493861a12.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986082; x=1775590882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r1Q/2yd3CABWU9e8ZHhd5Ccwcv4RlMANKgMqqauS8hM=;
        b=rhG173JlxxuAPC5qUW4D1SfBK/GSEXU39y9nkWiqIaZ8Zf7EuH3iP6n3PjZv+FYfs1
         6V3dRjl8lpPXjb2ymipbFr2NuU7qVFbrprer+ByylQstuCLOQ+sklsyfrxkqyj7ddaqI
         kKpNuhHKd2NDOdN1stlaBck+pzkm5MtIvqHIkuAnZ59rkXmQWCIR5pCkxICGWJHQlPL7
         vWNypdjf3p5vbqKwzFqLhXNnyZCjs1MclaQdKyUoqAzxZiQ1tKuCGA3CodKh9GqcMxZa
         tUpKTx/WF2IS2IPbfqi7xRP8I3u3Zr474Vf8eQrEkC4wNpErhbVEkaLMZcjr7Jf4v/Hs
         Cf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986082; x=1775590882;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1Q/2yd3CABWU9e8ZHhd5Ccwcv4RlMANKgMqqauS8hM=;
        b=NuIMhqhvsXSPHY0z9kuH8hifB8WS4buX7BsgfEGm8MGW4uoLAMInwiPxlCWUMwqny0
         4r+4hKWXrEX06++wEdfD6yHQ/jNl6C6QrU6mv7WONsr5h+iWXM5N1oAEMaYHjFCfohdv
         O+QLej5yk+MqLOM2oTlOkFu5UDgTkrdHvYmfALZfr4Cw9A1u/rnykSNr4Pu4gcH5nUrL
         yJOC+lPgoCVq11W+VerWK1H6nRrUnjWgYW/S5LjfVWvyL3mBQ25eRQGWZYg7yzGfCPW4
         5rjq4I8Vytpr95A9Zemo2yxdlUfvcvQ58TssWShAQieUtTqyXtUZK5PMqXaQ1bj/arA+
         VnCg==
X-Gm-Message-State: AOJu0YxlG7D9E+7ZujAQmSSmXqSl2Nc0SNcrWLXDdZqIL7dxG2SsW+5l
	w/RybTOIn/1zrbCQZAxOEBP7ld7Tqu/I1WOC8i2FquU1VRZwNrz9Mp5Z93xnzJS+g0YSMZHtotD
	TTIDNq2YH
X-Received: from pfbjf1.prod.google.com ([2002:a05:6a00:6e41:b0:821:82a1:fe7d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:600d:b0:827:3946:a23c
 with SMTP id d2e1a72fcca58-82ce88d3bd7mr808960b3a.10.1774986081665; Tue, 31
 Mar 2026 12:41:21 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:19 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-1-jrhilke@google.com>
Subject: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

I am taking over development of this series from David Matlack. 
v1: https://lore.kernel.org/kvm/20250912222525.2515416-1-dmatlack@google.com/

This series is based on the kvm-upstream/queue branch.

This series introduces vfio_pci_irq_test, which exercises the delivery
of VFIO device interrupts (MSI/MSI-X) to guest vCPUs, and links the
VFIO selftests library into KVM selftests to enable testing of VFIO-KVM
interactions.

The test requires a PCI device bound to vfio-pci. It can be invoked by
passing the BDF the VFIO selftests setup script, and then running the
test with the device BDF:

  $ ./tools/testing/selftests/vfio/scripts/setup.sh 0000:6a:01.0
  $ tools/testing/selftests/kvm/vfio_pci_irq_test 0000:6a:01.0

This test only supports x86. Testing physical device interrupts (-d argument) is
only supported for Intel because there are no VFIO selftest drivers for AMD
devices.

The test can be run with following command-line arguments allow for broad
coverage of the interrupt delivery path:

  -a: Random IRQ Affinity. Randomly affinitizes the device IRQ to different 
      host CPUs to verify stable delivery during interrupt steering changes.
  -b: Block vCPUs. Causes vCPUs to HLT instead of spinning, verifying that 
      Posted-interrupt wakeup (PIW) correctly kicks blocked vCPUs.
  -d: Device MSI Triggers. Uses the physical device to trigger MSIs instead 
      of eventfd emulation (requires a supported device driver).
  -e: Clear GSI Routes. Periodically destroys/recreates KVM's GSI routing 
      table to verify handling of dynamic IRQ updates.
  -i: IRQ Count. Sets the number of interrupts to generate (default 1000).
  -n: NMI Delivery. Routes interrupts as NMIs into the guest to verify the 
      VFIO-NMI delivery path.
  -p: vCPU Pinning. Migrates vCPUs to random physical CPUs to verify that 
      posted interrupts follow the vCPU across host cores.
  -t: Timeout. Configurable timeout in seconds to wait for an interrupt.
  -v: vCPU Count. Distributes interrupts across multiple vCPUs via 
      round-robin routing.
  -x: xAPIC Mode. Forces legacy xAPIC mode to verify compatibility.


Changelog
---------
v2:
 - Split the monolithic test into a series of logical patches (Sean)
 - Move READ_FROM_GUEST and WRITE_TO_GUEST macros to kvm_util.h (Sean)
 - Add gettid, sched_setaffinity, and sched_getaffinity to kvm_syscalls.h (Sean)
 - Extract /proc/interrupts parsing logic into lib/irq_util.c (Sean)
 - Add -t command-line option for configurable interrupt timeout (Sean)
 - Improve assertion messages with specific vCPU failure context (Sean)
 - Update guest loop to use cpu_relax() when not blocking (Sean)
 - Add KVM_RANDOM_SEED support to kvm_selftest_init for reproducibility (Sean)
 - Randomize the default IRQ vector and GSI (Sean)
 - Ensure blocked vCPUs are cleaned up correctly after HLT (Sean)
 - Use kvm_mmap() instead of mmap() (Sean)

v1: https://lore.kernel.org/kvm/20250912222525.2515416-1-dmatlack@google.com/

David Matlack (11):
  KVM: selftests: Build and link sefltests/vfio/lib into KVM selftests
  KVM: selftests: Add vfio_pci_irq_test
  KVM: selftests: Add support for random host IRQ affinity
  KVM: selftests: Allow blocking vCPUs via HLT
  KVM: selftests: Add support for physical device MSI triggers
  KVM: selftests: Add option to clear GSI routes
  KVM: selftests: Make test IRQ count configurable
  KVM: selftests: Add support for NMI delivery
  KVM: selftests: Add support for vCPU pinning
  KVM: selftests: Support testing with multiple vCPUs
  KVM: selftests: Add xAPIC mode support

Josh Hilke (3):
  KVM: selftests: Add helper functions for IRQ testing
  KVM: selftests: Reproduce tests that rely on randomization
  KVM: selftests: Make vfio_pci_irq_test timeout configurable

 tools/testing/selftests/kvm/Makefile.kvm      |   7 +-
 .../testing/selftests/kvm/include/irq_util.h  |  11 +
 .../selftests/kvm/include/kvm_syscalls.h      |   7 +
 .../testing/selftests/kvm/include/kvm_util.h  |  11 +
 tools/testing/selftests/kvm/lib/irq_util.c    |  84 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +-
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 439 ++++++++++++++++++
 7 files changed, 568 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/irq_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/irq_util.c
 create mode 100644 tools/testing/selftests/kvm/vfio_pci_irq_test.c

-- 
2.53.0.1118.gaef5881109-goog

