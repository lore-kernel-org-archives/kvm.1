Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE0457E55;
	Fri, 11 Sep 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146291; cv=fail; b=lbpzqSnqX4cDcPYekAkJTymqxPreHwCQR0AwhAgXHMbBtnUeO57R/8puht4MH5XDsZwEs5GHLagOWQFvIHAgDA6eJKh6KbTuaRfhgG8v690EX8/ORjT2md8nj6Yio7m6+yLDZstbWvI65vk1pivcSkGGumFT7LJPLLSzMpuUvRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146291; c=relaxed/simple;
	bh=H377nt6u0NYX7UVd9XucaRcJG0QmIoIOsWALm46xKF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bMD+cssZZAjw0TtxGD5hZxdV6w4hykXzLxIxTwmKm7sMSE1kOvi8SeGdt5YxVPZwVgyDVIJxyE7QT8YoWihO3w6VLARZs8EqQH78qoPEbDVmpcfphJNqAT1l7OvyvA7vwCODkb9E/xoZoVkDrJuxJqi/Guunuk1Zl5q/ASvVrJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JSF+R1xO; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSF+R1xO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5QgDm/Ue4ePFg4cOGjtcoOBiHHCsRPEklUa38U0E7xy9VemPKOJcBvJZaz40Ol3XUQQYYBpiZyfW8WnxjayMcUIlAqmUknButiNh2AUIPltTJJ8cXc+ZzZor5BHuhLwBl8/NaHdQU/K36BavGCsVZwTO4UxzM2mUqoSdXJpKg6fiAYD+WKkroKEevyspcElmswx9MRU7Y/whrptdbrhEz7z6MAxHVZJO2D6hFFTxlgcmusltxyn6SbXOP7c6WOA6ZL6CWrnN6c9OTw18X/WyF7m/c6Emw+pZ6Vl8PyZni2DqY7MKu1R+KZfyNiZQdNdgMbVmb8vHkNRsuJqACBiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaGMMJx/LWZGDPE96zRNDK2htNpyCjvqiJD3ujVj/II=;
 b=uFG6XVKDBXNhT/Wp3EkPWNUVn/qtIg1WVrKnHPfCU/WPhvGw3PAndu58LA7B5KSrrWv2M6QIJEz+vKfG/g8t413LWJHLmI7rOm0tTTZwWg0vHuI6U6sbhdBA5mZl7I+GpKJuIINGizufqgJJmD87tL7wdBVwUbaU3mIxb/pYjHJ20y7O+Z/hp2z2xUGyN/rja75xB0mgj42zKL2NbG+QOESAAPYcr4V/wPdILFFn0gOCien2THvWCEvQO+nOhOdwSt4U0lZFjIRkGePHYk6H5xGAyGhv0CAfCmN2N1ROGYNkkTUDTLE42N1Ufen5S7wyLPXVBfcewN56ciROIbOQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaGMMJx/LWZGDPE96zRNDK2htNpyCjvqiJD3ujVj/II=;
 b=JSF+R1xOJwrKcHjuhdqYeVg9MCQLtbeCFIqLkOEV8sN731H650esHgVcBHWhh1P/AN7xLGImGFOB4O9mJ8xKXP6cc6vkx4zNqHZFFrDNZSPmG+vRMzo2JMj785K3sz/yBOhuZsaKfjCflX80BkeP3WWMf64MTg84M6PdQC3Z3l7kWjhL7hwUkTx8EBA2ihIwzDqgWVcibG6arBuNyk5AF5SV5mZdG8G3WKovs0tZ2Shy1RNxbvhJQt6h5znu+/toTrD7w5PNWFbEN9iOUxIfvygSlj7NCFq3+Kc42OMwDWUwp26MQDFa7lL+dtIq6v91Ss+OjrsDdqNLyTtOaJkA4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:04:44 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:04:44 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH v2 3/4] vfio: selftests: Extend mix_and_match timeout to 90s
Date: Fri, 11 Sep 2026 11:04:26 -0600
Message-ID: <20260911170429.1642480-4-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911170429.1642480-1-alex.williamson@nvidia.com>
References: <20260911170429.1642480-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 980990ad-e2b2-4068-7134-08df1026c6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BpYg2b9Zyn0+9yGoR/7WsRCvc+r0KfJWESbbvaWU3J9h+IAMuZ5LYejyrRoJe9oLSdVnYUX0fMB0YkLo+MmYSdoeuG8UmARxgMAPBUFa9+Li/7BC8WizhcAQ4I2ATnqqfBI/2x3U8SwqeguPHhAjIfFo3G0k2eqD7Y8ZuU8Luvuvk/oW8P4cd43MvJJD8eIlo1/NVk28IbCY7pSCFNO6x4i+doLcaeMIPp4xgWSi3IKSEf3nubom5vKDVfXwiboma+xd2rMptVUF9VSSP5OYPt42+SOvjMY0DD+kS3yHkIBaczjrNwMQgBwb15J2duCAAExDGgC9cS36+fXNzDlKGsRgFqFnO2Uy4Q5UBoAAnoMx8msqMWwbCJW0puwcdByp7BMQ0qEo6DQi339aYZ3yQ587H8o3HCjqL4losj6OKlgZIPlm5nNd1VwVNh/f95gHpWuqfKli6efs6pUqfnmmA10MMPuBGP3iU2uTtYeDKsDrL6DXeYE/GHcWAV/OFQWTc+aTUX9FmyW07Xlnrhu9P7TqTjaQww2qOYBffcgNWBpGKnz5AU4LbCSgkwgrXkCSDWwZyaIjczVtUDHinzpr3n8RNb0RNHN3Fc469AgCRWrtKs6DmZPzCIuAV6IeZlW6ndo5t3qG0CK223YbouKwd/eihgCj+LZCg1Af5diCA8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VV5sATtnvilzu9mu3v0wM2oQm8GKhNqV0NeNbPo0FPx0qWP3uSQpjEp0cxEE?=
 =?us-ascii?Q?DRyTw95b/PFuK+KN+zS9Uq4IUr2xFHiRkRQx0esQdKgtHyUb0XV2r0EKwoJQ?=
 =?us-ascii?Q?90wYf4K/cOIlen6nrpaQOVruyoFPyF4oI2VJ8oiHHHqm6Xb9xQFRCKHb3QCq?=
 =?us-ascii?Q?9SbVLdzrFBS8Je8u+rOX4vAhqtn7OLBH22MjCd5o+pA6E5OiRES7CtRv3Awi?=
 =?us-ascii?Q?qzVJ0YBvifs6+Igs9NBP5gm3fOxOqTF+QQGp0GOJZKKhZ7uCvXAnGnzEAwk8?=
 =?us-ascii?Q?j5AiRcBdEvKOe5Wv6aeXQsLH/twKnIH4j3eeo6xvl3fOdIPfv9DdPil1PIMn?=
 =?us-ascii?Q?Pkw/FZjzvI9K+sw9GoYHRCZzaPUtP0c/9ha86aFH8UD14j7IvcZ3G1TIx4qt?=
 =?us-ascii?Q?FjSPWnEW+FGnB9nX+QNwQPhKCz45Hx6H0eAPHHEJps7HuyMKS4lN6WrIJqKJ?=
 =?us-ascii?Q?JD9C2U2Zrp9kYfizpQQDOigLml7pPsIaZ+kNHOfLxbQH8A5FLrKN8oQ1O4+y?=
 =?us-ascii?Q?abykGZenKFeVgIFoucmwEavrErXTBEcXyRYx7XwffpYXXYmJG8VUCPHhTt6e?=
 =?us-ascii?Q?R8I8eCxGNpNzt6ZHCzL6KGoddL2asAHCjEguib5lZGWymRKRmzVpngDN30wK?=
 =?us-ascii?Q?ty4Yx+WxmqBeVxgTYYJWAAvs5XAB62COHxStmKFFxgKSg4orcg+dRFJCVa7Z?=
 =?us-ascii?Q?x93M5gKxGzCv+wkV3pFBhMkSNyXDWXLYlG6KmZuqNKOn4kWw6HQSERYRlE2+?=
 =?us-ascii?Q?od7oN8I7hHc8Xsj1de4solEgWY1RjEMZfDQ1quIjYNUNWpD9QAwe2lOfbk35?=
 =?us-ascii?Q?E4XT5Rb4tg5avfPSgZsxcCFi8WZg1IW6DZo0kmbJMY2e85l+hCyBYG7yrIgI?=
 =?us-ascii?Q?xllxVdbvLK/UvyEdrAWcv8zyan760tENJa7thXyQ7o0u7YfW/RqeKKxNrtTE?=
 =?us-ascii?Q?5n2yxssfsHbOjfJ0j2YsT2qWebgulyvxEMnDjly62kPwTp3c54HmEgybeN2I?=
 =?us-ascii?Q?4OdtwkAnZHELFSYubFLsfk4aj0nNKStUJTur3TgsSIUWFuP6CD1dkrxSemRk?=
 =?us-ascii?Q?asA7ldcN7b+X2iDhuN2hoNCrQmqA5O2/Z3x8AQ6+j9ijvLx+cv+TUMKR3LuH?=
 =?us-ascii?Q?vV4zs9jP48mM022mz46UwfHFk06W8DDALzE/pQqRlkJ7G1ijkm8kHpHlHfCE?=
 =?us-ascii?Q?G/RcDC5QRdto49vjfDIuX0GZphwlD9lLX752NEVBt9umbknRRKovED+VD7YO?=
 =?us-ascii?Q?bRUqRiE3AueIkHd5YjZFLbkmqINzY2lzsBTKHn0RSUrWrBOsbIBCOqlA3rNM?=
 =?us-ascii?Q?j3RFyHoECFY+8EDeE0pdWDNMICjGdPo13w4V5EwDdl+gFAe3GVQPIJGQn/gh?=
 =?us-ascii?Q?RBwy4nVsh+qc5ekMCNq733BHEg8jfOUIYJZOabkM3+9r767YSFA6nGW6rCFR?=
 =?us-ascii?Q?+oNz/zZnuymKx/QlJinVKOOmORRez9Bo+mTxyaC8k7vnDBpuW1MxVVSPWh5U?=
 =?us-ascii?Q?h/WudVLV900Rub02vtSMDRh51odF8fEOjPMP+WTLpCd8GASZ3j543xD/pIYQ?=
 =?us-ascii?Q?4mp7mh0jh/yFpvKumabLBbwfRiBcLI/T8rCB6KJTK33T3d5jvTiDZXEKDWbp?=
 =?us-ascii?Q?HAV+tsCQ5IL0ld81Wyd5PISEualUmEuH3pj4xTDAwHmmku/ba6k51hnpEi4F?=
 =?us-ascii?Q?XrpeYzThNluRHJ4qgKfU3Hqyjo4c9xDQD5FTs9PrDaa64xWRhnTFDylvsV8+?=
 =?us-ascii?Q?90ZxfBOVIg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980990ad-e2b2-4068-7134-08df1026c6d5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:04:44.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVSoBMI0+D7Gvj0mRLjG+jrcLdMTuSEX65fuIPRUzQfN0SdnRIDSkcanL3tM10VFv3IwyO80Ya9RPNchBQyK1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343

Systems with firmware first error handling can see heavy SMM load
as a result of the mix_and_match induced IOMMU errors.  For devices
like igb that get wedged on these errors, the resulting FLR is delayed
waiting for the transaction pending register to clear, which never
occurs.  However, due to the background SMM, the backoff delays in
PCI code wildly exceed their timeouts.  As a result, the whole test
can report failure.

Extend the mix_and_match timeout to a value shown to complete reliably
on such systems, with ~2x margin.

Assisted-by: LLM
Reviewed-by: David Matlack <dmatlack@google.com>
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

