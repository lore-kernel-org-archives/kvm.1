Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF224570D7;
	Tue,  4 Aug 2026 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887855; cv=fail; b=H4JKHudkmSSjQNVycY2D9IYVUCzudsGb9DNzg+igz1y7vzKlg+5WBcLrurUfPhXAmdI0+aY+Se8YWv1KI2zqfcoSZ/5Y10IrN92jc4XlPvU9ibL6UYuH4jHgEbSqcPeQec2wjot7cxwDD8WArdkurSavSbm79JyEuvb/UL9J+ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887855; c=relaxed/simple;
	bh=vcOHw70gqx1utuf+a7+PmYUbcvELyPEmzScXy7/i4VU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFWIyQ0AUPNhHy6VtbUPon6drumaj9X9nt2VgwHu9UBvC5LUhUrccS0Tle1ZhogW7kLzoShVsMY5NtGqGVMacxNabYLSyfR3OQKqb8mns79cOIdBucvvWSs7axwvesvurd0zFoMHoGLRRMywBPebEEWW+SZx9o4cWgmwcTBVR8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cCFOnw4u; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cCFOnw4u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0Yx76byL6wpVZaF8iOoa/BKiB2seiYSpe1tlD4GALNBvqB6QiYjIP1GvAo7N46XSb5EfWKlbVKqfwqb+4DoW/N1SCzQe5WATZhmU5LZcS9PZ33VuOoddIGFe409VhTWMxUluFyhCN4qythIbc7olYmNYS/kbG/naZsSXE+tZvsSkWkUtn5UR0Hwu1xDjVd2+SD4CXI9xgP7SqvTPdI8tc4sq19+hdqcYFZIIW7SKq+yTDSiggRXwl41imqbnjeGxcU/pbAJb+R836N2yiVLQxrFmNCJXsqCQB8yB/6Ryi7s06QDPn5M2utWns0FGjReV5t0kmBNSQQVcylpRUB3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4zLir7r4cUE9wikPfOL7fM/empip98R+ra1pTfITR8=;
 b=BYAEYYC1jRyPjgDlExJJiOu58U1L2zGlspoY5KwQzdOUaTP513S+xyiBzL/fIWIfj+95vnQlCfk6A0m43dc5hcxAJZyirWIkG2iC5AdLJue4+aZt8fuQxE1faCjRhR9tamuIC+9nMk9bIiAetTK34ihWQA+AUzp/8G2rzmNVcI8rRGk5XD0nWa6E25/8N2fjqz/i8COX4SIo4J/51G+cjFpqKxkyA2gP3EYK+aeAiU0CgX7BXeDvchePkRSAeStxLy8skjr04G/c9KcxSKzCyICwY14qCKwBh+ZivMKBv41Zk5uFckU0DIwtfG2///sfIbcVLO7E6IvQWsXcjcElDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4zLir7r4cUE9wikPfOL7fM/empip98R+ra1pTfITR8=;
 b=cCFOnw4uhbP3JOnUdWN3MeWioFhG/xDD8ivVMLSYkvbjuB2eFvt0ItzLEp+izv3s8XE9/4pZcXpsVu7VdtdkiD+p5RyqEdTkiOL0fI9ih3LxO+tuGTqEAgFPqOEZyIvwRVP8f4cqAMsgYJ2MQbRdTAxJNxD3VZo+CP1i9INPF2c=
Received: from BLAP220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::34)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 23:57:30 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::a) by BLAP220CA0029.outlook.office365.com
 (2603:10b6:208:32c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 23:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:57:29 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:57:28 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>
Subject: [PATCH v4 05/10] KVM: SEV: Define SVM_SEV_FEAT_* flags using BIT_ULL()
Date: Tue, 4 Aug 2026 18:56:06 -0500
Message-ID: <20260804235611.4053375-6-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804235611.4053375-1-kim.phillips@amd.com>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: c2967767-8758-4fd2-8add-08def2842498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YZmNyc8E2xhGp3NQeYalCc1FE5KovITnNdjWB8gwhvMcsJPwn5CJ+0BIAtVdZwNJJMxiVcxzxU8QN+PDnYKyW7KAYk8Ls6xGmQNmeIo0OrdysiOWDijKPJ61q11gHHyYT+I846+pz6PFD7j5my5vcu+RQ+uoUHYR5nACpKlhb0vHPzEzubfU+FZ+hK3dL20yxZhl/yToRPbJiaQRxgmAQqB4wn5eaMcpEVGO1uDPSI2c2vjYUAWe1gyOyMrS3uR3qm9UJMUlBtJBRA4kkMVRbR75ScjTS9EhWlM95I/L0ujLLGIo+Xy5UxX73wK+HXROflKfmfXByjKkGOSG3o9TTvuE4SP8tijSNDmRaiX8DUjn0UVzg/lmWNa2doWs8+4L7XchrfT9aY01Jr77T3L0lC0Wr8jWcNeXOqfGyQPOLIr6WNwMDbvifoxjmVp7G00kpWeLZHe+j0JSRTzumlt4FBm7bs+F9eVdnnDZZ9izBdXOptof01QtRp2mnsfQkjLheze0rAlEShSqa7rUhAE4+g9IKSGiighy5s8ftKUmc98GuUW5x1nkKlyyleeT5AEE5HoBNNzabEgMVLhDEFjnYCLs7liRCPLYw+sp2I3b4sGNBNUBPr8QygpOFs+P3BrOpVB8CJ3OFTv3GP7GO+G8cQZVNpskD9dPZau4d4pVug0XqQJ/t2EQhmHlhGs3EqtsaNUPIHgp2wMjCcW053eDng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YUevFw78iNZNnieELHnz4dM7S3jfdPXtSmE2se+qnrEOc8JcVS4h43tIVE1dvx4rwCpeh3xj5uN6ScPY5xWkyWjxvFjXqiBwsQnlnAERSAHSnvesayLuEkU94vavYVr/2FjwvdrLksaAuInKrk8/2gAsdX5vvE0QrFWmP2TvfHppibxXxMOlox/h+ieCOC1BnVpZNq2ROTIwpP8eP4hnR/0nH8TwsakQ34T/EIA2FQjS5B/0/YPaWmlThDuLs2SI3B+0bQCHkdv+asdS9E/bXbKgZu0P1jpcBQqg172Ac2b6UxWr0sVfBFxNF2AECSEIZCJkMCphrkNGvW/xZibIO1LsEpeZls05HomEmRO/zYrY6OA6CwIFJwtAeKOokCbTqkAjGHZhXJRo3w5gy+Ayf1vfAdvsI6pYVBvHCXBTxoqb7YW95tL5baBtil6bBZK+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:57:29.6333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2967767-8758-4fd2-8add-08def2842498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

The VMSA's SEV_FEATURES field is 64 bits wide: struct sev_es_save_area's
sev_features is u64, as are the VMCB allowed_sev_features/guest_sev_features
controls and KVM's vmsa_features / sev_supported_vmsa_features tracking.
Define the SVM_SEV_FEAT_* flags with BIT_ULL() instead of BIT() to match
that width.

No functional change on x86-64, where unsigned long is already 64 bits and
every flag defined today is below bit 32.  It makes the flag type match the
architectural field, keeps composite masks such as the upcoming
SVM_SEV_FEAT_SNP_ONLY_MASK 64-bit, and avoids a latent trap should a future
flag land above bit 31.  The adjacent VMCB_ALLOWED_SEV_FEATURES_VALID
already uses BIT_ULL(63).

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Assisted-by: ClaudeCode:claude-opus-4-7
---
 arch/x86/include/asm/svm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index aa63431ba92c..52c900bf7e20 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -305,11 +305,11 @@ static_assert((AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == AVIC_MAX_
 static_assert((X2AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_MAX_PHYSICAL_ID);
 static_assert((X2AVIC_4K_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_4K_MAX_PHYSICAL_ID);
 
-#define SVM_SEV_FEAT_SNP_ACTIVE				BIT(0)
-#define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
-#define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
-#define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
-#define SVM_SEV_FEAT_SECURE_TSC				BIT(9)
+#define SVM_SEV_FEAT_SNP_ACTIVE				BIT_ULL(0)
+#define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT_ULL(3)
+#define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT_ULL(4)
+#define SVM_SEV_FEAT_DEBUG_SWAP				BIT_ULL(5)
+#define SVM_SEV_FEAT_SECURE_TSC				BIT_ULL(9)
 
 #define VMCB_ALLOWED_SEV_FEATURES_VALID			BIT_ULL(63)
 
-- 
2.43.0

