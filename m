Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974523FC41;
	Fri, 24 Apr 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052561; cv=fail; b=HW77Lot4YhISIchXhR4g84X6DVt2jGdBS0CJQSHeAfZpy5pjwO2bfRvjTyHza20e6m7Okl3K7ZIg12gGzC0K9uR5mItiWJQqoBd/N145m0C1TfO5lXo46djEqu+K00ccJ/8mu23ZHJjlJLyU6efFYAoMG3W1RoedpfZY0AP7K50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052561; c=relaxed/simple;
	bh=v5f2E3JEDnUX4qD8/xhGbOo5PfojHsht+Y6MpQ7X9Rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Evw0ZNEapYTIrCLzeAHeqCgIZbMXV+YluKn3wsuAqA+su4WynyZEXnB3ukRQa2KF/UKL20CO7rR8njN5EFwkX5mGbOtb/9doA9OYHStxklSrkbJiLpLIc/rij48DK657T+ed4fZJLEQZUsuz9w19iHsPtZHeDMgqK0ehaWXT2o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IqbqnYGk; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IqbqnYGk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVQLyT3UfYqTh5d7J3sgCUt9iuDSe+H9TZHD1+HsifH/jsPRhNxagcw7Z36X25LE2OSDT7vQfXtap3cPWj8/lNxumfQIZzRh/3y1yAigRLj3/IIMKplxCPn76rQjAiexLOnrCHIEPxVNX8IjLRNaYrtKKMK1GhEJ3/u+D1jdwAXw3SxqDn/q9JaB/qGY+q0j7ISEMcg2Z3i/bQJkucHTugErjT1BWXbqNctheCT/e69Y2Ds/cD8QTRoZENvyuNZkDIFXlIRtD2H4tVjvk63wrQ56Um0daJaRpH1Lpqn7YXpcq8kKpmmBGtcbaJ1XuhxZ/rdAqSGsKS9i63CheY3OdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NETC/ZOHb1m97pMCMbit3+MBln2OHviH3x1fl6ZmcPM=;
 b=mlg7TXunvdyUYEZOHry/cxOCvbL4znpCPr0XgFWG6neHgm8O+7rE8SSYAS8anesOjOSWWSt/V2BF8YDuKSiLGP35NHr6yOp5UW+xycv13qi7j14UfTVk6YOTDj64P7gwps7tQfMOCGwLLdBf7sc/Dl7xfbo5DO/nGOhuH39wwc5rWVj+flJraeAOk6ANDf3D0ybVdO8QznmssA4+Udira9U9OlsOdUl82RBdFJpsMRJmB6Ux1sCiBmF4/OPnYUHZcgMN8SA7YlFDxjHdzK2DxJmkIT67GPsA3xvxBs8Ax6cr4Bw9xaG+kg8syXyVAVLG4MMGJGjZtXrqMffTEojiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NETC/ZOHb1m97pMCMbit3+MBln2OHviH3x1fl6ZmcPM=;
 b=IqbqnYGkuR+lONsDjTWDy25q/jJvjpf0j1SuG04ZL4Ykffrfn0Lgc4dLcqQEPiKT5Dupc41riSEFdgRBtCkjyLZ6OmVvIpeJ65FPRLNB5m7byHeiONLr0ctOPmX9GmuXSWgHsNOd47On5DxD8ufRM9uzV0yUeG7PhTjID9Max6E=
Received: from BLAPR03CA0054.namprd03.prod.outlook.com (2603:10b6:208:32d::29)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Fri, 24 Apr
 2026 17:42:33 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::f) by BLAPR03CA0054.outlook.office365.com
 (2603:10b6:208:32d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Fri,
 24 Apr 2026 17:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 17:42:33 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 12:42:32 -0500
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Joerg Rodel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>, Melody Wang
	<huibo.wang@amd.com>
Subject: [PATCH v4 0/7] Add SEV-SNP restricted injection hypervisor support 
Date: Fri, 24 Apr 2026 17:42:04 +0000
Message-ID: <cover.1777048608.git.huibo.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 157e1118-43cc-4e14-79be-08dea228ddad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ds5chreBEiuPF9fE225yaLy1bIKKCGrhAZYIh6xfgwbXDckh+W0ARwrFBuaFEXl4gWfVnMnb1VmmPHAcfk+3Gl+hkG3+zPLXmmDrs31P5d6Gj+zocJP5LXUSkqjyA+o9znGarOOYYRljatxI9vcutONWPEFffalnne5EdVQzMeNJcfxFGr+0Quf9SJtT5csrtyR4DLoI2M8wC80sYaFActgIvMa/7iejCJTQb8Wja0x6yD/ElNo7Gojbvln4OKH1r5ncH9rnIKrdtmEYMAtip8pET3y3e+DiA0FDULBYm53jQ/Qs+4oFtzN/04FJZpre/eCuTK/Q9V4xixc78aaRyZvmeKHHMGgrNBJqno0CCBt4YNuo3U2O0sG09hlmQFClVQkIsIbvwNzOXuaMru9cuni5TMyxQI7TmmUUpt357jJEhDtnj7DPAK5bB7s4CUs0I7Jzbypq5yTUSvG1Zdf8nSLbt5hp5riznliQcaq4zvzZ5v5QJjQ8T3TmZpZnwtmKHoIWkkpdn92NMIC3uqaAPJvG3v5zoBNb5xEKTYsZUxV1t1shfJ4MsJFmMfyaQcocIfprBj4HQUEwWdulDZApVA/R5Y8QdnXTFvVpRN87Jd95KQJ/goLcH33Lo4clJYqKRyskFi2UsMpLWXokjMtv3Qq9rp0MDDyZZfZ3K6dt2f2vcy0OQ+qtuSfSJU2UWwBUNvel4hGLTBCJDstRgUJkEzFV9FkUNncm3SUd+AEhrIvHAd1Z3Zkqgvm92lyl82t3ZVMuG5fdqux4sBpFnlERDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mks43RvgLMj6e3zZcNe8GAoACxDwGLSPmV3tAY5YjaWCMG08GG2M2gqB7wPtmurIm782okwomT2QXvSC2wOe5BwwmuUfWtabE/+oco6V2SbOPHGNjZ0vOFxUIUDKTjLNNQfj+p2ZgMmKDpgeDAglmU7rKnPxhym0Y3JF75afpcJ3p1x5zUspeZyDnJ6LaIwH4nA3FmgM4oVqAemR1OCJ65rERtJyS9R4xQnVt7NWgxDqtNDliKokqVajB97FNHXbBvZGD27t6YgxFtfWOlOGPXdS24SLNTE8XsugFeDH52imeKNkvfuJM8Oi924vWRJzbnbxjl761FaHjdUOdR5Mai0SPjbWSuoT2I2Y9XXojYuU+c4njnlO1n7bwgtwp7JKqTerFUgeMotJdpB5sYPukSHZN4lBNk04THVzaZR6TXd+sfAMD8OhB1Beku8hSdAV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:42:33.4274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 157e1118-43cc-4e14-79be-08dea228ddad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859

Hi all,

This is v4 of the Restricted Injection hypervisor support patches.

The previous version was submitted here:
https://lore.kernel.org/all/20241127225539.5567-1-huibo.wang@amd.com

The new series are rebased on commit 6b802031877a995456c528095c41d1948546bf45
(kvm/next).

Restricted Injection (RI) is not a prerequisite for Planes support. Even
though the SVSM requires RI, RI support can be submitted independently. Since
the number of Planes patches is large, submit RI as its own series.

Changelog:
----------
v3

This is v3 of the Restricted Injection hypervisor support patches.

The previous, v2 version was submitted here:
https://lore.kernel.org/r/cover.1725945912.git.huibo.wang@amd.com

Since then, the series experienced the following changes:

1. Remove unused field in struct hvdb_events.

2. Add comments explaining sev_snp_blocked() with no_further_signal and vector.
   Explain that only a single interrupt vector is presented by the hypervisor
   in the doorbell page. Only when the interrupt is acked, the next interrupt
   is presented.

3. Add warning in sev_snp_cancel_injection() when vector is not #HV_VECTOR.

4. Update hvdb_map() failure handling. When it fails, no interrupt will be
   injected.

5. Remove sev_snp_queue_exception() in svm_update_soft_interrupt_rip(), since
   the soft interrupt is only BP_VECTOR and OF_VECTOR, so it will always return
   false, then sev_snp_queue_exception() will be executed in
   svm_inject_exception() always.

6. Add new #HV IPI feature in XAPIC and X2APIC mode, test each mode with three
   IPI types: broadcast, self-IPI, and allbutself.

v2

Hi all,

This is a v2 of the restricted injection hypervisor support patches.

The previous version was submitted here:
https://lore.kernel.org/r/cover.1722989996.git.huibo.wang@amd.com

Since the previous submission, one issue reported by the kernel test robot was
fixed.

All comments and review feedback are appreciated.

Thanks.

v1

Operating systems may not handle unexpected interrupt or exception sequences.
A malicious hypervisor can inject random interrupt or exception sequences,
putting guest drivers or guest OS kernels into an unexpected state, which could
lead to security issues.

To address this concern, SEV-SNP restricts the injection of interrupts and
exceptions to those only allowed by the guest. Restricted Injection disables
all hypervisor-based interrupt queuing and event injection for all vectors,
allowing only a single vector, #HV (28), which is reserved for SNP guest use
but is never generated by hardware. #HV is only permitted to be injected into
VMSAs that execute with Restricted Injection.

Guests operating with Restricted Injection are expected to communicate with the
hypervisor about events via a software-managed para-virtualization interface.
This interface can utilize #HV injection as a doorbell to inform the guest that
new events have occurred. This patch set implements Restricted Injection on the
KVM side directly into VMPL0.

Overview:

The GHCB 2.0 specification[1] defines #HV doorbell page and the #HV doorbell
page NAE event allows for an SEV-SNP guest to register a doorbell page for use
with the hypervisor injection exception (#HV). When Restricted Injection is
active, only #HV exceptions can be injected into the guest, and the hypervisor
follows the GHCB #HV doorbell communication to inject the exception or
interrupt. Restricted Injection can be enabled by setting the bit in
vmsa_features.

The patchset is rebased on the kvm/next (commit 15e1c3d65975524c5c792fcd59f7d89f00402261).

Testing:

The patchset has been tested with the sev-snp guest, ovmf and qemu supporting
restricted injection.

Four test sets:
1.ls -lr /
2.apt update
3.fio
4.perf

Thanks
Melody

Melody Wang (7):
  x86/sev: Define the #HV doorbell page structure
  KVM: SVM: Add support for the SEV-SNP #HV doorbell page NAE event
  KVM: SVM: Inject #HV when Restricted Injection is active
  KVM: SVM: Inject NMIs when Restricted Injection is active
  KVM: SVM: Inject MCEs when Restricted Injection is active
  KVM: SVM: Add support for the SEV-SNP #HV IPI NAE event
  KVM: SVM: Enable Restricted Injection for an SEV-SNP guest

 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   1 +
 arch/x86/include/asm/sev-common.h  |   1 +
 arch/x86/include/asm/svm.h         |  33 +++
 arch/x86/include/uapi/asm/svm.h    |   6 +
 arch/x86/kvm/lapic.c               |  24 ++-
 arch/x86/kvm/lapic.h               |   2 +
 arch/x86/kvm/svm/sev.c             | 312 ++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c             |  42 +++-
 arch/x86/kvm/svm/svm.h             |  26 +++
 arch/x86/kvm/vmx/main.c            |  10 +
 arch/x86/kvm/vmx/vmx.c             |   5 +
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |   7 +
 15 files changed, 468 insertions(+), 4 deletions(-)

-- 
2.43.0

