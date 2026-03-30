Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C53B960C;
	Mon, 30 Mar 2026 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865487; cv=none; b=qr81VcCVj/Lnpwwn8EBvIawCnkDMIaLfa/34AlwaJ2AEPpi9KyCYOGzFXywZjBCD22VekhQii1urgQirpEAcKqmC58SzHYQMdsHJ6i/amuVV4V27oBz+tWw2GsMqQEpoddLH6kUMaWBwKUA8LVbUBo8RGG6vuk/84/VGT7oosQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865487; c=relaxed/simple;
	bh=GgKA5DKfE0J6C86Pd58sBvtyWfrHRhL+cDnuFJprFXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7IN18xg93rrpr9g1uiDtmI7utWDtVKzSfyQcJ943/PnajGlKtRr0TaSvHa9fR0W1X6ohCYUq1jeUwFXXL9Qxty70DdumzOaBLXWRFNl36V/PYf6UQHYniUeEGqnqXAU9gBZ4MZzOeU5JL3O8Pj3xAyXbW7mD6OovTyBdjKuRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz3RaLZ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz3RaLZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05F4C2BCB1;
	Mon, 30 Mar 2026 10:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865486;
	bh=GgKA5DKfE0J6C86Pd58sBvtyWfrHRhL+cDnuFJprFXI=;
	h=From:To:Cc:Subject:Date:From;
	b=oz3RaLZ4XqTIWA/YrlmEslKtMgjjzZUSf4/xnt5q9aPl5HExKWwVBg3skiD1JgDEc
	 CF3Rpp229qlD1QYeyZo3hcEN6wHUVlMny1H+HiOqHCuZIj2lfzkQW4kCE8suuUFC9m
	 +1lDQDpxmPbKzCEZw8l1FsNCAYq+fKRbyjBxu/NMgDFBYTMWx38HfNXla2kPCp4KcC
	 5sz3bn1qyjvp6w+/V7eKKJ1KCz+rrUybjpPdUM2kzPIAWQ9rVfx1uoI84wjSJ0mxFm
	 5FKaKj7HppkUc0triJODgpx/rn6uKvJgtF6w9bU+g9qiD1BkO8LoPN8fZxV8Vjob02
	 SUlzlK9XoqDnA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 00/15] mm, kvm: allow uffd support in guest_memfd
Date: Mon, 30 Mar 2026 13:11:01 +0300
Message-ID: <20260330101116.1117699-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches enable support for userfaultfd in guest_memfd.

As the ground work I refactored userfaultfd handling of PTE-based memory types
(anonymous and shmem) and converted them to use vm_uffd_ops for allocating a
folio or getting an existing folio from the page cache. shmem also implements
callbacks that add a folio to the page cache after the data passed in
UFFDIO_COPY was copied and remove the folio from the page cache if page table
update fails.

In order for guest_memfd to notify userspace about page faults, there are new
VM_FAULT_UFFD_MINOR and VM_FAULT_UFFD_MISSING that a ->fault() handler can
return to inform the page fault handler that it needs to call
handle_userfault() to complete the fault.

Nikita helped to plumb these new goodies into guest_memfd and provided basic
tests to verify that guest_memfd works with userfaultfd.
The handling of UFFDIO_MISSING in guest_memfd requires ability to remove a
folio from page cache, the best way I could find was exporting
filemap_remove_folio() to KVM.

I deliberately left hugetlb out, at least for the most part.
hugetlb handles acquisition of VMA and more importantly establishing of parent
page table entry differently than PTE-based memory types. This is a different
abstraction level than what vm_uffd_ops provides and people objected to
exposing such low level APIs as a part of VMA operations.

Also, to enable uffd in guest_memfd refactoring of hugetlb is not needed and I
prefer to delay it until the dust settles after the changes in this set.

v3 changes:
* add fixes from Harry and Andrei
* fix handling of WP-only mode for WP_ASYNC contexts in vma_can_userfault()
* address David's comments about mfill_get_pmd() and rename it to
  mfill_establish_pmd()
* add VM_WARN()s for unsupported operations (James)
* update comments using James' suggestions

v2: https://lore.kernel.org/all/20260306171815.3160826-1-rppt@kernel.org
* instead of returning uffd-specific values from ->fault() handlers add
  __do_userfault() helper to resolve user faults in __do_fault()
* address comments from Peter
* rebased on v7.0-c1

RFC: https://lore.kernel.org/all/20260127192936.1250096-1-rppt@kernel.org

Mike Rapoport (Microsoft) (11):
  userfaultfd: introduce mfill_copy_folio_locked() helper
  userfaultfd: introduce struct mfill_state
  userfaultfd: introduce mfill_establish_pmd() helper
  userfaultfd: introduce mfill_get_vma() and mfill_put_vma()
  userfaultfd: retry copying with locks dropped in
    mfill_atomic_pte_copy()
  userfaultfd: move vma_can_userfault out of line
  userfaultfd: introduce vm_uffd_ops
  shmem, userfaultfd: use a VMA callback to handle UFFDIO_CONTINUE
  userfaultfd: introduce vm_uffd_ops->alloc_folio()
  shmem, userfaultfd: implement shmem uffd operations using vm_uffd_ops
  userfaultfd: mfill_atomic(): remove retry logic

Nikita Kalyazin (3):
  KVM: guest_memfd: implement userfaultfd operations
  KVM: selftests: test userfaultfd minor for guest_memfd
  KVM: selftests: test userfaultfd missing for guest_memfd

Peter Xu (1):
  mm: generalize handling of userfaults in __do_fault()

 include/linux/mm.h                            |   5 +
 include/linux/shmem_fs.h                      |  14 -
 include/linux/userfaultfd_k.h                 |  73 +-
 mm/filemap.c                                  |   1 +
 mm/hugetlb.c                                  |  15 +
 mm/memory.c                                   |  43 ++
 mm/shmem.c                                    | 188 ++---
 mm/userfaultfd.c                              | 694 ++++++++++--------
 .../testing/selftests/kvm/guest_memfd_test.c  | 191 +++++
 virt/kvm/guest_memfd.c                        |  84 ++-
 10 files changed, 860 insertions(+), 448 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
--
2.53.0
