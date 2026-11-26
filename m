Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795673387;
	b=ak2lSJGdd6EzEt1LIvJ75henP5e+KhMla07+ChwGmU7vh3UnQP3/MDhlL0NgZH9blIPR
	 2nmm7LmcXzL8Z+rZtlzGKiZszJRsm4g+5IMvHmkR8KYf8KmXbcgSNP/2YebfnXwkXonKA
	 JI1xhHTf3OBvJOiTSvwMCTDvTVZYt9fis/hh3vOzwbI+opl0x2dLiJJYUseHP/XvVnZYV
	 AfbpF3yhdx1RcNu/Zw04Fe/qI5QUWw54phyG5BuCgW6F2YhZPBdVaHLNWn6dfE1a0GwKV
	 B9B1MJa51qEcAewOnbbh0OjMWvCzJhrGHZph8AreUtzsjJykCfiMieb1z/1icrDPo5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673387;
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
	bh=Mldk2zq53xDY3RuaJFr/itTVTNeuyjrP5hHCSvXiBwk=;
	b=l5BQukhM8jico4cD+AhVaU+N6TGAKDrd+o3ng14FH0dQRdE/ndtLz0UPPw/MEymjNsV6
	 e/J3L63YCbF3P6VgPDbwXfnGsQKN5PEKagQ4gh+SsPMsOI92Ikqe9Vt2n8/TsurnsFVZt
	 7yVihrEmLBW1Ag0RHexH7kJvfX2yp11h2eJ2acgzPqc/+a16fDKbDDuoadCwgb69tnV7/
	 3jptYMRMhTvdiW7f8rfifJSdwf003zFzawP7q8kWh0BnjkfVt1SSq89H3y81LNWojtH7Z
	 cckdcGm+EW8QVZj2EgNBvJKmPQvagYMhKBwepRQ6tsDbA0hVWZaCRsg7XYGF/B2ZaBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GuFDa1jN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.71
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8C606A31C;
	Thu, 26 Nov 2026 06:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38C8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GuFDa1jN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AInGrVbBgr3GM5bJpFzKTfcKp2ZAFUKIfauZo7WNbCOwEUtARZr4axOcXmg/BUbyV8obx6D/YS9JXs/NSI6W/+7KxKwS7NTiwSyv+IGQqFfukZg7qd/MgDq6NB8tElwJNjihyP9+DV2ddHQ6zpGpFrNE/0cS9fsSTlQULFoPTpc5g8pE+Ef59M6gh2PMUsw4FTS4DXNlnfO1XJNXiVStsUEMFWqs7lQ5A6oWOAO23X1PEeS4z4XnnSHOsNAdYx2SJlt4wa2UCr38QaYlO42LzAJjjEmozABCjTsmvsmsSI4e19HYuL8A4HKJD1KFRqX6MXV1zrQ8bNniq4csfi0e/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mldk2zq53xDY3RuaJFr/itTVTNeuyjrP5hHCSvXiBwk=;
 b=N9G7lEpCsdH2eCQ2VW+AFfFjBuiT1DE0g5GH2GqqiPzRGnmH9CjS9M9PjDBYWHq8p2O2XTaecpXc5c6YaXgkojzwzCgQuuzv5u7h6E5bPHFejhCzIBDR70+h6ReJhWKYPZziWy3nBe9HSTWaosD1V1KXRkoD+i26dhXa5m2WoGsaxtZB27Ajsx2qQMYrsg5S7DooR8n0h6J6uibgYb1TUUX2y4XHEQ8zoHaQLc9b61agcrUviPCS6CV/IbHqo0jxdrld/fpoieftL2cgvsTvQwevXofw2t1/bjSKONNH1FWYQ5/oshqCPWEYVEqcIJuChWIMJMeaq4r0NfGFyShsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mldk2zq53xDY3RuaJFr/itTVTNeuyjrP5hHCSvXiBwk=;
 b=GuFDa1jNCwfTjFhFx4dFf0Hokd3RbC7UKEvDHz3e5xAFf+AVMkb1uKSiSrTQRq3Nu9iKXMY5KMoowxqEmBg3CQqt2epsEzLZ6aXncoqCEFz37pwvFd4et6ZF7OIDny7u6Duix+coXR2Au/Wg/Z6re+BqijpP1lxzmq5ddZfeNA8=
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:05:38 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::20) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 06:05:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:05:38 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 00:05:33 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <Vasant.Hegde@amd.com>, <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH v5 0/2] Add support for cmpxchg16b emulation
Date: Thu, 26 Nov 2026 11:35:13 +0530
Message-ID: <20261126060515.2198-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daf4589-fa94-4e0c-7b11-08df4b834b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|921020|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261028144727099003|261026140227099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	N/wds1PwhZo5dOyS4xpAl5E9p4pNskG99ppxUruNGcF85FQ+vnvlbewnTnt24Uv8rjXj2JQAKQPLlSja7LOU2EK33kGVIA9BVK9CoyKsRtRn9N7bHOuqNNnQdooQGnCfOVCwmeHGjs0oyKjp8Kx9Y1oZP3iF8T8ROVttVkigZB4Xc9M7UZbfv3FkUy/iPEyHksBDKRaY+PmFfnF8pT/iZkWbRgdqqMg4wcZqhAHMGpdu0IO+4FSchZ6ggXTolHv/pZzeen0hznNzXOaLoWwj38m/QW/d5MbPTO12Vap4EX2opFQ9KfbbqmoXhV/WT0p2dijPF6kC68p3Ot5pZu6APT8yKl+uzqtoEdIvqqOFKunCDcOABURq24viqEUndqlGip68hdG28oQOZ9h1BmTt3j+DlrWQDDEOSnncRZEutgVCROaeLthjk0FFUyb2FgSCvYT9ob3F4e/D+IQC1UcCBiEYT/G654jjHAshgHycpKu+DtiXZv4l8gDlhr+a9l+N2E5Rq5fjlfi2u1bTK7b5GJoNUoaBd8IuaE98GdK4I+QFMNHlIItM/IKxezFUtvxkZuEpk8MIBCloKRdfTEX70wWrlv3cA+8Xtlmq6GnAq7Xsx3+L39g98SwoqPNfTVkLLB4o1iuMHb9bHvoz1fOJq5gCHPhAS1VpXXTheWlLDpb4pTx9DlmRieFMMmkQDTvyav+teBXGf7KI4mfuhO84eA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NytDgA9Urk0CUR7C2a+KDnukOZYIUQexPCDWaDNQcBRCAbrWtJpPFwjB9jYNnL6GZPx4oFWstKSFEL2PspkTwzPnXwwC1EB9ToKnveddHK4AN/oaTWpMabf4QOxUk1gyu6suweZPhYPpj8YTlvb92d/lx/mv5WFVtpNNP8vm58ymfCc0bEDEEJPfBtpwa01jKGay+VPpZTvJmxjJrD8zUoQoJODo3bDg+KU0qoGLB4IPQyFbOPa4cDufNdrykWIW4RdEinpW3FxgWuulLK+Qwvldxy0iosp4g1PokzI44IgpGoYL8YWDz9W2jgvXao6x3v8lnYQhcYyVN1UDl59tW/4ln3dALi2CxGYV/SZhM8pqRdse/6mXwVA7TZm3fg4z00oMef9BoMBojGOUGVkdat0mo3q1XAcdamBhclNZPgys3f9XXQiQZoBuILB6Us5x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:05:38.2467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daf4589-fa94-4e0c-7b11-08df4b834b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

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

==================

Changes since v4:
https://lore.kernel.org/all/20260908074739.10748-1-sarunkod@amd.com/
Patch 2: Check if guest has cmpxchg(8/16)b capability present before emulating
	 it [sashiko].

Changes since v3:
https://lore.kernel.org/all/20260826070004.8100-1-sarunkod@amd.com/
Patch 1: Split the old value across RAX and RDX using "+a" and "+b" instead of
	 using "+A" [Dave]
Patch 2: Use __c instead of ctx in cmpxchg macro [Sashiko]

Changes since v2:
https://lore.kernel.org/all/20260706063035.1139-1-sarunkod@amd.com/
Patch 1: Trigger build failure if __try_cmpxchg128_user_asm is called on 32 bit
	 machines [Sean]

Sairaj Kodilkar (2):
  x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
  KVM: x86: Add support for cmpxchg16b emulation

 arch/x86/include/asm/uaccess.h | 63 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/emulate.c         | 52 ++++++++++++++++++++--------
 arch/x86/kvm/kvm_emulate.h     |  8 +++++
 arch/x86/kvm/x86.c             | 19 +++++++++-
 4 files changed, 126 insertions(+), 16 deletions(-)

-- 
2.34.1

