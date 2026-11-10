Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299453;
	b=36LxTb/H3RnF12kgdLcCVzi/6X2QakJYyHRiqIZ7B+xbx+lij9WBUMubIMQC64OARh+n
	 tsHIOgqX+2jyHEqwE2saYwHKXPqGHuW0YPZgwBwYjSrEuI0lyaTdmATZ/GBG5gAdU4gJ1
	 1b8zCTKwrnKj+TBQ8Jm32oXC7YBmGo+IMvyonp0WQijabSHrQJYQKOWhD9+VhO7s6HpyE
	 4C/F9xswHLDzAOJfOzEMq3ZvcIm2BjocBM7wGzMNJBtPMwkpVhRBByc1Jk6G2L0kaZIjN
	 i9OMGSwdW1ui7X7GifDF8TgbeTL6F/lTNGLJFrR/NWXfK0HAl69hrGMWdrrWdN1kTpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299453;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
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
	bh=KdUCaY+IUutxte/lDEeq5bLjROvNBQ+1yyRKVWt8gCg=;
	b=gLLfQQjPYCP/9zor/e1dFpD0nVVZIA8Xy5r629HSDfqePtLdx1GLMEOmbOq75iKntC9R
	 o/Dk/teLbj06vsqOi+VfGProQ9+fOR8rwAybnoa6bn7cIT69f9rmK1JltBpTjMU4XPKEQ
	 hl0hdjAUpgg/FHOj/i11m6iCszIyyklrX6vvRjTJmtElrRUKAIYcrBpow6UpSImg5HD/8
	 Vv02uIf9NEtOVNFwxmFSdRSEeOea51Qhur1JCJnAfkJ/0OJ0+epOBcDha7uY26wBPNKI7
	 +L4TbBUCawluhorOlMyrsa+Tz6pwQqZyTlJGvMg2nYnGe0mOL+yLjN+MCVcm6xXi+fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q3NpnWyb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.13
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C428606B9F6;
	Tue, 10 Nov 2026 08:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C428606B9F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q3NpnWyb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbCJ5RiMIhRv47KGFg/MLrW6rNPP6oXCfZCp44Sc7f+86re8RZ1egE68MuAk+EjIlpWOdMXQaSh9Kx7I1CpzLa3J10ksjnAHrLSAjhnoa3wKQ0+JjvxgYP6H+ExH6beyXGhzCVa3/4NH2rnJrsaV+q2qZNvP3vtfruqxLny1MFsLTz+hugGj+0pOuoBtl5JsWB7HRMDm8LdQMEhefpEBvhraWaJyDt9nfUxdP8jQ5FlvwhhawzaNA25Yzibv8lRawn9PWZEMTEC+vs1WyX0stOWt8dlJyMipuRCwOhqySc5Qou7tCmeAQM/t+gnSgT37tPTlM3MjyOFWjuTETpWs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdUCaY+IUutxte/lDEeq5bLjROvNBQ+1yyRKVWt8gCg=;
 b=b+1tVpDFM35a7RNbWGXrYP+Cj/p0dGFbDuWemRl+1VKjTLtSlWJiXwZ5UhpzxX3YwZ1Ply/N+ypTaTdZF9IOamdZL/Z7AVLSNXc/PVfH2G+swu6pUytUqFcJJhSwmZtQvoueElw96tUuFHFuiaisCy3JQjmNisTeCNEzugg0xEVCbrmMsLZ/seOEYPiOwQbcgmk687xH9co/W/n+wfSBd2/aNVnydDPF1S20EzCW5klMEh7AK2XtDbf9nQpUFzAQsCJXE6C8DePG589kC8GplBTJooivdMo3Pv2A9FTOrHhYaJ6TezOftn2uvnGPgXat9OCgO5kdu38Q1Z25peK5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdUCaY+IUutxte/lDEeq5bLjROvNBQ+1yyRKVWt8gCg=;
 b=q3NpnWyb6B3ZZqY6vemqKb20+D0Ei4RoeL8WPd2X+7nD6pgXJ54DDCmyJ/tIoM6/u/74rObsqWaO+ZGrK6IKyUayBo9gTJEXosj/aDANxcuZffdLNlHedQbkI+GZjpZGtJpM3nNOpOX1Q1we6tnOPTttz+r5/hEQuFlevr4KZp0=
Received: from BN9PR03CA0412.namprd03.prod.outlook.com (2603:10b6:408:111::27)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:30:48 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::6a) by BN9PR03CA0412.outlook.office365.com
 (2603:10b6:408:111::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 08:30:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Tue, 10 Nov 2026 08:30:47 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 02:30:46 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, <x86@kernel.org>,
	Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH  8/9] KVM: SVM: Clear AVIC Enable when Alternate Injection is enabled
Date: Tue, 10 Nov 2026 08:28:53 +0000
Message-ID: <bb0e384c986a4401b799be2b6b0dc0a69abdce34.1794295647.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794295647.git.huibo.wang@amd.com>
References: <cover.1794295647.git.huibo.wang@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 958bcde2-571c-4163-6560-08df3f04ebda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|22082099003|18002099003|6133799003|10067099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261021123027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	ReGvqXE4dZnnyMnV21Jks9SzeNB0pdZKGhprTSFdeQKuEdO9syYbY/3CcrAbKRyJz1eP1H04vtEZinp7Gyv3Jasr8p2jdY3EmpxgcuCXB64wbXSzNnDmVn616oOVpLsA/ou5oenEj1Oeh1b6dj46/4/VqJ1ot+pPYOyDz6VXKM5FhTjrrgnPN03HW6v4hZEFlDlRWxSgQHaNuzipE2lin0E1W7hARI6qMxTuSMuAdHXKFHeOOknRH056eJcB2DLW4DHmyRRPdl5SZPdjZ5VJ/Kfef5Dcj7XZtuOZerWLiB+NKqHabp6Ri4Nx371FTqTsJdK9HrvFqRfwPRie+GWjirqGfvJhqpDhw9rLg7vzYniReSYm58IbJ7fG72AdMsUhL0T+I9+ttf18sBkPUAQMym/+/i3QlxKuEaFVnvOJDgpLeHPX45WPL0b8mUq1d9aniL2xY3CGQzKcS/tbFV3Prx/j7A2B/eSdGt1x1ZVaN1x4UABiUpFdjYZXcQTslsblF6SCoyAHDK+VkXO2/8IqtoojelfjX2uXmrLO1H87RsZ1Ntgx3T4L1J5lB5wRUbBH7uPFthhdqWj+KcBKqC+wyUhE8tBrP7vdFo1SmleU4NCYC75WYIsTeF40nOUQdMmoK659G68YfE4Cd+FfnB3lnRoiErrqulQJKMr+/pl7UAa1ixw9ik6k+UfhtPNEiSHneWlKkOvQ1LnmM/6zf6wUQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zh5gtOEPJlegXe7brRJw1Jf2R1/EkXAcDndI5CL/bZwfmZ2HSZzQm61Tb4ELQsrEXtZnC9v55kCBRsey3VkPrGY9/V2kzKq8aH3hHA2jFwfvO5zKOYFUOc62jS14pF0yW1efQB3DG2Zx6Zn6FO0d2e/2C/bbGSe3WWBj4+x44Q3KjYTd5JXMaR7D07gZHYFStU803pg6Sudk2ybzm/eLAvlK0k0XpboOH/2PkXaXyiTe3yAo/E2frQsmUl9U9h4g+5lTwhS0NRwFOgZ4/c0jKaqHUF2EF18toJ/DHOxqiwW6kUFBlnAotQf9FhmWtq0sAp6TM/m5lUL5Q1h1+Hl5022lCpOlApEs4y9v2ga8RZFEiJmR1xwxBXH8y3FphRQvLK3q2PKu7u4O/wZg2xSW0hICTwQH1zUrkw6rNBoeGOeNuiNiJtjmezFSFU0a5HgH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:30:47.8853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958bcde2-571c-4163-6560-08df3f04ebda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158

VMRUN fails with VMEXIT_INVALID if the AVIC Enable bit is set while the
guest uses Alternate Injection. Historically, the AVIC Enable bit wasn’t
set during AVIC VMCB initialization under SEV because AVIC is inhibited.

Commit 3989a6d036c8 ("KVM: SVM: Initialize AVIC VMCB fields if AVIC is
enabled with in-kernel APIC") changed this by populating AVIC VMCB
fields even when AVIC is inhibited under SEV. As a result, the AVIC
Enable bit may remain set and trigger VMEXIT_INVALID with Alternate
Injection.

Rather than altering the AVIC VMCB initialization, explicitly clear the
AVIC Enable bit only when Alternate Injection is enabled.

Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/kvm/svm/sev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 019412173062..7846d4ebb278 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5089,9 +5089,15 @@ static void sev_snp_init_vmcb(struct vcpu_svm *svm)
 {
 	struct kvm_sev_info_plane *sev_plane = &to_kvm_svm_plane(svm->vcpu.plane)->sev_info_plane;
 
-	/* V_NMI is not supported when Restricted Injection is enabled */
-	if (sev_plane->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION)
+	/*
+	 * V_NMI and AVIC are not supported when Restricted Injection or Alternate
+	 * Injection is enabled.
+	 */
+	if (sev_plane->vmsa_features & (SVM_SEV_FEAT_RESTRICTED_INJECTION |
+					SVM_SEV_FEAT_ALTERNATE_INJECTION)) {
 		svm->vmcb->control.int_ctl &= ~V_NMI_ENABLE_MASK;
+		svm->vmcb->control.int_ctl &= ~AVIC_ENABLE_MASK;
+	}
 }
 
 static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
-- 
2.43.0

