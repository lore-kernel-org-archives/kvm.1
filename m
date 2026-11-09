Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794256584;
	b=S81S+ftWUHzjPSaHLDhJuuPMrc8Be5uVPEfk4jG7Vop4CMxnYLRRXgCWEoY5KRMJy8G6
	 rflho/vRvIu8aclSaCQN/NJ0ba4hWkG+x4g7X6L2LKBPPV9Ur/Qo879NKgy3n6h5SW2RF
	 f4wl4OhU8pGR9y3VfDaxcB9oALUOjyjcoQVxGlNUOJK/363uqwPg5kLigvXyLzRn1M7QM
	 CwXDeE8/OfRL6DcfIaRfpooJDtB3/NVuKS3VFzcX8ultRghRsv2i+NuxQxxEfIuzgv8hW
	 wCO2lUuvgQh9Rhgtio83BmnLVyMpCxtUfgDzrKHn9P3RXCoeCeNlfdQHyz9bQF9gQjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256584;
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
	bh=1Exxypuu8xJGENdHmQMfJH5TvekaATY0Z67Fc+2EG5k=;
	b=rf/WrsybQzEcWOW+iaCol0+670xz8MNO1GGb1+Ijn9skMCSxA1VnGJyziKqscpJjNEd2
	 W0Izg4aduwcOfEZuTg3oYBoY2XzpYPvcn1izguvNZkCkoSczTuqXU045wcPJMpVONtoV7
	 N5a+nrZWKkGpKvsZ4oWiWzj8v5UIX2qB4b/4fAHHkNamHKUElMdeZE6i7syk2OeBgOc/+
	 LlJTR4tFuqK03+T5E5Z7rIdk5yGe4GDJbRZl7/oMD7RTmzHIhwpGfnDC8kS9067JhL1Ar
	 6g9+LRxAYqZ+ciyIH9zA2pTrbO4g8RY6WwFjJGtkTCTbZ+Ij9oQE20Hd+9NpC4vPFkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pHfKfJlZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.59
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1871606A32A;
	Mon,  9 Nov 2026 20:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1871606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pHfKfJlZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nghNQ4Igq3Pm7et0uo7uxqpmjECAGIkhpGoApOAoyqXdpK4yQxNxK5jJrXVKS8JwxSr4GmJMu71gOkMyEMVWp3+EL3UUTCkwMvsjhoGzsX5z3GodY9Od8+JE2gYLcIdRn1H1xSvGn5HmGwGZcqocg44g4Q8wbc0/12grJzvE85dsEcd6N3Th/MCIbbY1DyhIIuRFhGrR3pFZI5PjLmwTDMlyPjq+mrN/QvmAj7+nadim0dKodja+3TT4IJOhpu4umduSblo+wuhhjIUfqHJJZ5UeWlC1Xk6czmemVlMzoeClSwKtyH6D0Znxq4fN35MuCWEzKFyg4ugaMXv9VwQo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Exxypuu8xJGENdHmQMfJH5TvekaATY0Z67Fc+2EG5k=;
 b=EJRYxJ/yhvYA9NRMJmBsWfKlIziM27pENAEGK4YHB/UEtoVjDEQUSgDxfnDMSy83c0Xafoyfmivc1OOwmnYhob49Ib/R7GJIT/AU6spEg9jukSYDQxc6HDuTACAa+DqEusz0WU1syS6kUN7beQxJtANsFD0vgbAyKkofMT7sXjQKTeAQ4ZzgPykErcYBE6bEP+EXPVFSXF79zyVjQKf2Y7vf41FA8GELOt+OqkH/Dv6DGAve2JxkV09joVb5oB2AgCfTXzUHJQqAmdhSi86n8hKUAYxQYvMFCAPsRqWaY34EiXUYk5FHokG3Pk5W54Y6zV766GV69oZUS2fvqmGE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Exxypuu8xJGENdHmQMfJH5TvekaATY0Z67Fc+2EG5k=;
 b=pHfKfJlZKhWpdqtKHd5fT3cguO4C9omih0mzykzgB1grGi501nJfC3g08Mx/VHbTlnEV82Fb/MaqO42AQcGP+okYUQsjCWtTKB1WhwmSjYkkwlPf2Y+fsRsPoVTyeVzJxTcGtVHA2mrdaaU/VK5iHDNT5CVxOn/SEFd2uqnvlrM=
Received: from MW4PR04CA0136.namprd04.prod.outlook.com (2603:10b6:303:84::21)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 20:36:17 +0000
Received: from MWH0EPF000D8950.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::9c) by MW4PR04CA0136.outlook.office365.com
 (2603:10b6:303:84::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 20:36:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8950.mail.protection.outlook.com (10.167.249.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 20:36:14 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 14:36:14 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v4 4/4] x86/hyperv: Add guest support for Enhanced SMT Protection
Date: Mon, 9 Nov 2026 20:35:14 +0000
Message-ID: <04910fb1afacec52ffc078c341ed17e47e5bffde.1794244450.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794244450.git.prsampat@amd.com>
References: <cover.1794244450.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8950:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaf7380-9112-4212-fc9c-08df3ea11988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|261026140227099003|56012099006|261021121427099003|261028144727099003|261102123227099003|10067099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XUAX1haqtAbjKItfiHVOeSzVFDsNRYX+WMHQCesXk+l7of/FabQNQxec9HoU/0wTJdyduPsQLX4p8IuThnIRLerpb/pkrT0pyf4pzWVGW0LnfJJeqQ9XqHh4UKT463WXiiIMTf6ZbTuHBa12L6n6+flDsNSOF5jzkorqVwdm+HrlLz3eWJm3pCggEfMW3JLeAK3Cll38ODrR8ROORXuT+eu7HCJUv+ReArtitvE6EhFK01DrOqwtBYui/7963otb/YfmG9kjRyLwCd/c7rB0c14oti60DbpX/J+qhseh3o2fhLVDHRvvDkc9AddXkUQlBV00omyll2rE5WVMHL3tkvjZte2wMdd3Y8HjHlHn6u4Ms0kzmFqYIIE/oWLbJ9HzauhJfSCoUxyiGHR15aHoim1xNX+aQjAnynpSybEUEsFXprqYPwSWQzNBx/iqIx9BL0xU3htMkQhh2Ah6xi3IvfA9hRFsWLSRP1UBJxgRWVyVjjAVzF+7V6Jr1DU/MNM7Z2pLxzcGUSE0wtfytRpHtlvIUIQkBoXs4yFX3R6dcqb/ghQXTxIifdgYsPP8DDmcMyFRYinJpXvIP74tjRLPMV7ECWS1r7sbJ0gSwMV16VED+bArXejYytIOK4vjWFHWsTU2PRgwqtgALdqf6y0/cMqBnW0Hf1Vab2LYNjZ8u3nbusb2iI48T6o17rBiJqC2KCWy9go+0D1quhWxdzU71A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(261026140227099003)(56012099006)(261021121427099003)(261028144727099003)(261102123227099003)(10067099003)(261022105027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ax8S7JoJwZ8A76yXGreAk+0WsSq13AlKDdv31B8nqNQLGYMyn3JWzS/ecwnpHgJnYl8jr6McotsKMFCqwxnkY5AmP5qX0Sng0qLyk+G2SE2HbmyT3hse8nkXDRXWp4Aj5DP1KM8oXYJwh3wiFFYm2fcciQUscjgkBWCIjuRtqWSssWw71pKDKbX8JlNAeIvRJTa+gg87nSXnQxvipl4FuylaFSLvr2b783u6KSs7bxCDN54UU6+owIN6w0kqHLAkaYYbqOD5p6yqrKh+iss0LKiHm3KHhKKV4wtJG+fe8SgFFTWwVtQHZSGjb2r1KkMFvexaea2FewArjlKN9RlhZm2g/fnoqFCkXsFq3lpuUoVxd3xySKGCLnxq+r4QmMbon+ZgAFdpzSVbDQX3Fkis4OIGw9LUN/DA9Hx19bwDK8M9aHJ28QU8Cc5cjTsRcF9G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 20:36:14.8198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaf7380-9112-4212-fc9c-08df3ea11988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D8950.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

Add corresponding hyperv support for Enhanced SMT protection. A fully
enlightened SEV-SNP guest on Hyper-V builds the VMSA itself when
bringing up an AP, so populate both fields there, before the page is
turned into a VMSA and while it is still writable.

Similar to KVM, fully set the sibling mask so that all threads of the
same guest trust each other.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v3..v4: No Change
---
 arch/x86/hyperv/ivm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2ce4dfe53472..40dd252f333a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -347,6 +347,17 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 	vmsa->vmpl = 0;
 	vmsa->sev_features = sev_status >> 2;
 
+	if (sev_status & MSR_AMD64_SNP_ESMT_PROT) {
+		vmsa->vcpu_id = apic_id;
+		/*
+		 * The mask fully set puts every vCPU in one group, so any two
+		 * of them may be co-resident. A legal ESMTP sibling must
+		 * also match on ASID, so the sibling of a vCPU in guest mode is
+		 * always either another vCPU of this same guest or idle.
+		 */
+		vmsa->vcpu_sibling_mask = U32_MAX;
+	}
+
 	ret = snp_set_vmsa(vmsa, true);
 	if (ret) {
 		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
-- 
2.43.0

