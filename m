Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663184D7D5A
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352250; cv=none; b=kaLrtY+ShlJ/7MUp71HB7VSvgYCaUa9qAyLSLz4ydGnysaiEK9r7lWv41Re7VuCPvTOYnqLI7d7SFk/8VYp6zqVNRVt24h94YwytWufAxL2aI2nrH79U7vew7v6BMTWRwgU9wySHlnfCGngsy3aC94wX5U5hcFj9w7nBthXY85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352250; c=relaxed/simple;
	bh=vMYXJiN4wozVvK0QVEIssopj/SVbqP6pLH/wIHxT+ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMMJpZenbgS5K8XKSFjuP6UNxFEqdJHMdfdidfMU7331VmrA0H+VJKI99jJha+qX2Zol2X9c0viWfnMFsLSQidgqzmOd4FwQw3E/TvR1AqAogHU0KBpm0g8sbBClNy9PlNwYLU+sL3/koD1T1AJhzydTk7w5k4IJxZqpRD157OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omtRSAWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omtRSAWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822B71F000FF;
	Fri, 25 Sep 2026 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790352248;
	bh=7VMcO05t+EmQUene7zWg2zftst5DVaGzFSjsbUQIws4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=omtRSAWCvx68t1e4vSrMKlEhFnF77b++zeSwaCgBpMPh20yaX6VjLbIMwgKw0Id0A
	 a3rkYsVFVGq3zhd0FD2pbTu1MHQT64EzH03qMG3mULepz++zJqK8qpqcTAvqACf/Ym
	 tYhpNcFImK0K4wTojhsk20K2ehJI/6pDOuQtW95a68GZN4E7/kywluemvHxFXrBJpG
	 0BjJxIPe3iGzi927gN37dyZmpKcCshKgURlrTryliUTqQr77zDxbTNC4bo7YT8GvkU
	 BlIbEqqUNmDlaab5Bcjtpzfig3y+ShMTpU/5mJfhX6n4VVJ5BjqoMwHPSli8+DL70t
	 iC/EWIGiWWYCQ==
Date: Fri, 25 Sep 2026 11:03:49 -0500
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <arabZS5cIkPgw6ef@shallyn-amd>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831071304.762939-1-tony.lindgren@linux.intel.com>

On Mon, Aug 31, 2026 at 10:13:00AM +0300, Tony Lindgren wrote:
> Hi all,
> 
> As discussed in a recent PUCK call, Sean suggested we post what Intel is
> using for the KVM live migration API for TDX as an example to see if we
> can come up with APIs that are not vendor specific.
> 
> The goal of this patch series is to start a discussion about live migration
> kernel APIs for CoCo guests.
> 
> Tom, since you mentioned that AMD SEV-SNP and Intel TDX live migration
> sound similar, can you please take a look how the API might work for
> SEV-SNP?
> 
> For CoCo VMs, the guest memory and vCPU states are not accessible to the
> userspace or KVM for live migration. The memory and vCPU states need to be
> extracted into encrypted blobs on the source, and decrypted on the
> destination. Before live migration, an encryption key needs to be
> negotiated between the source and destination.
> 
> The layer handling the encryption for live migration is implementation
> specific. It can be the TDX module or Coconut-SVSM for example.
> 
> For CoCo VMs, the KVM_MEMORY_ENCRYPT_OP ioctl() has been used with vendor
> specific sub-commands. Adding more vendor specific sub-commands is an
> option also for live migration. However, depending on how similar the KVM
> needs are, it may be possible to have a common API.
> 
> For TDX, we're using a group of ioctl()s that might be possible to adapt
> also for other CoCo implementations.
> 
> Artem has put together a brief description below of the example API and the
> migration flow:

Hi Tony,

is there any pubically available qemu git branch or patchset to show
how you currently are driving this?

> Example API
> ===========
> 
> - KVM_CAP_LIVE_MIGRATION - if a VM supports live migration through this
>   uAPI.
> - KVM_MIGRATE_CMD - the main ioctl that drives the migration phases. Each
>   command takes vendor-specific flags and a buffer for the blob that travels
>   between the hosts.
>   - KVM_MIGRATE_SETUP - establish the migration session and transfer the
>     immutable VM state.
>   - KVM_MIGRATE_ITERATION - close a memory copy round.
>   - KVM_MIGRATE_STOP_AND_COPY - pause the VM and transfer the remaining VM
>     state.
>   - KVM_MIGRATE_END - complete the migration, or abort it.
> - KVM_EXPORT_MEMORY - export memory pages on the source host.
> - KVM_IMPORT_MEMORY - import memory pages on the destination host.
> - KVM_EXPORT_VCPU - export vCPU state on the source host.
> - KVM_IMPORT_VCPU - import vCPU state on the destination host.
> 
> Dirty page tracking does not add a new uAPI. Userspace keeps using
> KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.
> 
> Migration flow
> ==============
> 
>  Source host                                      Destination host
>  ===========                                      ================
> 
>  CMD(SETUP/SESSION)          <--- setup msgs ---> CMD(SETUP/SESSION)
>        |    (repeated)                                  |
>  CMD(SETUP/IMMUTABLE_STATE)  - immutable state -> CMD(SETUP/IMMUTABLE_STATE)
>        |                                                |
>  KVM_GET_DIRTY_LOG                                      |
>  KVM_EXPORT_MEMORY           --- memory data ---> KVM_IMPORT_MEMORY
>  CMD(ITERATION)              --- epoch token ---> CMD(ITERATION)
>        |    (repeat until convergence)                  |
>  CMD(STOP_AND_COPY/PAUSE)                               |
>  CMD(STOP_AND_COPY/TD_STATE) --- VM state ------> CMD(STOP_AND_COPY/TD_STATE)
>  KVM_EXPORT_VCPU             --- vCPU state ----> KVM_IMPORT_VCPU
>  KVM_EXPORT_MEMORY           -- final memory ---> KVM_IMPORT_MEMORY
>  CMD(ITERATION/DONE)         --- start token ---> CMD(ITERATION)
>        |                                                |
>  CMD(END)                                         CMD(END)
> 
> For the TDX implementation, the above map to the TDX module SEAMCALLs.
> 
> Regards,
> 
> Tony
> 
> Changes since v1 at [0] below:
> 
> - Drop KVM_MIGRATE_CMD sub-command PREPARE, SETUP sub-command has been
>   enough for TDX at least
> 
> - Rename KVM_MIGRATE_CMD sub-command KVM_MIGRATE_TOKEN to
>   KVM_MIGRATE_ITERATION
> 
> - Rename KVM_MIGRATE_CMD sub-command KVM_MIGRATE_SOURCE_BLACKOUT to
>   KVM_MIGRATE_STOP_AND_COPY
> 
> - Add x86 ioctl handling
> 
> [0] https://lore.kernel.org/kvm/20251006113524.1573116-1-tony.lindgren@linux.intel.com/
> 
> 
> Tony Lindgren (4):
>   Documentation: KVM: Add live migration API for confidential guests
>   KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION and KVM_MIGRATE_CMD
>   KVM: x86: Add optional KVM_EXPORT_MEMORY and KVM_IMPORT_MEMORY
>   KVM: x86: Add optional KVM_EXPORT_VCPU and KVM_IMPORT_VCPU
> 
>  Documentation/virt/kvm/api.rst     | 205 +++++++++++++++++++++++++++++
>  arch/x86/include/asm/kvm-x86-ops.h |   6 +
>  arch/x86/include/asm/kvm_host.h    |   6 +
>  arch/x86/kvm/x86.c                 | 102 ++++++++++++++
>  include/uapi/linux/kvm.h           |  43 ++++++
>  5 files changed, 362 insertions(+)
> 
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> -- 
> 2.43.0
> 
