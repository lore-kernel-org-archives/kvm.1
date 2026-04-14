Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA92798F8
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158146; cv=none; b=h0Xn6gbhDphSE21e0QZOiBhDYz/7WQ3l80VPOpckirw52HtX5kJN91RFn0Xb6KF4gP3nA/7I/QlIMxGqz8n5C/OwdgwvZarbGSxLsr/BWbgraUDn3Xkz7pkiQBNJCZxNUyowNL+/4oHhBiu92Bwmx62qJmnbSI8hBTev9noYpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158146; c=relaxed/simple;
	bh=y5ZFOgUkzzgRbDidAMBukcviSU6qnrq1ANla800OYa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gc7qyrRsJHtZ034uBSs3iv2aSvkwQ9Fh0ohrLpSGiPwL9a+mYRMBLXreFZgbUgOGnu79e959QJvACo8TQIfxkDif5jUFghPDlvc89d+T8jQc1Yn1Eqpjol6/axN6iPiOed8TxWdndqyATanlBIPlOtWO7YZVch5hLZlbfE7WRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGDTp5ly; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGDTp5ly"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf5ad500fso4557389f8f.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776158143; x=1776762943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCk4HcphTywuTMhaSHp2v2iLapMiZxwN1A2t9mpTSko=;
        b=EGDTp5lygxcdWZDct+yPzGOTA3TQxxJU3ptaUrK+hI/yTtNvxCQH48rkTNz+sn6Vnl
         5vDDLjQNDMILRPyd8BjhLtqLPmzVp66UpRYROdrXaZP+QHzGn4Fd9IcL84gfT3UYXmBk
         KH9BrP62vAngqXCSf7cT7HIt8QJujiZ1eggQUUKgYrAOdtVk07TqE2YtdYe+hrJdutRh
         F6qZPA0yZ6XwwRdlZZuhzDN0n7vA+scCkn/kJ85RYqmYTjXAPrNmu48KiCyE+lr5Z7kt
         SQbWz4I5QrM54+6eGi002Ez8V8RxWvxQmd0nPi20OfJPmAd7pSiDudAbNEGjwfevz9Ep
         jLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158143; x=1776762943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCk4HcphTywuTMhaSHp2v2iLapMiZxwN1A2t9mpTSko=;
        b=lAgPnBNhZn6Y+/n7mRjoDQ+2oIfzIjRW/AB3B4KriQ4i4LXlpJn+Wz8EwHU00mXlcX
         9wWnWlDdP3PBfh0ZZSnDQWY6wii2GLBfW4gAy9To80H2lQZisUDOzCDhv7M4IrxtpFR0
         Ve+8GHMqP5qP4ncGz146P77hKljkdugDB0w2N6oD7gR19mAVD6E2tqOr8tkU03Q4OgLq
         t6eMp/q+zerua8WhsE69F11/0dMmXmRGhfb7eMeWAV88xTwFRZFtBCdpSqxFSPs5y3st
         SmvOQEgvVM7lYPqKhXegqsm9HSLbiw6HlWhMCC6zNb81/Ap/85DAmGAZZXYmtYLB4inf
         Lr3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8I8Seh+cgnrXrIYg+w3N/gf+llf8gyBcqUGYXC/7Gqzlw9Co90AL507KKCRxSSmdpl0Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMS5lsuE87t9VbDI6mgz1pyGwZ9yWDEZgH05A+oiZO1QStHuc
	vNUa2c9qd7igyC2hb0pKSONYj6S2F2b7tf9dWB3SmONXGa0HadMhTB7uml1w412sbpa6BKAbG5s
	ufk/78hg=
X-Gm-Gg: AeBDieubvAwoPgenRrbZdUnnvJrWIZJDAoB0hOHuuwOuPD5AlUrfFKNzvdg4MnTN8Zn
	MA5qVQqiNjvKvRFr1APcF6byKiUvHypfz68llHhfg+9PMX7i+GlR2bCKZGIFArwQEpRWPclKCwF
	soMk91o7zii+dCvf6cIWl6O0uMGb51/5PL4Hnhbv5cM+qYfE8mNJU5rPd39TQK8gbeHu+bMrOuw
	ku9r2/R/fNBgROMGiKQ5Q7ClUmUy/nRbV2xLdaN8VUUFcMYeUn9GV0qGRvr8Hg5axKZQX3sOW0B
	4vAUdbccQYg61lXqDU68PoFJ2KpKBT+PN2vEVoMr1HnXHttzi3ymsOocptO90KuTg44CEOspyNj
	K89aCG/7irj5iLUc01l2d+AKCS8PBQqeAxG+6kMsXRgmmtxhtouQNxKWJ5Hjkps3fTpqe+F33Bh
	uHvVJlfF+4Q4EY+/dmm4eVTs5rd4FWRZJWzaD4Sli+36OGTP7LrhAVoSAmr8ZXvMfmYg==
X-Received: by 2002:a05:6000:2383:b0:43d:7946:bae6 with SMTP id ffacd0b85a97d-43d7946bbc0mr9283257f8f.43.1776158143218;
        Tue, 14 Apr 2026 02:15:43 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a53sm38868373f8f.5.2026.04.14.02.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:15:42 -0700 (PDT)
Message-ID: <825cb787-b782-447d-90cf-d950d78e1cbb@linaro.org>
Date: Tue, 14 Apr 2026 11:15:41 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 v3] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20260414045911.63662-1-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260414045911.63662-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/4/26 06:59, Ani Sinha wrote:
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required essential
> capabilities were not present in KVM. This was not translating to an early
> return from kvm_irqchip_create() as was the case before refactoring.
> This is because, do_kvm_irqchip_create() did not have a means to notify the
> caller of the lack of required kvm capabilities. Fix this by making
> do_notify_irqchip_create() return EOPNOTSUPP error when  capabilities
> are absent and then the caller can check the return code and return early.
> 
> Due to this regression during refactoring, all KVM guests on ppc64le hang
> immediately during startup and this completely breaks all functionality on
> that platform.
> 
> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Message-ID: <20260413090010.60339-1-anisinha@redhat.com>
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> changelogs:
> v2: refactoring included which will resubmitted again for 11.1
> v3: basically v1 with tags added.
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f..92af42503b 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
>       g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>   }
>   
> -static void do_kvm_irqchip_create(KVMState *s)
> +static int do_kvm_irqchip_create(KVMState *s)
>   {
>       int ret;
>       if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> @@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
>               exit(1);
>           }
>       } else {
> -        return;
> +        return -EOPNOTSUPP;
>       }
>   
>       if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
> @@ -2610,13 +2610,17 @@ static void do_kvm_irqchip_create(KVMState *s)
>           fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
>           exit(1);
>       }
> +
> +    return 0;
>   }
>   
>   static void kvm_irqchip_create(KVMState *s)
>   {
>       assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
>   
> -    do_kvm_irqchip_create(s);
> +    if (do_kvm_irqchip_create(s) < 0) {
> +        return;
> +    }
>       kvm_kernel_irqchip = true;
>       /* If we have an in-kernel IRQ chip then we must have asynchronous
>        * interrupt delivery (though the reverse is not necessarily true)
> @@ -2835,6 +2839,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>       }
>   
>       if (s->kernel_irqchip_allowed) {
> +        /* ignore return from this function */

No need to explain the code. If you want to add a comment, explain
the "why".

>           do_kvm_irqchip_create(s);
>       }
>   

