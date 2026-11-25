Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604287;
	b=hUtbfKDeuObPpJEwS+L+Mby/LqdS4Nu5qVjS/8Xz4ewGNl6EJSFxyzoe/ebMd9bNVtav
	 0LG7hfnJ/UzfKx0H3WSSLwb8wL1mJb4/VH5f1QXY9sXRW2MyQfZ8voCb+i/SEOMCazbD5
	 rBnW6VdqOdmbs2pfVkc0Y5guDLDyECvxTw0kjLfK4SB+buB9v0ciZ/MQijEBrSBSJt2Q3
	 UpxJufCOhE+gQ1/ZElKMP0O/RA1a/y3DZ7zgZD/z73b8/uVXAggXQ1RH3G8gjTyZpSd/B
	 SIeumqnkIpG3ZaNafkU82MbAw9eF8ntMYLfOJ/uHG/SPX5sPX7mLc9zk+k6gIDUDGiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9ojd6QLbo6svWTxF6DUELPeNw20UDvUeJORZrpfd3O4=;
	b=264InFTpqxWiD+lbHHJT8t8fpWSqhSTYRY58ZUnIYPmjgNh+MNDeQmgJ3K/3tA+IljlQ
	 s2K/ePinKHPaa1PetQH3z+6GeI0OI4buzxIWLRjF+THXftT6mx5RSI+0pi0jhSi02jAXJ
	 Prd2QulTtvVe0sgD9miooKbCilOpPpKnJ8s3Z/KGD1trCmwTdFf3PE7xnlzkUfJuHnklq
	 1vObglIFPnpiw3n0DNVkU83ULQ3MlodlTxGJMlj6WhbA6r8Es2P/mDI/6VXDUK1c4/IJs
	 ZdFhWv8yqAet/2F317RIc7QiO7apJ2Ha4IvRKjtK4G25IwOG3v36l08nefTCEVDUlhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiQssqhg;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB5606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 10:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57CB5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiQssqhg
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a5024b3c28so3850741f8f.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604286; x=1796209086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ojd6QLbo6svWTxF6DUELPeNw20UDvUeJORZrpfd3O4=;
        b=LiQssqhgsoXlY6cGAtVuJws8xw3c+XRo4uPEUFuicxE0t1JzgDpUetKqqo2lhFywed
         YA09EVK1RUqcdkWFetIqV+PjtaY0f5KO+zdfhAnv8oWKC98coNDqUS1W/xJrnI+S30FT
         c53ldaeOMqyBkCegi/j/yQQdxgZk80u6Tb+jl6PmGLfj+euB9iitGGNJLiRJI6qZ0+Gc
         fAU6Ec/ObgsJt8pN9xlx7UgCjbO+hGaPUQ0Q11gfDDLrYRnJ6H2YDQQCjpph98YpisH6
         77b2+5Lr7JVzw8B21JuGb6BFUluy3XAEc9CNYrm98I/BnC0ho/HCTe/nCpsL4dGy/ezh
         tuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604286; x=1796209086;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9ojd6QLbo6svWTxF6DUELPeNw20UDvUeJORZrpfd3O4=;
        b=qe1sR0fa/u1GL+qhv+yEg1dnN68xW3Eov1TAsfa25V6949aUy6CaXt3L/aCVaeZd5e
         K8/6LPkfeN3Vt7/zd7Trr8WHm1trzxL68rDrvfRr0cYsoiF4uTaG9NlVI8J7nXXcr+gW
         4gfMToaNwGaz8wa0Tu95KjTVMkpVOw3m+yy90TSfweo2WYHtHAjJHanrw26aDjaqua3e
         XlijlYrpbiGtmSfmb6k0ppQSImRi47bHzPDWK1r0t7mTtIvzJYLSjjPpZET2um89FU/y
         1cZCMH5gSkWO1M8qyMJnc7qhhMuvoPFRXnVN6J8fbyUq4NvuRL03UQAnaWgbAtvXfk9r
         A6uA==
X-Forwarded-Encrypted: i=1; AL+hErE+1HEToCi079OZb3/KHCW+NaDleNz301bxxL6ZNW4rG6jUZBXIErNiVatf7WGtW29cSSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QDacEon53Enrap8kVxm8/pu1GsWu7XtQCRXjvfrpjftL6jLtQ
	dysOTLs3wLvIk5YDoZHmHIlISkwDrImAIqpREIVcc2nSJXJLkO7neuCY
X-Gm-Gg: AZFdTZfj1nfRjWz7Wti7XsxHty7FPEJdt4+u2BGGVTAy3KgFa1Ux6WYH9WNe3xjVQmL
	9OB3zYqvEm6AzDA8PCmwirrgA8xAElLn1tWiuDFAuN4QtrNJD90Or1zYdx1pjp0SixyHzHOhzB7
	XtH4aAmED1f/cul+/MZsmhgSBVVkgkbwDjO89sAAe4H+Gq2lLE68Ufp0RujaWrn+gaMihEhP3Cd
	Y6WZrw4euRYtZuWb889aaOjZQOW30ywBFbdBJ/nH+tFxtkyLg3ceW3mO4ROfEIWJVh5+zeSZteF
	4aufmAwlR0JAG9BN/qEz9L/etMRNGlSrgt5amn6e4mI9oWnlpjGbJqbdjxdh0zMkC6THY8AiNdA
	WhM6V+gKgaNhW5j7RXOyR617ej27zjzcdn+bdKCMdill1cJvs3Eeve+AozbebdeeFosxA8M8sPi
	YFhsBJ7camBLvD2DX33PbWyQXhm3X8RUet4UrBUECr9jeintYnNWizzNGVf296iT56Gxihqd0XJ
	lE59KILhkVt/GfpSETmoRrhfCbPtpOjVK6n6UxMzeX4/yQQuohanJ17G3wtxEyqIRhPGnQALenj
	uJ5AXz6hgH2bZ03NqW1RDuEbep9heTtPG2A=
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id 5b1f17b1804b1-4bb88805902mr337651085e9.7.1795604285398;
        Wed, 25 Nov 2026 02:58:05 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906817ccsm285486235e9.5.2026.11.25.02.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:58:04 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8888e81f-ec6b-4211-afef-215eba880e01@xen.org>
Date: Wed, 25 Nov 2026 10:58:03 +0000
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
Subject: Re: [PATCH v1 02/21] i386/xen: Don't resample GSI when per-vCPU
 upcall vector is in use
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
 <20261124232247.23169-3-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The callback_via GSI (or PCI INTx) and the per-vCPU upcall vector are
> mutually exclusive delivery mechanisms for Xen event channel upcalls.
> Xen itself will never assert the callback GSI for a vCPU which has a
> per-vCPU upcall vector configured.
> 
> When the interrupt is acked, QEMU's resampling logic reasserts the
> GSI if evtchn_upcall_pending is still set. If the guest has configured
> a per-vCPU upcall vector, events are delivered through that vector and
> the GSI is unexpected; a guest which receives both the vector upcall
> and a spurious GSI interrupt for the same event can crash. This was
> observed in production with Windows guests on a different VMM which
> implements the same resampling logic.
> 
> If a per-vCPU upcall vector is configured, don't resample the GSI;
> just deassert it.
> 
> Fixes: ddf0fd9ae1fd ("hw/xen: Support HVM_PARAM_CALLBACK_TYPE_GSI callback")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   target/i386/kvm/xen-emu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
