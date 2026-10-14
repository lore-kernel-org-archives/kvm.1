Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5637A848
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956194; cv=fail; b=lzJ3MMExmz/QFoK8ci+k1NhfAMGgEOwBo9jpm8MEi5xw90dMjCdFZH0KLNzCxgwP2tWn3HE0kQD9AZKdmZApqHsxsfwaQIJo//ssZokU/6tVuyMeBxXfl39SZaOP2kB0E6qYKGmqMu5lwG779Hty/SR4smIdJNIw612ZRuxE3ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956194; c=relaxed/simple;
	bh=p4bVh+r1jdREMHpTa/LRELsDTcEOX4SLNYXyK37PF/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXCVQhThXYXU42QLbPMR7DfdlK8yHlJ0BmOOPuyvT3c/mRvN6gMRX+pWGP3WrDMhXCJEV6oGSdRl9mMeqgp8rhuadDvv5gKSn1lwOpd3vgrHBW6JLqaU/vDTmlzyKolqS+IyjHZlDG+1SVlbudW2RpS/v9G4ss35A8TVGiaeCow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AJExK5O0; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AJExK5O0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efCzTu8z1tuIESBT4S5LiwYc32p/8zkaBWMpwkv6D2JJBeezgZtX43GVk6xQDfssX3YqzPBJtI9C2ahT1KOkb2tyDBW4bhBGzW/aNwQHkMDIxsS++O7fVcDDOG77LwZqWPJpPz15X5yJf88EUKh62C1fiZBVFRrdpQCnzhRVG1+r7AYhBmCCNgRNYFbw+23Esz9MHOFg5VQQ23yi77JMwT4mCGVaerYKcpivBHxI6l1y+tuqEy0/w9j4OOFc2n9orhnGIlz17G7TGdbSE1MyNWmv7QAG1AtkqEsyx1TEP8h5UlOrvotw4B/47ZqLuYgIzZb9SAYsIOQMUhu1+To01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sORZiQXU9MJaCyBB2lkEvmgebkZOxQXDY+iN30mIftI=;
 b=kjWIqy1NB/HK5a33VgAyeCTL1sRPNT9OfsjiJlEeIzRH3z7FB48z/D+pttCGE5Wv8tkVT32kfBAvWD4d0loK1oTyrrNWtEd+omJvYExxt8aP+L6GkHNhzoKIvKGrzcr+USmAwyCQTgW/pIzR2sWURN1PkugCs7+62uR4srSwF0LIzhFVtmulUNWzNcHzWUM0lznfcP7SHPdRJVaQejAuR60XivImYMh6gBYFfkFEBwEOi57IdrPyVEK9BfNcpkMjvD6rfLEnJtIjVmGZjO28pFQ2YHLYnO39TcjaCJ+CCGTP899isvFL4ko6KxESIGErASvEg9Si+Gd/fOYWUyHp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bull.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sORZiQXU9MJaCyBB2lkEvmgebkZOxQXDY+iN30mIftI=;
 b=AJExK5O0ZwdXAzQ7P3YPZWKOglOBGPNUH+c+hjh87toG+ZQx7iUWAeJSEK3xIrplfrBN4Os73YIWZrnFYBN4k9mi1Gy2yXx+OIAmPu4BpIEfAe5GOiPCzdEq4n1+RUwanFTk1fJw0kXPSyrv2Mczy3cN7qC+JUao1nBwlDLz2ck=
Received: from SJ0PR05CA0099.namprd05.prod.outlook.com (2603:10b6:a03:334::14)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 05:36:25 +0000
Received: from MW2PEPF00014673.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::8) by SJ0PR05CA0099.outlook.office365.com
 (2603:10b6:a03:334::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 05:36:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW2PEPF00014673.mail.protection.outlook.com (10.167.249.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 05:36:23 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 00:36:13 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, Ani Sinha <anisinha@redhat.com>, "Igor
 Mammedov" <imammedo@redhat.com>, Jason Wang <jasowangio@gmail.com>, "Marcelo
 Tosatti" <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Sairaj Kodilkar
	<sarunkod@amd.com>, Yi Liu <yi.l.liu@intel.com>, <kvm@vger.kernel.org>,
	<qemu-devel@nongnu.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH 4/8] intel_iommu: Add support for get_x86_iommu callback
Date: Wed, 14 Oct 2026 11:04:29 +0530
Message-ID: <20261014053433.24564-5-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014053433.24564-1-sarunkod@amd.com>
References: <20261014053433.24564-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014673:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8a45cf-2f95-4a45-d324-08df29b515be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|10067099003|261009223027099003|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J7TPzkIhgECFrGnJ4xLxU+Rxl6l/uSDgs89mUTeC2dKsgaOxKxVh+cQuqqr0/DmqFnqBN2q5NEJyGhEWCTtdVaKOMXJHnfJqX5ix9/ifU9dymagrK6GoIf1AE4RJQtovfrzuaDOzPOgYxyrYqC4szC+6icL9utZR3ex/Tur2Y4bdUxCaaH66nfw/WTSIeXC9pOg+i+Oiztc3NzOLoNBDMFbD8I+L43+vHJk5V/fKgBI6M2nxttd24Y4jv1rXj1BLBFklcVZDMhlDaUnZ13z4SG66gHulQNB/IP6cR7bRdWJh25IaNmW8YUGnW/57kYgOWewvKQirrqM2bvT5dszIJa3KEn1o70j9AXJBZyDe6iY8emSFQT3HM9DcoFay8m+ZOI0MdrFYYJCdcFXmI3ERVye610u7VPNsy3Hsub7orTRTCHLREkTsPR+EWStZ1D5z/GshtEWj6M7ehJwQcEB3JOVg1wE3r/SJ52RvMOMDGUgS5GWrmUp5CjPp0pJ7EaoKgutwoaAsKofd83KUR2GiFdnZrTC2EZQuNFZYlXoErEULM7sK3G8bqDQQ0Bsl4aWWW8YWAGazObrKTn1dvtqwM2QDbfOXxrjnusrsBqdlz91y8rHvQ4DWQ8PV9jJdH38BrWh8IzKIk9VQYyoi4OuldiF9yqhC/wAkLciIxLtPC8OveYNEhSs4niU4As5iTl8bm438SgzJCUCfkVyPDtb24fo1DLeAeNw+F7g30QLk16Jiqa1N+iYrVu6/cthqFe94
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(10067099003)(261009223027099003)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t3T550m9NGwpW/5BMPT4ovh9LdftDxCwdd/g5PhA8/J1tC64SmB4JfZFWaY5aTAqiOMkNKSxG7kthSEsM7iOZFVdm4jraqdsjM82kwmQk40LPBDde4oo2HunohemX96Md9A7JMkPZiFOkPqpsOJTOUY48nfc/s4EbTyvF5pEca2TpYOIg9SxG3V0kBUB3BdiQ+FH30zGgOOVxLVbF82sQpykGsL3iWNYA9V7cx4LSd0LBgpqgzkCEQYCl8GQleHaSV9Oqvv9U+QwojdPiPJk5+9PEVeL3LxpIlmMdls2nLqpQMAYPAPGE0KDVzqrkQSfz6Hvgm4FExBgOIjauXIxQc0aOGKzczmR7wqkfMNMsfO5ZeAZrn12RSmvIZgLdGKnAhc/V8q8ETbDuPO7/Ek69XvWLDw1aTbziW3ncnaN1tcPkqEyUl4C6s4G6TwuGKvj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 05:36:23.9780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8a45cf-2f95-4a45-d324-08df29b515be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014673.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

Return X86IOMMUState during get_x86_iommu callback.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/intel_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 82c3c3b2c35f..92a2d6eebb61 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5461,6 +5461,13 @@ static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
     return 0;
 }
 
+static int vtd_get_x86_iommu(void *opaque, void **x86_iommu)
+{
+    IntelIOMMUState *s = opaque;
+    *x86_iommu = X86_IOMMU_DEVICE(s);
+    return 0;
+}
+
 static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
                                     IOMMUNotifier *n, IOMMUNotify fn,
                                     void *user_opaque)
@@ -5535,6 +5542,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .pri_unregister_notifier = vtd_pri_unregister_notifier,
     .pri_request_page = vtd_pri_request_page,
     .get_viommu_flags = vtd_get_viommu_flags,
+    .get_x86_iommu = vtd_get_x86_iommu,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
2.34.1

