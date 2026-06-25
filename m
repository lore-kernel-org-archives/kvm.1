Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A436D9F9
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782422550; cv=fail; b=J4mtja+TPiexF+jNNyLpDIfiPI+O73g44FBVSfXIiNncFtCOV/9c30caZg5Gh4lUUKLS/aqavRydut2SWapeEJnE99XePiagoPtApZXZN8Cwg8jn+kxTmQjMRXbj80KJLM13Mul8SZUhVyfZspwW1LCszNf9ywjYC+fdOE50Yu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782422550; c=relaxed/simple;
	bh=w99WZjcoi87aeXzKIo8a3n/eWPdS1VR58JbZ3ox9Qi4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdUXrLS9zflupwznB/UPcilLcXumjjhig69Dj9Kfvb6E/nW77WYtV8gMf6hMPeHVp4bI7lXkcbn1dNxzYHp1BgKrmMEF1kSmFwSwrDvp/H/c2FZ1uGmdwLt9zOf5E6rVkwKmJTX+KARNN5pNudkTEp6SJ+3mAXHKHc/oMKPh8xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fh5uJWA0; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fh5uJWA0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaE6HGc4A7mgcbSoH4voHNrBSBCF5y59blmb4tjOUliKd5ZvHhqA5c9AfXZe2w0I13mDvVl1eQj4kd8qHeWAuLME802mT7JxHgbbBB51VUwKS2uu50rs2bo0swjmeHsFt4x4iB3rhlTKd86zITa0PWf2d/yd1MQkWUmbx1GRDOGxUhn1sLmASJ3A/sBMekxfMMt5j5sgkantQ56AfeRg04sMJA2LX95yM2R8NJwaV35fLrL8OeXNjW2Hnt1HbCuC44Sx3C7UP0IVXVAh5RAthCtUUnVopMCuUcTWVQXM5LLaryLYL4Qe3TWS18JPqMsSwbrbzi21W95wiVlNiy4W0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk3t522edh3FWAUrMTCmDOhujQ16KakiireDHV6V50g=;
 b=XUAnxp+mxhrweX/C5LFxuR0JQ+++gEqU9UrfmpYsmTLpGsKXNCUJUKY8h4/tBVRPV28EgP2HOJEi/aey4lKX4EOIn2WaxCgf1CrbV8jDpPcFdScIcbgXCpVDsgWP2+6uFuqG6ELqQ0LmG4HW9YZh3H3ChQ0GztI7LHH+Z83JbNz5eFv9nO2rMyHlUD93GZc+oPqspH0Ds2raKLLnrQrjMgzjQAnEr6eMat8C1ypzbEnN66vcf94TDS3VD9RntD5uJIzVzWJJaSOP1hKRFNboM9IBP4tMNKP4esi36ZCHqcVqlBNvLuOi7KtA6UuYLdeIMBc51PadQmcpO4FxTS9Glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk3t522edh3FWAUrMTCmDOhujQ16KakiireDHV6V50g=;
 b=Fh5uJWA01xT4A5IJPeiknOH/oPnB3Bw9bdI4OFsmv+ZFY0fYvEwu1VQABg4xWX7dah0K4KmaYUREeHOphbN9bx5iMTnt96BSbL9YE27nwBeeOhQBTKte1Ovm2T692K2yri0uof18tilrcHw4vLS8Mec0OX34IE0KJES4LGjuwjQ=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 21:22:16 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::63) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 21:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 21:22:16 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 16:22:10 -0500
Date: Thu, 25 Jun 2026 16:21:52 -0500
From: Michael Roth <michael.roth@amd.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
	<berrange@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
	<isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
	<ackerleytng@google.com>
Subject: Re: [PATCH RFC 00/12] guest_memfd: support in-place memory conversion
Message-ID: <bdg5gb5m4tnm5pmq54vafyykbegefsrz4qupn44ofwfiwkpwk4@zwg7e35l5zps>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <ajkrWSfmODM8NTZ5@lpieralisi>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajkrWSfmODM8NTZ5@lpieralisi>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 527618c8-16c0-42c6-2df2-08ded2ffd507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|23010399003|376014|82310400026|18002099003|22082099003|13003099007|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8yjWAUQ1Qg9e+E+LgUp0Ud+Y3I/sSTfUaHHdA/MyXGaXxlyUV1mcF6gTQPjkhE+vNCd4gTHAqfyx9x+03k4uxg9lhk/Y1pJgoXi5jjr/sJ8Eu1hQAeYgvaiQOILwGwSybnPHnDHDR8LxGSeh4rgAL/vrjn2IWj2sYNTbVvMsFyMeSR/vWHgqWDW6CgZU/4DItKF2ghkRGPRS/FMzZfCTLV344b7kuO6scp8EBiOg/z2qyM4zHU2wlpisMxkan89TG+y4zNgvk4Z8HbpbIMv19hXoXMJkikSeSgP4BDHAgaosQnK2vy11oCHmymizODMLd5NclyBieGw3wL0NEsTBuSFYWtZw1n27YuTcjLLYCHlGHEB4YxK9TQqXzen5g6bW9tBYuBjmE5Tb1gTXcKUfUegk5bhmKeDIAe64/tGU85eBKvyW40NLhEj9VMfr+v98Piu9PiD9KB5Y67Yzgzc6WQvkZh/BL1y27k11HiVWGONnYZG/F+xAz60pMrFVwdLyho20dFs/j8ID5/tYy8xrPQC3zJp9WlDoTHuK5vkS9W6opnDIB4tzA3fnN37GTHqTG6cVcARk78O+XH8g4nqEvcrJtdVqCZvAuS/IeMjNaMI/Du1Oc9mRm8AE8+tMvoupfDh9XH8+IJ2vvemR4WZHGaroOGwmQCkgHhUFxBOSE+4x6g2oV6FOpZsXfCmUfy5OP3HOhcBB05RRDqcYNnCJ5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(13003099007)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yQDgAvC3Xpt608C1a5Lk210q4ijCd8Rmt5wv5jlAujdBVKMiZc/NtkKs55oDcJhmtf17uhq1MdVeC1Hrluw8BuF1EAw8Yr/Z0zCLSXWGxN96AVlghvo1GtY0V9YlMZMmyXIZjJ8813zYhhm+A/cUXIKXIMgrQCU8cZcoFR81vXvkWFSuvt59IKfaXOywlkJ9yexWK1xKIyb8UW/dLvAPzzXqZ7RrArutX530mjsQH8VU9f7GD9lMFEJ85stJhUhOKdAWIevcZzFQQBwZPh5ZTYlOY0fLsLUQyUVp6eEJ0d32C+/Q6R8vuAj8gBQAESHp5t6pUUpnOxXt19QJUlQUvMG37SXsv/s/RiYzHBvDXBI95/41FEez4sCSU0pPxxFRujCIQn8F4VPatOP5J/0NjhO8oonIGA7oaxrArjDbQoxyHXGgnO/xwIaT8Y1jGtQ2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 21:22:16.4351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527618c8-16c0-42c6-2df2-08ded2ffd507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036

On Mon, Jun 22, 2026 at 02:32:25PM +0200, Lorenzo Pieralisi wrote:
> On Wed, May 27, 2026 at 07:03:25PM -0500, Michael Roth wrote:
> > This patchset is also available at:
> > 
> >   https://github.com/amdese/qemu/commits/snp-inplace-rfc1
> > 
> > which is in turn based on the following series:
> > 
> >   [PATCH 0/4] "guest_memfd: Fix handling for conversions of MMIO ranges"
> >   https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg07547.html
> > 
> > 
> > OVERVIEW
> > --------
> > 
> > This series adds guest_memfd support for in-place conversion of memory
> > between private/shared, and enables it for SEV-SNP guests. It is based
> > on recently-added kernel support for mmap()-able guest_memfd
> > instances[1], which allow it to be used for shared memory, and the
> > following patchset[2], which adds additional guest_memfd interfaces to
> > allow it to be used to perform in-place conversion:
> > 
> >   "[PATCH v7 00/42] guest_memfd: In-place conversion support"
> >   https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/
> > 
> > That series also introduces a new 'vm_memory_attributes' KVM
> > module option, which sets whether memory attributes are tracked
> > VM-wide by KVM (vm_memory_attributes=1: the existing 'legacy' mode),
> > or per-guest_memfd instance (vm_memory_attributes=0: the new mode
> > which allows for in-place conversion). The latter is intended to
> > eventually deprecate the legacy mode, at which point in-place
> > conversion would become the primarily-supported mode.
> > 
> > 
> > MOTIVATION
> > ----------
> > 
> > Today, SEV-SNP guests (and other CoCo VM types using guest_memfd) keep
> > shared and private memory on separate physical backings: a userspace
> > memory-backend object for shared pages, and a kernel-allocated
> > guest_memfd file descriptor for private pages. KVM_SET_MEMORY_ATTRIBUTES
> > flips which backing the guest sees for a given GPA range, and the old
> > backing is typically discarded / hole-punched on conversion to avoid
> > doubled memory usage.
> 
> Hi Michael,

Hi Lorenzo,

> 
> I am giving this a go on Arm CCA on top of Ackerley's KVM patches.

Nice!

> 
> When convert-in-place is switched on I think that the post conversion
> hook should not trigger discard+hole-punch since now guest-memfd _is_
> the memory back-end but it looks like there is no guard in place against
> that (I noticed that ram_block_discard_range() triggers a hole-punch in
> kvm_post_convert_section() - when the CCA guest first requests a
> KVM_EXIT_MEMORY_FAULT to convert to private).
> 
> It is a question really.

Yes, I agree that it does not make much sense to try to hole-punch for
in-place conversion, it's just uncessary churn on the gmem side. In my
internal branches I generally disabled this path but for some reason
left that out of this series. I've tested with the below change and it
should do the trick though; I'll roll something similar into v2 of the
series.

  diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
  index 5840daa7c8..2faec929b5 100644
  --- a/accel/kvm/kvm-all.c
  +++ b/accel/kvm/kvm-all.c
  @@ -3619,17 +3619,19 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
           }
       }
   
  -    if (to_private) {
  -        if (rb->page_size != qemu_real_host_page_size()) {
  -            /*
  -             * shared memory is backed by hugetlb, which is supposed to be
  -             * pre-allocated and doesn't need to be discarded
  -             */
  -            return 0;
  +    if (current_machine->cgs && current_machine->cgs->convert_in_place) {
  +        if (to_private) {
  +            if (rb->page_size != qemu_real_host_page_size()) {
  +                /*
  +                 * shared memory is backed by hugetlb, which is supposed to be
  +                 * pre-allocated and doesn't need to be discarded
  +                 */
  +                return 0;
  +            }
  +            ret = ram_block_discard_range(rb, offset, size);
  +        } else {
  +            ret = ram_block_discard_guest_memfd_range(rb, offset, size);
           }
  -        ret = ram_block_discard_range(rb, offset, size);
  -    } else {
  -        ret = ram_block_discard_guest_memfd_range(rb, offset, size);
       }
   
       return 0;

Thanks!

-Mike

> 
> Thanks,
> Lorenzo
> 
> > That model works, but has a number of downsides that impact certain
> > use-cases:
> > 
> >   - Each conversion involves discarding pages on one side and faulting
> >     them in on the other, which incurs allocation overheads in the
> >     host kernel for every conversion.
> > 
> >   - Some use-cases, like pKVM[3], rely on memory isolation rather than
> >     encryption and rely on in-place conversion to pass through things
> >     like secured framebuffer memory without needing to bounce data
> >     through separate shared/private HPAs, which would introduce
> >     unacceptable latency for that sort of workload.
> > 
> >   - Hugetlb support[4] for guest_memfd will rely on it, since things like
> >     1GB hugepages with a mix of shared/private sub-ranges would generally
> >     require 2 1GB hugetlb pages to remain available to handle shared vs.
> >     private accesses, which quickly causes doubling of guest memory usage.
> > 
> > Recent kernel work[2] makes guest_memfd mmap()-able and lets the *same*
> > physical pages be used for both shared and private states for a given
> > GPA range, allowing the above pitfalls to be naturally avoided.
> > 
> > This series wires that support up in QEMU.
> > 
> > 
> > DESIGN
> > ------
> > 
> > A new dedicated memory backend, memory-backend-guest-memfd, allocates
> > its memory via a guest_memfd file descriptor obtained from KVM with
> > the GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED flags. The fd
> > is mmap()ed so userspace can access pages directly while they are in
> > the shared state. For a normal/non-confidential VM, this backend can
> > be used in a similar fashion as the existing memory-backend-memfd.
> > 
> > For confidential VMs, a new 'convert-in-place' flag is added to switch
> > on in-place conversion support. When running in this mode, the user
> > *MUST* use memory-backend-guest-memfd for backing guest RAM. A new
> > RAM_GUEST_MEMFD_SHARED RAMBlock flag is added to track/enforce the
> > dependency. Additionally, QEMU is modified to use mmap()-able
> > guest_memfd and set this flag for other cases where it allocates RAM
> > internally. As a result, block->fd will generally always a guest_memfd,
> > and when RAM_GUEST_MEMFD_SHARED is set then that block->fd will be
> > qemu_dup()'d as the FD handle for private memory is well (which is
> > currently what block->guest_memfd point to). This allows the prior
> > non-in-place handling around block->guest_memfd to be kept mostly
> > unchanged.
> > 
> > When running with convert-in-place=true, shared/private conversions
> > are no longer handled directly by KVM, but instead by a new guest_memfd
> > ioctl, KVM_SET_MEMORY_ATTRIBUTES2, which purposely provides similar
> > naming/implementation to the KVM_SET_MEMORY_ATTRIBUTES KVM ioctl that
> > it replaces. This series adds handling to route conversion requests to
> > the appropriate ioctls based on whether or not in-place conversion is
> > enabled.
> > 
> > Since guest_memfd ioctls need to be called against the specific
> > guest_memfd inode associated with each memory slot/region, some
> > refactoring is needed to handle conversions on a per-section. Much of
> > that is inherited from the bugfix series this patchset is based on top
> > of, which adds the initial logic for handling multiple sections within
> > a range that gets heavily re-used here.
> > 
> > 
> > USAGE
> > -----
> > 
> > After applying this series against a kernel with the RFC patches above
> > present, an SEV-SNP guest can be started with in-place conversion via:
> > 
> >     qemu-system-x86_64 \
> >         -machine q35,confidential-guest-support=sev0,memory-backend=ram0 \
> >         -object memory-backend-guest-memfd,id=ram0,size=8G,share=on \
> >         -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,\
> >                 convert-in-place=on \
> >         ...
> > 
> > The new memory-backend-guest-memfd can also be used by normal VMs:
> > 
> >     qemu-system-x86_64 \
> >         -machine q35,memory-backend=ram0 \
> >         -object memory-backend-guest-memfd,id=ram0,size=8G,share=on \
> >         ...
> > 
> > This is mainly only useful atm for testing, but in the future there may
> > be more use-cases around using guest_memfd as a general-purpose backend
> > for non-confidential VMs, so it is intended to work in this manner as
> > well.
> > 
> > 
> > NOTES/TODO
> > ----------
> > 
> >   - the CPR handling to support resetting of confidential VMs is
> >     currently disabled when in-place conversion is enabled.
> >   - TDX testing would be great, in theory it can be enabled with this
> >     series (similarly to the top patch) but I'm not sure if there are
> >     other special requirements before we can switch it on.
> >   - kernel patches are still in-flight, but fairly mature at this point
> >     and nearing upstream
> > 
> > 
> > REFERENCES
> > ----------
> > 
> > [1] https://lore.kernel.org/kvm/20250729225455.670324-1-seanjc@google.com/
> > [2] https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/
> > [3] https://www.youtube.com/watch?v=MMfAGNW9RVg
> > [4] 1GB hugetlb v2
> > 
> > 
> > Thoughts, feedback, and testing are very much appreciated.
> > 
> > Thanks,
> > 
> > Mike
> > 
> > 
> > ----------------------------------------------------------------
> > Michael Roth (12):
> >       accel/kvm: Decouple guest_memfd checks from memory attribute checks
> >       hostmem: Introduce dedicated memory backend for guest_memfd
> >       linux-headers: Update headers for v7 of in-place conversion kernel support
> >       accel/kvm: Add CGS option to control in-place conversion support
> >       system/memory: Re-use memory-backend-guest-memfd inode for private memory
> >       system/memory: Default to guest_memfd for RAM for in-place conversion
> >       accel/kvm: Move post-conversion updates to a separate helper
> >       accel/kvm: Re-order attribute notifications for in-place conversion
> >       accel/kvm: Support shared/private conversions via guest_memfd ioctls
> >       accel/kvm: Don't default to private attributes for in-place conversion
> >       i386/sev: Update SNP_LAUNCH_UPDATE for in-place conversion
> >       i386/sev: Allow in-place conversion for SEV-SNP guests
> > 
> >  accel/kvm/kvm-all.c                                | 286 +++++++++++--
> >  accel/stubs/kvm-stub.c                             |   9 +-
> >  backends/confidential-guest-support.c              |  25 ++
> >  backends/hostmem-guest-memfd.c                     |  93 +++++
> >  backends/meson.build                               |   1 +
> >  include/standard-headers/drm/drm_fourcc.h          |  28 +-
> >  include/standard-headers/linux/const.h             |  18 +
> >  include/standard-headers/linux/ethtool.h           |  28 +-
> >  include/standard-headers/linux/input-event-codes.h |  13 +
> >  include/standard-headers/linux/pci_regs.h          |  71 +++-
> >  include/standard-headers/linux/typelimits.h        |   8 +
> >  include/standard-headers/linux/virtio_ring.h       |   5 +-
> >  include/standard-headers/linux/virtio_rtc.h        | 237 +++++++++++
> >  include/standard-headers/linux/vmclock-abi.h       |  20 +
> >  include/system/confidential-guest-support.h        |  14 +
> >  include/system/hostmem.h                           |   1 +
> >  include/system/kvm.h                               |   3 +-
> >  include/system/memory.h                            |   8 +-
> >  linux-headers/asm-arm64/kvm.h                      |   1 +
> >  linux-headers/asm-arm64/unistd_64.h                |   1 +
> >  linux-headers/asm-generic/unistd.h                 |   5 +-
> >  linux-headers/asm-loongarch/kvm.h                  |   5 +
> >  linux-headers/asm-loongarch/kvm_para.h             |   1 +
> >  linux-headers/asm-loongarch/unistd_64.h            |   2 +
> >  linux-headers/asm-mips/unistd_n32.h                |   1 +
> >  linux-headers/asm-mips/unistd_n64.h                |   1 +
> >  linux-headers/asm-mips/unistd_o32.h                |   1 +
> >  linux-headers/asm-powerpc/unistd_32.h              |   1 +
> >  linux-headers/asm-powerpc/unistd_64.h              |   1 +
> >  linux-headers/asm-riscv/kvm.h                      |  11 +-
> >  linux-headers/asm-riscv/ptrace.h                   |  37 ++
> >  linux-headers/asm-riscv/unistd_32.h                |   1 +
> >  linux-headers/asm-riscv/unistd_64.h                |   1 +
> >  linux-headers/asm-s390/unistd_32.h                 | 446 ---------------------
> >  linux-headers/asm-s390/unistd_64.h                 |   1 +
> >  linux-headers/asm-x86/kvm.h                        |  21 +-
> >  linux-headers/asm-x86/unistd_32.h                  |   1 +
> >  linux-headers/asm-x86/unistd_64.h                  |   1 +
> >  linux-headers/asm-x86/unistd_x32.h                 |   1 +
> >  linux-headers/linux/const.h                        |  18 +
> >  linux-headers/linux/iommufd.h                      |  48 +++
> >  linux-headers/linux/kvm.h                          |  62 ++-
> >  linux-headers/linux/mshv.h                         |   4 +-
> >  linux-headers/linux/psp-sev.h                      |   2 +-
> >  linux-headers/linux/stddef.h                       |   4 +
> >  linux-headers/linux/vduse.h                        |  85 +++-
> >  linux-headers/linux/vfio.h                         |  30 +-
> >  qapi/qom.json                                      |  35 +-
> >  qemu-options.hx                                    |   5 +
> >  system/memory.c                                    |  22 +-
> >  system/physmem.c                                   |  50 ++-
> >  target/i386/sev.c                                  |  12 +-
> >  52 files changed, 1253 insertions(+), 533 deletions(-)
> >  create mode 100644 backends/hostmem-guest-memfd.c
> >  create mode 100644 include/standard-headers/linux/typelimits.h
> >  create mode 100644 include/standard-headers/linux/virtio_rtc.h
> >  delete mode 100644 linux-headers/asm-s390/unistd_32.h
> > 
