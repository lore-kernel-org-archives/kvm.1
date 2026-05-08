Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE63CA490;
	Fri,  8 May 2026 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255744; cv=none; b=FxyKOeBV3uDGRRREsVbSXh3BSJbLAphppUKbzbrxiFIOFsdwJ4CScV/1d2t52A89AIOqH7Dlahp2h1CweF/aVz750a1jywy0kqU/pTDJiPWvkeFXeyaRuNDjwKBPsE6TLA6qKnANLaNcBYzR0h6Uhba82DUeSi+i0X037B0Zbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255744; c=relaxed/simple;
	bh=hszJPbk25oCRsgVacR/yAMEIK8qkeOQj2FZ2+mepVvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=swCHuZrD7ZDBtY32Q88+80k8WolW7H3++nFZvEakJCzJQEylXBRHoJeWRGks3hCn8qfXzA/7OhBiXLNGlvjuO3g2TVhSRiu0/t0sA5fXWkrs0dHCX2Hj3Tb7IIYewlWuYs2M+/frlwQ17+S8uWnK5ohMA0vTM2ltXgtczmUvEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi40rEGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi40rEGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07347C2BCC9;
	Fri,  8 May 2026 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778255743;
	bh=hszJPbk25oCRsgVacR/yAMEIK8qkeOQj2FZ2+mepVvY=;
	h=From:To:Cc:Subject:Date:From;
	b=oi40rEGzyLEeaqTKCnXG8CwFn8BRTGbwuXznXuPpGTOGlY6PZNJVKilqDE3QABu/H
	 2Xu67/3mYGMfwfGawfMrvMk7Uyj6YsLMKdc0qHSJia42MwlQKsk530J7xJZDuBHAjv
	 IAsezS8etzt0JIITWkh0hdDGTfSdv+xBWNJCsb6XFUno5UlGySbG/wKKtNgREXAu0w
	 mHsRD9ZHIRM+IK8KLewNxkkY1sAxEtkAJKQ7Bpk2ACuJ/rKPK8DqEJYMVaN3f8u40n
	 hRkgtcGa5HkGYuQwii4dU84BYXtG8Mb4A9aRwLmqucB1C1jwsp5oAxCsaH5yWcLKc8
	 jVmceaS1ZU7Hw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2F3C6F4006E;
	Fri,  8 May 2026 11:55:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 11:55:42 -0400
X-ME-Sender: <xms:fgf-aWGluAPobDKlDpE0xvgu2IEjJZeBZzvDUrGSwRbQdFQ94XXe4A>
    <xme:fgf-abTXydu02Wem-JaiqJC1o3UcwsLttck75b5zHyQ4-9qoxndisIwYDBq3n4r0X
    wnKX7iiIfIA_JNhElor2D10rd0kU6fvegylm5E9L51XO9iWJI81oCI>
X-ME-Received: <xmr:fgf-aYrPaSccvarci_SBDRFs7MR27iJ_jR5Yi8SpxRUGsKScxwXgSA9zjAb5Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepfdfmihhrhihlucfuhhhuthhsvghmrghuucdlofgvthgrmddfuceo
    khgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeggffhgeeiieelvd
    egueeuhfevtdeuvdeigedvgfegteetudevhfelfedttdekhfenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgpdhsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppe
    hkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfh
    houhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepug
    grvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hvsggrsghkrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgv
    thhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:fgf-aZpql0nyhmwcpEwzZgM-oWZYvy2QgBIEf5ke01zblvygZyMAVQ>
    <xmx:fgf-aT0S__8e11yJEGYoIa2V8LnklU5HZ1XdWRQZ1lmXQ1Rz5E0UoQ>
    <xmx:fgf-adijgt_6G-e-y87HyYlJ4YlXxPLs2BKw8DcqYOCQQ58Vlino1w>
    <xmx:fgf-aSn55DRSosXjqwicfejg7RkRUEPnlh2Ghkqi-7y5RK3N_ky_Kg>
    <xmx:fgf-aV8bx9VeZ33h4ByPuVbcCqPnFAjANicn7SX8Fgv5VVBle6ACoYdX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 11:55:40 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org
Cc: ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	sj@kernel.org,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v2 00/14] userfaultfd: working set tracking for VM guest memory
Date: Fri,  8 May 2026 16:55:12 +0100
Message-ID: <cover.1778254670.git.kas@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds userfaultfd support for tracking the working set of
VM guest memory, so a VMM can identify cold pages and evict them to
tiered or remote storage.

v1: https://lore.kernel.org/all/20260427114607.4068647-1-kas@kernel.org/

== Changes since v1 ==

Review feedback from Mike Rapoport, SeongJae Park, and the sashiko AI
review (https://sashiko.dev/#/patchset/20260427114607.4068647-1-kas@kernel.org).

  Per-patch:

  - 01/14 (decouple protnone): rephrased the !ARCH_HAS_PTE_PROTNONE
    comment to keep the original pte_protnone() semantics description
    (Mike Rapoport). Acked-by Mike Rapoport, SeongJae Park.
  - 02/14 (rename uffd-wp PTE bit macros): Reviewed-by Mike Rapoport.
  - 03/14 (rename uffd-wp PTE accessors): Reviewed-by Mike Rapoport.
  - 04/14 (VM_UFFD_RWP VMA flag): __VMA_UFFD_FLAGS now includes
    VMA_UFFD_RWP_BIT so RWP deregistration cleanly merges adjacent
    non-uffd VMAs. The VM_COPY_ON_FORK note no longer singles out
    VM_UFFD_WP (sashiko).
  - 06/14 (preserve RWP marker): __copy_present_ptes() snapshots
    pte_write() before the RWP-disarm pte_modify(), and the COW
    wrprotect uses the snapshot. Without it a fork() without
    UFFD_FEATURE_EVENT_FORK could leave the parent writable over a
    folio shared with the child. hugetlb_install_folio() (the
    pinned-fork hugetlb fallback) now uses userfaultfd_protected()
    and applies PAGE_NONE on userfaultfd_rwp(vma), mirroring
    copy_present_page() (sashiko).
  - 08/14 (UFFDIO_REGISTER_MODE_RWP plumbing): MM_CP_TRY_CHANGE_WRITABLE
    is set per-VMA inside the iteration loop, gated on
    vma_wants_manual_pte_write_upgrade(). RWP register accepts
    PROT_READ-only mappings, so the flat outer flag would have
    tripped the WARN_ON_ONCE in maybe_change_pte_writable() on
    resolve (sashiko).
  - 10/14 (PAGE_IS_ACCESSED in PAGEMAP_SCAN): pagemap_scan_test_walk()
    now returns -EINVAL when PM_SCAN_WP_MATCHING is set on a
    VM_UFFD_RWP VMA, instead of silently skipping the range
    (sashiko).
  - 12/14 (UFFDIO_SET_MODE): added userfaultfd_features() helper
    wrapping READ_ONCE(ctx->features); converted lockless readers
    (userfaultfd_is_initialized, userfaultfd_wp_async_ctx,
    userfaultfd_rwp_async_ctx, userfaultfd_wp_unpopulated, fdinfo).
    Hot-path fault-handler reads stay plain since the SET_MODE drain
    excludes them (sashiko).
  - 13/14 (selftests): rwp-sync and rwp-async-toggle tests join the
    fault-handler thread before reading the minor_faults counter, so
    the last fault's increment is always visible. The async-toggle
    test stops the handler between Phase 2 and Phase 3 so a
    regression that erroneously delivers a sync fault in async mode
    is no longer silently masked. rwp-fork-pin now requires
    UFFD_FEATURE_EVENT_FORK (and runs a fork_event_consumer), so the
    child genuinely inherits the marker; otherwise userfaultfd_reset_ctx()
    would clear it and the test would pass for the wrong reason.
    rwp-wp-exclusive now requires UFFD_FEATURE_WP_HUGETLBFS_SHMEM so
    it skips cleanly on kernels without WP-marker support for
    shmem/hugetlbfs. Tightened the GUP test's pipe write down to a
    single byte. Stale "WP and RWP coexisting" comment removed
    (sashiko).
  - 14/14 (Documentation): VMM workflow rewritten to use a second
    mapping of the same memfd for VMM-side I/O, so pwrite() does not
    fault on the protnone-protected PTE. madvise(MADV_DONTNEED)
    replaced with fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
    -- DONTNEED only zaps PTEs and does not free shmem pages. Added
    explicit UFFDIO_WAKE after fallocate() since neither PUNCH_HOLE
    nor DONTNEED iterates ctx->fault_pending_wqh (sashiko).

== Problem ==

A VMM managing guest memory needs to:

  1. detect which pages are still being touched (working-set
     tracking);
  2. safely evict cold pages to slower tiered or remote storage;
  3. fetch them back on demand when accessed again.

== Approach ==

UFFDIO_REGISTER_MODE_RWP is a new userfaultfd registration mode, in
parallel with the existing MODE_MISSING / MODE_WP / MODE_MINOR. It
uses the same mechanism on every backing -- anon, shmem, hugetlbfs:

  - PAGE_NONE on the PTE (the same primitive NUMA balancing uses)
    makes the page inaccessible while keeping it resident;
  - the uffd PTE bit (the one MODE_WP already owns) marks the entry
    as "userfaultfd-tracked" so the protnone fault path can tell an
    RWP fault apart from an mprotect(PROT_NONE) or NUMA hinting
    fault.

VM_UFFD_WP and VM_UFFD_RWP are mutually exclusive per VMA, so the
same PTE bit safely carries both meanings depending on the
registered VMA flag.

In sync mode, the kernel delivers a UFFD_PAGEFAULT_FLAG_RWP message
to the registered handler, and the handler resolves the fault with
UFFDIO_RWPROTECT clearing MODE_RWP. In async mode
(UFFD_FEATURE_RWP_ASYNC), the fault is auto-resolved in-place: the
kernel restores the original PTE permissions and the faulting thread
continues without a userfaultfd message ever being delivered.
Userspace then learns which pages were touched by reading
PAGE_IS_ACCESSED out of PAGEMAP_SCAN -- pages whose uffd bit is
still set were not re-accessed since the last RWP cycle.

UFFDIO_RWPROTECT is the protect/unprotect ioctl, mirroring
UFFDIO_WRITEPROTECT.

UFFDIO_SET_MODE flips RWP_ASYNC <-> sync at runtime under
mmap_write_lock(), so a VMM can run in async mode for detection and
switch to sync for race-free eviction without re-registering the
userfaultfd.

== Typical VMM workflow ==

  /* arm */
  UFFDIO_API(features = RWP | RWP_ASYNC)
  UFFDIO_REGISTER(MODE_RWP)

  /* detection cycle */
  UFFDIO_RWPROTECT(range, RWP)
  sleep(interval)
  PAGEMAP_SCAN(!PAGE_IS_ACCESSED) -> cold pages

  /* eviction */
  UFFDIO_SET_MODE(disable = RWP_ASYNC)                  /* sync */
  pwrite(cold) + fallocate(FALLOC_FL_PUNCH_HOLE, cold)  /* races trapped */
  UFFDIO_SET_MODE(enable  = RWP_ASYNC)                  /* resume */

== Series layout ==

Patches 1 to 3 are preparatory:

  1: decouple protnone helpers from CONFIG_NUMA_BALANCING.
  2-3: rename _PAGE_BIT_UFFD_WP, pte_uffd_wp() and friends to drop
       the _WP suffix, since the bit now carries WP and RWP meaning
       depending on the VMA flag. The SCAN_PTE_UFFD enum's ftrace
       output string is intentionally kept as "pte_uffd_wp" so
       trace-based tooling does not silently break.

Patches 4 to 7 add the in-kernel mechanism:

  4: VM_UFFD_RWP VMA flag and CONFIG_USERFAULTFD_RWP.
  5: MM_CP_UFFD_RWP change_protection() primitive (PAGE_NONE +
     uffd bit, plus a RESOLVE counterpart).
  6: marker preservation across swap, device-exclusive, migration,
     fork, mremap, UFFDIO_MOVE, hugetlb copy, and mprotect().
  7: handle VM_UFFD_RWP in khugepaged, rmap, and GUP.

Patches 8 to 12 wire the userspace surface:

   8: UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT plumbing.
   9: RWP fault delivery and exposure of UFFDIO_REGISTER_MODE_RWP.
  10: PAGE_IS_ACCESSED in PAGEMAP_SCAN.
  11: UFFD_FEATURE_RWP_ASYNC for async fault resolution.
  12: UFFDIO_SET_MODE for runtime sync/async toggle.

Patches 13 and 14 are tests and documentation.

Kiryl Shutsemau (Meta) (14):
  mm: decouple protnone helpers from CONFIG_NUMA_BALANCING
  mm: rename uffd-wp PTE bit macros to uffd
  mm: rename uffd-wp PTE accessors to uffd
  mm: add VM_UFFD_RWP VMA flag
  mm: add MM_CP_UFFD_RWP change_protection() flag
  mm: preserve RWP marker across PTE rewrites
  mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP
  userfaultfd: add UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT
    plumbing
  mm/userfaultfd: add RWP fault delivery and expose
    UFFDIO_REGISTER_MODE_RWP
  mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking
  userfaultfd: add UFFD_FEATURE_RWP_ASYNC for async fault resolution
  userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
  selftests/mm: add userfaultfd RWP tests
  Documentation/userfaultfd: document RWP working set tracking

 Documentation/admin-guide/mm/pagemap.rst     |  13 +-
 Documentation/admin-guide/mm/userfaultfd.rst | 236 +++++-
 Documentation/filesystems/proc.rst           |   1 +
 arch/arm64/Kconfig                           |   1 +
 arch/arm64/include/asm/pgtable-prot.h        |   8 +-
 arch/arm64/include/asm/pgtable.h             |  47 +-
 arch/loongarch/Kconfig                       |   1 +
 arch/loongarch/include/asm/pgtable.h         |   4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |   8 +-
 arch/powerpc/platforms/Kconfig.cputype       |   1 +
 arch/riscv/Kconfig                           |   1 +
 arch/riscv/include/asm/pgtable-bits.h        |  12 +-
 arch/riscv/include/asm/pgtable.h             |  59 +-
 arch/s390/Kconfig                            |   1 +
 arch/s390/include/asm/hugetlb.h              |  12 +-
 arch/s390/include/asm/pgtable.h              |   4 +-
 arch/x86/Kconfig                             |   1 +
 arch/x86/include/asm/pgtable.h               |  56 +-
 arch/x86/include/asm/pgtable_types.h         |  16 +-
 fs/proc/task_mmu.c                           | 108 ++-
 fs/userfaultfd.c                             | 264 ++++++-
 include/asm-generic/hugetlb.h                |  18 +-
 include/asm-generic/pgtable_uffd.h           |  32 +-
 include/linux/huge_mm.h                      |   7 +
 include/linux/leafops.h                      |   4 +-
 include/linux/mm.h                           |  46 +-
 include/linux/mm_inline.h                    |   4 +-
 include/linux/pgtable.h                      |  32 +-
 include/linux/swapops.h                      |   4 +-
 include/linux/userfaultfd_k.h                |  76 +-
 include/trace/events/huge_memory.h           |   2 +-
 include/trace/events/mmflags.h               |   7 +
 include/uapi/linux/fs.h                      |   1 +
 include/uapi/linux/userfaultfd.h             |  54 +-
 init/Kconfig                                 |   8 +
 mm/Kconfig                                   |   9 +
 mm/debug_vm_pgtable.c                        |   4 +-
 mm/huge_memory.c                             | 145 +++-
 mm/hugetlb.c                                 | 146 +++-
 mm/internal.h                                |   4 +-
 mm/khugepaged.c                              |  38 +-
 mm/memory.c                                  | 123 ++-
 mm/migrate.c                                 |  20 +-
 mm/migrate_device.c                          |   8 +-
 mm/mprotect.c                                |  62 +-
 mm/mremap.c                                  |  17 +-
 mm/page_table_check.c                        |   8 +-
 mm/rmap.c                                    |  18 +-
 mm/swapfile.c                                |   9 +-
 mm/userfaultfd.c                             | 113 ++-
 tools/include/uapi/linux/fs.h                |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c | 774 +++++++++++++++++++
 52 files changed, 2235 insertions(+), 413 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.51.2

