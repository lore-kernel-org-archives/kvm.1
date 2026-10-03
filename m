Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9DE35AC3B;
	Sat,  3 Oct 2026 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020303; cv=none; b=T37siBbxJLIjg7GAjfTb/H0EosIjUDK+PuqnDB92rE3cUns4IP4mCkaKk5H+1bfT71hWv4SBAPzr7DZm7kGM0VlLGX87XjTaFquoBjE6LYOTrVnkKMipuAlOcb6MafXQGNy3AdmeonOaAgEtX4hIK9+4eKwfQcC3QyjHVA+opV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020303; c=relaxed/simple;
	bh=+dALVJc9JSH+owpBS/unmTGDmxCqOpoeRSnzD/YF4rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MEzAepbCihnrum0ArI03+hqA5H8RxMQBqQAW559O+DQY7s6bHxYiM1I4H4jk4OTQtnJ/TEJ6gm8LLou8TH0QmOIDkPXVokONXV2ZSZF9kfSf8DTXIZFsPmqxVz/tMpDGmKtZJWEE6o7a48v1EpeqZ5i7pq+P91OA451aPZhKds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=phu51Eu8; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="phu51Eu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=OC
	/0wtYpR6XqN/W3IRAPjvRMqoNyj5HdME8Oy/DlXho=; b=phu51Eu8avSdLaDpA5
	KmJ2aZQLBo5YjTWvLQQ235MSDOppNzhXzg9NvTZilEMJcpNTbM7XSBT6gHLY3oaj
	UUuEvVNR8jP4rx93661kWQ1uf7HRIhcFBnOSGcaSMCrSsbun8aWQOdU2+CTjq7+D
	Zg5x+5XvxCcsZIFHpS/t56zk0=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnF9oAzcBqIoysCg--.31480S2;
	Sat, 03 Oct 2026 17:38:09 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] vfio/pci: Drain eventfd RCU callbacks on module exit
Date: Sat,  3 Oct 2026 17:38:06 +0800
Message-Id: <20261003093806.544631-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnF9oAzcBqIoysCg--.31480S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrW3Kw1fAFWkuF13Gw48WFg_yoWkWFb_C3
	yrZ3yxX3y7Cw4fKw12vF43u3sIya4agFsYyF18tF9xtry7tFn8WrsrGFnrXFy8Kr47Arnr
	J3yDXw1Yvw15CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRK7KIDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQE+eGrAzQG7xAAA3T

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

