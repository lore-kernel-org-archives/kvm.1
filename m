Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB67384CCB
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791054; cv=none; b=r6TbHf3GQSIcd+zl2xKlrYe4oP8gMsM2Ih/txKzt0/92Rofdst4/vtoqIwEGsGdNQfjElE2y7jINUFmACcMHOt5shka7iiStvxug/29FkvHsnTbEzrj7c2j5jy2Nuig2r8DdSJ4N/+ik2jm4H8SBZB1cW2UvRl9OP6eO6RsfIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791054; c=relaxed/simple;
	bh=teeyNIv/JEiwwT3fkLQ0kmcbVKriraNmcjYMJ0UUajQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJn+qNsaLneCWodMumRxflfqGdMy4gifX5LlFCfUf8VQufEfUfYgrQcCsXHB5TtVazEzj2OOzchWeAiDXYGQ8gu7g7FrpJtQ4Nlc9g/D7TbNhAhOZu/ZVqyNwGO+EJzroRNyIxH0XZVMevkH55J0/INkVJKZaJAKxUaIWGk8UzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dq3WktuS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dq3WktuS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so1168805e9.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784791046; x=1785395846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gTMcinR+9LxGJXRCG8QBuGeJK9HPvbs8Aj0hNum62ZE=;
        b=dq3WktuSm8Ce7e9EZxcw96yPGIa8Bn54vSfrlHVoeETU4aqyp0LEcQ92eaqZiPNkWs
         CduCAZvlbAE6XmF0tSrM62tD6lsYPTaoQ9RYt5J1djZvHE5qUdylVhF6jcXDGDvtgfmt
         xlje4EpfzwCEZRdliaxpz86OSBu6iMGdYarejmK0ZhT1VOwTiwvS/QpfJgW46zfbWr6g
         hvc6Z3ruHuIP4JgyX6DR00AIdP0vSmGZJcqW89usApcZfVSNOLAlK5CQ1fOr+jUSpWKN
         59dVRO/04CJO57LVhlT+UJjThvoI7G8uircfQdQkubAx7MQNPJFnxtgWWJPp8F5rMjVV
         81ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784791046; x=1785395846;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gTMcinR+9LxGJXRCG8QBuGeJK9HPvbs8Aj0hNum62ZE=;
        b=H7/M7+NgnCeXvuhq7qWMGMk6riLDdKXTGJWD/+uYjevCraO2dfsaxijDtdn4qoBfrm
         DbSDqRJXtFLkxXRuwk6ihHw6h81Ec06OaEY01GUHCr1BOF4bcPjRrHIazPdAMNQWg3wh
         KBBNtKQv0zMUlJ95y8y/fg6TCy9ZEaMo9v0NoJ7A2aoSiCHG6jPWGkDUKOH2qQ5ViNDj
         UuVS6kyuYnlEEcy+3zFB6YjeZv3HpDjKOj1IwEmDfAbPlrC54CD9M7L1t28ICu8DCV1t
         /JrvVkWwdGHCHnZeGrEwWvSbYnVfw2wviCmXpY0dUA77ok13oAKX8pm2/lz4G/z9XyM2
         DCkg==
X-Gm-Message-State: AOJu0Yyz7rW43OZDFhBPkJ1p5s80JoJk3JAEXdjF84vaZsFg0CLk51PU
	krXTZQ71APOkvmwPn0+tFiD4Iu/WPm5iLW4BkH3ofny4Zp95fvEE4xV1bFd1lazRCeo=
X-Gm-Gg: AR+sD10t4WNxjrySxczuuSkaAuPsndL3HVWXydU3V40YeQGwv0djSfpphl2fZrjROqP
	Q6RaRgnKXKWnYJeeL42zvtHH5WvgL3PPW0Dv/g03s+EywiXTclHFa7J0ZcMwtBBF/G6CigLrKji
	HzbPgqa9I/5U70ZFgJO7bUObtlZTEgEDRTVdfchX9SSYporGKV++yAdAHkj9CwuYsRWLxDhTI+I
	KfppLUGsKwTgl84QbVdFbbz7tqO/+D7WnXIRFCypMt9XcEsTmkArfmwdaoLWyV9xcu5mG0zh55V
	5JGUBcFPC1dOGaRChNrfvA97/1WJujZX3VwFRiZr0A77IzrV629uiRySgsOO1VLt4XwOe1GjGyF
	HELj2xUFZ5tL2FpAe6tbIdhX95SvLqzqkgER+YlSTn3uXDzc+4C+zeMFA1Kt6MNBXUMSu6UbcXK
	5HDCMuDQnixBpXj/A=
X-Received: by 2002:a05:600c:6a07:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-49573c8d700mr12326795e9.8.1784791045710;
        Thu, 23 Jul 2026 00:17:25 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a508aa6sm130774115e9.7.2026.07.23.00.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 00:17:25 -0700 (PDT)
Message-ID: <3114b501-158f-46f5-b999-68b5896aa3f8@suse.com>
Date: Thu, 23 Jul 2026 10:17:22 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
To: Sean Christopherson <seanjc@google.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
 Yan Y Zhao <yan.y.zhao@intel.com>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 Binbin Wu <binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
 Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
 Chao Gao <chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
 <20900cd6-6d05-4a20-a21d-2a1d4a6ef5e5@suse.com>
 <4ad035a82ee10dc4645e26a4bd1daf40786a743a.camel@intel.com>
 <amEbS6WDEyrvW72Q@google.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <amEbS6WDEyrvW72Q@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/26 22:34, Sean Christopherson wrote:
> On Wed, Jul 22, 2026, Rick P Edgecombe wrote:
>> On Wed, 2026-07-22 at 16:46 +0300, Nikolay Borisov wrote:
>>>> +static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int
>>>> min_nr_spts)
>>>> +{
>>>> +	/*
>>>> +	 * Don't cover the root SPT, but cover a possible 4KB private
>>>> +	 * page in addition to the SPTs. So -1 to exclude the root
>>>> +	 * SPT, and +1 for the guest page cancel out.
>>>> +	 */
>>>
>>> That comment here doesn't seem to correspond to the code in anyway.
>>> There are no +-1 adjustments.
>>
>> The +1 and -1 cancel each other out. Hmm, how about:
>> 	/*
>> 	 * Don't cover the root SPT, but cover a possible 4KB private
>> 	 * page in addition to the SPTs. The -1 to exclude the root
>> 	 * SPT and +1 for the guest page cancel each other out. So
>> 	 * make no adjustments.
>> 	 */
> 
> Maybe put it in code?  E.g.
> 
> 	/*
> 	 * Minus one page to exclude the root SPT, but plus one page for a
> 	 * possible 4KiB private mapping.
> 	 */
> 	min_nr_spts += -1 + 1;

Makes sense
> 
> 	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);

