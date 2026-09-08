Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF152EC086
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900852; cv=fail; b=pU/rGnEZNIkT+7h+gaEWZ/linztSGP9wtQOtSa+EMW9M5Mdw6WrWqabwOeEWA1wy51ol7dtxf4yxzOT84ZHj41uT8dqfwBWxMquDcqef7r5KYHsDlyczkp7kpS47t3+VLR9lej1Vq/MCCTGLFS+iKoqOj0sJq8t9WhgNl3cYrnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900852; c=relaxed/simple;
	bh=UR29LQ/oHEBDg2WEEqVktiODNHsoQfHZFwjHizaNgqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZQ6GNn6Xq9Pt9vADim4L7kEDQo4KNltRMAH8ciVoJL3htIdqSP6FSslbKHGiAD+MVv7EZ3CvWqSObcucN1nL8f1nSXSLGwX/ZY6uDGulNePyfOCAZV9LgjH9UqJvM1Gpo7PrILGtD3dhi6CQVfi3l6bRKm8dXIXEa0lJ2prsedU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g8n0d8D+; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g8n0d8D+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nor/i06VO1FT1UGAG5sL/bLK9HxECMQmS8XD8BdTVfFKXAcLcq9fbKZ6oz08ykmzHzzaDKnGBCu4c3TY5AcJMNTpqxP3e5CR+c3DjJCW793powdS056bJQ/8l1n1VDPTIUScm9j0YTkipmi6HbpXVdc+B1AuP9ZW2xuhR3EOi0jkVCNRjBb/A7uY/DW01lUCUNN2oOe6onf7siyPFzmaG463Y5BgABP0zDVv9SGJO63YpEWKYsx43KVU/D/JB/tOgD8CMH6R13aNw6FP5uW3rqDAMRSXxu0jGXXeh/wu+SUmL6itY1YPs9cKTr/lBA20JABvQZvVWrHsxUbJA2lORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFm4URltVY0Qf9s8MUoTEUqy1J6Znj8s4txWPYba5BM=;
 b=ZqXTHrvsu4yd+ERM68/QeEwgAfx4UY81k6mgyYQTp++vKUeLv+MKt3FeNdScDW6r4iHSEVesQ3vZ1t/2buq5AD1duwRURyfyVnZ0e/+jHShpyAGCHGpqZD90TRMrWXmkLKKk+Pzt5bX06OlES+Dtwy2LDwyJA4d6fT4FwHF8SHFqjTGhZMIij+iU7k1kfTsY1GMzJ5K8Mi2opA/IXyNaJ8dNLQQzLLANiwylff/UJaESJWslXeU6j3FNAR975VE8VbKKFfXwfA3/TgHxGGG9Eets0ZaeXULxRIxDc0xG9AgezLLm4DHfSLW/IEssMigsAppY6huByyaqryYAqawNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFm4URltVY0Qf9s8MUoTEUqy1J6Znj8s4txWPYba5BM=;
 b=g8n0d8D+TSyj7qDCXhTNfdoS6/llGkWchuKrVvREwf8FL/xuclLmVVQBI//ygzEiyr5I/0fs7WW1a7mGwRCA+gUziLlaXvYy3qLhKLtBItwDxq/39pEpEisRz3RrPUpTDMU0LJv7itUg15yM5rM20/sKinQTDyMhHmAO7i80a2M=
Received: from CH0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:610:74::16)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 20:54:02 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::45) by CH0PR04CA0071.outlook.office365.com
 (2603:10b6:610:74::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 20:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:54:01 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:54:01 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 00/19] guest_memfd: support in-place memory conversion
Date: Tue, 8 Sep 2026 15:48:20 -0500
Message-ID: <20260908205236.838281-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e5dc52-6361-48a5-5fff-08df0deb4ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|23010399003|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	9bHPaztyub+BvZ+uZKdkbSTi0LW60dXHhjMJubf/uQ1md4nRzXYws/bciVpziOgsn3mPUM9IDulI0kMneaD07aZ/P/G6FvmKS6z5r/YNCVq1Zz6BjZo03l+QTfPKjUiXWBmjDTiYP0/sNXSUTTubUq6x+d2j70RRfYfaQe8t6CrfHa1OXx40X+Ftlr4cHu85UNxvMlmZBigjGalzQSq/j7TtdwF6B8Xo8WU9YzTvIhmfYT1foGBn5p8KUyGAXDnQFNo6W7ULmTz+k2dMTQcOXBI910w3MW3h4NgH9Ty+ihK97oYreZs/+jQrZhaJIdNqAqvKuwLyTv6Rtqe5hVUVitu+xfjMG+MnHZZhDxPWZ3NgaZkznm6R9O/t7bFGQlhFVT65zChxSOKHe3jtGxnGLidIwWZn2AbkXoNm5oW1rjr9JmP12pi86u3mGhUGstWTrWLW1VgXv+L+bKwTU2xtdsYJIou8qX5TynAiyxzwTINg2QIG5ZM3iLWeLULucaZMuOoHOZ6AsqrG3kUDbrzh2n6HWyT+v6ffW4IPdcGuJ5/jjMXVJ6dFCP17qFPyj+CdCP6sr8st5MKtKU8fHFTvkJMshPk8OlK36koMRhaBu9R7O72RIRsE5B+GRvUC38S974BKaV5EyrlLNCqtkRRZF2x2toi15/paT69sUqJle4X3KFQdZ/Pjev9N1xmaTJeZgcKnxRJHNqnXdXTyfPj/4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(23010399003)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jhG0Dr445Sh4YmILNPVmGphimtuQg2NqVhV0foEI7zssK6W/eIo0vPt26Ufd+ZUTZEVc2s/oymlCikcXizpnpzy2i0KvRjlOfj8bW5z0DEstKuJWYlGymc/WyVfp/JNWUgQPd+MVJvLo5T5UcSjCon1yQ2CvyknNxJtabXg2UC0U4Qdt6NdggVGNRGKSSnsoLzDllVqgs9zPCLM7ZYpajGkw/r3YT/2jpoCS4EXCHhw3FUy3aGxjwDJ0tGajnYZK14wCXXQZSKojyfYqYBdIWsv79Lnpx1JKaedMPI/z2vALJXOklzh7lEVQVEIqf+tmlU9FFfnDfqSUiobKnCnV7QanydGwmGgD4m3OIxOUqb6yQ/zK9w/zaGbGsHOjchhRPECmBOgn2YpORJ8J09McAaCQLEvsf7oKoDoV7dUH7sX3uFvJ/lqNYrUiTq6tG6e2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:54:01.9309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e5dc52-6361-48a5-5fff-08df0deb4ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

v1: https://lore.kernel.org/qemu-devel/20260528000416.8161-1-michael.roth@amd.com/
v2:
 - reuse memory-backend-memfd instead of introducing a new
   guest-memfd-specific backend (Peter)
 - pull bug-fix-related refactorings/dependencies back into the beginning of
   this series for more visibility/context (patches 1-4, can be applied
   independently), originally submitted as:
   https://lore.kernel.org/qemu-devel/20260527223036.4614-1-michael.roth@amd.com/
 - move gmem flag specification to KVM-internal code to allow for better
   control of likely-global policies (like INIT_SHARED, which some confidential
   VM types might prefer to leave unset) (Lorenzo)
 - zero-initialize the kvm_memory_attributes2 struct to avoid garbage values
   ending up in reserved fields (Pankaj)
 - add a helper to check for in-place conversion instead of accessing CGS
   directly
 - add reasoning for introducing ConfidentialGuestSupportProperties base class
   now instead of deferring (Markus)
 - minor fixups/refactorings


This patchset is also available at:

  https://github.com/amdese/qemu/commits/snp-inplace-v2

which is in turn based on the following series:

  [PATCH v5 00/12] KVM/hostmem: Support init-shared guest-memfd as VM backends
  https://lore.kernel.org/qemu-devel/20260908133151.836685-1-michael.roth@amd.com/


OVERVIEW
--------

This series adds guest_memfd support for in-place conversion of memory
between private/shared, and enables it for SEV-SNP guests. It is based
on recently-added kernel support for mmap()-able guest_memfd
instances[1], which allow it to be used for shared memory, and the
following patchset[2], which adds additional guest_memfd interfaces to
allow it to be used to perform in-place conversion:

  [PATCH v12 00/45] guest_memfd: In-place conversion support
  https://lore.kernel.org/kvm/20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com/

That series also introduces a new 'gmem_in_place_conversion' KVM
module option, which sets whether memory attributes are tracked
VM-wide by KVM (vm_memory_attributes=1: the existing 'legacy' mode),
or per-guest_memfd instance (vm_memory_attributes=0: the new mode
which allows for in-place conversion). The latter is intended to
eventually deprecate the legacy mode, at which point in-place
conversion would become the primarily-supported mode.


MOTIVATION
----------

Today, SEV-SNP guests (and other CoCo VM types using guest_memfd) keep
shared and private memory on separate physical backings: a userspace
memory-backend object for shared pages, and a kernel-allocated
guest_memfd file descriptor for private pages. KVM_SET_MEMORY_ATTRIBUTES
flips which backing the guest sees for a given GPA range, and the old
backing is typically discarded / hole-punched on conversion to avoid
doubled memory usage.

That model works, but has a number of downsides that impact certain
use-cases:

  - Each conversion involves discarding pages on one side and faulting
    them in on the other, which incurs allocation overheads in the
    host kernel for every conversion.

  - Some use-cases, like pKVM[3], rely on memory isolation rather than
    encryption and rely on in-place conversion to pass through things
    like secured framebuffer memory without needing to bounce data
    through separate shared/private HPAs, which would introduce
    unacceptable latency for that sort of workload.

  - Hugetlb support[4] for guest_memfd will rely on it, since things like
    1GB hugepages with a mix of shared/private sub-ranges would generally
    require 2 1GB hugetlb pages to remain available to handle shared vs.
    private accesses, which quickly causes doubling of guest memory usage.

Recent kernel work[2] makes guest_memfd mmap()-able and lets the *same*
physical pages be used for both shared and private states for a given
GPA range, allowing the above pitfalls to be naturally avoided.

This series wires that support up in QEMU.


DESIGN
------

For confidential VMs, a new 'convert-in-place' flag is added to switch
on in-place conversion support. When running in this mode, the user
*MUST* use memory-backend-guest-memfd for backing guest RAM. A new
RAM_GUEST_MEMFD_SHARED RAMBlock flag is added to track/enforce the
dependency. Additionally, QEMU is modified to use mmap()-able
guest_memfd and set this flag for other cases where it allocates RAM
internally. As a result, block->fd will generally always be a
guest_memfd, and when RAM_GUEST_MEMFD_SHARED is set then that block->fd
will be qemu_dup()'d as the FD handle for private memory as well (which
is currently what block->guest_memfd points to). This allows the prior
non-in-place handling around block->guest_memfd to be kept mostly
unchanged for the in-place case.

When running with convert-in-place=true, shared/private conversions
are no longer handled directly by KVM, but instead by a new guest_memfd
ioctl, KVM_SET_MEMORY_ATTRIBUTES2, which purposely provides similar
naming/implementation to the KVM_SET_MEMORY_ATTRIBUTES KVM ioctl that
it replaces. This series adds handling to route conversion requests to
the appropriate ioctls based on whether or not in-place conversion is
enabled.

This support also relies on the memory-backend-memfd,guest-memfd=on
option, since it is necessary to use guest_memfd for both the shared
and private memory. This is set automatically based on whether or
not in-place conversion is enabled.

Since guest_memfd ioctls need to be called against the specific
guest_memfd inode associated with each memory slot/region, some
refactoring is needed to handle conversions on a per-region basis. Much
of that is inherited from the bugfix series this patchset is based on
top of, which adds the initial logic for handling multiple sections
within a range.


USAGE
-----

After applying this series against a kernel with the RFC patches above
present, an SEV-SNP guest can be started with in-place conversion via:

    qemu-system-x86_64 \
        -machine q35,confidential-guest-support=sev0,memory-backend=ram0 \
        -object memory-backend-memfd,id=ram0,size=8G,share=on \
        -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,\
                convert-in-place=on \
        ...

The new memory-backend-guest-memfd can also be used by normal VMs:

    qemu-system-x86_64 \
        -machine q35,memory-backend=ram0 \
        -object memory-backend-memfd,id=ram0,size=8G,share=on \
        ...

This is mainly only useful atm for testing, but in the future there may
be more use-cases around using guest_memfd as a general-purpose backend
for non-confidential VMs, so it is intended to work in this manner as
well.


NOTES/TODO
----------

  - TDX testing would be great, in theory it can be enabled with this
    series (similarly to the top patch) but I'm not sure if there are
    other special requirements before we can switch it on.
  - kernel patches are still in-flight, but fairly mature at this point
    and nearing upstream


REFERENCES
----------

[1] https://lore.kernel.org/kvm/20250729225455.670324-1-seanjc@google.com/
[2] https://lore.kernel.org/kvm/20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com/
[3] https://www.youtube.com/watch?v=MMfAGNW9RVg
[4] https://lore.kernel.org/kvm/cover.1747264138.git.ackerleytng@google.com/


Thoughts, feedback, and testing are very much appreciated.

Thanks,

Mike


----------------------------------------------------------------
Ashish Kalra (1):
      accel/kvm: Fix kvm_convert_memory() calls crossing memory regions

Michael Roth (18):
      accel/kvm: Add helper for handling conversions of MMIO holes
      accel/kvm: Fix handling of MMIO holes at start of conversion ranges
      accel/kvm: Fix handling of conversion ranges with multiple MMIO holes
      accel/kvm: Use dedicated helper for creating private-only gmem instances
      linux-headers: Update headers for v12 of in-place conversion kernel support
      accel/kvm: Add CGS option to control in-place conversion support
      system/memory: Re-use memory-backend-guest-memfd inode for private memory
      accel/kvm: Handle guest_memfd flags internally when creating instances
      system/memory: Default to guest_memfd for RAM for in-place conversion
      accel/kvm: Move post-conversion updates to a separate helper
      accel/kvm: Re-order attribute notifications for in-place conversion
      accel/kvm: Support shared/private conversions via guest_memfd ioctls
      accel/kvm: Don't default to private attributes for in-place conversion
      i386/sev: Update SNP_LAUNCH_UPDATE for in-place conversion
      i386/sev: Allow in-place conversion for SEV-SNP guests
      i386/sev: Update CPUID failure handling for in-place conversion
      accel/kvm: Disable discard for in-place conversion
      hostmem: Automatically select set guest-memfd=on for in-place conversion

 accel/kvm/kvm-all.c                         | 449 ++++++++++++++++++++++++----
 accel/stubs/kvm-stub.c                      |   8 +-
 backends/confidential-guest-support.c       |  26 ++
 backends/hostmem-memfd.c                    |  41 ++-
 hw/core/machine.c                           |   5 +
 include/hw/core/boards.h                    |   1 +
 include/system/confidential-guest-support.h |  14 +
 include/system/kvm.h                        |   3 +-
 include/system/memory.h                     |   3 +
 linux-headers/linux/kvm.h                   |  16 +
 qapi/qom.json                               |  21 +-
 system/memory.c                             |  23 +-
 system/physmem.c                            |  52 +++-
 target/i386/sev.c                           |  22 +-
 14 files changed, 593 insertions(+), 91 deletions(-)

