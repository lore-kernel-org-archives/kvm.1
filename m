Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606594;
	b=2eKvYe14TDIRPjVmGEhASsi+M2Mf95fJHRqe/cmGI+ux/iljUR0X8a7Ja58JP/udaSPU
	 I8lXOyb42IjSn+V9SpLLWRZyUWXxJTxAIyKHLA89W8/Yx/VF/hp36z1+waIl+ejlcp5jO
	 DF3tZU2niH+HKfT9y3UAsrn3aPW0Va1qvj8GO5krvBLxpMe/d5g7UnAHhDFn8dFIb/Cws
	 mjulmJpHe+gkz3oOiNeHVorR0+goyNWhrITgV4Js24bihgnK5/xOLigk7+PDWojqDtaRG
	 4EwPyJ8vBvex759JUyFHCus3k4uV4GhkpjuGYFQn5PnH07MfYNUlCX4C7gnjn8ftkMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7fOIsGrjGNi6CskIGWATs2FBSxpHu/NcffK3/zRtoLs=;
	b=4Ia1xI4cJXaHhFLBB6fNS2MLdTNaoihRw+JA3TpTDQbdi2IZvb4sm3DeFW6XTOAYnq+/
	 pucrYDmk6Wvd5uYAElcH98oBP44551+Qq50DBsIl9+TYBJMGjvpLKIBtSn03CCQSlpm2i
	 6EewWUkQf3ZqzrR1MXKRsHg0YL83mq1zFDbAJIImS0N7O/kv2fCItjybIoUt3Bv+/2DwH
	 MwVFJ52ea0mtPJzm/NKkzvVTG5TgtFR+aNi+Gw7Ljp/3Ee3MAivQQKp52JNrfnV24XiRg
	 IICQnv9Si01tFseQ4dEe7h+pAU+FajbHe5mkZ56sGYGPp3prgg/VP7s/UNSkO8cUC6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="R7n3W/Hj";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27302606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27302606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R7n3W/Hj
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so57943005e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606592; x=1796211392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fOIsGrjGNi6CskIGWATs2FBSxpHu/NcffK3/zRtoLs=;
        b=R7n3W/HjMW3Nv36Ham4Akbumlt47XBjJMTTitDVc0uOzzKIEyPA9bq4pXSU8+i1PR9
         zQM0gkGKN5fsJOPon+zLYVyWAFS+sRqTaMiVl8vdSBLMMXxyHAzHYalg+F2gjAmp5SyT
         PoaoJbqNfFyAAoWiNo/eZlwU471RbHKCdf/relUyRmDwgzpmNNqyrujQRX8b2KsjczTb
         t3eAIRrZyKDXbp/Dqku0g4/gpyaL9MGZAdc5RAPsCsm/7wB17FsbNEyMfqPENnQI9JFN
         OTFIx/zMwEet3PVDto9u7ZWrqlR5D08HJURZH3L6ztTVn6qvRewjYtOpmUHkZXIStcyN
         7agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606592; x=1796211392;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7fOIsGrjGNi6CskIGWATs2FBSxpHu/NcffK3/zRtoLs=;
        b=QXXAnytqDjuJ2gCS+oxT8M6sILUNuwz3u2edvbLg4fcanJinr7dX2F8TFXdgVg+W+P
         DfFD0IHR8qXH+Jm9KthXV90qH004a787nTb4OFBda67xIj1ypUk00HUVuTXDGIloBHYa
         lRIXvARbGn/PkcqHtz/OZrOs7wfAhqPYR/S2Ufc4Zo4rexoRntF3utzEU26yMe0ZXax1
         jpeZytsajZqpAaNsANJgJmJI+oD92jCPp7YmmZz7SqXqGCWStGNVxV4j7ybzqNaRKFeS
         XaiGRwXrn2ZGvpFT6ZbqpYeLCfO7HRoAj9FZBZOSfQyxBfjd74VoEXKe3KfBW3jObq8T
         DF+g==
X-Forwarded-Encrypted: i=1; AL+hErG556bSxMykIXSECmNlyyP45iIzJYUeDXTWdcpmw/i12JeEdWBvjB/rKKXcpo0wgWDfmJU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yFJ3beqfG7qW7a95G60/ahHTyAn9D9fEnZBoJnwbeUjmM57EZ
	FEp81/a9e+L9M4hZlTTS5jeAYfSJeZYLqSW6WLlWH/LVh7U9t6qOKLfJ
X-Gm-Gg: AZFdTZfHKg/PFydhj11VQaTPaFtUVrPo6Dej7vZMAWizN1omrixnKZqPqZV1c6LMBNS
	KmPHmuQVXbHEsfNelW20wVJRWQ2X7/YMK8RT9v2QKIn0eBp+q6G1f2Iaz1nYtE/ZHVgeHIHOaz0
	uGAt/VSEYu4yC93wKa+fNNakDcforQpOquLVmHZ3omReT7EkOCE26MhTu+N+wgie9tL6dPp0pQl
	i9UGrninVZpP8N9ky6wKaLcKLHyM7zvOP2ls/zZDFbsZLeR/8cfQfVFW4DT4ghny9JzDt5LIlAy
	GdVTIAcxcOE/D16g8uoiULEGCIJSt91PO2QtQV8fzTKNzJXXBQeWvL24FvAKnv6qkiwYkSVNUky
	J25XL1o7VTRNcJebd+ZDbMKMYGq7pxHIbUpW87V5TglxJxkTv3Ntvr7C/vKTyXO4j9qhU0hllMe
	PCz9zG1ZFBMzvHiFZ0HMKmVWKeBWPRMVbw/a5Mtn34pHwFMfTuR9qDizcMEs6aCfUog+OFr/jxi
	H4uehbsMNrV3dRKRSlszxkB8JfcFyuF48hMb7PR6s+uvZK7nK/TeBu0o7UCSp2Ek4xaCtuSB/ds
	MA+QxsKN2bFOqijLZWGPnSURz/Df9jyj/EQ=
X-Received: by 2002:a05:600c:8b83:b0:4bb:60da:56af with SMTP id 5b1f17b1804b1-4bb8893053dmr316762505e9.25.1795606592489;
        Wed, 25 Nov 2026 03:36:32 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm498592465e9.6.2026.11.25.03.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:36:32 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <bc0399a9-d768-4503-b499-157d5478fc69@xen.org>
Date: Wed, 25 Nov 2026 11:36:30 +0000
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
Subject: Re: [PATCH v1 21/21] hw/i386/kvm/xen_evtchn: Allow unmapping an
 emulated MSI PIRQ
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
 <20261124232247.23169-22-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-22-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The "unmap GSI PIRQs only" check rejected every negative gsi, which
> includes IRQ_MSI_EMU, so the later IRQ_MSI_EMU branch that flushes the
> KVM MSI routes was unreachable and guests could never unmap an MSI
> PIRQ. Xen permits it: physdev_unmap_pirq() on a domain with HVM pirqs
> routes emulated-IRQ pirqs through unmap_domain_pirq_emuirq(), which
> succeeds for MSI emuirqs. Let IRQ_MSI_EMU through; the existing
> unreachable branch then does the route flush as originally intended.
> 
> Resolves: Coverity CID 1507603
> Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
