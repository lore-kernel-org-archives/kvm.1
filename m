Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940286;
	b=PITp3SJlWXmjUKdpsy6nSYbgazyfmtagMq4QLfFiRiVJ4RIh9xWUq8krUfcimoUb4Vrz
	 ax+AWo/BZRnUL5VEK5kCqnfgQAPlPjKMoW6ufvItF128v6lIzNQqUWNYM5IBSRbOF8Cnh
	 Y0JmB71F9qc+frnPfLGSFPM1r7ieCUDJbzoJ3bktuVPx+/bKgeREY9NFgUfHBGr4mDKwr
	 p5OcaKtMEh/U9nwZwiWejRyzHPsDdZUqmZZfaJy7lwXZwR2V61JcxbClkVpkK/q5u1kJF
	 blARjs7aZl0AjYVUcV/OiyRlTCFPysP640LxDmsdV+FY+h8v/aK3NQ1FHjR0Xrz8UTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940286;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VE5rLoOHu2cgqArtkew1oUhpktbpmFHgchFtf1xMQjA=;
	b=vGBHuRRcGOgPCBRMkKLxvk7Ukmmyu4jg0GE45eoIFWb48msNmJ6uzlvFMfTbvWSLZCOv
	 X97Z0GQ8OUzb7lR/YcKn2cw4Bwe2yr4yXQ3xfjPZVVnmS0ak0U3wWiJR7t9Num7icb0A5
	 qIp8ugsT6WAxDcrygCVc58Dfqwd9qw+oe3Wxa2uvVKkVqMJTqUF7k8HpDKCgAEnqnft2g
	 jePAMucBCW+iSPBtmjhi283qBIfH6dJWY5BGJVYNRRgFgV/ngXIgUyKvcFhwGpcGcVGc0
	 BCFer+PPAV+skri8hRH6b7wijzmO6RtVRCPra80i56KAH9Y2qMiqV1VH39T+pbpQMeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LDpzqAsD;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD7E606A31C;
	Tue, 17 Nov 2026 18:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD7E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LDpzqAsD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940285; x=1826476285;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UIp5QKRdanxzSHHvHuTaVRJ3aND9uOqfo001d79Uz7A=;
  b=LDpzqAsDpBqR1A5UrilWbZ3Z0bADbkrxGEmS7fxU7sYmhalwk/AR2UQB
   EhioN/fT7uXmCLnnU+PxKi+HyVF3Gf9Jax4NKA3x310lgU5MpEkgRGIWQ
   /mDV38MVg+NrC8NvxRGLF7su4bb25gPn7go1TgobuG3AIkbNyvqR/LZIP
   DxqekwfwCvcEhm8ceKSaniVc4PGrtdOMxAuyQZqruyvwaLh1RgwsHmXP6
   oL3QZ0MJ8nOykBvWvLRLXEJYzpBnvLx1UwKpO7cSjJVHBBhd5qJ3O44TS
   HPI9osPCA7FluoP6gvq7N4+MTQumLBAkxwsb6IYKmUmR7Ga88DveX3hau
   Q==;
X-CSE-ConnectionGUID: Hr8isZtIT02qyUeqD9r5Bw==
X-CSE-MsgGUID: cGGirKriS6eOhbK0h9slZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607149"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607149"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:38 -0800
X-CSE-ConnectionGUID: b9sD7Ru2SgCMa8/2pmFo0g==
X-CSE-MsgGUID: /WR4iLIrQeKcxagEgKkQxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9774961"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:37 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 00/20] KVM: x86: Enable APX for guest
Date: Tue, 17 Nov 2026 18:02:50 +0000
Message-ID: <20261117180310.921701-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This revision incorporates feedback from Jim Mattson. Thanks for the
review! While he provided review tags for some patches, he also caught
something. Here's a summary of changes in each part:

  Part1: Establish EGPR state management
    Since EGPR storage resides outside the guest fpstate, there were two
    gotchas to address:
      * VCPU reset (patch3) and
      * The XSTATE_BV[APX]=0 behavior in the KVM API (patch4), with a
        corresponding test added in patch19. This also influenced [4].

  Part2: Update VMX handlers for EGPR indices
    While rebasing onto recent VMX changes, the VMX instruction
    information extension needs to be hidden when using eVMCS (patch 9
    and 17/18), rather than leaving it untouched.

  Part3: Support emulator for REX2
    There were a few smaller corrections, but one outstanding was masking
    higher register bits before accessing {X,Y}MM registers (patch 12).
    Another point was whether to report #UD or an emulation failure. I
    took that distinguishing the two is reasonable in the front end,
    although an emulation failure eventually be #UD injection in the back
    end.

  Part4: Expose APX features and test
    The rationale for CPUID filtering to ensure forward compatibility was
    bought. Then consolidated feature exposure into patch 18. There were
    also a few minor test-code updates, along with a new test for
    clearing APX state based on the feedback from Part1.

With these changes, I think the series in much better shape, hopefully
leaving fewer issues for Sashiko to catch. Let me check if there is
anything else.

Thanks,
Chang

References:
[1] Repository: git://github.com/intel/apx.git apx-kvm_v9 (based on github.com/kvm-x86 next)
[2] KVM unit test: https://lore.kernel.org/20260420212355.507827-1-chang.seok.bae@intel.com
[3] Previous posting, V8: https://lore.kernel.org/20260930210750.1487547-1-chang.seok.bae@intel.com
[4] x86 xstate ptrace test: https://lore.kernel.org/20261110031603.698635-1-chang.seok.bae@intel.com

Chang S. Bae (19):
  KVM: x86: Extend VCPU registers for EGPRs
  KVM: VMX: Save guest EGPRs in VCPU cache
  KVM: x86: Support EGPRs on VCPU RESET/INIT events
  KVM: x86: Support APX state for XSAVE ABI
  KVM: VMX: Refactor VMX instruction information access
  KVM: VMX: Refactor instruction information decoding
  KVM: VMX: Remove unused control-register access defines
  KVM: VMX: Refactor register index retrieval from exit qualification
  KVM: VMX: Support instruction information extension
  KVM: nVMX: Propagate extended instruction information
  KVM: x86: Support EGPR accessing and tracking for emulator
  KVM: x86: Handle EGPR index and REX2-incompatible opcodes
  KVM: x86: Support REX2-prefixed opcode decode
  KVM: x86: Document EVEX-prefix not implemented
  KVM: x86: Guard valid XCR0.APX settings
  KVM: x86: Add APX to supported XCR0
  KVM: x86: Expose APX feature to userspace
  KVM: selftests: Add APX state and ABI test
  KVM: selftests: Add APX state handling and XCR0 sanity checks

Sean Christopherson (1):
  KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()

 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/include/asm/cpuid/api.h              |   1 +
 arch/x86/include/asm/kvm_host.h               |  19 ++
 arch/x86/include/asm/kvm_vcpu_regs.h          |  50 +++++
 arch/x86/include/asm/vmx.h                    |  22 +-
 arch/x86/kvm/Kconfig                          |   4 +
 arch/x86/kvm/cpuid.c                          |  33 ++-
 arch/x86/kvm/cpuid.h                          |   2 +
 arch/x86/kvm/emulate.c                        | 132 ++++++++---
 arch/x86/kvm/kvm_emulate.h                    |  21 +-
 arch/x86/kvm/reverse_cpuid.h                  |   6 +
 arch/x86/kvm/svm/svm.c                        |   8 +-
 arch/x86/kvm/vmenter.h                        |   1 +
 arch/x86/kvm/vmx/common.h                     |   5 +
 arch/x86/kvm/vmx/nested.c                     |  72 +++---
 arch/x86/kvm/vmx/nested.h                     |   2 +-
 arch/x86/kvm/vmx/vmcs12.c                     |   4 +
 arch/x86/kvm/vmx/vmcs12.h                     |   3 +-
 arch/x86/kvm/vmx/vmenter.S                    |  31 ++-
 arch/x86/kvm/vmx/vmx.c                        |  36 ++-
 arch/x86/kvm/vmx/vmx.h                        |  63 +++++-
 arch/x86/kvm/vmx/vmx_ops.h                    |   9 +
 arch/x86/kvm/x86.c                            | 144 +++++++++---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     | 120 ++++++++++
 tools/testing/selftests/kvm/x86/apx_test.c    | 209 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/state_test.c  |   3 +
 .../selftests/kvm/x86/xcr0_cpuid_test.c       |  19 ++
 28 files changed, 877 insertions(+), 148 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c


base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.53.0

