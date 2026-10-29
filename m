Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793303809;
	b=lHpyP0WbeaTi/ulAGd3INQH1OIh0760nB6tqRlYohHbFJH85ub2lK/l5YbiQRWh10Fdv
	 JRjkLbJLXzCGa3pz+xWPMF8HcenB43ENy6BMGFQ173NbZVsXl+TOFqvi9RTkwWN5Yqoyx
	 yWgYf1CsbEOHNiXbd1SixkGzGft1RtblCpI/N/WrFI9sLLSvCvRzu7IKZTTHAttUuQFZ2
	 pF7yc2eE4vOXIHbT6rtyjmZNihGWh7SsyTK9BqUgfV/Q+Cc1U1j79M1lb9bXHEE98bTf1
	 b+TXnix5fm3VVyz40XZgPscUBDxDVzoJa5tmTHQMBc0iJUZoN4eOfDWaipOmW48ctHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303809;
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
	bh=TW3K/D7B/bQbGjDXs2N8Q4YWMY1bu1mxscLlIMm+y1M=;
	b=rheYXCSMKjrNnQcEypxNTy2Bi9PeeZvnfYKqNQMprlkk1Z0HglL5P2pyK8U5FzlsgM7p
	 P3wH/Eo79UdxXRt1cCxF8Ia4+RyxFSlA7l8i15XkxAuBj5ZpbQnFbX/sPuOlk/8utPGLv
	 9MlDapmZc4pu1FV55JwGG8S76vsvIkhSh5pqlhmccXywlQ41WNn4IX1l6vOrQK0qLcQVH
	 0Wpp6HJz/wV5YrVzwVB8QwF+rJDtXpGMb+hUaGSYke1ST1MHBrFWpm1BgF+SeLlDmY/U6
	 BEaf6e+R/LLeJ+iQNwhH8j2gAvtg4atj0vadsaVU0+NuODI00CHe5YHrq3NAGC9+qtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="whj3eyw/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.16
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1C606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E1C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=whj3eyw/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOpA95qkXWs51YjyN6IIhlVc6Ms7qw0JKep4CrVNhhUgFxHk72shRu+JHCKtLaWhoj+90yRCdfTjWP4vB4/hbeOGEDhH06qZQ5zZfmA9Jj9mTTD2XbjN+PH0k2c01kT3bXy3jWPU0vNas9qkfkVG3hV6I2Ah58jM1OO0sY73SH13qOVvBs0KYmiJ8adVGwrGVK4HOcr4WZNeNQxiIk4ivgzUopOMlMMzM2Dk/JWhbIUvKNRZspJwaAegABjLX4u1+RNZxXNI5FYx4Pw3ZxwdM/qhNp5+1wJlg2sNAJp/RkPldC5htR0xuR2/OeINfAHz8/4AkgkdT+9jwbQOoVd3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW3K/D7B/bQbGjDXs2N8Q4YWMY1bu1mxscLlIMm+y1M=;
 b=YUxFvpTlEzggAi4U1hBD3dxgdt5WRuG+T5Xn9i48PGSWYvxp69zHePm7zXkFwqtNf6FhjeZf6V6/Tg/T9q3sbLyIlvhf0hVHHRSpZVb1yBu6I0kayE20jFE3u0ZZVV3tzMXPYvBvDOVb4BjBK0zmQC1JZIbjpdUvJuSPePOIy9vCqhhssis9hUbz4BsOWVeVWnBt9jLFpFxImZu6aeUoKZfW5N7mhPSP5uqjH9YZ3OUOxS3ySi+jkOCFISmn+MPmPzfGiRQJDqBikqqMn406yIW3qlIcQG6w7Hw3x75xitq4HCdrJ7p8k2fKqHLSx7D9Pck5HLSYQk0zN/KZ40Xl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW3K/D7B/bQbGjDXs2N8Q4YWMY1bu1mxscLlIMm+y1M=;
 b=whj3eyw/a5U3JxcyqnetGIyXmDmFaAi2Vz4U4qP6hp0KQ9rsQgth6I9grssS2nLqVUjp/I0YbA1hbMTNIQ8pi4PpaDTV8H3ySORNcE/ofhDHP4iUYSl6J6BDbzN6J8RKAnvH8otd+anjW7a1yXfA/2QFW5UohXCAHv+roC6TMIA=
Received: from YT4PR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::7)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 19:56:44 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:b01:fe:cafe::11) by YT4PR01CA0030.outlook.office365.com
 (2603:10b6:b01:fe::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 29 Oct 2026 19:56:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 19:56:43 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 14:56:40 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>,
	<babu.moger@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 5/6] target/i386: Add EPYC-Turin-v3 CPU model
Date: Thu, 29 Oct 2026 14:56:22 -0500
Message-ID: <20261029195623.2209-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
References: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: c722de31-f415-4dd1-019d-08df35f6c18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|261021123027099003|261021121427099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OBsLh6DN7C54BGDBvYMZF9TK6lJTWmM3qxKSJaujpR55U/sAx8xXerfCMVlA6lY45bksWMiOmkMEtXRNa7l6GSqyyXsggKJMgNQKzqC7F6v7vqCe4YuyQMyyN5BLwqol1NWE6XmBqzhebV/1TzjI4gUZgbvJpg8Qvep9FgO3RucrYux+NIMhthPsS4Df7GHLJ9FoaA68wRY+tYB1WjGlaS3Y1s2zGHxHyPCtHIF/V6//el9moiHw9vMprLhDMpvn32rzpAlMrjOWAdE9u8JDamdoi9+sM95yAO29cdMKzKB9A0Xlsd5fE/RC7AnffqJIg/S1B/m3zqZFto9IzaM8b21kAAlI7ouCHGu+le+esdEzGr8aK+eskyrVGQlUUOJLicwlNsbb9L0GnZvIE+LD/1kxk7WMcCGNNhea9PIqoCko5DgA4VtlCPcHWt3kW5lCilmctRyeIxmZDbVW6TtTlO/Z+41BuiOpSwZ8mmvToYNn/5fggb/Cn5psc5M92niv9kxFN5v3KVN5d2h0JNfr4+0qmsv8mMtPaZP6U0fJ8F7E3sk8vWNdIPAY0h0D25Gt/DzAYbIsJmpO3LINBpEFlutxVtN16E3yuVpaw2VJfddBi47kfwjdjhjwtXFQGjLgperEDjM5v/8LM20WJpK2d1TuZ5Zth3eJ5f7hiHuPdym+yHPeifhdk7eQ8x/btZ+NfUibrgoLGgHCkiOCyHAYpw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	djxjblVZduotMyDdOpvSlS5Kh+PoJzMyxqGU6amdtC5JAeZB+oTb2l0tWRguk7L09C/NmGAID8UfdP6KCPfOPt5UU1U0O3+ZYMAuqZyiGErae/m6UDXsN74bIl8F2AuJFoZ0+AOZIEjLyWuEmwOCRuGBC0cQHrdfMq4ibkJpmcSbsIlxz/EM2+Ud+g5vfEJm58+UmCjb6oAsUXBaZSxmXogYPL5+XFEStel1GFnc6++yb6ZrK+nklpD0PP5JHPraqiIoD0pabAV+lrggYeGLHDL5wXY9t8ijTiVuDP5CVHT9TdHmjkYaXOlKzCiaeEi3edL9kLocaGZKedTFbk+FIejlu24mRMCO+d2LzYrnYJ7qBcHJDyABtGOLiGJ38HTIOC05lFRJ31dQ8TMXCF9F5QU6SEbDdPzONQDln6J7lQrsf1yB5CBbXGpfYSpbCR5x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:56:43.4743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c722de31-f415-4dd1-019d-08df35f6c18a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752

The following features are supported by Turin but were lacking KVM/QEMU
support until now:
	- TSC_ADJUST
	- CET_SS (Shadow stack)
	- ERAPS
	- BUSLOCK_DETECT

Add a new EPYC-Turin version with these features enabled.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8805657f01de..69f6bbb2e99b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7307,6 +7307,18 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_turin_cache_info
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "tsc-adjust", "on" },
+                    { "cet-ss", "on" },
+                    { "eraps", "on" },
+                    { "bus-lock-detect", "on" },
+                    { "model-id",
+                      "AMD EPYC-Turin-v3 Processor" },
+                    { /* end of list */ }
+               },
+            },
             { /* end of list */ }
         }
     },
-- 
2.53.0

