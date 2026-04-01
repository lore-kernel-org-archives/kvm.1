Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669853B8BB2
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077352; cv=none; b=nwSG4igz8ad5FanBzvWu+y6H4miTnWJAAb4EvYtrY2C9d6ESAG9vSU+b8Nc+lxjjaszq7ZQLnpfLkfanszJNWGudR9aEHV8W12YUREbL88CFvPvU2ioUU8nQ2cVOCb/axP2S4QBRrG7n+sz9nkLjbbv4VpHONvZpJVhb4Mh2xBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077352; c=relaxed/simple;
	bh=/vuIx1V+G5o+pbSAs+wUn8doNkEqrz0xObFAiDyvvQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxDKslVQoyb1hyGt1rafjb/1fg13OCzEPf+embEQ8bhlxX4XZ3MOaevXTTD3IG2ykJGjOfpZPFmeFZCfaO5x0qNt+GqhLPPShPwq890IuLd7fXnTA+HX1y8oQkkOQ0nSuKKEjJVb3Rlkdsoy7eZkHdNo7vPjoAmIB7eT18rHW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5YwtxKM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5YwtxKM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fe655187so1749165e9.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775077349; x=1775682149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wu484ARXgNjrCXY792DVUqnqI/7zasFvjnpp9c4Q+uo=;
        b=F5YwtxKMd+mxPFVHQvdmK+DkR7mFGVRFJ4yuTbtCdbO/s8JaIumai05wUYozsjwBV/
         Mn4VufeYnG9Q6adttCRt58GcPyCDw0LktQH6UE6sF8RsNM5JgRdO/R/juh3hQHgaVHl8
         PJd96V7uw7QsVTvWJtZbx+aN9VrdT9XRn4U3Dc1akyRuwLnWOSheaipU4g9MGBUnUz2c
         D/rxmutpHH/P/vIflZY7j3iMSEB764FCsa3wklxlsSR4WiBQOZkMec4e867zki2UK1dm
         6kUnHaZ4mMwAd0kxBtoe/G3xAzYA1FD5jl/vV3wbHXewXXBqOoa46OWYHqVWvJwUWmPA
         waDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077349; x=1775682149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wu484ARXgNjrCXY792DVUqnqI/7zasFvjnpp9c4Q+uo=;
        b=sRsjYe7gvGztMoATfxc36P7qHiGW8vG/D50mEVwhuwLwz9fGfEZ9PwGIPiNEmAAkZM
         s8eYFcriuoCxq008yh/t3CiClxRF6kwtYxlKuWtD2Al1FjQoGB9SCw36wv7Uj/rAiOjx
         XNJ/I1MmNm9FHpPaTEV9Pm8Q0k5M2jsay2G3H0+YpxG0cogPk01NkZGgZBDFiZDXTCdd
         Zo0S9IzlEN8+RsqnS83ny88WN4rgdDxVK4Ckrlao0Ilkp+Xwy/HgNvOQWqF03Sk1333A
         ca+n6vvl1K88ruQpAHXEMUQuuhGwJrgG24Oq+Tswj/gAH79cnHPgumhtI4fPV0fGfNaN
         bFNw==
X-Forwarded-Encrypted: i=1; AJvYcCVkk39a91A07FW6MkgUVHXO9MaVWQSA5oaq2nJQOnhxZCnMzacQ9IaD8eI9k1pxKU9PlU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbys8E07184cghnR4cPpYrBD2b0KYnpG3xEWndTESCP2/Oed/9
	tBcunGKOEIf5MeWCbQWlvSjbczofz/q08mH4L+uARvgEvNyTIJewWwm0JgqwqKL7mYE=
X-Gm-Gg: ATEYQzyN7HHHTSRT1dVlkO64muA9ivGCxgdViX5JcoN957IgGnkMLhgFeXKxW0q8ayn
	FJvLdCcAGUosgU49BFfVzu2Rsfrn4dfIeT2j7ZMGRU4EBj4CwtoGQOW+S/ZnJzrPB2cxGGcc6tp
	49oiYrto9ZIY8AjtZ+eLiLM5gT3CEy7LMAId7jddBI3FUQiWbZIjM2pMMW1zWJZSOuRoxk7CgQF
	oKV1o9ln56KJfVVMBF8JrZGCdyLcn68KaEf+Ue0+rJwqCyTFioOFWIjEXp6vO1NXWCdNiNAnqTc
	OHhpU3eaAYWm9CSIzLCOS6uPpMZdB14+WeRtOzX69eSvyIoFvW3ZGG9mTjnj6mJDNO/sNwXYyKI
	MdcSFTXZ3jMdlk5QwTu1uY5zzHYkF2Nv4D+dWaM0Q9zokoSI+UHrikvGX4osRHi3Cj3GzuWhbny
	MVnlrkmsqYjs5ZCPl7mE3ogJs5yXPCezwglT7PM7VQ08+Ri21XlK1NnE/knA2jkOF75Q==
X-Received: by 2002:a05:600c:c165:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-4888b786676mr11650045e9.21.1775077348657;
        Wed, 01 Apr 2026 14:02:28 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888955d711sm41710665e9.9.2026.04.01.14.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 14:02:27 -0700 (PDT)
Message-ID: <b449667f-11d0-48d8-864b-dc17f30a18fd@linaro.org>
Date: Wed, 1 Apr 2026 23:02:26 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 3/8] accel/kvm: Expose all non-target specific
 declarations
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, qemu-riscv@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Anton Johansson <anjo@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260401201753.92290-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 22:17, Philippe Mathieu-Daudé wrote:
> None of the declarations guarded within the COMPILING_PER_TARGET
> checks use target-specific declaration. "cpu.h" is not required
> since some time (maybe commit 4fb54de823e "meson: build target
> libraries with common dependencies"). Remove the restrictions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/kvm.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index a2463a3ac3f..8bf7a10deac 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -224,9 +224,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
>   void kvm_irqchip_remove_change_notifier(Notifier *n);
>   void kvm_irqchip_change_notify(void);
>   
> -#ifdef COMPILING_PER_TARGET
> -#include "cpu.h"

Missing:

   #include "qemu/queue.h"

>   /**
>    * kvm_update_guest_debug(): ensure KVM debug structures updated
>    * @cs: the CPUState for this cpu
> @@ -449,8 +446,6 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
>   
> -#endif /* COMPILING_PER_TARGET */
> -
>   bool kvm_arch_supports_vmfd_change(void);
>   int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
>   

