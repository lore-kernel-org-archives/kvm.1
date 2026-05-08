Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC003D8130;
	Fri,  8 May 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256923; cv=fail; b=UU+BjwAV4NVXSNfNnkNfz8wNkZBN265Aa2Q3nh/TUN5j/wYR80EO7idgMPVt0gSspX+YX5Uh51VGqSWMLJWFnUuezw6kGKmPM0/qY8lKLuJdLDlvFmDOgWCkPigpPE0+wj+Yj/Lwn8fV6icgpCsy1+mLdTEsqy6R6cQSn5K/fh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256923; c=relaxed/simple;
	bh=QuoGCoa7Lf26FSYJm505Hy6q8mlUtXrqLQRse/Tyr1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3hSQnSfWpVzEnZjtAyj4F8FNGblgfb6QkL8GbPb2od7SzdSkk9+Zu8gY134aaagbvVR0k/50ATSJcf2pX/HFYJLibK1B0T6Z6gGkXjOhat8w2NdibgQxAWBph9I14JzKwfBXb1+IKy+3qReMXTmjmfQWEIcee4comeFXytnyho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hqeTksVH; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hqeTksVH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br+sbzlc+XOKrD2Sp/grajH0xBZHY4WRJotyB0POokIHiUUA2ZCvaNsKFzXu+MfH3Q0pbv35RGJIG4wW/ytDCE0EEfKpCnzLzlkB4pinTFh5Cj1WnX8SH4F5VcSFvitzYe2lCQeeSlodgIa6waxeKjLaI8mXOE/vf9erhj8M6syc2xQJlU2coJ2pYkfH9O+tioR74g3fnIYXhzCNt86K7HNMx9PQERoXBtyRXyb2mpGfV5pWjIpz/BawudHhkyHzF9Pzxg+mLMpYcZd1bRRoOi7M5IoeuMroCON4WWZnEczAbrXTr5bCiwPd/wWOV/nhzMB1xHLCg8TigJs/f9/JHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QmqKf61Ht3xZe5Llumol6X/zHzdnUsB2FgRIiHU2xc=;
 b=uaw86cT61WRfnXCbITi6Rlqrht2hmb6f073QqqxC8KvkQ2vzsd6YrlhSQiQ5dF35X9TB5L+6G4BXbooeVRYi1S52FVHKBv7YV6Y8OT9z023nsSXQpoNe/cTOOMTidKeEAmTjd83UsDLE5NV3iJa6WURpP7FaRjqeRa1wt2x1Uxp60Yb+LRpRn2hBwwQH/g3undcbvU4qk95z9qINiE96pGmF7aa1y361mLnTnU/qcoa2NZzkgdl78tZf72W7xc5403dmJyPK3n5rvQgir7FypSGZR7D22K49rZ0U87DTYo78uy8O4kf0gSoaXVQzKPCVfdVefhaztIXsKNN5/O9FGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QmqKf61Ht3xZe5Llumol6X/zHzdnUsB2FgRIiHU2xc=;
 b=hqeTksVHIwG5UPt3oMaaV04XSMClYHHrLlpzxxLNLwYZgTNut9+dt9w/8kHtRV82Xoq0nKltUKKDNqCBY32460rw9rP30hR2OgpvRPh4m90npjeRgzp15LkSkgv/f+hqeilUfDuY41I90oTY0kaQif8WyZ35rkeaxP06FVMolkY=
Received: from BYAPR04CA0035.namprd04.prod.outlook.com (2603:10b6:a03:40::48)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 16:15:13 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::35) by BYAPR04CA0035.outlook.office365.com
 (2603:10b6:a03:40::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 16:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 16:15:13 +0000
Received: from MIKCARGYRISD1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 11:15:08 -0500
From: Costas Argyris <costas.argyris@amd.com>
To: Sean Christopherson <seanjc@google.com>
CC: Jim Mattson <jmattson@google.com>, Borislav Petkov <bp@alien8.de>, "Joerg
 Roedel" <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] KVM: selftests: Add guest-side test for AMD HWCR.McStatusWrEn
Date: Fri, 8 May 2026 17:12:33 +0100
Message-ID: <20260508161444.23676-1-costas.argyris@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <afzZvhJgmpAT2elF@google.com>
References: <afzZvhJgmpAT2elF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: f53776fa-4c30-465f-dcaf-08dead1cfc02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yD/ceKXUSJp1RH2HAAf35uMxTQHJiwgxiPCPyyz64uHL3Po9jBl+xBNWlfQjX422HZXARDXwmrjiG2DorCjK1cub3GMSVCsk25IWkgXiUDE2yxQpTo/BOlClXkuc5aSqcxn8PiQ/VsQNcNako5jUSqCJPp8ngntNK2CZ125egMH0Zsj4NhRoV/tu6iUjsP0x8aONABeoHc/zm0dxDvb5ucEElz6Dpl18bk6tswa1SUhV8ntP52p4xJm0SiD+b2ScUxiIMDub08XomgecT1B4Au7y0Yj4dgYCVDO/jQxYWWwU6g4F0h9Dh2HH6tXzrYFuLL6tBhLh80sAgNzQ5GejS4WDLNbb8YuRDjGxUCoZ5xV9J+RJrXcO7D6y9pY2Vk7stlglWBeAHXXMPnUd9nWit4qrbNMldbWjBybVMPJDmQpp9xeps6QADSjgGhNY39tQT+f4c/Kn0IYqqUYKlU51Vkg4SSejjJd97NnKTcdaKt3Sfv6yMtN4Xf8TJhEUtPB63afZ9EZA4YDZkSwmV05xrlhvTeUdRBVPzzGIRDHDo8SxDv4jcXODXR6TyIk8fPzWBbztkuhEmacwJAQ88G8MHCoV4kMXsCFZZGW4lKebjKkgTGNv21OAVRinQi8/W86T7z6jSe0nK72Sx4exXV6WVdt/AohK0YI3UCfikA7+mp6jUAAOFQSXwzbLMLPqngVezYlb3OSAQJm2hcaWqmOrScdEp3O4YTEiD7v2X7r7HmE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3O6LLnyu8Qw0wAiyyiQRU1B6m6N1nVh3sVU0K0OVY5Dt3tsvo0JvOVGfi2yiuGEmEYo9852mKlikTcEUkhdlqy1d9ULq8FvEg2600psSekkLrO7yYJhXeV+3OGIi5CTGDi9utg7atzRcaAffHS+vQw83rakHBrYrchbjsGW9igwATeyqiACdSpmBU71vFketwJhmJNBdL9WtBC/yPtKZ+CyJbMzCHk3P6bsRBqdIuEGeUZS3wd/U5sZh5NOwsg2KxoNpHAxyfrZ2sdete9OYExLntY0U/UhYVD4NUrPu7/XO81Xjh2NH7Q+b/IhiA4koc1SUWlHYOxkpM4VX4vDemxfUHflixKYbPO8m26JlTmtn84QQW2cBVXh2JABDNS7Ss+hS/uScxLyImjFUaf8vNOg5ZvNqUJoJFYWU65DlS5N6PQM8OxPHMA+44r5btee7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 16:15:13.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53776fa-4c30-465f-dcaf-08dead1cfc02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

Add a guest-side test to msrs_test that verifies HWCR.McStatusWrEn
(bit 18) correctly gates non-zero writes to MCi_STATUS MSRs.  With
the bit set, the write must succeed and read back unchanged.  With
the bit clear, the write must raise #GP and leave the register
unmodified.

This exercises can_set_mci_status(), which is only reachable via the
guest WRMSR path (host_initiated=false).

Signed-off-by: Costas Argyris <costas.argyris@amd.com>
---
v1 -> v2:
 - Fold test into msrs_test.c
 - Reuse existing helpers for the guest code
 - Drop unnecessary while loop

I tried fitting into the existing __msrs[] table but it doesn't seem to
map well — the proposed test has one MSR (HWCR) gating writes to another
(MCi_STATUS), which doesn't seem to fit the per-MSR CPUID-feature model.
Tried a self-contained function alongside test_msrs() instead.

 tools/testing/selftests/kvm/x86/msrs_test.c | 59 +++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index f7e39bf887ad..348811559831 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -476,6 +476,62 @@ static void test_msrs(void)
 	kvm_vm_free(vm);
 }
 
+/*
+ * AMD-specific: test that HWCR.McStatusWrEn (bit 18) gates guest writes to
+ * MCi_STATUS MSRs.  With the bit set, a non-zero write to MC0_STATUS must
+ * succeed and read back unchanged.  With the bit clear, the write must take
+ * a #GP.
+ *
+ * This exercises can_set_mci_status(), which is only reachable via the guest
+ * WRMSR path (host_initiated=false).
+ */
+static void guest_test_mcstatus_wren(void)
+{
+	const u64 val = 1;
+	u8 vec;
+
+	/* McStatusWrEn=1: non-zero write to MCi_STATUS must succeed. */
+	wrmsr(MSR_K7_HWCR, BIT_ULL(18));
+	__wrmsr(MSR_IA32_MC0_STATUS, val);
+
+	/* Clear before disabling the write-enable bit. */
+	__wrmsr(MSR_IA32_MC0_STATUS, 0);
+
+	/* McStatusWrEn=0: non-zero write to MCi_STATUS must #GP. */
+	wrmsr(MSR_K7_HWCR, 0);
+	vec = wrmsr_safe(MSR_IA32_MC0_STATUS, val);
+	__GUEST_ASSERT(vec == GP_VECTOR,
+		       "Wanted #GP on WRMSR(0x%x, 0x%lx), got %s",
+		       MSR_IA32_MC0_STATUS, val, ex_str(vec));
+
+	/* Confirm the failed write left the register at zero. */
+	__rdmsr(MSR_IA32_MC0_STATUS, 0);
+
+	GUEST_DONE();
+}
+
+static void test_mcstatus_wren(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_test_mcstatus_wren);
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+}
+
 int main(void)
 {
 	has_one_reg = kvm_has_cap(KVM_CAP_ONE_REG);
@@ -486,4 +542,7 @@ int main(void)
 		use_one_reg = true;
 		test_msrs();
 	}
+
+	if (host_cpu_is_amd_compatible)
+		test_mcstatus_wren();
 }
-- 
2.43.0

