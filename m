Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953B4071CD
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679036; cv=none; b=DNT893C82tqoIf908t0nXBVYtK60+eT7guWK/bNoeBCpBTjujEJfVnnqETpsSdjprDs6TjLrPxHDUGubGxHxiN62Jv1LMKoYf+swevBVQVY/9Pq/9aEjlhVPzXhK6y95OuMOnE3jAduEkMwFVgWyTdYV/dp4I0S+86kBX2BBa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679036; c=relaxed/simple;
	bh=2xloe2zN9D2dOCRnAN6WIzZpy2wkeMpVIbL2c7nQXMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ffhq8ilzgT2afguy1m7c7OWpU3Ta6FZpsk6UbG7snhrWZaNt3kgqGpnmw+gcokQkvSemiND1SfbVa8zN3fQmw5GmQX/058+qcHWFsOTQjil4MAXKvuel9lbs7iLUlD2Jo2Xk8fD51F/8VYzLhUmKySOQncM3w9ofNYAe0eObZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RtKQl6xK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RtKQl6xK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso2981225e9.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783679034; x=1784283834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kH1oe0mt2yvV4ivyAG7fAc1/DRismStfLafbo89Wqrc=;
        b=RtKQl6xKFapz6AGOddrjj39CqRbZKhr7M7eoFmFCX5Lm40JcIfZjjgPBLH9P5XiY4G
         t7S4M7LQgU5JOBHdZXuIRkCZrNaFNIgQX0Cs/2T+eu109aEHPkEbwqequYhVOtdICvE/
         qL2vVGZHXgNLlvdPEw6BYhnKXuttgc6pPidqdckrlQpKP+smzDK/0OaGLYIO9ICtb2on
         3I/pAZmP5t1v+vY9xC7594xEhE4X7q3cq9aCKdTrhKZ0U4yZTyLU14ZClSzyrljB/0XR
         lu+vPPUyOaKB1YsNQwjQ4NJ0BJIfUeXBJA+NSUdseeRKbfDAFslZxtz9bk/gNHdr2KSg
         eXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679034; x=1784283834;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kH1oe0mt2yvV4ivyAG7fAc1/DRismStfLafbo89Wqrc=;
        b=idpjzVYpGlCuoDMcy7sSjxWptDRMAhCXkv6y1mkCWlVzitn1dokEPpPY4Zf44bG99t
         Q1xAIuc9rvuHJYbZG5pXo/BbMrE37tptEUSqxW+XnpKcp0cNAPWwXesX1ntDsgKfFv/s
         NJe/b5y/83XoGxU0Lz60sCCGhMVLJXqO3SG+IgUi0g8qqy0UlscYGvz5S2GXlmNtcqan
         FoM45z6irdlWIW35S9TRfOGyCuX/gPk70eBNXcE8Xbyyne5mj5LM/lXeVVIEqipiUP4S
         fcv0sFuGeBu4tG2Dh70n9XZLdXG+EvXmuPVzgUotPaoxyfsBN/kPDepL9ZhzYChjrI2g
         7Rxg==
X-Forwarded-Encrypted: i=1; AHgh+RqgcTQZBPE5sRiOG3BpulocJMSH9v9qGLbNyj8YOk/DH9AdevAmx7CYvDWBQrGuRkTmGrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9CQLXms+k+WCS/LprfjjUWW0HPQIQI4SFyy/Ugjm6eCf89xFz
	Govz5sD+8A4XjPjjYZ6mcQMzjukonXoUHaXF/eKnMVlKNtGCfkyDU28s960NiEkB66w=
X-Gm-Gg: AfdE7cnYZSuWbhqHpAsl9V6mhTlnm+Wyd96Bx5m3yzcdYigDgCaD9K0nyNcAuYcqOz1
	A1BoXKsBh1Tk5lyNcJDSXdkBgQDS/hVP51MBkyl0OA0/+80nFN8bVKEpHk2pHe5a0abzGVeXcS0
	8zVThRDaYV5fzDNQhUQblszfZgALshGYpCM9H3eq5E0nPMU9ckSN8JOj/ruubxYM1QMbgt6f587
	to+L3NHASDewmahbptSn6yeEahQjF9pMhuiT1vtkLyhXNq+itViANx3Ec9uhMQHPKir78nmkCTa
	6rs5zmPTP6VjmCt/+gA3OPjmqscV2Udvl3JNomdn43CW5BoJls1WtCzinrP+AWuM4529dSI4S6a
	bCCX7sDsUq6JRjK+5D8kXR0QI72zd8oTtNn8xKTHrMPrf0bpPkrEYVwHyBoOZSlbGlfxLfqdtWk
	U5bcDHcxVTNM0sxNA=
X-Received: by 2002:a05:600c:8b74:b0:493:f6f6:bcb1 with SMTP id 5b1f17b1804b1-493f6f6bd0dmr3337525e9.25.1783679033604;
        Fri, 10 Jul 2026 03:23:53 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6e0e5asm130744335e9.9.2026.07.10.03.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 03:23:53 -0700 (PDT)
Message-ID: <c6945e35-4cb1-49c5-a1f1-7fd338144469@suse.com>
Date: Fri, 10 Jul 2026 13:23:51 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] KVM: x86: Reverse the polarity of
 efer_reserved_bits
To: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260706195413.1966458-1-yosry@kernel.org>
 <20260706195413.1966458-6-yosry@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260706195413.1966458-6-yosry@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/6/26 22:54, Yosry Ahmed wrote:
> In preparation for moving efer_reserved_bits into kvm_caps, reverse its
> polarity and make it efer_supported_bits, to be more consistent with
> other fields in kvm_caps.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
