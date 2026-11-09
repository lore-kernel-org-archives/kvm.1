Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794258333;
	b=fTkejh8t4p8FRbcD6odiI5Dj+a/+6eG/C1jX0HcFKLlJdM1j8c+8daJpvKT196RsMii+
	 bJ++F7UJ8GJDEDiifyjYhNck3WaHYVfhY5rlkXzTWSoHv/farSBjFIJyYFLKUKggiAIF5
	 6erVjxoPS8s+iSIn/BS7ZaQXE1XdQhacyEfSzdA7lN0sEhmIrvvxcTRBGm5VhQCRCVN7M
	 jqNKFIByR4MsXMn4Jm9wphqsP+JHlwvsGtWHc7+sPKGWRRmAwTA33O8qR+X2Ch+rtBHu8
	 aCVET++hzxm83/AYKfxh1W0JucBl8EAPCVkjSrdCVZ2ZA6FTkdeYPW8dZGn3m8w7BHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258333;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=Sy9u8l4qw+33zXqH6yQQ/D/LrZ3H+Sno8tntsu30Dlg=;
	b=SRznGHexD75SaC7kKtLehAgHtcFxZi9KWdu4FAxMb2EGurzoPLp3AUGOdOOAG+0Hj9O3
	 Mf8rZWFn3e7aV0ocmNapQY5F70RHNv0FJBRDqRNUFUXlr3lkvz1s4tc3lli953YmWetrK
	 8bMSNpqr0y7Jrma8QmFNSRIMBAH0LR7andgpPC+WncIh/ziFqv9/XqqT+xi9BNUETbPOq
	 A2efffYLIyPcUbAJMtRoRCeOQrRh5UKhk3s7LODfPOeqsko6w37649NrSjjNiFzaFegd5
	 HQVP5X+/KfJ1Rkbq4o8fGvLbY0QBcFxgUdCng7XHjXunfMH1E7vsyBqnzwaEuDOmk9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g3eKe2lA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.63
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D573606A330;
	Mon,  9 Nov 2026 21:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D573606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g3eKe2lA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQNprLWL/Z/fvfQvdq2SDonsa3yzkR8OxRJ2m7Mjf3G0i+69cNQMeOzKf0NPPEgMq5fx4a8SJ4EVAFlB+KY3RSrx+xu0JSLKeGgqEGQsuvjPXo0tsV8HjwmrGe70namjGAAErpbGOE+ytffp/0pHmthZCSE0Wx0LNxe6YSyQYPwbsEszFiLKQLxxNN63wznH2ngEqDVAESa1QoylmjmVzOeQC/YrRsudEGNffYjXALxKELYgDUvwVKGm3++HrcpDu6W1EiRJKzcPwanwbskT0jgeVrT+tdDPL88gKf8mq7bAgh/NeEaSgoA5/dsyEehyu8Vr81+7Z0weEc9X4X2bCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy9u8l4qw+33zXqH6yQQ/D/LrZ3H+Sno8tntsu30Dlg=;
 b=hQ9T2wNO+cpQO/semZYgLHdR9cVhV8bs4GCQfA9ClKQhJFg81UGkoKlRtVbSiRt6WiNwOprz64+AAVHYODnoxVrIM099y/cceCn6mbAba14p4gaBSE4vi2JDQy11QAVzTVuwruTsq3Cp74cQe7dKgQQ5h9qFjU04oIqmpiXU069ueluC1W7hvGRm2mGAvHD4kA0nWeBYiBttnyIMysMsOZCwUMAqlUHCxo9U13xoQ4ay4E+BwsXkHXCRX2mf+KJPigBn0Imx5g/Yrvsu0G0BbnA76vrYdHAW9Phg35IG3dnDCdPI1XDWseufe7Yj4RyIDuq7cQaE86U5zeueqnlSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sy9u8l4qw+33zXqH6yQQ/D/LrZ3H+Sno8tntsu30Dlg=;
 b=g3eKe2lAg0zpWhFIAGzrpbZI1PFbiFgaKfeWoXOn0zeBDnINLPvbTJMLraX6pSkmaO56ZKR5JU95Rgu4NhG/LVKOhkEe9Zzps18fjfJ8IVZLvFDUMDa41oho1vR9IfeTtUnWdbx9pzY+krjBRwtRJXQtV6B/GN9vYSargAQbxlA=
Received: from CH2PR02CA0027.namprd02.prod.outlook.com (2603:10b6:610:4e::37)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 21:05:24 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::13) by CH2PR02CA0027.outlook.office365.com
 (2603:10b6:610:4e::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 21:05:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 21:05:23 +0000
Received: from nigeria-2635-os.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 15:05:22 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <peterz@infradead.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>
CC: <pbonzini@redhat.com>, <aik@amd.com>, <Michael.Roth@amd.com>,
	<KPrateek.Nayak@amd.com>, <Tycho.Andersen@amd.com>,
	<Nathan.Fontenot@amd.com>, <ackerleytng@google.com>, <jackyli@google.com>,
	<pgonda@google.com>, <rientjes@google.com>, <jacobhxu@google.com>,
	<nikunj@amd.com>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH 0/2] x86/sev: Per-node RMPOPT windows for >2TB systems
Date: Mon, 9 Nov 2026 21:05:12 +0000
Message-ID: <cover.1793921823.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 084f1961-0637-4391-8fe8-08df3ea52c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|921020|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	F56axeauBGWAL1G+v1acn7oturclEl6942gQ9XMP03p2X+on/yVzsHma6h2XlO6r78vyD2TydflKqx+CmF2MDtB+tyonlucMsKGpjfT2phcQvZZozY2ZwtZ1VbPbxkdTjKCNFyV0xI+mbycliD6tPKxo9FrnApAUsHy1vJYbxaZfO7lFozA/jxVSBYTcgOUwCj/vWCSsyQHBgrATlNTekSH6Iu0zP3LgideKolN8SPPvBkdnaKDWBi1wrJ+BXNDFFEhJhL0ZLsBoPlfLNgyF55D1msV3XDRNulJEzM0nUfrn4nyL0xIqy8lBs3NObxs5vptWtJxHXc8wxXNV1GZ/sMMibyUhpp13a3dfxO0Ta00/N9WiIhTnK5dYNrdYd1zSWotDtyDUxwp9VdZiTKjW4s1oiY5fh2YVABtel6Ktt8wMgSRZx2iSa/7PnYjGD7Um8aV2AEmyhmm9S3GYBSg9IlUjqShBcLojFmAoY2gB70PCQnNx82OgpVza+YN0dR+f2BzqkqaxVgnC6hrmIKG+tlI0Hk9XVv9crGZzUScOZgMEgjnOOj2Q4JDIYQK2C3KihAq7mN4f/J/mbImjaNmaQ7QNnb0GoD9xoDSuoeXCmJ7FnTUEj3wZ7FpBoYp2GCsCaU13qg81urilH0tNHkxlypcVNvaQkIB2hTmrAPsLWW0jd4dNlGyigRx78tDYVZx4I4xziRSigfzMclMlC5EH/fLdInmUvxd3vVRvBD5F8TZ84qbYP7R0lP89/B1B1BjO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L36H1kLah5sXsPn26UboHIrkwx9BJ1mkTASbF+ZkG1CX+x3eBr5UISV6MJoLnumLfOdVZaIaITClMMGa3Txn97JRwRMoG6MaS1QJ+ZzA49B6haaw3uLwflR5vVeKwBdLq/9ABjV/GcvqSi8B38rjDwetGVlwKTLVY1VdHj+CTl+X2sizYJfIoO6gRrTiKcMOtLt4GfexAbUjEaKFRniaMm0/BRCGjJC04OqqGFbFIoHQWg/wYuBJ5zoQ1IJ2gQXgszuvY065aDeqq3KoUBf91XuJyhdldQr1S9q5tWH60KMOxvxpHwlWjBfcTzCY76I0e5DqmUfff3yn9khO7HU6GNayvu2KGYUzllqhJ9w9Q/++d/uflQWsQPtJHRX4sEY26pnK/mWEkgin+BhSHAbdllzHxM7CpwATLZdIHmZC6Q04MQ+NrtJEpHo/QDkKvAQ4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 21:05:23.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084f1961-0637-4391-8fe8-08df3ea52c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675

From: Ashish Kalra <ashish.kalra@amd.com>

RMPOPT_BASE is a per-core MSR whose optimization window covers at most 2 TB
of physical address space from its base.  The merged RMPOPT series programs
every core with the same base (start of RAM), so on a machine with more
than 2 TB of RAM only the first 2 TB is ever RMP-check-skipped; everything
above 2 TB pays full RMP checks for the life of the system.

This series extends the optimization across all of physical memory on >2 TB
systems by giving each NUMA node's cores a 2 TB window placed over that
node's own local memory.  A core overwhelmingly accesses its local node's
RAM, so spending each node's 2 TB budget on that memory puts the
optimization where the accesses land; whole-machine coverage is the union
of the per-node windows.  The <=2 TB case is unchanged: the window search
returns start-of-RAM for every node, so all cores share one window.

  Patch 1 generalizes the optimization scan to read each core's own
    RMPOPT_BASE (base and window size straight from the MSR) and walk only
    that window.  No behavioral change while every core shares one window.
  Patch 2 adds the per-node window selection and programming, and warms
    every window before the interrupts-disabled fan-out.

HW-validated on a ~3 TB 2-socket NPS2 box: every node optimizes its own
local memory and all populated memory is covered.

Ashish Kalra (2):
  x86/sev: Scan each core's own RMPOPT window
  x86/sev: Add per-node RMPOPT windows for >2TB systems

 arch/x86/include/asm/msr-index.h |   2 +
 arch/x86/virt/svm/sev.c          | 166 +++++++++++++++++++++++++++----
 2 files changed, 148 insertions(+), 20 deletions(-)


base-commit: 9f74092fda91ef93c2b07585785c1dc83cd7971f
-- 
2.43.0

