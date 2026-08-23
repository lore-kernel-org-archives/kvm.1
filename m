Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CC30D411;
	Sun, 23 Aug 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492226; cv=fail; b=nOz3/Lg3ldyyDYmb0m/2xxP0mNekDYdWBJZygSfgLVLpfB0ZmX0NqtJ+UZCeXQMQTYJz2EalF9gT9KJd7i96Um2YQjt1FRN7eQCT9Dt4eVpqyIQP2JujfkR4GfSHGlqPjAxP1hUH/Yi7VQ1C/LbXwGUOP8NJSdRgKI6blKG5yGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492226; c=relaxed/simple;
	bh=QoGpca2K2qIzQz9CVG+OIW++7fyOjuSFlIken4lrZuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UjB+LCzTDLJgFdpRCcMUvqCpu5aK4RF/awnBEgYurd10596rNEZnOKmvce8nyNuBRQY2t8LWZhpdI0qPDU7epjai8KO78GJwOyu4zIXCV3miC+oty/YbrNU73eTa5+Vo55wKCbli+DlsvZKVQ3wdiQv3i+esAhuNvEmEMajkRPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2dEGCNFc; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2dEGCNFc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JB2XYYBAWxVaPPYS0Nh5ZUe+5OGEqzwJFPGt/8euSB0tR6eBjxYtCeQHVPQZPwi5GgL/hxGx1tX2kx4Y+zjSQZApXJG+tr6l4HPtYPEwCmtFlltSbOhEK/Pjlh/BZGBPraRVnGQ3oP59LeeEiNl7kCOGj46hAlGS/D0DrSKyQQQ4jaelBySr/tGJw90onvrPYplCD7rpeFWj3gfMxAkVjFUwUmImdSNeSI8sCIutw+d5g+ktO3wf0Tdr1nehjjYfb4YKs+MbnRfzEFRSzYK4ydcheW7/GTG+/9Iuvvv8bzRq3Tznq0tPsxqnZMcqDAVDTl4byzsZR5J4e/DpKHRhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnhcPNIeFNxUodYSdgpowZtRY8vOzvsSY6XGiEauKxY=;
 b=XBWx1hsdoxAmK0k3vp71+r0/zgbY18LzMkNVd2B8ZAdzl4ACnNmQh2Ph6UHrqh1XVxXit6PKwKMRoPZOgKtfLtP5oJ8IOYCWqYF4FnMr31i1KmIAeitppp6IbBNBuprABnyVPxptvyxjz3GT1OfZ3BoF3dRUYgmFsc+v0GxvhtWrkEY8jN0Wi03l/kQrs4CKhrDbpz0QzoUCYuaDBHIFUkeGhLMAP+7IggOa3Kkbn9Oiz4EvbxXAhx0gIbKPMCrMf52zceJpOeMeaneTiryPSUchxBCojZEM1snNXh9qByGB/jxo5i7xptdJAa/jB27RXkehP+4vWNlpkev3HiWqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnhcPNIeFNxUodYSdgpowZtRY8vOzvsSY6XGiEauKxY=;
 b=2dEGCNFctqk+fgDyN/uRWLmc3smAiw8eTng7tuZrnBryve+t50RGxChdogVoJFIWkWFwLoJ63gk6RwDx3tQZfYTIpQeKPCoeUvPDDfuKrZF7MEzasM21v7TBLAh42DPrJdYUTg3LtQUBGX+bZ/F+ELH9/C9vkniXG95OOqlfEhw=
Received: from MW4PR03CA0341.namprd03.prod.outlook.com (2603:10b6:303:dc::16)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:36:56 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::4a) by MW4PR03CA0341.outlook.office365.com
 (2603:10b6:303:dc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Sun,
 23 Aug 2026 13:36:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 13:36:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 08:36:52 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sun, 23 Aug 2026 13:36:31 +0000
Subject: [PATCH 3/5] KVM: selftests: use BITS_PER_TYPE() for NUMA masks
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260823-shivank-gmem-fix-split-v1-3-512a29fb8e86@amd.com>
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
In-Reply-To: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Jim Mattson
	<jmattson@google.com>, Peter Shier <pshier@google.com>, Ricardo Koller
	<ricarkol@google.com>, David Hildenbrand <david@kernel.org>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787492201; l=2319;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=QoGpca2K2qIzQz9CVG+OIW++7fyOjuSFlIken4lrZuw=;
 b=iq3kYO+rx7uWI8FZ5I7427kdCW9mkwFGeBqap3iH6kZfWo9S1QVgAgyAxEHKFwo65Oj7nxQBm
 Yv38zy1gH1ODYnpY1XcgzUvPkuO1iBZhX9waVB4NAe4fRUd4omFeauZ
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: aec02686-81e4-472e-1623-08df011b99b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ztbcJ5mI+EAHEdSgC9zfZcAhn1TQevHhjZ1oQdkLTq0jBnzu2M5rTuxNhzQ5/CAC3uNm1J4N5PItCGosT/VbF5ykMREunmvX/YCwHLkvHR2565G/ysf9PuN8+a++MTmFfKhaaLBoClbU1y75Yj+6NdkGrfwuJ+STp2WpkRvxouLPum4Bha+tHDfNjij+6JYf8olOhHGLMSxz4WO6eiT1DOkF6fRJ5a3A9aNdAY09OHV0QNfc9LyRpgfxR56YYTP/XAg37HKl/U7/KabEzzaRo+LUxlGi8SkTO/Zjf2nf/Om4nzWptyoN/D4pp0Jb4psUBayiXRB1C5m/MFuDob9kLleBD8PhI5D27+t/NmDyI1oDN79YoSDIxgLb8v1aEAxvLQ7scHkJWcaFf2NS/kGb+ZT05WX/eRY2+1bowCPyYdR8KlbY/8tp2Y6fJFcnesurfqzuadh3rMDNJYOtZey9zzPi0fQ1RedMbJS723R0h3BLfWrc3ZWVvJwtNsbdlLh6s1BTF52/466cSDb3jN1W+ZgOgfMih9Gaz+i0+S9Dj82H3lb23Ss83o2UY/HLZutFRLMdlrs3GZ9GhOOncgegk4tEBQVktRj5+FUVoRYTg1f3ROsDR/nYrSGm0cPFhouY3l8TjhoHAQXZ6mVS4yLGHUmLErqgP/p6oknf7UZ4CJpCapjpGmJSVVoikX4wQRZJjxBV0E2Ak6+P8fw+A9H1Xg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zwrqS6eN6W/Q0Y0QKQ4mxR6Nu03Xo+Ug4u0h3QswKidyepZ5QzhN7WoBsNus3RFRAR5sXSfSt8MkctSMC/zvhCiRa4G9V/sL2oIn/3A/x3yXQDqgfZBl6x1wBd/vRhgU9KSsYZjkU4JMZhNavr3ocBgE0E4EdfkiEMw1lN/4knht97tsYS1E094QCrMlgpbypJJdJ6IOsdamD5cm/Obf9v2t3BE7UviBJQMCut4RdgQ4QlEy7YiBoAPJ1U/1Adw1NQiNaWMcSRzC9JDjo28LJ9+IkvOTa0TFzedOK/KbpYEfmrH/ETNz1i+IDQdJBDoZGcsB+8kHheXS71mb3/hbaPK2vK4N+J0ibMR22WYYd/9qyPXOMSeLD3R9eq5W3MpV/PSvecFgJjkwHG5WjdRWOOHFab+EZkDihXbs4o/qvchGQyDA3aVQfDmdwT7Zc6xg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:36:56.3162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec02686-81e4-472e-1623-08df011b99b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

Replace the open-coded sizeof() * 8 calculations in do_migrations() with
BITS_PER_TYPE().

No functional change intended.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 761e47e4cae2..769d8d95ab2c 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -252,7 +252,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 {
 	long pages_not_moved;
 	unsigned long nodemask = 0;
-	unsigned long nodemasks[sizeof(nodemask) * 8];
+	unsigned long nodemasks[BITS_PER_TYPE(nodemask)];
 	int nodes = 0;
 	time_t start_time, last_update, now;
 	time_t interval_secs = 1;
@@ -267,18 +267,18 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		delay_usecs);
 
 	/* Get set of first 64 numa nodes available */
-	kvm_get_mempolicy(NULL, &nodemask, sizeof(nodemask) * 8,
+	kvm_get_mempolicy(NULL, &nodemask, BITS_PER_TYPE(nodemask),
 			  0, MPOL_F_MEMS_ALLOWED);
 
 	fprintf(stderr, "Numa nodes found amongst first %lu possible nodes "
 		"(each 1-bit indicates node is present): %#lx\n",
-		sizeof(nodemask) * 8, nodemask);
+		BITS_PER_TYPE(nodemask), nodemask);
 
 	/* Init array of masks containing a single-bit in each, one for each
 	 * available node. migrate_pages called below requires specifying nodes
 	 * as bit masks.
 	 */
-	for (i = 0, bit = 1; i < sizeof(nodemask) * 8; i++, bit <<= 1) {
+	for (i = 0, bit = 1; i < BITS_PER_TYPE(nodemask); i++, bit <<= 1) {
 		if (nodemask & bit) {
 			nodemasks[nodes] = nodemask & bit;
 			nodes++;
@@ -310,7 +310,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		 * KVM_CREATE_VCPU ioctl. If that assumption ever changes this
 		 * test may break or give a false positive signal.
 		 */
-		pages_not_moved = migrate_pages(0, sizeof(nodemasks[from]) * 8 + 1,
+		pages_not_moved = migrate_pages(0, BITS_PER_TYPE(nodemasks[from]) + 1,
 						&nodemasks[from],
 						&nodemasks[to]);
 		if (pages_not_moved < 0)

-- 
2.43.0

