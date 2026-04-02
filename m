Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BA2FD675
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152942; cv=none; b=lNFfDLkxH2lM5VYDEbHXoBavLX5OFSu7GFxE5wjf+5Y5XdDj3q/3//krd92NaKBbKAwdgI2UtOoJehf9ZIHeBYvXRYCxPA56R4PvJxFVFlpYy23FNUDWiyFnzbKD8XKbOHFKFAUq3Hl2czb3Ndd65HBfyq/IIm2Hv1DGQoOHqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152942; c=relaxed/simple;
	bh=TXDzP/osUqzqvRHn7KTQyS7zwbfOQfMu9RutzAf+uP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlZT1qBR7z1x4fKnxoqlyXK310YoIFB1EqH7JFkaIelPSYLanke6OiKdypIJPk32IOIQOStsPla+067ufA6ymybt0Gp/80Qs/LzTJZr7Bt2EdAONNEm2KrFF/Wf3arkutk5REEOGRR6rhzOu1ELQoP7Qeb3DAmCo8vrKEt1URWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MDSrkoMQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDSrkoMQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483487335c2so11750505e9.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775152940; x=1775757740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Cqd02rloH4qWYkodiVboVkNgAG3Np1UDG5yCBlvtX0=;
        b=MDSrkoMQShCVzRvTMHBGaX1frU1WyTjCq/V5uGh1zOKYTrH3D+JXCR+MMLR+awU7bx
         eautEcsLhRz6JeeVc7IKGNCe7mDCscXZA7zZvWz5nvPvXcppPV7EmXw0TH+jClZrxNBA
         goF1QJrXn3oAqc98AMs6EkMdojADIOe2iqIC0xKxOmRbc43EkAlW+r2+eZBrOXE+yjK0
         K2yBtdqEoCyB4Gck7LHOeya6hX8O44in1RRyCOzEa55nujMQ/Mb3vQM1GmuGVHRnQ15F
         JDozzKPvD5snupCh0e98Dni3FjkT2mEaNDE4ODOZtvpZSs993zNkHdLGwrd/1CPCDKEr
         0Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152940; x=1775757740;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Cqd02rloH4qWYkodiVboVkNgAG3Np1UDG5yCBlvtX0=;
        b=BAs/hX89hbfDephazGDY+C29MLEEtt8MebpMmmRH55ljxYWpcb5DVPi1JRq/elbrqq
         K7ND9hhKVndXTO7wMZAJ/c4kWIj/oxfbDi09i93tBL45buexi0ndZU0RXGN82532F9vv
         OMZ56Y+Z4J7hnlUs/Qmhm8cO2WbBfKNYPwAzhXMxP270eYQOTv4BgboN7PZ1e8RRyKQR
         mSfKFR74kVJO8CZ+IBgAMSTK53CAJtVtaltE/wNh/UF31HPcmEXsPHBAcm3pXUt9m//0
         7xFD+MnM5vrev6vGxLAZdc3eo5TObqT7gFxBQalfluK/lM4J3kljDSypf6pZDUAWA4J/
         vknQ==
X-Gm-Message-State: AOJu0Yy0Qiot3JsJ64R6qvGRIF4AJJ+wPlzaVh7G04yZt8esfmFRg/9t
	/pgsp5FJqMCu2PAYmNZuhJqMd/gX+9lc2Zsh7FlPJPASTUA6Wb0/gQp6DyO14Yco7Qc=
X-Gm-Gg: ATEYQzwOUOHYw/DmNkEM7LC3P+XatR3VgCAjlVNcTXZLeYriq94SNQZHQse+YxGuv+1
	5rNmEheM4nNEOh2k9NlS4hPvRNpyZVNwBDM7DCJDsKSlO8nRkNK0MMkTbodCURkbgpT7Q0MBQfe
	tLzCfW74+rVpP6Gj2ZFMBgacA2dNe/3kl142p2z4iBt3Bc9nDtEo6taDfwQWB7FSyOi8tKmUbLy
	wZxT/uloFu3R8S5mnwYxg7Z6E6ejQcEZtAcA/i4rmjc8qXsSaO+xoDvVWfhXawmG7DDGnxmIJcC
	NZF/Unu45RdsVynHGJ8+v5w/4xAOR8ZUZfmKZ+Y5QW68Jh2rRJe62UPp62a0KsyBZJI1S50B29S
	POH9G+tdS0gyPAGri9SDVtAn3Yvj4OGwwgdsbImLs5YH/t+HG38qpYGBduDb2Whlc4rwlbzabwv
	+F1RQlBnehau19yXe+NxlJBduv86IixwG4JFxSVfKVTfBROydDZMq16/DTy9mC4sL3uw==
X-Received: by 2002:a05:600c:4e88:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-4888358809emr146323355e9.11.1775152939887;
        Thu, 02 Apr 2026 11:02:19 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8ee2d3sm74726695e9.32.2026.04.02.11.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 11:02:19 -0700 (PDT)
Message-ID: <66240c1c-07b8-4faf-84a4-0275d772b82e@linaro.org>
Date: Thu, 2 Apr 2026 20:02:18 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v2 4/9] accel/kvm: Expose all non-target specific
 declarations
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260402170434.94783-1-philmd@linaro.org>
 <20260402170434.94783-5-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260402170434.94783-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/4/26 19:04, Philippe Mathieu-Daudé wrote:
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
> index 9b722ad931a..c33fb160b5b 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -225,9 +225,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
>   void kvm_irqchip_remove_change_notifier(Notifier *n);
>   void kvm_irqchip_change_notify(void);
>   
> -#ifdef COMPILING_PER_TARGET
> -#include "cpu.h"

Prerequisites still missing, sorry.

>   /**
>    * kvm_update_guest_debug(): ensure KVM debug structures updated
>    * @cs: the CPUState for this cpu
> @@ -450,8 +447,6 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
>   
> -#endif /* COMPILING_PER_TARGET */
> -
>   bool kvm_arch_supports_vmfd_change(void);
>   int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
>   

