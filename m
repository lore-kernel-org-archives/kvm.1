Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383523F20E9
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585885; cv=fail; b=bJIZCDey5MzZjw0RGHnmWbcaD+BZT5E+c1lpo96+rOiE+caAhBtm2f9tZK2MhKFFYylesBSm9qvaiNb0RWdxoX8n11uDNeekI8kS1t6V4AzutD8sJEVsWEMBkAi1je58Hj9h9yWko3apC9bWxfG6XrJjpi+lh+2nlG7mXGraQn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585885; c=relaxed/simple;
	bh=quMzYEuviFZneNjatamq4LUaikSvwIBXl9GmMh7rp0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iDyTMM1qfoKN9MgkhxyU7KveajR89GRyPa8CRsHhD9esAvhFVwoMB0LFHlNkRfxdFOhsyuhl3N7wj55vpeaXNkV0xPuR9wsxCt08dJoUOIQkG/P8RtNac6c5Z4vfg4fkH91EA5k7XmzRgsE82Ms3ece5G+/KRJCuhYs4EtqMblA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yIMA8CRC; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yIMA8CRC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOLKrXYzg8QJYTkhVNY3+ym2YOPuwviHsJ8Ckja3B/HyhFgP1p5NIGoOYS91+ciTdEgw6vIResXpQ8xBoCI3TVgySPI9JkyUpvPd2isCZHhwXucM56lwNwYHBWMKlkTY8DiSf+Nf340s33u0R5zpZ0d5OCKewW8Q27uliiFdRtOqjodWwP9XtzDHcuCHGGfi632v3MJX67po1VhetFgS2yN1cv3U0EPBpeMJk9tRKWTnwUU7+WF8gi4qZSbMcla/wWpj9m46GZ2eFCVMOgPqnv8rzaCt9EyViVrR+G/qjvWZ3XBiUPZhnua5LPxgrqDqbIY7eww7xvMqJQHXbPQctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRsas0lRus4kmPDKPiCzwX56tss3NpsRS0byNPZUpus=;
 b=uGobs2g9nvZyheP3z9zLsvUK2aiFDtA82jVyg0oBWKT3/J+S2gapp3osS5lsLXuY339B0OS9sE1xabhsAZj8K1u5zSDX057qaqV695wg9fAZPlt5qkFAeLLln8SE+5krGp9S1UnJGKTjpMU8TMgdd4jzVLlQV75TuwoQNCsMWvn9vi/nnN0vq3oB4rAOVvBG9durx/fqUUP6IlG6Wj7Jd0xwLdzEbhWtpVXYZKwvEUyP5On/mrVTmbU4QvvdzK6TuPDUJxqUpPGW4jgABTtkDAzGR1+rCulCz8eLYHi105hAvYLNt2PFvcJE6NxZcpb0T2YLuPp9PuworAyLXby/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRsas0lRus4kmPDKPiCzwX56tss3NpsRS0byNPZUpus=;
 b=yIMA8CRCGVz6ZPEqGHcsSuprR+5trGeA6dzf4vuDHat8J+YOwP23IhOAoNqA1uCdx17kMrbnvxX0pT+Qkg4rGIae0v3OIczzNsdfowbwWD7GuOPMpfD9767ANx6l5sZ+KWfoX94qOv/ZkVfzr1Qhylh1565WrLlZ7nLDTXwuku4=
Received: from PH8P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::9)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 08:31:19 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:2d7::4) by PH8P222CA0028.outlook.office365.com
 (2603:10b6:510:2d7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 08:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 08:31:19 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 03:31:15 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, <yosry.ahmed@linux.dev>,
	<jmattson@google.com>, <thomas.lendacky@amd.com>, <nikunj.dadhania@amd.com>,
	<ravi.bangoria@amd.com>, <santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 0/5] KVM: SVM: Add Bus Lock Detect support and refactor LBRV
Date: Thu, 9 Jul 2026 08:29:48 +0000
Message-ID: <20260709082953.69434-1-shivansh.dhiman@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b824f5-cb06-4c46-d313-08dedd94735b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|13003099007|18002099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JoR0QoT9Ud8q25Q9XbcxHYsM2KXaZtFkCjeh53R93cNhl29U7C0ixYZglkKdKhk+bDHfeB+tYNy7G9RpielOJVTz/mmHxfSq9x/ASoq4cmULKa7SJ15PGGMtbGtBBB5EeBbWmE3WpvvMuTyvHKFKIolwX7qI12gvBrWns0QKqMNdD1P5fx9JhLqc2UbUps3DM8M6YIEZNhm4RCMSjxVmttilIulGCGFcriuWMDrSdVZAEBdzdVca+NdtPPXpa9aS5EqM06k21s5Jkk6QN2IiVLk5Gg1X+c+OYrKxZDM99z1kmDzYIj8jIey0X/OGbAVGz8k2f0NnyjnkTO5TmSt5Ad0SquBB5hhUVFolOZvUH3vjHoc0ILcsjC78tWRV8mm7xEF2N6I5gF7PUuXfA37iLo9alXDRnvrnQ7lCEVHBWkiQhIRomQhLauOzz0pDeBF1WnQ2WWK2YlX8lych/PPGM4O9ymEyJAYeBToiCyiF8Ba4X0EYCwZveDcKxKh/f02nQxXCWzYk1qyNdJ5Ya7DI4Fanvl/2pTk/OtP/EPjSVegYOmTyGbguegnwtzkVQFT+RtVtukPhPegXyEBQGdHDRZ8kJ4ybCHvzJ85935AQa386dpek6ZpTvQWn5kprQykoZPi0mBFNpabF9DkGIIxXC39l/lefevyNlJLBaXGiDb7VoKP9aWduDl2C7Hptz3hUq96TLxm9JfUq+noenPz5iA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(18002099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NO0dCG1vgYTP1/XD6MkVbtyWZz8HEbvm8UFAFNc+/OSHhWhwEvY5kEQ53QRn1IvmXCB3lq1ZL3ztXAZPQ06efpEjMKexSxzQ+rB3/AvfEZmIM3yI7o8wiGFjFyGhKjToY2ZfYDD8X4E79eC3gAbXRAgVQX6H5rlYP/DsMR2Vupd1NZe7NasliQTSeFQKRFBC4+vq+vaxb1Au3o51cccCe7NMAt/brLSyQ+NyyC2EFcTwyZjqhXjkj74ub9ZJTVdK29+xycjwdqEcqtoCnmY40PlLC/gC69vy/cdnaU6e2xjTHjJaVWSHTOm4IKPtZxA6NLVZvB/MV6eNkUAR1QVp2a5xd6LAugVrSkpFWtzb1s9l0c6YmE4/UZvG3xLehmGjewiNyBJG0NlRxoWM12uQ2IpoKIAmX3NOVvhAyqsXQ5D+SygB5oS2pm37u/2EG061
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:31:19.2178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b824f5-cb06-4c46-d313-08dedd94735b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680

Bus Lock Detect (BLD) is a CPU feature that raises a #DB trap when an
instruction acquires a bus lock, allowing software to detect and act on bus
locks. It is enabled via MSR_IA32_DEBUGCTLMSR bit 2.

This series adds BLD support to AMD SVM and exposes the capability to the
guest. On AMD, MSR_IA32_DEBUGCTLMSR is virtualized only when LBR
Virtualization (LBRV) is enabled, so BLD depends on LBRV. Enabling that
dependency cleanly required first refactoring the LBRV handling, so the bulk
of the series is preparatory:

  1: Refactor svm_update_lbrv() so new LBRV dependencies are trivial to add.
  2: Sanitize V_LBR in the nested control cache and drop the now-redundant 
     X86_FEATURE_LBRV checks.
  3: Use kvm_dr6_fixed() for nested DR6 so DR6_BUS_LOCK (bit 11) is forced
     per guest CPUID instead of unconditionally.
  4: Compute DEBUGCTL reserved bits per-vCPU so DEBUGCTLMSR_BUS_LOCK_DETECT
     is only accepted when the guest supports BLD.
  5: Add Bus Lock Detect support, wiring BLD to LBRV and exposing the cap.

Regards,
Shivansh

---
Changelog:
v2 -> v3:
 * Reworked the single v2 patch into a prep series (patches 1-4) plus the
   feature.
 * Rewrite svm_update_lbrv() as 'if' statements so the BLD LBRV
   dependency can be added cleanly (Yosry Ahmed).
 * Sanitize V_LBR in the nested control cache like NP/GMET and drop the
   redundant X86_FEATURE_LBRV checks (Yosry Ahmed).
 * Use kvm_dr6_fixed() for nested DR6 instead of DR6_FIXED_1 | DR6_RTM.
 * Compute DEBUGCTL reserved bits per-vCPU, gating BUS_LOCK_DETECT on
   guest CPUID rather than a static macro.

v2 resend:
 * Rebased on kvm-x86-next-2026.06.24.

v1 -> v2:
 * Used guest_cpu_cap_has() instead of guest_cpuid_has().

v2 Resend: https://lore.kernel.org/kvm/20260629081018.60618-1-shivansh.dhiman@amd.com/
v2: https://lore.kernel.org/kvm/20251121081228.426974-1-shivansh.dhiman@amd.com/
v1: https://lore.kernel.org/all/20240808062937.1149-5-ravi.bangoria@amd.com

---
Shivansh Dhiman (5):
  KVM: SVM: Refactor svm_update_lbrv()
  KVM: nSVM: Disable LBRV in nested control cache when unsupported
  KVM: nSVM: Sanitize nested DR6 using kvm_dr6_fixed()
  KVM: SVM: Compute DEBUGCTL reserved bits dynamically
  KVM: SVM: Add Bus Lock Detect support

 arch/x86/kvm/regs.c       |  3 ++-
 arch/x86/kvm/regs.h       |  1 +
 arch/x86/kvm/svm/nested.c | 21 ++++++++++++---------
 arch/x86/kvm/svm/svm.c    | 27 ++++++++++++++++++++-------
 arch/x86/kvm/svm/svm.h    | 13 +++++++++++--
 5 files changed, 46 insertions(+), 19 deletions(-)


base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.43.0

