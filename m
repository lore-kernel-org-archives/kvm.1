Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CD3F075E;
	Fri, 15 May 2026 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882670; cv=fail; b=rhL+xua22Jl7WlK1cyws/6/C5tpNysK7EIzeUTW9mYSzTx2O1NJstdZBhQLZlhamHqJ8nNB7EeB32e4yHfcaSzH0tTXIMXz7BPF3Sn976MVw6EeHn4d3we5qC7KXvb0ih37Q4u92TgPtXSwpn9XAGQXOU0xXNkx0O1MwDkpj70Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882670; c=relaxed/simple;
	bh=z2HaZ74kOjZfQig34dLy2/V0/F/TlVQUEE5uLdtHjZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skKRi2y+u2tW5GjiVbD0lEB9FAdMfne/GskxunAD854aX3ZDKe7gWS/97QHiqGakzthQV2X4kM49sPPH6Qmu8td3BDHczfFe3z0V602SzRtSAJMRGZprNg5bkV+9dVacGR5+9atcDuBE4gDL59kj3jYBAtjtsA7XivHNGXJ9GvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p0VoytU+; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0VoytU+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLsxqGXJct9s2xpwevV2ET5wSHB3tFO5JVmNPiD1Tf3EceuUK0aUGhScT/Cs8oT/L7Jtc46clRfpbqTy69ZgvUd69G9t4vp4CuxPlc4B2VzwEc/l0llMuztQFciUOnJzVGMRhRxxJJ8lq/9Y5QrNaastx2kan3d0oiZYsWpw63z+6nIuN8girKKUzDT2OH5n6Cl+HuJ0aCffaFEnT69jdNQvEzisPaI+o09D5qEkKpkTc+2GlOf20uZJlj+Ok1Hf1s1G3TnDg8/vSQ2nVgdm/O9vrPlq5FbUSdmyl6wO/usVPOQN92Vgx3GZ1+IoJ3djaUkLTmAHyjvSSxAsdAu4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z13udHEk2Ny/Y4YnhgYrJEeTPZj6ZvrWYqY6KwDQ3z8=;
 b=MmQHOcEffzryhA2BY6tV07f9mIvOeJHRYdmNl1GLirZKsYGbNKPGeM6eGqbBUB0SyxMiXr8S9OQLJBbEurOD5Oo+VX1nrs7X69OaFzWrIdSJ5t38SXHp+uC/6uKYDXgmUEEEh2BSgkpor2ngoQkvYn4+kStUYPK9fORM1nT2ptK0DHW4YmeZz8jH0nJZN7ZYVuS4cIT6Z8cPAeH7r3syypJiSuB+ADuxvMLtGPVnzH8Fe5cvixVKoThhzOkLo5t+9suwspReTc56C59l3Ak87PlrBZzQrAyCxX1Q9OvGgixKnDVTUCv75x7J/iF2Vd55fdUP6voS3IxE72bnetIw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z13udHEk2Ny/Y4YnhgYrJEeTPZj6ZvrWYqY6KwDQ3z8=;
 b=p0VoytU+Mw0WPp2VIenP9/+nk5FkUkjT2eZmAu4XxCLYJzAyu7bzbc/bV7Ne0MMe7c1VbzMta/AoSiN4qdEotnrtHf1Oe5N76SpwfrYS/huAWFMvapcP40j3im/VODZq547+IgOx9Ax7p7mG5CCC/NbQB4a+yZWD3LdUD42mabbrG5mEPUy00Pt1LB5ewGVgAKsPBtgU4nBxhnRaHXTARzmn2jMeD6o3qAq0RXIe8PXrS9fOqAry9nVOcrfnc6sWBtwcdJr3KIPOaKIikTl1ycNl248no4zzZoDg26O5yjtBBMMvhDpZiBsK65wc20if2Z6zdJfh0kPaN60Dz4qnVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:09 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:09 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 7/8] selftests/vfio: igb: Factor hardware programming into igb_hw_init()
Date: Fri, 15 May 2026 16:03:14 -0600
Message-ID: <20260515220330.565792-8-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260515220330.565792-1-alex.williamson@nvidia.com>
References: <20260515220330.565792-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:930:44::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ccad37-f15d-4908-34bb-08deb2cde3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	QfMhgTxtXWghNkWh0rK3I3ugdYZy8XlAkjvSyhxalTX/YFo4SowmH15fpnpI8/WOwU/sPYjld5bvTRVj0dlS3C6zwx6sL1CA4kykIDDh9gUq1zlQf+L1BzI9mS8sZOqOzMj012746xaQEr0MAboBvO3YLMnyRz54zHvtCMV6N8LzufcncXAwFq1DKVQVnkz45abrPUXx1z8CbjscPyQRqxUvdDjNZ06XZhBMgSXrQiZW2rgJ3znHNRag68TEytkqkp0qlRPqfkP5oAC6BuvkqHEN40aO7YF0GxZxiRLjy262rUogYQ3TfrJdk0jU7Z4k01zzSePL6ABFLZ5LSXf5/FlUJY5KdPgcnIoWa0BmFc6CGR95FOPA4pjkjqW9r/1oF0xhb8sSOy6ptQ6rSnXa9FFfIrkEjIpowUReuFy0DBPxW631y5bX2lXut1fjWwAWcJrLY3KgshhFOGQGdlfUWiRYcpP+ADeA6eeHOyY2dhlrQfphLNCRB4usK2Q7JcPxda2qeWMOAXfItvO4wqN2ulPWhjw0pAB57iC/6//afQe0ffTyGpQCtkZjYKkVFf/skftV8PxZ5mkhrJBcCeyjRT1+rz5fAF/Ob0VHqALFqVUultpa0gUuWAJvsfLBQ7luU+R/uABor+iBHDp1X/OG56zYJtv9m+biHAuP0a5CR+PtPV/7V2hT6RY+g/5BxVfW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DxRE22h6BWR/RAdtp10biGmD9yWrZtoCAzhgCNV5Fxa8bgIbDQc806079yTC?=
 =?us-ascii?Q?3MMDgXb1FXcLejlgsJpq//N3yZqZXzKBDct8BdwcfrMhYhCwuUlbwYwt3ngM?=
 =?us-ascii?Q?LV1gHVB7N41Q7nxmcOIkB+6VXmdyYR3k79xW1UXCMcjwTkSBaFmrB3OguCId?=
 =?us-ascii?Q?RRnj126c36yRLp+qS3EXEHGjBZfs8hs5E6Op6Q/bHCNn9gjhVjJXLBLegcQu?=
 =?us-ascii?Q?qaHo3/gc0UKz6MDWb9UZIdZerfz1z7s+7eISS5wqKdP2CfU7JhoBqQLKxCHl?=
 =?us-ascii?Q?j6jEnszfPelJaB59pFrlOiES6T+KIWr/PcLW5uqVmqTv/Y3MGtHQbu5O3OA6?=
 =?us-ascii?Q?8PnX8sygvTTVshn5Qpkahvuqe3t+9ST41GuTwGPuypCLhNYNRHVMgcLdZzts?=
 =?us-ascii?Q?8C+zaWPwk41srVZxAB+0D/7ShZRWIDv44JsuYBiSzpDQLjC4CutnasfwZdfI?=
 =?us-ascii?Q?AY+xHhfcU311MnXvC5jAsu0S/epytAqL7fz0AfN7EVVis/WHzGGLJJgkNV+i?=
 =?us-ascii?Q?/zgl5sfv6iPgE/j5htL+0dS6dzuMrPxBDIRGN6aScjSX/QHfp4/SWHG0PQkp?=
 =?us-ascii?Q?pdFj8YM1UHqF7o7o2xcYJ0d50IfExu0HKLTEn7G0T5WVDkSVPYZb+C7hfFyJ?=
 =?us-ascii?Q?jAqmJzML/uJMujM3HJHlVNwaGKbhdJhepKjF4ztttUMh67HRvIIrJSGCaxiv?=
 =?us-ascii?Q?g1aH6B7njvQuLYahihHOjVL6RDeJKMk/269x6IDDbNYwt/wytn0eWzzEnC4Q?=
 =?us-ascii?Q?wIhaIW1oeujLL37hIYzi2f1w38KL7jFjIQOXc9m4Ofp9IUU/AWymI82+NZzu?=
 =?us-ascii?Q?A5AJ4c48K+IpBlacbdtvyM7piqjGA4sq7kgxeyKJg492lpMybqmUo8Vzt6B6?=
 =?us-ascii?Q?N/2QRjZXO8J+yOdQXcA97vGky3reJoA51Xc7i/DdislrV88HuTFlA2gv1DEv?=
 =?us-ascii?Q?S7wvtYpnwXsauFeChBIZyQZJUMXc1Kj8JDKAsf6J+SQZaZvbnovRilmHJu1u?=
 =?us-ascii?Q?Av1aqZtfGyFiXZmMzx8WW1gimXmEnOJRYE4SKh8UOa5HHaGKEsQYBxRp1KXf?=
 =?us-ascii?Q?nPDTj8jGohQU+dDJK2ZyXiLjUJSMWYB/0KPH7RlMqRRplErz/HIrHnRZ5MDC?=
 =?us-ascii?Q?F8C5S9D6/klRrk96XbFV9XAWWlQePBgd7PsUKVc1qKrYXMbVXYoRSFP87J0g?=
 =?us-ascii?Q?RHpP8hLvdp1kVYrPIHXKvw+FiG1KD43370B2vitZg1stMqldjuDVUzlVonb+?=
 =?us-ascii?Q?sO2AHyBKWG5MewZ08PgjQA9ObcuCnHzRU/px76K9A5oRomqfsQADy7vbbnD8?=
 =?us-ascii?Q?5S1cVN5+LySdoa8X8vZ9d1sH69ymcueARpaqrmtSGQAhb1X+4Xg/QPz48IGb?=
 =?us-ascii?Q?aXe+qK7rD0BcpMCTG01DtqhEByLnxO2TsKVUN5TnRNYTGyHPxqDYzqI49kyL?=
 =?us-ascii?Q?Hl12Ylq/VGwjrBu31hWR29mUfNo3y+2U5hl4+LLhDVzqG/BGAkFGTFnURmbE?=
 =?us-ascii?Q?+y16jJsginSGLjJrX9wlSIXO+b4iQSasVFZ6uTcOnHVynM800vBHczojrgQ9?=
 =?us-ascii?Q?TIVjKCPmnRms3x1ou2OYmcGOp5PXxnaJbBIM/nkBbnguCAzfIa6IYMKIPxXF?=
 =?us-ascii?Q?jaVmF3kFyEJLfk25flkF5s3rrN6jyIXD2AqLh4zy369Vdqs7IPLCedisBWZm?=
 =?us-ascii?Q?1ktC/9t/GCny+ZFiQ/xGkKIZk0s7BSslAdKyKVHScJtT+V1KQv9hgYeGjwnC?=
 =?us-ascii?Q?4dJpf76Gsw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ccad37-f15d-4908-34bb-08deb2cde3eb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:09.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHfAJVb75Rtq/TgF5v+/oYLQ8+gAR96jSopVFB4KbzpvriG96l7ZazWObyepmQKbcHSJXVr0pfxoo9GG7a7FGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

Split the device register programming out of igb_init() into a new
igb_hw_init() helper so that the same sequence can be re-run after a
VFIO_DEVICE_RESET to restore the registers that CTRL.RST clears.  No
functional change for the initial path.

igb_init() now performs the one-shot setup: region size assertion, BAR
mapping, CTRL.RST + IMC mask-all to put the device into a known state,
and vfio_pci_msix_enable() to set up the kernel-side IRQ trigger.
igb_hw_init() does the rest: ring pointer setup and IOVA calc,
CTRL_EXT, PCI bus master, GCR, PHY loopback, descriptor rings, RCTL,
TCTL, GPIE/EIAC/EIAM/EIMS/IVAR, and driver-state initialization.

vfio_pci_msix_enable() moves from after RCTL/TCTL to before all
device-side programming.  Its only side effects are the VFIO kernel
IRQ trigger setup and the PCI MSI-X capability bits in config space;
neither has any ordering dependency on the 82576 device register
writes performed in igb_hw_init().  Performing it once in igb_init()
keeps igb_hw_init() reusable from the reset recovery path (which uses
vfio_pci_irq_reenable() to re-arm the existing trigger).

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 49 +++++++++++++------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 9f93ec7ba8bc..ef242ebd9d2e 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -175,7 +175,13 @@ static int igb_probe(struct vfio_pci_device *device)
 	return 0;
 }
 
-static void igb_init(struct vfio_pci_device *device)
+/*
+ * Program the device into a usable state.  Split out of igb_init() so it
+ * can be reused after a device reset to re-program the registers that
+ * CTRL.RST clears.  Expects bar0 to be mapped and MSI-X already enabled
+ * via VFIO.
+ */
+static void igb_hw_init(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
 	uint64_t iova_tx, iova_rx;
@@ -183,23 +189,12 @@ static void igb_init(struct vfio_pci_device *device)
 	uint16_t cmd_reg;
 	int retries;
 
-	VFIO_ASSERT_GE(device->driver.region.size,
-		       sizeof(struct igb) + 2 * RING_SIZE * sizeof(struct igb_tx_desc));
-
-	/* Set up rings and calculate IOVAs */
-	igb->bar0 = device->bars[0].vaddr;
-
 	igb->tx_ring = (struct igb_tx_desc *)(igb + 1);
 	igb->rx_ring = (struct igb_rx_desc *)(igb->tx_ring + RING_SIZE);
 
 	iova_tx = to_iova(device, igb->tx_ring);
 	iova_rx = to_iova(device, igb->rx_ring);
 
-	/* Reset device and disable all interrupts */
-	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
-	usleep(20000);
-	igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
-
 	/* Signal that the driver is loaded */
 	ctrl = igb_read32(igb, IGB_CTRL_EXT);
 	ctrl |= IGB_CTRL_EXT_DRV_LOAD;
@@ -284,9 +279,6 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_write32(igb, IGB_RCTL, rctl);
 	igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
 
-	/* Enable MSI-X with 1 vector for the test */
-	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
-
 	/*
 	 * Program MSI-X interrupt routing per 82576 datasheet:
 	 *
@@ -326,6 +318,33 @@ static void igb_init(struct vfio_pci_device *device)
 	device->driver.msi = MSIX_VECTOR;
 }
 
+static void igb_init(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+
+	VFIO_ASSERT_GE(device->driver.region.size,
+		       sizeof(struct igb) + 2 * RING_SIZE * sizeof(struct igb_tx_desc));
+
+	igb->bar0 = device->bars[0].vaddr;
+
+	/* Reset device and disable all interrupts. */
+	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
+	usleep(20000);
+	igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
+
+	/*
+	 * Enable MSI-X via VFIO before device-side register programming.
+	 * vfio_pci_msix_enable() only touches the VFIO IRQ machinery and the
+	 * PCI MSI-X capability via config space; it has no ordering
+	 * dependency on the device-side writes performed by igb_hw_init().
+	 * Placing it here keeps igb_hw_init() reusable from the reset
+	 * recovery path (which calls vfio_pci_irq_reenable() instead).
+	 */
+	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+
+	igb_hw_init(device);
+}
+
 static void igb_remove(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
-- 
2.51.0

