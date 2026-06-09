Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3B3EF664;
	Tue,  9 Jun 2026 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047753; cv=fail; b=cKx//axwCGRMij481R0ZPuSadR78uD7GWT21yKnMoF3llL/wF4wP2czfzrnzUoGJGX8+H8708J8J+EYdsOsBAngxbI4sB4jS+N1l1zgY6+rMpjVw1wt/9wlzWMN4CK0ogDV3y3cxUOuPMDY7Gg4ssk7dV78cQ+L0TAobjum8fVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047753; c=relaxed/simple;
	bh=HtJwQJo9ROfQhBfLfM9OUuslx/A5gRWofb0qP/UT2sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X0AG9rHp+AmbVF7bYT4dMFJXLfA2L2tWVoYaAvuIwuJGgigDESU3o1lVnkhCCeP0lpLkTBPDen8FnZcj0MLcX/6gHbaEBTE9OqkmLmxwpppa9DzKtGJ/q6IlDDEqd0SeoA4qJcGhsqp91vYaqnfJhna7PImGoRGw7VMoHiPeKhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XpTRdoKd; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XpTRdoKd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/DAbAUc/BPmCl0rfA0b6JI3Of8L7O8MiEgnOqsNXQWzEvRvtfyzS+t88F8n8bEgERvtoTj4XwfFsehuQU9TvkQzjiofeJRuVGKMnd+LhQW4hYRvHqKo0m+VaAKAKRxffDdLnCLTSXJlqBeuWlxuiBEVz92b9XGhcUg7MdlXz0fiJzmXQgeJ5n2M+9mNZtBINRvcNSTAsJLGSxIPGCXteXjq+yvKrIZ1jEcTcdTVcbka8bHhVI0IpdQxbWMDZhI70dh4NisveAo/P8p4HHTlJ96j778inI6/65xUrXEZxOGS6IbQHxGYR4Vlo01ApywXMW/gsLJ3kJZgnJvNT2Qwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCtSYzzdthCig0iSDzMTGlHUg6Wsfyjwv33d04zaXkE=;
 b=jQmTxPOIRwW/NnToPR6FGUyIhab3/xZuLb4r9nglzHIQxBKEwxxOqJjRmocGs8ZZE5hddPo3WKAqIIrTs9WQnz7ciM/AVD61MiJrKtPUsyH+njE+5Vp1Lt2wxnYZEePveILob58RdUBiL5Jy67Str04QauxRbsWwByGJ3Ehgizs6tqd4VXY16ILGjrhKvjw06NCsedFLo5C/xCx6OFJh+jtm0CElb6QEDnJOXFnKmQD7V2aG1jA31lBFzdwY1W86okN+ciK2xLfW5NTYICMmAcQKSj2RBujCBsmWXnM/kgdzlylcN33kblXpqFh1ffnBi0pqzDo+ISdnYBWkzT6bMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCtSYzzdthCig0iSDzMTGlHUg6Wsfyjwv33d04zaXkE=;
 b=XpTRdoKdTy3/ucsIKEP3jztBWSI92puLvE/2wEu/P7wWR9kYix8Xu+3coI/ne1ScJAtmWXtqG89etHTjGFIxqfbNKy4yW0yDSmGgV9pK8AVYR8U+ZL/Izc+s0sBb6u+V7CMA+SCz7W8y/+WHpU0HhB7pQLeLDDTb7VtoFBFK6aUfq4KDZ/KBwe18o8oQ84xEs3FV+KqM3ghBFb0RjDL+pdJ1X/yxbV9cqLPVGUaHLmKQt+wFo0MKGAMFavOhzXfpqrDfCHGr++w7j7kOpmUL/r3vChE4/GDCusrfOvxEiKdWireeLECYILEXAIpd1P9J1iPr5VdU7800DE1hG3/WBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) by MN0PR12MB5714.namprd12.prod.outlook.com
 (2603:10b6:208:371::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 23:28:59 +0000
Received: from IA0PPF73BED5E32.namprd12.prod.outlook.com
 ([fe80::8780:2964:7709:6b58]) by IA0PPF73BED5E32.namprd12.prod.outlook.com
 ([fe80::8780:2964:7709:6b58%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 23:28:59 +0000
From: Rubin Du <rubind@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 2/4] vfio: selftests: Add generic PCI command register helpers
Date: Tue,  9 Jun 2026 16:28:53 -0700
Message-ID: <20260609232855.3808971-3-rubind@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609232855.3808971-1-rubind@nvidia.com>
References: <20260609232855.3808971-1-rubind@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF73BED5E32:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c9b04d-6a47-4b0f-4e00-08dec67ee232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AHVVWkNeplJWoIgjV9q9vjAI5Av73RS3QqRKuOhyzBB7iuTHyyOm9MceMtYT2M5KJT+iqzDLUVHk9MsvsbyPYuhHpAWp2AaPgVskyy8GgvDFlb8jKFb5Dfjx6P+w3hg9cmawVlx9Pkp3jLsk91LT3PKL0KNT21GaZo+61e1B4jKqmkzPpL3tTXLn0AOlaUubcGo6DFOhAM5SMt3iy10vkQVn/yH+ZQ/y1+TOeWHqguX8/Glff4mRkzl8iA/cT7wXSTV5TFdcvouCweVYdWKYAts0IWgOlHWskjggSaaDBDNUpCF2LnX6OAcB7FBJLmaalUCde7OaPdMF3m4XZirjTAac3rLu8DORcDuDZ1p3P2tMo8+mnwW7yO0N+FBjE4USoOtdtTn04NXQ4JdUlcfC5geqtNf1o4U/f5I618ctn8mLUxfqDuzNWKkqlU0vl97QaVh6UGUO1h03CShu+PrhHIKk9PgvQZNfAcLisivTGC+ZIKn0xoGiNr8QgGxvcSo7OhLDnYk9Yju7lhLn2GMGZIaWwDAKt+GxvlENkP7BwzjesMIva4qRaNRpcc7OAiTtPsre+/+YpS3SYdrGcFycloosR0DXKLj6s7XEmbfsDqgWkdOXTTQT/K1SfUs1RROk4z18WFb4Q2o2OuoDAzeRmikJoRanXIyPFsSS5qOsrCui8I7tAuP18kgMqpXt/ye3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF73BED5E32.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOJEqSGflZK9tLiRj6ijHftJDnnTCa5zwgk60mhq/YdehrF32uvcVQ9dRJKc?=
 =?us-ascii?Q?rAz7DxQ1dnzjwNRFCGdJ/HnaP10o2zpC9yJAKXA8iEP7D548gAFehSKCU+ty?=
 =?us-ascii?Q?T8UCxbB1Xm9txbu5Wcm02cvtPUAftZwP69gT1PfkORwvTEHc4+kIVzuxJycO?=
 =?us-ascii?Q?yynLQYx/geNroBMiY6hED72BGnJQveZOxqD/Hw1f3HBjpMKW3Uf5iwQ+kRK6?=
 =?us-ascii?Q?m3BofTYf6N8jqhcg6FOqI/6Z7BdvRpyZA43N7BUw7enKK4j4yjt1KTX7nfxw?=
 =?us-ascii?Q?Arc1jpA94hAG+h7j91W2rFgpKugxJQIsho6LCbcI/1ctCZoLD3VIekRMJF+9?=
 =?us-ascii?Q?WcwQFPv2caT/FT3zIocp4YY8h84CxYWW2L2rNFEECXuEtldo0nDaCGlKVSGd?=
 =?us-ascii?Q?ERml77mPVy3t3/rT2RssJkRXAriAimNCKVhfOk6EnqD5oPQG6lTqxb22JWOr?=
 =?us-ascii?Q?e32KrJ6DaKOPbUA97R0E+umi+ptjVtjWR5aD8V6qoZBHOo/zN8AnsUKCarW+?=
 =?us-ascii?Q?LLY+FO1NHiwyHxv+/RW8SKqDUoMGgPubacPAjrTfFU2uJ9fcSCKO8QNYi4z8?=
 =?us-ascii?Q?EshS3pc0cst4Aykj30TNW1f24f3h+g3QVYowe8by+5K5wYViWtGzex6taXU3?=
 =?us-ascii?Q?P5igy/eUDWv1H4DmgLWD43CUpvv2XNnpx9wC36R8CEDj5NVGzQzgTJGxoSC4?=
 =?us-ascii?Q?6VS07p0oq3eLOuH08HtCozKF6eJM79XueNl/thmpSMLb87jR1J6/zBtWmlkw?=
 =?us-ascii?Q?C+qvMyP1NeFWBheeMGo0EcTA00vdH/X45MY+TgcEPUpoOKuprSL+2wh4BW/f?=
 =?us-ascii?Q?jxIIEWS5AU8+x+GBrKnH+PIh0kzuqQPuEHS1iCUkkZhSOaB7984sWAz8LYLn?=
 =?us-ascii?Q?yUME7ThlIodckpsATkGqBP1PReL2Gh16oIlPVRiYLMwNTqD5ITss8HYYQcQ+?=
 =?us-ascii?Q?OhyvTkTVq+EDCKGAFDuIrLUEIUPe3rFp2L3z+M5HtZd0g8MvnY0aN3SWOOW2?=
 =?us-ascii?Q?AdFdhhJWnX6HyHy6GrOIVaEy8pJ/fI320Bop7o8OdmVYj4gpPIhRugP9Wyr3?=
 =?us-ascii?Q?AZ5CzUBvUU+c/w82cKKJ7/dub3OTPrHfA/8VkAY56ZZI2Lw4OgTsyjOJ7ltO?=
 =?us-ascii?Q?Ojxfz1Qh3H6nvQZSSnYAvFrn9PoKYCMywaVDh/JW35HWlXEbpz4d37p+8oef?=
 =?us-ascii?Q?jdcpTf7JEQ8hxLUpmtf8lJhu66qTVdiqlxzyRthvAlwghz2WBQ8OE+GPBvj5?=
 =?us-ascii?Q?yAn/0UjoQJb9+RrwflUMWKZoB/GVHml35afaFxHe4JWq2sHlu/YiHx56Xh6t?=
 =?us-ascii?Q?4Zawzi39S2YEftMPNodeCPAoCZ3HvxX6H97klu4vnWU3x70k13SXZQOq7JFr?=
 =?us-ascii?Q?nDUhX+dggOzEiXo49jHMgBpERfuEFbJHm/hPS7RedXK3BX8+dz5HDA4T/Ek/?=
 =?us-ascii?Q?9qHELPq0q85qNhFux8brVk30IeSvU7PqvWs5jevMiuPJ9+JdC1XnH82iUqSH?=
 =?us-ascii?Q?Ay6jPTc2tRCdRcbQ256SkS9Qa+YC5GI+rF2bDa7CkykYqqZHYSEBEjPiCgWW?=
 =?us-ascii?Q?3iV4N9ztgFJTz3S0N1r1AuRWTOtq425/kJs3gb+OlzDjmSV3ixulrJABGsjU?=
 =?us-ascii?Q?Uxc9qBTRPGjjR2QBsAxL5gJvED7mitSsYmNNWPeQRxVUEAssECzCc2PgT8J5?=
 =?us-ascii?Q?sM8z3tssF8TaG9yGAeoU0YAsV20UB5J5Ykxq/AJmfOjqI3cs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c9b04d-6a47-4b0f-4e00-08dec67ee232
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF73BED5E32.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 23:28:59.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jY2J+3yOmAxjQtEEXV/G7nd0LZMXxRxw5o7OPIchGD9udtNB4XtBoA2g6eZWqedi1ByJlvr6uW/fZWJeLN24IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

Add vfio_pci_cmd_set()/vfio_pci_cmd_clear() read-modify-write macros
for PCI_COMMAND in vfio_pci_device.h.

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Rubin Du <rubind@nvidia.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..bb4525abd01a 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -65,6 +65,20 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
 #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
 
+static inline void vfio_pci_cmd_set(struct vfio_pci_device *device, u16 bits)
+{
+	u16 cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+
+	vfio_pci_config_writew(device, PCI_COMMAND, cmd | bits);
+}
+
+static inline void vfio_pci_cmd_clear(struct vfio_pci_device *device, u16 bits)
+{
+	u16 cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+
+	vfio_pci_config_writew(device, PCI_COMMAND, cmd & ~bits);
+}
+
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
-- 
2.43.0

