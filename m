Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4E340401;
	Mon,  7 Sep 2026 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765933; cv=fail; b=Btk9v8W4Rtdaq/lhjJxQotA0+g5NNRSlzIQ0ZMcuFSC0+UM79QmDH2rMwIds9gXj3LwSxg5/oc+uLWnn8TXl9B5DRC5y1k+Ii8S0bZRXpXhL357l14HIdC7UvezhJA21uHyft268wYAc5kkof/ydhlQhfGwDyDIAu+PaScvSHPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765933; c=relaxed/simple;
	bh=812nYdNCd0+ukKX3haJP6/coKUxYvoTMqbC4HoGY5C4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=XBnypSauwNBwRcwwntLSLN/n+dcqXEITPuQ07unwsVaoW8imx78SSu1wNZeJPZSWrqJlBduTklWNvrkMYD7KHsqtNyEF1B0IfmUM4A+/blyj2PouImJTonjvVBy/xSdbDj6rk2syVqTMsoNPEjPPB1ug0pvcWaFyw5JSvQYz/Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XmgjFxNz; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XmgjFxNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5LflHKrs3QKCYWhxkj7XuBTBC4eNBaxuG7lLV0MT8k0aOQRjdyBon8t5WgpQvB2Rnc4isAkkPTu5qyixUhFf4nrZ9kcQtqmM2Sw1f1SXOS3Rboedf6nDas366T1tkre87bFWOFBjckonE9E9iXBhdvcg6JQeG5X/0a6K9R+p0xKi4zP0lggy2rZQneIFK2vDksYOf7rpsLOr1Rv9C8sGA4TCPtIkFrXRmArVxYw4W6VLZqXQvkgZRyGceIKcPhBNXEdpwBgen43kOBZmxi0BaWnbtv/q6FAYm2rqIupYfbFLGWYcq3QUMQYolbRJ8FnZBETBdUlGE83zKjyFhaWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZgFiGbeHCzTPSqeHuSQAsZzU/TysqpcWv6TSLpd9B0=;
 b=pyqMW4w8oQszgbeFBkFyjirFRhoi19jDJad8dnkhJZs677oT1Qw2Sc7ZehoYB7oWRp394tRzeZwr2fnRK09Vh1D1+b3IKhqFx1PCn+gpNSo8y34x+wBhQbx1xEk4D0JDX4fa3C1N+iePNtfW4mwKrGK//VIenVJ/56kdtfJhBaNdNS7evwaCrcSAuHmdOF6qpl4H2GobXsU8tvxCMawoOcLWilB8V+fXip13btdHSFY/nUEidSQ63AkwT6L0EUw1rmJqsb8AsErzQh7bj2Iu3AgKfQyWSY2mfqYQ2faUSrgGYHnjLHPsxBCO6zMtzqwdWt6cQiSpGDXHfcPW/zljPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZgFiGbeHCzTPSqeHuSQAsZzU/TysqpcWv6TSLpd9B0=;
 b=XmgjFxNz4FpHf24YwBpM4PDUOz8AM6I6CaWdSrwTAI1bIYVZxlPnIlCF6nADTlNeDdl507zSTIbyIaUyncn+9EWKSKhsYcVZZxtWtzdzFH+nvFQ6jR8uOp/cSCNzGLTWZKacdK4tlSLN/hPaUiu2ufa5QLFlgN5HaFwQ16lyNQs=
Received: from BN9PR03CA0705.namprd03.prod.outlook.com (2603:10b6:408:ef::20)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 07:25:28 +0000
Received: from BN3PEPF00022BBA.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::51) by BN9PR03CA0705.outlook.office365.com
 (2603:10b6:408:ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Mon, 7
 Sep 2026 07:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBA.mail.protection.outlook.com (10.167.248.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 07:25:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 02:25:24 -0500
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH v3 0/4] KVM: guest_memfd: fix NUMA selftests
Date: Mon, 7 Sep 2026 07:24:56 +0000
Message-ID: <20260907-gmem-selftests-fix-v3-0-7a4be5c1cc8a@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhmnmoC/32OQW7DIBBFr2KxLtEAxjZWVeUeURZTPDhUwbRAr
 FZR7l7sdN3lG2nef3eWKXnKbGzuLNHqs49LBfXSMHvBZSbup8pMguzAgOBzoMAzXV2hXDJ3/pt
 L1GRaYaTrDauPn4nqeZeezpUvPpeYfvaNVW7Xf3Wr5MA1yl4JrZRu7RHDdLAxsPPjaU/0daul5
 TnBAuWMe+nYvP6ZFYDopD7I3kjV9VzUEVw+7HGOcb7SpnvbWt8xE68QfBmbYWhBO8BJTNp2A6A
 jRQiWjGq1Q0NiIkQ71JDHL1NBh8w6AQAA
X-Change-ID: 20260901-gmem-selftests-fix-2a5e94192f79
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Jim Mattson <jmattson@google.com>, Peter Shier
	<pshier@google.com>, Ricardo Koller <ricarkol@google.com>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788765924; l=2231;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=812nYdNCd0+ukKX3haJP6/coKUxYvoTMqbC4HoGY5C4=;
 b=VtY4gV4gQT6PyEp0A/oakAlXKFu6yblgZXwe+AN9j8qpE61l2xzEf49fuyocEVXbyWYyePd8z
 N5yBZgVBfdeDaEiLQ5bRhTLboFOGXkOebNxz5OQndrFqPcVQZyEY4M2
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBA:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6e418e-247e-4700-05d1-08df0cb13125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	fFCKSDNvO3Scqi9j7S8/rw0Bl8HrcNBw+li9V8ogJ+qbMw3eHflu42iS/SchtoPG5Bw5ZJGsw9cAdYtvioWFq0Nltl8j6l1ch51yF6bw81399zk9QKWKfqsyD7YyV96rMmqZ8Wn9TJMX644m4I4WFFQksjMlWh3JTbRBhCKjsouMpNBt3gRox8NVl6rhLD5fXmMduTEaPvCNjN1Qv5sNX32VU8dOFqyr2CzgJyd3lqjYfgNTLnwIc9aMW6Ba5HQ5RpFIYuWhK1YRaXMdVqZTUkE6Dsad8M2DDiHiRIJPAWCvFcWCP+ERWfYSr2cRvmhOwgaZVow5kmsYtRjlqRL/xNP1nJZAKVqMwVvttz9FJqku4xnp3/kAepk3+lGXXOHeIsNg1f4L+7Bi5WXJ/ATLx+eL4F+CLWucqwxJ+LBvltLxkPTz2jzGiFEOmMtREybOxFwUSiT8C8HHaXFagQhxnh605JyXzmJGbho7DVkXD5GQ7lnm35zzsc6I+pxXksdV/gvO1QjK2peCwd7dnlVMh4pzgNmdzq/AHNDk8Zu+EE5ZHyUVIuWkEvfEJER6zh3u0IYhkxME67qY3b2hvNCdh+Mic8PjF1O9X+TnGhzc79WKrZDcA8jgFhjRJwGBDEqzYbtrPv5adStOgOkVvUb+jQj8/OTkYv2mkzCHNiUPr1MZ2VmGEKzSYUHpgQSYfS5dNogRbSfK1KcQDa9DteZQiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3R0/a8Zxtz4r+9+ulgZB5FiVDnAabhEUMpkWQFJHDG6DQZo8dTGbURR84qB3xVqBlIGiu2jfBIgv2wbNvC8gSWkEWBgDibsVJMAXSkV35rxcl8xt/Efnmj8inC8CtM133R1zQeJOyiWJeyk8iu8cIWTcPH0WzXokaeeCKHI9O3ncL64NcahXBAYIed+CmjYpR7wk8yE6DNTJIerErfTSIrtjekk4F7YW7udcbrnegv3cZEOJh/P2CtShRoGz70/oK18k+ZRgBe96tvAMPB8Zm3uLACWx5+MW/+sFYDQ9SQJlf1HxGr2ajIOKQoCdILxyzAiMtBsQ+AlzNXX7Xn/WWMGTv7fCJwXv4n8Urxn9yDu/9gPPF+vd/pkF380jtCso+gDIHI7u/kJneldgL/HxHkXbcftZDr6Vu4F6WZrL11XkN9N0/XovGJfuyx6b+Mj9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:25:28.2734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6e418e-247e-4700-05d1-08df0cb13125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232

NUMA selftests in guest_memfd_test assumes that node 0 and 1 exist and
have memory. However, nodes can be sparse or memoryless which would
break this selftest.  Select the nodes from MPOL_F_MEMS_ALLOWED instead.

Based on KVM: selftests: Fix maxnodes bugs and cleanup related code [1]

Tested on a 7.3-rc1+, AMD EPYC 7713.

[1] https://lore.kernel.org/kvm/20260903001625.2792367-1-seanjc@google.com

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
base-commit: 88405f0ad1d5c680afe3ea0ce9345fa9e1deaac8
change-id: 20260901-gmem-selftests-fix-2a5e94192f79
prerequisite-message-id: <20260903001625.2792367-1-seanjc@google.com>
prerequisite-patch-id: 6424a3d1e4b372d513b201984c97181a9fc2320d
prerequisite-patch-id: 1d0e83e328934e90b0e8cb9e4c47f9c7c2d12f9b
prerequisite-patch-id: 11bb6b35408a3f251ae7300aa6f1cde2f3ebfac1
prerequisite-patch-id: 7b68398ae0815a4892358359bd067b4cf84c4912
prerequisite-patch-id: 91a2873eeff8555ff7bc728e29a797a07247bdc6
prerequisite-patch-id: d068f85c63973f8bd7606cdb771a3d007b75ad02
prerequisite-patch-id: 26bcf27d961c67b4173bb418fda0a581a6c8a72c

Best regards,
-- 
Shivank Garg <shivankg@amd.com>

