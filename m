Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE73F0AB8
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585966; cv=fail; b=S54390KtOiu6GTQqsmm8WW/vE1ad4sQlWGG9NKs21GFfRnINOvYOB2Bg0cU0q0k0iO9ptL2895/NEdIs6pqUDk1QoCHNDlHsBGzer0yUkMH9RyX7QkqzxsgJTTzB1PGVXFaKWQH9tetkCKK+rIlMzXMRD4DHXlmS4pjwPWW3aTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585966; c=relaxed/simple;
	bh=MtEz+fM3+MgKXNL2tzJKE2AwT3Qlgq9DYT5/Oko6QNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW3GcikCi0qkqLan/LdWZz9291OROKMKKJjEjozx4IhIF3SAJfwc6aesdM/THqvXQ5KnsE3ah2MFO+S1J2gc24+uAd9vnkB+n9/na+DS+mS5Q2zVssQ3gi2nKxL9JngymSPDb54D5O7jSug8xdaGV4uqNbaw0q20kvFBen3OTGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jFyiRvCb; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jFyiRvCb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Jo+F0LVZ2ppnq+TIzO0vedRwANpq0UgXjF1qdv31hGAJZZ7QPJ8YeMECkpPfR4BJ9APyZ4kRzGszwGZzYcjhp//2d2BKr4Zn3u/67j5a/BKhAMBFG7sYMbaCuS3uRymxc0pTvmPwYVGlp+FyLJmH/1abdGv5PP4jHZcg1oDve6CnKaFEa5iiWUNfCyZQOLe3Lo5jpOgXtxJ9RvN36MIjFuhK7FEyNjgQI9EigbBFLK8Oke3IYKVDdQ+JltAUInqq/aMmQ1MFZ/o8U5FzmCCakkQBT0w5mV7rEX4+/u7FZSRlKBtpAGJxLfR4ggLnsfKwsk+5ENobzZhUIRUPuL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HafP/CTFOOAn3pljaMVMt9aar9LktfxQZPQyQtetkFQ=;
 b=Tkv5znPEJt7HzGo2H1wCdnzkCF+1G2hOvZ0vt8fj2TqH4ArQjO3abPt+JQGKFfsoiC2XegBOW7w5Pa2qz7EQbFl5Ms3lG9enQYn+Ub6C1gtcd0jNwHyl316i+3JiOhGbu4mNO0PYkP5fsHHNi9BGofQ7aEZJEm+c2ZoJhF5p3/k2A8aXEk3SFtNLJWImKHmyrCErYFr2W3Y7ezUeEdS9BdgnmdT9EJGkeuGXrysqP1klnEvuJP2UMwjiRCcCwGbAIIHOgKfR1Fq8qyuFvv7r3ATkw6UbK1qJ3ZVRCUTxOpetWJEgIA8VY/GBVopW7cn8KtgsZDbwG+OAz9A9P47BQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HafP/CTFOOAn3pljaMVMt9aar9LktfxQZPQyQtetkFQ=;
 b=jFyiRvCbCZcs4vxB5Epd4HI64JJVY/MgvnMx9ksiA6uEy0P2jv2f1tVBwpyKEJlBGhEMZTe13s1EOvGFRmCEmrVFF7cMMueEk50oVOTjUUQIuozXv5OpcP34p4aj7+VECvg2OEMr2LTXf1s6C/tGB0ECZExNGYCBre+S2txXaI4=
Received: from BYAPR21CA0007.namprd21.prod.outlook.com (2603:10b6:a03:114::17)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 08:32:41 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::5b) by BYAPR21CA0007.outlook.office365.com
 (2603:10b6:a03:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Thu, 9
 Jul 2026 08:32:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 08:32:41 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 03:32:37 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 5/5] KVM: SVM: Add Bus Lock Detect support
Date: Thu, 9 Jul 2026 08:29:53 +0000
Message-ID: <20260709082953.69434-6-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3a39ec-630e-4597-a09c-08dedd94a42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|13003099007|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	F48Oc0olz6WOY1Apm/cRD4u7RFi6/TsfC5LXeKFEnrafNTQXdONbPAJr6GowH5vdTNwoW2EqVRStzAAnNIk0YhY5oir8QHsrm3Hd35y9jBS1BrI7R+uqY16Eh48DOvP+NJ5DaT3WFo8IbC1REeL3/HLf9nLXPtELKJqhIko11q2vZbWSpn/EgttT/lBU2RHFiIAyQJWQRToQLyifs9LgphI+n407ZWvaF9iJijRxPP4XFVzguIy/FpLluNOR6UTdybzU+LYvG39pqN4uaF/Edgw4kniyYTvNgj0H9fasgcw6pCuGjWiKdq+uRJ3BJq6WvDbxIJ1dUbaObYUkRVYTa5JuHizbEofiD2jxSVQBkA24Pf2fNMc7VaMxhflMAfB4HSvmy8+OdApsj5kb7sE7Or58Bu1K9jW/pzMMK6g25C3/9+A0HV53e78LJW3rrujFYN1z5whLasUh1K+MXeMMQ5Ip++rzW1G6jsOye+cK6WeW77nNaZj0eqns6ZMXCZSJivYmQKkOFs20KHb5rlJcEj1lK1itiP+W0T1YLFeGntpYiOLzFhPJ4CxzXYvLfOOQudDgCLkjIS6734T5EsmeOzELigQ4CWcFW1VLlZ7HFGAN78lE+kyeMU2HzoXxj3LXundsFADvY57R8m4j6SZWRqThxYyjEE+WySyRS2HYzS/Ijw7+1x7jibIJIEEzD4TxRW2bPFEPIxZjGA6FZiKYsQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(13003099007)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ce7/UZCHFqB66Z4R3WNQYtYVPNUPzwO6nNUNRfLQHa2dxYIhWpScXdGWNVeD45gTAyfmV7ux9NPRQIfYAo881OtBSOIonegrVFiTU+nX5vFL2vR3WL926UAT51EBW4DGxAHkUA049p+6AvzFzhM6AfmlzVg04EyjB3Ywo+wVcwzNpLb4bR+DYUSVnmPaBqNibjcEOHGvzdqGxmyHH/NLTQeOsT3uM/4F1dDCJU++RgeAX1KU7qfQAosIEhnHSGSQrcRGPvwdqqQ+cRXB9jNPYYIDy4mZTWhQLDXrwwL0eeVEtj7xjSjOyTZBNSU6Dof0GMeMBg5+MaBJGzjCOTEUq8yKSu+L7h3YCuhCcA/jDBxVusPmdn/bgYkyZDZFGXLgu+5MsjbyaHj6WE4PQ0ow98M7oHbWgzLxEJzbX8pw6lApSWxclACJqXf/qV1KsJNM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:32:41.1772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3a39ec-630e-4597-a09c-08dedd94a42c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987

Add Bus Lock Detect support in AMD SVM. Bus Lock Detect is enabled through
MSR_IA32_DEBUGCTLMSR and MSR_IA32_DEBUGCTLMSR is virtualized only if LBR
Virtualization is enabled. Add this dependency in the SVM.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v2 -> v3:
 * Split refactor and prep changes out into patches 1-4; this patch now
   only wires up the LBRV dependency and exposes the capability.

v2 Resend:
 * Rebased on top of tag: kvm-x86-next-2026.06.24.

v1 -> v2:
 * Rebased and used guest_cpu_cap_has() instead of guest_cpuid_has().

 v2 Resend: https://lore.kernel.org/kvm/20260629081018.60618-1-shivansh.dhiman@amd.com/
 v2: https://lore.kernel.org/kvm/20251121081228.426974-1-shivansh.dhiman@amd.com/
 v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com
---
 arch/x86/kvm/svm/svm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a59389c322da..bd204aa33e47 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -882,7 +882,8 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
 	bool current_enable_lbrv = svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
 	bool enable_lbrv = false;
 
-	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
+	/* Bus Lock Detect in guest depends on LBR Virtualization */
+	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
 		enable_lbrv = true;
 
 	if (is_guest_mode(vcpu) && nested_vmcb12_has_lbrv(vcpu))
@@ -5595,9 +5596,17 @@ static __init void svm_set_cpu_caps(void)
 	 * Clear capabilities that are automatically configured by common code,
 	 * but that require explicit SVM support (that isn't yet implemented).
 	 */
-	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
 
+	/*
+	 * LBR Virtualization must be enabled to support BusLockTrap inside the
+	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
+	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
+	 * enabled.
+	 */
+	if (!lbrv)
+		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
+
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
 }
-- 
2.43.0

