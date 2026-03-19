Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEB3C198A
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917617; cv=none; b=eQl65dovhO3zsAVXh4jKLE6W2OwZ1Et31jQaton+TudD9lBgIll52jFTYhqjOEeO7g9FZuQLyryT8RHL7WaikUJ3xPIikMgCCRgEZW57691M2BDKFZV5dUHJagHGAHgFKr7obzMYMOe9ZwJ9NRHWB+ibZWj8ifd66B5UQtj/+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917617; c=relaxed/simple;
	bh=wZdcKtseF4v5/aje/4Jl1GdjqDwZtEcyiGnhwepIysw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjhOXdf/3DPUqHIV3YqZwysuoqqdLXu4+OsUNe3x3cbTijhbJHGl3wuHD2XuVuQJTXwPDmlMLnYVqK9KNDXQ/JH0QYGexxd5ujw9GusD1HPPw+s4ViKjtma4vLlXZHM0zUkW4YMvU0HJO1edOy+T3PsWgADG2+5aXqco8DCrIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znNz60Wo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znNz60Wo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so10534735e9.2
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773917614; x=1774522414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EgVWOMJC7tDyrxkwGCDBHNk5vLVLJUqeljIhIXgn3Yw=;
        b=znNz60WooebW9QklH7azqRuvPgCX7jZ1zTw5TCyPctSyJYuG8wXdpQAc54DKN8wXgI
         7+5Qr2t6z3ptYW2d3Q1Ew5IykWMwK70xGVQSu6LIn58KVTf9JMV+K8Xq83JQCWMYq85J
         K3lp5CRQr+LI10ObZeTVGgN6/KNyjD10Nwovi5Krn0nix8XQcmO6UwVj3G5EO7HpgiH+
         T0T9NnNSd5AtZ3R1gMp0/NU49yTuftC/kJHhfoDGzrZgI8z0dqKCRb1upk6nA0ulDbFn
         GjxjpD/mRJr00HLaomawfRj7dYUNP4hXvceE5YAfUsfz5++Nxr7DnEH1cJxQofzB10j0
         sUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773917614; x=1774522414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgVWOMJC7tDyrxkwGCDBHNk5vLVLJUqeljIhIXgn3Yw=;
        b=NIRcshiOzLGOAtZpE2LpBW3DR81cHYfM7ckzWiYpY5WnVYkG3n7kYMqObrsLsRKMHS
         0x17lLL0dm3KZGC3Qj+3wzUTdDFJwfVk7ur3YUuh51hO7K4GpOQrMGBRuV37T7SDu+a1
         t6o5vHgWwcIv/NtryCTOa4zRt910LGAxVrdn4VM0leoudjkpcSIh15EnWBwXyCcFN2QD
         nzK5sct10mMbUPSPCI/u3SHfK3KZCB53ddQHkBrUAjQrYiO9FMm/Ez4T5Q0yDhMiLfkq
         iaRUhprj5WTwHUGRosqV7085bzaIFpz+6l5mWSAgMiCLl81VZZD2r1v6m/kB3KsZxeXF
         Kpgw==
X-Forwarded-Encrypted: i=1; AJvYcCUw8rW//rD50R9KWXdYvi4PZXd0AIqkNxU6TX9x8nBXOewwm77zPrCaAsqbrry/DlTUiIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7pBmGInKjpBHmP56m016ZTXeaYSoMTJqAKKdllDgdPLkg0iBK
	4H5Sa5IQ49u+Op63H18e3ew4HkaokEkWw9crYTH23OYR1WrSIjC7z54JmSx0neG79uXOeeU2/Xi
	1XL0dsE4=
X-Gm-Gg: ATEYQzyA1CHnwPwuFMfejdQmxpGmoz8G5Kus2OR7kyOmtjdeVYRxNPLYML/42YKebBi
	8uNxdL4La+Uen5wX4LHM+NsNcZK1oC/pQ084ZO3uEw8kAvHH1e42O+dJOQEIEQFAbmRUs/90YXJ
	HZtp3DhDYi9el8v9tl6MGF+dsBcdFob1iRgq3JXuU2vsHq7XL3uGJXvoE67gk9Bf+IMKAjZh8r+
	L/+12TlqiM/Y+fLQlOUmSyzkRSLD7ltiwRj3cBm0SBF5+gxyAkBboZ65Rq3653j9FQvIa7QSEwD
	tJsV9lY5U8EGg1/T++gBuxOV0akUcREmzW5sQvRQoJkuSCl2Nm7dU/2LK5VUK5BH0IN2lRXLZAf
	sdsLs5DSw5agNmFzU7AR3YYNFrttQNSjzZYqSRIjF8If2G/2Xx5YG6xpgEmlJ+shXKUL61IoDd9
	GFGR79FpVqcpLq4dH7AGsCSonzNgI+C9L4Xd3OfzYNuUguLsHPdPyZ04MQOY+WOk+k5Q==
X-Received: by 2002:a05:600c:5742:b0:483:703e:4ad9 with SMTP id 5b1f17b1804b1-486f446d066mr81640605e9.19.1773917613894;
        Thu, 19 Mar 2026 03:53:33 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c40ccbsm100353605e9.9.2026.03.19.03.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 03:53:33 -0700 (PDT)
Message-ID: <d616ab91-3cfc-4a77-83db-23ef16a00d49@linaro.org>
Date: Thu, 19 Mar 2026 11:53:32 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 2/2] i386/hyperv: add stubs for synic enablement
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Michale Tokarev <mjt@tls.msk.ru>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20260319101128.116301-1-anisinha@redhat.com>
 <20260319101128.116301-3-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260319101128.116301-3-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ani,

On 19/3/26 11:11, Ani Sinha wrote:
> Add a new call hyperv_enable_synic() that can be called whether or not
> CONFIG_HYPERV is enabled. This way genetic code in i396/kvm.c can call this
> function to enable synic for hyperv. For non-hyperv cases, the stub will
> be a noop.
> 
> Reported-by: Michale Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   target/i386/kvm/hyperv-stub.c |  5 +++++
>   target/i386/kvm/hyperv.c      |  9 +++++++++
>   target/i386/kvm/hyperv.h      |  1 +
>   target/i386/kvm/kvm.c         | 12 +++++-------
>   4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
> index 5836f53c23..767a4c7e1a 100644
> --- a/target/i386/kvm/hyperv-stub.c
> +++ b/target/i386/kvm/hyperv-stub.c
> @@ -61,3 +61,8 @@ uint64_t hyperv_syndbg_query_options(void)
>   {
>       return 0;
>   }
> +
> +int hyperv_enable_synic(X86CPU *cpu)
> +{
> +    return 0;
> +}
> diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
> index f7a81bd270..bd3c26d02b 100644
> --- a/target/i386/kvm/hyperv.c
> +++ b/target/i386/kvm/hyperv.c
> @@ -24,6 +24,15 @@ int hyperv_x86_synic_add(X86CPU *cpu)
>       return 0;
>   }
>   
> +int hyperv_enable_synic(X86CPU *cpu)
> +{
> +    int ret = 0;
> +    if (!hyperv_is_synic_enabled()) {
> +        ret = hyperv_x86_synic_add(cpu);
> +    }
> +    return ret;
> +}
> +
>   /*
>    * All devices possibly using SynIC have to be reset before calling this to let
>    * them remove their SINT routes first.
> diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
> index e45a4512fe..a393a5d428 100644
> --- a/target/i386/kvm/hyperv.h
> +++ b/target/i386/kvm/hyperv.h
> @@ -23,6 +23,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
>   #endif
>   
>   int hyperv_x86_synic_add(X86CPU *cpu);
> +int hyperv_enable_synic(X86CPU *cpu);
>   void hyperv_x86_synic_reset(X86CPU *cpu);
>   void hyperv_x86_synic_update(X86CPU *cpu);
>   
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index a29f757c16..9e352882c8 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1754,13 +1754,11 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>               return ret;
>           }
>   
> -        if (!hyperv_is_synic_enabled()) {
> -            ret = hyperv_x86_synic_add(cpu);
> -            if (ret < 0) {
> -                error_report("failed to create HyperV SynIC: %s",
> -                             strerror(-ret));
> -                return ret;
> -            }
> +        ret = hyperv_enable_synic(cpu);
> +        if (ret < 0) {
> +            error_report("failed to create HyperV SynIC: %s",
> +                         strerror(-ret));
> +            return ret;
>           }
>       }
>   

Why not simply add a hyperv_is_synic_enabled() stub?
