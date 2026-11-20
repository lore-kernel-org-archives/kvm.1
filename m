Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174158;
	b=zWpyrIxklOK3fkl2s79fd5hUkuASL10iFu/Zx8dwKxJbBj2pua4JQjxX02QjCeIgpUom
	 2/PPssiISFMbQGAjcNZwXTJGhbGOg+PkCtcGJuku4uYHkXwX1+ww4cs9YJsG7h6XeNZZ/
	 8/c4iQYOrKIUckDaiPuHnEysksnnKmU1kMjq35oQ+T2VJUk5mZS1i9jWhBSjTQzpDa2Lh
	 mQ118L3eTSieVgcuhbASSlzpfaTlMkce8z1oBmCwH4Nk3+sqmpJJ/gBLnxdGqJeiUXcWI
	 hMk2UMGoDIAtPnrYjvr1EM/ICQusv+D2DOpq5OpH4eeqjz+vqg9f1BdBCYXIf0Kx/ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174158;
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
	bh=77/4Pj9jkoYD8R26QJjz6p02Q6xMCetZakA4aAGZWgk=;
	b=B+Rqg8JvHd5MHM6RRe+9zP+qqCWkQhHiLwvj+GYGr+JKK7DdVqBHokYtF6S8LvsUqzS/
	 9/oAfsdC3MaDxnyIrI4BBjea6/V5Dqnh7gTCYcH6nHqFy0Yb++E2Z/p+OFQA8BBIKjAge
	 AA3p5tVLvEYpXpwf4z/7j83VY3ith6mvFJb3kL7uZeEASKqUcvnjXbcapAtOsSzARndPr
	 SCOD1Q0X1DxDDpl+as7L1p6qI0Jw/Wi98hS3gk/eYJ8ATxzozUDRKWPSraUpFn4BnvW3V
	 8zEi7YLisj4FwNP0egn0EQkgGD52kss/pztb35+Og49mRcaZYaXEPOliQzJwuRaAB5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ewJoa9zL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.3
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EAD606A33B;
	Fri, 20 Nov 2026 11:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08EAD606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ewJoa9zL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4jmfg5uREq6TPo7oN+X9dn+wiHqD5XvelmYDvmnZDakIMB6pg5G2elAaBZmU8gq8RBc8TtzsYsJGWne0pigWa0BJceENsNwIdMcnx7/avKmtiWpKJoixe5ZYY6pUcEAWcCGnA5AT0PQExrQKJql8wVCHZrlUA+zKkvVYQELlmi8N46FG+4Z4ymvyU/oARmhZFkxY15GGP3pYVjiinXbLrtLc6uhjJ5+r5Gg7oIQwC2mSfP+o0FcumEiIth8pYnQFMv7eeD6S3vdgSvDEdwZNC3qTEBZvinLRgGPflsw6NfiT/xdYCms7CnQp7uxohWh/qZDMd3bb7i7/UWkSqLxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77/4Pj9jkoYD8R26QJjz6p02Q6xMCetZakA4aAGZWgk=;
 b=IZJSTWnYjy/Nq3nEXLXmv20WPtVyRIrGPpVIzNvjt1JwgZYKkCGraEW4202kXE7sMYs7gK0+u4LQHghgXqwUNvW7oDc7cuIYWJiwz8Qz+5+VfIKCbrDgfC47t/4o6vMoh3pb47pDjQVWAb4LwiiU7OQIgbalzdRX64L2nAvOT+MJCu9JIQMhI/w3CFxo06LMhJ30ILGXO/K6MxyelWU7WYoYgDUMl+USgA8fgvxfd32rIX/blvquqI0x3wfuymrpea09TI5aWyYkYTt484Pgm1vVqaJ1LZTtnS6VisXGvuOIwrQ8Q0LGCenq7eVuFJY7uItGI+ohUtgdwN9kHL2LBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77/4Pj9jkoYD8R26QJjz6p02Q6xMCetZakA4aAGZWgk=;
 b=ewJoa9zLnnz9JE+QioEjXnHQGcOljZe5ZXteLjoFqOkJ7JIp9s2Y5rX0xLisdPxE9UEEKT/izCdbF9fl1zgFZ5y9P3ql853Dv52NE6xLEsck2ZT/mRlQNEmmGcAOesp7VFm7IJsh35t0x88YxPWticlFGavP07U0IikUHvmeEho=
Received: from PH8P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::17)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Fri, 20 Nov
 2026 11:29:12 +0000
Received: from CY8PEPF0000005E.namprd21.prod.outlook.com
 (2603:10b6:510:348:cafe::46) by PH8P220CA0034.outlook.office365.com
 (2603:10b6:510:348::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 11:29:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005E.mail.protection.outlook.com (10.167.247.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 20 Nov 2026 11:29:11 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 05:29:07 -0600
From: Shivank Garg <shivankg@amd.com>
Date: Fri, 20 Nov 2026 11:28:42 +0000
Subject: [PATCH RESEND v3 4/4] KVM: selftests: Drop unused sysfs NUMA
 helpers
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
Message-ID: <20261120-gmem-selftests-fix-v3-4-d94ffe17ead6@amd.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174124; l=2084;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=K7iRCpbATkBfsZazAGA/SCAppXCoJitr9wefoIXdhdc=;
 b=Faw98TTGjtjPsH5P3/dUWTHhMbgynuE7aWHzMnujYjSm7Pv78oPcYArl+3edXRXNGCIcYKwHH
 TwteSmC40mXAllRsQU8lbXAtmJp7DWUCqSIEHBN098VTOhMDe8UZQgH
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005E:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 031eeefa-601f-410c-75d4-08df46f97fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|36860700016|82310400026|261022075727099003|921020|261028144727099003|261026121527099003|261022105027099003|261026140227099003|56012099006|11063799006|261102123227099003|261009223027099003|261021123027099003|10067099003|261021121427099003|261021135927099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nHZju8TXikFOYsN63A1Ppjwy1MNNQCsTqP+/ptpHdw6wZYKfOymthE045fXhvSCRIhZKNNaQ99amepERs3XzwmTlkcJ6Ycc4HAMTWk+j4yXCB/vU3qsX44OGdhWLQrlcvgPXxo7YaN8cIEpz/0TDps4L5vWkK/9Z4EJGiP2esII18gptZ5tS3H2nAQwsXzLst76iEC7HOCufPyGIQmnnMTOEuqbQ8GZhlsyKsVKwvX7HuEsZSsesZ+Zj+bLxWXRWDxxMiW2umdPGrGKkFSSUra0kAWRWieSZ7T9C6mGghygXy+CR4a5T7OKFgfzgN9CUEzT7YPYPERIj46JqXsKXKgITK9CpejVN3lVeBUghgifKeLFtBy64/1ZfgWvatdW82E1GwwAnicNaNMh9sZDHG5+rnRSmP2zdTaodYfZOKMffpU1O9laXGLlHiA0BTnWWYwwGS0iwATVz1N3yX3Nr5QHsCB9gsblwJ6lzzDo9nyV7khSgXr1Engi2Vk5Um5S8yq1nfOlMkWqd17TZVOn3gXH1xRB4SU3kb6jnPeDqVcPvgZdvaUmeZTxkVoRGgrJEyFwBMLON6p4UIUkpaJKVQ0oA04qga0Z1y8CZI6VV0R8J7kXoPDkbBC9aIQVA8Ahqr2pqgTD57RgQYcjZkC/o+YdA/ZAQp94le0hMEezN8J9smwuDuHNQyPfUg/FoEipfA1DfRr8NMK83RWPvSIVKNzvwoxhn2/6POdpxvznRK0uVub0GhYLzMqG28hrjOkG9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(36860700016)(82310400026)(261022075727099003)(921020)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(56012099006)(11063799006)(261102123227099003)(261009223027099003)(261021123027099003)(10067099003)(261021121427099003)(261021135927099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ld8B9Nt1J5KBKU6lxmAk/ijdehyYbUo2ZolO90FGis3cODyoi0wS1JbIRDUHp41lXZ0IXv4ZbmVVsMueMSFLId7gWbWGY9Ak7ec78gayUkZUzaMVDpwhq60jrTK06IdG/9lPynlQMvss2W5jpnc4yZndFKy5m7djgN+Xgte9UZns2GV897hOR6PwnY0NRsWjVLrfJj1Pkjsd3UoEuNmsLDTfBaO2G5Phz3/cZb/WT7xiAb4r4Pm/EcguAMo3s8Abf0W1ICL0/PI/pU2310AmR/N1J1QGHpPMu/3GsE1O0YYvx718rwqwl7LTqv1XFWAS/GMnxgUihIy095rRjdvJ4keByp8cO7cEeztc4juH9lJlfO9wXQlEFhNs2CEiJ9xK0mkbFXFaZNb1KoysHBWSo46XvLZbqEQjz85vgdSxl9+a9q3gTc3PXqsiyx1ZPPmZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:29:11.2937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031eeefa-601f-410c-75d4-08df46f97fbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000005E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205

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
2.53.0

