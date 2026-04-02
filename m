Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B79361640;
	Thu,  2 Apr 2026 04:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103215; cv=none; b=mZP6ghD2IILH532DAsPl2sl+fpT/nVSav4eH0aLM8j886pdv+QSHNPrTmE/0gLSVN76KbRvxaOvVYwFt5AZV6BQyW3uoy2bdBL5Z3Qo3d7m0lR8Lamlekr3yLRL5bxpNJ0HEuhGHcYoO6YeLY7hqs4ZpnQv3lm2Vbtukqhq6mSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103215; c=relaxed/simple;
	bh=sgqKlJf5BnGeophpkDo1XgppS/PlXJsOousdP1fvs+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cISTpfwCkArYOcRt4swoQWjcWXc2qvGYMaUj7EkQ0eR1/gkYUsOlqYfIZYb40eX9jK4tH8adMfuDaSMnHqTUE6OaENlqzQHMI3sOb86zi/Rpvvh95q2co3fKXFQu4snShxEzRj/muft0ymfriI4td0QYQ7yf0DrlXg3xhmrz7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvr2rNwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvr2rNwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A146DC19423;
	Thu,  2 Apr 2026 04:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775103214;
	bh=sgqKlJf5BnGeophpkDo1XgppS/PlXJsOousdP1fvs+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvr2rNwH7jcgFyeELsMcovv2IN7DOgkkZipn+nmUsdhDY8PGn9xg1V65Cd3eDNjZC
	 yOfZo/FK5gNWjQOK3u/HyexXHHp+mGdIFZWjBYTU9DXbCPtneQww1q9LO2qSKMONAc
	 HKUotWOVqa3AjwFO9AHUHNX/Bhqo9JEmAz3n62YCJhKY/kf6nbNnCwyLVIE6y4DNzb
	 HQJK1LPHwqAN24jZAvyWUAZ8uftcU284unGBT8/FPvV0yKxMy2YxeE9/lf2hX0K61y
	 A2GiIRSfzoqJ2ODQtJr4M4/XVfD1KOD7mNJd1dtsWRQRW0UzuhdBcmuNMcXOvOVcUx
	 NR/HodG4P84ng==
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
Subject: [PATCH v4 13/15] KVM: guest_memfd: implement userfaultfd operations
Date: Thu,  2 Apr 2026 07:11:54 +0300
Message-ID: <20260402041156.1377214-14-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402041156.1377214-1-rppt@kernel.org>
References: <20260402041156.1377214-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikita Kalyazin <kalyazin@amazon.com>

userfaultfd notifications about page faults used for live migration and
snapshotting of VMs.

MISSING mode allows post-copy live migration and MINOR mode allows
optimization for post-copy live migration for VMs backed with shared
hugetlbfs or tmpfs mappings as described in detail in commit 7677f7fd8be7
("userfaultfd: add minor fault registration mode").

To use the same mechanisms for VMs that use guest_memfd to map their
memory, guest_memfd should support userfaultfd operations.

Add implementation of vm_uffd_ops to guest_memfd.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/filemap.c           |  1 +
 virt/kvm/guest_memfd.c | 84 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 406cef06b684..a91582293118 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -262,6 +262,7 @@ void filemap_remove_folio(struct folio *folio)
 
 	filemap_free_folio(mapping, folio);
 }
+EXPORT_SYMBOL_FOR_MODULES(filemap_remove_folio, "kvm");
 
 /*
  * page_cache_delete_batch - delete several folios from page cache
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 017d84a7adf3..46582feeed75 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -7,6 +7,7 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include <linux/userfaultfd_k.h>
 
 #include "kvm_mm.h"
 
@@ -107,6 +108,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
 }
 
+static struct folio *kvm_gmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
+{
+	return __filemap_get_folio(inode->i_mapping, pgoff,
+				   FGP_LOCK | FGP_ACCESSED, 0);
+}
+
 /*
  * Returns a locked folio on success.  The caller is responsible for
  * setting the up-to-date flag before the memory is mapped into the guest.
@@ -126,8 +133,7 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	 * Fast-path: See if folio is already present in mapping to avoid
 	 * policy_lookup.
 	 */
-	folio = __filemap_get_folio(inode->i_mapping, index,
-				    FGP_LOCK | FGP_ACCESSED, 0);
+	folio = kvm_gmem_get_folio_noalloc(inode, index);
 	if (!IS_ERR(folio))
 		return folio;
 
@@ -457,12 +463,86 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_USERFAULTFD
+static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+
+	/*
+	 * Only support userfaultfd for guest_memfd with INIT_SHARED flag.
+	 * This ensures the memory can be mapped to userspace.
+	 */
+	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
+		return false;
+
+	return true;
+}
+
+static struct folio *kvm_gmem_folio_alloc(struct vm_area_struct *vma,
+					  unsigned long addr)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	pgoff_t pgoff = linear_page_index(vma, addr);
+	struct mempolicy *mpol;
+	struct folio *folio;
+	gfp_t gfp;
+
+	if (unlikely(pgoff >= (i_size_read(inode) >> PAGE_SHIFT)))
+		return NULL;
+
+	gfp = mapping_gfp_mask(inode->i_mapping);
+	mpol = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
+	mpol = mpol ?: get_task_policy(current);
+	folio = filemap_alloc_folio(gfp, 0, mpol);
+	mpol_cond_put(mpol);
+
+	return folio;
+}
+
+static int kvm_gmem_filemap_add(struct folio *folio,
+				struct vm_area_struct *vma,
+				unsigned long addr)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t pgoff = linear_page_index(vma, addr);
+	int err;
+
+	__folio_set_locked(folio);
+	err = filemap_add_folio(mapping, folio, pgoff, GFP_KERNEL);
+	if (err) {
+		folio_unlock(folio);
+		return err;
+	}
+
+	return 0;
+}
+
+static void kvm_gmem_filemap_remove(struct folio *folio,
+				    struct vm_area_struct *vma)
+{
+	filemap_remove_folio(folio);
+	folio_unlock(folio);
+}
+
+static const struct vm_uffd_ops kvm_gmem_uffd_ops = {
+	.can_userfault     = kvm_gmem_can_userfault,
+	.get_folio_noalloc = kvm_gmem_get_folio_noalloc,
+	.alloc_folio       = kvm_gmem_folio_alloc,
+	.filemap_add       = kvm_gmem_filemap_add,
+	.filemap_remove    = kvm_gmem_filemap_remove,
+};
+#endif /* CONFIG_USERFAULTFD */
+
 static const struct vm_operations_struct kvm_gmem_vm_ops = {
 	.fault		= kvm_gmem_fault_user_mapping,
 #ifdef CONFIG_NUMA
 	.get_policy	= kvm_gmem_get_policy,
 	.set_policy	= kvm_gmem_set_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.uffd_ops	= &kvm_gmem_uffd_ops,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
-- 
2.53.0

