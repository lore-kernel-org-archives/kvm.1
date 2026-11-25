Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605519;
	b=sTQpwymDraQMASk+N6HqAwBuzTfPAQONlEOY7NRSHCoQR9XwqffT+0NzkeKADVCpGcbv
	 oZILoelSfUCwEzRuNk2Cwn6XBX3joQZZASj2U2SBDeQzVMcikiF+q4xK3dJ277FjP2+FN
	 6ESktpgTUKh/LkeGXc5MoVJMZuCUQHVMISi9zxHDw0v40v/BoLXC2WVeubbSMm1VsYNYc
	 KWnXMpekx6/bCTDw6JL9DpjtWExPTmZFU9AHUpKqG/MNPVTE8TIwpoSke1IljD7Y3ETy4
	 JAtywy4oU63QJ3hZxnUBayXLEh6ucMV1Je3q8PPnKM/m+2bX48irGd0PaKVUG5+6WwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BqDRusDdiLvl1Sf7gFE/D5Bw9nPWlQ6rHY0va4kEHso=;
	b=CZpbu5I3wZszqrzhiRs633SA2hYrtyFrSDniTkUgPkAZta4+S9FYRi5l/7ui9LUMPe1s
	 BKTjIXfcTJadj4gdGceny+7RAVL2IMZxXHfqMekR645WR7wRO65bNVovRehPWPQRcVLCe
	 bNGVzfPCKk6stAxdjG6yZOFmn5d827/5+2YF3y3z6EJjPcs9RT+8ErAxjHQTESHlbUSPS
	 +ms992Ul91m1XZbhSzz1ZWrh2N2/4rs3WSXT2zip4xOt5DiePrIt4+Bo0QdKckGX0pQqV
	 ewEm5GiT6gsWRuLD1XxU35XxAzaocJYNEoOTvzIFft4YKasxwoniVHzudQ1wxVnCyIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2CxyiW8;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F49606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F49606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H2CxyiW8
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so4590180f8f.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605517; x=1796210317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BqDRusDdiLvl1Sf7gFE/D5Bw9nPWlQ6rHY0va4kEHso=;
        b=H2CxyiW87X8rQqa4e36H+F0vzjzD2YQp+orPdO8jxD7VcXxsvH7e0scqLBdrJPbQGQ
         aBt69pZQ6UiUdyiHN4GRdwfks/KxG/PWFbF2QuuHSrKBpVLDKY0p4lCV4QBCqDgEuh3x
         CzeNsMpW/cx44zFJ9wsU2R7CUn/ioEk+WwjYE0CQgeLURs2+jK4yEBBnKnpJqyWzweNT
         rRgRqZKm7ZyTgliolnxCOSZm6otmaUGfo/sGIhfyvmHYBt+oLkrKG/NbzhLllr3Cgcdr
         Q6jQZlcgcGJrNUNn3zZVSKdyVclwWa/+RkUvqHCC8veOOjltireqvZwG3Cn2gB4YtzeN
         idTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605517; x=1796210317;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BqDRusDdiLvl1Sf7gFE/D5Bw9nPWlQ6rHY0va4kEHso=;
        b=KWuswre8yZEzbgXRR1UiQcdMBYvyebZVfKpLQbLKKVkYAf48/9h1idQbhphVs50m5N
         aY0QMYyeaqpTZRY5j00G624jygQIvpcwESJPdBVJFwxLKcqC+TqKej8RvDwi0m7cqlnb
         MFivici3pQCR66O5EH+UHV0Fzj1b3oLN6OgsuEtBWh+ljYvou7de5aH94wLejZHij0Jd
         uWbx5bzw6JMy71sxSckxxZiIBI9zKUc/olSjB8BhelSjdlqi87cTOJglhCWCdCSXFdau
         /5nEq0Xr8mISmfh+OWeBI63b/XILnGW7sd+oyrIwt4MNNAjjLmy7BDWo46oYC+WzVwZp
         zzHQ==
X-Forwarded-Encrypted: i=1; AL+hErF9A61DFEivM4V3ZuTW3cTlKuMwssYY8Z6S/O4td1IA+++iBIgNdS+bDouTIsX3yFHQbtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jc/SPWSaZ/TkPVSjJmVeR4JgikS/thvxDftbTn6LSRmjUpXrp
	uPP0xDiE93PUVn1iq9BF+MwvqzgPQiHfUh1+GfjNoRs64Xf4HV5BrBIb
X-Gm-Gg: AZFdTZegFynVLdei1e1F14AYhUhTJ9QFbQO6CkrirDd9DcqX55/tEIQQrxCZ68SRmW6
	rtJo6pBZI1UYsYmvwDaJAKoQMgFnbKjaGDqOiYxHvq6ERUbYOL/FyWXvps8+IOyFtzQ6+43VwBf
	afayNE43Na6yBodS3hNVKJRGgdUdLyJdZZRBbu0+gW4XENfhNkcd/5/aVejVXGLgfROZdf9d4hU
	tKtXmBHXiEcLSHFRvAFnuG+6ojNgi6ydOANbBOyciuZOuTEiSoxaOkMVLb720jURRC46wAlGojP
	uuov2ey/T9hLcRVaUz2C+ypTBtjr/ePFMOTvGS2THspqmGlKQKUlxeqJvBLnsabpCMchG0s6lf7
	lFjVPMgIMdWbH09KeHDnKFyNEgwJhILQx7MJBiUOuHM/kNv4GV8TMs2gDsYIHlvpPj1+29PvYs/
	1w1KtZQeLGjy8RFzeD+wQP9CIAjx84RTETnOkazgn0Wu09i9VQ9HX78scOa67gwneStvoaVbzB1
	m0PV1WdymSWv3GxDU6H6sDRLg0dxi86jui51UP4lF2GkQAE40ZYJXPCOasz0fkHk1WZQaL8jmiQ
	XU3Zy3PmoonqjQjWnDjjLwiSzWMnlQr8zA==
X-Received: by 2002:a05:6000:29d6:b0:490:6fbc:9457 with SMTP id ffacd0b85a97d-4abb39566e7mr23143727f8f.41.1795605517091;
        Wed, 25 Nov 2026 03:18:37 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm33914818f8f.4.2026.11.25.03.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:18:36 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <c4e8c8e0-91a5-4009-b413-de19cf64e661@xen.org>
Date: Wed, 25 Nov 2026 11:18:35 +0000
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
Subject: Re: [PATCH v1 10/21] hw/i386/kvm/xen_evtchn: Reuse existing backend
 port in find_be_port()
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
 <20261124232247.23169-11-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-11-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> After a guest soft reset, close_port() clears only the guest side of an
> interdomain port; the backend handle still owns its be_handles[] slot.
> Binding again then allocated a fresh slot each time, leaking the old
> one — and leaving a dangling entry if the handle is later closed. Reuse
> the slot the handle already owns.
> 
> Fixes: 794fba23a53a ("hw/xen: Add backend implementation of interdomain event channel support")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
More soft reset joy...

Reviewed-by: Paul Durrant <paul@xen.org>
