Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0B442E8EE;
	Wed,  5 Aug 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927823; cv=none; b=JJPFS1hoTJcOkUp7NC5BIYXUHxfCfhwAJlbMs6RG8XxIqrchyb0LrlWLsbrdawyiF3LmtrjqCVI42d6jFu4xAS7/URoLXLctkWPCUe/8n00xceBe8F7NRrjvbchP0PBy6oVF41o6jiGlLRXh2opklVxyrorm2qvMofdJLKtM3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927823; c=relaxed/simple;
	bh=ygsZWh33hnHvUwuLXaDFEYk72pxVn6bV15ilBTUEIYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M027c7qIPtjN4cF3r2g5UAP7cAeqr+z+6pgehn5PU432Ka+0z1aWgmO3k9bm4wZdEUirUAbXozqJI+D9CQu9i3uk3W5QPVRryZ9QrF0cnDYQAJ4c6qh6zBLDr+jRI5SZpRyXG8aVF3rtiZeO9Iwh5X6ti00avmuXATJfFgcO7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TiBXXY8c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TiBXXY8c"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1E59B20B7169;
	Wed,  5 Aug 2026 04:03:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E59B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927800;
	bh=km2QlDF0aAHcxmSH6eS1eiFJpoUp1Z3sibHXIZTPhEc=;
	h=From:To:Cc:Subject:Date:From;
	b=TiBXXY8cjQVE3wXwgaEHnQ+aVCqJLM37AqqBHvQIsAUjdvIpbchLIShahzJEzaVZC
	 APxXE1QeDJlAPZK9q6JrCCRMXt0jrID+hg/j0BB6JdCug0DAre5Uda37bzZIzvEo3E
	 GRDwiw2m/wrqXmWBtGFaDbdmbjc1URfAatKBI6s0=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 00/42] VBS/VSM-on-KVM: VBS integration for KVM VM planes
Date: Wed,  5 Aug 2026 04:02:42 -0700
Message-ID: <20260805110324.25067-1-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC demonstrates how KVM VM Planes can be used to implement
Virtualization-Based Security (VBS) using Virtual Trust Levels (VTLs).
It provides a concrete implementation for discussion and is intended to
solicit feedback on the architecture, kernel interfaces, and division of
responsibility between KVM, the normal guest kernel, and a secure kernel.

The complete implementation is available in three repositories under the
safe-tee organization:

  Linux and KVM support:
  https://github.com/safe-tee/linux/tree/kvm-planes-v7.2-rc5

  QEMU support:
  https://github.com/safe-tee/qemu/tree/qemu-planes-v11.1.0-rc1

  Build, test, and integration tooling:
  https://github.com/safe-tee/lvbs

Current build and run instructions are maintained in the lvbs repository:

  Build the Plane 0 kernel, Plane 1 secure kernel, VM image, and run QEMU:
  https://github.com/safe-tee/lvbs/blob/main/docs/how-to/how-to-build.md

The VBS core is implemented under security/vbs and exposes a
transport-independent interface through include/linux/vbs.h.  The normal
guest kernel runs in Plane 0 (VTL0) and requests security services from a
higher-trust kernel running in Plane 1 (VTL1).  For KVM VM Planes, these
requests are transported through a shared calling page and a KVM
hypercall-mediated plane switch.

The RFC demonstrates loading and starting the secure kernel, communication
between VTL0 and VTL1, and hypervisor-enforced kernel integrity (HEKI).
The secure plane can protect VTL0 memory independently of VTL0, seal kernel
text and read-only data, participate in module validation and permission
changes, and validate kexec images.

This mail series contains only the 42 VBS and integration patches authored
by me.  It does not duplicate the prerequisite VM Planes patches from Joerg
Roedel and Paolo Bonzini.  The Linux branch linked above contains the full
integrated tree, including their patches and related KVM work from Melody
Wang and Tom Lendacky, used for development and testing.

This is prototype code and is not yet intended for production use.  In
particular, the KVM backend currently routes VTL calls through CPU 0 and
the VM Planes configuration requires a split in-kernel IRQ chip.
Feedback on the overall model, the VBS interface, and how this work should
be split for upstream review would be appreciated.

Acknowledgments
===============

This work stands on top of, and is indebted to, several prior efforts:

  - Joerg Roedel, whose KVM VM Planes tree provides the in-kernel plane
    infrastructure that the VBS/VSM secure plane relies on.

  - Paolo Bonzini, whose "[RFC PATCH 00/29] KVM: VM planes" introduced the
    VM plane concept to KVM as a common in-kernel model for AMD VMPLs,
    Intel TDX partitions, Hyper-V VTLs, and Arm CCA planes.  Joerg Roedel's
    work carries that model forward.
    https://lwn.net/Articles/1016113/

  - The prior Linux VBS (LVBS) and Hypervisor-Enforced Kernel Integrity
    (HEKI) work by James Morris, Thara Gopinath, Wei Liu,
    Madhavan Venkataraman, and Mickaël Salaün, posted as
    "[RFC PATCH v2 00/19] Hypervisor-Enforced Kernel Integrity (HEKI)".
    The kernel-sealing model used here follows their design.

  - James Bottomley and James Morris, for their ongoing work on VSM-on-KVM,
    which informed the design and direction of this series.

Sriram Nambakam (42):
  Fix merge issue - Remove duplicate definition for
    kvm_arch_has_irq_bypass
  Fix compilation
  Fix compile error
  Fix compile errors
  Initial support for VM Planes - Add kernel config for CONFIG_VM_PLANES
    - Parse vm plane config from initrd for plane configuration - Make
    hypercalls to allocate memory for the vm planes.
  Use vcpu count from the plane configuration
  skip processing plane configuration for plane 0 - plane 0 is the boot
    plane
  Add plane config param to specify kernel image format
  Activate the VM Planes through the Hypervisor - Using KVM as the VMM
  allow the command line to be specified for kernels in other planes
  Various changes to support VM Planes.
  Add a Virtualization Based Security (VBS) framework. - Add backends
    for AMD SEV-SNP, Intel TDX, Arm CCA and KVM Planes. - Support VTL on
    Hyper-V in addition to Planes on KVM.
  Add a inter-plane communication mechanism through KVM. - model this to
    use a single page similar to SEV-SNP
  KVM: Add per-plane memory attribute support for cross-plane EPT
    protection
  KVM: x86: Add KVM_HC_VBS_VTL_CALL hypercall for VBS inter-plane calls
  vbs: Add HEKI kernel sealing and fix KVM plane memory attribute guards
  vbs: Add module authentication via VBS/HEKI
  vbs: Add kexec validation and make module auth non-fatal
  Merge branch 'master' into vm-planes
  kvm: x86: fix merged plane API/stat build regressions
  KVM: x86: exit VM planes and VBS hypercalls to userspace
  kexec: block legacy kexec_load when VBS is active
  kvm: x86: fix merged plane API/stat build regressions
  KVM: planes: expose memory-attribute setting to in-kernel callers
  vm_planes: drop unused per-plane vcpu_count
  drivers/virt: add VBS secure-plane park loop
  KVM: planes: add arch-neutral in-kernel plane switch helper
  KVM: x86: add VBS VTL call/return and cross-plane set-mem-attrs
    hypercalls
  init/vm_planes: set up planes from rootfs_initcall and load ELF
    payloads
  security/vbs: run backend probe and HEKI seal at rootfs_initcall
  security/vbs: pin the VTL call hypercall to CPU0
  security/vbs: add secure-plane monitor backend
  drivers/virt: rename VBS park loop to secure_monitor
  x86/realmode: skip the sub-1M trampoline for the VBS secure plane
  KVM: x86: deny normal-plane access to secure-plane memory
  KVM: plane: handle KVM_CHECK_EXTENSION on the plane fd
  KVM: selftests: run plane tests with a split IRQ chip
  kvm: x86: drop obsolete kvm_cache_regs.h
  kvm: arch: finalize plane hooks and kvm_arch_vcpu_create signature
  kvm: x86: use kvm_vcpu scheduling-state accessors and struct stat
    fields
  kvm: x86: finalize per-plane APIC state and CPUID placement
  kvm: planes: reconcile core plane state, UAPI and hypercall exit

-- 
2.55.0

