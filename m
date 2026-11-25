Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605426;
	b=M82B4YmkxJoTmMRF9CXKoRbmYulsRsvwX314j2VbZ4OvNeZYnaS5GtiV3wqXNp3cQf3u
	 ZKdBI5p/FsbXQ1S9wRkxp2iokCTmhFyv32FeLvFnuCP4876tC1P1cL+bVyT3QOF0xvj6g
	 1V1tbILmh9YdiMLe6/klF6mG5q2FbezZwPknqjOY6TdDnk1MdwnqSnnhLLF14m6YpdwuV
	 2EjKBsqIqa8g9qMOqu1x/xX5DOpd0t5XZIR6FzwpBcArM0DC2nwSXEHfZTUcPaQUtp2bJ
	 GN/ifgJoY48bBx1Fbiauyio6BVQzm+U6ng1mb8kC8pa7d8onJqm/ynd9uw5YTtSAynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sDsbr5ve7lstRzCqqwaH7hey2ad4/GX/MTHn8iSlZz4=;
	b=cevokenXKUWfGSqIf9bjSU2rk03q3qMKulTLBFjrMMoQVFehU9bE76ur7gZT79Fxo7hu
	 HuezGr+EoY5cxmmyYkXF6ZiJaGxqsnP64zudXU7dkSIuxn9sL683UCa2/LvbiZI2o1so+
	 kqcafKylrUU+JrmgVbPcf+UMeJrQogRGXsDjReGQwPvnCPKB6xsfEnpkUFvjjzkx5Y+q2
	 DEGlJmVOYZUqU0BZQxsbgIyhMPxePFmJk4AIMSkAuoMBkuiiEfPRrhBDl+XPokxwSn/r6
	 2/5XeFuflCDOon84BdxfMHXzJGffVU32fu20uPg/QVxnaFvgBEv+Na4Lf8oHC560ZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMkI1s6q;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5B7606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF5B7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMkI1s6q
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso40189885e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605424; x=1796210224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sDsbr5ve7lstRzCqqwaH7hey2ad4/GX/MTHn8iSlZz4=;
        b=uMkI1s6qFOru4xt+WokJe9Dl4CxAgIuSH4XscOvVLlbHWdW7CpsAvAvPQsa6HpkO5/
         ybEcsviw1zeGb+mJBVcBUuXpGvG/LR+R/Pd8FOk2LagsGD3awKokzW1EZLWGfFg216Ys
         6FY6HATpLTk81vz4pDyEabpLXGsEFzH2/Z/V1yQNm/l6z0vNVXF3YqyST/Jm8pk9i12d
         JhqWDGN3iXvHP9SDDRFP0g/9Iwg5rbrQEVKafRHWOA6ySNFQFuiRgjIb/w6+3oK0YmlJ
         5sBcJW6CaZYGg5ez6FGDyGj4X17ijMrbjBVuD/AJ9S5fDHyikNOt4dwVSnGWWS8GvRkD
         3M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605424; x=1796210224;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sDsbr5ve7lstRzCqqwaH7hey2ad4/GX/MTHn8iSlZz4=;
        b=Yue+xOfhKga4ZDZJnSbJEguf3vV8MiJwk2DXi7YA6bhWNkWMg/plZuBGewLP1B1wqV
         3fTYSbQfrUFBmAQpldCIRwfqYbBcETI7SvcxOEqZc3xv8GREi5Qa862Ih/aj9MqC6j0A
         puj5Fz/RzmRY8g0fHzN/uKk0kzJZnqfmX0+y5RdXkVBJLV8X8IeUOWmgpHpI7YrlS2xY
         JLzsvu+calmSdIYauBaCGtZC0ejA2pX7sGOYYWf9/yfwrkFksHV2TP53JR1+hZGOqpwt
         jRxdd0TYwfH7YHaoeV3s2qm83jsLuoz5ryhtsT7Nj2vE1vtRBpueW4377ifozdpBY4pc
         njvw==
X-Forwarded-Encrypted: i=1; AL+hErEE12euJF3vyj/0+gpVT5WZ5lkvpwmj+D27noev2qvhr4ho+82/rfqy0MFaQdvE2r5dAx4=@vger.kernel.org
X-Gm-Message-State: APuU4Z91TZ3DL8/g/53zTVvJ/i6HPwE8ijEBt7ph/T1RucYqs/7rRSlO
	nGLm2yAME91CcfXNMcEB6D0qvaD91vwuDsK398/6iC67s2jPTsvrhn3e
X-Gm-Gg: AZFdTZeEjwcrm7UBC6aN3tX6D6wRbe6NNBvCXEsYclVkvnnu8kBHlRYqqRzK713OI2v
	N10uOVnMEdXS6HakAiCFYeEakUu/YSo9GldI3N2LhCOoqdXDNpwlk8e+SQD2/KtrmVrBgq6Fe8w
	JmOfVKK1JrInGEY0xYipHXqdw1cH4DUamGu270Y0bouN1b8APKzlQkNLybOS7Cbds8B3/7iiTTo
	p8Pbv/H1rKkbuibd3QSAzP2xHNt8A9BwmkLfysb1DQXrpcbjTZHemhS5ueLNPmvdb9P5VxiPLcM
	ujbg+IZ3THNom05mGD0MP7XX9jEaPKm48WX8A7GCUKu+L+ofDCLK3gsAVsgZFOlLUOTir6oqjfw
	+ksDeQgnrBYkbWz5VUCj3O9pa0uSlljlqTFC1UEZ/FIWv5lcgLNkhjYQcTNvnSX3sEcdZjTOtaS
	a69e9+EsrkoF61IsnFRtk6IGoEqUjPCzjCvoIzxVqv1wO0iRahi2FWD3sXW0vReCkA80rzdGpRp
	Yy2QVuqQbRgpBWCIxPLFtPVsQ/nEHcVDB0YTygkA1irLqg4vd+5nUK7GywUyAGlrop126jVfmz9
	lH7AHG7pLphcg5x79ndjJKYncF15YyZYNsFeBIsqTGtJMv6U+521IpY=
X-Received: by 2002:a05:600c:45d4:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4bb8880988cmr372815065e9.6.1795605424154;
        Wed, 25 Nov 2026 03:17:04 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm454867055e9.2.2026.11.25.03.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:17:03 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <719ac82d-4638-43c1-b563-af0a33b25d1e@xen.org>
Date: Wed, 25 Nov 2026 11:17:02 +0000
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
Subject: Re: [PATCH v1 09/21] i386/xen: Don't inject event on invalid port in
 qmp_xen_event_inject()
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-10-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-10-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> qmp_xen_event_inject() reported the invalid port with error_setg() but
> then carried on regardless, passing it to set_port_pending(). Return
> after setting the error.
> 
> Fixes: 507cb64d6e66 ("i386/xen: add monitor commands to test event injection")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
