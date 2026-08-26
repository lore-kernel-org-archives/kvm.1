Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2E379EE0;
	Wed, 26 Aug 2026 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727660; cv=fail; b=GB/dEyeax5Nq8Rp4YBf0AXqldZpCwEdCaJ+mCgtUIFA08kdxRmct925lvYgO9F38/yK0b6h37g1VNseS1ka3bleAnXN7dvt+ObsFQ994e5RmVXYOkpMAUX9MBiNlPAeZv+MjcVSOjqI7hG71qzYBQoIq8G+QquJKxlqskWERgYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727660; c=relaxed/simple;
	bh=qbzw237Jj96wSOs9gmTafRo6K/pnlhdrMV0R3yXLrQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IWt7uYLDV9NJEWfPgiKaQ4Gb99acJtDgAly7IPxsL3uwcMii6Mwg7bjGbU1PXLn6MtlmtOIX6f3mBs7gKWCHafhBwiXAynFndElw5otTUfbiwVAe6n4IqGGrDaDJBewEvOyBT9AmJWTaZ6ZMyItB5evkS/UmqrNa+LDCnRDO8aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kpw8BJ/e; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kpw8BJ/e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyJdb5IlkG6o4B1aEnHC7t5dLL++LviQppEpxjb0GqZAJ/sXZTuzKJ6zv+7E77qmxprLXUXKQPLwG3r04o+Zk3Bhd/xGi7v44EUBzycvei7vdgcqZe6wwxMVJW9u/DcWLER6zl6cyeFwhfe57zhE4nD0oTgTMkTjjpFJ0pWAuJjpOgZmkpQNdHXMoFobpDGettfwXMspo1pC3hlfhxlBl8YfNqPeejvRgD6ibwv/AOldH4wvKrPc9BORz5cvuXOLSlJWUJlpA0AMyX8wxkw4Oq3CZ0TSvizMcZj0Kr12rLI26cqISi7yYiqZLvXdVD6iwYG1nzAe+frdnC/ZEkkMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFrIv1VRQUzjCDZ5WfYuS8BVc/9p+8Dbrz9Rt1Ej1r0=;
 b=LQKmM+/NShevNodbGrnC843jGyutBt+yHNJSNFm/Lji0RNIDgAlyGvALaRYNri6jZhgKQgNNKOOxR9u0p7OhOt6zc/5LH0ardNOixarjA49MxjfgGcICf3iSjP1kLMUulSfActUoHkZW8uGWeE5GgDCEOY61C+57LZWvZU9cDPArS1j4K+pEIK/IDYZwmi8YFLMvt93Os/Hv89c0SbETsny9k8P7x1iK/TqhFbX7t/95bXrfhq8ak4kl8esmYFtHNSmX61w7OUhiL1gDO105IM1k9BSbTQ6v9sPaxX/i5OwFC3PykR5ouwTY6ilu3ewxd/Xz92YKIN673mJfvuvC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFrIv1VRQUzjCDZ5WfYuS8BVc/9p+8Dbrz9Rt1Ej1r0=;
 b=kpw8BJ/e9uY7gcGba3xbNdeq0YziQ/c2AHAi8DQz6eGnJsBMVkcrve5PFZfXVb+PFIHcbIMN10fo9PpdvHNAFP5kk/+yhCgOAwIFQSBm4TWB8D7G92KftDz9aUwaCjveUzVITDj67Kyt7VMVdosUIqFoxyB8zRRinR0FSowL/Hg=
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 07:00:48 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::4e) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 07:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 07:00:47 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 02:00:42 -0500
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
Subject: [PATCH v3 0/2] Add support for cmpxchg16b emulation
Date: Wed, 26 Aug 2026 12:30:02 +0530
Message-ID: <20260826070004.8100-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: ceea8316-179f-4008-9f32-08df033fc19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|13003099007|921020|6133799003|10067099003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	A7/sD03XAK1PwFmY5ytLT+rVqkdbXIo6ZGOR7xwtwbQ0zD+wyVVXiCasjgyz0Q5/iCMkhWl1ZUNvKp+uFnu4vgcpI82lFXBYtHVqa8AqUcFbyf/iwhDWYsKb53tTH9bd3PBRDnSOPezfXDxYZqdhb/7GyHw/5h8SG+0ZUv4fOFvNdPW/Baxs5QpOH6elYuh5JDtgI+cl27iL/WJV/txhY7rChcfWA1uc/RKA6sCnoUwyIN58qRF74i+7n6XQ/SzaWFvvo/1ZDuxqLfjZ2X3m7LF8FlbUgeraHDxNBCdKa1Fdkb0UevL6yzLH+yIufBKmKg4cwD4n2f3xsHi8v/y/3ag17NGA0CDm3KwL8P+fQ1KP9VqZ/I+V5DnD3sjsGUhxF77PB2CJLW+xwA9jIAvvfCbyTaqk5r9yWMZq976pqoYwJXtBo6rl+BLn5d1Q2dAfI1DnLvM6z+KVRmOz9kggPKWE8spinTXuvbk/qiQ7/xh3BD7+lF5eNhVq89l8bLEpr0cT6+NsHL6U4YVjm4zeq0ZFsIyCA9o/IBMUqhE3hqvEya4+ClT4tfofHmf20mBh2UxlyBhI0NKfvsCrc0W4+UGolvL6+dBLqYWSabJHBaM9/IKq76VvE3vIfCB3HbYIabo/bCJhwjqRw1GovGR5zXOp7dMsJcwWoja1dGOF3YLX1ioDDoGsgeKq9zJ7Xw4R4OczD9WW/DGxXTJRW3vEU9uUou2IDUnKXwPKywaCSaNoPhWCQgEwEzzaZJwCsgff
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(13003099007)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iE86GHPR/Sts15npeyV1AD5p1LcaeVAuyZCnaW8XcQjorDTQB1w//uSRTHCQ7zIDMhgxAw1wpry56C9G0+w/68kteygDPhetn0vdqbYbPer7CVn9mBpmz0Hdj3ks5ZnLczFPeGCAqmIACCTtNWJdR9KkL4GDUCKVGd7LsMbO5czGcsWHNdUMXSHmxS8X4sJmGkWwN6HOXKWHThSXerqm/eMz/pNjSHru4kYSVIqlCxLR5oSnGYAMtFTaTH7f4y1od8v+6GFo8R0/P0HIevawVKLKiDYxP9myveWnf4tygbXESliw4QP3mGgVVtlPULnJ8g7hMN9bp6ls9qeSpj/V6tWSGcEXDM3kLfXalpvfVeDxxO61thNWEmixj2kCSnQVofbXXGkLO3VjH12SMYiJavMq0pP3iHEni4OCD0AU/Wd4dji/uApXTtY3y9t5mnIA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:00:47.5273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceea8316-179f-4008-9f32-08df033fc19d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058

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

Changes since v2:
https://lore.kernel.org/all/20260706063035.1139-1-sarunkod@amd.com/
Patch 1: Trigger build failure if __try_cmpxchg128_user_asm is called on 32 bit
	 machines [Sean]

Sairaj Kodilkar (2):
  x86/uaccess: Extend CMPXCHG user helpers to 128-bit operands
  KVM: x86: Add support for cmpxchg16b emulation

 arch/x86/include/asm/uaccess.h | 56 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/emulate.c         | 50 ++++++++++++++++++++----------
 arch/x86/kvm/kvm_emulate.h     |  6 ++++
 arch/x86/kvm/x86.c             |  7 ++++-
 4 files changed, 101 insertions(+), 18 deletions(-)


base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.34.1

