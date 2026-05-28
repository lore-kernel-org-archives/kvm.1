Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB32800
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926993; cv=fail; b=EJqANT2SfRdYTo2+RiHvybk+bUoNg91ao/tO0fY9oCG6CqDrHm+gXmdufR0L1PlNLVCy4ecP92aL8IDCDO5yEOzKoEI5cuGe9ipYJ64oVzOLZlePxn3u4Cch9S7UkK5ReRX3I91W2MYaIlfBT1taNDIaWsI/5XeRZIs8d1eEFuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926993; c=relaxed/simple;
	bh=D8QkIPWwj1Bxm7MZaGi6jecmJvqH9pgGPHcRBipaV2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKx/40C7PpKdMdP8NyUrKP8yY7G6oIb2fZ8PzIfiqTSLYCAniDioQozV6GOHH1A67GcUxof7Bh8YiEVCTrFHSAnVEpu82G/ZZS8yWQt/KTXAAuNKEO64Ol1it1nhLCiCDk+Q2coaiWBeQ1AjuwKShoLhzycfIMbH0hs7BzqRs2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IWsU4HO7; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IWsU4HO7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivJl7HZylL+k1CGlgTQLvjsgkob9mlkPYYwIyDoBPvxQPiuQQnk8Ku2p7F+MJvBgFFjFG3AAH9AAEXu0YaVP9SMXeBlfegC1CWcpg3Xx6mwMnlNwX1yxH5/UuswlVCvowrqp0eHYTkEl5x++Pv+JOIqIKZTmyYPjPt4SO06KdKBYgzs/+VO4883/zkLhUX0DW2jkMuWad1rUOABnStm/Jx+zWoow+sBZE3xd1dLNARI5z9WC377vdebSNxDRVAljvFH4XTxnm+0c9eDLkWppfCnE04nhu6RCLIyv8gjLUYpK2fj5um1iFja3dxXtrJJSj30vlWX7SS5lmkiOStPSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J68FecJVV8fCCDwnfwyI6YB+T5NYCyuPTmO4qh6UgAw=;
 b=fBYTq4sYtABEbPA6ROeDhiS246J5K5RavU0GyHlFrWfvqP1k29+CUKkVauJ3qrAEaj3PFb5zQyCgqziHFVEcewPV/+uu4PgKegjZ3jhAQHj4X+NYqonHVAnFB0JxqaNxeH5YPml4KfKTBg3LJ+zzSnxBEU25Badyc/8YbZACGeWYL4NEvnkvsEAqw+G8NUmvu/WA4APYG/VQWiuDO+C0eAFB42TS1Q2zUEFtoJ7tfuDGMVIvbm6vg27eVBFDvAalueJsjEmw0hB6eSNQAy9JfxYuGKvATGTFCUkW7/cJntsdWI5UiGY6tE9CWPeFwo5LMmTQo5lurj9o3/sgc0PA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J68FecJVV8fCCDwnfwyI6YB+T5NYCyuPTmO4qh6UgAw=;
 b=IWsU4HO7immpkqKmiS28GWunu8q8wmYEYmfu0Jo3D0XfrONP/GN+yFyzl01cLxPPBgQ91/BFs7uIucuxVaJlsIE3YgnDuYx8ZznKb8V/1oHWb34LLlfP28/27+T6DAEbjuE4h3jFAttQIv9cD6RqfpCI/ScSu/Fd+BDyDqBJWt4=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 00:09:45 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::9b) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 00:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:09:45 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:09:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 07/12] accel/kvm: Move post-conversion updates to a separate helper
Date: Wed, 27 May 2026 19:03:32 -0500
Message-ID: <20260528000416.8161-8-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b509a89-3a75-4416-262f-08debc4d6cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|7416014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YspS30bY3ck8gUe8fOIr/drFcYCBbm/8KSN3M0nmyd6xQhGIf4MLOdwD9D28IgkBIfgA2FZwET9g4PUixXC11PcGZpYG0Sc+QcfnSYQqnhwSiVN5uSyKRa0BNGZqj6LfEzIYgqMkD5XN4vBoSKmboT8CFjHKKEqOwz/WgMW4vyluAe08fAZJB2BjXMSpzpXxu0MWi2MLS6G8vHV01jehlqxIQ6ia3Lv08XkrL1qb6zlSL4DprRvzVTrBgBoK7mCJsNzBjNAXrC5VsH9lapOPT6K9M/aMoyXQDjWas3PqaVZNHxom+I2Ctitdh5EieaSAgfXEEw/iTcXm02IweGsZRyUvXmzUu4GBKKUOZxhNWJGX+IfFOWxOkN9gRAz96s2OLuD+btzGUR+gtwzhcTC2lth3ud+kL9eKBlfWKkMjE11982g9DQkNVZsxUpLk0wHAaCgDKTddmGU502wPx1Aswe9298BmUip4SXhCYv8Dt5kfRm2NJ00PUj5KHfR0SdppQpSK5aVb8P8fnf3jh1sFbwEESflI4BtaWITKLe2WffP3TWlvTIbtoRa0oBdzry5ye8WkUKF1lprAnGzLn0pQQmHO0JDT2XxTbljIGtA+VGmK6DlwGa00N4w+t/o9dLvbczsjd9Ao9GznmwgB5q+Eo3xTEPXt6so0LtHD3h/EY8pAmQ4HwVyp3r366lIB9SE3F6Oqc5S9Qgk8cyS513VbdhCslGLYABXhDz2UBNJS0ZU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(7416014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5yWWTmBDbeFfA+x1+K3BEXgIeAV6gxO9hNZ/UP/gnH1IqBF0wlMRMkbjSgBDQ8F/i7bmGYUEhReDN0ktwkJb6yrrZE8/M4DoCMdTp0YrWefV+5ICsh09YAHu5JWKh5vN87POkLuJ1X/0htxD8e0RgvUI/p7oZ/Dxg6mXDUGFQRs7EkYXkVmxo9R61gxpVULowXMi3J/sw/ZQa076L13HLsAA+X8zLL6J70QvJ83ZBlm23Kp2V4Etam3AGhB/speRQLiE7fcZzm2CPQv7R7wtZjm6HdftG/44QcCYfiIohb/PCSdIiCPOcBsV+59Lv8pJGlaX7Z34VjECLTtuDuVYu5n1iINt4usRkjZ7n87ytt4FoHg6vOuWK4+OTtUUMceugFQfp5tJSd8fELO0qBuqQaFr/Lzjlypoc0qPfC9m9wLI9sLW1T8Lq3o8LnYa2Cyi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:09:45.7390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b509a89-3a75-4416-262f-08debc4d6cdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004

Currently memory attribute conversions are followed up by other
bookkeeping tasks like discarding unused memory or issuing iommufd
notifications. Move these tasks to a separate post-conversions helper to
better compartmentalize and track these tasks, and in doing so lay the
groundwork for a pre-conversion helper which will be needed in the
future.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a1832712a4..0e6ff2de4b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3445,20 +3445,26 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
 {
     hwaddr start = section->offset_within_address_space;
     hwaddr size = int128_get64(section->size);
-    MemoryRegion *mr = section->mr;
-    ram_addr_t offset;
-    RAMBlock *rb;
-    void *addr;
-    int ret = -EINVAL;
+    int ret;
 
     if (to_private) {
         ret = kvm_set_memory_attributes_private(start, size);
     } else {
         ret = kvm_set_memory_attributes_shared(start, size);
     }
-    if (ret) {
-        return ret;
-    }
+
+    return ret;
+}
+
+static int kvm_post_convert_section(MemoryRegionSection *section, bool to_private)
+{
+    hwaddr start = section->offset_within_address_space;
+    hwaddr size = int128_get64(section->size);
+    MemoryRegion *mr = section->mr;
+    ram_addr_t offset;
+    RAMBlock *rb;
+    void *addr;
+    int ret;
 
     addr = memory_region_get_ram_ptr(mr) + section->offset_within_region;
     rb = qemu_ram_block_from_host(addr, false, &offset);
@@ -3485,7 +3491,7 @@ static int kvm_convert_section(MemoryRegionSection *section, bool to_private)
         ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
 
-    return ret;
+    return 0;
 }
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
@@ -3533,6 +3539,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         }
 
         ret = kvm_convert_section(&section, to_private);
+        if (ret) {
+            memory_region_unref(section.mr);
+            break;
+        }
+
+        ret = kvm_post_convert_section(&section, to_private);
         memory_region_unref(section.mr);
 
         if (ret) {
-- 
2.43.0

