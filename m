Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC803F12F2
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585921; cv=fail; b=pWmY94h6pV3Qc+Ij+G4xjNpPgBtOdiHxFyIJTZyXArBFj2lgqsJ+j/Vgd82DXJT15RyXVGzWWM/EvJjS3umqG1b2BfWFcYrhahC8/jtczik1jf0fFJVgCtFf5V8PJ1oTGkVSVoqk/+Y0ERL58Al8X2KZPi7/disKI1uoYo8jYPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585921; c=relaxed/simple;
	bh=0YK+BU3njEpKZ6dnaarl/KKsiIdtyhaY6NvdvhZ4KNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsOxhf2Y9X15IM2KpxLuiL9Obb/jCjT+pmRmUg1nKoPBFrEAw2rYlCFY+lu4I8gManduWTejzjk/6cDPefKv03k0oLQlGPem8peGLSaNLP2sEukXfOlsee5lqbGmudqw0AtqoGSw4EzAhx+0o1nueboqup2+nISf9KBHpjhRTN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQxGjVoS; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQxGjVoS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMuQjOy3aRjO8HCPRRe/vmfs/ykByuCGNvgEq04yPmAlqFqqqHA4M4CaPHKp/8B0fZDGCsQgH3KfD+mGBbEerdvU72wJEsnmy/kRwlWMYqIrRcqsqsjY8tzreDaQBuMtog/G1vv0UWlhBVVgxSsUnVFPORzvIOP/YKa0U2cpgQKu9bXNlbXb77Oo6JUD/Uweei3oapplRxB1YCHtI0nVrXzIn7z85ueSyAwbkmaJDsbjufKmen+F7f7KWKKM/mZOKUTrCsJW5MDdVRDPDn2LPiIZnncs+qLuP96U4d/84YZ9N/P7VEXuwbmlp9uCYTRZsPgDpQoSuU222ozqtvX6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWcOMVK+00+2/YPKrFHFV1pST2S1fGToPmdvZlbSd4E=;
 b=L2IQ2+3noz8B//XfAdHfE6NJLrK6iSKrKdWHgpHv2o0MOM0MO8M2v8JNSnRuTUnzFmO5g2KvIOZSak+Oi3jJVXI1bPpx93qO72ig8/g5gTtqvBr1AUmbVR7FyclTq+Ggt94ZmiBoFD3+/NlZm0MazMYhQLZbdMj5AlBRRYxiqyiuny7niL23ec9zYDOhN4jqqpeYFmfj8g0B5rnWaDyU7zpDqehlQWQp4fnoEfOfwA0xjqTS6kcBsUhNRjWk8YmtMAJYDHweqf9ZOIn7RjoykT1p8NnkGvVhlxz+sI2E7OMjILjb4vGa44u/N7OTh2ajl1BIS5JsXlO8+RDzWFuIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWcOMVK+00+2/YPKrFHFV1pST2S1fGToPmdvZlbSd4E=;
 b=AQxGjVoSe36LlozXtAssPpWLjYdj7o8dd49HVMWlAJyQYWtGvyWQhAif9gH/2b0JtxdZZ9kS73EPlZOvmmy4oVvz1on1DjJPKyrvU/g0HZCbbtFUPBkcgNQeytOP9uFFHuRTmsafINL4jQ5s6HUj9yvDlc8brAE2gaKN1ceGFlo=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 08:31:52 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::3c) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 08:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 08:31:52 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 03:31:48 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control cache when unsupported
Date: Thu, 9 Jul 2026 08:29:50 +0000
Message-ID: <20260709082953.69434-3-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: c2861d0c-e30a-4068-08bc-08dedd948710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KlFqaGL0XokL2XV10UvIxrMcwzPk9YCt332HaLRILktw8xF/hcr2c6OsJdZcI0p1FyycUFdYWufEnY0n4ntmsAtblB7zrY5XBZnuk+PgHJ6RJkDD4Ax7YY0mvTjZgfRckPG9JOy+MQNIN9tlGluYyyndonUy1VfagDRjsrFwBncsQfGPV5QZDDDj8b8Leg8s5Z1em5Hdnb1nwQeVoy7ElYUM6AqTo4kICZHPcJGm3EfeWQDA6U2eHf3ZT18HSaL+TzBIhxqcO3RAVcNDgt1yb/dVSK0zW8qd1tfh/ZpQGhILSej8OZ2oBZDMK8G7+0HNmasZgKySjnSp9ciJ61aqZNj+4z8bLv+WIq7TbqxE7Nr7zS4CUD4bv39Zltv1w49mSFiijE8/0qQJvYLskWDOT04Yka2MWumIt/1DMJbsQrRfdQpStOIcY0fNpdVclr3oXQ3Z+Qzs/fSNKeMDamwLesf6BSKcS3Nh1bOIftnDkYgkitPxMrR9LKeTAVa6L/l0IqKECD7n1dxZau1wQM/Jh+/S4x9CHISs7tq2vbZrSeXYWI75AWHzbOu9zQbHRMfLetvNZTv6vJOXhFNZqMJcrFrsZ3iAkSibmKNoh32P08FF1Qp3cdSGSD+44P9Uj0aAXmhYxi0PHleN5QHJn/TJLr4WS/BkTEfE0yJGKXcDOTOM6kZNtI4B3w7uiux9BBdIIqi9vucLpn6rYlqmYCGpkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FXLiUT7M/LFjxkcbHpCEzDveZBFCwJfJBy3xTg8rFVq5QvCP3J4bHc0lehnJCtwD0n8wQa/z2SV4dF2sfYw85Iu1qS17luB5/SCCvqIJw74tz7BHY3APxtMWNOq+V/OTwjwoqugaasBrVBxM5mmDCmgUVYAzUdofNvUOzLQWRK4oDOIzXVkm3JYKNqVP40wcKme0nFwT2jMlzQsgGhEK/rSBIU73Fq1NavwCl5qCyi6lOxDhC/29ziu8dtRuPVId7JMkbW+IMJi9+Vt6PliESTBj7/QNS6ujyV7lpI9d2/fkVQdPzxsLJTz3JlzIAd7kfNDVzI36+wlHcvusW4z80ogFX+uittS2Bi0UyN9FwOceDcmkknkKYPyHHWfX1eSL4w4DYhRJD7KfTQfi6sobrZndRnOB6F+qOf1VhSgQRoWnUVmonDwhGYtjNopaQund
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:31:52.2976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2861d0c-e30a-4068-08bc-08dedd948710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() when
the vCPU does not support LBR Virtualization. This lets the cached value be
consumed directly instead of re-checking X86_FEATURE_LBRV on every access.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
---
Changelog:
v3:
 * New patch.
 * Sanitize V_LBR in the cache and drop the redundant X86_FEATURE_LBRV 
   checks (Yosry Ahmed).

---
 arch/x86/kvm/svm/nested.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index d3df6b22bfef..84248e6665cf 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -534,6 +534,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
 
+	/* Always clear misc_ctl2 bits that the guest cannot use */
+	to->misc_ctl2 = from->misc_ctl2;
+	if (!lbrv || !guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
+		to->misc_ctl2 &= ~SVM_MISC2_ENABLE_V_LBR;
+
 	to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
 	to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
 	to->tsc_offset          = from->tsc_offset;
@@ -551,7 +556,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
 	to->nested_cr3          = from->nested_cr3;
-	to->misc_ctl2		= from->misc_ctl2;
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
 
@@ -738,8 +742,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 
 bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
 {
-	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
+	return to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
 }
 
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
-- 
2.43.0

