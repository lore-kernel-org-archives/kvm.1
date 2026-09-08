Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB03A984F;
	Tue,  8 Sep 2026 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855003; cv=fail; b=F8MEglIo/y3OoVLUa1Vc+5olPiWUeZ8NCEkhMOSjLUyQTk4hXocjnYf/0/ulfKX4abxJunkIIXStRYbyQiH4IOgOSaC7D1g3eVsozOogxbTe9tpirsu4xoXT9pmssNvCFp7h/jU7LMGtFho1nNoqp9UxL15tEMFE8BxmfDTYeJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855003; c=relaxed/simple;
	bh=ohG9Cg+d7MMwbeAptl9YHu99fN+uiNFF3IAiDZZfNKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HnDgK4ja7NmyMkp3XtKchE0EV9fnlpQCpXUXbpilOEbInkeysuhZ6b/STdFe78hdVCJceniRgYIByL8Dh5a81lvoJmZu1sSVO66QROnZKTj8opmdttuw4SnNiMnlwELWZC91WXSnINwXZjQbbiSYgKQax5NZ1XDSUByBWTzmpc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HuyMl0Ap; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HuyMl0Ap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9M98ysnIwh4hr6EQC4ebxOvhEhv0y6LPWAGRTWPX60jmVTh+u7Gj1hzqavwuTZS4vJid1tptRJHaD8A3wYICXpPYuJOhU0V6lWEI5xAumjbY5bTZEgUueKWyXdzB4fUlmMt3hUHzWY5KNFR1WQC1VbxPPXicc38Itu+9rRfYORvNl7/YtGh3sQl+DhcFb46jO1X0uzFh8QYxM837091pJxbSdtwn72fbv17x2OYiDb7JYfJ5cE1Dxwozc6q8wRMegMdNgy2uoMlOr9kZbhCsKbILfeh5yykkXI9gufcUPa/8iyul178J22dKpshAjowKioVc+4K/2mPJhRcqSMgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4tK4pomgVMTDnJep5Vcdb2TqHemBpYUt5XXHuXuM8g=;
 b=ZiphEp983wCWymuokR9VgJ1p+ZLiziPQcLY/BV1kiI/2ZhUe1IhjWXPT40MNz6IdJFLlZjVNd5GdS7qLQIKVsxBowYNw4F0AxO6xnJSRTVAy8PthvNh37TZVrFGh7HlrUxYr+j6hkXuL5jeFc+YeSyYfNklcksNhzGtO7lW1xV1cyiZzln+9clJpaHdBUdXGdIeaHh/UVHuLrLgXKX3NwOWQmW/d4BGce+L+cThei1EWGphC9YQRenSV1lm2eMpHxEkbr7wMFWEVV2xHzGdWrb9hovHjlt6IOX5OTb/m+QYq3UkGUSiawNO4R6oJHD3atmIQEH2YTBh5PPH6pMqKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=shazbot.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4tK4pomgVMTDnJep5Vcdb2TqHemBpYUt5XXHuXuM8g=;
 b=HuyMl0ApBpIGASsMfKljqsVoyOmy1DQvXsaytWBDp8bSZZ2zu1imUw2iT3c4TgXyz8K9jkvs/tJI8lamGJew4weXD67540ZyAM7+9bPFlZtHY8wqEFsA96gJQYDTBUgwVOqeLKaiu3as9IVrgl54+p8wpnUpf3nhf+QRP6e/lMU=
Received: from BN9PR03CA0794.namprd03.prod.outlook.com (2603:10b6:408:13f::19)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:09:57 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::7) by BN9PR03CA0794.outlook.office365.com
 (2603:10b6:408:13f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 08:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 08:09:56 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 03:09:53 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <alex@shazbot.org>, <anthony.pighin@nokia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Tiantian.Zhang@amd.com>
Subject: [RFC PATCH] vfio/pci: Block for the upstream bridge lock in vfio_pci_core_disable()
Date: Tue, 8 Sep 2026 16:09:46 +0800
Message-ID: <20260908080946.2235849-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 405b2300-9a0d-4a53-d74f-08df0d80923d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|5023799004|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	j6bcjX0kjj8lrKR7NGg0wTI3nBftDidMTDV3+JxPCpK8nsmO53Kw/rDEGUTexZDuJiQB3vGpPfRglzIwFVx5kkRd321ZCjzS+o2cM0Wb0V7CU9CWqmDkn6tTQSPT6r3NcUxlKc/QUPvwYOfbEc0PnO/RHbBMjZ1PLRQgdZnujiGYdvYifk0YXiuVydhYwkwmznBGjlwZLeGWI6RqcOLRctNhQoqbdvrhOuB1f2hbK+onLebuBfwX0IK6Th/wLMHuLIAsXgONmUi6mXvMDOC3S+UzEj1mFoelV46RtKuWQ3ekDSE8r7iAJw+HsX4ojKnd+zhYaf46F8FyBPiy9bU/rWGlSCMlhrTpzY9ty2BgDFGmvxq23Zi2jd+mCZ/qQmFe25BfUglguSaM35jf7TvBn7Ms7T++C3zjqD6l21Iho4mDUvVxX8CKJT2AJ932tHSzp4miS/Cn43/u2BWxcYFb4QU1A9yu5DTl0nMzjVSR7BM10vCkPwIWb/n9AJIZ/KN8NTurpYetHsMU8cXhAVxl3DM6YuG3IjafVTwjLqpLQzBLGifSVBO2LbpqBZ/ax7xsoIjuPzgBRbD5OSRyVPBsD+jeLi5OJ5A4X1CR6f9ruQ1GLvlxXVJjaMd6XfILknHXvyCxYhZc6zAO7onJJ+HbnQB/g4DbY3Yu/JOEHjq0vs3cKNrcKOLKw4k9f8D3Qt4oH+Wt30JpklAVlFQtlN7vaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(5023799004)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3pSF00ybQ5bsHnXbkTct8VFUw3W1QpocyrA/+TzokxRP43kLY809PayRxC+3wUNl0HF3MYaq0xn+DLlNE328CoGzAKmFC4GlnM5R5BtpCpThxaFhXR3yoqMpJ91b3I4TLfFsxepwRNLITXO297rEGipkMjNYjxhU3G92AhPerDRQA/e11KRAlL0KyDkZ9jHxTgFShgtHxSEhDhWW94oaSZLM4YQSSM8u+85OnkJ4DZXdIVWe9EEimKTA5JY2wmdTVp04/SB9rq/5oALV/fNPfM2DU1L0NZYQNk/TqqDR+i2Qt8NFgoJc3P9Fr2HT0Cdc7B6bwppHAyqthBRK/LasK5A1Hc7AAnUGayhdGQ96Bot8x6ZtaRty4SPOCo44Y40VrXKuvKrNWUnEiC7uDva51IxRHntGUc+rXWeJc7RqHKZkj98i8/7oR52HMcorEmFS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:09:56.9972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b2300-9a0d-4a53-d74f-08df0d80923d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626

An upstream bridge is shared by every function below it, so taking it
with pci_dev_trylock() makes the release-time reset fail whenever two
functions under the same bridge are released at the same time.  One
wins the trylock and resets; the others take the goto and are handed
back to the next user without ever being reset.  Nothing is logged.

This is easy to hit with SR-IOV, where all VFs of a device sit behind
the same bridge.  Releasing just two VFs concurrently is already
enough; which one wins the trylock is random between runs.

Take the bridge lock blocking instead.  The lock order (bridge, then
device) matches pci_bus_lock(), which takes both blocking.  The
trylock on the device itself is left alone.

Concurrent releases now serialise their resets, so a teardown of many
functions under one bridge pays one FLR settling time per function.

Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
Cc: stable@vger.kernel.org
Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
Hi Alex, Anthony,

Sending this as an RFC because I would like to know whether the approach
is acceptable before going further.

I hit this with SR-IOV: all VFs of a device share one upstream bridge, so
when several VFs are released at the same time only one of them wins the
trylock and gets reset.  The rest silently skip the reset.  Two concurrent
releases are enough to reproduce it here.

My question is whether taking the bridge lock blocking is safe.  I have
run this without problems, but I do not fully understand what the trylock
on the bridge was protecting against -- 962ae6892d8b added it to silence
the unlocked-SBR warning, and it is not obvious to me whether blocking
there can deadlock.  If there is a path I am missing, I would rather hear
it now.

An alternative would be to keep the trylock but at least log when the
reset is skipped, since today it is completely silent.

Not yet tested under lockdep; I am setting that up.

 drivers/vfio/pci/vfio_pci_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 362c375a0579..8966a5bea406 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -790,8 +790,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 */
 	if (vdev->reset_works) {
 		bridge = pci_upstream_bridge(pdev);
-		if (bridge && !pci_dev_trylock(bridge))
-			goto out_restore_state;
+		if (bridge)
+			pci_dev_lock(bridge);
 		if (pci_dev_trylock(pdev)) {
 			if (!__pci_reset_function_locked(pdev))
 				vdev->needs_reset = false;
@@ -801,7 +801,6 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 			pci_dev_unlock(bridge);
 	}
 
-out_restore_state:
 	pci_restore_state(pdev);
 out:
 	pci_disable_device(pdev);
-- 
2.25.1

