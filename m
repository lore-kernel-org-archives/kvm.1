Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794256533;
	b=Ys1MUbyTQ9Z/gOy14RV+IrsiCi2VJIgnpK4ACS7XuXLAYu8a4RlGPHhlXOqOZLgQ+r1T
	 V5cLSY/9P/yYX4RQMse+nY9/listsvmwt6LfysG1jlmViDowvcgNNMUh8WHb1PDZvv70+
	 22tJ6qtYIsNQOIOuMZNQPrnnBDM4nryDOCLovLHTS8d3lAcolzzO/BuQoH2J7/vOKHYOW
	 qcY+SexkaZCUZ9Vze88UZZoqDzzUwoX7Pe6RUuB5E0F2uPgtYzHRQ4HESk97Tr8Oogsd+
	 3ehEMv8rtir1pjrpTSeWir6snIwHeQ8eZD3cBq/j4UUaUuzmlA7osqOsu2+ohN/55/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256533;
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
	bh=9W6BgERHgJbNqgpoZMV7pANunaQYRK3xIEuIsJRg9RY=;
	b=aKSFPSKY3HuM8XOs/jYSsI898TEdRPDJFVmtW6hX4SQXaxcWPjrQcJrHqtOkdcUFjG+W
	 jz//oogoc6CGHICUgJhz3+ftI4ydJO5DNQcglWq0zgfjzwTrpQTgbDcS1wVeIU88Qgdjt
	 aHABkM5EseEabUjmZphJNbpS/mVUhpnh3t049roTYb5U08MHQ0aEC7zkA4L0uznx3/Nmf
	 kP0QSFI6NK4Ejueq2JWU3b+N8q1sR4UZuNqPOd64lcfkCE29k7UZWLTYodsOZTRGaOUnI
	 OAlmc4vPwnZPLHVN83lIBPDebiKLma/pSiLdYRNfYYHoAvVMdVv9oGRYDBrile57kmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YGTCSA5d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.38
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344C606A330;
	Mon,  9 Nov 2026 20:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B344C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YGTCSA5d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwmCgaC2pOps1/SoUqXcrdPUjXfMGk86JCW+CLIcqhXSwH5cmiMDM6YSA1PPEbU1f62ACZQRZcbFO4ZRyROhu/mig6zkgITlti0B5kmvs3ppM5gEesFbqqH7sK25d1Wr1vLI8hJ356A86YgwtuLZqJ10NqqTSDpqCpelXqph1clybv3fFTwSuJbLHUBhGc4sxTPuE1JkADWT5MhafaynBHszU9CbkBrIp4cRqJt9EdiHcasgVvGnRI0QYIlze3azBvp7RBx+wBHY7G6HJbWUZTU6ab2qXWVk5eSSKRA73da7u4iXGzKEUsB5E/X8QWpzoiG/7EZlBEVVhwseS8bMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W6BgERHgJbNqgpoZMV7pANunaQYRK3xIEuIsJRg9RY=;
 b=ROSAz2eG0y7uqKdT1V/oCUfjA+Jb2zqOUVVCosuhNrwoHgZo+fq3AG/Q1tD3uqPnV5+fwUJuFlj0ivzSMS1YxdlGEzj3EgD7Q7Y19W9mmwMUs55CMKqyKhdNT3m1LbICXx4ajkvfbh+4OBfEL49QAHPa8Fc6GJsQy3ChWvDsvPemvZUcFUmdV912UWu54NywRx/rJG/fzrI1Y2OyH6tc6CgbjtbFKjTqb0RrAC16CcXI3w1grymCGUoMukvKVaEOmjg5QwKdYlmlKNRSVcfshmvXv3vd++xcZmahTjP/DLK1lwk9sHu6+iHrN4Rc8wHvcPiqWJkpaaTLnEwfwb2w4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W6BgERHgJbNqgpoZMV7pANunaQYRK3xIEuIsJRg9RY=;
 b=YGTCSA5dE5yQydemolFWJLOLLNE5aMQKuX7krrv+5GKdJ0shCjX0jpCX37tevp2Y8Mg4nrZZ8hHL9UhCiOP6zfwq8J6k3745d7KpdN3DVcXRBqIX2W56jqvMBu6U5Fpre2xO+GM1/sQIVNzuZ0uVyZMor0pjReUs6TrkVY2yEwE=
Received: from CY5PR15CA0173.namprd15.prod.outlook.com (2603:10b6:930:81::18)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 20:35:27 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::1d) by CY5PR15CA0173.outlook.office365.com
 (2603:10b6:930:81::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 20:35:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 20:35:25 +0000
Received: from speedway8455host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 14:35:25 -0600
From: "Pratik R. Sampat" <prsampat@amd.com>
To: <kvm@vger.kernel.org>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<thomas.lendacky@amd.com>, <kim.phillips@amd.com>, <nikunj@amd.com>,
	<michael.roth@amd.com>, <ashish.kalra@amd.com>, <prsampat@amd.com>
Subject: [Patch v4 0/4] Introduce Enhanced SMT Protection for SEV-SNP
Date: Mon, 9 Nov 2026 20:35:10 +0000
Message-ID: <cover.1794244450.git.prsampat@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 585d7158-c7e1-4ee8-3047-08df3ea0fc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|260925021911599003|260925022911599003|260925021311599003|11063799006|261021121427099003|261021123027099003|56012099006|261009223027099003|261022105027099003|261022075727099003|261026140227099003|261022113327099003|261028144727099003|261026121527099003|261102123227099003|18002099003|6133799003|10067099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	FwGIPXsBHtyGaijlxHnUp9n8vuw/PDO806bJqi9mErjy7ODYOfw87wPUeII8aQmBTMzIZP84sjEmLaSAVl3ClG9vFBj1h8r2D0DCyUZWEi0TlnC7kCRPRSsv5GspzshoMc6FDfMkze7RWviRDhlErPyfjizy6y2NbkpQXeHGWuoIpN85H28nocnG91SMjkbHC65MSpm5AURIxwDK7qxQxPyctm6g27bIOuQ1JuqUrPTt5edMQrhizu3JuyEjTnubbhZnZ1Vojcl6zv+9NkMz1V36WTjP3U1wI3TKUsKFc4duMuIG8zxep2mJ3FCbsh1/Pv8x6f+7e7VL/8M/k3J7AlX9s2NWHuzZGRFVX7jOqiqbqP0jfoTrTTHkC7/3dLFQs0+iZt5Lgo1evDJgFbk/rrB8oaiH7TW5Z5sKeDQ9uLrd4gdT++B7tn0hSntzKgtWsetn71/QwZeQ6s3HDBQ4VOTlfLvjR0M9piowatehyTRHFnXGwhxd4K/aiP8PoEdfSVJPEK7RbnM2cE4y1ZrsdT7ilAee5CrIEqBwJBvCqfj5mMFQsWFVwRlJyqJlRHniOdUt4kkRkm9kViKdMdiYQdS9u8Sc/Zo6UtrRbC9svN033sDpSaSQqJrgvc3tTpjX+VTDBzvPkiVgCQClZb7IWbbtAYMt5ICP/nuNFR/R9LU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261022113327099003)(261028144727099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003)(10067099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NaHgN3VPNvfUadOs9JLtvEiqk/A9hTnhM7MmvJpDiuHeHzlEXvtwDjLq92S7fvcQYkioC5Q/EPINl37cukVu8HaVhnDvXL9Xl5tJ2JpL6Iv1ClD82hX5yFuOuG9Ujrr+KtNHGurPJPdC3ssGvH2124q+2SCN619irOeDvI2TLraUOYlz+hNGivYCdhPKukz1ugBRgmIEpj7udNDL+AVJeO9VA1xqtyUP6OR/BfoTBHuym4AZ4fCt65wL7B9U0rZx1oP0W/pbnomdXxyasmH3v5JCc6D0mZMq4ksNkx3avI3KGWQntOqWy9YXiCbMRx1uhb659L08dfEpiIGsEKi8dF5ZQCNRAwNL0P5iS22Tqyj2ADVTvoO31HIqAgOvaFUCaGTaFXJF0/TSyEGg724zWrp80DG7WPA0iU0huVUH1U57SUgTnRzCicx7x3A290LW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 20:35:25.8751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585d7158-c7e1-4ee8-3047-08df3ea0fc5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

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

Patches based on kvm/next

v4:
* Fix conflict of reserved bits introduced by PML support in
  vmcb_control_area

Response to Sashiko AI:
The EVENTINJ field is cleared unconditionally. so after a VMRUN, even if
the VALID bit wasn't set, the field would be cleared. so I don't think
we can hit the scenario that Sashiko is referring to.

v3: https://lore.kernel.org/kvm/cover.1792184487.git.prsampat@amd.com
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

