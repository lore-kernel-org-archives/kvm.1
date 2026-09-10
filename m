Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41D37A821
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019599; cv=none; b=tGYUmT5VGE8DiNGDiWa1MaumTUec+o+wNX7y2pRJnQeQ9Z+4NoHS6spQnAJYwYSz+kWlGBc81Cq8HjvTsYnteCsNxzsVfIt5W+U7u7oWJLjikWulae9Ok16x3rBW/HZPwKoET+mGPl05Xstot4ou9EeoCCboH0Q5gQsYC89AmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019599; c=relaxed/simple;
	bh=H0YWLVNt1VspJyW++/mL2xiGGQ1f0zXMz1fyGHmQyZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOrYexGSgT3CR6O9I3m4WbZwMTsaQnU+NihUkEmd9yFf0Vd2pFOij2jYbdoh27+hyjtHgBFw6cLKYeJuUdoef1jTxEnEXLJ0YE8Sygpo+eILElWeSWEv3AtF9jn5XsB8Ow6mylKRAgwuBEvTX8TyovbSOEvknyH7SeaY/iEqNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YL6xqdsf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kl0upvzk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL6xqdsf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kl0upvzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789019596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMvkKeYrjNymKP3nzuev6PMvw+A1W0w+cadnXyWgZ8s=;
	b=YL6xqdsfu3wSii8TSKIcYYLnf7o/aCHfaKwYd66rfmHv1SbtqK4z8NNOWJIzJq9YXmWBrW
	788biDknj/LrErgK1ysDLOR2JnnsGNmsbn7QyR0rN+/kvO0h5Ag7Xq6Ge3DfFkM33XuUQ2
	0JPU1/3s4gjDofFxz0ZY2b/fSKJVSlk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-cOgVyv6uM-aFshsLVouUOw-1; Thu, 10 Sep 2026 01:53:15 -0400
X-MC-Unique: cOgVyv6uM-aFshsLVouUOw-1
X-Mimecast-MFC-AGG-ID: cOgVyv6uM-aFshsLVouUOw_1789019594
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso6508723a91.2
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 22:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789019594; x=1789624394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aMvkKeYrjNymKP3nzuev6PMvw+A1W0w+cadnXyWgZ8s=;
        b=Kl0upvzkNScSvwSVY8x5ZZ0PSkVpt14VtcO/p7EJt2gwvyTmOqyI8AkJ+4/sQlyDqu
         IaGT2CcO9+RD7o8Qq/0yXPQNVrxeU/fGgx12f+GPBjasMGJYXTKsjZzZvwZ1ufTCpW0U
         vRIMkjWIXp3cOJaX5EUplUPSuYjr6LI1+QcEqL+n6SmOdRJM5/vf5Cyxv9Vs4eZbKEfg
         GXcTZNyktRkqEClIjQ+VOaBlH8SQBZe5PA2+sWXemjwdpLzhjQK74ikuYeaQNpjOa001
         Y7giqkjk+rNXt2PvTztsqISwyJrwFDSdMf8HgwHJ4U6UPE/1CjGQk94oQDDhvtIigWJh
         7j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789019594; x=1789624394;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMvkKeYrjNymKP3nzuev6PMvw+A1W0w+cadnXyWgZ8s=;
        b=iRIcb7zbWDTI2lkZa6uMdgGLQzkfd4hX6m6bNdzaIAS1UMBx3TCXhwKLi2UG3iRfDZ
         yDP34vZ97MJQTlk0aVlVGI50R8tDH0JPke9bKPd0AV+ThGVcS9UH8reLilZoDiHNy+sm
         xZQrvYUpy5fjWGhaH9JlLQFpD7aMHFXCM0zCbfOv9wricFKM8z8aG181o7SOh2ULsQMd
         OUbqDhH3acooeB9ZIMZbbN42KmefFwOkP2NmABADVhrKEMI1vWQMaf2nzIPZzDhewVjF
         E6fynxi2ET9o9Iuo5NOzF6AF9v9prD9m7vC7xow8IjpoDzf/b0atXqtONfUVi089oDB/
         lH9A==
X-Forwarded-Encrypted: i=1; AKwUvBzwqWNQhBquArG1wdlTreOuc2i9t1dG32fG92GjJFJbpZtQDp8mO71vjVZeZ+TJ+LSUHMY=@vger.kernel.org
X-Gm-Message-State: AFuF++kUgfOx0mUuAqp3s+kB+gtlhXb9IfXDL82ElmuSK0tqK70KZc8Z
	2ZEmLx0ySgC8LUoEGiKAGO8bI09DvSsa7ASCpWjF2fGjyWY2uZMkZBAYhrYgBxGga1EzhsM3lzl
	GZhX2nMKLm0hNzEilLtVTnJxeHd72f+vdY2hxMTYiZc+wWDr+drukAw==
X-Gm-Gg: AYBFou30dR+btuwQUc3ySewCggcuK2pUG1Ae8I6s/V2xgrRzwC0xWepqXezyoekMWyi
	PoTUPgGq9VyHn8MjxvJRRRb6hb/O9ohAn3O1s0jALcMoo8V99lk9NYsXpsv5gEar70NJdNjKrxB
	5GHlPkBgpQTsB8M2WBRKvvqdseuaGuf+3kx/TAY00sg75wIeNwiAxXz32ajINXbjUn2aDEnORAE
	RsEVxzIY46fOmisXq8QYN3aFBZGCZFvIvlHtlHKtvy8JSFr0aQZiHn6kqa2zWHCDTgBQ+bLh1yu
	OZFv09Io/K8meabNGFXc/72EsVaNIRQmw9PleL68Qh8oLf4P66hp7VFNK67R6sC9/tOTG4cTJdd
	DUIpdJTmGr6hDYQpzOnx2/Ce2eJL9DffJTaxsTA+Nuw==
X-Received: by 2002:a17:90b:5905:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-39b262133ccmr56583386a91.18.1789019593821;
        Wed, 09 Sep 2026 22:53:13 -0700 (PDT)
X-Received: by 2002:a17:90b:5905:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-39b262133ccmr56583277a91.18.1789019593097;
        Wed, 09 Sep 2026 22:53:13 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bae615657sm2525614a91.0.2026.09.09.22.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 22:53:12 -0700 (PDT)
Message-ID: <e66698e1-e582-4ff8-9881-4ddda5bc1d94@redhat.com>
Date: Thu, 10 Sep 2026 15:53:00 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/20] KVM: arm64: CCA: Add a new mode for supporting
 Realm guests
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260908162223.1683432-1-suzuki.poulose@arm.com>
 <20260908162223.1683432-7-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260908162223.1683432-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Suzuki,

On 9/9/26 2:22 AM, Suzuki K Poulose wrote:
> Add an explicit mode to support Arm CCA guests.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 3 +++
>   arch/arm64/include/asm/kvm_host.h               | 1 +
>   arch/arm64/kvm/arm.c                            | 5 +++++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 68647ff4bdd24..1afe3df3b923e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3256,6 +3256,9 @@ Kernel parameters
>   			nested: VHE-based mode with support for nested
>   				virtualization. Requires at least ARMv8.4
>   				hardware (with FEAT_NV2).
> +			rmm: Support for running confidential guests in Realm
> +			     world using RMM, as defined by Arm Confidential
> +			     Compute Architecture (CCA)
> 

I'm not sure, but 'realm' would be more appropriate name. rmm (Real Management Monitor) is
the term limited to the firmware to me. Besides, we have been using 'realm' broadly in this
series like kvm_vm_is_realm(), kvm_realm_state() and so on.

   
>   			Defaults to VHE/nVHE based on hardware support. Setting
>   			mode to "protected" will disable kexec and hibernation
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index b2e99c5cb1cd3..31ae9d8d8e92f 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -69,6 +69,7 @@ enum kvm_mode {
>   	KVM_MODE_DEFAULT,
>   	KVM_MODE_PROTECTED,
>   	KVM_MODE_NV,
> +	KVM_MODE_RMM,
>   	KVM_MODE_NONE,
>   };
>   #ifdef CONFIG_KVM
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 9af3bbb2f8c24..50f0adfadab38 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -3264,6 +3264,11 @@ static int __init early_kvm_mode_cfg(char *arg)
>   		return 0;
>   	}
>   
> +	if (strcmp(arg, "rmm") == 0 && !WARN_ON(!is_kernel_in_hyp_mode())) {
> +		kvm_mode = KVM_MODE_RMM;
> +		return 0;
> +	}
> +
>   	return -EINVAL;
>   }
>   early_param("kvm-arm.mode", early_kvm_mode_cfg);

Thanks,
Gavin

