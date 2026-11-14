Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794656499;
	b=2nhDcjC1ZBKXQrdMWPMJcXt0O+yKXQjKe4nMsThoaxGYuS1lPaI5hLFUI4myEjBEeBqH
	 iAn9pWm7vm2+MjFAruRbgGW2JIZH5vFafIIAgDR81MYSv6D59+S+c/o66GjW+5itziBrx
	 4fWyEgZlg9+jnZJlSsughlQLCBJW2Ky4Rqpm303qCrRenHDtDp094e8hmkW4os3jlDuDC
	 BlSQeaQRfQ+moUAAgR4+oR2bDk2oC7fDkn/JyEVJ42Ddlx76ODo6NQYGo7RRxDwkf2Jhk
	 0bsGviZreFdXiNWhO9ysRKtq5kHPKjx0FsCbFxlWJx2cvfAeZNO/sxcZ2Wc95Sv0xfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794656499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=a/fji4ANglWLhnM1b925r1xDhw6BBJRmXgZEro3KYGA=;
	b=PXq3tgcpWVUB3NpihVKgZlxzgaoZiri/Tw21lddHihZ0yvZxPQzMVET4cYPADuyF/jiP
	 V0Mphn+peKldZtymlqPYLJ6nFUhaN+QgPbWS+FsSSc3kI0OJ33VYNjZ49va5ByxA5hYy5
	 ktjRwSOHdLZSmwBtUny870bj3wHmNLZaQNDKXiOaHkbKfOVDrJ81jNoymUaZCymxABxa2
	 S6WbYS8XL6WkoRKrQZNmOHYUGHcILmG6u4wBq9BcoKXJbGP81N8M802m9ZQUE7hBt6CVq
	 BYgy8CmWPdW0d/sO2HwzbGaHoKvtU12iM09pekBQrI+TouGoG/sL7rZfgpowS/Go1Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flashbots.net;
	spf=pass smtp.mailfrom=flashbots.net;
	dkim=pass header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=RPk3hKmo;
	arc=fail smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B49606A32D
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 11:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B49606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flashbots.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flashbots.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flashbots.net header.i=@flashbots.net header.a=rsa-sha256 header.s=google header.b=RPk3hKmo
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4932b13c4ccso1678887fac.3
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 03:41:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794656497; cv=none;
        d=google.com; s=arc-20260327;
        b=J4/U3/P59iH8yWxf163dmKpXVddrOEKvbpH5j7ikAWFW1MJh2/iw8l8p80sVWzaP+R
         gaTZl8svaNZVuLFn9MHLRVXPZ1cUlUSi4Fi4qt9a824OdyVmxWqccCjudE3mbY3trCcX
         fVe0cr75BRF1D3iWo7aaXQURfjzYEnPLL74aUPYb+Mw/x1m6BoTOaaLetUAGuds6moHB
         oIy8nj1LaKnSkMpFXfk/Rw+5xw+oMpAz6ruWefzGua8irpZwCqP6wHm+XO4nba0+b5t6
         U9qFbDChCyiknuL5CTTsPJwgmPx6MM9Dmz4AhxweU1R1Oe3N9sdcDIcl5vy81IQq4vYK
         G5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a/fji4ANglWLhnM1b925r1xDhw6BBJRmXgZEro3KYGA=;
        fh=AMrGLitKGqBdjIyWWKXxVPjBo9ZhPjegIAx3vnpk7oo=;
        b=XcCvcs1d7ZEhA2MIVgHuofvST8m4mAZn8ylGI+doAM1HpJEioXhGjh5Mqpcva2vv+r
         bB2x+MpCzgGyUfr0XxTDEWaj1ikp54QixsVkTppISDvkF60+7qiyL85LM1H/TPhtXtUn
         NAabECm+zNLWHtcSxZH/XINPJAFwM04dTJyW0mcLwdtXeQNO9aq4PJic9dOAtm7aYqB1
         HbHccTo2G5cNGWqsOR0TIWVpwFCeumA++WfR1ve6KwKP1gbSOOjrP4UcAHMFT27aoPZZ
         i/zkEmpmvY13CIwzrJxDK6QDt1QSEsRT4Kfa33K8U9YlwqDnwxp/NAoKUY6ruRSJCmc5
         Mjfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flashbots.net; s=google; t=1794656497; x=1795261297; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/fji4ANglWLhnM1b925r1xDhw6BBJRmXgZEro3KYGA=;
        b=RPk3hKmoRJZOE/rLguqoyJOuGcI+0otfDHj0jb7OOJz8CKu6MRyvtZeUpLpVzvBaZK
         47pyhTHWDFQ1P1XlcTeOxUOIfzbX2jWaZLZ19EPmx3ZGxxskuCiRMvdrV/lQQwwSZVrR
         vW6pLdI9B6VSHdpmLs62jQCunpKHDRtp59ImFhyuB87W2d44eiehj8/z2l7f97f2Igdc
         vkF+ZBAmiXjyGePpmcbFQzoAdE3F7Fc87C3LuSRARiEaD8XBKhy+IHwAFaMAwI1EZdID
         nb8O+iCxZ7Sgj1igdgLaM8WLEr+AKf92TY8ExRgrig4CzkQNfiiblHSNsoQO/MmO6pKj
         t5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794656497; x=1795261297;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a/fji4ANglWLhnM1b925r1xDhw6BBJRmXgZEro3KYGA=;
        b=G1fWje1mUfbfOFQ2Q+VSpoOD+GQUX/q0j+/nnkd5KHS/0s5n6+0cpiFif8hnfdsrGt
         wiSIB68F3c2NrGgMCl5EMR54hU8IS5Z2wIcJh3zIexUlXC9pTZJkwt2D/ABVLOnpLCVU
         DOJJODds8Zi2ZhTw3lkId7LcmIm+AL5giwOoU0wjClHtqE/QmRMSkYSjRQrko+qkFAr5
         OUGR6o1ScqSF4ed5JUFsSsz99WNd7fo8nUo0HdTDCi7TaIkwBH2a2+eCv8uRSTqw8ad0
         q1nimnFgy+nucFqDPlPEbk83v7YinvIenAzyQ4Mms42M9jF3FsqdbzO1MvHAJPt5WBab
         QpDw==
X-Forwarded-Encrypted: i=1; AL+hErHyTEMVVjO/tgZZP8hsQkYD0g2HAL0CuJkx1UFe4kqJ/EGl6YF/h2dvTfQkARurXnZQ/O0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MO6ojcSknjVOwJblvD14QQavM+oW86XIibmn2c4OpB6KKBukA
	ia5v47c5c8MTVlkKT8wHbDeVYoFnsupuWBDw8jfHbGm2cFkZoRRiRvZOoTO677WV7Y9rX+gO3Ke
	BsHin+EPowP88WAxqu0puxkYCaR0ePLoPwrf3ZLlpNrNbeYGmJnPV8Vqsfg==
X-Gm-Gg: AYBFou1vT1ueh1FcLPZXaORbxPgbS4NgKMrKy5xaHna1ogy1yGttREyZYlur0KCLIBH
	+mPtrCJQbvjPLdUuCtfW8Zxtmetb3gcpoII7d/0vqbkJu9xjM2Yv92gZ7/qpdJ38MBuPO9rvZgd
	22aQceTQUwBA19I8TvFX787tmocdHR96wDGs85JJEbA999QVcEQiur5vfguGu2+7x6HWZjNRnap
	Lwy8uQ5XZ3xs9+8Zchxb86iUVWVDdRZSA9cOEm7HJ5Xt0jIVMSDhBcSlQLFlj/1Ok2GOzL//g6o
	HEZghIAowyrqPwETmkpGe7jGba7Vhkq9yVTNudem9MjkIRZRbMLxEuJeajsiHRLbAqnSItrDYFW
	P5wWudWWgQUi8DORS6B/bunZB1fgyAFgJTo8o4jK6uH4tKf8BbsoRYdkTB8nn5NB2u8beH6brng
	kjqedEgLknLHsmuuTW9WSKlIJwGO6upIrprGSOJGWUT7MjdffcZBvs5kWTxU2JhM6QFyC2aEWv
X-Received: by 2002:a05:6870:6c1c:b0:4ad:7ef2:6005 with SMTP id
 586e51a60fabf-4afdf445b53mr4823353fac.11.1794656497656; Sat, 14 Nov 2026
 03:41:37 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
 <CAKV3HMM9BKpmgWeFqRqamAsqqiofj+TG4DrOEHmbUyE0FjA7+w@mail.gmail.com> <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
In-Reply-To: <0f9ba1a6acb57a8c126739175b4e38dafac08c9d.camel@intel.com>
From: Moe Mahhouk <moe@flashbots.net>
Date: Sat, 14 Nov 2026 11:41:26 +0000
X-Gm-Features: AclHuK8iaDFWSE6FVS5GEQtiGzXP5xPODgzuL6kYZ3-GR4mSvXxwjBpv9blLgS0
Message-ID: <CAKV3HMMfx4APmardWdtL8yhirXMuuBQMZ8xrtowHNRnTKXNRiw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=F0=9F=9A=A8ext=5D_Re=3A_=5BPATCH_v3_0=2F2=5D_virt=3A_tdx=2Dguest=3A_Fi?=
	=?UTF-8?Q?x_and_speed_up_the_wait_for_a_Quote?=
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"Miao, Jun" <jun.miao@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "djbw@kernel.org" <djbw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2026-11-13 at 17:33 +0000, Edgecombe, Rick P wrote:
> We do expect quote execution time to change, so this may not be optimal long
> term. The exponential backoff could limit it to 2x the real quote time. For a
> long quote this could be pretty long.

The backoff is capped at 100 ms. The 2x bound only applies while the
sleep is still doubling, which is roughly the first 130 ms. Any Quote
that takes longer is seen at most 100 ms after it completes, whatever
its duration. A 10 s Quote returns by 10.1 s. The current code adds up
to 1 s.

> I'd almost wonder if the guest would normally be happy to spend more cycles on
> getting a faster quote.

I think so too. The cap is a single constant. I can lower it (10 ms
would mean 100 wakeups per second, and only while a Quote is in flight)
or replace the backoff with a short fixed interval. Tell me which you
prefer and I will do that in v4.

> Can you explain more about the quote use case you are targeting?

Attested TLS. Right after each TLS handshake the server in the TD sends
a fresh Quote. Its REPORTDATA is the hash of the TLS public key plus
keying material exported from that session (RFC 5705). That binds the
Quote to the session, so it cannot be cached or reused, and every new
connection costs one GetQuote. Requests are serialized by quote_lock, so
today a TD accepts about one connection per second, and ten clients
connecting at once wait up to ten seconds. With a local QGS the Quote
itself takes a few milliseconds. With patch 2 the same ten connections
take about 0.1 s.

Session binding is also the fix for the recent relay attacks on attested
TLS, so one Quote per connection is becoming the norm.

For the long term I have event notify working on top of this series. The
driver uses the interrupt when GetTdVmCallInfo reports it and keeps the
polling as the fallback. Over 120 back-to-back Quotes at HZ=250 it gives
2 ms median, against 8 ms with polling alone. I can post it as a
follow-up once we agree on the polling side.
