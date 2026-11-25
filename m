Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613482;
	b=S9uoruUEiQzMVC+0pH6RSK1kdzkRhpfwXfBnz90vkpten8aI5gInWTqXsRs4+9PEbjhu
	 eQel+0LJ0cpy4l1RTgSstxs42VqaSUaJzolUUW92qp6CTiRLPKLbJtM8QXOHT6Hk7YxGy
	 2MFVvgXFf67yIh5k/ijJPODI0FA+4+M2tBsX2gxRCBPPffyQ2N6c23hUvVkwi4wr/DsHs
	 9ZMmvhbWcpxfujzDCyfT7ty8/Nw/h9mTUJedKsfIgwCfyWHB/d08ggU/9nBAFMTaG4V4t
	 cGOM5tE5lAmlXfJhbX2HMktV3uqzVhdEg/BWI36xO7jN0I3IUMUyIlc53m9Jf013uWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1getO31TbpMrHD3IyKxKUohDsUND4FeywjJ/UyT4N5c=;
	b=w+xwERZC5lUJQ01+/sorh4M3opjgGNLLOlosmHe8YDkw4OIz8StZcY05Ji2Z688bDNnV
	 kkvw6Hso4QwCs/nfc/1LSJ0C61D3ZwQfmdyPnDwkZEPR62M38xsm9cE/S3EQL2HpQPBIV
	 Ios0GHebMeeulR0Iv/zQLfpPf3p/3GnyNMM8X1Red7V8wH7N+QGUro320KnOZ3wqjuAxE
	 l5c3s5dI7P2Ek0n9wCqtAjeRVOpUt1l2JmYYe838cQAXnncuRrQkY3kaDCDw2Qj3NjyUu
	 utejOsE3N0pGckkykAq77xn0bbHYPa4iOdKvn1ehakkDgjy/0a+2ZxApupDPUbUPpaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wCjCPSng;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD5606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 13:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DD5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wCjCPSng
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50cc7540b7so812870766b.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795613480; x=1796218280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1getO31TbpMrHD3IyKxKUohDsUND4FeywjJ/UyT4N5c=;
        b=wCjCPSng7HdLg+1PvfPoRoNMrzBzUjjDG6ENfDPuOzqzn3LjmzTRpRRll8VtIb8nLP
         3tA0I9C+dZU/wB+ndb3VYKS69MKxykz8wWgvoswwxjKKwcN8y3YleumNEU9bU3DORh00
         IQEco8sYSAyA1jBAkFlv64fRfv/Z7BvTnLCz9BhhcwN1L/YGs1v0B7FXWGLoXHcgAJbW
         NGzR0q0vH5eOwTSiL4zpFkezlZN2fw1xjRI0ec43I8YFqcIh2EXRhBKhkd4Ev4YFxHPv
         yOp2NoC85YXWRo/8KBhfohQF+zYEWUr7bQJIbVXAVCjsOLaNocFA1r+HA88SsHbVlBbi
         Yihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795613480; x=1796218280;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1getO31TbpMrHD3IyKxKUohDsUND4FeywjJ/UyT4N5c=;
        b=KBIBgiS8EsOzbtp6xE36P9zHUXYClGbCUnJ2+WogG4vPIs48QAQG7dyBmUCFqxbbux
         yYIfnKuN/eIsjwDA2GzLXZV4djsARCWW+m7oqW0VEDtgEoNh0xl6Jk9yjIhQiTB8A7mq
         ghC0JprzNevdJTBerxZ85oxrbZkRqZLNz2z7QsUUX0vBQC/qde50vxzO6sRAvTGv9nU/
         VM691ce5yxJFo7ZqTaDGSzKlU9I9RdY9j4S8MPq0Q5DX5P6aZSuxiJ7eW3IX0RG02wVO
         Qxj2S90O551G5+v3u1VD2CHn3W+CK2KE2Y9WNAjBxQLVZcx+jVOA8m1Ogj5a5WruGgxq
         2uWQ==
X-Forwarded-Encrypted: i=1; AL+hErHa/KGbarsVJnqrhB+r2jXbkyjLMfiIu+X6bIQtEp2hy/Xp6q//o2xRy/JVgMY8e8kOOQE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f5PtmP19I56tc89sjSyCCwC8r67sx/i+YWu86PIrtUB/KF1gG
	l24OzRpfjMnDo9oN1vigA8GHBXvLWUDAqE4eYGf5goUMaVOau0FyfV5b
X-Gm-Gg: AZFdTZdXQW+l3DGy9EoVR3TNxpCPcqWOkE00puyan0Qw0MTuGao59xzS41uQ/Mys57J
	aBFk9+ac+XieprncrY5PlaboX+tLWJaD0u+brK1RFLupqPZXXT0n2NZGQ+rcEWnSAukF5IuQjxh
	irIYt3flLmYUQi2awQDa8z9Lx8W3P8/jsV6IhOAL1HOlxAeo5roozPGdHc4jQ6kIbZeBrPcLJsv
	VRg6o7wCi3Br/1TVolzkHrKdFj2bUZEtXDde61G+N0nWaa7BXqpd4Ej9/AdgIhcd5ZhmoZ0zXy8
	C+UUqvND17EAbdUiOzKGVaMFkigygRqvEYzXgvr7+gGhlSMxVQ/PHC4Ncc2QPlFGwNNUBP5eGOy
	X6id/laeOqxaYI+TdJiWEjF6YwzJ9mO0xp5HOSwYoTeNqreW93WNI1d7NbxLppLXwfIOfD8yBEa
	iPbD3+alrkdyEWbv1LwiIJfInbmrROqH01nXwO+WlFcILw/OdoxFncY/3KvppO0QULj5ptuf5T0
	YPE9v2RQ+JHpy04Zyt60g1yzG54QCuk/jrT7Yo95/744XbS1LI/c3EE7SJqE3dwiFU669sb9WcX
	8lBl6qE1+saI8AOTN1PiuXvUA8ouIzxelzQ=
X-Received: by 2002:a17:907:4d0:b0:c51:f6:216a with SMTP id a640c23a62f3a-c513aaa8eebmr1221466566b.37.1795613479877;
        Wed, 25 Nov 2026 05:31:19 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6663esm639987366b.21.2026.11.25.05.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 05:31:19 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <7bdf9aad-dea6-4073-97eb-1c5d2535c9ae@xen.org>
Date: Wed, 25 Nov 2026 13:31:17 +0000
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
Subject: Re: [PATCH v1 08/21] hw/i386/kvm/xen_evtchn: Fix off-by-one in
 do_remove_pci_vector()
To: David Woodhouse <dwmw2@infradead.org>, Paul Durrant
 <xadimgnik@gmail.com>, qemu-devel@nongnu.org
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
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-9-dwmw2@infradead.org>
 <8e8fa5ae-f30a-4e38-8aa8-cd46e3b4ca31@xen.org>
 <51d6301de00d83468af889fd4eda0e9cadf23ec4.camel@infradead.org>
Content-Language: en-US
In-Reply-To: <51d6301de00d83468af889fd4eda0e9cadf23ec4.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2026 05:03, David Woodhouse wrote:
> On Wed, 2026-11-25 at 11:16 +0000, Paul Durrant wrote:
>>
>> I guess I'm missing a subtlety here, but the test only fires if pirq is
>> a multiple of 64... so why is advancing to the next word by adding 64
>> not correct?
> 
> You're missing the same subtlety that I missed when I wrote it in the
> first place: the loop *itself* does pirq++ every time, so when we do
> 'pirq += 64; continue;' we end up adding *65*.
> 
>      for (pirq = 0; pirq < s->nr_pirqs; pirq++) {
>          /*
>           * We could be cleverer here, but it isn't really a fast path, and
>           * this trivial optimisation is enough to let us skip the big gap
>           * in the middle a bit quicker (in terms of both loop iterations,
>           * and cache lines).
>           */
>          if (!(pirq & 63) && !(pirq_inuse_word(s, pirq))) {
>              pirq += 63;
>              continue;
>          }

Gah! Recoding as a while loop where the increment is either 1 or 64 
would make this much less fragile.
