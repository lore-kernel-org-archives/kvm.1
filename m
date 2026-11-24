Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505479;
	b=PvMf5/5fO6sOB/uk9XoHT/C2hfXmA2wtJs16UEIkDHJcwat1p7BK7NSQQDZzx3k2AsAh
	 Re7hgUzFGwNpp8G4gyHQzWfY9ADXrjHgv+zJPyCnV0dLbzPFyo5BG93tym5Y/9YC/+XaZ
	 xileKCJ6T1L43RzwGgmMz1j+EIB/nRgmpCABZ6MvKgO1+u+kTJpNgr5GpiasZZ+l46Pfk
	 3JuMvlgcLKgwA1JiZlqzWcZzgwOWYmy1Jo0t7WSvSneOqgBLURCZxy9HiufeN/0iPCGub
	 uiR8ZHLVr01rtMIzoAuOjFdxVglizDB08D02Gj6CWeSA1XPACP6xhljTRfhHhi3NDng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505479;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sbTOHDIReIXESpsLUzFuruA4nd6V61Nk0jm2vqTH+u4=;
	b=Fi+4QZ7DKAt4EeVLhOOXCIIsZCmmAycp4d231Hp4mLoQr86ywQqBGT2pJTRRk1xjdzDl
	 iziOx52JORxkNXVY3IZ4NZRUth3zrhjtbjdKKee/T6daGjF+6m4dPCHcovsvu+wcDMj8c
	 YCpct6I/flCarxYf9lin2ydUmBsiYLntRqKNKboIvOy9dTHGZSCZeFFNKpzk5QHX5OniV
	 1WKMYNvXw9WznS+QbhqTkbhL9LLChZAAnZsB6ZF0OsLwSzx7UZpqhZ/JGrwzzQmQsauav
	 M/nYTbQ2PVIcuighMFOrmo1F6Nzaa2iiLxTgY5i6K1W222MN2oOIgXrchvwEYm35J7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LTnP6ro4;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A40606A31E;
	Tue, 24 Nov 2026 07:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A40606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LTnP6ro4
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795505467; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sbTOHDIReIXESpsLUzFuruA4nd6V61Nk0jm2vqTH+u4=;
	b=LTnP6ro4+u1ZAoB27W/XrA9E0eb/aE1mjatICa/JN8ZyAGqBXi8NZtuITSnQwqqIepFEWFe2CztO9tlp/hJoEFWltm0YfBU6JNbmQMmgsMNq2sjnShTWRgVsvyrQEtU6h6uCENUPdQDbipmLWUrvnyuIRcbjA/U47g/RhdaGeFg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XFNkWxT_1795505448;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XFNkWxT_1795505448 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 15:31:07 +0800
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
Subject: [PATCH 0/2] vfio/pci: Provide kernel-side BAR alignment for huge page mapping
Date: Tue, 24 Nov 2026 15:30:46 +0800
Message-ID: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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

VFIO PCI BAR regions support PMD/PUD huge page mapping via
vfio_pci_mmap_huge_fault() since commit f9e54c3a2f5b ("vfio/pci:
implement huge_fault support").  The huge_fault path requires both the
VA and the PFN to be aligned to the huge page boundary, checked by
is_aligned_for_order().  When alignment fails, huge_fault silently
returns VM_FAULT_FALLBACK and the mapping degrades to 4KB pages.

QEMU already handles this by pre-allocating an aligned VA region and
using MAP_FIXED, see QEMU commits 00b519c0bc ("vfio/helpers: Align
mmaps") and 3863e47828 ("hw/vfio: align mmap to power-of-2 of region
size for hugepfnmap").  Other userspace consumers (DPDK, custom VMMs,
test tools, and QEMU releases predating that change) typically call
mmap(fd, offset) with addr=0, relying on the kernel to select a suitable
VA.  Without kernel-side alignment guidance, these consumers silently
get 4KB mappings for large BARs.

This series adds a .get_unmapped_area callback to the VFIO device
file_operations, modelled after drivers/dax/device.c, that provides
PMD/PUD-aligned VA selection for BAR mappings.  It also sets
VM_HUGEPAGE on BAR VMAs, which keeps the huge mapping available to a
process that called prctl(PR_SET_THP_DISABLE,
PR_THP_DISABLE_EXCEPT_ADVISED).

Note: CONFIG_TRANSPARENT_HUGEPAGE=y is required at compile time for the
huge pfnmap infrastructure.  The runtime THP sysfs policy (enabled=never)
does NOT block VFIO BAR huge pages -- vma_file_bypass_thp_tuneables()
already bypasses it for PFNMAP VMAs with a .huge_fault handler (commit
e384abeb559d).

Performance impact for a 256MB BAR, 4KB pages vs PMD huge pages:
  - Page faults:       65536 -> 128   (512x reduction)
  - Page table memory: ~516KB -> ~4KB (129x reduction)
  - TLB pressure:      65536 entries (exceeds STLB) -> 128 entries (fits)

Patch 1 adds the vfio_device_ops callback infrastructure.
Patch 2 implements the PCI BAR alignment logic and VM_HUGEPAGE.

Compiled with W=1, checkpatch --strict clean (0 errors, 0 warnings).
Each patch compiles independently (bisect-safe).

Guanghui Feng (2):
  vfio: Add get_unmapped_area callback to vfio_device_ops
  vfio/pci: Align BAR mappings for huge page support

 drivers/vfio/pci/vfio_pci.c      |  3 +
 drivers/vfio/pci/vfio_pci_core.c | 95 ++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_main.c         | 34 ++++++++++++
 include/linux/vfio.h             | 12 ++++
 include/linux/vfio_pci_core.h    |  8 +++
 5 files changed, 152 insertions(+)

-- 
2.43.7

