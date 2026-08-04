Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20B45041E;
	Tue,  4 Aug 2026 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887796; cv=fail; b=AaomrlVOCghMlPQGwuDBzzk1MAXeMxesVDP4Y2tno81sfwzS/EPeIwv96UWnmYMSW/xWmCMSGLJeZOz2FeNWc6xYSye6zOj2r3IsHDB62reGi6hxaaA4gMBCqruCkqkBMOJMPZlIP7vZn/JDtXvTIXLPBFOPS0EDBdfhh8CeWhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887796; c=relaxed/simple;
	bh=zsNO+0biTdVSkJLJacyuKkb7WgORQMJ2tuMUFuENKjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qcj+EWASgTijNcGRH0w620Gtl7qHB83tObGsLjK9ByMoZ1EkwBG2dEGM/zOs9IZXysTRYsP9veU1MwvGXQ7Vo3Qz9zCRfGgoeWX8z3n0oOLx8NHFDri9rBdAO9qxsLLLwXfmjYpD3NXytKn9VWdnypsMBioHn0jYVtkvRWTJ2GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RebieEkl; arc=fail smtp.client-ip=52.101.57.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RebieEkl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2wxZP+bztsH4VmJdq40HDE3KyCVpvTCQrdPLZZU6XwyXo8lbtfU7MgNZbF11OYJlWRkWdGSdHuqTKw1/9b690lt6cQLautoj2bwUIFSfnacmKlwjiQqp+xQViH94Nf3+6DlvTGQvUyF7MZ//9RRnjU9YJsI8WndX6EKm6+UVLSRpq9vT6MYm1m3kTWTeya4OScdHhDItcoXCOsADx3LLc30vq3EG/hqRutoo4qetrjA0ajBgszOIe1PwqvlrRWTcazsawigjNzdOTjoNptajxigSrsBOLHL9GlrQrVKiWAe0cF0TFDSMHBCmmBc+ByVVxb2nzoxrugU59MEiOkYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXBT2A5GbFbIqa2Y1X+uBuSnjzTt6DpEG45WQ68Weco=;
 b=Oco69vVly8ek3W2R3LRTeomWvAR3AFbcIoAgl/VljJis8EIcMXPfm8xkJ8Xa87Nb8jE39dCkCjBmBzmUUX7yPT4VygeakXccYU/M3lA7gFktWG483SCd5j4l9gEgoNThVGZNoTBdgyate+ZMmE/wNZAEhXy7WwNHq5ODopLorGejo/sXpFTUDmfFZQOuEGDOQyDUJGWeqnJn4BM/4uxNuF3+JXSrJAc2x84hi0WNmiXI6dUC7l8uiNiC9FSkxlydiqvomkWaKhJFeESwr9RInq+y8LM+8DZjVN1jTALzQP1jC0BDYHhyRjmARa/02pEm+Oo3bGpurUcVf1AomNSA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXBT2A5GbFbIqa2Y1X+uBuSnjzTt6DpEG45WQ68Weco=;
 b=RebieEklApCirRJ1J2bVXp1dnLPINtpQu7EQ2dsOSmB4hzuyvfBycUrspCeumROZsIgp4aKvb5oPwMTz2Kx+0wdFQowAOlJBxVd+Ly0XOS7YNcCqnrHYU4b8wMWmRO9fylSEw2JF6TyIiWs20qKbfD6eFPBcZ568XSMwZ2LWaDw=
Received: from MN2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:208:23b::6)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 23:56:27 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::69) by MN2PR11CA0001.outlook.office365.com
 (2603:10b6:208:23b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 23:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 23:56:27 +0000
Received: from dryer.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 18:56:26 -0500
From: Kim Phillips <kim.phillips@amd.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Nikunj A
 Dadhania" <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>,
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, David Kaplan
	<david.kaplan@amd.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, Kim Phillips
	<kim.phillips@amd.com>
Subject: [PATCH v4 00/10] KVM: SEV: Add support for IBPB-on-Entry and BTB Isolation
Date: Tue, 4 Aug 2026 18:56:01 -0500
Message-ID: <20260804235611.4053375-1-kim.phillips@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a1c858-768a-4e81-9783-08def283ff7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	AX14Axiz0cX6Nsy2X2yAsq/NkgXSL6gSW2s8zlYeli19c0js/mRfaevUDIxxOEteonqthrAkQloCqmPzj+IDIUiOwm6Q6rR1zkxT2NARgtg2Id5B90QCA7KEAogbzKqQ8TxD6tdg0d29PlbeIL6vMDrJ1+IquRTAqTsxDxtCK+uldTnhox6dZASJSUrBVXNd6XLzWVYO0pM9e0dCPAM17Os0pwXy4ZMBB8QlfNFmaOVP4ZOMcdaq6DSTg6wacIGGVlsOuMEtlDonEBBtvoharyMwE5ZzSlAeo5hBTtZsMDsC+wOK37vjbsTcN958/b+jPVNylxhWicK9ZVgB1SM9yaKU+5cRn7NJa1jRR+Ipz1kqHXnB+AbmfeM8inw4RPOmkLMbm7Y8smaQdU8QCap2dDrcDbetsytMakqAiLCuCP3BXMin891NrAtldNyPm/J7bGVUMhL3PgXz7n7NloqJ0GG4deH0OMMKH1NgIVmzM13ZPvzU4h9h6FrsE0pyY1sWaiaNNGXSyh2YoTBQDaFw0cpj02zeO5uuXfcMtU6PN9OpW2EPCUHbEiQLqSQ+0G3hZzRFierhBHKsQR5Klmzu0Z72EVOOT5AF9GV4pPTe4+mUSA0gb6W4Ii45PsZDkOpAkLOS+s3X3pVDWUrGH4rpMJsj74I7shs+mysLujAdp6A18nCnYRWzCz0oG+br9ShV/1l43naTYlUjVmStgFPPBA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tf1bnXvL0VLt7PKNgY74qY9jyzRBnZH45ZUJ1c6YbDxTXlM2Y00TdudaxOXbiMKWFUMw8LKqkM/kO4KG87zGIHqEMLuWqduMOeggkUtOvEoCOiHDreurwhRU1xHWkeykw9w2AqGNNR7xvp6XTZPyUpfj1WL95TCw2R4fsAn012iQvUzSEuhzUeYj+0an/wxLbmlZSlVApv1Ho1XDk3fQ1Hs+351zha4/L06QoU+76Fa1NjRwG1v5RG4iS4lZUmr+xvSj+jfzoVqJdWF4mRBClN3M4aThYHb7lblF4gU59guXufGW1w27XhLJGBIk9y2zmRodXDKuOwWJMnfqPnHaZLmTiV4kUwDzrvIIWQDIurSnv6J0RtP1uJWYukKDYGvrzajAhVjYx9xrS1y3p+IP0bp2DzNl0LtmfO/hgrIATm6as4lGGOqlHrcB/qU2oBHU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:56:27.3741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a1c858-768a-4e81-9783-08def283ff7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322

IBPB-on-Entry and BTB Isolation are supplemental Spectre V2 mitigations
available to SNP guests.

Patch 1 fixes a misleading no-spectre-v2-mitigation error when the kernel isn't
compiled with retpolines, but a user can still select AutoIBRS, for example.

Patch 2 fixes a longstanding bug where users weren't able
to force Automatic IBRS on SNP enabled machines using spectre_v2=eibrs.

Patch 3 allows AutoIBRS to be used on a kernel compiled without retpolines.

Patch 4 fixes another longstanding bug where users couldn't
select legacy / toggling SPEC_CTRL[IBRS] on AMD systems.  Users of
the BTB Isolation feature may use IBRS to mitigate possible
performance degradation caused by BTB Isolation.

Patches 5, 6, 7 and 8 deal with code refactoring as a result of
Sean's review of the v2 IBPB-on-Entry series: an SNP-only feature
mask.

Patch 9 adds support for IBPB-on-Entry.

Patch 10 adds support for BTB Isolation.

Based on tip/master (currently fd0ece3c0826):
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

This v4 series now also available here:

https://github.com/AMDESE/linux/tree/btb-isol-latest

Advance qemu bits (to add feature on/off switches) available here:

https://github.com/AMDESE/qemu/tree/btb-isol-latest

Qemu bits will be posted upstream once kernel bits are merged.
They depend on Naveen Rao's "target/i386: SEV: Add support for
enabling VMSA SEV features":

https://lore.kernel.org/qemu-devel/cover.1761648149.git.naveen@kernel.org/

v4:
   - Ran Sashiko in a loop until all(?) its comments were addressed (Boris)

v3:
   - https://lore.kernel.org/kvm/20260402202558.195005-1-kim.phillips@amd.com/
   - Merged IBPB-on-Entry and BTB Isolation into single patchseries
   - Addressed comments from Sean Christopherson, Pawan Gupta, kernel test robot
   - Simplified unnecessarily complicated logic in spectre_v2=eibrs-with-SNP fix
   - Reworded, rebased features on top of new SNP_ONLY_MASK etc. changes

v2:
[IBPB-on-Entry]
     - https://lore.kernel.org/kvm/20260203222405.4065706-1-kim.phillips@amd.com/
     - Change first patch's title (Nikunj)
     - Add reviews-by (Nikunj, Tom)
     - Change second patch's description to more generally explain what the patch does (Boris)
     - Add new, third patch renaming SNP_FEATURES_PRESENT->SNP_FEATURES_IMPL
[BTB Isolation]
     - https://lore.kernel.org/kvm/20260311130611.2201214-1-kim.phillips@amd.com/
     - Patch 1/3:
       - Address Dave Hansen's comment to adhere to using the IBRS_ENHANCED
         Intel feature flag also for AutoIBRS.

v1:
[IBPB-on-Entry] https://lore.kernel.org/kvm/20260126224205.1442196-1-kim.phillips@amd.com/
[BTB Isolation] https://lore.kernel.org/kvm/20260224180157.725159-1-kim.phillips@amd.com/

Kim Phillips (10):
  x86/bugs: Only log missing retpoline when it's actually the missing
    mitigation
  cpu/bugs: Allow forcing Automatic IBRS with SNP active using
    spectre_v2=eibrs
  cpu/bugs: Fall back to AutoIBRS when retpoline unavailable on SNP CPUs
  cpu/bugs: Allow spectre_v2=ibrs on x86 vendors other than Intel
  KVM: SEV: Define SVM_SEV_FEAT_* flags using BIT_ULL()
  KVM: selftests: sev_init2: Use BIT_ULL for VMSA feature bit definition
  KVM: SEV: Disallow setting SNP-only features for non-SNP guests via a
    single mask
  KVM: SEV: Advertise SVM_SEV_FEAT_SNP_ACTIVE
  KVM: SEV: Add support for IBPB-on-Entry
  KVM: SEV: Add support for SNP BTB Isolation

 arch/x86/Kconfig                              |  7 +-
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/svm.h                    | 17 +++--
 arch/x86/kernel/cpu/bugs.c                    | 71 ++++++++++++++-----
 arch/x86/kernel/cpu/common.c                  |  6 +-
 arch/x86/kvm/svm/sev.c                        | 18 ++++-
 tools/arch/x86/include/asm/cpufeatures.h      |  1 +
 .../selftests/kvm/x86/sev_init2_tests.c       | 20 ++++--
 8 files changed, 103 insertions(+), 38 deletions(-)


base-commit: fd0ece3c082632334ded22076932b302a048c7de
-- 
2.43.0

