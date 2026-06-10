Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60332DEA74
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781070464; cv=none; b=WKeN7HITTEkUaL+nrfGeTKodvK2sPkQ7ZxKiFYEbIfyUbDOqz3dYRv+2hpZOJMBALsEExlzYLg8jWq9FXVBt9pH5xGM5G81f53q3poZk8lHd2Ifmb54CGn5YngZ06zsj/3KE7WWc0IB50lgowLsI4hh6EIf2mEBbWGmefuR5zRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781070464; c=relaxed/simple;
	bh=nLmz9/Qd//C+4o2dXaRH73tYjWB1R4TR/5ERz+418w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HeLguqBakBsOk1ifIF1KLtXv0nH1AqusgvjjOewRowQzsmSfE3riEzGaWMmWomMtX7gPVqL/MipN+sqXAsYBxjBiV40sXg5csOubSQzaDY0K+nAte5EfnUNJ9sPIUlvcC+9f4aaI6W9N+UJskyMGn/In4nnF0LpHWO9KH/V2Bwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PgEtDMhg; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PgEtDMhg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781070459; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fcA6KLT7zJgfoyb1BLA3aFvyit7BdjojJ+YH53V4aso=;
	b=PgEtDMhg11UXlezMQBof7Tcl6scdXyqKgkxcDRZg13tniH7XuXHr2zS1EuBLqFcjT3rV6wvQ5BlGK1rha4n/j+zJcfLyOQ+I7Cl4sUSTml1rVJR1dBW57+lZ+pYYv3qXLv7lYVcPcvqDse2ShJs5BUqXDVUgn1dUhEs5cAeISJg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X4ZWCmN_1781070454;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X4ZWCmN_1781070454 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 13:47:39 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: kvm@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH] vfio/pci: make nointxmask and disable_idle_d3 module params read-only
Date: Wed, 10 Jun 2026 13:47:34 +0800
Message-ID: <20260610054734.3591169-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nointxmask and disable_idle_d3 module parameters are registered with
S_IWUSR, exposing a writable node under /sys/module/vfio_pci/parameters/.
However, writing to them at runtime has no effect on driver behaviour:

 - Both values are copied into vfio-pci-core's own static variables via
   vfio_pci_core_set_params(), which is only called once at module init
   time.  A later write to the vfio_pci front-end variable is never
   propagated to the core.

 - disable_idle_d3 additionally gates paired runtime PM get/put calls
   across the probe/remove (register/unregister) and open/close
   (enable/disable) life cycles.  Changing it at runtime would tear
   these pairs apart and leak or underflow the runtime PM usage counter.

 - nointxmask is latched into per-device state (vdev->nointx /
   vdev->pci_2_3) at device open time, so a later change can only affect
   newly opened devices and yields inconsistent behaviour.

These parameters are effectively load-time constants.  Drop the write
permission so they match disable_vga, which is already read-only, and to
stop misleading users into thinking they are runtime tunable.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/vfio/pci/vfio_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..b72f168feb3c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -35,7 +35,7 @@ module_param_string(ids, ids, sizeof(ids), 0);
 MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the vfio driver, format is \"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\" and multiple comma separated entries can be specified");
 
 static bool nointxmask;
-module_param_named(nointxmask, nointxmask, bool, S_IRUGO | S_IWUSR);
+module_param_named(nointxmask, nointxmask, bool, 0444);
 MODULE_PARM_DESC(nointxmask,
 		  "Disable support for PCI 2.3 style INTx masking.  If this resolves problems for specific devices, report lspci -vvvxxx to linux-pci@vger.kernel.org so the device can be fixed automatically via the broken_intx_masking flag.");
 
@@ -46,7 +46,7 @@ MODULE_PARM_DESC(disable_vga, "Disable VGA resource access through vfio-pci");
 #endif
 
 static bool disable_idle_d3;
-module_param(disable_idle_d3, bool, S_IRUGO | S_IWUSR);
+module_param(disable_idle_d3, bool, 0444);
 MODULE_PARM_DESC(disable_idle_d3,
 		 "Disable using the PCI D3 low power state for idle, unused devices");
 
-- 
2.43.7

