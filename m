Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11473CBE6D;
	Wed,  8 Jul 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492439; cv=none; b=CRyUrfPcB/B1yx2rHd93JH0j5/9w+7oQhk4mzHp4nu8xcDCC260VFOSTVogbbytTSmZMiVFoG3QxUtkNcBI4QLaAap3R1jfvL92Zu3Iuoer3l+vTdwUsXeW4u/6OVpiZfX+zFtIDGg5fIjjWLQ6tgqWOe1SkBnKJEUjsphSbN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492439; c=relaxed/simple;
	bh=JEnwHDdr2GBqgVScnWjfxq86SvGuGF3N+hwawbnrTOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUSXFABVL/tBU1+Nh3pd9bDhP1b5BHDP1R0V8NkV4GyguMdxMQEctLqdVOcozjfOzcTgqThxAPtwc7RLTQfJwYiAIU3Ch38SHySR+Jdv5mi29bhQr7worVIEcdBzXwfNqRu4ScLbxoQd5W277K9bLvr8Zgkfdh/DLOWPIBMNF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otnFCNu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otnFCNu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B51F000E9;
	Wed,  8 Jul 2026 06:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492437;
	bh=KBV7Fo5eSCy8KcVruYEtnD3WFJOtcXfQTAl3avf7zxo=;
	h=From:To:Cc:Subject:Date;
	b=otnFCNu/AKGnfogyiBoPEfCc22Cm16zBTnKA9vTwPBauAI0tbVNelCw2pcqnVUm/k
	 uqmpHP3YLzEfiNpGIHGNY328Ilj0yuetqttHWHikv32p1qznCSDP9isVxc4l4rUY+z
	 xYoIAbceBIaI6+OOaTRvVHgWRYBth9UXl1uJHsxOGbwH+zNUU14er4WGesankAMQwN
	 6IMdIC5VXpk+8NNAz6/gGyVOS8Ix6/TzHe9OnvmdcA+tm0Op/OEySwifGtqyaUzsEz
	 8v/9ssf/6OtczLazb8iq9OldOFusk+s4E6uHn7EQBRXiQ5BzcZBC47CPSfnQj76zxO
	 Fz6xD0GgNGepw==
From: "Naveen N Rao (AMD)" <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>
Cc: <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [RFC PATCH v3 00/27] KVM: SVM: Add support for SEV-SNP Secure AVIC
Date: Wed,  8 Jul 2026 12:01:58 +0530
Message-ID: <cover.1783490022.git.naveen@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is RFC v3 of the patches adding KVM support for Secure AVIC. RFC v2:
http://lore.kernel.org/r/20250923050317.205482-1-Neeraj.Upadhyay@amd.com

There are significant changes throughout the series since the last RFC, 
with some of the highlights being:
- Integrate with AVIC code since Secure AVIC is APICv, but for protected 
  APIC guests. This aligns with TDX which also requires APICv and 
  enables reuse of APICv code paths in KVM. Patches #8 to #14.
- Mandate use of split irqchip, and drop changes related to the KVM 
  IOAPIC. KVM PIC/PIT can't be supported (described more fully in the 
  commit log of the relevant patches). Patch #24.
- Enable use of SVM_AVIC_INCOMPLETE_IPI VMGEXIT for vCPU notification 
  request from the guest. Patch #22.
- Utilize vNMI injection path for NMI handling. Patch #23.
- Introduce a new kvm_x86_op to distinguish need for injectable 
  interrupts vs. IPI notifications. Patches #18 and #19.
- Retain KVM PV ops, and instead require guests to opt-in/disable.  
  Patch #3.

Patches #1 to #4 are changes to the guest x2APIC Secure AVIC driver.

These patches apply on top of Sean's recent fixes changing AVIC init 
code (since I was carrying a similar patch):
http://lore.kernel.org/r/20260630210156.457151-1-seanjc@google.com

There are still some rough edges to iron out, but I wanted to get some 
feedback on the overall direction. Please let me know if you see any 
major red flags.


Thanks,
- Naveen


Kishon Vijay Abraham I (2):
  KVM: SVM: Set VGIF in VMSA area for Secure AVIC guests
  KVM: SVM: Do not inject exceptions for Secure AVIC

Naveen N Rao (AMD) (20):
  x86/apic: Drop savic_eoi() in favor of native_apic_msr_eoi() for
    Secure AVIC
  x86/kvm: Disable PV_SEND_IPI if Secure AVIC is enabled
  x86/apic: Use AVIC_INCOMPLETE_IPI VMGEXIT for Secure AVIC IPI handling
  KVM: SVM: Add helper to check if Secure AVIC is enabled for a guest
  KVM: SVM: Set guest_apic_protected if Secure AVIC is enabled
  kvm: irqfd: Have kvm_arch_has_irq_bypass() take struct kvm pointer
  KVM: SVM: Disable IRQ bypass for Secure AVIC
  KVM: SVM: Add avic_ipiv_is_soft_disabled() as a wrapper around
    enable_ipiv
  KVM: SVM: Disable IPIv for Secure AVIC
  KVM: SVM: Short-circuit a few AVIC flows for Secure AVIC
  KVM: SVM: Warn if we ever receive AVIC_UNACCELERATED_ACCESS #VMEXIT
  KVM: SVM: Do not inhibit AVIC for SEV-SNP guests if Secure AVIC is
    enabled
  KVM: x86: Add a new kvm_x86_op protected_apic_has_injectable_intr()
  KVM: SVM: Implement kvm_x86_ops->protected_apic_has_injectable_intr()
    for Secure AVIC
  KVM: SVM: Implement kvm_x86_ops->protected_apic_has_interrupt() for
    Secure AVIC
  KVM: SVM: Add interrupt delivery support for Secure AVIC guests
  KVM: SVM: Add support for incomplete IPI handling for Secure AVIC
  KVM: SVM: Add support for injecting NMIs for Secure AVIC guests
  KVM: SVM: Mandate use of split irqchip for Secure AVIC
  KVM: SVM: Advertise Secure AVIC support for SEV-SNP guests

Neeraj Upadhyay (5):
  x86/apic: Propagate APIC_SPIV writes to hv for Secure AVIC
  x86/cpufeatures: Add Secure AVIC CPU feature
  KVM: SVM: Add handler for VMGEXIT Secure AVIC NAE event
  KVM: SVM: Do not intercept SECURE_AVIC_CONTROL MSR for Secure AVIC
    guests
  KVM: SVM: Do not intercept exceptions for Secure AVIC guests

 arch/arm64/include/asm/kvm_host.h   |   2 +-
 arch/x86/include/asm/cpufeatures.h  |   1 +
 arch/x86/include/asm/kvm-x86-ops.h  |   1 +
 arch/x86/include/asm/kvm_host.h     |   9 +-
 arch/x86/include/asm/svm.h          |   9 +-
 arch/x86/include/uapi/asm/svm.h     |   1 +
 arch/x86/kvm/svm/svm.h              |  12 ++
 include/linux/kvm_host.h            |   2 +-
 arch/powerpc/kvm/powerpc.c          |   2 +-
 arch/x86/coco/sev/core.c            |  18 ++-
 arch/x86/kernel/apic/x2apic_savic.c |  36 +-----
 arch/x86/kernel/kvm.c               |   3 +-
 arch/x86/kvm/irq.c                  |   5 +-
 arch/x86/kvm/svm/avic.c             | 105 ++++++++++++++++--
 arch/x86/kvm/svm/sev.c              | 164 +++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c              |  59 ++++++++--
 arch/x86/kvm/vmx/posted_intr.c      |   2 +-
 arch/x86/kvm/x86.c                  |  21 +++-
 virt/kvm/eventfd.c                  |   2 +-
 19 files changed, 382 insertions(+), 72 deletions(-)


base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
prerequisite-patch-id: 1428b4903537b426ee3822a74adf29fbbbeb8e02
prerequisite-patch-id: c88b0c2cb26fb85fc7ef07409aeaf643565b8600
prerequisite-patch-id: a3f8fc507b7809645b001e9394a51f8b299aae47
-- 
2.54.0

