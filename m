Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606536;
	b=011CA8fLdMREbMQjhAzOcZf7OwJgWtsonuIP35Msr0hU4xnKxK1eoPttYMUiESOO8FOk
	 e/lueuNSfEjVJYA93gKz0X8PtrPNYyMPhOdRfTFPEAcnPevwEDyIMxhLeC4scwZY8wSig
	 E8PXObUDlzPU6bDIItR4AoNjuIFxCGGhPTrfggJmeXadda0cI7mQspu/E0vzSWZzXN79d
	 huoO22hex22dxpllqw8rgvFg76Lv8eo8DkmH9HrZYYjVUiztnsJFL03Q9XFReKVzMs+t5
	 x61k8jbaJcBVtQrCd4UELwV0TF0RtxtwRnNLu0avSQ/x8oMMr/i+lA0h0XRtOQE35eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i17fHcvxw+7ZL4SDpaGzZuZ4XTXyMvScmMDjyMswMVw=;
	b=e4jxZ3m+80xLKnhkasN7q1cdEMnPEuWna4zWJt4x8Ms2/VhbG+K2L14HAdtTvf9WcVEa
	 0cUqVSZEOa0Nn33fXdNrAf3Z50MZHWTevdZe46SzatF4lKc8hm2x42LhzSp0QDQYYkI+F
	 WWTkyDYNd2WoBC6JfxbLyq5Nx2J3fQSgvQpCc7oOWxxXsvRUoT0d48Wi1Nb/9sZguEcG5
	 zs+zrI/Ekj02RSsn2I2s8PHFXaV4Kwjrjch7xxMtuAXLVkXgkn3+oX93Tnud5+2TlWA6w
	 NKHN19HKo0xS+mA6XaQzD4ogz5Q9BgoHK7uEUuKq3FCcnuCOJmdD/DQcnag4wUL3X1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z09znybz;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE609606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE609606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z09znybz
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso1084585866b.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606534; x=1796211334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i17fHcvxw+7ZL4SDpaGzZuZ4XTXyMvScmMDjyMswMVw=;
        b=z09znybzj8e/PFc6N+6Phak9rm34RRv/dYaTFJyEliN2ipvwC4mFjcubbX1LwBUh3J
         zbwgqChINMSdK7wYYnfrumtMZqMc+lERRCm6nBH+gHT5cDSDl3o+kkmqdfqMs/K2f3pF
         YIpqRioiAsji2MeG81JceBfY6sFGF7wURaWZkaRTYUFo+N58tHQriaNmf18gGB5nGTL2
         RGzUiaGXGcsgi5NShjHnCtADpJxWAdj6/vHvCnS4DgYELHxQcjy/e6ZomBie8mxltNWI
         GwfC9tm1km8LjTD+zHIftQ09JSww5biUvmXS38fcpJxLqYQpT+DEyGkPFDHf/tu4ifkM
         ZoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606534; x=1796211334;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i17fHcvxw+7ZL4SDpaGzZuZ4XTXyMvScmMDjyMswMVw=;
        b=03OeZhct3KHYTRUlwKVl2EFkvBIU4F5ql/L0WBvZLORXmzwQCI6JdSMYi4LjeXnfgR
         L3s8BDIy4UoS3G1vlEsKTa0HrM+qyQDmpjBDpH0h9B4rIWr6nr94kaYE28kpIxGiNKxt
         fAGsKcQx84PEpEs69JmmYC2xTl6lWEcgG/3RcYLfpJkNybiRgFZyn7FF601hiw1O/8kI
         9aCZofv5XoTEvFbkrsuozsHL5Q78wyBaxDSqS7UGvNB0tO8d46RP9khzt0294SV8mAPv
         YadO8PHq4x03N0lL1GFuJ4Z2ewKmdMe/ZpPQncff7g51xydlzvfWxh8fKvEMpRN9j/Xj
         behA==
X-Forwarded-Encrypted: i=1; AL+hErEEXCBZZBsQCZqjxGG/atEqCo79rfEK2V7MSqldnDCJXpwL0sJpAVWu8tlObUfyVnlacTg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xpHSXXJDa6OLVNQEIb1YInErd3ROmbW3gR99nTSyHSF5hUXBH
	fVnnpfqW4VngYpo3XavFqk95JIGrXl20tdQSW/zn69XyrNOgrKiBt1Ht
X-Gm-Gg: AZFdTZewqwwJqmSLqJsKNM/enTfbrqKUp3CJ3Z8vImrZVG+ge8LklyZi5WvUTnTq8C5
	By+z/iIaFGMmlle+6Lat2PS8X2CWMGrq5QVabh0tbxO7nq25/aBkjx1+RpvsNBzLgYUKNdq7Drb
	m59zOa3P9WB/EoA38riztFYBRB/lzpRHKBQdh3x7bIUEUQXTZhgaXh/3QslzzFKDM20MkmSnslG
	2In8YkNBVnFv5WrP6539hXf5txplxveYQytSscS2GJfUQ/X8d6cycOmoUjfBrOp7TIl0rJic6Lu
	Twli/BfbecPbhmoKyoi1+DpqoALYh4bsa8hQJSFWvom3nfYaLSYnP4Xjf2I8130/DmSMjxl553i
	z8YcxOZlymbKzxHVonVIqCz6Z/5EQq5cLEjV1qugFkWuwQaAlL3AK2b14ca3wMp93fhvkOOgcHQ
	T+xz6gZfeUdg8uFxpbtWKpyDhRsXGC9nfryAJ/oGTPKpDuEFfB5AZAvZxgljHpGoXgpUBmvhwQC
	s98AhVcBDKE5EDFZ8yfM8iXJBJ6s/6nnG44G6RUOMOritfvQWPdhwq1z8cx5KWpXIXiTFsx3PQ1
	0tjSerEHp1f0qzzliZA9Q6IdWR/No6FwX+4=
X-Received: by 2002:a17:906:a158:b0:c3e:d0ca:d30a with SMTP id a640c23a62f3a-c513a5e6b79mr1111910166b.4.1795606534265;
        Wed, 25 Nov 2026 03:35:34 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc42bbsm616068466b.61.2026.11.25.03.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:35:33 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e45e2c3b-7996-4f8f-8b80-2d852e032166@xen.org>
Date: Wed, 25 Nov 2026 11:35:32 +0000
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
Subject: Re: [PATCH v1 20/21] hw/i386/kvm/xen_evtchn: Hold port_lock for whole
 of bind_pirq_op
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
 <20261124232247.23169-21-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-21-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The check for an existing binding read s->pirq[].port before taking
> port_lock, and the allocation wrote it after. The BQL serialises the
> writers in practice, but holding port_lock across the check and the
> allocation is clearly correct and lets Coverity see it too.
> 
> The region now under the lock is pure port_table/pirq bookkeeping.
> The MSI unmask and kvm_update_msi_routes_all() calls must remain
> outside port_lock: they can re-enter via the MSI translate function,
> which takes port_lock itself. The PIRQ→evtchn→GSI delivery paths have
> further BQL/port_lock ordering constraints — see the comments in
> xen_evtchn_set_callback_level() and xen_evtchn_set_gsi().
> 
> Resolves: Coverity CID 1527403
> Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 25 +++++++++++--------------
>   1 file changed, 11 insertions(+), 14 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
