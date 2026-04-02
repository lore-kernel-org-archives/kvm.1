Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B1F39098C;
	Thu,  2 Apr 2026 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161608; cv=fail; b=cVPYxYpKvr68xNqPnzH0Y8YBrburDGNUFp3MtCbUxwpW47cnj1PU4ulC3t6qIw5dorLvcv9vpATBHhUwS18qnImFnxfmBObZrZ1b120jKn9e8grp66tLiA9ykI4O9ILsIn6GTFKzyTsFmYo8FrcOuc1kMU7BqByqQ5LtJQO+Odg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161608; c=relaxed/simple;
	bh=ZXl5X/K2XVT2Q9tItJOBE0mnRHwYyXuIN7KzTz2pW5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZ92yGRvVsPOob0kC3rKrGfw2WhTTxZedmgUFHWdqm/eGaX6hs220ZLWLEYsXgIpbK1P0xvY+mMF275mHuENNk6dFrFmy8VvL2JZAaMlUrmpUKbjZ6lvSTLEJ2SbjpexktwGivD8Hz2fq2i3/HbfB2HkLXWqXu7LabFTnQyqSCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Id+emxnS; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Id+emxnS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPG3VBgF3mAzXSw3057P/qimeIkK2VkhWRwArXkP/iUdjSkJT9BM5/Zc78/uj6g2SFJEjTSywV60vFmEYk2EJZHy1PB2MSNmC740MVBzxErvjtTI7zXbwxMxAvYHcnQR9+xgsSKf6FQ+XxX/qgik9ZjBZsvgS5QO6J8+KDPChrZq1KDB7juw3Y/56Lg1CQ4gOpaWMYrf1Ndw9GyuohnNrpKDdhW10+krxVgm4npxnDeWx3E0VTFaVaOky4SMfuHSwIelJQqrEVASybOJ6lnFHAyBWezhIOP34gJloshRC4Z78GH2xUoJbaD8twpeg0i3b/vxzQMKRsMxhzDb4WQS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPQypGpBaNLlMfV6fhqHDHq9GmWnnkegmBb8IVscIDc=;
 b=zMNkIq1n8dG9L/v3WQrYuRc84B16ElEizN9+Hb9puUsM2w0V0XciDAJhr7I61QaetsEy66h3hP2QQxGDx0aD6JOWutqzht7tPUCixUXsfI43JZX03Jsn/oqecPof1wocakeWuQ/sKoVTZdG0nl9/l8BLkcF7u1W1J2jyK2RcigX/peYsCagygDM6i0FLQZOSw6KHlXza/tyGdb9t0zr0fRvb8G7Ee2YQn+2MkiDhxBooQ6cSTgzo5iCbrMeRNz86X1t779lM1M9Q3tYUdEFoLs4DZ8CHy4m+EVPTKrgdnDnzNPCSH9sw41lRAiO7xI21y8SYmZz500/RjmaOH/Btdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPQypGpBaNLlMfV6fhqHDHq9GmWnnkegmBb8IVscIDc=;
 b=Id+emxnSFgxbJ/JzCbiWNMWcpbDYrUNQ7f2HgUeaZh0Y5iP/J+10KT3ZE6HNq4tXsiuABo3kjj1kgCClFSjuYS0tPFPM4YkKgr6M+bzf5ZXHhTSIpyEPJXqVo8fP6X2fcZs9tRAXBL5VMvqg7Bb7W1BYXyc5FhEvZf/GGSl//Dg=
Received: from SJ0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:33b::16)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 20:26:36 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::fd) by SJ0PR05CA0011.outlook.office365.com
 (2603:10b6:a03:33b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Thu,
 2 Apr 2026 20:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 20:26:36 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 15:26:34 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<stable@kernel.org>
Subject: [PATCH v3 2/6] cpu/bugs: Allow spectre_v2=ibrs on x86 vendors other than Intel
Date: Thu, 2 Apr 2026 15:25:54 -0500
Message-ID: <20260402202558.195005-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402202558.195005-1-kim.phillips@amd.com>
References: <20260402202558.195005-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: f5891943-ef79-4633-0736-08de90f62388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cVbTiaMMaX4nSUeYLtASyve7NUzhxxcV6vpj4/9JNsXkVXtIy/2hIQQJQIpULebez768AmPH3XyC8+0tlNjvnYjotdBCLMdBnyWOfYANOskp1lu5Ff9vD/cBBQfLt5lUG+wTWtPoW65JhK6LSJO+4KbOROAOGNqzQjffhpql6lGFY2bxcRIUCV1dMHPCUhLX/QNv9Bfd0sBWD7g7tLGvr+WSJTAEsMRoSuEJz+Q+aSGZjTJ8DuOW9bw6uSAT6voUw6Bu6kJAfcHw5MBQHR5pwNGM4hRAsM9nyuMLiL1mNvvll0+jKNdnzEFXlMn+OE+9MPUvbUXs775YZvmQqQPE/uYqjGj5JJDLtNBm+vh0m+yjlN1T9Je6nX2rBTdPk9imLeylWThlHvjDc1NIh+JpkZHC4lEvE3pODoq2K0fIMYi2GMAwkHTfQsIAKQXrYNf7GmYUii+ek1J2lB5De43SzNbmYWjG8pdWz1nlsRBgecNqIME2OQ7ePRxQ+7wrr0G6MuIM0U5M0FKz6csixCwWsW3pq5EjYdvh6yE21dixGjSqHI4aDc9AUIgw60XMXr7Va1osMEci1pZWnLqJNPrN1sJLhdsaV+PCy+W1aYy8Epgcffhj+j3DE5TApdWDGBzI2peOWihUXJwNi48XVL0HT5N/8vfwjiUSo8/MVQ7CjPcIDXkKACaOyzOP85UP94SEK78ZabNqc/scShS6LIfNQxIbc3ZCRBbGoteziE9N7Of0PYR2eS03NtDn8QEUe12pc/owoyq8YGhT9qoYrNqxsCvDwLeGvqsXNr1+dzTOTh4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rvaa6ulZcECK+gOSSu0nEb0H4mjOawGQB/1UXl6+ae2/7Pvge1IuGw9gFWZtoxisvUiLJWIn8AG/iPhD5cuRChH34l/Hs2l52trWaUhFjE8y1S/iVhBHSMjK5Z3PREm9c0qfLpvOAdhlZn0r/Xp9zC58BMU3AiblgoCJOONPIbzzWSXm5sK6XPdw/hytQP25EAX5hZplmIWddKANLfqR99FVgXnyDIEHs/yzzYnxI3PyIkF2mS52EexnhPIPBt6hbN9SWlsizwGwgo+vDWs56Z+EsXCIh7XCtHBTWEnXEv90T33R+yTZHxfuLSc6/Qb9nYP3L9cCmdwtMzHQIy9F8gS/27JrUcQd0uztQvP2dHV9/WTYRukn55cSutNaSL+HxUx2jJwC755GmV9aVAjHeoEne3CpZz2kLRnzzNxilTvNVjXs56PmG3tLbSq98oGL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:26:36.4586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5891943-ef79-4633-0736-08de90f62388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

This is to prepare to allow legacy IBRS toggling on AMD systems,
where the BTB Isolation SEV-SNP feature can use it to optimize the
quick VM exit to re-entry path.

There is no reason this wasn't allowed in the first place, therefore
adding the cc: stable and Fixes: tags.

Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v3: No changes
v2: No changes
    https://lore.kernel.org/kvm/20260311130611.2201214-3-kim.phillips@amd.com/
v1: https://lore.kernel.org/kvm/20260224180157.725159-3-kim.phillips@amd.com/

 arch/x86/kernel/cpu/bugs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dfefbde10646..eed5a72a870c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2153,11 +2153,6 @@ static void __init spectre_v2_select_mitigation(void)
 		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		pr_err("IBRS selected but not Intel CPU. Switching to AUTO select\n");
-		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
-	}
-
 	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
 		pr_err("IBRS selected but CPU doesn't have IBRS. Switching to AUTO select\n");
 		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
@@ -2250,7 +2245,8 @@ static void __init spectre_v2_apply_mitigation(void)
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
 	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
-		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
+		if (boot_cpu_has(X86_FEATURE_AUTOIBRS) &&
+		    spectre_v2_enabled != SPECTRE_V2_IBRS) {
 			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
 		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
-- 
2.43.0

