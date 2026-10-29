Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793303804;
	b=xLw9CQjS77WRN6J/u/NctoMYT0sWzqSvWZY/wxj0P2xE4LRQt3FMQgvTbGocIlnARmtM
	 BrntPEe66UHq2FClBHo2AjHCrzUBRN0qlh771iITJtCprnvw2gOv/f6CvJ1f7XduqlFDy
	 rf1oHW5YLIGmrSY3OGKNr1LPXal4IIbqxT5V5q3gBe3idxFLQkXYuOO5Y6oUazVDfchOC
	 e9i9mR3PR6iXsGIpLdr6BRBttPwHiXfM8+5J/NJbA211VjzHQjSOQfxy+PcJhXqGZMn/7
	 5Nsz1/x7wydxeMTFwFXzRn9KBJwiBFp/4Xq0YiP/sopiiGG8ehNlbkiL5t6gao0V3Rg==
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
	bh=C2ldarsBw2XGjtQ8UZ4f9L17A0+l0McgtJO67Cr5/IE=;
	b=cy8BQzZv8nyxBIebvBPRP1fzd328rvi7/dTidT5rBZKVYqvTqqBMkxizFnbRNiRuD0NB
	 OZwxOY4O/kCu4Z3felmKUwHbQpte+pqCGWu/Tiy5RBwcc9OdIyv5uiHQEeUhMTmVHinc6
	 bnHrfpE5hxjDF7YbWj3V/ufOsOouPAbg6LVFABZ0DOpA4fm7GD0k2ZJMUcdvtpcIf5vLW
	 stbkJJ6kjYAc6iC+kqi8cnktbRSe/66ld6hKW5G29kEweSitx7XJyB5zjmEhhHC/sJBXK
	 TfUEz8tpJkCuVzssbuB4KdSU7jdJW3EFeYhqjyC2Dv+upzbNCipDUZ/Si5OjPMWDD9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="O+JxBqp/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D8606A31F
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 983D8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=O+JxBqp/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI3hv3XYPzBi8jlqpTvjq53vm10hAM7rDfhN14ZzGtYSASz8b3GChXLnaQe97vfUSaEYC6ZCzLmm4dobksfXOPWc3EQ+1pxvoYGHTZ2cSjDajn7t7Ta+f3CJDGaGPsHMaRYxm015ipsT2u7SlxJMS/ysNJhvSAyKiGW6+vSQ0KKsSIplAkCe636N1CxXiAG8IGcze3Oyz2JzTHcF9J9BhEdmVRWC2zsczoMrL+o/Xcj50o5M94CXDVTFTpPTa0D2y+H+2uxIfGV66/45G8j4ioapLEz0jFtTSS86z72QtzIlQ6vEGtxgibpWLx/hZ/3OohRULLEBNFb/vbhk3Kc5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2ldarsBw2XGjtQ8UZ4f9L17A0+l0McgtJO67Cr5/IE=;
 b=xHThpL0UKAOo+SiwOoF2RBdp+wsgIVSu5v9Ax8Kwh609cW8qNN4U9cXY4f2yupGRvGD2I38iwh0sVzdv1dTtOh/AQWIr0Xy7GkTA/sVKLsiasXFhhaJmz5WmM0/67bUW476In9LNHMvjk0SSCDDGKfVSa9Vj3kn9vT7x/7pGWneC1qv0IMAWt7MJU8oZ2YHjrESvhLS/n6aED0Ginn0Sd24WDbI0Cc2QFxj1BwhU8g+/EI2ABmA2eYeEY5PtDU0/WG++1F82CV8ymSnwSEgKgxsnoN+xgzp6bUy5qKXv5JuR8shNX/JMnTLjScZXvaueqXiWg44m7BP3qhro+1yrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2ldarsBw2XGjtQ8UZ4f9L17A0+l0McgtJO67Cr5/IE=;
 b=O+JxBqp/GWLA9G4WzIk7Ek065KPLC3xJnhagnyKM9ZJVWyQAjjImqWZOC5GIis5/z0ic0klu30+jG6tmsJqKI4FYGUy2gUS2WUlWpvgPm5bl0pEMk9xpT/fyK0li94CbgecpwlvkSiEcaT1ihhPjM4iZQaiJpdRd1QS97sQiosA=
Received: from YT4PR01CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::25)
 by SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 19:56:41 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:b01:fe:cafe::6f) by YT4PR01CA0043.outlook.office365.com
 (2603:10b6:b01:fe::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 19:56:41 +0000
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
 2026 14:56:39 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>,
	<babu.moger@amd.com>, Amit Shah <amit.shah@amd.com>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>
Subject: [PATCH 3/6] target/i386: Add getting RAPSIZE for ERAPS enabled guests
Date: Thu, 29 Oct 2026 14:56:20 -0500
Message-ID: <20261029195623.2209-4-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f3f91e-ea71-40ec-42fb-08df35f6c006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|261026121527099003|11063799006|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|10067099003|22082099003|18002099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Xq2mwqJ2uwH+ma9ewHopKIazFBgPvfTqo8S1QA0kE9l9Snsj9/yB2UQ8xWTeBI8abfuEVm8jtT4BKThDfeaOsh0EaIMg5yC1CTScMySh/O5JIxu5tzfPU+pLm9Daj9WsScU0i5xS4I+d6PCK2ppfTSHgPgAoheSUXzIc9m8Iew/x706T/N+PBIFtsDHi5XhL2+R0Dl0vkq9OuO231ZXgw4H5NgVkU4s3oEA32jp48KpcMKFc9sm3w0+rA74+Hm/TOWiaWQhxdi9IXwhvKKv3yaPuOA2zLHSt7VqQEqHI8MaxUdaWKoBG2Ewbq9U2jN4ulMhleouZtZ9t6kqsqDHeeb+l1L217GKv8igxpce+GPAnsvsJBttLbIhDcf0CtTvMqn+A//MgyeWhVolNSa1+rh/D2NJeB7d2v9KGRccqnbRlbs1V45azijMGVwWDnmiPpz7U94MNyIUPWpDRfiMGgJRRJHuAKZS3AUldFgSml79GGEpxDajvFkNBmxC+v1fzyw5OOJbZpxhsDDc+IxgTbk/PfO8DLHxkhwdFbcgrwelyw9TlKQAPpE62rABiFgrlMEIHL6wXutlrMniJDHbvH3DHt9KT9E0Z4+t2nMfZippN8LxJK96JGSSiBYSryK5WWWgkcH3urH60cigwMaah6cHEM3xGGOJqRjlLSOJ5LsscReQBuKkIkk5lwp9sQlwFVtGPlMoYj7EUwt8kMBkqgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(261026121527099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M7VdfFK/wyTgLaVz2+dRYc1VgYKqLTKOcplH64oPD15Jgw/FsQmIgiUp0MaoEEdeOm2bN3ch3PmkymQJsDk5cCxTYfjDVXKZLSTe0OwChyxmN3+q2OVs1rEWlnEMnkt/r3jsPLwoLF24aUWnfb/IB5ZylOdHYvVhc9hzKI1nJkKyeIDLEj1Weber/1qZLOLFvs8sS5zlIqFzu6fGOMK/qsUof+/Pw4iR0IikeoHaszKgrvvwop5PrryxbynMZP2aFqi2rBzqrHzkui9lpAUWKsz/BcfXDEwbvgmONxfh8WZknwpToHv9NGeikmvwE/fc0gaxZyaGD7qg+2GKJfo8V7I2u8dsx787OfEBnu03SIjIZ4z49YM5TmtifdAqViqk/FGK065+fLUNPAuNRCdd98IwiTHDBX4u7XY7Xnsjrtfa3xg7KmK95S6CX/+E6fF7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:56:40.9335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f3f91e-ea71-40ec-42fb-08df35f6c006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018

From: Amit Shah <amit.shah@amd.com>

Newer AMD CPUs have the ERAPS (Enhanced Return Address Predictor
Security) cpuid bit. When this bit is available, the size of the RSB is
indicated in EBX bits 16:23 of the same function. Allow the guest to use
these features when kvm is enabled and are available on the host.

Documentation for the ERAPS feature may be found in the AMD64
Architecture Programmer's Manual (APM) Volume 2, Rev 3.45, July 2026,
section 15.37.2 "ERAPS Virtualization", available here:

Link: https://docs.amd.com/v/u/en-US/24593_3.45_APM_Vol2_PUB

Signed-off-by: Amit Shah <amit.shah@amd.com>
Co-developed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ece2e8b279f..8805657f01de 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9300,7 +9300,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 0x80000021:
         *eax = *ebx = *ecx = *edx = 0;
         *eax = env->features[FEAT_8000_0021_EAX];
-        *ebx = env->features[FEAT_8000_0021_EBX];
+
+        if (kvm_enabled() && (*eax & CPUID_8000_0021_EAX_ERAPS)) {
+            *ebx |=
+              kvm_arch_get_supported_cpuid(cs->kvm_state, index, count, R_EBX) &
+              CPUID_8000_0021_EBX_RAPSIZE;
+        }
+
         *ecx = env->features[FEAT_8000_0021_ECX];
         break;
     case 0x80000022:
-- 
2.53.0

