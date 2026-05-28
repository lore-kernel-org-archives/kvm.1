Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2BDF76
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779941265; cv=none; b=m2jAzYvYKgmvrnCMO52eyGtsoCa1VPLg+pcl/XP89Lfd261qDlCq7Eg8orNbk6t7tK5Q8fnqdgjxyVr+6nH678iErBOylbikjNcdvE76B++mVgMcwArVLZgtptHQ8U1ALdRylaIrU1N9xbBd7yRUbxRdzyUNLwegYAADeQDMA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779941265; c=relaxed/simple;
	bh=cU9MrMDCM5kbfai4cHhsGBkpS8gyY3/6wYuHRs6bx2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ4LJL9M9p+ppNDJbHAVMzfq6kf8l8FhbkG0Zb5o+XTEP8YttavJ7V3Vw5Jwymrr+TNQH7r4EzB3Oo8KsD8JFWZeB51amK98jlfBiCMNVvzYz2c40d2V50H1lSobBnhtOKoLsIAu1r8zhiOg0i7EIYciEc4ib7IDTju1LDuaWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/ZgAwIQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0mAT2WN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/ZgAwIQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0mAT2WN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779941263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1I8KzNpXq63WE4CP85HoO7zZcc0AvIs01nVPYeq3DW0=;
	b=K/ZgAwIQukOIE6YX34l/RebhSgtxaEcoawINFdod/YevsDSRNAh6bRyT8++AL0FVtyYq+F
	YrEcEDXtQNpHg/gJIQ3vxoxHOIW1bGUay8ZuEA2Hz9gGVmGzJj7k04fN9nC397SzIKYRMy
	DA7nWUIc+y8a/mhe3awVJume7n53EVk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-mZnTh7h6OjyOFz5CicpEdw-1; Thu, 28 May 2026 00:07:40 -0400
X-MC-Unique: mZnTh7h6OjyOFz5CicpEdw-1
X-Mimecast-MFC-AGG-ID: mZnTh7h6OjyOFz5CicpEdw_1779941259
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8271fb43d0so7079331a12.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779941259; x=1780546059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1I8KzNpXq63WE4CP85HoO7zZcc0AvIs01nVPYeq3DW0=;
        b=E0mAT2WNEr2e0fiBI5V9Ua/SELQH+qDMNRWLIMNfv0l1l9tsML3Qc2CQD0D0BNdVBa
         VrlcVTWmJo8cVA97IV4jHyQyC1aPext0Dy+Xhd6ck4CH1IjY4ADtisn2fJoM0r/AxsLl
         cjoc9Qbm/rSzXabdnFA+Msxko7mC/gqM5d72FnU4vLyPqc7Wkp3dZpfNFB2KQgBfXM/1
         DzSYnZbWenF/yyseZ4EbYrmyat9DuOXnrZq8y0PCPH3Y9eUq9/Pe40eK/oSkkwrteWav
         l/iE0tHLuuN2kEHPYtH576212FeeH3MUMpuAQJ6Dy//LiKbMfjU/4KQvNd8L60T8KdE1
         FXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779941259; x=1780546059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1I8KzNpXq63WE4CP85HoO7zZcc0AvIs01nVPYeq3DW0=;
        b=MsEr7wmfaDs1YV97Unmam2Qez3NVqGvVZPr0MbW+FWiAgILJJIJMNSxwjZAMz4sPEk
         6u7pRT+iRGZya7g96XSyE5/PuPPmxnECpJ1ShbRfFxWdJ2ucJkhpzbXDAiM/H6GGRHM3
         BhPOUut/duPzVXZ2d2OhxMkjsZRD+NdBgPFdfZi/Npcv9uLwfIaYsA1xXfm+qkywSmKl
         /txTvqHX7T26fv/bwGmEq8N12bDaLBco/YGfl+oCSR96iZ8ZRgAclsCFO634W13bYe+R
         1+ZezyYx7VA57tdAodZQbzTpS/s89cmigKuykOODYuLEdyTQKUOaQziMRyxN4FeQogRK
         kItg==
X-Forwarded-Encrypted: i=1; AFNElJ8VlsNEGCGCde0LiMo/dRtvChLNDlDlzxQ4rqjtHjUaXFKmi5IylZPx7GoJ8f0uv3KSm1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAWgFGE5ewvpiLwvqjTSSLs9NSf9LgQ2g94fsQkHOE64mvfiv
	+hzZqwcD2zgDmx/hl0rF2nGev+uhdNJn/GWoq5sli3jh4fIOduhrpTLBt8pmoc1k1ovL5s4J+Xw
	sWjy+mvk+xwL7G3k+Jspd6qccp/cQrCIiCeT6DWUW9ZnMuPQrcJO3A4EyudB5gA==
X-Gm-Gg: Acq92OFM3XHzv26gWrcU8V0E6QmTjetFRx04tsMWkIzgOgGEetnT8YRe3AtG3TJB/JK
	jKCJff9JVvTAsxXHKXaIf6353vpH8PECrwvKXXeT25HfLwKkK68EZywp+/xB9NnUDpKTpbj8P26
	HBPyz7tlb+/KIiCOdlteIrgHPtvLMxN97njkXwHfN1oneOl9hYtnD8OK0J3NVrBIX59QK7+zsyQ
	tEtFZlMm2MErbBO7wg/FSVo0zzEK/6ApZCR+OacTujvoE2YS+BgFCwkN9ZkxCtyYFCBKiM1jS+7
	7y37vTiv2HkZj07VcR3KPN7E3JRgCuCNrlEEfMQB8hvx5Mryb0GF6w1ijducKZqXPHqNZ5BAsnT
	FSg51mth12ldow/JEshAY8BtqAOTuuZ/f60GOLYOe7GEOIdJWHFnrT/+EPzKmV2HyZNRr0y0pjL
	g=
X-Received: by 2002:a05:6a00:194f:b0:837:acd7:a78 with SMTP id d2e1a72fcca58-8415f329ac5mr24016471b3a.16.1779941259188;
        Wed, 27 May 2026 21:07:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:194f:b0:837:acd7:a78 with SMTP id d2e1a72fcca58-8415f329ac5mr24016447b3a.16.1779941258714;
        Wed, 27 May 2026 21:07:38 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d7300ea4sm3790751b3a.56.2026.05.27.21.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 21:07:37 -0700 (PDT)
Message-ID: <5ea74b6a-a51a-415e-b53f-5ece9829dee8@redhat.com>
Date: Thu, 28 May 2026 14:07:27 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 20/44] arm64: RMI: Support for the VGIC in realms
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
 <20260513131757.116630-21-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260513131757.116630-21-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 5/13/26 11:17 PM, Steven Price wrote:
> The RMM provides emulation of a VGIC to the realm guest. With RMM v2.0
> the registers are passed in the system registers so this works similar
> to a normal guest, but kvm_arch_vcpu_put() need reordering to early out,
> and realm guests don't support GICv2 even if the host does.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes from v12:
>   * GIC registers are now passed in the system registers rather than via
>     rec_entry/rec_exit which removes most of the changes.
> Changes from v11:
>   * Minor changes to align with the previous patches. Note that the VGIC
>     handling will change with RMM v2.0.
> Changes from v10:
>   * Make sure we sync the VGIC v4 state, and only populate valid lrs from
>     the list.
> Changes from v9:
>   * Copy gicv3_vmcr from the RMM at the same time as gicv3_hcr rather
>     than having to handle that as a special case.
> Changes from v8:
>   * Propagate gicv3_hcr to from the RMM.
> Changes from v5:
>   * Handle RMM providing fewer GIC LRs than the hardware supports.
> ---
>   arch/arm64/kvm/arm.c            | 11 ++++++++---
>   arch/arm64/kvm/vgic/vgic-init.c |  2 +-
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 93d34762db91..21d9dfdb1ea0 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -786,19 +786,24 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>   		kvm_call_hyp_nvhe(__pkvm_vcpu_put);
>   	}
>   
> +	kvm_timer_vcpu_put(vcpu);
> +	kvm_vgic_put(vcpu);
> +
> +	vcpu->cpu = -1;
> +
> +	if (vcpu_is_rec(vcpu))
> +		return;
> +

For a REC, kvm_vcpu_{load, put}_debug() becomes unbalanced in kvm_arch_vcpu_{load, put}().
kvm_vcpu_load_debug() is called in kvm_arch_vcpu_load(), but kvm_vcpu_put_debug() won't
be called in kvm_arch_vcpu_put() after this whole series is applied.

>   	kvm_vcpu_put_debug(vcpu);
>   	kvm_arch_vcpu_put_fp(vcpu);
>   	if (has_vhe())
>   		kvm_vcpu_put_vhe(vcpu);
> -	kvm_timer_vcpu_put(vcpu);
> -	kvm_vgic_put(vcpu);
>   	kvm_vcpu_pmu_restore_host(vcpu);
>   	if (vcpu_has_nv(vcpu))
>   		kvm_vcpu_put_hw_mmu(vcpu);
>   	kvm_arm_vmid_clear_active();
>   
>   	vcpu_clear_on_unsupported_cpu(vcpu);
> -	vcpu->cpu = -1;
>   }
>   
>   static void __kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
> index 933983bb2005..a9db963dfd23 100644
> --- a/arch/arm64/kvm/vgic/vgic-init.c
> +++ b/arch/arm64/kvm/vgic/vgic-init.c
> @@ -81,7 +81,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>   	 * the proper checks already.
>   	 */
>   	if (type == KVM_DEV_TYPE_ARM_VGIC_V2 &&
> -		!kvm_vgic_global_state.can_emulate_gicv2)
> +	    (!kvm_vgic_global_state.can_emulate_gicv2 || kvm_is_realm(kvm)))
>   		return -ENODEV;
>   
>   	/*

Thanks,
Gavin

