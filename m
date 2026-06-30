Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395E3EFD22
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814744; cv=none; b=kMAjgHXVMfSMbvycMoGftm4ZjY7s8ikN5h0hlhHHnvrUXj9esjsblyvFtgEI4K0TpxnCZo1ND/bLW2UP/Ukv56hTpk9qHbRBXfUOzFVT4tikInpGUlpiifWaPHMkN3i9s1QJ1axCkDPahEAtVqgf5BGExA5e4/QySWbMViIiJXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814744; c=relaxed/simple;
	bh=aPKq/6IHE64Ld3RcwNTW+lo941pl3E9dYyDTa4chBOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/w+RjTdEqDSPM3HWRMBmMeqFnNxRrb0j6fn50Esu0+wQX4Y5u65qbyg6AJDpxJew5Bg1B3OLN6/fJ51xVhbnB0HMUbpNG46NGfxQnfGawbBhv1VEYR1ui8lsbsBDptb2UNt4NhzDU0H73ckWfXARDjQbT1+0cyw8iF5fDxItrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC1Jaq9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC1Jaq9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A7D1F000E9;
	Tue, 30 Jun 2026 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782814739;
	bh=vRwimpREReUGgShdpW79yNcehG6qrB1csDNTOa25d28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EC1Jaq9ZLVVay5+hzONK6kAI9BqttyjOTP4woTeVrenXD8MSuAiHLRYLPy6pxTB+7
	 IOccPNlNy+DBtw4dpQuzU7w5xWNUut2Tsxle2+iaRzFzBtNNHnaAFhezYTr7NGp+iu
	 hbUBIE2AnBYc++064E2kXhRt35w1223AztibP2UhV6YBy3g9wi/TNGfVtgWE6ajZn7
	 6ruT4GpXWF97sfnmqG+zUgyzh+3xRRZHLXJTDB2y6XvHG06+yZYjnkQVr9HJ0S3RYl
	 NmAaFrrH0EctO/0D2mt9iz/T9bvBACCeVTKQA6fUiYcVaeVPRgm4sctcFjpaBDIjhS
	 N/qFluKZUfDXg==
Date: Tue, 30 Jun 2026 12:18:51 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
	berrange@redhat.com, armbru@redhat.com, pankaj.gupta@amd.com,
	isaku.yamahata@intel.com, xiaoyao.li@intel.com,
	chao.p.peng@linux.intel.com, david@kernel.org, ashish.kalra@amd.com,
	ackerleytng@google.com
Subject: Re: [PATCH RFC 00/12] guest_memfd: support in-place memory conversion
Message-ID: <akOYC+3drsxA+/Gv@lpieralisi>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <ajkrWSfmODM8NTZ5@lpieralisi>
 <bdg5gb5m4tnm5pmq54vafyykbegefsrz4qupn44ofwfiwkpwk4@zwg7e35l5zps>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdg5gb5m4tnm5pmq54vafyykbegefsrz4qupn44ofwfiwkpwk4@zwg7e35l5zps>

On Thu, Jun 25, 2026 at 04:21:52PM -0500, Michael Roth wrote:
> On Mon, Jun 22, 2026 at 02:32:25PM +0200, Lorenzo Pieralisi wrote:
> > On Wed, May 27, 2026 at 07:03:25PM -0500, Michael Roth wrote:
> > > This patchset is also available at:
> > > 
> > >   https://github.com/amdese/qemu/commits/snp-inplace-rfc1
> > > 
> > > which is in turn based on the following series:
> > > 
> > >   [PATCH 0/4] "guest_memfd: Fix handling for conversions of MMIO ranges"
> > >   https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg07547.html
> > > 
> > > 
> > > OVERVIEW
> > > --------
> > > 
> > > This series adds guest_memfd support for in-place conversion of memory
> > > between private/shared, and enables it for SEV-SNP guests. It is based
> > > on recently-added kernel support for mmap()-able guest_memfd
> > > instances[1], which allow it to be used for shared memory, and the
> > > following patchset[2], which adds additional guest_memfd interfaces to
> > > allow it to be used to perform in-place conversion:
> > > 
> > >   "[PATCH v7 00/42] guest_memfd: In-place conversion support"
> > >   https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/
> > > 
> > > That series also introduces a new 'vm_memory_attributes' KVM
> > > module option, which sets whether memory attributes are tracked
> > > VM-wide by KVM (vm_memory_attributes=1: the existing 'legacy' mode),
> > > or per-guest_memfd instance (vm_memory_attributes=0: the new mode
> > > which allows for in-place conversion). The latter is intended to
> > > eventually deprecate the legacy mode, at which point in-place
> > > conversion would become the primarily-supported mode.
> > > 
> > > 
> > > MOTIVATION
> > > ----------
> > > 
> > > Today, SEV-SNP guests (and other CoCo VM types using guest_memfd) keep
> > > shared and private memory on separate physical backings: a userspace
> > > memory-backend object for shared pages, and a kernel-allocated
> > > guest_memfd file descriptor for private pages. KVM_SET_MEMORY_ATTRIBUTES
> > > flips which backing the guest sees for a given GPA range, and the old
> > > backing is typically discarded / hole-punched on conversion to avoid
> > > doubled memory usage.
> > 
> > Hi Michael,
> 
> Hi Lorenzo,
> 
> > 
> > I am giving this a go on Arm CCA on top of Ackerley's KVM patches.
> 
> Nice!
> 
> > 
> > When convert-in-place is switched on I think that the post conversion
> > hook should not trigger discard+hole-punch since now guest-memfd _is_
> > the memory back-end but it looks like there is no guard in place against
> > that (I noticed that ram_block_discard_range() triggers a hole-punch in
> > kvm_post_convert_section() - when the CCA guest first requests a
> > KVM_EXIT_MEMORY_FAULT to convert to private).
> > 
> > It is a question really.
> 
> Yes, I agree that it does not make much sense to try to hole-punch for
> in-place conversion, it's just uncessary churn on the gmem side. In my

FWIW - on CCA I am not sure it is just "churn" especially if it is done on
transition to private when guest-memfd pages are already private.

> internal branches I generally disabled this path but for some reason
> left that out of this series. I've tested with the below change and it
> should do the trick though; I'll roll something similar into v2 of the
> series.

Thanks a lot, I will give it a spin.

Thanks !
Lorenzo

>   diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>   index 5840daa7c8..2faec929b5 100644
>   --- a/accel/kvm/kvm-all.c
>   +++ b/accel/kvm/kvm-all.c
>   @@ -3619,17 +3619,19 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
>            }
>        }
>    
>   -    if (to_private) {
>   -        if (rb->page_size != qemu_real_host_page_size()) {
>   -            /*
>   -             * shared memory is backed by hugetlb, which is supposed to be
>   -             * pre-allocated and doesn't need to be discarded
>   -             */
>   -            return 0;
>   +    if (current_machine->cgs && current_machine->cgs->convert_in_place) {
>   +        if (to_private) {
>   +            if (rb->page_size != qemu_real_host_page_size()) {
>   +                /*
>   +                 * shared memory is backed by hugetlb, which is supposed to be
>   +                 * pre-allocated and doesn't need to be discarded
>   +                 */
>   +                return 0;
>   +            }
>   +            ret = ram_block_discard_range(rb, offset, size);
>   +        } else {
>   +            ret = ram_block_discard_guest_memfd_range(rb, offset, size);
>            }
>   -        ret = ram_block_discard_range(rb, offset, size);
>   -    } else {
>   -        ret = ram_block_discard_guest_memfd_range(rb, offset, size);
>        }
>    
>        return 0;
> 
> Thanks!
> 
> -Mike
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > > That model works, but has a number of downsides that impact certain
> > > use-cases:
> > > 
> > >   - Each conversion involves discarding pages on one side and faulting
> > >     them in on the other, which incurs allocation overheads in the
> > >     host kernel for every conversion.
> > > 
> > >   - Some use-cases, like pKVM[3], rely on memory isolation rather than
> > >     encryption and rely on in-place conversion to pass through things
> > >     like secured framebuffer memory without needing to bounce data
> > >     through separate shared/private HPAs, which would introduce
> > >     unacceptable latency for that sort of workload.
> > > 
> > >   - Hugetlb support[4] for guest_memfd will rely on it, since things like
> > >     1GB hugepages with a mix of shared/private sub-ranges would generally
> > >     require 2 1GB hugetlb pages to remain available to handle shared vs.
> > >     private accesses, which quickly causes doubling of guest memory usage.
> > > 
> > > Recent kernel work[2] makes guest_memfd mmap()-able and lets the *same*
> > > physical pages be used for both shared and private states for a given
> > > GPA range, allowing the above pitfalls to be naturally avoided.
> > > 
> > > This series wires that support up in QEMU.
> > > 
> > > 
> > > DESIGN
> > > ------
> > > 
> > > A new dedicated memory backend, memory-backend-guest-memfd, allocates
> > > its memory via a guest_memfd file descriptor obtained from KVM with
> > > the GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED flags. The fd
> > > is mmap()ed so userspace can access pages directly while they are in
> > > the shared state. For a normal/non-confidential VM, this backend can
> > > be used in a similar fashion as the existing memory-backend-memfd.
> > > 
> > > For confidential VMs, a new 'convert-in-place' flag is added to switch
> > > on in-place conversion support. When running in this mode, the user
> > > *MUST* use memory-backend-guest-memfd for backing guest RAM. A new
> > > RAM_GUEST_MEMFD_SHARED RAMBlock flag is added to track/enforce the
> > > dependency. Additionally, QEMU is modified to use mmap()-able
> > > guest_memfd and set this flag for other cases where it allocates RAM
> > > internally. As a result, block->fd will generally always a guest_memfd,
> > > and when RAM_GUEST_MEMFD_SHARED is set then that block->fd will be
> > > qemu_dup()'d as the FD handle for private memory is well (which is
> > > currently what block->guest_memfd point to). This allows the prior
> > > non-in-place handling around block->guest_memfd to be kept mostly
> > > unchanged.
> > > 
> > > When running with convert-in-place=true, shared/private conversions
> > > are no longer handled directly by KVM, but instead by a new guest_memfd
> > > ioctl, KVM_SET_MEMORY_ATTRIBUTES2, which purposely provides similar
> > > naming/implementation to the KVM_SET_MEMORY_ATTRIBUTES KVM ioctl that
> > > it replaces. This series adds handling to route conversion requests to
> > > the appropriate ioctls based on whether or not in-place conversion is
> > > enabled.
> > > 
> > > Since guest_memfd ioctls need to be called against the specific
> > > guest_memfd inode associated with each memory slot/region, some
> > > refactoring is needed to handle conversions on a per-section. Much of
> > > that is inherited from the bugfix series this patchset is based on top
> > > of, which adds the initial logic for handling multiple sections within
> > > a range that gets heavily re-used here.
> > > 
> > > 
> > > USAGE
> > > -----
> > > 
> > > After applying this series against a kernel with the RFC patches above
> > > present, an SEV-SNP guest can be started with in-place conversion via:
> > > 
> > >     qemu-system-x86_64 \
> > >         -machine q35,confidential-guest-support=sev0,memory-backend=ram0 \
> > >         -object memory-backend-guest-memfd,id=ram0,size=8G,share=on \
> > >         -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,\
> > >                 convert-in-place=on \
> > >         ...
> > > 
> > > The new memory-backend-guest-memfd can also be used by normal VMs:
> > > 
> > >     qemu-system-x86_64 \
> > >         -machine q35,memory-backend=ram0 \
> > >         -object memory-backend-guest-memfd,id=ram0,size=8G,share=on \
> > >         ...
> > > 
> > > This is mainly only useful atm for testing, but in the future there may
> > > be more use-cases around using guest_memfd as a general-purpose backend
> > > for non-confidential VMs, so it is intended to work in this manner as
> > > well.
> > > 
> > > 
> > > NOTES/TODO
> > > ----------
> > > 
> > >   - the CPR handling to support resetting of confidential VMs is
> > >     currently disabled when in-place conversion is enabled.
> > >   - TDX testing would be great, in theory it can be enabled with this
> > >     series (similarly to the top patch) but I'm not sure if there are
> > >     other special requirements before we can switch it on.
> > >   - kernel patches are still in-flight, but fairly mature at this point
> > >     and nearing upstream
> > > 
> > > 
> > > REFERENCES
> > > ----------
> > > 
> > > [1] https://lore.kernel.org/kvm/20250729225455.670324-1-seanjc@google.com/
> > > [2] https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/
> > > [3] https://www.youtube.com/watch?v=MMfAGNW9RVg
> > > [4] 1GB hugetlb v2
> > > 
> > > 
> > > Thoughts, feedback, and testing are very much appreciated.
> > > 
> > > Thanks,
> > > 
> > > Mike
> > > 
> > > 
> > > ----------------------------------------------------------------
> > > Michael Roth (12):
> > >       accel/kvm: Decouple guest_memfd checks from memory attribute checks
> > >       hostmem: Introduce dedicated memory backend for guest_memfd
> > >       linux-headers: Update headers for v7 of in-place conversion kernel support
> > >       accel/kvm: Add CGS option to control in-place conversion support
> > >       system/memory: Re-use memory-backend-guest-memfd inode for private memory
> > >       system/memory: Default to guest_memfd for RAM for in-place conversion
> > >       accel/kvm: Move post-conversion updates to a separate helper
> > >       accel/kvm: Re-order attribute notifications for in-place conversion
> > >       accel/kvm: Support shared/private conversions via guest_memfd ioctls
> > >       accel/kvm: Don't default to private attributes for in-place conversion
> > >       i386/sev: Update SNP_LAUNCH_UPDATE for in-place conversion
> > >       i386/sev: Allow in-place conversion for SEV-SNP guests
> > > 
> > >  accel/kvm/kvm-all.c                                | 286 +++++++++++--
> > >  accel/stubs/kvm-stub.c                             |   9 +-
> > >  backends/confidential-guest-support.c              |  25 ++
> > >  backends/hostmem-guest-memfd.c                     |  93 +++++
> > >  backends/meson.build                               |   1 +
> > >  include/standard-headers/drm/drm_fourcc.h          |  28 +-
> > >  include/standard-headers/linux/const.h             |  18 +
> > >  include/standard-headers/linux/ethtool.h           |  28 +-
> > >  include/standard-headers/linux/input-event-codes.h |  13 +
> > >  include/standard-headers/linux/pci_regs.h          |  71 +++-
> > >  include/standard-headers/linux/typelimits.h        |   8 +
> > >  include/standard-headers/linux/virtio_ring.h       |   5 +-
> > >  include/standard-headers/linux/virtio_rtc.h        | 237 +++++++++++
> > >  include/standard-headers/linux/vmclock-abi.h       |  20 +
> > >  include/system/confidential-guest-support.h        |  14 +
> > >  include/system/hostmem.h                           |   1 +
> > >  include/system/kvm.h                               |   3 +-
> > >  include/system/memory.h                            |   8 +-
> > >  linux-headers/asm-arm64/kvm.h                      |   1 +
> > >  linux-headers/asm-arm64/unistd_64.h                |   1 +
> > >  linux-headers/asm-generic/unistd.h                 |   5 +-
> > >  linux-headers/asm-loongarch/kvm.h                  |   5 +
> > >  linux-headers/asm-loongarch/kvm_para.h             |   1 +
> > >  linux-headers/asm-loongarch/unistd_64.h            |   2 +
> > >  linux-headers/asm-mips/unistd_n32.h                |   1 +
> > >  linux-headers/asm-mips/unistd_n64.h                |   1 +
> > >  linux-headers/asm-mips/unistd_o32.h                |   1 +
> > >  linux-headers/asm-powerpc/unistd_32.h              |   1 +
> > >  linux-headers/asm-powerpc/unistd_64.h              |   1 +
> > >  linux-headers/asm-riscv/kvm.h                      |  11 +-
> > >  linux-headers/asm-riscv/ptrace.h                   |  37 ++
> > >  linux-headers/asm-riscv/unistd_32.h                |   1 +
> > >  linux-headers/asm-riscv/unistd_64.h                |   1 +
> > >  linux-headers/asm-s390/unistd_32.h                 | 446 ---------------------
> > >  linux-headers/asm-s390/unistd_64.h                 |   1 +
> > >  linux-headers/asm-x86/kvm.h                        |  21 +-
> > >  linux-headers/asm-x86/unistd_32.h                  |   1 +
> > >  linux-headers/asm-x86/unistd_64.h                  |   1 +
> > >  linux-headers/asm-x86/unistd_x32.h                 |   1 +
> > >  linux-headers/linux/const.h                        |  18 +
> > >  linux-headers/linux/iommufd.h                      |  48 +++
> > >  linux-headers/linux/kvm.h                          |  62 ++-
> > >  linux-headers/linux/mshv.h                         |   4 +-
> > >  linux-headers/linux/psp-sev.h                      |   2 +-
> > >  linux-headers/linux/stddef.h                       |   4 +
> > >  linux-headers/linux/vduse.h                        |  85 +++-
> > >  linux-headers/linux/vfio.h                         |  30 +-
> > >  qapi/qom.json                                      |  35 +-
> > >  qemu-options.hx                                    |   5 +
> > >  system/memory.c                                    |  22 +-
> > >  system/physmem.c                                   |  50 ++-
> > >  target/i386/sev.c                                  |  12 +-
> > >  52 files changed, 1253 insertions(+), 533 deletions(-)
> > >  create mode 100644 backends/hostmem-guest-memfd.c
> > >  create mode 100644 include/standard-headers/linux/typelimits.h
> > >  create mode 100644 include/standard-headers/linux/virtio_rtc.h
> > >  delete mode 100644 linux-headers/asm-s390/unistd_32.h
> > > 
