Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD924C9576;
	Thu, 11 Jun 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202347; cv=fail; b=bY4EECtOrosXYOdDGvSDJEybhtbMYnaaflabsUa+iTXcnKGksptjOQgP2dGvNk3JVfpyRx8f/57azz37xYTEyyYoRlLHAyH5U0KTRbmRgGo5bzS+3rxDE6DN/Gxewas1/Jau4ecAWNR8nbq7R1P5onnka7SayU5yzhDaXMYLOcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202347; c=relaxed/simple;
	bh=Mmwtt/R6dn+8iwf9OaE2ypkPRMRWGbqhpJGJBF16VBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSjaf+wHefQ3iIfh/9Qd9UwffedQuLkxOrkhMClYvCuXR5TrSevA5Il+F4dXwgLFb01dDgzucjDe/P2D737RPwDBosj3AbGOlf+9KsT7fk3tVnjg+PlOoPE7ClL4r02wbb+9mnD52eXPtRoLUdYl16wPbNgpUVxPvwMxVtCLYB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aywtkSdT; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aywtkSdT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5sZT3YJ7RMbdYfb/ROjVSp9JAUMywUNjc8J1tZFFY+Q2xi8Z+cTlif/YbJHT3IDKj2WdSqoVBERydOWzLuYD/zjcJT5vr7TDbgjk9YjjXQM5anBYTJm24Qzr/SvGffKV3Yh39CkMPC1lqxwem9LM5xlfQ2aooVWPInbrX4TEzzGwRuGwMp1DXIgIVG99hDVDn9kbpHN0gvX6eDrPVuytxDoHPVwMGc8FqGhGrZZP5tzZLdMsXmtmZOXkogO6+QGMmWPaYEjjWq7RjDLk4wcV4oCv7pfY1rPHIHJWXhW+F8eU6i+6xlBAgVMqZSG7nSF2TbkHLAo7nlG+eidwIm59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2locqzhntCTzfe3YDnOEASo744fDUyG3HemAORcLskA=;
 b=gkhGXdLBDI2/80jheEcbNQVfn7wqa0helJpAvxo9W+PyPMZDaaQbT5A2KP7fXWbyJJaFhvo3qsROogFUgvBDeEDsQIK7YcjWeXVVkbXyM5wjMJZbxFSmu68d7pSmsvE3lXI72EOVu3aGwMAZVsyd0Wyj2yhlNTUyu+98+bZ6pduxeKgVwgAT6f8xN8CgKA6FkGo92aklE9m0eW+8HBfM8E45B6STFapTNIQ5MWma5D+B/nNxC+Emju5LJChlXAcQ8eBnoqGpAOgkSvLLKRBbjUcbrA9LcpZYKJug4rn/mqwx2JxxgJkFPv7QHnRCAEndowl/G7wGIKcMA/NBxreBIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2locqzhntCTzfe3YDnOEASo744fDUyG3HemAORcLskA=;
 b=aywtkSdT8HJtuLXOdMTrNTPqOvg1BX91L/n/buS/IpmltJHHt1DQL9MJYeKtmOe5erJdagnd+3XoAkLavTUuBwOKtkbe7hAxRZwYuyZzdB5QrUZJ1wy+zrqUNgGCcuguScrnR6cHHahviBA707aSZBRcuLq6eXPey9HUAjffm8c3JO5onSkhHg4w63J6Tfd+w8QH8+0hC6Y2IwF8cMVZoAHwcEyFD6r+6VOYi729Xe/HN8bGXiK4aLyKRA4TnMQJRIJ+v0pFKTMqF9cBCf0ozc7p4VFzvsE22H4MLnYwnRkt5TR3+TyFjEBaJwSXC6N3nTREfe0jAYYLGUhBlFNYig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 18:25:35 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 18:25:35 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com
Subject: [PATCH 2/2] vfio/pci: Latch all module parameters per device
Date: Thu, 11 Jun 2026 12:25:26 -0600
Message-ID: <20260611182528.4004073-3-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611182528.4004073-1-alex.williamson@nvidia.com>
References: <20260611182528.4004073-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:930:13::13) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8bf1d4-7f3f-43fa-1a2c-08dec7e6d434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|5023799004|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9f49XA0GB59vcyzd/Fza9FZHLxbGnQTIzSN/MImiKpiReEXtR0RXl1b4FR0gxhn8alOAB32M+DyIUDkyD0K0GLGWoZq46sacf3FvIAWyW2TdvfGS8I43o8tA8ZR7Btuj6eUPCGJ+Ey2qeEX6w/jhkre5MhviVX9hnuCY53gsmRow/g7VpobJ76ix6jB//6JeBG29v7SMSdu+GCh/93g5VNSedqhOsUmp/D0qP0BF1bs5+3GLLPi8WME75c7e5wBCtxZL207qQ4SfRawk2SwIcmMZEximZQZnzhxZIWa2gwSxmMqy6eu/cTs5y+mwnBJ3/S4bL/SeMAVg1uWo+lH9rmQ8/FBOtTcwMvU/bIliSbbzylhHVAIFno3mSRiQ3+gNcacSUrZIhAJpdU0nIdGOrdbvmPqCuwr4XB0XULr+lAwfYbX/Ixh1bP0xhrPzB7UqTgdj5KAIAEsPo8czveG2wMYCz7/T1NZHw+ixsh4NLyh3cMcJNMgXUbsvThNRcp1wVS302Zbv5ruf1jdiEYq5MPm59WWfwMm8bxE6MdAeNvdQ0lpRpnIzotcqhUk8P5SP4IASY5a+a+ULE+QcEkAwpE7WTscI6ln6LnbC8aIQJOZ0DTAqfFm8UK91dLg23oLfex8rjgFw0tkYT11jx0dnmXrqUNPUj9xgQI7HFyzhxZVFxvTb8F8jJE0BwpT5vPXU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6M60Q23KZlHsbWLxlNTuCJOdo8NS0Gl6B6baYW1BpAYTlUacQZAdjfuStYQ?=
 =?us-ascii?Q?kkHIB/iF02MuGMsUFHVBM/ycHjybfW9CZnyRMUJYJapeQne2LVHKj8rxwrpq?=
 =?us-ascii?Q?sx595IWbKQFJ7SKWerQue9WrCyohnljDCCBhXIFwRaNsU0Zj/pLXSSjaxvUm?=
 =?us-ascii?Q?M1PXuZ+cFWyejHH6HhsSc0rtseotjBxZgwi0y1by9TQ1ffL1CeowZRKoh3TR?=
 =?us-ascii?Q?ip6Wga5L9vlJ6kvjXkCMlHjPR0Uq5gGs4rZ8CzZQheaunO6PVD4eP2j5z8PG?=
 =?us-ascii?Q?mENTixp7VaVIGOrfELFpKD8QzntI1h622Lm+Aq+ccIOLQ4glCyiOgIS5n2vW?=
 =?us-ascii?Q?z6/fSxJ6P+POPtrALwYTIncBTSzV0EYxIVRjmAvzxliWge0Yyh8Ga5AYdgch?=
 =?us-ascii?Q?83KlJNevnz6PtxnWZoCqFNK4j07CYbUX5q7ER76How1VTclmICZOWb69s+jw?=
 =?us-ascii?Q?+ZgB7Gy5SSSu/uMntCwzTkmgUcte/NIkBuTN76IF8dOXLFDhMnOI6mAit3BW?=
 =?us-ascii?Q?XnyMf6WQLlvXQdSwCxrRghUsC4p93UnMoTf9HWIa+y9ub1ELVvCB45alIos2?=
 =?us-ascii?Q?tnnP36x0wROwtl4zZio0cBSURmkt6zw+5ihjWok/BgjVzpSCieZEO30mtq/4?=
 =?us-ascii?Q?v3jZaz9OJ7h0Gs+rox4w9vr2F9IPyxIX6MQefeAac7c7P1mTFobiCS+aTDAw?=
 =?us-ascii?Q?ORzGjynvn+6z6uoT2H37dBj3SxvR2WbOdMoZ09ggk8/GfllqOV+j0OJlnl8N?=
 =?us-ascii?Q?d3PHaavLkqdfyO0EB8gmG96ZjxF5Kuk6mu0v7dxT7MDBJ8DYYjGnsuj5FgTw?=
 =?us-ascii?Q?gwMCaurD2NYnM06g54O9wDUTioUz56yrc3j3Ogw1vYjKoZ3yXnQcM0mvleQB?=
 =?us-ascii?Q?hIi/KoZnaCexlPTWAg5RD3M4VLyTt7nzd6vOGRInxFT2uW6oJtPhkXy5cSYk?=
 =?us-ascii?Q?jMn2znl1qHBCGEP4UTT+ldiIezj9T3Fy5spi8+RttsPCtGqFox2YwB7vKThN?=
 =?us-ascii?Q?NS8f0UUtliOFLOngA61N5dUqWG3u3A3xCv8I3AuxfDmA3BwEMFpjyUtcEL+N?=
 =?us-ascii?Q?S7LsYt7sTGBXiL/Uli1AYjpBj8X0Zb4mCOGwLpEQRySKJtwc6w2GwmZ+3DYw?=
 =?us-ascii?Q?T3DlOxdIxq0Qh8M+EE0bIuDua1rG3NVOdUgG/GRILUEvkk21ZAsCN1U0OIBp?=
 =?us-ascii?Q?pzFt/QEcbMiAnY8+PfA3MIv4XIjHZH/3WLtN4oYvwp0QqV4oUvhLSlihbVjp?=
 =?us-ascii?Q?DHZeenF1/w/mGmerH8UFJw/Yn+xfkZkQTj0buuRp9stOR9JDqHNohbXjE64L?=
 =?us-ascii?Q?lk+EV/qWdI3ECNCphvMsC/oGLp64GIY6/B957Dg+wCKeC/s5L2+7/tXweK9C?=
 =?us-ascii?Q?vxTG4hpR38XEgr4M6l830idFigzz0CpwayH9BdN44kUX876eN8ne5Hs1zhGd?=
 =?us-ascii?Q?pirxWM7PRfzfTxIJVM3oIFTxwz/p2LaIihKPX2tnfb/NCGYfglA6odfnUotg?=
 =?us-ascii?Q?exJVEbX9321cFpaw+rhH+5amMZJR0ukzxuHPrIcZamySuWwxBs0fUJLCyj9p?=
 =?us-ascii?Q?90bE15QUtD8/gy9V4g8c+Nv4/AmIXqDiGqn/Encul5vvhJH+4KhgtatJifpt?=
 =?us-ascii?Q?79jHoV8mzlkfJxpak1YMwLqIIwintGTy/StIRF9OuEFo9IUxQluMHLfVM5+b?=
 =?us-ascii?Q?JTrXvmFt+MGW0VI66a5LFcHZf2nYyz9cQdD2eRpKZGtYtTSS2cwXiVhVcudV?=
 =?us-ascii?Q?jQ/QtbdSzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8bf1d4-7f3f-43fa-1a2c-08dec7e6d434
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:25:35.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQwdyVTf09tl0/J8rdQ8qG159X3pegsr4/0bdpjG9KZf/Dyv2QifJgCbj7xctRl73B9PSYCy4LYq5spEOx66uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579

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
index 9f71eae0cc94..61cf1a1996b0 100644
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
@@ -2624,15 +2619,6 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
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
index 27aab3fdbb91..74b950d73aef 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -128,6 +128,8 @@ struct vfio_pci_core_device {
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
 	bool			disable_idle_d3:1;
+	bool			nointxmask:1;
+	bool			disable_vga:1;
 	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
@@ -158,8 +160,6 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
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

