Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC935E92D;
	Thu,  2 Apr 2026 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103126; cv=none; b=OJNvZgSrKJ3PHOTw52Iu+Vh+GzdlyzMV0UdP7Ct6dLGmYJOGj6UAxEQqDUo1o4ToAxm90aczYqmVZ3Qj1vUmz7pJVjvplBWKx0qAg0/hJuK/+4rzKTyp0LKqhQYc+2eG5g17GarpD5dXj6dRVtF2o/XqYlJBY01LzJEpuikIGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103126; c=relaxed/simple;
	bh=YdxT9Os1hSGPmZw1lQ6CLN+t2WtiDCHbfZPu8SvWeQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HArmd6GjaX9amTH3yIEZxnUJqqoIaWEftj19wjM0s0aUYwmPSLuS6jwV+ECD2vI8aGT0M80oZ3oFs45vgmpl04vlnTNv5q2k6FfqQJ895WWbpebznTl7Zzxt6z+LiY9E3+kHxbkEGySE9fB+NVarPND9fZMFlLXIQIfEBCriczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKKUf4pb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKKUf4pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092F6C19423;
	Thu,  2 Apr 2026 04:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775103126;
	bh=YdxT9Os1hSGPmZw1lQ6CLN+t2WtiDCHbfZPu8SvWeQE=;
	h=From:To:Cc:Subject:Date:From;
	b=pKKUf4pbTEdGa00km9nLhdXKDDyJ1GVwXsRXfO8pRSh8eybncdhP7eo0EZ/127FMi
	 cy5KaxCS6/LgeFl9S4PzmWt9v5lLwwZA04l+DCqOSrUjn4IzVt6Y8h3fd9aB653PRn
	 dxbrdEgvgfXRoK7quOVCuCTXSlC1N0eYzfSDGRJZ2LL4xuswYT+2mJylXarNQSUthO
	 ODpK6qi84Au/3YWwX6Obs6dnjC0v1fGTECSqcljzY4IwZWRyAHSoCt2iAxoZ4Ys2Ig
	 /2pNBiAC4x+a+K/zpycRgg8P2tSKQ2TIkX60sAlg/yA5xUjV50/Y4M6Tnk0tt6uB0q
	 8838NCi68y7lg==
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
Subject: [PATCH v4 00/15] mm, kvm: allow uffd support in guest_memfd
Date: Thu,  2 Apr 2026 07:11:41 +0300
Message-ID: <20260402041156.1377214-1-rppt@kernel.org>
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

v4 changes:
* fix lock leak not only in patch 4, but also in patch 2, thanks Harry

v3: https://lore.kernel.org/all/20260330101116.1117699-1-rppt@kernel.org
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
