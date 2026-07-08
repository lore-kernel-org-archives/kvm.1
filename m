Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E553CF97F;
	Wed,  8 Jul 2026 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509262; cv=none; b=lfkIteKUiyfNxwqthMJCYVZTmogH9I40xQammjyePkLyThQqlV6oyiaIbq9VNfSX5DWNr0sZ4Sm6Rff1Rjs9b0Dk2knb6WIkr7n4EmNVBrYXN3F7WRFM5QcIVQPps6QhGP0hJGNE1FeF47zxAR6dDWcYB3jJM33E03M3t22qhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509262; c=relaxed/simple;
	bh=I55nioxr/rAFFSvgHNg4gvGXKkW9I6aClJS10s+4TFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQB9jgPY65+p/E5GDiFC2Kjfw2FV1HYUVMsvsHWtOsq/PpkCIprL8+rdOhwh4gLSuNFlXDJmcgZv61fEuNV4DX8ZQxWJqhw3lhQvmkm0KZx5RwEhtEyASFdvWB9Qa4kAmm5MdEsoE00wec8AkTd+R3JNG24avEYTKzvY4BTROjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lQtOsh2e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BlXJF+qp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lQtOsh2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BlXJF+qp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B63307A00A1;
	Wed,  8 Jul 2026 07:14:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 07:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1783509259; x=
	1783595659; bh=JvAyjlWNI6YZO6NfvIOecLrwqYMYnO8FDhEy8qDdGng=; b=l
	QtOsh2eY1e5/SzYl/z9xZrEwP0i4Ta/I4BOzfBEVqD1bV5kVEV8CpUmKoqkAJ0ro
	c+VqUjy3oAqde+7VbTl7w+6n83k5Veoia0ctTHZCOtt9sd3y/cu65FZ+CvWFbNKJ
	CLPEOOGTRFLzFtCU25aUrR24wqWeCccNRO+Z8wM5sBKHRJpgBcL/0xFgl6XaJQyt
	5FfqpRpa5vPesyptP32mblkcceCeg5qmDmLp+9wzMm8ZSQTXHjc1GI9Ir2tfPawm
	nfZ0UTrI5wISrF83zcF8ld0AIAFJRFfBiSsb/cdvOVlNIy6LJBVi5kHETkO70d8p
	tf1mem/OP8s3xm8OeoHtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783509259; x=1783595659; bh=JvAyjlWNI6YZO6NfvIOecLrwqYMY
	nO8FDhEy8qDdGng=; b=BlXJF+qpmCkN+UKm21yuF+vPkGPktq/Yx5FYbIKerUir
	vJAcMfNq2qT1a8yuDLGu/B4RbgJRopYjiT/htqrFBa3ZDHM/CBnv15VcmrlMu4pV
	ouJ7nioF+5VVS+ogZCI3NUft8T/VkNp1/HHTlvFerciUyHYHzCqFmCsti2k82EiS
	LHMi5NsGMQTUCMNILFBPW1B5ECKyHYx8WnsC1aNSLQvJ9m2oHIGLwzluMSX2BTDB
	s9J6YSC16ys0r1/qQl+UcVYlVItGnqkpBX3DZs0X/86dSUq3xsMrVCBkV87z9N0W
	+ihYzKFJE14koaTfSCBfnglt7rCvIHfzybFg2xRAXQ==
X-ME-Sender: <xms:CzFOajbPK9Xfa4V_yoPr6pp6UISy4fb00wA2prVuB4WB2qDJBo12NQ>
    <xme:CzFOamUFxMfU6lUh9SYU4BQCv35JDGNJZwCDyZEclLQ0M52aLKLlW6k6Cr845SkQ8
    ngZffZ0qq_RIcDkhm_xy52C4K3ZIGio7M4uTGj6MSeRnd6wUACRiA>
X-ME-Received: <xmr:CzFOaudJKANtGLqU6SoZOFnlewgH4VPT_MuoYJLCRVrqpcAgmkYKvXrWUnpRJQ>
X-ME-Proxy-Cause: dmFkZTEotIPoabf5BNYebqczoCEby+reBUPP5i1YdRZEdQfjort4psOrp/0yEBug8FqBK/
    Qao8Wy+oXokmG1sT8yeQ5gIv5e8osU1jW6dY4ciJrov5HFwukC3tLsa1O+ZrhX1cixDo2l
    3o/ha0BGK73pj/TiZWfdKazvCN7F9H6rRUYLWDa8BQO4IV9s9PrMv8MVZTRfXTaCvA6nHQ
    w+nZJOXrTSKMsIeBWJW2VDY9I3jsjddpdZ2NZbh5Uoiw/80CjHQMg9HjjYudoPHtjqYnNN
    y96cVtrwMWVc8vYWYWcj3+BlMbivfyAZ563yjsmxjR94v9YxkPdIwuEgkgxkw5tjypaqPD
    o4fFRdGL5sJxFfBwNXo3Sglpb41cbpizJDM6OErGUhdNtTGqsmlnvwPo4a+qT+QAK0sY8e
    4IgrBOH3cwemJ0puOLOPD8Djs3n5j0qnqMg6a4I5T9gdeKnSRCYnQRbtwJeJwZbNONTpFK
    /VbhddwcHtZfP3yOCltEM/55lIiu/9Mh0rGxG9PvBD+X1DpCtPAdRqQ9gR89jRtw+ETwWU
    pO8L9L5O1t0J0VQAoDWb851CWqiSTEYKOubyrK7sARaJELQpFmYR/Wqt+1vfpt305MMbty
    uk3ySP+3dJ/T3MrPSaweSbCiMfvijorfVV35tiuWnEmLmrR8QkXWUvjWZE/g
X-ME-Proxy: <xmx:CzFOajMSXW_LeKu482x11LvhplBz8W9LPq33Xbi3fXHXyaA2Dscl7g>
    <xmx:CzFOamLkxtgE6zNe59Dl_8qWchhDfxZbF2uNAhxEoqIkHn9DuzNtew>
    <xmx:CzFOaplbgIOX2Qww2ywNDIUkevbdN7b2fHko_36dYk92y3EZ0LUDjg>
    <xmx:CzFOalac777D98G0SCwxiv4eB2lxycceAUPPL2eXZqwK9YEKApGoKQ>
    <xmx:CzFOaqZxmcEZYZ0DTLns-tae7S1wjcGqNNUI12bRO0k7vmx5Ruy0uJYC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 07:14:18 -0400 (EDT)
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
Subject: [PATCH v10 00/15] userfaultfd: working set tracking for VM guest memory
Date: Wed,  8 Jul 2026 12:14:01 +0100
Message-ID: <20260708111417.173443-1-kirill@shutemov.name>
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
v7: https://lore.kernel.org/all/20260629120749.566063-1-kirill@shutemov.name/
v8: https://lore.kernel.org/all/20260703133615.1039465-1-kirill@shutemov.name/
v9: https://lore.kernel.org/all/20260706084805.8400-1-kirill@shutemov.name/

== Changes since v9 ==

Rebased onto mm-new; resolved the copy_hugetlb_page_range() conflict
Andrew hit against the hugetlb swap-corruption fix -- hwpoison keeps no
clear, migration uses pte_swp_clear_uffd() with userfaultfd_protected().

  - 11/15: gate the pte_none PAGE_IS_WRITTEN report in
    pagemap_page_category() on userfaultfd_wp(vma). The standalone fix
    now in mm-new reports pte_none unconditionally to match the ungated
    fast path; this series gates that fast path on VM_UFFD_WP, so the
    generic path must gate too. RWP has no such fast path and
    unpopulated pages are not part of the RWP working set.
  - 14/15: tolerate EINVAL from madvise(MADV_NOHUGEPAGE) so the test
    does not abort on CONFIG_TRANSPARENT_HUGEPAGE=n; rwp-mprotect and
    rwp-fork-pin assert the marker survived before the auto-resolving
    access (posted earlier as a v9 14/15 update [1]).

Based on mm-new plus the hugetlb swap-corruption fix [2] (in
mm-hotfixes), shown here as a prerequisite-patch-id. The PAGEMAP_SCAN
PMD-hole fix [3] is independent and not required.

[1] https://lore.kernel.org/all/20260706104906.36084-1-kirill@shutemov.name/
[2] https://lore.kernel.org/all/20260708090110.136162-1-kirill@shutemov.name/
[3] https://lore.kernel.org/all/20260708103429.150655-1-kirill@shutemov.name/

114/114 of tools/testing/selftests/mm/uffd-unit-tests pass on mm-new
(47 RWP cases plus the existing UFFD groups, no regressions).

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

The series is also available at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git uffd/v10

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
 Documentation/admin-guide/mm/userfaultfd.rst | 269 +++++-
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
 fs/proc/task_mmu.c                           | 116 ++-
 include/asm-generic/hugetlb.h                |  18 +-
 include/asm-generic/pgtable_uffd.h           |  32 +-
 include/linux/huge_mm.h                      |   7 +
 include/linux/leafops.h                      |   4 +-
 include/linux/mm.h                           |  65 +-
 include/linux/mm_inline.h                    |   4 +-
 include/linux/pgtable.h                      |  32 +-
 include/linux/swapops.h                      |   4 +-
 include/linux/userfaultfd_k.h                | 100 +-
 include/trace/events/huge_memory.h           |   2 +-
 include/trace/events/mmflags.h               |   7 +
 include/uapi/linux/fs.h                      |   1 +
 include/uapi/linux/userfaultfd.h             |  54 +-
 init/Kconfig                                 |   8 +
 mm/Kconfig                                   |   9 +
 mm/debug_vm_pgtable.c                        |   4 +-
 mm/huge_memory.c                             | 170 +++-
 mm/hugetlb.c                                 | 155 +++-
 mm/internal.h                                |   4 +-
 mm/khugepaged.c                              |  40 +-
 mm/memory.c                                  | 152 ++-
 mm/migrate.c                                 |  20 +-
 mm/migrate_device.c                          |   8 +-
 mm/mprotect.c                                |  70 +-
 mm/mremap.c                                  |  17 +-
 mm/page_table_check.c                        |   8 +-
 mm/rmap.c                                    |  18 +-
 mm/swapfile.c                                |   9 +-
 mm/userfaultfd.c                             | 389 +++++++-
 tools/include/uapi/linux/fs.h                |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c | 919 +++++++++++++++++++
 51 files changed, 2511 insertions(+), 451 deletions(-)


base-commit: 302dfbff3e73be2ba5723237c6303244ec27cebb
prerequisite-patch-id: c9e6fd9c901f858b5bc4f275c5bef195ea71329a
-- 
2.54.0

