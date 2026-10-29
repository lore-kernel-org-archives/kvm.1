Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793303809;
	b=zchHLyFkgk9bj29D0MMfAtSNiIcENohYp4+0v99JACcP0lTvsdZVpJT1TVEoCBEYSqrE
	 MIYAB750E7fNAH2oS3doxwjlF0Z8INYFOWtzWmfJF8+izcmvtHK8qV3U/9FZhy5Y6CK4d
	 xSprSTNH5mz++w/f5pns8MLymCp8oCCBCKntgK5aSTqfKmOs99LXNtrdfCni9WPJ42V1z
	 jTupJHgJDSJlP1VcYRK9/7lkLpoitFEFo+brVLIVTD5I7eeQws17Pjx488Jro5LODpq51
	 zsXwKMv342r6d7sU557YX3MBQbSLdNYYCcfi6BUcrysAvw0uHSI7Seww8pyzCmlmoTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303809;
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
	bh=O/C2vMbX9F7yAwyb1+hiXMNp7PHgzzVZDVyp+jsVm0w=;
	b=pCTlOr61nwdUW4wa1UVEjXFz/PbN8gdPE0AuUmVp5gCFn3zm8TusaEVuDxi4SBi7aL4G
	 QmMYouzjYgRbaRvDwu0OUsRYHOhVfMBWNctjoz7AlyPCmWFxQOgp6kBzUmel6DCy7YlO7
	 fS1Wiiid3K0shs+NfbMZ2MF3XRP/MC7zaHHxfj/obKrYoK+PS5GwR2hHx+aw+SBecuNv3
	 Ubo/7xgazj/S0N3HVkA0AbZQfYuHZv2kSHdC1cqNclaABgNJ9sfzSuhf1kt1TNUtTg0A8
	 KYpRwApg9lzsDDSfGa/8b048uD0jUTYkvpKZJvUDSiBScS8gyaFbs1wSMxcIAADoZRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MQdlH1zC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.8
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15B606A32A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD15B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MQdlH1zC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA2mJRMbMqkCI+ZNALu94wUHvmAlIhKot2B66Fb9fxxttavLEmYg4qiKltPT5V73XTKbPBRB+VBH8hgnIV8N3Tn8XGbWJSx7iZiLqdxxvcZi3FY7OY7gqjZcb/0ju5TtEJDUdE9Voa7zOpJ3UcZXFJHM4hrVXS/j//5AAiRIpANiiODBSUIFz6M8MnjNpcnd1FqS+v2Huqw2ybal5ioJ/QqBhLUP3rdsUi2CjEMTcmY0/MCX3tICtnXDfJ2lS/czCfg8AVqBSEIfLNUQ5Dfc3TeN9BMkJSCOnlt5WHorAdf5Wt/Q96r9dEOyldVMB/P4d7YXoNHp5u5GunXV9JuU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/C2vMbX9F7yAwyb1+hiXMNp7PHgzzVZDVyp+jsVm0w=;
 b=e1Iu+si5tTzVx+M0XCZ8Ib/OZyNDAhokJZD51Hw/Qel/FOCgNV9qiOLyXHMBSZkD2xvjMj2dCRMzdOe3/vC0FumeiGBFyxLRdNV8xwni10+aYnpOeXxiw3fxJ4tNTeF/dR6ireVv9NTL1y9Xby+oTxIwchejpC2kpoi1tKJqy8iKNUqwbPPu2qvZs4MpyYGKtpF2w/LXJYStXhGAVFjnGo1O2mMFu68X76RPoMQDV18nKqSaAJHVyZnmdhaZDbSEKlvTxTP2XUYKxHx2YwHKKPf35FSzXB8Pw5ZAj+zPgF6X5zmEailEYC1OVlMgy52ny6UX+FoxuY8wxhdJs0UzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/C2vMbX9F7yAwyb1+hiXMNp7PHgzzVZDVyp+jsVm0w=;
 b=MQdlH1zCR4rY77bx1GiPg1mKzkWupK2q4bqw4FxxGJwuwObrwJ3S14E+zKPSw2pzWvb+W+DitY/OdDwvSNPZhYc+lV25Je0LNVByH4h0SnDkWiDaTTCvZmFA5PFG8FugQV0zIuJBurtA6hiiUg+k+iDiRdUbpjDGz6UPxbDcPok=
Received: from YT4PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::18)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 19:56:40 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:b01:fe:cafe::65) by YT4PR01CA0041.outlook.office365.com
 (2603:10b6:b01:fe::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 19:56:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 19:56:39 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 14:56:38 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>,
	<babu.moger@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>
Subject: [PATCH 1/6] target/i386: Add AVX512 Bit Matrix Multiply (BMM) support
Date: Thu, 29 Oct 2026 14:56:18 -0500
Message-ID: <20261029195623.2209-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 467f2aad-c6ac-4275-5c17-08df35f6bef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|6133799003|22082099003|261026121527099003|18002099003|10067099003|3023799007|13003099007|11063799006|261028144727099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LYQlyIm0Use4MJazVz20ttOaWqq6RgCOqfu1FemUkl9Nscfvzr2zvAIpG7C2Td7XDNXM7rYmaH6iivhxOknzEACWeAPSVJVvAcbh8nZnjskhJ0anZd26IadWWyteMrqJtEFLZfmmNj+7/0Te5bjhcX3/PhaB13YvuT5H8Tk8nUasLF9PH1IDne+IJmtRb6I2rYgoYc62DNetOLBQqnaIxeRDG9AcA82vGwOpYHtEJodRJZsddQb4Q3jF/O6j08WO4R55koO3/dTdv5KrAxmoprqvmwvqfsJWGGeXOBJBFBYq+u/hRiccg0IpwcuEwpLZX+HPGro+G+KNahf7Ut6Oy8uQeSSxpUZpphA0/z5MChv0iSDXJ3FrX2I3WGXyO5qrOuOo+2tFxU/k2vLa05Kx+6zzXgvPkTAppiB9VtmsfmBa6hk9Fii0VSulmAAZnPO5P/h/sFUammJ/P5k16baj2cFy8EUgirgKyixy85Mv5GEExvmBn02jLmkcvmRjVbHsDAKqvBFwIxkLu947fL/eOXCrUe3Ex286hKnq60WMfzjC1NX1gp7jtCsYUFjnRTZdUIperPNw++TTfcZg5P9nQvQ10WoDjxa4u20jPx5f7/Ry70c1EqGcc1bIfFpMHt1S8jPQe+UQNcT1dHSipOX2xHHqmsZ24y4BSbuBda23D9tJfZm/DtsOhLwno3NROkaH3WD7R8mpPoQu2ijPONZ94A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(6133799003)(22082099003)(261026121527099003)(18002099003)(10067099003)(3023799007)(13003099007)(11063799006)(261028144727099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LTVnmyTpDM6vqxibMTd3GR3e1k8N0WZ5ZgdwF6gtovjYqumpizO/M7or/wMOKwLAnxFsR2XxPSMZggCvWsGhoMuI1S91A55YsxiofPOFvs4GAma4AtWvmUGjgQ79Hg7vigkaYfAplSF8QobYZiW62a7QgEGYlSlwdwtn14vLt6XoVlNsr1XSumqWsYyatlQ1WoWot3ERyJK+yuolHL12rU2y4MybuBrIKKMvnMAWdRBdbtJB7GFP/Q84kfflpMtsfbgGiOdhxhhnuZrfYzTyXueszPnggV/i6hRK76A6OkSyo40P2l7kGh5tbJOmW27/PntKiiMidzZhmro5ouvj4nr/hbJt6nQR01dlJjbLtB3xhR+ekJNFIBbMcqs6FGiS8Nz7IM0gCABNgRJqVxfCXdGk43TYk1zf0gcORDau5beOxJ2WA9K79wNDKezcQmIU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:56:39.1432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467f2aad-c6ac-4275-5c17-08df35f6bef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

From: Nikunj A Dadhania <nikunj@amd.com>

Add the AVX512 Bit Matrix Multiply feature flag at CPUID leaf
0x80000021_EAX[23], enabling guests to detect and use BMM instructions
for accelerated bit matrix multiply operations. Add the "avx512-bmm"
feature name to allow QEMU to expose this capability when available on
the host.

Details for the instructions made available by this bit can be found
here:

Link: https://docs.amd.com/v/u/en-US/69192-PUB

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5ffb10d1565..3ece2e8b279f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1435,7 +1435,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "auto-ibrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "prefetchi", NULL, NULL, NULL,
+            "prefetchi", NULL, NULL, "avx512-bmm",
             "eraps", NULL, NULL, "sbpb",
             "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2fd..9ddbd1c447ba 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1207,6 +1207,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
 /* Indicates support for IC prefetch */
 #define CPUID_8000_0021_EAX_PREFETCHI                    (1U << 20)
+/* AVX512 Bit Matrix Multiply (BMM) instruction support */
+#define CPUID_8000_0021_EAX_AVX512_BMM                   (1U << 23)
 /* Enhanced Return Address Predictor Scurity */
 #define CPUID_8000_0021_EAX_ERAPS                        (1U << 24)
 /* Selective Branch Predictor Barrier */
-- 
2.53.0

