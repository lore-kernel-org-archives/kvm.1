Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE2459AC4;
	Tue,  1 Sep 2026 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299659; cv=fail; b=koj2EwC2SinzvfT3KIxQOsKkZq7LLFRgmqVTQ34J2XFNgnDHu2OZ0HkvpoaLjTi5fdPsWFGKv8sei8+b3QWF3ghCQWIC+zGQnyCl98fyMnjP02Lku0n+NySHLSElsCcRBKejTJL2m+eqXZhl1AAYlnfoSJqnQtkPz7mSEW+mIdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299659; c=relaxed/simple;
	bh=nDU5m11U9MY+YtPYaUtHUMY+hUv3m3eo1+/yRhpVnW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+mc7PBBWxmEAIX4z493J3uekqx63LusjiH1kICy+E8QsEn8SWF3FTnCquicM9U6sG4LuaY0trfhrUhISaAIwH9TE1ywGyi2LDg//Rg2nXhU9II/k6EcdfphUTNFVtmT8Covv1N1r9VEwAeCA2zHvGs4Rut5cxCNelbhqYjtJbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cRmP2x2t; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cRmP2x2t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6mJ5Mebg8p4R+F4MHzpL5eKcb1sNAGDsvCnS1fB7N82Jr6XZt5f2Kdhy0FGhZYLHTEehsVHMjfgV5qlB0XtSw4ayApnaqG7IDNxwtykLIccZH6Somph2lp6/fyWWYmMex4uES3HgWx5YezEoPzwNwRpc3aF+W09nBbYPd3qu/nRg8oNOPVqPTaIGWMXqnCPAhlQ5kaDqnXo3BQMSNgfad+FiAoKeXuknrmgdS5arkKEMhLsQbjZAtmX262biPUUBatD3rRAKtfOpn9YzHsa/0OlIsjYx3iy9tAZr+QtQQJKVGp8+BG9AES1//xR5dYn+Ir1P22wOlhV/TTbhKuDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh8u9irCk1u6+2+R3B1u0LVttMASxrmt+E1esw/bdAY=;
 b=x8Q1499sCRPCskgJXv7vfuABEtfthGJQDsE6ymWkv0aTHDhaqPhZ9jFJ4emlNcNrTaNwq4ykRcFlNSaKss3DN86wXQ9TLcosXmDWodYmL06UANWEAy82C5/RaXl5PKAyYEdQICQAh8zS4w892Zh1I8GdSd5tuiUSilnedyh3JHXWSpSuwhjrYUobA9LIkF3EyMXnZM64SUegxudwfMIkLIEI1FN/kAotN6opH7HEN+tkca1p9UlrIDvb6lFrvGvfnplvkrFoMCtede/n+UzwVq4GbpDzLgfcI07Wob/pNeaMwbpA5lBNmDSmjiPrY05w4BUD2wywEcEurGn7OeSHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh8u9irCk1u6+2+R3B1u0LVttMASxrmt+E1esw/bdAY=;
 b=cRmP2x2tPTx5t57MlcBpjMR5a4+CwqIWEmDiV/4wFTs02u/A8GbstIZH4tc/kMO4LBOYQEyLS//IwKH7CYk19wAmdBjuTG0BZkEmnopvJcdplb7VGt/DbRhUq07BXhXIWtSlJSrQ63xyYzjsC6rUC81hGsu0myt7mzGsuSPPAR+mL1umsFUcnsjW85/fcanf5t0B7dxyjGfJ1uuZnL9x7Y3trOsDbnneFD+0INpXJrhIAtZBxsspu/2WtYc2h81+AXWwQ78M1/kUTAyF1d9tok7EcogmuMUjwgwpSc0YMk1LjqBmrsP/l6TCmtse5a1eNJ+KbEruF6PDCxYLrLQZIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:54:12 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 21:54:12 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH 3/4] selftests/vfio: Extend mix_and_match timeout to 90s
Date: Tue,  1 Sep 2026 15:53:56 -0600
Message-ID: <20260901215358.2421359-4-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901215358.2421359-1-alex.williamson@nvidia.com>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::27) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e28cdc-b93a-4781-ec33-08df08738f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	lXpGXSFYQxiy3ySdK0cT/n7DM4Ty2W5AVMVAbp1wJq7RyX+63IBg+YaJniB3y9uRM3vXt/fZjZgFPHkJNSiSf29fVLPnRg1zQmNrdNkRC68ceLrztFWPKvxaxyW5MzmTxqNMfd9j4K9m5o5n6+8xq2wSlb+r8F6FYH+XZeU8XoDlje2w1JyOTxsyvvhSMkck24ZsF8Et28NGfywTQRjmStEnFIWzr50RICKZBrmj2jRe1y8I2Qcm7D9koqDaLsmEQulbTZW3O2pVycrLc/4gKXw+fCghMniuQq2MZKqhUkfHhIvBwy9w+Twz1rjnZE6wC9rTN/nAbnN0crSgWdwLktMu7VM4lESdixTSL88inTfZ4togEjAGDXWTGKYQH7yg5zv3bsXWSUSGeM1HEfuFqfCnxD7LzSOBgLqNGka9m2VAJYcE9rkGrLCpYbmlWK9I7ckujoWVi4dNp6kGnSjIXdAuUCGPBrv3OWm+kCbPdzbi/a1NdHfNGqVX0wRGrLbXNF3XXzc9RZ3WVJ0xt/422BnBlurltuisiXWB+p4DhIFZvlJ4nHA6qWdIGKuZm248Q25wk2hlF9Bz9Aevizjgq2C9UQpmq6YpuX/snpcKMKL7H2EsBVlYr/XOAnvBWZMlJZqAh48N/aOqi7EIEUkQzlcL5ti96hDWGDZZqm8CQFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OtGoOxAleU+uG602yFycnbt/vi5DhR4wtDb8IZd0ZdTL2B9lR/e/9LRn0lbd?=
 =?us-ascii?Q?PgE9PSv7G3zh4aoD5c2VsmPangBtBhhtBHldZ8W3KAovrIpl2FEgZdFg5SZD?=
 =?us-ascii?Q?kMuq2TvG+GIlXNHBF5SIdSuxplBQmtZ1LHZ9bJHLExt+rPeT4lPQzy3X++HU?=
 =?us-ascii?Q?79UkKY14GBSxIGEsp7jmaXPA8ERAMhJjzeYihRpOE1N315fNMsdsm5vG3Duf?=
 =?us-ascii?Q?vmLQbjpGqRmbuoQNA71ZiVUbL2vsCqasC8Wd60WFK3LDEz/XCouHG+Hf8gKy?=
 =?us-ascii?Q?W7HepnZ3TEkBViXVec4JuLRa/9mobJsB/mCGmlWhQxtt4IGcyKSfRO1Wtj2r?=
 =?us-ascii?Q?Sf6kDqCPoYsStLKGGK4x/Hz2bzbUslDk03ZNhXzSBfKOnBC2FougA6DiS0z3?=
 =?us-ascii?Q?vIKJ/S5xXGfEbxQqz69MtCWK/P01/rmU8ery/wMW8KdVDIvfAQjD2Jv9WSVl?=
 =?us-ascii?Q?wqx73EIcdto68m6+ZJbpP6aiVVuyL5VaDBdP+JeJ9mwRR6A82qbAG/BXyppr?=
 =?us-ascii?Q?16v4h9oR6rJJDsMbUnG2bYDK1d3HGATxYvjnxhV942D+fY159ZMeE/uEl2yv?=
 =?us-ascii?Q?OL4Fd+6yGxnqLjwcugm5tR3GeEn7AwJmuPhCGOnH8o4IzhKtOU2NeqjRaubm?=
 =?us-ascii?Q?IOJ/EaAohNRPerTYiBSppyFWbNG+gk1ni3FLJLOlzCsWBnkbKlJUOpU7mYu7?=
 =?us-ascii?Q?aKg07XvOzdHGTETtDg1AxwztE96oBMJSukal1FjZQ0ERKzdim2neVl/+VIaN?=
 =?us-ascii?Q?3iVveLe4PDCttsn1R3CohosQtIyVyuvzeI6CNLdNMd8X2yzZu6trIhtlAVby?=
 =?us-ascii?Q?2Dn1ei4a5P5CO7nYfMJZnwvULHwXUOKFWuQHz1/9K2+crer6WQGvZ9PGh+H0?=
 =?us-ascii?Q?Aah1pYFrjQgug7e96VM3YlOXHmOuixs26K4qFyoi5ba62zTASH3gR42QF1s2?=
 =?us-ascii?Q?Fu4fZbPlu9dZDRoPIo1UJbn+YDmi0YL+HGlD/WKdMzG4P9qu+5rsqy9Fx89J?=
 =?us-ascii?Q?+sNLpmy2Ybn4egXkezijpDpWcUl1tV9fnPDritqS/3vb7TwCcXBZBHuZN3Bw?=
 =?us-ascii?Q?nucUP4gf02CKHPnxmpOiSuNOVvaXbE+CfDCouoVJZsi+HPsfTL9QDV8AyLWM?=
 =?us-ascii?Q?d4y+xw7PlCUGw8FxNfDBfo0mMxzL/jrkt8lCKScY8WeoxPVGarr+6g//3QCd?=
 =?us-ascii?Q?wml+5UPV79cmpsmRdokQJQ5nLpuH0L+UFGBwlMXBrQIMaA8Vc9ZD03i3z/fK?=
 =?us-ascii?Q?ahsPSujS2xe1O3Ke9zYBZPr5uJzAC7dvXFAMZJnsmJXWNV99N+anOgh+1qN5?=
 =?us-ascii?Q?eFtNkoeRx329Ky/ZRyrYIoFQIppitpBLNuwTIvq1w3kTb6zMpn4Lxz8/SYnc?=
 =?us-ascii?Q?/++LHupTHa6iDYwmm+O7Q22nxtiAv2WvO75PPvX3CRys72Vxcv5js+nNbjH4?=
 =?us-ascii?Q?Gskt4+rpCD8dZZuLKV6nW5jTWGcOGbqG84JRhxzcUhP2T9FWNEUwuIJj14VX?=
 =?us-ascii?Q?DskD6KfZB8MOrC2z+xz9tGZgAV8683/N7B0fyLJrxCE0jOtv4Nali/CyGjWO?=
 =?us-ascii?Q?TI/3uydnoJc0OzHGZRdHLR4hxKxsja29c4PKq6mSOxLY5RIYxtmabYJNO4fw?=
 =?us-ascii?Q?Rddq53X63cAyP8+k4Jvw8ag8Eeftay49WtxM9wDVP6A+YVg/2kSj667XR9vJ?=
 =?us-ascii?Q?uw5bNX7YaKFQ21KtlRHNMQZW4yFCGZzTfa238Jiwn5TDrYtrU+PONJCSuffR?=
 =?us-ascii?Q?xQB1AMNWyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e28cdc-b93a-4781-ec33-08df08738f0b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:54:12.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VW0hW8hoZ/hKtxY7mzaWYaxzo696+nj4h79MnkOUywKi+Dg0pt51Srb4s8Dhr+CNtYcCD/Uv5K4CRWam8Ol8fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

Systems with firmware first error handling can see heavy SMM load
as a result of the mix_and_match induced IOMMU errors.  For devices
like igb that get wedged on these errors, the resulting FLR is delayed
waiting for the transaction pending register to clear, which never
occurs.  However, due to the background SMM, the backoff delays in
PCI code wildly exceed their timeouts.  As a result, the whole test
can report failure.

Extend the mix_and_match timeout to a value shown to complete reliably
on such systems, with ~2x margin.

Assisted-by: Qwen3.8-27B
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/vfio/vfio_pci_driver_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 761bf117d624..1d532f944cee 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -190,7 +190,7 @@ TEST_F(vfio_pci_driver_test, send_msi)
 	ASSERT_EQ(1, value);
 }
 
-TEST_F(vfio_pci_driver_test, mix_and_match)
+TEST_F_TIMEOUT(vfio_pci_driver_test, mix_and_match, 90)
 {
 	u64 value;
 	int i;
-- 
2.53.0

