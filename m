Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BE313E1D
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097274; cv=fail; b=S7ANoDlN9i19x72nnNxqxPC+un9DVnXorefIv15vCO5V+z+GcDhUYuqVnu4YD9zbyOfxrfgBfWOfQ2VQn6eBa1BvqG82bGI0wAZh7dj04216vqL8tCjxcdcwZCW5lfLK7VXWJPCgFh/VN2gL3PXPslCLVjncd4pv8uZdQTvpljs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097274; c=relaxed/simple;
	bh=QgZViA92WmxdSYDWhb971dHb2nt+T+Xt6hVx+nt4aXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f1xpXotq+sqZvnq1uCuPjFSQ+6N/GSfQBlQPwbjH9bQK2CWROO1ueTtMgUrQhXmO3nK8Dh0ScEeVc5JlGvxRp+08BcnR8UwMp5AspwhKckOJUDdK3ckCHLk+v1xed54PKXe8hQk4X0gwimEM1ug+YErBqK78B9Gyg+VwPZzcDhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s89X+VjE; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s89X+VjE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDqKqP62orUDV6zQSGPbVxuIfrRQw+5s+SmmrVsxJP0/d0Hfqw3VxqUsQf3UMapq0C84h8be/c+QpaxcfbWceVxSm3r+4nDlhzhDBaBDYhjxq8ONcr/oka++N42hZXLIpB0FJvo32UnwLsHXw/KfX2Qd4ANubXu9z9Rp80CgGMd8vv8JSNqBBTa1c5lp52clYTZH8lZfwqWb3kpP9t2p6CArjWoK4+W9yzLjOX3SaPkPr5qfpP6G2EhQpGbKbVruA7MvhiTjepEOF+/37YC36ma6mRZ92fCqw2RTYvdFIv7CJvx+/+ZwsjTyCRJsUuZgkwFLTnE6trnyNcXUsaO0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L31PK9xdwX4GdaiyZse4EhmYxKm5CCs9TG6S4JfHpw=;
 b=I0IYXTMM0kFV+tYrYERWOOTO4QeTQrYmpigNUEYVrdESagPYKEbXAI5dLb+Isp+ptPpdAEcrFC1j5cI6iHsnCsmQx0mQ9rCAMi+JJHi/OiVjUiz+NKqp50U59FElTNPgN3/0OVEM7DeDqza0HOkPr0ok+C3uoIBZDdlehkg4QKs7ylskBmzo6+HwKFstGJsVM3WElLcTYN/7GpYXKxLyYAJiCEDGmOsVW5J5ih8Rp1l37g2riD5NFecChjx/kRGuYH2Vp5lxRyuB3WasfME7ArKgqt3ugCFnXYh43crVTThrt6n4e6kC0G2wdFxZ9N8r9moz4XUjTuMtaqAHr40dMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L31PK9xdwX4GdaiyZse4EhmYxKm5CCs9TG6S4JfHpw=;
 b=s89X+VjE4LDVTmQ1PIMbYPJBJaudPoA5epSvB71tIUPxiQyA5AbrKl2kgXuXWO0p70egXwxLJ71AVUerOCJJesr2ia4bA/nGYGNnu3Vts1cE+9P43Any/1V1NUz47yTsd4fZ7/2qhp7ulRP/3lLcxMA61Fyg9Bm8x2GwHSHjWhE=
Received: from SJ0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:a03:39c::34)
 by CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 15 Jul
 2026 06:34:24 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::22) by SJ0PR03CA0359.outlook.office365.com
 (2603:10b6:a03:39c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 06:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 06:34:24 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 01:34:21 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Nikunj A .
 Dadhania" <nikunj@amd.com>, Manali Shukla <manali.shukla@amd.com>, "Sandipan
 Das" <sandipan.das@amd.com>
Subject: [kvm-unit-tests PATCH] x86/pmu: Check for PMIs irrespective of PMU version
Date: Wed, 15 Jul 2026 12:04:13 +0530
Message-ID: <b075ec13e95167da1f2229626713c91d291bb75b.1784097178.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5bc8d1-a26d-48f0-e848-08dee23b1caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zLxGRJF6xc60CDOyVfox+uRICc7ka/2J2j2iQnGxJ5/QqanC8k13jAdeKlrEbbA0NEo5hVmRThwBAgJnN6Cud1Dal6d+AlxfGPC/SM3mHVLhoL+ryB1laa/Lf0iGYIBaoE6MeQ/tVgO5op+OjYvz9uiXp5Krt8roTVvG2Cp+fEH2R70Od0yEzut/DOSwYiSZxcTXc88x9xFStrLYmfn4lYJ1LMILkocecbYgNu/bprv3KqAAiLyPjIiggIivqFzUIN92Sfhj/93GbkdqY/4dMvEguubHsNbq3Dwr2mZJ97/P+WwaC3X61oK5zZwr2xFnHBPZ0t4e7gUituBDTFsSpSSMG0N8bqZftQC0ZdL02Tsdr5mfFE+M3pQ6P6iaIWALVh5tskyhDutb5H1il2Z6LzSYoWKO9sCFEzfcgyJMtiyb6FjMi9ATAkftEkxir3NHGvcQH9OJkDM3yydE0aMvfOtVS+DXa1kr8pv9fgPjRS0IUOF94lsoBOEDH4oCiRl1BeXZIalsbSD8xS+PzU1DheSpyVIcXumQp+/XKzct5tVJ1NyDzD3XeieRjP0R1LDeVYPyjR5nEnqGMZvjS8PXsWRYP7gWOuMIIG9rdNEE/0wNBmRCvSpLCp+csmaIa2IokIWsyEhqNtkrY6bGQe62Zqcyf//nz9H7782lL3GxXv7+mqcMwiAQztBXJ/HhgxIvPC8L5tC6H9EiQUk8lZGJyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q3GNOpvGUzDb9x6v8TIt+1jAy30Qqc73tNyGuOJIce1gMcvMhV0PnbM1KGvohHFsZxPZ82hytssW37lhFQEuN6oLWJlQQcD/bl07Zi5r+ibUsw8I3Tto2w5ADoSeKH2DjVq6Ieutep/mNzt6XIMuZ5keYhRxbzB29Zxe3kT+9AnZ0qZOZ/Ti6yexCeBa3DE5IW3lzH1qzCbhjFhu7fQGMW0exlDerO/1JnvYhxkBGjLZxkXlfL2z9/ixIRo3WdvgbsJiknnxn1MnYgYm5SZThuV1re+c9ReJtrsfyFwrs9okudJahFMsTYZXnWEzCqSvdKgJfFKkVRnqusU/WyKlLuhetpylvhFVtDE3QRq8u5E2CB+p/P3mlrLHYQz6URoMUcx5GWS91XlY7oz5ir2pnENp2q6lxxBO+6aCPewYN0mXEfvw1bc8if5SV6uD1BCd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:34:24.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5bc8d1-a26d-48f0-e848-08dee23b1caa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629

PMIs are raised on counter overflow irrespective of whether the guest
PMU has a global status MSR (PMU version > 1). Hence, always test for
PMI arrival as part of the overflow tests.

Fixes: 62ba50365a98 ("x86/pmu: Add global helpers to cover Intel Arch PMU Version 1")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 x86/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index b262ea59..22728650 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -592,6 +592,8 @@ static void check_counter_overflow(void)
 		else
 			report(cnt.count == 0xffffffffffff || cnt.count < 7, "cntr-%d", i);
 
+		report(check_irq() == (i % 2), "irq-%d", i);
+
 		if (!this_cpu_has_perf_global_status())
 			continue;
 
@@ -600,7 +602,6 @@ static void check_counter_overflow(void)
 		wrmsr(pmu.msr_global_status_clr, status);
 		status = rdmsr(pmu.msr_global_status);
 		report(!(status & (1ull << idx)), "status clear-%d", i);
-		report(check_irq() == (i % 2), "irq-%d", i);
 	}
 
 	report_prefix_pop();
-- 
2.53.0

