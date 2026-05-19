Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28563DB317
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227677; cv=none; b=fv9P+CCWgNmQicWMg0ppNcTOIjdsRkprYz2FbimVqITbYW2Qb9R7GqZXx4Ar+UThsoS0CE65qIsjIqkLzrnrMpgJG0Kk2GHn33dxj5jQU3f96K5QjeT4FmMbexYDVEMplTwkLSZ2VPl6aEYYAO6ahLxP2p4PlKv/7IHMAQJSJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227677; c=relaxed/simple;
	bh=y/SW7O/w3accyDkPzGH/G9KJEkTb/peuLSwbLsUuXUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIuIgVJfC2cqueZYKo+dXq95zg8HFyUoJCaQuQ9zev/zgOaI0Hb8Bny8AkfGg+ZC9p+zZq4/4I/wXjI4JGLm23ZSpcnSivOpB5K3w07ErNVMWYVG8cCie6ZqnU9d8CMRHvN1lBnbJbxokzVqcrE00sZBKqqJLaO5vdc0+h44qdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=XbrPR/zR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="XbrPR/zR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso33840265e9.2
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1779227674; x=1779832474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W9k29TOlaIv3pfp1+AbNy7JwKLO9oOTee4JH4iDdWQM=;
        b=XbrPR/zRi4LQvdxC0pGuc/M3bGjFcAUrh+1RVLNxGqhr/VfVUThX0DrUI2WVItMVt6
         H4ri03zLnxEV8yapLV+cjuKO9OfqKSiiVAAn5oZB+riHtQPFCLWPCggrpNn2dxvAH2VN
         ncXPilSv3g41qP4UniuXgSAWulN+0cn6kgQLSW/l1e79tPPGGibUaBemlZgFB6kpoDD3
         6MPt8fSRp5zPa7uupMuuWk8EyEU0Hpxxrl8TNF6Hx0lxtaRxOdfC3YmEgFDvwEny0JD3
         +DkFWDDjOPckpQDGcMIGzoem9vlRHzFiiJGZ+STPtLk+GZkK6sdIZwy1VPFQSTKJb5AK
         SAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227674; x=1779832474;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9k29TOlaIv3pfp1+AbNy7JwKLO9oOTee4JH4iDdWQM=;
        b=kapVRDC5zbZ3KIrLIJTFswr8xxJTxAVnNXa52BZmVPXNowHURRA41zktToYPcZp41V
         X53NdorCTPxK5gTv/ORHT7A/zN2Q8hMcsPO8dl7qqhuvRfXwH6VV+nb0ozWFR6ESnq0q
         RPYR1lpJ7ZapOK9kGLL7TdB/MehnxVH7Wwitgp4JF1uy24JC+49vU/AEEo7VQbX21OJB
         GLOS/83pNEEirGYnOvRcCq69VDGKCIaJ5O5yjz62oIUZPVc31guHCFCC8+yZFv6APYva
         l466cTi54Du2Jgbd+uEee0a2RTBUULlCc/k3/RUH3iOLLNCCLrobqqVZ4Fto9n9G0b6A
         l/FA==
X-Gm-Message-State: AOJu0Yz40EzrLuHoHXJ6mDMBt2V/sB+MswI8CkB+pEHyTZv3UoUIlUiv
	6yDAwGwbZYmx1vHwzEOe2XBvI/GO2v5hi40ZN1n8cEF7aQiTJsrH5zArBkOsCpnCesE=
X-Gm-Gg: Acq92OGVLFPKho/UpIQmonuOhifNz4yakHRALKEkwGu1WvYIRmiKsYyHmzR0f+C8AZt
	vZcSL4W37AXXNprx80glueJ50gEt/JXpeOvD0//Haaj2K6YH6MZS9gXfKxRssud0Pqsy+ScNqB1
	65ygXcQ8iUl+WMNantdfO/RgBv2Ly2rRnBsn50aNl/nVWflsROGbo0h1ENKgbw1G/ZXnmDjIUtn
	WY8XeDIYQ3M2GTDpNEDKo4GcaNxh30ynHlJX4sE538sWVMQJ18q+SHJlOq/E+tuMHyiL4Q/NGI2
	CFaeOkTEIbeA4NCl/ENqoXoRmgxbt64Q+NIU7ttE84a5UWyby5YFH8I9bIdUvd20VGzk69zurBv
	vasTzMw7LpGv50As1i8IN1G7zEgdQEApIUoh4pLehI+mAYS09my/DHbMHBKaFZqxrNTdF7kppnx
	KMq0dYKDAE4TI3s+8H48yhAO/FldR8PHneMaVyLM5PXXQjJu6oku5pRM3WdSPHLoVPwf4fLZdKn
	ewo6Uvbl6fW/uvTjgvhmYGPjOVd2bBfJsUva0F525zViQu2z7ATrXm6aIs5SMGXYv4=
X-Received: by 2002:a05:6000:2c06:b0:45e:8547:f21e with SMTP id ffacd0b85a97d-45e8547f289mr11973085f8f.36.1779227674080;
        Tue, 19 May 2026 14:54:34 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc? (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19c2dsm49700159f8f.21.2026.05.19.14.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 14:54:33 -0700 (PDT)
Message-ID: <ed904bfb-48c1-4ad4-9c68-a874c652ece8@grsecurity.net>
Date: Tue, 19 May 2026 23:54:32 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 08/20] x86/vmx: Use separate VMCSes for
 BSP vs. AP in INIT test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jones <andrew.jones@linux.dev>
References: <20260514210500.1626871-1-seanjc@google.com>
 <20260514210500.1626871-9-seanjc@google.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20260514210500.1626871-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.05.26 23:04, Sean Christopherson wrote:
> Allocate and use a separate VMCS for the AP CPU in VMX's INIT test, and
> simply mark the guest as finished on the BSP.  Sharing a VMCS between CPUs
> requires _more_ code than allocating a dedicated VMCS, and completely
> falls apart if things like "launched" are made per-CPU (spoiler alert).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  x86/vmx_tests.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
> index e2bf06ac..effd0c59 100644
> --- a/x86/vmx_tests.c
> +++ b/x86/vmx_tests.c
> @@ -9976,7 +9976,8 @@ static bool init_signal_test_thread_continued;
>  
>  static void init_signal_test_thread(void *data)
>  {
> -	struct vmcs *test_vmcs = data;
> +	struct guest_regs *regs = this_cpu_guest_regs();
> +	struct vmcs *ap_vmcs;
>  
>  	/* Enter VMX operation (i.e. exec VMXON) */
>  	u64 *ap_vmxon_region = alloc_page();
> @@ -9984,6 +9985,11 @@ static void init_signal_test_thread(void *data)
>  	init_vmx(ap_vmxon_region);
>  	TEST_ASSERT(!__vmxon_safe(ap_vmxon_region));
>  
> +	init_vmcs(&ap_vmcs);
> +	make_vmcs_current(ap_vmcs);
> +
> +	memset(regs, 0, sizeof(regs));

memset(regs, 0, sizeof(*regs));

> +
>  	/* Signal CPU have entered VMX operation */
>  	vmx_set_test_stage(1);
>  
> @@ -10003,13 +10009,10 @@ static void init_signal_test_thread(void *data)
>  
>  	/* Enter VMX non-root mode */
>  	test_set_guest(v2_null_test_guest);
> -	make_vmcs_current(test_vmcs);
>  	enter_guest();
>  	/* Save exit reason for BSP CPU to compare to expected result */
>  	init_signal_test_exit_reason = vmcs_read(EXI_REASON);
> -	/* VMCLEAR test-vmcs so it could be loaded by BSP CPU */
> -	vmcs_clear(test_vmcs);
> -	launched = false;
> +
>  	/* Signal that CPU exited to VMX root mode */
>  	vmx_set_test_stage(5);
>  
> @@ -10110,9 +10113,8 @@ static void vmx_init_signal_test(void)
>  			exit_reason_description(init_signal_test_exit_reason),
>  			init_signal_test_exit_reason);
>  
> -	/* Run guest to completion */
> -	make_vmcs_current(test_vmcs);
> -	enter_guest();
> +	/* Mark the guest as being done. */
> +	test_set_guest_finished();
>  
>  	/* Signal other CPU to exit VMX operation */
>  	init_signal_test_thread_continued = false;

