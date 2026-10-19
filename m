Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444069;
	b=5lf477ig4PCfMzkqj0Txdw1+H7twcFsfmnStRVIuM4AfU6Rnbtn8B/fydoCdkfZaLkUs
	 YhJsOaX4W+vhjajaFxsQEeSuCEluarqLLBkkUBlRAo/QOb2qIE/Qh2fDy1NSTjVMVEe0p
	 8ZxzeeG4NN8dEasvZQckyWgiiOXQT6I6O52ALJsY+H3WhGibu5QVoVH6N44wzM6C8NiZx
	 zzsl1U8DgVd6L3PoFLqsy5Zd1adg9cU9war78kbKip4NkxNWzQs1I2A8l+Y4JuHr05bwH
	 E26B0Xy2QQcf2Hfh1rmYqkcxfkr9/piNsqPx1Too26iB7Xu+bxiJM2VeqZwUAn3IR3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444069;
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
	bh=uTFk/xARYYGoMGY+pnoOCh51pdNlvFsY1Pz/ItxuVe4=;
	b=1+2+cFLHz92Ikq1FN7TgfQTKCFMP4JPGVhgpx4zhDyFYsgETOgSqL4q+HePk8NVudaUb
	 8l8F/20T3EopSelFqp3lcxdDzM0DHMHjcY9mUGrXRHt6wF9pRRto+QF77nk8Lt8BDXkTb
	 qn+CiP9r5i19vS9sLBlCoXO8g6tmYNs+myzCCE1R+LuAe9mxOj6w2oYeVn4bby22Efgfa
	 y/k0GNu0I934G7b/xz1B1I1NYpZX0zJ2TaExK1YpeesBktef+lFKGTixrz01byWDyurOT
	 4UOVR0PHTal+d9xuArQ6Xu+KY9Rkblh24AnxgJSr4nGcQsCiNeYBNXnAQJIqffA6vOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UV+f6CbV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.27
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CB3606A31A
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09CB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UV+f6CbV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUnbG86rp/p89g/jOam9b2pJ+bV7YXdr0D7NONISkPiBIidW9+ZsVaLGDCRX76SDYtGMARZxc6/oqIqdMZ5firhDOdyxKtow13QXoaV74OBTs4kDKm3E2IDqAb5Q9DniJNtzn7MX1eoSGEpkzChcu1AgaPME+EujlrVtb8otpqOD5plQCWDKhKXvj4EjaTD7c67L7GhoiWNX3bX7GRT+zXRJmFM8XCcDK+unZ380HdICrJ8TjHyBten51AY4ZE5ePOxWXk5J/HqxGEcCS4rFNEZVzj/EqfaZn8/X92aXGCXtTs7Fa/OpWuceF/QBYyRV1LfLX+vjZgwEVmBgwTsTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTFk/xARYYGoMGY+pnoOCh51pdNlvFsY1Pz/ItxuVe4=;
 b=BMbNlfmX9UKJGpYbtqvGOUPFWCxJUF0di5uThG/RLOWcySlX6TH8ryarCeMdmN/L3Lv749Bl9cqAepldHfdOwOV0YaAoneIt49cFZ9eFr2y5qABNT5eV11Zi93zwcbtCcJNSBVqByv7HurvM2lnoUak7lFrNvQSwZKaZ+imX86hu+n/X7rQlMFiioBcceP9czoyy1q6ayNPG6StY1BV4scSkESiWzxsSgL0N0LeJJe3hjOiElEExH7v6NdsL+yqgCc5bhc47gy8tp7ndwKyVEILr2BtyFjftDskIVLvkwIF5OsOUHO9/IKiJJWdDGiBesLp4wCKWFJt1pv9AN7bJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTFk/xARYYGoMGY+pnoOCh51pdNlvFsY1Pz/ItxuVe4=;
 b=UV+f6CbVUF7THVrFZ91KDg6mXq/GXoZmp3dIX9dwUgVFQ8W4WWrCKhMEZtKGDj7XUdYBSbyqjI2iXS8NmDv7Ly6TuXcqczSKQWFcMg8nhfoQqtNumNhuRiP3YQulqN2kzqzOzRFFLO636nco1wQ8a0c3oeU3nJFrKxyidnQKPpY=
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 21:07:45 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::68) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Mon,
 19 Oct 2026 21:07:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:07:45 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:07:43 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 06/12] perf/x86: Expose the LBR stack depth via x86_pmu_capability
Date: Mon, 19 Oct 2026 21:05:26 +0000
Message-ID: <20261019210532.378628-7-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019210532.378628-1-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d57a6f-ce3b-4243-780b-08df2e250581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/x6qpiCqB5aQuMDOmD0s2jTvzHVnlp++ZrseKFj5mc1ReehxfjmWsc6oUR7PAcIN7sV5NycXMgP5WbiBRM/r2qojPbryC8h+QX26Oek6sHguElhRUkawDvIKGkHcQhupDzEI6mDFvHln9vBcKDKAFWqLPnF5x9n1EZIK6m0sxKkxim+dK1cfn7U0p0SnwDr4j0SYfu0UPusnVxBXJrF/ha+VTNbx4ntCg2uldpU1ywpVnwGBPc33OsxyfqK0nIbKHplUcW5FeSTKUhsRjNnPCFy09+Il7DBw1RW30P5uo8RDX06H88D4iESO84Kn+1ZPpgnh7NLGUU9CXBsM02ENLuaY/2GUFF0CqgID4BoMesxhMtG2O9yfYrWWUeRHOU7FyD6wTVvXe9i6SaQ8MI6fjzTiQh2L7LUP93TO0FJy85pnydim36QY1lzZveZg9fC7Kb7NqRy4j8GFeCQM/2WKsGATT2LYhqATk0i0FUWqAjhvn7BhPqwBRNBO4jmvwrHRsd53mhQ6tRtrh5PEx/k4eWmZXKgqP+z69w/xrEvLfHJ+JesElJGXnSEOMutR+sVIMTxLgYcrv2H8c1v6BuL+vKL4Q8r9Qgvy7Yh5AB8r/Gj6BG02Qjh33qwwyjSDamdqVyO1bcyOayxWDBRUV9/IpSqm5c1oeDuGjpYVIDcFiuNUEeEsFf/D71I3xW8IHZzi27VnhOSe38PRK8CXZkNBRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iPcvmhzMv5B0/h44/G7+cL3Lf1kcEY0JRjMHQgm0fxyd9S3dO4QDp6wExjKAVQaUKsfJyu1KxTfXxhaK5GIqiP4F40iEhK2scZ4vPrFTWkFfsxHjgs640012FC8rC/doWh/XXXFk1lA/01Qw1/ZZUwz31bG++F+5KyuWFw/Pspgq+sfauQTBCMv/I8TcDP51y9h/e033285HwOMr94UzrQJ2H9D/9xKK8DswqLdIAxlC6RT/SP8gX2WREnZVf2sTpSB9g3ZkWBx2Ww3iDyMfIHWkR4IPXHi+xCMiJMgVKRBaJQeVEfESs4AtcqysxgXhLn2IwSOVorF0BB7jRGEpeGGmwq7IqL18N8Eg4PT44jw84x5AxAqayEgWapd6Z6ExUgCqayGOksEh0vPeQb2vyLpPTaolI5crqKs2T+VJizLMIvTeLP6AppUkiD6Hd1C8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:07:45.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d57a6f-ce3b-4243-780b-08df2e250581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476

From: Sandipan Das <sandipan.das@amd.com>

Report the host's LBR stack depth in x86_pmu_capability, so that KVM can
advertise the depth the hardware actually supports rather than assuming
a value.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* New patch. Split from v1 patch 2, "KVM: SVM: Add capability for
  LbrExtV2", and moved right before its first user, patch 7.
* Set Sandipan Das as the author.

---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8b3ea0adb965..85dc065406e9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3162,6 +3162,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->bit_width_fixed	= cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
+	cap->num_branches_lbr	= x86_pmu.lbr_nr;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
 	cap->mediated		= !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
 }
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1eb13673e889..f18cf0986e12 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -306,6 +306,7 @@ struct x86_pmu_capability {
 	int		bit_width_fixed;
 	unsigned int	events_mask;
 	int		events_mask_len;
+	int		num_branches_lbr;
 	unsigned int	pebs_ept	:1;
 	unsigned int	mediated	:1;
 };
-- 
2.43.0

