Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310C1FAC50;
	Tue,  4 Mar 2025 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089936; cv=none; b=kyd8YtmtVvLZZK4iNReXo/USO5da87iux313sSoFc6l9Ve7GbcbpUnB8mMQH/pj1jxPDfM2L91UB90XEnm0Gj/dS6MrTh0PCPlSyXDk9ukFlMNYgRlcFVwACsTo2w8IPmgXl2qIA09s8eFYNrrJKyp76r43PKRLSIZVqGNPoYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089936; c=relaxed/simple;
	bh=CR1ZXgDMnxX6Etue80km3eRUyCxbxUSFl5mOM1K0SbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iL9t+Zi/JlZX+Ip4dsL3SKRBB9wOEGG3J3Yc0z8xsJ2B17NXmklNAxOs8SXSn8FUGtniQJN+zBnmXlfvyS23MnqX3Y9TsSxcBM7ZLFJ4BritpN2nG2m+Z6Q0kiy5HFdaJ9p7R+vVN8wqzHG370BxpH0EPVrdXDqqOBjXUlBe/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z6Z8q1qrrzpSsq;
	Tue,  4 Mar 2025 20:03:55 +0800 (CST)
Received: from kwepemg500006.china.huawei.com (unknown [7.202.181.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 1452A140156;
	Tue,  4 Mar 2025 20:05:26 +0800 (CST)
Received: from huawei.com (10.50.165.33) by kwepemg500006.china.huawei.com
 (7.202.181.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Mar
 2025 20:05:25 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>, <jonathan.cameron@huawei.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v2 0/3] update live migration configuration region
Date: Tue, 4 Mar 2025 20:05:25 +0800
Message-ID: <20250304120528.63605-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500006.china.huawei.com (7.202.181.43)

On the new hardware platform, the configuration register space
of the live migration function is set on the PF, while on the
old platform, this part is placed on the VF.

Change v1 -> v2
	Delete the vf_qm_state read operation in Pre_Copy

Longfang Liu (3):
  migration: update BAR space size
  migration: qm updates BAR configuration
  migration: adapt to new migration configuration

 drivers/crypto/hisilicon/qm.c                 |  28 +++
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 224 ++++++++++++------
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   7 +
 3 files changed, 190 insertions(+), 69 deletions(-)

-- 
2.24.0

