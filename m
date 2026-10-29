Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793303803;
	b=MFWiY+vohDl/eMfzXjjXa7/DkdTTyw30BdBBj6kkkWILRBAwDGJAZ9GUO1dktuCA5hhd
	 l58vjqRhFa1l7kZ5vMhnLjHvfYSfLcwazbI8kmYofHB8nkQf62YyxbH2vIe2MmrYJjT1c
	 YfjCFHG6KTziDSVz2DJEh15obpBOfNXW00MFvh8YV9KW78dvNrVkwOtxczn16L6JyASke
	 HWM4p775Ywoq1PviK9mO1YFdRLQh/qu5f+00eT6Rnj/Rdu7IiLVtJkjZcBgisHbstb6mJ
	 DTWvYSH7+ThaX6iKxSD2QvzIUix+fNE9NlYGvHEVjaSnvmGGpUiBnnkV3IGi6Su04zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303803;
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
	bh=En9Q/meKfsGfmKSlCdGFvPimwYqUtG5GsZ2ZY8a72ec=;
	b=3iuYDhZ/EL5yf8rh8oRHubNON9rE/0pewyajgA9SapPcLP4D7CN/SyPt7KfLTWPsuQbY
	 01EEBfiBP0377Z7csehPNKddhIVHiqK2Es5q01/315irpI2AB1AOCjI0+FeKRMxxMMBt5
	 JYXMCmnUgeqEdQydUZsANDpx87noDWHSlPUodW5s6P6jv+sGV2GD/28ynJ74BUdmri9Vf
	 9rDj0RVivAW/uYwmoqGmNeoMzvMDl4i806jgM/rKeECW1I4D1cGKHX/LlKPIcKA3hfRCl
	 teHegpxzHaZ7K9kvnyHYprqnDl4Z39V4MP/sze2svPwj9t/u0BAWyOcuaN3EhzWXWPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Kd9BECA4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.0
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4B606A31A
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB4B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Kd9BECA4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNKfOj6bp4JTNUBuHXq7La/KYBrhAmv2G1trw1fzvJzMZEvw0VwKK+A7NDBXh0tNVVt3g0A1Hwit15F5DyAPjXWD1Dv9YHCd1gAGiPYfG/Uv0wVeubyOP6aETFZtJW6BQjHdDzV7vSU7YE3X6rN+S0R4h66B8bvCkksdpiL0tKSemdao2XKXzPj+nziOa+MmZ448OkubqPEOY0nYWoPBRITb4MfOC+b7dh5i0z52nN0dNLQxKM54oNYK6Uxh24AjVm+FTntI0mckgnMd0ewyoZv4CFlrvYrLxhhfh4mYUT7G6B3h0X985xLlJf16Ly0nyporMYcMEoZ5t2/ti00v2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En9Q/meKfsGfmKSlCdGFvPimwYqUtG5GsZ2ZY8a72ec=;
 b=NKqh5IR5lRDnrI0MXkDeqZbN2Lu0vs8kMAOd0sa3OacsbqPy/Drf/j63tNlM0JvjfWuHKY3YyPPXuDjGrNhUR0OBkfkx9H4iJO0RpBvkLW/YzqDRv0Si2JxWlh7SxnMoTsmqFVK++g3guDDzefBYSL8BSfrgICQFAYTuP8kzwaWqnZJUjM2F+OVHnoOYumPGtXKdq1pdHCfJ09yCV6sTAfIe3GtlUNlummzrL8niKcemWuVuuic1WddRfgzUpwIeII+C351DMDhf5X89keJngd0fYPXtXpVOypnJsBwRLTStEZG6j8iSiISBU7r8nASvAj2uXJYmYOrtL26L/KVcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En9Q/meKfsGfmKSlCdGFvPimwYqUtG5GsZ2ZY8a72ec=;
 b=Kd9BECA4olDy0tfKbihDUxYONrc7nBA210RpOTmvl4qXJ2+CPuSPOXAZ90vEelvNedvTAw6boWMGg0i/xvkToVNe9VI1HCRCPQKIpILxdU6FkyGDHXJp+07oDp67VtvYbGYgWecSWg5O6gHKiH8md7B0/FE67hgcieh0JzLd2Y8=
Received: from CH0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:610:cc::19)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 19:56:38 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::5b) by CH0PR03CA0074.outlook.office365.com
 (2603:10b6:610:cc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Thu, 29
 Oct 2026 19:56:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 19:56:38 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 14:56:37 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <mtosatti@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <shivansh.dhiman@amd.com>,
	<babu.moger@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 0/6] QEMU: Add support for AMD EPYC Zen6 and Turin-v3 models
Date: Thu, 29 Oct 2026 14:56:17 -0500
Message-ID: <20261029195623.2209-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: d8799441-2f35-4979-745a-08df35f6be79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261021135927099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Ate9cKAmgRrwduVS4WN0QAhI0QLkEwzvOgAwFi4rSsZPvQ3pLtHY9Z2itBWPDqWpH6XOmt1L5PbKQrwELHF8+XT/V0oB8cMoXwJZItqq4BgRrCdtaiqePnXIoEu02ikB8atEN6ofSzmBx3gmARY0sSKGS0gdLYMZEhoLu9Cadx7qcXzRu78frm2G8T+YvUx6Nb9MadfIqX5AS4dP5WgiLK8buVxxVEIiglidCZuTQmVo5suvbVY4YlJmvJM7HNMthyBsNbQZFXMEgfaZ2wRCHj0yxBsjE/qwKoyhF8rH2XdCEjpMh8Ni+xklGKJMQGVVMw7ymWjtQHnTH5PTbTnwEDNih7opbi7Shj427uKU6y7huXJB0niNxUfUgPvejdymuT5jNWaAKk/Pw7u9wLt+XvEih+w0f7Ndm31DXdG1AigJabCtCplCoS0kL4mf/UE8Pu1aYsPeCtqPH5Dt1r+/D/FMNWa5dBXZk+7+1IAqzoBJsJ/SGTEm/AepyJdAVor/R9Z/WQod5F1cnL6slqcQLc5gyyK/iAQqr+QXFUy3BkoIJPQJuO9uJLKX2U0k0Hz7WjpzXxqbAAOp5KI91PNkc+DPIhwpmWwLe69HYxCfO/1r37fhHP4QLV9ikRTCo6dj257+5LuO71WibfyOOZkFcbKiH2Ox06NUBqJy2PiTzWA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261021135927099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Na21ruovBHI10MWPPMre8OUmzq8frPi4rEXNkhyQDUu7aJe2Ia/PfJnJ00rdU82+G3YPOScYvNDxD4lSHxInji9Ijedhou2IjCvQBOp1Rp7Qtnx+xvk1qr0VQY73r1MQ2LOeRrr0/0B/Ea5yJQP3uAD6KoZlyfCpTWHn/U+m99MH945V5MxPK/dSlKwlLceEfdPQylPt4FZv0wzyrORlzfUosRt8F9usVBlvvk9qvvKDHf1/w+iBTKMN7njUfH9D+PdokAvb4cJbyOS+qJPg5axSiEZXpuywAw2rQimGJWNcqBfP48P8ybOuZAeRYxp8nj3eeJWu6Obn6CRlSkeHmdigFNFNe23plAfHj0CacGam4rdij58R1owpEJOCk5G5USi6fdqXKPFgYn15qL7ni0gawl62Wz39J1u3rcMMn+51yuQu4YWrWhuL7bFksljH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:56:38.3300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8799441-2f35-4979-745a-08df35f6be79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

This series adds support for AMD's upcoming EPYC Zen6 CPU models
(EPYC-Venice). The first four patches add support for the EPYC-Venice
model while patch 6/6 adds the actual model.

The EPYC-Venice model is based on the EPYC-Turin model feature set with
the following feature additions:

	ERAPS, TSC Adjustment, Flush l1d, Bus Lock Detect, and Shadow Stack

and support for the following instructions:

	AVX512 FP16, AVX512 IFMA, AVX NE-Convert, AVX VNNI Int8, and
	AVX512 BMM instructions

as well as new cache values.

Some of these features (ERAPS, Bus Lock Detect) were only just recently
merged into the Linux kernel. It's recommended to use the latest kernel to
leverage the full support of the model.

This series also adds a new version of the EYPC-Turin model (patch 5/6)
that includes some of the features enabled as part of adding the
Venice model support. I've done this for convenience, but can split the
Turin model out into a separate series if needed. The only patches
required for the Turin support are 2/6, 3/6, and 4/6.

The Venice model had two revisions before this one, see [1]. Change log
from that is:
	- Add Turin-v3 Model
	- Add flush-l1d and bus-lock-detect to Venice model
	- Add Bus Lock Detect DR6 support

[1]:
Link: https://lore.kernel.org/qemu-devel/20260825162544.18633-1-Benjamin.Cheatham@amd.com/

Amit Shah (1):
  target/i386: Add getting RAPSIZE for ERAPS enabled guests

Ben Cheatham (4):
  target/i386: Update RAPSIZE definition
  i386: Add Bus Lock Detect support
  target/i386: Add EPYC-Turin-v3 CPU model
  target/i386: Add EPYC-Venice CPU model

Nikunj A Dadhania (1):
  target/i386: Add AVX512 Bit Matrix Multiply (BMM) support

 target/i386/cpu.c     | 163 +++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h     |  10 ++-
 target/i386/kvm/kvm.c |   4 +-
 3 files changed, 170 insertions(+), 7 deletions(-)

-- 
2.53.0

