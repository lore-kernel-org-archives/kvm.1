Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725503C8C55
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901100; cv=fail; b=JO/ySjcut4TC4EH+e3jel/jvU+EFaFMKVzsid+EWR1GPBF4CYk7NPIh9K6u3pO7jV0+cajOsyfunz3xh8Xytc+cH5Df7MgOsgy281hiGoYJoVQ/W4IjrSE5HjXc9HN/yBUYH5Tk/vRe5FHkcCCgsthPPTrVG81mVFYoXsi+naDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901100; c=relaxed/simple;
	bh=7F8RKr/XoFYXCkZUGWXnB9tYusIgyVFqvQjOMrOyMJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffbnfMBs34LvPwek6FsDu8PLZPSrrLlZ+XFXI22iTesSJWsDO0cNJp0Cot1HftxQ7oynWh8rnzp+7ToAiTbyp8San+JBQymtiIIAiGN31mPHaygvpAzdBbuQQOLSC2EOYpwo6U0b2QutZZxnCZAKSnb9uTftbR4/9aJxwer9EBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EmCzxKcD; arc=fail smtp.client-ip=52.101.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EmCzxKcD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+3fT7ZIbfmJHw0XiohiDQIbIwLSiMctni+5KIvuSCqva/TzhxyAOW0/BtxLMnRy2IZga7ql264BrOZADA15hNa6ZGYAPM7GSyKFrWfzZlh9eQNIygJtJAiOfjwSuktOzMdmtIax0pxfvOV56EMWo8eHVtEqgIRt1iiqwa9rAf3WhkQswZr05mBvj0/ycrkknAs6Gjdw78ACCAKLMmJiNoVWYgmCzlJAcXhnAEa1BRFCn2x0hxLF/Ocp7AqTNThfe8dLmOwXeEG2M9DcKpsWc+zAABXCXh+Xa+hW36WSXHaA4nXVC3ES3fT7O2m2j+UC7yfRRNs+7g5PPdxW8n4GLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0zci9YGgjE9ZRB2S79q5qIBRbEzNUQxmk15tVppqQI=;
 b=pbQZc88CEDvywZERu4cIUYNjxKCbSMeGspPNqWDNjqt5BKSm1ZDb0AiFPQZl4T5owBETBJzMFUSZN1G+v/Xy6QZrPsRQSMFnI+KmuQOLgFhEighd31cbqMi27KkWDNJjLzylillggjJpqhhVBN4i0kb6Vce8Gkz18V/OqSTzt3UbkbFHu402Y/PMJpSfFbGYoVTLwi2TxtFpSruuqBdaoCJ/0JHztl6NuhGVSq6fiitGF/cGnHO+XFx+kK5bgUZdcEEDLQHErwX9QXMiIYp9WuRGVgcSQty3chmbO/zr0D2/prh+WiIZ5ZDbRugAiRwC1Zy4KFEMZ5aRKfekzYGmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0zci9YGgjE9ZRB2S79q5qIBRbEzNUQxmk15tVppqQI=;
 b=EmCzxKcDlRt/CDBJU2NJJl0QxnCkFA6+/Hzu6OILb2aWUWfCA46CHn3UqDrbj0laZRFsI0e3h4kQ/PFwmaQXjIzuQmZvOpBgSNv1jthKeLhH5HdbvE8NwCMBo6f/Wq51Jp191G+L52kys96Qg3nKpIo3hgabE2RwoC+MYthggRE=
Received: from CH2PR18CA0035.namprd18.prod.outlook.com (2603:10b6:610:55::15)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 8 Sep
 2026 20:58:12 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::2a) by CH2PR18CA0035.outlook.office365.com
 (2603:10b6:610:55::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:58:10 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:58:09 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 03/19] accel/kvm: Fix handling of MMIO holes at start of conversion ranges
Date: Tue, 8 Sep 2026 15:48:23 -0500
Message-ID: <20260908205236.838281-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 219a66fe-9686-4b51-9d0f-08df0debe420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	2fSOe4FLXJViJCpSZmkBTXFUYpoNEV+jRC7m0n2RI21/mBlOijmRG9Ujy4xEo5o5e1/CtkLif8QfuS6veeiuCBCXjKjVrSg0nJK+/IUx9AJRAckjYSgxfcvu+d3z9bEWCd035VjDwRvaas0x6cb0m3wHEYvzs4+/WssGMvJgP6vrT2WnqO022M7Xf8DhLDbGNH3Qk+GLRc7Sj7oNW4r9C+1OEGqubgBuA3yhdpTZS/kfCnaMfISNfy8Co6KX4w8g0euZPP5Uqi2yydeiJ3HTcizE73BaGNsofE6GJLz7JiSwfNACIiij23bDZJCzP++dwEGq9hMh12m9EZLOofYWT1JsDPAwWKZTJp4sJKHhxEPlcqX+Zh9ynP6Ueh0o8BhR0EybAZeZnLdlv7Adly22Ao1F+559ZjvBXAz13l9BfAYNZ2e3F8MpeeYk1IJrAPngydmiEKXum8UNARvwjqo2EWW31s+LflgeKLXkD2rwYL6asA5OzDY9exCspfEZK3tABS8HfNrth0LcAWuRD6ciXX8JdzOvB9C9mFgUrMcOB2XU2z+z6i41feo0qcJxyGRbgHhTTXKfhtq4PlUZ57rhDblSN8gCGo2KjMjXBadoUzNcIPZBTJdMJuXAVy/jyRDzNt8B4ssZr2Pvi+y1FQprWSspCwfDnPLyOP7sy9J23R5QamIlNw8/d3Ym2P25LkuASsDjxf9P/AB2NmIGeYEYrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ixiSjny9SECOj/dKqp6WRvTddAokSOs8H3WmKLOxwDKVwsUQAHYNuaDTpLOHLBA6N2UDSXRB1b4r0MOTpxqb0vdmCpah9hU/UEwP12FVFGRw7MyWWL1m9RDD/GTg0Boh/NWQp+SIwUO2JxKJxwKNIUt+kYAJVjbyq6EJMr31tQzYCTyiVOwIy2kF3Iv+nHBIoGuY3EF8QdLQkXhqShrHd5ckihnxyZLKjzm75VTr7Vevt7ZwW8Ye5gFpOeYWQT+KIlHeUq9rrctZ3ijpuVCGPN6QsidXU0IUshk7euKJodjl1Ngbo3IF675Sn/gIBxyXhrzZ2WLX1PsvOMeAlg+pyb/OkOjPR2ZwOC1DlOmh6QtJ/L6VLn2siJJNF0JIYrywUO0cpeN+uwOOSkq26pvqF6ACQxR0+gYoNQAcTzIHrhcUArXn59c1yYrXBfPYDl6M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:58:10.4922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219a66fe-9686-4b51-9d0f-08df0debe420
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

Currently MMIO checks are done for ranges where memory_region_find()
finds no regions within the entire range, or for cases where
non-RAM/ROM regions at the beginning of the range.

However, if the first region in the range is a normal RAM/ROM region,
then the portion of the conversion range that overlaps the region is
processed normally, but any MMIO holes that might be present at the
beginning are ignored, so the checks are bypassed for those ranges.

Plumb the 'start' GPA that was used to query memory_region_find(), and
pass that into the MMIO-processing helper so that these gaps can be
detected and MMIO checks can be applied appropriately.

Fixes: c5d9425ef4da ("kvm/tdx: Don't complain when converting vMMIO region to shared")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 62565a544d..463bbdadd2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3344,9 +3344,14 @@ static void kvm_eat_signals(CPUState *cpu)
  * non-RAM/ROM region that should be skipped as MMIO. In the latter case, the
  * 'skip' parameter will be set. Returns < 0 if the conversion request is not
  * valid.
+ *
+ * 'start' corresponds to the starting range memory_region_find() was
+ * called for, and is used to determine if there are any MMIO holes preceding
+ * the region passed in so the appropriate checks can be made on those
+ * ranges.
  */
 static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
-                              bool *skip)
+                              hwaddr start, bool *skip)
 {
     MemoryRegion *mr = section->mr;
 
@@ -3391,6 +3396,15 @@ static int handle_memory_hole(MemoryRegionSection *section, bool to_private,
         }
     }
 
+    /*
+     * In this case the region should be processed as normal
+     * guest_memfd-backed RAM/ROM, but still need to check if there are
+     * preceding holes to apply the MMIO checks against.
+     */
+    if (start < section->offset_within_address_space && to_private) {
+        return -EINVAL;
+    }
+
     *skip = false;
     return 0;
 }
@@ -3475,7 +3489,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         assert(section_end > start);
         assert(section_end - start <= size);
 
-        ret = handle_memory_hole(&section, to_private, &skip);
+        ret = handle_memory_hole(&section, to_private, start, &skip);
         if (ret || skip) {
             memory_region_unref(section.mr);
             break;
-- 
2.43.0

