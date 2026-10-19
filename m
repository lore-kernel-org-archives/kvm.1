Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792444168;
	b=vAfx/YsaKkMWL9WGVuwSG19SeCxJA8Es0fslY/39pD5hmCdzHZsKn3V4eAkdjtvlnKSX
	 qqo2eqgTErRDuabBvAEw1snRw1GN8xNwU36z6bleJMw092K3XNs+XfWaH2QKCQDXIhcDH
	 5jTCej0XBwiltoklwroCh1gnjOyIhZJ7o39ip3+3ASZfWqnXcv/aNBd5d6cp8UluwlIpa
	 5VVUOLW7Mxnn7CVlmjn4Dd815Ga+cUAZMNfRQKXKKygJ8PUOq3ji0eWQWEDjnRTNHtZAI
	 8rbraHc74HtGI0lgACnb6xiv4BogctPUx+yQg7LSI87pFN7HEPxLxAkXK0scJ0YccAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444168;
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
	bh=qfOPIZ+caAUMGz2SU3h9AMcec7H/CbveDgbWwxj1Dys=;
	b=376tGb0pdxPu+lZEykQolaKb79QZ+b5blOw/Sv6SZWyNgJo+WP459pH0SIjp4zEq8hSX
	 2YdrGlAb6zYaESmJMdNtNigTALCfGae2q8KSJ+Xa7tPx7Sf2khE90M37O5qtaVdAI/WvN
	 6ONuGOsYqSw31bKoHw1wUjFzpE9kUTHLhY0NIi+enmy8zY7hJkDFikUS2NX3A1cwbtWCw
	 Hzx8cHvJqSuF4dbRyGeVy0hD7Cueke1X2oCpJ90wDJsxcVIz0pZ56GZN5p3Q/WzZ4B+iU
	 Mcgpp6Wil0qnfdiZug7NEz48dwN23Gk8aEv6mUvdVmfpms3bnw2CFBc+2IOo9Yk2SbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WrIWQ0tX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.12
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBE606A31C
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54EBE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WrIWQ0tX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFtW9viu5dn5JLTRp7KQPZvZu9vPE5N2G+8TRDdx75Wwdltw4pAMJuDxmqgwb2AOB6sdeoICVUga6YOfuQ/XxmWNSq32OINW9S+gqI2IlqFPQ28glY/bATBLOKhfJaelpibCPWNBUkNBImZTrfeAQh+2rOk/NiqIw23WPS2r1WYbj9G8TzRRAmGMJOk8XjDTPg7wFQx+8+qd3M1A9p2mOiXNAF45f67l1aEpFpDPc6HFmaZSlSN0tj8CDc5iTW62nkHZjVvgEfE11FioBfWe+hsFdNhxMhpbxZ1rKbpeL5k+F4+qQWhP5/aojsaM8RkYf379erVICurC3I1XdhMfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfOPIZ+caAUMGz2SU3h9AMcec7H/CbveDgbWwxj1Dys=;
 b=BOJuVemXNA+Mn9Sxv9oNe7jUic+s3e3OPqy6VEmY2+b9V6p86sctGN7F+7jORSZIpl5t1D8ZlAYiYs8d6Y7oOPjmcv3kDbR/ErTwK4AQoZRSVrq3HB7246C64r9xVga/GQnGq94THMxUcYSOddXv3WeXOlWCruF80ACkUb7ch3lkSK07F+Graj530pY3z6uIj5gMjaF/65DiX2jXNegxeiDnNPOeoCzEWM9LMCCVD0tHgk/pjOsGxpvHafIlwm4RppsQs/MMJjv1oTpsE+pAdl1S4GEXD0NQO7n89YEDqddYQM+OvJBTHwMQucojjWts123sv3qOhoIT2T0DSWBKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfOPIZ+caAUMGz2SU3h9AMcec7H/CbveDgbWwxj1Dys=;
 b=WrIWQ0tXUYaghdjS45DvPum7i4mYCIdNVXxXmm+PC0JGDBHzPawXrF0jqbj9BdVLARisEsi1KBHf7NJO49jq5OCJCosGgat4qgucR+1ySjnx9WHfgA3EI5SYv9+91UhD/FtKj30S34dgQoCuwumNn0X0Vf28ddmVyJRRugt4fAc=
Received: from PH8P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::15)
 by CHBPR12MB307707.namprd12.prod.outlook.com (2603:10b6:610:33f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 21:09:24 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::55) by PH8P220CA0030.outlook.office365.com
 (2603:10b6:510:348::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:09:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:09:24 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 16:09:22 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <peterz@infradead.org>, <acme@kernel.org>, <kvm@vger.kernel.org>,
	<x86@kernel.org>, <yosry@kernel.org>, <jmattson@google.com>,
	<thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>, <sandipan.das@amd.com>,
	<shivansh.dhiman@amd.com>
Subject: [PATCH v2 12/12] KVM: x86: Use SCATTERED_F() for PERFMON_V2
Date: Mon, 19 Oct 2026 21:05:32 +0000
Message-ID: <20261019210532.378628-13-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|CHBPR12MB307707:EE_
X-MS-Office365-Filtering-Correlation-Id: 2723c017-d18f-449a-a1f8-08df2e2540d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|18002099003|10067099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	G3zB7/mIatpwEaxSmCZY01VMmPOiW86qGZX2HowhT2AvBzSSBRmjBTBTvgkn9VWvuGkNDhi6IV4PUODALuwvUSohxy1j6bL7nc1WzvWagt/RwhCL5kz99LafSIgWGYtPpurm3WobdFW2y4yXLcghoff0cttgLaMUjeq3ZSglKrvxBRbXUci0ET3a/f3c/BS7CSsnHDUwpz/C14pCb53fTtNosaWBTuWm/xIemxoMFfpoJSfnrWBJi4FV7FdOUnj/UkElRNpNC1D60WsphGp1NLbxJwPlq0M5w43mdgOmCdFilO5DQihaR+IUU1aoQcXe5KwXffiaWJWWuYOi2uB2EhffOsoneW4E76WzaxvF81wYDAppDN/GN+QAXmr14lfhZeyw1I9IF1oENK0Qk05+DLObmJQWHso5+DWxCNAERwqursLxmCoZkWD/JrBhh5OWFdTLsxnAdigj3s0NJFecN2VVbrX6kH7wy82Kx/w4mWvfi9UpiBtHryVHhOAAMTET9iUxFG793otFJVMu07pycdH9sy/dcwg9hcYqe9JIB9myJIJCt6/6fppHWPB54mT2n4jg12+Do70mln4runMTCnDubBQjrAFiPmFxzyMrWjbzE74UFuJDeMd7fuedE7IvmKkZ8ycid0x7Yox3eJrKVKd1cjL5Cj6TYYkfAA6NyHfmYt+AVj4YV8eaJUs8SmXPMF+w39VuuHRtNraJiZV/6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(18002099003)(10067099003)(22082099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QaolSLL7Mv1mjvDg99DlZmhglF/0L4JlgClQU4Drd71U1t9dDNLi3xvYOErPp8vG/EJ8NdICidwfXiS/dYeXKIpkt/GFwmbO9jNNg0vigsufsgzZe+SC3noBPfSdzkR8XNKZM8MdZLCkZn5HjOCRb7aCDmAgM8zYIMHA1Pv5qG6dHIfh67Tw/MWQsUfo9Pji3TLF43lrmmC9l3aAF+WJX2rcZ5/8o6ClOWgd1TMC0Y34EjoDazOqVNPkrivusAXYZ7QYdNKfv0Pv6wb1q65ONm6jui9LPeeQXHaxNT8F9QGQq6+/1coH2LNGza7K+KKYpXFZxYofdeE+fvErQISuA8ZxClLbpjGws2rahKP0RFJGrOutGl880Gg0S1UTaO0dhSH+eKD6u8tybOhmrgn1txAv2kkJw/+/2i3MzGFl8njjHCTDwe1OsxFPkIRCtCGZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:09:24.5515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2723c017-d18f-449a-a1f8-08df2e2540d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB307707

PERFMON_V2 is a scattered feature, so enumerate it with SCATTERED_F()
instead of F(). No functional change intended.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v2:
* Rebased, no changes.

---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 37da587ede71..3d00a4eaf1a4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1257,7 +1257,7 @@ void kvm_initialize_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
-		F(PERFMON_V2),
+		SCATTERED_F(PERFMON_V2),
 		SCATTERED_F(AMD_LBR_V2),
 		SCATTERED_F(AMD_LBR_PMC_FREEZE),
 	);
-- 
2.43.0

