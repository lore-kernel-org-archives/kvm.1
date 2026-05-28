Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21278F26
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946238; cv=none; b=uTGrjAr1MEH6OGgx+nN5erxOoQGK/7eAR/JGMG7w/Dm7+OBDh0IKyN5lyfsLXN++x8YE2MpZVmwfGEFqf+EiGquvGaSvWzlE26bJR3Y90SaJMPq3ZlaGG2nt7RyTZnIAmcerl83v7r/SmV3EX+j2i0SN0V+0n1l0UsspK4DsZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946238; c=relaxed/simple;
	bh=DgWGKIje13k1TapEkr+MBgcoQR7z1LfAsyvCQ1fD20E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APkgsXUbhqUvP4Qj7rBnxL/vXtTWqtgNRDWzQSDonoEZgRQPbPBOUiVtGXNf666PdN3a6UXyZdVSXCBRVOWwLD0tM0jD1M5uW5Lu5SDITcS3CaiJqhG8ys3dMN/hNpOsx/sqRLj8ZTGeJXJqMfvfHiHKqJPTrUcxVrr8JlpobaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qa6Gis8B; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYpfyNsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qa6Gis8B";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYpfyNsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779946234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q73WX9HWItM842HL8te6BLbm9UQjrRb26yA0hD3pI7M=;
	b=Qa6Gis8BG1wUGDSH62+t+2Tlwjygubw1RSeXwSNm5LryKxXY0WB95vzYad0xD3s8fSqzRb
	ghLLKYGzhlndFD/dE0XT5m+EaanMLlyJil0Z/Gt6XpHgLNl2QhIg/006MIQ8vhiZrMx4Fh
	054RR9oi7fjT9RrI0m2ukVAFXWz6oXY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-zfMtgf-nMHa86Q5l_A1k3w-1; Thu, 28 May 2026 01:30:33 -0400
X-MC-Unique: zfMtgf-nMHa86Q5l_A1k3w-1
X-Mimecast-MFC-AGG-ID: zfMtgf-nMHa86Q5l_A1k3w_1779946232
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba86e35aa1so197235035ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779946232; x=1780551032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q73WX9HWItM842HL8te6BLbm9UQjrRb26yA0hD3pI7M=;
        b=aYpfyNsMQ+u3dwqOoOgK9J1OKMwJRev8vivUKe4iuMMMMprC3O+5zKludhvvlVEGkL
         ieOUUyaI4T5BgQcjWW5QDqVxsJumRO2Uo67gU9Va1Fnk/n1DxxKewj0XTfPxObp9/wr4
         +5kQ0HMrRBlEHKWOTiyTS4dhWaRBbamRSKUlYVvdc3goNH2wCDO3zSzsOPJrnH4sLQLA
         CcqQF/wkeiWgy0yk/2g8xqEI0IIhmigaRSQdfY75/JPZx/iQ0wWk8Yg6SNO7NoE5cJpl
         nbJilESPIwLQnlUOZJAb4YVs7Nw7PxU674dKA302JIgKSXP7mtN7Mq4n79wcsQrdgv3N
         a35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946232; x=1780551032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q73WX9HWItM842HL8te6BLbm9UQjrRb26yA0hD3pI7M=;
        b=bvwLKSttSpNMhDpRkx/fDZtctbAIyGS/qsZsUlvE4fA8HKC+5sP+gILC+mb/3zU1Kc
         poOIHdI9q6iCoPlLtkHlu1KLfTLPHDN4s1G2SknbaCGUlhAiJogZ9k7oP9fMzOqqm4ku
         mvU5iw29mR/6RcfxKBsjNG4MnyPdB6lo88A4z7yxPWEZn9l1ibJVngCRRCfzOxBlfCiy
         S6MTzvFesoOvnubvjtDqqxGn5Eaor/QFQXTSQnTNtv/qWisx3NHfD2FOeWYqp97bZMV5
         0WrKrFdW3ic1AIR4VTcde41A6B6GHP7BRufy2BxcTvG7PvinCSjEbZXpdMvzFUMbOKMI
         1p6A==
X-Forwarded-Encrypted: i=1; AFNElJ/ax75v1oYqvZ1ek5BAba1q6dzJEuLn389jsGorKi2FesMllUG94Lop5PfdendDZrXqzvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGYV1Nvu7vZng4ge5U50WgKDA7zn53DINoZvCqx2ck/3hoe9w
	5NgwSz7iB3Hk9QnOUNmmu4TEsI5GOWzHVpcsTn0VLkqJvuxarbqRV+L6eAMp4oL5k/DkcWt7hsV
	jMghTqxkgyWB1XdCU3N7qWKQAMQf5xK21QDTzZpJqhLjM08kc6Pu+TQ==
X-Gm-Gg: Acq92OFxQm1wL7Vkuee4GpH6X6CmbON2AaxFrzBq1869JAkP4kUZ8NrGygUpPyKDZZG
	BptwmvAY4lrPDZH//Xm6WDrWDqHWoNYIP4nzy2sMt1F3QraKJVQAXidm28n/4dCDK32EfC8O15H
	ISGMcmVTKb6xtm156wm48jPTIydUSY3c+xOzg74WatFj8saHr7naX+8ZUXSZVS+kvpoGgFWDR0/
	RfoXVeidZsSsL7+cJYrQbuchMmqpaMZIqZb+uUQDOvpg20r+Q9MJQYEwwWBM9mxwLk1TN+JTnpO
	W8jV4+s5z/UTHgxNo7uks4tyMHV6WN+gIk/hSl+B6a9HZkq8Lu3TtRPwnxgVzO7efmVm9FB8Ht6
	nKixm8GdUeCPkRQ/b2kzaSNeM0jeLmTrbp4JRTns2+Adz9VJO/4DgX+smICC5waNPb8Ds8Xc67F
	A=
X-Received: by 2002:a17:903:4b07:b0:2bd:5b20:a5b5 with SMTP id d9443c01a7336-2beb066cd73mr260282265ad.37.1779946232115;
        Wed, 27 May 2026 22:30:32 -0700 (PDT)
X-Received: by 2002:a17:903:4b07:b0:2bd:5b20:a5b5 with SMTP id d9443c01a7336-2beb066cd73mr260281545ad.37.1779946231485;
        Wed, 27 May 2026 22:30:31 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56d2702sm173761155ad.31.2026.05.27.22.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 22:30:30 -0700 (PDT)
Message-ID: <ea4be6c5-9506-4253-80c5-c76c9ac3b77d@redhat.com>
Date: Thu, 28 May 2026 15:30:19 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 26/44] arm64: RMI: Allow populating initial contents
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
References: <20260513131757.116630-1-steven.price@arm.com>
 <20260513131757.116630-27-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260513131757.116630-27-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 5/13/26 11:17 PM, Steven Price wrote:
> The VMM needs to populate the realm with some data before starting (e.g.
> a kernel and initrd). This is measured by the RMM and used as part of
> the attestation later on.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v13:
>   * Rename realm_create_protected_data_page() to realm_data_map_init().
> Changes since v12:
>   * The ioctl now updates the structure with the amount populated rather
>     than returning this through the ioctl return code.
>   * Use the new RMM v2.0 range based RMI calls.
>   * Adapt to upstream changes in kvm_gmem_populate().
> Changes since v11:
>   * The multiplex CAP is gone and there's a new ioctl which makes use of
>     the generic kvm_gmem_populate() functionality.
> Changes since v7:
>   * Improve the error codes.
>   * Other minor changes from review.
> Changes since v6:
>   * Handle host potentially having a larger page size than the RMM
>     granule.
>   * Drop historic "par" (protected address range) from
>     populate_par_region() - it doesn't exist within the current
>     architecture.
>   * Add a cond_resched() call in kvm_populate_realm().
> Changes since v5:
>   * Refactor to use PFNs rather than tracking struct page in
>     realm_create_protected_data_page().
>   * Pull changes from a later patch (in the v5 series) for accessing
>     pages from a guest memfd.
>   * Do the populate in chunks to avoid holding locks for too long and
>     triggering RCU stall warnings.
> ---
>   arch/arm64/include/asm/kvm_rmi.h |   4 ++
>   arch/arm64/kvm/Kconfig           |   1 +
>   arch/arm64/kvm/arm.c             |  13 ++++
>   arch/arm64/kvm/rmi.c             | 106 +++++++++++++++++++++++++++++++
>   4 files changed, 124 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_rmi.h b/arch/arm64/include/asm/kvm_rmi.h
> index 007249a13dbc..a2b6bc412a22 100644
> --- a/arch/arm64/include/asm/kvm_rmi.h
> +++ b/arch/arm64/include/asm/kvm_rmi.h
> @@ -88,6 +88,10 @@ int kvm_rec_enter(struct kvm_vcpu *vcpu);
>   int kvm_rec_pre_enter(struct kvm_vcpu *vcpu);
>   int handle_rec_exit(struct kvm_vcpu *vcpu, int rec_run_status);
>   
> +struct kvm_arm_rmi_populate;
> +
> +int kvm_arm_rmi_populate(struct kvm *kvm,
> +			 struct kvm_arm_rmi_populate *arg);
>   void kvm_realm_unmap_range(struct kvm *kvm,
>   			   unsigned long ipa,
>   			   unsigned long size,
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 4e16719fda22..d0cd011cf672 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -38,6 +38,7 @@ menuconfig KVM
>   	select GUEST_PERF_EVENTS if PERF_EVENTS
>   	select KVM_GUEST_MEMFD
>   	select KVM_GENERIC_MEMORY_ATTRIBUTES
> +	select HAVE_KVM_ARCH_GMEM_POPULATE
>   	help
>   	  Support hosting virtualized guest machines.
>   
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index ed88a203b892..073ba9181da9 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2131,6 +2131,19 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>   			return -EFAULT;
>   		return kvm_vm_ioctl_get_reg_writable_masks(kvm, &range);
>   	}
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

s/return ret/return 0; The variable 'ret' can be dropped.

>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> index a89873a5eb77..209087bcf399 100644
> --- a/arch/arm64/kvm/rmi.c
> +++ b/arch/arm64/kvm/rmi.c
> @@ -486,6 +486,75 @@ void kvm_realm_unmap_range(struct kvm *kvm, unsigned long start,
>   		realm_unmap_private_range(kvm, start, end, may_block);
>   }
>   
> +static int realm_data_map_init(struct kvm *kvm, unsigned long ipa,
> +			       kvm_pfn_t dst_pfn, kvm_pfn_t src_pfn,
> +			       unsigned long flags)
> +{
> +	struct realm *realm = &kvm->arch.realm;
> +	phys_addr_t rd = virt_to_phys(realm->rd);
> +	phys_addr_t dst_phys, src_phys;
> +	int ret;
> +
> +	dst_phys = __pfn_to_phys(dst_pfn);
> +	src_phys = __pfn_to_phys(src_pfn);
> +
> +	if (rmi_delegate_page(dst_phys))
> +		return -ENXIO;
> +
> +	ret = rmi_rtt_data_map_init(rd, dst_phys, ipa, src_phys, flags);
> +	if (RMI_RETURN_STATUS(ret) == RMI_ERROR_RTT) {
> +		/* Create missing RTTs and retry */
> +		int level = RMI_RETURN_INDEX(ret);
> +
> +		KVM_BUG_ON(level == KVM_PGTABLE_LAST_LEVEL, kvm);

		KVM_BUG_ON(level >= KVM_PGTABLE_LAST_LEVEL, kvm);> +
> +		ret = realm_create_rtt_levels(realm, ipa, level,
> +					      KVM_PGTABLE_LAST_LEVEL, NULL);
> +		if (!ret) {
> +			ret = rmi_rtt_data_map_init(rd, dst_phys, ipa, src_phys,
> +						    flags);
> +		}
> +	}
> +
> +	if (ret) {
> +		if (WARN_ON(rmi_undelegate_page(dst_phys))) {
> +			/* Undelegate failed, so we leak the page */
> +			get_page(pfn_to_page(dst_pfn));
> +		}
> +	}
> +

	if (ret && WARN_ON(rmi_undelegate_page(dst_phys)) {
		/* Leak the page that fails to be undelegated */
		get_page(pfn_to_page(dst_pfn));
	}

> +	return ret;
> +}
> +
> +static int populate_region_cb(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> +			      struct page *src_page, void *opaque)
> +{
> +	unsigned long data_flags = *(unsigned long *)opaque;
> +	phys_addr_t ipa = gfn_to_gpa(gfn);
> +
> +	if (!src_page)
> +		return -EOPNOTSUPP;
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
> +	mutex_lock(&kvm->slots_lock);
> +	ret = kvm_gmem_populate(kvm, base_gfn, u64_to_user_ptr(uaddr), pages,
> +				populate_region_cb, &data_flags);
> +	mutex_unlock(&kvm->slots_lock);
> +
> +	return ret;
> +}
> +
>   enum ripas_action {
>   	RIPAS_INIT,
>   	RIPAS_SET,
> @@ -574,6 +643,43 @@ static int realm_ensure_created(struct kvm *kvm)
>   	return -ENXIO;
>   }
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
> +	    !IS_ALIGNED(ipa_start, PAGE_SIZE) ||
> +	    !IS_ALIGNED(ipa_end, PAGE_SIZE) ||
> +	    !IS_ALIGNED(args->source_uaddr, PAGE_SIZE))
> +		return -EINVAL;
> +

There are more conditions missed here:

	args->size == 0, return 0;
	args->base + args->size < args->base, return -EINVAL;  // wrapped range

> +	ret = realm_ensure_created(kvm);
> +	if (ret)
> +		return ret;
> +
> +	if (args->flags & KVM_ARM_RMI_POPULATE_FLAGS_MEASURE)
> +		data_flags |= RMI_MEASURE_CONTENT;
> +
> +	pages_populated = populate_region(kvm, gpa_to_gfn(ipa_start),
> +					  args->size >> PAGE_SHIFT,
> +					  args->source_uaddr, data_flags);
> +
> +	if (pages_populated < 0)
> +		return pages_populated;

pages_populaged is 'unsigned long', this function returns a 'int' value.

> +
> +	args->size -= pages_populated << PAGE_SHIFT;
> +	args->source_uaddr += pages_populated << PAGE_SHIFT;
> +	args->base += pages_populated << PAGE_SHIFT;
> +
> +	return 0;
> +}
> +
>   static void kvm_complete_ripas_change(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm *kvm = vcpu->kvm;

Thanks,
Gavin

