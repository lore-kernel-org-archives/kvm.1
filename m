Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA737A852
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005993; cv=none; b=FBNXtm8QxJ+uSXU293MsS9gHjtoeKHcTe99v+gy31iIM1oONI2edseMxUPKwNfSMTqGhnwadyef5hEdAhJ5NI1ZfopUnwdEWtAOkfzHAPBfuX+n4yiUpDPWEhHdsfRbp9X2Dr1nmu4ErNWfIZyp1E7tZpyCMcqW6Bk8bdtj3jQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005993; c=relaxed/simple;
	bh=tWHidKVtsdwKRB5jdKGXevt8I4wrmUq/pKRcb+d/2LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+4Gb2mx7HpJLGuD7bxEvGpAQFY6UDPHC4OEoud8kFeQcynDbcXt/FYFM5+dlAI9WbibqCgChp1nXJS6C7JuO1hYaeqmQ6lz3+yoBRfB/rC1kczt5Dgtezp3lX7MnW2E+7H52EeCHXguukjFckjZGR6apUS47/votuTbzovqkgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NSt4Fn24; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NSt4Fn24"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b691cb44so14112185e9.0
        for <kvm@vger.kernel.org>; Thu, 02 Jul 2026 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783005990; x=1783610790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GUA8gzuE5tCdaOiMzaRo5jxXpGPGq0X6g3CKwAZM4NQ=;
        b=NSt4Fn24npKatGgvjZrvX+2mdkJHq2GwSrmP8qDLn4K0Dybhw5JaVFlY17L8479mgO
         ivKiXBF6yDKnSW32STmtNOwIuJodHOKzRzndReTThjuKeBLXSCeYGa6CFwZjJZHhILF3
         ykKaqg6l3V+arHZ9WrWGoVti3UpFRxgwuvlZpojQ6hls4MQ/yzhwpjI9/Wd0VhgXgEBc
         8fvoBgN0mgVvuBQIuXOMPB1KKV+crwxjtzMGdS+ZuQX+KrO6bV02L0rs6MMfOHRl/aEA
         wrZUG80XEyhtvMDr61HMepWBxK9HHi3dyUqs+2mtDUcwpk6MrzM/XDPnlzbmLP6J60h4
         hljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783005990; x=1783610790;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUA8gzuE5tCdaOiMzaRo5jxXpGPGq0X6g3CKwAZM4NQ=;
        b=X+A33JblwvFVrLUajT4dBFQvb3uEFgEGTRxVhTC93LrV8vr6613WT+HBxxDBD2Ff8Z
         WKKvL5WVyRAHXEuFZOzH2s8WFDFLTxmVLMFniJCY/3SuXmgmCNldccBNgqNnQPjlZE2x
         NjFslPrKjAWfi9m1kVnZJQvxpa7gkrtHBRZ0OpYLnDA3VlQ0gNgb7zmVYj5fmcR1PeF3
         w/xLMa81I+1KFsVtCTnpXgfSi8Dir+q03VMWe7xNDI5G3cv5yUzg635K6V1USvupY/A7
         8G24OQwoE3YYff841PbQNuY3p4Afr3HfuWW8sxMHrXv5IgiCQ/ZWVh6/T84Fc53dT3Kf
         OuIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WIAsvy4D+BPQ1paIX991kaTFcvmIwnshrduE4rLS32bI/J8X3R6TjsMH6tr8W3+OPNwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kURYvYUDyUirTRkafYGP9LjrQDq8exFE2UyUyjCnd+jmCBY5
	AUtvukLUGSrffwKH9vHvlDKtKcXVV7/n4lilFoBNbU9GqHM3CS9tmiTvIQ+zfLj7TdQ=
X-Gm-Gg: AfdE7clBxu/Oav/x2wY6WMrMkds+tz3lfPbZXK2EMH/8GqtjaMedEOmB3aur1+4TfDl
	Pu1GFv3aCmGW7man92lkDCl48WYuY2fxSj1T+ZMNf6/+9g5hJYjrnt/Ze5oYimXJHAFDN+HQhZJ
	haSQrRrpnTt0JnG3Va9fqRYDdbYzugnPB85ixbZxZlzw+/m8vJfbzhTeeTgbfwiW3BHYIPriL25
	fXH8Uddqz6Ep1El3JtFHdFRz+G+mcuI5CAdPn31wFZPHaoYDF6w9U+MlCFkt/XscYBJbHX5Rfa5
	eaRQwAeUCiiIDkkWx3SHJDPXDb87iN15pgfBspV7f0olletwEUYWZ1pezxlTq3hm8tCj2QQW/h5
	nHtYsIQKmurahTFQXO1Y+uzT/tLzPS++MxKZggu1tK/sen6wdITOOKjB2bpEYM4yZV+kVPuxXAi
	LcX0mcxqdkHbAEPvU=
X-Received: by 2002:a05:600c:6a98:b0:493:b307:6777 with SMTP id 5b1f17b1804b1-493c2b85665mr69863775e9.22.1783005990368;
        Thu, 02 Jul 2026 08:26:30 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6354926sm67312345e9.1.2026.07.02.08.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 08:26:29 -0700 (PDT)
Message-ID: <b5d0a554-4d2e-4338-918e-1251e697a309@suse.com>
Date: Thu, 2 Jul 2026 18:26:27 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/15] KVM: TDX: Add in-kernel Quote generation
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, xiaoyao.li@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-13-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260522034128.3144354-13-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/26 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Provide an in-kernel path for TDX Quote generation when handling
> TDG.VP.VMCALL<GetQuote>, without requiring an exit to userspace.
> 
> Use the core TDX API when the TDX Quoting extension is available. For
> simplicity, each KVM guest checks for availability only once during
> initialization. KVM does not handle Quoting service disruptions.

I think calling this in-kernel quote generation vs user-spcae quote 
generation is misleading. Rather the distinction is : quote via the vmm 
or a quote generated by the tdx module/tdx extension. I think this 
should be the level at which the distinction is made.


i.e tdx_get_quote_vmm vs tdx_get_quote_ext or some along those lines.


<snip>
