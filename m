Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F93B777B
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692857; cv=none; b=DDWZxrUbdxhrpFQT1mRwfC0OhuMSHQJp3t0sLxQXWoLz5pUqXOc/V0qmTmJm1JJwwuUSPfMidowZhQV5P+AiMeQo/aHOi88gW8ZgNxSevCkXnqw7rETJhWMCU56JvcYiTwWFEL4p9tfSeGhZJd3Tx2jILJRPKYLCpNMwYpPtStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692857; c=relaxed/simple;
	bh=URFZ1vwASMvVqdA1+9smaG7I3bKjYdtJPqnOH0H41mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaVlX3IN/yZmd9e0jEdD+azG102LTXpIHT1DY0Z2JQka5RM9NLDuRlCYVvsLnycUpZ6MwgNLxmXAS5UD9Hq9e7ymxmPdSV5XN2J1HaDdIxu/vuFyB1Zo1ZgbctAtqWsQBxm2yB4pb8NhVXvLcwS35cZQiCdUfb0ZD70YOZc6xX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyrEHoBI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyrEHoBI"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36ac67f489aso479033a91.0
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779692854; x=1780297654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFMw4UuGDjf0p4oj+e6tcK49mC0E+D/7wabzuRfHops=;
        b=KyrEHoBIbS1NQTdH302i3F0DIbVQ0esPmP16hZ6AYlzxTyDnNl3838lEtIki2Y4NAm
         CjZO/n8AGwUXP4d9c0781SAAMPX8vGszC5Ny1UD/Vdvxq1ih/UjuwyktiRrRsdouXihW
         yLVEM10eR4N4puIWp1iEU2WPs1eL3zCiRCx8Jrijqrzm3bjTUdAuVhkGdF/Q7ooggyXV
         1orj53Tc/F8Cg7egj95150fGnXiSBdzYBbVObQUSFkIQUhbyt69YH1vfvNLUQ1IZGaHB
         7JQyj+oc6xPWVjZCiYG0r9yVHluh108oY1qf3WG6er73a48WRXsUHTn+7YP6hT1i8dH7
         gMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779692854; x=1780297654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFMw4UuGDjf0p4oj+e6tcK49mC0E+D/7wabzuRfHops=;
        b=gi53g+kMk3gIhp2ROamSr2SNQ59Mr58WdfiIjPaeSlofmjxh7UwMOAqLWwGyTcCDrO
         lNwuxPSODq07f3qWoEXLUNtEml3JT1dBDoJo5C5TNpgxsd1XuOpuDicw7wivfrBOJIrT
         YsZEJb8h/Jg+ViA+uUJ9R5std3YGUUfglHjA+Zd7nPnzwW+2UuCfhmnMrK/QexuciZ00
         oi38QamPb6nmR5lzatt3a4YANprRfwFiKba4u1BoRNNzDok97ce2QMYwBgIJFxhMUo63
         oAeqc29h0MsQa3jVpWrxnqAnNiM4+KA6NBJS5NO8GskthJOVXb7Wlq9Eesu1HjxvfSbL
         wYNw==
X-Gm-Message-State: AOJu0YxweSS7q67YzDSXAagECdW2hKASI6glr343rVos8d5iGfT26kb4
	I+e4Nk58HypOOwrs7p0U7BCRAxLkAcJhpXFHtaA2oH6Wa6O+M+ry6/Ya
X-Gm-Gg: Acq92OFN0qEpIhDdD1YyvoOtokwxfJ9tW8XIuQRkB3Eda5sglR5wLdkb5Q6tHk+wEco
	CXtS1CjCEwP6odSBAhQo0ysYgmSHNHCCJJllnJcgV7muYyMNlaXQt4LEcnLuFgsrT03LRzP4+ah
	VCF7MGv6C3xhXpAVsSlI1X1VT+MrBaqREe1nkNFRk4elMa0jUnsI0fBYNkTevHaVsAPkQsEO4ig
	bwbyDKSp18z6WLwQQTQjdLK5S/L6cH8EjdRFwln3NuNGU9utfPtlIk0hQYo8wXvmUSRfKfhCE3I
	1EXO0cnA4Zt77HpVNO00bL2NMswaWlCZU8QS7jAXkyf8/trZHHIvD7DVQ5bmcS2uf1DNro6v/+8
	UD4Q8G6lVMHte/UtnKCRjMMhLlyNjUmWmhDHN2lXDomN5qrZNGzThGe1swYtXG8gHEJLWCJjJ2r
	m6zIZH4dByWNGaqvO5tdEFrIn2npnaqTX0T0+5VhUb7VAmYMqHL+Xc4yY5Lk4=
X-Received: by 2002:a17:90a:e70d:b0:369:3c3d:f899 with SMTP id 98e67ed59e1d1-36a6ba28e3bmr9654503a91.2.1779692853856;
        Mon, 25 May 2026 00:07:33 -0700 (PDT)
Received: from [10.3.165.119] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm8580394a91.7.2026.05.25.00.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:07:33 -0700 (PDT)
Message-ID: <d93320d5-2974-4e26-be97-785ffd2ea7c5@gmail.com>
Date: Mon, 25 May 2026 15:07:30 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/2] KVM: irqchip: Cache IRQ routing entries allocation
To: sashiko-reviews@lists.linux.dev, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: kvm@vger.kernel.org
References: <20260525035242.107264-3-yanfei.xu@bytedance.com>
 <20260525051714.485D51F000E9@smtp.kernel.org>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <20260525051714.485D51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026/5/25 13:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Missing bounds check on user-supplied `ue->u.irqchip.irqchip` allows an out-of-bounds array write on LoongArch and PowerPC.
> --

Posted a separate fix for this issue.
https://lore.kernel.org/kvm/20260525070154.495455-1-yanfei.xu@bytedance.com/

Thanks,
Yanfei

> commit 8ac8d5f6cab84711afabacca6347f1ad673dc605
> Author: Yanfei Xu <yanfei.xu@bytedance.com>
> Subject: KVM: irqchip: Cache IRQ routing entries allocation
>
> This patch caches a VM-local entries array allocation from a freed IRQ routing
> table to reduce allocation and free churn during frequent routing updates. It
> also initializes the remaining MSI fields on x86, LoongArch, and PowerPC since
> cached entries are reused without being zeroed.
>
>> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
>> index f4f953b224192..15cc80cde071b 100644
>> --- a/arch/loongarch/kvm/irqfd.c
>> +++ b/arch/loongarch/kvm/irqfd.c
>> @@ -60,6 +60,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>>   		e->msi.address_lo = ue->u.msi.address_lo;
>>   		e->msi.address_hi = ue->u.msi.address_hi;
>>   		e->msi.data = ue->u.msi.data;
>> +		e->msi.flags = ue->flags;
>> +		e->msi.devid = ue->u.msi.devid;
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does the KVM_IRQ_ROUTING_IRQCHIP
> case in this function lack bounds checking on the irqchip index?
>
> Looking at kvm_set_routing_entry() on LoongArch (and similarly on PowerPC),
> the irqchip.pin is validated against KVM_IRQCHIP_NUM_PINS, but there doesn't
> appear to be a check for e->irqchip.irqchip against KVM_NR_IRQCHIPS.
>
> When kvm_set_routing_entry() returns success, setup_routing_entry() executes
> this array write:
>
> virt/kvm/irqchip.c:setup_routing_entry() {
>      ...
>      if (e->type == KVM_IRQ_ROUTING_IRQCHIP)
>          rt->chip[e->irqchip.irqchip][e->irqchip.pin] = e->gsi;
>      ...
> }
>
> Could this allow a user-supplied routing entry to provide an arbitrarily
> large irqchip index, causing an out-of-bounds write of e->gsi into the heap
> memory following the kvm_irq_routing_table?
>
> [ ... ]
>
