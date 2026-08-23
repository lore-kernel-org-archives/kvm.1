Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C72C15A9;
	Sun, 23 Aug 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492214; cv=fail; b=IkHwvvNyotl9I9TdRqP7NkM2eDJy+9xMuDHKzztiG8hN9J6awzS+D1AwSnz0G7qbfWsBs+TPwsRJCc4kKBJSJNd7shEJT9ScOPrAiXzMhtYIRgx9OTmd3OCZinVmz+7xu02ZO66/6nom48CB/3x77Hz4MbK0XmgtBjGarDvfc4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492214; c=relaxed/simple;
	bh=z2wS0WJl0hB2QwVna8rxngZt4A92gUKEkN9b26PBg7E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=NFD0ecdpdYTyo/ozCOtm4dOT+wAP8PtDDsp7ihlhltqi00njazVRHbwP4pfJd/+OHw3p1ipTssugMp3vJWYbmre/i5ZcsKpHvcoT0uoB/yWK4CAnKGus8BpqG7/dxUouIOdtMy3XExClBV3N6oUzKCmBY7HYz52a981APdP96og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nax+V1Hg; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nax+V1Hg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFHGKO8b0besMnQu/Ea+FBK8JJLyBrKcxl397lPhb74RYWXDsJcnrpbJPPp8p1fQvNKqQNsnr+mRpSoyBAvnXXqyMQW4tv87HoICTxDgq9BSIJGUxg7aYIxKUXB0iBSzRyaQj92v16FVAqz95n9SzMB7MR/tehHw1D3vcG6J1A4vZMN+3Ah/Mu8Vh44TJp/U2UjiBlTxJv7FF2t4UVDk1KoLQMzPHhJCWllFKPjoPwl3PKmN97FVG6HhSerblG6rZIgvRvc9677J1aivdvdpcFoY/9mULBf53fvXeYLI03WDbbhiiOupHXLmX/i+c5wCb8tt/8Jvsd8bwnsoIzc8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1/P/obpcblMvrGiM2045ZeSSvZM+mvocNLJ0RgThRk=;
 b=jONKLZowvnBZGSkfaN2MbUZUq7LXA3i4a6maAT1mZS4OfVPQOhght9/eNTBTwLAT4YT85oyMDY4eug3P2bbbv77oMefIvHfsKBMmCLCjHdYRQgXnTvIuiBA53HkUib21di1AWgjKb9c7skMjQmA/aZ/JRO4qJubP94kS06GbO/crcoYkFvTPTMB4BLiIGqdXclcZ3b6OB6oRiipxeiyzpjm2N7WGtqkmllndXnVOtsWVgiuc7jV6Cb43wby744Xn4WtvUbsvDsP9yuV9rBhwzQCcXjh8LXeqv6ZoK+NR3/BX6MYkSNJC8XNbeed0vSinxjqef3q3E0hHqMcMjAV7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1/P/obpcblMvrGiM2045ZeSSvZM+mvocNLJ0RgThRk=;
 b=Nax+V1Hgpx2ozCU3Z+Ggy2JnqiQDa2gBVqXTer6hd5Xp4FENI+crOmBIM5QXr3vgM2wDgSndq9uWXlLhWHSeHykQ1ewrZiiER/BuZlxXr9kffsSQ8hobSLnveIPhnjUMubrRx7Eky+N+5ps/IGiwBePStsKw1683BsTtsZGPo68=
Received: from BYAPR21CA0026.namprd21.prod.outlook.com (2603:10b6:a03:114::36)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:36:46 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::28) by BYAPR21CA0026.outlook.office365.com
 (2603:10b6:a03:114::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.2 via Frontend Transport; Sun, 23
 Aug 2026 13:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 13:36:45 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 08:36:41 -0500
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH 0/5] KVM: guest_memfd: fix unbind race and NUMA selftests
Date: Sun, 23 Aug 2026 13:36:28 +0000
Message-ID: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFz3imoC/x2M0QpAQBAAf+XaZ1vnCsevyMNhsXFHt5KSf3d5n
 KaZB4Qik0CjHoh0sfAeEuSZgmFxYSbkMTEYbUptjUFZ+HJhxdmTx4lvlGPjE3vral1Uw1TbClJ
 8REryH7fd+36De8FZaAAAAA==
X-Change-ID: 20260822-shivank-gmem-fix-split-b8a9057cf987
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Jim Mattson
	<jmattson@google.com>, Peter Shier <pshier@google.com>, Ricardo Koller
	<ricarkol@google.com>, David Hildenbrand <david@kernel.org>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787492201; l=1339;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=z2wS0WJl0hB2QwVna8rxngZt4A92gUKEkN9b26PBg7E=;
 b=qVLb0qmx3CuBcKVsnahuNG0Bfiq7MbyNTnifkSELeDLPXzezNE6bS8dVXi9mDtk0uITasMI3i
 0VRD+JWfNtKDddfcAiZjhVpQbk45Cw2NYLz6HDgKW+4RoHCMoR1V4xw
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd8f6b9-5553-4274-97a8-08df011b932b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zYwqDPLs/sLqrT0ii9t4j37kaZappCsRadQSvw4JloiGVXKTnkjeC5t+SJl2/amYfrH4dGCiDC++FV6akv++Kf4+mgeyYByuJ1XIaWU3PCpr/5tOAZNkCiuG+8Ga6Tbvl3b5LVs6rqN3A4QrFwb1YBmWbwUdS7Jzb7v0UJ/NsR7m2jCZPnE0XO6SWFWL/8A7dacfusd2IiNUW7Kp+pvWKSuM5zPHW1/drcWJZqqXOoWE9mxUyABmVTMX/J6EDhJLN4B1J0Ck8Ncpzwc/hGva3KqOfRZAPt8hlcyOs7/SxF1qxgptwbsEjxMQidB7VYzH8gn/YMzYchdrRFQtXkPnPJx4qXuerO8bNeMnvrRVLLZYuy7p5noqnStxC6VirwnN3DJf4oU9y5w+DkMyeJA2l4zQ8W0Zky9IJvGNKuXn8sUIlCfIZ9v4/b4aSh2gYKP1z3FW8p5PFyQmntXV+7Ft5p4yvtQMNmyGJpwhwtoQ1+vRZHNP8/xirFrGpOM3SD8GAQZEP+1vjK//3lLIk3OKuqDZ9xn+QIF4WvwnZrc9QJ5+ZvTZDWqkiB5fR8DAugexgB6KSiEmI0slN3c1t7ul6oW+0WGCDnKvqWOkE39Y//49PpCy1sGwt3TDj31oEpkdFS6UtMhHaJ6h31LuBze2z9AaY1GcSvWXAH04LLYKqMSoXbNJAHiQ304YVBEMAaCOYeh/vdKDNM676FpOFHgfDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d2YoF7gqSw2lkCYY0GM9ovAkE4inwJqF1GYUQOsyyVtrGE7Oy1UwbUB0st+t6P6hvDPvP5soPUVTwMrwJujM26eOPr1bf1vVEB8ChaMYw7Qoo9PmHPjkT3cv7y/7hvpzYZW1QOVlEtkPYRWT1X/WaWwCRMMG7+7LxpI08xbboZAQJ0uNB+2+1MGKUsbg+BoVRFsMvEcuPPx6hSrcSpSXoSqFvpnz7AGCyP5Z3xy+YZlDoxkMgu0ly6/W1co6MqPJ3idmXP2w12W+Rxc6ng5rqtJ0aMoIbtEJV7j4u0RL0LQX2l9TC5y3y9JnGuMP3xHNAYZNBQVj8QJ+698c1ByAWxDXu+OU2JbcIbvLWzg2aLPNLOeccnZnLPdrGcVnYV0BK5sKDZRY/Z5PhrJkNJDGvVS1lcODPu9chh1MPWWoCpUo2mE1KGYgwB/km+sfhxIy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:36:45.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd8f6b9-5553-4274-97a8-08df011b932b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

Split out the guest_memfd folio migration series [1], where migration part
needs more discussion. These fixes, reported by Sashiko bot [2][3], are
independent of it and can be reviewed on their own.

[1] https://lore.kernel.org/all/20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com 
[2] https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel.org
[3] https://lore.kernel.org/all/20260728091945.EA6C31F000E9@smtp.kernel.org

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Shivank Garg (5):
      KVM: guest_memfd: take the invalidate lock when unbinding a dying file
      KVM: selftests: fix maxnode arguments in xapic_ipi_test
      KVM: selftests: use BITS_PER_TYPE() for NUMA masks
      KVM: selftests: add get_numa_mem_nodes()
      KVM: selftests: use allowed NUMA nodes in guest_memfd_test

 tools/testing/selftests/kvm/guest_memfd_test.c   | 86 ++++++++++++++++--------
 tools/testing/selftests/kvm/include/numaif.h     | 52 ++------------
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 14 ++--
 virt/kvm/guest_memfd.c                           | 23 ++++---
 4 files changed, 84 insertions(+), 91 deletions(-)
---
base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
change-id: 20260822-shivank-gmem-fix-split-b8a9057cf987

Best regards,
-- 
Shivank Garg <shivankg@amd.com>

