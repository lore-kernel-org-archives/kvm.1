Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505481;
	b=st+E70WqAXfQ7Sw4CpVhqZgJdv5EwMiA2hK8ugtaQuKa2ORC2uh0m0TYcrYWkeLzY1oD
	 o2pswUVkHcY9i5ISdGDsLh0hOz+yjrvGt6thGkWvSMP7ibPZlz08ngxe7z6N/GTotL/gw
	 u28RJSFDgUXQ2mfQGwcLhjVOjdihj9ShCrl4h8VmEwJpzo1cW6vVtCEuX1dCCDUtqVqQS
	 Yn5l3Mrr/ItqfXH6rbeAXNpPu/fNruCnGM5attzKkg3vIQGjqygaiTBbURyVpRQcWVsE1
	 h+2+XOKrM6zBHTB6wWt2eBs6kdGsRPvyXWlgFMBiASO04KUsGmbTno1ZnpzIM9S4gAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505481;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KzNlvZBJxxiRpC131MPYRoXwXZNh90geY9cwgFYizRU=;
	b=Pc8fuFTVFHBisB8CILKcYbXiXR1Zrj8jMYHPsO99YSfXL3pOEZ2UxHrd9MKFCVkU2Lb/
	 m2P2PkjeWj19W7iPwj5KwPoNq2yki84oH6xhD7ee4GqiE1tUiP87NH0GQPQMNkuRedRyd
	 5aZ/oY+o010Nkoldb8uJLX5dzwJEmABbrPwaCgZjyfv5D4WLBB5kP/5sjM0bsnXhGlBef
	 eDT9C78CjOB1xWRvKvivrtxi5tROv+WUyhHUV999vMDSipdTH59B2X3Qve0SivOZBWrbX
	 kXJNShmMkLXNNUgEqG6PTJPWqJpQyz0LNW4LI7+REvxfLl7RDaFaI7gGhcURbJs/SZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wZXBNO6M;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3541606A32C;
	Tue, 24 Nov 2026 07:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3541606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wZXBNO6M
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795505468; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KzNlvZBJxxiRpC131MPYRoXwXZNh90geY9cwgFYizRU=;
	b=wZXBNO6MPaw+Ve/Ya52CMG9XpIRqq1CW1Ym1KV3UhnK09BUWVCc3cTZB9N8iNvpXhk0FObYBA+xozXFUVeUqZC8HrQ+nIdsL0k3izgkReOzJPh7JwRZDtxttNMIMiBDhzz1+2y2E8xtb3aCJm7l0NrPZnUYE6DmN0tQJ7L1MY7k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XFNkX22_1795505468;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XFNkX22_1795505468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 15:31:08 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: alex@shazbot.org,
	dakr@kernel.org,
	xinmengs@nvidia.com,
	fengchengwen@huawei.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	mattev@meta.com,
	alifm@linux.ibm.com,
	ankita@nvidia.com,
	ritesh.list@gmail.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vfio/pci: Align BAR mappings for huge page support
Date: Tue, 24 Nov 2026 15:30:48 +0800
Message-ID: <20261124073048.268988-3-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_pci_mmap_huge_fault() is already wired up as the huge_fault handler
for BAR mappings and can install PMD or PUD sized pfnmaps when
CONFIG_TRANSPARENT_HUGEPAGE is enabled.  Whether it ever gets to do so
depends on the address the BAR VMA ended up at: is_aligned_for_order()
requires both the fault address and the pfn to be aligned to the huge
page size, and the generic mm_get_unmapped_area() only guarantees
PAGE_SIZE alignment.  When the address is unaligned the check fails,
huge_fault() returns VM_FAULT_FALLBACK without having inserted anything,
and the region silently degrades to one PAGE_SIZE fault per page.

A PCI BAR is required by the PCI bus specification to occupy a naturally
aligned, power of two sized region of physical address space, so the pfn
side of the check is already satisfied for any BAR that is at least 2MB
in size.  What is missing is the virtual address side, and that is only
fixable before the VMA is created.

QEMU already works around this in userspace: it reserves an oversized
anonymous region, rounds its address up to an alignment of
MIN(pow2ceil(region->size), 1GiB), unmaps the slack at both ends and
remaps every sparse subregion with MAP_FIXED at the aligned address, see
QEMU commits 00b519c0bc ("vfio/helpers: Align mmaps") and 3863e47828
("hw/vfio: align mmap to power-of-2 of region size for hugepfnmap").
Other consumers do not.  DPDK, custom VMMs, test tools and QEMU releases
predating that change typically call mmap(fd, offset) with addr=0 and
leave the address selection to the kernel, so they are the ones that
silently lose the huge mapping on a large BAR.  Providing the alignment
in the kernel is defence in depth as well: the kernel should not quietly
give up on a huge mapping it is able to provide just because today's
userspace happens to compensate for its absence.

Implement vfio_pci_core_get_unmapped_area() on top of the new
vfio_device_ops callback, modelled after dax_get_unmapped_area() in
drivers/dax/device.c.  It derives the largest usable page size from the
BAR length, capped at PUD_SIZE and at PMD_SIZE when the architecture
lacks CONFIG_ARCH_SUPPORTS_PUD_PFNMAP, asks for an area with enough
slack to shift the mapping up to the next aligned address, and applies
that shift.  Shifting the address preserves the offset of the mapping
within the BAR, so aligning the address also aligns the pfn.

Everything this cannot improve keeps the current behaviour.  A non-zero
address returns early, which makes the change transparent for userspace
such as QEMU that aligns the mapping itself: MAP_FIXED never reaches the
hook at all, and an explicit hint without MAP_FIXED is honoured as is.
Regions that are not mmap'able BARs, BARs smaller than PMD_SIZE, and
mappings too short to span one fully aligned huge page all take the same
fallback path.

Also set VM_HUGEPAGE on the BAR VMA.  The THP sysfs policy does not need
it, since huge pfnmaps are uncompactable and so
vma_file_bypass_thp_tuneables() ignores the tuneables for a PFNMAP VMA
that has a huge_fault handler.
thp_vma_allowable_order() is still consulted before create_huge_pmd() and
create_huge_pud() are reached, though, and it calls vma_thp_disabled(),
which reports the VMA as disabled once the process has called
prctl(PR_SET_THP_DISABLE, PR_THP_DISABLE_EXCEPT_ADVISED) unless
VM_HUGEPAGE is set.  Marking the VMA keeps the huge mapping available for
such a process instead of leaving it at the mercy of that single bypass,
and makes the intent explicit regardless of how the process or the
administrator configured THP.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/vfio/pci/vfio_pci.c      |  3 +
 drivers/vfio/pci/vfio_pci_core.c | 95 ++++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  8 +++
 3 files changed, 106 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e7c012febe91..2757ff9075d2 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -158,6 +158,9 @@ static const struct vfio_device_ops vfio_pci_ops = {
 	.read		= vfio_pci_core_read,
 	.write		= vfio_pci_core_write,
 	.mmap		= vfio_pci_core_mmap,
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+	.get_unmapped_area = vfio_pci_core_get_unmapped_area,
+#endif
 	.request	= vfio_pci_core_request,
 	.match		= vfio_pci_core_match,
 	.match_token_uuid = vfio_pci_core_match_token_uuid,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..0f465cddd9f5 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1874,12 +1874,107 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	 */
 	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
 			VM_DONTEXPAND | VM_DONTDUMP);
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+	vm_flags_set(vma, VM_HUGEPAGE);
+#endif
 	vma->vm_ops = &vfio_pci_mmap_ops;
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_mmap);
 
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+/*
+ * Return an mmap() address for a BAR that is aligned to the largest page
+ * size the BAR can be faulted in with, so that vfio_pci_mmap_huge_fault()
+ * can install PMD or PUD sized pfnmaps rather than silently falling back to
+ * PAGE_SIZE mappings.
+ *
+ * Both ends have to play together for a huge pfnmap: the address of the
+ * mapping has to be aligned such that the whole huge page fits within the
+ * VMA (see is_aligned_for_order() and insert_pmd()), and the pfn has to be
+ * aligned to the huge page size.  The latter is a property of the BAR
+ * itself, the former is what we can influence here.  The offset of the
+ * mapping within the file is preserved relative to the returned address,
+ * therefore aligning the address also aligns the pfn as long as the mapping
+ * starts at a BAR offset that is itself aligned, which is the common case.
+ *
+ * Anything we can't handle, including a user provided address hint and
+ * regions that are not mmap'able BARs, falls back to the generic address
+ * selection.
+ */
+unsigned long vfio_pci_core_get_unmapped_area(struct vfio_device *core_vdev,
+					      struct file *filp,
+					      unsigned long addr,
+					      unsigned long len,
+					      unsigned long pgoff,
+					      unsigned long flags)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	struct pci_dev *pdev = vdev->pdev;
+	unsigned long align, off, off_end, off_align, len_align, addr_align;
+	unsigned int index;
+	u64 bar_len;
+
+	/* The user asked for a specific address, don't second guess it */
+	if (addr)
+		goto out;
+
+	index = pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
+	if (index >= VFIO_PCI_ROM_REGION_INDEX || !vdev->bar_mmap_supported[index])
+		goto out;
+
+	bar_len = pci_resource_len(pdev, index);
+	if (!bar_len)
+		goto out;
+
+	/* The BAR size caps the page size we can map it with */
+	align = min_t(unsigned long, PUD_SIZE,
+		      rounddown_pow_of_two((unsigned long)bar_len));
+	if (align < PMD_SIZE)
+		goto out;
+	if (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && align > PMD_SIZE)
+		align = PMD_SIZE;
+
+	/* Only an alignment that fits within the mapping length is useful */
+	while (align > PMD_SIZE && len < align)
+		align >>= 1;
+	if (align < PMD_SIZE)
+		goto out;
+
+	off = pgoff << PAGE_SHIFT;
+	off_end = off + len;
+	if (off_end < off)
+		goto out;
+	off_align = round_up(off, align);
+
+	/* The mapping has to span at least one fully aligned huge page */
+	if (off_end <= off_align || off_end - off_align < align)
+		goto out;
+
+	len_align = len + align;
+	if (len_align < len)
+		goto out;
+
+	/*
+	 * Find an area that can hold the mapping plus the slack needed to
+	 * shift it up to the next aligned address, then apply that shift.
+	 * The shift preserves the relative alignment of the file offset,
+	 * which is what makes the pfn alignment work out.
+	 */
+	addr_align = mm_get_unmapped_area(filp, addr, len_align, pgoff, flags);
+	if (!IS_ERR_VALUE(addr_align)) {
+		addr_align += (off - addr_align) & (align - 1);
+		return addr_align;
+	}
+
+out:
+	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_get_unmapped_area);
+#endif
+
 void vfio_pci_core_request(struct vfio_device *core_vdev, unsigned int count)
 {
 	struct vfio_pci_core_device *vdev =
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2f3fa2787737..98350c87d2ea 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -187,6 +187,14 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 				   struct vm_fault *vmf, unsigned long pfn,
 				   unsigned int order);
 int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma);
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+unsigned long vfio_pci_core_get_unmapped_area(struct vfio_device *core_vdev,
+					      struct file *filp,
+					      unsigned long addr,
+					      unsigned long len,
+					      unsigned long pgoff,
+					      unsigned long flags);
+#endif
 void vfio_pci_core_request(struct vfio_device *core_vdev, unsigned int count);
 int vfio_pci_core_match(struct vfio_device *core_vdev, char *buf);
 int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
-- 
2.43.7

