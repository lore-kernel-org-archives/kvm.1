Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27048423E9F;
	Fri, 25 Sep 2026 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336556; cv=fail; b=iYBaFIIJtii0tknzJ0AxJryeCYFwiWYryiRJnQYrvPDvho+mqtRCTpMS+rL+Iv61lIFoO0qDSi/qgA68HZeWsyQRdfaYwt8pUkkM6EyV5tg/QJ0rr2sexKxkA66K3KzLFK09MlZb8jwppGd1HJaU5v8SKXyfVp4GvxsFJKoGJxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336556; c=relaxed/simple;
	bh=z0VLupQrMpCJhlG3aScizptyq39Oae3F0xs3HFWNgh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=POikQx/ewjsq15CScJtATLBP7LQx88WAKvehgZCabyx20EYpIUUnoXzvE+b8ifR2F46ioRbBiXZuah64KSfY56IhnIhZEIWku/jF3bOalN9g7Is0bFxuXUQWBrW/YMejc+Mn7TCYPrycEs3SWSPJLCS1B+Cbz1HN3T7/tEdE7LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RPiQVyVb; arc=fail smtp.client-ip=52.101.53.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RPiQVyVb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njUAouPqgURHsXncACwtIyzBKdPHBU/lT1vibzHfXyI8p9cVZsc2uI2LpBVeQDxklsMViIsJ8YcDuqIxZYIew+tnidSWcSkzAy0kQPQYWLptoDbv+jLzpmAXVEy/ajcl/GBx1InY+sXsBamEhcuz0/54hyuONBdURnwstfbQB6r+8Y/N4uy4H/TXR50Us0yR91kfI9hcmxQZM9cL/oh450Nlbc/Ym+c5wXC6ujgEFhvJaRytTE7SFbtypzNP912MyPPwPMJ5AngF1SmAQahz+EvydCh49S0HksE22mCEzwhQBAzoPB51Eo5A1QM0cEeSaWq6uQ2/JnOAJ0wJVAM4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4Zy/wOpHBzpnQBmZbuayMjz9HbMbQI+96DVZPaZTRk=;
 b=VYaaow0cQWJBH0mV2JctOsk/Fc/nJY+JnJBkucmdXiZ3ixZ8+FWkTMvMH8Hi4nue0haSxvYsgErm/DR2fkRUEXiXK5E9UNZdDZ+Y7iQhtZnLObgp/WZjgIqqFSC2U/IEbn3g/zMJs+WoXl0eTHUlG9eGEcMml8YVfriFczTXkAtWUGLvMcNIe/j4FMkAGTtTmPz/bkhiNmz+1v9x9S5lHOJTkSWJECzKWYgnFcotgufXIRfol+k8ckb9iNMmPMx30pPbZBQ1YZTxqBibVOm0VqKzKbRmvb/l7R7bnksyxzuseUJEvulfX98xnX+6KCLruYfygdDdmA7ghL88Ve6obA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4Zy/wOpHBzpnQBmZbuayMjz9HbMbQI+96DVZPaZTRk=;
 b=RPiQVyVbeTwBAhsk7cRmmHM8twkUEsbsI2FnNruPRktFlKLbjAfC4xcvApClvU5ytzCZZv3nut1L4QzUXJss2j0Hs7DLEB27RqMTc1CmhjoXKuiSzOy+G5ayAxtuRm12ScYwvj9330xPjkwNqfY959M+4yB4CVAYUv136XsYgoQ=
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 11:42:28 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::33) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 11:42:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 11:42:28 +0000
Received: from purico-abeahost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 06:42:22 -0500
From: Shivansh Dhiman <shivansh.dhiman@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<xin@zytor.com>, <andrew.cooper3@citrix.com>, <sohil.mehta@intel.com>,
	<dwmw@amazon.co.uk>, <yosry@kernel.org>, <nikunj.dadhania@amd.com>,
	<santosh.shukla@amd.com>, <shivansh.dhiman@amd.com>
Subject: [PATCH v3 0/9] KVM: SVM: Enable FRED support
Date: Fri, 25 Sep 2026 11:40:08 +0000
Message-ID: <20260925114017.2208531-1-shivansh.dhiman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 5796c8c4-7af6-4fb6-2bb9-08df1afa138f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|23010399003|6133799003|18002099003|3023799007|13003099007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9ndKIIQrWzILkaPm9dUewGYYdKlg/PWyDM3dBPCMtFFyMqv/1zU56bEXDbV7hmCnSVPqruiF2qSEfoQhKR+AkxDyPEdCq6Rxn9ALXeCOOXj9R+GbD6ZDKiz5uTEFnLzLq0YXT71EMod+Nbdti8Snc3r41P/eQQpIiedj4XhYWxDv7mE3OojcgnPKA3xmFu+UjCMKTUp57Hd6EUxj5tzrSaEGvZ0Ew3Fg9flMK8V/jM0LrpGwPV1T9MmBmk4P3HOhKPH9/dHtA1e/5OfLLcz7CYd9dTej84n6ZJYLxs3tOU4+JpiCclOv2yCAdDUD68y/rg/A5XIDrLqkMIiiT8+ktzDrqx3FZsb2N0l86AcWctwCacVFBiTDiwPeqXD+MYzOYpo2XuNRjESYkndyM7XtqmuLONwFbeb1MnSw3wWO1VB53gMDF53nU+F+oTofcr5nwRx7PpaqU8kkthFeDOhB4ZOUK0iQ4QB6Edjnrh4Q7PWAserva9+gp9Otnb4usDINYk9y3PnkZFK/jbnVtcwmxRh2vp8P+K5nom4WRUwR/eThWVPTqtg9Ye8BlE/AiQMVP3PZ4O8REpSR5i0AkShjvV0h3GZ88Kei+I/AGllumn3qVSeX1vojddazvosrLnhpRxNlLm9lysU/AqkzEqyYA58scfs4ceRV/cJcv0Jlbzg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(23010399003)(6133799003)(18002099003)(3023799007)(13003099007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BPY3MNqAwUfxQiqqDxJfMAsLnZCTPp6Jm1zzYvxdkvNqv79yrP7/B0GKZXQ+t8n3s4e/jOxqSaEGa+JIhnnluGT4fmmLDgxK0w4GMjoTK4Fi4tWFzXxgGNZrChz1WIJt8G7Tdv0Z/6tVO8qH02IQGhQ0N+8NVbEW9qo90IAv/6xoOmpNHnzTK3mtjymhyKSX3zxntQdc6apiQKhuYAznEcw3ee2v42dXNYR4FlAmKk06WMLma51k5F4zZcSoAhaY7vcoNTqIOAWwD/HELJ2C8Eif1CFzb1xopQ69Se5n5HroaTB/xlhQmGBa/l3ZgxiCcf2guT3dA8n+igMY28sTEv7KD1hKp+UrnHWvRbEHLc2bAx544mVgJP5WNu1Q1Ok7IbBM63nZWH0QxHa28DhRif+jwUeq9b+HyWBH9D2+SstOrT6wx4ZaT4XNtljavqvb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:42:28.0944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5796c8c4-7af6-4fb6-2bb9-08df1afa138f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716

This series adds SVM support for FRED (Flexible Return and Event Delivery)
virtualization in KVM.

Background
----------
FRED introduces simplified privilege level transitions to replace IDT-based
event delivery and IRET returns, providing lower latency event handling while
ensuring complete supervisor context on delivery and full user context on
return. FRED defines event delivery for both ring 3->0 and ring 0->0
transitions, and introduces ERETU for returning to ring 3 and ERETS for
remaining in ring 0.

AMD hardware extends the VMCB to support FRED virtualization [1] with
dedicated save area fields for FRED MSRs (RSP1-3, SSP1-3, STKLVLS, CONFIG;
RSP0 only in the SEV-ES VMSA) and control fields for event injection data
(EXITINTDATA, EVENTINJDATA).

The implementation spans nine patches. The important changes are:

1) Extend VMCB structures with the FRED fields mentioned above, disable MSR
   interception for FRED-enabled guests to avoid unnecessary VM exits, and
   context switch FRED_RSP0, which hardware doesn't save/restore for
   non-SEV-ES guests.

2) Support for nested exceptions, where we populate event injection data
   when delivering exceptions like page faults and debug traps.

3) Let userspace save/restore the FRED MSRs, and don't intercept ICEBP
   while the guest has FRED enabled.

Major changes in v3
-------------------
 * Rebased on v10 of the FRED VMX series [2].
 * New patch to save/restore the FRED MSRs for live migration.
 * New patch to disable interception of ICEBP when the guest enables FRED.
 * Update the FRED fields and their offsets in the VMCB to match the latest
   APM.
 * Clear FRED from the KVM capabilities when vNMI is unavailable.

The full changelog is at the end of this letter.

Dependencies
------------
This series applies on top of:
 * v10 of the FRED VMX series [2], which adds the common x86 FRED support
   (CR4.FRED, the FRED MSRs, exception event data and nested exception
   tracking).
 * "KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown
   intercept" [3]. It keeps FRED_VIRT_ENABLE set across an intercepted
   shutdown.

Testing
-------
Testing was done on a Zen 6 machine in the following scenarios:
 * Booting FRED-enabled guests and checking that FRED is exposed
 * Running SEV, SEV-ES and SEV-SNP guests with FRED enabled
 * Live migration of a guest with FRED enabled
 * KVM selftests

The msrs_test modified in the VMX series is passing, however, fred_test
doesn't pass on SVM yet. A fix, if needed, will be posted in upcoming
versions.

Opens
-----
 * INT1 event type: As I understand it, SVM intercepts ICEBP only because
   an ICEBP-induced #DB delivered through a task gate otherwise ends up
   with the wrong RIP [4]. FRED has no task gates, so patch 9 drops the
   intercept for FRED-enabled guests. The CPU then delivers INT1 itself,
   and the guest sees the correct event type 5. David, does this look
   like a reasonable approach to you?

   However, when KVM itself injects an INT1, the guest still sees event
   type 3 instead of 5, even though the hardware supports it. I think a
   generic fix in KVM may be required. Any thoughts would be appreciated.

 * Nested FRED: FRED for L2 under nested SVM isn't part of this series
   and will be posted in upcoming versions.

Links
-----
[1]: https://docs.amd.com/v/u/en-US/69191-PUB
[2]: https://lore.kernel.org/all/20260911213659.2025974-1-sohil.mehta@intel.com/
[3]: https://lore.kernel.org/all/20260824131824.6040-1-shivansh.dhiman@amd.com/
[4]: https://lore.kernel.org/kvm/e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org/

Previous versions
-----------------
v2: https://lore.kernel.org/all/20260402184240.1939480-1-shivansh.dhiman@amd.com/
v1: https://lore.kernel.org/kvm/20260129063653.3553076-1-shivansh.dhiman@amd.com/

Regards,
Shivansh

---
Changelog:

v2 -> v3:
 * Rebased on v10 of the FRED VMX series.
 * New patch to save/restore FRED MSRs via KVM_{GET,SET}_MSRS (patch 4).
 * New patch to stop intercepting ICEBP for FRED guests (patch 9).
 * Keep the guest's FRED_RSP0 in vcpu_svm for non-SEV-ES guests.
 * Updated the FRED fields and offsets in the VMCB per the latest APM.
 * Clear the FRED capability when vNMI is unavailable (Andrew Cooper).
 * Renamed FRED_VIRT_ENABLE_MASK to SVM_MISC2_ENABLE_V_FRED.
 * Use ex->is_nested to check for nested exceptions.
 * Updated the FRED prints in dump_vmcb().
 * Updated the commit messages.

v1 -> v2:
 * Modified the zeroing of FRED MSRs from INIT to RESET and updated the
   commit message (Sean Christopherson).
 * Moved FRED MSRs save/restore logic from svm_vcpu_enter_exit() to
   svm_prepare_[host_switch/switch_to_guest]() to reduce some MSR
   accesses.
 * Confined the enabling of vFRED to svm_vcpu_after_set_cpuid() only
   (Sean Christopherson).
 * Removed the need for a new function parameter 'reinject_on_vmexit' in
   svm_complete_interrupts() (Paolo Bonzini).
 * Used guest_cpu_cap_has() instead of checking VMCB bit in recalc
   intercepts (Sean Christopherson).
 * Gate all the FRED MSRs through guest_cpu_cap_has() while dumping VMCB
   (Sean Christopherson).
 * While switching to host, added a safety check on guest_state_loaded.
 * Variable rename from 'fred_enable' to 'intercept' (Sean Christopherson).
 * Replace variable 'nested' with 'is_nested' (Sean Christopherson).
 * Formatted variables in reverse fir-tree order (Sean Christopherson).

---
Neeraj Upadhyay (2):
  KVM: SVM: Populate FRED event data on event injection
  KVM: SVM: Support FRED nested exception injection

Shivansh Dhiman (7):
  KVM: SVM: Initialize FRED VMCB fields
  KVM: SVM: Disable interception of FRED MSRs for FRED supported guests
  KVM: SVM: Save/restore FRED_RSP0 for FRED supported guests
  KVM: SVM: Add support for saving and restoring FRED MSRs
  KVM: SVM: Dump FRED context in dump_vmcb()
  KVM: SVM: Enable FRED virtualization
  KVM: SVM: Don't intercept ICEBP while the guest has FRED enabled

 arch/x86/include/asm/svm.h |  33 ++++++-
 arch/x86/kvm/svm/svm.c     | 180 +++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.h     |   2 +
 3 files changed, 207 insertions(+), 8 deletions(-)

-- 
2.43.0

