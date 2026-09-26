Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A1369D47;
	Sat, 26 Sep 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440031; cv=none; b=K1ROIRqkuJceVI15UvBB7kT5A1dcJ7vJOQkmvzVKCQspljlwPI/vvopTIQZoi8rXUNqLVlIc8U14yKi/qJ3dm8KpdZ9NSZ4MM40i5MHJMw0mvX9gpBaCZ30tsKGXpmlOJnnVLJt0d/hTzFXlqdloz6wtkjnG1+6DD2aPBI2FygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440031; c=relaxed/simple;
	bh=+dALVJc9JSH+owpBS/unmTGDmxCqOpoeRSnzD/YF4rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JKcjHzIfg1Zvjq85n0pDCqHexuEXf+NL83Jyh61ukd7RnUMFhsZ860Qw5Jyhif3zLZMGNKpd434FynFfgueAK8hD0b5mq3IQqVZUAI2mddnSqRs2F4lJrGDEHbCcBSr/ogsZfXD4XhzLWXv1aR2Wdvl3N6PuvcS409AkNBFSehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VT39lYNm; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VT39lYNm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OC
	/0wtYpR6XqN/W3IRAPjvRMqoNyj5HdME8Oy/DlXho=; b=VT39lYNm8t5ZDopjtj
	PgAmf+P3Augzze5dBMl8CK7Kf4gTaDwXHesEWNN18URq/EtKnHH5h4PplcvqcDf3
	hExz4uTSI4C9sKQWrpmSqB9dEC+Va1MFKITKkQFphyWnEVvuOUFiOHrbd+UMdXfY
	QG7KzWadBfhhOzBWFgv/Bt/Aw=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v6EU8rdq1Ce5Aw--.54526S3;
	Sun, 27 Sep 2026 00:26:13 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Evans <mattev@meta.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 1/3] vfio/pci: Drain eventfd RCU callbacks on module exit
Date: Sun, 27 Sep 2026 00:25:50 +0800
Message-Id: <20260926162554.163197-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926162554.163197-1-yaojiale02@163.com>
References: <20260926162554.163197-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v6EU8rdq1Ce5Aw--.54526S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrW3Kw1fAFWkuF13Gw48WFg_yoWkWFb_C3
	yrZ3yxX3y7Cw4fKw12vF43u3sIya4agFsYyF18tF9xtry7tFn8WrsrGFnrXFy8Kr47Arnr
	J3yDXw1Yvw15CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuWlvUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wVOiGq38iVDgQAA3k

vfio_pci_eventfd_replace_locked() defers freeing replaced eventfds to
vfio_pci_eventfd_rcu_free(). A callback can remain queued after
close_device() returns and the device driver module reference is dropped.
Once the dependent driver is removed, vfio-pci-core can be unloaded while
the callback still points into its module text.

Wait for outstanding RCU callbacks before vfio-pci-core exits.

Fixes: 98693e0897f7 ("vfio/pci: Use RCU for error/request triggers to avoid circular locking")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..9bce419c52c8 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2675,6 +2675,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 static void vfio_pci_core_cleanup(void)
 {
 	vfio_pci_uninit_perm_bits();
+	rcu_barrier();
 }
 
 static int __init vfio_pci_core_init(void)
-- 
2.34.1

