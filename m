Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3D3D4111;
	Mon,  9 Mar 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069559; cv=none; b=ZzQNwQaTjTnbUv3RXCTxI08r9IwfWi5P0lzyjJdWN+a3krRNa0wUX1IfhOsn0FqiLGyNLJGFWBIdztSgNWxxFDmkdzXzs6W5Sfuv2hQQEPPmz8Bl+dw2ryaxXObrPdve2iHL/gesUaHy+cZooBCiqufgf5oxF2HuWphmtlx8fT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069559; c=relaxed/simple;
	bh=xyQnOW2UDFd5jAArw1nWS6MsXbZdktoGFPRukmSWN9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCWjYrKIhGyyCsPy5q4tN5PxxDMY9HbMHVG40i/npisTOakFd3z4ExkMt3DenivmFRWAxXE4xijSDUXB23Wt2GFiUZ192TyU2pd7DFMKpQY1J2qu3IkeHz1cce+3NJgc9RUJbU0FH/XpOJr+oilNW9rBK9jYZ0hfCJAQTyMW6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyLp+xOG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyLp+xOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDCBC2BC86;
	Mon,  9 Mar 2026 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069559;
	bh=xyQnOW2UDFd5jAArw1nWS6MsXbZdktoGFPRukmSWN9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DyLp+xOG03I6mJo4gcMfc/+Ifnd6+9mr3SmRZReS3gUB59IJtxRzKYh6uCwGbf35n
	 mA09i4Y9TZaDcXjdoHWgA9psr/HHQ5Vmw9UjHOgORc2dtCFhdHH5c+CdCLVoerUQFA
	 zgKYCWWMophRIJapyS/x9VRx1zzA0Xl85X4CYI0S9IAgmoqmrYHrU3vnG/8QmmjRBI
	 /AYEcixMmT7fSlKbi01wP+sn/Qc3LMxUelwYIpPHcDiAOR1UoJYubJtfp78jUFZvi4
	 Jiu1hH7v7CekQmhFXZdscglWKrkGWSFQfoHbqKVI0WCvwVybBq7Bcl+7wsK7dsJ0kU
	 Eq70tr05k+ywA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 1/4] mm: move vma_kernel_pagesize() from hugetlb to mm.h
Date: Mon,  9 Mar 2026 16:18:58 +0100
Message-ID: <20260309151901.123947-2-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309151901.123947-1-david@kernel.org>
References: <20260309151901.123947-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the past, only hugetlb had special "vma_kernel_pagesize()"
requirements, so it provided its own implementation.

In commit 05ea88608d4e ("mm, hugetlbfs: introduce ->pagesize() to
vm_operations_struct") we generalized that approach by providing a
vm_ops->pagesize() callback to be used by device-dax.

Once device-dax started using that callback in commit c1d53b92b95c
("device-dax: implement ->pagesize() for smaps to report MMUPageSize")
it was missed that CONFIG_DEV_DAX does not depend on hugetlb support.

So building a kernel with CONFIG_DEV_DAX but without CONFIG_HUGETLBFS
would not pick up that value.

Fix it by moving vma_kernel_pagesize() to mm.h, providing only a single
implementation. While at it, improve the kerneldoc a bit.

Ideally, we'd move vma_mmu_pagesize() as well to the header. However,
its __weak symbol might be overwritten by a PPC variant in hugetlb code.
So let's leave it in there for now, as it really only matters for some
hugetlb oddities.

This was found by code inspection.

Fixes: c1d53b92b95c ("device-dax: implement ->pagesize() for smaps to report MMUPageSize")
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/hugetlb.h |  7 -------
 include/linux/mm.h      | 20 ++++++++++++++++++++
 mm/hugetlb.c            | 17 -----------------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65910437be1c..44c1848a2c21 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -777,8 +777,6 @@ static inline unsigned long huge_page_size(const struct hstate *h)
 	return (unsigned long)PAGE_SIZE << h->order;
 }
 
-extern unsigned long vma_kernel_pagesize(struct vm_area_struct *vma);
-
 extern unsigned long vma_mmu_pagesize(struct vm_area_struct *vma);
 
 static inline unsigned long huge_page_mask(struct hstate *h)
@@ -1177,11 +1175,6 @@ static inline unsigned long huge_page_mask(struct hstate *h)
 	return PAGE_MASK;
 }
 
-static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
-{
-	return PAGE_SIZE;
-}
-
 static inline unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 {
 	return PAGE_SIZE;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 44e04a42fe77..227809790f1a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1307,6 +1307,26 @@ static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
 	return is_shared_maywrite(&vma->flags);
 }
 
+/**
+ * vma_kernel_pagesize - Default page size granularity for this VMA.
+ * @vma: The user mapping.
+ *
+ * The kernel page size specifies in which granularity VMA modifications
+ * can be performed. Folios in this VMA will be aligned to, and at least
+ * the size of the number of bytes returned by this function.
+ *
+ * The default kernel page size is not affected by Transparent Huge Pages
+ * being in effect.
+ *
+ * Return: The default page size granularity for this VMA.
+ */
+static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
+{
+	if (unlikely(vma->vm_ops && vma->vm_ops->pagesize))
+		return vma->vm_ops->pagesize(vma);
+	return PAGE_SIZE;
+}
+
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1d41fa3dd43e..66eadfa9e958 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1017,23 +1017,6 @@ static pgoff_t vma_hugecache_offset(struct hstate *h,
 			(vma->vm_pgoff >> huge_page_order(h));
 }
 
-/**
- * vma_kernel_pagesize - Page size granularity for this VMA.
- * @vma: The user mapping.
- *
- * Folios in this VMA will be aligned to, and at least the size of the
- * number of bytes returned by this function.
- *
- * Return: The default size of the folios allocated when backing a VMA.
- */
-unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
-{
-	if (vma->vm_ops && vma->vm_ops->pagesize)
-		return vma->vm_ops->pagesize(vma);
-	return PAGE_SIZE;
-}
-EXPORT_SYMBOL_GPL(vma_kernel_pagesize);
-
 /*
  * Return the page size being used by the MMU to back a VMA. In the majority
  * of cases, the page size used by the kernel matches the MMU size. On
-- 
2.43.0

