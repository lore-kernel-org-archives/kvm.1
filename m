Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FB362130
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853521; cv=none; b=APQ6x2GRPObtdCVbZ9RQMn8M2OzZKJ7ohUqT4tCctMHXP6HDpik6rEjhvNl13vrOi/Zvv2V/EXY1NFw3cnNPqcEGCXj9IK3roygzJbjsJ4o4Qpy8PUfOJ61jgIIT6u5xz/xwix5iEMJDLWduWRgCbdGQOYFGnUElPbA0IYRWi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853521; c=relaxed/simple;
	bh=QgQ0IcYUI/mtt+y1ANpQvqwtmD6pY6Cq4ZVA2i5QQEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdpC8/kHT3kpTZYXDOeYz3WvkRbBBxjXNWujK6ysHdu0KH/HQ3QhNj3dmHyuZPquOx2IFswXp9Mf+d8Hq408vFemR8siMOzg+WPDETejKI5iCF0qN35Aqnfx35nQJlfQdJYCfsTM7LapwY9CM5VYahB2QGW++z0ue3e9IVURaJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZpWy5Mxb; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZpWy5Mxb"
X-Gm-Message-State: AOJu0YxGid3KJuWIK4zLRsTcxOkbuyRfXLxvEX1GVeSiEaYoYponI8T2
	Py/F1uRP7koY4IboOztvFVemnDcJhJegvUn+S+kyqPL71R5kRI1hRssX6vq/CoENi5B5Nex1OI+
	ZzAX4m6gWkOu8K+AOi8OHhG1KANn0kzN9HOvwQ+Tv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785853504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIcOFle/zwz16Xg1hcnb8SPakGcZDbwDo5/3Sec2GL4=;
	b=ZpWy5MxbQQuUjfnAADWWz003PQpeN3wNo3lmcANeryWZ6XWnBueEFE4CoEuA7LO2KGMEWM
	N2Dnflkr7YbuRsdfWAHMT3/HSbDp4OYqJ7Fs489JEoDiaunFAuNUyO/n7mCGgkhhED0Im/
	d1acuS353ugWzEqcXkwxRAmRje4c5d4=
X-Received: by 2002:a05:622a:550c:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52ce3f651e3mr1750781cf.1.1785853486200; Tue, 04 Aug 2026
 07:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803134403.80630-1-steven.price@arm.com>
In-Reply-To: <20260803134403.80630-1-steven.price@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 4 Aug 2026 15:24:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTy4tpv+d7Q0H1Coe4PXAFrvHc8_fiOyv8GXdo7y7CNMdA@mail.gmail.com>
X-Gm-Features: AUfX_mxdVEoiKGsOFqc7silG1XiAgRiraJnJQa_4blZVDkZkFRMAqMHa_QhDxGw
Message-ID: <CA+EHjTy4tpv+d7Q0H1Coe4PXAFrvHc8_fiOyv8GXdo7y7CNMdA@mail.gmail.com>
Subject: Re: [PATCH v16 00/45] arm64: Support for Arm CCA in KVM
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi Steven,

On Mon, 3 Aug 2026 at 14:44, Steven Price <steven.price@arm.com> wrote:
...
>  * Rewrite Realm entry and exit handling to fit into the generic KVM
>    run loop. Work which cannot be performed in the entry path is now
>    completed through KVM requests, and MMIO, PSCI, RIPAS changes and
>    host calls are adapted to the new flow.

Reading v16 with pKVM in mind: this rework helps, but the series still
adds a few kvm_is_realm()/vcpu_is_rec() checks to the core arm64 code,
and several sit next to, or inside the same condition as, the existing
pKVM checks (the nommu path in kvm_arch_vcpu_load(), the timer
offsets, the NISV abort injection). Both checks answer the same
question: is the guest's state owned by something other than KVM. It
might be worth a common predicate covering both.

Cheers,
/fuad



>
>  * Rewrite Realm timer support to use KVM's IRQ-ops infrastructure and
>    software resampling.
>
>  * Improve SRO cancellation and error handling. Ensure a cancelled
>    operation isn't treated as successful, wrapper return values can carry
>    negative Linux errors as well as RMI return values, and those errors
>    are propagated through the KVM users.
>
>  * Check that the RMM supports the host page size before configuring it,
>    and exclude firmware-reserved NOMAP memory when creating GPT entries.
>
>  * Expand the KVM_ARM_RMI_POPULATE documentation to make clear that Arm
>    CCA cannot preserve memory contents during an in-place
>    shared-to-private conversion.
>
>  * Allocate Realm parameters only while creating the Realm descriptor.
>
>  * Document the encoding of the arm64 VM types and require
>    ICH_HCR_EL2.TDIR before advertising or creating Realm VMs.
>
> This series is based on the guest_memfd in-place conversion v9 tree[1],
> which is itself based on kvm-x86/next. It is also available as a git
> repository:
>
> https://gitlab.arm.com/linux-arm/linux-cca cca-host/v16
>
> Work in progress changes for kvmtool are available from the git
> repository below:
>
> https://gitlab.arm.com/linux-arm/kvmtool-cca cca/v13
>
> The TF-RMM branch used for testing this series is available here:
>
> https://git.trustedfirmware.org/TF-RMM/tf-rmm.git topics/rmm-v2.0-poc_3
>
> There is a kvm-unit-test branch updated to support the attestation used
> in RMM v2.0 available here:
>
> https://gitlab.arm.com/linux-arm/kvm-unit-tests-cca cca/v4
>
> [0] https://developer.arm.com/documentation/den0137/2-0bet2/
> One bet2 change, which moves metadata out of the individual address
> range descriptors, has intentionally not been implemented because that
> part of the specification is expected to be reverted.
>
> [1] https://github.com/googleprodkernel/linux-cc/commits/guest_memfd-inplace-conversion-v9
>
> Jean-Philippe Brucker (6):
>   KVM: arm64: CCA: Propagate breakpoint and watchpoint counts to
>     userspace
>   KVM: arm64: CCA: Set breakpoint parameters through SET_ONE_REG
>   KVM: arm64: CCA: Propagate max SVE vector length from the RMM
>   KVM: arm64: CCA: Configure max SVE vector length for a Realm
>   KVM: arm64: CCA: Provide register list for unfinalized RECs
>   KVM: arm64: CCA: Provide an accurate register list
>
> Joey Gouly (2):
>   KVM: arm64: CCA: Allow userspace to inject aborts
>   KVM: arm64: CCA: Support RSI_HOST_CALL
>
> Steven Price (34):
>   firmware: arm_rmm: Add SMC definitions for calling the RMM
>   firmware: arm_rmm: Add wrappers for direct RMI calls
>   firmware: arm_rmm: Check for RMI support at init
>   firmware: arm_rmm: Configure the RMM with the host's page size
>   firmware: arm_rmm: Add support for SRO
>   firmware: arm_rmm: Ensure the RMM has GPT entries for memory
>   arm64: mm: Handle Granule Protection Faults (GPFs)
>   KVM: arm64: Avoid including linux/kvm_host.h in kvm_pgtable.h
>   KVM: arm64: CCA: Add wrappers for realm related RMIs
>   KVM: arm64: CCA: Check for RMI support at KVM init
>   KVM: arm64: CCA: Check for LPA2 support
>   KVM: arm64: CCA: Define the user ABI
>   KVM: arm64: CCA: Add basic infrastructure for creating a realm
>   KVM: arm64: CCA: Allow passing the machine type in KVM creation
>   KVM: arm64: CCA: Tear down RTTs
>   KVM: arm64: CCA: Allocate and free RECs to match vCPUs
>   KVM: arm64: CCA: Support the VGIC in realms
>   KVM: arm64: CCA: Support timers in realm RECs
>   KVM: arm64: CCA: Handle realm enter/exit
>   KVM: arm64: CCA: Handle RMI_EXIT_RIPAS_CHANGE
>   KVM: arm64: CCA: Handle realm MMIO emulation
>   KVM: arm64: Expose support for private memory
>   KVM: arm64: CCA: Create the realm descriptor
>   KVM: arm64: CCA: Activate realms on first vCPU run
>   KVM: arm64: CCA: Allow populating initial contents
>   KVM: arm64: CCA: Set RIPAS of initial memslots
>   KVM: arm64: CCA: Support runtime faulting of memory
>   KVM: arm64: CCA: Handle realm vCPU load
>   KVM: arm64: CCA: Validate register access for Realm VMs
>   KVM: arm64: CCA: Handle Realm PSCI requests
>   KVM: arm64: WARN on injected undef exceptions
>   KVM: arm64: CCA: Prevent Device mappings for realms
>   KVM: arm64: CCA: Require ICH_HCR_EL2.TDIR for realms
>   KVM: arm64: CCA: Enable realms to be created
>
> Suzuki K Poulose (3):
>   KVM: arm64: Include kvm_emulate.h in kvm/arm_psci.h
>   KVM: arm64: CCA: Don't expose unsupported capabilities for realm
>     guests
>   KVM: arm64: CCA: Allow checking SVE on VM instance
>
>  Documentation/virt/kvm/api.rst       |   70 +-
>  arch/arm64/Kconfig                   |    1 +
>  arch/arm64/include/asm/kvm_asm.h     |    2 +
>  arch/arm64/include/asm/kvm_emulate.h |   37 +
>  arch/arm64/include/asm/kvm_host.h    |   12 +-
>  arch/arm64/include/asm/kvm_pgtable.h |    6 +-
>  arch/arm64/include/asm/kvm_pkvm.h    |    2 +-
>  arch/arm64/include/asm/kvm_rmi.h     |  139 +++
>  arch/arm64/include/asm/rmi_cmds.h    |  465 ++++++++
>  arch/arm64/include/asm/virt.h        |    1 +
>  arch/arm64/kernel/cpufeature.c       |    1 +
>  arch/arm64/kvm/Kconfig               |    2 +
>  arch/arm64/kvm/Makefile              |    2 +-
>  arch/arm64/kvm/arch_timer.c          |   34 +-
>  arch/arm64/kvm/arm.c                 |  139 ++-
>  arch/arm64/kvm/guest.c               |   93 +-
>  arch/arm64/kvm/handle_exit.c         |   14 +
>  arch/arm64/kvm/hyp/pgtable.c         |    1 +
>  arch/arm64/kvm/hypercalls.c          |    4 +-
>  arch/arm64/kvm/inject_fault.c        |    5 +-
>  arch/arm64/kvm/mmio.c                |   16 +-
>  arch/arm64/kvm/mmu.c                 |  144 ++-
>  arch/arm64/kvm/reset.c               |   13 +-
>  arch/arm64/kvm/rmi-exit.c            |  178 +++
>  arch/arm64/kvm/rmi.c                 | 1561 ++++++++++++++++++++++++++
>  arch/arm64/kvm/sys_regs.c            |   47 +-
>  arch/arm64/kvm/vgic/vgic-init.c      |    2 +-
>  arch/arm64/mm/fault.c                |   28 +-
>  drivers/firmware/Kconfig             |    1 +
>  drivers/firmware/Makefile            |    1 +
>  drivers/firmware/arm_rmm/Kconfig     |   26 +
>  drivers/firmware/arm_rmm/Makefile    |    2 +
>  drivers/firmware/arm_rmm/rmi.c       |  776 +++++++++++++
>  include/kvm/arm_psci.h               |    2 +
>  include/linux/arm-rmi-cmds.h         |  201 ++++
>  include/linux/arm-smccc-rmi.h        |  493 ++++++++
>  include/uapi/linux/kvm.h             |   20 +-
>  37 files changed, 4446 insertions(+), 95 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kvm_rmi.h
>  create mode 100644 arch/arm64/include/asm/rmi_cmds.h
>  create mode 100644 arch/arm64/kvm/rmi-exit.c
>  create mode 100644 arch/arm64/kvm/rmi.c
>  create mode 100644 drivers/firmware/arm_rmm/Kconfig
>  create mode 100644 drivers/firmware/arm_rmm/Makefile
>  create mode 100644 drivers/firmware/arm_rmm/rmi.c
>  create mode 100644 include/linux/arm-rmi-cmds.h
>  create mode 100644 include/linux/arm-smccc-rmi.h
>
> --
> 2.43.0
>
