Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A01E8826
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878075; cv=none; b=i9p2Uj7a/Ge7zwPl3+kZS/lD+wpfZuJTorbGdeX1Wgc7AZOd0rnKWO6A31hFoEdXafBKXYAZN8UsSTopp0KL7kBqdUyy1MmCcV5qUFgxVQG6GY9AZsGpxyk65JEvEugtVTiVZEwM+Pp7iK4OXkQwKUeoaLndG2qeuy2LKM1NVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878075; c=relaxed/simple;
	bh=eQ+vO3uikK3r+t8sbnpREdRELM9q83TJDDxfewgcNWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mmn1y87JZiUXNJ6iIsCFuA4o1JxOFjg9ZDYCj9oNKzQ64GWEfkQAT7vRHfmjqPujBbFzGx+1hyBtDS9sJwFfRTRuJRRo4Gyludkg95GNOEnGNvPx9/E2EfCPOK/ym2B2MpEJrQ8g+uQU6cGCbrYYB3INVbjiv2myY6rUhkAlnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhcYG4ww; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcWC9RO8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhcYG4ww";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcWC9RO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777878071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qv4lt8vvSadY5VMdb5+FkHDDdj82rSVshuJj79hlra0=;
	b=IhcYG4ww2Ld0Ee4YsPf0IYsn5vniw4Z2MRHPlMrq3rCGMIQocV1MOWzmzTxXLWRjc0EGuo
	tGb/li1YjE1Ra96ckuuOrPtRftmNWTZ9nHM9bz13tYXNFyM1XV4whDKbhGFywjhFzxyDE/
	KTrT7kirPCcqfjPhv/xKHrOPTY3cjS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-0Ge0Dqk7Pfu9N5quoS6HBA-1; Mon, 04 May 2026 03:01:09 -0400
X-MC-Unique: 0Ge0Dqk7Pfu9N5quoS6HBA-1
X-Mimecast-MFC-AGG-ID: 0Ge0Dqk7Pfu9N5quoS6HBA_1777878069
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4470d6d2a4fso4130524f8f.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777878069; x=1778482869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv4lt8vvSadY5VMdb5+FkHDDdj82rSVshuJj79hlra0=;
        b=UcWC9RO8U4wjvED31v4FsGP9SB4O87LWz8UEgsZzuY/2V11JnM3SYu7veCKAp8Sqca
         yTJ1TNHivDk3obtWGuOtegOvW3oFseRKskFcGwy6ZcY9jKk8qY/O2dF6HLYgYnSb9svn
         nf47b8/JvsLqFMzrmAQkORh8cxYL2CXug1m/xcwYCgvaaqryhui/8OuwXlM1yNIAg7Ed
         mm8fRr4KrT1UH9m1JCjk/IqDfKswlXmtHukSmFAb9w5DOPV11x/Ee88ACHn9JkdbyUMh
         hLVOjd0xeGQ8gBCA9DyXmxe+UZqbO7Kq7uSgk72VMwjagVxGGv9Qp4sBKKHUkeBeEf35
         Nwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777878069; x=1778482869;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv4lt8vvSadY5VMdb5+FkHDDdj82rSVshuJj79hlra0=;
        b=TLYVMgxDqLl7HZ/PrBF79ze1hJHj8M7I1CWuS068o0xjY6HgwfgxjIbcFYWKQBzsnN
         sFoFiwjPRRHmxwyf6izxYMD9RG+PeJ7/Ps3b5AeFhlpH+IzJeAuZQxOfR/UIfb2TWQAN
         SjSTpFf7vLaQxxHj34ZivSlG3R6Qk+W27HMR0oyr4+IewivQovW5EXiVApXzp1oNQLo2
         4EVbLDeiDEhTF2s5DUxk5xPSk0tmua9ILjPo7mmGpK6R7qZNNCKEKABJftoMuYDdzX38
         f61B/qD0RGhojOvXu4gB+kcZXNutKSirmLI1mqeE1M7LJo46s4ALPU/le0LHfFX1JFte
         /Wqg==
X-Forwarded-Encrypted: i=1; AFNElJ/ACgNZnxEfAAbZIwVjYuCCHIsIw932L+7LPP6Ac0EylEKazeuRu8KakxHWLmV8j8LqzHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NOm29BWA+msglMLCmzmmFLRo8eaTQDS2nBDjlDV+eN6KaGBt
	qxC7joirhUgy2DOdCbEp2EpAhaL0RpqPUcU2BA9UWqvbE3OIuGzFTGWhwyd5nlyyGckLONkU9WA
	thB8qd6Eqjix01a1TAzgWpN5cMdlvDwbKzjmaTx8I/hFqcnUJiDZOuQ==
X-Gm-Gg: AeBDietPklBl1qa3YWyzQ4nRUlEPALaj7aSHEVyTiEyNJ+Vff3MbvSDDfvgrHGpvZNi
	lLVjZCot47lNh4flfFsZVtjoB7VOlQ0HRRBn6GC2HaN2x+jrWF0Oz2cjimEkO1U/a81Jmlr6AVg
	yfB6hCjvCUei2ja9lPL2ktH9HynCL3cYoM2yPDxAZa8xgZp1r0ryEXilcmF4EYeDentaq0vUHam
	1C9oryotJ7jZdP5ipmTzkaY6F0BqlKicN5AQl8CeKW+F0J00VQYdw2ng53aal7V+xatz6492aVo
	Bp/rZOhLcUdYAB5m89vUdvatQTttXeJI+Jlbrr06XJBJKpTGWk7531+0byDMp91223rztYFufvM
	Jko6kjLcX2HI0KkjzI+HpVA9sxqaQRA==
X-Received: by 2002:a05:6000:4301:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-44bb66d4b78mr13694592f8f.24.1777878068756;
        Mon, 04 May 2026 00:01:08 -0700 (PDT)
X-Received: by 2002:a05:6000:4301:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-44bb66d4b78mr13694528f8f.24.1777878068309;
        Mon, 04 May 2026 00:01:08 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.246])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7d0e7sm22277051f8f.3.2026.05.04.00.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:01:07 -0700 (PDT)
Message-ID: <d90975a4-a141-4d65-816b-0b2c5931493d@redhat.com>
Date: Mon, 4 May 2026 09:01:06 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2 4/4] b4: Add b4 config with default
 prefix
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
 <20260427-b4-cmdline-v2-4-0fea2a50a9d0@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260427-b4-cmdline-v2-4-0fea2a50a9d0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2026 19.36, Christoph Schlameuss wrote:
> b4.send-prefixes adds the prefixes when creating a new patch series.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   .b4-config | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 000000000000..b780cc3d4e6f
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,2 @@
> +[b4]
> +send-prefixes = kvm-unit-tests

Reviewed-by: Thomas Huth <thuth@redhat.com>

