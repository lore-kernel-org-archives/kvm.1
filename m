Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502D39E6F1
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380702; cv=fail; b=KLIwNaA4s6x0ksMns1ifS6FNnAlkx1tt1Vr8tpayEc3oA+fKNkgY7voO0Rfi7jxCQcXWZdCrcemN4Z5LETfQrAwMoF90DAIG+n/3ek5ZDprkcx+w+giT1jR/i3RsZx929BsAQtHjW3+dJghVRR069fnQdkT3yaoaCiBexOC1HNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380702; c=relaxed/simple;
	bh=FwD6jA/xVtfd9wPEXQ4uwCl+RnVu5AUXdvMldKTrszk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tumyz2d+wX91e2SORwUQ7LCZO7/dmkjZ4ij/lEP7Z2gVTUFk71b0licv4D+co1gSJlaawotHeO1Qqj/A9+9YYIzKPhU+CXjIvFUUme83aHHTo25PZjIvarSCcO0SPBskzUFfhzO17jpZtkf6vwRLBYL3YMS5i+vjANE5W4v9e/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uuQ3vIXc; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uuQ3vIXc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXASfItzOShayBaUOO2Ywg2wFAuj7gdqprw7GVJ22KUoEZG2IfJ1RhydhPrC0w0ApwRUhHXgBJzJd3hFABDChNQHCkC6/ZXMXk355KHotjzHGKH5mN/BdqEd30oG7af6dgk3qFLFWoZ0VZjkKKuwMLR5hr1Fg9fVAGWn0uUFFsa9LNGqJTFfdOVNACVzRyL7XxuBXS8dfJD1ng1j5IsXOxhBuNhMddh8/xk/5QjrPJ71EMg/b6K5GvHC5jgR0vwsBtnO+koT1tncqxfdU4iLbyAmjfbnQgMPRkHYCXbb//XmEI14QSVjuvxO8Mg0yq/GaJKs9l/UOW3TEHdlYN7dDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iz6dUTz5GBr5TrNOUsqL8zNEx02w6wIvBAZ3fmIMQkA=;
 b=QjRE3OAt73cfDBIJe6K8k9CKvp72mPMoq4zoRivViMembr+lFUJ6lQKdhT+8M5O0nMQiWDTZENQGquwpWUlAnZmufs/Id3XKGIpxv5/UkqIu2Oyx/0fTEKlgRDnX4pGH2LV3Av8VnQ9xJ7xV3727IZR4BM5688Zx3kQn50mnisXaVNnV/pTor8O9UkWdyTaVKVbjMzETdVLI/3t7x/pIQ3UpcTUBFvNiFsIyvLIoewl1tFZJpx2hYMTZhW1EapRrPt1i9jg2Mrewcho67GUuLeVyTe0wCoF/Pg09sIHat1iCl4l57T5XDvkUGllIQu5aH6Mrax9TzERnpZc2gdAr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iz6dUTz5GBr5TrNOUsqL8zNEx02w6wIvBAZ3fmIMQkA=;
 b=uuQ3vIXcKzTXstkmN/WI1lKtfa92//jDRjbHSSaZLHaYjzeySgzakLse90sOk3T28mieH77xdjroTQu5zYe3+RkQPQAy4Y68RZ03Ot6zSi71AGfoKVyESHU6vdUskj/IFus7ZIDi1+3648fAMJ6MFrdmu5B9PUbcQHGjt5KcMTA=
Received: from BN0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:408:e5::27)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Wed, 7 Oct
 2026 13:44:32 +0000
Received: from IA0PEPF0000003C.namprd03.prod.outlook.com
 (2603:10b6:408:e5:cafe::1f) by BN0PR02CA0052.outlook.office365.com
 (2603:10b6:408:e5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:44:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003C.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:44:32 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:44:26 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 00/19] guest_memfd: support in-place memory conversion
Date: Wed, 7 Oct 2026 08:41:24 -0500
Message-ID: <20261007134323.1606088-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003C:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: e0153c67-be93-496b-c277-08df24791dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700016|23010399003|13003099007|11063799006|10067099003|260925021311599003|260925021911599003|260925022911599003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	HUko2OL0fSn2rQOdcf+oKJR17+6t6LjVIsFriJuXTkxuQ9Sti8WPPAtVbj18aTs41UEayYv2bemfJNDoo40z4bLTcQ83yqY+D2Ax2dH4z0JYwlsYWAjG86Tc2VmYVD0CIF/UEg3RAaK4X3bMaG5hdGhis88FLyFeCZRALusfC3jwLVpRKO/N2DlZPXxLcXNVoIqLGiVPP3oMZ6M3LyMN/8bSd3v+x4GR/xGZACAtODsOQUJUESeXfuP0gw34+mcG8tOQkJuJZgYc/iu+DVR3vdH3F5njvovVCG1zYZXgn+/P8KUJeh4nMgPwdeNwobo8l3wfsxHJH7/w7B7f/r4G5BmCVMlkdBw13hXpLNLJqy1d0azwUZSdH1a9M1idTrsUwm4pgLD+TmrhB2be94Sp4+7W0vHhIWqe6sJYHb+3NTPnlVahZfwgQS5+3TMmDttjQoRiJlWU+Ny3Imt9X+dmY9RGGT0oT3kOulg/kQu60q9VhMFM++XHNcyZGXKKs+bpnwTnS1OGPUW40KC0phE6rLGCjSsCR9ou1NkoH6nnh7Ji5yWWyT7i6feYnQPSXsCbJqRNkxyCGvmuDi4ZuibnuGsQKxVpOpCz8qX/zqunMtAQ9SmII4rbLqVzZp8vjSOIJDYUrrWwbsWFl75sSH/rI/YQRwRq3+xtarls+Ej5bw4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700016)(23010399003)(13003099007)(11063799006)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uf0UB86g1apzcDFuBxDLgghRhxj0z9XFs68wGs8JbsWyWUOd9D4txRts3s2ZrFDHqBhxzdmnuATfC+UXcGfPAniwou75PVwzWSJGTm++/XF3qWzk0ZefrNzmCyowGcpA2c16x8WLN6j5Jt73yaapK1PE7L4U+4nttnhOfEPIrkgcnaqSaeqKqMUaovsAryprUNBAFg/DoiUC3hAoj0JgLSRmhRRoK6zShGqzCC9Ng+0GQJzLvsl0LPVefCKYhKeq7jJZzoq1Y873fwSW87fYsB83sBF5kt9QYR19PkWTK9iBTupOx6U+gcrkOKBtUJmaXBjJrIcYcZo07HA5B0oMKLLOEAir5pfBM01fz6wL2faw190TA5vpj3lN6dSl8ScMAoRk93liFevHMu64UDlDyyU68qL9cjFZHCjrsMB5zmbVvtR7pBJA/SZaztKDT3Lm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:44:32.1284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0153c67-be93-496b-c277-08df24791dee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

v1: https://lore.kernel.org/qemu-devel/20260528000416.8161-1-michael.roth@amd.com/
v2: https://lore.kernel.org/qemu-devel/20260908205236.838281-1-michael.roth@amd.com/
v3:
  - rebase on top of master, which now includes prerequisite guest-memfd support
    for non-confidential VMs
  - make CGS option implementation-specific (Markus)
  - beef up conf/guest-memfd rst docs and reference in qapi changes (Markus)
  - rename _SHARED flag to _SHAREABLE (David)
  - refactor/reorder patches so that SNP QAPI definitions to enable in-place
    conversion are deferred until all the required code is in place rather
    than relying on the new removed 'allow_convert_in_place' CGS flag
    
This patchset is also available at:

  https://github.com/amdese/qemu/commits/snp-inplace-v3

The first 5 patches are bug-fixes for code that was added for TDX to deal with
private MMIO ranges. Since much of that needed to be refactored as part of this
series, they are included here for context/review. Testing of those patches
would also be appreciated since I don't have access to TDX hardware and am
unable to check for regressions.


OVERVIEW
--------

This series adds guest_memfd support for in-place conversion of memory
between private/shared, and enables it for SEV-SNP guests. It is based
on recently-added kernel support for mmap()-able guest_memfd
instances[1], which allow it to be used for shared memory, and the
following patchset[2], which adds additional guest_memfd interfaces to
allow it to be used to perform in-place conversion:

  [PATCH v13 00/44] guest_memfd: In-place conversion support
  https://lore.kernel.org/kvm/20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com/

That series also introduces a new 'gmem_in_place_conversion' KVM
module option that controls setting this mode vs. non-in-place
behavior. Currently in-place mode is planned to eventually deprecate
non-in-place mode.


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
will be qemu_dup()'d as the FD handle for private memory as well. This
allows the prior non-in-place handling around block->guest_memfd_private
to be kept mostly unchanged for the in-place case.

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


NOTES/TODO
----------

  - TDX testing would be great, in theory it can be enabled with this
    series (similarly to patch #18) but I'm not sure if there are
    other special requirements before we can switch it on.
  - kernel patches are still in-flight, but are now in kvm-x86/next and
    nearing upstream


REFERENCES
----------

[1] https://lore.kernel.org/kvm/20250729225455.670324-1-seanjc@google.com/
[2] https://lore.kernel.org/kvm/20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com/
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
      [NOT-FOR-MERGE] linux-headers: Update headers for v13 of in-place conversion kernel support
      accel/kvm: Add CGS flag to control in-place conversion support
      system/memory: Re-use memory-backend-guest-memfd inode for private memory
      accel/kvm: Handle guest_memfd flags internally when creating instances
      system/memory: Default to guest_memfd for RAM for in-place conversion
      accel/kvm: Move post-conversion updates to a separate helper
      accel/kvm: Re-order attribute notifications for in-place conversion
      accel/kvm: Support shared/private conversions via guest_memfd ioctls
      accel/kvm: Don't default to private attributes for in-place conversion
      i386/sev: Update SNP_LAUNCH_UPDATE for in-place conversion
      i386/sev: Update CPUID failure handling for in-place conversion
      accel/kvm: Disable discard for in-place conversion
      i386/sev: Add sev-snp-guest parameter to enable in-place conversion
      hostmem: Automatically select set guest-memfd=on for in-place conversion

 accel/kvm/kvm-all.c                         | 449 ++++++++++++++++++++++++----
 accel/stubs/kvm-stub.c                      |   8 +-
 backends/hostmem-memfd.c                    |  19 +-
 docs/system/guest-memfd.rst                 |  21 ++
 hw/core/machine.c                           |   5 +
 include/hw/core/boards.h                    |   1 +
 include/system/confidential-guest-support.h |  12 +
 include/system/kvm.h                        |   3 +-
 include/system/memory.h                     |   7 +
 linux-headers/linux/kvm.h                   |  16 +
 qapi/qom.json                               |  13 +-
 system/memory.c                             |  23 +-
 system/physmem.c                            |  54 +++-
 target/i386/sev.c                           |  36 ++-
 14 files changed, 585 insertions(+), 82 deletions(-)
