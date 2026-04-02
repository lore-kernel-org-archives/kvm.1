Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472852DCF57;
	Thu,  2 Apr 2026 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161652; cv=fail; b=bJQ4SN8gwM+4vCf4TAWTeKe3nOjRlcStRW3i0CFNi6+pId1N9aHfsA56OPB80VbS38b1lj6HgxxTfKMXbK5/EnrEBKHgAzvuOYf8BaXsW5L80InmL5geyj1rl1oxqLHMTSzfxE4xsTuCJmRRR1IaI6pLwV+D+3C+QYdSGgtD2y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161652; c=relaxed/simple;
	bh=dEwL8xi0TkZnfNjDAywWJ5C4wKqn19L/jRczUAYK1XY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVncpub/euWZ0Fwd4wDm3R3BZKGXkm4cpM07jtbfj5lEcLk72voqBIJKMKqIebuJZH4SJaFRRYGce3ilpWi24a9OeKtXDoY15Ll7LqY+clCnoHZuJU0KjNBhwvvmZYXV8ffsnuF9Q687C9yLVTHDc8sS5iurRGqB/GAQbs2MJ5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1eQB/lvC; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1eQB/lvC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idj/GAvtLpykdnbgy2x8ncfi0frnmDrhVVBHKuUhDmhjHfkCepjFLSCpAbJSJJFN75bd0jMbqD+jpkC/rvFQD9iUJOxuPWrfisabcrKPa5Oo4VbMX2rMpJXy7BkObvrXOox5p/imcUu7LfYzz8QOGXjjJy87rMQFQdhjm2hEfu59wt5Lbm+az6X52iTJGyZ0/vzM0RzCFEO/Cx4Bkayee63fxMBtJDGmKlDyAzgFbJBuALkxhZXSCRSApQJwghN/em7Qui4klsa3NEA71+8AHax2X+5Uzc9Opwnmp7k+4Udn/Z0de0kycT/wlUvfoD6BeqG+U0lwRjI2C7EIBttzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJCF6Voz4k7YVShF8JLVLdCUBy2L41c/c1J2Bt2WIaI=;
 b=s7oXixNkMLTJljXPtxzdzL3sloUysNe/4fDl8sH60Ze8FPRCryzIpoh6g/CZDuKdr6NUOkX/OGTRC1paENqtX93y19/F0pWbsIomLQ/+fWhx3Xwwu/5zCYwDNMbsLc9/1RhCSrmrKYVtaZ1VVHaucFiyXWz1MbaLndbG4+AbWS5fAr8FGLkt+c3D5EpTYLm7Bi6mbHnGjosWmJObjB0wMhaOXKAHBWuYmsj8ADZ+ev1VSxR4IsNOCyIkeuJ4zLXpQ3kCdjFuAG50KUxt8iTED8NzqPFZ+r1dN53oEE1T4uqPATp1O9lb9JDbhTvyElApXsrfbA1xkxIZ0ddarIGa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJCF6Voz4k7YVShF8JLVLdCUBy2L41c/c1J2Bt2WIaI=;
 b=1eQB/lvCvehQRrV5smfRRblAPC6rb9+Vwfw0IABdJY5KE3iid3nz87tGFW/MtK9G6j8cJLGEcNWdFeZfzMn/t7hMm2MGHk3+gQ7BQ1wQPTS27d9qXsZx7VjIz8A4m6an+EnE1rq4120qcyde8/OzwDAUSrA9qLAVUT0Xdx8NzRs=
Received: from SJ0PR03CA0174.namprd03.prod.outlook.com (2603:10b6:a03:338::29)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 20:27:26 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::9a) by SJ0PR03CA0174.outlook.office365.com
 (2603:10b6:a03:338::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 20:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:27:26 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 15:27:25 -0500
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
Subject: [PATCH v3 6/6] KVM: SEV: Add support for SNP BTB Isolation
Date: Thu, 2 Apr 2026 15:25:58 -0500
Message-ID: <20260402202558.195005-7-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: c024b790-6667-444a-644f-08de90f64129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZzG4iv0Kq9C5dMso82CuzZtUSAGmBObthzN8OIlUvlCWYQlL4dNDPcnumpEWpTPfdo3zq5ebPs+QIhHZ+++/hVceydNGH4AQWRqOar0ZSDfxeEi3mZy2IDN7wV6fc8sbfQv/kvGL4uRN/O17WAPNWArR/Dzf5s4vpDNDCgTjxba1spUZvTuB/pQiYZYLlOFEXu/YbrmdM6GOTR8goJkbFUV6ao3kNW8VVb9dp3Zgpu5C0csdxm/5M7EPTUvxw7S8bu1VqkuJ+r39ulzIUZETz6GQYyBD0gSo0cEgebmbdOYfOTTuWHvTHPMdwhYKZ/Pf94XLmXLJq/zL+py9J6TyTLQyNi1VpWBCA7eZUMQOOZ3J3QKDg5C4Y+8WuojBCz9tnv7Shakz0M9zHltx+x2l/fK+BhCRaIHBEtTRm6v2w3XxWf5L6jBhiJ9O4iRaMZ0qWS2k8KIzhkvRxPRYVapscaMzijo3YzV/kbLlGCjg464b83rSTrEeuTqk0HvRt+mIqgOBMbnMWmlgoo0GaM47upJi2Cq0vBMsYuVQe5TQ8UxoCcdhDDCwhanUH01jJ7PpwPvAlSoQxV92aeYT2dZAgjfqQ39LoGzbcFLcPVpWrFuEztARSemWcqDzu2DlBML01vp7DPFj/+M15bwLuKcH0fuX7WOjLAQVsqc7lcmo/L1uTnSHT2anatV+bgQUnDzYQ+DfT+zPJCYF+bJCU32HSAgOsJs/Ac1RUzDkoDYFvScfUpe4e9P38Sc/TyLgj6CsrOvBJqNR224m2NfPsUswAf+YfLV7rSpxd+T1VM6b1+o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3PZi7+kv7dQiV29eKBPf0BlWVIVsKVnYgx5hVBZedUNb9oX+zwod24US32LU0wx6EGb0bJ1szOgPgiBBNE3SduxdA8uIg+iIzv7l4gApshZqeFTEqN1x1USWu59WnFdzR2Y7dtw5deaTGPF5QHEM1YVoeMNIwqbIj71G5MMheZ68LyZSKBQJSYSzg6SbH4PQ/5y9f6TxJYd1zMG8oiPoPAp15vuJK2GqrOHiApfZcsGTVogbKSV59yIVGmtIoK+cXIpO2a1lgMzIeP+i+c3lF51EZ4UwtmS9gh+85qSwaMP/c3Rts2McwYncmb1hSFVuoi8qVyYtXccN1qbX7EACECHrlepwaoI/oN11tOFZmNSXtoCwcOe0/mOI8z6Zywmra2CKHFdQNTx7+NYAn9yd676A9Nqgsy5beId31ro8u2ZlcA9292i1m31JIua2+n+G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:27:26.1986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c024b790-6667-444a-644f-08de90f64129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

Advertise support for BTB Isolation via SEV_VMSA_FEATURES when SNP is
enabled, as all hardware that supports SNP also support BTB Isolation.
BTB Isolation is an optional feature that can be enabled by the guest to
ensure its guest Branch Target Buffers (BTBs) are not
affected by any context outside that guest.

SNP-active guests may choose to enable the Branch Target Buffer
Isolation mode through SEV_FEATURES bit 7 (BTBIsolation).

For more info, refer to page 615, Section 15.36.17 "Side-Channel
Protection", AMD64 Architecture Programmer's Manual Volume 2: System
Programming Part 2, Pub. 24593 Rev. 3.42 - March 2024 (see Link).

Link: https://bugzilla.kernel.org/attachment.cgi?id=306250
Cc: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v3: Reworded, Rebased on top of new SNP_ONLY_MASK etc. changes
v2: https://lore.kernel.org/kvm/20260203222405.4065706-3-kim.phillips@amd.com/
    - Added Tom's Reviewed-by.
v1: https://lore.kernel.org/kvm/20260126224205.1442196-3-kim.phillips@amd.com/

 arch/x86/include/asm/svm.h | 2 ++
 arch/x86/kvm/svm/sev.c     | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 2a2b8705b2c0..d3a15a40a09b 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -305,10 +305,12 @@ static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AV
 #define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
 #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
+#define SVM_SEV_FEAT_BTB_ISOLATION			BIT(7)
 #define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
 #define SVM_SEV_FEAT_IBPB_ON_ENTRY			BIT(21)
 
 #define SVM_SEV_FEAT_SNP_ONLY_MASK	(SVM_SEV_FEAT_SNP_ACTIVE | \
+					 SVM_SEV_FEAT_BTB_ISOLATION | \
 					 SVM_SEV_FEAT_SECURE_TSC | \
 					 SVM_SEV_FEAT_IBPB_ON_ENTRY)
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 561023486253..733423000bc8 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3166,7 +3166,12 @@ void __init sev_hardware_setup(void)
 		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
 
 	if (sev_snp_enabled) {
-		sev_supported_vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
+		/*
+		 * Some SNP-only features such as BTB Isolation are
+		 * available on all systems that support SNP.
+		 */
+		sev_supported_vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE |
+					       SVM_SEV_FEAT_BTB_ISOLATION;
 
 		if (tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_SECURE_TSC))
 			sev_supported_vmsa_features |= SVM_SEV_FEAT_SECURE_TSC;
-- 
2.43.0

