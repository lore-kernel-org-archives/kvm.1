Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A845041E;
	Tue,  4 Aug 2026 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887833; cv=fail; b=SKO02DEtCEWkjAL6QG1+Yw1oOuhyMq5N8SYuLSU445AQ9el932PsQn1TK6gVVD9aKUWWi690s+SktZFW5FWcUT6Kt/PitGKsB3t3OzgQ1f/FM9WCWPSW6/5I1SoJ+8BmQd6MZwiPN8CdFWbo01CspeVU/ttepGNoC4U4CFMTaNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887833; c=relaxed/simple;
	bh=/8iN0dLNJB7B/w+c8fG69zzj17gK4F5thO/PJvNkufk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzTKwytL2wvuyHaMCk4yF+QDIMvU/VlkMv6M4pPaHWL0QLKp0VdEB2jNapMDsUl9Arpz89WUz1u9noVINPSq3M3TtXM3meyYunML9a35HglKFCEw8BJI4s/DGMDlt6n0sDa7zxSbJ3TXrhGrmiJtjf483Z0m3nIYY2kpAVkE9UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BuhDbx92; arc=fail smtp.client-ip=52.101.48.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BuhDbx92"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEbpPh+oLzJBNvfztUsBbMu9F/jCOAkDF/s42ShFuTRp41s8JpZ6bdemONtBmcKg9EyvOG/JNeTewHJXh7/aA4vqQNxDHswsp8RnYESKgjNDL0VYpOtz8Foyt6W+JMgiO/EiOTQmZQDpgiyk+aBDtw/rU+r2/+ZzHv7BHK1U8Mmw3CzsnMDJExomTeUZ7CSMjiRtl6Rf1s9qjKs8KwuNVPSrpk9Ph+hyXQ3RBWM2glSuR7HT2POwiCNpcGXPYezsxGtEVS+jfd/U5f8odNhNN0cCKH/8LO9KdYAdnMEs8Z4aRndRgm9ZZWb0Iufavmqhy+RDovOH2s7a06WN4gjQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V5fvAywgkHl+XvZQLyCv4+sFuU7e7OEOgDaSYD2JW8=;
 b=p8kBV4DylLF5nXf+EgW3iI8vIF1qtS3fHJLXrlga+cTiVRYM1zejOzWe/H6JDdgR7tpkffVGWl5GuDolXraxpHKKgl+8oSvAA3GvR4z+ZTA4XPf22LA0Y5iYsG25Mgp0PsJ5kxVt5WgOLg0JEPcpegVTkQY7CnqakmTx+LYTGiM66QC3WiJ0fTaolu1DTwnk5uKEl9TZ0FlnHHB2Zj6A/JkMUmXMRr8ho5RruDcHXENcD3JKvfxDcFYP0/snjwXy0mN9BUhYogL+0jr69wOF+o49yPguprElr4xiNi2GpidIihldszHIlV/+gykH/b3dSQ+LkCxFFo6+InVXPF7ocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V5fvAywgkHl+XvZQLyCv4+sFuU7e7OEOgDaSYD2JW8=;
 b=BuhDbx92mR/SjTS1TZS9KfAafjjsrTAH6LfFRCYwu244bH6d2EiptatGVHzMTh8aOgSAEWepmc0UPKwA/iq5HKELzzYYSKAw0TjisdYv1YH+AuNaKVUysQP6t0m8yAr0uADO7T1srZ2wzCkvvuNBn6omYZpFs5RGJEazaHhs7vs=
Received: from BL1PR13CA0228.namprd13.prod.outlook.com (2603:10b6:208:2bf::23)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 23:57:07 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::92) by BL1PR13CA0228.outlook.office365.com
 (2603:10b6:208:2bf::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 23:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:57:06 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:57:05 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>, <stable@kernel.org>
Subject: [PATCH v4 03/10] cpu/bugs: Fall back to AutoIBRS when retpoline unavailable on SNP CPUs
Date: Tue, 4 Aug 2026 18:56:04 -0500
Message-ID: <20260804235611.4053375-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804235611.4053375-1-kim.phillips@amd.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2eb501-88ee-4501-f1cd-08def2841714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|10067099003|5023799004|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3vCJ2uqg56Qp8Ory6aijlBc6zRsPT12OV8hdxybKM7H1ieQ/QJcPmzpbU0/Q0ujdB+zjlVIqWhudDN2vECLpi7dJKEfeS3qN1WEbljsox4zItgIDGXCdwDmGHfHpdzVBQ2atkvkN10dAfQFloP0AOsE3FSXQmZmwya1QgBRnGcArKG0f8AV1o7D9Adu49Fidnie32yo4xP5nrv+FmWVqSAHN4YVk8hXMg0lqsrHuTv4f/QQcVG9v8AWzAi0Ljwo+lsAFT7c68V7DH8YeY3/PGDuvlvtatV7cQtSUdtpvCmE6dlq5RjAogHtfgp0uUwdM71VY04ricgYsSsGRNnQy7V1MnooabeK8DObtEf65xsmT4FOlwEseT1V6FrCNcBq2H31VIKp3gwlUSB1fAjk1Ie9b5e/lmn0rvq+GHWevawVx3olphczLkfNUZR97M0OFS/ojrVaiuuCd606K7lFywSP7hnMvhjo/DO9YdTRLSzftdf7F1epr/Trwe0XzOauJCtL8Q/1WSptjNiVjW3L87dFMZmYnUJudWWN7rWK1gEOpAXEyTOVMKkRERXu4krYKq42mFSft8UTYAtexg1wLftppdm0ZQFJUwaP0XeP+neLyYvIGLRIID/CNaGwvWmeBJrxno3pX6idh5Th1/LiJ5cIakg4/VulNmCsCQUFhVmeRZqrZflrVmeeqRwqMYzDSlKYQ94YUw6nIAuOdK80AyQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cRg0fu1J+RDGqFK6RENAhdtuCbUuacMlP9Ye4Mn8sv6WXmEWv8VYxOVDxYgLTgt2hMgERkFwdi1DIOu9HKZBUEIvhqpy7wW2PcmVFTxLfdoPvRzZ+m2tZ4BBrYZINIGAmTNFfBdJ+s9ZKsCTxj8x6a+aSxgQG7INecSb97Kac2SxkvsUwrUJvOq01YezhYYXR56Frbt/JD6iXMwsK1Tv83K4CZwWULFJbT5eXIiPvAl/qZgD3Au4aOgZMn4sE1GyuXH+kDvyez6FdI0wOhW+LgU3eXfOIBNU4bAnJtqPplj1sH1UPuhdlEBO6Weumn32UTvNG1DLyMdAL7v2t/mmoD6ctW/6tXWrX9rpjf3qrmol14n6Pa2zQPwgH7wNx1V7AdPT0qMT16LJpIpWveAj5Bmacyvnl9UT700JITXbOztqfKt1P8d5sldRsVRTDtXq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:57:06.9710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2eb501-88ee-4501-f1cd-08def2841714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

When the kernel is compiled without CONFIG_MITIGATION_RETPOLINE,
spectre_v2_select_retpoline() returns SPECTRE_V2_NONE, leaving SNP
hosts with AutoIBRS completely unmitigated against Spectre v2 in the
default/auto case.

Since SNP CPUs have AutoIBRS available, fall back to SPECTRE_V2_EIBRS
rather than leaving the system unmitigated.  The preceding commit already
enables AutoIBRS (and sets X86_FEATURE_IBRS_ENHANCED) on SNP parts, so no
additional feature-bit fixup is needed here; only the mitigation
selection changes when retpoline is unavailable.

Fixes: acaa4b5c4c85 ("x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled")
Cc: stable@kernel.org
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/kernel/cpu/bugs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a813a98ac5bd..6a036b509f0b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2204,6 +2204,15 @@ static void __init spectre_v2_select_mitigation(void)
 		}
 
 		spectre_v2_enabled = spectre_v2_select_retpoline();
+		/*
+		 * If retpoline is unavailable (e.g. built without
+		 * CONFIG_MITIGATION_RETPOLINE), fall back to eIBRS on
+		 * AutoIBRS-capable parts rather than leaving SNP hosts
+		 * unmitigated.
+		 */
+		if (spectre_v2_enabled == SPECTRE_V2_NONE &&
+		    boot_cpu_has(X86_FEATURE_AUTOIBRS))
+			spectre_v2_enabled = SPECTRE_V2_EIBRS;
 		break;
 
 	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
-- 
2.43.0

