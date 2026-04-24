Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9DF288AD;
	Fri, 24 Apr 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052586; cv=fail; b=hnqB/z96P+ini/8pTU95eZCFzeU9crRGA4gGlqkpUpMMJ4g846sg7fUIIjqTA7p/e95gGkYZAgpjbFTnfgCAFsTFFm9Om06KV+niXrCZaQr4aaxni8QJnyUC4DeZQKSLgP+jXa6iNfPGtluZSYje++Sy8qw+9jHjSaXPqYS96EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052586; c=relaxed/simple;
	bh=kgJ+GeupMS3S9NyfTGpitSE9mo5zo4cZGfAJM+hdAjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lumXxGWeahdBpMxmeKIhaIjPexxGtRafpBGj1Sc1NAxpGn54dea1EP+HBl1joZLQOgf4pzB9VzE4luGv0G/S6ftKJnB56wdyCG8HgLCXdEp6TkWUnIxVeD29UNlB3oz1XO8Ko1UcE2NWzKe06FoENjDuKgZI2csRXPkFAihVwio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UlwdLhaB; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UlwdLhaB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIQe3IBnbWWwaBerqo9IxTbYjiVa3Y3jVq8YhuH17q7voDTFvhratAelQaJyYwjk29T5rBcK8HhVFdXHM8qRyQkjivtSVZaBKbS43t8HVUH8shyiOqpSPos3OrDWZzCp6D5BQ+9NSuNt5yf1OeaRpr5EmKjuODCqJabHGsFDj/jtyIJeZxF6+TVT3C0aWoM7CWTj7E7Tn7448A46eNqCAUDECING/rXsm1nhQPyFBBaoiINGgNdHffN8tfO6i8Pqw2ptBvu9866osVcnSGejE6bFQFYuzmptWvzoK1oS9TwlBK1+NjSwh/PrH8QFv8ALb3NZ2vJkGjmYYAmUeSvnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9RPexNeBttsmvrNwZ0q1oLXMeCZdzmXjxUCRXOEi84=;
 b=iw9HfghfKIjkVWsSPEufYE5bkgYFBuMtz6dJFn8eHVrMeeIXZlrMyL+Y6sBiTDk2xa0NlNF21h+l2ofiUZl+lZ8X45ID75zEnhy5BLwgF54iteTdq2kHsOCwwBKfH6IzMSHN0ssgE19oGaiLC7dnsIQwB9cT3ziJhYmKsvdzhnAvKw+LkyiWnlaThgbPEWhEkLidVXtdKnkLOu3drOtaim+c0PcYzXqmqhE7PTX0IymveJuXogeEFGnQ8aFMsDDgWjk233mhJjPEO0sUly277d0asT7/x1MK/hJXx7hIQTZKMK13b1d7V56IcDZ8Hy3XNJRt4SEGxYGUGHnh+r4msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9RPexNeBttsmvrNwZ0q1oLXMeCZdzmXjxUCRXOEi84=;
 b=UlwdLhaB+SIM73q3/y4jJVqUlY1IvZ9YRXB7USMPv3z8U6/sMLEMYjd87bGg5NOFyTpp5rF0OQxWsF48Vl+iqs0zwd6aanrnS2W/xbcElVpDLpXXsnCNH2afbbk9cWKYEgDfa+Q+kGdigQpOjNSFyc+t+JwkAbe5btiB6YeJKDU=
Received: from BN9PR03CA0420.namprd03.prod.outlook.com (2603:10b6:408:111::35)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 17:42:58 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::26) by BN9PR03CA0420.outlook.office365.com
 (2603:10b6:408:111::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 17:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 17:42:58 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 12:42:57 -0500
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>, Melody Wang
	<huibo.wang@amd.com>
Subject: [PATCH v4 1/7] x86/sev: Define the #HV doorbell page structure
Date: Fri, 24 Apr 2026 17:42:05 +0000
Message-ID: <9d2fd7cf59a31e7df23fe24fb3c177c2a272d4a6.1777048608.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777048608.git.huibo.wang@amd.com>
References: <cover.1777048608.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f02d0c2-f3ca-4cb7-74ad-08dea228ec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Q1VBImQ6qcoy4K5IKex4NmGtp7xsQhu2hjxrmjACE9Zo1QDufG3nfGUgZ8ZsduUmwObmLOIq+DuZFmbRSR9mG1qWfeZKTJUxaRHihS6l1VuOntDmSewc4OATOFVI0Wf+Hskc+JaLrKMVenUDy35pxZgmZsQChL+pAJb2e/z1BoyQh/6diX7ObIPWLQOaCh/c+hLRpAu7EVpQLoDUh9s4qKzyaXszRk/UoiSXoe9gY7StmOMdgyS1wOrXe9U+YriP+aLZmt750zFllGPsiiev0O6F3MvxJ4TfkGae3Si+9q6uAphoh6oufpot3qM5CByeTbQBsr92IwaPuYykIiw1dFv3Pyal3Mlr4rLzeybPD3VgA9TGROpVrIJVGIiCtB5Gi3vX1idfDWf+rl8JIG9+X2sh1u8YTbfH2svZuOZa2EgYtV5W/uVqUixAgYc0QfzNptczhS+LHdCVkrCMeu0s+iahqyPfh8d1iPCLUEl4t0BMKualLt407av2NkxUP5J7eV82iEBjzCFzwEjItoacGrNyLwWgrECow4vaSFVTWzK1uY5EOBDH6is9XBZs6Psli2a5KMhOtmyjXpFbIy2ZcUq6uIaxHRH/q887PKayT/MT3wL3xmQXqyf9NIPJDYJiFTp5VgQCmoKxQrDUDuSn4iiEguozBnSg30z+KvpvLYvgwcItbkgGzIqZ+Jdq3x1smG+CuI7H0gaOW3gdx9v60up1g4efxOrp7x4P8R5tN0KW3+ZftMm7YALU5w+7NESHvYOOpBCv2yAfiLks3U4vAA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TbPfdMLZJGMy2a4/RRK7Ls7XcCQFK6ppZUng/kZohy32PXOmvGBCNV4bbyXoEuJl/1mJUS0kkggdeSE/IzHDtxXG1Xkw0RfKjAy1cos/AH+J4Lsc93AefxiD3xLTKzhxhKqNbJYaaZ9S5K4sIbGE7RnSwJUzHbDsbPs0WJSBwWgmFXhb2Bk/KTiDo7VXJxUT8d1Ex9ZTx6rVru/WGjC/oaUX3gUORJ7mFSWzLI6RCsKKSlrVhQbx3dQPNDtbqBdv+P7WYR/Gt5nx5i1xquG2EDCpIm1Qmy+wD7CKxYW3UcG83jJa6qiBXFPRJTEFKeyVJ9t2GUdQUEUMvkrUkOsYCtBbwEMa9rI1Hk/65h8gYLzSulHJl6rJEeWVkdL4SXE8oJxg5Du/kGD73OYwn/YbQhtw0Y82ANRaSjgbizAZ2be9njhESIV/HgzSqX4PUkWJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:42:58.3964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f02d0c2-f3ca-4cb7-74ad-08dea228ec8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

Restricted injection is a feature which enforces additional interrupt and
event injection security protections for a SEV-SNP guest. It disables all
hypervisor-based interrupt queuing and event injection of all vectors except
a new exception vector, #HV (28), which is reserved for SNP guest use, but
never generated by hardware. #HV is only allowed to be injected into VMSAs
that execute with Restricted Injection.

The guests running with the SNP restricted injection feature active limit the
host to ringing a doorbell with a #HV exception.

Define two fields in the #HV doorbell page: a pending event field, and an EOI
assist.

Create the structure definition for the #HV doorbell page as per GHCB
specification.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/svm.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index bcfeb5e7c0ed..9822b0b346ae 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -252,6 +252,39 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_TSC_RATIO_MAX	0x000000ffffffffffULL
 #define SVM_TSC_RATIO_DEFAULT	0x0100000000ULL
 
+/*
+ * Hypervisor doorbell page:
+ *
+ * Used when Restricted Injection is enabled for a VM. One page in size that
+ * is shared between the guest and hypervisor to communicate exception and
+ * interrupt events.
+ */
+struct hvdb_events {
+	/* First 64 bytes of HV doorbell page defined in GHCB specification */
+	union {
+		struct {
+			/* Non-maskable event indicators */
+			u16 vector:		8,
+			    nmi:		1,
+			    mce:		1,
+			    reserved2:		5,
+			    no_further_signal:	1;
+		};
+
+		u16 pending_events;
+	};
+
+	u8 no_eoi_required;
+
+	u8 reserved3[61];
+};
+
+struct hvdb {
+	struct hvdb_events events;
+
+	/* Remainder of the page is for software use */
+	u8 reserved[PAGE_SIZE - sizeof(struct hvdb_events)];
+};
 
 /* AVIC */
 #define AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK	(0xFFULL)
-- 
2.43.0

