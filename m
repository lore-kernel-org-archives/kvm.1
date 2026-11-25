Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606082;
	b=M3wmdqAEEVPWUbjaFXbFwN92nbC8KDmklbZEqvQklzLK0ReA4syheB0B0go2tPm2VD11
	 iJf39Sl88PN17sG6OAA9MrHPIAZ5CL1B0DPsghjfD/tnG1265qT9qUioM1VbNumoAhzKg
	 YhSUmuVenypefoKrNrloAxcT+hRBp5ISEfruBE/Hx+5IZQF2zS16YylnZFgxzT9Say+eF
	 y2MVIBr5vrdFdc2zPRj9IbjOVn5gOLk5yr/taw0/kvu2isam9yEb4XxgRFocXRRfR7utk
	 XnlME/HY2/p00TIJ3WsJa/9zgs/YXzEmoKO2/4nw3tRN6V0hj+QHw8ycCUD48kKEWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EN7GUMRzh20SUucnfQTtq8uiWe0qYvrM5Jkr0GomWl0=;
	b=ntyC0jsmdUVMbV6TdopPq5q8dBZ+PAxNfNeBrN/Ox7S706j3SmJb4eU/Z4EL/tmFoE7M
	 YsmoOWkZ/vQ9G42RW2+j+udysKFSDSUcUWoG//Xv5nDqNHqEqrU0QEvxvyUNYCWOnqKbZ
	 C4d977VxxWe/xba7CX/dyj94cLqdFRGzLUbIVUICd2nAJrH4whsW19kSZEDAgBThKTCxy
	 BxEEkDUCVBlcKPn/l0Z5aFYWr2YFUTJBvuo59TKUfAul1zKXlfzOCSbTsrkwNdunEfQ3T
	 E0BnvBo7yCwk/snUj6ylXwiYdrnKAk9oJzaV1jhd37UVy1e7OQjNs1OrOUsPRwXSsgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pxy0maAM;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB91606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB91606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pxy0maAM
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so48821815e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606080; x=1796210880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EN7GUMRzh20SUucnfQTtq8uiWe0qYvrM5Jkr0GomWl0=;
        b=pxy0maAMfaDXjZPNBUQn5vWQRXNK1DO+CiC7q7BETm1Us5N4xmBg4xgdog5H11OQTh
         JMsl8LIlxqoh5Bjg6KtInV4d4Ieh4zS3vL9K/le7OCB3BVrrii8WXjDI9sQpJeVUnU4c
         DEL9+979ZGkFEOxbWBqR7XNGnPyJkD5phCeJMAjCbZ8hWEz7+t4FPz3xtTfJf5hfMrML
         /G5FVlwhY1p9UxslFqgrc44eSS9pcnRCKxVcc8Yc8GP9neD8rKsZLwx7wTPg6Y5J0BZ5
         UtsLmJA+VZtZ2NoSqjkQJrHXSk0BShtgWstxp55V3JjFTl3Qk7NOe5KD6ljqEiXAcVEI
         gvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606080; x=1796210880;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EN7GUMRzh20SUucnfQTtq8uiWe0qYvrM5Jkr0GomWl0=;
        b=hsQbqed0mBqjblhb/vd8R9/fPJw4imv398FjjgkECDloAvHwYPDjjL0/Aodo7hkJqX
         YjhuMW3VH8nfypBG5g3xMrIkuxtXniuaItIWnKmGj3NRtOjLmqsNAoMxd6LnN56c8S8p
         D+sC8hQVrjW70oBbZvJYPfMt3B2U6EX0zv2uAx8yTERu88YKgb8w9IETorpoBWRTVREc
         R3Dg5jfh7cB32n5bTmBtFsRBI6Gsmqn2rsDWFrT+ZBxByDRlWNSwCrg0elwpucB286nq
         s2v9UT61ZGdIhbmCpITYSq6lccMifaTOKuQ3cECDbMubtrKy39dX3efqjCpQ/sIEwAAR
         47bg==
X-Forwarded-Encrypted: i=1; AL+hErGUp1q/FkWeaUSdR1XDvpjNS/buXJvEsAfFHvtptuDfrDpHvrRkvzYYnNjEipysj1DfILI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b/aM33SMAu6ns9xNZoMM+5VfFMNUfa6LUdLdxzqdjzBJYQBFQ
	p/q6LHoztYnfIDvWlsrtHx/lrcl5eBJ2uY3wokbjedpBZsAO0ajh4GjT
X-Gm-Gg: AZFdTZc3AkVAMyRA+OkaUtmTWiL8sQjuI3HoynEqUCOD4qAEWC8Hr99VWrwQqADRSlL
	UQrBzEtDQ9l5gTAJuUM4jaFuZHRm8TsSRrILMxHG/gHsQjIX5ZkEusVj5UUue56BWZOq4pj2FzQ
	wLh4I1tsOsYdKF4Mj/4TrjpptK12z/NeleHek2X2qLwed+PRE6bnRB9penTuhRAcXNKRwAgT4oW
	I6zhjAMuRlHolBYNSDdlycb018BQ9W0ubMmi5KChZDNlf44Cj5pzoPacTv7gj+PUKs+pgmKmWCR
	K89oeVZLp9teipSamEpfr85lxHQxEEbuaHHDysjWmnxTRgHdBvl1HULu2AlGehYOZw+25UZFxQ2
	hGiGPFzInbp33s7bW73LkvkAjnjcDxSrPDK8ttfcMIOCxt44HCCcAjqqERYMzEPjRVOtdLsBXrT
	ot8IQ1BPjK0gBk2asWEPbqGWzcwZylUNeNiE8bd+Jg5R/JZeJpkkKqI31M2Nviwpzf4pvVPvMps
	29XvW0T6Uooozka/PIdGhja8bzZPjNuEMJ4H9S0xxCUU25x5BdFhbDnw8B6L9jNXtwREHD4Xyk8
	pFhnxhuQ0H2NeND4kreQ79iziY0P4syGun/7zQTag2/E072cAsmFjSc=
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id 5b1f17b1804b1-4bb8881099cmr340385915e9.12.1795606080223;
        Wed, 25 Nov 2026 03:28:00 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm460692465e9.9.2026.11.25.03.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:27:59 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d0e3be64-58d8-4d4e-b90b-f37ca4dc5e3d@xen.org>
Date: Wed, 25 Nov 2026 11:27:58 +0000
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
Subject: Re: [PATCH v1 15/21] hw/9pfs/xen-9p-backend: Validate the request
 header size field
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
 <20261124232247.23169-16-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-16-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> A request whose header declares a size smaller than the header itself
> was accepted, submitting a zero-length PDU and advancing nothing, to be
> re-processed on every ring kick. Reject it instead. Set inprogress only
> once a request is accepted, so returning early on a half-arrived or
> malformed request no longer wedges the ring until disconnect.
> 
> Fixes: 40a2389207fb ("xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/9pfs/xen-9p-backend.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
Reviewed-by: Paul Durrant <paul@xen.org>
