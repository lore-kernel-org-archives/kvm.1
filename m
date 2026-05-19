Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C23B9D89
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222329; cv=none; b=ihe+klRbuxPpVSGckZ3rajR/9AdpAOIeg8rxFZj3C/IGRvDExNBoN/OiEVXxF+gdlWPTTcFRWtjCr9GJMKKpagi0Gtn9i55Ik6RYdzRYZ/Rn+BjvRcLD42MrpkBKOw3Ms2ITmQqkY1/pm8LulcBlNx93ur74kTeYtsG2JNwhG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222329; c=relaxed/simple;
	bh=yNOo4znZTxGxR4SNw9FyeGyZwwSM+knEdVS9MWgmDss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RFGI27jTxFLlzGE6jwe/4qtKbk6kbXTvXGWkGuzSFm4eOfaTSHnLnFQdCK5myK8LRg2/axnYIiQGIwGW6n89cPGi7CENUx/AgJEgQSnVzY0iG2r+NhAgZ3Vn6aVkCgx38YVop730koZ51BE8xL6bpnkcthHUwqpQeLyYKBzeEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=U9ot1S10; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="U9ot1S10"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JDaJ792073946
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:25:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=D4ZtGBKXTQWkxkEDo7
	qy9RupcJeBysOQQtfuLb3mqvE=; b=U9ot1S10keemjqLtbngY9n8IX6dZS+87oJ
	s/Fz5pTvcIB8vyuBpTpzCNsXjHVNndunjssCoBxAn42NwKkROKm0Ktqe+QV8j4xZ
	tUaHs64pcqXXAhRSazd7/HG3RmP1BGggGpQIAc8S/koW32Bnst6FN79nFS0tx+T8
	ez86IyBT6RsGlzJKaMt3hGO4mxTUen5yRN8hvze0lXJ6g0c5Loiu9tvM+b/1NIHH
	MQj1bztIVIp14edqEB2JUeEkly987lqJJXhq0vSRCZ1B5cuEeZfoLzVC34Mv1Hhs
	j2HLrup6Ga/TPjV2iyUnEFNQEsdoLv8t0X9YTlZjcEDG9XdQjTvw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8rvvaw48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:25:27 -0700 (PDT)
Received: from twshared116290.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 20:25:26 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 734CC2F3ADA40; Tue, 19 May 2026 13:14:01 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v4 0/3] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Tue, 19 May 2026 13:13:48 -0700
Message-ID: <20260519201401.1558410-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIwNCBTYWx0ZWRfXwlPsWvKLOpi7
 6K/Rb/kW/rOrR5BTezf7DV21IwBnKC2+btXD9Mrp7Eu2hAZdjtdmwz5qb0xB6jFhuzFUzkO8x85
 5mzz0sTnPxWUI8q2w13jHAQXPnkpLBbSQ/UyRaZ7eso9hC9aYTPEEAPLpSXYcbgjfs4AGye5PKe
 05medETFRX4/uBLf2uExS7QfDKEoos8/pHI8cPBh5P5o4jP2BlUxTBscLWLXZhrb5uye9jxr4QC
 FzJr2EX6tFQeqw3FArOdvWMMycSNRNcgyRMzrtafW2IcGxz0daLcdsclWrXChsY69JanvJFQODp
 NAIvdr5j5/zGmmG9cmw2FbwY5JBujXrk1GfHRFlEvHzSNaVSoLCiXpODP37bEAzi6rDdvWOnBwx
 vpjQMbqS7unApdzilLfUg3klVrthQ9WLj2faRriSvdROfiUqsx2Aqb2O+59/Oa7p9nEvmQV3rZJ
 K2LmDj/KSAI6tJphHtQ==
X-Authority-Analysis: v=2.4 cv=KfHidwYD c=1 sm=1 tr=0 ts=6a0cc737 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=UdSwML9BD3WwL5YSS9IA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: CgTIKgGdPYBez_IqSCJCg2b6RoJ-bkwI
X-Proofpoint-GUID: CgTIKgGdPYBez_IqSCJCg2b6RoJ-bkwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the
exporter's steering tag when performing peer-to-peer DMA into a
VFIO-owned device.

Patch 1 adds the dma-buf get_tph callback and the new vfio uAPI.
Patch 2 exposes the enabled TPH requester type through a small PCI/TPH
helper so callers don't reach into pci_dev internals.
Patch 3 wires up the mlx5 RDMA driver as a consumer.

Changes since v3:
  - vfio: TPH SET is now write-once per dma-buf; a second
    VFIO_DEVICE_FEATURE_DMA_BUF_TPH on the same dma-buf returns -EBUSY.
  - vfio: annotate priv->vdev with READ_ONCE/WRITE_ONCE across the
    cleanup, release, and feature-set paths to make the existing
    cleanup/release coordination explicit.
  - vfio uAPI: shrink steering_tag from __u16 to __u8 to match the
    8-bit ST width, and drop the trailing reserved[3] in
    struct vfio_device_feature_dma_buf_tph (struct is now 12 bytes).
  - Split the new PCI/TPH helper into its own patch (now patch 2) and
    rename it from pcie_tph_get_st_width() to
    pcie_tph_enabled_req_type(), exposing the enabled requester mode
    rather than just the ST width.
  - mlx5: release the allocated ST index before the MR is pushed back
    to the FRMR pool, so a reused MR cannot reference a freed firmware
    ST entry.
  - mlx5: free mlx5_st_idx_data when its refcount reaches zero, fixing
    a leak that accumulated across repeated alloc/dealloc cycles.
  - Initialize ret in mlx5_st_create() and mlx5_st_alloc_index_by_tag()
    to silence -Wsometimes-uninitialized warnings reported by the
    kernel test robot under clang.

Previous link:
v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/

Zhiping Zhang (3):
  vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
  PCI/TPH: expose the enabled TPH requester type
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   6 +
 drivers/infiniband/hw/mlx5/mr.c               |  86 ++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  28 ++--
 drivers/pci/tph.c                             |  12 ++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 134 +++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
 include/linux/dma-buf.h                       |  21 +++
 include/linux/mlx5/driver.h                   |   7 +
 include/linux/pci-tph.h                       |   2 +
 include/uapi/linux/vfio.h                     |  35 +++++
 11 files changed, 327 insertions(+), 19 deletions(-)

--=20
2.53.0-Meta
