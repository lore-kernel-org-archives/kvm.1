Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E9400E1A
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570337; cv=none; b=r9M/hQ804yDn7tfWeZYn1aQQ/nDJv2JKo908cr9M4DW7UPgJUy1vVm82XK5XzbGw4YOetZw8FUNiXEkQk0xI11z88sBKXw6SqwNSO6qTtzYMyXVok/J7IuiMdS3mbjLsMLzUkT2PMLBaPCu7MS6z+DS67RtYMi58GSj8UgDxatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570337; c=relaxed/simple;
	bh=caahILeVUu3Hfv0T+Y1f49/LmbAXlrNmVpsYyB/qzJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UoI9NLyjV6X6WS0xdw1qBDNHqsl1dtNZlip8grrIlJNuy3xM5x3ZNhIJkpegzFBSG/ga5eIuitepKat3RmNLqwg33yhmiae/AHn7zr5XcY8PnWDmm2nrlS+P2A5ndkLRSgj7ieUDdIezkbCT8iAkIXTIWTIPnt3sxCMeNNy74YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JkKkOUQA; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JkKkOUQA"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso2302946b3a.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570334; x=1787175134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bXr09UYAM02F1WUon8mNRFENVPSO7Zrn6zZGvLa7M1E=;
        b=JkKkOUQAsqD1iFl+VihlGxknQs5KBNQvV5K1ZnGBCfZcxQf7IjwUE7kbTE22tK7RLk
         EyUeupjT4k33549ol4exLKuphXTL6K0htqEkGV4pxV0mOyiR/dKXjKsd5NjBEiA5zLti
         wiBuXv22mp4CtgIw030ucAB+ZGxux2RbuwYiqxBGyt8Ih1QmYy9vv3AgfyDvdMEvmgHG
         Y4fyxeJn5THvwmRtas1MV2wYmJ8yTU2xisSJlSbOVbhrHKunrsWZAUxzoYJy6hsZs8mZ
         0MefmoAa/RGTL3BTjazq5WiGBcei1cAK/lDg+MDrYLzcnOlwpKY2l9yI7I7DElVJmZNY
         jP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570334; x=1787175134;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXr09UYAM02F1WUon8mNRFENVPSO7Zrn6zZGvLa7M1E=;
        b=cbzCKi8dNtuJ2aD9k/9kOmL9bIKqx5Kr3+bHp8piixF273v+z4OHCEA1v9rZzlqiUI
         c5E5OR0UZ1V85xIsrAuxrDoiT65+A/zbJD6vm/5/veao+iQNHIhhyckvuHl5gXH2UAY9
         HZAfp80Ltb7IxPp89Ng6BK50HGTV2GB9G9XSY2ZJ3OAf2jckm222H5lORROfTiQEueAo
         GGu+EglcrdzHyOL/jHZ2cjgNDxhAjLfFE0AcEtNRYqHbJ/3bXX8Cn6WOqpNhMB1Qt8A7
         5iNhOyS9Ge0ol13q2OgYkKxAr7gC/rCQ0cdk+iF2QUg34EAcyd2r+qnYPisoygbR2H9V
         6eAQ==
X-Gm-Message-State: AOJu0Yya8+4hppCaAEeDBzeRnNXK0hAnbw74XXfSBv1ed+y78nhEd5hT
	puSezSsNgzAcoOBHVSbQdB5KfcLetGnx1lSDVCjtZEjVltTII0uNxAgVUxD61v5opnJ+pIFR1G1
	02OcEDg==
X-Received: from pgcp13.prod.google.com ([2002:a63:740d:0:b0:cbe:43e4:a684])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:951a:b0:847:893f:2d0c
 with SMTP id d2e1a72fcca58-84fc6c8b967mr877590b3a.5.1786570333872; Wed, 12
 Aug 2026 14:32:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Aug 2026 14:32:00 -0700
In-Reply-To: <20260812213206.1564354-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812213206.1564354-6-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Misc changes for 7.3
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The main set of x86 changes for 7.3.  Yosry's INVVPID and EFER validation c=
hanges
are probably the most interesting.  Almost everything from me falls into th=
e
category of "fixes for things that are technically bugs, but that no one ca=
res
about in practice".

The following changes since commit a204badd8432f93b7e862e7dac6db0fe3d65f370=
:

  Merge branch 'kvm-chainsaw' into HEAD (2026-06-25 11:32:09 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-7.3

for you to fetch changes up to 66ee8f1556575c8f9ae76932dd3aca65b4b60e59:

  KVM: x86/pmu: Clean up vPMU comments and stray blank lines (2026-08-05 16=
:42:23 -0700)

----------------------------------------------------------------
KVM x86 misc changes for 7.3

 - Fix VPID virtualization bugs where KVM would fail to flush hardware TLBs=
.

 - Harden the SNP and TDX "populate" ioctls against bad input, and to prepa=
re
   for supporting in-place private<=3D>shared conversion.

 - Fix a variety of #DB priority bugs.

 - Fix a class of races related to enabling Hyper-V emulation on a vCPU aft=
er
   the vCPU is visible to the rest of KVM.

 - Use static calls for nested virtualization ops.

 - Move more KVM-internal code out of x86's kvm_host.h.

 - Enumerate support for a variety of Zhaoxin instructions that don't requi=
re
   explicit virtualization.

 - Fix missing EFER validation bugs, including in the KVM_SET_SREGS* path.

 - Harden kvm_vcpu_map() against double-mapping and thus leaking references=
.

 - Misc fixes and cleanups, e.g. for largely benign syzkaller splats.

----------------------------------------------------------------
Binbin Wu (1):
      KVM: x86: Fix emulated CPUID features being applied to wrong sub-leaf

Carlos L=C3=B3pez (3):
      KVM: x86: Treat any non-zero return from set_dr() as a faulting condi=
tion
      KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_s=
et_mce()
      KVM: x86: hyper-v: Clamp stimer deadline to avoid livelock

Ewan Hai-oc (5):
      KVM: x86: Expose Zhaoxin SM2 CPUID feature
      KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
      KVM: x86: Expose Zhaoxin RNG2 CPUID feature
      KVM: x86: Expose Zhaoxin PHE2 CPUID feature
      KVM: x86: Expose Zhaoxin RSA CPUID feature

Hao Zhang (1):
      KVM: selftests: Extend the invalid nVMX guest state test to cover RSM

Joerg Roedel (1):
      KVM: SEV: Explicitly disallow NULL user address for SNP_LAUNCH_UPDATE

Kai Huang (1):
      KVM: x86: Use KVM_X86_OP() for the .pi_update_irte() hook

Like Xu (1):
      KVM: x86/pmu: Clean up vPMU comments and stray blank lines

Sean Christopherson (45):
      KVM: nVMX: Decouple INVVPID operand checks from flushing of vpid02
      KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL INIT_MEM_REGION sou=
rce
      KVM: x86: Prioritize DR7.GD #DB over #GP due to illegal DR6/7 value
      KVM: x86: Manually check DR4/5 write values to fix SVM intercept prio=
rity
      KVM: x86: Prioritize #UD on MOV DR over #GP due to non-zero CPL
      KVM: VMX: Prioritize DR7.GD=3D1 #DB over CPL>0 #GP on Intel
      KVM: x86: Use kvm_dr{6,7}_valid() to check DR{4,5,6,7} write values i=
n emulator
      KVM: x86: WARN if MOV DR emulation hits a "too late" #GP
      KVM: x86: Read CR4.DE in emulator if and only if accessing DR4 or DR5
      KVM: x86/hyperv: Get target FIFO in hv_tlb_flush_enqueue(), not calle=
r
      KVM: x86/hyperv: Check for NULL vCPU Hyper-V object in kvm_hv_get_tlb=
_flush_fifo()
      KVM: x86/hyperv: Ensure vCPU's Hyper-V object is initialized on cross=
-vCPU accesses
      KVM: x86/xen: Always route non-singleshot-timer vCPU hypercalls to us=
erspace
      KVM: x86/xen: Consolidate checks on Xen vCPU ID for singleshot timer =
hypercalls
      KVM: x86/xen: Punt singleshot timer hcalls to userspace if Xen vCPU I=
D isn't set
      KVM: Initialize a vCPU's index to '-1' while it's being created
      KVM: Move nVMX's lockdep logic for vcpu->mutex to a common helper
      KVM: x86: Treat a vCPU as unreachable if its index is invalid
      KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()
      KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task synic->active a=
ccesses
      KVM: x86: Move the "APIC attention" macros from kvm_host.h =3D> lapic=
.c
      KVM: x86/mmu: Annotate tdp_enabled as being read-mostly
      KVM: x86: Pluralize the macro guard name for msrs.h
      KVM: x86: Move CR and DR macro definitions from kvm_host.h =3D> regs.=
h
      KVM: x86: Move KVM_GUESTDBG_VALID_MASK from kvm_host.h =3D> x86.c
      KVM: x86: Add static asserts to document connection b/w TSS structs a=
nd macros
      KVM: x86: Move KVM's arbitrary task switch reason enums to x86.h
      KVM: x86: Move "struct kvm_apic_map" definition from kvm_host.h =3D> =
lapic.h
      KVM: x86: Move "struct kvm_vcpu_hv" and all children from kvm_host.h =
=3D> hyperv.h
      KVM: x86: Reject nested CAP enablement if nested virtualization is di=
sabled
      KVM: x86: Add static calls for nested virtualization ops
      KVM: x86: Move nested_ops out of kvm_x86_ops, to global kvm_nested_op=
s
      KVM: x86: Don't WARN if IRQ disappears because it was cleared from th=
e PIC
      KVM: x86: Don't WARN if IRQ disappears when Xen emulation is enabled.
      KVM: nVMX: Ensure KVM_REQ_GET_NESTED_STATE_PAGES is cleared on VM-Exi=
t
      KVM: nSVM: Add CLASS()es for automagically handling local kvm_vcpu_ma=
p() usage
      KVM: nSVM: Use CLASS(kvm_vcpu_map_local) for SMM VMCB mappings
      KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR bitmap merg=
ing
      KVM: PPC: Use CLASS(kvm_vcpu_map_local) to patch dcbz
      KVM: Harden kvm_vcpu_map() against double-mapping and thus leaking re=
ferences
      KVM: x86: Extract VMX's unhandleable emulation check to common x86
      KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 requires emulation
      KVM: x86: Rework kvm_x86_ops.vcpu_pre_run() into .vcpu_needs_initiali=
zation()
      KVM: selftests: Use port 0x80 in invalid nVMX guest state test
      KVM: selftests: Refactor invalid nVMX state test to prepare for RSM t=
estcase

Tim Wiederhake (1):
      KVM: x86: Replace delivery mode TODO with WARN_ON_ONCE

Yosry Ahmed (9):
      KVM: nVMX: Always flush vpid02 on first use
      KVM: nVM: Ensure INVVPID is emulated on the correct physical CPU
      KVM: x86: Move enabling EFER.SVME and EFER.LMSLE to generic EFER setu=
p
      KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supporte=
d
      KVM: x86: Always initialize EFER reserved bits on vendor initializati=
on
      KVM: x86: Reverse the polarity of efer_reserved_bits
      KVM: x86: Move supported EFER bits to kvm_caps
      KVM: x86: Check EFER validity on KVM_SET_SREGS*
      KVM: selftests: Extend set_sregs test to cover EFER

leixiang (1):
      KVM: Remove kvm_debugfs_dir on kvm_init() error paths

 arch/powerpc/kvm/book3s_pr.c                       |  11 +-
 arch/x86/include/asm/cpufeatures.h                 |  10 +
 arch/x86/include/asm/kvm-x86-nested-ops.h          |  36 ++++
 arch/x86/include/asm/kvm-x86-ops.h                 |   5 +-
 arch/x86/include/asm/kvm_host.h                    | 212 ++---------------=
----
 arch/x86/kvm/cpuid.c                               |  22 ++-
 arch/x86/kvm/emulate.c                             |  49 +++--
 arch/x86/kvm/hyperv.c                              |  95 +++++----
 arch/x86/kvm/hyperv.h                              | 117 +++++++++++-
 arch/x86/kvm/irq.h                                 |  20 ++
 arch/x86/kvm/lapic.c                               |  13 +-
 arch/x86/kvm/lapic.h                               |  33 ++++
 arch/x86/kvm/mmu.h                                 |  11 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/mmu/paging_tmpl.h                     |   2 +-
 arch/x86/kvm/msrs.c                                |  21 +-
 arch/x86/kvm/msrs.h                                |   5 +-
 arch/x86/kvm/pmu.c                                 |  12 +-
 arch/x86/kvm/pmu.h                                 |   4 +-
 arch/x86/kvm/regs.c                                |   3 +-
 arch/x86/kvm/regs.h                                |  38 ++++
 arch/x86/kvm/smm.c                                 |   4 +
 arch/x86/kvm/svm/nested.c                          |  20 +-
 arch/x86/kvm/svm/sev.c                             |  16 +-
 arch/x86/kvm/svm/svm.c                             |  66 ++-----
 arch/x86/kvm/svm/svm.h                             |   1 +
 arch/x86/kvm/tss.h                                 |   7 +
 arch/x86/kvm/vmx/main.c                            |  24 ++-
 arch/x86/kvm/vmx/nested.c                          |  81 ++++----
 arch/x86/kvm/vmx/nested.h                          |   6 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |   1 -
 arch/x86/kvm/vmx/tdx.c                             |  16 +-
 arch/x86/kvm/vmx/vmx.c                             |  19 +-
 arch/x86/kvm/vmx/x86_ops.h                         |   4 +-
 arch/x86/kvm/x86.c                                 | 110 ++++++++---
 arch/x86/kvm/x86.h                                 |   8 +-
 arch/x86/kvm/xen.c                                 |  43 +++--
 include/linux/kvm_host.h                           |  26 +++
 .../testing/selftests/kvm/include/x86/processor.h  |   2 +
 .../testing/selftests/kvm/x86/pmu_counters_test.c  |   6 +-
 .../selftests/kvm/x86/pmu_event_filter_test.c      |   4 +-
 tools/testing/selftests/kvm/x86/set_sregs_test.c   |  81 ++++++--
 .../kvm/x86/vmx_invalid_nested_guest_state.c       | 118 ++++++++++--
 virt/kvm/kvm_main.c                                |  12 ++
 44 files changed, 857 insertions(+), 539 deletions(-)
 create mode 100644 arch/x86/include/asm/kvm-x86-nested-ops.h
