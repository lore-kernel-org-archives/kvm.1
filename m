Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029D31F9BF;
	Fri, 17 Apr 2026 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457719; cv=fail; b=eZ/w6xvcnvoJq7KhDWTLtuU7rnoGPhhpYaGosCXDfooigIluF2GoAjWrmYjwS9y9fA2YARkkwvWCgAAKNzLXyTk/JCdlLJFIr/NH2st02wddpo1bVc5ouhTw9WcSvPK6gjePRnOgEQrtFRAc0/XYjLe4HL+Pa7c3khZlM2bfZWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457719; c=relaxed/simple;
	bh=FwOTV0OlKHex5o+lmgovtmCCHdJMSG3724AivI41huo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eH9atPBTql+LxopJeOJwm1/EhEdJs/KWf809IdDqN/NLsELM7WYpu//5ZpzeYIzdA6BqFs3R72GsjYGhSMk9UxH+MzRVHYk7W1ocupylucqYRqh5WZJzfKYwQ4TasbMlomV+yavrp/PVnJEng3obr+Z5BhT15eHwK67VsIcQ/8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FYIlDTnh; arc=fail smtp.client-ip=52.101.52.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FYIlDTnh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hbw//q1w0dGQk2oOUfkDXwu1xccZAMVsU/CGxJaKmriJv4iDz5DZCrVAMczoozuKa2hTVW0YJXuggf3H58SfyEi0won7de0eUHXeSjVUz7P+UF4PKqdCJpwApfQ1zgfgkmI7xMd8D+sbI+8e/d+Xhan4Am4Vc82rULUxnvPKhTuGQJtk+tGCEu0wzegXeAzPQE2mOaW5Q5mkajJxYum5F95UNahrhMctxdmJoSWAyEKUa+/mxQItD3VETiStOWh9/wFDTLFmIYjNOwRr6BEYUY0LquXe0NOVT3V8EXr25yQKtuW6rFZo4n9v3nucJz5e0yfEn3I+3+KF6AwMKTiLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=800slJCbfoVGHJevUQaVwDICQ+JdAQyguOySYB9zR+A=;
 b=V7DaIJ2cA3xm1JGwUjwYtmjrcCoK30GCcQnIPeS1dKyk6H4tRqw/HG9sLdDaeUcfoS5qsQGcJWu30UEK41jg9qQ+SeXroJeILVpE57Jnnn+dCCisrmDFvhN57x3W9ZFmhedhe0nvKNjJ7SZpC0LoN4FcLWeIhMpRMNZV5p05LzSKXF4MsLAaLdtXfc8BoBZOvlSqu+b8ytaNk4HmbXkS/mqs9V/lddshj6C2CFOBQqnEc2Dalk8qJtLossi5O/yVvPNLUI7yVDqJ7HHo/WB6OQP6HuSzBUGTlu8XceR4JLAYJH3FrecKH80S09n4cQYqznIw+gn8bFJmrcq/DperTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=800slJCbfoVGHJevUQaVwDICQ+JdAQyguOySYB9zR+A=;
 b=FYIlDTnh9rNOr+vZyTFDesDZ+YHeh0DI1gaE3+BOFt8Q069QJ2t89slUOryjEki0umcJy6VqcSQ4GAlLwSsJoQpQ7woJYBqnCW/Q1tVA6SZDTsWmfKAimyqTiW5bcUkD1ZVOISaAlWo4eTwnMluB5gE7MbV8tq6DnFVyN4fLIS54WwFlAqDs3ZXa4s8DUaB2kLWH+5rNstRS7OIzZuT86Pin0xhtQU/gaDIHhqauJxrgJfSs0A0vZEcATULPfRkBj07o0yW3/7ZPVuIKS/+KHfMpuKOeGQxtHG0FuzizqveDcWTCasYoBLa7fYA3i6Use4kwg61VdYnfpPsLFfsmfw==
Received: from BN9PR03CA0908.namprd03.prod.outlook.com (2603:10b6:408:107::13)
 by DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:28:31 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::53) by BN9PR03CA0908.outlook.office365.com
 (2603:10b6:408:107::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 20:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 20:28:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 13:28:13 -0700
Received: from meforce.lab.shazbot.org (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Apr 2026 13:28:11 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: <alex@shazbot.org>
CC: Alex Williamson <alex.williamson@nvidia.com>, <ptsm@linux.microsoft.com>,
	<nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] vfio/cdx: Consolidate MSI configured state onto cdx_irqs
Date: Fri, 17 Apr 2026 14:27:58 -0600
Message-ID: <20260417202800.88287-4-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417202800.88287-1-alex.williamson@nvidia.com>
References: <20260417202800.88287-1-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DSSPR12MB999212:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b14320e-6e6b-4bc6-73d0-08de9cbfe3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JE4c76JxkH74lOkPSawCt5IhqxywCPfGLIt78wcssAQR3AA2lePiWnvDQz/1PRMRinq5T3XKNViMq/7/q11BRG0Y5Zh6YtgYHwXNUL3mz1WLJcVP6DTnbg4b+lpJsEKTrwdd2fJ7wtKctoU2whOeqt7ETZH2jl+KcXs0sKPO4T18dUwnBvVpMbGzHHTkIl7IaMPiZXNXOkSlFdZCygoGzQMt2EkRWrbA/nF2lQWQWHe1YcPveh627wrlLOixAeYHnhWOVUvo0Cs43Lbc5toEiqt4P9u0KVB2eejGX7mzNuH+QuMOy+LDIIjsxoCjyjE96I3zNonm4Xhsky+tOzCDm4HHqDl8egRQFXcszQgOt+HzKxyLivmzMEuyvssD01Qf/C6fb8Jr8htJXFtKe2O2yYUGdhnejKNtyPD9v7cZfbAVVftlorC5BXvkADOAkPKk4FvelIhXjc5dBW6O5dwj9HKG4X/hs453+CNzW8ZwvMAK1JP023NOpo3hD7KxPFWnG9cByKfjoCgmXQYzFpZQo56EL9R2CKp7Lho/Dt/yX1rtZWUMbvk6Htek/9xtBOVVXDL8KaFtJDDWD7P0+3V1qXKnKxqHdU5FXjHWTceMw5It/REdB063n/lMJ1SAqTv+VAswtF4JG2ds18q2hRSdDFDQ9UXAZHTNXmb9R1552JFPPrDDSzENlniVTjRLn3dDkmDTybk/xbWTCALNOJyxFGOr+PMPy1wjVlo0Ol/v6CSdXd7nNenp6u3irDZUYPxCZpNYr/3A7YIfB6sn3JGMqQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wr+Uf76KUAx2rnyzF4BA1an2mkYS9vupuXFE//pzFH/mO9uOLCIdIY9fCO0eZhIxy8dWwWfIS/NKzOgBlUV6iSZ+UyH/9ZATxgh1q47xqzRaTEn4nfJ/iWEHZ6H715U/fRcWNoiesnlnRIX3cNe6Ded0nVIBupXhRe2+aO63wHGw++EF0KyU+lNe/lhk+cDVOj7DEHlIojw1IR8lFq1AK4udBLHgcJIrzBl87zMQ8/sdcU3tzD8GALPQnEzp16R/2P2DEcDNjEIZ7d3Z8PJUQ0HpXuRX/gVl4lad6SZLXYDXuIF/4vw/wgljnsFH0MXVff8wdUSeY8+Zkgr5HlIV7mqnor9bF3lWXlEDg1J6LdBlonPYeMPKsuqVyELlhScMdZkmJYDgbXFLi5YwDsJuzmMtNtbONyy8sjh2o1u8IB3ZDaiiDTCmOqunifjJgLnQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:28:30.5303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b14320e-6e6b-4bc6-73d0-08de9cbfe3c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999212

struct vfio_cdx_device carries three fields that track whether MSI has
been configured: vdev->cdx_irqs (the allocated vector array), vdev->
msi_count (the array length), and vdev->config_msi (a boolean flag).
The three are set together when vfio_cdx_msi_enable() succeeds and
cleared together by vfio_cdx_msi_disable().  However, the error paths
in vfio_cdx_msi_enable() free the cdx_irqs allocation on failure
without resetting the pointer, leaving it stale and skewed from the
other two fields until the next enable call overwrites it.

Clear vdev->cdx_irqs to NULL alongside the kfree() in both error paths
so the pointer consistently reflects the configured state.  With that
invariant restored and access to the MSI state serialized by
cdx_irqs_lock, vdev->config_msi is fully redundant with
(vdev->cdx_irqs != NULL).  Drop the config_msi field and switch all
readers to test cdx_irqs directly.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/cdx/intr.c    | 29 ++++++++++++++---------------
 drivers/vfio/cdx/private.h |  1 -
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/vfio/cdx/intr.c b/drivers/vfio/cdx/intr.c
index 6dfe0ced3bdd..4439481fe633 100644
--- a/drivers/vfio/cdx/intr.c
+++ b/drivers/vfio/cdx/intr.c
@@ -32,26 +32,27 @@ static int vfio_cdx_msi_enable(struct vfio_cdx_device *vdev, int nvec)
 		return -ENOMEM;
 
 	ret = cdx_enable_msi(cdx_dev);
-	if (ret) {
-		kfree(vdev->cdx_irqs);
-		return ret;
-	}
+	if (ret)
+		goto err_free;
 
 	/* Allocate cdx MSIs */
 	ret = msi_domain_alloc_irqs(dev, MSI_DEFAULT_DOMAIN, nvec);
-	if (ret) {
-		cdx_disable_msi(cdx_dev);
-		kfree(vdev->cdx_irqs);
-		return ret;
-	}
+	if (ret)
+		goto err_disable;
 
 	for (msi_idx = 0; msi_idx < nvec; msi_idx++)
 		vdev->cdx_irqs[msi_idx].irq_no = msi_get_virq(dev, msi_idx);
 
 	vdev->msi_count = nvec;
-	vdev->config_msi = 1;
 
 	return 0;
+
+err_disable:
+	cdx_disable_msi(cdx_dev);
+err_free:
+	kfree(vdev->cdx_irqs);
+	vdev->cdx_irqs = NULL;
+	return ret;
 }
 
 static int vfio_cdx_msi_set_vector_signal(struct vfio_cdx_device *vdev,
@@ -129,7 +130,7 @@ static void vfio_cdx_msi_disable(struct vfio_cdx_device *vdev)
 
 	vfio_cdx_msi_set_block(vdev, 0, vdev->msi_count, NULL);
 
-	if (!vdev->config_msi)
+	if (!vdev->cdx_irqs)
 		return;
 
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
@@ -138,7 +139,6 @@ static void vfio_cdx_msi_disable(struct vfio_cdx_device *vdev)
 
 	vdev->cdx_irqs = NULL;
 	vdev->msi_count = 0;
-	vdev->config_msi = 0;
 }
 
 static int vfio_cdx_set_msi_trigger(struct vfio_cdx_device *vdev,
@@ -163,7 +163,7 @@ static int vfio_cdx_set_msi_trigger(struct vfio_cdx_device *vdev,
 		s32 *fds = data;
 		int ret;
 
-		if (vdev->config_msi)
+		if (vdev->cdx_irqs)
 			return vfio_cdx_msi_set_block(vdev, start, count,
 						  fds);
 		ret = vfio_cdx_msi_enable(vdev, cdx_dev->num_msi);
@@ -177,8 +177,7 @@ static int vfio_cdx_set_msi_trigger(struct vfio_cdx_device *vdev,
 		return ret;
 	}
 
-	/* Ensure MSI is configured before accessing cdx_irqs */
-	if (!vdev->config_msi)
+	if (!vdev->cdx_irqs)
 		return -EINVAL;
 
 	for (i = start; i < start + count; i++) {
diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
index 94374b5fc989..4c00bf633356 100644
--- a/drivers/vfio/cdx/private.h
+++ b/drivers/vfio/cdx/private.h
@@ -38,7 +38,6 @@ struct vfio_cdx_device {
 	u32			flags;
 #define BME_SUPPORT BIT(0)
 	u32			msi_count;
-	u8			config_msi;
 };
 
 #ifdef CONFIG_GENERIC_MSI_IRQ
-- 
2.51.0

