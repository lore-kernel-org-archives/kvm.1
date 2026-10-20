Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487565;
	b=q06M+n58VBYFR/mKgReQx6f0oaFeg8XsnZtlV2AuZqxGka9lXwd/+t5AXdwQZSlYL8Kk
	 RRrKqhMl59xiuJnDcf6YWDJntfQrZanO9WjFq1bghJ2IH+lysAHUlK6lEvNGCYClkxTyY
	 UeDuaTjPV4+i6WI6GL0pxH8CfSxszz1eRTBCfNZCcu4Q0YyIZYq3d0g+xiKTLLCcQ5gNN
	 9usKhV97QoIEclCiEN5LkdUvqPuSLA+o50zqvzr+cwKcvlLhJY1Fpi+2okUnAX0kUHl7v
	 fI860OXNULxAfcgvZ2injo7o2hdxb5CXFgkhb/+yPXzQtLmx50j5xvDarUS1tdCUoyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487565;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ws/nAel3gKigB9xjBOx8xYnJzYDjiCbjwmjPbmNoQBg=;
	b=RNAbiEfbuhN+vEkhr2lMGhta26hpLyqsG8m2q8R4vUGcL5Q14JOLjyJEitI7Scsy3ZUu
	 wjPk+9kPjVuq6GzHcNA+WNFRmpRBE2oUJft63VcRYJbFQxoT9gJT66Q+ICSOQDImjCLbd
	 LShp+B6yzPJfBC72MRKiTF43NRdfWEVuO286qbGaP0ypP3dRrFh032/yBZU7H3+rsPd9C
	 DfRLISlrHLvHGuAnvN3R1t1yzfJwefCNhJPhLnvVpXvYJYTD3Dm9+xB7+HzHJp3+5UAU8
	 R85auzHsiDnoKsFF1hgJO7dUQvTy0byOTPeo+fA+hymCgxdA5wJ3QVXFKUjj8u14itw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c1Ae35cs;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RjpmwlSO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A92606A31D
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 09:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84A92606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c1Ae35cs;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RjpmwlSO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792487563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ws/nAel3gKigB9xjBOx8xYnJzYDjiCbjwmjPbmNoQBg=;
	b=c1Ae35cs1ZYbh5DhIE+oo1+/+GRPUGxlpM9P04Swkwpk91/cIHfoN7vytXTqtBZtH3wctR
	D3YcA3ptXG/aUbNv67T+BWsKELGp5v+bomoes4lGfCYltw4zNfglG5S+V7zwpmNpl7QGXr
	u24JSWuKhZr+GivcUK/Fik5r+JYEkkU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-ULXG70HrM7ObBOoR81iqDw-1; Tue, 20 Oct 2026 09:12:42 +0000
X-MC-Unique: ULXG70HrM7ObBOoR81iqDw-1
X-Mimecast-MFC-AGG-ID: ULXG70HrM7ObBOoR81iqDw_1792487561
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e011829easo2114945f8f.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 02:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792487561; cv=none;
        d=google.com; s=arc-20260327;
        b=PVPmjiisYFNKn8d9cvYNAlZcz7giJleZjHd96Pxm6wIV6JRxCYmTh/FGdGqKs1Rczd
         4jMi1gU18VeSzSpqzomuznn8D816EcJNSWnMdf1xMxH8z+2V6M7KR5eH4iUjFkFBSWiz
         LyBTCsEDooPbnsJScbwcViKWaQFNK9Srv23dxB7jQFouFZAZtArS4f9cVIjj+vA3WRcJ
         5VL6lj5G/4r6kkS6nin91FqwNEQqCgVadMIH+Et4Sc+Ep/LR7iYG0SoggY5HbGK4GsQU
         rmO0w4dYoQrafEVPM1wOcmbx94ObgvOJropbaqElL1PQFPWxay80jjf+lUk8vdEuItGw
         sh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ws/nAel3gKigB9xjBOx8xYnJzYDjiCbjwmjPbmNoQBg=;
        fh=nhO4VgwCbXbiw3OoOlKC8vtg56yl62MJw7cxf534pU4=;
        b=qhSt8L915SVuetFYx+nLjmzahbXH3bJ/X8xB2VYg0ttO1xL+lCBxSKLe6uT9JvUcrS
         4DJZyFmQLiZ4rXNqTh4zWPbHIFECw/xg4C8Aj/CBM84A3dwnTwCeL8Z1R3rSOYyf6c2G
         0/libT8L6MvNrz08wC4PbeaVf6hgDu6JS3DZSILEDHOQgrb9BRu/QyerjJxUHQiavyZ+
         WwxO2f/oV+XJcoUrNaZL963F3pMQTiMIgLH2EHZHl6RA9HRHKeSdQQuRl17lRzDptLd7
         PgONmr+cRakp//9Mx7MaoX00/ZsVHi4wd1G9Ytq/SfsOBzzp7dhjp/iQ/czImx147kln
         PSIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792487561; x=1793092361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ws/nAel3gKigB9xjBOx8xYnJzYDjiCbjwmjPbmNoQBg=;
        b=RjpmwlSO5deu6v74SbJFeC+/cs6rPQCcxOwX+77f1JeZA9FUx7TmEOYQ3GWV2/O1Ar
         ENJBEE4VhEMJgncIoI36mOfKZbYA6rnhiIynRSOn67MKm3rM3wl59yZPG1KOmRxbQfPo
         HmzNRMfIpvTnVxFcFENkgTTdMbNuTO4fRgeehP/p0DX8LwrUvzLLBWZwfw5soBpBs+pY
         3qSiD1P5XYAVD4zmRr9S0NylvmdMIsLf7QGVh4VfSENaDj2ZtfPJks1YFfHT2I+dkWH+
         8/EWntvDVjHooscn5wxLkMcLJ98hgkIVS5Zes3TWBqgsRobUmDmfNmWb0b/18vmYcsd2
         wNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792487561; x=1793092361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ws/nAel3gKigB9xjBOx8xYnJzYDjiCbjwmjPbmNoQBg=;
        b=M2uRgD8OyflY2aSb5D2nGPTCcYLqlp4s1/eT7WXEQmI847LwlTP0MIIqTr39I+uW7F
         /6o67VE/+ZOUY7kN/oLfQkPUCekRIUZJx6prsX6CSnfVuBgZdribPN2K1dpnoZq2HraD
         e4qzqSVIZ/NklWJ8V9fmmefiq+ibGtYPU546/4lnmF5YRJ8y8OthT0DXqKC94k4QneGR
         zNyK/aj00rF8ja09WrS1MxuwdqUhAtOfd9AytNjI+qTcEbHBRewzZGcW086QsAwi7GRq
         zA7BIbqZvuL1Lmen5PCK3K/OCXI0PCK61G01Y//H7ybXXXSrhnHdEF81wY1Vyw4k2rUA
         8bEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyjQ+Z0oqZXU5kX6Xa1VZNJ+6oiO54v3RgFIpQojPXV+wHAAdKwmFwG/zqF8IwOEuj+rw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyfZeL47YdvtMhnbLFRnm9qDwmjaTxKqBuIPvWGhsu3GLYwSn1
	amoJlHgmqcSkZBj0SdvEazG4/BCgx1jh4aBQ6cAxgTCMXLAaPXMALSzUmEMXxUEidya6joZ5AKs
	mmnCwWVkB0Icf7tD8i19R9BQ0EHDBwtdB2Yr8+hAQdVuob0u8ZMXWxayzxtZuymTEgVXGJZgXbw
	1J1RvdY74SZzN+OINoXzy7ozfpedQc
X-Gm-Gg: AYBFou3ogyGlZUlDncn9e8Y2NU4nPoN8trrBPVkJwR0rr6KyeeW8muYIl8DJvGzleoo
	TJaplqDV4LpSXAH0ytwLX7vLw22EnekH+TN2dQpH++PNztaU33Wh00zGzwUt3F6folzDywr0Xec
	t4vXmLeB4gWaHNp0zbRwQkUlB6Y3or8wTSR/LNbXjv0g+9CVxV9izOW4h9+g4Xcqitlpn7DxmVy
	Tiuiu1yVgrYVU+kxCU0diB2c9ATl0HxFywoC667sq9+3URTHr4na6Aiz6SwUQ==
X-Received: by 2002:adf:e6c4:0:b0:48a:fe3b:64b7 with SMTP id ffacd0b85a97d-48e07fbbd81mr15612500f8f.53.1792487561008;
        Tue, 20 Oct 2026 02:12:41 -0700 (PDT)
X-Received: by 2002:adf:e6c4:0:b0:48a:fe3b:64b7 with SMTP id
 ffacd0b85a97d-48e07fbbd81mr15612464f8f.53.1792487560497; Tue, 20 Oct 2026
 02:12:40 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atZJV1B79VsZoy8u@sirena.co.uk> <CABgObfYRYCrOj-rHDaDd3LSFMSd0ug-YoB2pD7jDA8ZgMR0sCA@mail.gmail.com>
 <86wlrczvyl.wl-maz@kernel.org>
In-Reply-To: <86wlrczvyl.wl-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Oct 2026 11:12:28 +0200
X-Gm-Features: AclHuK-CANssAdVajcJL7_fA2sG8dYMTVFsVqplrwOo8ywfc31IgZ0Xj8SjnqCI
Message-ID: <CABgObfboCa74iJg7SgGqP1emsETwd-oSZG57p9XARYv89tdScQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the kvm tree
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Oliver Upton <oupton@kernel.org>, KVM <kvm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:13=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
> > Hi Marc/Oliver, is this something that will be fixed on your side by re=
basing?
>
> Yes. As soon as you have a stable tag on your side, I'll remerge the
> fix branches on that, and all will be forgiven.

I have pushed both the next branch and tags/for-linus to kvm.git, so
you can go ahead.

Paolo

