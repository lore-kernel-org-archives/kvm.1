Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524040;
	b=COCpW2k92Z9QdkttjSD/C9i9gTyDjS7Ctt9DcR2QD7IVXruSe3VttSN3UqAMX92IkRWj
	 xCifNmh8NFFpj53dKp91M30Ym4D67EldOFkjv50V1XidZSZNZr/Gf/MzXSnum/UMhKIju
	 G/lqyJmkS7uNbg0a4nArLqM3M2rSfEMmVVOd3zCnjA7pt4XNhNt9GAElv9AFWRVRNK99c
	 UPBliCHnKLkA0upIuXWn/JG7MXHrEbsi2oHpHCg5hVIPSKxRd+yJGhh66EKDWsxfnxylI
	 px6SS/x5s8FH2M/ETGrQySMpFuv+VMYqJWGPwqTYFBK69aPluDt/oNPP+JI9Sz2tcqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524040;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bYt6nDZcrUOPPKenRBXzBQFQ4YbrvnkuK95SE/EcFmA=;
	b=e//Zi2lUR24Qzp22pMtz97s6eH6HUmBUF6HfWlEv/XS71m0X+Sawsumpvvp71rIWAxKi
	 H8fG7Z+svy84u9t20dZtOHQCH3ezxwCitwfbuUlIPGQT5cA8/wpmymlqF6TDvHisJpaf3
	 cJQZ7wmy/htiYPe+9svY1NYnKqaQ40JyXQ+xxeKY1gaZ++jG3z8wkNvIl1IxPS+9dHaH8
	 08v8B5yYZggNQgUxyygrl7SRrUF/yVffrWz2ivdqhuMr/54PvyHmOYXMIXPkNRKvp4n+v
	 lpM7JLB1RInf6QWg9sXuUG4M4XDJA/BrQA4S+SH6IqjfzIGBZdMewcetLCkS7Vd0g+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="g7Nmw7T/";
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644E606A326;
	Tue, 24 Nov 2026 12:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1644E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=g7Nmw7T/
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795524028; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bYt6nDZcrUOPPKenRBXzBQFQ4YbrvnkuK95SE/EcFmA=;
	b=g7Nmw7T/p+On0LVo5jg3P19zW/KXc+zwzv/ba689xPFuAY8unCGDqnqdlyvriA0P8rW0Fd32HVbBpEMa8Iu0ZNPG20J9WKn62owI82X8oA5zxm+P5Eg5/v3QMJAie+iAgHQ12YgFos7Rw26yomZsUohPf7I0txKvAilyNDLURKY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XFOSkgI_1795524004;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XFOSkgI_1795524004 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 20:40:27 +0800
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
Subject: [PATCH v2 0/2] vfio/pci: Provide kernel-side BAR alignment for huge page mapping
Date: Tue, 24 Nov 2026 20:40:02 +0800
Message-ID: <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
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

---
v2:
 - Add MAP_FIXED/MAP_FIXED_NOREPLACE check to avoid interfering with
   fixed-address mappings (Sashiko AI review)
 - Simplify align selection to only PMD_SIZE or PUD_SIZE, eliminating
   intermediate power-of-2 values that cannot be installed by
   vfio_pci_vmf_insert_pfn() and could cause alignment failure for
   sparse BAR regions (Sashiko AI review)
 - Remove unreachable dead code (second align < PMD_SIZE check)

v1: https://lore.kernel.org/all/20261124073048.268988-1-guanghuifeng@linux.alibaba.com/

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

