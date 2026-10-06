Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B6248893
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791253482; cv=none; b=cbNRO5jYy8kxpIytYqpp6nbOelQAqgfmSCVqhk7e/zaTDi5E7iD8pKkPL7C01qeNOR3alxm2iLdWKwBAR8bzy1j0SuW7Lnk+NMSQkXynSW19gdsN8NRouA6S7zmsd8hkkvmckwqAkREOPGc9gL65vzDTHT32Xhvnk0G+id/fy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791253482; c=relaxed/simple;
	bh=QWAFFhzhcemt4JkAXvKSQU+sijmwJ3F9VG6lkevDJYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nt3QpX9Eq5FG2qlAop3RuD0AfFIhCRuoEmhqn4rpRDoIAXsc9wyWjV32ve9iKMNMV5yv4sX4/+F1sHEy7JPb5KQOBTH8Dx03lBMtu1gN6sZLJCPogRx0uyHD31JGbeCITeN5bavSEs0Qbo5WhCBfNXS4LVZEYMkZ8JVIOf1l27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkBGYy5z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJcmcpx5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkBGYy5z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJcmcpx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791253480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugMxefZ1qIEDU/oRAsn8b/LDZMC+9ePrF31NK37FBF8=;
	b=AkBGYy5zhUpXNv6jCeKlBZIcQYZcDv8nWCqebRuA51PVg/alI0xdUhxTcLTj6hNIG2YBg6
	66DwdziOQOqcO58vFJzzSND4F/zN68Ca7E+OzL7pwGSrn+FDTJ09JeDrcTgvC+McCEPCBy
	boyPgPPTFrEmQovv078x6IGRE03pNVw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-KGYJFs7AOq-Pl04tOZrHAw-1; Mon, 05 Oct 2026 22:24:39 -0400
X-MC-Unique: KGYJFs7AOq-Pl04tOZrHAw-1
X-Mimecast-MFC-AGG-ID: KGYJFs7AOq-Pl04tOZrHAw_1791253478
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so1879546a91.3
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 19:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791253478; x=1791858278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ugMxefZ1qIEDU/oRAsn8b/LDZMC+9ePrF31NK37FBF8=;
        b=VJcmcpx5DALv7uuleEiOhn0jYwrW+03RBTia+eoBsXBvPlpSBuwX7ObQOisqBFFbeN
         lOLO0REZFHanfad89zYRxgfb/Fmqz6b0rzI848IZg8kgJ6/wveNmh6y8bA5dTMB1XVFX
         mZnbiABY8EcD4s4ATqVSmNNxy+SsydLwAXelB44z3+6Lu1mULiFiiz2nTdw98J/TILzg
         mgALqZ0Vww3BGvQyXFJwmIJyc/xUws5+S35s9hx6aZZXWd7c4QkmHKRx8V1UhZk50P8X
         GmU6+HNGw15YMy1OmucKeqbtwYEdEUfOF3EMor7lQrh43oABSV+LHcM8cKwmTabtuqXP
         cPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791253478; x=1791858278;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugMxefZ1qIEDU/oRAsn8b/LDZMC+9ePrF31NK37FBF8=;
        b=D+09IGdywvfDFQj+COCPpA+tN2e9gNjfZ7XLiKB0G1UyWU4SNYxrAebowzDkv4Km7M
         3UuQzhxwyWxD9aQp/BLrmxJwBmMLi7kmtJgSojS8KOqf/5BUkizvzij79NdHN60pDIGk
         1uURWuIwCHWhxw4qiy9fqPVfCW1ecqyQ/Z8C0vqx/GsKFnPM+txT9Ab/szkBCbDfPQ+W
         NQ7pO0M2snTZqcIb+Zy1RgUWTM98coNhdIy8+9+PCjTvFErBWFoLUzGhl9e/RK/lRWTr
         rThJGO44GfE9EEpMhzSwn9puT3Bimolaub8JMaukUrtAd+r6yX+mGRBQ3Y4tkRlDF46J
         EJIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHiFMS+S4rklDw0zpG06Bop/q0+T36RS4Bfshit9LzbovAGJU1Si0VQuquAfonYv9JhmA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoMXJH8Pycp7n08nJcVYwbKgdbSMm7W/jay4cK2yEWXfPn4E0F
	SHDX0E6bKd44uHHTOh0h91UB2cTkZ3EoIbk8eEoYZYRn06uoqzN98sE9AwLJub4gVkwNrZ74VIJ
	/v25KpAVvfARweDuIxo4sSyJ9NOBhstsqthIIY4p70DiSqeKOd8E1UA==
X-Gm-Gg: AYBFou3TzkeGeVPPP+VXew5sdw6I25BjV6ZCWWyynwNS1MyLsSk5zSpPqvJTSSqZvH8
	w1niK0+6NJDHwLa6kTmP7BWuk5kgyr7rtxKiApUDbZnpILMX278zYzc0t4mt1rVfoiVbIi0JJzV
	Tgmd/++iwmuiEhUCZo61mogjif7Fis1NuZUs9IVq7qNTK/DGcHz7+gVz7f9QVbdqrz5bZpETo71
	0k4eoJram1c71/Hq05Ht2LBt67Isj8a/EKVGZciWO9LGaiIALunk4/3hd9pHsSiNWuuC4JVnRsK
	g9LkA6ioXPec7GEZZfFvxtUz3BMrrG7gIh0tow4SDfl8O0n6rqGqGMzVOUQ4GFS0UgFP66PbGGG
	FDdPtcz5/RegzeQ3HvQzBesKYsxYMkN2Qu4myvpZM4w==
X-Received: by 2002:a17:90b:58e8:b0:3a4:9b8b:2ab9 with SMTP id 98e67ed59e1d1-3a6ce34d7f8mr8521739a91.8.1791253477874;
        Mon, 05 Oct 2026 19:24:37 -0700 (PDT)
X-Received: by 2002:a17:90b:58e8:b0:3a4:9b8b:2ab9 with SMTP id 98e67ed59e1d1-3a6ce34d7f8mr8521712a91.8.1791253477385;
        Mon, 05 Oct 2026 19:24:37 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm3352206a91.10.2026.10.05.19.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 19:24:36 -0700 (PDT)
Message-ID: <7f42005b-b840-4a5a-978d-18877bea3481@redhat.com>
Date: Tue, 6 Oct 2026 12:24:27 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 09/23] KVM: arm64: Prevent unsupported vcpu features
 for VM types
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-10-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-10-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> Prevent unsupported VCPU features for the protected VCPUs. Realms and pVMs
> not support 32bit EL1 or NV yet. pKVM doesn't rely on the host vcpu
> features and it clears the unsupported features while hyp_vcpu is
> initialised. Block the features early in the vcpu init if we detect
> incompatible features.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kvm/arm.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 

One nitpick below. In either way:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index f31d31fa27ad9..9c2ef7ca6a961 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1668,11 +1668,12 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
>   	return -EINVAL;
>   }
>   
> -static unsigned long system_supported_vcpu_features(void)
> +static unsigned long system_supported_vcpu_features(struct kvm_vcpu *vcpu)
>   {
>   	unsigned long features = KVM_VCPU_VALID_FEATURES;
>   
> -	if (!cpus_have_final_cap(ARM64_HAS_32BIT_EL1))
> +	if (vcpu_is_protected(vcpu) ||
> +	    !cpus_have_final_cap(ARM64_HAS_32BIT_EL1))
>   		clear_bit(KVM_ARM_VCPU_EL1_32BIT, &features);
>   
>   	if (!kvm_supports_guest_pmuv3()) {
> @@ -1688,7 +1689,8 @@ static unsigned long system_supported_vcpu_features(void)
>   		clear_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features);
>   	}
>   
> -	if (!cpus_have_final_cap(ARM64_HAS_NESTED_VIRT))
> +	if (vcpu_is_protected(vcpu) ||
> +	    !cpus_have_final_cap(ARM64_HAS_NESTED_VIRT))
>   		clear_bit(KVM_ARM_VCPU_HAS_EL2, &features);
>   
>   	return features;
> @@ -1708,7 +1710,7 @@ static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
>   			return -ENOENT;
>   	}
>   
> -	if (features & ~system_supported_vcpu_features())
> +	if (features & ~system_supported_vcpu_features(vcpu))
>   		return -EINVAL;
>  

The following check at the beginning of kvm_vcpu_init_check_features() is redundant to
the check here. We can drop that in this patch or a preparatory patch.

static int kvm_vcpu_init_check_features(...)
{
        /*
         * This check can be dropped since the same check has been done
	* by the followup "if (features & ~system_supported_vcpu_features(vcpu))"
         */
        if (features & ~KVM_VCPU_VALID_FEATURES)
                 return -ENOENT;
}

  
>   	/*

Thanks,
Gavin

