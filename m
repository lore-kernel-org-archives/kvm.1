Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98E45DF68
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246467; cv=none; b=cxjwY4OouoSHZkzFdtAwcd14M/9IUyzXibAhSm9g6qLy7cWEqZIAp+D19iB2ssQoQ5WIRqUl1nMHBwBSKcx+2u2MWCHE6cCxwJsUOk0B3obSP+/Zj4van3Q7XJgF2wGtGoaK5JtMp7Mylswm3vqxtEHwqZZ2t2vLisiH4pB+Gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246467; c=relaxed/simple;
	bh=JbUaXALva1bEq25h67NxkLIAtKXgjkKYvuFLfXE435o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9YdwVOiPhxpy59mbldVeqBSbX6pl1AR+SThq3K3qWfG+YuZ9PwbjtzkLhWtNFaXhgNhAbzWo8CY/BkZIgRHkG6ZiF87Nqzp20sob0bdaDxgl9v1X147yRlmYYEbKLvSo7c0q/Hltcm7iw4faVZca3iq4b3RKeLVJ3l+teEZFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxwVn7L/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUmJo9y/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxwVn7L/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUmJo9y/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790246463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZNV1frEqDiEI9aSLfzfuk3rbds2XUUobAuj0Balos8=;
	b=PxwVn7L/IlHuYr8nrtwV2mb3B4XXbSaGDVFiYtGJyoddv6NV+Fs+c5Gm7/4vpp5PkuWGBe
	dP8fTwgzmLcIDP7gm0ybjMHTMA4/H8MLuoh0IW+WWWHMJF5XpGPs8c8ntvY3OpyopbTKzs
	zrpQJur03r+KNNJ1KdrhcJiV5qThpPk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-S-S4iLpwMCe2ZjW_nj8uDA-1; Thu, 24 Sep 2026 06:41:02 -0400
X-MC-Unique: S-S4iLpwMCe2ZjW_nj8uDA-1
X-Mimecast-MFC-AGG-ID: S-S4iLpwMCe2ZjW_nj8uDA_1790246461
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e3f521346so1902952a91.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790246461; x=1790851261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZNV1frEqDiEI9aSLfzfuk3rbds2XUUobAuj0Balos8=;
        b=IUmJo9y/JCySXTu/HSmdr1W6t+CnW+bXWwIhm1KxiK3BUKsYmOW7ypTJvQzuoglFK/
         LwqPFCn5vD89Ua9nQwOuVIfS+AOxMI4IXEKFQgJgrx+6EbVXRjcpA8glEW4aXTa0Dkxj
         BwEHM5+CSqPmt2I75CRFKgtWgdiSUA6OHa7sYxo5k2pqFvmnYkQocKsYGuFRpJOWwqEY
         D7uMlE7f/96y2A07fIhF5cf5lJYfFob31GB3CfFgGnikpUQMHmBsGwCScDICdt46+mgM
         BRSxuTnKxCj3f4oDS+w+CZZemExPXF3wfQHSHsxJgFw290S07LyW6o0u8PTiwrXJCxEg
         ARtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790246461; x=1790851261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZNV1frEqDiEI9aSLfzfuk3rbds2XUUobAuj0Balos8=;
        b=SE09O7jSdqbuHrWbXyoSOvrvj53X3FZZ8tgG4hEdsqDzXMNbA3CXsFqqo8HyJ2mqVJ
         0j7fkCudN0xc6BUGZzvmV72KI9RWEs70HM4RoamRDIX4IxeMeuu/435v2WIixWjgDaFg
         UWuDpeVLrAuHIzISpFtHOGElICwvOsvFsrQOi2Bhnhf/eMaLbGL1rYCuRb4JMxaqeqi4
         svaohsAQWqDMVtCFGph2hS9FUlsajyT82R+MW24ckdpq6zBg+5aWGXQh2KDF4LvM2Nmz
         tjXgATv0/ZHTjfHsPH4ilBYe0ai6vo5wP3i0LkFnWpFm+92FTo5AxnIHBXMoiKAs7d5a
         Ae0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwpR6b0Xh5Mwi19M6Bo2p6L/hXUOnZw8sHBwfVJwB/69r97eKuNWKSVOeCpUM1zawMjfrc=@vger.kernel.org
X-Gm-Message-State: AFuF++kUcSiNQfqpWbsY7I5YCLQZOm6avpAu0V3ai/NvmxWh1Fnyoku8
	Df/MK1NeWGOeZc6e0oP59pUj27SfdlYRRt7zPWuVCSkeW1A0TR/4wBZSb9ARA79qY0YaUSlA+pY
	Ovf5C7rrWfth0zrcSXbLuT93o+SeLHshLwUGv1FwGd856cOzSJyDR0A==
X-Gm-Gg: AYBFou3VT1KAIrD9/y3EoRrA2X/nOM1PM6AXTXxqtyYAYg5mmlyQBMfC1uZJFYaHdp7
	rZxs3qo5kK7wbrM2TiHGQbcPhQ5335Ud0Oe9qw8cu3bco4AbbtUKolqb/4N9V8cP9mreyqklD58
	ay56TYfrHHZC/VBLufhEdB5EMRnppGXO8s6E3AaGFhP/xglSl234nayK/Ecja91/lGHK9sCWn87
	0+TPicN0EEyGJqu6OHlGKANHLCEgEtVIrq2KoBgw4BQY2Gz0hDc0xw7n44d0bicpeJjO0Y4VCbx
	sQ5KFQstsVNxr1BNj57PNFDKSwDKjipYOruFNbOLMM8OggVd+IefgAtzHADpGwbEAuGHWsQBLtM
	KACu9TnDxIZ2jytiXkyIPc4TcFN9U7a7N9qYqwqirWQ==
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a09c9df050mr915853a91.58.1790246460992;
        Thu, 24 Sep 2026 03:41:00 -0700 (PDT)
X-Received: by 2002:a17:90a:1149:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a09c9df050mr915834a91.58.1790246460395;
        Thu, 24 Sep 2026 03:41:00 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3b7240sm2411213a12.7.2026.09.24.03.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 03:40:59 -0700 (PDT)
Message-ID: <a5dbea3b-d175-42d2-a29d-9280c92236da@redhat.com>
Date: Thu, 24 Sep 2026 20:40:50 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/20] KVM: arm64: CCA: Add basic plumbing for Realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260920212845.707-1-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260920212845.707-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 7:28 AM, Suzuki K Poulose wrote:
> This series is a trimmed down version of the Arm CCA KVM support, previously
> posted here [0]. Like in the v17, we have tried to split the entire series
> into the following chunks.
> 
>   1) Base RMM RMI support under drivers/firmware/arm_rmm -> [1]
>   2) Linux Host support for handling GPFs - [2]
>   3) NEW: Enlighten KVM arm64 about the different VM types and use call
>      backs for the VM type, rather than spilling the is_this_type_of_vm()
>      everywhere. Adds VCPU and Stage2 MMU related callbacks with support
>      for the existing VM types. There are other places where we may be
>      able to abstract, but those need careful performance evaluations
>      to make sure they are fit (e.g., vcpu_run)
> 
>     With that in place we generalise the predicate "kvm_vm_is_protected()"
>     to cover all  "Confidential" VMs (which includes Protected VM and Realms),
>     allowing us to handle common themes without having to do things like :
> 
>       if (kvm_vm_is_protected() || kvm_vm_is_realm())
> 
>     Also replaces the code with precise check for a given VM type to
>     avoiding combination of if (). e.g,, kvm_vm_is_unprotected_pkvm(kvm).
>     The checks under arch/arm64/kvm/{nvhe,pkvm} still retain the vm_is_protected()
>     check as pVMs are the only possible protected VMs there.
>     
>   4) Bare minimal Realm VM support without the actual functionality to
>      run a Realm. This would help the maintainers to review the series in
>      smaller chunks. This doesn't depend on [1] and can be independently
>      merged, without being "functional".
>      This series includes vcpu operations and the s2 vm operations, which
>      do need the RMI driver backend to be meaningful. But the KVM handler
>      is in the right shape. The remaining changes would be added once the
>      RMI firmware library lands. Also covers the SET_ONE_REG/GET_ONE_REG
> 
>   5) Core implementation of the RMI driver for KVM and actual enablement of the
>      Realm support. This depends on (1), (2) and the guest-memfd-in-place
>      conversion series v12 from Ackerley. This is available here at the integration
>      branch [3]
> 
> This series is comprised of (3) and (4) above.
> 
> The integration branch has been tested with the following components:
> 
>    tf-RMM:   main branch (commit 5e6e2acd) compliant to RMM-v2.0-beta3 [4]
>    kvmtool: git@git.gitlab.arm.com:linux-arm/kvmtool-cca.git cca/kvm-v18
> 
> [0] Arm CCA KVM Support v16 : https://lore.kernel.org/all/20260803134403.80630-1-steven.price@arm.com
> [1] Linux firmware RMI https://lore.kernel.org/all/20260912083611.2513845-1-suzuki.poulose@arm.com
> [2] Linux GPF Host https://lore.kernel.org/all/20260913070459.2547407-1-suzuki.poulose@arm.com
> [3] https://git.gitlab.arm.com/linux-arm/linux-cca/ cca/cca-host/kvm-v19/integration
> [4] https://support.arm.com/documentation/den0137/2-0bet3/
> 

Apart from the issue found against PATCH[v19 05/20], I didn't see more issues with this
series in my tests where kselftest/kvm cases and kvm-unit-tests are done on various
combinations: 4KB host kernel, 64KB host kernel, kernel parameter "kvm-arm.mode=
{nvhe, protected}" or nil. So with the found issue caused by PATCH[v19 05/20] fixed:

Tested-by: Gavin Shan <gshan@redhat.com>

Thanks,
Gavin

> Changes since v18:
>    https://lore.kernel.org/all/20260915160141.3543048-1-suzuki.poulose@arm.com
> 
>   - Patch count down by 3, after merging different patches together, see more below
>   - Retain NULL vm_offset for pVMs and move the counter offset flag initialisation
>     to kvm_timer_init_vm() - Marc
>   - Merge widening the scope of kvm_vm_is_protected() to the patch where the
>     flavors are introduced(Marc) and also dropped Fuad's reviewed-by, as the
>     patch is now bigger.
>   - Merge "Use kvm_vm_is_unprotected_pkvm" for !kvm_vm_is_protected to patch
>     where flavor is introuced.
>   - Merge "vgic-v3" mandate and preventing vgic-v2 mappings to a single patch,
>     where kvm_vm_hyp_is_distrusting() introduced - Fuad
>   - Drop kvm_vm_hyp_is_pkvm(), reverting to is_protected_kvm_enabled()
>   - Use is_protected_kvm_enabeld() for pKVM guest flavor checks.
>   - s/PKVM/pKVM for commit descriptions too
>   - Make sure the vm_mem_abort callback is !NULL at init time.
>   - Bail out early for !pKVM && !Realm VMs in kvm_vm_ioctl_allowed(). Use
>     kvm_vm_hyp_is_distrusting()
>   - WARN_ON_ONCE(!kvm) for kvm_vm_ioctl_allowed() as it must be only called with
>     a valid kvm instance and only from kvm_arch_vm_ioctl()
>   - Rename kvm_arch_vm_{ext,ioctl}_allowed => kvm_vm_{ext,ioctl}_allowed - Fuad
>   - Move kvm_realm_ext_allowed() to asm/kvm_rmi.h - Fuad
>   - Don't expose PMCR_EL0 to the userspace until we support PMU
> 
> 
> Changes since v17:
> https://lore.kernel.org/all/20260908162223.1683432-1-suzuki.poulose@arm.com
> 
>   - Add a patch to fix pKVM handling of SYS_CNTVCT/CNTPCT to override the counter
>     offset (Patch1)
>   - Restrict Realms to VGIC v3 only - New patch
>   - Add kvm_vm_is_unprotected() to replace is_protected_kvm_enabled() &&
>     !kvm_vm_is_protected() - New patch
>   - Use macro to initialize the per-flavor vcpu, s2_vm ops
>   - Add a wrapper to initialise vcpu and s2_vm ops with a BUILD_BUG_ON()
>     for the array size checks against VM flavour types
>   - Drop forward decalaration of the vcpu, s2_vm operations that spoiled the
>     fun ;-)
>   - Remove irrelevant comment about the order of timer loading for !VHE
>   - Use the explicti kvm_call_hyp_nvhe for pKVM specific ops
>   - Don't call nvhe_vcpu_put from pkvm_vcpu_put, open code them
>   - Drop cpu argument for vcpu_load() callback. We set the cpu
>     before the callbacks are invoked
>   - Drop kvm_vm_is_confidential(), instead widen the scope of kvm_vm_is_protected()
>     to cover pVMs and Realms. Add an explicit helper kvm_vm_is_protected_pkvm()
>     for the cases where we need to check for a "pVM on pKVM"
>   - Add kvm_vm_hyp_is_pkvm() for checking if the VM is running on pKVM.
>     covers both unprotected and pvms. But really uses is_protected_kvm_enabled()
>     under the hood
>   - Add kvm_vm_hyp_is_distrusting() to cover pKVM guests (both protected and
>     unprotected) and Realms. Use this for preventing the vgic v2 mapping into
>     Stage2 for a guest
>   - Drop superfluous !kvm check from kvm_vm_ioctl_enable_cap() - Sashiko
>   - Drop KVM_CAP_CREATE_IRQCHIP, as we don't support VGIC_V2 for Realms
>   - Filter out the vm_ioctls that are based on blocked cap.
>   - Repurpose the pkvm plumbing for filtering the caps and ioctl to generic
>     and plumb the Realm support in
>   - s/PKVM/pKVM for the comments
>   - Drop type argument for pkvm_init_host_vm and also drop protected variable,
>     now that we have the vm_flavor to check.
>   - Use kvm_vm_hyp_is_pkvm() to replace is_protected_kvm_enabled() with valid
>     kvm instance
>   - CCA: Merge the GET/SET REG handling patches into a single patch
>   - CCA: Reword the commit description for SVE VL access handling
>   - Reordered the patches to group the Realm realted to changes to the rear end
> 
> Jean-Philippe Brucker (2):
>    KVM: arm64: CCA: Expose SVE VL register before VCPU finalization
>    KVM: arm64: CCA: Control user register access for Realms
> 
> Steven Price (4):
>    KVM: arm64: Avoid including linux/kvm_host.h in kvm_pgtable.h
>    KVM: arm64: CCA: Introduce Realms
>    KVM: arm64: CCA: WARN on injected undef exceptions
>    KVM: arm64: CCA: Support timers in realm RECs
> 
> Suzuki K Poulose (14):
>    KVM: arm64: protected VM: Handle user writes to CNTVCT_EL0/CNTPCT_EL0
>    KVM: arm64: Disable Steal time accounting for protected guests
>    KVM: arm64: Include kvm_emulate.h in kvm/arm_psci.h
>    KVM: arm64: Track the type of VM in kvm_arch
>    KVM: arm64: Refactor the vcpu_load to allow for VM specific callbacks
>    KVM: arm64: Add vcpu load/put call backs for flavors
>    KVM: arm64: Reuse kvm_stage2_unmap_range in kvm_unmap_gfn_range
>    KVM: arm64: Add VM specific callback for S2 MMU operations
>    KVM: arm64: Abstract out memory abort handling
>    KVM: arm64: Mandate VGIC v3 for for VMs running on hyp that don't
>      trust the host
>    KVM: arm64: CCA: Add a new mode for supporting Realm guests
>    KVM: arm64: CCA: Add VCPU load/put for Realms
>    KVM: arm64: CCA: Add bare minimal S2 operations for Realm
>    KVM: arm64: CCA: Don't expose unsupported capabilities for realm
>      guests
> 
>   .../admin-guide/kernel-parameters.txt         |   3 +
>   arch/arm64/include/asm/kvm_emulate.h          |  16 +
>   arch/arm64/include/asm/kvm_host.h             |  69 +++-
>   arch/arm64/include/asm/kvm_pgtable.h          |   6 +-
>   arch/arm64/include/asm/kvm_pkvm.h             |  25 +-
>   arch/arm64/include/asm/kvm_rmi.h              |  84 +++++
>   arch/arm64/include/asm/virt.h                 |   1 +
>   arch/arm64/kvm/Makefile                       |   2 +-
>   arch/arm64/kvm/arch_timer.c                   |  34 +-
>   arch/arm64/kvm/arm.c                          | 300 +++++++++++++++---
>   arch/arm64/kvm/guest.c                        |  73 ++++-
>   arch/arm64/kvm/handle_exit.c                  |   2 +-
>   arch/arm64/kvm/hyp/nvhe/pkvm.c                |   6 +-
>   arch/arm64/kvm/hyp/pgtable.c                  |   1 +
>   arch/arm64/kvm/hypercalls.c                   |   4 +-
>   arch/arm64/kvm/inject_fault.c                 |   1 +
>   arch/arm64/kvm/mmu.c                          | 210 +++++++++---
>   arch/arm64/kvm/pkvm.c                         |   6 +-
>   arch/arm64/kvm/pvtime.c                       |  14 +-
>   arch/arm64/kvm/rmi.c                          |  18 ++
>   arch/arm64/kvm/sys_regs.c                     |  28 +-
>   arch/arm64/kvm/vgic/vgic-init.c               |   2 +
>   include/kvm/arm_psci.h                        |   2 +
>   23 files changed, 752 insertions(+), 155 deletions(-)
>   create mode 100644 arch/arm64/include/asm/kvm_rmi.h
>   create mode 100644 arch/arm64/kvm/rmi.c
> 

