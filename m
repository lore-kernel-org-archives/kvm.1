Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6644CAC1
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318953; cv=fail; b=m2Z2GvQENXFt7XcUG6RIDjJIUGb1pWYBG0KH5y8Gt0U6WG/6IaOXKL2wiEYXSsuUxoEQzfR7i9b0TM0lvVcz1qS88VUwy9bCSnHS+m3Qx7v4xj8ZY4Ce4jETcMr2ZAopEVMG7G9TAJVGazHAvxZMUVy8xO4DgO7n6+68SRoQ5fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318953; c=relaxed/simple;
	bh=S2jWmrXiXoRVs3SVP6B4qsdc/yiKAev7x3ohk1+tPxQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaouEfWeg/6kWI2yHuBocyILpULWtt8uSCP1snqzpjB/VU3iQvXMjw0oI+ubLcj61mKxVNkg2HJCbAU1uIic2iLfEvdi0lIRKOrErVAa2HV9qV48jEy9AEK7fXKlbdJVMGhRyl3aHSA21+l2KLWxdsZXcugbg73SrMa+9PYUT/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d6AZ+Wyx; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d6AZ+Wyx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5bm1rfnSguIkZdcoozHeiyYv3tBKu6Jx5n2MygREiy2+uDnE7yKUMg8tkKi1fha8pKIo0yjUPTPIuJEL5k0Duws2iVtB3p0yWYdFvBavVFMDNwKXtLm+XcU7HrpZrEffIFjOaO6gLT0dUWl7dyEqtnLsEDcw81+KSPAIGctBQsbihQgYIGgiVo5ae/NFLg9P/Al+0jCrjTpzY8q8DokrePQbz20xNXGJBi7ZT+L5Ebp94AHIuPA7NyMYBf7zjcyrmID29/mIrGf0ofr99OP1UH+2K1xcxNnXRp5rcdsQhck2p7f73EixWr7Yoy4VWx25sQQ0mGFpIiMDhUUO/tm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz5DaUQmzx0TO7yS5SDiiC96hAL96ILoCBIogTNYHgg=;
 b=A1kqzSIJ+HFew13qbewI8jaTfllqRaKEC3rGKZt0o6cj8pt83Tu4VXMLacrmH3anXAa7GKAiLhMAOd8gHv+lTPJDaR5AkHqf0wjBOdvFfqKL5CrcrXT5iMu/3y4iau4JXvagCRlEVZIraVpuVCq8F7OfAjDX/u3zWDhOyr2Ri5c8eXUmkwxgQ54ODBVDad67GhiBY4/Fp7cCS3aNkGKccS5TwFShErIy/imY8brrPGOC/glGO5Xtjjcw72jLctqtdO6VDvZQ/yoru2FUyUbMvHAR61yCJS2crz0PEmLOuKhsajGPzoo//FMbFOJ9b+Bt3YQaDibNMlzcKKY1zYCyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz5DaUQmzx0TO7yS5SDiiC96hAL96ILoCBIogTNYHgg=;
 b=d6AZ+WyxqXfMsIoBLYu9jOUFLl6Wg+WXkF0tcrsZPy1YrUo4ieeE6NPbP4jxx57kOrKZoRN5I1nNbBGr/vz4FjRYQSbfrOsUBRGIlgk2u3grnHqIeyNkiS24ensyLwV8vWlo6e957hihUNr40Z/LxNyxs1/cv3JqN2r3ehwJQdU=
Received: from SJ0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:a03:33e::20)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 06:22:22 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::56) by SJ0PR03CA0045.outlook.office365.com
 (2603:10b6:a03:33e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 06:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 06:22:21 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 01:22:13 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <kvm@vger.kernel.org>
CC: <pbonzini@redhat.com>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [kvm-unit-tests PATCH] x86/emulator64: Add CMPXCHG8B/CMPXCHG16B emulation tests
Date: Mon, 6 Jul 2026 11:51:53 +0530
Message-ID: <20260706062153.346-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 619872a4-0536-489c-bc91-08dedb26f018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|3023799007|13003099007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	pvCsTRLkBTts89RjJSTgeNGmVYXvr5LV9cflEyng9osg/x8QnGaDqvF085gtAXFe+7q8MFiVY9aMBVLLX84Yhp1+kOvR839auilEJcjJv+3y5NYwfrIQIMjZgKpGD+BKWQjaOAZlNoOgDtfkyiEUx9mtrBx+iBD+2TosoFgsrqFlLg54Yz+4zcHW4Bv6KJ1XF3/pSzYVvoY1oymfm49eiOoL8cztIUutIHVrIK2mlmJg8yzobm9rE3Mk3iFlB4wS/q541ZxI41xKxNhf4GdQKecJfrbgjZGXFeTEnGc+Z1Wu8vSPfLvpSGFsBkVSf+mces3cS0QXSveHi+DrJOtPro0v9fLFbH6vEo9MOrToonQmtBeMfFEUVq9s0FUw4rCgYwnxxWxPGLIKIFMO5sM/ExK3BV9mvJJNZpwE3pFKO7c05ux+i+yLGbaeoHgKea9Uz1ZrkaepyW6wG2O4xOKTSg0rrze1GXMg4b8RVttjO64+vV+Lz/dKgUODNtG7oI7KhcZhhJPBP2kSW7Z8eMtdHl8tqlgB20sIy0NEryLY2l58veJfEE2SJvyQ9lILr63iPn/7klZCo/1aaw13S6+sPkCM3StTCVAONrfnlbhUMN7aSw0kbsl0LmbdT7Ieq7OYn3BT/6zi19WU9Psn0F/D2h9L3+4oHD4A8sAWk085xpaotm15YuRGSS8x+g4zQyCTkZ0jqSQ+Dk7wsd2tWOnx9g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(3023799007)(13003099007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	76vV2GTHaCkuE37kjBnymMaH/sbN+J8R+3MFm72yf17bCySkf64vbGR5R4Ao9RQA0Usj/2WtvC07avF+dx8JxNnhiuRvF/LclhJAf+x22vhPNi95A4AvVeH82Fqfmx2VKqW8J6q9w2Kb+HQHG+9tf+D7caAKGGb4Gap5X+GN4HkyEBLXHxyZzBE5g+Mv4BoIGW0QeKVeSH0YNRaZ1C+2lE5a5KgNA/LBpCUBOyW1dkwa/P6fvxcCPIwQrcosYGbZjeMnvSi8N+vm9UsnC2pnyodjOhVcZE0k7F7tp7gmxMR+Rn4FUPYIPeBs5re0htxUc0+em7w47BsTljcCHuPLTrf6FgG+LF6GGRzINAeMDh/3IDIjpcueBZWdFY6s5wnCxGbzbPyBff3w+mujklvWYyr4oagAnTqg8Kfpoa6BtdjjkPDw2SMlFzcBeS+d613A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:22:21.5240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619872a4-0536-489c-bc91-08dedb26f018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

Test KVM instruction emulation for cmpxchg8b/16b (0x0FC7)
with and without the LOCK prefix, and with the KVM fast-emulate
prefix (FEP) when available.  Cover both the compare-succeed (ZF=1) and
compare-fail (ZF=0) outcomes.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
This patch is intended to validate the cmpxchg16b kernel patch[1], which is
required to support the AMD hardware accelerated vIOMMU.

The cmpxchg16b tests hangs (with emulation error) on the kernel which does
not have patch[1]. I am not sure what is the right approach to resolve this
issue, any suggestions on how to resolve this are welcomed.

[1] https://lore.kernel.org/all/20260306102047.29760-1-sarunkod@amd.com/

Base: 1da1819e49fc4938985edca67df669099b4c87a7
---
 x86/emulator64.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/x86/emulator64.c b/x86/emulator64.c
index c4df5178147c..3d92053a06d8 100644
--- a/x86/emulator64.c
+++ b/x86/emulator64.c
@@ -245,6 +245,164 @@ static void test_xchg(void *mem)
 	       "xchg reg, r/m (4)");
 }
 
+static void test_cmpxchg8b_success(void *mem)
+{
+	u64 *memq = mem;
+	u64 rax, rbx, rcx, rdx;
+	u32 eax, ebx, ecx, edx;
+	u8 zf;
+
+#define LOCK_PREFIX "lock;"
+#define EMPTY ""
+
+#define TEST_CMPXCHG8B(fep, lock, report_str) do { \
+	asm volatile("mov $0x0123456789abcdef, %%rax\n\t" \
+		     "mov %%rax, (%[memq])\n\t" \
+		     "mov $0x01234567, %%edx\n\t" \
+		     "mov $0x89abcdef, %%eax\n\t" \
+		     "mov $0xfedcba98, %%ecx\n\t" \
+		     "mov $0x76543210, %%ebx\n\t" \
+		     fep lock "cmpxchg8b (%[memq])\n\t" \
+		     "mov %%eax, %[eax]\n\t" \
+		     "mov %%ebx, %[ebx]\n\t" \
+		     "mov %%ecx, %[ecx]\n\t" \
+		     "mov %%edx, %[edx]\n\t" \
+		     "sete %[zf]\n\t" \
+		     : [zf]"=qm"(zf), [eax]"=r"(eax), [ebx]"=r"(ebx), \
+		       [ecx]"=r"(ecx), [edx]"=r"(edx) \
+		     : [memq]"r"(memq) \
+		     : "memory", "eax", "ebx", "ecx", "edx", "cc"); \
+	report(memq[0] == 0xfedcba9876543210 && zf \
+	       && edx == 0x01234567 && eax == 0x89abcdef \
+	       && ecx == 0xfedcba98 && ebx == 0x76543210, \
+	       "cmpxchg8b  mem == edx:eax (" report_str ")"); \
+} while (0)
+
+#define TEST_CMPXCHG16B(fep, lock, report_str) do { \
+	asm volatile("mov $0x0123456789abcdef, %%rax\n\t" \
+		     "mov %%rax, (%[memq])\n\t" \
+		     "mov $0xfedcba9876543210, %%rax\n\t" \
+		     "mov %%rax, 8(%[memq])\n\t" \
+		     "mov $0xfedcba9876543210, %%rdx\n\t" \
+		     "mov $0x0123456789abcdef, %%rax\n\t" \
+		     "mov $0x0123456789abcdef, %%rcx\n\t" \
+		     "mov $0xfedcba9876543210, %%rbx\n\t" \
+		     fep lock "cmpxchg16b (%[memq])\n\t" \
+		     "mov %%rax, %[rax]\n\t" \
+		     "mov %%rbx, %[rbx]\n\t" \
+		     "mov %%rcx, %[rcx]\n\t" \
+		     "mov %%rdx, %[rdx]\n\t" \
+		     "sete %[zf]\n\t" \
+		     : [zf]"=qm"(zf), [rax]"=r"(rax), [rbx]"=r"(rbx), \
+		       [rcx]"=r"(rcx), [rdx]"=r"(rdx) \
+		     : [memq]"r"(memq) \
+		     : "memory", "rax", "rbx", "rcx", "rdx", "cc"); \
+	report(memq[0] == 0xfedcba9876543210 && memq[1] == 0x0123456789abcdef && zf \
+	       && rdx == 0xfedcba9876543210 && rax == 0x0123456789abcdef \
+	       && rcx == 0x0123456789abcdef && rbx == 0xfedcba9876543210, \
+	       "cmpxchg16b mem == rdx:rax (" report_str ")");  \
+} while (0)
+
+	TEST_CMPXCHG8B(EMPTY, EMPTY, "nofep, nolock");
+	TEST_CMPXCHG16B(EMPTY, EMPTY, "nofep, nolock");
+	TEST_CMPXCHG8B(EMPTY, LOCK_PREFIX, "nofep, lock");
+	TEST_CMPXCHG16B(EMPTY, LOCK_PREFIX, "nofep, lock");
+
+	if (!is_fep_available)
+		return;
+
+	memq = vmap(virt_to_phys(alloc_page()), PAGE_SIZE);
+
+	TEST_CMPXCHG8B(KVM_FEP, EMPTY, "fep, nolock");
+	TEST_CMPXCHG16B(KVM_FEP, EMPTY, "fep, nolock");
+	TEST_CMPXCHG8B(KVM_FEP, LOCK_PREFIX, "fep, lock");
+	TEST_CMPXCHG16B(KVM_FEP, LOCK_PREFIX, "fep, lock");
+
+#undef TEST_CMPXCHG8B
+#undef TEST_CMPXCHG16B
+#undef LOCK_PREFIX
+#undef EMPTY
+}
+
+static void test_cmpxchg8b_fail(void *mem)
+{
+	u64 *memq = mem;
+	u64 rax, rbx, rcx, rdx;
+	u32 eax, ebx, ecx, edx;
+	u8 zf;
+
+#define LOCK_PREFIX "lock;"
+#define EMPTY ""
+
+#define TEST_CMPXCHG8B(fep, lock, report_str) do { \
+	asm volatile("mov $0x0123456789abcdef, %%rax\n\t" \
+		     "mov %%rax, (%[memq])\n\t" \
+		     "mov $0xfedcba98, %%edx\n\t" \
+		     "mov $0x76543210, %%eax\n\t" \
+		     "mov $0x01234567, %%ecx\n\t" \
+		     "mov $0x89abcdef, %%ebx\n\t" \
+		     fep lock "cmpxchg8b (%[memq])\n\t" \
+		     "mov %%eax, %[eax]\n\t" \
+		     "mov %%ebx, %[ebx]\n\t" \
+		     "mov %%ecx, %[ecx]\n\t" \
+		     "mov %%edx, %[edx]\n\t" \
+		     "sete %[zf]\n\t" \
+		     : [zf]"=qm"(zf), [eax]"=r"(eax), [ebx]"=r"(ebx), \
+		       [ecx]"=r"(ecx), [edx]"=r"(edx) \
+		     : [memq]"r"(memq) \
+		     : "memory", "eax", "ebx", "ecx", "edx", "cc"); \
+	report(memq[0] == 0x0123456789abcdef && !zf \
+	       && edx == 0x01234567 && eax == 0x89abcdef \
+	       && ecx == 0x01234567 && ebx == 0x89abcdef, \
+	       "cmpxchg8b  mem != edx:eax (" report_str ")"); \
+} while (0)
+
+#define TEST_CMPXCHG16B(fep, lock, report_str) do { \
+	asm volatile("mov $0x0123456789abcdef, %%rax\n\t" \
+		     "mov %%rax, (%[memq])\n\t" \
+		     "mov $0xfedcba9876543210, %%rax\n\t" \
+		     "mov %%rax, 8(%[memq])\n\t" \
+		     "mov $0x0123456789abcdef, %%rdx\n\t" \
+		     "mov $0xfedcba9876543210, %%rax\n\t" \
+		     "mov $0x0123456789abcdef, %%rcx\n\t" \
+		     "mov $0xfedcba9876543210, %%rbx\n\t" \
+		     fep lock "cmpxchg16b (%[memq])\n\t" \
+		     "mov %%rax, %[rax]\n\t" \
+		     "mov %%rbx, %[rbx]\n\t" \
+		     "mov %%rcx, %[rcx]\n\t" \
+		     "mov %%rdx, %[rdx]\n\t" \
+		     "sete %[zf]\n\t" \
+		     : [zf]"=qm"(zf), [rax]"=r"(rax), [rbx]"=r"(rbx), \
+		       [rcx]"=r"(rcx), [rdx]"=r"(rdx) \
+		     : [memq]"r"(memq) \
+		     : "memory", "rax", "rbx", "rcx", "rdx", "cc"); \
+	report(memq[0] == 0x0123456789abcdef && memq[1] == 0xfedcba9876543210 && !zf \
+	       && rdx == 0xfedcba9876543210 && rax == 0x123456789abcdef \
+	       && rcx == 0x0123456789abcdef && rbx == 0xfedcba9876543210, \
+	       "cmpxchg16b mem != rdx:rax (" report_str ")"); \
+} while (0)
+
+	TEST_CMPXCHG8B(EMPTY, EMPTY, "nofep, nolock");
+	TEST_CMPXCHG16B(EMPTY, EMPTY, "nofep, nolock");
+	TEST_CMPXCHG8B(EMPTY, LOCK_PREFIX, "nofep, lock");
+	TEST_CMPXCHG16B(EMPTY, LOCK_PREFIX, "nofep, lock");
+
+	if (!is_fep_available)
+		return;
+
+	memq = vmap(virt_to_phys(alloc_page()), PAGE_SIZE);
+
+	TEST_CMPXCHG8B(KVM_FEP, EMPTY, "fep, nolock");
+	TEST_CMPXCHG16B(KVM_FEP, EMPTY, "fep, nolock");
+	TEST_CMPXCHG8B(KVM_FEP, LOCK_PREFIX, "fep, lock");
+	TEST_CMPXCHG16B(KVM_FEP, LOCK_PREFIX, "fep, lock");
+
+#undef TEST_CMPXCHG8B
+#undef TEST_CMPXCHG16B
+#undef LOCK_PREFIX
+#undef EMPTY
+}
+
 static void test_xadd(void *mem)
 {
 	unsigned long *memq = mem;
@@ -542,6 +700,9 @@ static void test_emulator_64(void *mem)
 	test_pop(mem);
 
 	test_xchg(mem);
+	test_cmpxchg8b_success(mem);
+	test_cmpxchg8b_fail(mem);
+
 	test_xadd(mem);
 
 	test_cr8();
-- 
2.34.1

