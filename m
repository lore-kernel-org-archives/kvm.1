Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793303804;
	b=ACL1fixGNyvtehqJSDfvxH1/PGLJWKwYi7YmdfAnFH2VpemrCCoSgyj1c8MOIOSb7lyF
	 ggJQkNCIsscAngZk0xM6ZxJBbAYP9tP8ZR+bKa71OTJwSkMHiWMyRnEYJdLB+7MYHAAor
	 78zmWeTeBdTDIgr8IT5yhrrYzsWs0S/StuPk+S4HwBjPRkZn+ZxxcC1culfXXcd1AyBRa
	 A/Whpx+wdikzVVJmRtSQTrgtD1XPoGtRHa3FR0sfHB+47UYosjFup8REmSzjq38UInlyQ
	 UzTkMNxZbnJRe0mktuEjDB2cF12CyzVuLGjPORXB0RL7orVzpPzfVdr0c0bXupgomHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303804;
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
	bh=tBNJBPrEdTMZOp1KgiEbvBOnUAzOz8utSQ3+25qAcIQ=;
	b=LY/VCUxStXPHGPF3GeWxUXluz9/1tBzbh2wKgXU8HecmRsV3iYl35G9cUVU0H6ATi5gL
	 52NGCg+Zri3bFojwUs9EPzVDyPt9avRIgU8kxYVcYsrXGERDRPPb/tN/q5K5EyTwBePXw
	 KaKx7jW45qAHToTsx/nS+EVwqUoafkfquqzDfRGU5KCgW6UfeIenGa90vV/oh7pdW6YMt
	 UxUX4OBXSyu978kFUNqFVg1uaPfqxLA6h62qv7y7U3wOCYliuKFA48Z8hcn343C5a/8JD
	 DLm4sfbd9tmad+AuOfadE/yM1lO5zM5o7NaPLzjGrY5YIGuu7pazeTKEOb40tlvG3AQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WdgOYAoO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.34
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013034.outbound.protection.outlook.com [40.107.201.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCA0606A321
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFCA0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WdgOYAoO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2a5f0RQWWL4IVu6mFbyRi5uj22hubxnrCBTn/+/9mYvc6bLD/U1qbKn86ESG1klo67dP7xRAFrd2C+8xLc76YlZ9J2vlNtqq0VJP8y8sIhHVGx/HUNkQx+MA7oxQAwgZXsBlloQVO2yB1Kr2bLCs7aBU2phBRoN+M7ikmgyV/LSVON3bNPwffAoacJnC7i/exbUofxPX7HBJCrBKt6Pi2sFYVzhF7+9hafYeYBwKg7JYqAMiYdq9SVQzvkzoWZVWeRLXkUauDmWUZ9/n4wP1omimqCYnb+ggbwsuLxt/PlqkOIFmfTpnwQJffJDqnNYyiCEMHtRrnBY+4b4Ub/MWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBNJBPrEdTMZOp1KgiEbvBOnUAzOz8utSQ3+25qAcIQ=;
 b=IZy26dxmDPg5JBZHw10GFQUO0EPtcnkDCigv3Y3y6+1z5k/gV30yJ9Gse/4ieManDajzWCOvfUhjHR3Qhs6jzzhzvp3y99NJqqkoO/QBWrxjz1JPu7jBsaBsGlUY7Ayl9smCJhpIfVOACRMfcdMj+fRCoJ6nhqilZvFM4rTS7WmRkqnqd5o9/Qq202a6/zc8bqFCFo2z+ryWzRsRFEH9EJkGoUh4dHGc32X7OjD7wb13OQHjSZ9yshlWRNOEojNF8NZUI0ELev4O76gziF5AHMN53j+74wwPJxH8k4nFT+FR7eqqMoIdy6cEh1navtHrPwaFdRecpN2IIZsHGvgcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBNJBPrEdTMZOp1KgiEbvBOnUAzOz8utSQ3+25qAcIQ=;
 b=WdgOYAoOOK5rGyIEsfcKfs1pzHGsliZMXZiEFhY8uNqkNz23HBnoBkioS3x8NbdR+T+fk88O5WBIH4uLNtzCsihbmmKf5MI5hbX53t8lhvLFiWqMx1jv8FQXl3cFRa1f3YUVL9cyfNQ2pZ9ww65XA6ozntIhtaOa55YvDCB1Cls=
Received: from YT4PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::24)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 19:56:40 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:b01:fe:cafe::13) by YT4PR01CA0032.outlook.office365.com
 (2603:10b6:b01:fe::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 19:56:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 19:56:40 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 14:56:38 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>,
	<babu.moger@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 2/6] target/i386: Update RAPSIZE definition
Date: Thu, 29 Oct 2026 14:56:19 -0500
Message-ID: <20261029195623.2209-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
References: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: ee193239-ed47-48ee-6f66-08df35f6bfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|261022075727099003|10067099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	U2W5OPckA96jzYph9Uuw4D0NNcfAlo9+uUUA0BnAqFu+xnZcDk69ZX6SxWxP5f5ah4XPtHSeB68J+uTn0pYI3UGI0tbeK5kqTMLL2TA8HcnJMQLhd6zeWK6OlrpoTaav0ih/sRFN4+1+zmRbDPfUKuByo9X+z8Mzom8vCl4bay1dTaeI/HNb2zsu1fequ103Z+eBXKO40TVyPU3exfncTPn1G0Mm+sqgEOY0sUhnD/qzIxCSpBIdN2yUyhbGyb93gaInYvEpmTghS9ibCPMuCn+kGNxiVdKnOAexTy3Llf+ZCih24FpNa0fTYcWCjLeYR+VoOZbPxTaf3IBSqVcAUcsdBKG+ReaQTiwBZo9kGd2y4XkT6AQlHfXewotfuIv9HuTVtcGf3nYkgSWUYOw7c5cobmHdPBuoaBdoUuz9LpSFJec65fRCy9GIjKl8WhR6iTc4Guhm9MO4A4lgRLf8F3jv431ciBgaXJfd+5rHAXhr7kSIII9Kl/R8Fb83X4Gf+SeYXiHZPuWyehxJTOab7GEZS2YSf1+Tu7TvHofkpbcwsEnNrmezP2XI6Z7SbJKvPNdFfzkgSR9rfCN9ALuoppGnXeS4M9ZSlROcpD5/ZcYmuDREIM9H5yyUjZkIYbvC8dSA0cEefe9/69A2Cr3xHvt7v587NVu4ogv95nlfsHUfMQEYcjUot2y834wObrboT5XX/HPq1lnSAwVL/Fluow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(261022075727099003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4s8KbgzGkxynJDBj09ELoglADT365vGRFnOpLLaQmX4ybPJH3GDIMjzj2Ko6yTd9hVwVBhZg9sVhorrMIV9JI3eLy8nrKwIL/LVWqzO9xbbvfThJ+UrbN8x7ZRXCWWEFTqoyTVpqy2+rFq2e9z4uaMZMfOUbXdyaiD/PwiERsnKFJMV7d92XF/FdVRhryqTJoALG72OXR7jGRTEW1EcIAQkvCZ7vVMtqSu6o0b5pMWbQ/m6xKzzsYayMS4/7+2NFgYRPFH8UOrBHZQ6G5MTpCBCTPkiSsLgdkfz5cT82aovzxVv8egXGbE0qcXKkOT3Ot9dmQAK7eq2YBaYjxVPrzWUHttLVXAvfVrb4M9ATHU9shyYHYmZxiZP2FhGRiMisR7ms1PFvk/L8yPH61XuaHgxNsHzOLevU9pEA3kreZKEvkyIzLIVK4zCBarE94Toj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:56:40.4156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee193239-ed47-48ee-6f66-08df35f6bfb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

The RAPSIZE definition originally introduced in 9c07a7af5da:
"target/i386: Expose new feature bits in..." hard-coded the value
of the field to 0x8. While this value works for current CPUs, the
value may change in the future. Update the definition to be a bit-mask
instead of a hard-coded value for future-proofing.

The field is currently unused, so no functional change is intended.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9ddbd1c447ba..b7d135d610d6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1221,10 +1221,11 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
 
 /*
- * Return Address Predictor size. RapSize x 8 is the minimum number of
- * CALL instructions software needs to execute to flush the RAP.
+ * Return Address Predictor size. RapSize x Y is the minimum number of
+ * CALL instructions software needs to execute to flush the RAP, where
+ * Y is the value of CPUID_8000_0021.EBX[23:16].
  */
-#define CPUID_8000_0021_EBX_RAPSIZE    (8U << 16)
+#define CPUID_8000_0021_EBX_RAPSIZE    (0x00FF0000U)
 
 /* CPU is not vulnerable TSA SA-SQ attack */
 #define CPUID_8000_0021_ECX_TSA_SQ_NO  (1U << 1)
-- 
2.53.0

