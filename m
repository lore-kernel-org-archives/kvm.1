Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604758;
	b=y37EI3Qqv3WWcAsT+4ciAHaJ3YycvHO0YKoqwgw61y5hkLuDJ6zsVaEPmQWVPyfp50rX
	 m/3Ht+lcRCejPvSUee0rvOiNGXeViFLBgv0BcPUGW5DBs7ToFCNCTtuMRFqkmU/Fwb4rt
	 IfmT3S2GG6K+HJtpEzWc1BuzgmXiZD3+KnbXvMbW4CcfNclyQZE1V+nPnK4R38+eLChKW
	 wvHZzrKTrFW0e5cLQNuu4uZjTp8QuQs7LH8ZmWAEUe3cNyAdAMtuE9gFt7W4ZjxB7Hsha
	 3WgWnijCp6SPxccbQEYJSRSOwzPnLCmTp/ywmSfLECPHTboZJcu1fpMFoLf9TO2PaRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604758;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oS2GSG0gTbNBdIcy/EYt/+8Op7NtDzRF0d79hf39B2Y=;
	b=vGjsHjXaHQWSBz22/w82uI+Suyjs9/8xSLVVI1D8grATQa4brVHxykabtU/5uEpwktbM
	 3IBW4lCOp0ac25sZojLD1Ik/Mtr1ZWhY2N31zXxWX8eT9WGhZB8SvLe58sYPGIeeFro7Z
	 X7rVNPB3lqjjjGFN3d/i09LFoSx2rTwJf1VsMsV3mPZaFPdp894hOCGIwmkY+FWJPsQ6j
	 BqDtZZkQe47apHjDh0Gz/Y/k2iqGUZfremGfNM6tgHe9NBYUbRVxLs7Y+XKSnwJgVCOxt
	 OoRxlKm9RMUHRR64Umd1PYKlbiuOq+MKD2a8tSmH3Ux5/ZNwvegmnlkHqQsqz3YGr9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b="LvN/laLM";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A78606A32D
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A78606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=LvN/laLM
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so4578845f8f.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795604756; x=1796209556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oS2GSG0gTbNBdIcy/EYt/+8Op7NtDzRF0d79hf39B2Y=;
        b=LvN/laLMwAP6yWYFS54Es+e5khmhfROUn08VgFW2HdhXV8/SEbysIF/35odGISZTkd
         aBDohsIMl7wHdca1EamprUvGcdKTMItmkI5KO4ifJH0JD9d0k0lxUuOGpEw14sLpz6GR
         Zd4HnldJFJvk70sw/fraPSWyLjp6CyM5Evv5XaiBCg+0yH3iwO5rO7iwWlIaFIcHJN1n
         9VrL5PoU23x1HbWZJk6STS7eepUogRdJ7thG5IgfpaXM6/NuWA6oKG5p++u4+mmz8hNX
         8U018VI6TRbQ3AsTBxI5t0BezufunKZhCUsxTyhOiH+Xix9otzTirY2ONW8WQk42AnMx
         7XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604756; x=1796209556;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oS2GSG0gTbNBdIcy/EYt/+8Op7NtDzRF0d79hf39B2Y=;
        b=Y0MfpqQDUF3sMihBsZX6SrfEaocIqtcV1WNjY2S2U2D6QLkxxIkRqiyr0PLOYtGBnr
         jK8z8wpf64atQwZ1Me0pqMN84GlayJ9q3c46ZTcqqKassuCQKkbQ9cV4s0Ys0P+xLC+b
         k3FlNr3qybvI0UQOhFeHuFNKYzJPGK5RbPcITadKSdEF8hhdWibtyfLplPyA3IB3TYjk
         +nC4XZBgbl7AF5dhXXXwTCETsQ5JGzqH2mQAfobD0RwU306j8+Ox6daeE86sSv7M0HaX
         GAJiJO6EjiKToRU6AOHQwQ0cDy5Y7vyVKCnpxW7m72kdxwRMWlh4ZCWvDJU7ugEQU341
         P2Ow==
X-Forwarded-Encrypted: i=1; AL+hErH1dQ/18LbO1303w+R7U9HMPVu/++lU00oxzhd4fobWEpF5bjS0w+gcRmobJGB2aPMhNYM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rAH8lUeHevncKIkNOQcjwrVy3oCQuWpxlZIPRJdyITwY27ue7
	TqBlpZc/FLITkJzoWdCyxfsfw+ZmGA+fD6vgtRyyX9Ph2hz/N4XDddWXvm8vfu1NgiE=
X-Gm-Gg: AZFdTZfquE6uCFJw5E1leOk0fKi/zDWhS8P6h7ajPGRa01m5BnFjsqaXKTYq4G2cU9W
	4fVKXXfxrYhJzVKMpDvw3SxBtOCvRxOdr4y163d6BC5jKdhQYoOudSlkJ5jxhcw7J9jIqsFfVpV
	pPDOvG5Egp58+eRE0T/2ayyKJB6Q6ruXItvVuGIpDYQL3ZJhMgYapBDNcvNX7f5jD4Gbej+0e2G
	7X1lKD7QnBCRj8wHFrQSa24N1FrvOf4GQoc+AAnVfsevVVT9W1P/3seZ83z4Qz04RjXBNvRrXzo
	wt3yVJYOR+hVBq5mkkXOLuFfncX0ICcUIgTZ4sw2a7xnMDOEJF7v1AJvjol+dXwUnEampzb0/LV
	fcgA9PGPve1HifdJweUbwV1uLyzg8F3tZBloclRt4tq8ulsYPdLK+KHoLMug+rUoT+WmSHYJXGC
	rLLB/QUcVZDApDyTTtvCVurxho/WoqfQzehWd1dI8cqiZe/03XtSEh1IMQlxtGD9z86jntOlo5w
	2iphOXVtq6sswrECnJ562enLwNVdsbE1RH2wh+/APz5s8md+/0XbdgAY0g52y9NMbPfW0zwUxcb
	3Sz0JZBd3Fsnkgb6vOk=
X-Received: by 2002:a05:6000:990:b0:493:ec0:861c with SMTP id ffacd0b85a97d-4abb0c5d53fmr32529130f8f.16.1795604756007;
        Wed, 25 Nov 2026 03:05:56 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b2c9sm34833647f8f.31.2026.11.25.03.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:05:55 -0800 (PST)
Date: Wed, 25 Nov 2026 14:05:51 +0300
From: Dan Carpenter <dan@pereq.eu>
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 6/8] KVM: arm64: nv: Don't deliver a pending SError to
 the wrong guest
Message-ID: <awbBD_8rLYZ9aJTK@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-6-224689d8a764@pereq.eu>
 <sashiko-outbox-232776@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-232776@kernel.org>

On Wed, Nov 25, 2026 at 07:24:38AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] KVM: arm64: nv: sleeping in atomic context via
>   kvm_nested_flush_hwstate()
> --

This is an existing bug but my patchset makes it worse.

I didn't have CONFIG_DEBUG_ATOMIC_SLEEP enabled when I tested my patch
but I have enabled it now (although it wouldn't have caught the bug
anyway).

Claude says Smatch probably would have caught this bug, but I haven't
been rebuilding the cross function DB since I started using AI for
static analysis...  I guess I will do that again.

Anyway, I will also add checking for sleeping in atomic to the standard
review.

regards,
dan carpenter


