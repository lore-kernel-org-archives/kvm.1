Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604739;
	b=rldKvAhFEkcNp3WXtfbsswUvY4W6k+38DvFwP1k9DQYqcoBeiGn+Hj7imnnpRgkyHYSh
	 45kDiH9RaR/s7n1h384Il+/FrmeSzyF4Um2CyNJqrVQFmNHmzr346deNyqQXbEi8eDDTK
	 IwEO3HP32qNZxi5DvlVlrb8EgIBw13H+sLkcHGxvY4HuzyYwYdB3+7fmRJCvdb6+42NRc
	 2swTxNY1XAylVTi2EZlL3ShBF8Q0w4CoHccIXLgLWfz2o5IxT9j72jk0KnQDn+aKfhPod
	 zagRspbRYvpvUqQffRBazUZMpBx4/s1PQGb6wKP2/II11rVAVTMznekD0RcE6XI7puA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rj/OmW4asS9jNN/viln1BFpfuwXmJiprMQIHIS8uDWw=;
	b=UtdHxlO0PHDqXvfMQDVM0wnPOKJvv+ifBka73hNAYKA5yqdRnTfGkvoRoq8scB74UHVc
	 V0xVz2kXVch5Gyr/ZrAuZe1lRlpn3aQBJ8DCcRGLFz10hGCbbs/zZKn32XCh45tJ8jrl9
	 bvg8M+8nzBVZFkEFTlKfjzLmOuTfSLO9Q0q6ld/2ofOTWEg1w38ojKdF3u8YEEpFEsBao
	 R+h7AgS6vhnclQhj9VV8muFKBrUrMd+HSxhoJyhEM96yg9HAg6yOSX+VLGJdxOWRwwZzB
	 YP33E5Ms1Gxr9XT/uRGEqoq9N2a/fVJ7rYwLShvR4F1BduMHUaoYyHAmqGSoF4f2apA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EkJpL0Zd;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A975606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A975606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EkJpL0Zd
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e30c26a4so1257709866b.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604737; x=1796209537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rj/OmW4asS9jNN/viln1BFpfuwXmJiprMQIHIS8uDWw=;
        b=EkJpL0Zd2So3VZhWVlZIgYAYvE/y9wew5r+5IndhiqU8qZaJ21Pc2Is6zwWh4fQhsm
         fT53a6KWOHgbVbaoXdarpP/mMp0LqmiCwJupOr3y4Le6IMhHJJNxJz2dalM1BtwKXXc9
         +RR8XQLTZV/roHX0v6AgQqpLOIB9vW0wId7p/erUByspT73o+4BpBW5nDTEVqKMABJkc
         1eAClkUkjMufGdWhBG8gBV7fWIrQFNRu4Q+t1nMpdgsn5RDZBZDyWtVJTsEkp6zBWNp/
         yhtkQ+PnPmP4S3fuUGPLMCHEeQj6akgByrIfdJD6gHMkhdS0jR0/qYPinqO+s0+yCWI1
         pXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604737; x=1796209537;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rj/OmW4asS9jNN/viln1BFpfuwXmJiprMQIHIS8uDWw=;
        b=HCIWzDje/bHZ9D1yeW0xLsojgMm2P7KmzGeNlGrgW7Z7wmFuh0+JxAnHfUGHPVuXYa
         foBmt1LuLasjypNCC5QtCytBdTL80oNHHkTsi4zcpVSwYm7KAmyt6oIK8DRd93iNE3L6
         OzCaw9E5DP6U/unxufb0pAZEYx8wkwevCUVNIiC6vZniFhyDnnSymAV3AuYWzjtLiq+g
         0M5VZx5MucavQtXAmYe7OwnuDZd6tfnBjI94qy+aZhtFCIwRnqW9+gkympgPSRXz+Xpv
         RyO/5+ivkirH5ENNcSrOkL0ZJ2BaeRLHPWi6RIc1N7CJPlKhhkZPV46WWcgGgngzk6OM
         CyKw==
X-Forwarded-Encrypted: i=1; AL+hErFmmkhynS2+9IgwDXpeA5VxaTUDYWk44Bqowu0tcC4CWRd7oP1wK0ap0fr1istQRj/YLZ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KJrk87DapGBJIo+odsq0y8fyqKyqvFh4fhfJqyAU4/GkHoHzB
	UGvGHJxpVZSMwY9avNZ3bPY9vd/k31wDNYWZNBHvdCJgiHGs9C/8gE+C
X-Gm-Gg: AZFdTZdZhz+ckcQ9zwbvf1+dxtpg9JM7dD7iDrOK8GbvtoSSlJ9mcCBi7N6bgHkyg75
	KlYpL0cck+vlrBDiex/wYgfUmIw3L2VLMVtu7Agb+AxPycTvxY6i3d7j9PMoGBBBRgRyIEdmxuz
	GdphroVM7KfAbRgTmQudaLOvZwZAGKhLC76RoMUbMad49Uy9OCG9XoP+Kuoh+DyBYbvEgjRU9lp
	FemHD2U/gUL2JvHXyjDEtwr77jOKqf5smAUXAktlq+rjQnR5bnV+pa70DDgbgw7cLqxK6e7Q6pX
	YmZSWZJ8sEjVcVZ4CEwyfUlFzG+1oPG65rn2QFhiD77OsF/fIWPpWukt2wR73RiUAxEjX0iXgcM
	k+9hOmFBJdjw0XYql0DGKFY9pN+7LCJeriNyTKdViJzRWn/zcrQ8jVXUrhTqwZDs8rjEl27tN4s
	YG7z7gM6sitzY2LBQS8oAIq7vkgC6zBXzw3ugAHnar+19yX3LcoDycZN5clIhR257aPE3OBUHfA
	qMz11gbDZoB1RlYhNoKhyIMQhRVR+evGzgavsxMGsnnHbkABy7VkrKBwUi8MjVvtjoOwI4JUudg
	J1RVgF1QUGnbJVurzbbq/4FJP2nwzPcVUpE=
X-Received: by 2002:a17:906:ad8:b0:c2e:4397:7c82 with SMTP id a640c23a62f3a-c513a5e6a7fmr1084197166b.6.1795604736841;
        Wed, 25 Nov 2026 03:05:36 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc316bsm614560066b.56.2026.11.25.03.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:05:36 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e2cdc050-42c0-4565-aec9-2568c391d756@xen.org>
Date: Wed, 25 Nov 2026 11:05:34 +0000
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
Subject: Re: [PATCH v1 04/21] hw/xen: Publish backend features before setting
 state to InitWait
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
 <20261124232247.23169-5-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The XenbusStateInitWait transition tells the frontend that the
> backend's parameters are readable, but xen_device_realize() set it
> before calling the implementation's realize method — which is what
> writes the feature nodes ('max-ring-page-order' et al. for xen-block,
> 'feature-rx-copy' for xen-net).
> 
> Linux blkfront reads 'max-ring-page-order' with xenbus_read_unsigned():
> no wait, no retry, default 0. Lose the race and it silently negotiates
> a single-page ring — 32 request slots instead of 256. A device
> hot-plugged into a running guest loses essentially every time; at boot
> the frontend doesn't come looking until long after realize finished.
> Netfront reads its feature nodes the same way.
> 
> Commit 240cc11369fc ("hw/xen: Avoid crash when backend watch fires too
> early") introduced this by moving the realize call after the block of
> code which both populates the initial xenstore nodes *and* sets
> InitWait. The crash it fixed was real — xen-block's realize processes
> watch events via blkconf_geometry()'s aio_poll(), and the handlers fell
> over when the nodes didn't yet exist — but only the node population
> needed to come first.
> 
> So keep the node population and the 'online' write before realize, and
> move only the InitWait transition after it. A watch event during
> realize now finds the frontend in Initialising and no backend 'state'
> node, which the handlers tolerate; none of the three realize
> implementations reads the backend state. Verified against the original
> 2023 crash reproducer as well as the ring-order negotiation.
> 
> Fixes: 240cc11369fc ("hw/xen: Avoid crash when backend watch fires too early")
> Reported-by: Mark Syms <mark.syms@citrix.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/xen/xen-bus.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
