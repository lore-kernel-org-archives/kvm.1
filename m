Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5637B41C
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080387; cv=fail; b=sqHCLT7TmUwxB0dqvB0ugN7qTDEw+f8/OrcuciTRkeHCskxljy/Ee6nnq7Ztlota/OT25wwnCV3bJilf3pDfWcMS1OTq/O8OnpE9+/C1cpOYU51KuZFS3qO2I3s2L75RfCT0woaqob//4yrUyxvwyTnOtruiGMMAVjfQGWMlVgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080387; c=relaxed/simple;
	bh=Azs1j++PbnTjm5mSNSF9J7lmO8rpPPvuEQ+Hk4bH4Xo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ke08k6NBFBoWQrvVcedShnaVJISPqmCnOPVbSd/aqAoKaJCaDdd45BiaTc+tlLHeuB/3GtQge/B4EDkSoOX92jDAJ3ap56q7gA4Z7vqrzdC/pZM+SHAcJ5rn0tP7WN+zrKyqdlL02worRgHdm78FE0i0JDFMzpz/wTkK3Zi+OaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TZZGIRoS; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TZZGIRoS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm/Un9uugPL1qi93rIiqB7P/wftBdIMLxoRH2Tn2i0Xzn9rhndgGL0VV6Aql8WfNNmTJP55xiy0JAWDXtz/FhM0+Jxv0zvOYhnBm7cIosEFC884EtItlU0/+M/hPrX3D8bfpBzLG8Czl0tG7obYUWz1bdACmlC8u9P/pxL2DTQAcRQlbdq887V/wUBn9GBWcwrsm3hBJKwUAultMhxuy53bqNAStO+Tka0ImEXVvvubixCn7KRdFo+HDn0ncYdcKvCzGRtjoVinfkRGtyNtlxqFGhX8w4OHMtT3wgPjvkY/uqWoYbkFr+OCcLKrQbjmXexfn/XnKkZh+AGFvqUT3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBiaeU1SCcu0vgS4x48uv19vK3l1XnaERkQftjQumMA=;
 b=AaYDjt5GEOyISxRHFIbWXQ2I+ldylKrW7SpC+AgtoKf/u9REFrYk/VaX5wMWktlawKcWx/FQ9JRzK8LsDHkK7y620W00utdyWDXl8NDS8a/7JgNX0fcbIiPHTPburB70Md8UyEiBt/REJGL0JSHmNdk4iZqQwOEj/mtU3e9Y3Q0gBgE78Y1mHb8qb01I9OEsbaeCjQq/WRA9kn5gYBd40ZzAnSdYze+7UA0XnPK11jO++vyfV+vs/DCkkxxm82/e/0+XvvXgSMunYXHBaFtuIhMKcp9y5mDAsx1ZLyY5AQJaGlfMsPqJVHsq3CpDskz2GEdldIqRmIY473JeFHZrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBiaeU1SCcu0vgS4x48uv19vK3l1XnaERkQftjQumMA=;
 b=TZZGIRoStqTmoC5KZ1QsY6LYN5G+PLGQ70P6KbYqfGqGIW1mDuIySgZc0I47QuGxGnN+CGpr5ABZSeixkDdUCwodNZNHP8qUENvPktuVCjzln6mPFvlduxEI9ApEdV+mIdf4UmjSqcLEBkJLY1oKCMR82iyMKjMz5wRPf+i6Aco=
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Mon, 18 May
 2026 04:59:40 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::6d) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Mon, 18
 May 2026 04:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 04:59:40 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 23:59:37 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <kvm@vger.kernel.org>, <seanjc@google.com>, <pbonzini@redhat.com>
CC: <thomas.lendacky@amd.com>, <bp@alien8.de>, <joao.m.martins@oracle.com>,
	<nikunj@amd.com>, <kai.huang@intel.com>, <yosry@kernel.org>
Subject: [PATCH v7 0/7] KVM: SVM: Add Page Modification Logging (PML) support
Date: Mon, 18 May 2026 04:59:09 +0000
Message-ID: <20260518045916.2988667-1-nikunj@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e7b6c4-44ba-4f05-77a8-08deb49a44e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|13003099007|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	vNvD6djjxg7dohXwIuxqerfqe3b7ZPN/XhTpL54HBbF5B7HGAJ5tkvprEF8BCidFjR4L4SqKGeKll2L+86+0HZl2py68hHCJaPxM9UMbAfsXoT0AFoMt6N745r+kpoLGTxcMHJu0s8TmCupCJLbf9R2PmmUJDJbjUTm0dHEWOY4n1cHTifMoDKRXEcZx8WFsZU+5Z7n7/ou9v4esFaPlePhEB7kEwyt8Mt7UJtx85bmq+4/Ji/OXDQfk4m2gqGnmNrc4kZ9AtkwPc7Umu+hXz7ZKIbibkwbb+RAUNv8BqbMlk1vh7geT+SUQm/cntE4sF7b+Db1Ef5PNbsbLEVyngtRW6KlHqjWTszOMMB8HLviwEtcDlPpaosjf/0xft7s5b6CqH3XZwZ2e7BiFvlE8+NDbDaowTryeBkc6XGQWn87t6+98U+T+AXddAwIdKzIsA5/Rzk1YEr+3v0tckHc6BASLwdo88AFZjZ8/sw1lHVE+PEb1NpbuQ74tPnprIxGvZQuIqRsEVV6cM9J2cr0kMza70oBgU9sq0Fu0JfMQ+keUdaAiEgkn+mnIOLvHbm9MUKDtNRY4LScpHkLEOMZr/SBaNDJj/5y33XkYNDU5b3+/xF5W4Wxdn/lR1j12IaKnUJ/vh8wBOfMu6W3O81ojILe2h+JZy8HxK5m1VWWuS3FfISiSPbU0Q3qNz76IOtLS7fhwMGptnrtv5kp6cTSl6qtqy33Cj6bhbEjFMQ+YGPc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zs1I1KGgTCxUnnPQttcRx5WhLeboTwTJOh8uPJ/LmKdXkvsMa9Tjr0G6+SXfa3qYtHfcEUgkh7LWOYQvky+t/NtsiFzqYPrOlBc0r1gClAKJwYE840MWnyU5O3zTFSwxCib4pVDaLknzBcK1EvurC+0StfAfuZcNUMSkNW3+iVU/1Nr1RzF1ZiCP1DKPpHC9pmX0HURZrNuuIb4jwRukFLg6PgGP9/x96K72Ah94HOhhd2PcsiYJM+6KExZUkvQbCXFBj+n0iStztTEkmudySQOeOgZlcIH0/xMXiXtJjDfy9xVL4FKYxnfp4EV8IbMPJMQZk3P2CpueqKrYasiVoQZnPsxFtNoKTv3i9+mN21DPycpCTFYfbVIS0E3fhNpwkREeYgKUpzKefsNgBIRGLMy0frG/0X6J9vV5GUh22PArs3YgBQ9+daxE1SjYXHmt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 04:59:40.6278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e7b6c4-44ba-4f05-77a8-08deb49a44e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159

This series implements Page Modification Logging (PML) for guests on select
AMD Zen6 processors, bringing hardware-assisted dirty logging support. PML
is designed to track guest modified memory pages. PML enables the
hypervisor to identify which pages in a guest's memory have been modified
since the last checkpoint or during live migration. More details can be
found in the AMD64 Page Modification Logging specification [1].

The PML feature uses two new VMCB fields (PML_ADDR and PML_INDEX) and
generates a VMEXIT when the 4KB log buffer becomes full.

The feature is enabled by default when hardware support is detected and can
be disabled via the 'pml' module parameter.

[1] https://docs.amd.com/v/u/en-US/69208_1.00_AMD64_PML_PUB

Changelog:
v7:
* Swap patch order to avoid adding @pml_page parameter only to remove it
  (Sean)
* Add Sean's prep patch to pass @vcpu to init_vmcs() instead of @vmx,
  cleaning up all vmx->vcpu usage (Sean)
* Drop guard(svm_vmcb01) patch; access vmcb01 directly in
  svm_update_cpu_dirty_logging() since VMCB is just memory (Sean, Yosry)
* Only initialize PML index on reset, leave unchanged on INIT to avoid
  discarding unflushed entries. PML_INDEX in the control area remains valid
  after intercepted SHUTDOWN (Sashiko, Sean, Kai)

v6: https://lore.kernel.org/kvm/20260407063245.2755579-1-nikunj@amd.com/
* Collect RoBs
* Rebase on latest kvm/master
* Dropped SEV PML selftest (Kai Huang)
* Added guard(svm_vmcb01) helpers to temporarily switch to vmcb01
* Use guard(svm_vmcb01) to ensure vmcb01 is targeted during PML updates when L2
  is active, similar to VMX. Dropped patch moving nested CPU dirty logging to
  common code; upstream now updates vmcs01 on-demand via temporary VMCS switch
  instead of deferring updates.


Nikunj A Dadhania (6):
  KVM: x86: Move PML page to common vcpu arch structure
  KVM: x86: Carve out PML flush routine
  KVM: VMX: Use cpu_dirty_log_size instead of enable_pml for PML checks
  x86/cpufeatures: Add Page modification logging
  KVM: SVM: Use BIT_ULL for 64-bit misc_ctl bit definitions
  KVM: SVM: Add Page modification logging support

Sean Christopherson (1):
  KVM: VMX: Pass @vcpu, not @vmx to init_vmcs()

 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   2 +
 arch/x86/include/asm/svm.h         |  14 ++--
 arch/x86/include/uapi/asm/svm.h    |   2 +
 arch/x86/kernel/cpu/scattered.c    |   1 +
 arch/x86/kvm/svm/nested.c          |   6 ++
 arch/x86/kvm/svm/sev.c             |   2 +-
 arch/x86/kvm/svm/svm.c             | 108 ++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.h             |   3 +
 arch/x86/kvm/vmx/vmx.c             |  72 +++++++------------
 arch/x86/kvm/vmx/vmx.h             |   7 --
 arch/x86/kvm/x86.c                 |  31 +++++++++
 arch/x86/kvm/x86.h                 |   8 +++
 13 files changed, 195 insertions(+), 62 deletions(-)


base-commit: a9512a611bd030088f13477258d1f8103cceaa40
-- 
2.48.1

