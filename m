Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784333508E;
	Fri, 16 Oct 2026 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187660; cv=fail; b=XEtdxjjeGM0wWLyDKf2pyfXhPf/A8nvpy1TG9Ebmp/f8rEpCHZCFVZ3LXbF4m3GhW7lTSwajPX+WafeOSlI62OEmKtMSHDUzqkPjR1hl91Pnj7Z60g+iQnSIATMZBUCxktC+1szPy8JVUJs9v7xgkqp9Unj93xTf2G9sW/auCLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187660; c=relaxed/simple;
	bh=WmS4nmulBncIjqU6bLZCeTL252dVC/kvBWiUSMYs1oU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DUFAwG574UcrqcnsvvMXPE1auqXACc6zqIvkOWHutPygJRe0fNq7fPPc69ECAlK9gWbzfoYg+pPbNOWVSj7rb/gsUhAY5m7G5zHND3fWA4zjQGbPsukCMUb1Ye/kVsi4NyaRxJ7phNI8rcRzW57vN1YJsuZKyg1+BCWQUVcBIWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tfmri8yz; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tfmri8yz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+dBA742rJi2VMfDA7YhZufrLNopxvNdiq1og1E/ohvH0TdQzRYcl/xff54AYibiwb4pBCfRZaeakYMeLppWptMSo2QwyqL9RM5zfXKJ7N46ZccTWB+8l5ftsVWJxu+qvdUi9PdI2TKi4Jx8QvovB/qVJOodHKa1/U60K+eKqV7GiuV7t80Vi+28e1HvV8HP0TVtVYY7vYCdocAipK97AbgGaJtH4I0D0GUW4WGhmt+SEgXpn1aAhHeHOPzcE7Z4mOVm5enSfMKSBXNQ5zHwsspj+ZVk8QgT5/4ZLwpoyRyRhoYcB0qTERA7y/T3lS04hjoFh0Hw/EEsjQ2NY5ii7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sksmAcYZA6cYRPmY99G3DtkPmrSmawMh+REJDoy/P0k=;
 b=Q933sd9H8jNlbsRiN21QUjnwSndty0WbNgsrLbz6mRC+Od+88Jp285qdvW69ZSQ+hu7u7u7qykDG8/hL9sGnOnzFmgutiIP9afchfs1pKfhfVCH5dtvRK8zldQJnPGRVx48EndM7s/KKnK2VD2cSYQVFUqViHNy5jz4HjFoxM/SXFKzZGjeTbZhifINzKFwMxl8y8qP2qwnfTSl3MnypYTYFLPpK+3XiE/YXHKOcYexyrd9ftVn/1GOEbHJR/BdCfN8rGeLnUSuA6Vd0jzW3B9sHfwYXcEP/1qnwzYRmQv3DUfDT7Css0y7WF1vnLrKYRyCzUzDEzkQCEszAqDZ02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sksmAcYZA6cYRPmY99G3DtkPmrSmawMh+REJDoy/P0k=;
 b=tfmri8yzQhZMVknse6TvHPJ/pp9lQAJoe6bo/9Yk9GQazh7BQTWbKmz9GX5AtaI9SMara9FaqlXENlXdtfbOiJjednFnUIPUrtgbJVwS+wZ/xPK+wJbs4epH/OdUUn8bVE7HIdHnVOR0yTh9tZCY1/jf6R52yN93Krj+SgUJxWU=
Received: from PH7P220CA0064.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::8)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 21:54:14 +0000
Received: from PH7PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::3c) by PH7P220CA0064.outlook.office365.com
 (2603:10b6:510:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 21:54:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000A.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 21:54:13 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 16:54:06 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v3 0/4] Introduce Enhanced SMT Protection for SEV-SNP
Date: Fri, 16 Oct 2026 21:54:03 +0000
Message-ID: <cover.1792184487.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000A:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 937a9890-5033-4180-564f-08df2bd00450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|6133799003|18002099003|260925021911599003|10067099003|260925021311599003|3023799007|260925022911599003|13003099007|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Xy2tKdP5D4WwOXpKcjFv3fAZrYEdKPkjJKeg98l1CUvyJZ6EYaOV7+UMsUOWBqTMZsAO9BnKr3Xw1edp8fx6+LeVkhC7c4YNAA+TgxEYy8N0uSPN4BY0Cpe5J2F0KfdCN2iXv3ZnlcVoMMOXDDB4MuSl4SHjZK+r/wujYKvPMvle2AAmO1ji4yR22+tJN71oB1LOW7N1RDfU97bFn6pOemi/P9+iDs1Gr7aGx+I0TpxG6Qldhd5dkCVigC9/uz+M6fujFJfUn4tOACFnsbxMjV15r2e60GiaYhBlrqR8laOPLTrlSY0Uk+wVXSfSY3AGTGeXXngw39L99pkJ3G22eQb8zYS7J7IeQ3m6bbGtnZ6a6c+4mR8vhaK8BTgY8vN4V1MnAaOTlK5cZ19anO9RtLDRraKjdCRK0NOY4JiqskQ8RCNbqFnIv7CN41ZbmBWkwdoHCg6AQNO3V8wzIaTGxMO+/b468XyCi7T0aWYQWFEiDuiHJP/Bo4+591mytfGVsasXLZq6AUhzKxLt+c9Tran9NTi7trw8VmBzee1KZuLqRY26vMPUtEHP/+KFF9EDrJIa2iQOkqkEeGJmpzl7aH8F1SHRW2NZG1m0DwHP9CiussEWnPgduigBknvojCGndkTj2rII6t6/1Z8lfYcfqXK/pe1gAnkZUJXJZfYhUvs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(6133799003)(18002099003)(260925021911599003)(10067099003)(260925021311599003)(3023799007)(260925022911599003)(13003099007)(11063799006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fR7UFGrmL8SEGEddrh1LuPCUPr9MDBz1eQiE2QMlH2gK0wpAaj3uoyEbgCeAuKg2veNO2oNAW2oxhIOO8aRys0S+tMZGUtWhFdmiyfJcbUPjKohGRvjhkqLz9zzTYWGroIsyvCUvsnTny0Xy1BOAn2E0+6Q9Baa08cowDtS239Egd9LOrRlQOPcn7gCjmnV94OdJywyODVWyv4UPKFDmJ4TqJ4/vIOs+3oK1kL2Gh0+AztKg97vcckfSaHmVSbV8AKc56rfM67yGtEZzAOY44+j5JXsDSyo1/UEcOHdfkGNUda2nY+Rr2MYKVB4nE9IBGqXQDetyHRRrPzfse/v4AXrlQcSMFbAyq18FGUHm+wC1jKkm61+BkPF+7UTTC7yLETIaPoHy6vrdDA8dXMoOx5T2g8l+Gx3x0o9vNu8zk/fye5YmfnIpsQnF8tsNC9Q5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 21:54:13.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937a9890-5033-4180-564f-08df2bd00450
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

Enhanced SMT Protection (ESMTP) allows an SEV-SNP VM to require that,
while one of its vCPUs is in guest mode, every SMT sibling thread on
that physical core is either idle in host mode or running a vCPU the
guest itself has declared a legal sibling.  This mitigates the
side-channel risk of sharing core resources with untrusted host threads
or with another guest.

Unlike core scheduling, where co-residency is a host kernel policy
expressed with cookies, ESMTP is enforced by hardware. The sibling mask
lives in the VMSA.  The host is not trusted to run arbitrary kernel,
userspace, or interrupt-handling work on a sibling thread while an ESMTP
vCPU is active on that core.

Both KVM and the guest fully set the VCPU_SIBLING_MASK, which places
every vCPU of the guest in one group so that any two of them may be
co-resident.  Combined with the ASID check, the sibling of a vCPU in
guest mode is then always either another vCPU of that same guest or a
thread idle in host mode.

Usage
-----
Requires patched OVMF [1] and QEMU [2] builds (unchanged from v2).
Launch an SEV-SNP guest with ESMTP enabled on the sev-snp-guest object:

  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,esmtp=on

ESMTP is opt-in because it carries a performance cost as VMRUN stalls
until the sibling runs work from a trusted vCPU or is in host idle.

The guest reports the feature in dmesg among the SNP feature names:

  # dmesg | grep -i SEV
  ... SEV-SNP ... ESMTProt ...

Empirical test
--------------
* Identify siblings via:
  cat /sys/devices/system/cpu/cpuX/topology/thread_siblings_list
* Pin the guest on the siblings
* Spawn a load in the guest e.g. via stress-ng --cpu 2 for SMT=2.
  Expect the guest utilization % for both sibling CPUs to be at 100% as
  the vCPU siblings are deemed trusted
* Spawn a load in the host latched onto one of the siblings.
  E.g. taskset -C X stress-ng --cpu 1
* Expect CPU X's utilization to be shared between host and guest %.
  Also expect drop in CPU utilization on the thread Sibling CPU as when
  the host task runs the guest will be forced idle.

Patches based on cryptodev-2.6

v3:
* Collected Reviewed-by tags - Tom
* Reword esmtp_timeout_ns description - Tom
* Use sev_status to determine SNP support for guest as well - Tom
* Convert esmtp_timeout_ns to u32 instead of u64 to avoid a #DE error
  if the division extends over 64 bits. - Sashiko

Response to Sashiko AI
* Possibility of a stale EVENTINJ to clobber a valid EXITINTINFO here in
  svm_complete_interrupts():
	- Today we make check only on a non-zero EVENTINJ rather than a
	  VALID one since that check on exitintinfo is made on it
	  anyways later within the function.
	- AFAIU, it is not possible to have leftover events from L1
	  injected into L2 wihout the valid bit set.
	- Only an L1 that does so deliberately can possibly trigger this
	  and even then the impact is limited to that L1's L2.
	- I could add an additional control->event_inj &
	  SVM_EXITINTINFO_VALID check if is really a case that can be
	  reached in reality but keeping it off for now.
* Not syncing msr-index changes since several bits apart from ESMTP are
  also changed and perf tooling maintainers generally sync that. However,
  if needed I drop in a patch that syncs the MSRs too.

v2: https://lore.kernel.org/kvm/cover.1791302373.git.prsampat@amd.com/
* Move idle wakeup ICR programming to svm_enable_virtualization_cpu()
  instead of sev_hardware_setup() - Sashiko
* Remove cond_sched() in ESMTP exit paths - Sashiko
* Add a VMSA builing of ESMTP fields for hyperv - Sashiko
* Add ESMTP to SNP_FEATURES_IMPL and SNP_FEATURES_IMPL_REQ - Local
  Claude Sashiko instance
* Cover hotplug CPUs / SMT changes by programming the ICR for all CPUs
  - local Claude Sashiko instance
* Add esmtp timeout documentation to kernel paramters
* Collected Acked-by tag - Boris

Not syncing msr-index changes since several bits apart from ESMTP are
also changed and perf tooling maintainers generally sync that. However,
if needed I drop in a patch that syncs the MSRs too.

v1: https://lore.kernel.org/kvm/cover.1789399214.git.prsampat@amd.com

[1]: https://github.com/tianocore/edk2/pull/13128
[2]: https://lore.kernel.org/qemu-devel/cover.1789399242.git.prsampat@amd.com/

Pratik R. Sampat (4):
  KVM: SVM: Re-queue events that were never injected
  KVM: SVM: Add host support for Enhanced SMT Protection
  x86/sev: Add guest support for Enhanced SMT Protection
  x86/hyperv: Add guest support for Enhanced SMT Protection

 .../admin-guide/kernel-parameters.txt         | 19 ++++++++
 arch/x86/boot/compressed/sev.c                |  6 ++-
 arch/x86/coco/sev/core.c                      | 13 +++++
 arch/x86/hyperv/ivm.c                         | 11 +++++
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/msr-index.h              |  5 +-
 arch/x86/include/asm/svm.h                    | 12 ++++-
 arch/x86/include/uapi/asm/svm.h               |  9 +++-
 arch/x86/kernel/cpu/scattered.c               |  1 +
 arch/x86/kvm/svm/sev.c                        | 48 ++++++++++++++++++-
 arch/x86/kvm/svm/svm.c                        | 41 ++++++++++++++--
 arch/x86/kvm/svm/svm.h                        |  2 +
 12 files changed, 157 insertions(+), 11 deletions(-)

-- 
2.43.0

