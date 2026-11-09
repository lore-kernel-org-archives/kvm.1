Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194340;
	b=Tc7s3I+fkBOYeMvbVxIMsvLuNHEjJwEMD5T5/WW6NrDrnEZByR7wYvtfg8ITi6tIol3k
	 NuLQKSMgvUPQPTrGovo3IulSOJ+8wJ5IuVtFMvDfVI7dVUH4WU4UTooQXUskyu+BHXrG4
	 2x54gOZmlXOI5BqPK0fVcw0OgHrp9e2wYM24NCcKY/L5GSi3rMYMjN5j+YO+rp0fcw3FG
	 Y6y9ITYbAABl/fRQxMynNHH0e2LW4G2tjbfmfcO20adJkAtm0Z0bZ+SPf2YsFRhXrjIBy
	 /vHcqJM5lkrfsUXl0/tpBEd/rK6rJwdK+dTNt1fHIYvHozNgdO154CkiSaIGJSHwHHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194340;
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
	bh=s2o+ZV8QG5PzyES4lN/qxvm3eNAAo3JsG56dq5Af3XI=;
	b=aTvkOje6eV3GpNgb6UaMF43DHeUtajy7otaDN6Z67/wI3UgDSv5q2TzdX33RiuSB2UVF
	 d/uB3qjsYSM05x8PjTKJVJxhB26I3hF11tyVbgVXTzC4N/SwEi5bAUf8xP+XDySAul7dH
	 CI8Po9+641IxiCIesbyAKOWt3yt09IzeeZdw5KFIa8oImMirr1H20PxBu5FXq1mv38Zil
	 Lxbkpu/FfhwgYDnyrtOJvgvZVQta20p4MqEBMFprsqAMC8HLA2sa1kP15zhHp0uu2zq6E
	 VoicNmOxfqb6h6Ng76vGJNnDOFDHoxFbCX/Arurd3k+BEs/6TGUFeMKkutj0SuBFoTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dIAcGFXa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.3
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C4606A330;
	Mon,  9 Nov 2026 03:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 795C4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dIAcGFXa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvSJtA89V801bV1DYehwJ3PZR5PAyPUPZCMDbwXgaCNvmKv8UOrGptVPtzMcPPDkzwV2K40RM7J9bRXjVCTSXuyoNP3Ply0DHGCbMP93e/TU/BjNPA1Jn+T607XAOxU9noor/U35NMY8trJpXoV1dZx3E1SARUK7tylM+qTAIUBIGPuuaFK+UkuF4ZcIjL9Cuj4qsSkhhTKFYobtYxQiLt0TsRIbY1NzuN4kAgupwstZVw8dDye/GeGKoZ8yXAg/JnNoxYaOT1ph71Php8mEVZiKYFv9n3LsgNGSYL2JEChmPRxCHT16OKpbD8TIDkFsRgutdMDjFqqaQKtfMbQK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2o+ZV8QG5PzyES4lN/qxvm3eNAAo3JsG56dq5Af3XI=;
 b=WItAjkZv52XaFjwMxEVHLLh91vr6VcNxqVkZetIGplXgNi/04Q1V1aD5OnxUMuOjV8ldNtZJrIZAyV6C9w2oCsQr1+aR29IepqD91pFTBQJOmp36tTKH0tRPtuu3kZlG2LVc8mKTw5cw89qUoZ11iyt+Qsp+Z20moTmEEpBX65W1N62m38M0PAYPU1mpe60MZ3hof/t/HVRw1R+uJkUxJb2C1t92adIvNwaUHQHVemcEDJBu4cPGnbYc0DroEopodAKta6nHfjmjBPFKkxnQTOg1F6BBYMYXHR2/wXrHlFfK1JDC0bmwP0rq70Voo8kLhoV9qGaTj/wgYumzctqBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2o+ZV8QG5PzyES4lN/qxvm3eNAAo3JsG56dq5Af3XI=;
 b=dIAcGFXaI+uGQmWYllD1Q2Qa+vS/S9/uTHpcYUQu02KTt9jOWR8G6mvkzzaLtTnTxfZAvUoQQWSUjSHVB9jGux1pO6H3UYdZ3mDTMJUtgSfpOs17s2AOtZ7srO9wLt3yOsJZxBhF6ZCjyfWwbFdBhM4DUZMjKfOxqkXLo3gW1NE=
Received: from CH0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:76::23)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 03:18:54 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::35) by CH0PR04CA0018.outlook.office365.com
 (2603:10b6:610:76::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 03:18:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 03:18:54 +0000
Received: from purico-9dcchost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 8 Nov
 2026 21:18:53 -0600
From: Melody Wang <huibo.wang@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<bonzini@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <x86@kernel.org>, Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH v5 0/8] Add SEV-SNP restricted injection hypervisor support 
Date: Mon, 9 Nov 2026 03:18:32 +0000
Message-ID: <cover.1794171754.git.huibo.wang@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f0c60e-035c-42f3-b8ea-08df3e102f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|6133799003|10067099003|13003099007|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021123027099003|261021135927099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	TqcTquYeYYD4X2rhny3RkZ3k5nlbREj0MAeDYY9q6ju2twbReQYj3tvxOm4qPZwEWQGfPPZlKiQ5rbsWDGz0GGhSDR2a2FewnoPPVe1+2vp37bZ/8p70AFxgcekHomGopMZfz4xpgOWvBnrO6/GrBqoAle9MQ8LFFB8PYMMMzK0virnK6kNzVAJQ0NcWPkwVq7enfIn779370yRv6JNq7bIZemxI+r7e57o2losdya52sOCmLNzWxk6T0VV5p+17qNGCO/e0B6lwuZMPDgm8uqBUhIW/N8AOnkGobncrPYq4C9GBbzFX+Cn7r8dqxIAH/e7ROEtKHqbpt2/M45KXscHmVtQZluP/3KE5hydGoTeIMqMDxYkS4xf/T7OIELacmLZ011b1BfHMQxnzYuEX9uzFntxZ58QPD4KcglN4mY1n9zgujuGAWnqwvqlvmEVOW9NSS40G4/fRA+gH5O62OEj8HYDDncSl6xtWp56ghbDQFs7+cpJxhYONo6ykKupmHPb/kyiuPmKATu06GL9pQgiD11dSryKqDSQ9tFbxzlzBTNc1D192+1G1/dD3mJWwXvuYTV2sL0rBUFhv3ImjmHoG/gXXhRKm6jcvSo9r0TrKoD+MY+B0Qtg0oQL1ylCiZ/bzDz1BD2NBT/frPEH7Tw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(6133799003)(10067099003)(13003099007)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kCGRZg1wuX8i80Yxz91tFLVQMP95hVnDoaB+ZVXkpHYuGA7C6JBxNnKTz+RXAsn/r1itieXWaPXmqrNRJ5Xwg3+ZlcWBSc0VJu6jUC9Fwmd+KMWuPbw4ukTi8BvFL59A5rffr2Z2iHOeOwwAJORkLzoH/yhwKY1gq6Z79Pm/A9SHCEEbJdS3m577B9MJvwSJeiEq8KhSv4AWaeqZ0Sp2wOo9XSisjDBhlcRzeLLoOJaTbCCMYNvUEypJITzjhdO1ITj30Hf7YfqpRQumKLlofrEq97WKB5pWo/68RoUbTBFgfEw9QVx4/bJEvqwadTZC/lR2ety2K+DGploOmz/70i8E53YkQv9igu7GZXb7XdDvmycoKPSZWW/Df+2dsAmKTtJL0Oty+mZsBRcnEQVaasU31+YaBFom0TGrmv3uSNiwYqOlf3UmQldf9cj6A6LP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 03:18:54.0995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f0c60e-035c-42f3-b8ea-08df3e102f27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

Hi all,

This v5 of the Restricted Injection hypervisor support patches.

The previous version:

https://lore.kernel.org/all/cover.1777048608.git.huibo.wang@amd.com

This is based on d4b7fb647204f0c81dfeae2d1a708e4d858e0c94 (kvm/next).

This series addresses v4 upstream review comments from Sashiko, Tom, and
Joerg.

The main changes in v5 include:

1. Guest-Driven IRR-to-ISR Transition: Instead of moving the vector from
   IRR to ISR directly upon reading (matching legacy interrupt injection),
   KVM now waits for the guest acknowledgment before moving the interrupt
   vector from IRR to ISR.

2. No-EOI Handling: Added handling for the 'no_eoi_required' case.

3. HLT Intercept and Architectural Alignment: Added a new patch to properly
   intercept HLT when Restricted Injection is active. This addresses the
   guest's loss of control over HLT/interrupt interactions by immediate guest
   re-entry on pending events.

4. Sleep-in-Atomic and Scheduling Fixes: Resolved critical issues caused by
   kvm_vcpu_map() calling paths in the HLT fast-path (sleeping with local
   IRQs disabled) and during normal vCPU block polling (incorrect
   TASK_INTERRUPTIBLE/TASK_RUNNING state transitions causing livelocks).

5. Refined Cancel Injection: When canceling injection, KVM now only cancels
   the #HV event while preserving the pending interrupt information in the
   doorbell page.

6. Priority-Based Vector Overwriting: KVM now overwrites the interrupt
   vector in the doorbell page when a higher-priority vector appears,
   avoiding sending an unnecessary duplicate #HV.

7. Documentation and Review Feedback: Improved several comments for clarity
   and implemented code fixes for valid issues pointed out by Sashiko during
   review.

This patch set remains an RFC. There is an alternative approach that I
will present at KVM Forum 2026 in the talk: "COCONUT-SVSM, KVM Planes,
and Secure Interrupt Injection - Upstream". I plan to update this series
further after gathering feedback from the KVM Forum community.

Thanks,
Melody

Changelog:
---------
v4

This is v4 of the Restricted Injection hypervisor support patches.

The previous version was submitted here:
https://lore.kernel.org/all/20241127225539.5567-1-huibo.wang@amd.com

The new series are rebased on commit 6b802031877a995456c528095c41d1948546bf45
(kvm/next).

Restricted Injection (RI) is not a prerequisite for Planes support. Even
though the SVSM requires RI, RI support can be submitted independently. Since
the number of Planes patches is large, submit RI as its own series.

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


Melody Wang (8):
  x86/sev: Define the #HV doorbell page structure
  KVM: SVM: Add support for the SEV-SNP #HV doorbell page NAE event
  KVM: SVM: Inject #HV when Restricted Injection is active
  KVM: SVM: Inject NMIs when Restricted Injection is active
  KVM: SVM: Inject MCEs when Restricted Injection is active
  KVM: SVM: Handle HLT intercept when Restricted Injection is enabled.
  KVM: SVM: Add support for the SEV-SNP #HV IPI NAE event
  KVM: SVM: Enable Restricted Injection for an SEV-SNP guest

 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   3 +
 arch/x86/include/asm/kvm_host.h    |   4 +-
 arch/x86/include/asm/sev-common.h  |   1 +
 arch/x86/include/asm/svm.h         |  35 +++
 arch/x86/include/uapi/asm/svm.h    |   6 +
 arch/x86/kvm/i8259.c               |  45 +++-
 arch/x86/kvm/irq.c                 |  51 +++-
 arch/x86/kvm/irq.h                 |   3 +
 arch/x86/kvm/lapic.c               |  46 +++-
 arch/x86/kvm/lapic.h               |   3 +
 arch/x86/kvm/svm/sev.c             | 403 ++++++++++++++++++++++++++++-
 arch/x86/kvm/svm/svm.c             |  96 ++++++-
 arch/x86/kvm/svm/svm.h             |  35 +++
 arch/x86/kvm/vmx/main.c            |  10 +
 arch/x86/kvm/vmx/vmx.c             |   5 +
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |   9 +
 18 files changed, 735 insertions(+), 22 deletions(-)

-- 
2.43.0

