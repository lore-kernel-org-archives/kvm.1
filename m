Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031DC3D333C
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122453; cv=fail; b=BDFlmdPmFdSlproBiVq778NbfX/+eW055gsdCEz0Y15Fq2fyXBkj0VIBLee3TIUsC4r4bNfbpm97olLd+ayOe72vPvdjNBD61WDy1TWbcbFbR537StINnGfNnvbM9m43Pwb8tvTiDAoe/T+bKO0Q6ffk/KlhAlb+fpgYjeteXKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122453; c=relaxed/simple;
	bh=9B45lbHGPGj+fcGb3qhDfn3aMcdCjmFOWiX15VDTs/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mU4iQ1wOiTlho4UNP0OgjteYBPO3yepEFsh2KAPBkAx6Q5ZyghFp6MThqqRbmESGFLhWlDz6wNtbmc/wy9xmozQ6sWObx7YnzIVJC3bsBU1uQqJBc4FmXrZDpo2dHpjgbiCIq0SLpLsaUjtBcR9pc1nswlKSBqG11H2DEHEQhtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r7Qv/73c; arc=fail smtp.client-ip=52.101.46.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r7Qv/73c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzRwnnJ+SJCMrh3c3hgZ4o8UVzBSLt6jDQdMeGuqUYNzXt/hhc4Y4c8skdVbZ7yEmEY3DJwUZIa8HeXpguFet3JbmYaVdkkdWD3KyTTc9XnS5RGJITw+npdENXKIqe9L9VhNHGJs0S6kacAV5+RMSsQkpeSh29PkvQIc284Cj7aix44j73W41oJsKZaEVR+FzHXl8d2QRlOuvQ/Bikiy4WrpAPWhQIvc8RYF0jQeoY+y/K2NhzN3HGnrqdxU3pRE89Q1W7fB6lflON6l/+Bb/dS1oGcP52clHAiJJ/M8RJHLsg/gkBDwbl7FedLmkDdSV8iaFrbOhK4+RsDL7NsBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJlLYUkLE3wY42Jek9/42l0dQTvrvwX3ScwoGSRvKkY=;
 b=hf79LSuvHT5CGXsSk/0NOTjNwYz7zXD41D/p/Q/p0Mmzj373PMY/To8TC/M2VtBb2XgNLZBz6iA3oGzjlSIBbojmKsAv9HfWwlqnQ240GsaImk3LGAAB8OgznZHmmIWyrAr5d5G2AfRL4VApgn+V4dRe44xZVNwBQZka7OXOyussf0FW5vxHrRRLAH/tYwNHTS8FA3Esn7Fv+0zkWqfJ49/yTu3R+zi8IJTp6FK2D4KNxvGkma8dsMizIi4uP+b8UZ3Fy9uHdGPKAJkwZHpapd0OwpkFuKWqwY7SbvGqbM0yL6sAGsn4lkIsG50Gpjg95XazzgcG9XHgehsVeqxkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJlLYUkLE3wY42Jek9/42l0dQTvrvwX3ScwoGSRvKkY=;
 b=r7Qv/73ctbBNxx8Tdv88q5+owsYpIhe5cs6n1Et1pvGZ8KGlbl3I1LiYErSfE2i5q9ii7hCO4+CrjZlsE1/P9JBdg/FLCiT26ez7K4SXTalh8PsrLBRcvFGnFgGsjWQqGlPswj/VLKg85PlpysWZ3XEFt+1DvcmnhHDz8fuGAP8=
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:00:42 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:23e:cafe::37) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:42 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:41 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 8/9] perf/x86/amd: Remove exclude_guest check from perf_ibs_init()
Date: Tue, 10 Mar 2026 06:00:20 +0000
Message-ID: <20260310060022.15120-9-manali.shukla@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310060022.15120-1-manali.shukla@amd.com>
References: <20260310060022.15120-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a123d9-bab7-4de3-8d16-08de7e6a5d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	q0lNKsQPlktrnBR7n+Z3EpOftj0oUUKzJP/NeYg25fh/5w7C0KnUXRDHXbK0zx9c9hMsUd3txqluxkzg13mJ5Cp5wYI4dwwBIYxIb8WS0hY350hdFFhoo1cWEYBSSxVKCFeq8eGJ5/TE6UOgu/yGWBKGwb7ZDdxhVEM9gICOpKJXuOpT97c8nOfj3/OoBiXmg+WxmtYjUXE+N4ojTdVqXhFOY47HZeGKLWKZbZopSZVhShgn+KcY89Fy3FYkc9NH6pBzvqGXVamtovlUEBEAvJmFSLf7n69u8HBv1mNS4Ff3BMVYueRPSkx1DaoBNrEpv9WPzD90YBcjHuDgshYg1h7TWjunsFnPoD76BqvcSnwMVL9dKr9+XZ/srXSuEOIaZwbKOavptO9QkkytUwaZM2s9x7GaoQ6t4U1BLFfx80quWKBCBJ+iygLLzaWb1CWCfFZIr9W0eeYUj1eaOqm5DGsJCJluNPklO0M1KzFNDFsVZx4bU+NK1hiigORxIyWLd4iSqQKFslJLoe7DApyhmyvI+iRZVTtxFFcI2ckaPsQ6GjUH7BUjU3988OqF3fvMXC84QXvfyYZOREOH4R2vgrb2wZnvUMJQ/FqrBR1MxwdjfS3SrE0C/2YksdBiN/Bkh8e/C3H9DwlL7LYzf+dKli6J6vbgfT0i/3yP9PYazCsYDhCwB92ad2RknvYRjt/jedHZ/BUQtqwQBbsBL5nDJZz3FRN6czYGV+0q37cB2TsujI4LLiWGKirmDpuklhH/UFTSmtW1jldtX+jWwx8ePA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aL8dapEtkDpkJry/SaTSsL79coP2AiAuH+E3fVyyylNwtOGpxvfF65aEM+xF+b3YvYcJ4U9eEirW1KW3DAh7huRunYY1KVd1e3MXjDwm0xlIrRPhBAKOnKU8bo1iDIyESVO0kEkoGgqUhoSx1Bhze7Y81N0eccHHr9iazeK/Ruao40uN7xM0uPiKouh/NgSZP58u4hNgrnU6SCHx0Hp3lm6PLSTWGMJ5C/pHiy3ZaqDUueI4/LB6l9nlec07LQ9EFO9qIzJFxsNLTRI14imrlP3ScUi8FhfR8Amvjf0/vmnfiD+amZdZ6tDK58wjKqHKehoOweFhX5HyCbE4D8cNxQPFZn7b+8336dBN5K5w1p4oz8GJEUkLt++tWzY5hpsv+QsrggIqYBqyJN8gxHo7bTXZKj61FtRJsoSQPy61SEnCKuuaVr61SdTaw+dCu17P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:42.7599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a123d9-bab7-4de3-8d16-08de7e6a5d2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463

Currently IBS driver doesn't allow the creation of IBS event with
exclude_guest set. As a result, amd_ibs_init() returns -EINVAL if
IBS event is created with exclude_guest set.

With the introduction of mediated PMU support, software-based handling
of exclude_guest is permitted for PMUs that have the
PERF_PMU_CAP_MEDIATED_VPMU capability.

Since ibs_op and ibs_fetch pmus has PERF_PMU_CAP_MEDIATED_VPMU
capability set, update perf_ibs_init() to remove exclude_guest check.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/events/amd/ibs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 034a992bbfe3..7da06c143b32 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -327,8 +327,7 @@ static int perf_ibs_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 
 	/* handle exclude_{user,kernel} in the IRQ handler */
-	if (event->attr.exclude_host || event->attr.exclude_guest ||
-	    event->attr.exclude_idle)
+	if (event->attr.exclude_host || event->attr.exclude_idle)
 		return -EINVAL;
 
 	ret = validate_group(event);
-- 
2.43.0

