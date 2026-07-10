Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C64229A8
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691045; cv=none; b=hLNbbC8DU+P8rbFv9846HYJ4oTW8KJUkIuElwouH6r2GdsL1QRpHY0WZ5Q0BJka/zhmlTAijLHncNCRuqRCM6cDFPM3Myt52v6iILhkMoqJojEm+CP7+G7G1Fjn6JYeiz9DorX6pWwtbCNZqG7wlNqc2WEkH1aZyfrCBCMX62pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691045; c=relaxed/simple;
	bh=TQ2EawHTybhqz5ut5OdOmkwQ6s4YPHVlTvfcwcLsDsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHN1Ul5TSR72T1Zb5ILzsHnjS4j9TORCYro7bJOumnJ8a8r1UKMnI3rb17sSW9mtplgW8SMVj0I4LDAucMrGuXbKj9SHtr3lNlN2Yt4Qs+rhUVxzfph12shaNYtQ5Kbqxo0Jc42QG7D8DugtBWxvvxTYHzH75JrOp7rD+oSxLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmbDQ64E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+4B7+nO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmbDQ64E";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+4B7+nO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783691043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aYJqpLb9GIgT20IUphAhHkDOGA0o7U4qoe1VhHkgGlU=;
	b=QmbDQ64Et3vrtKWuqkTfg5Qs2bgzVhJcmxsJOtUXwpf3tcJ03MsmBLS70vTgPGd0xsEWdT
	N8aCV/K9uV6z+/T9zIgAacfgXVvAav/34XmQnNa67MMb4vZ2j9PGRJuiApeX1a3ntjw+MB
	WsvCDRtNUkwOPWpaQ7bbQBS3D8cgk2k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382--4tvcIXlOD-dfQiASNT6hg-1; Fri, 10 Jul 2026 09:44:01 -0400
X-MC-Unique: -4tvcIXlOD-dfQiASNT6hg-1
X-Mimecast-MFC-AGG-ID: -4tvcIXlOD-dfQiASNT6hg_1783691040
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493c526df6bso7528835e9.3
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783691040; x=1784295840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYJqpLb9GIgT20IUphAhHkDOGA0o7U4qoe1VhHkgGlU=;
        b=J+4B7+nOOUK2rdE7v9dCFXEjXgXoiXSQwZxVrtvYeFlFj7OBCtPabEFWdSKxL4Z9dX
         bVRsGMJz+OsbC4eaVyogknYv8eDEgcnAnmKJdRZh38kAnD/CDdowu/1Aw1oK971Ambjv
         NcNpQwEa+4Yr0cP+Y9jU9GXjyD6QHm+8YxxsTLH7Lo+yRxUGFATAr8nacQZYPFcmAGYn
         FNX2AE8kJMivbDWPh0Qul5nxrkOzGv8wSqRgbZA8nUyzDL+7XyO6/TWn1GTmZ9a0xy75
         QhImjukQxqN7DtpotSebop6wsrCWBr3FXBDul3rPvK4+M1UJFjKFVDEb/ROf85cFjhdo
         h5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691040; x=1784295840;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYJqpLb9GIgT20IUphAhHkDOGA0o7U4qoe1VhHkgGlU=;
        b=oUs2b+JwPZrwpbAPVUAKCp1OU4yD+PaLL6Q/HcUQzPOCnJq3GR8cARHjcAn++/hIjL
         0j7LQo7T3ipCZyDZdh3AMHx6Hgr/7bhQ+IpQ+m7FPuZDhTE/+UYjHyEjfQhCwxmXZ4+P
         8nryc1FPeagq48VYV+cnWxqfuPslFLVy1//BQyQRpQlevnPmP9FmN6G2oP6isiNUnKf1
         0VEMAPWwqAQpKqfNtj0r3W7ZQEc+I4cyCoyh9qAzCP+9bebLO6kTIqJWBp0Dl0WfmgIv
         SWQjr9R5KgMaPZ2tTYajCiLLJ/1msRE2BGmryYkn0ENMw/4xelU/8pqy+B+/G5clZcbk
         MS/g==
X-Forwarded-Encrypted: i=1; AHgh+RqBrHqlJSXAoTAYi89ApO6sYiaMpVzddwlBou/JXeKfP2Z9YPmQMvfIOy7NQ/MnISEdq1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxixoppMr8YUdPmIA9lA0mwfjrL+xZ1OdoZIhMGyoU1CzjEQbKR
	PXOTC8RQFz8duVsx7FZmHF0rTn+xCYj+g6Q1TUWF/KcEELiG05b05nTalzd4RxGaCfdRQ6RDd6K
	12UZGdJ9Y9ZgeDfO0wZSmspmmopPtmIlax8+kqtBH2dG3YiFMEgMxGA==
X-Gm-Gg: AfdE7cmL7VSaVMwKL+VKFOSshN7RIO49WeRF+k3eYvoFSWvobCW1wzXeIFhM/TqWKaf
	Rqsvn3t9mrqawwZdkxmCbX2JZtPa8loi8f56aUD78X99MA1h0zCa3ipbn2n+TNA35RvKm+YWAML
	JeUJtj6oJjv6AA84vWin0yqjFil0T7vsiGborDE+tN50st3BIgxg5vAGQSiHLYWcaawoSwMzZAv
	2d+gdYDhYFf8id8bF0+FS8NujNPCqBa448FwFRHb0TFGNFrNwe95J9s3h03Rave/QFHpWL+pBM9
	Cb1Nm72lj5YQ8PH04UJl9NLj5H/7CkkKUCCx9idkjVD09WTYXOBpwwoOJEAh3M9rIdFnOHp9utf
	NwRbuTD9EXo7WzUlCRB30K/hzz2V+S3MbfJUT3rbRr84PhVAqAA==
X-Received: by 2002:a05:600c:c8a:b0:493:c3f9:65a2 with SMTP id 5b1f17b1804b1-493e688cf81mr123108445e9.5.1783691040292;
        Fri, 10 Jul 2026 06:44:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:493:c3f9:65a2 with SMTP id 5b1f17b1804b1-493e688cf81mr123108055e9.5.1783691039782;
        Fri, 10 Jul 2026 06:43:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c? ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73ae14sm136837915e9.11.2026.07.10.06.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 06:43:59 -0700 (PDT)
Message-ID: <ec03b514-3252-4895-bb93-e577f5347b18@redhat.com>
Date: Fri, 10 Jul 2026 15:43:58 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ui/input-barrier: fix off-by-one in keycode bounds
 check
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/6/26 14:53, Marc-André Lureau wrote:
> Use strict "<" to fix the off-by-one.
> 
> Fixes: 6105683da35b ("ui: add an embedded Barrier client")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3951
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/input-barrier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
> index d07027114af..0a238d4010b 100644
> --- a/ui/input-barrier.c
> +++ b/ui/input-barrier.c
> @@ -87,7 +87,7 @@ static kbd_layout_t *kbd_layout;
>   static unsigned int input_barrier_to_linux(uint16_t keyid, uint16_t keycode)
>   {
>       /* keycode is optional, if it is not provided use keyid */
> -    if (keycode && keycode <= qemu_input_map_xorgkbd_to_linux_len) {
> +    if (keycode && keycode < qemu_input_map_xorgkbd_to_linux_len) {
>           return qemu_input_map_xorgkbd_to_linux[keycode];
>       }
>   
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

