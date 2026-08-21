Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC0378D76;
	Fri, 21 Aug 2026 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343300; cv=fail; b=KzdWpJ+pTXX8BKDqriAEm7pq5LihiTP6oH+B+lS2cZ8ryGMbMIUMaPrbJ7d8VhhDiDaXhGtusMEsrMmW32ORkijExylzr697Yypb0m/5UiQz9J+l6k82IqfgVVGch5g334jVZ1Y/TcHTjwpEqjDxkPvb4I3oNdhNYJXgy2ufkWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343300; c=relaxed/simple;
	bh=EbDhuLO6YoLgULf3seCo5/8dp4ZQvxiCRakPaU2UTV4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJU2mW6dPqYfn6qeFhMBhNYhrdlO9LpY58jPGccZCBPOr2KggSwnHqoyUtMGrCyCjvJ/wV9+wS88Ou2/J0aOFDVxJTLOuCRx9VoOIUjUKfoZ2+YlhIZXoxxVn+tfMcmVlr1dPKQ+RVPXEEKsvnwZVqwZ28gK7mYv+KTjkkbb0QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KOg/3zq0; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KOg/3zq0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEJgwJRNiKbH1GRT8BoYK/GhvM/SAMOaSRxeTCbZkr0hyFCs6RJmnDUZJ9VF6o98MMBWripkM6tumDjns++fiusnIHYY9ENRSEzu8ZGUP8MRBApXfn7/oY07zdmUx48eDq9HDnVaZq6WMcxfU3mAquJOk96CGtjF+s0Fc/ERoCe5W7NkzJFN0COHQH4CPH1I9HyrT7bq8Q8Oq2Lin+oeq7AeF84wUei5rn1KZbYQSjZKnJgviBRAplR2FHnJmfBVVPB1hLkNLyI0p5gQQntMY9UNvNiu6P1e2Fldjjd2zUKXwcVzJhjrPrD2jCLpzLqeIae2vc9BBzPw0Ud2nivm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EutSFLrMlFUYglFfZNbQGnMYLG3FRy1Q8YF37EuQJRU=;
 b=FNi7NpsnXiLPcFkMf8LTjfmEgIYUdAE3o+GFS3zHBM/DdQBpQyWwXm6zRuhhzoC0MHMZeQohh7AauFTjTJ0jMRLgLVkMtjHni25Zz7IAyxmLMRWZ0t7W5/VfKmbwg8eGfx3lPULkhxj04uAbXaxA/+FVgvlyEPkYhE4d09yjUROa+nehWaKphZEe3x4gc/o7Z7x8xfh264lErVsQbFVmHCw+kweEbY9l1N7vFwcVQ1L9eSLl8mir5sRMU/ajyIuKcdxYjLuYmx4T9iuO6FBcWVzcXQxZNlwu421NcSVEjDCC0ovqdZUB9EVNRAf+EDFY6fvzIf918i8DjOJM1lmG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EutSFLrMlFUYglFfZNbQGnMYLG3FRy1Q8YF37EuQJRU=;
 b=KOg/3zq0qTzSzrk1jIBRJKtj4JW9of1t+xsCgvnA9Oc++6/BzdYtU5X2MNDGQgpyJIovPUhlu4ARCU9ylLjHgg+6ZExxLJsWm7u4unkcGft0Gf9W5vHxZQEWbcZrpcwFn/9Jvrrgg2/dAE2965zmY3r5cQh19WEyQTsSZz9MZ1U=
Received: from SJ0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:a03:39e::6)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 20:14:52 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::92) by SJ0PR03CA0271.outlook.office365.com
 (2603:10b6:a03:39e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 20:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 20:14:51 +0000
Received: from nigeria-2635-os.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 15:14:48 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Srikanth Aithal
	<Srikanth.Aithal@amd.com>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev: Skip DR7 write during kexec when it would trigger an unserviceable #VC
Date: Fri, 21 Aug 2026 20:14:32 +0000
Message-ID: <20260821201432.879450-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: 994413ec-8ad8-4bcf-7ebd-08deffc0dbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	pMhenftYrhzqOo7nzDJ6AhDkiW/SdFGqVv5NyTsqBE1LOuCgP4dLxc/qKbdi6KxOlMhHHxW0X8rjx/Ew1EGMfRQV47FQFSQ5nmMHq7V84u6pgApDYfLQFLUJd9Lq852mN0GyLnkxvUcGOEve3m66IX8F7w/QHH96KUCxnpAm9ieK4c4O79OEwPtBkCf31jI/BaW7IWvW0Ma3fIb/6eLyI+PD7JaoQ9dy75M729su5TPsrt7FxGCh84ltifosLwSGYS3swL1yzXaDGHr+OvbqN2E2T1E8hiOO+t2+jIl3GTq+uSCgis2t6lAzD+wViABQVvt0qCQgCySQIuP/83D/Np5z1qXt/Rd3uQ2SkyyVHPGLzlbVrFyMFURFf3RWvhwGKu91ExgL5yw738bu6KJ0lpQxWvbeZNimQaU1lvVL1SNZpih2bfEuDIMOY60uNENyyRH4Lu7ZzVSsMIwqBiGdw3i6b0lQv1xpXB3uigi7pU0rXgJf4bZbzW7LPQh8a5T9FzUptVTxo9xF6o4Cu/fyMFHyFg7iUs0dRSKfiKrZkoaaBN3LjIRkAuP2MKTe8+JCb4xizK3Tw1QC3bHw/7+Hc8JhdUP24/cZrU29d2WC7IWAnDRKhK/Ik3oknCAFJ3z46NiuOAKKMGWnhq/uw90ghdd786LUbkhtVi1SMM+nRYb7hr4CYe1wyzKBDbIEJr/cJa72pbNIRg39MXlS5DHcvA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VCrJTc2Dr4vz5YwUCqrDJka/yv0e/TokVuELI0KSMO9EqwTFi8OC7e2L0eXzsi1iKdf54X0ar/yzeiFobuw8r2yH3LHMHMR3lsa8qVHk/S9pDp1DGnRbIichDtpHvssu1lbLH6LItYlVRpS+A+aE0IwjnVVmRwP1Yx+scPPrpxCqnBcMyKZN/P+rXvxYdCAdK9zXAXX9I5o7DE1dehY1CjNeubnKVscoSMRtjCE3LNPuGGxUf9iOKVstScDh9E5eFCysG21Rx+5sutRoPMGwjaliBk285MbyfvVNdcyIqiw9PK7Bt4vYDPgJ83uPgWDHdez7r0k8fhPbocPKtGz5AigmAcSDZ94fPLiaazZI8tZQgQNRBqPJXhU0zcPvb6SWUSqjtqUSvkEpi/HiX4lk2B0fFJEZLnQGWRRmiwM/hUik50ZjGNNrSoDIgNJWezcg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:14:51.3272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994413ec-8ad8-4bcf-7ebd-08deffc0dbcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86

From: Ashish Kalra <ashish.kalra@amd.com>

machine_kexec() calls hw_breakpoint_disable(), which writes DR7. On
SEV-ES/SNP guests that do not have DebugSwap enabled, DR7 accesses are
intercepted and delivered to the guest as a #VC exception, which must be
serviced through the GHCB.

By the time machine_kexec() runs, snp_kexec_finish() (called from
native_machine_shutdown()) has already converted the per-CPU GHCBs and
the boot GHCB back to private and set boot_ghcb to NULL, tearing down the
GHCB infrastructure. The DR7 write therefore raises a #VC that
dereferences a NULL GHCB pointer, causing a page fault and the kexec to
fail.

The NULL boot_ghcb pointer is a result of commit 3645eb7e3915 ("x86/fred:
Fix early boot failures on SEV-ES/SNP guests"): that change makes
__sev_get_ghcb() return the now-NULL boot_ghcb in this window, turning
the previously-benign teardown-window #VC (a bogus VMGEXIT the host
rejected but survived) into a NULL dereference.

Skip the DR7 write in this case. Its value is not needed across kexec
because the new kernel re-initializes DR7. Guests with DebugSwap enabled
context-switch DR7 in hardware and do not intercept the write, and
non-encrypted guests are unaffected, so both continue to call
hw_breakpoint_disable() as before.

Add a CC_ATTR_GUEST_DEBUG_VIRT confidential-computing attribute, so the
debug-register-virtualization state (AMD DebugSwap) is queried through
cc_platform_has().

Reported-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Cc: stable@vger.kernel.org
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
---
 arch/x86/coco/core.c               |  3 +++
 arch/x86/kernel/machine_kexec_64.c | 11 ++++++++++-
 include/linux/cc_platform.h        |  8 ++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 989ca9f72ba3..d4c90a2da2bf 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -87,6 +87,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
 		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 
+	case CC_ATTR_GUEST_DEBUG_VIRT:
+		return sev_status & MSR_AMD64_SNP_DEBUG_SWAP;
+
 	/*
 	 * With SEV, the rep string I/O instructions need to be unrolled
 	 * but SEV-ES supports them through the #VC handler.
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c3f4a389992d..60d25ceada03 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -398,7 +398,16 @@ void __nocfi machine_kexec(struct kimage *image)
 
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
-	hw_breakpoint_disable();
+
+	/*
+	 * On SEV-ES/SEV-SNP guests without debug virtualization enabled, DR7
+	 * writes are intercepted and generate a #VC. The GHCBs have already
+	 * been torn down at this point so the #VC cannot be handled. Skip the
+	 * DR7 write as the new kernel re-initializes DR7 during boot.
+	 */
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) ||
+	    cc_platform_has(CC_ATTR_GUEST_DEBUG_VIRT))
+		hw_breakpoint_disable();
 	cet_disable();
 
 	if (image->preserve_context) {
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 559353ad64ac..24ba1000ac94 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -62,6 +62,14 @@ enum cc_attr {
 	 */
 	CC_ATTR_GUEST_STATE_ENCRYPT,
 
+	/**
+	 * @CC_ATTR_GUEST_DEBUG_VIRT: Guest debug register virtualization is active.
+	 *
+	 * The platform/OS is running as a guest/virtual machine and is
+	 * virtualizing the debug register state.
+	 */
+	CC_ATTR_GUEST_DEBUG_VIRT,
+
 	/**
 	 * @CC_ATTR_GUEST_UNROLL_STRING_IO: String I/O is implemented with
 	 *                                  IN/OUT instructions
-- 
2.43.0

