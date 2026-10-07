Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7643955C4
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380979; cv=fail; b=HrbyuTp31sPw8siotwNneBn4DiNTG0hTz4IORNOYBjR3K+StXYLUwENmuvXqkpKNz6KdeF1/5SWCmLftcBd7JLyaPCEOvNhJwtWPl42pbS/gfrxr5wXgE/2prNaHybooTsYpHsSMoAvsB1RnBK2t7qg+LBYZ385AzmplOD1s3dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380979; c=relaxed/simple;
	bh=+G5GCASfmRp5YfIPkbFC9CQU24z0wxWKXiobaOoljFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siQrWw/JLUgMz0G2DHeJfbXcB8XqxOJ3XUNZqRu7YA74gvihLFNyvP9meHOjPj50LXRoIyX+ihuw/VBm3Jx+1mUlrgtJdUIdqmPybfOS469oAnPlhRb6r54JvlQ5F5StIoVPx7vSTiLKNqMzphr6NXWHyZDP/F8HRQJKIzQ2WIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LCdwkqW9; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LCdwkqW9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQf+rFWsgje4Cz8F95cpQPcTZ4oUv8OFIJ6hVZOW12y3II53kIIfbdLaQ5KvMguwU3zm0NgCU5mzNiRW9PoQK0ITva5gL/v/mmnEHLmsakZ2R6wvf1xvWmtWgimK8aj4H0tS4sV6j6hjQrZ05eY8jK7ApLjCOp1THEFAaedrNHRDPQ+ahtu6eZWa1d4jThatppg53HiO5HvM9U/Bpfsrg3HZ0PznKp2y2Tia1w6tR43ttm0ztII3PPiizL5pJTLpUIuji6as4Nh6GJkvSkz64UEMzfnA2+1Dv3sJfmFYATojzvlJ/zjeYRj0SQ3OnB8OJv5oi3SYKPckvMGsuxCwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygDuSSojy1K4ySomDQUyfqpuUXXu3aweZpqYx5LQhj0=;
 b=C0yQHv6TG3Iv2WFnJwPWrhnL1PbFGRE2uLLMGxzmpx/caRcLQOW/tmN7ZsWnZFAZSX3LRC0jGnBlVFK2MhXcOQ5uYqqeXsUuztZAw6ZxxBN9AEKElghWN9yl+obnSoLwqCL3vWR/yrf1hRFKuqAvaRyjULRB1qnrnxVt5eSw1ddjMxGRvYMkYf1lignDw8NCNmLLvenPrR4ARAXkuuo4te0fhwzHa62Hb5CxZYdne+TXRQwMdgTnHRSZOmwOgYGAFRCSVK9hN0B+dB7CB+QxLWY1E+Gs8LsqJwcnUbVv3Js1pwVH1aUdN2V9DHc5aQ97hne7IKpZDc3ZlxfIUm2/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygDuSSojy1K4ySomDQUyfqpuUXXu3aweZpqYx5LQhj0=;
 b=LCdwkqW9fEO4DW/COgclspczowyt12qV+6mNGJDbPW/nXB33s/eYnrwgy+jEoFaSFtfAbCbnEpQYDkitYOlDj9EpxaBZK/3LW+d9Ni2RhjX+S9KG9aNM+uo/2am4c1LkE94Sx1SbLFgBwCOVfh8oKb4tkp9t/YccWh+N3g+MOMA=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:49:06 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::80) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 13:49:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:49:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:49:01 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 04/19] accel/kvm: Fix handling of conversion ranges with multiple MMIO holes
Date: Wed, 7 Oct 2026 08:41:28 -0500
Message-ID: <20261007134323.1606088-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6c45b9-6b30-40ff-f07d-08df2479c0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|7416014|36860700016|1800799024|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	rj223u1OmY5H1aHe+TCmCXMbT7GMTOWGyAkw+mCMMe0PU7FE6Q2HKezSsNwLkzBtgm8NQ07EF86l9HzPFJ8UbENGtN0wzvdlD30mytoNXoyv5AUoF9+TZr7B4NvA21HyVLkIP/IO+isbQmakjJL+Sd2k3ZL2gi3H392mIlHa5w4PKbUOJZgyI58RsEUFysvNjxDzByMEFKwHHU7OnTCsATko3ddjTiwbVbecusMpaGdxxhqxhCpIf+HfwNUzByLWl1qQbvUktL52AytbaWI4hKxQFMhiXSLYgSQe9gHj+9Q/em/b/KbR6xOK+VfQKzqoU9QTxHmllDPloIMwSteomXR/D8WZphqPE7yTAkSl+ZXriv4H/peE5VF7l40Jo/+elheguAaE+nuFN01KEEH0Yy0utTFmZWJ4yaZTfbmhB/6jLt/0ZOnzKEdfFF/RaH8O/wtbB22V3QS6txwXGgtU2jzmcENNKNaTJrx2OzFm52ZCUkIBkBGy/I3jKM76z6q897QTFY0tLhGbV0uxn1Vff3PF4Xnr9JNhEVgblCwEcQzBgZV5wcjbqdCoCxzMrv8AQTYloP9gAHy/5LZZxOEiH9g2LlxwTR5gacZIt+S1bGDgd4PaCPdd1O8W2IAuKatcFg+7i1G2XFM5KbTRKj0HZKf7GpxhcOhxO80tfZ1/2jJiIHpg9uSXRr8SSImn7pM+lw6dOErA/BgbhVeKH7cEWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(7416014)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LZw5wANkzJF2Qhm4ilx2vH4c82V1pUEjQ0bgqVJKyCWRuyDP4KK7f92u/FLtdfsI5fY8+qkIHiCN00gsn4ptT8QBupUv/bvfAxHLCcSDow5L+OJx3zw4ZA+tokVJbNkfdMFci5BMHEe0t1buBQ06MRuM0sLXVl9l/9HgJAHxYaQrUm8DI4IQ4UJI4WuXB35f7eIb8l5njtzV0icV2o4rJCh7n3X2FSh2EcvtjKb3T93SoI1hT/qgwVoEAzMmzvgZ7JqUEjRqPTS929qOn+lXPy7WITkizoqI7syz53MNw55f1UQVsz8LWsaGmxMmOSIVYyEhh2HyVkiOnwEQPWGBwnjFNXDPIvPbSheNoLoZIAeqHp5HbSWSC9D2zbK9tcwgcO2eCFYvpVhZ07dU42L6XLFWg+LeIGLVn7IRuRo2k0hqIlgkBQc/KUsDdxoc3dsB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:49:05.0867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6c45b9-6b30-40ff-f07d-08df2479c0a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399

The current handling will properly handle MMIO checks for holes anchored
at the beginning of the conversion range, but misses subsequent holes.
The current handle_memory_hole() helper already processes all MMIO
ranges up to and including the sections found at each iteration, so
handle this by simply calling handle_memory_hole() for each additional
section/sub-range.

Fixes: c5d9425ef4da ("kvm/tdx: Don't complain when converting vMMIO region to shared")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f0a79c9bda..2dfd14c257 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3493,7 +3493,12 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
         ret = handle_memory_hole(&section, to_private, start, &skip);
         if (ret || skip) {
             memory_region_unref(section.mr);
-            break;
+            if (ret) {
+                break;
+            }
+            size -= section_end - start;
+            start = section_end;
+            continue;
         }
 
         ret = kvm_convert_section(&section, to_private);
-- 
2.43.0

