Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48C2F4A16
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122451; cv=fail; b=JOXYvWYcyie5E6a4WsKbRAyK59flWUYErJMSY0q4O/RO4dGuDWNw8ue6Jy5cW9PWhI8Z2plystOVxsVBqmuBJanPlQpLU1nz3rBANreWRdLQMk1w53AJu0+TyPZUI563DPBXZDJ6ci0oovj4sISiefBjn+nqt00s1mvdSJ5gP40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122451; c=relaxed/simple;
	bh=ZKvRgzMvvsrcE4xIXUOZhthTUTlbPk6UtvrxdPCzm80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U15sCIC75MrFNIDGILrSCbDs3zPBvw12V3r9qNrJZzt8I7knnC9hy3QeTYhViouYQcNTNQAxBwrq/P0pC4hV11WaQO1r+BPjTFXTrUIaNuzgblk2d6kzGHyQztZcgsvmoW3U7vdNAJdTa/ZMyJFV8zzdQWEyQCa20+lSWIR7grY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wrz7Bm3G; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wrz7Bm3G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVvjDRbZWNZbughHt6ubI6A8j+vLx634DCL7as5WWD9HQhuFc/AmE/RW0cTkuHBsSH6nqaGjWU4hPcNJVR3rsJ1ruaDDjT0aToMgm17Y80MnB1ZGDXQDgsnMquOCfzMtVfdJ3QSNgE789k+mgG8uAiHKcWJNa7AgoqOHm3FBdqbSIiHCh1GM6MmxaKbG3WVPYIriEwOYoLfUxiqFlB/8k6m8WaHYxwAiUrCFIn+vSh3Ka3ZCYhX7QvlObTs/pknK8j3Ip9WFHHdwSUzryKBLptq6KJhkZPWxSdHILdGIvHMuRpu/vLgLANh83/dJBXFx+ZZRbZtbjVvrcL8xATHJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GszhwqBqzvbws5TqLpV2t6GxEC2UNXR+dTpYwizd6Qc=;
 b=HdDqhXdf4mwT/h1KCG7XRZSVpEeBgxqqJ2h8DBsAoSaCeZ66qrqLqtyioL3DDmQNgvyiU/4lLwIMZYKF5J4zGEgjn4DcHJ3OOriOQXazHiQCEfVQ1z/VjgC2rMf/8l+iByJTER4787NAwCrkv7ygoZF2aabm2C5zgY3ZAAJLIif90/asqJ6//Kr+jGEPR0x/2gKS0ELX0NKW/eYLG3Vsvh2DpF0eIFyPc7vL+6xp5lr742vqXy3EqhzmZ16Ds67W0ZBYBTmBc9sSMEsP3TXYlpjiJegRI0T/u89hk5ciK6fz5M1XQn2D3gr716nUnDhWBPJ6y+1ZVc2LnxQCK7HpjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GszhwqBqzvbws5TqLpV2t6GxEC2UNXR+dTpYwizd6Qc=;
 b=Wrz7Bm3GoQtEtFXCaGCtlgoJD8mzk1kQZPlx6+ok2E4LCmBO4WIWSpvr8VX3gUdsEQYGNr6nPIhKBbe90wQB5nqorjlPCnGJGc8xXDaZMY43I4skhs/j9nqEAzLAVXzXsypwTyqOiTAVw7NVn4+JG8xbEakMTRpMbFuy+8kPkM4=
Received: from MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:00:42 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::98) by MN2PR01CA0060.outlook.office365.com
 (2603:10b6:208:23f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Tue,
 10 Mar 2026 06:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:42 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:40 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 7/9] perf/x86/amd: Enable VPMU passthrough capability for IBS PMU
Date: Tue, 10 Mar 2026 06:00:19 +0000
Message-ID: <20260310060022.15120-8-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: ada91cff-b22c-4dd5-afc0-08de7e6a5ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	8xTF/PZsI97+TCtjVnpJmYTXsQ9dvQx+2NlyryumdwvyJZEzBLdf3kysgCpz0p/Xus77gpcyLBzmrDlCjoMUjTTqFrTeBKxg1W9dc19960TWOjsCYzg2Jc8wMXWA8Oy4tuivego3wRWF5JR0/6mvLuQc1suh+yGpaRjRYsm/+WeTgrWDTB/kLBuyzVAEpVBzDue735+2+dSvSctFQKipUEhDZ2h/8KL44RK0ZNTLOsWdevE4md7TfpmNuz+iea1qFZLx2G9g34Otn8wlPxELnadqh85302HtGVpWei8eAuEFGq6YCJ90iJcxcqob8A1JTf+gnkWUvX+6lSJg9+eZWBrY7iGKsnoFAqcXbgF+YWXjyGgONGlU+RQ2Ox35lsztwkosCKWl11QCBnf2Sm8Nl63jAsn0Dnzn3tDCNOrqlGIjRE/nbarm4BT21fRVAIT8+panBdLz5yfFD6MzCALJskdU8HXjI/bUIkS4Amsxvrvpq1jsrnP0TVeQG7IJPWqVeq4XHwrEiOR3e8Tx7jdOCVbm/dmI3/ia664dz2nU9RPlv4eumA5lRkA4X0Mu0ynibCGG5Q5YAqLJjFdS46f1O8/cHB3fOaPR8ZsK9dbfflubHYPMHCRk0IYBgy3QIioCMovxZXdU0Z76E74ngrjVHa//XiVdzdxdhwUATsK+jxefugUMd+VjPIwLqy5V5hSE954pbWMmlYiGoRAm05vJtbjcO9/r8qq8ue57OM6O7dhuLmykyKeDc/CmfXw7207XcQEOAOj7SBSnP52X41RnNw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+/FOMUP7KAOSY0HwBm5GLuae74t9Men2htYfpW71iKhzMOqwt1ejkgIPrt7nPkikZmUUbvPonwfm21cUIlTHxYRkG46Rs9hst36G0CijpEmDHImUcGy/drEpyMaBKwaYT/VNGild9FwBhXccG5Wgn7ZEk/K0o2sm+uaOw1XI/72A7kDGszg/6d2CNMtQzaCpr/BZ31uCa9g/E2FeN0WI3WFoL11SZHTXskTq2ijs9FWEc9kWglG4vNfNlWeH3rRNCamZPqKgopt0iNO9hCaNcgOl9by/i7/5OP1BaV+b8ocLVUPiPGEzl57VuMtUUv0RI2ibr8/tp5UtSMecc5dEIB2thCpZoZhVv8LZhboR7y3+bISYayjusfQQIdHo5rE/quneJ61tgXkHY6g9NWAFpf5kEDzI5VlXvoneAiKqmkkP38wfbeipRiUifWvWng1F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:42.3123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada91cff-b22c-4dd5-afc0-08de7e6a5ce8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

IBS MSRs are classified as Swap Type C, which requires the hypervisor
to save and restore its own IBS state before VMENTRY and after VMEXIT.

To support this, set the ibs_op and ibs_fetch PMUs with the
PERF_PMU_CAP_MEDIATED_VPMU capability. This ensures that these PMUs are
exclusively owned by the guest while it is running, allowing the
hypervisor to manage IBS state transitions correctly.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/events/amd/ibs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 09b56bab510a..034a992bbfe3 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -971,6 +971,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
 		.check_period	= perf_ibs_check_period,
+		.capabilities	= PERF_PMU_CAP_MEDIATED_VPMU,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.msr2			= MSR_AMD64_IBSFETCHCTL2,
@@ -997,6 +998,7 @@ static struct perf_ibs perf_ibs_op = {
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
 		.check_period	= perf_ibs_check_period,
+		.capabilities	= PERF_PMU_CAP_MEDIATED_VPMU,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.msr2			= MSR_AMD64_IBSOPCTL2,
-- 
2.43.0

