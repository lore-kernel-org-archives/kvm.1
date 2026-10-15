Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D04EBAD2
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060802; cv=fail; b=mFylGrTcSXaQ5wA/lqUMrUIk7kQJs+OlrzMBeoQspv9JrARAPg3B1sfScxKbXBK6hlKLXyJu3tZgdFadsqpoe1JktvjF5jcC8QmWSFtq609loWcFWvKAyFdY9xEGM9htTY37IU+zk/hFeBo+gDKtIEpIeGdGEjbBtutpoeh+9PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060802; c=relaxed/simple;
	bh=o/JfRThqspGuBXGqUXLUgXmkFRrpDFVNgJJKoyavqHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VUce1Vk1g+kBruJ1RG0f0LFZJsWt0399W7OioDWLZv2wU/l4KEnqafQhFC1erGW8eCr7aoMsOeox8oytEQesXDF+tUOHHrlAuKzA/6vLxTLe52TCklNSRJ8k1b3+wUt3zhRPGPpQ8nRjtxpTF/zoxjbPYk4lv/c1lJU9GTZwZe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ihllqJ8w; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ihllqJ8w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozlnOfaYgwsWdsLSoUytSe5BdS4qntxRg4cbM5x5+Ke8/+JyJ4FhPHP4brnpjGLdBFTsMTPbYCBRA14p1yVW6RLP8DgnGo64W9rCDxYXogyliIaLQ3aMNoMlGv2pE+LWxyjkcdOgfuSVYMIUQImT4esbSvFEDPF4sxjGddD7Pzk2YujXD0oF7vu+MRUGufkTcVuVq+5yepCY3BkS4bzCdAibP+2d3WbX9G9Kkg75+ZMKtFGZ3+dpX7uCT1dkuZ5ttnzdKCTB0uTyL3IVpnV8IR3rG+R1KH04tMLTVThROrh7P1UE01LHLmBtkxXiP+ZqsyaibhRlxE2B+ND8Wnc3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjWOTyTPWj13MfP91WBExNlLUZTB8YorwUjL3Q4Qpe8=;
 b=OcqUVR4L3l226ajdOqESfZa0u0gjDMttd2xcdt6GyivdYRULuyNqQ83o8fjbZMyvp5SnblDVIppIG31qUJgxQsHYL3FYn3AwhIBbBcv7P69Nb9+DRDkChfjpaJVnr81bJi0v0SACz+c6X9yFCBah/BTM3lFlHKkPzEViv7cMGR2LWShpdMePZCYSZYSpQA80fFVDVqDC3/Xr3Ws3QKfqmE+Lowo1DhfjexaFtyvFxYiA23rzuRSKw5d8MJpfkyFJeU2oQ9q7di0j/uWoLF1oow4A5lTTr1mTl6K/h+fQ044Qf1gVBoh8rwmLR0Eo+8ztfbDadJ4EWFM2S8eq2H1rfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjWOTyTPWj13MfP91WBExNlLUZTB8YorwUjL3Q4Qpe8=;
 b=ihllqJ8wPlyC651NHstKppkEWlV2tV9pTjQon+kdRUPa7cxTcZnxx6WqkQl0wYU69lXbp5GaVGjXl8NmHh1qfuL1vpT7k2cIRiPj8+FKglaArVl6WhIkL44IamK+IW313cLUZg/bfqpLTIiPINSvszKNQLQ0J69yC7miVQvuNNI=
Received: from BN0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:408:e7::33)
 by DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:39:57 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::26) by BN0PR03CA0058.outlook.office365.com
 (2603:10b6:408:e7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 10:39:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 10:39:57 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 05:39:48 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <mlevitsk@redhat.com>,
	<joao.m.martins@oracle.com>, <nikunj@amd.com>, <kai.huang@intel.com>,
	<yosry@kernel.org>
Subject: [RFC PATCH 0/5] KVM: nSVM: Emulate Page Modification Logging
Date: Thu, 15 Oct 2026 10:39:28 +0000
Message-ID: <20261015103933.2088307-1-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a4556f-7c8a-4704-fd60-08df2aa8a82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	moEKGFNOyZ8hzX7K4OIHScX8/3gfE8TNKr2Qt/1drsoQnlBiD2xxkP40TYUP05CDMQsl+S4v3fIIZazDWGPNj9VKv43FmHaprhR7+JGkCkmV86JLA2K+7pFkt97WWXLmCYIP8089yg9XSnFNJ1TVHd6kAxMkorEwmyqf2fmwlza/SA+cPzGkTsl8vCKHvy1vmTNVSSpOM9LkGfWlgb0wMsiHwbR+UmCWRvx1VWYRMpAHAfHR7/35LTS0W+p7hWlqeAdKajHBp9jOHXAY6QMIq2TV0dGDRhn8HJlyhf19qtLqriJRno4vBu10Qqsr2+2FKJAFhKc2q+lMAxoTbpDde1fltouQx7mDeqg2uDqQt/rUCTBh6yyKX5Y9rzKpXVjgCBIfVv42ZNd77HukUnmyCmVAp01XZrlbPuN31jtIva34gW9A21g/RvH3s5g270yR3gnZC6ADfY/DbLDpeur52tZrPm8p9Ia8FV/nkPGBEJbuDiybR8u3YquXd5fng9zon9IkzN/nvSG25fl1UKzw1cgpFNYnHXv9vf+YoNeRMPGVQRZKjW1rC04slYqqB3uZe2fE23eeNEBLy4/DNhGoCJyfUCkSSlG8p6PuZtKg6s9pAbzoblY3Roc/no1nJdIrxZ4YVs45N+l0bB1+bXXaPmAwi3TxfdzAq+j+CvDsruiMXfXN148uMa6lJeby44hvfhzWyFSFzpz2KwXhRLLMIg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4o4LRy6qeca1zfXaT5EYY9SKKGP/eMDpJURmlzPgtWDymcaCLpsNhn/us9KolUDC8LyYtvwWBsBRXzIHDCx6T2RJ9MR6h6XXdtCZdhw6PzPulcpD15lpttgP8ezvflYCVEMC+doQb7CMlFtJXwhsT76rPfx5NX8DBipg8ns/ge2CoLo2zez/p0XupxfGGJ1piTSqnfA+SIyUVnsOHyHpBTizcjBpOGGFTemTV8eLpjOJ09rlN1tTTo0URXERhtSyQrh9x2BTkE+q425S8AJXRep98iiP0IHNvf/0j17CmdhA4ZmoxqXA22+75lqA+xSG2xhgTqKqKwZ3bfMiWX5v7cvOifAx63ap2nJQcWSMDFUigJzlUaM5Ya54N0s7I1p9P1nmxeXi1sInCd8rMyneEHqVJ7EJW4Ujgq04KG5/tq4fZOZuJW1FnGMR/Aa8fzI8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:39:57.3931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a4556f-7c8a-4704-fd60-08df2aa8a82d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC

Emulate Page Modification Logging for nested SVM guests, allowing an L1
hypervisor to use PML to track dirty pages in its L2 guests, e.g. for
nested live migration.  Hardware PML is never enabled for L2; KVM instead
logs L2 GPAs into L1's buffer during the nested NPT walk and synthesizes
PML Full exits when it fills, following the existing nVMX emulation.

Based on kvm-x86/next (dea4f6380f4e).

Tested on AMD hardware with PML:

 - A 16G 2-vCPU L2 guest running stress-ng was ping-pong migrated 100
   times within L1, with liveness and memory writes checked after each
   iteration.

 - nested_dirty_log_test and dirty_log_test pass with npt=1 pml=1,
   npt=1 pml=0 and npt=0, with no kernel warnings.

Nikunj A Dadhania (5):
  KVM: x86/mmu: Log dirty GPAs only for the nested GPA walk
  KVM: nSVM: Add nested PML emulation
  KVM: nSVM: Advertise PML to L1
  KVM: selftests: nVMX: Add nested PML coverage to nested_dirty_log_test
  KVM: selftests: nSVM: Add nested PML coverage to nested_dirty_log_test

 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/cpuid.c                          |   6 +-
 arch/x86/kvm/mmu/paging_tmpl.h                |   6 +-
 arch/x86/kvm/reverse_cpuid.h                  |   5 +
 arch/x86/kvm/svm/nested.c                     |  78 ++++++-
 arch/x86/kvm/svm/svm.c                        |   3 +
 arch/x86/kvm/svm/svm.h                        |   8 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 tools/testing/selftests/kvm/include/x86/svm.h |   6 +-
 .../selftests/kvm/include/x86/svm_util.h      |   4 +
 tools/testing/selftests/kvm/include/x86/vmx.h |   5 +
 tools/testing/selftests/kvm/lib/x86/svm.c     |   3 +
 tools/testing/selftests/kvm/lib/x86/vmx.c     |  18 ++
 .../selftests/kvm/x86/nested_dirty_log_test.c | 191 +++++++++++++++++-
 14 files changed, 329 insertions(+), 6 deletions(-)


base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.48.1

