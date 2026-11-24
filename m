Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524039;
	b=KVOgea8N/pT6shMAYUjXsdcHF06wAa79m0QrRsmE1mk15xBv8E40YVqc9IS4ZXV8GuMK
	 Jt028FE3s6Kap+5y0OPznqGS510ovKi0I+R5PSqLP1EckK7eRkGPA5GSqrmXNldOKvNqO
	 JHCOTTo8sJ/1i2797Ilvmvwq9iIpb7Gwag9LX9EKTjwiMbF/r5+23nHGlgj/b6rER2x9v
	 d12ztXO6/FQABd9WSCtMHkDyXIAcsKbYV5lH0QqUnv2S80v4K1uf2Xxq5wOjW4fOz+/NA
	 kQeEAuiKnrxsTTDfahKSvUKZkbB92HPu5mvnKHtuOV5y0UFTmWI/MaO5lkFWHMHB6vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524039;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cpeGn+vip4Nk+6DYnVkKAZSr7bRqWaR1yDs4vpW4hCE=;
	b=M0LzrwH90DCDs2JgOdFiSjNzc0u7GNQyhzxK3Ir3GjDFfD49nCTE5xuf89IbX0Tp9bJX
	 e1yK/yFO0UVJZfEbccF8cyyNcwPZTeHJMOQVZJDtozRVdzpQsYABqHKKaDQJXPnupDfd5
	 r2Avv0T1aN3Iy1tVLbjFvr0HMYk7MAdnb8+EgEgIZAQo/2Z8fH7VcJSfPVflfn7PfQ4dV
	 5ytEIuPIrMwebYhOJr/or6ZzmByVpzAQoeusePtr9IA7M9NuosYgxV7StmHUezWJoL+g5
	 RVjXwqEDQLLHIFsLDt4p1B55hMZLxvXiaeu/4sd9F0S2Qq0qDjkN3L4d1DjVHirvxVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gpuI1LDR;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5450606A31E;
	Tue, 24 Nov 2026 12:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5450606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gpuI1LDR
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795524029; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cpeGn+vip4Nk+6DYnVkKAZSr7bRqWaR1yDs4vpW4hCE=;
	b=gpuI1LDR8T6Jc1N7kCvPf4X5moA26F9g4Poc7VvLA2UxR/rSwvfQeAdBfgfAEBjtDADvf+q+wKsihNEDgwOJTBgGHVCQ8ZnB2eF0ro3JCmLLXuLlu9exkMpZa96rBJ1HgmUnxTZ6W3R+hdKyHs3FMB+hel61ajJaehVhUDlOlgk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XFOSknE_1795524028;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XFOSknE_1795524028 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 20:40:28 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: guanghuifeng@linux.alibaba.com
Cc: alex@shazbot.org,
	alifm@linux.ibm.com,
	ankita@nvidia.com,
	dakr@kernel.org,
	fengchengwen@huawei.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mattev@meta.com,
	ritesh.list@gmail.com,
	xinmengs@nvidia.com
Subject: [PATCH v2 2/2] vfio/pci: Align BAR mappings for huge page support
Date: Tue, 24 Nov 2026 20:40:04 +0800
Message-ID: <20261124124004.457441-3-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
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
index fcbb2da860e2..0d116dc39f24 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -17,6 +17,7 @@
 #include <linux/file.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
+#include <linux/mman.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
@@ -1874,12 +1875,106 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
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
+	/* Don't interfere with explicit address requests or fixed mappings */
+	if (addr || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)))
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
+	/*
+	 * Select the largest huge page size that the BAR physical alignment,
+	 * mapping length, and arch support can all satisfy.  Only PMD and PUD
+	 * orders are supported by vfio_pci_vmf_insert_pfn().
+	 */
+	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) &&
+	    bar_len >= PUD_SIZE && len >= PUD_SIZE)
+		align = PUD_SIZE;
+	else if (bar_len >= PMD_SIZE && len >= PMD_SIZE)
+		align = PMD_SIZE;
+	else
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

