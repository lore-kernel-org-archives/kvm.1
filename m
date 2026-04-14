Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15493D9DBD
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176638; cv=none; b=c2a7skFvBlIZ8LqIlheNYUwfbI437PpHDUwn1R23/2rfFFzEM6WxW9OAHvTLBETEV1RaTaETHrbZXHDSN6k45QRhchMzVLLj1JsLNstYQc9a0kIT17lMtiAV/7xIbfU/5pkltju5Xg7/3odfsBc/VJevi/JcrYZTcwHxGUwNoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176638; c=relaxed/simple;
	bh=/fCVxa0eMyMWklv2E9q9GFJdXVtpfKD77F6QKI/nFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BKHy16D+ko886590W/VnagkV4CfK7Seo/XfkHRRyNpKr1/kkXFUn7rSzR1gTOvWu/BCHtt7I3e7RPLzEUzyDVddB0qLDaqX/45hNqOTIVrCwFjIEtnxAWv9JZU4CEFoHV+TtSEuDNQIBD524xNvQ0Ji17kdGyGtZjJp6yGlk7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUMgG7US; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUMgG7US"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0429EC19425;
	Tue, 14 Apr 2026 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176638;
	bh=/fCVxa0eMyMWklv2E9q9GFJdXVtpfKD77F6QKI/nFIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CUMgG7USGrHWNOhxeLwWd/mwPJHpMj3QUt4q9oHTRQdLna0K9mfo2uXiVDMQ4hKpc
	 uqrM/kI+CMLi/YxeXP3Uj623dK4aKke80UIjoAkHX6M43RqZ9INfja18DHQc7R/S2+
	 pW4MsWKJLn0WAhQd7L7Bnq2qe9L/yhS012c69IM4E8TCzpKVthZEBVCnW8ufu9TC95
	 4DEGxxDjc8+U+4jNcXTmaTYPTexLDZ2jImIEi8IukiOLl4yyK7zsCk9aJdFfpN8eBS
	 VYO4GHxm5TEZYZGz0+e6qMSjf4rzl5yQgj3E4hw6+5bIWpkdYJqXbqzw6K8qRMJ6CJ
	 2qGv8yv3OQZ6A==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 28BECF4006B;
	Tue, 14 Apr 2026 10:23:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 14 Apr 2026 10:23:57 -0400
X-ME-Sender: <xms:_U3eaQCvx35FDPWnL6sBweeurEOIpI1LijIehBqkLQ-bQHEONKlxzA>
    <xme:_U3eaT_VLmjwZOt1WWXNz-43IGClnMVgKQG_vmW9Zpt3C0HbfQIow8sRSqkzPvv-R
    D_TrBXUamNa9V1MsdCGIbUQMkUdXgaIPtCBTAxjlvnrjaXezzIrkyw>
X-ME-Received: <xmr:_U3eae-dUcx-b5B52N4dZw92O_l69d7jJWMEWbFPEPP9sCzpLlTml1QK-rznEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepfdfmihhrhihlucfu
    hhhuthhsvghmrghuucdlofgvthgrmddfuceokhgrsheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleevheejjeevveetgfejvdfhtdfftefhhfettefgkeejfefg
    keduhfdthfehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudei
    udduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshh
    huthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggr
    vhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhr
    vghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:_U3eaT3tV0clRDLau64h_TF2174YK72e9bO6MIuYmNiAAB_3GGKYmw>
    <xmx:_U3eaW-oonZ89wLF8NBRjooF_IQKHfLzthUEv49mYfz9vXflpFxGFw>
    <xmx:_U3eace5NWItR9K6l05oht3kgIeUcBoOkY2SSpv5ilJbt-QDeiPC9Q>
    <xmx:_U3eaaEyQMfeSO-25SexlC6pwViL_nRKottkT37wtZNO6LAucKdryw>
    <xmx:_U3eaZAbUtd7_zzDnzhJQDQYpwcvp63VCCSURN19-3KzfM-2D_ehBgmi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:23:56 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM guest memory
Date: Tue, 14 Apr 2026 15:23:34 +0100
Message-ID: <20260414142354.1465950-1-kas@kernel.org>
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
VM guest memory, enabling VMMs to identify cold pages and evict them
to tiered or remote storage.

== Problem ==

VMMs managing guest memory need to:
1. Track which pages are actively used (working set detection)
2. Safely evict cold pages to slower storage
3. Fetch pages back on demand when accessed again

For shmem-backed guest memory, working set tracking partially works
today: MADV_DONTNEED zaps PTEs while pages stay in page cache, and
re-access auto-resolves from cache. But safe eviction still requires
synchronous fault interception to prevent data loss races.

For anonymous guest memory (needed for KSM cross-VM deduplication),
there is no mechanism at all — clearing a PTE loses the page.

== Solution ==

The series introduces a unified userfaultfd interface that works
across both anonymous and shmem-backed memory:

UFFD_FEATURE_MINOR_ANON: extends MODE_MINOR registration to anonymous
private memory. Uses the PROT_NONE hinting mechanism (same as NUMA
balancing) to make pages inaccessible without freeing them.

UFFD_FEATURE_MINOR_ASYNC: auto-resolves minor faults without handler
involvement. The kernel restores PTE permissions immediately and the
faulting thread continues. Works for anonymous, shmem, and hugetlbfs.

UFFDIO_DEACTIVATE: marks pages as deactivated. For anonymous memory,
sets PROT_NONE on PTEs (pages stay resident). For shmem/hugetlbfs,
zaps PTEs (pages stay in page cache).

UFFDIO_SET_MODE: toggles MINOR_ASYNC at runtime, synchronized via
mmap_write_lock. Enables the VMM workflow: async mode for lightweight
detection, sync mode for race-free eviction.

PAGE_IS_UFFD_DEACTIVATED: PAGEMAP_SCAN category flag for efficient
batch detection of cold (still-deactivated) anonymous pages.

== VMM Workflow ==

    UFFDIO_DEACTIVATE(all)            -- async, no vCPU stalls
    sleep(interval)
    PAGEMAP_SCAN                      -- find cold pages
    UFFDIO_SET_MODE(sync)             -- block faults for eviction
    pwrite + MADV_DONTNEED cold pages -- safe, faults block
    UFFDIO_SET_MODE(async)            -- resume tracking

The same workflow applies to shmem, with a different PAGEMAP_SCAN mask
(!PAGE_IS_PRESENT instead of PAGE_IS_UFFD_DEACTIVATED).

== NUMA Balancing ==

NUMA balancing scanning is skipped on anonymous VM_UFFD_MINOR VMAs to
avoid protnone conflicts. NUMA locality stats are fed from the uffd
fault path via task_numa_fault() so the scheduler retains placement
data. Shmem VMAs are unaffected (UFFDIO_DEACTIVATE zaps PTEs there,
no protnone involved).

== Testing ==

The series includes 6 new selftests covering async/sync modes,
PAGEMAP_SCAN cold detection, GUP through protnone, UFFDIO_SET_MODE
toggling, and cleanup on close. All 73 uffd unit tests pass
(including hugetlb) across defconfig, allnoconfig, allmodconfig,
and randomized configs.

Kiryl Shutsemau (Meta) (12):
  userfaultfd: define UAPI constants for anonymous minor faults
  userfaultfd: add UFFD_FEATURE_MINOR_ANON registration support
  userfaultfd: implement UFFDIO_DEACTIVATE ioctl
  userfaultfd: UFFDIO_CONTINUE for anonymous memory
  mm: intercept protnone faults on VM_UFFD_MINOR anonymous VMAs
  userfaultfd: auto-resolve shmem and hugetlbfs minor faults in async
    mode
  sched/numa: skip scanning anonymous VM_UFFD_MINOR VMAs
  userfaultfd: enable UFFD_FEATURE_MINOR_ANON
  mm/pagemap: add PAGE_IS_UFFD_DEACTIVATED to PAGEMAP_SCAN
  userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
  selftests/mm: add userfaultfd anonymous minor fault tests
  Documentation/userfaultfd: document working set tracking

 Documentation/admin-guide/mm/userfaultfd.rst | 141 ++++-
 fs/proc/task_mmu.c                           |  11 +-
 fs/userfaultfd.c                             | 184 +++++-
 include/linux/huge_mm.h                      |   6 +
 include/linux/mm.h                           |   2 +
 include/linux/sched/numa_balancing.h         |   1 +
 include/linux/userfaultfd_k.h                |  21 +-
 include/trace/events/sched.h                 |   3 +-
 include/uapi/linux/fs.h                      |   1 +
 include/uapi/linux/userfaultfd.h             |  40 +-
 kernel/sched/fair.c                          |  13 +
 mm/huge_memory.c                             |  33 +-
 mm/hugetlb.c                                 |   3 +-
 mm/memory.c                                  |  51 +-
 mm/mprotect.c                                |   9 +-
 mm/shmem.c                                   |   3 +-
 mm/userfaultfd.c                             | 164 +++++-
 tools/testing/selftests/mm/uffd-unit-tests.c | 458 +++++++++++++++
 18 files changed, 1096 insertions(+), 48 deletions(-)

Kiryl Shutsemau (Meta) (12):
  userfaultfd: define UAPI constants for anonymous minor faults
  userfaultfd: add UFFD_FEATURE_MINOR_ANON registration support
  userfaultfd: implement UFFDIO_DEACTIVATE ioctl
  userfaultfd: UFFDIO_CONTINUE for anonymous memory
  mm: intercept protnone faults on VM_UFFD_MINOR anonymous VMAs
  userfaultfd: auto-resolve shmem and hugetlbfs minor faults in async
    mode
  sched/numa: skip scanning anonymous VM_UFFD_MINOR VMAs
  userfaultfd: enable UFFD_FEATURE_MINOR_ANON
  mm/pagemap: add PAGE_IS_UFFD_DEACTIVATED to PAGEMAP_SCAN
  userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
  selftests/mm: add userfaultfd anonymous minor fault tests
  Documentation/userfaultfd: document working set tracking

 Documentation/admin-guide/mm/userfaultfd.rst | 141 +++++-
 fs/proc/task_mmu.c                           |  11 +-
 fs/userfaultfd.c                             | 184 +++++++-
 include/linux/huge_mm.h                      |   6 +
 include/linux/mm.h                           |   2 +
 include/linux/sched/numa_balancing.h         |   1 +
 include/linux/userfaultfd_k.h                |  21 +-
 include/trace/events/sched.h                 |   3 +-
 include/uapi/linux/fs.h                      |   1 +
 include/uapi/linux/userfaultfd.h             |  40 +-
 kernel/sched/fair.c                          |  13 +
 mm/huge_memory.c                             |  33 +-
 mm/hugetlb.c                                 |   3 +-
 mm/memory.c                                  |  51 ++-
 mm/mprotect.c                                |   9 +-
 mm/shmem.c                                   |   3 +-
 mm/userfaultfd.c                             | 164 ++++++-
 tools/testing/selftests/mm/uffd-unit-tests.c | 458 +++++++++++++++++++
 18 files changed, 1096 insertions(+), 48 deletions(-)

-- 
2.51.2

