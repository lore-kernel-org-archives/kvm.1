Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174278;
	b=E4gVgswkEInDnZnaDnJEyMlr8eAN8MVLaHMa7/5Nh/xxk0svQav+VR3z9ZOErlQc3fqI
	 OUlvlXrTzugD57r4xQaZO8ykNlt1KGwuVsK0UOQuuiCgheNNPOYOApgJumJOedkRelLj1
	 xZegNjUnMiIXRorhOsudrXcFSuJsreasMHW0g5BAd96VHKTvGc4dQUX2x1RRs2O8za+cV
	 T0hBFeyFRhKuq9Mle4OqqOJcGRENYPn6q4w8BLEsp4Gr3VkF2Gc7P/rfkyPDZ0CDD/biu
	 jg8KvdHXv1C4mp3o3OwVmu8XH1tuhMD+IpXZj9iq+/VLnRXuKOHSEQwuQ6vv+Ixcx1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174278;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1ZVPPvVtqrAB2c2mSje2erDG8+LKoPPZsSPx2xl3xQw=;
	b=xF3XLFSzhUkL0T2x8grgQBUxzyuAf4mWPK4tgftqhbS1yakwjblK03vnwAjgUt4dXiu+
	 kluLxauLqUrnMHIVzQohmR9n9kAiRFueXfS/x5JDlT7gIBXX8Q3Q2KpUGBkVWpNpziGPC
	 28sDmK6leohip2HLYMv5bWmdxpjtBQxsR5e/gtQ59W040qt4+lzn0mpIwURf15t6uf1OT
	 1pGQxuQxlj/0PX47Zh9wys9sqbZa8pcbvuxLlAWnXHCcNigYQi1s2kGTpBk/BSNDUWCX7
	 q47XfYsl8ey2dMghfMK6mSF/Pc8bV3aDuNYZZ9CjP3Bg5VFYs6+b/nCh4SceJNopdiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W9M5aqUK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.19
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C36606A320;
	Fri, 20 Nov 2026 11:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C36606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W9M5aqUK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XigPSE9036aBceEHfG37y0SEVP6lNqXdCiBOk8dnozuQpJwJnIr1/2t80gKC0AIpc/8PfPBKgFFXn2mldCm+RlA7+c3b0aGODgIhqKGyKGOTS9Imr1S71W8OOULpaP5eju7xY0vx/4QGnNd0m8Cck+TSX9Nqj2zYWzl719klnQ6y5Y+65xP52gHFfHFWKWp7L8Zctb2Q0xNheDDmauYz+je8RXIOllu9nvC9I5kzP/oARDDQwzKKT24ePcMr989CMDQm23crpSYNuLrpB05ilkfqJgS+mGeAEqpTN+ljHBxAz23FnSaFGm1f3Oat7iXe8C+s0skoEnjOv+u8VrOwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZVPPvVtqrAB2c2mSje2erDG8+LKoPPZsSPx2xl3xQw=;
 b=GX2nWMWvnQ76C7WdiZOAaraP79aSJYQkR6q5o5TjCvIW1eFytIWJQHdNZDd4Ai39QzrdxyZRyezOj26drtaGC6D+WiZxqMcBZsf8o3VuDvxnPzhOFy3nD6C97jHTiEot7/GGM76i+L4ZsOD/+BN2cB4mc6M4KpgFpTkYr/AZa8AGsCYbwOs9YXG/MQ+PjzwWR4CpnpXxMpnKGV+BQM5ncN3rVdAdJIgYMlIfsOLoamzvvrjpoHIUowTTxpHvGmftqizFg9UixsFLHtXGu0BZngjTHoiSDTd/1NmK7vZBXqOCtsHiQt0C/WYgqRF+nP1T9T9Aq5Ms+ZFeRK+IEdz7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZVPPvVtqrAB2c2mSje2erDG8+LKoPPZsSPx2xl3xQw=;
 b=W9M5aqUKuJ8Hdj8TSeOI0/3phjSmFfNOUNTvgdLXFw0xnIwKe58hwySOXTKaElR0P1ZJHGlD+0Bz/x3oIb2AxW+WCjuW3aIG4XY4zVUIFxvNZvf0sFims9qlKYvrdx/cKKakoeaQSBXjmR2N7cC8Y3dCp43Si/RX2E95uelqn6E=
Received: from PH7PR10CA0015.namprd10.prod.outlook.com (2603:10b6:510:23d::17)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Fri, 20 Nov
 2026 11:29:07 +0000
Received: from CY8PEPF0000005A.namprd21.prod.outlook.com
 (2603:10b6:510:23d:cafe::4b) by PH7PR10CA0015.outlook.office365.com
 (2603:10b6:510:23d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 11:29:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005A.mail.protection.outlook.com (10.167.247.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 20 Nov 2026 11:29:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 05:29:02 -0600
From: Shivank Garg <shivankg@amd.com>
Date: Fri, 20 Nov 2026 11:28:41 +0000
Subject: [PATCH RESEND v3 3/4] KVM: selftests: Use allowed memory nodes in
 test_numa_allocation()
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-gmem-selftests-fix-v3-3-d94ffe17ead6@amd.com>
References: <20261120-gmem-selftests-fix-v3-0-d94ffe17ead6@amd.com>
In-Reply-To: <20261120-gmem-selftests-fix-v3-0-d94ffe17ead6@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>, Fuad Tabba <fuad.tabba@linux.dev>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174124; l=1507;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=20U/34DFne+CbHctbIxfomvNZxZzlppwUKt2yR3HfHE=;
 b=r41RaUwPkkFtZRAjWZ+H9iS+GQsrelzLJSj9XqfNti4wCb4Cyl7XsAavgIjGDogMt4bHXLNUv
 F6La4Q2icv4AW4RxG4Wply3twXViRVDusEd7TzLI+ysa+HDoBEJNfV8
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005A:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ef15f9-20ec-49e8-0649-08df46f97d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|36860700016|82310400026|10067099003|11063799006|921020|261021121427099003|261009223027099003|261021123027099003|261102123227099003|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gSqiZYpjp+meLTGC0OLFyTMD/46CVK+qHrAZjQ4eK6CpfnBQgPGzsovNsJ9RU68WfvpI3Tj9La/z+u6qsuac3JpAWpKEs+REeCg/EyViuWN+yTFYrTjbQO81WDdbYnKEBLi6eJ94E9xxlmcaE+am5psBn5/p3YcvI6kDMgk9FQK0rFMo9IIpAfubSvYqZScZHBwXphEtHuXT9GK7EdUnPuGLExdBl+a3xVxgu2mqiwL6PUDQ3VEGoN90gIm8bdyz/FZbpvNx5pcqdMyDtMYVCwVeHWw1fJZm6P3zLgdh7whDnL4NXemR3Nw64ZrWbWp9dVxv/tNU4MSiMWTsA1ku6aUipVBPb+4WGhBpQ6nmblc2eAvOD7YG1t3BdfRlh6+QASl4+f3go5mAIytCQ7p86ADUJW+2UQG2gUpBM/5Zdr7YhoafUIOc/uQxEFfGstS6NKrnTF3cJMG4V56NY6zyiuyrNad5tS8BUoXIekwhi5fH9feXw7UoRPp3wKmbYykKfh0d66gPwgwkOMCokcWEhI5qMZYx6AwgUET2Fq1CLtSSvxNcFE8ccXE+sQDM54bWgBumf1N0JDEanubePis2h9gnPmkQ1Oc8sUm8mtR9Bj/GKKY7YOX5RmAJItIveC8TpEG2Z9GkLDm9pNK/0O/0ATnsAFMvDnLamFDjTU+hTrZao70aAsKqugiHxikVYrVvMMutkBjFqG6Fpp45VDQtLZROcbc81N8LE1NWFiHD59NtaQ2Hlp1JpZF/KGZbDf5P
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(921020)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ElZZpiXrnNb2FLYNJ2YOUxop3xZEYp6r3fhZ3hpTxtWq0AJIlEAbQCbA7jMdWqb88zakOe08RTwLhkV9Vy8UE3GjpqSUaZhxlvXmmMLa6HQdm8FsIvum4y4zx7LWGY2PWhftre/paIdmHkjjN/le5o6FZKas3Rx+RXUpVmjYWRYpiTJGrf0KOQbnJUR/xx6vr2WkW8yw5yy3fmNuGICvgx9eFc5R5lA0lK4JfvRGTE43/ch08e/EkVlyWsRFeCBNd+XxT38TpF8G2nqKPqJ1Jz+++TLTF8pvhg0a8nRHidblCi5u09aYM6ZLPFaZ7ksU4NY0fXLwY/0vL5NcFPg795mSKX6zGSuTDir0qip3fxcCD3k7rcxlIr3SX1Ih5bYDk+SqZ4zEIXiSFHVfc+PGibL4JME49duIspNg1kPD5N0DcC57sPrInUSwmg6nyo83
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:29:06.8920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ef15f9-20ec-49e8-0649-08df46f97d1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000005A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608

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
2.53.0

