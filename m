Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BE2DEA95;
	Thu,  2 Apr 2026 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161640; cv=fail; b=f5uxXcs5Y7tJh3ozfJEvI+8FHSkUsNhjf7ov5xBZ6B6Yd+6JIDoVwzKcBaQRrYJQUyRn1VvClJ5xbC2FMNTraUdtKaZTL3xY/siwf1LZjShomYzek4vmGxJF1UDqSF32B14q59++Iln2KHjxQ68RCH2XTM6nMI344fiQ7ZhQXis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161640; c=relaxed/simple;
	bh=kMvEna96QtqymHpyh9krhFebBu+h1u9v1Lgx9NLCjRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fODG9hnWmNOfR73UjRFAvS9lFXRsr3OyWxDvOHfMj51TeafkDFTI7G7BsXjFe41+i1ZhSitLqWR4qySXFCMf/+IUKEFE2IRexPtQp6mW5mjqpkPx0d/Wr5yfRcQ8xSwaXgBRY8gWIp+HxkMTW3fFjKe/6Spd3+41tJHUfMmIC7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bKsLCRYV; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bKsLCRYV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raKMG18J8sKmSpYZZsYMcABN47kNWxa1bubSF3lo1pZ0EtzBwRuJnh7Sw9oWfEOB5rMDdK2R/+JfHE00iouAwk19g7ie8WcUqHY1ZdM29Y9A+QIBGrAg9RokyEOS8gnywXiSsbB5s29d69QjtTw2W0ufULwKVWa67uHuPM4atJ6PKR230WusyjCdNRmGT18DnigURqzXLnh0aZ2OEetZ1yjAZjCWrL5KUT+Ndp2VTUfhp0BrJyIBiKNleL4HJuLhT49rKYULrQJGy7vxBdEiu8Pu8dMCg/sDn50JMV+KKRM/YLjrfITgUjiTpPmr9FG+DvSNl7GapUgrrJI+3QyKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcafCRsEbnLA8pjFAxThusE21PeEN+HdiGQ7wh9Bj8I=;
 b=D6zYAeJqTrf+wYrJ12yZw1o2hdSIhucbvoU68IFA6DpadpJFnYk6EuVi0ZXDEIqecs2ZXMxICdPHJknvdmVG6W6RyBCnrCM7Q521IolYA2Er6nG+O3bVLeaucnYSKYWigAmgg6M+9Dov3iaoKpUghuG6WrZUAa8AvbMhLLZHxfISu3zVR5Tq/Y6dHJC3rtTRXfIFk5Mmv8wY/oaw7MpAG4LxvjDmC/0I80SdvWyHXTCEyeJjdEy4GkWEDdzKoE9rY64Frfy8tecZ/oSOMhZe++a6U7tSwL73uwn1yaYRnETCWJ+g5quRiiVozLoardE3qGkZ8MgnmcsnJqLHG0QhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcafCRsEbnLA8pjFAxThusE21PeEN+HdiGQ7wh9Bj8I=;
 b=bKsLCRYVy+grw3WDZ1mTZk34M40PGtFHHpbdsKxsETNKAzsdREZdA1U1rHE/ZoRu5fI/lcCCkJFGvWwJOs6bsgPfsCdjvcy3AWeTViw8b3QIzHT7EIkgXPhz4O6/83Q5HlXpa3eSjU9zS9HszgQ/Ji6ltGvOP4ox05tCHqRG7fo=
Received: from SJ0PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:33f::31)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 20:27:15 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6f) by SJ0PR05CA0056.outlook.office365.com
 (2603:10b6:a03:33f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Thu,
 2 Apr 2026 20:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:27:15 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 15:27:13 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Kim
 Phillips" <kim.phillips@amd.com>
Subject: [PATCH v3 5/6] KVM: SEV: Add support for IBPB-on-Entry
Date: Thu, 2 Apr 2026 15:25:57 -0500
Message-ID: <20260402202558.195005-6-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402202558.195005-1-kim.phillips@amd.com>
References: <20260402202558.195005-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cdfb7c-9408-4455-ec66-08de90f63aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zilZMSNWEF5MPnlvaEE3pWJCPd+dIgi1C11D3MMP4ZDyxfUVJ45EpCly0KxblvfBXFdQHYlryFnw760ElPM1C2BEyJpu8COV4hLscauld+Cl7hu0+8J2vN3WXZlGpfc0gGdZNu84YqX4MRVwPt0a/qI3Di4OS/Sl9+AXYKO61TCD9O4UKxeoeFfxyA3BFIvBRZkZBdeqtBAVuDgGZ7wbTb0dBM1p9k6e8FKm7aORjs6KPxxC82DpbdHDMxvudokV0y9HZY1vzz6JHGQIdsvtN+HgWkED2Q6Hb78jxPgOVXFtOfVxvjLtG6IknmRa5ENzfKMPM2XuUJBYIoKDGCmKoMOh/6kZyJaU06ApIKJZNcGU6wdUmfTQCgn7hmGxcBzt34SOD3gipDc5MVhfckV7HlhAp2eLOK66T8cOF0jsSrL9ymShQbqzoE7wBv/J0v4y44QJBX/7e8Vh3FmgrealJoClV66++syKf92f66/1WA/jIwNmMvs1aT1Lgsj0/TLbyiiCeNC90xO02i3GNG1UFG3faR1Onv5iFjj0/DVBhQOSWxPA3/78RcmMYyKwSlwyKpcHzmCdhyQyA9xiDFQOHZLcRx0LNlYGQbBOdI2TZEIOvfaXdDc+YeK4xT8dhZbgd8dn5qRMJ/ldmnRmkHFJ2tDkL70sB1D0wW6ka4JmT3z+FsBPSVTI2AwzbyvWbC8YeY6tr/XSpHohBVvPyFkOsnjJdELMnZL8x0GtXXCaaRS0cSg75FgBYfW6rDl25DRYA/sABU9Y0c91HRgbpDqpmGf+ZfMmRn9syEjr4DSAK+U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D8imLXrCYyiIZ2GkfnhK9JbIE4K4KOIBIlmmaXodQxeFWVU0OD/TJdevGSQUM4qT0pB8YSgbaE4ZTK642/jjZud3m85/gZfB20E9k6v5jQ7QWxUVVQpGQ3CNHYMMY3cooPqhYhUd9vMPTeiRiXli+DjSM/dlJDUuEnyqmDE+2Klr26lFlCwfGLLUdalC0nVMxtEJKe7U4LgdwrYQI+uUi5LuPo7RLLZ/0pQaoiTaYC1n+PdsK1RUPlaGIp80MdlZZHV0cIEWm+vCQOhCZhx7z/5KESuAB1GUOYuHKCng5cx9RsGbAaJA1na20vrwl1QTJL6RarD/GdWR9WjWCFeWWZwhKjdakW75o/Z2/3wxvqAmO1npvsm1bvxFK+N/Ltgp1AJ/GhMed6AO3JkvCAi0EAeWdUOdGF2m3VlHqf+GBZOfwGaXiCTZSnYinde2FxWH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:27:15.2665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cdfb7c-9408-4455-ec66-08de90f63aa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

AMD EPYC 5th generation and above processors support IBPB-on-Entry
for SNP guests.  By invoking an Indirect Branch Prediction Barrier
(IBPB) on VMRUN, old indirect branch predictions are prevented
from influencing indirect branches within the guest.

SNP guests may choose to enable IBPB-on-Entry by setting
SEV_FEATURES bit 21 (IbpbOnEntry).

Host support for IBPB on Entry is indicated by CPUID
Fn8000_001F[IbpbOnEntry], bit 31.

If supported, indicate support for IBPB on Entry in
sev_supported_vmsa_features bit 23 (IbpbOnEntry).

For more info, refer to page 615, Section 15.36.17 "Side-Channel
Protection", AMD64 Architecture Programmer's Manual Volume 2: System
Programming Part 2, Pub. 24593 Rev. 3.42 - March 2024 (see Link).

Link: https://bugzilla.kernel.org/attachment.cgi?id=306250
Cc: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
v3: Rebased on top of new SNP_ONLY_MASK etc. changes
v2: https://lore.kernel.org/kvm/20260203222405.4065706-3-kim.phillips@amd.com/
    - Added Tom's Reviewed-by.
v1: https://lore.kernel.org/kvm/20260126224205.1442196-3-kim.phillips@amd.com/

 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/svm.h         | 4 +++-
 arch/x86/kvm/svm/sev.c             | 3 +++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..236411a1a86a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -459,6 +459,7 @@
 #define X86_FEATURE_ALLOWED_SEV_FEATURES (19*32+27) /* Allowed SEV Features */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 #define X86_FEATURE_HV_INUSE_WR_ALLOWED	(19*32+30) /* Allow Write to in-use hypervisor-owned pages */
+#define X86_FEATURE_IBPB_ON_ENTRY	(19*32+31) /* SEV-SNP IBPB on VM Entry */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 4f844a72890c..2a2b8705b2c0 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -306,9 +306,11 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
+#define SVM_SEV_FEAT_IBPB_ON_ENTRY			BIT(21)
 
 #define SVM_SEV_FEAT_SNP_ONLY_MASK	(SVM_SEV_FEAT_SNP_ACTIVE | \
-					 SVM_SEV_FEAT_SECURE_TSC)
+					 SVM_SEV_FEAT_SECURE_TSC | \
+					 SVM_SEV_FEAT_IBPB_ON_ENTRY)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 9663424c0cf0..561023486253 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3170,6 +3170,9 @@ void __init sev_hardware_setup(void)
 
 		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
+
+		if (cpu_feature_enabled(X86_FEATURE_IBPB_ON_ENTRY))
+			sev_supported_vmsa_features |= SVM_SEV_FEAT_IBPB_ON_ENTRY;
 	}
 }
 
-- 
2.43.0

