Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387191;
	b=RTcblG0ji6p4ZM9oMZtCqq4HmJAiJdWfe7rUE0d744GztabXVCseUicVx26WQro0auvr
	 t6uLyboTQRVRNPSqInmj5zt1V2KzK7cA0tL2Z/feRMLcdhrTZJ4O7BUgJ5Rw4fMfwJ9gI
	 TZoet2oU8i2PCV+lt4GIbgXT9RmkueXQlF/lrLO9001jOlmoTpNT3MevmwUay/0tItK8c
	 V6vVJvH7DM2Ar4ZQ2sh+1uxZBDp5mFE85CGbPxnc03+Wu3rUGkO7V8VP7GrrfAz/NZVBq
	 jEEtliY9DjBvbNwgvlRvNALEPLYl+/xFZ44Fg9nXCmRt+6vvbCFhy6HUCEnyYE7q+Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387191;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Bup+crGi6YtoSqoBJS8ljgeQUiUJYX9ZeouKCgYprC8=;
	b=eJ91UvV5/UDOi10LKsW2AK6nsz5R4AWkTcdouOzdlgsmP0rqpO8UKPwAGaFn5xkxXs3E
	 qApUn7Iz++ueT+iuXWK3D0R5HOcQfOlZnPqtUzwK11x6rOgBj6LQ1UuP//joM7nXsu+Qp
	 ksYZ3dnfnq1iat6KqM/5KEfnbAKKmHEE239+3tD2vhZq7TsHqPRZcGReO9UM2gwdWjlDn
	 KayoONn7/VsSfEL9KoEO3UrmrpYQLDhxtL/1tMwhy5K/L2NDElkcVesKSr7NXP3QMoGv2
	 /hZIUf7MAroGthWL2vSoFPEOP8OpVi1e35WBQMcUB/gsHXJtUWx/S3e3/hpBLkwPpyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a2TgLUez;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fApUEOLS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C513C606A326
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 08:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C513C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a2TgLUez;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fApUEOLS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794387189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bup+crGi6YtoSqoBJS8ljgeQUiUJYX9ZeouKCgYprC8=;
	b=a2TgLUezpEn1aqdatrsPP/g8UhCZp1ga/RYbeYJRNwAQf9oHrtmqHmIXBpYj6RkkJ5sX7P
	4GQVDyiLLwjFpm46KJ3uLLY9G+qCpQwwHPw/5fHxBxmOzPneZglqrEJ+DXMbHZLRHdrxx/
	eTb3r6KhCMyxSSj81V9yOlFqyfS9FCA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-cctxvdK0OECQ5MhIddgUQQ-1; Wed, 11 Nov 2026 03:53:08 -0500
X-MC-Unique: cctxvdK0OECQ5MhIddgUQQ-1
X-Mimecast-MFC-AGG-ID: cctxvdK0OECQ5MhIddgUQQ_1794387187
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-49337a224a8so2620157f8f.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 00:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794387187; x=1794991987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bup+crGi6YtoSqoBJS8ljgeQUiUJYX9ZeouKCgYprC8=;
        b=fApUEOLSfUCrD40rwwqOxCVXmLJttNbBKaz6sx2UQfao+dpMuEzAev7ALCEhWDDJDK
         7baRnwOMoGocz2UE4Zt2FF2h02ggNP2ZpUEiKfzH/eXFoYR5+ueNKqNiBnToRR1Jtbku
         DS7OXoXT9NlKjErxpEivQd3s0N7Qi6snDrJeEaJTODT3WrPXtF66TNhfbgdFr6Xywp8B
         PY9PqNXy56wB4M2NeQNHdJD/c/6B7vdauCvun9CdndvkRGuY7S9Oy/+grjYhEKBGoX9j
         P7s1mTkuvtmMbaJNgHHO1FsJqTa/d9XW0wa3EF01AE6M8S4Z5JptpW23Ua8fb9SoG79d
         Z41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387187; x=1794991987;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bup+crGi6YtoSqoBJS8ljgeQUiUJYX9ZeouKCgYprC8=;
        b=lopZwqcijMRcMy5r4kzgdxqW+Lm4C3QXgT7CASO8v7mx6WhO62cpEVJ0PMFoF2KWaU
         uB8ydZJq4nQ9VsX2k31UC2r/On/q03+e2oBSryOgvXbVc7jZTz2cE4wqkzp+phk1w/0X
         vJObQj2QO4Etsk25cUaDYXG+F/pr1tzjF48EhEl9LF0YGeXHdheswaaDqoxKzouCMzHt
         6/kSKDn6oRFgtPxF5Zpt9q4l3eBjHxAnZRJ87ViVdg6YVDEICQlFa4OE6r4d0bmt1uLp
         JfqUR9dAs0D4iQqbnoNMdMdxePyxhpiTVaRhwZNe8aOSzBeBbLf/Mz5MBzgR1fDxMhtI
         sFwg==
X-Forwarded-Encrypted: i=1; AL+hErEtwe6+5UtFniVmbBRuyRQ+iWeRyTJDLHow5vgSguTbE65ck17WxJQ4JVUKbyZbd7CuYik=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3ZuunAjW41fjFuiwcQn6o3+/69K7kjJhTeHR2j3bmS5mopHAp
	jkWn03UYCKMnoMbKeid6F3Hk4S870IzGJTaX7PhU2VubgRIU6VyySA14E2lfdmquuOfU2HvmiZV
	Wg4OXGvCx6Iu6Iu6KyZ+IETnrBTRgXpe6r+aW3DgDq7KDqf30Bmr2kw==
X-Gm-Gg: AYBFou1cqRnVE+x86Bnnj2/qQlX660X6WUA33rRUbEuxPjjKgeaLVWSTxBuNhOi+Efr
	fjnW8kb4OJW4r9U40bwlSaQCwJq4n5gx+QDLGR+HyBClMu33Sd+7RbT9z50nPU7ZPtl0ylLx2bb
	eckdsp4eFiaBtWoHvgPQJLwG8/DU0UcUZEdr265CXptU+aXvrHZLKCmqiA0r/7dwNXFj8VsQjQQ
	CF4WGfCnob687EGDXlhu1AW8YIOs5p47MxFwPNkKCl3zPmOdwcF+P49aG8z1s4gk5LUSRlJpVEV
	ANVA0ttTxEyyfpaZ6emhGBotqnYeMlUfikN1bsVSNLXmLT5BlbNO6B8JsS7IAXi2V3b3sKuux/u
	LPvxV9XpDIcOi/tBcWfs1zuBE3Mcf090GuhlrmT4YNNLG
X-Received: by 2002:a05:600c:1989:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4ba0931beb1mr28238405e9.3.1794387187057;
        Wed, 11 Nov 2026 00:53:07 -0800 (PST)
X-Received: by 2002:a05:600c:1989:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4ba0931beb1mr28238055e9.3.1794387186718;
        Wed, 11 Nov 2026 00:53:06 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2c5asm191780205e9.5.2026.11.11.00.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 00:53:06 -0800 (PST)
Message-ID: <fe4b7c46-2467-464e-91de-c3868d290acc@redhat.com>
Date: Wed, 11 Nov 2026 09:53:04 +0100
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
Subject: Re: [kvm-unit-tests PATCH 2/2] x86/desc: Remove unused exception flag
To: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jones <andrew.jones@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, kvm@vger.kernel.org
References: <20261022204413.856786-1-yosry@kernel.org>
 <20261022204413.856786-3-yosry@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261022204413.856786-3-yosry@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 22.10.26 um 22:44 schrieb Yosry Ahmed:
> exception is set to true in exception_handler() but is never read
> because exception recovery redirects regs->rip to
> exception_handler_longjmp(). Clang 24 warns on this with
> -Wunused-but-set-global:
> 
>    lib/x86/desc.c:483:13: error: variable 'exception' set but not used
>    [-Werror,-Wunused-but-set-global]
> 
> Remove the unused variable.
> 
> Fixes: 932ba2d2f530 ("x86: simplify test_for_exception trigger functions")
> Co-developed-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>   lib/x86/desc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/lib/x86/desc.c b/lib/x86/desc.c
> index f4cdfbc92c560..b5d4056260a1d 100644
> --- a/lib/x86/desc.c
> +++ b/lib/x86/desc.c
> @@ -480,7 +480,6 @@ void setup_alt_stack(void)
>   }
>   #endif
>   
> -static bool exception;
>   static jmp_buf *exception_jmpbuf;
>   
>   static void exception_handler_longjmp(void)
> @@ -491,7 +490,6 @@ static void exception_handler_longjmp(void)
>   static void exception_handler(struct ex_regs *regs)
>   {
>   	/* longjmp must happen after iret, so do not do it now.  */
> -	exception = true;
>   	regs->rip = (unsigned long)&exception_handler_longjmp;
>   	regs->cs = read_cs();
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>

... and committed it now to the repository.

  Thanks,
    Thomas

