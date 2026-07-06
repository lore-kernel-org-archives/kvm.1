Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C463E9C0E;
	Mon,  6 Jul 2026 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319540; cv=fail; b=bpB3yhC/rmfOYYMKZv+TILzpJFAee6bdBTMR4vxythcYVu41LDQfsa/lJxS6OmYjmF0+Fzc0Rd+RRaHRzdkagjprn7IKX8lbFchLhwUiIP9LYqnvai8caMJ81gPrSb3Ih7EA+ChJUgpgV8pM2EPTWwz5HMoWu13WMZrd0TqrZi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319540; c=relaxed/simple;
	bh=fA/9wwc9qkAGcW/HIrFd57tudO93OaALCUIhUTuzML4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ScAmwtpX3H0dHW4NOhbR0z+sjjIQIPu3sNbKf8ba7wOTZ8e+7efFXpiYNuPczpwJpAOcEkOUdw/kiLsUTPaGXU3O+0wtZj1yS4dRPGc5qhapR8eDb+FdsGOasoBJBRZtkX7z9S0S1R7u/foe1TaMf8Q5VJlws9OHUyjhlLvNkBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BQ6Ssqqq; arc=fail smtp.client-ip=52.101.46.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BQ6Ssqqq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WypEyadi8NLkvGjlKjKDvTyhjRLCw15ZVDg7IcgF6n5XU9MFrOTCnUeO0MJ8/oj5UXHTj5uq5mwn8bNf44miPFrrJBQ6SdnkjYw4+d0i4ixAAblKf5kIWMieOGK9d/YbCzSPKYQ6E90xHBkfHgGAgHc1PPlGvmzq18dBC49FOwc5De6WTsOOkTUxFMVrXwxwdDyZ3iApzn8NX/J7ao8MKCSv0KIjZJ/2PkvvEI/12Ro+w8Y9lRnyVQh/ONwdyPq76CBGBmDW647SCEM01+kMlfYdqhg+csnEA0TL6fpppJHL/OgZBVn0eGV2yr27x1fOO0uL9a8Y1PKXuUYhIqN/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IxOArd+ItkhI8lpO4dfJOdpPPwFHQmBpEe/lhS3OUA=;
 b=ouevrHkJSto3qHD3EElibHCSK/0GmhU01D6ntDsnlG1bbslkpA48d5aKV+5a+oncVzfkZrqqTwILUDesZgyF5kibC8Lzoj9vx1YeigsNEcnDO/V7rsQkuuLEVJVEUqZ4v1M1sjYeZGzfRan4/r6UxsXsWhbbz1FV3oMGGShsmGO7V5qajB1w1HNhHh0mh7ehsC7VIDxnhRG5SuWoYpvI+zCZYOef11T/i+O1kCgzWE42WEHG2NiSgS/IP55jm6VHBV32AIgT9uX/MbksVs1/qRLQEIxM+WzpzKHbR3zYzitxfLb2o+K0iT9QGOt5sNwjK13nmHNDtlF6hcEDUvKNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IxOArd+ItkhI8lpO4dfJOdpPPwFHQmBpEe/lhS3OUA=;
 b=BQ6SsqqqcQyGo6Usb+y0ug+qyCkmdw6oWKrbpGzxDCczWsVpM1TEuBoOX6DUf7X3uScWkYiwg0IaxRGw6Jt7FCRYFfrHsaAMtT1iNglkhAbofqJerDNKtrRwcQqO+SxnKz8AkSor1YtttJUpyy51dtLt609f33anONBrvjBRfuM=
Received: from SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 06:31:58 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::95) by SJ0PR03CA0250.outlook.office365.com
 (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 06:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 06:31:57 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 01:31:05 -0500
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
Subject: [PATCH v2 0/2] Add support for cmpxchg16b emulation
Date: Mon, 6 Jul 2026 12:00:33 +0530
Message-ID: <20260706063035.1139-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a0514e-9f38-4293-5ffb-08dedb284769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|82310400026|376014|36860700016|921020|3023799007|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bytCAuxPqakPfQafZkfTb0F68AF9L0wt4GMhBMivydDMn7LXbtVex265KISj3dZgLM888WLYyDN4Py2zqNlm9MlYcPq0ZIpsFQwYoTE1v4GGZYNXBVQvxdLNc9MnlDagNdECrPzner4IkrdT+9GwDLpRuvOB/0wzcINr3Y+QiZlIM4jBuv6TGj34fArl/eeTTtEPjIzKbkN1aW6Jaf4yGpZD35XVPUXjW2dG73H7ln5K7tR0claVPDnHT4OCC/h7EbM2behZrxOGUmHn6vLS0IC5jxCX9lzXK5VpVoSC0L5mgubAzA9ek+vGxoZtmpds/7m+2Wljj0A9bMCzogGu1L9vAoSvMG8KFVQqm/VcN99U+cqGNy3iCMDkGQnDhxh/OQuytl1WpNL5qasHpEPsBIlHZ7wPwbF/3mvejAYNbwqtDYsy/sdbr/4YCnVHOrkfsgliCTTf1sip3sc6l+We9C7HNVG/d5huLCTQSqKoAL4DcfAsUiIYOpFxYME1I1HTPMLbFcsnFQzwPGsRJXEFx+7rjERh7o6/QXMRQwvmVfheI/xIZ8eioaGUEn7pwtrdd8yz9XM1D8lyHEReOyO8M/ejkvdRQ0qoeJnpNskENzHf49PW5yn4vjLNXAmYcuMMVLPU0tLQ2snB4h1T2f1ik0o1DvggAxISySQqW8EaEHH8k3R7hxRpaXD51U5M9bT57tflgKVR5Kwf1y1D5v2riC1Q37OqdP0kAzIIgn0u3AIsyMVf7CzEk9Pv4HcnRM5D
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(921020)(3023799007)(13003099007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0pLO+tmCEZLCG0fOCAYA9v8JWo46Ceql0hrrCKbVQBClryF42DkiP8BhEg6MBn6yjZHDaNF/OxLRCPh9ID0ACeypFeOC3Xc5Z+GqOMxoz2iy+ymi+YYxR3HUKIdSh33D12p2HtLnJnUlmBn7tv/FdpUJZlzczs3N5JCiMmYLbTZkv/8ps/9SG9tFlCnncu8dB+Ygwz/rFgcAOOHEwp/NNULEkyxpIfNm+ueGnZ4EEGeabZtMleFz51B1gjN4hErJzG+uDmzZQ/d7BCHaQse2sTePkb/TkMJpT9vd+aKYOpODI7h105DtgvZv/08V1zCn4eTcSAeBnRaMrjeZlb8fjjuCKHTQmUpcmb2jskyWL94d8444gjXb1tSnHjxC8139jQlgm434FsRbtpCCkAdBBUwpnEBfMP8r3ABsJEOkF4Iyece9EdT38WEjo/wN/wO5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:31:57.5093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a0514e-9f38-4293-5ffb-08dedb284769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

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

---

Base: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6

---

Sairaj Kodilkar (2):
  x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
  KVM: x86: Add support for cmpxchg16b emulation

 arch/x86/include/asm/uaccess.h | 56 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/emulate.c         | 50 ++++++++++++++++++++----------
 arch/x86/kvm/kvm_emulate.h     |  6 ++++
 arch/x86/kvm/x86.c             |  7 ++++-
 4 files changed, 101 insertions(+), 18 deletions(-)

-- 
2.34.1

