Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDA3016E7
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906310; cv=none; b=b1BvKNtcIGrup+m6TzPeUz/CdLT0bf/aXsiWaN5lptfBH/cRqI1WgxSSBuykWJan9jPSxXRsJ0+dIFGMbSqviRvPoqKUWTma9cB1curqOV3iRUNU1sW/dePYhxHiP2Iqef6kSDqnJ+jpwPp/DUjeCo6OFEsMuZJhoMwlcOcL1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906310; c=relaxed/simple;
	bh=pDCqD/JN8Q1eog4eO+xe5vWbGLc6Q+RvNxDSBGqufBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKDb3YHO9c7fFTylocGKgVDGVIi3IDLWDmVkvKLwjPNeIzPwyaSSongPlIYx9FBptawOpXLy8WmnRXXgxR4DYXO5z2wnGw8jVqUD78rStl1ahMdCL8eJtrCmAxfc0iYK74YsHCsuk9l1U0KzQhmtMHvDcMNP3NMuOX2eT1MqiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=OY4PrWHm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="OY4PrWHm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso102812945e9.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1779906307; x=1780511107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8fUnr8M2iVhBIQXPtF6CUWta8Ik4NyKWK7afUll3x7w=;
        b=OY4PrWHmsVenhtmRLtvIQnEXzJ8Lfyi+/FnVm0KYdeXapFv/bae2Fg3sVPNmm9ahXb
         S/LKnIQdq/WU1hmxYeSr5AtOvxdF1Og2gJ+VALPnkRbbhgWl/q27vCpzFL8OlGzL68LR
         RR/Gx9dA12AxyvCoqT8siifDKuFz2t9Q/C7dLZRI5veEu+yxHuFwv8KLI55dK9wV1yey
         wOHHeHB5aYLq8vNL3A1wMWcHt7C7HzVV7BC39DLYlQcoEfn4Yrfi84ELJbkXtpoDj3VM
         Q4Wpdn16T6Y9EIwR0D0uZVIzuvUmtF9fAQ0dX2TIvFMaXu2KrEmVBJEHDnaH8TvMS1MY
         jDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779906307; x=1780511107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fUnr8M2iVhBIQXPtF6CUWta8Ik4NyKWK7afUll3x7w=;
        b=jMg1G4spcUB/KoMwxawpLHXO26dTMykBOFKfa3K2k+9/93k+uQiBXfbVnr2F/aXdam
         c58k+kCWa8s/d14ph8A9VHMZjL2Usp1jKrqyP7emNk+nN1Q5KrHFzZCRWPRq4+wMp9Og
         Tg5wGowUWyDM9sLJIvPOjq3mSPTFX89o4+46mmajb7z3wwZysyPQYiXNGEbL2cXs9AJ2
         CZ1nRTNcB4cICa5g3fccyom+hoo6jhfT6A38t3t5sP6epXbcvOp+t3/GMHTSj1KUT6Zs
         n5oefT+lv6UvkEpZDMsF2gaEA4C1lWkIGS+xImqJGe4UhStZUdbfIpzyxcJ0Ltm82H8r
         ROfg==
X-Forwarded-Encrypted: i=1; AFNElJ9F/Ru1uVXNiQbNWSn0t8sL52nSDwC0q4jBQ3nbMnIfV5ON1prD9PXWd3qGK/YPx9oGG2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nL8UOzEa6CvkGqnD3BdzR/YPG4YDxexqR7gN91zC++VhywN4
	8LMKlfh78foeM8K3ioSRvY19i3HVC6jmgm0Ox8+dHmJv8gtK9bJmrQvXnR6DnhOjwxE=
X-Gm-Gg: Acq92OGY2ENNW2fmztw9ycRm8cnXYOEnl6OW9ruh+07l/SV3hX42M1Do1u4r8cYXlJP
	FHEBV8umOxLAn9LXBjtfwoIFSzslofKg0uXBymXnb8tEq8UQBzf5naGSmixsqIrCG03TcSxDsG5
	lSl/CZdxaAlBRQEslzMIXyAIoIn5XKMtJpxwx7Sm97k4ax0kUoEyWufyYlChtw5xY+a8XkolRC8
	xyhiVMVub2BkFvukNNl5uBEVvHYzy8c9F6GwErj/8wAAuetlq1rXP7UJutdyX1OuEruEANA6xd7
	K7ShWVI+ugenA8ptl3ETJAj/3yH4aYiP0dIopU7Mr36d8jj3LEjPA3kWksCaIcZ+tmM/XjmW67Q
	EuANZbFMoh2aNQBnuofwpa4R+y2nFcnHD4nOUrHC6cMMKhcRsbN2jzed4LzKQZ5yTOAAdJjA04w
	Hrfi8o4QBtEP0JzpiMYOwWdoVjMWW80FL5AkI5LoCuizw+2o1JqBwJHk0+kWlpnbQ/qgv1xdr/p
	FFOjPoYlFHADd1WxcV6r5kn15P/IOAC62AW9Qhh1tZL3vXWfI+vINo0olJrZ9PxNB4=
X-Received: by 2002:a05:600c:3592:b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-49044ebc292mr458944815e9.28.1779906306923;
        Wed, 27 May 2026 11:25:06 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc? (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm457149285e9.8.2026.05.27.11.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 11:25:06 -0700 (PDT)
Message-ID: <349032e2-67d1-4009-88ec-a505646e67f9@grsecurity.net>
Date: Wed, 27 May 2026 20:25:06 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf
 functions
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Andrew Jones <andrew.jones@linux.dev>
References: <20260514210500.1626871-1-seanjc@google.com>
 <d2f3be07-b930-402d-bac5-63a21877f6e2@redhat.com>
 <092d0688-0c8d-4b82-bb62-abeb26845df3@grsecurity.net>
 <CABgObfayKKDr9birEVn=QMj3Lxi5wo9GnxsSDcZByxEC+HA+Ng@mail.gmail.com>
 <09aad595-c4ef-4cc1-8aaf-e2300fe5a619@grsecurity.net>
 <ahcQmNWSroRQj5B0@google.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <ahcQmNWSroRQj5B0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.05.26 17:41, Sean Christopherson wrote:
> On Thu, May 21, 2026, Mathias Krause wrote:
>> On 21.05.26 12:48, Paolo Bonzini wrote:
>>> On Thu, May 21, 2026 at 12:35 PM Mathias Krause <minipli@grsecurity.net> wrote:
>>>>> I'm applying patches 1-18, adding the last two give
>>>>
>>>> Looks like Sean already integrated them into
>>>> https://github.com/kvm-x86/kvm-unit-tests, including the fixups that
>>>> came up during review.
>>>
>>> Oopsie. I've merged manually everything from there up to commit
>>> 0ddb0873cf4f1bd584c0981836778b795bab94f0.
>>>
>>> Let's post what's left as a new submission to the mailing list.
>>
>> In this case, Sean, can you please fold in the fixup for bbe76fbda4e1
>> ("x86: Prevent realmode test code instrumentation with nop-mcount") I
>> posted at [1]?
> 
> Given that the last two patches are yours, and that I can barely follow what the
> patches are doing, can you post a new standalone mini-series with those two patches,
> and whatever changes are needed to make 'em work?
> 

Ahh, sure. I'll do that.

Thanks,
Mathias
