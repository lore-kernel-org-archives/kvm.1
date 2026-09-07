Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53165415F3A;
	Mon,  7 Sep 2026 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765940; cv=fail; b=nBpw4790nV9Qk81ZpTDTWji6eg/gm3qlkKJQGj2mauN4GdipIrDEITDPnuU/yV1TGzr7SYIJN11+IXqw5rLWZUYfO0KZBg94KepP6EdEnDM2AniLO3HH0qzOq/WMy+p1GLaO+fPHQR/FcmRQXwG+D4uvqm8EFhS5x8/IgSiLLsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765940; c=relaxed/simple;
	bh=wJGzYlmfGqp8k2emw7SOgEW9PK15w8sBBTkuozEozyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X+2/iLHfhiDAFkJqFCsy5rvaCBKCJN2j+jFyFfiUc8zo3C2b6Z7EL9vEArtnMHuc1raC1bkxA+wd+f1L29mwxLkAk4pJwSdCuEC7R3/fncALQ1xDKL1TfWC44eH5MS/JOF38WSbcLjqZLmX2qCdAe2OnaTrv5UA+0PREspFI8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kJ/SYlE9; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kJ/SYlE9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfrvBnC10GMNfboxw3YAzVDqawrx3d5sRlsmdOwvVjvMKdGkY+zCUDYg/10NU7XdSnb/fCKAeQD8F8wpuMKQ4WdAjW6IwH9m9wN2CTXbXbea9Lrnaxmb8kMBcnMUNDblWnj6Eut1TW3BodisOOrET2Zhp86lL0UX8e0POaNRBIBWFd9itBGHQ3jH5joYzk+mFGih/Y92lzickOvY5dYFYXkqn0zRhNgDU9ibnBBVcYvk7YkrfhQWieqxuxgngONailjoHD0RrAflE/3yYUivXxZACawHUI03G/y8ZDbzi+OBvmlxAp0DHOONU/8fjQvd5bomOmwcXGQSXI4n9c+IXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+VJb8KAWLEU0qNIxxBZUOcoOZcSuH3xqDz8x45AsIo=;
 b=vbnm+3oxP3daOcjfy5NNQ9vgANYFfkeOQJZF8+daQFxhWdyEr7ZXrdIu2O/ScAJUpoDfLcYhSt03iDAuIM1B4whxoKp3W+hUZVwu0g6mrP+UdlVrJnXy5CKSkUmK+Q6rjZh+BApwtk6hboaea9aYD/e/xxKZJfYSpJpy/IFYHguc7H/iFIAG+0J0pWVrB7y2xw+s1xZnSlZLV8jYVj9NwFXHuRb1XO0WD4Sb6NfFG7tgbPM137SW2dl8Z7uQ0dFgO5+rWsBEpJ8KEvcAXxknJ8pOYvvpOQSVP1lIQwPZimfzxZx5oPVyewm3hTt7Td/sKZLs3v5X7OqKc3vuWnzl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+VJb8KAWLEU0qNIxxBZUOcoOZcSuH3xqDz8x45AsIo=;
 b=kJ/SYlE9Iq+fwjMSRA9zFq/VUMAc+EvkoYIzAseip3g/7mV4z6zCOXZUEMvTF7YHfJjihzar5VoQNj3v7fCA7O955L+diW5hsOGBx2fJr1MQ5yZQRAhPXPmTiZYpN2m9CjJFJ25RVO6OwtEDiIFGjhBV4HAjl15wbyeG15cxpJs=
Received: from MN2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:208:23b::33)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 07:25:35 +0000
Received: from BN3PEPF00022BBF.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::4b) by MN2PR11CA0028.outlook.office365.com
 (2603:10b6:208:23b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 07:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBF.mail.protection.outlook.com (10.167.248.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 07:25:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 02:25:31 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Mon, 7 Sep 2026 07:24:58 +0000
Subject: [PATCH v3 2/4] KVM: selftests: Use an allowed memory node in
 test_mbind()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260907-gmem-selftests-fix-v3-2-7a4be5c1cc8a@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788765924; l=1286;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=wJGzYlmfGqp8k2emw7SOgEW9PK15w8sBBTkuozEozyA=;
 b=xerR8Gg1d1IbkUCjOgfZDWyolx05ImS9kdmxDAIBJ9Q3M238EIU3/G2HSc8gekQpMuHyg4LdV
 ePF9TvLL8tSDfpkLkAZc46fUUJEfmB2j4/1GkECD0HqjpG0vFXOv/x6
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBF:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 10696e89-5ffc-4590-eee9-08df0cb1355d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|23010399003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8zgiaW8ZbTv8DM34LaPED9PJRqqM7JCtCIy9JaUDd/nPzgioIa3erb27mlcy1ShdmRyxdA9vqc9NTqPPcAOmlVww1uLrKnVgjHlSAYcwANNEOBEdZrZUbDWXVNKT6cua/eYJcnD7IvFVvyuC9in+jjY3R5f0jqn/jPHk/coeG9bswKuV1lnLbf+xxdgq1D9orc+9ecttwzygq26cdTKKzjBQ7JBbA243nKk8F4TywzuKzyFm7Q6hPnAJfwPqNzk/+JSIT98U37gZcxXixxBM70O422jbR+WrYe5h9OfHEjoN1T/Eyfv38Rb2cYi6UNu+xCbJks9+hoLNAg19T18HuwT56zJg226KKZTTZpuC8F7YHCIH0k/azYokeFZlIUUAVIfHBKTW92eJA8KqKkphkesU1rjhFY+cxN0S6YBgp2K28I7g0uuWgwYnZd+7vC43exUAPdZZGis/aBn6HlgSLvbdWc3tGP7OQDxnsnWYlUoKLF4AOJr22eO+HEkBRHsplPQij+/5LyexnU0+8KdhsQ4Rg7/OLPZZ3Ra6CyvdGb4uf5LqzHtLvYnxloN6312d7EGeEoMEcfLWwfSkXNLz8p8ivQ8guQFGASMKxQQVZ2k4GwCRY01MuV72ohun3QTWld8WOdEXhaPx2iAq2ZGGtTEBvjnV9QWxyvDLmqYe4hZRGhtIZYCFko4ZZf7PCZjAV0WL2GyCSCzq2FNQu0AEdA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w+8aWihI/4aCZlNXYZ4+EAbMToMDzvj4+qoeKe1EhO/yuvvNwc+bUgy7iMhG156LMaOyYjqOOfXI2NDMeAq6IuKSdq1pzMHaT8KG201rv0kcpoqYJ0THOd9ezs70xqoQVRsaRb+sMxAh9mNhPCApTjj/t89+tk/Ix3IIKOoXx7t/N2MH727Ttj3354xKLhzghh7WyrQraumSBijFGXxtuqdcc3LyMYHDmlh0JbT3qh0+a5H5S2Leqw5ZbzBpk2HSOe9EyXnRBvLOzDoLaj7NbLVYuQvczBw2l9MGWeOuCjfhr8b+Ru1bvl4p9SzxiNQKj+IKQhGFOxdCrHgEc8zQ2ZqPPSXnxOt9pZXuaGspXQEnhm+4oB1t7XAzK8mvrtirZT3skdCMLE0cUoMTZtCgi2kKyGYHJqT9ZWbN8BKcMpC5tANo5n6cx1h1DvCb5UiO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:25:35.3581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10696e89-5ffc-4590-eee9-08df0cb1355d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B

test_mbind() hardcodes node 0 and skips the test unless sysfs reports
more than one NUMA node.  This can fail if node 0 has no memory or is
excluded by the task's cpuset.

Pick a node from MPOL_F_MEMS_ALLOWED instead.  The test only needs one
node, so allow it to run on single-node systems too.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index b3bd03167ba8..ea8e38064e83 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -81,15 +81,16 @@ static void test_mbind(int fd, size_t total_size)
 	unsigned long nodemask = 0;
 	unsigned long maxnode = MAXNODE_FOR_MASK(nodemask);
 	unsigned long bind_nodemask;
+	unsigned long mems_allowed;
 	int policy;
 	char *mem;
 	int nid;
 	int ret;
 
-	if (!is_multi_numa_node_system())
+	if (!kvm_get_numa_memory_nodes(&mems_allowed))
 		return;
 
-	nid = 0;
+	nid = kvm_get_next_numa_node(mems_allowed, -1);
 	bind_nodemask = BIT(nid);
 
 	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);

-- 
2.43.0

