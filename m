Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614987;
	b=wYbCZWHynL2u5PIIz6930dQyRz2n20h4qICtpN3xZSESK9S/vIpPPJ95/B3yIFjqJLgX
	 aVAkV906Ir1qxJHhfthA2uOWkkMTp46y0b7FD7q9sV3ozh8e9FBm/oWygBwVdmvtShDHm
	 4DskY/oYjvMI1bkiQv1Z0s7yJT0pTfFYUe7gIPqKJhDkTqHSLGjYM9lD8R/ISoQF2mr+y
	 MWJrNncvduYAbXXQPAoToim/gNj5qpldayyYHgxUeymxBVTAsnxIROAnLRmLVxBNJs3H9
	 duuZwMvtJCLNEO3nutNaraoxYyma72+1yrnb0TY2LCM2GnkWnv8r4pVSeNh12GBDe4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614987;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xRYTM7fnAWcOHXN6sYtLFwsf0RsyMtzXmlCvmvLIHrg=;
	b=MgxRh16ihJvPfGTgX7p1cmpt1VWK/5MUg8KSgJm4KFNm2OixDc15pEOWruVFuYZQ7IjR
	 sbGJPOLK53P+N/ugnKky0HgDkE+BQHU/qfRIhdwvGnAAfdZX2DlQ0jIcXS0r3gmI7zZpa
	 +/kAsvK3ouQQQdOafGO+e15hqhDczEeE0DHwec2M9HKNyU+NJWw5yy/w025+VGDRII1k9
	 C4vw7//UTrpzeZrKhKpfXiaW29hGrLJp3GtfArF+IlF3UzxpZoeW4zgs03AcXNmp6w8gn
	 w4UJbjpKr93Cw1gxOIcC04dynDwcTwevat5z5HwFxag6LIGOxv5QrlO4pwVMEX+ElcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=p1quoMtK;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43E606A32C;
	Wed, 21 Oct 2026 20:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C43E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=p1quoMtK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=xRYTM7fnAWcOHXN6sYtLFwsf0RsyMtzXmlCvmvLIHrg=; b=p1quoMtKV/aLG7i8AqC
	+uQWoPkWgpRohfDSu68uHYpqbvwecEc4rFnPgAmHzKor+I+lYSquFiKrOHalKmbcA9UnKrVXs/Yqb
	DswZLGW8KkMxm0Ni3AjlYLQCJI0lrXmrWfnzD22iG8hBSdoo+AhawAXh98HAJohnPRplxNItaekci
	z5rfXpbzxF1dSlPbwStc/Gaqsj9jYrBl7axb4mExcYEXS3Cu7xWJsMqJGbKF4X3too7lH9KBn1h8+
	lqqgGP2+Oo22zvS2Ntxce1m/CGgcjsR4DGOJHaInE4FA/u3FDRwAH/mTmhCjJgPGMWGcv3DzDuxtv
	kWa3dBE9l0o/dDg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xJcz6-00D9zC-1k;
	Wed, 21 Oct 2026 22:36:11 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 21 Oct 2026 22:36:02 +0200
Subject: [PATCH v4 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-3-66f00b7a564c@virtuozzo.com>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3894;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=livbJIVllqi9tjof4xcSXNlwj+qMnVMZzyODwKG/KkA=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq2SI4OzYdMkv0y22/iMTVTPGRPBuq7eyDakOFD
 eYKcKYE9OGJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCatkiOAAKCRBRlgpH+WFc
 Ki0OEACM5t9icGUbUfF7oM2+7vDjg6uiZ/QlwAXRXORLzo6PdOir8qcZhQ2Dxp4vS7e/BtF9xYE
 Am5NxUVCXW/owrlYnm1bLHQ+2ylTm6JlCLOCh7ooy4ILlAFDJyUvv5nfoLHhk6ydEhlQ/lO9OLY
 QqAUJWsK+CdOArLzZ+wB160FQiBufc4zHI50sZ0rA5fuGDuoiJdu3UJNc2q7+SJho2qlTdmIEPL
 +4z05HFrk80HSM7o8vibRwzGbfHUSpJyf4/fGolfMYm8X97VQ4fHl/Hc+f7XqshSZPrI0Hi82hI
 2kRwr/rUw2QqTn2KyBtUSSMieLe+FTcHVOB2o1rKMBmy5kTvYCjrsbHJLHA2N71zGittHvdFQAV
 wc+CRV5a4yJ+i7wj9g8sBSXJYtl2oc+Nh3YoFgonmxrsr4gqVGHh0p19j4QU3uKT79elyogWliL
 igktAc782Hv4OTeQEw/mOWzRD9KPuEBmYe7RV+vez9WQ5phkrIUO7KMODcMGrQ7m56j2UQgODJC
 +jnUCGDIFF7udwOHWjbtMgOT7iBJj2rMVJaPPjPKHWG65w8dK0lkgKGgVE3c5iLC1VO4TO60kpt
 r73GPnlPIIN6sFFV/KhwFfnUD5kZMhrKgeZL7gLF+7azWsgH31FT8y1gkMNuThqR4EAn0bTzxKI
 mnF4/gQ14YUWGGQ==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

copy_huge_pmd() reads a special PMD without the page table lock and
copies that value to the child. The mmap write lock held by fork does
not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
lock.

The zap visits the parent VMA before the child's, as dup_mmap() links
the child right after the parent in i_mmap. If it clears the parent PMD
after fork has read it, and passes the child before fork copies it, the
child keeps a mapping the driver has revoked, for example:

- vfio-pci: the child reaches the BAR after the device memory was
  disabled or the device was reset, instead of getting SIGBUS;
- panthor: the child maps the pages of an evicted buffer object after
  the driver has released them.

The same branch deposits no page table under the copy. ppc64 in hash
mode keeps the hash slot array of every huge PMD in that table, so the
child dereferences a NULL table on the first hash fault, in
__hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().

Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
from a folio under them, as copy_present_ptes() does with
vm_normal_page(). The zap clears the parent PMD under the same lock, so
either fork finds it none and skips it, or the copy is in place before
the zap reaches the child.

The copy of a PFN mapping then goes through the same tail as a folio:

- it gets a page table where the architecture needs one;
- in a shared mapping it is marked clean in the child, as a PTE is;
- in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
  protected instead of a warning being printed.

Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 13e3674fb6115..da5918a0ade87 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1961,25 +1961,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 	bool writable;
 
-	pmd = pmdp_get_lockless(src_pmd);
-	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
-		     !is_huge_zero_pmd(pmd))) {
-		dst_ptl = pmd_lock(dst_mm, dst_pmd);
-		src_ptl = pmd_lockptr(src_mm, src_pmd);
-		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		/*
-		 * No need to recheck the pmd, it can't change with write
-		 * mmap lock held here.
-		 *
-		 * Meanwhile, making sure it's not a CoW VMA with writable
-		 * mapping, otherwise it means either the anon page wrongly
-		 * applied special bit, or we made the PRIVATE mapping be
-		 * able to wrongly write to the backend MMIO.
-		 */
-		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
-		goto set_pmd;
-	}
-
 	if (vma_is_anonymous(dst_vma) || arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(dst_mm);
 		if (unlikely(!pgtable))
@@ -2021,7 +2002,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		goto copy_pmd;
 	}
 
-	src_page = pmd_page(pmd);
+	src_page = vm_normal_page_pmd(src_vma, addr, pmd);
+	if (!src_page)
+		goto copy_pmd;
 	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
 	src_folio = page_folio(src_page);
 
@@ -2061,7 +2044,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 	if (src_vma->vm_flags & VM_SHARED)
 		pmd = pmd_mkclean(pmd);
-set_pmd:
 	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 

-- 
2.43.0

