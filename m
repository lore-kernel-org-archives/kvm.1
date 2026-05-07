Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0843ACEF1;
	Thu,  7 May 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168358; cv=fail; b=uSpPyNqoQZq/ik+qCyoV9nn+F47STZeC+u/pu7cmwifcZpy1+Zluq3QOMrtgpx8wFLAH8uOCH/hbpbRuEtgwLYRzOEoqvgx8/Gq9R2qM0UWX39ucYzI9Db+oIZM54rMrh7bsRQrRwSb/vHevinrltdEepT1sfii1sMDHu/SvKJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168358; c=relaxed/simple;
	bh=1D5+mVUOMV9cFiMtls02rCq07UPvMZnwnBUUJISDkoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQF/9rgtYk1NMZdRoag85eNzfDEvBYbvvhlDx7myfVof3aZJZYLjPE0WgiyWhgES+NlUdh5PPswttfAyRQQF3hIXjSQOSrOlBVY9098Bm6LCZv4yCudlGYvrOdJ4Xvln36ENa8e3KCvMEf1iY61obfSJnDrr7pawOHNtS3EKb00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0LlgvLIa; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0LlgvLIa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rw9qfB2RRJwPm+c3wCuPYNocV3+vQIpEGoGkKZ6BVK5FzzW090kkwdI2F/fOvbsMyn4X5RMa13kuTT7JUbDOdfy4FNQR7ylXamVfSKaz2lANwAFpJ/MhUFI/UaCkBsZqdyINVPKkYVv1UHBjStokUGuR0dy5sMS0QtaJO0Vy5Ko1VA8Ww8TMWwEkDa0anO3FV4fp27eyYKqj/hDcl7n79QfW1+l53PpoO9qzXUJIlSZYoreapYCvSKyRq08Ma59gc+qbdmuxyKavf2xO1XNBrJsuK4HmYBeceyJc1f6X5DZguUr4hNziNy8PVHegAZCYrdcHAO1AbOJk3UnqoSW9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5c73llqw6my2uTGSFqNY7y62fCbAgMAeEgWphGR5SM=;
 b=Ka8dyixD0NyL39Q8KE1KTtDTMzB9n49SU4UTgb1T1iSbKFXbUs6tfR+X8klvXNllTIFucFouuFzZUB4ZE81zCN6gpDeytJIUM2ne3NKo0e3xL/qcN/UZfGtMpNsWyMjuQX2BhYLh43bu+z8xtSsSc0/2VeP1c2Jhc/InR0XUb3GmdsKAbsqTkoP6GZH/2lIoEDtKEp/yVJmD0J1huHSCupSFwvwYSTMtTXUOpm9MEhwcjHMKILpnYb3i1nugttiYA/0lpP/RAAoL2AoMjCda+zWRcnck651UibK2T8pAIV9mup9CtZk//VqFkN+OJRezCiLhzQRXcbTdn67I+KakvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5c73llqw6my2uTGSFqNY7y62fCbAgMAeEgWphGR5SM=;
 b=0LlgvLIaekyR4G+a9loNXkR6LIXgMDNCXI39nb4fZi/EzhXH2qZj3NX/ncK+hJWp2PSMiUKMPE+PYpmXmgZQn0NH7vdcicQVktjv4UaGF9YU1PVsqUbBSQ2VqXjagTVhCV2vSIgQEynmiMxat/t8PXf+e7PMIv0wKp/JADNcHQA=
Received: from CH0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:610:e6::17)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:39:12 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::35) by CH0PR03CA0282.outlook.office365.com
 (2603:10b6:610:e6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 15:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:39:12 +0000
Received: from MIKCARGYRISD1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 10:39:11 -0500
From: Costas Argyris <costas.argyris@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Jim Mattson <jmattson@google.com>, Borislav Petkov <bp@alien8.de>, "Joerg
 Roedel" <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] KVM: selftests: Add guest-side test for AMD HWCR.McStatusWrEn
Date: Thu, 7 May 2026 16:38:50 +0100
Message-ID: <20260507153850.8214-1-costas.argyris@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 951e605f-a405-48be-15d2-08deac4ec9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eEBR37izYetKloH3xnhBZKB1wov4uDYjK4CKcs8hwsBAWUQeU59y/+f5CFWWVmOdE2f5LNDGyWI1Z3SJGnRUhVY9QhVfUy2TMf2o6Txdp+WJiLSFlwGYpUnpGyVsEc9VEoiOY/K7NNrO/Wd3ZIRJUntdCu6B37SHcnwitP67uMmDkhmLRkYm1fY6OMDjoT8kOMxSpv1nzxa15ONf6RT9kEhVtTk4DV2UOmEyejDK4Rbkx7n6yOVXQa73iupY4Ctij092/AadZh87tjjMIF6NqqmuEZUH5u+nHoT8gmY3l2jwfi5wXRRM9lsEZ7Sj/xyy70H1Q2zZg3KQgz2BoVwMBtzsehzbYoA0YJysWaMrC3SZ8cuaHKqSFYheFQFWuAjTN1mvlpDJ3RED1arxIZblZJJ1MVFn6odbxfOAXK1N7gWjLlbbM6WGAz5ORABvwXDGo+mo74GwWgDVV9fvjSP5GCE4OViMhoH/8x/35//is733HAH0eEEXhB622OWbuBzxEGIvUyVwprf152IPzMg8/qg1aS2RaUTlVYoRDfW8DmDI6iI7qHNRkMewhyG9cJF4AOlQ9AyXMcipgK30tBo4zXEKdsAqMEX4G2rjYypg3Ay+/BRi3MiBFzLCf4NLrgt696uDiRXezZnslch5phsLH/OmiFAzF78dLJ0+bKVZGdIaUtQUd+gQyUwcVdcFsY6Gnb4KelfUqv+iXndpvnIIJcGUzyZSZXhYVUaGbKSKBDI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JpCRD9FbomBQv4fILm6Yla1N6nlmPg9pydj1300bKhuWv1PuS30jMvp1jkmFZt5FxXrfPHMZwti0oluEE41zTzT4B/bpq0YRjZyS9EUEI3rmY7/Us7OyQphYh2FOhMOobRpXpQetrWPMMvWz5gXomj3yq6f8rRa0vNNaXd8oZ2JdvhaifS5R3fL7OHXrcOwrvlo8I3RNTYNfce3j5YoPFNUOEbX0aGic3LAvkmcp8HHZBUr/Q/7vzauOa931k8rQ6+BnPxk4owpicE89LMH4rSsPWPQ0u0nCxEG7XJb0ra3UVvwVWfHHmQE71nnnDrtkNqBGeJynUegh1MJ+kZ3oTHWk23QDMYB9+HqbOZpWPbA/sQU6nX1SaPodi5Lc55rjz2OIO6FtD6iOeas+8ssg+9Ln+tZyilFZRu5nJgCg9XXlHYodokf/i9N2gNXtIqEF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:39:12.7545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 951e605f-a405-48be-15d2-08deac4ec9e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

The existing hwcr_msr_test exercises MSR_K7_HWCR only via KVM_SET_MSRS,
which sets host_initiated=true in KVM. The gate in set_msr_mce() that
calls can_set_mci_status() short-circuits when host_initiated=true, so
can_set_mci_status() is never reached by the existing test.

Add a guest-side test that verifies HWCR.McStatusWrEn (bit 18) correctly
gates non-zero writes to MCi_STATUS MSRs. With the bit set, the write
must succeed and read back unchanged. With the bit clear, the write must
raise #GP and leave the register unmodified.

Signed-off-by: Costas Argyris <costas.argyris@amd.com>
---
 .../testing/selftests/kvm/x86/hwcr_msr_test.c | 65 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
index 10b1b0ba374e..4e249bffcbb1 100644
--- a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
+++ b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
@@ -6,9 +6,9 @@
 
 #include "test_util.h"
 #include "kvm_util.h"
-#include "vmx.h"
+#include "processor.h"
 
-void test_hwcr_bit(struct kvm_vcpu *vcpu, unsigned int bit)
+static void test_hwcr_bit(struct kvm_vcpu *vcpu, unsigned int bit)
 {
 	const uint64_t ignored = BIT_ULL(3) | BIT_ULL(6) | BIT_ULL(8);
 	const uint64_t valid = BIT_ULL(18) | BIT_ULL(24);
@@ -30,6 +30,61 @@ void test_hwcr_bit(struct kvm_vcpu *vcpu, unsigned int bit)
 	vcpu_set_msr(vcpu, MSR_K7_HWCR, 0);
 }
 
+/*
+ * AMD-specific: test that HWCR.McStatusWrEn (bit 18) gates guest writes to
+ * MCi_STATUS MSRs.  With the bit set, a non-zero write to MC0_STATUS must
+ * succeed and read back unchanged.  With the bit clear, the write must take
+ * a #GP.
+ *
+ * This exercises arch/x86/kvm/x86.c:can_set_mci_status(), which is only
+ * reachable via the guest WRMSR path (host_initiated=false); test_hwcr_bit()
+ * uses KVM_SET_MSRS (host_initiated=true) and never triggers it.
+ */
+static void guest_code(void)
+{
+	uint8_t vector;
+	uint64_t val;
+
+	/* McStatusWrEn=1: non-zero write to MCi_STATUS must succeed. */
+	wrmsr(MSR_K7_HWCR, BIT_ULL(18));
+	wrmsr(MSR_IA32_MC0_STATUS, 1);
+	val = rdmsr(MSR_IA32_MC0_STATUS);
+	GUEST_ASSERT_EQ(val, 1);
+
+	/* Clear the status register before disabling the write-enable bit. */
+	wrmsr(MSR_IA32_MC0_STATUS, 0);
+
+	/* McStatusWrEn=0: non-zero write to MCi_STATUS must #GP. */
+	wrmsr(MSR_K7_HWCR, 0);
+	vector = wrmsr_safe(MSR_IA32_MC0_STATUS, 1);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+
+	/* Confirm the failed write left the register at zero. */
+	val = rdmsr(MSR_IA32_MC0_STATUS);
+	GUEST_ASSERT_EQ(val, 0);
+
+	GUEST_DONE();
+}
+
+static void enter_guest(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	while (true) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_DONE:
+			return;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+		}
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
@@ -42,4 +97,10 @@ int main(int argc, char *argv[])
 		test_hwcr_bit(vcpu, bit);
 
 	kvm_vm_free(vm);
+
+	if (host_cpu_is_amd_compatible) {
+		vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+		enter_guest(vcpu);
+		kvm_vm_free(vm);
+	}
 }
-- 
2.43.0

