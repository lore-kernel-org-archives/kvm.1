Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604883;
	b=YCOA22Gf4Lvj32rUMBlhMQRv6P2Naqz4IDZ0TgNPFPXzOAljpyJXTrHG7JeYuTlvnL2g
	 w/Cwiy6I69sRS1y3Rc/YYbLwB74RO47DovFnFiC9M/DRi/eS1v0iAvaykgJTjFG79Mwd2
	 GVqVYQqr6hEFvylnwQgd6v8WT1ho/urmLuER8UzlBlfSiuZHeS9l/8t0Kwh0cNYwTd24L
	 4lm4oevnTt5OIsOov5vpsqCucq3o0iO6jexj1z/BH1J9/1poE3giB3t2ZeU+tQzmxDYGU
	 l0GVrXegAhHCSiudW2RFHKRMDSz+UnwtIEOhPw/miN9DTDPHX2QUsVLZviI/3W0M3hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y4LbBbtYYoQPuIJYoiViXu4MQ2ajttX0MT+blUePV1A=;
	b=pVuM4unfD2NK7jkipAFrWXce6svk6VIiqiZEt8tVPTSu0eGO9aqcbzdMDvTummT5AVUM
	 XfNk+oNIXHBBqNy2xU+ezdkraclAaZ9nl6PYZ+E4v7AzVvgbCRJcwnrd0OVU30ler6hsU
	 x4lEzt17jnUTyTIJLpd+Rtelj7SLm4mIcY/cqyI158+HsRDDcfLX+D7EheRo4mdYP/YP2
	 BB4et7ncPG1+edI9/cD7YZvGDNyiXOgp95vrGLV1ZxGMxeFRXUMvzRhw68l6/yXGTGkdN
	 sresK6ekDRq5cu3bkrbnzpgPOb8sS7Dn5WvgK+zey3Y9au2Y40EMkFFw2d0VebBHXZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZrUTGHb;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58829606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58829606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZrUTGHb
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so3517621f8f.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604881; x=1796209681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y4LbBbtYYoQPuIJYoiViXu4MQ2ajttX0MT+blUePV1A=;
        b=eZrUTGHbJg2riqxWgFX+K5Xl2R+WCDFMMu9cSoM7E9x63svhEgdtUDqraAPHv0zteQ
         5+e6qhE4pvle88FqRJjULU4olvPwNoimhBL+ZRBpBh0DbaZFTtj+q4tZhz1k7uV2xsXh
         0ZyMFLlb9XZaVorPnOBEQ73XnPSq3oVAA3P9jj/JcarH3kf50RumLvIbqbq6eAh+UxoX
         thSU9/FQNaQpuhsgLEdngFvZKta0jCZO9piB5FRjvvCi7SE4SY7XAbjGnWk9iqSOh0dv
         sRQb4n7y1Re8PtBSu088dGHdYy4Hp7GdnJqy4au6Y88nNcP1sAodr0UvvvRnzdF/Oq81
         1ptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604881; x=1796209681;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y4LbBbtYYoQPuIJYoiViXu4MQ2ajttX0MT+blUePV1A=;
        b=Hm5YoCKINTT/f+zL5fWokYwR5QGWWt6Ku0yRmSSy6ku8/07OSo6NOPpz0DbKNndwJH
         a8GqhvHKfypyAk/QiqcHjW/JnENmwRkaOiEYMaf09W5Actn8fYMSuf7JDTZFBnJON5S+
         T1+Z+kARzFt5qKG3YPnNni8D3SRPOLkjNaJ/5C+24hj0BxIiCrHDE+mzqoJxJTNJaTRf
         MnPheGtDf40Nxh7NY2OCgY7sH5Dupv0DjzvvN0CvoFLFZ5bKz79VzwsygLbZmh0xhZwa
         EsbyV/9sGTxnajV4SEULbVno+dkRzig/LZ/56ZhC96PP4DZASRcvcWFdSEGFei8h8/ec
         +vWA==
X-Forwarded-Encrypted: i=1; AL+hErHEfaxQPUOlu+t8aHxX/Hm9KaLBa5k8Txl7ofF4PR2VREP/1i9mG/T52WpzO9g2RHog2uE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dwgXZOEECLrnS+xHLiCZydJsWwbfAmCOjfejtjhZLOki6WKMa
	mGw5opsPccYwr5R1I/YC+ZMW17plJ1B8mHDofoh6KUsonwU+qZeeQA8E
X-Gm-Gg: AZFdTZesEb7R1af+kTn2qQztLCdrqAekhHsBLFlXcQPwQqxquO4qk/k6s2AIP4xH/w3
	Hqbi1wtpLMXk6AV/z2FiipOdmf8lPznYbv/W4ZnPd1gX+oWtl7flOaIPrLnKw8J638RaLii5yBi
	LjRwptTeOvn1yAtd8vww+76GrQJ4Yo3E+yi1b3ut776laJi5a2UXLk2pHlsdCNjsOo07vQyrA1s
	QY94uMdYaYfAYsfkXfp+mlwqqWk1Y36vU7/ZVYEVUbgld3XhfVfxTBowORd6GchM+JbY3G5GKe0
	D//b91Nu/poQwQ9F69eSmWEO+Qd8lakt7J16k6jPVuc6svAVw9WQ551jYtU8I+yC49kcf4GpOkY
	5M4/AkskI1w6M2vw2nh7yqBTYyhTgUkzdD6Vy6k7edPtDaXKJxVyEhs0rutWwGBxIO+ob5UVuTz
	j9AmVKjsruce1kIw7gKnfBkwGiHApWP0Bu1ZGD/LzAIwcTToE1y0bOBQ1L3T0yKtID/XEjGcBVm
	poCfATn2LWfBcq/j2YGYneVNkHxB/AvKkNr32e0g5xVgzTf9+QJ0uGX83LsVU0G9PtKXPwd9fcV
	1A0nPDJut+HcLX6a8q4HexYZBK7hZjyfcNA=
X-Received: by 2002:a05:6000:2b91:b0:4a6:5086:2df4 with SMTP id ffacd0b85a97d-4abb3d2c096mr19854541f8f.36.1795604880544;
        Wed, 25 Nov 2026 03:08:00 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989b3sm33590374f8f.51.2026.11.25.03.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:08:00 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <b399c8c3-335a-4b39-853d-b21744a43ed2@xen.org>
Date: Wed, 25 Nov 2026 11:07:58 +0000
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
Subject: Re: [PATCH v1 05/21] hw/i386/kvm/xen_gnttab: Fix error handling in
 xen_be_gnttab_map_refs()
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
 <20261124232247.23169-6-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When the grant's target page cannot be mapped, the failure path calls
> gnt_unref(), which asserts that the map_track[] refcount is non-zero —
> but the refcount was only incremented after a successful mapping. Take
> the reference as soon as gnt_ref() succeeds, so the failure path stays
> balanced.
> 
> Refuse writable mappings, including a write upgrade of an existing
> mapping, when the underlying memory region is read-only, and set errno
> when the upgrade fails.
> 
> Fixes: b08d88e30f06 ("hw/xen: Add emulated implementation of grant table operations")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_gnttab.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
Reviewed-by: Paul Durrant <paul@xen.org>
