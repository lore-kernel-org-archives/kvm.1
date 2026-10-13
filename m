Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F6560AC3
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928838; cv=none; b=mcIYWjCyhYuvNJ6EZvsB0odtLnI6YtgToWtGJGceeNw4RRJqYBaHa9jH0uNe74b0lm0rLwX9TklrsG4TBND+rhgz+8G2P2i5AdFeQtO2mYsjjJy3KQhB/KJTnMYLP2leuSzkUR0S9amXVuZTn52QG94Zvj5hFCzZ7RNqkRCVNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928838; c=relaxed/simple;
	bh=sn2mLGJH0tgKOcGLdG04mUbQQzWBRolRQ4hI/fHGez0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYGbEGZaXW2dJ/Bkk2FF8I2UjW0K7eAfIe5YY4dRtu5/ePK3raMZ6CybBvL/Yj1EczOnpcn3HvNGa5Qx/+Dl0AOjpWMGnGNpNJ2MHC0bpncZgU5lmZUxebK0JL1XpqWE8Kg36esGzoCUvF71h1+FD9gX4XCZMeE8eDvAlnBG5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gawf1Llf; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gawf1Llf"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso1336965a12.2
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791928828; x=1792533628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UI33XHytP9UeW0jMN4hGWfxaoI7IkHXeeChdjxsUSUw=;
        b=Gawf1LlfFwPJJ/yzr0pEXnALwLMR1MSuVuwaq04nbYEzIL4ZSl3kAr1MFg7fjoZMSM
         NQoFEW7dlTsQ20Ypf1aoLD7cHJwX7ahaTUPBKkrfRTsk7cgcNYtZZVQ5V16ExMUh0RoF
         A0ZdoiCmLYcLQ0bRRsULHT2zigxI0LPUI+X5aTDaDOrtNdo0Mld5S2X7CxQL15wwteMV
         p3xZzZWBAYBjOWfhVZ02EYrfnrkiGY1oIPwEWLfC81ySh9DW9Nhd/QUmVoGSZe2uIGCQ
         y3nCnZE8/rV8AmjTiHkC+DyBG3R4aFU8tEUAb9Z5Teo2OfWoxuP89f317vYE1vXz4SO0
         Fz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791928828; x=1792533628;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UI33XHytP9UeW0jMN4hGWfxaoI7IkHXeeChdjxsUSUw=;
        b=lbnCrtQd9Wh3keCZ54JCH+CKvFngHc0XL6dPG9vNPJcktFEx06tCR7Eri+1DVA+gNg
         hWoH9caEQktfUc3/fIt8C/I8G71kkzRMbc2ahvj+Nn44DgPCpgP//djmxAoDOAXoePlv
         D0aWEpGqLdJSemDdbI3vciM9HoT45N2/WMM8Wy6riCli+6cd1VGnwud46OrnxG/Ccnhd
         1dZ63VrUf5qQSkowRq6qAH7xzn0jkkwCkAO3J8Gwujjr1UkzfOEfEUIAxn3CD0ag+EeV
         flKPNdyYFtl2CbXKzFcvLM9aArtfIvfo9J6vv4kWOSg6cRp7Zd+BraUJv+A5Rhp8twLo
         3L1A==
X-Gm-Message-State: AFq9FYIKYdfNfj/UdHifsgs0GqWrE8nXxsbjZZDEGYtDAR5Qh9ezed3l
	TTvUVNc0JtHijHIzuOuBrwst08qXUWT2yjL9vZrmozFpDBOafegGue7v1fZnAjY/wCExwcluufr
	hUU6M
X-Gm-Gg: AYBFou0JxDGicjer9ODenlOVjt76paKpsI13TUozEnsjutTQ75ci7t+lowFbAHlt2tu
	SFO0KTAuU19TfpXjcrUOEz4Nif+CEMZWj/SQHVIYyGzn8n/Av77Nmy0fgOcUAxOSj3bQ3D8vLih
	dMW5SAZJu7uDZB54OyRU3lZnsCuuh2O7IdZp61myUTu1qJIRAo791fuSixj76UqHfU+N+z1V3JJ
	0FUbo8HPxocOgDoXM8qe+xaF66cGE3KS/tL2DEhrKxn+3NtN1dt56q5KyoPVaWAkgA+eVZUJbzm
	vDOBDm3Kjy0R8bGwwES41+TtieBIT44GLkLxE4RERNNBrsVV98gCvXsqZHW2R9eagqgvfpKmrMx
	djtfbkUXOzzdrY6BWbfXmqvHUNFr/dbvHf3vgrqsVUGj/lI7oDASco6lqyAdelyECE0xTCUXgWP
	VRWNkLYGx28IjzseHEBZC1bAIRg0AvRgEVAtxwMGamiowGYRMcye8P2iNJs83cPRC1oW5J3ro6s
	g==
X-Received: by 2002:a17:90b:3d82:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3ab3ab3771fmr9650115a91.50.1791928828071;
        Tue, 13 Oct 2026 15:00:28 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:adc4:c3cd:7c5f:3991])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac678d2229sm309218a91.3.2026.10.13.15.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 15:00:26 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:00:22 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
	gshan@redhat.com, joey.gouly@arm.com, tabba@google.com,
	yuzenghui@huawei.com, linux-coco@lists.linux.dev,
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com,
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com,
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com,
	jonathan.cameron@oss.qualcomm.com
Subject: Re: [PATCH v23 00/14] KVM: arm64: CCA: Add basic plumbing for Realms
Message-ID: <as6p9q051NgTKHum@p14s>
References: <20261007073537.2454351-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007073537.2454351-1-suzuki.poulose@arm.com>

On Wed, Oct 07, 2026 at 08:35:23AM +0100, Suzuki K Poulose wrote:
> This is a trimmed down and updated version of the v22 of Arm CCA basic
> plumbing series [0]. I have dropped the CCA specific bits for the sake keeping
> them separate. This series now only contains the framework for handling
> different VM types and lay down the path for adding Realm as one of the
> protected VMs. The full support for running Realms under KVM is available as
> an integration branch at [1].
> 
> The integration branch has been tested with the following components:
> 
>   tf-RMM:   main branch (commit 5e6e2acd) compliant to RMM-v2.0-beta3
>   kvmtool: git@git.gitlab.arm.com:linux-arm/kvmtool-cca.git tag:cca-kvm-v20
> 
> [0] Arm CCA KVM basic plumbing v22
>     https://lore.kernel.org/all/20261005090754.2140522-1-suzuki.poulose@arm.com
> [1] https://git.gitlab.arm.com/linux-arm/linux-cca/ cca/cca-host/kvm-v23/integration
> 
> Changes since v22:
>  https://lore.kernel.org/all/20261005090754.2140522-1-suzuki.poulose@arm.com
>   - Drop the CCA specific patches for now, they are on the integration branch
>   - system_supported_vcpu_features() - Start off with a base set of features for
>     the type of VM
>   - Add () around 'flavor' in KVM_VM_S2_OPS() macro
>   - Drop BUILD_BUG_ON and redefine {kvm_vm,vcpu}_is_protected() for nVHE
>   - Drop {kvm_vm,vcpu}_is_protected_pkvm() macros
> 
> Changes since v21:
>  https://lore.kernel.org/all/20261001210703.1597150-1-suzuki.poulose@arm.com
>  - Keep the kvm_arch struct packed, by moving psci_version, closer to vm_flavor and also moving the vm_s2_ops, closer to vm_flavor.
>  - Drop the kern_hyp_va() for vcpu_is_protected() in nVHE, instead ban nVHE
>    code from using vcpu_is_protected() (by using BUILD_BUG_ON()) and convert
>    all users to vcpu_is_protected_pkvm()
>  - Drop kvm_vm_is_unprotected_pkvm() in favor of open coded check against VM_PKVM
>  - Drop WARN_ON_ONCE() in the kvm_vm_ioctl_allowed() to match Fuad's fix merged in v7.3-rc5
>  - Move '&' to the KVM_*_OPS macros
>  - Nuke __unmap_stage2_range() and define per-VM callback for stage2_unmap_range, removing the KVM_PGT_FN() hack for the call, and also for the others
>  - Drop NULL check for vm_s2_ops callbacks and always define everything.
>  - Add no_age_gfn() which plugs in for pVMs and Realms for the vm_age_*gfn callbacks
> 
> Steven Price (1):
>   KVM: arm64: Avoid including linux/kvm_host.h in kvm_pgtable.h
> 
> Suzuki K Poulose (13):
>   KVM: arm64: protected VM: Handle user writes to CNTVCT_EL0/CNTPCT_EL0
>   KVM: arm64: Disable Steal time accounting for protected guests
>   KVM: arm64: Include kvm_emulate.h in kvm/arm_psci.h
>   KVM: arm64: Track the type of VM in kvm_arch
>   KVM: arm64: Don't call vcpu_set_pauth_traps for pKVM host
>   KVM: arm64: Refactor the vcpu_load to allow for VM specific callbacks
>   KVM: arm64: Add vcpu load/put call backs for flavors
>   KVM: arm64: Consolidate stage2 unmap range into kvm_stage2_unmap_range
>   KVM: arm64: Add VM specific callback for S2 MMU operations
>   KVM: arm64: Use a local kvm pointer in kvm_handle_guest_abort()
>   KVM: arm64: Abstract out memory abort handling
>   KVM: arm64: Mandate VGIC v3 for pKVM VMs and Realms
>   KVM: arm64: Prevent unsupported vcpu features for VM types
> 
>  arch/arm64/include/asm/kvm_host.h    |  73 ++++++-
>  arch/arm64/include/asm/kvm_pgtable.h |  10 +-
>  arch/arm64/include/asm/kvm_pkvm.h    |   6 +-
>  arch/arm64/kvm/arch_timer.c          |  12 +-
>  arch/arm64/kvm/arm.c                 | 275 ++++++++++++++++++++-------
>  arch/arm64/kvm/hyp/nvhe/pkvm.c       |   6 +-
>  arch/arm64/kvm/hyp/pgtable.c         |   1 +
>  arch/arm64/kvm/mmio.c                |   1 +
>  arch/arm64/kvm/mmu.c                 | 247 +++++++++++++++++-------
>  arch/arm64/kvm/pkvm.c                |   6 +-
>  arch/arm64/kvm/pvtime.c              |  14 +-
>  arch/arm64/kvm/vgic/vgic-init.c      |   2 +
>  include/kvm/arm_psci.h               |   2 +
>  13 files changed, 493 insertions(+), 162 deletions(-)

Version 5 of my QEMU-VMM patchset [1] has been tested on this kernel and things
work as expected.  Instructions to build and test on the QEMU SBSA architecture
are located here [2].

[1]. https://lore.kernel.org/kvm/20261002202026.1204110-1-mathieu.poirier@linaro.org/
[2]. https://gitlab.com/Linaro/cca-public/build-instructions/-/tree/upstream-v5-kvmv23?ref_type=heads 

> 
> -- 
> 2.43.0
> 
> 
