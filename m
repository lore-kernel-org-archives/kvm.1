Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A029B8E1;
	Fri, 16 Oct 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187707; cv=fail; b=Wf/aF66AHimE9entK7lVtx86gpQakaQCLjp48Dwts8B8f7lSXVjIydaWOCmscwN08ezmASgxH2akSm+gWfMxn0HV3EVJnFVKBJTaKRbHWsv3t5pZGa/d/sIuEiyPP2iHxvC0C6COaUA+y4I2IKtXn9/HhAsR/e2tYU/BGlFTkYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187707; c=relaxed/simple;
	bh=bZj6WkONFM+KUsC/Veop0Yei4CRWbLkmd7ybniniUlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FW+WD3QR/b1hsIgjpNDeFc491wLilGyiCvupbuvqy4bQ+zWUy9IroyiARErxzqAQRFURU1uQbqcvfT3wcpngBbmZ3iAGb3Da7ha/3rZvlXB+a0vRnRpfpsG4j1KmuoyPBS5Wj1rgu0PO0UPxmH6PLDS7idFZy5bt3UlfM+DAguY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IVHW3H+K; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IVHW3H+K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2XHUVrL62zWrmJ5MPttR8Zu0hhuDidyoTve8C5uMoFTKGxfooV8rCzBg+nT6lrx7Y+6Arehq1Dvnp/P4tvb+rBhCL8TCFrKeslhalHwMLxcfpd/ddUc8ffzUqUVemse/Xz93+ziCfJBBuMuuMZh08tEJF477t5FGBjiYEW+Js29Mn9McFhwvmDlso2SfNc64tkOB72AhwKYEDuB5IE8h4T3C5+2AtCCAUY1b3N+2ald/IWLRBG5ZXXPC6/EGsgSI31icP8gKwECol+HHeU8REmh876GcX+3dCY3JGXtzI3DIRiZXBIpb9gLdvp+GRQYQds+t4Slf13zjKGGdyBWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cuFSVmfnzvVwVCCSRlrPPTEj9FlaSVjyYWOcq7irM4=;
 b=ISLoeh6ZYFCKBlO3RmhwZauV4RRqptraInVMUT4jaT2lZxVwUcm+1CKm1fEbGOioC8uH25509Tpvhn/k6dMi95HkY+7aEe7Q/e2R5Rz5BahsTDd0h2/uLPJr+JqG6hfSRwroi1JOYZQH0tjaqz1iRIBZ/N0Idf6UxZ0mxt4XFQjMl9wnSXNniIgu2nwbO67g4bzM5AK0NjsebVkzzc8Ad8Qn9x+Uwe4vNLAI04DfGVe2ICh5XZroC928fpJ/BuR04dfPdI7lZljCUaudLuBBbXwPoqQiV1KAySLHY3hTDoNhjPIAKXeg7dLAbnpwXizOWyUF3Zafkkr6j8GlMjycTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cuFSVmfnzvVwVCCSRlrPPTEj9FlaSVjyYWOcq7irM4=;
 b=IVHW3H+K2UhB8oy/kdxsafWDxbx/FHwXlWYS6ZCiA/6iQT2cv1TorBhAP0W2r+GhvBeRr1qkGM+lMOrSCS/OX5G9eqjI5GO0clq3K8Zk/mzSrv9detqFAwfNXYE+S/SNDn6jtiQhQPAMDJiJg/KZrZcgGl3nYvLuAfyv5gvjVD4=
Received: from PH8P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::12)
 by AT6PR12MB255547.namprd12.prod.outlook.com (2603:10b6:170:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 21:55:03 +0000
Received: from PH7PEPF00000007.namprd04.prod.outlook.com
 (2603:10b6:510:2db:cafe::a8) by PH8P223CA0006.outlook.office365.com
 (2603:10b6:510:2db::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 21:55:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000007.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 21:55:03 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 16:54:52 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v3 4/4] x86/hyperv: Add guest support for Enhanced SMT Protection
Date: Fri, 16 Oct 2026 21:54:07 +0000
Message-ID: <32abec5508bb39420b713e3960233979a520e4e9.1792184487.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792184487.git.prsampat@amd.com>
References: <cover.1792184487.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000007:EE_|AT6PR12MB255547:EE_
X-MS-Office365-Filtering-Correlation-Id: b2296f63-0fc5-4714-cc16-08df2bd021d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	uMa609eOENguS2X8e/eAQCN2lzKYN31uF1uf2wuqb7SSQAliCKWlUjynIscDnk6xTnM3J4LdZWV4H443Y17vmGUWF1KaB6zNGA0JpSNw9CjNRb1rTqM/sb2g1kXRplFc3ivcabfi9ipVAZADc8G9a8impzS6UmXCs0wmAKa2sLvMgzvo1WwNgQNe9qnIQbsH3w/JuQUd/3FDvB9dFGvs2n9U8ALOxS97irdDvOPU+2DU5qNsnL8jzjkJ3rH4ddpHJJZh1Ro+Q+5VfjHmC5fO36CWS28YP1GxDt0H2O69IQABgR4JUEhN5hKzeou3kvqG5n7ujEQCH+YcXl8bN/mpmQd8QUQmPLVSsjS/yI22Oam+f8UESQ4LkyBUXAs76f6GTeg4+C5PPeuyPFsNTkoi92+tcbOrKuJP0SrnWl/h9XJtg/cHenO0jIpAqPbZvyHP/XhouOT00OzBIrjOG7jZ46XCDk86mcbK/Rkak2Xa4elxLtposyAKWmJayZOo8UeeOn9DoDBTNatZihjZEghwFrxXveYN5+dYtPrGVpeiWDH9poPaLeeZpccodZpfhECvCo4N3Sas9tZJmKHzq4UBb+Nvj14LELPs4Cx304K2jQra4pPvlYbmExQ+2x2LK+a21I9GmNsT0iFs/+HMb044kN4d1zJU5lmwnPApZwRZPIegKgbZDJarmVWRUoap+JqDXOjSXDG/OdyCyygy9bMR5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S8d4I2RiTOAmtvCwRNqlLTKymq5SKqsL1eAUyCqLuWOc3BmcAO9DiZxbsblr4cZrUd4FVFUW2I7/fbvTVfg4LZf1D7uw1vgBx0qQo9TYg0T0S7Ojvttm5OoAIh41WS39iz8PZrFH4iWrxpuhYdIjIPYKGJBdw9fE3VXO0gQZCUgNnupTlse65NfWgi9FJV03ZGTWJgegbGwsNhCoGkTtrZtVJIzlAK89dANO7JR9wczaHFToh6kSmrP5PRnidgjYtfp71E6Qk9W4/OHzk0JRRYtTVFVs8LhxjwRjoqK0OCZeN9ob/TdyMMH7/2PA2Zqjdm8EF6g6KcPOUxfrgRLHo88TGTAka3EvaACeJWnWxTLK0XSkCqHroGA5cKrOJXcUcsuYKSl8TwUPMVsew/jcm+292JqHAqKiduQjRioirR/c5nBtEaKdodNokJ5h0eDv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 21:55:03.0151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2296f63-0fc5-4714-cc16-08df2bd021d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB255547

Add corresponding hyperv support for Enhanced SMT protection. A fully
enlightened SEV-SNP guest on Hyper-V builds the VMSA itself when
bringing up an AP, so populate both fields there, before the page is
turned into a VMSA and while it is still writable.

Similar to KVM, fully set the sibling mask so that all threads of the
same guest trust each other.

Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
---
v2..v3: No changes

v1..v2: New patch
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

