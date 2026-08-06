Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B93385D89
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786056191; cv=pass; b=tvfy7XGDgmyABqD0TwZ2G7WGdUGtP2776fMkFh6UwgJFp7DvqJ4x62UEvq4Vk8zHWDbIj3nNiRba5dLcMQQX15+EmfN4Lfl/+DrYw9+uiC2zieUvMcPEyFurj6lm6OMNzOtRLCO4Upb8XqtWRhqwN6RJ1/+UZXyx3why6Xhlzfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786056191; c=relaxed/simple;
	bh=70iwZ9Cw1FJjHC2K1XcrH7qvJKBYnnnjLMUyOrdbphI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5APqkYo/K8VY1HQX1fcvseoiZ2AcWtpoge3wEJLhCLAU2u7c5/QP6Se8lGLb63o3hhdnCUVhyWub14FV9Y3/EE6kLtg+pRPiVB+YY/XR1rnUpLDBiJkedJFpq49/6MqBFkIsPe8cHLu5IBuunU0LnNQNw56dKolwZUi0sYZLoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5QDh4mW; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5QDh4mW"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2577870a91.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 15:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786056188; cv=none;
        d=google.com; s=arc-20260327;
        b=Xboy+eah6Opcz/SkdNm+6N5EYi85uU5fkEYFHlwxEp+8fDWYg9dgRshI2J4o1EtDwa
         OVeL8eQHI50Lv6sR9LI0IHkmZRAATXeGu2U/RCQ3afltc5a1iHcNfWWakyXrF24zk0Xz
         qLOfFuvBhUcXT2XAboHVQ0OTVGGp/HOjDPTwK7Bkw0/LKyQS9nwFNiM+IJoxSIcWlhAc
         9Ve2p7pM7seiN1mG+bNLZEK4AOYWLyAoSMX1iNLfD4gtN8idCTBMzt/3IJSf9hL8Ag3V
         haomlfv6P/jVXPCfpmBULHNzjH6X9740zbQpnp9Aa6LQViXhxndDTJVvzwdMvyVH8Zhb
         1H0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=t3iDpdzRxEXGTzSx99ebjxlSOptD6jmNZBgMvWAVu1o=;
        fh=0rmrw+Dv0/9E3N2RiPhg4wLMf168yjPWJVcaHZyaYjc=;
        b=KqCmtFTvJLw2jeR3pAWMqTEYB9z17Zrr+ilDyQNM4p4t7FixeVO0iCbhQbq94Z9SW0
         4JyFNSkVeVnvBGJ3Orzh0JpcohbuCj2Kc7eMwROlWu7o62H6yl2zL6om7qlDVrb0EtEe
         /7BDd0JOo10nynJq16lnzBUNZChgXqUfQU2m8MwtkPUipkA/iMQjBNtQSShxEAaIk/TA
         B5Q1OBtXmnHvYfs0VeBblEUHl//DDnmJOKnj2/jx+Zz+Q6xFd3tmjV1/mMxpLrpE7Zm1
         mvXVM7tasBnUzxYwkB8EbArBpnk2PQ9a6EtYyOkPF5e3B93xmI8EXeiMbFCu2qwMdNuf
         Bs0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786056188; x=1786660988; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t3iDpdzRxEXGTzSx99ebjxlSOptD6jmNZBgMvWAVu1o=;
        b=B5QDh4mWQAiNqOofVKpKu0wStjUVzvJbDPSLoaBRUun/jVa6j0PRS+SFl49qBlnhgg
         56imA5vbZOi77tBRcockkJuRJS1a+rZZxNvYLp1de5hRd2qJec0Avie3g2Yd+XasXTa+
         HRfz7IYG90YmvZ5xuEEaT3R3f1L9zV+KV54fd0uyLg+3L1fw0wSNbZ7ozS2oPp7P0IjZ
         ZITsDRnROypDCPm8AXESyry57nlV+4sh/TwI2ssV0eX/Y7da1QnB6FLgmCPt4pWG4s4x
         haW6ZR6jDgvNIMGRpqCU476jR44S409ZBjWcd0nE5CKFxA2mccjk8+22V7GTVJhOulnT
         bXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786056188; x=1786660988;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3iDpdzRxEXGTzSx99ebjxlSOptD6jmNZBgMvWAVu1o=;
        b=SvU0xRykZuZXj09D+DUyJT9rlHzJwpuCTtg9x/gPSJfERhlyLpT0d6+tjXykYbrAdK
         fBpE78sqMzyy4IS4VUn5ZUH+IAEDhE1aKdNSgdpJAE9t8W8jFyWYYpTqJfLphwpHXqaq
         Ym275oUIOc0pySi/lZEkP35GT0NF4gIITrila/rbWLfOSrBT6SdkRNDx4XroOwdo6fzt
         TRWuzhUzXKWIWQLcqq83odKnk5HbXl4KmB8E4/jBCrjyIhL3vh1+pgZ4GVV2xE717fsV
         GrM+cdNji0YpTQKLGt8eZZ3F09nT1j015cXg2VQ/2aek8GxJSNOLRds59FRo5WSc/enm
         eNmA==
X-Forwarded-Encrypted: i=1; AHgh+RogiGgtb46+HlErrQeJsVcjySBUzSeBzAeAa0Avs+wNU4ytM2zarO7+MNY9OllVhu7IzeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLa6IbjF0Eu37UdcgN32LgjDywpZ5f6KbxcH/jvpQ4ZM87IwA0
	bjTMFWHyclI2nb5inobLzsgQnb9VEzC311lHa9AoEz4uCIiBLK572Lgi94hKHzHnCK4Df0mqjDa
	Vmnd/Rmh4rUVRgQPYTdedSkubrw9RNZ1lKogVJu36
X-Gm-Gg: AR+sD10zVWADULLlbefdx9AooTsFhJ0s7zHD9lqh6b6FqZD4b29h5cXBiDgMBQ1AcQQ
	dzyQKeL/S2AMPxc9P8TUOERuVhVZRj9lmFn8oR/8C3mT1l7uI+TfQ0NsAWEOJJZSSsYEWX0H8kI
	Nttap+UGBeBa/N+xoL6A3O8ex9pB1GxQeoC4SiAq5D7JROdpLQIfgBmgsgVk7AM9raVP4EZYOud
	rSiMvtmY0U5JCYMopxzBknU9m45lRsuV8jjC5yUiU7vX/dmUK0CJcBmVEJlULV9gmdky+8EXFLH
	ROK89oIOmNXaYZ8rcclJmpBjm6HIIeKqIxEi7SjkLODzNW0Aoa9/0/bpCZ6LzsJCnIlGh01jiB5
	EScgl6pFe9Q7xRrQut5gvJn08q1XcRTXeyEk=
X-Received: by 2002:a05:6a20:7487:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3cb85e2b724mr19964239637.6.1786056187332; Thu, 06 Aug 2026
 15:43:07 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Aug 2026 15:43:06 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Aug 2026 15:43:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260803134403.80630-28-steven.price@arm.com>
References: <20260803134403.80630-1-steven.price@arm.com> <20260803134403.80630-28-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Aug 2026 15:43:06 -0700
X-Gm-Features: AUfX_mz4KvATUHiDYAFclNLmldRIwEYFFUZFU-z1uCffxQhTAlRAoSRwyvnJ1NM
Message-ID: <CAEvNRgHF-30EwJEprM466+Ag7GSuJWrzMGNAw7kCvXyT7YVucg@mail.gmail.com>
Subject: Re: [PATCH v16 27/45] KVM: arm64: CCA: Allow populating initial contents
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, 
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Emi Kisanuki <fj0570is@fujitsu.com>, 
	Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, rick.p.edgecombe@intel.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Steven Price <steven.price@arm.com> writes:

> The VMM needs to populate the realm with some data before starting (e.g.
> a kernel and initrd). This is measured by the RMM and used as part of
> the attestation later on.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v15:
>  * Handle negative error codes
> Changes since v14:
>  * Holding of locks slots_lock and config_lock have been moved up the
>    callstack with lockdesp assertions placed in the lower functions.
>  * Add overflow check into kvm_arm_rmi_populate().
> Changes since v13:
>  * Rename realm_create_protected_data_page() to realm_data_map_init().
> Changes since v12:
>  * The ioctl now updates the structure with the amount populated rather
>    than returning this through the ioctl return code.
>  * Use the new RMM v2.0 range based RMI calls.
>  * Adapt to upstream changes in kvm_gmem_populate().
> Changes since v11:
>  * The multiplex CAP is gone and there's a new ioctl which makes use of
>    the generic kvm_gmem_populate() functionality.
> Changes since v7:
>  * Improve the error codes.
>  * Other minor changes from review.
> Changes since v6:
>  * Handle host potentially having a larger page size than the RMM
>    granule.
>  * Drop historic "par" (protected address range) from
>    populate_par_region() - it doesn't exist within the current
>    architecture.
>  * Add a cond_resched() call in kvm_populate_realm().
> Changes since v5:
>  * Refactor to use PFNs rather than tracking struct page in
>    realm_create_protected_data_page().
>  * Pull changes from a later patch (in the v5 series) for accessing
>    pages from a guest memfd.
>  * Do the populate in chunks to avoid holding locks for too long and
>    triggering RCU stall warnings.
> ---
>  arch/arm64/include/asm/kvm_rmi.h |   4 ++
>  arch/arm64/kvm/Kconfig           |   1 +
>  arch/arm64/kvm/arm.c             |  13 ++++
>  arch/arm64/kvm/rmi.c             | 119 +++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_rmi.h b/arch/arm64/include/asm/kvm_rmi.h
> index 90563183a717..03f8bd2d13a2 100644
> --- a/arch/arm64/include/asm/kvm_rmi.h
> +++ b/arch/arm64/include/asm/kvm_rmi.h
> @@ -108,6 +108,10 @@ int kvm_rec_exit(struct kvm_vcpu *vcpu, int rec_run_status);
>  int kvm_rec_handle_request(struct kvm_vcpu *vcpu);
>  bool kvm_rec_handle_hvc(struct kvm_vcpu *vcpu, int *ret);
>
> +struct kvm_arm_rmi_populate;
> +
> +int kvm_arm_rmi_populate(struct kvm *kvm,
> +			 struct kvm_arm_rmi_populate *arg);
>  void kvm_realm_unmap_range(struct kvm *kvm,
>  			   unsigned long ipa,
>  			   unsigned long size,
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 189e8ad78b22..83b95e836b4d 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -37,6 +37,7 @@ menuconfig KVM
>  	select SCHED_INFO
>  	select GUEST_PERF_EVENTS if PERF_EVENTS
>  	select KVM_GUEST_MEMFD
> +	select HAVE_KVM_ARCH_GMEM_POPULATE
>  	select ARM_RMM
>  	help
>  	  Support hosting virtualized guest machines.
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index b7c308817d45..f1b26b263bf0 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2154,6 +2154,19 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  			return -EFAULT;
>  		return kvm_vm_ioctl_get_reg_writable_masks(kvm, &range);
>  	}
> +	case KVM_ARM_RMI_POPULATE: {
> +		struct kvm_arm_rmi_populate req;
> +		int ret;
> +
> +		if (!kvm_is_realm(kvm))
> +			return -ENXIO;
> +		if (copy_from_user(&req, argp, sizeof(req)))
> +			return -EFAULT;
> +		ret = kvm_arm_rmi_populate(kvm, &req);
> +		if (copy_to_user(argp, &req, sizeof(req)))
> +			return -EFAULT;
> +		return ret;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> index c8ec766d3dc0..d18c241f7eb2 100644
> --- a/arch/arm64/kvm/rmi.c
> +++ b/arch/arm64/kvm/rmi.c
> @@ -609,6 +609,76 @@ void kvm_realm_unmap_range(struct kvm *kvm, unsigned long start,
>  		realm_unmap_private_range(kvm, start, end, may_block);
>  }
>
> +static int realm_data_map_init(struct kvm *kvm, unsigned long ipa,
> +			       kvm_pfn_t dst_pfn, kvm_pfn_t src_pfn,
> +			       unsigned long flags)
> +{
> +	struct realm *realm = &kvm->arch.realm;
> +	phys_addr_t rd = virt_to_phys(realm->rd);
> +	phys_addr_t dst_phys, src_phys;
> +	long ret;
> +
> +	lockdep_assert_held(&kvm->slots_lock);
> +	lockdep_assert_held(&kvm->arch.config_lock);
> +
> +	dst_phys = __pfn_to_phys(dst_pfn);
> +	src_phys = __pfn_to_phys(src_pfn);
> +
> +	if (rmi_delegate_page(dst_phys))
> +		return -ENXIO;
> +
> +retry:
> +	ret = rmi_rtt_data_map_init(rd, dst_phys, ipa, src_phys, flags);
> +	if (ret >= 0 && RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
> +		/* Create missing RTTs and retry */
> +		int level = RMI_RETURN_INDEX(ret);
> +
> +		KVM_BUG_ON(level >= KVM_PGTABLE_LAST_LEVEL, kvm);
> +
> +		ret = realm_create_rtt_levels(realm, ipa, level,
> +					      level + 1, NULL);
> +		if (!ret)
> +			goto retry;
> +	}
> +
> +	if (ret && WARN_ON(rmi_undelegate_page(dst_phys))) {
> +		/* Leak the page if the undelegate fails */
> +		get_page(pfn_to_page(dst_pfn));

Is there some way to avoid taking a reference on the page? This would
interfere with conversions. There was a similar discussion for TDX as
well [1].

TDX originally incremented folio refounts for these:

+ when mapping folios into the Secure EPTs. This one was easier to agree
  to remove, since TDX can trust guest_memfd to keep pages around on
  behalf of the guest.
+ To indicate unmapping failure (IIUC this is the same situation as
  above). This interferes with conversions.
    + An alternative discussed was to mark these pages as HWPOISON, but
      that was eventually rejected as adding unnecessary complexity to
      make TDX special for code paths that only occur on kernel
      bugs. (In TDX's case the unmap failures would probably only be for
      kernel bugs.)
    + I later worked a bit more on memory failure for guest_memfd
      HugeTLB and found that because we will need to restructure huge
      pages for conversions, using the HWPOISON flag would be hard to
      handle. For TDX since the conclusion was not to use a HWPOISON
      flag to indicate unmap failures anyway, this turned out to be a
      non-issue. Nobody wanted to use the HWPOISON flag. (I hope you
      won't need to either)

So for TDX, on an unmap failure we do a KVM_BUG_ON() and mark the VM as
dead, and do nothing about the page, it still gets returned to the
system as if nothing happened.

Here's my understanding of why this is okay for TDX (Rick and Yan, could
you please help me here):

+ For unmap failures, the page remains in TDX's Physical Address
  Metadata Table (PAMT), and the page is still assigned to some TD.
+ If the page was assigned to some other TD, it would be blocked, since
  the PAMT shows it as already assigned.
+ If the page was used by something completely unrelated to TDX, then in
  the TDX model the host is free to write and read pages. Nothing goes
  bad until the TD tries to use that same page, but that TD would never
  use the page again, that TD is already dead and the HKID for the TD
  was leaked.

[1] https://lore.kernel.org/all/diqz34bolnta.fsf@ackerleytng-ctop.c.googlers.com/

> +	}
> +
> +	return ret <= 0 ? ret : -ENXIO;
> +}
> +
> +static int populate_region_cb(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +			      struct page *src_page, void *opaque)
> +{
> +	unsigned long data_flags = *(unsigned long *)opaque;
> +	phys_addr_t ipa = gfn_to_gpa(gfn);
> +
> +	return realm_data_map_init(kvm, ipa, pfn, page_to_pfn(src_page),
> +				   data_flags);
> +}
> +
> +static long populate_region(struct kvm *kvm,
> +			    gfn_t base_gfn,
> +			    unsigned long pages,
> +			    u64 uaddr,
> +			    unsigned long data_flags)
> +{
> +	long ret = 0;
> +
> +	lockdep_assert_held(&kvm->slots_lock);
> +	lockdep_assert_held(&kvm->arch.config_lock);
> +
> +	if (!uaddr)
> +		return -EINVAL;
> +

Why not check for !uaddr together with the other checks in
kvm_arm_rmi_populate?

Also would it be okay to inline populate_region into
kvm_arm_rmi_populate below?

> +	ret = kvm_gmem_populate(kvm, base_gfn, u64_to_user_ptr(uaddr), pages,
> +				false, populate_region_cb, &data_flags);
> +
> +	return ret;
> +}
> +
>  enum ripas_action {
>  	RIPAS_INIT,
>  	RIPAS_SET,
> @@ -727,6 +797,55 @@ static int realm_ensure_created(struct kvm *kvm)
>  	return realm_create_rd(kvm);
>  }
>
> +int kvm_arm_rmi_populate(struct kvm *kvm,
> +			 struct kvm_arm_rmi_populate *args)
> +{
> +	unsigned long data_flags = 0;
> +	unsigned long ipa_start = args->base;
> +	unsigned long ipa_end = ipa_start + args->size;
> +	long pages_populated;
> +	int ret;
> +
> +	if (args->reserved ||
> +	    (args->flags & ~KVM_ARM_RMI_POPULATE_FLAGS_MEASURE) ||
> +	    args->base + args->size < args->base ||
> +	    !IS_ALIGNED(ipa_start, PAGE_SIZE) ||
> +	    !IS_ALIGNED(ipa_end, PAGE_SIZE) ||
> +	    !IS_ALIGNED(args->source_uaddr, PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (args->flags & KVM_ARM_RMI_POPULATE_FLAGS_MEASURE)
> +		data_flags |= RMI_MEASURE_CONTENT;
> +
> +	mutex_lock(&kvm->slots_lock);
> +	mutex_lock(&kvm->arch.config_lock);
> +
> +	ret = realm_ensure_created(kvm);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (args->size == 0)
> +		goto out_unlock;
> +
> +	pages_populated = populate_region(kvm, gpa_to_gfn(ipa_start),
> +					  args->size >> PAGE_SHIFT,
> +					  args->source_uaddr, data_flags);
> +
> +	if (pages_populated < 0) {
> +		ret = pages_populated;
> +		goto out_unlock;
> +	}
> +
> +	args->size -= pages_populated << PAGE_SHIFT;
> +	args->source_uaddr += pages_populated << PAGE_SHIFT;
> +	args->base += pages_populated << PAGE_SHIFT;
> +
> +out_unlock:
> +	mutex_unlock(&kvm->arch.config_lock);
> +	mutex_unlock(&kvm->slots_lock);
> +	return ret;
> +}
> +
>  static int kvm_complete_ripas_change(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> --
> 2.43.0
