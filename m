Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FF286D70
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791253534; cv=none; b=RvEM4aWlujqGDTXNZy4Zkbn07NqB7FJJLSvS+x6Tcfr9F/N5zKP+BsWDC26dKUC7zBEK6bGvCuftBwwYUTK4T80VSWEWKs2aqv772aPowyeN56AYkUwnaHpirLUbmDMiIy8R6AVaEPvXaGmCLwMycweFLPMXPe/2uvpMPybEDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791253534; c=relaxed/simple;
	bh=QWAFFhzhcemt4JkAXvKSQU+sijmwJ3F9VG6lkevDJYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U82ncsGw/C+MAGZ/84oA9Ze3crJw/jKeMh7KLw6i9gsZ5my2qn9okN9rlPgdseQBDgdebzMT24OXyO+A2Nd2OTMsf4P+Z8SaxD+i3PxxyscLU/HlpYjFZA/URf4yp8tC/Yig6pRHnrvnKnmuTAA0x920SySAxwKKs7ooBQUWPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFuSqM0k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBhZ69jN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFuSqM0k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBhZ69jN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791253531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugMxefZ1qIEDU/oRAsn8b/LDZMC+9ePrF31NK37FBF8=;
	b=SFuSqM0kMRocs6bRvUTeS3WzPdsf1Gp5DotSQLJkYsDFmxv8HeU3M21S1hHfdkiI9/IOyl
	sfEAgEWf7Xei3ojQG/pMjWUaNC7eR4EF1STdJ1AVYF4xyc2qQbF/jGHw6ZqtLfbQ55SuQq
	VUITBINIeeTA75W6d1yvFkGIwWxcV2A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-PbPyUUpcOJSABqg2kLa8lA-1; Mon, 05 Oct 2026 22:25:30 -0400
X-MC-Unique: PbPyUUpcOJSABqg2kLa8lA-1
X-Mimecast-MFC-AGG-ID: PbPyUUpcOJSABqg2kLa8lA_1791253529
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a470ead068so2115708a91.3
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 19:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791253529; x=1791858329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ugMxefZ1qIEDU/oRAsn8b/LDZMC+9ePrF31NK37FBF8=;
        b=NBhZ69jNhhguozeqBY4TIXOYuFgsBFi4Ps1KTx970EiBEM1DElHXQVhw6Zicvl7uwv
         nRQly9XjVJ/HlSLHMlkZpQunl38/y9kFxlb7PuZXB1Q9EbtUHZ9FQmG5L7FhRDLPSHSM
         T1yUkKiWpd6Zc7gsMtIFjzs63v+E9i2l1+k4z5+naXv92cWbmYxQ0ylyckrXbzQXdsfn
         UfQtykREq3JNjMKB947OF/ivwMRA9LN6K23IZge3EBJW1xIDN4JltJSoCgrKAaTgYNFI
         uvnnu51DysjmGIJ1qyBWCVS0Phb7FxGl+QyBL4lfk1UIZ7R0cPJ+/kn7u9/iraRMwLUq
         wLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791253529; x=1791858329;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugMxefZ1qIEDU/oRAsn8b/LDZMC+9ePrF31NK37FBF8=;
        b=bZ6hbH6vGo/RUaDg6K91XDo1l6pnuSQ5/waqNunn8L5AiMWtLYP+v0OS4eOTQl3RAX
         p1T8rR6dIdgIaH7eAfUYlliBnvSx0NMf8+dvags5S5PURQZ9o3WI1Ph+acujsxmeTk6z
         J7AvN/XZheVMQVISx6szV9eds9MZXfmQ6lZU4/5K1fo4hEbS/IMosHYyzytnA5Mj7LpH
         VaM8ccI/9idT7QJaj9M9gew5ivRZrS0oRU+qgVY0wRE/OT9UOyzEyEJyhbwW+CFSd+qW
         MbHaQiQFOxI0wfFMJag49apfUVrhQ5R7NpRGnyXHPx5q1CJEPT5BNPdAqhxxO9zBjEGk
         PfiA==
X-Forwarded-Encrypted: i=1; AKwUvBxnjY0AQ7aZn5pZe69XuMMJH8SmqXwtDzMP7LWgKdJrgb3Us8lLQZMcMO6UQhVbHZy6RTQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkyxyh2XFqmLwL5nkJgf1iV1fHJ0FakkLTc9JuuAHzPWvO4xJ/
	+TPzr49rZKE9/zktFmhdM3Vvv4doSBfT1H2WTj+75C5OdzHzpLSu9zLgszaRDDpZffp0H2SMQrI
	XEkuZyNDjdUhSFQCTV6aQOhZ/ngTF2q1NcI4RO4s3D9js1GQ09WlFyBXnLJ8z1g==
X-Gm-Gg: AYBFou3EKucKSmmnnXGeFtOR2uKIavRnwT3f1nxLPCUlaRHsYfYf/yANXhXM0Z6f0IN
	ql/j2cWKAW8WB6A8T9R5Dn0vrcrBHCYDY9NiacOsXa5KOcz9B1T1tje1lI3om9SUuU2HH0zr3MD
	iLbrKggPeGDLeALa8W8bOhe9nWNTsxfSDXiNWawEuI456JtL3G6LLxtiDsL4ZV17Hu2Qfv+OgEg
	Hsz2tTM+fkj5h2nzk4Uh6XntIB+clSVlCCliPga2L1a4jyE9PfY/zO6pNwUj9qcHVtsFtDP7YzS
	i25t/pjEf3qQMmES14QgAv8PH6lq3e0boEp+i++Ultt8WzVXq5TXZqqn0n/CWKc3Hp8OBqGO92h
	DD5L/h8hCmNCNYMzYJ8IyNkyKG0GjccKjXa3pjpa66Q==
X-Received: by 2002:a17:90b:2812:b0:3a4:cbaf:f152 with SMTP id 98e67ed59e1d1-3a6cec2fb6emr4459086a91.33.1791253529340;
        Mon, 05 Oct 2026 19:25:29 -0700 (PDT)
X-Received: by 2002:a17:90b:2812:b0:3a4:cbaf:f152 with SMTP id 98e67ed59e1d1-3a6cec2fb6emr4459071a91.33.1791253528874;
        Mon, 05 Oct 2026 19:25:28 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a85388c664sm2351690a91.4.2026.10.05.19.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 19:25:25 -0700 (PDT)
Message-ID: <32c662e1-0de9-44a7-81e5-2b1e6c824114@redhat.com>
Date: Tue, 6 Oct 2026 12:25:15 +1000
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

