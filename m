Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954804;
	b=TXrNMjtoNVdAVJnYqUIXLooeMrO7vLZo9V1iPLFzWd3/Kd+IMSwH4xR4ZkeXjVD28BAV
	 4rKJnU1rVkE8+neQKKJdR/svWca9ydZJWEiDKd4j+5E3Liu3Z1sCSK4+OVs6O8FdC572f
	 nT7nosAXOWjAd5en3QNXt6mNTSPsrTAEh1oe+f/Xnmsmb27bKGkw1ThlPexVYRS75JhqK
	 ImjJhvVdNk64iJ1XWeAZQMmjAYCMZCSYm2N/4U+8phudGw9LtM3TBpZpsTSaVbseTPCqa
	 S6jq/w3AQpEjCng9s7G6TsNMV1zx21mniaMXf+c8WPlwS7XDrbq5MJyYfecVGU9t+HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954804;
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
	bh=dEpOQlDj2yMie+El443kI+M/wG34gkJNa1oa3hDIzrQ=;
	b=BIGnQyEgEDbyAPQnPLrf2/2fthd2kD0J+EBoVqrLFC65v8a03/uNjsjSRCezyioafob6
	 uFg1iX3OE7uapGeREOIHkPt2HS1m4CQE8SOYpxT2+GhbzGo041jhdRpXzb2KYQ3GzY7E0
	 P347RXEUijge7TbfjoYVY+U5X8JL5e84CQOfVnXiFih2TYqJ8OAVzgfXv5cypq4OC2++P
	 ty1NWTuGEd2qzexE18vbWGHjAMmlSeHw2pwwr3LdVxbv0W2GwS/XPBfUyK3h28pV0wA/e
	 5wegOwj0o7Gi9pN+1L7+2TrH/Qv/nYXuUpqmXxGLgZtdpA/jIHY61hMEyRFtCbr+8mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Lhssemgp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.46
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDEE606A31C;
	Tue, 17 Nov 2026 22:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDEE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Lhssemgp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URIy764CkbNkieVeyATPVQtoSdijROe93ST7DgDw/Kzhbh9HqsJso8HPP8fC6RsZt/5LVQKX4sgwBKRmYVEOT44Cs2vgYXwhDZJV0UklymzWPYL1P+oT2E8DYE/zjcCHBRCRt4bKG1+Fauf3C9tVx4Dv0q0OubYWsnWX0VefBE96DTwipIAhcOC55HRjynfn+LBQtA6Qdbhkdw6Vj+l0XP9/bafbl9dZu9A7N4zK5rnZYk4anzM14Zj/OQqFRtlBCYwb3frtZ7Xx/5tw3yD4qVjx/9chEIyoyvDiG6E2OkcTjDenJNBqZqM9D7SwzayiU2rMvW3qviMC18OUhzuhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEpOQlDj2yMie+El443kI+M/wG34gkJNa1oa3hDIzrQ=;
 b=mZHewklcgieUKcqh6qPKsKR76gIARefhIfq0dJiZ+cqx2pdVa/uespdiT8ic+sqiAzYeC81Ge8xEziQUllSJ3Guqzem9oXGpgZhyXIEUk3YtX60ahGhXsSmXMUO2qSC2ix1dGCuPJV6BLeOrlbtxdepfd4RhC6uq8bYq5Bk0KQSpf37cIwayfylgYk/MXCB5x8iP5YieOo3XM1CscIsvIY6r28WSagceHf5EQwJWn4CHIq+xRyOrfkbdZGIvUvFfqiZcJ3twRbfjvIL79p7F87gEcYVnA3FLcbM3+vSfIbX0RxKcwkX0o7EGShnGIgpJWl9qrgRokB7vu1CXes2hAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEpOQlDj2yMie+El443kI+M/wG34gkJNa1oa3hDIzrQ=;
 b=LhssemgpkFJrDEFTriddr7e6X6U8QxnGKXzpfd3Mqji6EdxKanXhG4Bx3nJeCJfEOtfGrNQEDvTG5NbOTd695bBayQqDkBRvyvuHmmw+9goYgM85ysKBzq7/7/SVVWMhKeVauuyQnpZFacowFCu4Z9Bdrtv11sm7ngdlT8D4tiM=
Received: from CH0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:610:75::33)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:33:20 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::4f) by CH0PR04CA0118.outlook.office365.com
 (2603:10b6:610:75::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 22:33:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 22:33:18 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 16:33:17 -0600
From: Kim Phillips <kim.phillips@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <tglx@kernel.org>, <mingo@redhat.com>,
	<ardb@kernel.org>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <kvm@vger.kernel.org>,
	Kim Phillips <kim.phillips@amd.com>, Nathan Fontenot
	<nathan.fontenot@amd.com>
Subject: [PATCH 1/3] x86/sev: Report distinct termination reasons for generic requests
Date: Tue, 17 Nov 2026 16:32:55 -0600
Message-ID: <20261117223257.748178-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117223257.748178-1-kim.phillips@amd.com>
References: <20261117223257.748178-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 326544c9-b325-46e6-9ba3-08df44fac77b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|18002099003|22082099003|6133799003|3023799007|921020|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|261021123027099003|261009223027099003|261021135927099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	IBesErKlTL8qOhG/LSIvKJTDSdj8J8TeAU9NLmPWpiI2aR9+gmuvW1qgyCiDJ8mSTw9hnbNrxRGcWbeaoNQKuBozpVxKpJXN2jAV8ubGoXGIbCMOHn30pv0XPkjRR5H65Cp4I/FaUeRk1Ax06M8cxSlCMA5ifZ9BXsrU65D6SpajIj32beRww8qtTZ4tWKmYpesFIadG/AeShtvckKp0LVQW1b6PogfS3ODw3FIcKuuCO0k3xFvzvWEdaAH6XA6J+0VZQHyWElfyv7XI5VXXbqeLeI3QSkbc8hO3Vv1KSpLzND6emVhyCRtc+rnr/tTY+KFEyZfLUBPo4Ika+TbPmlkIzCx10uuusxi/BRxqGO18vNJl/FZD/MLIvb0/dycgCB9zC5EcPyGobu/2tijRU5IpKRJjQkfzAMG17ddiPvAhDCgpWcIYsa9KnVQjhitNFSsI16xzXiD7bk0TqCfQWIInttW4Y2xl3I9tfibT95d2MeRz5J7+OMUXwra1a51JO7xeO6agfpO7LyqBzOTGKDg8MwGetwYHzN8gFcoW33cqQYbamN0LMdJ7A7UpH7cd1Y29fop0nphzsgUZOkVEMOi1wgGQJW2dLWE6LPwIwRf+bZHgvojnuJ5uE9AdlAehmZA/eTnuE4xSe49WaxPlPgoa7Vyuv9D6JDTDBnamQHV8q9sME9vJMpEMwCg/ksVc1FEFa5vbg8IRUXRdtDv2vhl7BxTyaafoACfsg0w+lAZR/WoDqHVh6QFqUeoWwqbE
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(921020)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021135927099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E+pgmSaN6Ol+M1gE4F6XiEkCRwwuqA4zzhPgJwH+QM4Plumk4IJ1rcFwHOMa9Ysbe8OG/Nkqog6GBBt760Ma9LVgupfUycjkuS78ZuG5J8zwgDxEeElktvcw/f8LbDhCRf3RrVYeRlQhLuCt11UIUTuuCrIOFqELge1WKBFlGB4aPkOK5c/ed2S2QDwxigSmHmIcl7QSA/qQZf28FQQ2qwwSv7Y7ap4mGjTVp1ZK09CkhP15c0luAHPIwz003ABDLRC2cj/+JBVQD+QRuf3VL7xZFZHIpw4XOavxfEcRBf/RmC1bWVXxrpd5y63qr+jray5zIzpl7QTUgnaduS/POjQKvzCADB2aK4qDXRbItH3QGcvDJ3sRyhAk3qj5mcnjwBHIxECAEQFkxnc0Po5vxTP63cLQVHE8jSGqjujf+B2Oloss9EIYTK0gzFEYf7Fk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:33:18.8772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326544c9-b325-46e6-9ba3-08df44fac77b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082

Six SEV failure sites terminate the guest with the generic
(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ) reason pair. Since the GHCB MSR
termination protocol only conveys a 4-bit reason set and an 8-bit reason
code to the hypervisor, all of these failures are indistinguishable from
the VMM's point of view, which makes triaging a dead guest harder in
environments without a working console.

Add distinct Linux-specific reason codes and switch each generic callsite
to a specific (SEV_TERM_SET_LINUX, GHCB_TERM_*) pair so the failing
component is identifiable from the termination code alone. The four #VC
handling failures (decompressor, MSR-protocol, early boot and runtime)
share a single GHCB_TERM_VC_FAIL code as they represent the same failure
class; the remaining two sites use GHCB_TERM_GHCB_SETUP and
GHCB_TERM_NEGOTIATE.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 arch/x86/boot/compressed/sev-handle-vc.c | 4 ++--
 arch/x86/boot/startup/sev-shared.c       | 2 +-
 arch/x86/coco/sev/core.c                 | 2 +-
 arch/x86/coco/sev/vc-handle.c            | 4 ++--
 arch/x86/include/asm/sev-common.h        | 3 +++
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-handle-vc.c b/arch/x86/boot/compressed/sev-handle-vc.c
index 030001b46554..8a4963193114 100644
--- a/arch/x86/boot/compressed/sev-handle-vc.c
+++ b/arch/x86/boot/compressed/sev-handle-vc.c
@@ -101,7 +101,7 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	enum es_result result;
 
 	if (!boot_ghcb && !early_setup_ghcb())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_GHCB_SETUP);
 
 	vc_ghcb_invalidate(boot_ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
@@ -132,5 +132,5 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
 	else if (result != ES_RETRY)
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_VC_FAIL);
 }
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index d9ac3a929d33..1e4fef117171 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -514,7 +514,7 @@ void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 fail:
 	/* Terminate the guest */
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_VC_FAIL);
 }
 
 struct cc_setup_data {
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index eb2e853e950a..e94746b78e9a 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1108,7 +1108,7 @@ void setup_ghcb(void)
 	 * This gets called only in the BSP boot phase.
 	 */
 	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NEGOTIATE);
 
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index f25d302efceb..fc390c0deb55 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -975,7 +975,7 @@ noinstr void kernel_exc_vmm_communication(struct pt_regs *regs, unsigned long er
 		show_regs(regs);
 
 		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_VC_FAIL);
 
 		/* If that fails and we get here - just panic */
 		panic("Returned from Terminate-Request to Hypervisor\n");
@@ -1067,6 +1067,6 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
 fail:
 	show_regs(regs);
 
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_VC_FAIL);
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 01a6e4dbe423..3717796c4673 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -209,6 +209,9 @@ struct snp_psc_desc {
 #define GHCB_TERM_SECURE_TSC		10	/* Secure TSC initialization failed */
 #define GHCB_TERM_SVSM_CA_REMAP_FAIL	11	/* SVSM is present but CA could not be remapped */
 #define GHCB_TERM_SAVIC_FAIL		12	/* Secure AVIC-specific failure */
+#define GHCB_TERM_VC_FAIL		13	/* #VC exception handling failure */
+#define GHCB_TERM_GHCB_SETUP		14	/* GHCB setup/mapping failure */
+#define GHCB_TERM_NEGOTIATE		15	/* HV GHCB protocol negotiation failure */
 
 #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
 
-- 
2.43.0

