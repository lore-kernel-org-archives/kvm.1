Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C63FE36D;
	Mon, 29 Jun 2026 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734878; cv=none; b=L2J6LhJnNjyL+dqzBGuKwZFA/Lpx7whvy9KhZAFjpkEHkDIk3LXZMPxFm9N45KRbkaDpLCZxFUeagqWina8SwybtlciAoXpzwxM8ICgp/85ufdg5d34aoRHFCEpVQNnb3N2Xo/858bi259kvHSxrFpJ4uPgAdkLTga+gHSt+yR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734878; c=relaxed/simple;
	bh=/CeH+CgEPBV8+vZf1TRiQRke6jG6nX/cVuCWBCV/M6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yqn1i5m6hEc5DicWXVIUjx9NscQtDEwKF2aQCp41IG5VxQNkSBtZWPosgiprU7/iI4BarXkkzqfvvz2dUNc85PQ8nj2Q/gQh8kOke4bQzCvL6vOqX7clQKOVoTVTC448eKCYJk9o7oiKIx51Kr8R2tS0Y96hlF/8Zxxz+aOhUAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=LtIKchLU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YcHxJB+f; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="LtIKchLU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YcHxJB+f"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22DD01400103;
	Mon, 29 Jun 2026 08:07:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Jun 2026 08:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1782734872; x=
	1782821272; bh=UgUfSQ3fgfdnjYJwVZAgLkKRpc+OyNaXy23DbcKh0B0=; b=L
	tIKchLUHiowbhOygHxmCBogwmlzKWSMoOb8OnT5FTRo0Lg/7zJ2y3Wuu8rCmMnWT
	Ps61Am+hiqt/icaym+GahxQfqKYCopa3+hKD+I+k+7XyQSZstt7VKZ0kACSG9WFu
	/Cp7AyH9NTPjTe8UtZDsWfjYSQitJqKnoRa3LCNOA2CZBpy2qk9wexnAd7H3v7bY
	Y2M62ZRM6W0CHY3hwqvAgjBSW2jEcVS6g2Cit7YGGMx8+qIQ6gF2Xf+YSv3EyLhW
	Sr76iAU24cDwj4JZcBuWfciHDUW30T70VYWsrKRcrYQEgZrBNf4vr0JwcYQBP/yV
	uZq2kb10sQjYhxaEo9MOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782734872; x=1782821272; bh=UgUfSQ3fgfdnjYJwVZAgLkKRpc+O
	yNaXy23DbcKh0B0=; b=YcHxJB+fX5q3H4dvIZn7aCUZwu0/DaAdq5/ciUsrQhqe
	rkjyZtty1+4uSevQcgc12Z2+11NDYAb7kWWD7+xP/I3Jz6usQJ5Yi+71nn0fc7H/
	o+A//n/4qjVa7NDySUqwARk7r04vM8gOu8TgVoTiXjhMzKEBuU7r7kO2wbbaFDfX
	mhdlJglEdemykC1QD2AWUWJJjvyF8r4ZIsENChSs0CXvazJLKjEgisovwPtr7J1A
	1vK9WfEJzTEy4h/AqeDuOh2cAjUthmizUwNzXPwrEDAqEWblC8gVjrqdxAiinBf7
	fARrNYrzv00poWKy++dPFala4HAdcPj/L0Qb08KRJw==
X-ME-Sender: <xms:F2BCavXRRPoDacjVszM8MBVT0emcaVZ2lmmj3GNYDbqfkThIAuoxgw>
    <xme:F2BCarjK9TW7jhqreZYvBDqien9HL0RKvW4oQHDxezdlwzpRZ1XxVwYTyUjQr60Wr
    IWga1K6j72qjz9EbGSdvu5PYT5QWDnQIsLmlkqdTDqDHtEkHRP6308>
X-ME-Received: <xmr:F2BCaj7gJYgbJXkjZu3LXG_LpWb77z4LC7ONIbHhMyuS3bTA7lgbZa0_72huIQ>
X-ME-Proxy-Cause: dmFkZTFUMlL5mu5y8Upbv9HR9aFxU4WQKlExYJbTC0hStB1ZaeQIv/++UIHbviFJ2AGPQk
    gj7l9YOykxdouzJPl5/lriT8Q948gdAIJ0XIynWvJn1flyoMhiN49uGLzqcID5igt13Z9b
    L3kra4t3SVxpZKLFF4y9OeRDrhsKThwFN6yYHWzsJHREjnIpWtaygQ2GGHrUyWMjBLeEtx
    osclhPO2lGuRYRPu3fUhKYvVbYRGprIk6gy3FhSO6q3liAby7E5t1CfY2Raob7o3dOvQTH
    mB2rtF3LAPUoafCxiKPztyvhVTLhVm1gkL2Zu2o+beJD19ZvTDTLGVSzBw+J/J5MnspcY+
    7yKjSMs3YEzUJUqm2KiNNJdxAgC+lOlv0+8Qk1Evo80ichj+kBvqe9aGyhG+QN7JddI9tk
    t6pMAbw51FjG8OTAYaIqG17cQ4fckD2koSpv8HWnv6i3b7UVn/uJe9FHniiC/Gi2RQrxPc
    hrwLCVnFHOtGdfQc04GhmDuzwFMLDtKOYvWPolMu63GTODifIb6AMmDDwxbnL6ee4pNdlt
    yFFmdJpIFt71sB61quIjsBwoAKX9PHwhugoczOHHkmh6IFIcXZU3qcmVXvM5YdhRk/cD0y
    PbgLlhiqs9DAdI8XSbz6QWC4flDa9I4onP3GQzR22gC5gRyaPnttZcu6UUZw
X-ME-Proxy: <xmx:F2BCaj4_nO7Ds5cIlEZ97XpDN4y85qmTijh5k2sxTo-F10njhkPdHw>
    <xmx:F2BCahH0SNmVLFcibcpYKwQ1G-Ba1QmyxfRf9h7hHMhQwHA1BqMOaw>
    <xmx:F2BCahxDTMzevmYCCdH_xWk2oGEhTAucU6RmMyaJhsWMNGXjvGCDWg>
    <xmx:F2BCah3hhPbB-ZWRR1wTKL0wQVEzqCiKbbtkKwBn_5Zbcr583GzOPg>
    <xmx:GGBCam2TSsRejXKts53s4QL6htg9syPe26JtTucA9JhHAZTLu7cNRuFg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 08:07:51 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
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
	kas@kernel.org
Subject: [PATCH v7 00/15] userfaultfd: working set tracking for VM guest memory
Date: Mon, 29 Jun 2026 13:07:31 +0100
Message-ID: <20260629120749.566063-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

This series adds userfaultfd support for tracking the working set of
VM guest memory, so a VMM can identify hot pages and reclaim cold ones
to tiered or remote storage.

v1: https://lore.kernel.org/all/20260427114607.4068647-1-kas@kernel.org/
v2: https://lore.kernel.org/all/cover.1778254670.git.kas@kernel.org/
v3: https://lore.kernel.org/all/20260522133857.552279-1-kirill@shutemov.name/
v4: https://lore.kernel.org/all/20260525113737.1942478-1-kas@kernel.org/
v5: https://lore.kernel.org/all/20260526130509.2748441-1-kirill@shutemov.name/
v6: https://lore.kernel.org/all/20260529172716.357179-1-kas@kernel.org/

== Changes since v6 ==

  - Rebased onto v7.2-rc1. v6 was stacked on the separate
    "userfaultfd/pagemap: pre-existing fixes" series; those fixes have
    since landed, so v7 applies directly on v7.2-rc1 with no out-of-tree
    dependency. The only rebase adaptation is that the accessor-rename
    patch now also covers two call sites in remove_migration_pmd() that
    appeared in v7.2-rc1.
  - Addressed Lorenzo Stoakes' review: the two VM_UFFD_RWP single-flag
    checks -- userfaultfd_rwp() and gup_can_follow_protnone() -- use
    vma_test_single_mask() instead of vma_test_any_mask().
  - Reworked the working-set documentation and the PAGEMAP_SCAN selftest
    around hot-page detection (PAGE_IS_ACCESSED, non-inverted) rather
    than a cold scan. A cold scan (inverted PAGE_IS_ACCESSED) cannot see
    file pages that are present in the page cache but not mapped, so it
    misreports never-faulted regions of a pre-populated file as cold.
    Tracking the hot set and reclaiming everything else from the backing
    file is the correct model and is now what the docs and tests show.
  - Documented a related file-THP limitation: RWP state is PTE-granular,
    but a file mapping faulted in as a PMD-level THP loses its RWP marks
    when the PMD is split -- split_huge_pmd() clears the file PMD via
    pmdp_huge_clear_flush() without redistributing the uffd marker to the
    PTEs (there is no PMD-level RWP marker), so the range silently reverts
    to untracked. Cold-page tracking over a transparently-huge file
    mapping is therefore unreliable; the selftest opts out of THP
    (MADV_NOHUGEPAGE) on the non-hugetlb backings, and the documented
    hot-set-plus-file-reclaim model sidesteps it. hugetlb is unaffected
    (its mappings are not split by split_huge_pmd()).
  - Collected review tags picked up during v6.

113/113 of tools/testing/selftests/mm/uffd-unit-tests pass on v7.2-rc1
(46 RWP cases plus the existing UFFD groups, no regressions).

== Problem ==

A VMM managing guest memory needs to:

  1. detect which pages are still being touched (working-set
     tracking);
  2. safely reclaim cold pages to slower tiered or remote storage;
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
Userspace then learns which pages were touched during the cycle by
reading PAGE_IS_ACCESSED out of PAGEMAP_SCAN -- that set is the
working set; everything else is a reclaim candidate.

UFFDIO_RWPROTECT is the protect/unprotect ioctl, mirroring
UFFDIO_WRITEPROTECT.

UFFDIO_SET_MODE flips RWP_ASYNC <-> sync at runtime under
mmap_write_lock() + vma_start_write(), so a VMM can run in async
mode for detection and switch to sync for race-free reclaim without
re-registering the userfaultfd.

== Typical VMM workflow ==

  /* arm */
  UFFDIO_API(features = RWP | RWP_ASYNC)
  UFFDIO_REGISTER(MODE_RWP)

  /* detection cycle (async) */
  UFFDIO_RWPROTECT(range, RWP)
  sleep(interval)

  /* freeze the snapshot before scanning */
  UFFDIO_SET_MODE(disable = RWP_ASYNC)                  /* sync */
  PAGEMAP_SCAN(PAGE_IS_ACCESSED) -> hot pages (working set)

  /* reclaim everything not in the hot set from the backing file */
  fallocate(FALLOC_FL_PUNCH_HOLE, non-hot) /* or pwrite to remote */
  UFFDIO_SET_MODE(enable  = RWP_ASYNC)                  /* resume */

== Series layout ==

Patches 1 to 3 are preparatory:

  1: decouple protnone helpers from CONFIG_NUMA_BALANCING.
  2-3: rename _PAGE_BIT_UFFD_WP, pte_uffd_wp() and friends to drop
       the _WP suffix, since the bit now carries WP and RWP meaning
       depending on the VMA flag. The SCAN_PTE_UFFD enum's ftrace
       output string is intentionally kept as "pte_uffd_wp" so
       trace-based tooling does not silently break.

Patch 4 switches the uffd VMA-flag helpers to the vma_flags_t
accessors (vma_test_*_mask), so the VMA_UFFD_* masks are the single
place that knows which modes the build offers.

Patches 5 to 8 add the in-kernel mechanism:

  5: VM_UFFD_RWP VMA flag (aliased to VM_NONE until patch 9
     introduces CONFIG_USERFAULTFD_RWP together with the UAPI).
  6: MM_CP_UFFD_RWP change_protection() primitive (PAGE_NONE +
     uffd bit, plus a RESOLVE counterpart).
  7: marker preservation across swap, device-exclusive, migration,
     fork, mremap, UFFDIO_MOVE, hugetlb copy, and mprotect().
  8: handle VM_UFFD_RWP in khugepaged, rmap, and GUP.

Patches 9 to 13 wire the userspace surface:

  9:  UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT plumbing
      (introduces CONFIG_USERFAULTFD_RWP).
  10: RWP fault delivery and exposure of UFFDIO_REGISTER_MODE_RWP.
  11: PAGE_IS_ACCESSED in PAGEMAP_SCAN.
  12: UFFD_FEATURE_RWP_ASYNC for async fault resolution.
  13: UFFDIO_SET_MODE for runtime sync/async toggle.

Patches 14 and 15 are kernel tests and Documentation/. The matching
man-pages series is already upstream.

Kiryl Shutsemau (Meta) (15):
  mm: decouple protnone helpers from CONFIG_NUMA_BALANCING
  mm: rename uffd-wp PTE bit macros to uffd
  mm: rename uffd-wp PTE accessors to uffd
  userfaultfd: test uffd VMA flags through the vma_flags_t API
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
 Documentation/admin-guide/mm/userfaultfd.rst | 269 ++++++-
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
 fs/proc/task_mmu.c                           |  98 ++-
 include/asm-generic/hugetlb.h                |  18 +-
 include/asm-generic/pgtable_uffd.h           |  32 +-
 include/linux/huge_mm.h                      |   7 +
 include/linux/leafops.h                      |   4 +-
 include/linux/mm.h                           |  65 +-
 include/linux/mm_inline.h                    |   4 +-
 include/linux/pgtable.h                      |  32 +-
 include/linux/swapops.h                      |   4 +-
 include/linux/userfaultfd_k.h                |  89 ++-
 include/trace/events/huge_memory.h           |   2 +-
 include/trace/events/mmflags.h               |   7 +
 include/uapi/linux/fs.h                      |   1 +
 include/uapi/linux/userfaultfd.h             |  54 +-
 init/Kconfig                                 |   8 +
 mm/Kconfig                                   |   9 +
 mm/debug_vm_pgtable.c                        |   4 +-
 mm/huge_memory.c                             | 161 ++--
 mm/hugetlb.c                                 | 158 +++-
 mm/internal.h                                |   4 +-
 mm/khugepaged.c                              |  40 +-
 mm/memory.c                                  | 135 +++-
 mm/migrate.c                                 |  20 +-
 mm/migrate_device.c                          |   8 +-
 mm/mprotect.c                                |  70 +-
 mm/mremap.c                                  |  17 +-
 mm/page_table_check.c                        |   8 +-
 mm/rmap.c                                    |  18 +-
 mm/swapfile.c                                |   9 +-
 mm/userfaultfd.c                             | 387 ++++++++-
 tools/include/uapi/linux/fs.h                |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c | 781 +++++++++++++++++++
 51 files changed, 2333 insertions(+), 437 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

