Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3C378D63;
	Thu, 11 Jun 2026 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213768; cv=fail; b=gHuU+WxdbopcWg7Dki2xCApG+gDe6s7BYLRuhQLaaa4lme4/gsjNVgK4+TBRmyHlzDb6sFn+hH4zZQkZhRlFWy40E0KfLufccpWmHmI4JH+VahuFsNGmxfEUU0PnBbe8BekGSwwbgwueLYsFugXBJ1AjPsVRe3Bxt2mUuxkPGPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213768; c=relaxed/simple;
	bh=U962TqF8gfQvouWuqcOE8+tfnRbp6828TJZXk4g/mtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HREMXChVFh1IOrODdt/Ie94ib6/Kdo/urnE8yC0D4CXCZR3wgnM67FM3yXa+Z2KVns082AA7mFjXCBp8Mck1dXMSSPnfrIN9aAXRIbadj78VFZ4G8UvMS3//gOAF1G1u0EAiMKYc1IHuyB6o3do+NJw4f6d41TuwFYxplGkq1Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sv+xeuLu; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sv+xeuLu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naptbbs5DA0HQm+kLCKPoWQ1gj1EqvSWVIJmn0vUelPSV00BDhuudXlCUtEBi0rN4UkZcu56fmaHk/DDDpIFE53eO1TPewZe33B4NmjWDIVbmrN2DVdjQM1ghhkkvz/Hl/B/3y2mObK8KIXdbDf9a1nIpMHa5aCbPYKJluYPeFirLMyVsl17d+75gUZVZjqI1Yi5d708ZaBL+o001ar/I25WsdeN5Kp87poXUrsfkQhzbDkndYX4/DMqGaPe0sPhTx+QpLQq9w0F4GRBY0aNgYGQXZdx3WWbQDNquklxNDdHAIT7jvHjoyOsJxtwMPd73swKb6I8yolbNOXTxeMjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgU9LMUvkel3FUUv5Kxm53NW4M9qfc05aVnn+Xv84aY=;
 b=a4jurC6R7IcgyhzCRv14VNJ8AAcbfUyIeYUcdcgJe3ex9DWsM8wHHMDLYftVGEiObqe60+EiXBSPp97wfnQujQAXvsKjJlpRIdDHa4LCDaNcZUbDAOgC8BBongznPSuwCzDfpcXd9RSKJ49oGH0pmLG35a68haMjb/KA2+IpRSHYgMiiaPfVyLaFjeN30QEziQEQ6a40S91/CbsNm3aaKfVWSDBkVflo1DeEbbiVVEUvYNrGdIE7DR46wRgzxKc4mwElALpJeSpBSR5NqXK9Fg1oP3pxt8iXaktyjMLeOTCIm4Xt1YLTK3jcIriGWZPUx9ht0D/XodfCe9ja+C8qvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgU9LMUvkel3FUUv5Kxm53NW4M9qfc05aVnn+Xv84aY=;
 b=Sv+xeuLuzsuLUgRLXSD35UW/01sKMDz9ET1i96SLEbB9Zs7t7wAxZJs0DiLHKMLfP4GNmheBmbAVTSN6P+GS0X4PwGvBswM+R1utTpbzrcJrO7L4b4aJYRIKFYneOPFf9loRfV1hmNbRDfNhonxsZQ+P9pLCgZcm4Ppez/26TTnOG5nF+mdS4SQj/ZxgAGktHBcS51koZwUR/oTj01Bs4n1cwLgmXyzroTnSSSPwHxESF9/9sAo7xvxL6Y2AsR6NWAd0lrMhDShfsaOcmHqVD3vgAMnaNPQ7h9GbCY/9Bpxhhxv7XSM1w+prxp7Fi1FalN8buawaEdkiJ+LzqNyoUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 21:35:46 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 21:35:46 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com
Subject: [PATCH v2 5/5] vfio/pci: Latch all module parameters per device
Date: Thu, 11 Jun 2026 15:35:38 -0600
Message-ID: <20260611213539.4100590-6-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611213539.4100590-1-alex.williamson@nvidia.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:44c::15) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e6f3d2-1bdd-4476-e76b-08dec8016614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|3023799007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jg55xdhe5bWllJDAnwAvm+7wsXgZZUMmMSEIpvm1+CbF+sxH7QqbLnXL+uEcW+fyIae6yX+WOq6f/WSdOL0GCIlUbpg6n6gCmL0zyHqorC/5oflPZ98agfhjTZVneHrbhGWKKHhI1XiCnCkh0QMory1FvKJvlois9434dyA07otGGjFIWhVf7waT2MjhciAB3fQp15Mk3RL4JMP1Mqw74EyM4FN4KAPc2ODfdz8RLe44juMa2Cdh/uErggwg8cbGhDANovqgf19tArgT1AHJYBDcBQWc2x21bqqrw9c20bEDAfF5E7PVcb15GxZM8KRLLPFOdTljP4uWt7+c15ImdEAUzkQv0VPjaDpb5FW1ZD3Pc6LyQ1Piti2ol197BNIydA0U1BRDPS12jjY91W/jL5EiNP/5708HgNZU8k6qmfTQCANtOk6413g2DaCEJqfK4Q6AUZs8ssv5ZAKdwzoXFWUSV7hGZG8AXkhVjqp8VpMuBj2mvKPJDuF+/Z3DfLeaN0WUzkVtmp0Dz8aSu3SHcZKs0xqr/05oP0HuOfHP4PO0wVKYARr6iH+TkzjxwQefb8GeTPj7gzeBJrgo5I+fKaDDS3ddoFyoaPWWze1+wM5K9XmmFyuwCwKfSFZqwxFeiJmxJdpkYQwvSFOAaexT4sfJ0IA0ARJVvRjkE6A3rx+g+Y4YG03O+dD0VPUo3Lnz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(3023799007)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SdKDhuQPiKKaNmy/WDFzCThnVAR+IXE7B/tHbK+7F+in+AD+FqRNbizNqCgf?=
 =?us-ascii?Q?BMOIYAHi5mlOZIWAkA6RFaWyxTbygTg4rFd6gAW7IcuiPS5ZEBSZwhJ3Dwsq?=
 =?us-ascii?Q?+8Pi3ujzUu3doUYkGhUJK88KrJ0KOZltTDf/HMCIXl6hBMrzz1fn4Hu9tVCs?=
 =?us-ascii?Q?nyJVqCqV/ofhqca1dgaP+6qEDZILlvEPYJXAWXKkyexh3F+vlwteJ795tJpB?=
 =?us-ascii?Q?g+dk6X02qkc3yvut242G5hJU0oHJ0OhquJKAGzjNkGfsxmW8ezBks2FlNhIj?=
 =?us-ascii?Q?9ovNj5FsNumcEY/pXHnA3KthKal05Ff/DD7yGcANn7IxwoVbnLNdgh0j1B6+?=
 =?us-ascii?Q?omc9+HRe7f90aZJ/cJGM1iY/ekwRoKkAL0qWcZ0l1liOwo3gAnGzmfb0jewX?=
 =?us-ascii?Q?6RfRLsw8tGdPY/DjqZviLx9S1ZxQi7E719yY8d/T2SPf4vkHl+67kr4VDHDq?=
 =?us-ascii?Q?8euR9e8I7ne5Zvpd/xXPf//Azt/dDAtZ5qoBb5RJ4evFnc84bJvUr/qe8Uik?=
 =?us-ascii?Q?qznCICKnyop6jEeqlhvvG8CVO7AlPo/9WRAxawvgLeTrXpEGEff1ng1sDNwi?=
 =?us-ascii?Q?LMuMiEjtpnWkUoqJtiYZwMBKd8A7rz7mFaOPVxygM4FcBLzvD8IsfzBYgJN8?=
 =?us-ascii?Q?iQefRj457jChvFpVNiA/lUqYpkQW+D/9LGgzU8j/XuVX0NVp/L79PuvDKmNu?=
 =?us-ascii?Q?hhhp4jgy/stxWLR7bdWaGmyrSLiC7yPRCCNfI8MMVCF/c1VX5pKwz/a1ZWi9?=
 =?us-ascii?Q?Ueyd5UeRB6ZV+IOZSTcq9E66poZ0AbLb1HAIjkMvFkcSTztrPd/SumdzGy2c?=
 =?us-ascii?Q?qwiNg9VhlJ5SnjUfw7Z06vpZhI6qRVd9dvEwiBDlEJarYv5HmIJEloO+I/1U?=
 =?us-ascii?Q?wIXMWIT0C1VOosiYVC6Ev7ZAHwEjs+U0AiTAt9nZMRt29mXZ1MzRM5XQayDi?=
 =?us-ascii?Q?qSATJBkqeI437wKqV2qay2Mdv8up3lVT6D/HkKIu7RaTeGyuO5huSTPRmEYx?=
 =?us-ascii?Q?VoXxd8BhvaJYaVk2+v1bMNoyeQRRo9Gt5HJ4hENRqYNpqr+ZQTIZXbtX5Vml?=
 =?us-ascii?Q?BtRoip7wp06awTNu+mBQvj+6K5gBBUExfIdAUhM3bAu56SjI7uOQpo9W9n+G?=
 =?us-ascii?Q?Sr98a1fSdJ6+JYlfwA5CHa0lH0zOEQgMtFnNseXYDacDI2xYbIJK7wvtoj2/?=
 =?us-ascii?Q?sbiCMMxoD63YfHRqSyzbTkHimHxu+EXzEdNIkhaRlYAdTYvkxGAa1JKgf2q2?=
 =?us-ascii?Q?gGuEF5tE9kPD/tnpZr3hVWRG/QQiBHCe9x75UvLVnHoYQdMjCmNMhDfCHNFv?=
 =?us-ascii?Q?a7pldGULOu4a/a5/qZf3VBta3+KMfLupNUO4b0IjIi4MhO0ZZ5yNX6ky/mXH?=
 =?us-ascii?Q?k/SO0nyX2GRlnCJBcdiCbJ3iGmuCfo/zNS0Hf05CdOqC1wqyg9/h5t6IF/xu?=
 =?us-ascii?Q?WhQZQWCmCmM9nEuR6PTIP1LgTrxzHRgoieNayxmYhiqI7P5JMym7g1LLxexi?=
 =?us-ascii?Q?h/GPyXGa94GdPz1cxsBRg15AmaWe9psW0H5OmDzgN5PnMD5zd/IB073MQ9Zf?=
 =?us-ascii?Q?UXbfyXk6cc5qKHxu3fOMm1OKa4Vp7a/KlkgBMxHdfLWMaejuSrV/hslMOHtl?=
 =?us-ascii?Q?hpsIernfgNX73SVk4xjigOKgGketlLnQJmrA679ScO8zGweTPi/Ugtbi4Zql?=
 =?us-ascii?Q?mKvsMwAihltIvSLY9rIWLKeF5VjoFO45ueZV/q+50wP7QqBLr/CctJLTlaxr?=
 =?us-ascii?Q?a7lFymyVBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e6f3d2-1bdd-4476-e76b-08dec8016614
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 21:35:46.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3+vhTfJtN4xniVA2P0p0rJNuZ08HBQxF/1CkF7r2yKgkk9LuxsCq1eatTmo3AcPs8wkWbLQmSFDUKHcoZlTYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706

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
index d2d3fddec610..76725c0e7dda 100644
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
@@ -2625,15 +2620,6 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
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

