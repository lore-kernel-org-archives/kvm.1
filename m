Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EF282F21;
	Wed, 26 Aug 2026 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783787; cv=fail; b=NHK6LkYXNwWnJODg4jwrZYKk9+EdIduuZp5kAr/d5mbX+R2Unlo0BQqirwnODhHZNUJUikO74kRCUSE+rXh4NaQBWWFcZuj5+WJ4Gq7C7frrhKXCoTI9Nivo3+OBJS827zhnRUToE11Dga/T8E6o6GVIuhzFAHHIcr4fnPj21NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783787; c=relaxed/simple;
	bh=aWvriXNidefYQynXjKnhbYLGmpPRDzSmIU0xlCVGr3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nr9AXkVZJFBx5bWIZlzwhRyUlTlJcl4eoC21igFqvb2D1Q6rLqecokTnzy3bkEsqrjJ+dSRnkC4wOz39p+4LxcQYM1/xkv4fU1VTumNcBvNV3JwTg2EpBhLOKVA359XMQxL+rbIDjbA4N43Ls40Q4RYpkSiKvzR4/mi2UolcXQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KwIFKCIb; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KwIFKCIb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd5dhpRPAEqdZ830GF0VOHRDBaMRekU3SKEse88sdTQFlnT/ZzTUj1xHQJn2b3tL9HCzS06ZwFAfi8WDuk/PSwkSJrscgUo6Uwt7/w5EtJOAzYiHsJQNmtdGFFdN05mfkG98X8/f3EoLQYrr24HxpqmRvag0agS7p8/Q/AmoxWaqvtVkaAUTNLA+wOle77hMN2qBeCHnHc8mPIyciOIifikq8dLT7aQnDj3/SH8IfVeWAFIf3ujhsKk9qwGpHaht4ny7l+RwEvtjJaSRH1dvgIeBdsPFIuALzcos8kDqgBuBc8AzwqJl85Y1mY5kis7k5XPrZvK6wHxGrMPkOVaBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB5rLgaTanf6qlCmfnrSZiBCl9rseusyK9gCsuNrORw=;
 b=hAdGJPVpoD/oTkNH3KNo1jZ9Immq5L8MZ4saN4Z7UiNAci/Jc+j57arNGJMEbyYedEqyA/UlMFbasx+HjLJVpYYK1jHFcJfEJKNnAkYQ5NBnsLq/psn18/CtDSl8Gvc9Lr1D0S3GmSd4QaOxEwBEjGJBu6dPBgtCNsz+c8dYsZPy5dEIQnyp0oMVA6rkMcfGO7wXJDna/HUvEgQkv4BQ1tSUCoK5nC6Rw0QfN1VI+VfdMMt3/yU+wOHd+o/4ibFMZxNxZhnBY7jor6vBgg06jf0ajKpQgI/QeLUVubU+2OVutXVjxnLzmx4EY10DG1BQEVDZCtugNrvSDhD6V9txiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB5rLgaTanf6qlCmfnrSZiBCl9rseusyK9gCsuNrORw=;
 b=KwIFKCIbpNfTaFebRZH2pzZEK6gxlGsWCsStklI09hP+1piymJWRunYCU72nmnUii6pRQBKKQoUFvLGI+WGx+Ha8ejPZnLolHlon3QytyzB0QUcqos3Ppl72V2Wv2/vAqZKCqvzmbBr85iqySf2mS9JqF3x9PEie8zYonrda6KA=
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 22:36:19 +0000
Received: from BN3PEPF00022BBB.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::4c) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 22:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BN3PEPF00022BBB.mail.protection.outlook.com (10.167.248.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 22:36:19 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 17:36:17 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>, Nathan Fontenot <nathan.fontenot@amd.com>
Subject: [PATCH v5 4/8] KVM: selftests: sev_init2: Use BIT_ULL for VMSA feature bit definition
Date: Wed, 26 Aug 2026 17:35:06 -0500
Message-ID: <20260826223510.3669875-5-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826223510.3669875-1-kim.phillips@amd.com>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBB:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 7123ce0b-3f47-4068-f43c-08df03c272ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W7DFy9C0SCYE+yHzDVBCPW/eJwu6J5ZJDafy1jTkMHjq6bo9f/JLSPkIidCIVnawx1uMyK9laJqnifNMQn+6IhTQI7a+30W58zVyv80wrlEGs9gKXusrRe0hYSA6TjJKRAQ0F6JysaUnPxjUWKPeTVkdLI8AfOEqmmgEQ2kafs/QaUVhfFOxXqzseiCFi/k8C5dFdED/ViBU8s3fKl6KIFO3sr3SvUqXSmqxQWnyLTJ1caBub5XzCrptEv/8y1lvDnnZMyfVd/DysvPLWDWz1cZmTfK+cNvCi+YFJrsZ5Ita4SPY93LvP3qg1XROReXBDUwt2a4la/yT/wonnuyWXPMoxUbcB0hVCCbr398p4iTdmbutWwP6/dDGqrva+W9JIeRCoFMAoKyRV9PhE5MoS45yrob1hiYYmFHBtLN9HPZ1MCw5TjxqPVL4yyANfJHquqE6qZ2mVlvnO4bejriBb2LkUlrhpM5QPBVcbjLxsTTSJADLekKhpTNaJYSEU4mk7lBVVvlJCVZkaFeLC3GMJtG3o2z9dnPz+mH3ApwCPjvYHhQGB48p1qj123dq5cum/z2l3KO9zAuLZGIAc4ARAdwiWsg0ouE4oFF2+98ksay2rM18NqaNMfFdThnnPmODjVPUCEJFRCwpNaCclIWvXcTvp4hCLSNr6WJgtB6ceOhZItqkW38QN4XKIe13KvuxYKfbd+nYqJzJOYZN+lt3TA==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8JqTKEFNDsDBFhI545IlOtH829ryHl4WFrjlvIS5URoVFAhLygyeJKwEGRNINKKz8qWmDEuFmX/t/ahEC6S33itzgsC5Ul35n/U6OEYlx4AK3pG3pWU0mN1xDpSHjl7rFA1ftBaLIMr62xlY9zBHr6gFKVZ05CGYI1/pkU2rLy8QjuSFuqx7xzpgQYyMuZb35k17AnUEIrpqwMkwj0HhuCw4TckNh0MEbuuOcXxIeo0MzGe+oIy0z2j3wIoewycTzUQAPA0teO99L37sH2lXKKJHOcO+jubN/h9nA4KyhxGKcj2KlISJXgbLVCd2jZqxncVAYBEt1gqQx5IFfsoFEYiXw1Q/POGnDgp86/NO8AUF4TjAAbwmusvC62EBdAJd8/H96TMQbJt9iJmS6OgLoM2tlNThbRfXikYgfS/3bt3WYES97XrhPlJvDjmP09Uy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 22:36:19.0596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7123ce0b-3f47-4068-f43c-08df03c272ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

SVM_SEV_FEAT_DEBUG_SWAP was defined as 32u, a 32-bit unsigned literal.
The kernel's supported_vmsa_features is a u64 and uses BIT(5) for this
feature. Redefine the selftest macro with BIT_ULL(5) to match that
64-bit semantic and the BIT_ULL(n) form used by the additional feature
bits introduced later in this series, so every feature-bit definition in
the file is uniformly 64-bit wide. The value is unchanged (0x20); this
is a width/consistency cleanup only.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 tools/testing/selftests/kvm/x86/sev_init2_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 87bff4fbb7ed..61a94c6eec27 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -13,7 +13,7 @@
 #include "svm_util.h"
 #include "kselftest.h"
 
-#define SVM_SEV_FEAT_DEBUG_SWAP 32u
+#define SVM_SEV_FEAT_DEBUG_SWAP		BIT_ULL(5)
 
 /*
  * Some features may have hidden dependencies, or may only work
-- 
2.43.0

