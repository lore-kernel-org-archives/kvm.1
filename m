Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0329423A9A;
	Fri, 25 Sep 2026 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336642; cv=fail; b=XDsXkTN6esIl2/KW/9U9c2RbwrczL1FyQmNBg1AqhPsLn0/xxmMjQtDtjtStq2ec6KggDUsDJwkuKRo8yb5Z5DZcesK6k7whNtr8SHqFusf6gvogHIeRCD8P0zKeUS0wTpYmkj7WxNRSnH4e9gC+iWivZVOIu127nDajrIAOErQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336642; c=relaxed/simple;
	bh=JZpJU5V0owtd+XCDq16HdtfPRKH9HC5dQ2D6XtGTO2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpxOpSnd3NGpnnNVR8w9ZhRqooH/mS3k5UahrZNCe6M1Ow3iANrFrFr1mk5kjYDgPTAv85a7JmJpUWryQL5mLcNabpDK3tiL3RaV9oBP73l+MTSuMsIgSEwYzBhVdzUDPJ/hNakVWLTU6P0MSx/K3XrND3ZrGGmkpKnv87VbVL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3h9IfUvc; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3h9IfUvc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDJWbsbmj107EHUxfUgLbveZwpD0qLuSqsMnAnnuoobEnBR4CJo/FLuoQEfcUbK3Ko6rSthvisnHPkG/smbpHTAS90bcinHwsyGHINuolog3IZcpNmqBA56QIameRkNQmP8/SMh6Eza4PMY8cQlnSqd2KMerzSsMwjVxqTfxSckIBCBbAH9LS47Gx12aFJMIaYjXXw0McSuBKwDy7BZ83XZzqfvtpi1Fu9B5v3sT72pTRH0eYrdtcYkr/sRruPU0N0J+P8E3KtEUUxKSzVIHl4S2gCRalqmKjw6hH77aHxGeMNslw2nGyg3NSyvCUdPlPoDNX2DzTN3XnXfoMxBpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3giTaEag7Jt0NoU9jm5pDEcztmFiOriZVaOdl0wgk4=;
 b=psfrjKKi1qt3KWOpRw4OvLrjt70d0HvHWyysuk6S0WY2kLyfX8zsm6jJg/mCXH3lH4MjqyVlMvWG1Ll9N4c1RC43k0dKyZOZDTIJAIM/Dw6Eg3suHahwPnjX32EkyNGinMM9eI/W9SiCe+vUbj9RK5oh58i2hPMWlp/SqswcIrNOwtZGwB2eBWSfdisocqjODKAnAIJDzJhlF1z4Hg6TrYzidK/z0n6jmJ1XCHtAq5eBZ2jumc040gs7jUDryTbBNkOQdKvPxmRTegFgkizHX3tz26qP/JxMj2OgCXke2WSajGD1EkOUmfg6fB8PrdNckL1vVMcHa7cJ6KnAptRdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3giTaEag7Jt0NoU9jm5pDEcztmFiOriZVaOdl0wgk4=;
 b=3h9IfUvcNWFYNpLb/Xhq+LAk+0xyZrAV397ifmS0Oy7W+wh6X0XxjrChrYHSMFZIH4M8vaYkOQGsd1np1OxJlQsCaMTLM3cp3WpIBQZBHvNLRmUG0cn52loVcZTZ0ugcoOm+R2iQCtuClglKLa26lGy5b9/kZ45HJTDHVHRpzP4=
Received: from BN9PR03CA0585.namprd03.prod.outlook.com (2603:10b6:408:10d::20)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:43:52 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::3c) by BN9PR03CA0585.outlook.office365.com
 (2603:10b6:408:10d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 11:43:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:43:51 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:43:46 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 4/9] KVM: SVM: Add support for saving and restoring FRED MSRs
Date: Fri, 25 Sep 2026 11:40:12 +0000
Message-ID: <20260925114017.2208531-5-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
References: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: c99294b1-7fc1-4205-637b-08df1afa4580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JG+sx65RSaijzLEyh5neLVsYD4WTYEw4CCOvOop3zGneLOmKoLdz12AAZpsF3t9ALOdelJ7pbdn01I4OQmVHaX2UyuIRbGlaeofElCY2Pr3FNVdK4Kgk2/Up4nlsBMUrnNZR7aX9YvpDncAm13SrvmOOrork21gr1E0/PkQEDIo8CRFPTDMnP7nsCN8hPeqvxrzTvuIoIzlZLZz3nj8bJ/ChyRjlu1tD9lKp+9bbjFGEHpr5AjE9UeZszrjnFNNwp1j8nrqxdvJqDib7UW0PTqNSj0nyvnGBCyLIl/ccBnYRzXl0+3CSHUbyRT+T64mTaoxnDRX+ESXUPKd7RfyUdiipfl+WJuEyIKe9BOEbbjrBd7ST13b6QRgYUXJQynjvKfjx8FgDTZ/ERuKEjvReWaxONVOznmLRMRnzqCzGqL2+2qLX6v6OiOKx70Cd7/FPBSGDJ10qq8QS5XQ0TWOgUw+XYXcrC/60tFsaCJL8N/NZ5R1YsHKjkUIPmfzg3nq0zej1as4MCUnjgt8+pBUSgVXt+n4nogg5eWHqHV8cx3RwbeapyDkNeg08DQUGrXEYdBeu1QUP6AKx3mPCPFmBc8nkZXfE4SGk+siCWETQqvXMCRpkl8JsAR3aVx8Q1HWajPO+SQBw2VE42Arq7H2Z/QQCXa8yOc7Mv+Lb2nUOWVB9JLML9O3yfwSEZhxWfNuMJYwxyCBvxjNDrx0HA95wOA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wler8fDYrvoWvSuU5JwY4NMCWhr/ttZgrKne17RBgO1WN0gj27CVubrfqCRcTHhxuHaoJ/qrTHWXDH2lTZJHo7YvVofd7t6hkXM4inrYgcjVBWjKr1ki2WBOFYna+WFKBNvs9UmhP+h2cO4YE8X2hQlE7GIxDNo78n+lU8zcnAX+NoeU/85JtJrZUG5WmaoOztkT9YRZ2ujyxNFlMfqIrh0mbARVuzRyTsmoIDATERx5X9Uf1Fff46hpch7BRK2uec7bYMZjDoVQYiWcLrDo1+8MNvLMJ5FYSJ8oPQrQMUzvGSYZ5zRAVfNHSfVW5XjrBcdrJkZRLLqDx7KOadreRLBO5pedLvNxTm1Cq11PhLyd+8kR+cRlzKntw5XIAYztVhk0n8FU6/v3mreZme1xEmQCp8T2PCUTVIcZiYVpGVa7qBE85KwA5hLWClHxk3di
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:43:51.9654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99294b1-7fc1-4205-637b-08df1afa4580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

Handle the FRED MSRs in svm_get_msr()/svm_set_msr() so they can be read
and written by userspace via KVM_{GET,SET}_MSRS, as required for VM
save/restore and live migration.

FRED_RSP1..FRED_CONFIG are backed by their VMCB save-area fields.
FRED_RSP0 has no VMCB field and is served from the KVM-managed cache
(svm->msr_guest_fred_rsp0).

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v3:
* New patch.
* Lets userspace save/restore the FRED MSRs through KVM_{GET,SET}_MSRS.

---
 arch/x86/kvm/svm/svm.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c1263a3b3e73..72d49c6daee7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2877,6 +2877,39 @@ static bool svm_pat_accesses_gpat(struct kvm_vcpu *vcpu, bool from_host)
 	return !from_host && is_guest_mode(vcpu) && l2_has_separate_pat(vcpu);
 }
 
+#ifdef CONFIG_X86_64
+static_assert(offsetof(struct vmcb_save_area, fred_config) -
+	      offsetof(struct vmcb_save_area, fred_rsp1) ==
+	      (MSR_IA32_FRED_CONFIG - MSR_IA32_FRED_RSP1) * sizeof(u64));
+
+static u64 *fred_msr_to_vmcb_field(struct vcpu_svm *svm, u32 msr)
+{
+	return &svm->vmcb->save.fred_rsp1 + (msr - MSR_IA32_FRED_RSP1);
+}
+
+static u64 svm_read_guest_fred_rsp0(struct vcpu_svm *svm)
+{
+	preempt_disable();
+	if (svm->guest_state_loaded && svm_manages_fred_rsp0(&svm->vcpu))
+		rdmsrq(MSR_IA32_FRED_RSP0, svm->msr_guest_fred_rsp0);
+	preempt_enable();
+
+	return svm->msr_guest_fred_rsp0;
+}
+
+static void svm_write_guest_fred_rsp0(struct vcpu_svm *svm, u64 data)
+{
+	preempt_disable();
+	if (svm->guest_state_loaded && svm_manages_fred_rsp0(&svm->vcpu))
+		wrmsrq(MSR_IA32_FRED_RSP0, data);
+	preempt_enable();
+
+	svm->msr_guest_fred_rsp0 = data;
+}
+#else
+static u64 svm_read_guest_fred_rsp0(struct vcpu_svm *svm) { return 0; }
+#endif
+
 static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -2915,6 +2948,12 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_SYSCALL_MASK:
 		msr_info->data = svm->vmcb01.ptr->save.sfmask;
 		break;
+	case MSR_IA32_FRED_RSP0:
+		msr_info->data = svm_read_guest_fred_rsp0(svm);
+		break;
+	case MSR_IA32_FRED_RSP1 ... MSR_IA32_FRED_CONFIG:
+		msr_info->data = *fred_msr_to_vmcb_field(svm, msr_info->index);
+		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
 		msr_info->data = svm->vmcb01.ptr->save.sysenter_cs;
@@ -3160,6 +3199,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_SYSCALL_MASK:
 		svm->vmcb01.ptr->save.sfmask = data;
 		break;
+	case MSR_IA32_FRED_RSP0:
+		svm_write_guest_fred_rsp0(svm, data);
+		break;
+	case MSR_IA32_FRED_RSP1 ... MSR_IA32_FRED_CONFIG:
+		*fred_msr_to_vmcb_field(svm, ecx) = data;
+		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
 		svm->vmcb01.ptr->save.sysenter_cs = data;
-- 
2.43.0

