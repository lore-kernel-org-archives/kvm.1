Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE8379EE6;
	Tue,  6 Oct 2026 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305713; cv=fail; b=bHjla+Ev2tGTh/TRKKgE9Pz8yKFo2ieG9SHez5utS/tymEKBfRHMT0ooXm3eWheCqoiuLQjEU2bemWqcETToqtej0jeBg+qBhyAF+RRALJMz30PT1EluxEvcFnTNjOR5RS/UJKgga1Xj5roW+CQ/30azyja39lbr06z+yxzVknI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305713; c=relaxed/simple;
	bh=f6XLXCSWTZ4uMxfGnWy9abM0+Ja2KtpuzEbYJj0W72g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Opn7zx50QFf8MBhbulgKybVIP490ITI8wmHHfNgHpJQlKbDN/pa+IugKhO4zfpF8qR6fURQ5JcovkU2LOEmJUU69hf3cP0r+WGxWW6Ygs+qZ9vJqGVoXRlFpu09lxYUkdS/n1l6qWfnFV0fPfaCxaUg7gqmdCt68VTip0FowD14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f8cPLmYi; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f8cPLmYi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/doUoIg5vFCNGbl7MNBg6s43bZuwtQ2Ug2UlO+k3kebiCPtudCzTtXBEz0f+c2OtVVJ7Q/75KC2TyqBB0LfNoCOzU0Z+Iuvx0SUZMAapvgu5O6Fa/DMTNuLSiF9BJKbqUF1hXvt8o88mkgQuowc79AMEn5lqthdfRH1oKD0d42FSyElJXUKjFCJ9ID/cFonGiz1gFIRBFTE/7tSdst9nnI4+frxxHZigj03Ujcc9QuTihUXiny2xNiDoGU9BwnHAjq7iwWHDkYJ8DXSwokyS/fGDmZPeovGV/D84cMeUG6vm0XTOnqu3dkIU1bRVGrNKHJ91+gqa4Oty8tkp5QxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Wnip8syX8wHCPxsgNMJ/XEqwytDcYlFGykBmnTACo=;
 b=MICI5hsf1IdYwcwFjbbAWE9yr2DKdiWt5cU1vUFU7cSsGENDhCX2yVw7bzNbtFin/QIWFd/CY+uzl3ULgHBeeyCqydipL/5iohaCK6gXVafJViwQborJ0vYAgb0QiAqs4c4RMUpL4ElnjzVqrBHW7rJE73YnInExbc/X5oUGdW5rEdNjy8Ox0TYEmN+dcT1wLrfQbqIwLtXujMdmZ175x+R4TvdFvQ6LjTiqYCSoU73OouOAShWsawrgwZfeVRUXPwpm4jLmca7lUgZ0R6cocUTNdD7dxt3gPLYbt9PVswMxFcK3SvoaZICD6O5Qxh3fBZDir+OYq2Cmn0GGe5+4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Wnip8syX8wHCPxsgNMJ/XEqwytDcYlFGykBmnTACo=;
 b=f8cPLmYiKPSR1wAKVbV/ZNNWecVKXPXr+iLMLQ89ZV6RQ7Ze6GnU2m+Vd5Su+LXg0/dMJ3pmp7cRBgkDOoB0p14WHtxbHxiHDRrDWZKq/gXH8XpZc3y7ORhKjYNK877Y1Hr55O6lRfPJL8pZ4dEnC+Q4pRqNW7+KXdOJqIGsQWo=
Received: from SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 6 Oct
 2026 16:55:07 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::7c) by SJ0PR03CA0111.outlook.office365.com
 (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue, 6
 Oct 2026 16:55:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 16:55:07 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 11:55:05 -0500
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v2 0/4]  Introduce Enhanced SMT Protection for SEV-SNP
Date: Tue, 6 Oct 2026 16:54:57 +0000
Message-ID: <cover.1791302373.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7b342c-c41d-4235-99b8-08df23ca937f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|260925021911599003|10067099003|260925021311599003|260925022911599003|3023799007|56012099006|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	M1t1juK4c38iPjgjZB7upt1sySc48aX0YExi3CiJSCCKy5XahJR8rB+bjUUEdjZ5IZh3nDik9Y0EFbmCj4Hm0PJBj+4uzby2gY7fNedh4ufTQkJusC2/+dC+U62JFsbCTgfZaJ3atNEJXHkgpJlZwwUe0g7ArWookU7R0FtwQF/fjRITAmvAVaoCzWxQa1yN3F4qAIT2pRi6zcxwHA0PN4ZCwniOwOtcHWphylcPgCvSZQb1ZaqT9rHQ+WOp+jX5h4x6NSJbQ0+V5gLV9C65DIj+50p0Kx68fzfJv2i2lW41Zt+ibJ5VcWzBsWF9sIo4MjKxdWU/RJrqL2vzPWU0yW/r6vz5XsP4B/fs2YxcpTRc9meorlt2kPukrGnEIKj1k8cXRdwbRmKiUY88edN5q63QHWuWwpXN8091hCASx7gNMl075aoY0xzoS7eJGcmzEZ6hJw1B0aGbz1rKfSsFGk/C2DZdg+bYtPcDdEwtw4FNd8JkQYoetP63Yf034awb88hxbtgkiUdmm529GYNg7S8PMVDUYvlJsUczauENSvszHEPDAVVN3822CQ2QlhGM5gquZjuNhxD4baIjLHrkwb00DqgvAWnoLE1FGbe8v6Ci4UIJRSi/rdPGxb3SxF/Gou844IKLoNFzbFMs4kKDOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(260925021911599003)(10067099003)(260925021311599003)(260925022911599003)(3023799007)(56012099006)(18002099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yb12g2IsaOPAjHmflXcIjCDjIjjxQaxl+/JO/EWF2NZhp1xZFQQNlquiagrqu7vi8wswhYN84/+x3KpB90u6nSe3ckeQXK+GoRPkzDvsLXc/fHUVaRR1SMASBT6lz6VzBAN3R0wl0TTJHilBbr475qJeKHEncnW9o/ubN5SYox786g/D/gOGK9UaNuMVWtO1/HEoMqI5Lvl82NLUQEDxfs8JgchakyeZ8q0C2cXN6HhVt2C3utO6lsrs0A52TfxCj5xW/ImmvupV5lc07alf+oCtLo3Lq+14RMfC1r560PySnqsOU6F3OhIk4KPPlUEY7oc1A877Fq0cuLnRY6VRRfkZm7ETBs9zho3fI5mhBR35K9dmxj+6aTguvWzW8eVl805ZQGhtcJsAIAKg6+epnikwN5b3hKnNq0NM1PSguw0polO+hcr1EQR9K1oTbj+3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 16:55:07.3877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7b342c-c41d-4235-99b8-08df23ca937f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755

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
Requires patched OVMF [1] and QEMU [2] builds (unchanged from v1).
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

v2:
* Move idle wakeup ICR programming to svm_enable_virtualization_cpu()
  instead of sev_hardware_setup() - Sashiko
* Remove cond_sched() in ESMTP exit paths - Sashiko
* Add a VMSA builing of ESMTP fields for hyperv - Sashiko
* Add ESMTP to SNP_FEATURES_IMPL and SNP_FEATURES_IMPL_REQ - Local
  Claude Sashiko instance
* Cover hotplug CPUs / SMT changes by programming the ICR for all CPUs
  - local Claude Sashiko instance
* Add esmtp timeout documentation to kernel paramters

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

