Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCA3CF69E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122444; cv=fail; b=YpbfMZng7/93hCBREywZbR46ya0UyA/HekihGgOa11ktY3WPsYaLOF4FXH/wbq2HLALdv9bdk1OIlPImZjyQHnwmTd4Kmg90WVv177lHqH45gHfzQcZkaqEl63Er6Iuf/uOxBAB6QDNE0CN/W/hyZmWSO1EMEJ79dzj/2/TMbRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122444; c=relaxed/simple;
	bh=+IscRik++pn+miCUADxCxXGTRfR29P9jUf/yrUWiddI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foUKljRzefR1G0swBYZgpP8IKuNiDeQcD864Ecg86OOY06N/c0E5beaV54MidvPcimWxX6LAKeGe5YMJ5513KZ/qHCHeuGXNoStLiEJ2QBMZ0sreYdZncjIloxdY1lAK5meiYcfSfITEwmwft8p5qiPenvbPeZtoPm7bgMCyqNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m7+c83Gu; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m7+c83Gu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lju6iyNVfwhli5lZ/FaFzGc+qqhjcUTqDnUq4Y4LQmQHOP03s6nMty2Bl/8b/pMJLvxx40IdSUpHGaPhgL8i6U+zwglGTmWttg/FGqVpQnQCta1FtZLtHtnay3j/tYMOVeTHpmfCVQt3r3uki6wne0VD28vDUYviOfTXvLqDrN9EpW6zw4cmj+IkkarX/+PYHj74flttroh+ZcPyNQNeiybSjYAjwS2iQxE2XGvQ6B3azrJDqjQZ0knVb8zbrwtZ4Tm7KDCPgm9m8Ak4oGY49rf5VX8nFCTWMsIENpjGrZTJv4BJQl163m2J02Z/IPMW7Rmj7UOla1seidr1vksruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1QM/tRlMAAJS/AwKBV88jgjXIEeP4iZnTWX/9fDv+8=;
 b=rmi47xG5oOBzQAl+zdnXZGPyGlGgLF6YbOV8WvtAY6PTO8fXoFg3Bm0nFrQ0R7LIe7JqUeE+JOZuRnmwjeqwgvowXrbODqOLIKJyUlFyNw4nAOmroHePOWplote33rlJnWphlweZfYi5CFME4hugiKRWWlIzGoZU9BmXaO2pl+ooVkKf3543TSmd1hAmmlS4hBBpHn79yN/bC7jJvrpHb8WYcapqrVvAp2mU5pgbPwXSdIwCMrlQUXbiO4J0l9fw1FVg1WwDoX8Arw5JIhQolO0kBNxCindasZe0tCJl8WbjenctEY+1bEGWpvHpqySf39bNNIzyxxJffuBNzy1jIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1QM/tRlMAAJS/AwKBV88jgjXIEeP4iZnTWX/9fDv+8=;
 b=m7+c83GukTKKv3rZr8pNget8d/zW5ZxQKZVvNB8DhnbIw/S+dRkKPV/dLXz6oCQZR7AMblkAQqeQBBlLCm56zY9onB88cSSGw2SfNCP8rTdWPIwZK3RKC8D/oEzf3dCS8iEkVbDeiaPdUhjOQ5NwpKMxa22eiAXOARONI+Ltcgg=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Tue, 10 Mar
 2026 06:00:37 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::91) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 06:00:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 06:00:37 +0000
Received: from volcano-f23bhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 01:00:35 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <mingo@redhat.com>, <bp@alien8.de>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <santosh.shukla@amd.com>, <nikunj.dadhania@amd.com>,
	<Naveen.Rao@amd.com>, <dapeng1.mi@linux.intel.com>, <ravi.bangoria@amd.com>,
	<peterz@infradead.org>, <Sandipan.Das@amd.com>
Subject: [PATCH v3 2/9] x86/cpufeatures: Add CPUID feature bit for VIBS in SVM/SEV guests
Date: Tue, 10 Mar 2026 06:00:14 +0000
Message-ID: <20260310060022.15120-3-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5698ab-c73f-4f91-cbe9-08de7e6a59f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	kc187mjKSAWNtfKRREMOA4B8Gw1YefbBUE/P1v5bf3cNVBYZf/PfFnUqTiu0Wf7DvgyfMWnYMLg4KgrW5fcZjUk/sVO9YjEngOtXOSxX0wSDY/uHUp2tkk2GD95iD2CmTe5qaKHDc+l7X7HyDqb/pKCA0sZkclqjouGSkrj3DTk6tX68+TbOy5NgpNRCbFRCsx1yI/r1iREwCYYW5KL/i82Y6WmgqByCC7QX8q7OPO+wVWnsRga6mHHrzaoOe0tQqm81PWvYo+b5sUZk15K4p6wLeO6NfuKXM/Pw2i52ger8fqueeFH8zJHSqL3zJgWeKM4joN2OFNT8y1+SVPtC86t92vMZC9MlpuOfbu3qGF/bU+EHqEPiuI29dXeWwwVwc1zKIMhuASmJ1L5ZxtYL4XsOIhQTfkhzGUiH+17B5Vfzyxe7iDGoFVu093hB8qdoeTKmNjMktZtrIb/tOpZbO+ST2j8TvXtglEOmHZgDE0yjJRMCaij2jnk7yik5fogCMlirO3rZIUs3lCPnlGCjqkVF5KsQE+c228ORJhlwUGS28PJ9VwIjYoyImQtZK2ShJm/sHzBLE6GLX0zZcPFIEhI0tbTI3+2FqlMAVpniysNBaWrEe1ZCmmyyzbRXGSp+5tez3OgDdaDMCYr5mJkE8e8+e7Shd5DwLNGgHwi9ORKYIMz2tw9gzOF3lVMHvCI92Gb93H2RBJyxT5OA8jkvUmGiuzKQpG7zNtohQbE5k5wHE8vgN49FAlAz5P6P+R62S75mnzvhMkT4juNZU3Pkng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Rm/8QGjY8cRiHSrqPavYMdygyZP1El41sPHfQqmR4B/0pj0cZX7eT9JVlvBtYcKLpMeF1yNJd95EIp02EyqFpwA5UmXBcLshtv6AGWtG0GWDUvNghQqLRTo7OAOUo5SDjHIZXMxrkw5M7fGC0uypEVmsr2Nb6sJfauH3i8wUy42wccSHpIDqrjnUjkVrUCOeYwcQeAYAtAWQ0oHX/omngRwIP9ClmNJd65uhld7hO5z5cjaLU6FMecf77d5QtPU/YPmyaKu9BI4D6ShrSbXKQ4YxSaauzL0QsktyAUjc//Gj3gMtEdLXgtVqQatU2NSXRoV+8P2v0xrlWK5QnXWnNkV88wtCVNGlEx0f7tZmIbnxcmV7NVcuw/a3D31ugSizB/MRhRUNzLXEQt7X0z1FnENejhVgyVOUpdsVZ8j6eJ4GhHkDe0GlaJ3ocxY2SR5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:00:37.3925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5698ab-c73f-4f91-cbe9-08de7e6a59f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

From: Santosh Shukla <santosh.shukla@amd.com>

The virtualized IBS (VIBS) feature allows the guest to collect IBS
samples without exiting the guest.

Presence of the VIBS feature is indicated via CPUID function
0x8000000A_EDX[26].

Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b1631eb15e74..a1cd6437a052 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -382,6 +382,7 @@
 #define X86_FEATURE_X2AVIC		(15*32+18) /* "x2avic" Virtual x2apic */
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
+#define X86_FEATURE_VIBS		(15*32+26) /* Virtual IBS */
 #define X86_FEATURE_AVIC_EXTLVT		(15*32+27) /* Extended LVT AVIC acceleration support */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
 #define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* Bus lock threshold */
-- 
2.43.0

