Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF03128D9;
	Mon,  3 Aug 2026 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723544; cv=none; b=GseuPcvsPgfBcvxYe1cS7AKqfh2RQtG/oLjxJPKJqNBYZWIH1P8HHfMWujfaoxwcfJcTHkJgMwGsBCPCK/OIiGq6yE3YYdk0VVcxabRIdQN86EfPHR6mKiGaAlTvQiMFS3wvGjBR1tNq45IDPgFl4oSs7dpVLN0GlNSpK+pvblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723544; c=relaxed/simple;
	bh=TsWZBAspibW5+2oq4KOnzowZT9XEjF77ieQg5zJDTNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fi+RXtc8XGJdYJGyNivbd5oTA/X1Irw093YHVR1MFHmoFMQgHpBxu3ZxAbVWnoyzuTm45zqiVd7gwgr5M/0D+kPwfaiAIcoQpr0gA0x6AXhonbjWh9qagqiZsbKMB7PSVmCljqx0HTY4QSXEURyZFflUS4Mvr22Qa4n3I0hgTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c+vX2Xq4; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c+vX2Xq4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NKwDf+FTIkm89wPO8ZA4ZcOUnzwrdThnjZNSTqpxNj8=;
	b=c+vX2Xq4xjmEJHsh63ktfhpZNoZ3JkjgVYiintFqXTo+GmsSEbr6b+k3S7xKxWL1TwXv8ljAU
	wFEXD3o4heUhUH1svS/XMBt+uug69IylxQBt/bMgWz6tq+KVzVLsKryduO6pKyM4FAcso78UNn1
	/s58EHILODSEDlLkvAgx6ts=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hD0VN6LXqzpSvB;
	Mon,  3 Aug 2026 10:09:32 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
	by mail.maildlp.com (Postfix) with ESMTPS id 8574620333;
	Mon,  3 Aug 2026 10:18:58 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Aug
 2026 10:18:58 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH 0/2] fix two issues related to the driver.
Date: Mon, 3 Aug 2026 10:18:55 +0800
Message-ID: <20260803021857.2370179-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500015.china.huawei.com (7.185.36.143)

    This series fixes two issues in the HiSilicon ACC VFIO migration
driver: a calltrace when a PF is passed through to a VM and migrated,
guarded by NULL pf_qm checks and pdev->is_virtfn selection; and VF
BAR2 mmap rejection on 64KB-page kernels, fixed by aligning the mmap
boundary to PAGE_SIZE while keeping byte-granular read/write
truncation. Build-tested and functionally verified.

Longfang Liu (2):
  hisi_acc_vfio_pci: fix live migration enable conditions for PF
    passthrough
  hisi_acc_vfio_pci: fix VF BAR2 mmap on 64KB page size

 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 61 +++++++++++++++----
 1 file changed, 50 insertions(+), 11 deletions(-)

-- 
2.43.0

