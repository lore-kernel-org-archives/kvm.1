Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EEA4E5350
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970674; cv=none; b=Ca/AboDAWIYuu5HEfN+zID8ebmYG93tGUY8VQWLUh8Jy2kq2LYsvgD4D5oxlh1dOg01tDehja82HAChbwaY7160lmPVlDF9J/QRzz/k0oXIILpmtelY+kjueeUbCmcCkiXNhFeh/hzWkp+rophiST4QjdXGH8jpNns/nn10Mi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970674; c=relaxed/simple;
	bh=97Y5P82kkTYG0wInjB3HpyVWIKLSycXtjBmQDZjYXmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBq7Ce4jh7XUG4MURTW7ttJ9JRofik8bajzbfQa6/+6A+B4N6m4VKKv1v0HnUWQowrpHfmcEWfUQJcmiWa4uz47hjo6cU0JZJp0TLVW4jllEMqFn1bPwra4kxvktqLgy70q8vwf0CWtEnIPmkvC0+ZzrzRwouQBwMJ2S4XhyAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip92MAHL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip92MAHL"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dc202a60eso1398510f8f.3
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791970665; x=1792575465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2vqgPBzudi7/wozeWO4xZg2nwY2bakbLYAqbfosODE=;
        b=Ip92MAHLc2PNziOJrvfM/qDAgnps3y+irY0vQLtHNAER0cSfRtGbpXi+ao1YIg9f8N
         Uvod9og5I/Pi5u5F/NhoXBkcuG1CyfP38E5/8ZFfhZZaRz1BmA6zi212nQ6rFKZY+Vxr
         +5nTEOVggc/z/qcfZp/Mb23E+HJr82xwKf9jRKsKqx08Z4qoy+TOaXFIQaJGUew40535
         IP8MUcQOfY3t80tLc5kWoNlmlgfFBI5GfYdcOkUZbw5vyTc0zs6Y+rLkRoKjtZDlCQDc
         uX740hfuqojVs7O5+i/5ddRewvSRo1Am9lEma1JpUUgRnhCDcVBheSCy8+sCnYBzy2Ty
         BqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970665; x=1792575465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2vqgPBzudi7/wozeWO4xZg2nwY2bakbLYAqbfosODE=;
        b=OBkB3tHrsEHaCx6ouZRq3H3e87rt6NxWLzdtHpu6j1YqW54k/Sm6cvsiMx0B+NtKNk
         kY1lDi2HAEI2wytSn24+//Iys5+7KoOsXuUzbUC+SZ10NT9TmiO4LzvjV9EfIwkaU+kh
         VqpsM+AVnkmzbI7GBuqtQX00NE5/D6IgA5igytkHZzcrN9fle/EQXuVa3Z0pSDkXPR21
         M9jYSXCp8bGKvIQnWDjHcckrZsbrhs2bqhSgvCYiRKQ00pTGT+lsyHpwzXRVcDFvN1hJ
         ao9Gxw/dD8zUEx4r9gYbbQS9vvQ8hjHWVBqUK3UCLW7zt0iZIklMdRqRHuIwFJD2Bieh
         aNiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcCffFkMl470DtdfiWl7R6rvXyg3wtUTpCRot3btuA/zbtuIzKZnIpbXlGNhujqM5Oi44=@vger.kernel.org
X-Gm-Message-State: AFq9FYIF5TFAuqL+KPo5prfXNNuAt1RUsRtL5Sc62Wr6X5Sf9rvHedWa
	5hhmomZVAbYrcFwn6Rw0kWSTHTyw5EU8IBLlzN38L0zkGk91mBkxLjHC
X-Gm-Gg: AYBFou3S+clJxekKgu5a2vRgiV0PyoDxqcoER+ZBn4vqc49P1E0mB6Bgix/M9EhPR04
	UtRcsvj49Lf7N+MgaC/m1l/xqrxcywuV2vAbVdrWOm2JqogXsHtrBxQult2IEs1DabcDbH2Ws1A
	6WuBbT3WtJPV4itNSCFJZKlcr84MDVZN2gGARgCf+K2txXuQprssn0Rf6EuboUuf+1FRcxTE1gv
	kRX/E3DMmOhGYbqgPCIYAOTOy+cC1GjbY23XR/GPY781EfoT/81vroBMhPQQwyrGESN6lLTqRt/
	UIUQEIz85p6BKOLUWLCBTkmwaNLV+p83ybwBrw5msRHLdZEBjE8QUmE2k7AABTwJeOeUxGrDszO
	WdnKRO9wKcZh7zlB9LqP9v2QZ4eYlr4i/pQmDZx6mccPfd6BLqEOrg8b5nLhsCih8jvE6gCyT4y
	iqW4oYmO1e04xH0P/NiSfHPCBKqYXAqvXFL/v8hWjFk9x2KhmjcER9ClsLCtdx17sfXO/xWaTyD
	xF988YMh/TzhpZNhJ1STB2Wm+P5DLPaU8w92gT3m3A99Re+FgrOk5hODsXhP7Vk7eFtQeb6PelR
	p1doyqnK4tw3vGdFSknF2XC8K6qdjqplGBw=
X-Received: by 2002:a5d:588c:0:b0:48b:5083:96ae with SMTP id ffacd0b85a97d-48ddff64e46mr11244091f8f.15.1791970664941;
        Wed, 14 Oct 2026 02:37:44 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm9365477f8f.35.2026.10.14.02.37.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:37:44 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH v2 07/11] iommufd: Use large IOMMU pages for provider mappings
Date: Wed, 14 Oct 2026 09:37:29 +0000
Message-ID: <20261014093733.90312-8-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014093733.90312-1-griffoul@gmail.com>
References: <20261014093733.90312-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

Provider pages are mapped with one PAGE_SIZE entry each. A device that
uses a large provider block then misses in the IOTLB on every page, and
the IOMMU needs more page table memory than the block requires. A
revoke also flushes the IOTLB once per run of pages it unmaps.

Map each block that the provider reports with large IOMMU pages where
the IOVA and the frames are aligned alike, and with smaller ones where
they are not. Only the pages of the block are mapped, as before.

A large IOMMU page can only be unmapped whole, so a revoke that cuts
one widens its range to the whole page. It maps back what the provider
backs now, and a device may also fault on the rest of that page while
it is remapped. The widening finds the page with iova_to_phys():
pages that only look like one large page make the revoke remap more
than it must, which is harmless.

iommu_unmap() may not split the range of one map call either, and
virtio-iommu refuses to. Map each IOMMU page with its own call: the
widened range ends on IOMMU page boundaries, so it also ends on map
call boundaries.

A revoke now batches its unmaps with iommu_unmap_fast() and flushes the
IOTLB once.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/iommu/iommufd/pages.c | 114 +++++++++++++++++++++++++++++-----
 include/uapi/linux/iommufd.h  |  11 +++-
 2 files changed, 105 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index aa7740326ad6..4b284dae26fe 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -241,11 +241,17 @@ static void iommu_unmap_nofail(struct iommu_domain *domain, unsigned long iova,
 }
 
 /*
- * Provider pages are mapped with PAGE_SIZE entries, and may have holes.  Some
- * IOMMU drivers warn when asked to unmap an IOVA that is not mapped, so find
- * the runs that are mapped and unmap each one, without touching the holes.
- * iopt_provider_map() refuses frame 0, which iova_to_phys() reports for
- * an IOVA that is not mapped.
+ * Provider pages may have holes.  Some IOMMU drivers warn when asked to unmap
+ * an IOVA that is not mapped, so find the runs that are mapped and unmap each
+ * one, without touching the holes, and flush the IOTLB once at the end.
+ * iopt_provider_map() refuses frame 0, which iova_to_phys() reports for an
+ * IOVA that is not mapped.
+ *
+ * A run may hold large entries, which can only be unmapped whole: neither end
+ * of the range may fall inside one.  iopt_provider_map() maps each entry with
+ * its own call, so an end that is not inside an entry does not split a map
+ * call either, which iommu_unmap() does not allow.  The ends of the area are
+ * safe, and iopt_provider_revoke() widens its range to the entries it cuts.
  */
 static void iopt_provider_unmap(struct iopt_area *area,
 				struct iommu_domain *domain,
@@ -254,19 +260,23 @@ static void iopt_provider_unmap(struct iopt_area *area,
 {
 	unsigned long iova = iopt_area_index_to_iova(area, start_index);
 	size_t left = (last_index - start_index + 1) * PAGE_SIZE;
+	struct iommu_iotlb_gather gather;
 
+	iommu_iotlb_gather_init(&gather);
 	while (left) {
 		size_t len = 0;
 
 		while (len < left && iommu_iova_to_phys(domain, iova + len))
 			len += PAGE_SIZE;
 		if (len)
-			iommu_unmap_nofail(domain, iova, len);
+			WARN_ON(iommu_unmap_fast(domain, iova, len, &gather) !=
+				len);
 		/* Step over the run and the hole page that ended it. */
 		len = min(len + PAGE_SIZE, left);
 		iova += len;
 		left -= len;
 	}
+	iommu_iotlb_sync(domain, &gather);
 }
 
 static void iopt_area_unmap_domain_range(struct iopt_area *area,
@@ -1700,11 +1710,30 @@ static int iopt_provider_prot(struct iopt_area *area, u32 attrs)
 	return prot;
 }
 
+/*
+ * The size of the entry that maps @len bytes at @iova to @paddr, the largest
+ * that iopt_provider_entry() looks for and that fits.  Mapping each entry with
+ * its own call keeps the revoke from splitting a map call.
+ */
+static size_t iopt_provider_entry_size(struct iommu_domain *domain,
+				       unsigned long iova, phys_addr_t paddr,
+				       size_t len)
+{
+	unsigned long sizes = domain->pgsize_bitmap &
+			      GENMASK(PUD_SHIFT, PAGE_SHIFT + 1);
+	u64 align = iova | paddr;
+
+	sizes &= GENMASK(__fls(len), 0);
+	if (align)
+		sizes &= GENMASK_ULL(__ffs64(align), 0);
+	return sizes ? BIT(__fls(sizes)) : PAGE_SIZE;
+}
+
 /*
  * Map what the provider backs in [start_index, last_index] of the area into
- * @domain, and leave the holes unmapped.  Each frame is mapped with a
- * PAGE_SIZE entry, so that a revoke of part of a large block never has to
- * split a larger IOMMU page.  On failure nothing in the range is mapped.
+ * @domain, and leave the holes unmapped.  Each block that the provider reports
+ * is mapped with the largest entries that the IOVA and the frames allow, one
+ * call per entry.  On failure nothing in the range is mapped.
  */
 static int iopt_provider_map(struct iopt_area *area, struct iopt_pages *pages,
 			     struct iommu_domain *domain,
@@ -1729,7 +1758,8 @@ static int iopt_provider_map(struct iopt_area *area, struct iopt_pages *pages,
 		return -EOPNOTSUPP;
 
 	while (index <= last_index) {
-		unsigned long pfn, iova, block_end, nr, i;
+		unsigned long pfn, iova, block_end, nr;
+		size_t len, done, size;
 		int order = PUD_ORDER;
 		u32 attrs;
 		int prot;
@@ -1752,20 +1782,25 @@ static int iopt_provider_map(struct iopt_area *area, struct iopt_pages *pages,
 		iova = iopt_area_index_to_iova(area, index);
 		prot = iopt_provider_prot(area, attrs);
 
-		for (i = 0; i < nr; i++) {
-			rc = iommu_map_nosync(domain, iova + i * PAGE_SIZE,
-					      PFN_PHYS(pfn + i), PAGE_SIZE, prot,
+		len = nr * PAGE_SIZE;
+		for (done = 0; done < len; done += size) {
+			size = iopt_provider_entry_size(domain, iova + done,
+							PFN_PHYS(pfn) + done,
+							len - done);
+			/* On failure, iommu_map_nosync() unmaps what it mapped. */
+			rc = iommu_map_nosync(domain, iova + done,
+					      PFN_PHYS(pfn) + done, size, prot,
 					      GFP_KERNEL_ACCOUNT);
 			if (rc)
 				break;
 		}
-		if (i) {
-			int sync_rc = iommu_sync_map(domain, iova, i * PAGE_SIZE);
+		index += done >> PAGE_SHIFT;
+		if (done) {
+			int sync_rc = iommu_sync_map(domain, iova, done);
 
 			if (!rc)
 				rc = sync_rc;
 		}
-		index += i;
 		if (rc)
 			goto err_unmap;
 	}
@@ -1804,9 +1839,51 @@ static int iopt_provider_fill_domains(struct iopt_area *area,
 	return rc;
 }
 
+/*
+ * Find the large entry that may hold page @index, which iopt_provider_unmap()
+ * can only remove whole, and return its first and last index.  An entry of a
+ * given size is aligned to it, lies inside the area, and maps its pages
+ * linearly, so look for the largest such block around @index.  Mapped pages
+ * that only look like one entry make the revoke remap more than it must, which
+ * is harmless.
+ */
+static void iopt_provider_entry(struct iopt_area *area,
+				struct iommu_domain *domain,
+				unsigned long index, unsigned long *first,
+				unsigned long *last)
+{
+	unsigned long iova = iopt_area_index_to_iova(area, index);
+	/* iopt_provider_map() maps at most a PUD-sized block at once. */
+	unsigned long sizes = domain->pgsize_bitmap &
+			      GENMASK(PUD_SHIFT, PAGE_SHIFT + 1);
+	phys_addr_t phys = iommu_iova_to_phys(domain, iova);
+
+	*first = *last = index;
+	if (!phys)
+		return;
+
+	while (sizes) {
+		unsigned long size = BIT(__fls(sizes));
+		unsigned long start = ALIGN_DOWN(iova, size);
+		unsigned long end = start + size - PAGE_SIZE;
+
+		sizes &= ~size;
+		if (start < iopt_area_iova(area) ||
+		    end + PAGE_SIZE - 1 > iopt_area_last_iova(area))
+			continue;
+		if (iommu_iova_to_phys(domain, start) != phys - (iova - start) ||
+		    iommu_iova_to_phys(domain, end) != phys + (end - iova))
+			continue;
+		*first = iopt_area_iova_to_index(area, start);
+		*last = iopt_area_iova_to_index(area, end);
+		return;
+	}
+}
+
 /*
  * The provider changed the frames behind [offset, offset + len).  In every
- * domain, unmap the range and map what the provider backs now.  A device that
+ * domain, unmap the range and map what the provider backs now.  A large entry
+ * that the range cuts is unmapped and mapped again whole.  A device that
  * accesses the range in between faults.
  */
 static void iopt_provider_revoke(struct mem_provider_attachment *att,
@@ -1836,9 +1913,12 @@ static void iopt_provider_revoke(struct mem_provider_attachment *att,
 		struct iopt_area *area = track->area;
 		unsigned long s = max(first, iopt_area_index(area));
 		unsigned long l = min(last, iopt_area_last_index(area));
+		unsigned long unused;
 
 		if (s > l)
 			continue;
+		iopt_provider_entry(area, track->domain, s, &s, &unused);
+		iopt_provider_entry(area, track->domain, l, &unused, &l);
 		iopt_provider_unmap(area, track->domain, s, l);
 		rc = iopt_provider_map(area, pages, track->domain, s, l);
 		if (rc)
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index b4500fc21368..04ca2a244267 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -241,9 +241,14 @@ struct iommu_ioas_map {
  * behind any range at any time, and the mapping follows: pages that the
  * provider does not back are left unmapped, read-only pages are mapped
  * without write permission, and device memory is mapped as MMIO. A device
- * access to a page that is being changed, or that is not backed, faults. Such
- * a mapping cannot be split by a partial unmap, and in-kernel accesses to it
- * are refused. It is not supported in an IOAS with a dirty tracking domain.
+ * access to a page that is being changed, or that is not backed, faults.
+ * Large IOMMU pages are used where @iova and the provider's memory are aligned
+ * alike; a change to part of a large page remaps all of it, so a device may
+ * also fault on the rest of it while that happens. If the remap after a change
+ * fails, the range stays unmapped; userspace recovers by unmapping the file
+ * and mapping it again. Such a mapping cannot be split by a partial unmap, and
+ * in-kernel accesses to it are refused. It is not supported in an IOAS with a
+ * dirty tracking domain.
  */
 struct iommu_ioas_map_file {
 	__u32 size;
-- 
2.47.3

