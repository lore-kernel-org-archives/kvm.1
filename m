Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEA63CCFA9;
	Mon, 15 Jun 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550794; cv=fail; b=dU5pB6SI1TlDfnqH4gRx6AtEB0JSpihd17dCTWVeGabQjxf0aWBR9WSon5YXOvPwgmoc/u7pKA9ouVIZisYGN70Da7GXG4h12GfaXNwSa1p/XIuvchVxW37lkkAiBoQZDR4kEXD90oeFUXPeeqxfOgnue8TCR5FwnYnltztSr0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550794; c=relaxed/simple;
	bh=4eK4xSrDjBPnZYprpQvn5hIpdadzi4Ye7YNiCUV86B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKMHGI/gEcBU6AR/piRl5oAiNb277/MvxhrTBMZnA/KYgioQkYS169yMtIuEAtnnQqDttL1uvAPtSftoThjQM9v7D9ayJ6Wq0DoSDG8XWNw27KKQ8P3rIS4WkgUARTAY/AvD8eS5AN/vkWd9oFWDvdxK1jUkTX7OUxmNTWZGIHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tXp4Jzix; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tXp4Jzix"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4UhGzoZaRC9A2WIBYiHf+GLpXL19EZ0zzBprxdlTcEIMhzwRPkxLrdxwLTmYnd5vH4fMaz9oCXQKu34V6jrRNLoHJnaslNv90IRkKHKrFoC1NN9PY8ih9I5mga6wPnBEUJfX9dTvE34WQG4nymWCV34ru9DQJDcX81u7cuaY+dkcHv23YvSgLd4voF883oLjsyGvhQbiUTcsYCenJ/7/iu9x+VgtPRpMtyKXCBuWlNdjqv3Ixj4gDLsGror8rjKoY53KtSTPMonDsN7qT4yjTkGp5Oe4Qi8xckOb0l0iyvmA8YdqIEUyGjY7g8hgLQjAPC+Kz6DjvKnWysZfJVDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9UuWs8LlWZvw6OWi/xNSLQJgXEPJvvSSstFXvMVeo4=;
 b=gT80eF4wFP7nfYTf1CKn2wm5a6LR/2qUE1wuhn6RkLfkxhr6L+z3sl25F7mr4Z7Gq7WQK5y/hgZ5u84aBJtHQ8t8yv5JDS2I26rnW8sIZNyYFzM4jngf51PhqQS8Rtxn/XkdZLvQdA5BKukNXuxsVKoTSQmWsbqs4WZKj9zrgHxwnMEf6D9pMPOJy2NYlKaF9ekcwTV5fJH6EOX2/vUdBTXCuEDXCxnclwbg/S67E4N/nkLLAU6Y5wzAO9ZbMeoRI6eILzbkeEVs7YrdZXIV1baLRRTJxcrv5/xjRFfOwz9xVbEkqLlyIYVVIQQDnCRX0vGXMoEAovoZReqwzCpuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9UuWs8LlWZvw6OWi/xNSLQJgXEPJvvSSstFXvMVeo4=;
 b=tXp4JzixnMqv3xBksCJP4tKfsbcbOMcq4qUPMAiB14gxe5w+NDzGkdOl7T9G8wwkF5AJb3JmZdnDTFbmscOJx36ghElCRBBf/IQr5hUtY7b4UT0ciFk1drzlo0qiMi9Eir8zHfGpxmRI4WjgyeJUaOShdEsFJAU2jHaUQWAhqzsya7s249iBVgutku/072CbGkA4bHS4sTaBB6jPL/vwKsvcYQTe+9hCL8EEtJiHikrni5zp/WFGRwpexcFjNcfLCiOI813fWsQtnNKG/U2BrgpMSKk02nfNktX5vV5x7pu8ono5dGy/W94KqP3+1kxX97P7iBZEJSbyHIHgDeVVEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:13:02 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:13:00 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 5/6] vfio/pci: Latch all module parameters per device
Date: Mon, 15 Jun 2026 13:12:33 -0600
Message-ID: <20260615191241.688297-6-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615191241.688297-1-alex.williamson@nvidia.com>
References: <20260615191241.688297-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: c9766958-9b87-4209-9a3b-08decb121dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|5023799004|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	l3rJ7/OdVRFfqbpRPASxvfRRVCg7xEzVMMfHGZlG6Kx07bHRJXEgHc7FE7pJzivdvA5T0i0PYx4P27ljPG2dD1UvS0GDupPrxK9iWOsFsfJhgkGp3FgZE1i1Nf83JYbrxlUAKpUVFCcQz7ZCN1ozwIsrJdTan4sSNrTKhkVDZgpy9EJl0HprvF6VcbHf649WmRukjhrXu6JvKlzqYWq1tPG0RZaC/viMWzK3fSZ7OOl91q3ed0/KswLJz4VEyVoVvM67Ua8ad44MxjFFux34ZVW1v2yVNYFfo8MN+OyMOCMs7ErC0TexKucw9Ro0X2KcZaBkmJ163d+/k0l8bflhnM8o4BFaGxydrdUezO2KXASG1SyafDBXR52igY0Db/y8PhZknnvK10Pm7bIJ7wbk8s+ykklmAkvQ8/QJlQ4F5ZMvVj09v29Dq9mj2yBPZ0yAQxVvGPFElitcMGeb0v4qMrLaKvxdcN0o8uKIo4vmZj56wYA6cp+w/GKNSlKi1TdOO16pMtZQTT5+NmkygNn4vAiSfDq31Kh4ecR3xBl0Y06VfSN7RVyeqgNsTcEonHKA9DJutH5ra5t6nXalyD4/eaIWP3L1Oj6Ozkw6hNjO054a3W7LkZNS0JGoIQAe20xoDA+x3EztSJglRFMBzEn+Zc1U4An8/z7hjIbiPRV78P4vRETy72UMjBdyLLoJf32p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(5023799004)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zWc3COv/3uSD5+iy+RgZmiCFk68sJLtXNY42dweFyJnU01mqCEY+QmIDky+F?=
 =?us-ascii?Q?2MFryt9ZZQZQV6bmkiFN3eeG4NrSeR+n63u2052nt9TJfx7fugwLFA911VM9?=
 =?us-ascii?Q?lQh1myjR2NrvImyyqx3rwp2GBJqxkBxdt3ZB+izBMHAJ4VUPJ63F7UJuhIcK?=
 =?us-ascii?Q?H3ssWQwhbvKzzqqM7/b7F5oZUyV0KIqJVuylrUC2ItD1wOFzjOF38y8yOC9Z?=
 =?us-ascii?Q?nFqHGFlDFB6k0SJWblMn5zpt3atRbN/KO6eI7Gv0jxdUDWdB2A10a5UUxT1G?=
 =?us-ascii?Q?B8Fzea5eCweZOOHp35BeZc+7lcg/wMdCRF0DnFxdVs5NcORlGOxJVsyryCca?=
 =?us-ascii?Q?ApJnlXbSsa6DQuLPViFgCNh9fiNEFRtKvw7OItTDefYxanyJmCp1WU8kFcYR?=
 =?us-ascii?Q?XK74Ib55Q9NmDS99gKDEhRkrv09Cc4iCMnxdULgy6EiV/RnYFCYfbEeKsbfY?=
 =?us-ascii?Q?936MbBB6g5vtsSVTf68wHc3q2+hqA0iqsY6jmWbOrZIe6d/pK1wU+3+Eo4O1?=
 =?us-ascii?Q?gRmijN7dIUMf/4KW2ld6LPjCti9Jert6SJ5MlyFSnZCne8qejYY7KDRem7yw?=
 =?us-ascii?Q?5WBuxQtUfAR42MQaEeodiKhHPuLGc6SXCgfT1EBNH/tXuhOs41UBYAc3Ayy9?=
 =?us-ascii?Q?c4MdUIeuMcvw9FabxDyrzzJjZG5kuikeYu5UFUhA39LidEzCpjQC0irS0lX1?=
 =?us-ascii?Q?sXYgMdM2gs/gsaj/gozts0V5/mLGvEcXKbt425ihn3B3axiVNlNSaCGkgzJ5?=
 =?us-ascii?Q?8QxPGSVhT455YjBvwaP4Vr4z9tpzXOopJybarWNHUh5By4yML6q0eZuMAcel?=
 =?us-ascii?Q?Oxznb4bhEtWHUJuAYDhM/vAyw3Pa2cZ/onEKkd9obmjR225uUzXB1yO0Kku7?=
 =?us-ascii?Q?1lBvH/1aTjn2qXEwEtMYooI/N3Y0hajVQGtqLtcPlWo1rAYd3iVx4pdClG2N?=
 =?us-ascii?Q?diVNoY0Hwjr2cHh3X8uZHHnWZsiDml6mtHYcFR0t30JFG/WEJ0cS9bv6MHVc?=
 =?us-ascii?Q?iO1o0oodBNSOtepN0J4Qwot79+PdRN61taXiSAo6CLVGXzk+V5eTG5AvcR73?=
 =?us-ascii?Q?cpQ98/QawHdXx2tilRZMipVjdqIomDqG7TJ58pIoHn0tD8c8Cf0nhTBwK5oA?=
 =?us-ascii?Q?cLjgA41c00ex12f+NhW7+jgpxRe5LGuh0suYQbzW0lzovS9K9vv91rvXDAlb?=
 =?us-ascii?Q?c1O/7itEysOPx+5+cAuNGj8/AEcReQSTTmnZKJ68ADq7WHU0O6QbIqbGbhrz?=
 =?us-ascii?Q?Y6ICe8fCSlLdymCFazMwt8DvchQDZj3KnCWp7mEtkyTkKs9I2w2JFMrgLl0T?=
 =?us-ascii?Q?LzVBkmgQta2ddVk2uGDE0SW39CaIylAPQjnh4kCLbrshS2ZJ5tx3iBQy2/UD?=
 =?us-ascii?Q?7jCyAMenSpGLLWh2ZzE91yusQPMilLUryhNCL/kL59xnX2uwZhvdltZlTweQ?=
 =?us-ascii?Q?z5B3mZwvpgZCqzUWPZi2hcg8X6R2rdsY3RpHQjNlPENzBqNDGzdBxaG5P0tq?=
 =?us-ascii?Q?k1c4bj2Jz6Qa7IQLrE34O9gmRhmURs47+hKVRSbbDGukp8d/IDpceYxPNHz/?=
 =?us-ascii?Q?2XMdVcaPRXcoLzP2sp96kPeXfczyNLBptn9SwBUQsdbKMu7koTqKiS3VdhX2?=
 =?us-ascii?Q?JnBt67CBwxqqEbZJuNN5yo8JaHH7OlQkcLRm2Yn9elvDly4nEv5F0F/ObPQH?=
 =?us-ascii?Q?uktSj29bQvi+Q5OKedLC4fjhvmMaweOkgidPxPx1bikI/hL4XaviJsVIHVeh?=
 =?us-ascii?Q?J9bk6Q++uw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9766958-9b87-4209-9a3b-08decb121dcf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:13:00.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJ7KzdHhzONr332rWjmNIJxUHGdVTEUS8iRynVAA/jJTVu6isLtJO6VfdGvSR7Z6Ro9IJ8w5MJPNWbZa+VnP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

The vfio-pci module parameters of disable_idle_d3, nointxmask, and
disable_vga latch vfio-pci policy into vfio-pci-core globals each time
the vfio-pci module is initialized.  The disable_idle_d3 parameter has
already migrated to a per-device flag in order to provide consistency
for refcounted PM operations for the lifetime of the device
registration.

Pull the remaining vfio-pci module-parameter policy out of vfio-pci-core
into per-device flags set at device initialization.

This also restores the mutable aspect of the disable_idle_d3 and
nointxmask module parameters for vfio-pci, with the caveat that the
parameters are latched into the device at probe.

A notable change for variant drivers is that their devices are no longer
affected by vfio-pci module parameters and those drivers may need to
adopt similar module parameters if any devices have a hidden dependency
on vfio-pci setting non-default policy.

Assisted-by: Claude:claude-opus-4-8
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/vfio_pci.c      | 30 ++++++++++++++++++++++--------
 drivers/vfio/pci/vfio_pci_core.c | 26 ++++++--------------------
 include/linux/vfio_pci_core.h    |  4 ++--
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..830369ff878d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -125,9 +125,30 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 	return 0;
 }
 
+static int vfio_pci_init_dev(struct vfio_device *core_vdev)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+
+	/*
+	 * These behaviors originated in vfio-pci and moved into
+	 * vfio-pci-core when the driver was split; vfio-pci remains the
+	 * only driver that toggles them.  Latch our module parameters per
+	 * device at init time so that later parameter changes do not
+	 * affect already-initialized devices.
+	 */
+	vdev->nointxmask = nointxmask;
+	vdev->disable_idle_d3 = disable_idle_d3;
+#ifdef CONFIG_VFIO_PCI_VGA
+	vdev->disable_vga = disable_vga;
+#endif
+
+	return vfio_pci_core_init_dev(core_vdev);
+}
+
 static const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
-	.init		= vfio_pci_core_init_dev,
+	.init		= vfio_pci_init_dev,
 	.release	= vfio_pci_core_release_dev,
 	.open_device	= vfio_pci_open_device,
 	.close_device	= vfio_pci_core_close_device,
@@ -256,13 +277,6 @@ static void __init vfio_pci_fill_ids(void)
 static int __init vfio_pci_init(void)
 {
 	int ret;
-	bool is_disable_vga = true;
-
-#ifdef CONFIG_VFIO_PCI_VGA
-	is_disable_vga = disable_vga;
-#endif
-
-	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
 
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index dab82c078580..db36d903dcd4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -38,10 +38,6 @@
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
 #define DRIVER_DESC "core driver for VFIO based PCI devices"
 
-static bool nointxmask;
-static bool disable_vga;
-static bool disable_idle_d3;
-
 static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
 {
 	struct vfio_pci_eventfd *eventfd =
@@ -92,10 +88,10 @@ struct vfio_pci_vf_token {
 	int			users;
 };
 
-static inline bool vfio_vga_disabled(void)
+static inline bool vfio_vga_disabled(struct vfio_pci_core_device *vdev)
 {
 #ifdef CONFIG_VFIO_PCI_VGA
-	return disable_vga;
+	return vdev->disable_vga;
 #else
 	return true;
 #endif
@@ -111,11 +107,12 @@ static inline bool vfio_vga_disabled(void)
  */
 static unsigned int vfio_pci_set_decode(struct pci_dev *pdev, bool single_vga)
 {
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	struct pci_dev *tmp = NULL;
 	unsigned char max_busnr;
 	unsigned int decodes;
 
-	if (single_vga || !vfio_vga_disabled() || pci_is_root_bus(pdev->bus))
+	if (single_vga || !vfio_vga_disabled(vdev) || pci_is_root_bus(pdev->bus))
 		return VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM |
 		       VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;
 
@@ -562,7 +559,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vdev->pci_saved_state)
 		pci_dbg(pdev, "%s: Couldn't store saved state\n", __func__);
 
-	if (likely(!nointxmask)) {
+	if (likely(!vdev->nointxmask)) {
 		if (vfio_pci_nointx(pdev)) {
 			pci_info(pdev, "Masking broken INTx support\n");
 			vdev->nointx = true;
@@ -602,7 +599,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		vdev->has_dyn_msix = false;
 	}
 
-	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
+	if (!vfio_vga_disabled(vdev) && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
 	vfio_pci_core_map_bars(vdev);
@@ -2144,8 +2141,6 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
-	vdev->disable_idle_d3 = disable_idle_d3;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2616,15 +2611,6 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	}
 }
 
-void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3)
-{
-	nointxmask = is_nointxmask;
-	disable_vga = is_disable_vga;
-	disable_idle_d3 = is_disable_idle_d3;
-}
-EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
-
 static void vfio_pci_core_cleanup(void)
 {
 	vfio_pci_uninit_perm_bits();
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 985b8af5a04b..9a1674c152aa 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -127,6 +127,8 @@ struct vfio_pci_core_device {
 	bool			nointx:1;
 	bool			needs_pm_restore:1;
 	bool			disable_idle_d3:1;
+	bool			nointxmask:1;
+	bool			disable_vga:1;
 	/* Flags modified at runtime - dedicated storage unit */
 	bool			needs_reset;
 	bool			pm_intx_masked;
@@ -161,8 +163,6 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
-void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
-- 
2.53.0

