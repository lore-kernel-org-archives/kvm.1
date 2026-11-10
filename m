Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345219;
	b=kAvMpbNV/+3G6pJ/Ojd6qvNiQiaqFOpnz63atE058dbbjtiRlXdk2G+onreItQPJJTKh
	 bVn5bVsticCgDJa4G/eIsKoDTGma6cVPX5/uN3kwHPzBiF08JPxQb+OTDpYzJUJY2iwkv
	 eJW3oYjPLtpM32fVfCLVJAqE0HVpC7iyrDeTAWHaGlmUacQfRf3MTkh7pA9rqQs2GIwfI
	 DZGiT0MP2d5GUlOsNji3kvgan+VeHMYw8YsrJoCicNogI8MaoxmDO0nIUw96Npljpb8Px
	 ytyDYRQuKEeF4qtc66G8Mu6U9WVmTRzpj7+TH1DsSOUK456oiQKXY0ZlzOf++j3tMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=lmB6Hd3K7WIxkVjF2clYujbDcz9bAuhj2rRE9NRLJbY=;
	b=Q754EZNK1jHGIKV3iyNJ7iX0Buf3sZlfeX4zmCK2jzQ1SMeR1oAQafsakrbGg3AtTA+Z
	 cNysy/EURpdurbPZkyP9diABBTZWM1eFn5j1bcM2tAiBzlDx/b4OUv7cHhFcYk0MYtj3x
	 EG1l2Bnuw2yKmD2e5nkSOO9EYk6BbTZviDqwQo4xu4eoEuskY1QNXEg6iblSsnT6ed9+V
	 mcfZ2GWABMbzMq28PJQ45tWQtXKCBNc8xIxKwxW6Yd6lvgSNza0KAJkJX/tZZzdwtwvlt
	 /UqPJCroGUEu6icV4GTcuj9VWIhKmr6/LsHWZs30hAHkLrpKuTh9/+NXaZY38mDyPQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vo3EESPq;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA740606A320
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 21:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA740606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vo3EESPq
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eaae62796dso23819505ad.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794345218; x=1794950018; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmB6Hd3K7WIxkVjF2clYujbDcz9bAuhj2rRE9NRLJbY=;
        b=Vo3EESPq3s9qTUdHxZQztaVmL9/aC6NA99RVdFQtk9Th+ZTKg9qYYfhND0p7bl2Ono
         TKEZzBVyUDd94dL+EodmR7LYSoJwCjvdZgB9ZeAC0kJ6A92dJk4tVSiVyBGJNxqXFimF
         863enSCvrOFGp8vbu/PLMUTiA9LrYBwY44pEZQJreOVW9JJ95WuqfvajZPQIEZ67wlDR
         pxFbIaMkVWIrXSbv+vQTTqOPl89SM1A7fIpxKzX9w58tvNljYUThGupW7rB+ztbIsNpX
         l/x2bgq17uZi+Hnx3ht5YlWb/3u4BMoXjgx1i5np6J1DvSLR/gg9laH+hxxuXT/Vt214
         crrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345218; x=1794950018;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmB6Hd3K7WIxkVjF2clYujbDcz9bAuhj2rRE9NRLJbY=;
        b=Y65sGMFv2EgOjGx765V1T9MW9v0hqpwW+3TEtalIpa6wovB5Uw7Ot4bsZ8b9wL2CXU
         QdlBb1cDotRjrGxg9R1CdWQ8jhMI5mASxG64k7bVFLvuIMFOU1yRsOGL5L2yNiDKwfmo
         o83pH+LMACTfNOnyCu2x2KIazGLOV2pU9blQpa0Ls5r88LyA+YbgK6l5w3w/Ic4ftYGc
         4Uhq82sDK6E6h2gewsU7jSojrsK0Pf5fgEv1GeMvZMsIwsbJulb7CyiZn4GnDKb2+DSz
         U1NGIv/un5fxu3iZ62NLJwTmuRKYFjXIf45XeOyUmMWf+j2lytaV1xCd++Zu1DA2g6i7
         pm6Q==
X-Forwarded-Encrypted: i=1; AL+hErETxYWnbOmTyDn/a/K1ePEgQRfUYLjrLuBrNa1IaT1ePV45unQNWSvwcO/4kNivDf6Ej5Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ft4yC1bOtrk0BnT2BJaC7BVXAqGhDD+3k5YFzDkSdoOHEsCvF
	qfzDg6c8xWuT87qdlR4CGI6nvHbghDHllSLbnyFb4EVwqQA/kUI+uviqLEQAzo1QXyomkKNuihR
	2EZdPGA==
X-Received: from pllh5.prod.google.com ([2002:a17:902:7485:b0:2e9:fe74:4523])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c8b:b0:2ed:2176:2455
 with SMTP id d9443c01a7336-2edd7b864b2mr3011055ad.38.1794345218010; Tue, 10
 Nov 2026 13:13:38 -0800 (PST)
Date: Tue, 10 Nov 2026 13:13:37 -0800
In-Reply-To: <20261103220337.3578111-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103220337.3578111-1-skhawaja@google.com>
Message-ID: <avOJAY8HvkTClshx@seanjc-mac.roam.internal>
Subject: Re: [PATCH v3] vfio: selftests: Remove libuuid dependency
From: Sean Christopherson <seanjc@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 03, 2026, Samiullah Khawaja wrote:
> Replace libuuid with a minimal uuid_t and uuid_parse() in libvfio, and
> drop -luuid from the build. libvfio only uses libuuid to parse VF
> tokens, so pulling in an external library is not worth it.
> 
> libuuid is often missing from cross-compilation sysroots, which causes
> the VFIO selftests to fail to link:
> 
>   ld: cannot find -luuid: No such file or directory
> 
> It also complicates building against glibc alternatives such as musl, see
> https://lore.kernel.org/kvm/c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com/
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---

Tested-by: Sean Christopherson <seanjc@google.com>
