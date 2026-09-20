Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8732330652
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889106; cv=none; b=F6zYaSUt8379qZ35u3p1SM8lK7LG4LknL/aeWECLRHwcAaKOFO+tOKTyanlxIpCWp7CSsgJWJAik/2L8tfppn16W0XIQOI6kfMO6YZf0vvBaSJBYlWrhvBmXHS3AbEB3jbVlycm5LOF4epVSRJAN6uhwHB7Za4L+7fOq8pD3nOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889106; c=relaxed/simple;
	bh=eA25W9wPF906HF0oiOd65O9ppQ/GP3fr4a+upcr0/ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqyRD6r7mq0z+ebO02xHS8jFbLupwzZ4fKRfwB7MBkyiTo3AnrbvNKCswaH2tSyk6bHX4GG4l70IjloGMgN9zYjfpAl/v8U1z2JPOFnR+/9nM3Cw9XzsQKs9Kdl3yKKTK/9n9kuT069w4lpb+2x0NCJ4EEELnLXAcINiKZnrXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoZvOtP+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoZvOtP+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso9328375e9.0
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789889102; x=1790493902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AVd7bFzd0ZX9iRwPMPjomvmczu/wfwuYfR0YpCmlLo8=;
        b=DoZvOtP+o1XuZrDCA4wWGEd2o13QWSRKByrDZwByGkT/KwZanxY3O7c93sYZEK2XRY
         fjgSXGgAK8HXMGhnKBWRGhnlonn8RSobSQYelWLKa2TTagcaL5vjkbqdlpjPg6YXTof+
         1mP12GXtRHo3WTWCe59f5053XISKiI3ZjT3yH71dLSzmuLxSr3+vBA4x1g3rvAKTqeGr
         LaGR6YICxnR1I1ah/3qmTYc89LK+d45l+f6zUrQc+yu1qaf93/qPLEEbo5fjT2XYPJV3
         jcC3qgM3qVjXqwkl4N2DD+LEG4k7ba9HylO9LfiKAnHZDVjLNM/shgGY4dTVxOkB8U3/
         9oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789889102; x=1790493902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVd7bFzd0ZX9iRwPMPjomvmczu/wfwuYfR0YpCmlLo8=;
        b=TFnJ5NsbpPpLDlm2xia9Su5vayZfnW/E5Oju0GBI8fPa+vLiGVDvXNuS43J7sqy8Q0
         TYwZuR1VuZtoyheBLmzRSgoTCswR9gmUxukQXisTlGfKrxtzAmM7QjNvLEZ5UEbmmLqL
         gx/hkjqaP81F6pP0FsEFkH54qQA7VZAlBcTiHrp2hQ2UpYkAj9iYKY/BceuLGFMxT7gl
         ZJRenLTqYs+ju6yWGbVPURc2l9YXxgpGu1ndA6XzjEv0pdz7EB1YGvxEo1BoNA4fVIKn
         6OYqnhFVht8DXRJSXn2mGVSQL3o6ie6NzbQkuSRATKkPf2BG7UoAAbUn3X/ZyiZ7VtwV
         yxbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxj28uKRjvh7HBEKAZu+wUOVnKfstKCHPOfMsUUTi/AIdxr8C5YfnBeWGaqPBqdWK1UucE=@vger.kernel.org
X-Gm-Message-State: AFuF++nS8fo8ClSGm+cx+Q3fYgK+D54mFq4jMFdBMaSZ8q7BhUgf4u1i
	npplgMqEsDZgOy1pyMiclyq+zXDKP0/ypIoiT0yvVc9MHrqM1kHMSsXI
X-Gm-Gg: AYBFou1j2ZVOHcF55k2GyG5+M6lpIuNs2jT4yzci1RWLtqstVOVi+8+e9IOewqAhTKZ
	VsAxwaf1sUvYSthDhEGM9bDy7n1BLW9QigXKXFxvWuIsAxR5DNKiOTVKsGPv3NMvfpYpyqirgRn
	EJn40q2BPW20Xs7qazG1IQcudOiePFVcVF5K39gnzJG30urxz+2Cjaf5XggWNAn0wCaWlagdKVE
	5enWU0KcSh5TBAZ03EdfB9oRgmLNHX0kPO2LCE96JEOB1Nr5N38DR7vGH9wTK6KwTEnloX5JkJb
	o10sgy5dZJarlM7xz0mG3te3b2AGHAG33IlAbG+aWVZC5eXrIVfr6YChAVB61AdeFuk1/UxgfS/
	8vPGoA4v2veRRvMxTr5n0dWmBSwaxNRgoiEES4vTsCTWG2hHMHtINBi2/Pw7TdppqKnY2OQEf67
	5TJ373YRwBhS9qiiN2yf0EAeoxAZB+YvQw/xTU3UEunA7f6TMdII1fSYK70JP4TSpKB5ag/AxrC
	k5t
X-Received: by 2002:a05:600c:3b8e:b0:49f:bc43:9e96 with SMTP id 5b1f17b1804b1-49fc57144aamr126372555e9.8.1789889101638;
        Sun, 20 Sep 2026 00:25:01 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm125191575e9.9.2026.09.20.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 00:25:00 -0700 (PDT)
From: mike.malyshev@gmail.com
To: seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org
Cc: amoorthy@google.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	chao.p.peng@linux.intel.com,
	xiaoyao.li@intel.com,
	yu.c.zhang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Mikhail Malyshev <mike.malyshev@gmail.com>
Subject: [PATCH v2 0/2] KVM: x86/mmu: Fill memory_fault for unresolvable guest page faults
Date: Sun, 20 Sep 2026 07:24:57 +0000
Message-ID: <20260920072459.3485710-1-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Malyshev <mike.malyshev@gmail.com>

When KVM cannot resolve a guest page fault, kvm_handle_error_pfn() returns
a bare -EFAULT.  KVM_CAP_MEMORY_FAULT_INFO documents the opposite: that
KVM_RUN fills kvm_run.memory_fault "if KVM cannot resolve a guest page
fault VM-Exit, e.g. if there is a valid memslot but no backing VMA for the
corresponding host virtual address".

The gap has a practical cost.  On a host that assigns an Intel integrated
GPU (Raptor Lake-P) to a guest via vfio-pci, the guest's display driver
clears PCI_COMMAND.MEM on one vCPU while another vCPU is mid-MMIO to BAR0
of the same device.  vfio-pci zaps the BAR's mmap, so the second vCPU's
fault finds a valid memslot whose VM_PFNMAP fault handler declines to
install a PTE, and KVM_RUN fails with -EFAULT and nothing else.  The VMM
has nothing to act on and kills the VM, even though the guest did nothing
architecturally invalid and the condition clears as soon as the driver
re-enables memory decoding.  This reproduces on demand and has been
observed in the field on production edge hardware.

Patch 1 is Anish Moorthy's 2024 patch [1], code unchanged, with the
changelog rewritten around that user.  Patch 2 converts the remaining
WARN_ON_ONCE()-protected -EFAULTs in x86's fault path to KVM_BUG_ON() +
-EIO, so that an -EFAULT out of the fault path consistently means "guest
access KVM could not resolve" rather than "KVM is broken".

Changes since v1
================

v1 [2] took a different approach: it mapped KVM_PFN_ERR_PFNMAP to MMIO
semantics inside KVM.  Sean objected that giving PFNMAP memory emulated
MMIO semantics changed long-standing ABI inconsistently, and outlined this
approach instead [3][4], including the shape of both patches.  v2
implements that outline:

  - report the fault via KVM_EXIT_MEMORY_FAULT rather than inventing MMIO
    semantics for PFNMAP memory;
  - take Anish's patch rather than writing an equivalent one, crediting
    both authors;
  - add the KVM_BUG_ON() + -EIO conversions as a separate patch;
  - x86 only, and based on kvm-x86/next rather than linus/master.

The userspace half
==================

This series reports the fault; it deliberately does not define what an
access to a BAR with memory decoding disabled returns.  That policy belongs
in userspace, and QEMU does not implement it yet: QEMU routes
KVM_EXIT_MEMORY_FAULT into its guest_memfd conversion path, which rejects
a vfio BAR -- a ram_device region with no guest_memfd -- and stops the VM
with an internal error.  Unmodified QEMU therefore still loses the VM
exactly as it does today on a bare -EFAULT; only the reported error
changes.  A QEMU series emulating Unsupported Request semantics for this
case -- reads return all ones, writes are dropped, as the hardware does --
will follow and will link back here.

So this series does not regress today's userspace, but neither does it
fix anything for it: it is the enabling half, not a standalone crash fix.
That is also why patch 1 carries a Fixes: tag but is not tagged for
stable: a backport would not help any userspace that exists today.

Testing
=======

arch/x86/kvm/ builds clean with no new warnings for x86_64 and for i386
allmodconfig, the latter covering the 32-bit-only hunk in patch 2.
checkpatch.pl --strict reports 0 errors, 0 warnings, 0 checks on both
patches and on this cover letter.  End-to-end testing against the
reproducer requires the QEMU counterpart and will be reported with that
series.

Link: https://lore.kernel.org/all/20240809205158.1340255-1-amoorthy@google.com/ [1]
Link: https://lore.kernel.org/all/20260621133708.3454718-1-mike.malyshev@gmail.com/ [2]
Link: https://lore.kernel.org/all/ajnEAkFGyJWmomhq@google.com/ [3]
Link: https://lore.kernel.org/all/aj1Vc13mqb-fXiow@google.com/ [4]

Anish Moorthy (1):
  KVM: x86/mmu: Report a memory fault exit when the fault handler
    EFAULTs

Mikhail Malyshev (1):
  KVM: x86/mmu: Convert can't-happen fault path EFAULTs to KVM_BUG_ON()
    + -EIO

 arch/x86/kvm/mmu/mmu.c         | 13 +++++++------
 arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
 2 files changed, 9 insertions(+), 8 deletions(-)


base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 
2.43.0

