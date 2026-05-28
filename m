Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909823F0A95
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973999; cv=none; b=UR8iGmBdMQb2bZdiMlYbHDOFxcjVN6CThdtasCxDvDms1IxcK/yH7T7942GkvZmcKnOM03UTiS3K1sjU55wV3jO1oiUWbuDJl8p+UJH0bbioAkwZs6sCUeT7Txr6X1atzUcxM+vk6GMZt/N7oOH4J3Cn0L62G7eBVOxCuxu7qM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973999; c=relaxed/simple;
	bh=TZLmQ/KYY1udKoBKGzp70J/oplmxxcPGnNNgRx6uJ8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TrSb9FVIOHl9bCxTgiKvwwEdelLZQc9I6cJXTS1xe25wWqwSP8x8S3hNHM6ZH7VWhjMM3duj125rNfC9HCJ2/KXKBiHiZF1pMnt8py5mYQyA0QJxP3ovAnc1alHCme/7kEUiFnzm9xF+D7FxEeia22ZFsvSXnkXbDVQNANKVx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SdeiiZeU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdeiiZeU"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c828659ecd4so5764338a12.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779973998; x=1780578798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0iI9c87twl9a+8/4I6jTFHT53Suni3Jvj4xWPyZqc8=;
        b=SdeiiZeUSBKfvBWxEyDLQkTGT8MvwomAWsT8XFQ3dpj1QICxfLFjFHZYkZ7aDWjGcY
         VCcYtVeqqyVgs2RgEJYc/LWklMhyCnB8FPME7nU8EHVE8tGfvDMZs4fhgnEDylbqXOJU
         +dLpWV45ec3K3C4cRTO/2o5m4D6AznfZGRIDXVwxJudqD3MHOGPk9mtLOHBTxE/Mert/
         rgXFs3a7y3xiAPHwTFuj/HMKIIE6UK1r5iYYsE17yIbBxaw531hbQjQTFyHVkMPHORnK
         9Lwt0qXSRvL9zXlqmfw4Ra3F2fiYVo5wYfGPEXSt3sjwYX5cUP959IIus0nuGlsWm5rJ
         qpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973998; x=1780578798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0iI9c87twl9a+8/4I6jTFHT53Suni3Jvj4xWPyZqc8=;
        b=V/HPgnmENKhSQr/YBBIMH5cIzNVnp27qJBRRtGFvemV5vkmJLXP8GNvmF2FpwIfpdV
         7KJgw0K1wFXvplARphZ6d+cxUSAzxp3LGva2pbzaBvPTzqLzXR5ulRwST2msGiQz+acr
         WcgP3r0bcjhNgBgI0+KTdc+ts1uQkQIDTIOWp4XToFVKE1s1J7thMfmAE09Jl7Fj6s7e
         qv212bxLr2nzU5KElLkaC7bPKA5ug/jAnGKltLkAXoglvJpyX2DcQvh1Y6ocr9dwuvBh
         yPCDfHXyeE4OJ8WYO1GsXjBDzIwPp5cTUGsBaayCbArvIgo0fstJGM1ZEmUYnZ75iIwH
         aqEA==
X-Forwarded-Encrypted: i=1; AFNElJ91ku0UQnEa25ehWY7Eu8VvzIvXMKX5FqvUfe7wfWHHjXFC4CllCS2N4NlGfkTtd9IYC7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylO6UDc6PSkyIvO/gIqZpPHGD3BzXBc9oU+AWFYWpQh2Sxtt9r
	iyJ5+b1JHnrK6hErkYePMOXEK+/rXltG+IsjPjwqax/yjuQR1wXnZPwx+2FEEsZDsbPoNCN9+OJ
	eU2Jw8A==
X-Received: from pgvt6.prod.google.com ([2002:a65:64c6:0:b0:c7f:cb0a:3b6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a06:b0:3a3:90d8:fd7f
 with SMTP id adf61e73a8af0-3b328c3af24mr28729183637.8.1779973997582; Thu, 28
 May 2026 06:13:17 -0700 (PDT)
Date: Thu, 28 May 2026 06:13:16 -0700
In-Reply-To: <20260528094542.2529735-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528094542.2529735-1-piotr.zarycki@gmail.com>
Message-ID: <ahg_bNoktd0XOKV8@google.com>
Subject: Re: [PATCH] KVM: selftests: hyperv_tlb_flush: use swap() to swap PTEs
From: Sean Christopherson <seanjc@google.com>
To: Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, dmatlack@google.com, 
	vkuznets@redhat.com, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Piotr Zarycki wrote:
> Replace the open-coded swap with the swap() macro.
> 
> Signed-off-by: Piotr Zarycki <piotr.zarycki@gmail.com>
> ---
>  tools/testing/selftests/kvm/include/test_util.h    | 2 ++
>  tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 6 +-----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index d9b433b834f1..a66bc9ccba65 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -26,6 +26,8 @@
>  
>  #define msecs_to_usecs(msec)    ((msec) * 1000ULL)
>  
> +#define swap(a, b)  do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)

This belongs in a common tools/ header, not in KVM's test_util.h.  I don't see
an obvious place, maybe tools/include/linux/kernel.h?
