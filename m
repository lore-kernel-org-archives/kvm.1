Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514FF41C72
	for <kvm@vger.kernel.org>; Sun, 21 Jun 2026 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049033; cv=none; b=l7p6U6etGeao4v6WkrsB1mEwv03Jz9EOnY7ABxyAaK+LoowaRJ5AsCFxQ6z31P6O9JTddjb66ufh9w1fRSmSnlO5HQWum/pZ4j+K/0QCXr+iErkIEdpuvMiNB5+gfBNK50EHSbI9S2MMAAHQwSKVridUBsqGz+w7R5BAOxjIkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049033; c=relaxed/simple;
	bh=6ihalu85en/+gN7tgPEPg2Vj92sCtuBXcx5ejgJvQ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aw21HH3uzn1GMKAc+RUVCCLbjI/VDdnB8GALOKSaxIsnG7lsD+qm/Ot0mmU6syQr8kEChUqOeOCGsxYAc0ss1GFNriRgjbW+QuFMRkPwOMdaaBvPqcytpr2V6zmtUC4xnEsKpSWK6fUudxWjvohuneRXeuX612We59giZV+NLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfKROgm4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfKROgm4"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so26030005e9.1
        for <kvm@vger.kernel.org>; Sun, 21 Jun 2026 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782049031; x=1782653831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/+hi9dABkCsEUrlA98qCvRSl1EMUnAqOVs23V/vAGE=;
        b=JfKROgm4JBgDFUzpRcYMw/GogccEVb38UET3ucjgK9FvTTKKBqe8/qydrsgEvG2Aqq
         xEGzySq15bo6gFrmtTV4PQcOrg+1zWzEL+Lize1YOxb682CZPHC9W4v4fmTF5lRBImgR
         /1dUdHjc7RngZZ/L2tQJ76RsEArHSjSg2+7SXlWyao/lR/t6X+CtRtOPAPzy5WKVq7FE
         BHf1d+POqdZ4mrRs3URHcaB4d3weRzLgI8wNzAlCUZKbLeG9q2YG1Y66yEtRlg6tewYo
         gUOp78X39AYfGyNVznU4mPeahXb/ukhEDbJOHPZ+1H+xQLy7cneZKkLBbmG/ebGNcJ7g
         gKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782049031; x=1782653831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/+hi9dABkCsEUrlA98qCvRSl1EMUnAqOVs23V/vAGE=;
        b=qcoGhn4rFcadD/eCJP09UJdcbBgyIJEJ8nRSlKT2LUKwqHEMEIm89LbRxLSvOdZJGQ
         UmikKtLEaQXH8gPVL+87el6J7jk7we3AjBSpeZDtCgLXfITLWJevn/7zVkceogM/sbay
         KdEyZAkrjOpgKEBohMOUAGK8w27RS05qhBMoY3yopvipdduhGhaoIAOpjOqOqs/6ULCN
         OfclIztmgGQF6dVrd1XPDHqbUWElIwoBYwn9/m1VwoF0AXoCXGxqbr/6yz+JxF9Mj1fL
         xm2z1WCFG7TFgKKEec+Qv4Zmags8FP5VDm8rGRNadD53W7oXfFFv4SOS1e8Lo8sElWWZ
         N97w==
X-Forwarded-Encrypted: i=1; AFNElJ81BxxXqJppnuCxgePKcjILAoljbjm6/MQnMM4dsEWUip16lo32QrkfDir2SG3+Jz1vTBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+LwGn57kYF0dhvCpq4kqHboyMPU+uPANeLU1kplzvPrYlQr1
	2sSxsWmiecSXjeNqkrimJLt1JbJccYyDjqQjgHgmLPnsQzA0W9K2KDsu
X-Gm-Gg: AfdE7ckgt3T/YoU5nJ39K3+Fv4xHqw5ZEo/iX+aCnPk8wd6xkOFp0MfJu1La6IkURp4
	7YAF4LI4EflmvPTKECv6BPhHKRGO+s+YmHwqDnhz/HUyCf24f0skAJ39fMuSv+KiLOWFKswY1AA
	YjhxhIVCHQYZZ9sIFJsAwUOvaUkDhoaWc1tI+WcUOtL8g889oId5NP8SNXek5b4OG4cUzlDT4bS
	+n7mV9ojK4PsQMvMJHfs75QZSOoeaV/E+9I5g2ttpc5z6nhKGxbTswTzu7QECeLBRhBrIXD2OK4
	8SwpuSXBWV1QFvfy76fnQygtUA9EmcCnsirH4dxE/QhqXPJgHqtDtnAx3aGO5w4uYWJkVV94MW7
	brwXb43xoA/VjAopppyq5Q90mmDFl+MvZtfTlx81hbJkYlZ9jejF2tXYJ5Qw4gLpF6joICkeCZX
	tckDdwiwLxBCpgUhPCBQ==
X-Received: by 2002:a05:600c:19c8:b0:492:4cc7:de73 with SMTP id 5b1f17b1804b1-4924cc7df3dmr76007435e9.31.1782049030547;
        Sun, 21 Jun 2026 06:37:10 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5397sm18864155f8f.13.2026.06.21.06.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:37:09 -0700 (PDT)
From: mike.malyshev@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mikhail Malyshev <mike.malyshev@gmail.com>
Subject: [PATCH 0/1] KVM: x86/mmu: don't kill the VM on access to a disabled passthrough BAR
Date: Sun, 21 Jun 2026 13:37:07 +0000
Message-ID: <20260621133708.3454718-1-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Malyshev <mike.malyshev@gmail.com>

A guest with an assigned PCI device can crash its own VM by toggling
PCI_COMMAND.MEM on that device while another vCPU accesses the device's
BAR. KVM_RUN returns -EFAULT, which userspace (QEMU) treats as fatal.

This is a guest-triggerable, host-side VM kill, so I think it is worth
addressing in KVM rather than papering over it in userspace.

The window
==========

A passed-through BAR is mapped into the guest via a VM_IO/VM_PFNMAP VMA
whose fault handler (vfio_pci_mmap_fault()) refuses to install a PTE while
the device's memory space is disabled. When the guest clears
PCI_COMMAND.MEM:

  - the kernel vfio config-write path zaps the BAR's userspace mapping;
  - userspace's memory listener later removes the corresponding KVM
    memslot.

A vCPU that faults on the BAR in the window after the mapping is zapped but
before the memslot is removed lands in the page fault path with a *valid*
memslot but a backing whose fault handler declines. hva_to_pfn_remapped()
returns an error, the gfn resolves to KVM_PFN_ERR_FAULT, and
kvm_handle_error_pfn() returns -EFAULT.

On bare metal the same access is an Unsupported Request (reads all ones,
writes dropped), not a fatal error. This series makes KVM emulate the
access as MMIO in that case, matching hardware, while leaving genuine
faults (e.g. a vanished anonymous backing, vma == NULL) returning -EFAULT
as before -- consistent with what tools/testing/selftests/kvm/
mmu_stress_test.c already asserts.

How it was found / confirmed
============================

The crash was originally hit in production on edge devices that pass an
Intel iGPU (Raptor Lake-P) through to a guest; the guest's display driver
clears PCI_COMMAND.MEM on one vCPU while another vCPU is mid-MMIO to BAR0.

To study it deterministically I built a reduced, hardware-light reproducer
(no specific guest OS required, the race is host-side):

  - a Linux guest with any assigned PCI device whose BAR0 is mmap'd from
    userspace (/sys/.../resource0) and hammered with a tight MMIO write
    loop on one vCPU;
  - a second thread that toggles PCI_COMMAND.MEM 1->0->1 on that device
    via the VFIO config region.

Without this patch the VM dies within ~1 s. eBPF on the fault path showed
the -EFAULT originating in the faultin path (kvm_mmu_faultin_pfn ->
kvm_handle_error_pfn) with the memslot valid (flags=0, not
KVM_MEMSLOT_INVALID), no mmu_notifier invalidation in progress, and the
pfn equal to the GUP-error value -- i.e. the VM_PFNMAP fault handler
declining, exactly the case this patch targets. (An earlier attempt to
treat it as a stale-mapping race and retry on mmu_invalidate_retry_gfn()
did not help, because by the time of the fault the invalidation has
already completed and the seq is stable; that confirmed the failure is a
steady-state "device decoding disabled" condition, not a transient
invalidation, and led to the MMIO approach here.)

With the patch the same reproducer survived 200k toggle cycles, and a
fleet of 17 devices ran 48h with no recurrence.

Open questions for reviewers
============================

 - hva_to_pfn_remapped() can in principle return an error for reasons
   other than "fault handler declined" (e.g. an OOM from
   fixup_user_fault()). Treating all of them as MMIO is what this patch
   does for simplicity; I can instead plumb the specific condition through
   if you'd prefer to narrow it.

 - I could not find a clean way to add a selftest: a faithful regression
   test needs a VM_PFNMAP backing whose fault handler can be toggled,
   which from pure userspace means /dev/mem or a real assigned device
   (neither CI-portable), or a dedicated test module (outside selftests).
   Guidance on the preferred shape would be welcome.

Mikhail Malyshev (1):
  KVM: x86/mmu: Emulate, don't kill the VM, on access to a disabled
    passthrough BAR

 arch/x86/kvm/mmu/mmu.c   | 16 +++++++++++++++-
 include/linux/kvm_host.h |  8 ++++++++
 virt/kvm/kvm_main.c      |  9 ++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.43.0

