Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581B3AEF46
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961331; cv=none; b=OI0NN/cujR1jPNAFskTp1iFvbce9FeY4n6PiWwcFU/juVrbdMcTHBZQeAC4ESrlNgiMVfJ4FB4Zx10ODUJIyYdRHpO5Qqu0vvBrkjT33QpnJALz4PjwBEFBQtTC9MdfiIqiaZTHtrDl5O86fsxxgFSLekuGl2X6VCg8olmoLj3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961331; c=relaxed/simple;
	bh=O/xNBL1lFnlrFZEUcSb88lJibJ0mr+kRo4zwFbNpyvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGRZls+4wALLCPPmB33MNDxWnjKgUxjvZ9MBIih2uk2M/JpCWmlkb8F2xkJkZzI13Kx0XG8Q2CDPmQZLd45ajUGw7yGuo04fIO11iGg87+uGxp8sZryIjFRSkOQka3ahiIdbUxdQ/vhF0izaMZbGxt1DiOcrtfuEJEpjMOlxAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhRx1XoA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhRx1XoA"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a871daa98fso427125ad.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773961329; x=1774566129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtVhzb0DV85uGcvAl9P82/7gTaMXIzZ0xIhVOg4FCYk=;
        b=lhRx1XoAT6IysHvHm+M9iPS/NSLmzHdGGEzwGqDwK/ioai3bRItaR9BbZ2RD4D2sId
         Z0AjaTlr9ACRJSXx20YvKsqmSQbt1ozsb7F2Y5yTaqPF5y3GE9850RJ88s1FjIvYTLxp
         90pkH/yNf0mdRTk2tSHM9wfCFcqODGEJJxffei2ndNakhJhVkQtZ9ca30LLJPA9J8XzP
         dZHS2fABcTB+1F83xyrfS2v0jpsXPpJKJ409Sm+IPms69C8nvPVBXuivZAMbg8rYzMMY
         y3R4nWgUyjUiQZamjZy3v/4DawiamNBRh7hBHS2gDo1Rh0eWn8YiemNm7z6k2iIQTyST
         aXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773961329; x=1774566129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtVhzb0DV85uGcvAl9P82/7gTaMXIzZ0xIhVOg4FCYk=;
        b=UDugy7uBeYuCcvEGKxeVrHbvGy62kTnCP5I0o8MFQj49Z5FXnyBAA0x3axzaZVNJx9
         agCv3ixqzQbaoKUbEEfhzwtRlJW3QXEdHxZD00Q66+ip69GyB16QOyK4jXOveWAY0qFS
         uGZLVuTWz/v+MllLNNAi0FTirBrXLFIpbBndeaBt2ZqgmqNDUHNhgdvGhaV3YzmAU0c2
         rSfSSo3s/U5iUcay2VZHswOhk8Wt7n785XhQSRsw97UPm4P1GG/SNBQtWF+/EC/0wvU0
         7tptQqOYxEZtdd7lsQ/jt4PNo9WLKI1BehC8XAZpKzPO0ojVV2v6tP0/55kwK25KKIGn
         JkxA==
X-Gm-Message-State: AOJu0YzYTQqbETAKXDqQQfZsGRIKkhvT+e47Tx++DTYPCvndDYaf0X5Q
	nmhXCt34O5OfDD+bgkx46I5Dg2uHaHLgaY8uaeEx01DDxA1NEBhd47mYxZNE5Uzl3sY=
X-Gm-Gg: ATEYQzwww8T+y8pBA0IC9HpsEJP0rtfBczxJofdw0Ekk0O8cUxkg6wCFZU86BOFLS6G
	rNBQspPRhYVhZvpBBakbT8C4Sf9M8/bFfY4hYnjy0+WtJDfiH1JMdDbaO3U10TaHcKGh0BTGlVP
	o9J3WworiTh3ze2xrAtOT2h022bb26hp0EcXaP9bxGQaQo4pwOAu8QmRr4evsUZn1WhIaKyV625
	PJOnfSpWx5OWJRt1bSqsf1RoblYFPud5utpUt7VasKHtEMk8Q+PS4WJ42accXH0ewvbYHHa/KIW
	4UZq9BO5gBC40RoO2fWW53sbEFPaiADm+E1c7DyB398RhTokMC0oiHPkWN5YIbRt7fW+AFbh9/O
	aYL1dNa8ylASOC4Svioc++0MPjasOeEkwQQzgz0AMv3nTTZGlgqK/ftzAwB1BhrGZaMzfVlI/RC
	oQZk/Wv8E59gtGZHwm+Br4ywgNdSXdniqvoPqwVg==
X-Received: by 2002:a17:902:d582:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2b08278b1b3mr7031995ad.30.1773961328468;
        Thu, 19 Mar 2026 16:02:08 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:bc0d:d18f:b06e:7b15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836ace98sm2468535ad.80.2026.03.19.16.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 16:02:07 -0700 (PDT)
Date: Thu, 19 Mar 2026 17:02:04 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Emi Kisanuki <fj0570is@fujitsu.com>,
	Vishal Annapurve <vannapurve@google.com>
Subject: Re: [PATCH v13 00/48] arm64: Support for Arm CCA in KVM
Message-ID: <abyAbPIkDn2bGZwd@p14s>
References: <20260318155413.793430-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318155413.793430-1-steven.price@arm.com>

Good day,

On Wed, Mar 18, 2026 at 03:53:24PM +0000, Steven Price wrote:
> This series adds support for running protected VMs using KVM under the
> Arm Confidential Compute Architecture (CCA).
> 
> New major version number! This now targets RMM v2.0-bet0[1]. And unlike
> for Linux this represents a significant change.
> 
> RMM v2.0 brings with it the ability to configure the RMM to have the
> same page size as the host (so no more RMM_PAGE_SIZE and dealing with
> granules being different from host pages). It also introduces range
> based APIs for many operations which should be more efficient and
> simplifies the code in places.
> 
> The handling of the GIC has changed, so the system registers are used to
> pass the GIC state rather than memory. This means fewer changes to the
> KVM code as it looks much like a normal VM in this respect.
> 
> And of course the new uAPI introduced in the previous v12 posting is
> retained so that also remains simplified compared to earlier postings.
> 
> The RMM support for v2.0 is still early and so this series includes a
> few hacks to ease the integration. Of note are that there are some RMM
> v1.0 SMCs added to paper over areas where the RMM implementation isn't
> quite ready for v2.0, and "SROs" (see below) are deferred to the final
> patch in the series.
> 
> The PMU in RMM v2.0 requires more handling on the RMM-side (and
> therefore simplifies the implementation on Linux), but this isn't quite
> ready yet. The Linux side is implemented (but untested).
> 
> PSCI still requires the VMM to provide the "target" REC for operations
> that affect another vCPU. This is likely to change in a future version
> of the specification. There's also a desire to force PSCI to be handled
> in the VMM for realm guests - this isn't implemented yet as I'm waiting
> for the dust to settle on the RMM interface first.
> 
> Stateful RMI Operations
> -----------------------
> 
> The RMM v2.0 spec brings a new concept of Stateful RMI Operations (SROs)
> which allow the RMM to complete an operation over several SMC calls and
> requesting/returning memory to the host. This has the benefit of
> allowing interrupts to be handled in the middle of an operation (by
> returning to the host to handle the interrupt without completing the
> operation) and enables the RMM to dynamically allocate memory for
> internal tracking purposes. One example of this is RMI_REC_CREATE no
> longer needs "auxiliary granules" provided upfront but can request the
> memory needed during the RMI_REC_CREATE operation.
> 
> There are a fairly large number of operations that are defined as SROs
> in the specification, but current both Linux and RMM only have support
> for RMI_REC_CREATE and RMI_REC_DESTROY. There a number of TODOs/FIXMEs
> in the code where support is missing.
> 
> Given the early stage support for this, the SRO handling is all confined
> to the final patch. This patch can be dropped to return to a pre-SRO
> state (albeit a mixture of RMM v1.0 and v2.0 APIs) for testing purposes.
> 
> A future posting will reorder the series to move the generic SRO support
> to an early patch and will implement the proper support for this in all
> RMI SMCs.
> 
> One aspect of SROs which is not yet well captured is that in some
> circumstances the Linux kernel will need to call an SRO call in a
> context where memory allocation is restricted (e.g. because a spinlock
> is held). In this case the intention is that the SRO will be cancelled,
> the spinlock dropped so the memory allocation can be completed, and then
> the SRO restarted (obviously after rechecking the state that the
> spinlock was protecting). For this reason the code stores the memory
> allocations within a struct rmi_sro_state object - see the final patch
> for more details.
> 
> This series is based on v7.0-rc1. It is also available as a git
> repository:
> 
> https://gitlab.arm.com/linux-arm/linux-cca cca-host/v13
> 
> Work in progress changes for kvmtool are available from the git
> repository below:
> 
> https://gitlab.arm.com/linux-arm/kvmtool-cca cca/v11
> 
> Note that the kvmtool code has been tidied up (thanks to Suzuki) and
> this involves a minor change in flags. The "--restricted_mem" flag is no
> longer recognised (or necessary).
> 
> The TF-RMM has not yet merged the RMMv2.0 support, so you will need to
> use the following branch:
> 
> https://git.trustedfirmware.org/TF-RMM/tf-rmm.git topics/rmm-v2.0-poc

This RMM version is expecting a RMM EL3 interface version of at least 2.0.  Do
you have a TF-A to use with it?

Thanks,
Mathieu

> 
> [1] https://developer.arm.com/documentation/den0137/2-0bet0/
> 
> Jean-Philippe Brucker (7):
>   arm64: RMI: Propagate number of breakpoints and watchpoints to
>     userspace
>   arm64: RMI: Set breakpoint parameters through SET_ONE_REG
>   arm64: RMI: Initialize PMCR.N with number counter supported by RMM
>   arm64: RMI: Propagate max SVE vector length from RMM
>   arm64: RMI: Configure max SVE vector length for a Realm
>   arm64: RMI: Provide register list for unfinalized RMI RECs
>   arm64: RMI: Provide accurate register list
> 
> Joey Gouly (2):
>   arm64: RMI: allow userspace to inject aborts
>   arm64: RMI: support RSI_HOST_CALL
> 
> Steven Price (36):
>   kvm: arm64: Avoid including linux/kvm_host.h in kvm_pgtable.h
>   arm64: RME: Handle Granule Protection Faults (GPFs)
>   arm64: RMI: Add SMC definitions for calling the RMM
>   arm64: RMI: Temporarily add SMCs from RMM v1.0 spec
>   arm64: RMI: Add wrappers for RMI calls
>   arm64: RMI: Check for RMI support at KVM init
>   arm64: RMI: Configure the RMM with the host's page size
>   arm64: RMI: Check for LPA2 support
>   arm64: RMI: Ensure that the RMM has GPT entries for memory
>   arm64: RMI: Define the user ABI
>   arm64: RMI: Basic infrastructure for creating a realm.
>   KVM: arm64: Allow passing machine type in KVM creation
>   arm64: RMI: RTT tear down
>   arm64: RMI: Activate realm on first VCPU run
>   arm64: RMI: Allocate/free RECs to match vCPUs
>   arm64: RMI: Support for the VGIC in realms
>   KVM: arm64: Support timers in realm RECs
>   arm64: RMI: Handle realm enter/exit
>   arm64: RMI: Handle RMI_EXIT_RIPAS_CHANGE
>   KVM: arm64: Handle realm MMIO emulation
>   KVM: arm64: Expose support for private memory
>   arm64: RMI: Allow populating initial contents
>   arm64: RMI: Set RIPAS of initial memslots
>   arm64: RMI: Create the realm descriptor
>   arm64: RMI: Runtime faulting of memory
>   KVM: arm64: Handle realm VCPU load
>   KVM: arm64: Validate register access for a Realm VM
>   KVM: arm64: Handle Realm PSCI requests
>   KVM: arm64: WARN on injected undef exceptions
>   arm64: Don't expose stolen time for realm guests
>   arm64: RMI: Always use 4k pages for realms
>   arm64: RMI: Prevent Device mappings for Realms
>   arm64: RMI: Enable PMU support with a realm guest
>   KVM: arm64: Expose KVM_ARM_VCPU_REC to user space
>   arm64: RMI: Enable realms to be created
>   [WIP] arm64: RMI: Add support for SRO
> 
> Suzuki K Poulose (3):
>   kvm: arm64: Include kvm_emulate.h in kvm/arm_psci.h
>   kvm: arm64: Don't expose unsupported capabilities for realm guests
>   arm64: RMI: Allow checking SVE on VM instance
> 
>  Documentation/virt/kvm/api.rst       |   86 +-
>  arch/arm64/include/asm/kvm_emulate.h |   31 +
>  arch/arm64/include/asm/kvm_host.h    |   15 +-
>  arch/arm64/include/asm/kvm_pgtable.h |    5 +-
>  arch/arm64/include/asm/kvm_pkvm.h    |    2 +-
>  arch/arm64/include/asm/kvm_rmi.h     |  129 ++
>  arch/arm64/include/asm/rmi_cmds.h    |  692 +++++++++
>  arch/arm64/include/asm/rmi_smc.h     |  430 ++++++
>  arch/arm64/include/asm/virt.h        |    1 +
>  arch/arm64/kernel/cpufeature.c       |    1 +
>  arch/arm64/kvm/Kconfig               |    2 +
>  arch/arm64/kvm/Makefile              |    2 +-
>  arch/arm64/kvm/arch_timer.c          |   28 +-
>  arch/arm64/kvm/arm.c                 |  178 ++-
>  arch/arm64/kvm/guest.c               |   95 +-
>  arch/arm64/kvm/hyp/pgtable.c         |    1 +
>  arch/arm64/kvm/hypercalls.c          |    4 +-
>  arch/arm64/kvm/inject_fault.c        |    5 +-
>  arch/arm64/kvm/mmio.c                |   16 +-
>  arch/arm64/kvm/mmu.c                 |  214 ++-
>  arch/arm64/kvm/pmu-emul.c            |    6 +
>  arch/arm64/kvm/psci.c                |   30 +
>  arch/arm64/kvm/reset.c               |   13 +-
>  arch/arm64/kvm/rmi-exit.c            |  207 +++
>  arch/arm64/kvm/rmi.c                 | 1948 ++++++++++++++++++++++++++
>  arch/arm64/kvm/sys_regs.c            |   53 +-
>  arch/arm64/kvm/vgic/vgic-init.c      |    2 +-
>  arch/arm64/mm/fault.c                |   28 +-
>  include/kvm/arm_arch_timer.h         |    2 +
>  include/kvm/arm_pmu.h                |    4 +
>  include/kvm/arm_psci.h               |    2 +
>  include/uapi/linux/kvm.h             |   41 +-
>  32 files changed, 4176 insertions(+), 97 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kvm_rmi.h
>  create mode 100644 arch/arm64/include/asm/rmi_cmds.h
>  create mode 100644 arch/arm64/include/asm/rmi_smc.h
>  create mode 100644 arch/arm64/kvm/rmi-exit.c
>  create mode 100644 arch/arm64/kvm/rmi.c
> 
> -- 
> 2.43.0
> 
> 
