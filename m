Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E803B27E8;
	Fri, 25 Sep 2026 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369505; cv=fail; b=UA6MF6uULAS82Rw52yWd/M0HrqVuvbFO+GbHLSkokD+7/0beV+YUQVo9iIBfEm1m7HyuTpvPX+0RIoDzLPIxyhi+paXPdbLEn8UQ1Co4dpRZsy0UYA3FYMt9lky8zB1INeAaBQghhjf2s3AqFXBP2leeN4jE/u16I+G+MDOGCC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369505; c=relaxed/simple;
	bh=Cq8yt8s/tTprMYtxWe399admSt/QaPAS/Ey7rajEkcY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T0MZGuhK7WCyYC1c/GmAhySrq1EvoNhaV9AQJg2OTigWX31V78oVuVvOCapkYYCtrxk/w86YqBJ/NaVtxbj9evUCCzwoSKXKTi+Iw3uoHrzvIj95JFHNDs4mbv6C26ssUsTxjCWOe2CI5mKVpjXrAn8+bqit/C/MRszERaYePjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nqHNu22c; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nqHNu22c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG7IFANSz5GCHvI+YqTfbOSPhlIloOAym3Xc9dZahvFKx/ycgmWt5nEB0Y6T1krf9haD/K5j5m5Aholi+trqnTqBSbVfywHBiryGQM1s+Opz6G/2jg64vajqR1UaUQ1tO+efhSwlNsDFr78EC/pFsB3yI30m5l58bAmHglcuNPlFlyiPaobKX/vwWnvd5ebQwb127k1dJAGX+nndIZxbyIc1du5yndEnh1tfwfFKC6ivs1Ztn0frpiTXdVf1Qitmxs4/eDlIybwBtD+G6ymNNdOvF+y8j/Z9yT7wzRc9FXNbXVJNTTNY7Qy80JKX7fWPf7DbAL0KxJOF5XRXINlZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvsCrAu5ayMDUpGwaP/lU1BHN2vk059qtfdL4sWdx4Q=;
 b=k7kUN2QTbBAuJLUSItbocKbY9/ORhUxPjDhx+9+zhujmhNA8WlPeCCCe9BZX1gyvBmf1LkBOoy1Ah9oZlWTA5KSZqqcsMW1sNZ1OVZiH7M6Vh8I/7Gycb/sEKU519PxuF5ASWktbZOInmeZH7c84ikbPsGbgnct+nvxu98hdTmRaXUP5pvI7Arr08zpPy1x/Tj/hmV2xGaJ/H9jjkZ60vov+4/mfYFagTmkcusqCJID9JRke+DWHNX+lQtJMTpD763pDvKWZDd7E7P5upkCcFwvTy7/UT3iVZ1bYvxy0WPr0fe/+pNp4jLxFXvNXKlrOC/o6RyuuPeWyjbJeFeKyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvsCrAu5ayMDUpGwaP/lU1BHN2vk059qtfdL4sWdx4Q=;
 b=nqHNu22cc6ELeLWPDo9qQqrRdXvtsSOnIoiX+8OiITxaTUjN7bca2uRiA/EtWShYsdHHBVkJN0qErJ46uyFYDTgkCVFk0QST+9AkT+iQtoaqEw7AgLrbFTtxIh/UlArH5wtLqELLMsM/oVq2gZGjzHWGl7nGD5ABwbdsk7+R3t2CiPRqq7f/7OeahjoK7Rd9R644mHaRvxKJaOp0DnmdKlcIA20zw0UnLRK90go+uf14hUK7rSoX2WwDfcnkEsW7neqRfns+Vvkh9vDhg3pQP+vTRzjmzQ1/8OgWfjcLDPmV0Qvnylgg8SGHP8ZuajvGVC026hvnqUixPeKSl2BGUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 20:51:39 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 20:51:39 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH v3] vfio: selftests: Verify a failed second open preserves the vf_token
Date: Fri, 25 Sep 2026 14:51:32 -0600
Message-ID: <20260925205134.3505611-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA1P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::16) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdc3731-99bf-41c1-0975-08df1b46cbf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|3023799007|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4MjsvYDK6blRafV7ZukChUkzjWHQrUlsicqQKMR7Ojaqetya6A0yaULBjDmeXkh2BO091AD5UlhDIO3oaSJpdWktVnQgdttFSKCdG/R7fp6ND3r7QIWjkobupSs2be6BOl1VATN1z+WD48i08OoXb95KMW6/DMKowF9rKdUuwAej2lUUYo8aOAiCBVhuL2o1sLAp9psNEzT5ANHQ+QhxAw16b/GrE9bqLYzxKJFYF45jkkUv0ojCuUpBFkIngeBPEWOUh/IIyBc6Tzf18mdLro4gmMk67Y7+y2zkTs0gp/uA4W2cpqfyILqK2lVe1T5DztqpXWYZY+rBgbpvD9ItfxLsaYrhFpaXCA5wDaIzkplMRLGDW42wSVpYUXQYXBcLus09EU+26PKPTJojlpkXRMxTtjA7IqPM9X9wy4/TbWU5DMcbnMVNhyFbR0XFHvYULXp24wCUHMudCV8g3wMXtc9B5mCCcfI5TxydpPo/6dFkvMvld2MKtIm+cOHZ7Lj0ge7MpuQaLtgwiLOCWQXMuH0LJjOSmsxXU7EnygErpYB0WP6DiQ/cYmbJuQ0JgB9KhuTZ9bISlY5a3hHJzTeqtVpPigtkF5k0leRjIGAgk2W4ui3gvumdu3GiahxY9NATa8K8bU1osllbyPV5lc0Gb90eAG0hmHkoENMhOWuvksI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(3023799007)(11063799006)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XQqFAMLplUQS3jdAtmDzSfRPgiSy8i81uT1cFAhNlBb06OLO/QADnAbdMBFE?=
 =?us-ascii?Q?AL+VDalCheZeiYhEpBH9ca/wTxyGRgYxi8u0NEXBfzkQXZ8iW454JcmLs1QI?=
 =?us-ascii?Q?xnYgDT5QuofmspyqQ07ulFnq9fbFPkvF+rl5BGkBmxYqHNodkIzZ2PsDuIMH?=
 =?us-ascii?Q?ruPOGh+zvQFmDzbf0YEoMnpEY0ah4bTSrYBxJRu6DlnhTs4sg52mjFPvSLNv?=
 =?us-ascii?Q?+Mz6lnetNWc1G+l27gx4YcpWfiat51sZmatxIvaTsjX4dFolJNgK9TKnotqj?=
 =?us-ascii?Q?IVTpo1z57ZiATAp5EjKpWhwihyzib46RlSD2KbFhA87LcLx0fOKWdki7L0xk?=
 =?us-ascii?Q?S47VX08U3W51zArkTGJSYL/aaERmbjdfBSNT22BMHs6jM2UmV96trpZzKXre?=
 =?us-ascii?Q?A3ai23jes7OJZP643PPcVWZ3GAsHqivmTEqwNhxcUnryiL4rw5ZMYUKRh2xY?=
 =?us-ascii?Q?tje5xueXT8kukgpOVEwxV8asAyyAgEEGC5gge1/k1TLiraMF1jF7AJSjViuP?=
 =?us-ascii?Q?iQCJ2ynt2YPN4ucR87+RQkHssoSBtkLdBewpE4Z6I3Q2oWmX9sK8fMnS88NS?=
 =?us-ascii?Q?Y7svMNyPjb4hNLJDmJQOHY6Ok1jcYWzR7F8aJLMnFQXMLgi/HZIsjuZno+FA?=
 =?us-ascii?Q?2zQL/srDt8wMuJ4WIacHcFfRvNvqYvaV0wfKan84QIbcNU0e+2v6M7LG5o7x?=
 =?us-ascii?Q?KRjmkP7jfv0mBbwlOOUo2x4LKC7fYnd5kJDKJwqSZgwAOnWgfCBF/qp1glzp?=
 =?us-ascii?Q?9wyTaa6cQ4yZH4onqsaJfYjO6/Y+OaiUtMSVoumgTFzIXn8zP0Lj/jtWapDZ?=
 =?us-ascii?Q?ELggxt++6YZDMDueHtdwRkIS+JcZZzlfi3XT2o2UaDlEdvTewQd+5/MMWes6?=
 =?us-ascii?Q?qMeqeGI56fd6NiPVE/RghVXzKzNRRwD02qIqsniderTSdiJDAtyj72z01M3B?=
 =?us-ascii?Q?Y5GrIOv80PyhXfsGWzaJ+rMlYM/l2V/UKTGXFs+mAQG+V/0OBwwgQov9qK1V?=
 =?us-ascii?Q?3hmIjeGs8AOCcmfUWKbgILKYLYhHPxx0CPK1hFetcqkOHh44+qTOq0rYrywH?=
 =?us-ascii?Q?XGxHtMgCmg+6p9i6NWjB8XOd3dlx9m3qgZHs69YW71k1HPoEkOlMBjgitdEN?=
 =?us-ascii?Q?Ysi8MxdXcCsurFaWzyGcUwlyy26ZsnbjA8hKSkIN5pXxCQBNoBsMqUS1A9tp?=
 =?us-ascii?Q?73TUcgc9wbReaN1XTnTZ2jdJLVSIrOUGEroZZNWwXU0k/KNZgKFyg9m4Qf7V?=
 =?us-ascii?Q?f7+LVQJN4CCfHDOHjxTkN+6BT0BAo3u2WIOTJGVdxNm5Due2FGxGW23+KHPT?=
 =?us-ascii?Q?bO28rCyOcXuTqFYiFt1dZVt3KtNd3NVejE2J4379FFAoR6kMOKf8G7impic3?=
 =?us-ascii?Q?p2j8qXDh8pEhUDF1R+SfkzATiR8V+MHYcuItjkiKMsKX7Stk03klV/kdPg6v?=
 =?us-ascii?Q?B53li4rwPmPTDohpuOCCW5u7xGvAtoOhkVjjv56krmdZduSU4s1jhHwc+Xg4?=
 =?us-ascii?Q?zzRRb+1tqwVPaUWVcdanitdVb7lwvBWbI/WWReQJyPOhGv5eaPHlQpzfo1hz?=
 =?us-ascii?Q?diuaiRX4rXOPLfhaOshmdBgkcekqJzjAq5gYlBmDvTpo21GTVvMnWWH7hyei?=
 =?us-ascii?Q?tQROhGsmPFMPQlyPK6of1EwzMSJ7mI3ljh3X/NMY1O0bxVcgcmDGTvnhm00P?=
 =?us-ascii?Q?EcO77cUO3dwwDcoi3OdgK328VXhn1uowVkeXKelatRkwHejMiF/9DBMPPoF9?=
 =?us-ascii?Q?gnWQbMgqqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdc3731-99bf-41c1-0975-08df1b46cbf6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:51:39.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jyNp9kSRtH6K8RPdZsoa6C2NP59dlJI0J3avgkDKtK2i8pK38MbOwLZiGfV388pdGmOCQQSnE8Lm8QSGWgIYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820

The cdev path enforces a single open per device and rejects a second
bind of an already open device.  That rejection must happen before the
bind can mutate state shared across opens, notably the PF vf_token, so
that a bind which cannot complete leaves the current opener's state
untouched.  Before the fix in commit 258ba46543ab ("vfio: Reject a
second cdev open before mutating shared device state"), the second bind
mutated the vf_token and only then failed with -EINVAL.  It is now
rejected early with -EBUSY.

Add a regression test that binds a PF with one token, attempts a second
bind of the same PF with a different token, then initializes a VF with
the original token.  The VF init succeeds only if the rejected second
bind left the PF vf_token intact; a regression that clobbered it to the
second token would make the VF init fail.  The -EBUSY errno is checked
with EXPECT_EQ() so the clobber assertion still runs if the rejection
returns a different error.

This hazard is specific to the cdev/iommufd single-open path, so the
test runs only in iommufd mode.

Suggested-by: David Matlack <dmatlack@google.com>
Assisted-by: LLM
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---

v3 following v2 from [1], incorporating David's suggestions to combine
the tests using EXPECT_EQ() rather than ASSERT_EQ() so that we still
test both aspects without duplicating code.  -EINVAL reference moved to
commit log.  Remaining patches from [1] applied to vfio next branch.

[1] https://lore.kernel.org/all/20260911170429.1642480-3-alex.williamson@nvidia.com/

 .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
index 19d657d00b75..87f42aae340c 100644
--- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
@@ -157,6 +157,41 @@ TEST_F(vfio_pci_sriov_uapi_test, override_token)
 	ASSERT_COND_VF_CREATION(ret);
 }
 
+TEST(failed_second_open_does_not_clobber_token)
+{
+	struct vfio_pci_device *pf = NULL, *pf_second_fd = NULL, *vf = NULL;
+	struct iommu *iommu;
+	int ret;
+
+	iommu = iommu_init("iommufd");
+
+	/* Create and bind PF using UUID_1 */
+	ret = device_init(pf_bdf, iommu, UUID_1, &pf);
+	ASSERT_EQ(ret, 0);
+
+	/*
+	 * Attempt to open the same PF again and bind it with a *different*
+	 * token (UUID_2).  This must fail with -EBUSY because the cdev path
+	 * only supports a single open per device.  Enforce it with EXPECT_EQ()
+	 * so the clobber assertion below still runs if the errno differs.
+	 */
+	ret = device_init(pf_bdf, iommu, UUID_2, &pf_second_fd);
+	EXPECT_EQ(ret, -EBUSY);
+
+	/*
+	 * Attempt to initialize a VF using the original PF token (UUID_1).
+	 * If the failed open above clobbered the PF's token (i.e. updated it to
+	 * UUID_2), this VF initialization will fail.
+	 */
+	ret = device_init(vf_bdf, iommu, UUID_1, &vf);
+	ASSERT_EQ(ret, 0);
+
+	device_cleanup(vf);
+	device_cleanup(pf_second_fd);
+	device_cleanup(pf);
+	iommu_cleanup(iommu);
+}
+
 static void vf_teardown(void)
 {
 	/*

base-commit: bc78c90728cd74d1c7335fef786fa51968bdebad
-- 
2.53.0

