Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F949E126
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875345; cv=none; b=gzhIx69hPkGaBU262FiOrUBpIMCn/N7lNuQtb/mGuj4vjcD7U50k5FJ+Gd9VnrKOuBp5kmRxMbLDeNHQnqQMH0mHif5D0l+53hAvhw+pBRRCZVSYNPI6CKy/a6ZPQinoewQQelvuglSBYSe0ouKlPaDnh2j0ylmJso9UlLT9aWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875345; c=relaxed/simple;
	bh=N8mioDvdo5daJet3hIcOI20hbgj9UqQpZA8C8PRYWSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tuhaMTYzYuAEgXgW5JDammIdil80ZNI9lxBkHhkVok8EKiEhuSexGtA0wQwb+llIpDZ8le6fH+GfoGDVg8tqivTm3o8T6bJuJWvS1zNp5rFiwyWZA2Y199uKYxZ13qQMtLC6OYuJ65bcDVst/nOsYj7NEuAS0l1aJTavdbZsAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOByoh7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOByoh7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790875341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1JsxJI1DK+UFFG7hyWzL3KnReeR7YmIro8TUxSnhdD8=;
	b=GOByoh7QU+DqGu9C8qmZvyBO5lJ36S9p7EZ9A2h4OL67xvYp38YHQxRz2FaTeXCt7CUNit
	mlknx5AsXccyBzO1dq6Mw/rGt+gN1k3838ZltciEmuBZ/Wy0bEoIrVFSjGcAJEaTxffLrY
	ebQvBsxu9AAL3Hz67i3mzZWqvtCwL3M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-b_b4-IsQNauilYwSrb5Sow-1; Thu,
 01 Oct 2026 13:22:17 -0400
X-MC-Unique: b_b4-IsQNauilYwSrb5Sow-1
X-Mimecast-MFC-AGG-ID: b_b4-IsQNauilYwSrb5Sow_1790875336
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE0D11865DA0;
	Thu,  1 Oct 2026 17:22:15 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AFED1800446;
	Thu,  1 Oct 2026 17:22:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.3-rc6
Date: Thu,  1 Oct 2026 13:22:14 -0400
Message-ID: <20261001172214.209754-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Linus,

The following changes since commit c2f24f140c2ee6c00775c2a93c6ac931acec2b60:

  Merge tag 'kvm-x86-fixes-7.3-rc5' of https://github.com/kvm-x86/linux into HEAD (2026-09-26 00:40:07 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to f9bfc323e76120c2cd1fdea93bbf315eec5eb934:

  Merge tag 'kvmarm-fixes-7.3-2' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2026-10-01 13:13:57 -0400)

As mentioned in the previous PR, these are the patches that didn't make
it in time for rc5.  The most intrusive change is reverting a commit
from 7.3-rc1 that made struct kvm a bit too large, and fixing the same
issue otherwise.

There are again a lot of selftests lines; the sheer number of commits is
not small but I don't expect much more for 7.3 due to people travelling
to Plumbers next week.

----------------------------------------------------------------
ARM:

- Take a reference on the last IRQ loaded into an LR to prevent it
  from being freed while running the guest (Marc Zyngier)

- Ensure that the ITS MOVALL command only affects LPIs that were
  previously affined to the source redistributor (Marc Zyngier)

- Fix + test for honoring the host's trap configuration when running
  non-protected VMs while KVM is in protected mode (Fuad Tabba)

- Use the host stage-1 mapping granularity for VM_PFNMAP mappings at
  stage-2 (Mostafa Saleh)

x86:

Various bugfixes where the guest could do stupid things on purpose to
cause problems in the host:

- Failed VMRUNs can cause pending TLB flushes to be dropped, and in
  general some actions done through VMCB control fields have to be redone
  if VMRUN fails

- Toggling MSR interceptions or eVMCS execution controls can cause the
  host to use a stale MSR permission bitmap

- Bad page tables can cause a WARN.

Also fix issues in last week's pull request (my fault, for changing
email workflow and thus missing feedback sent to kvm@ but not LKML).

Generic:

- Take kvm_lock when creating vCPUs. For almost two decades everybody
  thought it was not done for some unspecified performance reasons, but
  in reality it was only done because kvm_lock was originally a spinlock.
  This is a better fix than 97d65b544f48 ("KVM: Check for duplicate vcpu_id
  as early as possible", from the 7.3 merge window), and does not waste
  2K per VM, hence its inclusion here.

----------------------------------------------------------------
Fuad Tabba (4):
      KVM: arm64: Apply the fine-grained UNDEFs without FEAT_FGT
      KVM: arm64: Clear HCR_EL2.RW for 32-bit non-protected vCPUs
      KVM: arm64: Use the host's HCR_EL2 for non-protected VMs in pKVM
      KVM: arm64: selftests: Check a feature hidden in an ID register is UNDEF

Marc Zyngier (3):
      KVM: arm64: vgic: Allow last_lr_irq to be NULL when LRs are not overflowing
      KVM: arm64: vgic: Take a refcount on IRQs referenced by last_lr_irq
      KVM: arm64: vgic-its: Fix MOVALL handling of source redistributor

Mostafa Saleh (1):
      KVM: arm64: Use stage-1 leaf size for VM_PFNMAP

Paolo Bonzini (1):
      Merge tag 'kvmarm-fixes-7.3-2' of https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

Sean Christopherson (21):
      KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
      KVM: arm64: vgic: Rely on vCPU creation check in "trylock all vCPUs"
      KVM: RISC-V: Use kvm_is_vcpu_creation_in_progress() instead of open-coded equivalent
      KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
      KVM: Move check for existing vCPU ID to the top of vCPU creation
      Revert "KVM: Check for duplicate vcpu_id as early as possible"
      KVM: WARN if vCPU creation is in-progress when locking all vCPUs
      KVM: x86/mmu: Bail from shadow walks if the root is invalid or a dummy
      KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on failed VMRUN
      KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN succeeded
      KVM: SVM: Don't mark ASID fields as dirty when setting control.tlb_ctl
      KVM: SVM: Sync guest's PERF_CNTR_GLOBAL_CTL from h/w only on successful VMRUN
      KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
      KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls are modified
      KVM: selftests: Add x2APIC MSR test for inhibiting APICv while nested
      KVM: selftests: Run the nested x2APIC with and without APICv being inhibited in L2
      KVM: selftests: Verify that L0's TPR doesn't get clobbered
      KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt
      KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12
      KVM: SEV: Nullify "have run CPUs" mask pointer when freeing it
      KVM: SEV: Do cache maintenance on the source VM *before* clearing SEV state

 arch/arm64/kvm/emulate-nested.c                    |   3 -
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h             |   9 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |   7 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  25 ++-
 arch/arm64/kvm/mmu.c                               |  47 +----
 arch/arm64/kvm/vgic/vgic-init.c                    |  12 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |  12 +-
 arch/arm64/kvm/vgic/vgic-v2.c                      |   6 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |   6 +-
 arch/arm64/kvm/vgic/vgic.c                         |  21 +-
 arch/powerpc/kvm/book3s_hv.c                       |   2 -
 arch/riscv/kvm/aia_device.c                        |   2 +-
 arch/s390/kvm/s390/s390.c                          |   5 +-
 arch/x86/kvm/mmu/mmu.c                             |   6 +
 arch/x86/kvm/svm/sev.c                             |  57 +++---
 arch/x86/kvm/svm/svm.c                             |  43 ++--
 arch/x86/kvm/svm/svm.h                             |   1 +
 arch/x86/kvm/vmx/nested.c                          |   6 +
 arch/x86/kvm/vmx/tdx.c                             |   5 -
 include/linux/kvm_host.h                           |   1 -
 tools/testing/selftests/kvm/Makefile.kvm           |   2 +
 .../testing/selftests/kvm/arm64/hidden_features.c  | 184 +++++++++++++++++
 .../testing/selftests/kvm/x86/nested_x2apic_test.c | 222 +++++++++++++++++++++
 virt/kvm/kvm_main.c                                |  35 +---
 24 files changed, 554 insertions(+), 165 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/hidden_features.c
 create mode 100644 tools/testing/selftests/kvm/x86/nested_x2apic_test.c

