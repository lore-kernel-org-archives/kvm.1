Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194397;
	b=35ENke3WFfk3G0xRki/8cqGJzc3I65OLTnKfa1TwsOm/t+H1/jTTxTreuYN9TYYFtyGt
	 u0hx5+CAWJDoS71bxM0Lp8U2cMd6Sltw60w5+FyY3rrJ6ghBKuRz0BqkeXETwX31hAVh1
	 g1Jx9NoX4pRaaQQ/lCo6zv23M6bBTkCq/9F9YQY1OgQXbGobY+dsiRITr5K+TWf+XhGmA
	 N629YCc9fFdwstBkc47Y+UNsUX77hdbX71IfD4Dez6kiM84iUSXMQsdAF7NlJMj5VhG3c
	 5HeI/XJbMtCXJTFRwb+qS3lUGYn2UyVSpnri4RbyenpjTBrdPbZaJt4vkWCfoJmUKTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194397;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=q90vWAcqo869co26nDXvxhyGYVbX44zjZBWrAZAYNkc=;
	b=UuSTj8R7z+nkdRH3UYP0f9v+0pp1rMxdimNLhY9hBMgoqVepMDfRFWORJu5IF0fzwmzw
	 rdtZDhi7ES9RDNIXmp0s+A/N5pvjv9HbB6zMcfRCfY/X4gXnPjMLew0Rv2UOfMI4yD3Y8
	 Un2uAonF/qzSCZdFxix8ONjBff02nDUC3pRRDXdpi9chdsUGSQFqbYZdUyaIdMdZCnVcu
	 BkLLpq1PwT54vW4/Pux2x/k7nJKAE0iM4ArD2EtdauxosKVDzLISAzlBEY+NurWoWtMz4
	 W3IiMzn7auGzyLmBzAjtYzQSnklxUaOpmKGfVN9OwiHF/zj6a3awAOM/PDD9VLCLm4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="U9q5dmd/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.35
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE80606A321;
	Mon,  9 Nov 2026 03:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE80606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=U9q5dmd/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvn3AzITKWU/jmbjEuvF8IyxzxtcSMoqClUEEj4la/dfS40XizSAgDVBl5fLTaDaoBOLyN6QPQALf59UN9He5ZSayzYzEwZepphosbCM/h7uOlLilOGsF44tCCjdS7NV8Kfn8wut/BEJq/FbKdJe3OXWEZC339RREc5NJNCcBwQQQMDZeFNNwfo8jOShkES1Ktrh9qrFlDS844O1f3Tii7JoqyKGcxf6dhuo+Wl/t543wTKsVWkchD4v8W697KdafE7rWI3VsN8IIKw2DLX+RItniFYh1/i3Ggc12ahXBIT1RqE39fPmXYSrd0HTGNhIEFTz8SXBzTA2T/+azB83fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q90vWAcqo869co26nDXvxhyGYVbX44zjZBWrAZAYNkc=;
 b=pRcF7/vL0513NXQkdFZd02+J6PX5aIU7VBUhbfj8FUCyx62+Dst5X3cCkLdEdSXAv6RGVQEzijM2j6CAkFbvCfk9XHEbEjpx4OlBpgwDoMMfJ14QLxEghglIwETKi3FNattHDgv/4Jr7qjTM25TfZuHhvrljA+KFKYSGAINBc5Bc7/F4Z/sAavSmD6Y9qwvdyyKjAoxUTGQMzZePqO4a78KOKK4N94Z+qaIJdf4h1lBtHfu3wW5Kw5vXvl/tAjm0QOA02bdPySp8ZL49V0DAxI3X72ZNb/RWE4IS1htNUEb7KuEwi4OsU8qY/qGhZAJZXhre1Kz8gVDJomtRGOb0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q90vWAcqo869co26nDXvxhyGYVbX44zjZBWrAZAYNkc=;
 b=U9q5dmd/1k9M7nOTyHjZhqXaCk3Hip6fNL4I2qNA8BNIx5BKe28CteEE42opEEgwSa5q0CEmHKcCSknMhIOsEpahJYosLycwvqjg7Xiz8+78dfY8q/fRvjyIsxX6Oy0pTVv5+GQLPj1gZCH00f3fh6xPqJO0u71QHNnD1SoQ9Rs=
Received: from CH0PR03CA0325.namprd03.prod.outlook.com (2603:10b6:610:118::31)
 by IA4PR12MB996427.namprd12.prod.outlook.com (2603:10b6:207:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:19:05 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::6c) by CH0PR03CA0325.outlook.office365.com
 (2603:10b6:610:118::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 03:19:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:19:04 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:19:04 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>,
	"Thomas Lendacky" <thomas.lendacky@amd.com>
Subject: [RFC PATCH v5 1/8] x86/sev: Define the #HV doorbell page structure
Date: Mon, 9 Nov 2026 03:18:33 +0000
Message-ID: <9700efd65a1f45745841f10857efcad3c3613990.1794171754.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794171754.git.huibo.wang@amd.com>
References: <cover.1794171754.git.huibo.wang@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA4PR12MB996427:EE_
X-MS-Office365-Filtering-Correlation-Id: 493777a4-5b52-46f2-1f8c-08df3e1035a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|6133799003|10067099003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261021135927099003|56012099006|261026140227099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	U+qHZ+VNcMLaTxh0oZozobiU4R9693LEN33hlkh/NED6g8OskxUTew7ggqqrVcAYGF61B1VrkDAmuRDFdjwqhQv1wS8J7W9bEMTJrMEnaE5euxiz9kO5BZSRe2MIFRGM/E8MD1lBudOUPA2+tJh/DRZvj6Gvs0w2SuhMvZsmA34dXMEMJk4yE8bHk/Rhsv/XSf2SroJbCqjVXtnIHg30+579S34IfDNirm8PkK1JHMQYI0n5K9Qf/qWPxpdPoaQpUYrHXxXp8fPKXp69KfRI6oeY3XCZKV8LPBbkexMGviHQ+nX99oHFtd34T4HSyOcae2TeFCM4ajf/GfjizW0FjOUpv0Ws9U8fEAehzQJy3tXrO0PfAracuqqODafL2GCYjiejsDnD90M5PbCvdXupRa6WlJ+ogkcKQz2+9jUOC/lsu7EUeWiycIjlGEojq7mlA/0IdNPxyyGcflutS85Z1v5Xzcl3bpZB1ux/lp+FvwgwhLLJL/4JtvJaB0KTBMNYmLgl7FQmiD7qlWpGjMhNq6dG51LpDyZ9Uyx+TreB5leD+2sV2PEKDczgh53Vxm2SJHt37fl7kXCwlEltQgc5M6atzz8SBvzSs5FXBc1JWtaInReDwCAhMvdNrQ6hSknw0gMvMKEIdf4h6sGAP9bi2bP7Z4yxJWRhNYKl1jTRPQrDgumlGBa+0xLAK+BinOPBhebu+HPmZm5fsunaH1L6/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021135927099003)(56012099006)(261026140227099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nDYcsI7U02Dqvq4AHxGFI+I8chMeqUKtioHeKt4vh5ICALZrLM+XkBMmAbm0ikyVpbT7TR/x9pyEEgvSt9eoioywiNZ/x7onzofXFAjpC8BjGdbSy7vizsyw9TSIKS23vzm9wZf6srYGL+/i9lPtfN6DweWk6ErW5XKgPD3mNtovyd0ihN1o+Op8/mvp/MBMO/DtopPlCjk4NcoL1JdgevzReLQPY3Y0o2ojhF0NiseqTwZxoBxkfR3e478vISVefJwBSz4bMePJ8PTAerXULJ/7aDspXWLLAU1YSAP+Urk8jDUuG9Q0nwlkLjicHgWnfBHio+ebzGTVD4kFlQUpxsXfHzo/7Lm+0lvRX3rrnfMFjmq20Mgy+S0gGQ7Pb4+WWhMicHotVXxamzmkf3Up65jSWwxMHdqQccBV8uXqvt0LlkvwXFWeD5PyMciD9MHR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:19:04.9664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493777a4-5b52-46f2-1f8c-08df3e1035a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB996427

Restricted injection is a feature which enforces additional interrupt
and event injection security protections for a SEV-SNP guest. It
disables all hypervisor-based interrupt queuing and event injection of
all vectors except a new exception vector, #HV (28), which is reserved
for SNP guest use, but never generated by hardware. #HV is only allowed
to be injected into VMSAs that execute with Restricted Injection.

The guests running with the SNP restricted injection feature active
limit the host to ringing a doorbell with a #HV exception.

Define two fields in the #HV doorbell page: a pending event field, and
an EOI assist.

Create the structure definition for the #HV doorbell page as per GHCB
specification.

Co-developed-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 arch/x86/include/asm/svm.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..3b77eaac3d07 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -253,6 +253,39 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
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
+} __packed;
+
+struct hvdb {
+	struct hvdb_events events;
+
+	/* Remainder of the page is for software use */
+	u8 reserved[PAGE_SIZE - sizeof(struct hvdb_events)];
+} __packed;
 
 /* AVIC */
 #define AVIC_LOGICAL_ID_ENTRY_GUEST_PHYSICAL_ID_MASK	(0xFFULL)
@@ -569,6 +602,8 @@ static inline void __unused_size_checks(void)
 	BUILD_BUG_ON(sizeof(struct vmcb_control_area)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(offsetof(struct vmcb, save)	!= EXPECTED_VMCB_CONTROL_AREA_SIZE);
 	BUILD_BUG_ON(sizeof(struct ghcb)		!= EXPECTED_GHCB_SIZE);
+	BUILD_BUG_ON(sizeof(struct hvdb_events)		!= 64);
+	BUILD_BUG_ON(sizeof(struct hvdb)		!= 4096);
 
 	/* Check offsets of reserved fields */
 
-- 
2.43.0

