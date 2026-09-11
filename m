Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA043A8384;
	Fri, 11 Sep 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146293; cv=fail; b=MW4mi49FMQBBxeMauNLC2gusR1pN1irfw49Tm2FYvsQcLL+Sb9o6YYkMlo3JxH+kTN4OThpo1zFV59pr8px/8CuD5q1QeuArycPxBp+9eLPy/xOZua0l1yvV41DO9MfG4GsfBtC+XnI2PNWCdypqlW1hyRbe3RZ6j6IvtyfZEb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146293; c=relaxed/simple;
	bh=hQ5j4HxCSpOnb4hynrIOTlk4ifBtW0XBWCRK99T+zaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F91+8DE3bHB8ihy0EYxapf7Dy+oTWsMbyJgw3b6OQDrA3yLlaJmUNhHsvuBBFCIYri1dMxyv2OB1q0XX/pNBLnGnhsIWOKMevkVdb3vDmYh6NQV9uTJUgxf6JPzQxeFD62+9LTplkl8eFH2orPDL27ocwL3erIXYqFfc5xp/dTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QrQ57Unc; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QrQ57Unc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TboffqbYv4QQK2/KDWLry7v/fQuSOpQqbbdxmdE/C39nZilFWBuppj8bwLxEM6WOzgo5aN+3EQsKUwPiKCBkfnc6nlFQrtjZ0Ocy7mFoHyuiv5WwjYacz130OR3QaFmgv8yJBritMeuoYYGuvHD6GuZcJ8x7dsGy5IuqziSlG+RtUOl+gPVSREJlBWG/nyxSdkzy9mjxL4wKlKov9NfaMZptUoLwKx1K4iDnS0tnQSbey+Puvd3lNmYiHDLGvpPhFEntQlfnIPe/ZKBTsv24UGwfOIaK2wvjBey7+/8SqFJMmUF44a0KEg0gMjcxlCL9PeK2B9JzfTgsz17DzURTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKnloLd2iA0rVp3xdsFkHbbe8p6D9CXvh+k63Q6ysU0=;
 b=wRVwk6iSts6+gHcHPtNgY5VTBOz6nl9N2F4M5g2nhNtbumFF1FBAQQPkk3iYAwrDHod3hpEzPDuefH/HrBeX3kRaI6V8s3dfufmtnAk3pk0C37dlCis+Eh2aNsqjKlMFKdfEY5Sda6ur5yDAR0rcLm2NKUfK0Ts9f6RkSPHinjqcM+EJD1dyHhl/jMCsPbrQk/Xkf6dDQUFBsTAbdOwtIAjQIdCQUTl2fbizsvToSHvC9ASbdgxE7EbwQfX/e/m9BOKkzI6OGm9cOe7+k8gNbOnNYp/j2AkDmjGz+Pl2C0RdanYaZJ05LqyMSYNfBaLMd3OIWbFxTFSnh3Wh3KDwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKnloLd2iA0rVp3xdsFkHbbe8p6D9CXvh+k63Q6ysU0=;
 b=QrQ57UncGTaZR9+0w6kX5Pcx8qKxgvp3dCegJ2M/mzVotU1zASSr5qd9XQV8clB2+/FHO+TW7/rV6jtul00FV/6T+n6gyFniFztApoLWc8KjhRq+7VriPQaMdkP0Z3FOkRH7PSmtXKcjr1kdapOeTN6n40jNDGl/xXuNIwdwjarvz7QmPO/FGYTjpa05IMlynWPXYwzDgrKH2zRpkJWvI2DUEEk3j3iOiXBvSceStjuM6K2LgxlJec2IY+z+O3ElEtsPcRzAtvm26KDewHB6BzvSYh9GBCiLqRzDevNnAM+KZnyZxTVjpgeg5TJEoY6TZ+TeLMf4y8RjEgbreXIouQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:04:43 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:04:43 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH v2 2/4] vfio: selftests: Verify a failed second open preserves the vf_token
Date: Fri, 11 Sep 2026 11:04:25 -0600
Message-ID: <20260911170429.1642480-3-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 748daf69-c9f8-46d9-ffe1-08df1026c60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HsGvfE413w9IbJuT/fXF5A75st6FinO2sDMEAFHzWzsAVVrvIlpmixiMK3/Ww0L/qymNoKcLJPON8Hxpr9+7oa/UKBHeZLtM02Xq9LrViBeyRCFw0gZSt9RzaHaK5Lllsyu9setRW5sHdwM5dto3wLMD68r0kiFXMCVvtr/007Q++65yW+BuzfUtsp4xRlgFIBpQSVe7W4CInbDd0DP7YogQ0P4BDY8Cpe+phIuE+b8MUnDNfzcmSJP9YgJsQpjdIrAcIWV3BzVl1JrZcd1RT+/FcvKmXZVmwEn+2jgmW5ynBnRmyuv/tDWnFdNDNxwiJuUGX8duj4e7Te4BbnYxdnAIiTWoGdItRQtLMnlVTV9rWXNp7WbsATESiMruZU4h2E6zNs7fhf8OMGGv0F7w3RqvhQHoWHKahuh1zJJ8tCJvPNt7RRVOf4AoNAUiks1PuqTund6/4m5sOctOT9udJluqazufcixAUaAntw+XEtRoRh4I7NBkVoQINzWhZBMbLhp8Ag/nuBLvyJV6cBJ4JmHwZAnCe0LlVKCoBANKPLewZNitk6CoN4hheKaBkM1/p86t10II0YBb5VTnr5VeHx3TFaI3StZCgh2LMpfFk04+SCKc5+WnSJGmFeFjh/vYy3tgDN1MX9dikosXvfoFf4U/RAGzhZxQC90ElycbICc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ot9dxieR0/gXts3TqVN6DX8ipUqOZ61OmSx9+A5r6VdEWYiPzcOftVdFHFFT?=
 =?us-ascii?Q?IiwbzY8Qs0RkeXAdd8lFbxkhU5u4jIsAvzK8iHu+2TZWEPCrh5MfcldpZt6z?=
 =?us-ascii?Q?j/2TAhSTf5aV5q1T7ZAg+0ru+AZm97hxvVxHebX2kad4SyCtiLHXFah2wdRP?=
 =?us-ascii?Q?5HX8VNK2PQo7gGFVIVRQWJ4fJlv8KHeaLZB2y7LYZGLCelPQKsvkklBB5djv?=
 =?us-ascii?Q?vcIZMaftQ+r4LhFqMtOaonO440SSsmNCJHqU5IuSBE3wk7OOI08gRVUN7Hx2?=
 =?us-ascii?Q?NRyluHH9cKiPVxO15xyd6c9uxqRRxega1xHOtPBI/283lkZ2KtOA6i0zAYOJ?=
 =?us-ascii?Q?AgQnO98wwtWB/1INu3YKYUIaIs8IYWo7Lk6ILPKCv6/tYjYAeTCub7YrZdS2?=
 =?us-ascii?Q?+RUlsqQdrcPE5xXr2FIn0Wtz2eR2RMGvPfUdxK4g+bK6Du9NRiKRzjx8QDq9?=
 =?us-ascii?Q?s2KeyuHUdtdN/wvJynGZXQ9yHX71dGq4ay0E8dx6gYcE5FX625nkWR876nQx?=
 =?us-ascii?Q?US1P95jhM0X1qBfWjKpQ77UUsPXcXcks8Z11zroWjnIGtDpABD/dT3Bqm03t?=
 =?us-ascii?Q?ozVeLl2HA7cQgZjTYJCvd5X8RDhbNfj71gzicPCfS2ZQoBVTYwUF3FBvkr2p?=
 =?us-ascii?Q?Shk8XiKDTGP2psUJtJj8lq9Deu8Od795IBLM+OQSPN8e/1J/m87SJ5+QrJph?=
 =?us-ascii?Q?MBh2XDHTdB9ZH9c4RD0u/x/DIEqp8INJQErugur1OqB7jsSlkADroz0t4atv?=
 =?us-ascii?Q?X9A+FZ0fRVhxWGfawd3cRDYgcwbZ+TvFo/hjva768AZgkb84H6ds4SCPRUEx?=
 =?us-ascii?Q?27f2CstjxIQRzLYiw1Fs0ybqOPOae2asjhqLxhx7fl06rm+/NpidhdJxsGwE?=
 =?us-ascii?Q?XrVOXQdN8ZzyN4/ApSyrVH5Hd9Mc4PNMPj7BIsSPPFOCDEHDZ73YJxso6OT7?=
 =?us-ascii?Q?0yLTA2wb2YuaDFlzblgNzOB8MwvE3eUQiC5ZHTQkgqTCyJQb5DVXJsSwFvB6?=
 =?us-ascii?Q?JNKZlVTTdYoz6xzzuz91S76k0HqGpDef8b4KgI1ZV1DUIRiwI4frQHrrhjhW?=
 =?us-ascii?Q?E4LP3mh2Wg83sofRBUGRv/wPZh2iM7QB5FyEXOi4PQ1QVL7ttXbC4rkEMe37?=
 =?us-ascii?Q?uKo3mkwhGHeOfV804+b4MGqiWUQw8SebwfQVm78/VonctWtJcPP8UefVlE5J?=
 =?us-ascii?Q?adWMTi22XexxW1KMseQ6U8umTTHDvZU9reGH79xQxum7ULe0SfQmr7XslZNL?=
 =?us-ascii?Q?plIw5Dqd6sjDJ730SRVR6tNvSTpf3FzImJ4xTH80rXbRmE51c29ybjGzCT8X?=
 =?us-ascii?Q?YWv+fzc/Jn/Ci+cn7IZgT/+ylUTKRQLD4dvhcVn8SRD0Rt7wWsiDFUCiZ6UV?=
 =?us-ascii?Q?g1qTTfiblzUAkPNU+Xm6ef3FKNk0ova5SF6hodtmlXTy1taObd2LWns7vgtL?=
 =?us-ascii?Q?MPD9zELfQeuCg3CeM9m5ahPkqLX1z3DcxN1nHxV+3Iyqf7ou9Q1z7GJ6eyeb?=
 =?us-ascii?Q?99S95Wv7cp+JYioqCuZu/JoogMWvVTjE0PLfLVIUgKAyYHtOfla/JTcmo4nP?=
 =?us-ascii?Q?Gpsdch/HWSEaqSWsBgT76bK41ed/QGzsti8BHDPOs6FZZKBmOsWRcu7TeCHw?=
 =?us-ascii?Q?QA/wkkKICJpB4XqXIOuqBxp/fULmr4k1LnwwNlAJNXBLChFjjOA+ifpX2DEk?=
 =?us-ascii?Q?XlOwo/7w7C0YpSJZ0jaahmunRi69dfo3TqqaZk0cc1Fc8usInk5r6YiLjVej?=
 =?us-ascii?Q?eg15hLMGoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748daf69-c9f8-46d9-ffe1-08df1026c60c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:04:42.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/Y2H1CEPiOMYXAPfU8ahTCEDBGWPevlNNI6evzdl0aD7WpMxiNrOcVrUvVjt78itYh9hGUGe5B4avQlQC6mIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343

The cdev path enforces a single open per device and rejects a second
bind of an already open device.  That rejection must happen before the
bind can mutate state shared across opens, notably the PF vf_token, so
that a bind which cannot complete leaves the current opener's state
untouched.

Add a regression test that binds a PF with one token, attempts a
second bind of the same PF with a different token, then initializes a
VF with the original token.  The VF init succeeds only if the second
bind left the PF vf_token intact; a regression that clobbered it to
the second token would make the VF init fail.

Additionally add a second separate test that enforces the -EBUSY
errno on second open so that the vf_token clobber and errno testing
are independent.

These hazards are specific to the cdev/iommufd single-open path, so
the tests run only in iommufd mode.

Suggested-by: David Matlack <dmatlack@google.com>
Assisted-by: LLM
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
index 19d657d00b75..b57e4498443f 100644
--- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
@@ -157,6 +157,63 @@ TEST_F(vfio_pci_sriov_uapi_test, override_token)
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
+	 * token (UUID_2).  Return value intentionally unenforced.
+	 */
+	device_init(pf_bdf, iommu, UUID_2, &pf_second_fd);
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
+TEST(failed_second_open_returns_ebusy)
+{
+	struct vfio_pci_device *pf = NULL, *pf_second_fd = NULL;
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
+	 * token (UUID_2). This must fail with EBUSY because it's a second open.
+	 * Previously failed with EINVAL.
+	 */
+	ret = device_init(pf_bdf, iommu, UUID_2, &pf_second_fd);
+	ASSERT_EQ(ret, -EBUSY);
+
+	device_cleanup(pf_second_fd);
+	device_cleanup(pf);
+	iommu_cleanup(iommu);
+}
+
 static void vf_teardown(void)
 {
 	/*
-- 
2.53.0

