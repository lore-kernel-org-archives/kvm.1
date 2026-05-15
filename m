Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84093EEAC8;
	Fri, 15 May 2026 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882659; cv=fail; b=taGnvrmTgAlWxu7H7cYNa8lwQerxYxKKfS11xcwZEV/MPSfDaQCxBnclPsyz4aCT0bxGYTUEzhhGVDn6UtplzT1bpbrfxaUmqN0D/EUgncn+XChl301qA8kQsi1oGxVoCoRGYEQgrygDU0E6rvGb8B9Vofdp4YsEq7Uwp4GFTqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882659; c=relaxed/simple;
	bh=CvS8MqDH+10FO32sqHn/E5hQ8+Pc1HIfOC9mcVBHw0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qYd0FfBj8WD4ralYpWhW1IMiMwAp4Fb9CapuAuC2DFCWt5lnkKSnwUYNL81aNsqX2Je3ZPa8vB5LDYN6Th9s/C/p5lF3odKHvmt0Xmh0oM415x4pH1Uz93m4HgDKU5M1JqdO9dt6r3c+Hw3phEex23aUTX0AmIy1UvcO0qGRJTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tDhQO5gc; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tDhQO5gc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuKoVhyeChBkYQhz5t7Niixdl6SPKy54mbK8eBDTSOzfBuvKVA3dGa2vLM394tDNLsxfw2bII97kOaeCW+0RCx29bTsLXEPkYm4ahxZjjGvBsSWsw00S3+tWuPiGEnVWRtjLJuw+/PEAN6urtYMZX7L7sbm9bvPPqVHW84zAs3LhwpiEgruQK4Iq4rkZbK+IxD3ZlE2Reu/L/ypAxIiTa2fMdl+yxMZSnZ8lCSOHlpb2ItZw7yyNugks5B4LI/wVuNNcOwaQYt0PSeQu3RaExe7W2aFG1GvZRcohWzJ0LJvrnEPjoqWDL1STUD2XK7RaQJM25ff3AKtW25hRwjoPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPZbpcMq6eUi05swevzJWgw4C58b5LRjtfCheJT6ZvY=;
 b=BQE3RbfWkoKhtbolRr8/6cU6DSAVRSSmR9GI3yyPmLGacKFDvGb78XNiwmCgUCc5VsGhIKZPVI2AtM0PBA8sFQ9Qa5Nqic6MriWNApDwHlj23RTmaMQEwWzS32w7vLaMrNexwnxANxHiQJyIN4uTw3WJ2gtFS0YwKqRfENiSsg4NejLDj1NH4wvwa0DFoeKLLBcqdstfPh7k2UU2jWyYOIQgfYtSHSYMMmerTyYlk9G/R6K7eaZixZnCRH79UQt1KCf1UG+V28ZYwS5lNucSy4vZrLMYI+FmOkxVCoJzirIYAFoc/Ck9MjvZt0BXTfxKejxJH/up/N00DA54rmIQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPZbpcMq6eUi05swevzJWgw4C58b5LRjtfCheJT6ZvY=;
 b=tDhQO5gcs4FKlY7Z3jZDu5qCLLF7gaw7w0jnkR/BKuTbp4bnNpr56nJkAGb97yTwgKBgMbX6jWpDKARDc85F4C0uvu6nAMGNlRr9y2mbldOHTGxJR3tsMP9sQv12DFhbbJFvvet08zeMZgK3NeI6zqJ02pyY+7j0rCKqmNp5hbwNlHJ26GaLl+2t1fsWq+N7NrqFjC1Nq070RXoBuZtuerc2jAkzqqOqvQj+VvEttNKMpvVT0Q1NSXZQv22QBpOESxdlYOhL+/3Oi4/rsI0RUp3VDxym3iZe+jcPxTYRidbXZRJBs6YSEL5HKsIiox4VnszqoPwc5G95zvXt4KGryg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:07 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:07 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 4/8] selftests/vfio: igb: Extend memcpy completion timeout for line-rate hardware
Date: Fri, 15 May 2026 16:03:11 -0600
Message-ID: <20260515220330.565792-5-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 00933dab-da08-4b75-ce65-08deb2cde28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|3023799003|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Yzewu0almcR4TxNMYi5DWgKrJKMssYBTAfZSP0oiIv7pbbS8V7TpH8akFI3YlUpUD+CxhvpiZ8eOLO/TJIsS1ydarZrT4KkscLsiN08inmtt6fj1eBxlx42cBz9psHhYVJjih9s6Up1c7LOpfSkh1gBH/R6/tMyjsFsnjkJ76RIRj6AX+5pxQkgJC00/Fs8ksgte00dfUPkK+XOjiT4nzJJsQxCYBmPBFMGeIR1jl+ZVJcETzAs2ukMlTmctkPme+9cuFUUDpIt01vI//1f8Pu9QkYAoFcVuyQXExBxsgFx/9ZMN4lNHoeoCztG5tR2wHu5KVNvdNXAaoRVYOe49Av7RouNFxtc3nZgAvz7Yb//uBRXEd2PfiV6L+/NFfkzMqliyIBgQGy78aAo+oADapam7B5r90omXp1vJBbi6fxviUvAN3e5/0g0xXTxiqDxRvGYTNavU1vmhd8uxcDpHtn5VCTrBlIVEvx8oR+4gDSL2wI8SAPlhKQp4U0erxp97QTPb1aW9MAVuOcKnd4tSynfY84wSVhSxjb5GO5INGu3Mm0Ftd3TWC8sQol0aiclATTU+QG/otG+25vHugrlT9FY1YQhbnYjraF6IHhbDWRzkJnS/12QvTsSrTh8EIwYQ/Forb0rj0UU+kGLhfuRlZLq2hohtXHTHTBQuq6vRrmcjyuw3kh93IPhLsWp4YRc0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3023799003)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g5Jio7lG4lCaWisRBoqSkqRUjOrwDnak4yBxj6dbFGb12V17HGyuW9yqWZgv?=
 =?us-ascii?Q?rB1ZZO4fJBRhnkIU/yEYddCRf9MKlIhmnQ3PJhh2B5EmhZM+nObfgu3Du4c5?=
 =?us-ascii?Q?y5qb5wI8j4bjfz8Sri0XcJyxdMtlQjSXCe/7D8bysrKvhu5AZ6BQRqOOuGHN?=
 =?us-ascii?Q?O5s64e5x4aEb0THRvkveXD9L3JHJn/z8al55fzYXceRRKweohPSon12xtBvL?=
 =?us-ascii?Q?5kSaH0GfVHI22OoXo3XhCwZhDgv5Gknoje7CcB40RHb2P6d6DBEd/ABztZOP?=
 =?us-ascii?Q?CaV/Ersi7SLfQYzdZwdL7j0xC0S6h/XhGivcSpU30ghk6qe8PAuRko1DSBzY?=
 =?us-ascii?Q?1jmnWKvQHutK+WuNmkc0k0uyd8OsMoHDn/wjYdw3fLikgzBLJqsuZbHLqBma?=
 =?us-ascii?Q?jbLWX4Lfy9yedGcwmI83K8iqeta3jTCSBzToKnn4YYgc2LxCGtFC5+5uKc2C?=
 =?us-ascii?Q?cRNZB713IkPVX5lR8Lu/QHAOs8Uz0vlknk1N6oM7bZSivDhVKSGC1t4G4ifg?=
 =?us-ascii?Q?Q/o4aRySZErQQ7t1X2ALsUt+m05pg2eLu6ZIgIVJ8fc3tP9zgQ+nrHO2YbRl?=
 =?us-ascii?Q?0/lKGlkbVzrBu81EY1x+RBxv/xqM7myDH0xtkuP/rMLTXr+NdccmSzNBmVmY?=
 =?us-ascii?Q?NgWOXOuzgNb27DqZ9tvrkfvLEjqJZSyXv41kz349sx9M0cMYx5uUfXWIM/HM?=
 =?us-ascii?Q?yuKvL+B16G4C6fYlmP8NMpWNq/p1wd720yB3kt7NMoRdAiH/sw3AzN8JF4qi?=
 =?us-ascii?Q?LARg6H2+tSe/ThsqnYMZBuk/lDrFhkWnVKA9B+SonAmr+fFHyTjKqVd7uxyX?=
 =?us-ascii?Q?fuitIMBW1jv22FUF23dj0fXT/SRa9uTLPcEdQ8Wol8m54UVs9s3Qecb02VjS?=
 =?us-ascii?Q?gMN3VX7UAtdt7Li6U8g4hMsP9dDx8bPhG8FFYLRLEIgDgpdbDR2ht3U0ZYXp?=
 =?us-ascii?Q?j0B8Z5Z/N4vHDIrWl7DMIkUZ/6dhQPPD+hJow5Ooxqxkh1HluxBCV/2LnE7+?=
 =?us-ascii?Q?ckGskK6nyFVlrq+N0qAZ4xDdo7xRfKU3FP+5iisXILLzXIYGECq96ePZyOwt?=
 =?us-ascii?Q?ZMzn3ASSMIwNgXcLNo86fmJXb1UVAVPmDYUfqNIAnxFSgQ63SIqj+9sQew6n?=
 =?us-ascii?Q?/bEhUvm8IUulCsE0OelJMW1j4QRgIqP7RBgxJnPYmZNYZ+Em612tSlHl6K9u?=
 =?us-ascii?Q?ph5eemo7R6MyqzBlCsXIwAt7u2/MMULXBGvRwyhGqZfwN6yoexj1TxEcZkrF?=
 =?us-ascii?Q?6BJLfvi1wLZwG3Ro3cF7ALiHbtAZxKwDPPGeM4zhLeagCQ3MVxP/nk3AJ+G+?=
 =?us-ascii?Q?QVKeZOPP6NQiv9cWaQ/ECLwaK2YOXgYLa2LCe3+5yE+St4yYhqqhEsyxTJfs?=
 =?us-ascii?Q?qa5Hqei3C4KvEhU4tbkxdODtyenGEsxcom4Vp+q2VJh2YuwSL0k/hgNkBNP6?=
 =?us-ascii?Q?N3dhL+U+y5cCvZHV/n4Bt+KR4KYIMV1x6qYx3PwYDTfUm+rH8wJfVfdt3x9w?=
 =?us-ascii?Q?DVGh1sgnU68Go7XbziXSTXrwTqSA7qOVvHe+isyxBNS21HFn2Fd7kQH8QMl8?=
 =?us-ascii?Q?Z41tTcj9lxCTXBz8JTyYMmiFmSlyLckMdxxWeqZl8VsHewN8uXmBqK5Zvyuu?=
 =?us-ascii?Q?fuTYPYAt080L1Dat9/ajbuX0X5TQBQJGuE7dUcIyNnkiYJcvKsNNg3jUUZfq?=
 =?us-ascii?Q?apM7sCqIQ69KRaFz2BikAm/D5r71CWCN5EOe6wfKfxBN9Qojbaiayqa/BdRQ?=
 =?us-ascii?Q?llbM4yAozg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00933dab-da08-4b75-ce65-08deb2cde28f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:07.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szhznnqFLz5dT5jxIsCSIdb+pYKvCqmGmIEPHlyRmLGd9DCJbmKnZTFJzP7J6s7diLhotiU+WUck5wLNGVWt0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

The submitted driver waits at most 1 ms (100 * 10 us) for the last RX
descriptor to be written back.  QEMU's emulated loopback is synchronous:
by the time igb_memcpy_wait() runs, the receive descriptors are already
written back.  Real 82576 hardware processes the descriptor ring at
line rate.

max_memcpy_size is (RING_SIZE - 1) * IGB_MAX_CHUNK_SIZE, approximately
4 MB, split into 4095 1 KB frames.  At 1 Gb/s line rate (~125 MB/s),
4 MB takes ~32 ms on the wire, plus per-frame preamble, SFD,
inter-frame gap and FCS overhead (~3%) and descriptor fetch/writeback
latency.  The 1 ms cap times out long before any valid transfer can
complete.

Wait up to ~200 ms (200 iterations * 1 ms) for descriptor writeback
before returning -ETIMEDOUT.  ~6x the line-rate floor leaves comfortable
headroom for host scheduling jitter and slower PCIe paths, while still
bounding the intentional invalid-DMA tests (mix_and_match) so they
recover quickly on real faults.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../testing/selftests/vfio/lib/drivers/igb/igb.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index d44a08a36171..2297382d7c26 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -422,11 +422,22 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 	prev_tail = (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
 	rx = &igb->rx_ring[prev_tail];
 
-	retries = 100;
+	/*
+	 * Real 82576 hardware processes the descriptor ring at line rate.
+	 * max_memcpy_size = (RING_SIZE - 1) * IGB_MAX_CHUNK_SIZE ~= 4 MB,
+	 * split into 4095 1 KB frames.  At 1 Gb/s (~125 MB/s) the worst
+	 * valid memcpy takes ~32 ms on the wire, plus per-frame preamble,
+	 * SFD, IFG and FCS overhead (~3%) and descriptor fetch/writeback
+	 * latency.  Wait up to ~200 ms before declaring the device hung;
+	 * ~6x the line-rate floor leaves comfortable headroom for host
+	 * scheduling jitter while keeping the intentional invalid-DMA
+	 * tests bounded.
+	 */
+	retries = 200;
 	while (retries-- > 0) {
 		if (rx->wb.status_error & 1)
 			break;
-		usleep(10);
+		usleep(1000);
 	}
 
 	igb_irq_clear(igb);
-- 
2.51.0

