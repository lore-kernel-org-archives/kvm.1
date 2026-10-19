Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792440852;
	b=OFon6YafKHmZdl4/r2WwUllzQGQtcttPRHeT/S6/GFPFzS5r2kNEWPxXhLD+1GjWSMgh
	 WLcKFqluD2ug2U9NsIantFM63mIeuocCemvARWEorQMfaktIqIrj73XsyK493ha4ul3e9
	 K3ljHU4vz0zmwO96/9Y5ntzHr1dudUqkcxKa6XNWvXys8rR3KuKYLSeHjwtPG/EQpsOgi
	 jt48QsvXD6Lew2aZckoqFqK4+USEOEkaw11DdkZVKaWmCn4WSeyULuH9sUemXRcfoN93M
	 UBa5E6amgGj14NRfRcBhv3xPkLc/dFtggjoBy/PKBdiFMQhS2BT+LPwTx0lzmIIXN2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440852;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8+amxV6u2UzFyk64CgspuUqWzS14/o4d4VNcCeOU5yI=;
	b=XMCEoSOn9o5iH3W0kFu1qVc0FZl2ewcp80crGp7oXY2IhLk5tlhHOx29xCDGf2OxJ/oU
	 tDxsOt/d+kjxnyAeMYA83WAKfWrZxxi3YGLdEiaqc7kYmFP4QY9SV5OwdBPBizWf2jXCw
	 ZZsvZJsp9hYSqOw30hYzzDqDbEPOUOTLIqXzDW+ORu9ZOxafhxcM7ZmvNcuibj0wrzDip
	 Wl8iwfFcYUkyQbz2QEUMz0VetCY9+x/nWTE43HBJuv3lyI/cp+Qz/zJzEPzoGjaIkstrq
	 vKig9GnkyjfHi4zx4NbQcUDgcWD7voy1L7SJflroVVTD3eOoWIri5LbI8i9AEo5hOWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JEAG8Acj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.44
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60AF60A2601
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 20:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A60AF60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JEAG8Acj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgB5DfvzaiADv37D6jerEFPmLyyxNsamcbVgwIpGo+dI61ULE1TgoJ1EG2cWD77FwzvfHYn9/oqQxREeb+BrQ3/HFfAR+90rcBKztOdVgoJb40pYKifepyURukh9awvZNk7RaYw/38pDpWj1QDNFirnZRvR7Rt7tTpS9DXM6Qi9gvrnwzHkuYLhDALyJIg4HwNmyH5Jhz18ed4O856K44c2AOIhUW6di+i9U4di8p78ENTTN0JLp8vRQb1Cv0UcY7L3sWQW25WlpmTBClHqX8eRtobikrbje9vJ3WQan9p0EE3+MH8tv1YDZ8CZkbu8dscNwz7tFwtebfmkkmQGoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+amxV6u2UzFyk64CgspuUqWzS14/o4d4VNcCeOU5yI=;
 b=AmLIiWZp+RwhMGV+2ttrvdRogNdkhfxSW1UyYmz9CPtqQS0UXOKrI6jw9NQkfrOQpdNTGNpe7jsqw6Ue/d0txgvvq6oUsC5jwGnD3hGXkFGAWQD5g2qC3f5Ug0JhodYP6cDTF9/U6un/5kpvpzQDMlYZAteXtss5SJ6pvT2qTyBU6X8bzcL37Wj/UXI9D2hiODkgs+/YmwkoUUNYI4g4byGk1dbuzQlxUfH85A10IJCkAyYnxO70YLRuP/0koSvDzYZipKy4OJMEsqhDxz+di52b8Tj85di1VP+XR4020o0TmbSzu3pe0+jNAYgcOKnWIBp/0bL2SUeX3DlSIN4ofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+amxV6u2UzFyk64CgspuUqWzS14/o4d4VNcCeOU5yI=;
 b=JEAG8Acj5qCah+ALOeaLOQv+8Q6WH/EEuZtsTuG2gl/CX3hdDBaw76HCBCZvQvsk0V/mWj7Vt6hU47gKdBaJH+aAiY8kRkhYC9gPvoaQJq7vASNaxMSMITIdb4R6dcmB1fvDm8CnsX6Ecb8L8IMzh5hq7yicgS7p10JhemNg6fM=
Received: from DSSP221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::15) by
 MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 20:14:08 +0000
Received: from CY5PEPF00000E7B.namprd02.prod.outlook.com
 (2603:10b6:8:3d5:cafe::7f) by DSSP221CA0003.outlook.office365.com
 (2603:10b6:8:3d5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 20:14:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E7B.mail.protection.outlook.com (10.167.247.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:14:07 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:14:05 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <seanjc@google.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<yosry@kernel.org>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 2/4] target/i386: Add AMD LbrExtV2 states to vmstate
Date: Mon, 19 Oct 2026 20:13:11 +0000
Message-ID: <20261019201314.269798-3-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019201314.269798-1-shivansh.dhiman@amd.com>
References: <20261019201314.269798-1-shivansh.dhiman@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E7B:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f281c8-eb0f-4c46-2b62-08df2e1d87cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|261009223027099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	hmH8F+4CyTJI+4YvQJSc6TJGQ3g98soNCToHaRCbVgdIcFTWdkEwxziyWTjl4+KeSC919gLdJB67vCBiTqNmzhe/tTQcjc0zXTjH/bVKz3HFmBvj+mb4Vl6FbVnRLmUAtz1b2NVc2Ax2kiGAjgIblqh0I/DovoFB5PY5Mvu3M7Y5GIZwNP5e5yHWqJGn68aYYIk0EKgYg/Kn4GJ2FDwdZDn1JMAo9VXEreNxPE7VhZImve+spVsppOiOCAHOU48knMRMOhjdtzjvbAf+tgtSPfG4MAXoJbNEo8Yd8M7WnVAvgIk7XIKD2+PxwDpspHTndYnN62BPdBNRrZbzXurs98pBQclAnUn5+1udKHUyAZmKiNPuKdraTHhZ9NImnowrxaUCP4nlg+xRJNLKNSoVvASi5qmKZqPUTiEbvgcyGb1NoGhq+5efFxuxwNbbTxOzlZNS0z2tak/EMzGur7/h70PzR204Rfova6cGsLSwL5LXrv8fumFJeVW8ssW+ykRPvE9kL4/b8xEXgUqMXBGAq58nWCooGTTRjMT247wT5R8Ewl4kx8s4ZW21JlUM2bjiGC5SAQyr1lkahbvyXlmLqZj4PJiCog+xYhC1wOjHwRXYLj9INtTLM68T9b3GLoMA6zbXr5NUPja69NXy8RaQjCCrfGgUFGR7eYkiNTzBgi6DXONkQqnIqVxTs2154G0/RFLiQmqQ6epqUcN1edpmmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TSmBRNg9FazHA7hgoTjH8PbS4gziIueflkwvzqLd/oMwDtGDWXO0Sn9/dyYYaOsCHRZ6Rb67z2umg4RZWg8waYA0xaYRTNjMm1PydJrIUmeDgQssQXfPnaLSOs6ZrnT2nQr67Ss774T5PtZiRK7P0PvOrZbAk3q5w44apFJoGOTJFycmKcJR5Rd0NA3lpg59kx1ytP9EQgtHb8bvu98FXJjP9EkYn8QJWt9Y6WsL3LAuf5cNoPqvYAfFQsVuSrflP2hVekVokbRht4p5/1rV7lXWFGMPUNP0H4J247ZTIf8BZUDOf2ee0IBtBlz5HjeC9d1wdNeGWtUFKrUDIGWalG2iTcMyo4P0ENaN+QYrT+0tOl+mnu1kmZyqaGgzUyd+TiCOaw5zR8AtXTRokyk2fjvdgi4II14ZjzgmO3l1Bm1FZmfHUJxrJnmDNpltGblr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:14:07.6354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f281c8-eb0f-4c46-2b62-08df2e1d87cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E7B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

Migrate the LbrExtV2 control and LBR stack MSRs in a new VMState
subsection, so that the guest's LBR configuration and branch records
survive live migration. Do it only when the vCPU has a PMU and LbrExtV2
is set.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* New patch.

---
 target/i386/machine.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index df0e0c178e43..1363da5b430d 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1648,6 +1648,29 @@ static const VMStateDescription vmstate_arch_lbr = {
     }
 };
 
+static bool amd_lbr_v2_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return cpu->enable_pmu &&
+           (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_LBREXT_V2);
+}
+
+static const VMStateDescription vmstate_amd_lbr_v2 = {
+    .name = "cpu/amd_lbr_v2",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = amd_lbr_v2_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.msr_amd_dbg_extn_cfg, X86CPU),
+        VMSTATE_UINT64(env.msr_amd_lbr_select, X86CPU),
+        VMSTATE_UINT64_ARRAY(env.msr_amd_lbr_stack, X86CPU,
+                             AMD_LBR_V2_NR_ENTRIES * 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool triple_fault_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1910,6 +1933,7 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_amx_xtile,
 #endif
         &vmstate_arch_lbr,
+        &vmstate_amd_lbr_v2,
         &vmstate_triple_fault,
         &vmstate_pl0_ssp,
         &vmstate_cet,
-- 
2.43.0

