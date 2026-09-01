Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2872C21D8;
	Tue,  1 Sep 2026 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251010; cv=fail; b=qgNsqbwDm4XQfJ76hTp7RAC6CtCr9wCKIlr1OajTUyRCtvpFMX911RBIBgZ++V8flLo3L0v07SGV7iGvebuTodPmc7NqFRVCQRSZJA+02hWANnWaiZ0w3SbdOPbmqWzH47bZePOGAsXRmBLdgBNkBFXrt1gUUP6LnxFoKlow8v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251010; c=relaxed/simple;
	bh=tGs0zuwD3KrzordnWtzNhu5Gh9LoxN7mqeSymJN6U8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h9OhDQTTnqAajKvLe0cLGlqDt55Xai+lGXw4KCv9yjsHNAI1eXuFPfznVXeQ9va6UYEw+Chz7MA1B+updt2hafCB2/s0rHyhZByfXyIou1cosmcvYGahsZXmpHuWwrN4PcsRhkU4dQ9th/9h8n9DMgNPIzjwONVs4IHTpTzBEU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pReWdd+g; arc=fail smtp.client-ip=52.101.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pReWdd+g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoCSLwjrdH/+DoiHnqRu+800WihPUWJtRNIEw621yHOU0/swXnlk+CRMYRaaj9k4yoZfMvY0v8y0EYtmTIqtbeH7KBaGcsVWKrx49FBrcgcCgdEGVyOqyY6THfR4ARnl2FP6/WGghTzF0nkLnk3a//+z/XjMeXsD7UH1Gg2cXdnTIeeiOoSKFn4xq4iPOJe8bOw056P3Guw7YIO5zOPMQsSMZL81RAXEWQEfOi1izH42ASIAgHGVY/p6azGVeQaoDqklpWNKDmkDSGlRoT1Vj2sFI84T6F8y6alYidBhxZZscw1i922UQ+TSDMFaB0W0g2OKk3VNZOjijJ04lQOoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZO0zMuQny7cTBUURlsShGny+j6BM3LF34c09lsTWQ0=;
 b=wtn/piTngipGtWvOBZ/qPifOh0iQqut2llnEdM0vCwYMkzVq5kkFJMWlMTgrsSG9LkfTuiyENajJ8DOHRY34C/kOtsQikcXrZbGBKK2ER5jhjoChNTTlQoSzQj6rQRenQu/kzZxH6XEeG5U6wXaFnELz7ob1rkD+Vsmhd79pvwiTwbyjgZe5JuvACbNouw0r51za4Um3jKQKEey7unJtmUx+EltFRM5PuT8ffmoOSs9ObCHxK2i4vwQ+9Y8s9iKshPiTGgK/wDgXpWQlCl91c20YyulTxwmvr573CxpTFEp9O+4Qw2u6Q3+IRQb1TJ0JnWLzul4iUBplvzesqgwkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZO0zMuQny7cTBUURlsShGny+j6BM3LF34c09lsTWQ0=;
 b=pReWdd+goaTqLcv+r/j8aH4yX+r8K1NXAUX8ospdoCMWQRahnvNHZKNEAOBE8idgPua7HkPYWYr581S3Ptk06D6rFWJviPsrJpiuAgMVqKQoALYl7RP4NV7cU8rUi2wZNUdwKStO9imd1g9oM7dQZ4svMDAFJkW7Z8vuhSRVC3s=
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:22:55 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::2e) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 08:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 08:22:54 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 03:22:51 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 1 Sep 2026 08:22:39 +0000
Subject: [PATCH v2 2/4] KVM: selftests: use BITS_PER_TYPE() for NUMA masks
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-gmem-selftests-fix-v2-2-5a273153354c@amd.com>
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
In-Reply-To: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788250963; l=2319;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=tGs0zuwD3KrzordnWtzNhu5Gh9LoxN7mqeSymJN6U8o=;
 b=W8jIDNxuVgUMbBRHHWZ/UU8dx2Y6E/1niHU8M1aCIJ6E0bEBjdNbkR0FWyLUH/7U/xrR0W8Sm
 o+HFnLlRMRkAOyhzzDwTEoZbQkwCI+wJxkT5Mher54hmMAInlf7Y3Ku
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 16afd044-9f15-4a90-31eb-08df08023906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ljahU9ypst07E7Mid9eGPcRoyzVr9PYpvaEs5+a1qzBkQ6emG81fjOpK/zHLac7lxw/StLveaxosFdA4pA2m5KqfkRlAuEHxQolS2Gyu1xdx9ZJulNa7rhKGfACQhY6ElCwTxpyJ0ynrwzjciJPWXveWg6jNicRbm5DyjulCsjNwCHm3NJu1SD+XXmsszdmmz9j50mhGhF2eqD5BbmIsLvTJ5ozplscYXXNLQ9YvyZEnpgA5BTn1K6vh+GlsaozgoUukzq+ArT88JUbHGbeM5cE5ALeEoQFu9qbRK6w0ivpACEBLMZ95LUZ/mOsBvR/3cUYSroUT8xC4h1fCVfw0IiXCY3N9vwjzjhVArwMh/gHhZ9eqrFfEZEzEb9XQv+o681rt6+5kw6HosftmBgbyVk1v6okhKu4oC0aFm+IS4r3UcEVWzIdQPTrar6avPYnxXDG3mXBE/CUllEZgVEgkFuVb7pkkVXQY9IFVOB65Ql5TxHn7MXoqu80eMho0higNt9XMrScSLbHRhStKZirufuffqIxnPbnuriSGAsEaL9zdD/58cma+lN0yzLEEloXh1F8veJW8kiGx50AXDCiKZ4MQ7GDkams/FpNQIB2iO+9459/JDaO34rNtQnYw+BRjC/spMVJKaEhRZwnjbOO0okTrWHsiux+Fz1ODuAdG3vYTIUpVxVL83PQHjDRKwl6G1kUA07KfZ65jytjBFC8FNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U/6enaHP8WUWPvPIqm8/3ucA7LeOglOgUy1G70kQNm4Jfkd1/5AxsnTN/zS4M1PNIDV/L6NB61LhDDcg/kd1DwWee3Kzzdno0k7P04+oE3DPvwsFAh/4OQhv7mvicL8PEqTdHaQYRpQfakBZbFWUap6wzhFNgQ3XMeJXQ7WyUvhEFlV2u9eB+iHhtt6mXel7AXsXg8PCyjKoQkwa305IvXoJgLe2OYsKJ2QCakLvIqGOHMNUJJv2ouvpZSWcY07X+C8PjmnJWAwAjXakTXM+l8gTChzRB1nwVnBaVxUX8HMv+8E7CAOLI7eUmVhmxlpajMzMuUll80HujagDGUuKL4HPcWFNqLhgwKQal8vc1hfuyPWzoqjTTT5uoRCKn95KIm65eR7igDH+tvzZx4ZK2clybrwJrpRNk0GUlTRjNknTxXg+dR5iMArRBKssBmt6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:22:54.8164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16afd044-9f15-4a90-31eb-08df08023906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634

Replace the open-coded sizeof() * 8 calculations in do_migrations() with
BITS_PER_TYPE().

No functional change intended.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 0f11f4d7cc3d..e5706dd62d3b 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -233,7 +233,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 {
 	long pages_not_moved;
 	unsigned long nodemask = 0;
-	unsigned long nodemasks[sizeof(nodemask) * 8];
+	unsigned long nodemasks[BITS_PER_TYPE(nodemask)];
 	int nodes = 0;
 	time_t start_time, last_update, now;
 	time_t interval_secs = 1;
@@ -248,18 +248,18 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
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
@@ -291,7 +291,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
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

