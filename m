Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188438F928;
	Fri, 18 Sep 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720973; cv=none; b=CjlLaa+9iccS4G4aEyLXXS4di4AX3C15tJJLBbLKoQm56capNLkPUUsp6CSiYKVubCqUZTVZ2gBgkyRJRvGaXacg6/L20WYDsd9r0PyTJHlVvF+teMB+UYjtH3s9Jt0pPJC1WMOeIunNf32Luh2GlqKFxZZr+lc+UJNLLAOMBAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720973; c=relaxed/simple;
	bh=jV8L4iD/voRnwW1OdmRK6RNmbyMDfme/qo/FYWWQUSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXIUK6FAnL/VWXp/h0RDnizsH0eUqn426p6dMI2Hwkii6aYCY6Uewy5pe3dqZClV1fwDqdZkroVK8bVsydry1tliBQSXZ7kW0wcLPqInSsbpakhuESy5JyIwZpgW01vNoe+RlLjtGrEubs0/a14exyNDRN5JpC5rg/ujdRmFlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1ld7AFwi; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1ld7AFwi"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=64o1Yps7R9zmENsYsyhSM4AE6MeKdVw+iKfXbsHnBBw=;
	b=1ld7AFwiEVDhhz/tNhscSHn1N43vbU+f+ldAsFRpB1wKuyRm5CFO5c9GjQCPf7QEk1YnLGO9+
	a9I7uiCrYhrWTTNYKNFty6UMo+gPc+mcWY9hJOZIZNGm5XoXfRpB6CTUpdqGeehA/cVmkh/nghn
	R1GX/bTASOCXEU7nayHBHLI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hmQnv0rThzcb40;
	Fri, 18 Sep 2026 16:31:31 +0800 (CST)
Received: from whupemk100014.china.huawei.com (unknown [7.152.184.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 2490A4056D;
	Fri, 18 Sep 2026 16:42:46 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemk100014.china.huawei.com
 (7.152.184.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 16:42:45 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <alex.williamson@redhat.com>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v4 0/2] fix two issues in hisi_acc_vfio_pci driver
Date: Fri, 18 Sep 2026 16:42:42 +0800
Message-ID: <20260918084244.1485837-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100014.china.huawei.com (7.152.184.20)

This series fixes two issues in the HiSilicon ACC VFIO PCI driver:
1. A NULL pointer dereference in reset_prepare() when a PF is bound
to the driver and passed through to a VM.
2. A 64KB page incompatibility on QM_HW_V3 hardware that breaks
migration and the guest kernel.

Changes since v3:
- Merged the set_reset_flag fix into patch 1 (was a separate patch in v3)
- Replaced pf_qm guards with a mig_ops check at function entry, per
  Alex Williamson's suggestion
- Moved the 64KB page check from open_device to probe, selecting generic
  ops instead of rejecting the device, per Alex Williamson's suggestion

Longfang Liu (2):
  hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF
    passthrough
  hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3
    hardware

 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 49 ++++++++++++-------
 1 file changed, 32 insertions(+), 17 deletions(-)

-- 
2.43.0
