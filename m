Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DC7263B;
	Wed,  1 Jul 2026 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782872136; cv=none; b=uBqOwxu03D7dAZXLHscmn1ecfTmwTxDMXqyPUU5Yvsw3iMH7swe7p2vnaSpb6SienTgcpzoneIWW1QD5wjXrkTcNCA8kFNsK70zeJ+W1jPlZw17m1B1gPHs0+RS+7UulfOCi9BlZg55D55EvXyFITOh6i5SpXyQUExzmeCLwbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782872136; c=relaxed/simple;
	bh=Pw/JDUXvjVK+3QrfI9yFi2jVw+bIU28wBw3FXCmitUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlwcBSWT9s22Qqt3K0p7qomsTV0fkqWM5gLiV8DFsMYgsYdFzFa9aUgFeRqkcR10JNRyMbxrFU0FAnr+2OIVkyFLr3a8ug1QvY6eCCE/g+VneuzIE8gC1dMCtVIbYHkLNbuAyYurjtzYl5vVY3TvPIABffTDh/URsu+knrWGbyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=s0+qdUoi; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="s0+qdUoi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1782872134; x=1814408134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pw/JDUXvjVK+3QrfI9yFi2jVw+bIU28wBw3FXCmitUA=;
  b=s0+qdUoiUNgfXncmmYrd7FPh8tRmMUXrpDFF3rQRu9wVYGqKCrdh8FnM
   QUVhgxblen12HstkkUfjRYmZuIWvExD+SGyCkE34TP2EqkRNprW1twCwY
   SVbDxmWQm+wwBMXwvdGqKBVubY2rNHSYzyy//cSSYDtM1OYBrnAw8Rt1H
   Mfh4wzPfYb1nL//lYObh171GWLFo5bO/p6CYduEMRvFQ6/m9GlQLGrqzy
   3UN025vE6PmCOfOAQ/N7g4TpbFw1qF5c3qj6plcT7xKBdw3r1AqOTwIRV
   FCam7XMi4lg9nWLI0D8Sm1FsTc+Ax7fYjSjXZcXfLdwop6dK2HUxvk+hj
   Q==;
X-CSE-ConnectionGUID: bBjDRgR1S82r0er4sS3MIQ==
X-CSE-MsgGUID: GCPlvuMaT32sUsNDSFnLqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="245894211"
X-IronPort-AV: E=Sophos;i="6.24,235,1774278000"; 
   d="scan'208";a="245894211"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 11:15:26 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id AD701C01826;
	Wed,  1 Jul 2026 02:15:25 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 65B5FC15945;
	Wed,  1 Jul 2026 02:15:25 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.91.60])
	by az2nlsmom3.fujitsu.com (Postfix) with SMTP id BF254100A6C3;
	Wed,  1 Jul 2026 02:15:16 +0000 (UTC)
Date: Wed, 1 Jul 2026 11:15:15 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
Subject: Re: [PATCH v14 00/44] arm64: Support for Arm CCA in KVM
Message-ID: <akR0eX0nCumIgnlh@FCCLS0092175.localdomain>
References: <20260513131757.116630-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513131757.116630-1-steven.price@arm.com>

On 05/13 14:17, Steven Price wrote:
> This series adds support for running protected VMs using KVM under the
> Arm Confidential Compute Architecture (CCA).
> 
> This is rebased on v7.1-rc1, but still targets RMM v2.0-bet1[1].
> 
> The major updates from v13 remain but have been more fully implemented:
> the RMM uses the host's page size, range based RMI APIs mean we don't
> have to break everything down to base page sizes, the GIC state is
> passed via system registers, and the uAPI has been simplified.
> 
> The main changes since v13 are:
> 
>  * The RMI definitions and wrappers have been fully updated for RMM
>    v2.0-bet1. In particular the temporary RMM v1.0 SMC compatibility
>    patch has been dropped.
> 
>  * The PSCI completion ioctl has been removed. RMM v2.0-bet1 still
>    requires the host to provide the target REC for PSCI calls which
>    name another vCPU, but KVM now performs the RMI PSCI completion
>    automatically before entering the REC again. Userspace no longer
>    needs to issue KVM_ARM_VCPU_RMI_PSCI_COMPLETE. A future spec should
>    remove the need for the host to provide the MPIDR mapping.
> 
>  * The generic RMI init, RMM configuration, GPT setup,
>    delegate/undelegate helpers and SRO infrastructure have moved out of
>    KVM into arch/arm64/kernel/rmi.c. RMI is expected to be used by
>    features outside KVM, so this code should be available even when KVM
>    is not built.
> 
>  * RMI_GRANULE_TRACKING_GET has been updated to work on a range, this
>    allows it to work when the region is not aligned to the tracking
>    size. Solves the problem reported by Mathieu[2].
> 
>  * SRO support has been moved earlier in the series and improved. It
>    provides a cleaner way for the host to provide the RMM with the extra
>    memory it requires. However support is still incomplete where the
>    TF-RMM code does not yet implement it. This is noted by FIXMEs in the
>    code.
> 
>  * The ARM VM type encoding has been reworked to coexist with the
>    upstream pKVM KVM_VM_TYPE_ARM_PROTECTED bit.
> 
>  * The private-memory documentation now notes that arm64 uses
>    KVM_CAP_MEMORY_ATTRIBUTES.
> 
>  * PMU support is dropped for now. It will be added later in a separate
>    series. Similarly for selecting the hash algorithm and RPV.

Hi Steven,

Is there any plan to add support for selecting the MEC policy (shared or
private)? We have been working on adding support for this on top of your
series. If this is not already in the works, we may upstream our
implementation later.

Thanks,
Kohei

> 
> There are also the usual rebase updates and smaller fixes, including
> changes to the RMM v2.0-bet1 range APIs, removal of REC auxiliary
> granule handling, fixes to the address range descriptor encoding, and
> cleanups around realm stage-2 teardown.
> 
> Stateful RMI Operations
> -----------------------
> 
> The RMM v2.0 spec introduces Stateful RMI Operations (SROs), which allow
> the RMM to complete an operation over several SMC calls while requesting
> or returning memory to the host. This allows interrupts to be handled in
> the middle of an operation and lets the RMM dynamically allocate memory
> for internal tracking purposes. For example, RMI_REC_CREATE no longer
> needs auxiliary granules to be provided up front, and can instead
> request memory during the operation.
> 
> This series includes the generic SRO infrastructure in
> arch/arm64/kernel/rmi.c and uses it for REC create/destroy. The other
> cases are not yet used by TF-RMM and a future revision will be needed to
> finish those paths in Linux.
> 
> This series is based on v7.1-rc1. It is also available as a git
> repository:
> 
> https://gitlab.arm.com/linux-arm/linux-cca cca-host/v14
> 
> Work in progress changes for kvmtool are available from the git
> repository below:
> 
> https://gitlab.arm.com/linux-arm/kvmtool-cca cca/v12
> 
> The TF-RMM has not yet merged the RMM v2.0 support, so you will need to
> use a branch with RMM v2.0-bet1 support. At the time of writing the
> following branch is being used:
> 
> https://git.trustedfirmware.org/TF-RMM/tf-rmm.git topics/rmm-v2.0-poc_2
> (tested on commit 3340667a291a)
> 
> There is a kvm-unit-test branch which has been updated to support the
> attestation used in RMMv2.0 available here:
> 
> https://gitlab.arm.com/linux-arm/kvm-unit-tests-cca cca/v4
> 
> [1] https://developer.arm.com/documentation/den0137/2-0bet1/
> [2] https://lore.kernel.org/all/acrj-cKphy4hJsEG@p14s/
