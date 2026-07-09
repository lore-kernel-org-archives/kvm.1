Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD963EB11B
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585901; cv=fail; b=Goir8cyA2ERmuU0pXbWkR6uy+NPCCl9NXvq/HXynym3OXUm+WsqXN5cDRssx5O7JtPFlA9qWmnIVuqudOiRAg2GE76d0CZWGXsIr0yqS02vueOWanBVIt6TfTIRlyY0W5cIWChiaeEP5nDc8Tl75Z71H4SRkGP02ozp+k0XNQJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585901; c=relaxed/simple;
	bh=ChOEfilWGboTMpyEHD0LS0/1Mrptr1EknCA5n/LXMTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjWp4e+VcVXsTvipD66uny53dI7sfL+g9dpBh0gtylVsgBXeUnUe/8iSJmGPBcPxeTr/v2eRjM33kPFr84V9UTCQ88CNtpX99e3WCpiAZ0frtfAzKhOLELL4Q63mhAJWNddrAIQHoCWiUM4qmpdq9EGQcuxqQjLAxCABhTgIqC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H8qxfY1Z; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H8qxfY1Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/RcLJHgT57hi2HBrLoR+Zg3PclODzl5okoj95zmwVCGgJHw8feUV7hIA2oZ8nCS/GhD0ly7Hrm1ukEaxH7dC5IDOCRHA6qQctmb5P7pA3Bb7CKS2RirHP7q2p3tDUHPCOPnksZTHM8IZBp6RzZvECITPuSgNWOfeeYu3H05VFhcegaiUhn7JofYtxUJgy//eJOssbty4r6ZPwxIJUe3FLi4ydmL6cAyrwzZaFvb9CuVJCzmvY7ahELh5S79vUP+IBR7W6FKkxRbx/mZUTDO+9WPi2Z8Nx/whygvNB1/P1XevPi0qyJPbo8VlOLKRN+f3q5s12m3mB3WiYXnccFQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iOs3+a4pya43QckjxndXrdt89N7op75QIkWyUWB7gk=;
 b=Sc6l+Tl6Ey7+YamLatlbln5a1B0FVM6z1DuryhEAJzrVUIt2921ZbMKhZTD+6rSuu4RFxznrGTiLmmSPaU8zku9lHCqxSZOU75xYvVuHjHUQb0ziEBulkk8nbjmmZJvsEFUMeQbISmS8Kb6n0D7LE4vggfqDa+RNO8sOiFjzj4wNjQDHiY9+3fJhjOx6KdXivCVBx0TaDs1utN+y1B+Vx+c30feSCwTulY8bd936yiVzM0/DdnXf7qNdHGZ0XOkhuwKlCiK+TCx3CJK0ezhgLZU9+XVMaAddYmThc5AuwpwwhbWgrlwZ703xN3JZ6IKIsDL04ldp1odFJ3FpNlmRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iOs3+a4pya43QckjxndXrdt89N7op75QIkWyUWB7gk=;
 b=H8qxfY1Z1ysxD4ZEoCIlU3g+ViOTGunCnXMZFxv+pyPZocLx37r8/WCAgBg8yvp/JSrPk6RkfOPXcfo72i5Rax5AmKGEA55NU6eZiokpk9Qq2a6MU8pZAmSMaZyqtCjk2hF8C6RAx2nedYJ4PtAJ1D1ySii/t63oGOPFw9gd+HA=
Received: from PH7PR17CA0050.namprd17.prod.outlook.com (2603:10b6:510:325::22)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 08:31:36 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:325:cafe::8d) by PH7PR17CA0050.outlook.office365.com
 (2603:10b6:510:325::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 08:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 08:31:35 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 03:31:32 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 1/5] KVM: SVM: Refactor svm_update_lbrv()
Date: Thu, 9 Jul 2026 08:29:49 +0000
Message-ID: <20260709082953.69434-2-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709082953.69434-1-shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: ea06d8da-5000-44bb-8cbc-08dedd947d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	p0aC4t2vgtrSAdGDF+DfmOyw3L0SZxHgD87Bdi2eThftVP0WaQm7Q6ftu92YsYMKV3PWikWynoAh6ooQZIsM3mmwq3j01bknnJpKJbTt7K1A4WNhHMKITLThBj/Q1Mqc6ZSERq5Z4u8MStsTMXLeXCnCnPshkShphQ86oDm2Oqg8OUJfAlsk9+699FRL5q9c4LB4rRfITl0EE4IBD/l9ck80YkcTbdc8R569RKS66ok0xnCH9ij5vtryq4BFTlAKIL6g0CrqwXszGma1QkZx2tTvAdQ2GMmuUF5gJ55ner5QG7jUgyCVV7CFIJXSd291IN05/iZvx5rXTk3Gz1hHjb1oD6lmlyHefhO33RDIOjbSrwRa5qB84mEQeeFGBydzYrwepc5gRj/NaW4Gp2biL3LZhGRm1VJl94dNcmOwHA96peOJoKox7kJMDQyaE4Hc00Ee7NHh5cl/MAWLcmnmdmhTKmiP/g9eo127yC6Ox6vGYzxNYgyHnYEZm76GifeaoavJEJePqsafvgIaLTNOmkj1HOPWh3//tQafnNiQQWGL1CQEAEnCZB4bNYZ8Nogz6gcNlh0DyPt9ujIi0bTJzjvYUJzkJFrZD+NWja6c6FZat47S4Ns9ZWJb74LEJf5fKEF9uFM+kiBDKR5P5ZZLuAViSkPHs6FsgZ+lVgcniasbnMpHY/DsD+mBG/wEtU4+Egtib9Piw4BgT62i7J8mUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/oi8x9J9ZPB6ZD8iAKvHsW36NB5PdUEqMczL3+WnbQ0h1/B5WANl++bzSz5nfLs27l3lwv60QYHJ88Lwv70nqbWT6YXRQvhxbJLqt9kiNq2tPPIIbPvsFv3y+y8SZHPk4nRRDkpZP55z+rWjfSuAeR9FeTEQEUG0oMBOz+VT1zVKZV71NyH1soKCyPt72dCyUIbbkPWNSX47nuQgVzdtH1gH3w4GVMV8oVtMvyTrG9TQCvVoSKtGfRnQBhgl9AuA5K+7FQNvra/Kl+VlypT4NdvYXooCm6zs/CHiKpYcMFs++OWyPWYUY768OvP2Ga4csmH6eJZtKcyWug3V1l99KQmtOP9J+MAoByr1xUVUSCMrashtyaYVx1NfYS3+cpLpghlHr+F57ErHjpAFnpekaitpPdJD7FU+X7w3iBPj1tBo7+t8CNYodHVGckoGn8AR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:31:35.9663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea06d8da-5000-44bb-8cbc-08dedd947d57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362

Rewrite the enable_lbrv computation in svm_update_lbrv() as a series of
'if' statements, and use nested_vmcb12_has_lbrv() instead of open-coding
the nested LBRV check.

No functional change intended.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v3:
 * New patch.
 * Refactor the enable_lbrv computation into 'if' statements (Yosry Ahmed).

---
 arch/x86/kvm/svm/nested.c |  2 +-
 arch/x86/kvm/svm/svm.c    | 10 +++++++---
 arch/x86/kvm/svm/svm.h    |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c1485c3e691c..d3df6b22bfef 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -736,7 +736,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	return 0;
 }
 
-static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
+bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
 {
 	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
 		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f..cead8f99d856 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -880,9 +880,13 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
-	bool enable_lbrv = (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR) ||
-			    (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-			    (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR));
+	bool enable_lbrv = false;
+
+	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
+		enable_lbrv = true;
+
+	if (is_guest_mode(vcpu) && nested_vmcb12_has_lbrv(vcpu))
+		enable_lbrv = true;
 
 	if (enable_lbrv && !current_enable_lbrv)
 		__svm_enable_lbrv(vcpu);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..8d77c10cf4f6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -899,6 +899,7 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
+bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
 
-- 
2.43.0

