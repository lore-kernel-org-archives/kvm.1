Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606452;
	b=QjMOpzdLahEA6FTdY1AfgNZx+sJINYNmsn3vqz1zyNBoXtV9qqFuedWK/vpYDwVJG6g1
	 MkBU6H3Suol02mgcEzO5DMQsxa7U1XoC91V6fEWzr+9JuyTTVDb3cXsZf3Ec3bqxB0WmL
	 Ti2LWndvH3vFjArpvPKMOrY1bL1CsXVHfMaGtMM0TSofKXAAdXLywm/ZfMy2h31D97BnO
	 9eDAUGAkiqNLRcKiVYSJaYEzTcH9hVM70u7ukHAsaG7JnF6eRz+MoeUnCPaJTVgTfMc8Y
	 aJu95pX0X/lcr/h3OZYWnFbFMxL+f0OyRyo3nbk+ZCsGt2TQbmTVGuKLK1DoVBsrOsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Yl/4IscYRRIYoDrOcOqnAZtQEjR1B47TFUIpt05puco=;
	b=A2XMNm8/d/x5amfaXcUSpdP6qXxx4o+XfrDIGkE5mNeTuZ49z2I+pZrXVJZI3eAUBIMT
	 zO/LRO25WWleCGF36rvtdZ48ts7j5rieFzO7bZFHfBeF/9B14QiaV06EUPAPYwZPVepF5
	 E62h610USX4w4JY+ihna8cTrJQCiLX3dKV0a3ttbdHuA+N+q2x9MJFEzWKejPyLKceZkp
	 4GvkDclj3cZpoMGXk3dCtUamn25BKOlOR6BZtn2l+xwlPCaumEo9g3naat7sDbe7jvBHU
	 ubnUJTsq32l1iXkT7wTTGPpj0gUxMGtSR3znxOZJH9449dnBdSTOSmi2K2Au40SzoPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Qc4Vp26/";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C61606A331
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C61606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qc4Vp26/
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso58655365e9.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606450; x=1796211250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yl/4IscYRRIYoDrOcOqnAZtQEjR1B47TFUIpt05puco=;
        b=Qc4Vp26/uC7qsxwIKtKlk3T1TJ2q4O30iidXJ2WFl8sDz0hR7xCeBstThm7T7ry1Vf
         5g3L95KJQr2h1O0lpwWBQ0/qbr3Yxd/z1YtgGCixUWrzhidlYmnyyy6NkhN3UG+TQEhL
         g5caIlTM7ZfL4k0L/YhHys12a1uPiaUlnZVAsXvAAP+jbCeNXfru3Yc3x6z1g/QYtlc4
         stcEoXb+GBczKk+33B2HcrUASMHG2XWSYo/+WNePFhMlgUzonxGJo3WUSAKWgDEAcPPM
         ySZs0IusjywiUR2aL35ZzOyDo35vSeMRAihfnIHS5yLQa01ev83J+J7SzRmFBmObcB/Z
         8aBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606450; x=1796211250;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yl/4IscYRRIYoDrOcOqnAZtQEjR1B47TFUIpt05puco=;
        b=gMmk4HbkJGV3SfYy846H6RLqEhnlKglvDANF3xiI4afFJQKJAxHII8w7EQv5ofAAns
         xE38sRd5bdtAkrAWgiQypQmKnN/JA+Y+yq2uTBHX/ZCQTwsDNlH7HQULyoNhvMYTt3+1
         YmQiChBHT+62s4BrteWurCMMDvIjbONlrT9g4ToqMyiLVKSyABUtsG+tQv6Gh9ee3j9x
         mjDxGAyjXDgbpy0OfFG4RfWPICDCoIIxvSZESN+IzQafcFHDG2slXiPFdCXQoeJx8tTQ
         zBcEHOP2x6icCymOQDtGylAB4IoFgnupS9wvVIzOH91ueMSFx2mS6nUBNp5tGTEen3Ee
         Bpqw==
X-Forwarded-Encrypted: i=1; AL+hErFt76ZaY4Li+G5xEsQBJ4aQrrI2OZxBFgpkp04kFiA89cgjryE4huhkG406c5p+O2G7Bmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vI8ijhAlv4gL5QlYYjLaQXQu1KeQREN1nE7ltoej9q1995gO1
	3rsxO/rgqTEFeV2mjDggrKYRJNuKEavmljUauJDxGNE6PTnFrCL3NMP5
X-Gm-Gg: AZFdTZeCTuqgr6xbssN+mpilm07tl2OEVD848EAanBmaqfmhvkW3NScIhKViK3Fhjux
	RitUZbXqZ0pwdwSVP6M0wOcaG235M4mwa48phnEsdsw8uvKtDX4fKtilzr35j0LTFmn2eF9zmzR
	cicTOfUgGk3vt5Z6OZnoFx3XRDNlUw+E3zkPpcvcSLlfmg/Kq89XncyeZZ5gQ7mnucLUNA5ru1+
	P2CZFmhSMrqboFte0LYu77Isb4ZMYg53wtjqvvQg8jFH3HazawmHc0QKM3L/tXnxIOHKh12t1Pr
	P0nhPvPLHS8R8Ve1PPvegVj29zG0loB9svccBQQdagUKlI3ZZAf7VCfKf15p8JCDf+M2rdb8fbF
	1GSCZdtKLE/UHLSVtwKS/Jh2M9m6ALqdS4bH93yft/ORdwYjc6LmnDJdhqWpvSsJzybKOq+kwwg
	fFbspDseWeHnChJj0GtQD6NpS795tG0FtmMiLOaW+w+I2DzHXDQkACFpKWX0EQFuz7Y0i7OHRID
	jgRAMIf/rnKcERMUTytdGFyX+PIEH4J/nKU7VJuD71ydf9vu7LZ2gOcM4kd2h9FNwK8fb4ftvNI
	zChuLA+ozUZWgEhbmosqF5BI6VsPIntXNCc=
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb887c3428mr360008895e9.1.1795606449726;
        Wed, 25 Nov 2026 03:34:09 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a12acsm542185355e9.8.2026.11.25.03.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:34:09 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e2787d40-0b72-4f37-b132-dfdf49d2ef04@xen.org>
Date: Wed, 25 Nov 2026 11:34:07 +0000
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
Subject: Re: [PATCH v1 19/21] hw/xen: Bound the rep count of PIO and MMIO
 ioreqs
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
 <20261124232247.23169-20-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-20-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> cpu_ioreq_pio() and cpu_ioreq_move() iterated req->count times with no
> upper bound, so a count of UINT32_MAX kept the vCPU handler thread
> spinning through four billion iterations. Xen's instruction emulator
> clips a rep batch to at most 4096 repetitions (hvmemul_virtual_to_linear()
> and hvmemul_linear_to_phys() both apply that bound before an ioreq is
> sent), so reject larger counts as malformed, and reject a zero size, as
> the other framing checks here already do.
> 
> Fixes: 9ce94e7c8a99 ("xen: Initialize event channels and io rings")
> Reported-by: Feifan Qian <bea1e@proton.me>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3756
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/xen/xen-hvm-common.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
