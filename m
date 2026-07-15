Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2330C630
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096928; cv=fail; b=ggaZVcgUK+oo3+oYzAP6QfqbJiEgG/xJb4oCnaJQ5lZZteW2DzuwIeiNj2yXTeaJVxU7WFCLwW7+PIns04blyubjzVWd71rXvAzf0lZP7fkPfaBrG9zbT2tDSAiosIraqBWOkTqvjHA/v5GTqtRkj/ntljRf5nsQyVDDyQXmisY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096928; c=relaxed/simple;
	bh=ZBnhSpertu5BX70HoqCZTvokEdPPcZ+lPpDR1YwI+x0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CHV/u2XhWFpDfw7dGr94o7mQpVZBHAqW72FAOzKYVwOrcXtQQxLZz8hWJ7CZr+vl/nHJ6j6J9BrDXimvkA1tjeG+qfbO73yRLVymBLpLetgGNQuYoc4POnqxO/bjoLiG2UbqBs2aucTm+o03lYouovJGz5INz+Al6b7tZkaPjuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LoRLZDWs; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LoRLZDWs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVL7SOYiYCynB/dBfM15b6mKEYlTxhPPm6RJ0P8i/3S2gSEyBW1PP7skGsJks6VkyQLy/iLRWfpsesC9A0p++5DzOBXKhXUcM3rkyN5UUDpOdzXxf+2xrqUGqHHaKG6+goq8TclXWa5GQZcVepoFQqhOjC6Z7u1U3Tb4jCgtBuEN9Cbiov7XIC1K/QJesF7ustmVGSA1tZXsduMSJGjaYPQPEmWeo/aqepyaNxVQ5JI/F7F2eexvt2risXCjsvteTKvYDyVznQ/lheN552w6QZ+O+eC+xX5fIClDeMMK/1T+nj3PdIcoCrdUfI0lKZAYC2xTTOm0Y4yMAX8cMz5rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDp0+1BkVI5G82LaMGoxAEk1fHjwzNERckukTcWbUt0=;
 b=KAnZt3pkzz9L9g78Yk6h8Aefi1pdOs4o05d6ZglralnB8O8fo/iv6R3Xc0ymAtg7CTbOpyTSnneh3IzmX/dBnRwyuAsNYIsgWWdMh5YwFEJc3P14CVco3qGcTm9pmDmXgB5B8vYVpmS1cQwfeuXJSkV59AaEWcofGimQGGhn7T8e0YBZvIoUntRkHIyXbmTeo9k7cdpD11bFnB8BS7I/zE0CW7lPLdSn2yk4AJr6EcejIq/dUiazEHK8Ovc04SZ5/TXy5yb5vuSiYaMxw4NV4U48yc8MjRKPjw6YRAKaalpKsRxO+7vWhh0DPPweXUdyaYIDn0Qq37bnKGMPh1hFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDp0+1BkVI5G82LaMGoxAEk1fHjwzNERckukTcWbUt0=;
 b=LoRLZDWsislhmhTw4BJ/ARlSAyZ5hnMMCZw9VL0e38iQljeFb76RhtzevCBbr0+ABsfkiJXIGK4mRVcMwJX6Fhi1DTixR4Td4+Lk8NxkQEU2Y+CQ6SVCo5rpwBlrd6eUNtb+VAZzvb0OGTgMJndV7s/nPksSEqLJYOzAkV0UhWA=
Received: from PH1PEPF00013305.namprd07.prod.outlook.com (2603:10b6:518:1::17)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 06:28:42 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH1PEPF00013305.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 06:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 06:28:41 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 01:28:36 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Nikunj A .
 Dadhania" <nikunj@amd.com>, Manali Shukla <manali.shukla@amd.com>, "Sandipan
 Das" <sandipan.das@amd.com>
Subject: [kvm-unit-tests PATCH] x86/pmu: Relax precise count check for emulated instructions on AMD
Date: Wed, 15 Jul 2026 11:58:28 +0530
Message-ID: <3bfbf15c22652ba00cf4a16fe9e0a3bfe7071f97.1784096302.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: e361be82-d77f-4220-d90d-08dee23a5004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	VaO7fC7IiARLNo0fvLcjDw13j49v+ZesdpQ6bUNNfqatGNObL6DiEjmsz5Bnl5ikw03k7BzXFZY5wnHLKTALblWnn8nURPMgo+E3K1xpJd/2mHSfjibqk4TUnI5qDFcZvfU1KIVfCRByQMuFnjukzPOT5opNlyDvcwqv2EvPIVYVTA72MhO1jqtxLaTNkLWNSutYx5bZO5r1obTLBIHCr2s1k/QheaTdoR/JT5wTYMAHEbrpIVD3gtj9cTPtaev+ljraf51sIHWRl5eslzGUZf8PN6kdZ0XBGuiXr/AE+is/YnbhWURTzuoU0LsxbyaqX0uRAT5dzHlzfNy8Dexk5S1O3zJJRHMQrnUdcTIQQ4bkI6rBJlt4Ma6ec1iXkO5ylXMhNSELn6onvo7J6ZfTYQoeGi6MBKaFA08/YuHtGXkBuNGrFFdi9y6LA0QRd3q6hPKZtzLXevk7UNTR0XStfs1gRnf0iqEJSk9aLoQJsp+U5ubriF8zR8IpQD65cuO7kGTne2fT4hAFa+ZCNPh8reh4dMNPekY/pilc5ExkFmjwRFCGltqUpzi8bUez3pC3dfUQOfREQYDvWSx7ZDvwTMtl8BSJjdkiQnW/3ixYFLlNfP6JeiPwj/1w955J+XXLwRFAWza/TCzQWsi4x/MSNzq+QSjqXBi3lvDn67XnYXzhOl/PZvu7egcYlBac/ZLyEgJXxJDIyETef68DPju/DQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MyuE6Zd9R4GAXRs/DQWyEDRLkIurkBpsStbFwPaVq7xkEqZ7RHTfk6XlGsdcNvUv9+Tqs+HZLv6m6Lf1+STWPidUtoqXvKI106UZQTY2XgNZXDFfClaRjKnUNFT/6MNGg9UhA5bMNREkw+vu7dBi2l6VyKy2d9PIk/W2sGrv2udVZfooiO1EcaOT2emZQZJ7xUzYbUEgZk9VZjetBGWwtaSEXQT5g8fUOAaKivhQHVxEZIhALvcM+AAhvXMGyAEVr1n88cwzmpMV2O5QewfaE2d00RFzI/uLSCtFEi53ullS3LgJqpDje9dhWqxo49yM3+jVHpl4bJ5MT4MYvnNmefJAFyFVwPcQrlV3H9VeFju1UTqa+CX9my1L6n1+D7gB8R4WF9m7S/SGCyr5bEpq5xbJSLoxErG7CCUC4/BYJ7qd6439wgKEhJ1sP35l1UoD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:28:41.1087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e361be82-d77f-4220-d90d-08dee23a5004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

check_emulated_instr() expects the retired instruction and branch
counts to match the expected values exactly when a global control MSR
is available. This does not hold on AMD processors because VMRUN is
counted as a retired instruction and branch in guest context. The exact
comparison therefore fails, with the surplus varying with how many
asynchronous #VMEXITs occur while the measured code runs.

Hence, gate the precise comparison on pmu.is_intel and fall back to the
lower-bound check, mirroring how adjust_events_range() already handles
the same VMRUN behaviour.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 x86/pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index b262ea59..2b8d1b5b 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -786,12 +786,12 @@ static void check_emulated_instr(void)
 
 	// Check that the end count - start count is at least the expected
 	// number of instructions and branches.
-	if (has_perf_global_ctrl && !pmu.errata.instructions_retired_overcount)
+	if (pmu.is_intel && has_perf_global_ctrl && !pmu.errata.instructions_retired_overcount)
 		report(instr_cnt.count - instr_start == KVM_FEP_INSNS, "instruction count");
 	else
 		report(instr_cnt.count - instr_start >= KVM_FEP_INSNS, "instruction count");
 
-	if (has_perf_global_ctrl && !pmu.errata.branches_retired_overcount)
+	if (pmu.is_intel && has_perf_global_ctrl && !pmu.errata.branches_retired_overcount)
 		report(brnch_cnt.count - brnch_start == KVM_FEP_BRANCHES, "branch count");
 	else
 		report(brnch_cnt.count - brnch_start >= KVM_FEP_BRANCHES, "branch count");
-- 
2.53.0

