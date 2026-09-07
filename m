Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810341A928;
	Mon,  7 Sep 2026 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765943; cv=fail; b=UZ3rN9P9Zs9bhTh3Y+sQboW+MvAg7ltfp/l8imqS1DatEgYjrRZdJdAttOBdy6cjy5/s5O3rGGk7JEaIuSPK04Qa64c5hCrsFM8rhqinOvmNpSfyBHFGuuUnoBjyCLtC7s8IloGqfZOsOAkYsju45a8WIvRyD0Y9G/YCAtOzvwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765943; c=relaxed/simple;
	bh=g8xA/CeHWn0fR5gMmhuAeudgM8redQtek7htLUdbMYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M5aOvXiktz9aM7XtixCqGMHmUOTq7ADJLlbqtpdbx9/FhNOuIwoeHraLhejpslCOScoZ/AyvsW3WHOOf+bk1Gj821ALPy0jDMcV/N9rBVLjGfq6yI8UlrwONJYmFSjJVxXSHUdn7QmvrBNYWuD6in+Y7l9bxMAsGX/n+q6587ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0LOVnNTT; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0LOVnNTT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9J+gzk7zB/gGQMXiVaf4grf//7+oDe1z+Et0qYC5DGEBsohX66dQ0C9+qqfsf2ioEVdA/KlBVFQYJjYctNewBDrAW7+ekz9XRvYwGg3kNzuq8/J1SbhZ3enEJyFqOnL5pTf1oGsOrdaaLr8AeZ+00h6h61XX/Ywbv9YUO0IaI2OLvzvj2+qk2GJvHSuLPeRn7lo1okdc5lpa2W9P762CboyM7LvxYH1s5zxqVbkbfFy5TRUu+xZ189Flf0K4G1jySkkeoMV2jlbnP3/tLIP2FaxASo3QS1EPs9MH4UGPMJbBWMZC5/DP9+p4Y1CBTlTFoaa6Em3VK3AMvIytUUvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4K3bxeZnSamcBpFP4KaOX4+XQnEc650cp29dSj74Xo=;
 b=gfzBHxTOVgfmA9TRBvSstKa+BhEvq7ninCiEFQapjeF3NYuLXOVxPQE8HDmjx946O1ckbnx82cjiUJT/1L5ZW0QRgd01InAgeTlvpd1t2RHj8buZgwfQp8zx6uOrTZSK1vLmdctdzBWNpNkl23MDNZeqNpj6dOysITeWKxyGoL1H8VcVtyI5vYVcDNUnMi5ik8hgNlmZwq0uuarINbDde9JtP1/AqT8eB/KkGVfd+sjpN6cnkw7atbkuXZ7Q+W4PWb7z1ogjA7vywuD713/cOJN4NB/OEdksQ3aEMvhaQiqn3fiFjPNygHLbwkiOvtKlZDAT4nzgY8q6tU1OLquDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4K3bxeZnSamcBpFP4KaOX4+XQnEc650cp29dSj74Xo=;
 b=0LOVnNTTuW01PCL8QPgQrgOdtTWvLizl/9NE2PW8f+ovlYRCjkmCQzVuKzPDZexDiX7K4JYAJEFOnV/SFHrSIbazjakcNPYlL55Wdoh0EZEwxtYOUSULcYrtI+t+B6Ux47rjFt9ybbQC2NJsOaxN4KQlBhnfGyNAR7NLCesZkR0=
Received: from IA1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::10)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 07:25:38 +0000
Received: from BN3PEPF00022BBC.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::7c) by IA1P220CA0016.outlook.office365.com
 (2603:10b6:208:464::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 07:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBC.mail.protection.outlook.com (10.167.248.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 07:25:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 02:25:35 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Mon, 7 Sep 2026 07:24:59 +0000
Subject: [PATCH v3 3/4] KVM: selftests: Use allowed memory nodes in
 test_numa_allocation()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260907-gmem-selftests-fix-v3-3-7a4be5c1cc8a@amd.com>
References: <20260907-gmem-selftests-fix-v3-0-7a4be5c1cc8a@amd.com>
In-Reply-To: <20260907-gmem-selftests-fix-v3-0-7a4be5c1cc8a@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788765924; l=1507;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=g8xA/CeHWn0fR5gMmhuAeudgM8redQtek7htLUdbMYk=;
 b=SDQLdlg1+DTikZDZ4zRvSauz7xY4G419iKJBs4hXVuP24dXo67xKHBTwP2rJhY1lYLBOcRsF+
 +IJ3OrzIUVOAyAdGAK9vtrnkkcaf8eJGbKbgLSB1boyPKGkuSupjbjd
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBC:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f8001d-4dd3-4ac2-ec97-08df0cb13759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vwMVea0oZEX39Xvir3yLU2nhZ87W9gFBpV1BE38QRVq9fG16B3bd3jR6YWlAPWgqEpTceS7xuYokw5AuFLTpi4TSVT5Jzp6TipzZ8K8oI0l7Ad6Gc3iKWS2o2Y1MZJy+JuFu5JyRJgnwq/5IUDB89LHaXi7brv9NJfb2mSk9sLR4t0MgrTi//7VinYXhCjzertWth3ijibUuL90MAlnpCxu/zdpYasEmyONbe9yr5RXmissOl2sHSZ2fiIU76GD3f7DHYEDD4B477COCJwAQVsKv9J3TBXVPkM7sM+6AfwED+TyWOV/CC+QbbMfSqNllpf9tk06YyX+bS9fsCWo7WP2KtviCfmhzOXfpcJdFmd3MTkT+0RS5O4JErW3SOjJqAtpDt0ZEmLqYPnVSOBQ9QTdNEwPMHcdfWhRvQF414tFT72091Hy7drlvuLdZHtJVoXkTPxhH9feAHOyMspstN/5xTxVSqox88HBWvJNQ4bYSwwKgfPqcmNtdLctlS8mDALvxiOHHHa9p9kl4Ft8GrngYugktOS6QS71zg7bRm21+nA1x5Qe1ykIMiVHUG3b5tVv7EmpyGlcvjpWbTkqgWmJcsSMJvYi20SxHuoINZEk7qTKcQd0Njq/8gtWv/TFEhW5Oi+wT2mcy70vaOkBeRzaiLn6f+G8KvBwO9ehu+VZJ6p57Xa11zBnrTbe2oN6Ckrx4Xg7EUbNLquJcdgMhEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KJFld7h6ltFN1UyR9xzFOEd565oxYw26iFHN6n89my1NXVgalcl4R2haQXE1yo08ZozdaZt1hYPNRAg1kfMhrWxmyCnJn0F/83vCJ4OKdHWiuqcYHoOjrY9PPh9Uit2csHHTlcmpzrrXasSNbpvoAJr0e9CZu5V2B02aKnAUsRUH6vmw+wib4WjRvNiko26ml3aICWzcmIW8mlK5A7w5lauEPYWuAJvTMwMcxRJzu6suiHQY938Glv+5GwAPbaYtl+WlOVG8ciGqWXj7UoyLTGX4X5JGdjUsNHsE21er9potZTrUzZGUha1dQ62eKLVBTsrWPcEFFu+5oxYd9M1RPzmd6mzlXIro9m5siTcQeLIqdOSkqIpA436zgwZzBSTpQywKjJueijDSi0geBT9AK9OFp0dR68yRAkJB/CqN+sgfTDGiGu0XRbotKjqP4Km6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:25:38.6860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f8001d-4dd3-4ac2-ec97-08df0cb13759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

test_numa_allocation() assumes that nodes 0 and 1 exist and are usable.
That is not guaranteed on systems with sparse or memoryless nodes, or
when a cpuset restricts the task.

Pick two nodes from MPOL_F_MEMS_ALLOWED and use MAXNODE_FOR_MASK() when
passing the masks to mbind().  Keep the two-node requirement because the
test verifies that pages are allocated on different nodes.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ea8e38064e83..cc5abca1adae 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -127,18 +127,19 @@ static void test_mbind(int fd, size_t total_size)
 static void test_numa_allocation(int fd, size_t total_size)
 {
 	unsigned long node0_mask, node1_mask;
-	unsigned long maxnode = 8;
+	unsigned long maxnode = MAXNODE_FOR_MASK(node0_mask);
+	unsigned long mems_allowed;
 	int nid0, nid1;
 	void *pages[4];
 	int status[4];
 	char *mem;
 	int i;
 
-	if (!is_multi_numa_node_system())
+	if (kvm_get_numa_memory_nodes(&mems_allowed) < 2)
 		return;
 
-	nid0 = 0;
-	nid1 = 1;
+	nid0 = kvm_get_next_numa_node(mems_allowed, -1);
+	nid1 = kvm_get_next_numa_node(mems_allowed, nid0);
 	node0_mask = BIT(nid0);
 	node1_mask = BIT(nid1);
 

-- 
2.43.0

