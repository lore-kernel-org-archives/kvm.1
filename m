Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5834E745;
	Thu, 22 Jan 2026 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047336; cv=none; b=JqvxvYtwmkT2mq+mbm32PzvUHGX9XK+0XsfdZrR1SW2jwwpsxjiXkIw9YA/up8IxQ5Rd2UwKlOoY5j3ClCaLtA+2Ln0yDK9aq+UpyfVtfEwLEJedPELY/ppZ0i+LaR1wBACVrW4zIv6WntlPaWxZXAgirqUs8/adQoj1eHhs2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047336; c=relaxed/simple;
	bh=dqEmjOPqtK0HIEGgbO0kJ0yiytcq7HuGU+1SDEMRV+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oEGyat/1HbqZjiasksUZnOtDHvpMd9pZnKfXmwrBDrn9dSxMRSfJKRYHE7OfH13HIEpEOMOmCC5POSRwf+JmiJ81o5Yc36pD2BND/tHn+i079mJM4/Zbb9Qceg8P53Rn0TtU5eixMq2JUsxrUV2fI+b7hmZqllWbkK0x2mYNQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5uf9HgLM; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5uf9HgLM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CbBNSqJ4VLdw1njxQI2qSZxuAhZjUSY73maoaQJgznY=;
	b=5uf9HgLMXkeGz+kmuSXrWL93P20pun9q6Zifw9gTEY2cwz6LwuiUiG/EeuRyuJ2QcZApc4Y+S
	1IrAV4XQ2JC6EpxHCRMNDeQa6MvvQ/CPn62fk+5M+heeIOkKNNB1hz+W+y2IsF0RdVv9JeHVHV7
	u1ctspmJFf8b3AOLGcriVpY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dxPNJ5pcTzcZxy;
	Thu, 22 Jan 2026 09:58:08 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DE2040539;
	Thu, 22 Jan 2026 10:02:07 +0800 (CST)
Received: from huawei.com (10.90.31.46) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 10:02:06 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<jonathan.cameron@huawei.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v2 0/4] bugfix some issues under abnormal scenarios. 
Date: Thu, 22 Jan 2026 10:02:01 +0800
Message-ID: <20260122020205.2884497-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500015.china.huawei.com (7.185.36.143)

In certain reset scenarios, repeated migration scenarios, and error injection
scenarios, it is essential to ensure that the device driver functions properly.
Issues arising in these scenarios need to be addressed and fixed

Change v1 -> v2
	Fix the reset state handling issue

Longfang Liu (3):
  hisi_acc_vfio_pci: update status after RAS error
  hisi_acc_vfio_pci: resolve duplicate migration states
  hisi_acc_vfio_pci: fix the queue parameter anomaly issue

Weili Qian (1):
  hisi_acc_vfio_pci: fix VF reset timeout issue

 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 30 +++++++++++++++++--
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  2 ++
 2 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.33.0

