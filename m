Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D539A06A
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125862; cv=none; b=CUqypanNe9Ma/Po0HNAjv9tN4pTInE85AAGezsCSIwCWkSTTIKhdarnMan6CdObToLTqmSFcnVlJ9B5CdFybrDk14aIML9EboZSnG5Sr5FDYv7kRmcjdnfzLeqphl2YRjVF6FJBBtaawkXxQIgWgXZ7kcliMl8BcblDN2S6f3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125862; c=relaxed/simple;
	bh=XjUUDdcP2CI0CF0n8gkpkLfWDsLoYAA7uUimqdblRQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gCnsDxaMgx2E8DjS5XRUTWy2B48hEZen1N7IilPh+CcjBbs4RNTktOyGoXMUhyfJTIXwUM3AaVtK1X6WYv0npzrjko99KIViGfzbF6AdGLdAPGUEYThLfg3ehSh1DkMmMyFNax39sVYIqrfScMmRvPonOJDORD4PQbUpE7msnTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOsrEavl; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOsrEavl"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd61bdc8683so1970779a12.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792125859; x=1792730659; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NxZ+b4JCGOlHDvtphu6wLcPq/YWjg3jI+s4nvF3CTmI=;
        b=OOsrEavlNgGVIw3rDZM6qVvuBD6sURT0atlkh8vyDuJ4QL42u4Wt6OxRj+ofO+NLaM
         GXjUg1Y0p39b0iY1wAgQvzuhd0SsqJWgxJEzRsOmrLwGFFAS5LOyPulL6u/yx3xcB2aR
         A84eBO/TaChndsYhgl14E3A46E8F7T/z2Q8Roisq/9Dq+u5KgaFrB87cF6lZV6+bgcAd
         6xtVtC2ri0DJUzlkA+rKEmrnUy1NTuI4xAizpxXOh0/GmomN3g+kZcXfhdxsQ4D0IenS
         9IZxqSMgHrqVLGtqz7UxZG4frwjKOBiyJxB1kGHpHde4zfefRdHejzEMzGTCbJVViNxZ
         LHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125859; x=1792730659;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxZ+b4JCGOlHDvtphu6wLcPq/YWjg3jI+s4nvF3CTmI=;
        b=T4q1uRzQaidg6qEqCkO7eBqNzUMV7RBcR2IOw+QcZW3NcNdLI8i2poN3oIJRTlihV2
         Kiq/f4/iQMEmc7u9qywIZjRNi9IP+8KMbjrWGo3LHnGVu92tju2rtDp45dZh0aYKoGZj
         LWOWkoben95KIT9qZsqTsTMYkRme/OP5bYltuA6Mdzen3WuscAEBBTEZ9k3XiwSXZClU
         7bqJnkxGVfvfjMzEPpsCDlZtjjs8OzzO38WiN+os4I8D3k4OBROQwhbIeSG25jtq+G0i
         YvSUmW3JFFksiyNwMe1rY21mJ2vwR9wA5bE0cYF4FNH8AA3psiGmvDlxshQPHiUKHU5M
         EfQw==
X-Gm-Message-State: AFq9FYK+20g+VqojAtL1fvlcDpdm8LxDzZndpC25d+hxqBU1srjv200U
	+TFV0e1aMYrDwyKE3RzQtPaM+CJjjWt/5yCeqeJiF1LxER2SYcfpZqzbAJ91G42xThd3jmii2z3
	Z8G3TiA==
X-Received: from pgby3-n2.prod.google.com ([2002:a05:6a02:6503:20b0:cc7:982c:320f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c793:b0:3e0:e12f:5dd
 with SMTP id adf61e73a8af0-3e16bf0290cmr16704765637.69.1792125859176; Thu, 15
 Oct 2026 21:44:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 21:44:07 -0700
In-Reply-To: <20261016044415.958618-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016044415.958618-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016044415.958618-3-seanjc@google.com>
Subject: [GIT PULL] KVM: guest_memfd and CoCo changes for 7.4
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

In-place conversion support is the obvious highlight.  The rest of the changes
are either fixes (mostly found by AI) or prep work related to in-place conversions.

Note, this is based on 7.3-rc4 as it has a hard dependency on commit fc6415a384f0
("mm/gup: factor out LRU cache draining for folio into lru_cache_drain_for_folio()").

Note #2, this will conflict with the "vmx" pull request.  More details in that
pull request (I do my local merges in alphabetical order, so I always see the
conflict when merging in the "vmx" branch).

Note #3, there's a deadlock splat with SNP[1] that isn't resolved here.  The CCP
driver holds its system-wide mutex (that guards PSP firmware calls) while doing
a variety of might-fault operations, which leads to an ABBA locking issue when
KVM attempts to issue SNP_LAUNCH_UPDATE while holding a gmem's lock.  The plan
is to either temporarily disable SNP[2], or (much) better, fastrack a series to
fix the deadlock by having the driver hold sev_cmd_mutex only when it absolutely
needs to[3].

[1] https://lore.kernel.org/all/asz8GKNO9aQANr5E@google.com
[2] https://lore.kernel.org/all/as0FedYcvJvdOaq2@google.com
[3] https://lore.kernel.org/all/20261014132145.1726322-1-michael.roth@amd.com

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-coco-7.4

for you to fetch changes up to a6270ed4bec0caa25913082e71ce22254e9cd3ed:

  KVM: selftests: Support guest_memfd in-place conversion (2026-10-12 08:08:29 -0700)

----------------------------------------------------------------
KVM guest_memfd and CoCo changes for 7.4

 - Take the invalidate lock when unbinding a dying file to fix a race with
   kvm_gmem_invalidate_end() that results in KVM leaving the MMU invalidation
   count elevated.  Not taking the lock in the first place was pure misguided
   paranoid.

 - When binding a memslot, purge the bindings if storing the new memslot fails,
   as Xarray's "store range" API can subtly fail partway through.

 - Establish memslot<=>guest_memfd bindings *after* the memslot is ready, as
   the memslot becomes reachable the instant the binding is installed.

 - Don't grab a page refcount when reloading an SNP VMSA and stop returning a
   "struct page" from guest_memfd's PFN lookup altogether, to ensure that KVM
   doesn't hold any unnecessary refcounts (the lifetime of the page is ensured
   by MMU notifiers and similar hooks).  Preventing unnecessary refcounts
   greatly simplifies supporting in-place SHARED=>PRIVATE conversions.

 - Add support for in-place PRIVATE<=>SHARED conversion, i.e. allow a single
   guest_memfd instance to be used for both PRIVATE and SHARED variations of
   CoCo guests' memory (though not at the same time).  This eliminates the need
   to double allocate guest memory for TDX and SNP, and is basically a hard
   requirement for pKVM, which relies on being able to preserve memory contents
   on conversions.

 - Hack-a-fix a deadlock bug in ->error_remove_folio() by returning -EBUSY if
   the filemap invalidate lock is contended.  Punt on a proper fix for the
   moment, as a proper fix likely involves reworking truncate_error_folio().

 - Add a pile of selftests for in-place conversions.

 - Misc guest_memfd cleanups

----------------------------------------------------------------
Ackerley Tng (25):
      KVM: SEV: Treat unassigned RMP entry as benign race on PSMASH failure
      KVM: SEV: Check for invalidation before warning on unassigned RMP entry
      KVM: SEV: Drop page refcount early in VMSA reload
      KVM: Rename kvm_mem_is_private() to kvm_is_private_gfn()
      KVM: guest_memfd: Always fault from guest_memfd if in-place conversion is enabled
      KVM: guest_memfd: Pass mapping type filter to invalidation helper
      KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
      KVM: guest_memfd: Ensure pages are not in use before conversion
      KVM: guest_memfd: Call arch make_shared callback for to-shared conversion
      KVM: guest_memfd: Return early if range already has requested attributes
      KVM: guest_memfd: Zero page while getting pfn
      KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
      KVM: selftests: Test basic single-page conversion flow
      KVM: selftests: Test conversion flow when INIT_SHARED
      KVM: selftests: Test conversion precision in guest_memfd
      KVM: selftests: Test conversion before allocation
      KVM: selftests: Convert with allocated folios in different layouts
      KVM: selftests: Test that truncation does not change shared/private status
      KVM: selftests: Add helpers to pin pages with CONFIG_GUP_TEST
      KVM: selftests: Test conversion with elevated page refcount
      KVM: selftests: Reset shared memory after hole-punching
      KVM: selftests: Provide function to look up guest_memfd details from gpa
      KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
      KVM: selftests: Set up page size and alignment independently for guest_memfd
      KVM: selftests: Update private_mem_conversions_test for in-place conversions

Fuad Tabba (1):
      KVM: guest_memfd: Fix the in-place conversion documentation

Hao Zhang (1):
      KVM: guest_memfd: Avoid deadlock in error_remove_folio()

Lisa Wang (1):
      KVM: selftests: Support guest_memfd in-place conversion

Michael Roth (1):
      KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE

Sean Christopherson (30):
      KVM: guest_memfd: Elaborate on how release() vs. get_pfn() is safe against UAF
      KVM: guest_memfd: Gracefully handle xarray errors when binding a memslot
      KVM: Use goto to handle errors during memslot preparation
      KVM: Only bind memslot to guest_memfd instance for CREATE operations
      KVM: guest_memfd: Split bind() into prepare()+commit() phases
      KVM: guest_memfd: Establish memslot<=>guest_memfd bindings *after* memslot is ready
      KVM: guest_memfd: Drop superfluous WRITE_ONCE() when binding a memslot
      KVM: SEV: Drop page refcount early during RMP fault handling
      KVM: guest_memfd: Stop returning struct page from PFN lookup
      KVM: guest_memfd: Optimize away conversion overheads via dead-code elimination
      KVM: guest_memfd: Use kvm_mem_is_private() when populating guest_memfd memory
      KVM: guest_memfd: Introduce per-gmem attributes, use to guard user mappings
      KVM: Rename KVM_GENERIC_MEMORY_ATTRIBUTES to KVM_VM_MEMORY_ATTRIBUTES
      KVM: Enumerate support for PRIVATE memory iff kvm_arch_has_private_mem is defined
      KVM: Rename memory attribute APIs to prepare for in-place gmem conversion
      KVM: Provide generic interface for checking memory private/shared status
      KVM: guest_memfd: Stub in ability to enable in-place shared<=>private conversion
      KVM: Consolidate private memory and guest_memfd ifdeffery in kvm_host.h
      KVM: guest_memfd: Invalidate both SHARED and PRIVATE mappings for in-place conversions
      KVM: Move KVM_VM_MEMORY_ATTRIBUTES config definition to x86
      KVM: Let userspace disable per-VM mem attributes, enable per-gmem attributes
      KVM: guest_memfd: Enable INIT_SHARED on guest_memfd for x86 Coco VMs
      KVM: selftests: Create gmem fd before "regular" fd when adding memslot
      KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
      KVM: selftests: Add support for mmap() on guest_memfd in core library
      KVM: selftests: Add selftests global for guest memory attributes capability
      KVM: selftests: Add helpers for calling ioctls on guest_memfd
      KVM: selftests: Test that shared/private status is consistent across processes
      KVM: selftests: Provide common function to set memory attributes
      KVM: selftests: Update private memory exits test to work with per-gmem attributes

Shivank Garg (1):
      KVM: guest_memfd: take the invalidate lock when unbinding a dying file

 Documentation/admin-guide/kernel-parameters.txt                |  26 +++++
 Documentation/virt/kvm/api.rst                                 | 116 ++++++++++++++++--
 Documentation/virt/kvm/x86/amd-memory-encryption.rst           |  14 ++-
 Documentation/virt/kvm/x86/intel-tdx.rst                       |   4 +
 arch/arm64/kvm/mmu.c                                           |   4 +-
 arch/arm64/kvm/nested.c                                        |   4 +-
 arch/x86/include/asm/kvm-x86-ops.h                             |   2 +-
 arch/x86/include/asm/kvm_host.h                                |   9 +-
 arch/x86/kvm/Kconfig                                           |  15 ++-
 arch/x86/kvm/mmu/mmu.c                                         |  30 ++---
 arch/x86/kvm/svm/sev.c                                         |  66 ++++++-----
 arch/x86/kvm/vmx/tdx.c                                         |   8 +-
 arch/x86/kvm/x86.c                                             |  20 ++--
 include/linux/kvm_host.h                                       |  91 ++++++++-------
 include/trace/events/kvm.h                                     |   6 +-
 include/uapi/linux/kvm.h                                       |  16 +++
 tools/testing/selftests/kvm/Makefile.kvm                       |   1 +
 tools/testing/selftests/kvm/include/kvm_util.h                 | 139 +++++++++++++++++++---
 tools/testing/selftests/kvm/include/test_util.h                |  32 ++---
 tools/testing/selftests/kvm/lib/kvm_util.c                     | 237 ++++++++++++++++++++++++-------------
 tools/testing/selftests/kvm/lib/test_util.c                    |   7 --
 tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c | 512 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/kvm/x86/private_mem_conversions_test.c |  66 ++++++++---
 tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c   |  36 +++++-
 virt/kvm/Kconfig                                               |   3 -
 virt/kvm/guest_memfd.c                                         | 653 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 virt/kvm/guest_memfd.h                                         |  19 ++-
 virt/kvm/kvm_main.c                                            | 157 +++++++++++++++++--------
 28 files changed, 1875 insertions(+), 418 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
