Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AEA3EDE4E;
	Fri, 15 May 2026 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778882660; cv=fail; b=KfeTi+Xk7th5xLa513BFazVUlOxaBmBa/dBpNN1CT4Xodj2OzXPhpx0lFjbfbsdR23D3Iyh4veej2z2YSA23yXQqhDsD0bqgGibV4eIGdCl9cAEQ60VV4DEk+fbpGJjjchbtakkV40YCkMXpIF4NRWH0JqSVo+VAU3KEcsg0Xo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778882660; c=relaxed/simple;
	bh=ZoB0hbw4+iLnjEZJO5pGXxuVy6psxRa6QnFZkfHgjKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZD5pFZ7VJ0UOx0ofSroVKA3T0SmfthYKCd1FnP+iP/POzezpxzHl6Pi7d3Co0UBUHK/D6UK0s4P4otfozjnv529xYdZlaKB+kFcDBScjjbcWHaUr4kxJAmuV2Gor9+UZHPIQ+ib5vzqrPxS78g9RSMC7nLWMaBYe/X0w+TlCmpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mvnGFjds; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvnGFjds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlMFlOzSNymSUiT1sz3hHRQsjlOTu/0/Y05Ub/c8q1Ya0BLyiI3Nnq2gNpDjp1Epe8m8zmeVAsJiKqDi4VHdBmoKtK5FCgJRd8TiXprYVs1YRwCgGGYC836esUUZ1Bn7HNmSQqnAOqiEfLOa3kksdg8leAK7p3XT91GJsp8LNZPYDvn+vh8Oq4yhUmEzZ9N9sFC20+q4Jdel9ZgjXCBYLAX7wLKWItM8mxoaZlqnHyesFnlVM9WgKfWdVHzkG/CjO8BxuVirLXs/P2d515zMiT7GgOqLobX23+KB3EMOvSY7Q/xHMFWCf97fcTG9YcIVX+6fjkCSgaedoU1QiOtH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb9gK+f94+LwvpvHUbbQRKoUDNo55C27S8PkdY+4nxc=;
 b=Lk1zLU7GXH0mtBIPb7zq2z6/4Vk2QrPxKd2qSC4CaRMh+n/oOeg0dHhA/1kAsvUuC+MSAaX4GzyUSIASr40+y+pLpQ6D3YkKHeyJZBltmHOxA3VN0jaqorD9sm1SeOFcDl8eWZ8ysXM06HfdlvJqLC9B8Ke1DF2Ie3kSQgHRFxGf7i0m7A7KFHS8FHnwbc9hiVJz4O8hZDIZN60T1u2NJs7Sax89mRXksSVqrE0KEViLMlj/7ywUbVnPkjObjFsj8gbrXPP/gvfYunKThEM43t56SFRYbYm0YL9AJV2oFp+pn1OCKrJX3hE4nqQGXoHBCe+cF27HGZa2iSLTzmMaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb9gK+f94+LwvpvHUbbQRKoUDNo55C27S8PkdY+4nxc=;
 b=mvnGFjdsOhoXRLFUm0hqnGJP6Lar/qeAOYKkhN6R5zYZjuaRK4kNmSHKucD9KqOftsQs9la4btPQ4LJ5h1yD+lIbhiOJ3EoLQdOIP4oIH2xMcDtU+UDGZhv0ORGTA1Xq3mw62vY2ezaE9AqmodxVN/wzgYYZBKxWkMpn+tIfLgz7QyhqslnuMAPCjC/G/g7f4vRESP/ClP/Z1Nd48PZrFApjxcDzslteYdkscWmrITSL54Wf9/1pGu/4/IrTkN5kDjoUbw/tj04N1pfBpYY3Eh7aSw7LaCLUz9XC4KfJ5gsui0QB3/IELSB3NG8h/aw7cWmTydRbCoeZaezB8DZrfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 22:04:08 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 22:04:08 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: jrhilke@google.com
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5/8] selftests/vfio: igb: Disable PCIe completion timeout retries
Date: Fri, 15 May 2026 16:03:12 -0600
Message-ID: <20260515220330.565792-6-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d8a647b8-951d-4048-16c6-08deb2cde305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	4PgGAlsx2T5j3Hlw69kGEiDuEw0zbfd3tKBvbHgQH59Xi1nl2rcjPxL5AyNckLzWwNtB8MJaUZgelafyCJ+7Q+Ox49PWzE22Hyk27m9mBvk9bH8dQ9ZqDgEEIhp9KcK+xiyvThbE3gzyyQujtwYO2cDITQdMqrvZGWVeA7v5GgUYsqRlLX1vovC6zTiwfpwuAeNxt7tUyo3x9lfHXjHh50sGBfAtgY6eX32WdckzjwmpRFXVrFZhYIY+Kv39L2G0V3alzQGBIaZV+boE6+A2HWXeuLbZhtRN/LJcW08a7cHoxV+K7PryqHhgLMNHEw9drxzZHsjPGEx3OEvUOwq+21SsunhzxMJspLqmYcVyjfOswCTC8PRbXNGympjZXy1Xlko8TAZu+tZ3lU8awKY7WtPysCRJalton/c3ciCAqUTm/6VdssyJ36PjA7AykY9NdpisG7hIJJHeYTjRddBqVmvaeA1Ck3a3O7JEYRk0mdBDQSGs1q4y8kjJAHVMm968qeqE0vGXolOU551J1uBClgevcacIP4RlqNhv9YDMU8SGSIS3pSUhVMAvu2QK/ikmwCYWOS2cFrvZ+wsoTI9PJpSMWPVpiVen3KIiftxDndMnRw/gxmFHFNXM6NeMdq4LMgScjaXxNxdywqxcefJ+z/tGbxrmFAvftAg94K9o3JKpc6YWjWQUW+JVzIceQk/s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SxeMRXeyH5XtVkaecAzLhry7c2V+qBhgtt/UqhiT0NKvV9Wa2U8Vue/l2T7Y?=
 =?us-ascii?Q?ArG9oFANa2smlSjq7vlMkFenBv+6ucgEBFGn16ZaJv+M8k5xa4xdfuhSDW+b?=
 =?us-ascii?Q?9e/niHhx7u6msr56CK228953OT4XIEKcANRqgm2hdlT1jpHmuuF4fr1ojyCf?=
 =?us-ascii?Q?2BOAoOWiKoKROxBsosWrRqOQqEWBB+lyPszo3MMKwI9i1HwSbFAKnLlCf7Z4?=
 =?us-ascii?Q?yWMXP0xx4c1oLPu43VPoyjMNFXsEu7aOru8ph+GDg2H2za6OKyrVBaSZOOGM?=
 =?us-ascii?Q?G20Ai/njOUv4ufafaC/5lq5h+15KdTRIoLkx5YsIDDvOF9F5o5PoIMLf7hcB?=
 =?us-ascii?Q?byEpPxf774EGp+2sy+jT+KdtDFvDUZZv/CD4udh9LVDGS5uCKKpy1ceVgcZC?=
 =?us-ascii?Q?ygCtjL83Bx7nmz7TfIbTnlZ1rSobX3DYbzE9ltbIbJxMkcpoZWWgOofAi5gY?=
 =?us-ascii?Q?BD6xTGR6+HtY5RvW5UVqh1mrKcfQEO8GP9o6rKjr4jnOo9W6dk/IeE8cATVR?=
 =?us-ascii?Q?af1x9u+Gj/dVlj4Hjrl2HMyVCHoYnjClz9SlJtIy91qYqIlgvy2fCm1nDYed?=
 =?us-ascii?Q?mN8MYmejZbuG1AtCBcIS23fGB0589R8gwZ+M20bFZSE/RJeX8aF8Q0rPF3l3?=
 =?us-ascii?Q?ewarTY/SQW9rT0sNAA0UPHSG/bE1adkYo9pT7ag2H/VE3EmsDpeeTQY5GTyT?=
 =?us-ascii?Q?W0pOXQAipZ2lwwvORQSOuIX6U0a5a83zV/H6NQQUJlyfxDngz7zl1ikqUljH?=
 =?us-ascii?Q?EPMyl8LBeZGvD+GBgQ4YVNXpgb7WfApswMdycvNIKv7EKK9rwoFwWWzni5Ww?=
 =?us-ascii?Q?xt4+MIrgTFGZWiusQG0fxx5lGs3Q77UulGA16pVwb3nfN0MT1BzrGvZF+C6X?=
 =?us-ascii?Q?NizHvORdom2xGAtfX6C7EpsbtwlyOnzc1RGa2zhPQD/d6y5YCEn2+sAxLs6H?=
 =?us-ascii?Q?51MWbfsdJG/irmvuCdur/OMrz0T9Uau9aWCL30WfSxS1Pq/UD+q0ExFQXlCB?=
 =?us-ascii?Q?nNO3Gkq8mlXYv39CTLV9EK9ei0eFDttPcmSo9+8qmSId6hobCi6i/arauseE?=
 =?us-ascii?Q?8whkQz2U549JO2YeFY/JcDEGJUbvp4Kv1O9ddZrCPgUarGHtPqmQsxjZjv3+?=
 =?us-ascii?Q?2yhM8SRINLJ8ggLFGPM+hrL73rK2g93zeVafc/GSefL5Hee8TRc2bGJrtyRJ?=
 =?us-ascii?Q?QpXkg40SuZP6xmOxBqCuQBN1N5iu42Vhz9DSQpgFyAGK9EN2DD0/sgV/wg5f?=
 =?us-ascii?Q?OO47uCXNiwjMK0UGZaYK0l6y90+VGhF3lmCdoMLWH0UJfZdvO9FR8kldk2rz?=
 =?us-ascii?Q?q4S6EU8O2ILGmKIdLSqPZFAMuJNq+rQtCT3Oa7YTB5PodYi8WhWbOhakIy0B?=
 =?us-ascii?Q?LnSBxJMQh6TAo+rGnYkKzK2o0dTlmIFAquQqc7PLUF5Sip4exdAj1qI42aFD?=
 =?us-ascii?Q?8a5pYZqm7bQdyXlQ+3aTkFAysbLLm3REztNdZKXionaLtKcz0xAQick9O020?=
 =?us-ascii?Q?kJS49DgIu5vvzBoHfXPoWuzK3zEGQQ/CLSePOLTg3+sBFGfixzpMnQp+XnwR?=
 =?us-ascii?Q?s1XqR5yIfXWnyFx+A/iZXil4PkqslOAkH+FuLz+hM5JHJ1GCY3Z0jxW2n20D?=
 =?us-ascii?Q?soq3sTzpcGpZ4md2pZN48jTqtMW7KGKvDphW+i/kgsHMvSHZN+VU32m2HXWN?=
 =?us-ascii?Q?Uhlf9GQTXw9yqICXJkeJtThxD/h9L6kNf2J2XYRrIuMgIOnq8Hu9qx7f3319?=
 =?us-ascii?Q?uLboSvOSBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a647b8-951d-4048-16c6-08deb2cde305
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:04:08.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoU6cVY3ifr88iYb8gAQmR+RBNiG35LF8n67bHUDXO/8TIKygH5XHeIJn9/ctAS6kgAo8LUILsHtw4JzWsbqGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

The mix_and_match test intentionally submits TX descriptors with an
unmapped source IOVA so that the DMA read fails.  By default the 82576
re-sends the request after a PCIe completion timeout (datasheet section
8.6.1, GCR.Completion_Timeout_Resend, bit 16, initial value 1b).  On
real hardware this turns a single fault into a stream of retried reads,
keeping PCIe AER and IOMMU error handling busy and interfering with
subsequent reset recovery.

Clear GCR.Completion_Timeout_Resend during device initialization so a
faulted read fails once and stays failed.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c   | 12 ++++++++++++
 .../selftests/vfio/lib/drivers/igb/registers.h       |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 2297382d7c26..9f93ec7ba8bc 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -213,6 +213,18 @@ static void igb_init(struct vfio_pci_device *device)
 		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
 	}
 
+	/*
+	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
+	 * section 8.6.1, GCR.Completion_Timeout_Resend, bit 16).  The
+	 * mix_and_match test intentionally submits descriptors targeting
+	 * unmapped IOVAs; with the default (set) value, the device keeps
+	 * retrying the failed read indefinitely, which keeps PCIe AER and
+	 * IOMMU error handling busy and interferes with reset recovery.
+	 */
+	ctrl = igb_read32(igb, IGB_GCR);
+	ctrl &= ~IGB_GCR_CMPL_TMOUT_RESEND;
+	igb_write32(igb, IGB_GCR, ctrl);
+
 	/* Configure PHY internal loopback for testing. */
 	if (igb_setup_loopback(igb))
 		return;
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
index 139f1c2e6fdd..45f71dc26e24 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -73,6 +73,8 @@
 
 #define IGB_RAH0 0x05404 /* Receive Address High 0 */
 #define IGB_VMOLR0 0x05AD0 /* VM Offload Layout Register 0 */
+#define IGB_GCR 0x05B00 /* PCIe Control */
+#define IGB_GCR_CMPL_TMOUT_RESEND BIT(16) /* Re-send on completion timeout */
 
 #define IGB_VMOLR_LPE 0x00010000 /* Long Packet Enable */
 #define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
-- 
2.51.0

