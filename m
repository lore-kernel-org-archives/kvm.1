Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE813ED5AD;
	Fri, 15 May 2026 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882655; cv=fail; b=PhYmQ5D0cMKKwVx8xDIzwCunNRwO3RWVurDetJ6pRPqnWS0lAl6SHZaqz0tWLPA0kM26hRw6RCMkoJt3I+6J0j7d5qMfrC456rLo1m+jFLbTkaKL6GUaSAubKlIyi8K8iWbDECy1qtmtKfs0W2QdM+o0DOJ/A40bIdaU/NrW8ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882655; c=relaxed/simple;
	bh=4FtgZRIy8qz3wJMvaJWRwcfBRe3ZD/Klp0afJ1HJpHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V5uNxwPS8uxLF3x4XSUJw3RmQLETkhLnm0HqbczwMpdTG7UJJy0+2Mu6qAEjhJ/0sa+G7f9SdbM3zAO4XhD+CW3daXeKsm6YUdfuMucKvsGf9R9cYVGZuVOU3yRAvgb2XtQ7Pb/Gf730idfLfayyjhrqQ97QFU2rbglffdw6184=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ehk9jVJd; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ehk9jVJd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO9USWd/5NB3MgLLBVAZqSn2Ti6theLYgF6IaFGiW/9AcHuAh3aimG2Ea5I31JUj8IumUKekYSqqxRf3nHWIe3B1wvibbeM1aK1Wkt9vxzfOOgmKqTCRkHol0u2FAsb0fV+BXH83fN/hoZTaiEksL+4fZA5j/4Sfr1fESkw0NDQU9g2/tmzjaXkesBqpN8w7ARRcw51KUJvk5Zp68HeM5AQw67uwKDQ8MY3/Ift+LXeRoEl1mjd0a3BTwa6I2/dqsqTcq0Y6djTR4kHnZiH0zvPAYtXhHzKcD1a2XCzEQv7yjELm9g/XgkmFH7XG2sCuvN7lYCf4PyH/JXd1aMlrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag5V/+cYFcEdJbqAdJwLw4nkH3CohYGIIk7VYt+NCvM=;
 b=OFVf2qYpfOtVKmP+lntedCYts/TeENiQgJ8I4ogLHi3a3Cllv7teapM6DoGGMBpRHFtkRRaI+XvpnpGXJ/pw0yd38uxZNxxqC11f/BTopb/up+yd2dBA4V/3MJc0v3IdqkEhOGP1gcKtZ/IGHSnogyBHO040aclnlIj/LjpFgYTG3Wj8fhJMcAwSo6GLozJTNh5kcTcvLkfG4XMhhhs2vqPqY9o1HUWi4febnyZ6fFiJApv2Piv6w3a1lx4Rz2h9z2a/P+YV27IAvseIiZfFkwSvdvHYeK4g/iRWsEjve5Sps7DzrooWP0xS5TUKUDGlxGkaR/sFiTS7hMZ7+fBPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag5V/+cYFcEdJbqAdJwLw4nkH3CohYGIIk7VYt+NCvM=;
 b=Ehk9jVJdYwlj6wJauNqS0dWAUKHV4K6q7q+Qctc8W5I6XlDQAPcQyM2CEp94AyaOaFYtZ1fY0mopgWjPRKStYf/3PBhly95jYEi0io8UjyJqLmemuowFD3FYQjRnDHD7BvHBpAXBf+gcsSoMRuUs81qAN05bbevx5EAkZ30Sn2Wyp0NImelqNRcRYhz5XEHHmBMWMdIZrsCphUnC0cuJd2WaBrYSJKqFE6y9Da753I/qxDjNpKCUseFOZgs/Bg+ZG74AF7P87xD+CkIerpR39b/6qqBPpcR+VV/kW7eNXXPQ3SIVBRRt/r7G3fhUx/I3Ok2jhQqQPTi+CPxqzwBUwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:06 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:06 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 3/8] selftests/vfio: igb: Program MSI-X interrupt routing
Date: Fri, 15 May 2026 16:03:10 -0600
Message-ID: <20260515220330.565792-4-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0697901-836e-4ebe-b479-08deb2cde217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	MA3C83+ymdis5erVuR3WBGy1ZotjsA2tJEXHPDqP5c0kkgIUsMtH1qMAuk4LUGC8Ea8cUvEI5TxYBFtcOUrs76Z8rwLlzg5gBAY9Z+AXLmEqXIf+f+wI2ryeIDrTTEvDy7Q/OO5Yw2B86NRY18UIByz93xQg1ctpV1uM+i0nGbtCU7v0eF/zQ3aJyJo9kvdGFYEnGlnqTM7kzDKnjR/E7qcf0xTaiR5quua/r2axTfO4UzMWEg5f9rEe4jiTlt8HcSNZFZYVjlaNXkqYQFx/Sg2eAxms2WKK6dLEHTKD/JKF3joaGJK1LGy1X0R8DtlP0Z+TVZUlJPWvE8/6CbhwYGjPVq29ZWQd2QVi4BsJ9s/tHTUrVfElQElE/gbMpwpgpolRNe4p2WP8wBahXfK8XZQUj9ZkLVZwbZdvyWkHJk0JSEtlYAYqywBrCKEycXXAUQ0sH+db7uYdFpJRkhRygRsXGYzpExc/OVuH3ufdjsZkR4rtr1yykjKO7knhMzIjoFxrWyEGyYLNTdlkIY9EChEkTi0QZ+IJ3Yd9rx8LrU95XtjSpc4coKo3xgy4sQOfKspymLB74QenPgvNKeUoWBP2j4VckoW+6MMwB17eOLM5TBYcYSgxilCZOmf2ZXwhWrI2WyHhscm7DXOXdYSg2sbQsrEuOWDE0WE2eujZuqORpA5zMNCknSDpuKDid+o2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aCHnuanwKIz08HJY4s1+CAhLARqEU4Kp68GV5vidXe7L+TG4sBMF+bpqEavK?=
 =?us-ascii?Q?wbpMBULX8uOCbHKAnrMgigvsMRim2lFjswmkAw+JRxxQqzgIaIyZdRqfR1fs?=
 =?us-ascii?Q?lO8ij0U1G1A33YCGAQ1gZU+U7rGff7lI6wAAKnYD9kmwJe2OnrxZYTVYOSuV?=
 =?us-ascii?Q?mi367ouFYLDtTRW9fZjUD8M3kq7bURieE3n6LBB9/iGZ+t4B4gxWlLqCZ9Is?=
 =?us-ascii?Q?nhCOb2iuS7RZOlVuq+2v0qzWFLIy6tvYKa1lJvdy/kM+XYr9ergn+SOfN5wN?=
 =?us-ascii?Q?UP10DCljB+Z1kZJltDR1vLFGHSJhy/pW4BLr8mMpALe9nTcpNMwGGUfoWyvd?=
 =?us-ascii?Q?EaBLssj9ICxafqTvD385KVp5dUQdPF38b6tx9yXIqJpeeHkwfncVjdnAH7/F?=
 =?us-ascii?Q?jAirpR6bmKxPppLgd4vHZ9BQhKg8a6QJgZRo81yEJoXufViM+8m/CksKeS6k?=
 =?us-ascii?Q?jah6nvIicQgFby5ZS6E4XCuousPSDwc8QlILbPOc+qHyGfUXI+FRU8RsZ5ZL?=
 =?us-ascii?Q?IOUA+JXCtkanWF/aHAorsh/k48JkbwKXRmlJZC94nAVQmqWML7RXTR85wRYq?=
 =?us-ascii?Q?t7m1qM2+stGhSQ418OKWmbZLFJidD4f5PLb+80lDc5GRiAiSvHb0P0WpPcEk?=
 =?us-ascii?Q?RmgUASEnDf7Hc323Vy+h/Puawraqmpl7UZU9zaGFDIb2VCUj5NQhU5cLjQrv?=
 =?us-ascii?Q?tsnfJKSbusWAJWZfiTg0Dn5CGD8kBolZESY/YoZDz+EaBcF4dIvTCRPNwpGc?=
 =?us-ascii?Q?AmhmyRCQu9jbInA/HghI6eM85Re2MQmmDYo6VchpAPwMuUOoZ8wOZFWld6e8?=
 =?us-ascii?Q?33Nj61/itvBbZ/d6SYaapyvGb33FV/CK/cPwd4QPuGNaLT6B/WDfb+DJwzZL?=
 =?us-ascii?Q?yojQSrKZHesNeStydCNmEiDlxJSx42767HQz1j37WHBLZo/oc0u6+yJpMWgz?=
 =?us-ascii?Q?eNean/X2ScXGdJ5Ov+pjJlg+j5uRxun9oP6QHrdZ7qmaKiFNtzEzcT6hLpaD?=
 =?us-ascii?Q?JKyP5grsa5C95tYkXTXurJKiEPhm5/zgP2myNCzEktezL+pYIWNLBpFbzPu5?=
 =?us-ascii?Q?lUXDg7xhajYUsR9eyHi0R9quXnTzQlO5KNFgfbMIeBf2OZyBujCnxez6DuSx?=
 =?us-ascii?Q?uL0e2g12eywPVi2WMV9eT35OFuTS/T5V31kX/9YC/UCOCETPWofUfNu5nGYC?=
 =?us-ascii?Q?7UZWUFTfsWphl8rsEbJxN3cOk2xxh4VNw1eb2R/oxZTSWwwbcnxLLaFbyPfn?=
 =?us-ascii?Q?uMHDtRFBxGc7RK9QQ57MqTDsiMj9YkX0RuIg9Qd+cUaXzl9sb6+++MBqzaP1?=
 =?us-ascii?Q?PR536TaOZpJUwqaZLR/gXhoamTFd+HzOfuzfTwVi7oyW6bPa/VcPaQH80Y8O?=
 =?us-ascii?Q?OWIaghpWkFqyMKssRhz8cctH7MbwiLTBaqpT9czFl+TMw/JAcA1zgrVZg2bY?=
 =?us-ascii?Q?I2qcAHVFUJhytCbTTSgQSaQaU772H8N2Ie4iamXdbPzAVJ23v5//2ZtRYflO?=
 =?us-ascii?Q?OKJ5bI4PJhs5LakL6k9hoinXRXThsffl2+J6WTezHJPViV/ZwuxZAoJOS3ij?=
 =?us-ascii?Q?gq7owIqBgkE22wFXkn51hzRpPKuNm5X/4EPjFmtgeGB0JwT2mU/Hf/oIZUxS?=
 =?us-ascii?Q?R6nXIvf9Sukv9SsYQnntoM28z5NiStN+8sMz5ZLIHlnHWp4TmYnK8YLZWlSs?=
 =?us-ascii?Q?Cox9n92RbtryQmPwi6j0vykC5QvxURGRFGIo2yPydznJAdaM5Ka+UyWhPD0Y?=
 =?us-ascii?Q?h9rZOJCUPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0697901-836e-4ebe-b479-08deb2cde217
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:06.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcmHmKUdLxfDhecL3CPocvAQUFg51bbhclAZj7kisysLOKghTo329aOCDevYT+r8Rli+XMTcM6M1P3HQslSazg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

The submitted driver writes only GPIE.EIAME (with a register value of
0x10, which is actually GPIE.Multiple_MSIX, bit 4) and clears EICR by
reading it.  On QEMU this works because the emulated loopback path is
synchronous and EICR is implemented as read-to-clear unconditionally.
Real 82576 hardware needs the full MSI-X programming sequence.

Per 82576 datasheet section 7.3.2.11 Table 7-47, MSI-X mode requires:

  GPIE.Multiple_MSIX (bit 4): route causes through IVAR.
  GPIE.EIAME (bit 30): apply EIAM on MSI-X assertion.  Without EIAME,
    section 7.3.2.11 specifies EIAM only takes effect on EICR
    read/write, which is not the path used here.

Configure auto-clear and auto-mask for vector 0:

  EIAC (section 8.8.5): auto-clear of EICR cause bit on MSI-X assertion.
  EIAM (section 8.8.6): with EIAME set, auto-mask of EIMS on MSI-X
    assertion.  This guarantees one interrupt per memcpy batch and
    prevents repeat delivery if the cause re-asserts before EIMS is
    restored.

Replace the read-to-clear of EICR with write-to-clear.  Section 8.8.5
states "If any bits are set in EIAC, the EICR register should not be
read", and section 7.3.4.3 cautions against read-to-clear in MSI-X
mode in general.  Write-to-clear (section 7.3.4.2) is unconditional.

Replace the magic '1' values written to EIMS/EIMC with IGB_EICR_VEC0,
add the GPIE/EIAC/EIAM macros, and drop the wrong-valued IGB_GPIE_EIAME
macro (the new definition lives next to IGB_GPIE_MULTIPLE_MSIX).

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 40 ++++++++++++++++---
 .../vfio/lib/drivers/igb/registers.h          |  9 ++++-
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 594e51ba29f5..d44a08a36171 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -275,11 +275,32 @@ static void igb_init(struct vfio_pci_device *device)
 	/* Enable MSI-X with 1 vector for the test */
 	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
 
-	/* Enable auto-masking of interrupts to avoid storms without a real ISR */
-	igb_write32(igb, IGB_GPIE, IGB_GPIE_EIAME);
+	/*
+	 * Program MSI-X interrupt routing per 82576 datasheet:
+	 *
+	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
+	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
+	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
+	 * applies on EICR read/write).
+	 *
+	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
+	 * Without auto-clear the cause stays set after delivery and the
+	 * test can see spurious interrupts on the next memcpy batch.
+	 *
+	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
+	 * MSI-X assertion (effective because EIAME is set), so a single
+	 * interrupt is delivered per memcpy batch even if the cause
+	 * re-asserts before software re-enables the mask.
+	 *
+	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
+	 * cause 0 to MSI-X vector 0 and mark the entry valid.
+	 */
+	igb_write32(igb, IGB_GPIE, IGB_GPIE_MULTIPLE_MSIX | IGB_GPIE_EIAME);
+	igb_write32(igb, IGB_EIAC, IGB_EICR_VEC0);
+	igb_write32(igb, IGB_EIAM, IGB_EICR_VEC0);
 
 	/* Enable interrupts on vector 0 */
-	igb_write32(igb, IGB_EIMS, 1);
+	igb_write32(igb, IGB_EIMS, IGB_EICR_VEC0);
 
 	/* Map vector 0 to interrupt cause 0 and mark it valid */
 	igb_write32(igb, IGB_IVAR0, IGB_IVAR_VALID);
@@ -305,17 +326,24 @@ static void igb_remove(struct vfio_pci_device *device)
 
 static void igb_irq_disable(struct igb *igb)
 {
-	igb_write32(igb, IGB_EIMC, 1);
+	igb_write32(igb, IGB_EIMC, IGB_EICR_VEC0);
 }
 
 static void igb_irq_enable(struct igb *igb)
 {
-	igb_write32(igb, IGB_EIMS, 1);
+	igb_write32(igb, IGB_EIMS, IGB_EICR_VEC0);
 }
 
 static void igb_irq_clear(struct igb *igb)
 {
-	igb_read32(igb, IGB_EICR);
+	/*
+	 * Use write-to-clear (datasheet 7.3.4.2).  In MSI-X mode with EIAC
+	 * programmed, section 8.8.5 explicitly states "If any bits are set
+	 * in EIAC, the EICR register should not be read", which rules out
+	 * the read-to-clear path in 7.3.4.3.  Bits not in EIAC are still
+	 * cleared by writing 1.
+	 */
+	igb_write32(igb, IGB_EICR, 0xFFFFFFFF);
 }
 
 static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
index c44788642522..139f1c2e6fdd 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -78,12 +78,18 @@
 #define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
 #define IGB_RAH_POOL_1 0x00040000 /* Pool 1 assignment */
 
-#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
 #define IGB_EICS 0x01520 /* Extended Interrupt Cause Set */
+#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
 #define IGB_EIMC 0x01528 /* Extended Interrupt Mask Clear */
+#define IGB_EIAC 0x0152C /* Extended Interrupt Auto Clear */
+#define IGB_EIAM 0x01530 /* Extended Interrupt Auto Mask Enable */
+#define IGB_EICR_VEC0 BIT(0) /* MSI-X cause/vector 0 */
 #define IGB_CTRL_GIO_MASTER_DISABLE BIT(2) /* GIO Master Disable */
 #define IGB_STATUS_GIO_MASTER_ENABLE BIT(19) /* GIO Master Enable */
 #define IGB_GPIE 0x01514 /* General Purpose Interrupt Enable */
+/* GPIE fields per 82576 datasheet section 7.3.2.11, Table 7-47 */
+#define IGB_GPIE_MULTIPLE_MSIX BIT(4)  /* Multi-vector MSI-X mode */
+#define IGB_GPIE_EIAME         BIT(30) /* Apply EIAM on MSI-X assertion */
 #define IGB_TXDCTL0_Q_EN BIT(25) /* Transmit Queue Enable */
 #define IGB_RXDCTL0_Q_EN BIT(25) /* Receive Queue Enable */
 #define IGB_MRQC 0x05818 /* Multiple Receive Queues Command */
@@ -101,7 +107,6 @@
 #define IGB_PHY_CTRL_FULL_DUPLEX	0x0100 /* bit 8 */
 #define IGB_PHY_CTRL_LOOPBACK		0x4000 /* bit 14 */
 
-#define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
 #define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
 
 /*
-- 
2.51.0

