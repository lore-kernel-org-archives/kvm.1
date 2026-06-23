Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7739281F
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244649; cv=none; b=GtrG9BOvaAPHMWVACorhO0pkDN11gLoFMlVWdO+AQ/vetnoFKI/cR55duOR3U7hSTaYiUIfiZT+0H5yrHYhD/9LNTp67BswfRaCDfkloaMUxzr/F03oaR0nypbT7lO1fbvR92KPuWBZSdV3kOFrqHbCnzPQxc/DPpecvNtuTnak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244649; c=relaxed/simple;
	bh=cS1JB5K5LEiNN3GFVoT+fk/p1KBe4YLWKs9/23hvb2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVp7h1KwtkZWpJHkcttERP4WQ9b2t0CpJXDOdDTYiRuL/SxZcNkH3RPDJxnOStsd7RkR3AXJOZfDoTHlITzgjUU5HS8Up0tGMaLj5sTTxoXzcJAhbOChV5QLVjyDjAxKIhY8xp/zksrvLELSOozYbP1BsIidR3CT/VYT7ACRIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ay+kH2oQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ns31AQgl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ay+kH2oQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ns31AQgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782244647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qDc7guQ2ycA7m89lxili9KO877GhNfGfglR9NmUk+Uc=;
	b=ay+kH2oQb/oVqrs4/z41ZrptmKu+KhHouI4ywHy8d6p1j1ltHtsZCYJI6MJuKrzl+mPCge
	mGp++qPox8qZlEknOme/ivQfc1AwXKBRR11bmMZORY204uSnsG9aGAX03mfY6ERJp0OWS8
	5AavPsvsGb/dmN/WgbD3VCGDS1RVE0M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-8nHzEnilMsuCvW5_tD1yNw-1; Tue, 23 Jun 2026 15:57:25 -0400
X-MC-Unique: 8nHzEnilMsuCvW5_tD1yNw-1
X-Mimecast-MFC-AGG-ID: 8nHzEnilMsuCvW5_tD1yNw_1782244644
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924725bec9so1252725e9.1
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782244644; x=1782849444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qDc7guQ2ycA7m89lxili9KO877GhNfGfglR9NmUk+Uc=;
        b=ns31AQglrSv3bX2D28LOprpF2HikPr/LZp7reSUzq8+k/W3Jdt42RfzWLy7gfXE2LH
         15OwgG30mGawNX9Xur/+uVKbM88vrlYCk9VkbnVm3wK1aFUkocycFwqdYg6IVEkaP7NU
         33vMEqgJZ8gmU34x5dcRPlcLdcleND4F4HOw3Bsn2p1G3OIcVTfZ0FjU1Dqh5saDAjXO
         UvtK98+Se9suvLOvgTA13KjXX1RkfZCT9AJEeukiqZAhwW5WyDWp7kSvggK+8hbNdCCN
         WHm0/5oWqpnnQxQage6ac11+bRMrewFIrnhq8nW449keRuPVjhLYp3GxEAWbq0SoF/HX
         6+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782244644; x=1782849444;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDc7guQ2ycA7m89lxili9KO877GhNfGfglR9NmUk+Uc=;
        b=mw1j7zojw/I730wfa/QKdxUmgg2y85yCTH2WWGBpuN2uq2y2hZEfHnVEp9UgvxLzOr
         8wQ+fOyU35rHLA51RJSxjy85PUIQaMZ/8sxZ2/mTNYrjzDzRTCDaPMUvB5AnZcJ/Ef1a
         sn97w3XOd6q+SQ6sg6GfQr6jZ/acDtHbkRJsLXlkjZTTe+rgq+zHxryWSVxB9ShvgZQf
         Ey89ntKA3N+3dEda0soygk5KdIrdSPon1s0s+j63a3CQnF02Prj4ksnbK0XdqsczQzDH
         KMpHY1QhxUh4c/2FE12ySFhbtSNlE9OaOParn94ryfiLfrnDeRNSml3xo8yzAI82YgxM
         wXFw==
X-Forwarded-Encrypted: i=1; AFNElJ+mz9v1FoJd7lHY1Wl8jtmbPWJ1pM1EDI/+6YffIaptf7x+DTR/YqXjdEXcY2uLN64IOh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9u6i/bb7JfFr8hJhW6q+vJjv/3B0L1xdeAl0jTuMA/aAWxL0V
	ngoXpNJA3QCvAj7gDbNBeim8ADUFzzJKPs95iJ8SPwh6sSv4jllMxuTaU2MM7h23n0oeVe7Inqi
	LDaXadEssiLoDT2vsOOA5gvWnkrKXnxEV+qa1bq+0hVxU9vzyMeyujA==
X-Gm-Gg: AfdE7clTbFX1lspOKHBThn8nw9wMqNU3lt5EYnkJi2l5izLeTNh5PnH+9qXDk2/hieq
	n23IwFlDGHneQeQbU2fw45dge5m62fGj7YFgz45VUzKlW0EP7QuvwT0Oh9T8h9XGLitIEMP9KlP
	TO0vLBZ/oiY66nPsOnvQmhqjXgz8BGDRn+H67ytA6Fp1r1xXYXIvR6R4ikM5dYVtb50a31ZjAsd
	kULycwpsUcxG5qV+15yq6qVp5fxIrOBzV7UbbRrCdwNCWzGlsEpv3J8kcAo9sv/e5SPERSD2Td9
	FcrEtILdL1nWCojbsGCKYHcTjQzIvgLUJ0BIk5BmbT8ayeYKxTdFsqLIJ32rBC5fnvKNt71qK4Z
	vhTH5reA=
X-Received: by 2002:a05:600c:a51:b0:492:379c:32ee with SMTP id 5b1f17b1804b1-49249083c09mr275512265e9.6.1782244644371;
        Tue, 23 Jun 2026 12:57:24 -0700 (PDT)
X-Received: by 2002:a05:600c:a51:b0:492:379c:32ee with SMTP id 5b1f17b1804b1-49249083c09mr275512025e9.6.1782244643935;
        Tue, 23 Jun 2026 12:57:23 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1e840eefsm57195f8f.1.2026.06.23.12.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 12:57:23 -0700 (PDT)
Message-ID: <21cd2f80-64a2-48ca-9821-7a233470af77@redhat.com>
Date: Tue, 23 Jun 2026 21:57:22 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] checkpatch: add support for Assisted-by
 tag
To: Andrew Jones <andrew.jones@linux.dev>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20260622164109.26350-1-andrew.jones@linux.dev>
 <CABgObfYzDQN-2OpM7JjoPe32Y=y=FokJEq2oePYbyASUuxy2yw@mail.gmail.com>
 <ev32z6yxkujq3ctb66f6l3e2l5cx2b33ye76mlqvo6jdsydxsk@hwmgkv5rmqym>
 <92a4d803-c545-48e8-ab5c-647bb04f3560@oss.qualcomm.com>
 <b3agpqbu47bnsfcfzskdfgymyag6y6be5danltshzwiimybvnh@r4773lfg6vfj>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <b3agpqbu47bnsfcfzskdfgymyag6y6be5danltshzwiimybvnh@r4773lfg6vfj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/06/2026 18.04, Andrew Jones wrote:
> On Tue, Jun 23, 2026 at 05:08:07PM +0200, Philippe Mathieu-Daudé wrote:
>> On 22/6/26 21:00, Andrew Jones wrote:
>>> On Mon, Jun 22, 2026 at 06:43:45PM +0200, Paolo Bonzini wrote:
>>>> On Mon, Jun 22, 2026 at 6:41 PM Andrew Jones <andrew.jones@linux.dev> wrote:
>>>>>
>>>>> Import Linux commit d1db4118489f ("checkpatch: add support for
>>>>> Assisted-by tag").
>>>>>
>>>>> (I should have used AI for this, since it'd be fun to include that
>>>>> tag on this tag-enabling patch, but sometimes I still do my own
>>>>> homework!)
>>>>
>>>> Personally, I don't see the point in providing free advertising to AI
>>>> companies, so if I had to choose I would do "WARN(...) if ($sign_off
>>>> =~ /^Assisted-by:/i)". It's more important to know what AI was used
>>>> *for*, than what AI was used period.
>>>>
>>>> But I won't complain if people want this patch.
>>>
>>> The process is now well established over in Linux kernel land and we
>>> encourage kvm-unit-tests contributors to follow Linux processes. The
>>> motivation for this patch is because I just queued an ARM patch which
>>> used the Linux process and it failed checkpatch. I'd rather checkpatch
>>> succeed than to have to tell people to remove/modify the tags they're
>>> used to using with the kernel.
>>>
>>> We can encourage contributors to also add sentences stating how AI
>>> assisted when an AI assistance tag is provided in order to capture
>>> the "AI used for what" part.
>>
>> I tend to agree with Paolo in that I don't see the value added by
>> these tags -- except the free advertising --. Besides what provides
>> $AGENT_NAME:$MODEL_VERSION is likely irrelevant without the prompt
>> used. And even if we try to reproduce we would get a slightly
>> different result :) Then by the time the patch is committed the
>> information is almost obsolete.
>>
> 
> kvm-unit-tests does sit on the boundary of being Linux-like and
> QEMU-adjacent. So I can see why the QEMU position[1] might be
> considered over the Linux position here. OTOH, I'd rather not
> complicate kvm-unit-tests development. I'm also personally not
> that against the tags providing free advertising. The tags also
> provide stats in the long run which may be used to compute risk
> factors and/or evaluate quality of particular LLM designs which
> can lead to LLM improvements.
FWIW, I think we should follow the kernel here. k-u-t has always used the 
coding style, header files, scripts, etc. from the kernel, so IMHO we should 
not diverge here.
And I agree with Andrew that the tags could be useful in the long run, e.g. 
if there is ever a problem with a certain AI model, it's easier for us to 
find out which commits we might want to have another closer look at.

  Thomas

