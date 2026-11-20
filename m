Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174190;
	b=xg8nYDdeKOpzEulttuOwd9ivW4L8eYw2Qe81a3F2VoXvF3464YqjMrzvF/qBGg/M3GRD
	 /7zjDGDDpbcvR9r2bzUtr9gtt7wcH1HrTWY+p9v/J2NoNNv/YcDpapmDuDcETPFUrw+9r
	 JPPep358+PPoNcWfnLz/CIYbBMqG1zsbAvmW9Eej/3xWu5d6jGmgjeq/GC9O3mT6TdCza
	 q/B23lyulkcX21X5u90xDG2MV8fCcf2tfskkWY3Fsmbyg/epkD+UGVaqvjlPxnqvxJvqB
	 hNtgq3SaYQ6C9SDwDcOQujATbkiL9D8lR9ijLoVjdOFG3HgoX1zX34qocfISsTy+q3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174190;
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
	bh=w/CCthtenjbRnr7jDc+cJHd62skVMzNG3wdlsv52gsY=;
	b=uF671NODfcNC2+dSq29FyQ+vq1Yksp+yZVwMbnVc640gaiMPj/GIUp6CfjCiR/CbPOak
	 ibOZTeAA4ml1pYoL2q155teHQkd9bqwSYpFW+QoKaPR2yAWSRMLKRtZDY7DORmP4TxqjQ
	 FYYJIH7Xzui5ELAHKdNAh9jbBoX07KsqbirJLOhiQXatu3ctZdJCaBlen/fKXgj2VtPLL
	 zahBpvFgMtgP9pgL5vMd0sYSGDz8xdbumM4Zd/LU0I+sgcV3x2fhTNm42OxIiQe+LO1XJ
	 LubuF5euPsvvMN4L5sqHuNmnabGMYsyks0VrVaiZmHhtyOgSlKjFXekKxkM7KVt+lQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QyJtnU+Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.14
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093A606A32A;
	Fri, 20 Nov 2026 11:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6093A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QyJtnU+Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpxcYMnmVA5VNh7lZNqYYIEs2x4wZFUDPHYR+bTpEUXexn4br0RyqI8i/f+2Gjzc6llHXsyFJ1Yk5BipGJ1eAzPTtSJwwwuMlHJY3OoHXkENsaiWRmMEasoh+7ZI2sDjDwVGWNNgYwnLe6yuUD1oDIXLsI6ZaYCX+UN430OxX8ImV/4H0Bif0f+GPpVbjRz67YUkDQ7ibikgKnbLMAFb8uTrs8vu19hmWiAhG+cAi/euwJj9k4N9zwBPhN0ytVPBK7yq0L79I/bSjIBYTsFWXWLTUbhXpKvDI1yR22Y0UjhFk25IFrsOes+VSlwSvU6EQFugmLPMwUtiIr4NcUdP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/CCthtenjbRnr7jDc+cJHd62skVMzNG3wdlsv52gsY=;
 b=C3qZJAoVxHmV9rsgYOfOuMCxfhwmyqXDEAmN9MvfcC3808HVV4FXFo9OS32tJnzFicz8U1jiS7xcwCRkN/OD2rQjZFmiYTxarPN9H1InF9Lr+AVeH5T/ODSjKfOri+3vZ58zvCcqlh6Yus3FK77O6ZlVP/0O5PA+4dSPc/wZ5yfQ4pWiYOSlKTupifSsCQmVBKu3CuYLhCvyHDT3+cGbt7rRUtULcbQgSRxf1A7knLX8K03QdQaaV9p0zrfPp+nZO2lECceiQuTshUMamKqcr9SBzjU3f6Qi3EqQC8xnzpv8YUFrkfwgzHG5nq2ZU+lvq3Y/Qa5+fuIR37RMbT5gfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/CCthtenjbRnr7jDc+cJHd62skVMzNG3wdlsv52gsY=;
 b=QyJtnU+ZH2nSb+QM199OO35H1/PGaoPOZiPMsCTt+MUKSMeHSTCE44NMqlXnQ79Q3GPQHRxBFz3YJfUy2X7LxuJopcMOaoTnrc8KRGlg4ScE3nRK7hGW5wk1xSiVvb26uXvN/MQuNyIfy04CXdRWI0GOwD0buSZm1aIgYD0jiVY=
Received: from DS7P220CA0066.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::17) by
 PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:29:03 +0000
Received: from CY8PEPF0000005B.namprd21.prod.outlook.com
 (2603:10b6:8:224:cafe::15) by DS7P220CA0066.outlook.office365.com
 (2603:10b6:8:224::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 11:29:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005B.mail.protection.outlook.com (10.167.247.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 20 Nov 2026 11:29:02 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 05:28:58 -0600
From: Shivank Garg <shivankg@amd.com>
Date: Fri, 20 Nov 2026 11:28:40 +0000
Subject: [PATCH RESEND v3 2/4] KVM: selftests: Use an allowed memory node
 in test_mbind()
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
Message-ID: <20261120-gmem-selftests-fix-v3-2-d94ffe17ead6@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174124; l=1286;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=dfMb0KMrIIhvCj0yfI80j/7GStnIWuirZxpeazE6WEo=;
 b=JHbQCnEjT1PABn4EcE2Q2d6d+rvfmpXwIcDZF0pHqHZJZj6F242DjwmOnZ5bM4oJE3UKVeLm3
 Gud+UWMZcJKBJPhpB8wKsTrA15AiJnfV4RXyfcdy7L+rIwyCZvIgMKZ
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005B:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: d5324d1d-16a1-4ab3-8efa-08df46f97ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|921020|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mxqSxk/RME4R3VG2E0q7SjVMbpqUOf7scmylAU0AD2wSpWG7ZB2WCSQoS7qw9ysnKdaRttZ78amcvb6BHHD70+cBiA8otsws9ZKy+OpTzKHEExJuNBZHv+W+GtSVH03oy8/U0+jCqIXiP1L4XeAeqjZdGh3x0idM0TDlki1qbdoEA84GPcvH6gNuBvKXOAZMVOQww9Czy/xMfic0tdIfCLLwwPttXnEHD3Je29lo+n8QFCGxMRPxz3lkCagU1PZ216FsTxJHfSyZ0VCnnuxoK0BboAJRg2O58wAC1f0NASHyqIAj89CWg55m645kE1UNVk7f5nMDs4ssa/oLM1Ug3NtN9l5eSg8+0qFBPD7jB9Gd/ju82zfBzYBafBVjGjOfRUzsg1BT22XEow4JCvBdrQQexk9T+rzuc1rUXGQ/TyZxwafFJPUcHQZljSazK1Fv4ewybb8dmtK9OSO3S7CLjviY0T270K1P6bwHzEJqtLy7hrf2CWteTJRGB7fPkR5q1mJ4C78vug043sh3xVkOqLANE8kgWqduLfrkYWetSL9vOf3/R9XfXZuy8vwxiB39EtLHLUt/KldI0sBbsA5iusmar98vpKdtCrsX2M6hsR8NjOTIOpesydsq88wlXg394W0vlJ43adXIVuVri4FXbkIQoM149ysXkp7jN+9mvJrTXiBxlBL09E7KiysgDhILEKzfPhGbmavEUHBTangq7bcu//vc/HOmxYGmCk15A0pY4jVuXJrq189ael/WDZBZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DRl8o9KzUn8pWoovaGdBDbtu5hIvCYyrZ1qj1T8s342LNNtwezyOwpfVJPM51eg+0vWlyT6IQcaat3fF5RKnPUxR4Qe6syDFssqa5QhRK2UqPKt4CLh30ssxAZzOVMO5HJw42cFIRj8fRo6VBcO+UAegVPxVO5Rdgtxxqtj0xa09VbmKWCBFe4xHeaZIR9ySyRmkqh9aZ9MW/h1jopNiG4ovCxsGCcD38LmGn1ii0tDiyh4CpUHRfJgW5/TxGUD+A3O8S/WR0ZVIjFbnzHGneSGwVMi1oU7NT0eZ1D0e7j75A1YtQtNu4Vl3FUPQj4fpl02z13kYPCIqAHUF+lVDHq8Stcjppw2hno8QUp54KV/WLMS2PySZzUV0Y/3uzA7JVRJ2JrGPfInkCz1AD8DWb4+Qb8wfFDFOFepqiG6XOOdYK8TyC437sU2+pA+Y0O8a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:29:02.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5324d1d-16a1-4ab3-8efa-08df46f97ac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000005B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164

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
2.53.0

