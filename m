Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6A463B86;
	Wed, 23 Sep 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151975; cv=none; b=gEFEyxVN54ADUVFRAwNWGbTdfbccnOCCEHReH8nP4vmBTvopVIxevCMTiGMPgtuqkhAkYzVwdrC8Vv0HaPmjfhtcSgtFvgYpKzavLsbaUezC8FjrMytbDxbAXFHzSuDM/ntPj20PiauN+toXEc1XrihYwiqADBchvk3bP8WlfFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151975; c=relaxed/simple;
	bh=tvGHjFIzMxxPKsSOeO/ShjEPK8k6LMsoQWPQiXuiPsY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ROwdWSK9/q+E1E/xjcsOM8ohPVlBcNHUfnBLr1cpk2/jUItHk7S00ie8QW4H8zPl3UajeknyEC/kmdvC+pL+7mSUGihsR0l0UKqSJrquwWNkTz5VTsBLa9WqHNzZnMf5A2zUO+PhcIjCe0dZk9yLYwZFDRSVneBjj5cZgpnMQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cfM0y4AB; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cfM0y4AB; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cfM0y4AB";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cfM0y4AB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3PDpZy/4r3hPKkqz9VXE5N+0GfnKKGIWJnDJF/SP8Fg=;
	b=cfM0y4ABUx2Wt4C/Zi8xs0e+PJ3FEsBgEXqCsT26NgaPWgiVlY/GbZOO+tmi1Dq2smCtElgTr
	R5rGB+8pkc5j6WVHzX7s2kynZhTJgr0KgpkWuhD++FCNFD4ktU8SWBH1bKr8c0hzRZgO+5+S+Bd
	B1MpxdoWX0E/xxpoIqPTKnY=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4hqVR102rrz1BGPk;
	Wed, 23 Sep 2026 16:25:49 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3PDpZy/4r3hPKkqz9VXE5N+0GfnKKGIWJnDJF/SP8Fg=;
	b=cfM0y4ABUx2Wt4C/Zi8xs0e+PJ3FEsBgEXqCsT26NgaPWgiVlY/GbZOO+tmi1Dq2smCtElgTr
	R5rGB+8pkc5j6WVHzX7s2kynZhTJgr0KgpkWuhD++FCNFD4ktU8SWBH1bKr8c0hzRZgO+5+S+Bd
	B1MpxdoWX0E/xxpoIqPTKnY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hqV9P5QQqz1T4Fq;
	Wed, 23 Sep 2026 16:14:01 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 23CA34057F;
	Wed, 23 Sep 2026 16:25:53 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemk100014.china.huawei.com
 (7.152.184.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 16:25:52 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v5 0/2] fix two issues in hisi_acc_vfio_pci driver
Date: Wed, 23 Sep 2026 16:25:49 +0800
Message-ID: <20260923082551.1754351-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100014.china.huawei.com (7.152.184.20)

This series fixes two issues in the HiSilicon ACC VFIO PCI driver:
1. A NULL pointer dereference in reset_prepare() when a PF is bound
to the driver and passed through to a VM.
2. A 64KB page incompatibility on QM_HW_V3 hardware that breaks
migration and the guest kernel.

Changes since v4:
- Removed dev_err() log from reset_prepare().
- Removed redundant pdev->is_virtfn check from probe().

Changes since v3:
- Merged the set_reset_flag fix into patch 1 (was a separate patch in v3)
- Replaced pf_qm guards with a mig_ops check at function entry.
- Moved the 64KB page check from open_device to probe, selecting generic
  ops instead of rejecting the device.

Changes since v2:
- Remove redundant qm->io_base check.
- Drop PAGE_ALIGN for BAR2 configuration region.

Longfang Liu (2):
  hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF
    passthrough
  hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3
    hardware

 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 43 ++++++++++++-------
 1 file changed, 28 insertions(+), 15 deletions(-)

-- 
2.43.0
