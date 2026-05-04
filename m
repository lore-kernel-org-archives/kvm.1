Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C52BE05E
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881531; cv=none; b=T+5yswCW4US880OKFqyoPsuc8IcOwoOfXECel395VyP89i9KT5BfCTE3l4jU7t4tSC/FFEsyILRqGogsYSMn17TTc9Tiax9vc4ihhGF7+SH9N6iQyas2bM1S1OTH9mt6fAXRm/SEGDbeuBILyJLRyoh0eXOAIAgQIoLQSc89U+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881531; c=relaxed/simple;
	bh=0MkAoInbjJvx0j4G0DvugywpVN2C4BnrtYBcxX9q00Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PbvRGifeNDD1F4h7YKTEFN6EczhFJ8w+Ud78+xg/vP0ho65FjpD+LtdnuqNLZJyEWzL7uptrx+wiBYvnjWVhRfUt8DqeNqcU0mdFUaoETmUb/9Y+hbz0oBRCeJnEl0aELl+e+aLJaGXiwgxMom6T2Yk4pOF2myVU2jvvLcIm38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWa9FaCb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1vzXULt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWa9FaCb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1vzXULt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777881528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Cp/3U0v8vn1CVxT9urNg0BrhHp7zlAjGZ1Gfn47hogQ=;
	b=jWa9FaCbPdI5nvAm5TGoqq7+49knHj5k9GG0vJDEySugd3m/YHoEDB1oKrUxLj6M6NJGvw
	Y4CPgw/d8N584/HSc1Ba3C81pb1YcOlhX4JtVGTiwlLG5+sP87IaemSfOGN918xNPC9yqp
	Sk6sYV3Yh79OAUt+y9LqbQdO9jU4/ZY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-tMZNKlm9NyOgl44dJ0aerw-1; Mon, 04 May 2026 03:58:47 -0400
X-MC-Unique: tMZNKlm9NyOgl44dJ0aerw-1
X-Mimecast-MFC-AGG-ID: tMZNKlm9NyOgl44dJ0aerw_1777881526
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so642729f8f.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777881526; x=1778486326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp/3U0v8vn1CVxT9urNg0BrhHp7zlAjGZ1Gfn47hogQ=;
        b=M1vzXULtUSyQK1n1Y087ZGraVX31I7U34NKYN2a13lSn2a9dJSvNdfpqFurGFsHYdz
         1PJiDvJZinPnzGxoL8TCcxqCUnr0A6oVSuBWFtJo8Q51PCVd+fFxRHo5FZFShBy4ya1w
         I9bnaixoXyiBU3/uw2IR/hj+vTpmZJdqqy2NB3mz10A7VpuYAYt8xj1wemS8vq1sKxBG
         GHudlBBeR5ccgUzmZKIn8xuhBnK8UrJji4QB5xqGwH2JW6dvhE5wWDTqVzt6atIDCnaj
         9pzhuQCOm+P75GT8C+sdiBWmXcln9zILyMpc/9lZfEASK0Cbd1Wlu8tPCEyTp+OBpKbb
         fwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881526; x=1778486326;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp/3U0v8vn1CVxT9urNg0BrhHp7zlAjGZ1Gfn47hogQ=;
        b=bVIH1xdqZp6S/yuExwKRGlqQlvWRKN7GyFrG1Fi41yRjGErqAevimGOsE8lPsReLds
         wvhFuad67SEuTiZONKOT2KdFfDU9yodb6pyatFjX4xvWbY+rsJCEIo9z66nIR3mSzvjo
         hkMRobIntSuAPuTg3JX+s3X8FPdLExz1HPUQYvwV2gF8if674R4SiGjKy/0hatY3NXr4
         O6N+N5GRGxwSH3h/nziLJVQHdOOCAc81kRVjm/QvLvrIStOcqPNbCCbH51+GlGflLkVn
         wMyKtqlMFH7CHwQcclspe52/SsparnQSWpj9TgtVH7ZM6aUPUcRczcLlSWSNu2tzEf/N
         sdmA==
X-Forwarded-Encrypted: i=1; AFNElJ/25nzYXSErTFfafbLCnGXcQw3OnufUqzpDX7vSJnvwxWUWi5iocfW4DPL3PyhEYlhC7D4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6N1YtpRxS3hZNKv661F7zdmUgNANHiO+S44DmrfSFsElhzztR
	TDZEcK0ZIYd/R1Zj/sNtEplgc7PbxKPXfNlFmi881lhL7pQehWvyBlhWQse8QP8BFNkp8MnBfok
	So/bi/53685PhxwUm2P6gLTX1cs7jwPbmgSlgnyurQsTNhrRFmwJatA==
X-Gm-Gg: AeBDieuNbB4PD5SY4ILTEjKkTjNCz3Es5372ze6i7v/ywKQh+zil9Tuzq7iRlafdEzY
	ClcbN4GNhn780d3lluMFF1sBJuXnM2hruvp8KMrzuXYt3anprm3L1dZuzGNlVFuKIBwm0caZW9/
	Pa47WSmFPSt6UJVuxJhiZdbD8gYSiwPyFFl5ODl1WMIZ+wmZEHYnzvEL+fEdL5rkQRNTiT+AoO3
	B2pJVBjWRlX2WdvLHXiDxxy5vuRWsoA5/4PdKoPfwlc2xpnvMVtz6gnV0O1idCID4ZYF00cIlht
	n8B1Sy6uXWKbdOaxK8+d0QqPX+kocvT1nLRxrGwIC7U1km8ldIw9zw3AF/AWX485P9jEF6MaZup
	cXTOootDwzP1JKdZrAqHxBdd4+GwP7Q==
X-Received: by 2002:a05:6000:1a89:b0:43e:531f:720c with SMTP id ffacd0b85a97d-44bb51b6744mr13022671f8f.11.1777881525967;
        Mon, 04 May 2026 00:58:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1a89:b0:43e:531f:720c with SMTP id ffacd0b85a97d-44bb51b6744mr13022636f8f.11.1777881525584;
        Mon, 04 May 2026 00:58:45 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aab44sm25180557f8f.29.2026.05.04.00.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:58:45 -0700 (PDT)
Message-ID: <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
Date: Mon, 4 May 2026 09:58:44 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-unit-tests] realmode: load above stack
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20240604143507.1041901-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240604143507.1041901-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 16.35, Paolo Bonzini wrote:
> The bottom 32K of memory are generally reserved for use by the BIOS;
> for example, traditionally the boot loader is placed at 0x7C00 and
> the stack grows below that address.
> 
> It turns out that with some versions of clang, realmode.flat has
> become big enough that it overlaps the stack used by the multiboot
> option ROM loader.  The result is that a couple instructions are
> overwritten.  Typically one or two tests fail and that's it...
> 
> Move the code above the forbidden region, in real 90s style.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   x86/realmode.lds | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/x86/realmode.lds b/x86/realmode.lds
> index 0ed3063b..e4782a98 100644
> --- a/x86/realmode.lds
> +++ b/x86/realmode.lds
> @@ -1,6 +1,6 @@
>   SECTIONS
>   {
> -    . = 16K;
> +    . = 32K;
>       stext = .;
>       .text : { *(.init) *(.text) }
>       . = ALIGN(4K);

  Hi Paolo!

FYI, the realmode kvm-unit-test now also fails with the recent version of 
GCC 16 for the i386 target:

  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/14195195727

It was working fine some weeks ago with GCC 15.1:

  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/13977260961

When I apply your patch, the problem seems to be gone again in this case, 
but since there were some other issues with this (with older versions of 
GCC, I think):

https://lore.kernel.org/kvm/49f8aadf-6e3f-4d2b-a32a-8ba941a3a2a1@redhat.com/

... there must be a better way to fix it?

Could you please have a look?

  Thanks,
   Thomas

