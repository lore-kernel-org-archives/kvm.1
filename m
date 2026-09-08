Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3625B0B8;
	Tue,  8 Sep 2026 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853689; cv=fail; b=DV1EPDxWUBG1VWTwO7zOEBOxZzukIudDOdLr4w2828abCBhFKLbQ7xgQK7PP8OvzMWbIvHBcnjtZ43sIuhOtIbczh7ypKedojg8G5mJZJ8AhqwpRmIZZjVez+uY8Bgb5xM4iI+U866ZWTUU7rhTSV9ZLFMJ3MTNdx+3KUc6vQq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853689; c=relaxed/simple;
	bh=3OmXhKI+zeTTE6qVeiJKq9WjFRO9pZqqtWonFx/iF/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K6FRLQvsjK0GOwO2Nvon/+Tpd/vZX6zWrBsRm+sbJAmrH7YQFYERREVLsVV2tZVEP5kS/+9PS9OTt/guE8VlVZteAGR0/Fh8zC45TzTM8L5omD9qA0k1mEjUi4gNeEOZ3HPIW5ork0E6lsHzUgEI+JE36EsIWpJJ/c35u8qYJ7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C85OooSM; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C85OooSM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODwrFH2vqcE2CMomepXNXB8SSow6/ovlh3AygDjtu3jvLxvbJEpHqhTeGE2Wrrvn0+MDiWIM72t5ei46sHC/ZBW9uIsR7DkFHLdw5RcMN24qjUKJ0PmiG/pCw+d5AWsubWTK+xACjsmAsmuLnZTAJWJf1xNBzdGj22G2g5D7clLEr0eD6+YBGwnAe2kYuzLmhNhDnLjIcSQNSHpHu3OC340aGM85ey7fFQN/ynyMncWqIw1d68SvBTQrWPrgltAiStcXc42AK2B5boCslmC8Fwa3zCmL4AgkTWMFuuSNs1pAfm39xjQC8iZAQcBemrQzuTLgLFM0WFEp/xf5KMqlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnioJdS4x/iMpTyA2Szchxj7c28lb7i3uTfIZ6bzYU4=;
 b=gnrLFcM0XsZxAiM6LdPEMYFiaFPHXQsZCmvCdddqeIJoxtiYPkC/J+CezTTxSjXLrOa9wP6xiPquBbxnvQYun+d9pe5mxvgIDqCrI+8YXXMiqGONec94PDttxcmegbawHxuYAcULMNauD96Kq7kXvO87RoKCYcYHGMlXSrOlYsWVPWGPTZ6k0MpwE1KkxyTVulEVmUmsHKVjrkR8tHCyyb7SMCGmxD/0IvVzKPHhSDupp/7mQoB859J1XKQDSDquWF/yH6Bu4aMijNHGJzY0w+ZmAcSeey0frMSwngMZmkJrRn7Fho2RRK0HnVten6e4bTCIp6bTkjp/smg4GMMwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnioJdS4x/iMpTyA2Szchxj7c28lb7i3uTfIZ6bzYU4=;
 b=C85OooSMtoRj+fGp8XuWVtq80Bt2tPTj5TiTxvVhKm6qvnMzr6hx09JXQ7qJpZd0VM64G1k4RSxpwE+QUG0yTA4kdPk9RkY8truFzHSsPtUnAut0fZAVmEn93uG24Ogz87lswWPo2NLJVipWsOksonia0is7ZkMZ2Q+N9UyX1oQ=
Received: from CYXPR03CA0079.namprd03.prod.outlook.com (2603:10b6:930:d3::22)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 07:48:02 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::14) by CYXPR03CA0079.outlook.office365.com
 (2603:10b6:930:d3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 07:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 07:48:01 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 02:47:56 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, "Uros
 Bizjak" <ubizjak@gmail.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 0/2] Add support for cmpxchg16b emulation
Date: Tue, 8 Sep 2026 13:17:37 +0530
Message-ID: <20260908074739.10748-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a4ccfa-d119-4185-43ed-08df0d7d8256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|82310400026|1800799024|376014|6133799003|3023799007|10067099003|18002099003|11063799006|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	C335ZHUquCPtv7ie0bU9sh8eLEOq2S+pvO9z6PuvzB43s0FELeXbjXm4MIa5Gd5i2tYOkbOhvsTO3kei90rHKN3eJb7QHfo080Ttdd+XgErL4IwIOxDoQLYd0IAqvjEMC2SuNx5bNYr7iFhyr553lM9HjN64T4ERVrOx/9QOiv3iW1BLEMF7044CHQUdeJyOX8M3b3GoF1XgatSBI0f2gsXZKjlcwssElaKdl7G5n6yw8dF4gDMGIOjVV3VDRWgEEpZwODo/TGF2cKIHX7oV+9tNDyiTrLK/d6J+cxKUCDEYd79JczclnjqMFzdSqyrK3dHgNe69r/ymIPJcBhdbM38XkmJemEvLbDfGKVhnxlgdkbYfMH63H2gN0T8u+V8TpWON1RDjmhEQOTL9RR2LD+IccoOO6ZbOCDwBBm9bS5fhWs+OuKBbIsY+4zhBGXqeuCAlfm4qnUx7RQ/IskQUZO+IKWaD3vhALHVsU9fsUSl3jX5MOH4Rb/sUd33fb0s3RSCExLBz7dhY1h+f/EKDpfMzCRFYvORytnoqPmI+1k6/B0ehrhIdb6lxQNM7t2L1IC6/t+q3effgnlZ1DR8iDLVuquNIed9p32IZI4rOhwmA27iMFFdziSFqAiPxr3+zKBIBBERSnr6nhsjmHxxIr7wHJxU290yIWlDsUlc5WYDv5pUNWUfKm0Z9WwaW7hEr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(82310400026)(1800799024)(376014)(6133799003)(3023799007)(10067099003)(18002099003)(11063799006)(56012099006)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/MjqjZsKtRynSEmYRb6Uo0NvfU7+OSUZH5/LGwAzjp/2Uq5mSjV9U+hFOeNLlZefmsM9SYtU6wiUjqoSiyE1CQdox0UMCQqifs/mvdI40I2aEI2GiJymBEVPw4PhW6DTN9ZiGygMbf6+YU3C+/QjOLIi0kUc/iJtaXBGolgn45Z8QuVyUYaCQZLyofjy2yClM8uY+LHsNjtbUWCcyJ9yak3R9bpLv4bbXMmL2FkWr9Cq51hTDbiS8ERh1gnTJ2TtTHDbCT0KBXnXMrC1rrIjJhMpg8+pA2EtP+voo0ETbz+4ql33naXVmROtgy/Q7qFBAbH3zN4O17FHQ8b//WGo8MHt4lQFQ0Kd9Pmmwv4spnRWwpY/sWESsu72R8Hj81GCNSPg9gaT0IhHaIeQSN4BX/eSM/4SSFtUxipUy4ZxIeC98/k7nPXVfiapmdcqCIVp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:48:01.7790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a4ccfa-d119-4185-43ed-08df0d7d8256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622

This series adds 128-bit compare-exchange support needed for KVM to
emulate guest cmpxchg16b instructions.

The AMD IOMMU driver updates 256-bit device table entries with two
128-bit cmpxchg operations.  For hardware-accelerated vIOMMU, QEMU traps
those DTE accesses to install nested page tables [1].  KVM must emulate
guest cmpxchg16b on the trapped MMIO regions; without that, DTE access
emulation fails.

Patch 1: extends the x86 user CMPXCHG helpers with
__try_cmpxchg128_user_asm() (cmpxchg16b on x86-64), wired into
unsafe_try_cmpxchg_user().

Patch 2: extends KVM CMPXCHG8B emulation to 16-byte operands (REX.W=1) and
uses the new helper for atomic 16-byte compare-exchange on guest RAM via
emulator_cmpxchg_emulated().

You can find the KUT to test this series at [2].

[1] https://github.com/AMDESE/qemu-iommu/blob/wip/for_iommufd_hw_queue-v8_amd_viommu_20260106/hw/i386/amd_viommu.c#L517
[2] https://lore.kernel.org/kvm/20260706062153.346-1-sarunkod@amd.com/T/#u

Changes since v3:
https://lore.kernel.org/all/20260826070004.8100-1-sarunkod@amd.com/
Patch1: Split the old value across RAX and RDX using "+a" and "+b" instead of
	using "+A" [Dave]
Patch 2: Use __c instead of ctx in cmpxchg macro [Sashiko]

Changes since v2:
https://lore.kernel.org/all/20260706063035.1139-1-sarunkod@amd.com/
Patch 1: Trigger build failure if __try_cmpxchg128_user_asm is called on 32 bit
	 machines [Sean]

Sairaj Kodilkar (2):
  x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
  KVM: x86: Add support for cmpxchg16b emulation

 arch/x86/include/asm/uaccess.h | 64 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/emulate.c         | 50 +++++++++++++++++---------
 arch/x86/kvm/kvm_emulate.h     |  6 ++++
 arch/x86/kvm/x86.c             |  9 ++++-
 4 files changed, 111 insertions(+), 18 deletions(-)

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.34.1

