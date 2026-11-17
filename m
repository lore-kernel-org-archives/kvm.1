Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794954819;
	b=skLAyi5h9ofME66bVD4bgQeY7DtSbX1E2LO5ZFjrnS4L6EW0I3fu+rTJ0EM1KCJRK4Ja
	 CCvcPCWnIOQeCQo5IFH0UQIvtPeeDe/XQyAoXPKvhj5D1nPusb/i39Nn+qiclO26X60tQ
	 TqL82k8yasrjvzRZXkrF9zW30RcQJyhPf1JzsmnO9DWQki7gzZUxuUHYZovukx8pjy2jJ
	 ccA6YG62HHNwfcFkS8wg917q1YL3uJdmvfwgUeXDRqlM83h3CsMvFzTMhTAwGorCOj6Nm
	 UvMXPTcHj7WT524tRc/fACAzDc0yF6ZmIwxeWmW6gD7k8Il5tT9BN2oCcZm+gDKdbxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954819;
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
	bh=wLusZwO1Xf5z3k4Tj81EHswViQyEEldX/YQriZOrA3s=;
	b=lK/EvRJZCJfT7YAGOSIi7VT0zmg4vyIuhFCXbTUeufgT0YcBJSO4wfE3JmuK07W2z3QD
	 Y+tG67WsY70fC6NgorDkNdK9Un1+b2QVxfwAKAcx5hOMSItsWPfDd86jGaOLSpha/0PfE
	 RmfVLrm6IguQeo0ocChxWdy8VY8vSfi8qvVueo/Tf7+xW3R5eURxAWkmkve/Rp0wRHszW
	 4qLhlWUsO7BYMNRih71VhwrZUIjBeL5buGWBlXD9YVQbGlJR/dxVUuu5O+yQPS6SwkaKU
	 /0ucyFobUh6XogUrQMGqFePI6jSWA37bJ/o2n6Qd8yGY+WTNDwz8bSb/+YjEMkBPBew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tZloOYM3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.13
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26BF606A31C;
	Tue, 17 Nov 2026 22:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D26BF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tZloOYM3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkL/z+5tgFdQG6XhtXgSeKHP291vuVHja8eROmrtbrarFPAFirKZPuIjN7mFJ5kVt9OIaRDKLNJVP0r+GfxDShS8bKV/L26RP0cBPekzP17tExIGgATYi2V1yu9o3GnQF9/S1ydbXtgaxkAAUU1vmqn1MzZrU2nKcPBWfzKEor7BhtxqdEhj14OggdjbFOLU9mwXvFxcJZJNMFneTVTUBnp78AFFlVtrGandtoJPJXqKh3hHODv2MBecCeoa0RCDD/w0Pm24bWjy1SRtd/C6eyQwdSbGW9CEL77SH4r6lhOvuTJVxB4mywjSaSXjaTTu/VO1NildWHugh/Ttr15CnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLusZwO1Xf5z3k4Tj81EHswViQyEEldX/YQriZOrA3s=;
 b=l5E+ydZQp/gfG6atjMJlkjiHXPqOObmrbOBwIxAjIO4RMDKg05HtFI4YCKKPDJM9NVx5d0AWmns2bgjTzdVzDYM5XCDk0QTR1/mUtuJxfEJ8YdATKEBN+arIlE6xvzMOY2EXBvJSuBOYpWtbqWdikQvh7X8/bgShsIpgA7ky2HCd1cBA9bkYKX6RR9yfW9o/ys0WdDItlk0KibjZ+oJwebJ9nnFo4t5+zY4Hq5dkb1YBM1Hxtyc3T7UMe+2PnRN/TT9SxD9KphuC8R0Mq/DTn+gSx1QfVjqw3rzxanAxORCp46Ddaj7c5VvSr/7s55S4Fn8Ryu1nknckErUJF9N27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLusZwO1Xf5z3k4Tj81EHswViQyEEldX/YQriZOrA3s=;
 b=tZloOYM3NvLp4SBdvEWEBoKcyBicPD4KwExdvLvSX3MXv4D6rVHgHse6OM7SenRW7/3yKG8BOMDSj6Uxp8V2BKoF6swcIjz1JR4KIKoqlvkjrovH6DSY0tdmnt7TaBkwtplns6d6CMPrEQA4jqnxeqk7LR7/bfooXhUh0MT33NI=
Received: from CH0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:610:11a::31)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:33:30 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::12) by CH0PR03CA0335.outlook.office365.com
 (2603:10b6:610:11a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 17
 Nov 2026 22:33:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 22:33:30 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 16:33:29 -0600
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
Subject: [PATCH 2/3] x86/sev: Report distinct termination reasons in do_vc_no_ghcb()
Date: Tue, 17 Nov 2026 16:32:56 -0600
Message-ID: <20261117223257.748178-3-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a6f908-ed8c-433c-d338-08df44face27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|23010399003|18002099003|6133799003|22082099003|261009223027099003|3023799007|921020|11063799006|56012099006|5023799004|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/WkRFeXjhzqpgdoysWSzbIPp9we2L5f80R2akqOCT9fQseP/JO8q4KMPOUZGOH7N0zjfQYwwVKTFLhS/fSTpldTWknT61TgUiAEW+FJhbVR+8ux+d0kDND/tvI6ClDtIvsFKrjMWpaKbnhFZjFZ7NIVbuArDKMNuM/D5HCaP+3HrQd4l8PjfDyNy2Gp2iXyxzTWESZ8KSr0+R4C5ubg61HTPVbJhJTz+e0+k1LKqAz60QCMgljzLs5SyN6rJhiSdvCDNyKTFrlQuK5jeckiGnoCeWv5c+QIIegpJgeKed47X+c/nr2vbTX2rSygaHPMiyRoCZjAuQGMF50a4byzRts1ACSgV68pBRAh7Zmcs6NyIdNs2heD9JoM3SH2V9lYtMFjIZplxKIIBZCI54zIpPDq5+og2o91EW8rEpIhqMo0D62fJW6UsHGw9nLRES2DUZimZhmgygj6HXeMROee6JQuoDy8X2CgAvqXj8jrdKsXgM4Wypr/QXdp7ogsXI6T6f5pQzQDHol3D9J/+SGgevaNnqOaF40jBNnlF4keJDad53YWL1gcDIbST6LhODAHc55SYpBgIdP63wOHqQKR6RSMY5V2FVVK4xcspfO/pHvPI4T2FufEp4i3e/w6Sj57ryBbeeBa9PH3u2TcWir0aWSvV+uORUYpPn+T55HpGQr4oT6GT37Vx3SUT2Rsxto6UHv4l8pVZtg/BFzmNkhRtWtetzIcvzzj4+8CSdsMvEw+sIGE/B8mg1/spHhiw3sl/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(23010399003)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(5023799004)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tvuWxc2cpEvUEZ0ft3rujJkNElsJwnd0f7zDR20tC4SMJKyGwL/wBD3xiGowVnReswq1xkd0zDayz40GzEu1ffB2FX8Skxo2W37uGGOk7A25vvA4vUX9csLNJkhSgJZPPnoqHSCBYxf7ZjXGLM9ko+dYDgyT53iDBfmIWG64KswSLsAW5xLsqdbkQlwRv5Fq/NZZEkNTCXsUa9B/E59Qgu097dY8z1yO3AWt7Z+FFNOUT2PxFwEEhYt0EBeC+UM8iV/dIQx2Gm7hBvd8dEyOt90GlIMTGux8uk5y+5bxxPYy0WhVAApyFke2qsrTBaW2/DwCUhRe4Z+aQg73fF9RxwbKxvPVUWbiPl9ANKIaEW7XB6zzjQEeD41EAm2ceXWj9JbixSywqvYvCWLvWhv5Vz8qJBqAfVhNoluRHz2cEy8VwyDugJX1s+zTO8T4O++S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:33:30.0748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a6f908-ed8c-433c-d338-08df44face27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434

do_vc_no_ghcb() funnels every failure through a single label, so a guest
that dies in the MSR-protocol #VC handler reports GHCB_TERM_VC_FAIL
whether the CPUID table lookup failed, the hypervisor fallback failed, or
the hypervisor lied about SEV being active. CPUID is by far the most
common early-boot #VC source, so it is worth separating out from the
generic #VC failure class.

Use the existing GHCB_TERM_CPUID for the CPUID-handling failures (the
snp_cpuid() error and the two SEV sanity checks on the returned values)
and GHCB_TERM_CPUID_HV for a failed hypervisor fallback. The two checks
that reject the #VC before any CPUID work is attempted - a non-CPUID
exit-code and a non-CPUID faulting instruction - keep reporting
GHCB_TERM_VC_FAIL. No new reason codes are needed.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 arch/x86/boot/startup/sev-shared.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 1e4fef117171..9ffe04dfb28c 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -470,14 +470,14 @@ void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 		goto cpuid_done;
 
 	if (ret != -EOPNOTSUPP)
-		goto fail;
+		goto fail_cpuid;
 
 	/*
 	 * This is reached by a SEV-ES guest and needs to invoke the HV for
 	 * the CPUID data.
 	 */
 	if (__sev_cpuid_hv_msr(&leaf))
-		goto fail;
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 
 cpuid_done:
 	regs->ax = leaf.eax;
@@ -502,16 +502,20 @@ void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 
 	if (fn == 0x80000000 && (regs->ax < 0x8000001f))
 		/* SEV leaf check */
-		goto fail;
+		goto fail_cpuid;
 	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
 		/* SEV bit */
-		goto fail;
+		goto fail_cpuid;
 
 	/* Skip over the CPUID two-byte opcode */
 	regs->ip += 2;
 
 	return;
 
+fail_cpuid:
+	/* Terminate the guest, blaming the CPUID handling */
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
 fail:
 	/* Terminate the guest */
 	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_VC_FAIL);
-- 
2.43.0

