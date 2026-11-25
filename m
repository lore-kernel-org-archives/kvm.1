Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606243;
	b=nfpnneu/Fr2F92WiDpzIjoLRKL8H5JxChJ115Zcx7wuGm44A9KiFrL4QLzIUfLT5zKZK
	 8SfTetivkeeIQvI+uRfOoIQBsJEFG3YmvpfGcbd7m938kgj+EPUpHejwyqSyWXwbRI+D4
	 RziMs8cdt1GKDFOXs/oc8IySCt4EhVKXzRHLaG1X/z7hMNhlvOBySM1puRaHL4gGk77e9
	 VV8Pmv6PrG8kJEqNGO5zncHQQwJc/UVjVfbKk/5Utc1Aa8qs3F4erBcJou44Rn78y3T4L
	 2I/fiOlEswsn08IKi/LkFON5i2l8xOvR0JAXiST+c4EQYZH/Fg0Gma4UAM+E2ltVlFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Afcqxjv+MkGGt0UAmpL0zC/ETeooQhBIhJHHPCywLOU=;
	b=KtwNDaPFijM2fpbVOZXADYT2dH5mIuvb8NA4A6Zmxyv2gmzZFszOSMolImZEzB2tju3x
	 yNv4lOB414E1KJ4K+46IXEsuaVnHWVpyFbbgj/uhMgZPBc7SYChKWByH38qHJS0OjAw5y
	 IJqjaQEB6zjeeHMSodStV1iqqNjTVhlr7aT+MBihatN+UNqwT56UgVifjMo0gQA/OiJUa
	 W+D66NfkBF7Rbr9IhpZKBGRBJTb6J+DI397eqPuOvEelSEoJAi9SjNFa8wLGWee9eA3V6
	 Q+hiwwJdCaXTTewsNWuanT2aWMdHmw7Iv8c7XYPVYc/zcfdGq+ZhRX8ZRUZHHNvXgNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FzC6Wtno;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2F606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA2F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FzC6Wtno
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c51a02ad3acso71093866b.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606241; x=1796211041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Afcqxjv+MkGGt0UAmpL0zC/ETeooQhBIhJHHPCywLOU=;
        b=FzC6WtnoMZYAUX2aoIdPVg1ULT8seXjJ9oECVJ16sUYnCzW8gS9amTw+tna8+ngyXP
         gn2kpfDnJt0V4/LF6AGuKen/DPfaCwKgh4nmq80E/57YzBfvCiwWZtz6N9qnurTXrn2W
         i7FuO4das1RbGd1aKTG6TrLwdoKbwrnQYEA3y+FQbR3RoqTrRE6AeOEm9PXiSv7hXkvJ
         hCWVOvBGlv8NU2VT1LWn0btS6wmrSvnMsC9TwJ7jiOMWqXb1NcVYTbtCldn1rswEwdJL
         Ev3r44hWj0uTYPywluggKYzqpdWfNKCmxwkpI/anv3xekYCZ4xKoIbGtoPAmOEytaQLx
         9gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606241; x=1796211041;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Afcqxjv+MkGGt0UAmpL0zC/ETeooQhBIhJHHPCywLOU=;
        b=Xq70uNCC8ibtzC+sNhxr3quNnM7dAg9pmigg6W2My4ACxLlZBua7R30T66PMOQj8mb
         4pxUedC9d79ZD/N1YA9HNfUGjlgtAvjEl6dqWTzWG4yZBp4zeoBJbi/Dywf5gcoxTuV/
         trqte2Cz1SQusht0G3BxabhNXtF+GPi//YntKl3cVnCsEzcjY7Gn4d6X3Xyu035apFv3
         6Eozep1aQTRi+BtPX222a6e7aGr3hTsD/7X8DY81UtoEaMs55flFShcfvOmsNJZbkjSs
         4U5Dtuc1ZbN+kdYT+ibSToEpn0B747L5TseABPKeq8g6JbhAURe0s53RjVhGtxCPYzzu
         /xkg==
X-Forwarded-Encrypted: i=1; AL+hErF7Kq3IV5G7dFmNishMcGAyjtm3D03geb5RkxnEQB7jhsCqh6vYocuaeCd5RXDk1b1b8/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CHgC9jixCT7mV/6UrPyh+QRdR3iE7bc6G5tZO5eFzxger7t+n
	wxQ5IAHS5OKr2nisIk3Qr5t3i1HJMOVGvpkQaiqzO44jIKlodD0F34RG
X-Gm-Gg: AZFdTZfAizz1JXmKGx1xoX8QCyJIf5aBF0bdqq4HUXcpg2KR85TIml65KvuI4bQWJg4
	MI6hyCLtpDTJXlJEHDwM+Ajts8j5kQ37sW/5L8ZBQoNquQJNCPqx1HI/a89WZTLf0+Z9+OHl/Eb
	pETM5o46t/rdXRFEPXJuj9RrbViNn1Xk8BqMsthstJqq+f1l16mSM4CTpqdYa0QfkUpv1MRj5Yk
	A1LtV0PPnRXuTynZmqM7g3PUFBPBaEPWfevrUb0yxky9JDJaInJM969vxc8Bpa/zff3+AQeiOna
	Fcr8ajbF0AltdV0snLAQZ9o0IDOMKQXf0t3JUe7sy9WSSaXYgrUsETx88DxgvFGLTX18W1avu6W
	nyqOgUpBJSYzJISxpr/ERTASCkwL4gTn9nPhEsAQrNFIfm0zyDl8d1HehX+FOG8VxKVWd67IXkF
	u7uM2j7A274H+OR0q5h5Fr8G/giB+KNgRWy5m9Q1NIGRFeYdDbpHCkAL0vZlN9G5yXk+X6AlCvX
	UmW23MceNBMVteIzQ8kqgOsxSX+NakrPgLiXrlx0rKs8xmbSyWt0RBGL107fMV6OU3EeGsWedTc
	3bZVNTrRHohzlqbi7Y7kZKosIr/FlCK8sK9CtohVWsE4F5MvKzhorn6S
X-Received: by 2002:a17:906:1e04:b0:c3f:d912:ff8e with SMTP id a640c23a62f3a-c513a5ec26dmr1199239866b.16.1795606241345;
        Wed, 25 Nov 2026 03:30:41 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc2579sm599898266b.52.2026.11.25.03.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:30:40 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <cfc1fd74-4843-4017-899f-7b30b6baa448@xen.org>
Date: Wed, 25 Nov 2026 11:30:39 +0000
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
Subject: Re: [PATCH v1 17/21] hw/9pfs/xen-9p-backend: Close event channel
 handle on disconnect
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
 <20261124232247.23169-18-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-18-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Disconnect only unbound the port, then dropped the pointer, leaking the
> handle and its file descriptor on every disconnect/reconnect cycle.
> Close the handle; closing also unbinds.
> 
> Fixes: b37eeb020123 ("xen/9pfs: introduce Xen 9pfs backend")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/9pfs/xen-9p-backend.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
