Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83233CC9F6;
	Fri, 25 Sep 2026 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336727; cv=fail; b=uPJy0NhzoEWa5CigKgXLQt9I20wnZkE1unbKtcQJ8cG9V/isYt2MqAWq6e+4+Xy7r1NQkr8Rnxp+c1v5EEc7QABfxBqEOWh5+h5qFpgC5UTgIjOS6qyPDBddHidvbjt03oS39FuffEMDBBU3MDQl49Jv+c4m5j3j/xBwJj4eQhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336727; c=relaxed/simple;
	bh=qP0lFvevU/mHr7HZ/mEI0BrOV8FkoC5ALDHKP4EAavQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRsRLq1jnjotVMoC3k2drZSKFROyfmHjcf5rtvfmaF5Y6YMqIhONbEaQETwOIFBjXvhDqOLNZhKP4LUoLUs81XcIpVr2+/i/FRmdYy6FB8mCR8b4h3SRc5IDNgAEPnEOFMKdhVYLfABL1cqLGTGcFbpPLJ12845jcMWMK2FaVhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRYvQrcg; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRYvQrcg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQuuwjVcqBf8C0uPBKURObepYqeXDFL6xJVEn2hc71MfXzPGoVPVVdvqE/Awpo63B+FyTPOkW9/vb5bYGUrlLS8EvvbKPuNkUDNt5fo7BBygO5gI3V0IwvJ1R9yWa7/GfK+iNY5fIfSa+919NckAohn2h2nGQiyc0qYWZAbKyb33/ghfodetoQ0ymSvGxn1xk7RCGhsmPlvuDbxVfuH6rDvS+TcamLmTXQY0ubpt+vPHceDrM3Ou5uYjkC6adWp+1+Vci1broLaFW1y1IZuypAkanFB+ltv5A1FtFhwViVx7ai4PZtQPV/EUwLKJy+YNNu0yDOfSwZqMrfSatjXMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD/7ZHUFGopD8CV3ZW/Tyz/mksLsS9YrdYkUzmYgMDs=;
 b=H2gMTM8S/UPUEtlKoz5wEOlpY93aK87M9tsKmVmpzTdluuItxSQaw5tpRNhqjemygfEWfeyZdYooimvrZXDfpclx8Z5+Fwn+A5Z/ByZFAdcxALGenbjS9+nxE/KwY5ygY4rIlGQmM+OgTCvFuipHB56jqp5JQ0JKQtmgxZ6lW3xwu3zo4dP2/lT1kGWkwDCYcKxQ1ojHYNpteVzqDv6dWkabWWskftbRvTpUCKaMlP2fWmZ+/MaBrapCV8PRbT3IEe5ydb05iDoBkr+M4GsU4l4uEnxigwMDbktLya+YV2n8Nr4yewOX4rMH7UR/yAJjKHyk5bY/hNdeUQI2CHyafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD/7ZHUFGopD8CV3ZW/Tyz/mksLsS9YrdYkUzmYgMDs=;
 b=xRYvQrcgN/nXfrhW7btjMMDHtb4QnQEO7x7RXzZCh60BGoqZASfb5jIJjGxitj1XsIZ3+o38t198XV4LLDnbEHjLVe/nO3LsPADhg1eeQxnyMizfz2Zj/OzuaKkz7vXzuI0OvlUVbLeMRI18/QdiG3/jPhqYuun9MLWi+40BTD8=
Received: from BN0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:e8::13)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Fri, 25 Sep
 2026 11:45:17 +0000
Received: from BN7PEPF0000009E.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::62) by BN0PR04CA0038.outlook.office365.com
 (2603:10b6:408:e8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 11:45:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009E.mail.protection.outlook.com (10.167.248.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:45:16 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:45:11 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 8/9] KVM: SVM: Enable FRED virtualization
Date: Fri, 25 Sep 2026 11:40:16 +0000
Message-ID: <20260925114017.2208531-9-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009E:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5b197f-c2e2-4f31-d60e-08df1afa782d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|7416014|376014|10067099003|11063799006|6133799003|260925021311599003|22082099003|18002099003|56012099006|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	x0iPU4l+oRyN8oNg+24IxKZ7Vf584sJiGU4TT78NUi8xkh4k+2lbf7PlfUVbXZUzDAZ/TCWeHDZu4AXQk1u6TYjGA7PipkLlk5siN3x8XgC2M89rw3eoP5IswvI1cDGIroGtn2SM9nSNOzoUl04lGaz29i3fsmZok4qi6KVrvygIfMjpA8dn+7rT69ZvIk+06A1lFumfNjksKY3slx8A1pDWxa1oUz2HYfSFoxVzsLWidCMXVehySCsoOTYIF2FcKxb3cBTIYm9AZlgJcxXpfDW8lCX3R3RC8mblk6uobY4AzoBFsyljQouMB5drufglkGfggvrOqNObTJQl8rMDu/bV4euQWsnjjeCm/+Hgf+e5hEVPmKDy1l3waxo/dLOaCPRaFxt2dUPG08+mc5sUgeQtwfGrtnoOmFKqvXwwxUdniq6gHJtOlmKcnYJdps5YXkFSycd6nLhZoy2r2ZAQAfarTxnRkthinHJWMIMZksOLLAvAUVdEPCEXvCqMfehoh+CQD/2gfjO0tfEBiPDax3p7+syQBxVfSZR638fjpDguGVBqdGQf5TEUo8GVinD7TRUk4xOlWYwSfw8eyaISs+Tud2UXQRanyKayaKerpL4tJvL1FNm9HtYV8U2T+exXRQPvoLXuNkswDPIHTVVo9aDnps5G+JjN5Q2rWKh/kUpsTLtt5YmfKgBgbfcJgvLfHVz/b0WfLFcVZfVS/NUwmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(376014)(10067099003)(11063799006)(6133799003)(260925021311599003)(22082099003)(18002099003)(56012099006)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SQTO8I62L6HbFdYjhuuBh56ZQmvqodL8JEUCHuEOEAIVuSRL8shMuJb7ch9NB2me+OGbK6alM1c5Ip3qBfziF7vgf6HOol3hif+OOFzRvHRn+kcStkwUMvcj80VIClUONmeeDcRkcvT1A+luqVRY9NPJKvLZ56V/n1PxyeTb8JzyNYHO0XA43Te0d+yYcd4Cp1Jr4hoxI1lZPLkDMq50I+08ne4vqYDB8UNN9yUMBVJ23WfxNylSLapHPrgajVYwJ8XF2ZYklMwK0iO8M2eJArNQc5hIBeND2etr3WtA560Krk6UR0DHtfDI5aIcxwQKLFIphi0sCC3i1x8DeGQK8xNDwNjYkjnkRzN6nIcgxiYDzah9Bqcoc/VKC1+gu16oMY+htprU0Cgb4u+0QhMgX1LtSyuej5C+roRELCQWWCxLpa/S5N13eVe1U5duLcC6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:45:16.9889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5b197f-c2e2-4f31-d60e-08df1afa782d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328

Set the FRED_VIRT_ENABLE bit (bit 4) in the misc_ctl2 field of the VMCB to
enable FRED virtualization. This enables hardware to automatically save and
restore the FRED MSRs on VMRUN and #VMEXIT.

Set the bit in svm_vcpu_after_set_cpuid() when FRED is exposed to the
guest, and clear it otherwise.

FRED virtualization requires vNMI to handle guest NMIs correctly, so, clear
FRED when vNMI is unavailable.

Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---

Changes in v3:
* Renamed FRED_VIRT_ENABLE_MASK to SVM_MISC2_ENABLE_V_FRED.
* Set the bit in misc_ctl2, the current name of the VMCB field.
* Removed the unconditional kvm_cpu_cap_clear(X86_FEATURE_FRED).
* Clear FRED when vNMI is unavailable (Andrew Cooper).

Changes in v2:
* Confined the enabling of vFRED to svm_vcpu_after_set_cpuid() only
  (Sean Christopherson).

---
 arch/x86/include/asm/svm.h |  1 +
 arch/x86/kvm/svm/svm.c     | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 1a6d4509b05b..288a8a78f1c7 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -250,6 +250,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define SVM_MISC2_ENABLE_V_LBR	BIT_ULL(0)
 #define SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE	BIT_ULL(1)
+#define SVM_MISC2_ENABLE_V_FRED BIT_ULL(4)
 
 #define SVM_TSC_RATIO_RSVD	0xffffff0000000000ULL
 #define SVM_TSC_RATIO_MIN	0x0000000000000001ULL
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 86a3ba54aab2..25dd379725d4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4912,6 +4912,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_FRED))
+		svm->vmcb->control.misc_ctl2 |= SVM_MISC2_ENABLE_V_FRED;
+	else
+		svm->vmcb->control.misc_ctl2 &= ~SVM_MISC2_ENABLE_V_FRED;
+
 	if (is_sev_guest(vcpu))
 		sev_vcpu_after_set_cpuid(svm);
 }
@@ -5675,9 +5680,6 @@ static __init void svm_set_cpu_caps(void)
 
 	kvm_cpu_cap_clear(X86_FEATURE_IBT);
 
-	/* SVM FRED virtualization not implemented yet */
-	kvm_cpu_cap_clear(X86_FEATURE_FRED);
-
 	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
 	if (nested) {
 		kvm_cpu_cap_set(X86_FEATURE_SVM);
@@ -5751,6 +5753,9 @@ static __init void svm_set_cpu_caps(void)
 	/* CPUID 0x8000001F (SME/SEV features) */
 	sev_set_cpu_caps();
 
+	if (!vnmi)
+		kvm_cpu_cap_clear(X86_FEATURE_FRED);
+
 	/*
 	 * Clear capabilities that are automatically configured by common code,
 	 * but that require explicit SVM support (that isn't yet implemented).
-- 
2.43.0

