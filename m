Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B7E48665E;
	Wed, 26 Aug 2026 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783779; cv=fail; b=By4NhAq/AiDM/vgpcwwqcQLZlhsK8KzkeLrA9gpVYTyAnMUXcMoS7DLp20qtDZyVSKGkkt/cd4PsX61xLyXCML7FsTkYHhCKGgrrToAnvIgU2t6dJHI7NJE/uPJmm2fZ19ZpR7lsjdx8FOpfP5r2YUf+GFAMhnQDup8BLkeBGNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783779; c=relaxed/simple;
	bh=vcOHw70gqx1utuf+a7+PmYUbcvELyPEmzScXy7/i4VU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yc5A25wPjUplJzFsQnj80Nr1AydAry6w6onJiA+c7fSm2WMuvy1xn6hoGA1uVE9H3i92mu2n0ANULiFrDF3CHGeG+qLrotw7gEZ8ClgZus4LVVfwt9EfE4Kpa85sT2aLgaHZfmL1SMJR9C8SI2hIGcvb3MnIG7fQx200KkCjw+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XVRVh95F; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XVRVh95F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXSc5Y+JwFXo8PSDdH1yq6p9FoFs/FLLskvWTWVsoQuURnnfxBwB1BFo8nuG5h6naJZjPbxd8HJ9Kxbale08rUH2UTBr8EgHRr3pJgvRglOLmjBcysbEZAZDdz3VfaduSFzFSx39/KsWA3FY2l9oGVOfBH+v0i4r8z+526JyW7HJc8AwTlUO0EcJP/ys485uN7+1uyJjhY8bfP8kwNw0HSYzgZcrfu2CsJKeZuY5ar/EYElUmSgqdW+g5BX2hQLjAOpf7/1o6BIeJeWyksUsWRpyl1bey+6O5GUpLNghm9cv/tWVZds3dIAV23+cuPxToZ3ko0O0WkiaKEhmyioBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4zLir7r4cUE9wikPfOL7fM/empip98R+ra1pTfITR8=;
 b=OIDDJfQRUnCwaSW0J/cdZGnTKkETzjkbms01ps/bAGjkDiahWXSMOQcHw/6yOAoSNhaENvLfytqQQ745Qy3KorM3btM57lORv1bOntCL+Cr1TUQ0q7AyVK+pE1T7RkXhG3r+WNSE7UQFYQ36nmDWV/UMcMJrfSszPqqyZHrHgQN5T5URKRVlnCCRSTxIWAX2zJjnSUk8SPjJXw8Xng6gxBlLeztqNMR9OGo5c6q7RI/HGwHcfqsVEjwlgltm/H/9q6Xu1ofpVc9U/I+JPQHvyv+CM0sP9Q9ZS8Z0lnK6mUYMKrkeeXjTb7b1UZ4StreomVnemxDYku0pk0+USCxM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4zLir7r4cUE9wikPfOL7fM/empip98R+ra1pTfITR8=;
 b=XVRVh95FueSM8J1dq6UXcO//SPAzOEstyHmUj8fmsp9iViXtXHIhO/rRhnAgD/TbdMw1LKE0kXS2ZOG46eblBK+zgVeSbvfS51m/IZrx5DU2UC7XgassuwTd8FclV5A2lQQkufSnwRL+zTC8F4kLoaMn3hMX+y6P0M6wmy68uWw=
Received: from BL1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:256::10)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 22:36:07 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::2e) by BL1PR13CA0005.outlook.office365.com
 (2603:10b6:208:256::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 22:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:36:07 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:36:06 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>, Nathan Fontenot <nathan.fontenot@amd.com>
Subject: [PATCH v5 3/8] KVM: SVM: Define SVM_SEV_FEAT_* flags using BIT_ULL()
Date: Wed, 26 Aug 2026 17:35:05 -0500
Message-ID: <20260826223510.3669875-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826223510.3669875-1-kim.phillips@amd.com>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: c259622f-11fc-45ce-2d1b-08df03c26ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	F90OU/awg53ZLVnk2RmbyxhpUAMAyAvTEOtfi471TjgunI2fkIlc2l4HwZ48cJ5G++CzQSTPzdFKrT+SgtPUGX7Nj1aTkVzUl5ZvAIaFTndznVsdnyT8oLSHHKeAqNHn4C5XDg2oUVtGigpUn0a+Rf9UAGm6A9fpt6TUETBybWF4KMDzPlOrucgzk2Kmp7vTIsTaO+PwY7DcUkWGlkK/uHnXQleSO5UJYXUBbtKPNTly6bC/Ohn6VSCNSe/m8tUU1lgWkazx5lGWit7dlEOsa9Rf44e4RL/nEaDAiR2RdHhFSFeZ0k5iEQ6I8L+/Qd0CtA5btbBSZJbkqR922DpYzvrVcCCCiRNlvEItuUrq60ImT+1je8KW+b35B/N+E07ATTgq5Igp+AtOcLutaIhdn0vPLTErivfcQjKyTW2me9evldF+GU9KbFGlN8NhxcpJZMFcNyrniyurrIY5RfWCSTBFelAVeiGQ+5Ustyi4hl7/1MJrQ6TzPiI6Zhuv/SgFpwY2B3fzuUmJZnUpVOfgzI0/ZSS+VpG2FGKOcL9XVVs2ugTl3ntHdZ4inIrpHCWYkExUbGriyFUUkCp1NQRNBG4FzKfMMXQ137WJaSsmOoo1Tkf/Jpc8M6m3BnpP5Pwo6Hu4MNo+EEdt/IenIFGbmkm0fcumpkUMjjTB2/owiHhaUpltXmv7CqJCmVEpbnKa5p7Z0xMDdcMO1iBrwR11iw==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RF0Yf4boEjviSObrR7Dww5pqhFG7D4dJv9vLdAaG3QUIeRBQDOfBThkPrfwVOjmjXakN6ssfBzL4/r3SS3JMgn7XttTePe7MvfT6yO/vZpMs/fo10IRwZvPyCPcIZH8syv3c4TWIAXRXLMshAD4zustrYHE4ikEXMjmoMQaeZuyWLvWj/HEltzhWAVN/JScq6o8SQIQcJL8/ld9EFcHnP5I+XRZCowsiPhbdUK4+s11Wf4tfxos4AHKGzXiAWVfqACP1q0zS9XSi8Zgk3Tg5kukaCgCbThFHKzPMci5TJToiJAg35IX294Vn2nTHkWmre7YQW2Vv+UEAumWe5tO54Y/vaJneM38dzeSdrl+VrEiV8DHLPolcKD+wwPjbYx/2iHf/eSbDcnmss+IYHfVrks0KEAXEElUMoyNG+cWb6pzsp1D387+NgsiKCHILX9DU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:36:07.2985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c259622f-11fc-45ce-2d1b-08df03c26ba9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704

The VMSA's SEV_FEATURES field is 64 bits wide: struct sev_es_save_area's
sev_features is u64, as are the VMCB allowed_sev_features/guest_sev_features
controls and KVM's vmsa_features / sev_supported_vmsa_features tracking.
Define the SVM_SEV_FEAT_* flags with BIT_ULL() instead of BIT() to match
that width.

No functional change on x86-64, where unsigned long is already 64 bits and
every flag defined today is below bit 32.  It makes the flag type match the
architectural field, keeps composite masks such as the upcoming
SVM_SEV_FEAT_SNP_ONLY_MASK 64-bit, and avoids a latent trap should a future
flag land above bit 31.  The adjacent VMCB_ALLOWED_SEV_FEATURES_VALID
already uses BIT_ULL(63).

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/include/asm/svm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..52c900bf7e20 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -305,11 +305,11 @@ static_assert((AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == AVIC_MAX_
 static_assert((X2AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_MAX_PHYSICAL_ID);
 static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_4K_MAX_PHYSICAL_ID);
 
-#define SVM_SEV_FEAT_SNP_ACTIVE				BIT(0)
-#define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
-#define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
-#define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
-#define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
+#define SVM_SEV_FEAT_SNP_ACTIVE				BIT_ULL(0)
+#define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT_ULL(3)
+#define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT_ULL(4)
+#define SVM_SEV_FEAT_DEBUG_SWAP				BIT_ULL(5)
+#define SVM_SEV_FEAT_SECURE_TSC				BIT_ULL(9)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
-- 
2.43.0

