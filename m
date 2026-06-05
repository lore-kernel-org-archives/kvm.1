Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D43815DF
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679326; cv=none; b=sKxsCdfWKDxu3hX1dq9qMbdmZ0YGnaBnuLMawuQKYgHRuyfD80cyV/oKYmMhz+Xgrc2WlYhMSVphNTqHWNuVG+yTd+pGpXqUvj03a30YO1e3v49DyKhajM+2TaB71MdTAzHhJ/t6G9J6HUkqcUvv7kw6wdF+zMDnrtO2ktcBt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679326; c=relaxed/simple;
	bh=3niKRmDHxwyRp2JeLNFOtmvwBY8emWKsp6bOTgXVikk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iWxfUo+Mi6VZaRtBp6b5cvakFUBuCr8OvEHteFnqSyJaBHySHK7lsjvGtKZLnlXN2hKyCdN81SKV0ESEAG+Yh4FDNhT8hoTXekghWduQp1ZhupX8+w97G35UouGAKhNmsamKJZW1gNc422/BvZnwTewXlcyfxgggZKG5GVlZv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KG5FV+qp; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KG5FV+qp"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-beb833df15dso342935366b.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679321; x=1781284121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5WfUZoABBIW0tyIpALU+TWbIZ4Vz/CJ1yqpAAE2dls=;
        b=KG5FV+qpzqT+64U83cCKMTuOIsrLsTnLN5AJ9pKYfP8bdRmm4ZYKzMjORBLWHhCyAV
         y7ArbZFylCEHcVo6IRTt6gwi3MgDW0G1HILtXRuT99gDpOebNEgQ2a3kCn+SHk530Cm9
         uSE2d15F0aCgeYIA5j0J6aW2DPCJSvZ2xeIMFMIEwBu+u+W+loAsCqLwykRJilazS6RS
         QPhnIMMGmbf7ghE95lu0VNM4RVAm7B/qwzL4xizz7psZnYBVmOpTnEvEllkM20gYvn9A
         NgOrHTLJ8cnenwTqvAcbBnJvzBl+POMq8ecqeuUbHHpop5IgFBo+gU6fJmVEJFwKLw+X
         GZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679321; x=1781284121;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5WfUZoABBIW0tyIpALU+TWbIZ4Vz/CJ1yqpAAE2dls=;
        b=bQonsiczqCZVxzAtuN4rdzbxYXJ4vmwtI44kp8Isd0ZX+LMsyAxERy7rzsubOvxq/O
         nhC8Fe8pk/8Vtj4z3DL3k8TwWPbRfp0Rx/5JF8hmDyqSTHShwFScw/znDxkIOP3gFMRr
         +SO2EzN4ZzkcLz+pJ/ar7BcJUGRwPE0U+HRapcfKehZdbfYabPZa987o/K41KDXSJ8qt
         fKJgdgvFukv9x2tDGyHBLabsJ1x6phJgiT2JBhBa9KBirMKsLcBdUQ5uZxQG5k+HlWtA
         lPcYRusjIiKcCrtUC2e5MiOKWWiGnUbOligmP8hmaVjtb0feIJnJ/C+R7KmSGO/rEJSL
         TpCA==
X-Forwarded-Encrypted: i=1; AFNElJ+vQZBLk+pO/chuPLbsTMp5DwxISUhX71SL9AwrPZUHp0RdIxC7TRWNH/bNcsze7/GB0oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9piVbDz0MfVY2uAG2Z/8TzE9sgOTZAsDRB5njZqPPRpD94xzc
	QGqKMy7TZJq3s/3sNvMxooKSPG/jPyfJkoCHDS8mucvYUhB5ERQIOx9L2ddo0Jlv+RDwIHfu63s
	u1E6+GAB0Ogo+zyyoNQ==
X-Received: from edbif10.prod.google.com ([2002:a05:6402:5d8a:b0:68b:12e9:a194])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9487:b0:bdf:b9fa:6683 with SMTP id a640c23a62f3a-bf3a71f72c7mr204228166b.14.1780679321346;
 Fri, 05 Jun 2026 10:08:41 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:25 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <cover.1780667929.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 0/10] liveupdate: kvm: Guest_memfd preservation
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Changes from V1:
1. Remove mem_attr_array preservation
2. Removed prefaulted guest_memfd condition
3. Updated the check for shared guest_memfd from INIT_SHARED to
   kvm_arch_has_private_mem
4. Added the document liveupdate/vmm.rst

Hello,

I am proposing this series as RFC, to initiate the discussion for
supporting the guest_memfd preservation. This will setup basic arhitecture
for VM preservation during liveupdate. This Cover letter has three
sections (please feel free to skip the section you already know):

A. Guest_memfd introduction:
To make the audience familiar with guest_memfd
B. Liveupdate introduction:
To make the audience familiar with liveupdate
C. Actual Implementation Design and questions.

**A: GUEST MEMFD INTRODUCTION**

Initially, guest_memfd was created to support guest private memory in
confidential computing VMs (CoCo VMs). It was designed so that whenever
a guest wants to grant the host access to private memory, a series of
calls occurs: from the guest to KVM, KVM to the host userspace, host
userspace back to KVM, and finally a new page fault maps the memory into
a separate shared address space. Conversely, if the guest transitions the
memory back to private, the subsequent fault is handled by guest_memfd.
(Dual Mapping Architecture). In such a VM, all guest memory is initially
shared. On the fly, the guest may request to change pages to private; the
metadata indicating which parts of memory are private is stored in an
xarray inside struct kvm (mem_attr_array). This array serves as the source
of truth for the fault mechanism, determining whether a mapping should be
created from host-userspace-mapped pages or directly from the guest_memfd
file. For private memory, Fault also calls architecture-specific function
to set up private hardware access (e.g., on SEV-SNP or TDX). This type of
guest_memfd is fully-private where shared mapping comes from userspace
mapped address space.

Subsequently, support was added to allow the entire guest memory to be
backed by guest_memfd. This led to the implementation of the MMAP and
INIT_SHARED flags for the guest_memfd inode. When KVM_CREATE_GUEST_MEMFD
is called with these flags, the guest_memfd becomes mmap-able by host
userspace. The INIT_SHARED flag is used to make the guest_memfd completely
shared between the host and the guest. Consequently, page faults from both
host userspace and the guest resolve to the same guest_memfd page cache.
However, under this configuration, marking a portion of this memory as
private is not possible. This type of guest_memfd is fully-shared.

If guest_memfd is created with INIT_SHARED without MMAP, the host
can never access the guest_memfd. But the memory is still considered
shared.

Hence, At this point, Only use-case of guest_memfd is either fully-shared
or fully-private.

There is ongoing work to make shared and private mapping in-place backed
by guest_memfd. [1] There is also ongoing work to back guest_memfd by
hugetlb pages. [2]

**B: LIVEUPDATE INTRODUCTION (LIVEUPDATE ORCHESTRATOR - LUO)**

Livepdate support was added in kernel to update the host kernel by
minimizing the downtime to minimal. This is generally achieved by
preserving the current state of the system and retrieve after boot to
resume from where we left it.

Any subsystem that wants to preserve themselves, register their handler
with liveupdate system. This handler includes calls to the following

*can_preserve (file)*:
This tells the luo system about the eligibility of the file. When
preserve ioctl is called, it first loop through all the file handlers
and call can_preserve, the one which return true, luo uses this file
handler fh->preserve call to preserve the file.

*preserve(file)*:
This actually preserves the file.

*unpreserve(file)*:
This unpreserve the file incase userspace want to go back.

*retrieve(file)*:
On new kernel boot, this function retrieves the file.

*finish(file)*:
When userspace decides that all the files in the liveupdate session has
been retrieved, it can trigger this to do final work of cleaning up.

LUO preserve its memory using KHO (kexec-handover). All these APIs will
be implemented using KHO calls.

**C: GUEST MEMFD PRESERVATION**

SCOPE:
1. Fully Shared Guest_memfd
2. Guest_memfd backed by PAGE_SIZE pages

Any VM whose memory is backed by such guest_memfd can be preserved
across liveupdate.

The preservation call is straight forward. It walks through the page
cache, serialize the folios and preserve them.

On the retrieval path:
Currently, creating a guest_memfd requires an associated struct kvm
(derived from vm_file / vm_fd). Since there is no direct way to pass a
VM file descriptor via the LUO API.

I leverage a companion patch [3] (Also added as part of this series
PATCH[1]) that allows one file to retrieve another file from the same
LUO session. This enables the guest_memfd retrieval path to obtain the
preserved KVM file, use it during guest_memfd file creation, and
subsequently populate its preserved memory.

Preserving the KVM file allows us to preserve additional VM-specific
metadata, which will be crucial in the future for cleanly resuming the
VM. Currently, it preserves only the VM type.

On the retrieval path:
KVM normally requires a unique identifier (fdname) upon creation,
which KVM typically assigns based on the newly created file descriptor
number. However, in the LUO retrieval path, the retrieve call restores
the underlying file structure and delegates actual file descriptor
allocation to LUO (check luo_session_retrieve_fd). Currently, I used an
atomically incremented sequence number as the fdname. I would like to
discuss whether userspace services rely on specific naming conventions
here. Or if we can change underlying the retrieve call
(luo_retrieve_file) to pass fd?

This series also introduces the inode freeze call for guest_memfd inode.
Which fails any subseuquent fallocate calls or new page fault allocation.
VMM is supposed to take necessary measure when it is triggering the
liveupdate. VMM must:
1. Either pause the VM before preserving the VM/guest_memfd OR
2. Take action (vm_pause or unpreserve/destroy liveupdate sequence)
   when a fault fails and VM_EXIT to VMM with -EPERM.

Preservation Order between VM and guest_memfd file:
There is no strict order, they are independent. Guest_memfd file needs
the kvm_file preserved token, which it update on freeze call as freeze
is called just before kexec jump. kexec fails incase freeze will be
unsuccessful, for this case, it will fail if vm_file token is not found.

Retrieval order for VM and guest_memfd file:
There is no strict order needed for retrieval.
1. If VM file is retrieve before guest_memfd: guest_memfd will be
retrieved and vm_file also retrieved and userspace hold reference to
both files.

2. If guest_memfd file is retrieved before vm_file: guest_memfd will be
retrieved and it will retrieve vm_file internally and userspace can
retrieve vm_file later. But userspace will not have reference to vm_file
and luo_finish() will drop vm_file final reference if userspace does not
retrieve vm_file before calling luo_finish(). This is valid case, as
guest_memfd can live without vm_file as in the case vm_file is closed
before guest_memfd file.

I have implemented the basic test, where it spawn a VM with guest_memfd
or 16MB and write data to its 5MB portion. After LUO preserve call, and
kexec, On retrieve, a new VM is spawn with the restored vm_file and
restored guest_memfd and the data is verified. It uses the liveupdate
test library [5].

Future Work:
1. Support private guest_memfd preservation.
2. Extend the support for guest_memfd with in-place conversion of
shared/private.

[1] https://lore.kernel.org/all/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com/
[2] https://lore.kernel.org/all/cover.1747264138.git.ackerleytng@google.com/
[3] https://lore.kernel.org/all/20260427175633.1978233-2-skhawaja@google.com/
[4] https://lore.kernel.org/all/cover.1691446946.git.ackerleytng@google.com/
[5] https://lore.kernel.org/all/20260511201155.1488670-1-vipinsh@google.com/

Pasha Tatashin (1):
  liveupdate: luo_file: Add internal APIs for file preservation

Tarun Sahu (8):
  liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
  kvm: Prepare core VM structs and helpers for LUO support
  kvm: kvm_luo: Allow kvm preservation with LUO
  kvm: guest_memfd: Move internal definitions and helper to new header
  kvm: guest_memfd: Add support for freezing and unfreezing mappings
  kvm: guest_memfd_luo: add support for guest_memfd preservation
  selftests: kvm: Split ____vm_create() to expose init helpers
  selftests: kvm: Add guest_memfd_preservation_test

 MAINTAINERS                                   |  13 +
 include/linux/kho/abi/kvm.h                   | 106 ++++
 include/linux/kvm_host.h                      |  14 +
 include/linux/liveupdate.h                    |  21 +
 kernel/liveupdate/Kconfig                     |  15 +
 kernel/liveupdate/luo_file.c                  |  69 +++
 kernel/liveupdate/luo_internal.h              |  17 +
 tools/testing/selftests/kvm/Makefile.kvm      |   6 +-
 .../kvm/guest_memfd_preservation_test.c       | 230 ++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  26 +-
 virt/kvm/Makefile.kvm                         |   1 +
 virt/kvm/guest_memfd.c                        | 185 +++++--
 virt/kvm/guest_memfd.h                        |  44 ++
 virt/kvm/guest_memfd_luo.c                    | 489 ++++++++++++++++++
 virt/kvm/kvm_luo.c                            | 190 +++++++
 virt/kvm/kvm_main.c                           |  94 +++-
 virt/kvm/kvm_mm.h                             |  15 +
 18 files changed, 1456 insertions(+), 81 deletions(-)
 create mode 100644 include/linux/kho/abi/kvm.h
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c
 create mode 100644 virt/kvm/guest_memfd.h
 create mode 100644 virt/kvm/guest_memfd_luo.c
 create mode 100644 virt/kvm/kvm_luo.c


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
prerequisite-patch-id: 85705fb54d3065efe1d87ab4b69e828a9f3404e7
prerequisite-patch-id: 7bf85ca17e12b26a72d41ee35f2ec8fc5ce2e692
-- 
2.54.0.1032.g2f8565e1d1-goog

