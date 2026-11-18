Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795005778;
	b=3vCQF7Aogjzmcm8tbP+cEUWoc2D2pqmlNpYyjhqwgTsVvoTUXkhSN28Xhu89Wu5A61qU
	 OfZW8zps9ueXCwkthTAZLt5OuNPclnGEgdffi355PeLLHYYLNO2qdqRVhRCfUdZJ8reIq
	 o5BIQzIQx9cDrT6wMSZkOrIMwv6PgwXvks9ceHdSRuH0nK1mghfcmOYI2iA7GP8UpII8Y
	 brQ6m517b0gqMOBZGOziT/96BeHLmblgcHuwefccWikGBvTnKFKX1fH6bykfWr13eLmL2
	 F+tMTcmqqB7TyfgBjEzfh1rG1Jmejysny09wn6ouJPW3NFmqdtjy+IGQyca5hkZOs4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=tu4WQsRLgMJNCrYncFACnd8vCyNNudt+UvD0tk9IHEI=;
	b=DlsqJOGi8zXX+pO+GTVOWIlCpNWxnRIrKN6eo0ni3PVUUIv0ml3ZpXbV7nfMOFKCVmD1
	 QcMfU0nC5IvSwzLD2TSpTmwmCnxW86azUzQW+5AyAKtz0NX139FqCYIqZsWJuDORY5bMc
	 Eg6eFCPGRldKqEhP9rn/9WSup5lldWi0QTn7Nwy/cMJRptkx07qwGp5WIcWEVojAi6WGG
	 IDdiG25g004lIbP28AVBa6c9nnzZ5DUfM7wO1bdErz0Cfq+j5OM5NwP+OowhWUIoIsJce
	 qZAc7Hrm9+KsOEMrH+23zkmeetT2diUxkTJufFHsofox0PjgNhc/Yd9sKUKobrY6M2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcO03lPw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581460A2602
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 12:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D581460A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcO03lPw
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b85d0d0d52so1325817a12.3
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 04:42:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795005776; cv=none;
        d=google.com; s=arc-20260327;
        b=rUjuY7oBCBcSqlZon5dCu40nZ+5xZ4feFeErRFqKT+9GzifSk/k4d1tWgHHUF0RH9g
         VtMCxUyQK7dFXdvK+H/VyH5XCa2sRhH4bMnW+uCbkzB1vOFq8G2gMOZj/2PtRPalanDc
         WJM3tztorH2D3pR+tG3P6AD6XelVKKOjOz5LHOFSVrP/IS2l2chDPtC1PbLPbp5T6BVJ
         JosiEOZcukG/YprP5Y8tUm1aBokN1RJKO6UHklZ+A+A8EoVHE7oGJteny2OKjXn0c+/B
         QnFDXOl84MxpCFyuK1O4dDRHCkfn0Npcb69atmw0JPrQrWtDkv267BPuTvF0FxO5Zkot
         LR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:dkim-signature;
        bh=tu4WQsRLgMJNCrYncFACnd8vCyNNudt+UvD0tk9IHEI=;
        fh=NaLZ9i44hx65Xi1diKp4fH+UMaMtNqJVKjEMSDW0wbU=;
        b=Tcixc7T044XdqlkLVoiNLraUhxHD8ZQSukRZ11ZDGuBLdtET5Qx9zrEvxjui1CH01y
         TEx3+MsEKg5tg71CSVPbOsRfwrNObNwX7ZWocMX3Bha0Xt2KXmgxjGy/rd7G0XvM9CM0
         uVh8dHUU33qRXH8HqAEV/rLT3kaIybyywh1TsabxajzHjd5Gx/tD5bFXzQL+rpV6hHtj
         Yrvfs9Kz8/apcyka9B9NAu2nw+D9eeeSm+8WGMETWbY+vHSACo+8A3egQMBU6rBPRq5S
         VHvOHkbMkm1FJt0cshCvzvoKHh2fGFts4tce62V++IAJMJ5thw8nNDnYfyMaUGigWkQf
         mLMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795005776; x=1795610576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tu4WQsRLgMJNCrYncFACnd8vCyNNudt+UvD0tk9IHEI=;
        b=qcO03lPwu9LuKr0krp5dfjHJOP0sWF8HTYWGANLS1W/cjnUrYMGWj3krs6DlpUamQZ
         Smoe3Y8oR4zYCcjUYcLMdUbL7VjroxBYLxxtDF4Ql+AIMIDYNPVboOI63sSfC/p8WPCQ
         r+2SkTRyAz1s8+CBStHQ60ovxMMoVKYTUz9q88BIkBoVqdSu5oCaRV7gdF/agCXbncVb
         VwJa+bDYkD52JZUcBypfzc/2PwzPo/miT3Q52ii69kpplHbbowX/sK++WHFq0VpXt/Pj
         Da6kW6rzDQFYgAqnv0dZSOASsvRorYiLEtezfvvIQRfDI4gSn803ki22NVlH3rWW/jJW
         X6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795005776; x=1795610576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tu4WQsRLgMJNCrYncFACnd8vCyNNudt+UvD0tk9IHEI=;
        b=MO+1HGbRcWgtRJ27K2wPiH8M+BGPai1ogoLuikuZNRxIUoUUugPTzlePoAze+uv+OG
         VdQ+be154nQhTmXR98R42Yfm1rDD9zuI+ZiDOfNo3xJgxv0wZuoHqlsOmaYRJaeOfDXo
         +b854gLC1xIJ5knpUgplEPZGShVIkRcS4bVU4yRWJi48wcunX5eMAHVM+PKlwOPyBQvD
         11mWgi1kJy8hk9ueSHNepOZ+jYm1K8lwJtqzY7JlY2xVqgmnY2YHoIyCLExeTBCVZvbc
         bnQbjNq3bc4teIV5QpXy7xrT1wVTgK/HcUTQeqm59IhSBDVEKnZGJYJAkug49KA7nBeF
         LJEg==
X-Forwarded-Encrypted: i=1; AL+hErFFLaPXomUXM6YugMYUJlULwpNPtdz48rZjWetAo6btaIpNbkZUqyOAadmTDJbLP0LRr9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CPIYLLY0oGtJMg7i6LUWNEfUzEDxc4midSBULBOVYNqc9A/yq
	q/OWkc+DQmYdTusW1jT+Wll1JbtvPzWmqYUcJCjJXeDfCEdYOyItxA93eA0J9jGvIfBizUQbkwJ
	tY64n+C1c6qoH6DHiGg3+gN/e6DJ+V/g=
X-Gm-Gg: AYBFou1Xyn0BZfB6Q5GN+V3XjLmQrDQrCnIYaaPuggeVFfrQFA7tfQsBt9A87XAs3V9
	nNI01lDEu4Qc3d3DF9F3n5WLsZ8vrp0V6o5P5gJn+KGrxfd7ABotnWDuV3D64S3SLEOuro++vjd
	kdai5l0ED2HKdE+SXD/p6s2aeX3zSD6y7z+BqWhdBQG2Wp/LSHjYC1vl1XizPkCzG7yBKItKeK1
	mlw8aIH6WxFU7FMGcLh5ZA5gW7s6ldDY+VzV9TumE/EFQTKM0wC2jUho+zYf2CojggTJ928i0mA
	dtax/RdVy/aD+T3rLHtCmGI1quV7N8p72YjkEakB6j7C6rJlgksLpRUQHFGvaw5gApqabXLS+ol
	Lk5HIZF4y2E8XF2HpoBtDYyxMx+DSqolHQ4MdVPZ+0aILuCbo6F7EnXemNBB1LJP74ERj4HUMML
	v04uDpJSUbYlfCwiyIYOVwU2Wb+oaPEaaAB+hAJ8jli+uhv9mFzshBuKiWeSU7yw/ukUzmQ7Diy
	0Uf
X-Received: by 2002:a05:6402:4504:b0:6b5:7770:ce2d with SMTP id
 4fb4d7f45d1cf-6b887f21f0amr1932132a12.26.1795005776013; Wed, 18 Nov 2026
 04:42:56 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Wed, 18 Nov 2026 04:42:44 -0800
X-Gm-Features: AclHuK9CtLBvDfSZS8u-mbj4wWauHAFcNWfeQbnm5RFPnJDXGikoy7UxbQ7nZeE
Message-ID: <CAKSQd8XBwW1h9YCo0yhw1shKQyD+NdFZqN-0-55nEhJ+NMWJLw@mail.gmail.com>
Subject: Re: Re: [PATCH v8 12/20] KVM: x86: Support REX2-prefixed opcode decode
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Jim Mattson <jmattson@google.com>, pbonzini@redhat.com, seanjc@google.com, 
	kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	zhao1.liu@intel.com, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> Does hardware raise #UD on 0x48 0x66 0xD5, or does the intervening legac=
y
>> prefix nullify the REX prefix as in legacy encodings?
>
> Yes, it is nullified and this behavior should be preserved, I think. I
> was also able to verify this on an APX-prototyped system.
>
>> The text clearly permits 0x48 0x66 0xD5, since the REX prefix doesn't
>> *immediately* precede the REX2 prefix. The table is unclear.
>
> I'll pass this documentation feedback along to the relevant folks.

Fwiw, EVO processors have MSR control bits for this =E2=80=93
#UD vs not, REX/REX2 bits merged vs not, plus more.

--
C.
