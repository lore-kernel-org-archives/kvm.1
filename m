Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F70B415F3C;
	Mon,  7 Sep 2026 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765948; cv=fail; b=mUKq7p3Qos5qLv9uMuQxkPatLzEB8CSbaVg6tZhi+OQZOkaHT2OGl0xEnX+azmPXB9ZAfW/BElfmzrZbbwo/5hgq+W59fPfRKnr4npdadmPu8eKmiQvuVz/WLd6FnSDpQaPwGufBTg7jAW31cUZ1QOrY/dlb3nfpHnqARE9v+Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765948; c=relaxed/simple;
	bh=yukzV0l0ZMwqNLaEq60fyFmbcjXdCl8xNnL0q0m7xp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L6U5DgXg6LqTeRKVfnCSEfqvhfi2dS/HT+6MLxDrgey0MAo296iiLWqZ90s3gbaTThsX2TIiO1XxqOdvUoX8q2EtX2ijlYA9DRWgjW0sXzZ4JRM32pHgYKZQKfofdQE3vUeBGzNW5RRk9FcnLEknvktfXn4mjtH+4hQdlPXCLwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xg64y+bn; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xg64y+bn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq5opcUtF733NaEZEoJ3CuiXReQlxn4eB1OhfgqMWPbgWp5XTFnzjz0JMHXDY8N+Ybja4IsQafju0Zdw4TOUJqP2CvIKZw0i6QH0YN28woOdalq+16aCJ4sFtmTnvtzWocviISLHDGpVeX0ipRTfA8LoMdZz057qh/OVrDuGa7yCZEyXJNia3n67Ky8CSM+QgzhY8Paa8cAe48jqqOB6+4FbaJ9hOIBUPiloNOWUpiXaNKOKxAvbJlfzXbXVpwmA6vPStKuvQw7Ma1R1vWUtyyROmyrOe4BV6tkWKZiBTIW7Io5nk9eNLhAPadbP7eDqnjcDsJk1/EJgiPp5ANdRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJZiJRDldMAZS2uz1ngzE1FHNtPDhjb+6i7g5ZUTCHk=;
 b=guWwR6fgmApgTK8UmA02e6ikbI9S0LwMRGddRWVfhkwzFNngzb9eF1+xNV4cacTR3/GaGlODARb1sKGb7pjIMoy1bhETLh7F75X7OY9NU3BxxLdlZbVqv3KL8R6GVq7yo2qBE/RwR2uuxFZEHoYE0FyMDL8jGHdLKJ6dVT2HIVxwBGlCAsSu+zsuCAEtz6/mSwMx5d/Arqilb0jszlV6CKP9Wxqm40OZNFwnbOTawxIprI4c+UJ9lgpYZBxW0x5EeWbNR/chWcA9CfhHZhw9Hw1FgM4W/HRgtKPC6F3b71J3I6oVJ2/0gYC598HN8JCgC+oVwI2v06YkoN28pBCrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJZiJRDldMAZS2uz1ngzE1FHNtPDhjb+6i7g5ZUTCHk=;
 b=xg64y+bnq4PJAWeJkcLTJOGl36gczuuvmZszhjYGMhME060+98a57wqBIoD9J82cE02w958wUwWykJmrEuFYBgJ+rITgBwpBfkYflIjFfWEKR+R12AEJuCJ9gIE9P1MkIzDxwDmkl36Uoxggxl0rAoKIgZVHM01Iw6podrw28NA=
Received: from IA1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::11)
 by DSVPR12MB931903.namprd12.prod.outlook.com (2603:10b6:8:4fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 07:25:44 +0000
Received: from BN3PEPF00022BBC.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::6c) by IA1P220CA0022.outlook.office365.com
 (2603:10b6:208:464::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 07:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBC.mail.protection.outlook.com (10.167.248.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 07:25:43 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 02:25:38 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Mon, 7 Sep 2026 07:25:00 +0000
Subject: [PATCH v3 4/4] KVM: selftests: Drop unused sysfs NUMA helpers
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260907-gmem-selftests-fix-v3-4-7a4be5c1cc8a@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788765924; l=2084;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=yukzV0l0ZMwqNLaEq60fyFmbcjXdCl8xNnL0q0m7xp4=;
 b=nk5q12Ni6eisGWNZhKA13XPJiYJXfvvROhNcHXxC9RBPVfNwRMCvGbLJ7w7aup1FwfFiGQeQC
 5nWRaF1DMFvDKk4je8wrd3Cc9VC0RhYLBqnkJxf4LJB/9RHtgBKLKcK
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBC:EE_|DSVPR12MB931903:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9346fe-a9cd-439f-f0f3-08df0cb13a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2q9gVvxOWXuR6nm903yTH0sCwemWUf+7c6I/s7OKOMS7jHf96G9cd4oJf5UNtl6yxMOzZsiiroOPKE3BthvvbiE3fLYCgw9bwOrQwSNvD9JGUSjYj+KL38q9uv1T3MLSOXuq+dhyCYJHM13BsFyFH+ZazlCfZuaEfTUxLae2bS71WEraIwPONgXrOVL8f0k/3uQBnsmDPS53X1zYpW1nUtfoQzlJ4OG1fL0/tt15IqtQhXbt7LbZPKlUVF9vpG8/J60Rc3GawLMbNWIGuuXnfAVF+y7RJfuyiEjq5CSYNOvbYESYt6MfdNaXDw68P3EbgRH0rnWmjKMBid8Wx0Et4qhaq1/gfq804k0Q0wnUFDxUuRDd8cVN0WLYfXKVgESTSyWh4qX9BKQZ9uRn2bnnxunCteDll6g47fjofd0hhtoZ74QtmYER1bN3ZxZdBmDH/JjWtxoNcR5TEHH4EKZ3s/Cci2QJJwTFv5vq658+WDSEKmiehgMrKNiLN63auQNiqQ5DvvVgjT/EjUCTW/cICVLF4ENOGmeS3D3oy5IXcTNwnxIRh7Wq44GTsC6b8sRIZxdORPNzw04e+AJAb1huS6DIP9Nth/eCpar1I8xIAEQG+5JkoyO2/RhKRqIKOqJ26TlTOR3CyTzsWNJLlMW+Ck9920wv4PrFTtABrxnyX9V2//MAfQEn9z00QlJhsQ9U
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rp9K5Gk5WufHxeAmMvrCZcJQUARhSiyYA3maFMNAceH7Fzdpo3IsdP5PusqJQhrbQrvGLKWw+vMVTac+5pzZdY5ri1AzNPvnIjzQzN4eQCItR6MvjfeYQ9QqSpJdMklP5+rQG7ZZV2RcHfGEjiZQdV+JmGhGRY5Y7UuI4JMUaF0PKHJfE1V12uNzAVlpiusAO8/cQBPCNeQKZi6J4cXupcLe/q/KfiKx2pRnJTvGrtsZmgDbfhtYI/mnhwQY0AGhIRbaT7L3V4hXE0KQ0Xp1hqGmh2NhE6SG0Kl2I2SKOMBVRcSWzy2tGUP1L26LODOO+2PhxhDgTY7Urm/aVArMPnvAk9CQ9b/CpZCzaoylUrmjqStP8hI5SQp6KNdFCUy7LBbUWsE6LyyRKKoC6cIskFQuBq0dOH7ECJIOEyjVFLJAkSGj6rfy0dOaVbavoGiw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:25:43.7322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9346fe-a9cd-439f-f0f3-08df0cb13a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB931903

No users of get_max_numa_node(), is_numa_available(), or
is_multi_numa_node_system() remain.  Remove the helpers and the now
unused dirent.h include.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 tools/testing/selftests/kvm/include/numaif.h | 52 ----------------------------
 1 file changed, 52 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 0945500c6322..c3884017ebb8 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -4,8 +4,6 @@
 #ifndef SELFTEST_KVM_NUMAIF_H
 #define SELFTEST_KVM_NUMAIF_H
 
-#include <dirent.h>
-
 #include <linux/bitmap.h>
 #include <linux/mempolicy.h>
 
@@ -73,54 +71,4 @@ static inline int kvm_get_next_numa_node(unsigned long nodemask, int from)
 	return to;
 }
 
-static inline int get_max_numa_node(void)
-{
-	struct dirent *de;
-	int max_node = 0;
-	DIR *d;
-
-	/*
-	 * Assume there's a single node if the kernel doesn't support NUMA,
-	 * or if no nodes are found.
-	 */
-	d = opendir("/sys/devices/system/node");
-	if (!d)
-		return 0;
-
-	while ((de = readdir(d)) != NULL) {
-		int node_id;
-		char *endptr;
-
-		if (strncmp(de->d_name, "node", 4) != 0)
-			continue;
-
-		node_id = strtol(de->d_name + 4, &endptr, 10);
-		if (*endptr != '\0')
-			continue;
-
-		if (node_id > max_node)
-			max_node = node_id;
-	}
-	closedir(d);
-
-	return max_node;
-}
-
-static bool is_numa_available(void)
-{
-	/*
-	 * Probe for NUMA by doing a dummy get_mempolicy().  If the syscall
-	 * fails with ENOSYS, then the kernel was built without NUMA support.
-	 * if the syscall fails with EPERM, then the process/user lacks the
-	 * necessary capabilities (CAP_SYS_NICE).
-	 */
-	return !get_mempolicy(NULL, NULL, 0, NULL, 0) ||
-		(errno != ENOSYS && errno != EPERM);
-}
-
-static inline bool is_multi_numa_node_system(void)
-{
-	return is_numa_available() && get_max_numa_node() >= 1;
-}
-
 #endif /* SELFTEST_KVM_NUMAIF_H */

-- 
2.43.0

