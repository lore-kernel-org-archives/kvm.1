Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085463ED127;
	Fri, 15 May 2026 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882650; cv=fail; b=AH+2bmagmBviwvdgNy6N5iHZDfnls7i0EfV8rizLH7S8aoXfPGFkbCujLehv8AYrkJRt9Ifsj2zXEvQnXhckWMnog9hOVB+uGerx8K7tjgsxh3JLTsbm/xnU3bFPWXC6gO12FiYMHFq4LnoVgiRau6U84p7+c6FIe7aWC/Yztow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882650; c=relaxed/simple;
	bh=DflzomXxj7xOVzhZgJK+9msazINxgOg8d1cbJiZazkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJkk+UPnEe1h22TtDz6DSs2gS7M82BWwzGOj0CNx4nnUKEjObndOQqG762FJ7EFpnXRMhQx99W02gL8kfiMy2VnDyOGrpo+1zxX8+f/ZcKxOcvRETPxlLF2KAEB5nB6UDOW4MwLuuMsMAkBTsQhG11vH8/LlCTqnw1a9/R2bdvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YKTAnhaz; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YKTAnhaz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0Fb28MfjjUWRCRlv5NhDJwNW9Gys9+UzacDUFVc32tChV4+wLq9hrDmtA5/z6qt4AJg9vbY8PDGEpmT8ZUJYF2zudJyYl9Y1ATNiGNSe1iQw3cGJNJWAv4BJbUemKyTh/uj646fDpkc1cHg1ewI40gxo/mtQurymvaovHxDOY7RttUvcM1x28tIxRqY1OrrIFboaTRbdjhJAMFkfChs3TfFy53KBeD2nk5HtfPdulVET5YqgkHXXl9f5rq0iuMCYKkJYrSS9RoBqMFoodHVYJbeXBPowuW01u0EkgqqG33ju/9DnYEzfoyLQvGBHn8vpVVEhlnQRBVeQ7kYW0/mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xd3dk88egimFxgjVyqlS5kUZH9qHoUiQJ1N6+pEHH8=;
 b=TYKNuMTVxiEgBcR41S5lIwiymDfJkCUqiGai8GEN7bN0H+jG/vUW191FK3sTkkfwwoO/jrqqQSuEhex0qFPbkltNXcmGvzfkLqzNPtb4DPheu4wkEyIHjBXvPX3KGcd1j4C9vAwhn8uxpMNAYLaz45OoBMElWuZeNMjUmUSha3xDvBoGm+JGYYikd6Wnf7oTaFChSyA9ebwuzHOCSYAERL0JyPPxjvdZRaOjBzX6Qvx6jXNTwhffFeu6kOG/YWKMd5Koz1kKsKhYTAn5OGovp9rCF5Dy3iMLgL0E6mImA9U43a9w/h+RYa1uTcVpXA4Fgp+ICrJCP3gwzHhUpOcLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xd3dk88egimFxgjVyqlS5kUZH9qHoUiQJ1N6+pEHH8=;
 b=YKTAnhazSEQ3qEMC9Kw7fyHaTp21Yos3mWIM2IkIgLicVBkIrpzVDJsYZvsjG1CzKny1sLEVhaE0wCoPzcD49lDueMkHl6NfoAoJfS7t+e9Z7s2zVwSIw+c2TWM1uyTs6/X9sx5IB94qy+8QDydxAeug1UMbISeXyUdXKCjXbdxxYbbTs+GpHRfi0XVUZ2dFzby5kYr1+ThonIVcnvRgQL3Kz0RGt2WhzRTmGGLTvZtlbimGFnZrU/0daKGEr2fkAJ3uOH9GaXJfge6cbKgSfduKWkt/GBlcyPZ+/TQZEP3IaAkhPIdeetdHc6LrAg6lPts/V4QfCUsgSeTNPlmLTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:05 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:05 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 2/8] selftests/vfio: igb: Use advanced TX and RX descriptors
Date: Fri, 15 May 2026 16:03:09 -0600
Message-ID: <20260515220330.565792-3-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef830616-c41e-4090-97e0-08deb2cde198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	0FRDOjWK37FRD4C0FwVW0kIoAaOik6QsxS0UlQPC7sidHCuQfotxZclPgzGPempNJ17nWkq8/fHAXZNr3kxuxrvNwOY7Ww3q7veDIMxBKFEUY7RF3rSbW0mj7hEEowvg8GgHUyyRrTXVe+AJKMfN28gQuwfU3Fhj1FRVyvytekwNsPsy+pru6jLs93y7patOsLCP0mkMk4iAKPzzapNaVi/5KBRIRKEOkUItDlZ4ifUiDH2j6bZH7dWUWNK7pwFbUBLA9A/VpIMILnMQ5sYj6quexVgRNlg9sOdhZZwJ8/STYb+ba+lUmselyCsdTLriWxea5uoRsyQvgUx8UeonwkStbOvg67HtI0t0HkjfaMLNiSt8NJljQXRLMNdGZtA8Hy2rssvvuhlFgS5XC+5Td/7vatdLmvaRt2w15EgzP0GmrWoeYAzT6IkZAQfEn2Rw4OavkEH6qQ0YPXqncIElXHYjxn3UKdjSR5i4bO91++eu9+1HquH/6Uyo57IiodUbHerGt+EOpVHdhsap3mtRs9JJZWsXT6DM3r5tFURcrP5Fv5ZNfaZ3KNOvGk1C1cyh21ohN2t5hQjFEeCssPDfQNTvfX4fmaJSyzH2E0d93vYv4CTZd4+rcSw7TuDpz4i93X0unUcL6Tt6RQBAv2I7RYN1YLIl3frRO2EmLfz2pjvmycT//2SJQ/wn2h83ZbaQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ki1mZn5fDhvWXa5tBOR+fsJNyLKYKuXsExK8Vmrkzz/0R/836aMiPcUufnpB?=
 =?us-ascii?Q?ZRsaB9n83GGue8lJLyUprg1mCnJrD+H43ze2kWnRfBOtnv/LJW1LV525BcET?=
 =?us-ascii?Q?Jk22X0MDqgDVOVpJj41w/m/FSZuKayNhNSYQWGiRb/+r8KXXwHqiJ6TPXgnp?=
 =?us-ascii?Q?Sb2J+P/gl8rU09A7EMvBBA0d9q+KWsNHGnUqMlb6Kr0ygrrZ993UjCuPmNHS?=
 =?us-ascii?Q?7M59pxv5DNaGNKAKMG/Uy8JKo56SZE4JeN/iO5uQh2lmliiUFItR4vxiI339?=
 =?us-ascii?Q?EtUGiP6RYlep5MpwZtwahp/oRl0GQ5Ta+Kg289BQg5hsaJMLG+G4wR2vKRIZ?=
 =?us-ascii?Q?rpkmaUQXvao6A8UEATLsSyx/hs8YHpPBIdrrTF0JQBfOSfcRVf5haR6Bdw38?=
 =?us-ascii?Q?T5+f2aqWDJyLIguNRLiNP6B+aB7oZ+B71KgsvS4X+TszdekklFoTaZbpiSZG?=
 =?us-ascii?Q?KwcU5CS1WWwpmsziCHWdSFF4hXSO5uTNW48c52CdjYBmCndyDl5ETGzyL9mA?=
 =?us-ascii?Q?QKVQ0b5ILkkewSGoNhveeviRI8uaO2Zz/w1qFzyYuwTIHcG1mNCvKmB7rAiS?=
 =?us-ascii?Q?ZLbdyhdTOcr8AZthDXWLFSp2FPZjFLUBjFU3PwTqBIIL7f+HLx2xrWBFqzqM?=
 =?us-ascii?Q?w6IqULwscxaflERGBbHcyIwQQWgZfgScfBiDPjw3gePEhXKuNNJLJz7vuKkb?=
 =?us-ascii?Q?Bb5S9t7tQj2OLZ08roiH/UNqVUSh3VjjY6Pu7ZHq8lnS7yAr0l9F4mds+OVD?=
 =?us-ascii?Q?cgVJp0iCbrEunBDf+ncBVEO7E/D9ZuBskOn0LcQhAUSlLFaS4USSdX8pq3Av?=
 =?us-ascii?Q?xHv6qIhSp9VPT8/7IBucicJxwOV2B17bdMrMzeJaei7PwM3sv4OL+d62aP71?=
 =?us-ascii?Q?H2/3hGu3N8tKM3tDf2XyA+lDIRRjcu2BV3CdJr6zfNqSlD5mDBYV0hZ62qyG?=
 =?us-ascii?Q?B/JpOI53pVvY90ev71glKuDmtPwoiFK14S2MvtPczzGgjMm4W51NH06v1XD8?=
 =?us-ascii?Q?VZF9lt/Yi5kZouypMJ+qDSkWUsld+VuBJUqohSpLaNzQhMBzPDlOnWt6Tcin?=
 =?us-ascii?Q?xhHsknh2Nbspt9D23EHIw0IAE+QQIHy0TzAo451GZ6VqGB7Zs9dsrL2mDiPb?=
 =?us-ascii?Q?XbomHZFdyBoPPC/bkw9Y3EkXidhyHmGP6nKvNJ2p3u6Ufyjvfu7eTngGwdMU?=
 =?us-ascii?Q?J9W2Zchk7T+KbVFDCeK19lF4iDdS5naoQzvRO5iaDWM6j9JwYZC+5S5zIk77?=
 =?us-ascii?Q?j8/2j87JHH+A0z53WEu9PB6IOd+tOWQDsaN5j94qThESu4j3BoaqA/em6r1r?=
 =?us-ascii?Q?5/pdn/27HibeP+/xR9ZouZhxsGYPG3Ny6XlNqv86n1pCpSc/s36GnyuqoWi2?=
 =?us-ascii?Q?I3Gt2kp27lqqgNIzT9xeJlQHrI6IlA+VHHDKEVxy/5abs6rMZp04vcW+WB2P?=
 =?us-ascii?Q?E902NogLXGADIZtGEXnSJxt8aDnna4OmKFBZf0t4HeiCbPIvEf0wBthF5G0/?=
 =?us-ascii?Q?fBSktQHqE9c/U4ZPwQT9FSP6cJrWQMndxyEUXVA5Umk1bB7NNyhZb8JaIVYM?=
 =?us-ascii?Q?DlYMGgA5U7y9eH+JF24BiXvc1chzXmgxErE1nd8gVCtBXltRcS8CSff21w9A?=
 =?us-ascii?Q?D9b6WbMcu1W3p1+IN0fOJ37szdxAH5zTmKq+F29jcykFKes1y/QDI5MO8LJp?=
 =?us-ascii?Q?gGrf+e7ztdx5m/12mIykPmWrhnMhR7o1s6Kp3+5A22h8uUT+3bXEV5ajUxNU?=
 =?us-ascii?Q?u33lFLcuYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef830616-c41e-4090-97e0-08deb2cde198
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:05.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GfKrqIsLRGrHf2aACXXVuskUhvFagD1JBAX5ve40Qb7XzMOAU6XwGuk+eOcEs65gEwi/jJYF0PEbmFRNWCpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

The submitted driver builds a partial legacy TX descriptor (just
DTALEN | CMD_EOP) and never programs SRRCTL.DESCTYPE.  QEMU's emulated
igb tolerates this by treating descriptors as advanced regardless of
DESCTYPE, but real 82576 hardware does not.

For receive, 82576 datasheet section 7.1.5.2 states: "SRRCTL[n].DESCTYPE
must be set to a value other than 000b for the 82576 to write back the
special descriptors."  struct igb_rx_desc matches the advanced
one-buffer writeback layout, so the test polls rx.wb.status_error,
which is only written in that layout.  Section 8.10.2 places DESCTYPE
in SRRCTL bits 27:25; program it with 001b (advanced one-buffer).

For transmit, datasheet section 7.2.2.3 describes the advanced data
descriptor with DEXT (DCMD bit 5) marking the descriptor as advanced,
DTYP=0011b selecting the data descriptor, IFCS (DCMD bit 1) asking the
MAC to append the Ethernet FCS (without it the frame is dropped as
malformed), EOP (DCMD bit 0) marking end of packet, and PAYLEN in
olinfo_status[31:14] carrying the total payload size.  Build this
descriptor in igb_memcpy_start().

Remove the legacy CMD macros (IGB_TXD_CMD_EOP, IGB_TXD_CMD_IFCS,
IGB_TXD_CMD_RS, IGB_TXD_CMD_SHIFT, IGB_TXD_CMD_LEGACY_FORMAT) that
become unused, and add the SRRCTL register offset, DESCTYPE encoding,
and advanced TX descriptor field macros.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 36 ++++++++++++++++---
 .../vfio/lib/drivers/igb/registers.h          | 21 ++++++++---
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index ce2e2c90315e..594e51ba29f5 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -230,6 +230,17 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_desc));
 	igb_write32(igb, IGB_RDH0, 0);
 	igb_write32(igb, IGB_RDT0, 0);
+
+	/*
+	 * Select the advanced one-buffer descriptor format.  Per 82576
+	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
+	 * value other than 000b for the 82576 to write back the special
+	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
+	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
+	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
+	 */
+	igb_write32(igb, IGB_SRRCTL0, IGB_SRRCTL_DESCTYPE_ADV_ONEBUF);
+
 	igb_write32(igb, IGB_RXDCTL0, IGB_RXDCTL0_Q_EN);
 
 	/* Wait for TX and RX queues to be enabled */
@@ -339,11 +350,26 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
 			rx->wb.status_error = 0;
 
 			tx->read.buffer_addr = curr_src;
-			tx->read.cmd_type_len = (uint32_t)chunk_size;
-			tx->read.cmd_type_len |= (uint32_t)(IGB_TXD_CMD_EOP) << IGB_TXD_CMD_SHIFT;
-
-			/* Set to 0 to disable offloads and avoid needing a context descriptor */
-			tx->read.olinfo_status = 0;
+			/*
+			 * Build an advanced data descriptor per 82576 datasheet
+			 * section 7.2.2.3.  DEXT marks the descriptor as advanced
+			 * (required by hardware); DTYP=data selects the data
+			 * descriptor; IFCS asks the MAC to append the Ethernet
+			 * FCS (without it the frame is dropped as malformed);
+			 * EOP marks end of packet.  DTALEN is the buffer length
+			 * in bits 15:0 of cmd_type_len.
+			 */
+			tx->read.cmd_type_len = (uint32_t)chunk_size |
+				IGB_ADVTXD_DTYP_DATA |
+				IGB_ADVTXD_DCMD_DEXT |
+				IGB_ADVTXD_DCMD_IFCS |
+				IGB_ADVTXD_DCMD_EOP;
+			/*
+			 * PAYLEN (section 7.2.2.3.11) is the total payload size
+			 * in olinfo_status[31:14].
+			 */
+			tx->read.olinfo_status =
+				(uint32_t)chunk_size << IGB_ADVTXD_PAYLEN_SHIFT;
 
 			curr_src += chunk_size;
 			curr_dst += chunk_size;
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
index c00b5ae83ccb..c44788642522 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -22,10 +22,14 @@
 #define IGB_RDBAL0 0x0C000 /* Rx Desc Base Address Low */
 #define IGB_RDBAH0 0x0C004 /* Rx Desc Base Address High */
 #define IGB_RDLEN0 0x0C008 /* Rx Desc Length */
+#define IGB_SRRCTL0 0x0C00C /* Split and Replication Receive Control Q0 */
 #define IGB_RDH0 0x0C010 /* Rx Desc Head */
 #define IGB_RDT0 0x0C018 /* Rx Desc Tail */
 #define IGB_RXDCTL0 0x0C028 /* Rx Desc Control */
 
+/* SRRCTL fields per 82576 datasheet section 8.10.2 */
+#define IGB_SRRCTL_DESCTYPE_ADV_ONEBUF (1u << 25) /* 001b: advanced one-buffer */
+
 /* Tx Ring 0 Registers */
 #define IGB_TDBAL0 0x0E000 /* Tx Desc Base Address Low */
 #define IGB_TDBAH0 0x0E004 /* Tx Desc Base Address High */
@@ -100,10 +104,17 @@
 #define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
 #define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
 
-#define IGB_TXD_CMD_EOP 0x01 /* End of Packet */
-#define IGB_TXD_CMD_IFCS 0x02 /* Insert FCS */
-#define IGB_TXD_CMD_RS 0x08 /* Report Status */
-#define IGB_TXD_CMD_SHIFT 24 /* Shift for command bits in cmd_type_len */
-#define IGB_TXD_CMD_LEGACY_FORMAT BIT(20) /* Forces legacy descriptor format in QEMU */
+/*
+ * Advanced TX Data Descriptor fields per 82576 datasheet section 7.2.2.3.
+ * The cmd_type_len word holds: DTALEN[15:0], MAC[19:18], DTYP[23:20],
+ * DCMD[31:24].  The olinfo_status word holds: STA[3:0], IDX[6:4],
+ * POPTS[13:8], PAYLEN[31:14].
+ */
+#define IGB_ADVTXD_DTYP_DATA	(0x3u << 20) /* DTYP=0011b: advanced data */
+#define IGB_ADVTXD_DCMD_EOP	(1u << 24)   /* DCMD bit 0: End of Packet */
+#define IGB_ADVTXD_DCMD_IFCS	(1u << 25)   /* DCMD bit 1: Insert FCS */
+#define IGB_ADVTXD_DCMD_RS	(1u << 27)   /* DCMD bit 3: Report Status */
+#define IGB_ADVTXD_DCMD_DEXT	(1u << 29)   /* DCMD bit 5: 1b for advanced */
+#define IGB_ADVTXD_PAYLEN_SHIFT	14           /* PAYLEN bit position */
 
 #endif /* _IGB_REGISTERS_H_ */
-- 
2.51.0

