Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A064
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 00:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926746; cv=fail; b=DL2AMe082/LRoqZbb/unPsX5aJ2UUdFHlmlTdMdvRXPj9zhniat77NengoFEdkXzC+YnhYm8AOdIK8Ukwc8fzyj7XDtsEQSrjTWNKb/1XxTH5f6iCWtefoHCXwEtTUs4aIZqm0YPrTgbyzFQyRFB/yShIKOt090XpnfrtP5RQ3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926746; c=relaxed/simple;
	bh=2oS8+fqtxxsaS15KC/L1xcdaFsP8a3vFgxDwJU0eA4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aP95Jk+oo80CXr6HuNfnFFfxtPxIgUpXB6pRRO9iXFVk6RD379EG/ubcgd1jjp8SAOBDbyGdC5Dq8y9rf/JvKsKIvUNyL5+HAz6F/D4YLc4niVyQBNFRjdPfC8Y7KcpfJcTVan7OC8sqfZDZ8+g1WOamiF894JjbRjkX9EuUOuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dJZ7rqEk; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dJZ7rqEk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fisZzc4fqOylE4is2pLckE0LDfx+aUECW4GblFBlGgtv2nKqc/tIO/P5gZaM74JlEg9ssDBz+F0QBn5IOGyuEPh6jphOtneZGNYB5XNmKuFWxr9deuGcwYNYvN9tsZwFZDe0HTotJ9XtFw0ecQ/HjebHqn+T9LZzVeYj43gfrpn+igHrMo4qdcZGfaSXROc8mvwLVKg8Z3QE/eJ25sb45TrPjzb+TgKRJxrPwzldc3PPCgqUh/dw106unlTMImw1QkJWpejbRMk75xVdFEHZTje0B5Ecte/D5OFBQhCp/aod9N/zzGpfZp/qQBrIil9DcD3arOuRIHFV0bpye5lOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XFImSYpsmG6AKHNTTkj/+F3ydt5mAJMigNXppyr6m4=;
 b=Rq+AeEnJMr99Hq8RoEUkOugbpjVVIW/5y+ArNzeFFDZmaJpjd0lRzct9uKiQ9M7viP1nwOEUCj4ZAJkJqyrDa4r7m8z3FmV4t+a0QPNoGuQ6VIkSgwVHTpsFu3ck7RkwjwWopxG7XTZ9V77DiaGmDKSIT2bWpl5/UCml25JFn0s33Av8UVDmkAXMROOPFdlaaUxATr5eRpRJvaRoMBN27wuj3lxPmVtRDps9Nm+QRAiDsuMIyy8xcw2K8xQxzSK6E+rQo4rIDZ9Io9g1Ocx8eqTvevq6A14htZgEjfFMnA0ynI5KrTh3CUFuVE69a8os14g2UuHwJGLqgb6HyIBq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XFImSYpsmG6AKHNTTkj/+F3ydt5mAJMigNXppyr6m4=;
 b=dJZ7rqEkEZlPOTQhOcfMHbAFqXxJYtClaf2d3puBzJsvXAi0XKLZeQcD1Ye5gyoN+cYGDp9CHvD9b8WmvxKPwU7q8NyL5ash9/u6pObqD87U4g2qYGfja6lEqiE6d7tPQEIT1BRJTORZNXS24NRayOxRwhcXvdgxnoy2LNcAvNs=
Received: from SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::17)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 00:05:38 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::9) by SA1P222CA0080.outlook.office365.com
 (2603:10b6:806:35e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:05:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:05:38 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:05:38 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
	<xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 00/12] guest_memfd: support in-place memory conversion
Date: Wed, 27 May 2026 19:03:25 -0500
Message-ID: <20260528000416.8161-1-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a04891-d601-4caa-cc4e-08debc4cd969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	6pCHRjqmSlDOoa0XnOijVr6nnj1rWR8iGN9dDonXQp97oKrH5PlRkUX/Q3VMabFA0qiGZLkXNlocXYX1jAGBJWw3pi4XVCf9TB4wLtWeKqbFMcz4ABcakh2o5GNHhlPQ67A0xqLTduxiDmIzxZJh5+V5DFg7zoSsyIRVKqgq5li+Fx1o72Jr7i0BFCmWRBuDnahKwAIrRrixp59jsOvrJD0cwh5ffh7hjeyacZDu12M+EndUaFAWs4hCD19ukXCd4YuiTioY9oknY7+D/wHY9fUuFNeJ1ZM0IPXQDA2KuUWWa6X/OPSw2OkEM702F+xOZyGlgreQyazrUKnoTHL1CDNIgxlP27q+uPz1DM/W2r9KhEjmvpE9p6KFMvhsBdfSa1UM/MY/AtMVUMAg0QPX7l0ct33bLfqNOVuuaNPfjAZwQT8YELJgR35KJTNU7thF/wOn0a1PwLCZaNSPYbb7sTlnmavrMqpFvj/dzjhM7DIqdfo1ONQDjX/JQ0svpJ+lozKbpd7uvE3ZsJ4KxnVqzHU4mxnjtfLfYySYORUB1f8+oVJItxrYzJJvelH/SOS61Hr1WZPIr4hLm/kx7nNA7+4R/9EerOUCFRxhj7ushhWE5h8XjykFvjjNETZOxpdQ71Mxnzlj5auSKPeo95BoK7q1jLK7cNi6EPvECkHeBA6mbcey9pkVlA8Td17b+WEL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fvQYnHQz2zZw8KPhWggH2jwtrRYiQE79Ia6ppd8izF6ZM97+GKrTAjXi2TlmKx/DTXupu5FUq94B2+4Y3utmLrRPw5qRpExPKnDKqutkEo/mshHVc5Truqn6QIrZUS1LSRo8JFKoGi6XPt9SdpLNHlkMZc8IJI8uzYA3e6RFB8emsBMm8CP/BlaukT7W0MQIAUiEBLHrH2IY8P+sd+h4jyOYJQYo46BR86ETmVgoFt+getNhoIiSQjpKUhxna5+Ermf8x5hHb1RNQfrAHlAxBuOgh8/s0OAXo+26buZzAzxbVf/eHoC3DiHcby0L9ZktfM0TSiAx5BwAIzD9AXvYuxaemmvf7d6KLMCspXs17XrmCZntMfcVtWnpkK95KQfazCbZwkxSS+AZRMmU3CcyuhmxhOM421qNctS9WwsuLuiG0tjldyOIskYLL9Mtjph5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:05:38.3606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a04891-d601-4caa-cc4e-08debc4cd969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347

This patchset is also available at:

  https://github.com/amdese/qemu/commits/snp-inplace-rfc1

which is in turn based on the following series:

  [PATCH 0/4] "guest_memfd: Fix handling for conversions of MMIO ranges"
  https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg07547.html


OVERVIEW
--------

This series adds guest_memfd support for in-place conversion of memory
between private/shared, and enables it for SEV-SNP guests. It is based
on recently-added kernel support for mmap()-able guest_memfd
instances[1], which allow it to be used for shared memory, and the
following patchset[2], which adds additional guest_memfd interfaces to
allow it to be used to perform in-place conversion:

  "[PATCH v7 00/42] guest_memfd: In-place conversion support"
  https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/

That series also introduces a new 'vm_memory_attributes' KVM
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

A new dedicated memory backend, memory-backend-guest-memfd, allocates
its memory via a guest_memfd file descriptor obtained from KVM with
the GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED flags. The fd
is mmap()ed so userspace can access pages directly while they are in
the shared state. For a normal/non-confidential VM, this backend can
be used in a similar fashion as the existing memory-backend-memfd.

For confidential VMs, a new 'convert-in-place' flag is added to switch
on in-place conversion support. When running in this mode, the user
*MUST* use memory-backend-guest-memfd for backing guest RAM. A new
RAM_GUEST_MEMFD_SHARED RAMBlock flag is added to track/enforce the
dependency. Additionally, QEMU is modified to use mmap()-able
guest_memfd and set this flag for other cases where it allocates RAM
internally. As a result, block->fd will generally always a guest_memfd,
and when RAM_GUEST_MEMFD_SHARED is set then that block->fd will be
qemu_dup()'d as the FD handle for private memory is well (which is
currently what block->guest_memfd point to). This allows the prior
non-in-place handling around block->guest_memfd to be kept mostly
unchanged.

When running with convert-in-place=true, shared/private conversions
are no longer handled directly by KVM, but instead by a new guest_memfd
ioctl, KVM_SET_MEMORY_ATTRIBUTES2, which purposely provides similar
naming/implementation to the KVM_SET_MEMORY_ATTRIBUTES KVM ioctl that
it replaces. This series adds handling to route conversion requests to
the appropriate ioctls based on whether or not in-place conversion is
enabled.

Since guest_memfd ioctls need to be called against the specific
guest_memfd inode associated with each memory slot/region, some
refactoring is needed to handle conversions on a per-section. Much of
that is inherited from the bugfix series this patchset is based on top
of, which adds the initial logic for handling multiple sections within
a range that gets heavily re-used here.


USAGE
-----

After applying this series against a kernel with the RFC patches above
present, an SEV-SNP guest can be started with in-place conversion via:

    qemu-system-x86_64 \
        -machine q35,confidential-guest-support=sev0,memory-backend=ram0 \
        -object memory-backend-guest-memfd,id=ram0,size=8G,share=on \
        -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,\
                convert-in-place=on \
        ...

The new memory-backend-guest-memfd can also be used by normal VMs:

    qemu-system-x86_64 \
        -machine q35,memory-backend=ram0 \
        -object memory-backend-guest-memfd,id=ram0,size=8G,share=on \
        ...

This is mainly only useful atm for testing, but in the future there may
be more use-cases around using guest_memfd as a general-purpose backend
for non-confidential VMs, so it is intended to work in this manner as
well.


NOTES/TODO
----------

  - the CPR handling to support resetting of confidential VMs is
    currently disabled when in-place conversion is enabled.
  - TDX testing would be great, in theory it can be enabled with this
    series (similarly to the top patch) but I'm not sure if there are
    other special requirements before we can switch it on.
  - kernel patches are still in-flight, but fairly mature at this point
    and nearing upstream


REFERENCES
----------

[1] https://lore.kernel.org/kvm/20250729225455.670324-1-seanjc@google.com/
[2] https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/
[3] https://www.youtube.com/watch?v=MMfAGNW9RVg
[4] 1GB hugetlb v2


Thoughts, feedback, and testing are very much appreciated.

Thanks,

Mike


----------------------------------------------------------------
Michael Roth (12):
      accel/kvm: Decouple guest_memfd checks from memory attribute checks
      hostmem: Introduce dedicated memory backend for guest_memfd
      linux-headers: Update headers for v7 of in-place conversion kernel support
      accel/kvm: Add CGS option to control in-place conversion support
      system/memory: Re-use memory-backend-guest-memfd inode for private memory
      system/memory: Default to guest_memfd for RAM for in-place conversion
      accel/kvm: Move post-conversion updates to a separate helper
      accel/kvm: Re-order attribute notifications for in-place conversion
      accel/kvm: Support shared/private conversions via guest_memfd ioctls
      accel/kvm: Don't default to private attributes for in-place conversion
      i386/sev: Update SNP_LAUNCH_UPDATE for in-place conversion
      i386/sev: Allow in-place conversion for SEV-SNP guests

 accel/kvm/kvm-all.c                                | 286 +++++++++++--
 accel/stubs/kvm-stub.c                             |   9 +-
 backends/confidential-guest-support.c              |  25 ++
 backends/hostmem-guest-memfd.c                     |  93 +++++
 backends/meson.build                               |   1 +
 include/standard-headers/drm/drm_fourcc.h          |  28 +-
 include/standard-headers/linux/const.h             |  18 +
 include/standard-headers/linux/ethtool.h           |  28 +-
 include/standard-headers/linux/input-event-codes.h |  13 +
 include/standard-headers/linux/pci_regs.h          |  71 +++-
 include/standard-headers/linux/typelimits.h        |   8 +
 include/standard-headers/linux/virtio_ring.h       |   5 +-
 include/standard-headers/linux/virtio_rtc.h        | 237 +++++++++++
 include/standard-headers/linux/vmclock-abi.h       |  20 +
 include/system/confidential-guest-support.h        |  14 +
 include/system/hostmem.h                           |   1 +
 include/system/kvm.h                               |   3 +-
 include/system/memory.h                            |   8 +-
 linux-headers/asm-arm64/kvm.h                      |   1 +
 linux-headers/asm-arm64/unistd_64.h                |   1 +
 linux-headers/asm-generic/unistd.h                 |   5 +-
 linux-headers/asm-loongarch/kvm.h                  |   5 +
 linux-headers/asm-loongarch/kvm_para.h             |   1 +
 linux-headers/asm-loongarch/unistd_64.h            |   2 +
 linux-headers/asm-mips/unistd_n32.h                |   1 +
 linux-headers/asm-mips/unistd_n64.h                |   1 +
 linux-headers/asm-mips/unistd_o32.h                |   1 +
 linux-headers/asm-powerpc/unistd_32.h              |   1 +
 linux-headers/asm-powerpc/unistd_64.h              |   1 +
 linux-headers/asm-riscv/kvm.h                      |  11 +-
 linux-headers/asm-riscv/ptrace.h                   |  37 ++
 linux-headers/asm-riscv/unistd_32.h                |   1 +
 linux-headers/asm-riscv/unistd_64.h                |   1 +
 linux-headers/asm-s390/unistd_32.h                 | 446 ---------------------
 linux-headers/asm-s390/unistd_64.h                 |   1 +
 linux-headers/asm-x86/kvm.h                        |  21 +-
 linux-headers/asm-x86/unistd_32.h                  |   1 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   1 +
 linux-headers/linux/const.h                        |  18 +
 linux-headers/linux/iommufd.h                      |  48 +++
 linux-headers/linux/kvm.h                          |  62 ++-
 linux-headers/linux/mshv.h                         |   4 +-
 linux-headers/linux/psp-sev.h                      |   2 +-
 linux-headers/linux/stddef.h                       |   4 +
 linux-headers/linux/vduse.h                        |  85 +++-
 linux-headers/linux/vfio.h                         |  30 +-
 qapi/qom.json                                      |  35 +-
 qemu-options.hx                                    |   5 +
 system/memory.c                                    |  22 +-
 system/physmem.c                                   |  50 ++-
 target/i386/sev.c                                  |  12 +-
 52 files changed, 1253 insertions(+), 533 deletions(-)
 create mode 100644 backends/hostmem-guest-memfd.c
 create mode 100644 include/standard-headers/linux/typelimits.h
 create mode 100644 include/standard-headers/linux/virtio_rtc.h
 delete mode 100644 linux-headers/asm-s390/unistd_32.h

