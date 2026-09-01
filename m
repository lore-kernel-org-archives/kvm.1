Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8B367B84;
	Tue,  1 Sep 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299658; cv=fail; b=G2kcyOzy8QC5cltA00WuuGdJ1K/BgFlRxDAW1mtIuMK1QoN/0w0QtdL3yOKBDntTDYjoKGHbc4bUH93JraZRD/UMa6Hd5g3TY8xiZikmaB9pn3J/jl1RXtvBgUe9gYDBRcARCJfdcpRpyd+OHVyFzG6BiMA5KkPLPxVsy/KxSGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299658; c=relaxed/simple;
	bh=Yd+rX46QtCerjGv/GcM+u7sYam400r7YyzOCBaZfte4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NhhpbwAPoL0w2IN4AC4axkHtt9hLuzS2ks2oeqdtrs8M4qYO+KQDk2dNzaElK2qFLvNebaY5mYO+RZtoi/3QGHIds4FUM1oV+OK90dr9UVAVRvGMxGfQuBxgxTamx6XN3KWCt6cjBDmkv4tC/tcTbNDXXTQ1Mht0+OfCDXnJAJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NxT0BfXT; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NxT0BfXT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS/rQfDAKeEYiSXRSIIVbvgax253YlK6PLYvAKW0UtxSmP2LaA2WJU0bHlLvWxO1AiNbuzJa/9Bv3VO/9Yv6hVWKHqeph5iRWPN5gftQMZHQSn8auG4ZSdyujHq0eoieW6nIa9pHKutM39num2bLjSdr6gYD+QO+WpzQR34Vr31hY1PNTc1vAx8oGjMTzDlmgnSEagJ0twetoNq7aUVE8X/OAdUWJxkRX2PwC8S7opopJUuNDFlaj8bK/FhW3iW/XVmWJoOyJiMzo1shCwhEikXtZ1EIg9ie/QTyj1CWOJ4cNWDnbGs+bDOxXbR7skjzoZd6mjQbxNtXLkxutvxixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV1RkeMLfPSfwXRzumQFaSPbnAcOGHkoQink6YTvzfs=;
 b=DMJ9dCVZ/A8mNo9koy8p7iUdi5Qf8p42Fo/lQ8KDTerBonx5r8d3TcoEKmxHR73RxbdE3xmbV1n+dy3yMhsw/LgkXbAkpCU+74M89INcWB9QOi3HpzjpWTYPkYMO28Gbfa/KdvPYTL0l8XrkGsozfgq435JjgqcfFzA4tHwBFmNDHjGbxRcodwNwfBHZO49QBWYPOHQrkg2CZEmX04JYW7Jmc3TQjz1gG7sWumsHO2l4Y/8YWp5pzYabb0Wq4z/JXwR8HiB+SR9QdSvJsW1XwUPATSsydnEzFWDryAQgjqTwg3be1v8zlsvs7LcXkntkRoUViVhUvk6CAExmQQu35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV1RkeMLfPSfwXRzumQFaSPbnAcOGHkoQink6YTvzfs=;
 b=NxT0BfXT7eeZnsJN9GxlzACv4afbDd5uyiTZEfsaeZ+6qy1iV7NtToivH6VmQ4GlGchB6NZPvnaMa6Q72IHn3JKeyshubK0gPQQNDfw8rInT5Qcv0Armj4dzkV9IwJT1CVAM28NcJ3VwEjklwJ9KKTzPraZESNSeiW8yq/TPKiowNtqRDHtJ7SbLwe0AG8cWgJMJbsUOCqvHNABJEoboePk40tsPxKOLPDxj8Pf7hJGYbctqXCUDqJf3y52fKmzK8vgsJu0xf3izh6HtxJhp+t3wtthkTHV/yoTCyZ0ExMymi2gpsCx9jCtl4RoMCegjzEMIfUV6p0BRBHbDm+PqKA==
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
 21:54:11 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH 2/4] selftests/vfio: Wait out transient -EBUSY on open/bind
Date: Tue,  1 Sep 2026 15:53:55 -0600
Message-ID: <20260901215358.2421359-3-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7960e2ca-e5a1-412f-72dd-08df08738e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4RyVBOiYjfrJQ+juXoUeJGKsfZXa+IFkcQKK7UcFTwTNSqvw0BqdzXMCIx58OGDreWwPlZdlmOcOlR7YHweBqNwf6QFN7H6oMheETr6EsNmGo8aG6WTx/Oiz7qyM4gJnV9DoC1PHtyuius9EnBA02U4W4p2wq3ccak8JVdiUQXSNacR52KUIQpl4o8eX7jpSk6jXJTcgQgBxxNLfMfEGrMABuYqGndbWdTs51PrSyCu7+RuqNSRtyDHA6dxM820KgoxxB+00d8uqwNq/jR2c0rK8pAtVIL2rc65l0jH85BCKS+kM2xpoAAGwppcP/J3L0aZWUbMwocpaWsfbi7RHV8lhk/yMQGoEYkU8decT2IiAxJzoK5Sjv6/x/2aUObzxG0ofOJIDmgVkX2B0IvCXSRbdPeEhGrO3VMSv0uDZLuuy+bCVHOwXCILsHYfsPpdjIWA3utJNJcxmnhAJNs+x49wQMaX/fdup2panYLP9bbSAq536Hbun7Gq5/abAEdKYmdB7TFO7t1ObaQCG4YvbGrIMhXLqhu0Zr/Pqk8mpbv5wiFFc9Up+ka6qJW2gKVcIQ6DglFePhM5tbiXQMUL7NIZCgq0MGH90XJaRyRtz4xAYw0HTNZvHY8WhssNW/7yiCT8vzJsXzukfzaz5vB1Al9ti/J5BteG1bBeEw5k9ZPs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kDRVXC4t6VnValr9P6kiaNPKSML5RwCZUkIgHCnfOXldJmyph33UVJIvlSNf?=
 =?us-ascii?Q?e6Mav5ydI+wZOpLWnbo5zgbeLemEQ3KnE/GrlTMDxbXHdOzp4u6RD1Ae9BbL?=
 =?us-ascii?Q?/sVKAJSVoepq2Q0LLGJiQZip6gW8UoZyc/E/e7S3a6waqpJuV8ccrUAGNx5r?=
 =?us-ascii?Q?OibBUrukedOzviFmwqAUiybVlJpJg0Xi23QblxSZ+UpWRhb8CPA1Y1Opde8Z?=
 =?us-ascii?Q?waCQgZ9J6VEeiWo0u8z4KQcKPTA/k7XGhruyTO4DsgJTJmJd6R+RBORBSkLc?=
 =?us-ascii?Q?yIFnuQ9en4PdgTbLY2/8ox+9+1UCDHIbnz9MisJzsofTRBEDGd/65MJw6ujX?=
 =?us-ascii?Q?74WCGYlJvCTyzgPcZGBEXSlPE0T/0AK/6kGw94ES7X6lHD6lmoABy8OOPo/7?=
 =?us-ascii?Q?St9z/CQ0jxW0MsWli0D70J+9vE422m9aLyul2gsAWMZfKB7fav4nOi7+kU5z?=
 =?us-ascii?Q?HCnWCFIPBlDK5pMLaIMTFI99FLOokWTRZfLHhrjPe8ojpaSBEWcrDb5A+afC?=
 =?us-ascii?Q?wmc0llXi0sqz3v0Hz3PWsy0k5+CAakWk963BHM6PGvhFlhQNuDplLBVMBaR6?=
 =?us-ascii?Q?PGfV6sjv3XyNfCjQhz32smcHUO1qntC95ewvQ9xNJz091WBospRNa5dQ0qom?=
 =?us-ascii?Q?qj3nm9S5gNmu3ePRPU5/yddL5h+32Ldb8OtIuM/1OR+B8V+NQDP11sccxgxN?=
 =?us-ascii?Q?7pZh0agwjiqecHYKcGffAmyO6t0dCvUyqKCcDxuY/Xh9BL1nPMLhwwfCTH7Z?=
 =?us-ascii?Q?/nAAaf4xWtUA/T356tDEsWVcdsm/rZBZ9IQ7iTkfd+U3NtLVvPewQuDJhJkZ?=
 =?us-ascii?Q?3ILdxviXnyLiwXtKAp3mW8iU7PLzHx7cEv/VPA9DHRxlzyxj/uTbuxYoS8OK?=
 =?us-ascii?Q?qsuUG7juocXYJ2ilZMTfVIKt4q3DoN646FLk/lbdhFcAZNCM+Nk5pyHltWIj?=
 =?us-ascii?Q?JkhJbfP0j7H2l9Ehrqe/7LMvyy1oHt+BZ+CRdLDZZFBZXpWsQ32BysbaWMYq?=
 =?us-ascii?Q?7pqeCSYbVWC62n/aPiFx+xfYnQDTQeRGoGx2qfMdvLOvwbGRH5EruuWKY2MT?=
 =?us-ascii?Q?auDNnIAPajKEAZcd95XrJTaLjvlH9A7b+bgfEwvLmJB1t0C++xEWouuZob6M?=
 =?us-ascii?Q?zS5h7v7Ar5IttaMli8G5XaCc9H87YARgkwhY/hgzsn3QmWY5lLt15KC/Horo?=
 =?us-ascii?Q?mjnVvEOX6aXXZdu1tjWrkSqU/aE3kAJssyXSAPapC22uggNjNqRMEs3NnZwJ?=
 =?us-ascii?Q?qR+FDTJjJGRoAKH1tEif+qOwpeWv6A1JhLeNjVi/AhpUjg/SxyIvkUi5PRQz?=
 =?us-ascii?Q?VeOSLUySrmXu9NWPm2RRg7alVHKlNw8+yprIZkrGDQoycSX504SZYbJVP5eq?=
 =?us-ascii?Q?Ba7FNAtKuScuiXBbHYu2jCCAfg6H8wAWaDFG4DAlawRCmZp1E3Lqygc2Nxpi?=
 =?us-ascii?Q?BfRGYD3wRfBomc+td/A3ufiYdEOf2GG5eaScTWA/dKrOe79LjMlyDkWCf05D?=
 =?us-ascii?Q?Izlve2uR3MV4wL7a7vxDYoIz5xMOFA4AVk0QetIsEYqU41H0GdM7EpK2LiVx?=
 =?us-ascii?Q?oA/p62oXcgOaE7P1qbxUcETZY5TdiiX3Sl2/D1B9u9D7gYRw9+yJKjVfD4X+?=
 =?us-ascii?Q?wA0o4Iiw8QHfvbIejpMmkHDFczS5CdkHX/h0pSn6RrET+2wBi2WfqKb45N1F?=
 =?us-ascii?Q?DOJi6gdkI4LzAhG6S2+WIrosD8QeUrrTnENb8Ge46jeFtLjgHOhCLXvYSCLS?=
 =?us-ascii?Q?4ILektuAsw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7960e2ca-e5a1-412f-72dd-08df08738e79
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:54:11.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evjxZlzw7f1vddkHeDDcwF1g3qiIpuyqcZ10l4lJTpPmjCcM09QvdPim4XdMWRNqeeRVWaetio+c7mtxgW37SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

If a test is killed, for example due to timeout, fput can be delayed,
allowing the subsequent test to be started while the failing test still
holds the device open count elevated.  This results in a cascade of
failures as each subsequent test fails on open, blocked by the single
user requirement at the group or device cdev file.

We can make the test framework more robust, and allow better
identification of specific failing scenarios, by waiting-out transient
-EBUSY failures on group open and cdev bind.

The 20s retry window is heuristically determined in testing on a system
where scheduling can be significantly delayed due to SMI handling of
platform errors generated from the mix-and-match test.

The SR-IOV uAPI and IOMMUFD setup tests retain their non-retry bind
paths as these are not expected to encounter process kills due to
underlying platform error handling variability.

Assisted-by: Qwen3.8-27B
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/lib/vfio_pci_device.c      | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4063a0e2b3df..8a3139b7c6dd 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -282,18 +282,34 @@ void vfio_pci_device_reset(struct vfio_pci_device *device)
 	VFIO_ASSERT_EQ(r, 0, "ioctl(device->fd, VFIO_DEVICE_RESET) failed\n");
 }
 
+/*
+ * A prior test's delayed fput can briefly leave the open count elevated, so
+ * group open and cdev bind can see a transient -EBUSY.  Retry to wait out the
+ * fput scheduling latency.
+ */
+#define VFIO_DEVICE_BUSY_RETRIES	200
+#define VFIO_DEVICE_BUSY_INTERVAL_US	100000
+
 void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
 {
 	struct vfio_group_status group_status = {
 		.argsz = sizeof(group_status),
 	};
 	char group_path[32];
+	int retries = VFIO_DEVICE_BUSY_RETRIES;
 	int group;
 
 	group = sysfs_iommu_group_get(bdf);
 	snprintf_assert(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
-	device->group_fd = open(group_path, O_RDWR);
+	for (;;) {
+		device->group_fd = open(group_path, O_RDWR);
+		if (device->group_fd >= 0 || errno != EBUSY || retries-- <= 0)
+			break;
+
+		usleep(VFIO_DEVICE_BUSY_INTERVAL_US);
+	}
+
 	VFIO_ASSERT_GE(device->group_fd, 0, "open(%s) failed\n", group_path);
 
 	ioctl_assert(device->group_fd, VFIO_GROUP_GET_STATUS, &group_status);
@@ -432,7 +448,16 @@ int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
 static void vfio_device_bind_iommufd(int device_fd, int iommufd,
 				     const char *vf_token)
 {
-	int ret = __vfio_device_bind_iommufd(device_fd, iommufd, vf_token);
+	int retries = VFIO_DEVICE_BUSY_RETRIES;
+	int ret;
+
+	for (;;) {
+		ret = __vfio_device_bind_iommufd(device_fd, iommufd, vf_token);
+		if (ret != -EBUSY || retries-- <= 0)
+			break;
+
+		usleep(VFIO_DEVICE_BUSY_INTERVAL_US);
+	}
 
 	VFIO_ASSERT_EQ(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
 }
-- 
2.53.0

