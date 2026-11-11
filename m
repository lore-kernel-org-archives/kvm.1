Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386910;
	b=btA1JoBl0qz+u9g6ifKOARFz+/MwFK1lgpfT7WBZAdf/mwZKWQbrx2US3rmXmMBzdTOS
	 lFHlXlIqGL88AdLuUYRvCUQhcmBjSMAfqmHWT6Ads9iLzicXt793QnR/KTBmg7IO7apFA
	 viTYiFGSoN1gl5CAJrStQFBUNKmJQ+YuDdWusvUjcfiXCSYBqnA+jb0poKE+9DLyJ4J9r
	 +sUlEq/IZrScelWead7O+rd/I0ybSPax+yHQ4++XBWQgvy2jRANY0rqiYSzhsYTKJW20m
	 +t7uSPsoLD9d/P0ApXjgbIASE+QNQWu5c4eTmGDG0d/Pt3R1CfG05a050zUpN8y8pPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386910;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yp8s2J/InivNK5nKc/stCkmRC15VJslKGiXFwHcA1KY=;
	b=qtNQ25egHGFOHoDwXKOLqVTJT9EE/EU1Y4eMyd5wFmMoCOHkx2Tn3UQ/YYUUZrFL1QZ0
	 Nejd0da10imWLA75pLFnPn2oSOPSZm7KQDpARXYh7PWi/mRIIa+gLbktmKWKLlFEHlrXf
	 XAMKQtcgXj4UWuNLeeNY8o7oIofUczW7PktfHifzNG6SUBFx/1McTqbPu9NN150AYziXx
	 pP6wgWQ7nd4D0wiR5DFW+BSsjOe8vqUODYwl60HmmQGCynus62rlXbKHQdVAjpu0bpj3o
	 5zspN2RK+Hg2aiaIIsU9Cq2RknbUwed/5ZdeKZDXUtz05ELZbu9moHohoCiBlXSVkUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="a+gy/bon";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="fsshDl/W";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C18606A327
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C18606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a+gy/bon;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fsshDl/W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794386908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yp8s2J/InivNK5nKc/stCkmRC15VJslKGiXFwHcA1KY=;
	b=a+gy/bonjwnOwCaeHhnQHDM9omCtfOCfkoGSYxxO67zRIkkU6+2HxfKJ68NaOH3q2k+KnK
	Tr9dhz/GDTULwALtxcboHLK3mryqOfbGra+ec3mqzUXRvcSB2ogXALjIAlXhBEMFgv5Pmk
	V9i3WKZRbywYf6OIBusFEXn8QrM6B5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-AN7B0wZ7MmadF48Yqa1yKA-1; Wed, 11 Nov 2026 03:48:26 -0500
X-MC-Unique: AN7B0wZ7MmadF48Yqa1yKA-1
X-Mimecast-MFC-AGG-ID: AN7B0wZ7MmadF48Yqa1yKA_1794386905
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-490ab0a20ebso2196186f8f.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 00:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794386905; x=1794991705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yp8s2J/InivNK5nKc/stCkmRC15VJslKGiXFwHcA1KY=;
        b=fsshDl/WgMi6hvMfkGVQ1HUT3TJWN6K/bfBtrPGjwbpm8mv6jDUs3J90RHcss+qO11
         nJWgEJq2XcUmGW8ZaHq+A3d1KEzHXZhcuTJnSu7o/3ilAwRBPIhiUH6mwjbLdLRYWuNj
         XJlIILH7CofYVsaRGLy2L7sghr14fYsMkvKXICp9FI+Yypcx4SQmxeOr+uWZ7e91tkw9
         k4znT2Ro09QAR5XPwhZvjiNiXvH+OtMWcCjrmWQ/jlxMduUigEqDcf1ySszeBlhFrDh1
         UQva5HQxobViJCQ6VrymGVM92jCjuwYBrOhzsnBQSbN2g2Ek5f8ejFNJFpyrYWVjiE5M
         ijJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794386905; x=1794991705;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yp8s2J/InivNK5nKc/stCkmRC15VJslKGiXFwHcA1KY=;
        b=A//bw7cyUGFKu4SvyHBfBS3eAjq5ImZVWYJ2YfWH5XxENIXHNBfstNWQN0Vb+2TRSB
         40LAE01ZODrwVxMqrcX9uqTIL669epLjSpPqgMBlWHF1T7KtL3sT8FXeT+tlW82ykr0a
         3nKgaX2a8VnsA7FHu9/ff9reR6on9FAuEcC/UQp0TPtI+7OFvZf1aynppget3L/EYvGZ
         hY33dWz7O+WQl2lCAm2cJel/f9zUx+MBBqqthVBR1+QgBjC/NUP6RDRCFi7wqVGJJ0Ut
         FYWtozu95oRqqm+HwUc0vV5ac2wDj0LAc9r6imYLlK9G06IyPrFgaFcaDBFWOTBGPx5q
         a0kQ==
X-Forwarded-Encrypted: i=1; AL+hErH8T+AUQqiUIhJz72LEIm6uX7Rl3M6KKkA4N7fVz5IsIiXT2LwxoxFdGgo9an7pOnSapAk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oCwpBFuJ/HAL0U7rYvNta8v5chSkjEU15gZvpVAhCA/hpGr5p
	Ub8s1EhUMtgtFIT1iER1EQeD9Ns6nPYiAtKBzHW0HVj3/McsRxO+p9o8VBiBc088SOflHwszsP+
	KrbCnJ52d/zll89J/hPqcSGg59YDTLxRQISSFQNg/zo46jJ91tPdfmg==
X-Gm-Gg: AYBFou2eRA9V28DTCFputX0kzxkIR6ppNYKQiDpQ3y5RFa4Lvf26Vr/kBOKvyvc0X1m
	fhsWup7d3+CeeqTg8yb5aqbHEF/tFlMgvs+ofE4zmPRFoW8C3YWOcN3Ld/mdYjEw9H3zT0/SIsZ
	jF0GJ6Z2scI6IStWeHzmZbxPZh3GcBmwJzxNqrIiTxOJ3GiXoQM4rbc6iUJ4uWTHdRLB5wxopLq
	UZYf0hRi+jw2mQGrWnGVH8vV2QpOhp2iEe85HZeNbIgB22vmkAXJ35XOgKHDuw5pLFlw3q/SQfF
	Do2L6dXi9nX5JM4JcLH9yboytpfDNL5Vh0DAcaCgcw17juqnZEsny8V6GPZqzX6KI+WIIqrHZ88
	fojLqbvK7gg+St0PeqkfYIRKXhTGAcj+xt2i7bG+E8T4Emw==
X-Received: by 2002:a05:6000:4a18:b0:491:3fdd:af34 with SMTP id ffacd0b85a97d-499c81d65ecmr2447517f8f.36.1794386905360;
        Wed, 11 Nov 2026 00:48:25 -0800 (PST)
X-Received: by 2002:a05:6000:4a18:b0:491:3fdd:af34 with SMTP id ffacd0b85a97d-499c81d65ecmr2447491f8f.36.1794386904977;
        Wed, 11 Nov 2026 00:48:24 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bc9asm8946568f8f.29.2026.11.11.00.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 00:48:24 -0800 (PST)
Message-ID: <3430a395-8e25-495c-b74d-52e2d2918297@redhat.com>
Date: Wed, 11 Nov 2026 09:48:23 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] lib/x86/desc: Remove unused variable
 "exception"
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20261111081833.69641-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261111081833.69641-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 11.11.26 um 09:18 schrieb Thomas Huth:
> The variable used to be the return value for test_for_exception(), but
> commit 932ba2d2f530 ("x86: simplify test_for_exception trigger functions"),
> changed the logic of that function, so that it is now unused. Clang from
> Fedora 45 started to complain about this:
> 
>   lib/x86/desc.c:483:13: error: variable 'exception' set but not used
>    [-Werror,-Wunused-but-set-global]
>     483 | static bool exception;
>         |             ^
>   1 error generated.
> 
> Remove it to fix the problem.
> 
> Fixes: 932ba2d2f530 ("x86: simplify test_for_exception trigger functions")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   lib/x86/desc.c | 2 --
>   1 file changed, 2 deletions(-)
Never mind, I just saw that a patch for this has already been posted three 
weeks ago:

  https://lore.kernel.org/kvm/20261022204413.856786-3-yosry@kernel.org/

  Thomas

