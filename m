Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174140;
	b=VUXCefXH0l5v6SJ3GUXNU97QxGUIWOvbz92aKpXFlWbbj788aKdnxCGtPukKI20EQsjQ
	 dx9YXlJpEjjjnGijsWqsW9WdtERZv94/m3fQDdcaKCB6kcNE5tBIlyiNJ0wt+JhwHalfE
	 3LwyW/w2po+TDFiB+kcFsRtJjctEeiiKg1o1BMMcsfBwPDIO5UacyNplDd2gicz5wOd+j
	 WX3tM9bwqB+0IgrivhcuXAKl9hBegHwUEKSe9k79qVtn7up3MfBf31lJ9pIBcVhIi/osA
	 ptDO9tbnnHDUkh75ZxCN2G47udXf+HDNEmplsRKm0e0sL0+uRDuScZ60VfVEtNQQelg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174140;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
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
	bh=uQw025XTO9QxbB8lnF8KcWPVp9vI5ezmiS2ZjFO9ha4=;
	b=OwJLSVsr0LmsFOIoD1XgzRxuJ4x9sctyPAwIitttqAcPxQlV+vXtFvUHrUZHUTaDG75z
	 Hbw2MU0Txj26GVxYQAZ7D+3jJ9XKF5rxvMc6wY4TLVeJ2fL/GmWeKp/Lu+acVra0DIpuQ
	 BNlDjmvtKtD5Z4W7VIdvfddQU/GG2Xx4KGUQ1mVscXUU/lJTnXeXkARAN6Jh797D8Q/QY
	 FjUsIh5KaHZ1ydWv+ucPxjReS71TBtSBqb2h4CnDRhqlnWWoN321f9bNIOQUSooMrbP+I
	 Ay4p1PgBp1pucT5r0sFLTQ882RPN8SsKNifVPndXyx7OcnyPjAKVtb7dAEL8xsBie9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=myRRMjIc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.71
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA3606A320;
	Fri, 20 Nov 2026 11:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80CA3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=myRRMjIc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii8zX/7vn5xzqdZicD3IPPxVRq4q/D6AegfDhUNJqkjGRRN2kEDchq4vpStjpRQo7HL+y7tVv9Tn6bvAzgeWGA0y6RdcnwrjDR6oTg3kpLMwd9Zo7men1Zg+YQxsZonnD14jHfnKb1rciln93YVp9HBVo1OKx211fEoWP7apq8EdzqNwB7WGyjcwk74frEL2G8MK0uVA/ZNiJpKg0IN9Rr/6OW3CS/cGaTwExQrm/FhkoizE1tveleLPM+AEp9GnCUu66hOsQlSpbq04XkmAdMPKLRU/RkkbaXauenVSDysbKWeJzy83FxFO+uqV5hynwUasGJWzYKLAZqwqOWtamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQw025XTO9QxbB8lnF8KcWPVp9vI5ezmiS2ZjFO9ha4=;
 b=KXbPTLntQ5I4/M/fhGGV41JlcfbuENf5apiRt1Q8HuH3DhX2+MbfI7YDKrNfkF0ffTwYs4PkihvD0Id39qiIUXojQTeI9NLQ+aUnjm1nbQvvKOM+jx1z8vHaXD8zJnSecenKP+nEJ+oRQwabMSabG+xACDTbnuNOQp7mdy+uwlkPBYEdPLKoDwJZ+shU81Cm3H0n8NojmL3MZJBHOvPGfbvrzc0qBnE4p1n+E+9LMGSMBfNw9W9T4Ms53M64UjVWkTn58Bi2bIqHCUeycM13rHXbx1zW80TZJRK0jb1FDQYF0F56qVysRfCDnOKy6S1M56Rn6NnWBWYpME6UOaluoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQw025XTO9QxbB8lnF8KcWPVp9vI5ezmiS2ZjFO9ha4=;
 b=myRRMjIc8cLKw4toRGfKgatYLP0EC4/bItqELsMozbnt6qRfXCLIIHA/uLREtdSFiY4f4AXJu0oWZvc3sXo50gZJGTGUFCRZKOklDxbQjrJiOdwTaMFiou6UgIpVr7p+lFG7R/NhNxl4pOl+3FyVzAn1JC06Pe1iX+BukQoecyI=
Received: from PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::13)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:28:55 +0000
Received: from CY8PEPF00000059.namprd21.prod.outlook.com
 (2603:10b6:510:348:cafe::7c) by PH8P220CA0029.outlook.office365.com
 (2603:10b6:510:348::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 11:28:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000059.mail.protection.outlook.com (10.167.247.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 20 Nov 2026 11:28:54 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 05:28:50 -0600
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH RESEND v3 0/4] KVM: guest_memfd: fix NUMA selftests
Date: Fri, 20 Nov 2026 11:28:38 +0000
Message-ID: <20261120-gmem-selftests-fix-v3-0-d94ffe17ead6@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PvU4DMRCEX+XkGkf+jeNUFKSlICWiWPvWiSWcA
 9ucgqK8e1YHEhSIcma038xeWMOasbHtcGEV59zydCKh7wYWj3A6IM8jaaaEWgsvJD8ULLzha+r
 YeuMpn7kCi95Ir5LzjA7fKpK9QJ/Z026/e3xgL+Qfc+tT/Vy6ZrWk/2FnxQW3oJyWVmtr4j2Uc
 RWnssBm/Rvg/gRoAjgwAW2UMW7gB3D9mlnx/YNe7t9bAzTklJfct0OkM5OiNmsVtDcegnLBA25
 kCn4cg6VaI6Ij2PUGtfneBEcBAAA=
X-Change-ID: 20260901-gmem-selftests-fix-2a5e94192f79
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>, Fuad Tabba <fuad.tabba@linux.dev>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174124; l=1943;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=BpggX0TRAkbOUAEZ9fxuhy71gbtUNZ9g5B3Rg+dxnUI=;
 b=O//Sn1JY6dQGvxNGQgMDsa2Cie3HIYn9tB3tM5m7mdNws9wesw7+i23ALAlPvIZ3oNMHjHXVQ
 xwtrUTwCjRPDL7xsIOdatFrg/I3yvZw6VEGkP8F17GxsZ4NVRA6KyXT
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000059:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: c51d198d-2d22-4c7b-517d-08df46f975f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|921020|11063799006|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003|261022105027099003|56012099006|261028144727099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	CHtIa9TDJaAwqG28J0eqmiTNPz+DD3n1jroRH9v57VWemzH98Kojs82wsKYz6vmZCdw0J1Lvv1wArcpU/w6lYyF2Sa25cCHwAijN1XvE/NMW1dmMLyHDxdXLgMJUymjvJyhh/8nkz173PRbQeXd6rgzR+YZKDOe5m0AE+TxFmGhwXJnooqAJNtqRkZriR8DMqbwQ53ErGnYq5uaY10dhiPaLfUYUSSEKBswKSU5gpH0DBL39Nu+gXqY9orUdpCAjsjPKP3g2ntabP/JR9xS6Xd5pB8e3nLkDXIp+J+KH3+b32xTrWEyhZiQhfMQ620isHXvtMoZ+FH1iQEnNcMFF9fbYP+H/gULB63p4Wz0+BtAflfozc0VSMcGH24Z7Ti4Q0HCYdrIGFBtZ416PXTzDie9Ty44k/pQOBBFbOHTCfnpr4kNlplMuR3/qh3NceVTZ4/fO9muZq1S+fJxe4KbCXt+hqK/roSpo15iGcPPPj8sA9Mnge2gshSSC4BHs6JIXbT/xUpcVPY+ykbI19yr7jIES35P7pM+BDHRJHxqC5ymzInNl58xsZc8y9qFvpcu7hVSyxbdk/3FIoSBj8EkhTSrTD20SPzFCHypkba04NxqmKWxXnT9WVpQz0s7Ds2OT/pOXv9jwjIL2//upCe1ePVBKjrQDj5rwleTG9Q5AkPi9uQ69U9fMwMncYdhC8HKO/JWgRAXukLs0clA9zYcGFw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003)(261022105027099003)(56012099006)(261028144727099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TRCW3u4TqHi7mWCAWDN7YgDbGnZaQkIaQdl4iXra9+7CSU1GnKAlRWqceMTg5j49NjhXsQRdbnmItxnQfhguTnoail/JG0SKP59Yr2HzcAaCLrLEbsjd1vUMJOYMYYX7NRCYMl4k5vKDgUqvM9LZaw4urVgZup7sMucpH9wf2UfL1ZhLGkocuCQCl4w9TzT/B2DUvHKxmWN83hSKYRkbXKSDHmIkYyuyj3BonrPZ6g1XzyHg+VtMuaECyW9I3+O5Oh+AfUm4gIcm2m/7VMzzTAM+oFqo4T75+Dg7cw3kjOdm6Cn82mJwJ3G4USAJAIsjRPgpHkuK3FiAM3CySB5ZM/bYc/wIjeG3vkK+6EVf5fo0+4mHPARemz6DC7Gpp5KNdW/z5tWunw7gsRt6w8gZeBhfUpPbmlhUnq8aK5nGQTcEtCIMEbsuh4GEOTbkqb3Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:28:54.8567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51d198d-2d22-4c7b-517d-08df46f975f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000059.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

NUMA selftests in guest_memfd_test assumes that node 0 and 1 exist and
have memory. However, nodes can be sparse or memoryless which would
break this selftest.  Select the nodes from MPOL_F_MEMS_ALLOWED instead.

Based on kvm-x86/next.

Tested on bare metal and in QEMU. Without this series, the test fails
with EINVAL when node 0 or node 1 is not an allowed memory node. With it,
the test passes for any set of allowed NUMA nodes.

RESEND:
- Rebase on kvm-x86/next. No code changes.
- Link to v3: https://lore.kernel.org/r/20260907-gmem-selftests-fix-v3-0-7a4be5c1cc8a@amd.com

Changes in v3:
- Rebase on Sean's spin-off series [1] which picks up patch 1 and 2.
- Drop Patch 3 as version in [1] is better. (Sean)
- Split patch 4 of V2 into 4 patches. (Sean)
- Use MAXNODE_FOR_MASK() for maxnode value. (Sean)
- Link to v2: https://lore.kernel.org/r/20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com

Changes in V2:
- Split from unbind race fix. (Sean)
- Include <linux/bits.h> that defines BITS_PER_TYPE for self-containment. (Sashiko)
- Link to V1: https://lore.kernel.org/kvm/20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Shivank Garg (4):
      KVM: selftests: Prepare guest_memfd_test for arbitrary NUMA nodes
      KVM: selftests: Use an allowed memory node in test_mbind()
      KVM: selftests: Use allowed memory nodes in test_numa_allocation()
      KVM: selftests: Drop unused sysfs NUMA helpers

 tools/testing/selftests/kvm/guest_memfd_test.c | 61 +++++++++++++++++---------
 tools/testing/selftests/kvm/include/numaif.h   | 52 ----------------------
 2 files changed, 40 insertions(+), 73 deletions(-)
---
base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
base-tree: https://github.com/kvm-x86/linux.git next
change-id: 20260901-gmem-selftests-fix-2a5e94192f79

Best regards,
--  
Shivank Garg <shivankg@amd.com>

