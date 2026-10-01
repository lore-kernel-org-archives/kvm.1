Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EEC331209
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860861; cv=fail; b=lpExg0tMlLzr8BP0eh/LVHYY0m8VW/JABh/DFVk6en0/MpICvQQxe2xvJSCiXr6KTXMP/hpV+ysWIiXG9OAPZxcHCf3eZ94cxPWJhx3j5FmEJlntkoYddz0LN+qJeJkfnzO/KL9VUr0Agy4xBJCihvs4t5ULZwV0D1v2f0UzK9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860861; c=relaxed/simple;
	bh=U/DPbzCvkE8jGX/k/02euwTPOFCIUbdBymraoKMm/HQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ghdGeafxDki4iphg0PgfM0aUSmc2bmuKVlnLc8BlpCSL8+0T55rwe+6+CDjNjtWWJiUd8Py4m4RsPBeuR91xbzbAU22vvwapLJIOE8/um2ou9BOKdbB0K4w10V8QTzlUTKt8CyH9v54se6DNSN4ZwbSUuIcttJb3p4FH714D4rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mZF/GVzd; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mZF/GVzd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaLlnsq2b7pAh0Hb4nq7GfyYfNYafrKMvJQuE5wVZdaWtqJlCVk2xtj/M9CXufKu3uOT7xCpc5FQjLDkBMNU+aDf1tu/tKogZh0Fd+9ymiy0kMGzhumXPWSfEUtxmZPdbI61rSJGQLzD1J2dDBNawdcKU7Ja57YTWy7dDOfl7AKQMdp/BtNNtpvadp2N63iKDDu6Fnja2jSy9ypQRa3tDA3SdNpbV2rafZI8hU7pXaBhX7AUGthWpZ8ZrOG3YrAd7L0nmctJWXWqopiCZGewkS/Fp1rDc83Unq8G/k1If9xln71z2Nwme0L1qDgnnwh0B9PF2BSM8MKuLraNa+QFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5LH6QDSRV9BIRtngHtSdcitPgq5rMDe9c3abyZTZL0=;
 b=oh8Nz2F4iDewEuvQirLWhCiXLCAWutUTIQ3KEb87NUs/qLQjzpn63NeqX2sU+U7sx77gPmWv6JCFdo6z8Nce/Xqrr8Bvy9pFT6WMzYPG64oOlMRxx320RUtBsE3SIlBgXDonHgmW9f4Up/9mxdns61WM7wQXnX3AUPylldOW2N/0dtOCze6bRlENz06YoyzNfwzYCfXYP8q9B45KR96DI2IWnNLqOuj8yDpDSwIIDpOQ0o2fw/fFGr1poii9nfQw7k4m8u4wq0wouWuQtM0v01tL8r/Qrof867/ZRtS84bUQ0hipZN8j8EZjozY5RHoX907ZYmAZZVYzXTufBISrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5LH6QDSRV9BIRtngHtSdcitPgq5rMDe9c3abyZTZL0=;
 b=mZF/GVzdcHwpk3Oz6ApXTeWLElYSfE0HBb3lBubY6bUsddvDyZ9/XTakzTmfKq7SNiFbu+RNKEGxrXgqf7wefZyPJ8hHhRh8rr511x5McV0oUWflIUY14cFKaZXUn2kFpZr1hOp5L57WyhX7AHrs1NjXt/TQ7I/30OEorYzmzCM=
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 13:20:56 +0000
Received: from BN3PEPF00022BCE.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::96) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 13:20:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCE.mail.protection.outlook.com (10.167.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 13:20:56 +0000
Received: from kenya-2231host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 08:20:52 -0500
From: Manali Shukla <manali.shukla@amd.com>
To: <kvm@vger.kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth
	<michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>, Jim Mattson
	<jmattson@google.com>
Subject: [RFC PATCH 0/9] KVM: SEV: Add PMC virtualization and filtering for confidential guests
Date: Thu, 1 Oct 2026 13:20:12 +0000
Message-ID: <20261001132021.254270-1-manali.shukla@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCE:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8bb4f9-f407-4481-61d0-08df1fbed366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|10067099003|260925021911599003|260925021311599003|260925022911599003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NCQz3LsZYmJkWj4vBtVYkgt8l0VqGP6R49jCyPeVPAyCFWrwvIigdvA08Cih5zt7EaZNaTzsNaDqitPsgaHgiwOinmdpOrU/ur/69zhFN05KGeDXODCSHAm2hOz6UJTIRkQlHik0UT5JxwnrjKC0x+AK2BMy7soP0OaCmwM2rOqyQrSCH8o8ktvGqM8nExqAvbaSs6Nzg62PkzPpQtTm/w6Lvhb2ArWY6XwoWsL/bp3bjXsYhAzKVUvzXZQ1i9ilaITNoa2bqIl0/CpEg6Pth2WTAE3OBChTuDaZqz0vQl/Z7oXvG8P+DxEw3ORA3K7dcCo8p4EroPdDRcWEKEvAHOOlOe9BnW2Rzn+jiRA0xr/pLbvudK2CA+U7KFo35W2lhierSUKt6HXmhBP/p/uSUfN70Xz3FFPy7btnUzyAS/NYaAej6m3WV+CCS2jozX3psoX4NrZBJlm8/h1vIT3zK2CHDP94F0+vC/JUsxCX+77IBfBMZd2saNa31honEV3yD4mZHRxYr57XZ4AR7Gyi2FER+Crm4DMbCgaNbyrUshV4AFVZtCjw+3+6BiH6ns5x1vpONrNRN3qf1WIySxRwlwqXxTRv2Z0aFZGdoU8nEChkBc9TluPpK9AGkRWNk4UsEw5F8R9UZKkQWGUtirc9Jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W2lIE9mf1E/co9kw549oSyC0DHT6lKSvZjBGXfRB1u+NMEKSWe2jJyuOFcoCPlC4GN6jsQ/mpgB4a4//vnfySeIWet9j+Q+dyewdYe6aRBHVt+Ty7JKkKuGTbCIT2EQDRrPMXcWv9fE4dxbe8hd9Lp50l0fclrmWeIzGfqbmFsJsJCVjqRHoLeyrW/YwKgwwtFb4nSfJvZ1aSYyRG9X3wzru53uBcmjNkS0KCmBYpPQ3MCHzq7P+mmgtD82ZENBUNRWU362V1cOm/k+8FM9vIBRvwizst6irdvF14R6LtozQxF9I7GkTfOfAVIFx1Pare56dNNix9jTgfV3cwnjgoo/1bRfbJoKElead+XSll72buHJzfQgknw/N5KI5WpRDO+xi4kEi9uZxDPiMnYDbIBiFJSV5ug68VNtvWHCLtPB8GOu3BYAFb+goStKLG86w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:20:56.0417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8bb4f9-f407-4481-61d0-08df1fbed366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BCE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

The hardware-switched mediated PMU series [1] disallows PMC
virtualization for SEV-ES and SEV-SNP guests: their event-selects live
in the encrypted VMSA, so KVM can neither read them nor intercept their
writes, and couldn't apply the PMU event filter to them at all.

Hardware-assisted PMC filtering [2] closes that gap.  Hardware traps a
guest write that enables an event missing from the VMCB's allow list,
and VMRUN fails if an enabled counter's event isn't listed, so an SEV-ES
or SEV-SNP guest can't count an event KVM hasn't approved.

This RFC proposes a new GHCB protocol through which the guest shares its
event-selects with KVM, so that KVM can keep the guest from counting
events the host doesn't allow.  Comments on the protocol design are
welcome.

Overview
--------
Patches 1, 2 and 4 add definitions used by both the guest and the host:
the SevPerfCtrVirt feature bit, the VMSA fields for PMC virtualization,
and the proposed GHCB PMC-filter protocol.

Guest patches:
  - Patch 3 adds PMC virtualization support for SEV-SNP guests, and
    seeds PerfCntrGlobalCtl in the VMSAs of SEV-SNP APs.
  - Patch 5 forwards trapped event-select writes to the hypervisor.

Host (KVM) patches:
  - Patch 6 adds the hardware-switched PMU for SEV-ES and SEV-SNP guests.
  - Patch 7 filters the event-selects these guests forward.
  - Patch 8 fails PMU event filter changes once the VM has vCPUs.
  - Patch 9 advertises PMC virtualization only when hardware-assisted
    PMC filtering is enabled.

Design
------
  - KVM can neither read an SEV-ES or SEV-SNP guest's event-selects nor
    intercept their writes.  On a trapped write, the guest's #VC handler
    forwards the write with SVM_VMGEXIT_PMC_FILTER, RCX and EDX:EAX holding
    the write, and the scratch buffer every event-select.  KVM emulates the
    write and runs the reprogramming synchronously, and returns the filtered
    values in EDX:EAX and the buffer.  The guest programs them, honoring
    only bits being cleared.

  - KVM adds an event to the allow list only when its filter allows it.
    When the list is full, KVM rebuilds it from the enabled
    event-selects in the buffer.  As these are guest-supplied, only
    events the filter allows are listed.  A guest that lies about them
    can only make its own VMRUN fail.

  - SVM_SEV_FEAT_PERFCTR_VIRT is advertised for SEV-ES and SEV-SNP
    guests, whose kernel discovers PMC virtualization through SEV_STATUS
    bit 13, and hardware-assisted PMC filtering is supported.

Limitations
-----------
  - Support for PMC virtualization for SEV-ES and SEV-SNP guests depends
    on PMC filtering.

Testing
-------
  - SEV, SEV-ES and SEV-SNP guests with perfctr-virt and
    hardware-assisted PMC filtering, with a PMU event filter denying
    events 0xC0 and 0xC2: denied events never count and allowed events do.

Questions for discussion
------------------------
  - For SEV-ES and SEV-SNP guests, KVM reprograms the counters right away
    in the SVM_VMGEXIT_PMC_FILTER handler, instead of just before
    VM-entry as for other guests. Is that OK, or is there a better
    place to do it?

  - KVM can't see the event-selects of an SEV-ES or SEV-SNP guest, so
    it can't apply a new filter to counters that are already set up.  So
    KVM_SET_PMU_EVENT_FILTER fails with EBUSY once the VM has vCPUs.
    The filter can only be set before vCPUs are created.  Is this
    acceptable?

These patches are based on
branch:         kvm-x86/next (https://github.com/kvm-x86/linux.git)
Base commit:    6cf46b37b0356 (kvm-x86-next-2026.08.07)
                + hardware-switched PMU series [1]
                + hardware-assisted PMC filtering series [2]

[1] https://lore.kernel.org/kvm/cover.1786345201.git.sandipan.das@amd.com/
[2] https://lore.kernel.org/kvm/20261001044351.50535-1-manali.shukla@amd.com/T/

Manali Shukla (5):
  x86/sev: Define the GHCB PMC-filter protocol
  x86/sev: Forward trapped PMC event-select writes to the hypervisor
  KVM: SEV: Filter PMC event-selects forwarded by SEV-ES and SNP guests
  KVM: x86/pmu: Disallow PMU event filter changes for protected guests
  KVM: SEV: Enable hardware-assisted PMC filtering for SEV-ES and SNP
    guests

Sandipan Das (4):
  x86/cpufeatures: Add SevPerfCtrVirt feature bit
  KVM: SEV: Add VMSA fields for PMC virtualization
  x86/sev: Add PMC virtualization support for SNP guests
  KVM: SEV: Add support for hardware-switched PMU

 arch/x86/boot/compressed/sev.c     |  5 +-
 arch/x86/coco/core.c               |  3 ++
 arch/x86/coco/sev/core.c           | 35 ++++++++++++
 arch/x86/coco/sev/internal.h       |  1 +
 arch/x86/coco/sev/vc-handle.c      | 68 +++++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  3 +-
 arch/x86/include/asm/sev-common.h  | 12 +++++
 arch/x86/include/asm/svm.h         | 13 ++++-
 arch/x86/include/uapi/asm/svm.h    |  2 +
 arch/x86/kvm/pmu.c                 | 18 ++++++-
 arch/x86/kvm/pmu.h                 |  1 +
 arch/x86/kvm/svm/pmu.c             | 85 ++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/sev.c             | 83 ++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c             | 18 ++++---
 arch/x86/kvm/svm/svm.h             |  6 +++
 include/linux/cc_platform.h        |  8 +++
 17 files changed, 344 insertions(+), 18 deletions(-)


base-commit: 6cf46b37b0356b3408f8ba949e10462cc71b533d
-- 
2.43.0

