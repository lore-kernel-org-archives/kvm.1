Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46E30EF68;
	Tue,  8 Sep 2026 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852682; cv=none; b=GpE9bwmmyA8ArUbgjHKAiRyzHZpFOhPMUWgMxQpUk6XUmR2sGcrd02BrA28YVimg230FTHmLetFPFEmKIUFNKG63jZorO0Y4c4+gxca4v+nkaWt3KQcaHykvfOWjXxyECTviJ/5vEEYufQQ1vsabTgQ+dWa/8A/elij2h8FAwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852682; c=relaxed/simple;
	bh=8+quB6EjKOoEa1ZHF+bZNfsyz8/M/RI5EzR+EzA9+cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISCg80MYA81V7nmqKTc6aUJGp2a/n5OOysBj4gogHPZizR+3bovD4nCvXOAQlLJ/c6NXX/tq44DaCU+2qXOJq36qpmgOlIu7kBR9vk9amfWqzUOihj58US+62b6GN+Zar2/dLThNnLkWA2gebFhAef4SDIJ5NB1f89Sa/JB24Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GXjftrs3; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GXjftrs3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1788852684; x=1820388684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8+quB6EjKOoEa1ZHF+bZNfsyz8/M/RI5EzR+EzA9+cI=;
  b=GXjftrs302h0Ganvwjmd/69WazLRY7n1KmcDrfFu+BD2G8+fSzZ0h26W
   PYpKSMYEf2C2pfIVVAvyHiSohec61hkWpA3FbqWiI+unS8JR6X2nKi+1M
   6YZubX48VqxvVddr5lNPIwrbufLiH21QB2G7nU5lmTC9jm75qcfF4nMqQ
   5X6OVNqX97zs7lcoezq8LjpI0VVTY6Z/gRPmY5VK98cJqQ6vgz6MNu7ll
   C90P9BNPRPEKLccpe/Ep2gbx7WCF+P78c4hoael6+e78gS3iulRbknmL+
   02BWPn66Xb8OZdRy2wkLJ8yntaO2UWqvUWbFPTjdZb0D6g5d5F9LhFwa6
   w==;
X-CSE-ConnectionGUID: Kq+p6d2DSVaqos5cKrIXcg==
X-CSE-MsgGUID: ruYD2ve8RGGyGwTN235FrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="242278686"
X-IronPort-AV: E=Sophos;i="6.25,268,1779116400"; 
   d="scan'208";a="242278686"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 16:31:17 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 1FA801C000AE;
	Tue,  8 Sep 2026 07:31:13 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id BE6DB1C002FF;
	Tue,  8 Sep 2026 07:31:12 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.9.15.163])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id 4C91114000F7;
	Tue,  8 Sep 2026 07:31:05 +0000 (UTC)
Date: Tue, 8 Sep 2026 16:30:57 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org, 
	gshan@redhat.com, joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com, 
	linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v17 0/7] firmware: arm_rmm: Add RMM v2.0 base RMI support
Message-ID: <ap-4lPkYzogPqs_V@FCCLS0092175.localdomain>
References: <20260907095942.1140734-1-suzuki.poulose@arm.com>
 <ap-C6NLnxuWWTMzi@FCCLS0092175.localdomain>
 <f65216f6-cb7b-4b76-a7cc-79b332db2bd8@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f65216f6-cb7b-4b76-a7cc-79b332db2bd8@arm.com>

On 09/08 06:46, Suzuki K Poulose wrote:
> Hi Kohei-San
> 
> Linaro is best suited to answer this. I have Cc'ed Mathieu (and
> Lorenzo), who may be able to help you here.

Thank you for pointing me in the right direction and Ccing Mathieu and
Lorenzo. 
I'll wait for their response.

> 
> On 08/09/2026 05:09, Kohei Enju wrote:
> > Hi Suzuki,
> > 
> > On 09/07 10:59, Suzuki K Poulose wrote:
> > > This series adds the generic firmware layer for talking to the Realm
> > > Management Monitor (RMM), as specified by the RMM v2.0-bet3
> > > specification[1]. It is the first part of the Arm CCA host support that
> > > was previously posted as part of the larger KVM series.
> > > 
> > > The split allows this RMM support to be used as a base for other work,
> > > including Aneesh's PCI IDE support with Arm CCA RMM as the TSM,
> > >   without depending on the KVM Realm support that will follow as separate
> > >   series. (See more on that below)
> > > 
> > > The series adds:
> > > 
> > >   * The RMI SMC definitions and direct-call wrappers.
> > > 
> > >   * RMM discovery and version checks during firmware init.
> > > 
> > >   * RMM host configuration, including the host page size.
> > > 
> > >   * Stateful RMI Operation (SRO) infrastructure for commands which the RMM
> > >     can complete across multiple SMC calls while requesting or returning
> > >     memory to the host.
> > > 
> > >   * Verification that granule tracking is available at fine granularity.
> > >     Fine-grained tracking allows each granule in the system to be tracked
> > >     independently, which is required before individual granules can be
> > >     delegated. A future series will add support for dynamically supplying
> > >     memory to the RMM for this tracking.
> > > 
> > >   * Support for fully firmware-managed systems, where the Granule Protection
> > >     Tables for memory regions are allocated and managed by firmware. RMM v2.0
> > >     also allows dynamic GPT creation on demand; support for that will be added
> > >     in a later series.
> > > 
> > >   * Wrappers for the RMI commands that are used for managing the "Realm VM"
> > >     lifecycle. This is added in to make it easier for the on-going KVM support
> > >     to evolve in parallel pieces.
> > > 
> > > If the platform firmware cannot manage the granule tracking or the GPTs, we
> > > bail out and deactivate the RMM, reclaiming any memory that we have donated.
> > > 
> > > The RMM v2.0 spec introduces Stateful RMI Operations (SROs), which allow
> > > the RMM to complete an operation over several SMC calls while requesting
> > > or returning memory to the host. This allows interrupts to be handled in
> > > the middle of an operation and lets the RMM dynamically allocate memory
> > > for internal tracking purposes. For example, RMI_REC_CREATE no longer
> > > needs auxiliary granules to be provided up front, and can instead
> > > request memory during the operation.
> > > 
> > > This series applies on v7.3-rc1 and a branch is available at [2]. The KVM
> > > CCA support that builds on this series is available at [3] as an integration
> > > branch. The KVM support depends on guest-memfd-in-place conversion support v12
> > > from Ackerley [4], we plan to split that into parts, which apply cleanly on
> > > v7.3-rcx without any dependency and is in progress. This will be made available
> > > as soon as it is ready. Until then [3] shows how this base series enables KVM
> > > CCA support. You may find the tf-RMM [5] and kvmtool support [6] below.
> > > 
> > > [1] RMM spec : https://support.arm.com/documentation/den0137/2-0bet3/
> > > [2] This series: https://gitlab.arm.com/linux-arm/linux-cca.git cca/cca-host/fw_rmm/v17
> > > [3] KVM CCA v17 integration branch: https://gitlab.arm.com/linux-arm/linux-cca.git cca/cca-host/kvm-integration/v17
> > > [4] Gmem inplace conversion https://github.com/googleprodkernel/linux-cc/tree/guest_memfd-inplace-conversion-v12
> > > [5] TF-RMM https://git.trustedfirmware.org/TF-RMM/tf-rmm.git main (commit: 134266ae)
> > 
> > I understand that QEMU-virt is not intended to model a realistic
> > production platform and that QEMU-SBSA is generally preferred. However,
> > I sometimes use QEMU-virt to test functionality quickly because it runs
> > slightly faster than QEMU-SBSA.
> > 
> > I tested this series with QEMU-virt and found that RMM initialization
> > failed during boot:
> > 
> >    [...]
> >    INFO:    BL31: Initializing RMM
> >    INFO:    RMM init start.
> >    ERROR:   RMM init failed: -8
> >    WARNING: BL31: RMM initialization failed
> > 
> > The following TF-A revision was used:
> >    https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git master (38269bb)
> > 
> > After investigating, I found that the failure was caused by the lack of
> > a plat_rmmd_reserve_memory() implementation for the QEMU-virt platform
> > in TF-A. Adding an implementation equivalent to the QEMU-SBSA one
> > resolved the issue:
> >      https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a.git/+/9d594743aa4d4e8160cdf025ea7538041648972c
> > 
> > Is QEMU virt still intended to be supported as an RME emulation
> > platform? In particular, is this functionality simply not implemented
> > yet, or is there a reason why RME support is not planned for QEMU virt?
> > 
> > If this is not the appropriate place to discuss this, please let me
> 
> Mathieu, Lorenzo,
> 
> Over to you folks :-)
> 
> Cheers
> Suzuki
> 
> 
> > know :)
> > 
> > Thanks,
> > Kohei
> > 
> > > [6] kvmtool https://gitlab.arm.com/linux-arm/kvmtool-cca.git cca/kvm-v17
> > > 
> > > Known issues: RMMv2.0
> > >   * RmiOpMemDonateReq:count (Uint14) is incompatible with RmiAddrRangeDesc4KB
> > >    (Uint10) and RmiAddrRangeDesc16KB (Uint12). i.e., a larger contiguous request
> > >    may not be satisfiable by the host. Arm is aware of this defect and a spec fix
> > >    is in progress.
> > > 
> > > 
> > > Steven Price (7):
> > >    firmware: arm_rmm: Add SMC definitions for calling the RMM
> > >    firmware: arm_rmm: Check for RMI support at init
> > >    firmware: arm_rmm: Configure the RMM with the host's page size
> > >    firmware: arm_rmm: Add support for SRO
> > >    firmware: arm_rmm: Activate the RMM
> > >    firmware: arm_rmm: Ensure the RMM has GPT entries for memory
> > >    firmware: arm_rmm: Add wrappers for Realm related RMI commands
> > > 
> > >   arch/arm64/Kconfig                |   1 +
> > >   arch/arm64/kernel/cpufeature.c    |   1 +
> > >   drivers/firmware/Kconfig          |   1 +
> > >   drivers/firmware/Makefile         |   1 +
> > >   drivers/firmware/arm_rmm/Kconfig  |  26 +
> > >   drivers/firmware/arm_rmm/Makefile |   2 +
> > >   drivers/firmware/arm_rmm/rmi.c    | 819 ++++++++++++++++++++++++++++++
> > >   include/linux/arm-rmi-cmds.h      | 678 +++++++++++++++++++++++++
> > >   include/linux/arm-smccc-rmi.h     | 494 ++++++++++++++++++
> > >   9 files changed, 2023 insertions(+)
> > >   create mode 100644 drivers/firmware/arm_rmm/Kconfig
> > >   create mode 100644 drivers/firmware/arm_rmm/Makefile
> > >   create mode 100644 drivers/firmware/arm_rmm/rmi.c
> > >   create mode 100644 include/linux/arm-rmi-cmds.h
> > >   create mode 100644 include/linux/arm-smccc-rmi.h
> > > 
> > > -- 
> > > 2.43.0
> > > 
> 
