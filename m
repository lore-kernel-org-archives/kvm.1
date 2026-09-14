Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42622A80D
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402978; cv=fail; b=ac+yTgabv+/nSf9jN12aFl+d8LAftKfaQtvNvoxjt67m4W6lVH57sCh+PbCBzDrXxeou+7/VhecFk89KRvGSD4JsirT8exm3ZQvyNBjEdxrhz1w/pIJlaVpq9JnEXfCANuUYMBl77h985dLnQp5mZuzPQYuWVeUxvwD4QzSiqdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402978; c=relaxed/simple;
	bh=XVcYec0R0fhguK9CLAob9mByVDeX8LcfS4F2sfwu7VA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lx2yTPjatbeKzpEjC7K0SSsXPcONmbl5CD9diTdvOXCj/8V2q7X79AXc+Nyff1pD0B0lkGg/pUpFnGQH3aoFAKR0MMqb0ImsMC2kUVTlwGbdwkhNFnSDWyeAbyIq2eFZDbnh4Pj91szRdb+ivOxVG0Q+o0giQnO89uUAYPN9Gy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v+CZkxmM; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v+CZkxmM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AH/9t2A9BQtBF7G/lRWhPahQLY+m7kXcEGnBZ4WINOwXVhBwG9yXZ9L3lqJEHTGmyMO7x4yy5oSY7pxdEm1RsMybH5MzpAVTTvhiQ0MuVFGceojNRZh8L+oWhVAaOu6SeM9NXfsLJEcu2TWJFWYPj+IJNS3qrAp6ZqvFgLMNG7DrbI3jBAtZdpyGV4zVejqOuVX3vQYk3A9LCGOVkHW02EL7S8Xosf6TbC/Pf42R2Cf5sskjLj4f7rxccD86ej/wVfT4naBpJUpphLINlD+p0HEbOGiGbzgrIL/R2NIzlwmCkQ6VEs7j5mXKZOMvzxyb9M+hX7Nvp0L08wWer1kEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKpcSUf3lmM6JS2Wp10QBayw21bHqfrDl67kjUt1EUU=;
 b=GONhhgrUN/p5gwdnPEZ1HgKn2QIf4KLaxfo/RJZhtbHQorT+7zWM4vr/hQ5eDuhgUoG+VTrCS2RmJqrrbtWihYNkTRP1wAdDrFMl8a2zknAZyEXP3/1fXzrkshUbgl5rJmLpLIUNg9qmqphbDNXlHi0lUs/VqNre0uODrRy1AlLjmWQHVlQip086JhopoTJl987NDQMJD4oaamrbb8lMQtNmysynUC3kfgdsO938iFY6G63ULom9mjIHAewIJmBAzauuGwbvqXtuzd+hc3zEBQNrfGxtkxj1jBQG/IvQPZU1RTDRnYqVabXtLDwjzQ2hL3nTJ6qXYsEr9X2bBqmWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKpcSUf3lmM6JS2Wp10QBayw21bHqfrDl67kjUt1EUU=;
 b=v+CZkxmMxtLMWZCHxvu9uYw4Obsnh5IWZobmCqkX4+Zwxt1pyW9ONpLk2H1hfy+u2c3Cf9ER35RYONczNuqoQg+/y5mq/C7tJuItSWQm6/199bA3PljFCEtw38OzQkvZFzuSWBa75eQdmen+wyXFFuIbdduGf7+aL4a5tsJkPHo=
Received: from BLAPR03CA0116.namprd03.prod.outlook.com (2603:10b6:208:32a::31)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:22:50 +0000
Received: from BN1PEPF00018549.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::89) by BLAPR03CA0116.outlook.office365.com
 (2603:10b6:208:32a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 16:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018549.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 16:22:50 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 11:22:49 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <michael.roth@amd.com>, <thomas.lendacky@amd.com>,
	<ashish.kalra@amd.com>, <pbonzini@redhat.com>, <prsampat@amd.com>
Subject: [PATCH 0/2] i386/sev: Enhanced SMT Protection for SEV-SNP guests
Date: Mon, 14 Sep 2026 16:22:42 +0000
Message-ID: <cover.1789399242.git.prsampat@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018549:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa0560e-aed3-4b61-6a50-08df127c6bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Y3zYRHBhQDnBOlUbkFg6UF6WJXW1NJ1AY2B7fRGT08VKTZa3CySed/ne7/A3YJVl+eN280xOmaMcu6M7u0l2qLgCEZ/TSi2bCYi2fY4/EMRB/wYkAO7u6LVZQQaIOFCcRUG01/eO6+CcyZDhplURlyNyhS83yf/H5K0Yt2RW4jli8ffMF2uW3X/JAtkRmD5Fcz1G/ezwlH0eYJvoV8SD2hjoaVajRZk0XUO99c67ew4/0ROUldi+MATwx4jUdT3ClhYy8XV2EKJvx+gDVdA7RH5S5GC9BCc8YNezAQ0vadII/M6+5yGqshzSrkjcfWSZQzJltuMXeGYc1ZnvzpBiRyAm4gIdHjpiNu9CHYOCZcGsIllyRAmc7BF7BUsDeMu6y3dBNAeQdJQC+nW+SiuarS6HmqvgaoFNgNVOy+Pun4fYXGqUd2EkFi6sckcxt0iboIAowsc/T77OIOv99A5U6Poc7aF+sWq/enHVdHgr8Ra4F1H0hlC/hW003udZ0yOhXYMF6LcKZ0vLrrZo0zxNzra376cU8OfNuj0UlAy9h4TiOuV+H2mqWGHoet1tJg7RlR6f4TDNvagK2FEUkT+mNXsmZctzQNRUl9UU8G3tUi+3UcVA10GKsZS1fwR3Rs3HWCNX3T1cR1VNihzSNVDAWJOaljJ/fx65H0ipHdHW8CN031K61DBO4i7iZFqajTYGdH+SfCuMFr2V1PHNV3EyqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(56012099006)(11063799006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H90IlwxZl09bYfZPgrlJ3d3y08MtdnH/zZF0tfiAslH9hHBIPnvPxWK6cuf99THN1PcjKoPB5iVThwtOba07mawXv1s5kKmY2c0K4RjQkg+cZXNNVZVEnK3WvykaX4kDYRD69T01vU42JzIenKVZpAMn8RGqb/FCZ+8Z6n0Ll/CbdgjglPFClx1eAoISp/x0KuLx03VZT+XWmnGB2Lh9mGHuGXv/v6yiajWhorVBsQ5Rux6uvDXOlOsDDTStNa1rMLmTae+f6AAXDMXYMb7XzUW/SnuzeQH6Snlq1PUvqIXfJ8COeMPfi2KbzcJO04A1ugMN4oq4MNd+1lBL/NU/LlGT1esd/a1oBjJrNCBbAN1H/Z2cgzfOfQXM4QEohpS8/y53fajXMp3GYvaUXZuf0C8D7Xr91YEYWh2eLchv4KzQJjyFkDVaJBItDD+02vxL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:22:50.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa0560e-aed3-4b61-6a50-08df127c6bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018549.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF

Enhanced SMT Protection (ESMTP) is an SEV-SNP feature that lets a guest
constrain what runs on the sibling thread of the core its vCPUs execute
on. Each vCPU's VMSA carries a VCPU_ID and a VCPU_SIBLING_MASK, and
hardware admits a VMRUN only when the sibling thread is idle in host
mode or is running a vCPU that the mask permits.

This series adds support for to opt-in esmtp support from KVM and
engages core scheduling onto the vCPUs to bundle trusted siblings in one
group.

Usage
-----
Requires patched Linux and edk2 builds. Launch an SEV-SNP guest with
ESMTP enabled on the sev-snp-guest object:

  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,esmtp=on

ESMTP is opt-in because it carries a performance cost as VMRUN stalls
until the sibling runs work from a trusted vCPU or is in idle.

The guest reports the feature in dmesg among the SNP feature names:

  # dmesg | grep -i SEV

Pratik R. Sampat (2):
  i386/sev: Introduce Enhanced SMT Protection for SEV-SNP
  i386/sev: Add core scheduling for ESMTP enabled guests

 qapi/qom.json     |  9 ++++++-
 target/i386/sev.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev.h |  1 +
 3 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.43.0

