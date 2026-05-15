Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B093EFFD2;
	Fri, 15 May 2026 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882673; cv=fail; b=TLXJEaz47r4VFPT6GcL6NOo1Z257X7JsjUYEmk1fJFGIP7Ei0Qyvs5g1xfn/x/9sZBj11v0gBByQKA0mXLyp4cxrPjL2hvrWpzpOxKMKdWt8oU1BLRdQZNlkvYoHERepMEoIt+Z03CCqYC5UOOtTgrD4k8VKjE3Y17CchQ+h+sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882673; c=relaxed/simple;
	bh=SKz/dKdtRKsz6IvJ5Tmg+/9eoaePCgIkDs7wtn4hm5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bT7/OPCdR3ayUlWpicQtrhCMDab/+6PjpunKhO/g+GD1aK3qhQZjeOJuyxqZoj8W5ShIFUaTUW2g0ioyQXsxytXmwSKJs6JE4yHczLXj9hYgSo59SE9Lf82YhFMYALaekFmblozvakzk2849QCW1XQsz1vXfBPI8XZaZ9vCYr0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ruFeRO2I; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ruFeRO2I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ib8U+YIoH9kdGe6bnHIHQra9jIoqjjiqeoyd7bJNEaF0hTWNJnmW3BaXbBfUx6SQMklnyKJwEEgcHkg0qt7q9FqHqLVTnpSYReSiEF3IATRndFyAcOPnXjUnR3kL890tjCO8pvdk/QhcrWYLlqjUBXk/0RYcCmkqM0KOmqEjnKZfOZNrptWMu0kTLg1nDx8yizFtPR3YCJqzvV27jlfyKsd3V7c47yZ3NQvUvCKfhUoa5mAEw5Mx1XTEv5MeMadan32SpS8/rKVoCpCgg9E5fp3/Z5+qivAhzuOMKejouPY/v1d68ZizqV/2jvGfD89+yzc0WtxjRjSo+hR7UF7Brw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuXRdLDJE3yAAj92xUqh0aOaVRjKOYeYidpxPcZ7DWc=;
 b=nbd5XQ0ipAlSjfeNVmTw8ErUkonhPs8+ngVSiLcY5iwDX4y1xT7W2NJC/Op2imJLs2RiXOKhp7jFsTxkRWkPfd3jT4Maolg5kNXxFT6aFnEfBT2fpAiNbdz47bSnqQm2AFhNekO/TbjJow5uOTSPb19XyqkcnXUrsa+prxBwBEWvG7dG02bF/vntxi3WvlMYyntRC0WlBmU6Kh/QRnJIuXOy1RtmfQB7L54/SH9492DDkMAVbmqQFBJ8srXLjaFpHpko3A42C+P5nbtJ5S+mo5/Pos3Gh3SaTI9ElEaEFIcFqwh1BuKT09NY/oR6gSJbBkZrjiC9+huiaIvuIIS16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuXRdLDJE3yAAj92xUqh0aOaVRjKOYeYidpxPcZ7DWc=;
 b=ruFeRO2IZh1hrcJDqvBfJIVOmUCb4gMrdWgQ8gnUTmcS49FG61o0AyQpHXehmaOjEObs9hZsZ5UvYKH8pd9IgUKdexX5vX24P3g/4keWhm0gGt63Pqz3KoouDl+qYaebAXZJhARyRwUBVa8/AQu4iHhQG9HP15OInGDIz+Gldhsuclv6BsQVLr4OVgZhVevkmd4FRCc6f1iZm5RkFDZjpkh79T95FnjzKMN4W4YGemjVI7iLwxJP93CgSWHEi0liM0Fz1KN0kictQPKDTQL/YkIGb8y+VjW1Ik02XC4GbGidD+ELEW16ePbMl96zn5liqbiKmoQq7Ixp8HRWRoZ2SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:10 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:10 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 8/8] selftests/vfio: igb: Recover after DMA-read faults
Date: Fri, 15 May 2026 16:03:15 -0600
Message-ID: <20260515220330.565792-9-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0623907b-8c0a-4e70-fb4f-08deb2cde483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	hJVWm+24iuEZdbyrJveKrBD+QklT7Ivqk9S7RCPy2aDbtLEsfN8LomPM+GSQjAtYUvuXMDi7eCPItQe6Pr3xcjbOjXUNurK9Ju1z/9eWFXvK7DATCVYgjHIpjxH9/8N14TwJgx99eUCChWS22iMwk4fUlEg9T9Ix7KsKauyekRm5youHZRkgs6Zjsc9yERGBHkmCi+m+8WtQbvOhBar+QvRJCrvxj1ir/bq54jGVZE6S1euSsBwb/S3EMO8Xn1fOwKYm4COLuK6hgDxU05sc/u18mAnHsj0mAnaf5yo5a0FpZY3GvubnqxRlej0gIkujQH7hsQcgRu+U/CIFazXyVWC2ibOiASE0QEbBNPg1H5WL5rLPKaul16hXVHObWfx/DTctxs6P1ReUjxlgz+vCv8cpYfbrUJj5+YM7Abyqs5CWvHvu1OEdxOGubgZk4WIukH9O5CySfaNtR+YlXzFdLfF9M7T+UUKKG7gk38ZDGQtHMGHce6D4sxIcfxX5e6XRcXDqvWAVHk0PSkZlp8kyyS8lCy0B4GauoklwtcpmBz1pWrAGnCAkb/0syprVby1wzu6hgXBVuLWF99KZqBtmJNjmVk7DoKfxWtxIpqOW06NUC8NiDYLnO2LLI6KEelseFwkn3MgXLaziN5RA2ISYKXqB1Fua8H5eCiHdu5kOe2l6CgiKTOsFy8O4TuQi2al0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t1/FmSycGg8u3TFJ9/cnTCbasi0lvOpzWQBu8M2CQ/LAPBoJsuPYIpgXTH/m?=
 =?us-ascii?Q?5Zyajd74+HkfLlHHOWbczp6DHQKH//yjw4EEmy5DU7qvE2KdZSmxwpeG0I5M?=
 =?us-ascii?Q?FL8wLQeCV3qguK0gLs77w8zftuY3xqvfNEygNTDYcSzI9rW8WzAAnfsEFWge?=
 =?us-ascii?Q?vegZ+UJKLtFP0o86wtDO8NUIFPh3OSh0SoG58Z4cX455Y4V6/eodiFYv0NpW?=
 =?us-ascii?Q?bfu2aw8G6OBbuSMN1IYNe4MQzBed1zMD34ssRe8et2OrxbGDaLH1p6bWIRwx?=
 =?us-ascii?Q?0+A/lYGkIKAhYde89qmx71OHTtApLtwIL8YSI5YuKmeQM3bX9EH7jrf61BvR?=
 =?us-ascii?Q?pcFS/otKqI6UW+0ojWH8vkrOWuNNrbQ6WjbDWoIPXKqRcA65sSjvBwYbb45+?=
 =?us-ascii?Q?wi1P1dgYsJnghE/QFYxR21g9SXH0Qs31/hYYSnZ8kJ/vOjMARfQasyr9raYZ?=
 =?us-ascii?Q?F9nr2gQYbYFF9r6p4ZJGRT1qB8adHoXWrhXiBNIJRrwB0OeC+Z8/AuPvEtEK?=
 =?us-ascii?Q?8/bl/LXVzoggBlK2xzpij7ajDbwo7jlpBB5Lm4dNIXV1RZZd6U7RMhgFT60H?=
 =?us-ascii?Q?HI0l25+WVV1egN8CqWzxOq9R09bESQ0Tjo2U0jWEIS5Yr9FjTdXE9FakDIEC?=
 =?us-ascii?Q?pBGACNKSEsOAuHigagXlgfMs2BX+1zYlPe6xVfGvLPUlmBeMvhZY+EpfgWOB?=
 =?us-ascii?Q?TzHHIeoBV9yvC7nglt+sz9i0QN6x3hX78n1ttwzVS4MIdwaTiJWFiGUxc5sf?=
 =?us-ascii?Q?O+ursOvKtuKzljeFMOC14zFswFGkINkHwl005ZGFE0i6DhKMlL367y21el+f?=
 =?us-ascii?Q?f3KRf928HvLvdzpXJuffebSUPD9Usa/osYQsxMvRw6DN5XCPcAx+Lfo994kv?=
 =?us-ascii?Q?wK46NUmykG84quP/VdTacZAiONwB8PnhQAo0P7k6Y3K4oT9eozgMrW6VYG00?=
 =?us-ascii?Q?AOdHgcMr4jqyMydEQJfXj7MOyZPttoJJW+AavhCr8UFhZZ8cvGDabBkqbm3W?=
 =?us-ascii?Q?jz+U5QTxxYjhCIGa/Z8/W/Ift75z0yEyLkHhVjwxN5qyMrME2Fg+ADdxLve5?=
 =?us-ascii?Q?DFeFT0gLxkB7MSVqstPoZT9NhX9unn3WsQ15JyGgyZCipYd/YT4yVbiHRiTO?=
 =?us-ascii?Q?ikpKBvGU9W8t0ShRvHgpWf2DfU5VZ0HaLNgzDBMwz6WdEFc/sc1LDK89jCvs?=
 =?us-ascii?Q?Tte8ULOhQsGCa3rthfFWvLEYWgnlk0bLvBY5DzDd/sDRRZ8hUFCOlNHtGqKg?=
 =?us-ascii?Q?fk2Udk5fo94kEqimofj1JbTEvQU99J5q62ndz0qpj0wJqBhYxwtHWw//fLp+?=
 =?us-ascii?Q?jL2dc4rXaxt+RjHpKK1KKPDa0B76hEwVTEMBpTWXkDcGU2sx+pjq4xUiFi+I?=
 =?us-ascii?Q?yOC65ejM6el10dww7X6kl07CyDCrTupcr/k+CitIXubXensZP0PtW6+cLxb1?=
 =?us-ascii?Q?LuYebwH3Aq7Qhl03dpszBgdFoL3EMtaYYgWkyvTQ/m71OrWaDjBKr4GXYAAN?=
 =?us-ascii?Q?Xee8NtEHXB78pRrKf5upCyDlkXOK1CKAB0i5cEp0hpQAf8Blxf5Y4J7XnWe6?=
 =?us-ascii?Q?2+gprbbatqWGicX5F3UTUL5ZATAMyLSrTssCMUorTm36zEmSoaiFR6jF1YC7?=
 =?us-ascii?Q?PDw3vQ9XEt5/7bX/Ef8jfL+F9NsuhGSH2P92G20R1aSbvihKQ0Ia1LxETbUG?=
 =?us-ascii?Q?3omqaBLW8j663xf6uPcjH5U2+ClUJT3z0jZfThJLhw/jbnGcpUNkYBKRPTX9?=
 =?us-ascii?Q?PnZMxtPNlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0623907b-8c0a-4e70-fb4f-08deb2cde483
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:10.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikGGIt6JNzHEco3hEfa9FrAyxSko4vUA2m4fCfrYAYD8ISJkuq9Lz5Yybuy3r5U8vYY+d7lQa11639nrdy5OAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

The mix_and_match test intentionally submits a TX descriptor with an
unmapped source IOVA so that the DMA read fails.  On real 82576
hardware the resulting fault leaves the descriptor engine unable to
service subsequent valid descriptors, so the next memcpy in the same
test iteration times out.

The 82576 datasheet (section 4.2.1.6.1) describes CTRL.RST as the
software mechanism to recover from a hung device.  Empirically
CTRL.RST alone is not sufficient in this state: the visible queue
registers are reinitialized, but the next valid memcpy still posts
descriptors without any TDH/TDT progress in the same process.  A
fresh device open after the failure works, which points to a reset
scope broader than CTRL.RST being required.  The 82576 advertises
PCIe FLR; VFIO_DEVICE_RESET drives FLR and supplies that scope while
preserving the selftest process and its DMA mappings.

Add igb_error_reset_and_reinit() implementing the recovery sequence:
issue VFIO_DEVICE_RESET, re-arm the kernel-side MSI-X trigger against
the still-valid eventfd via vfio_pci_irq_reenable() (this does not
touch the eventfd, which test fixtures may have cached), and
re-program the device via igb_hw_init().  FLR clears EICR and leaves
EIMS=0, so no explicit interrupt mask or cause writes are needed.
igb_hw_init() resets tx_tail/rx_tail to 0 and igb_memcpy_start() zeros
each descriptor before submission, so no ring memset is needed either.

Call this from igb_memcpy_wait() on completion timeout, preceded by a
10 ms delay so that PCIe/IOMMU/AER error handling triggered by the
just-observed DMA fault can release the device lock VFIO_DEVICE_RESET
contends for.  The delay is heuristic and tied to the fault path, so
it lives at the call site rather than inside the reset helper.  The
failed memcpy still returns -ETIMEDOUT; reset recovery only ensures
the next operation starts from a usable device state.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index ef242ebd9d2e..07d1a907f18a 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -443,6 +443,28 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
 	igb_write32(igb, IGB_TDT0, igb->tx_tail);
 }
 
+/*
+ * Reset the device via VFIO_DEVICE_RESET (PCIe FLR on the 82576) and
+ * re-program it.  VFIO_DEVICE_RESET tears down the kernel-side MSI-X
+ * trigger but leaves user-side eventfds intact, so re-arm the trigger
+ * via vfio_pci_irq_reenable() before reprogramming so any caller-cached
+ * eventfd remains valid.
+ *
+ * FLR clears device-side state to power-on reset values (datasheet
+ * 4.2.1.5.1: a PF FLR is "equivalent to a D0->D3->D0 transition"), so
+ * EIMS and EICR come back as 0 from their register-defined initial
+ * values, and igb_hw_init() resets tx_tail/rx_tail to 0.  The next
+ * igb_memcpy_start() will memset each descriptor it touches before
+ * submission, so no explicit IMC/EICR writes or ring memsets are
+ * needed here.
+ */
+static void igb_error_reset_and_reinit(struct vfio_pci_device *device)
+{
+	vfio_pci_device_reset(device);
+	vfio_pci_irq_reenable(device, VFIO_PCI_MSIX_IRQ_INDEX, MSIX_VECTOR, 1);
+	igb_hw_init(device);
+}
+
 static int igb_memcpy_wait(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
@@ -478,6 +500,24 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 	if (rx->wb.status_error & 1)
 		return 0;
 
+	/*
+	 * The descriptor never completed.  On real 82576 hardware this
+	 * typically follows a DMA-read fault from one of the intentional
+	 * unmapped-IOVA tests; the fault leaves the descriptor engine
+	 * unable to service subsequent valid descriptors.  CTRL.RST alone
+	 * reinitializes the queue registers but leaves the engine wedged
+	 * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
+	 * is required.
+	 *
+	 * Delay before requesting reset so PCIe/IOMMU/AER error handling
+	 * triggered by the just-observed DMA fault can release the device
+	 * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
+	 * heuristic.  The current memcpy still fails with -ETIMEDOUT;
+	 * recovery only ensures the next memcpy starts from a usable state.
+	 */
+	usleep(10000);
+	igb_error_reset_and_reinit(device);
+
 	return -ETIMEDOUT;
 }
 
-- 
2.51.0

