Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA011CBA
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777607225; cv=pass; b=Gi4Fpuo73kRMrstPcjsf7o6Ko442pGhN9B35dzcN7+QFKGBXEF3snbLGkFg8Z++MO31j0NqP4WRIonP+z8hsx7UmpLZNpLmmSydRceSozb+3N4FERDwwWYX3mJ+rR2okpFPLPftW7WcjVaTpGKn/7MT8+ps5BWpsISVtaWANxJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777607225; c=relaxed/simple;
	bh=4OWpo6VaBFpeXh1oCTIM66xrw0oCx9lo7khd/wOSDZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O56TkhAskgatqygSm2uaByBlIhsLVS6w+SvH6XflfgDvqujeypZDPsZrl8MfZ4Iz3YBxXvHEzcwdEC7vEgQNyt5lxFH/Z+l5kMqi0LAMt4ggVaBdNUcDMW9m6BZf4taLSzy5rj7JSVz1EdAWlKdGr9H6e120YBOEk0uhTMnwdKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpbKonej; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sVgnnFIs; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpbKonej";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sVgnnFIs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777607223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVBZdlCz89eivV0S2EJ7M170Yj+NIquGdnZCXji9AXs=;
	b=QpbKonejnoSv7cKIEQ/KyupccMNVqp/lF2wrP2Xl70btrECNDAK/UxPTYnqiVMjcESnrhj
	TgEjSe/ljXf9NorAfjf+3+nXQJLx0ht3MLq1K6Nay6CYGlcMI5z+b6ZBCje78mEJVrmRTs
	XFDlMDjsYr+k+kvORO2lxZzMfYseDQc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-XSWKRaDDOj2XZRKVwGH7tQ-1; Thu, 30 Apr 2026 23:47:01 -0400
X-MC-Unique: XSWKRaDDOj2XZRKVwGH7tQ-1
X-Mimecast-MFC-AGG-ID: XSWKRaDDOj2XZRKVwGH7tQ_1777607220
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7757463eso1666978f8f.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607220; cv=none;
        d=google.com; s=arc-20240605;
        b=gMwi09R0p3fxtNcYVjpqgPiZ5Vp469z0v19btu5yodW1oOktkni48LrYfQr/ZaR8D5
         Iqhq/vXxqwYoRTovB3IsnXripaNoIiCB2a0eiHZtf92KVFFIsojbV7aNowJEPlFJJzMb
         zVdsi9F1v3ttxuvIA4jKuJhmP6esC6BI5LKqrh7yoPS1lqTo0suJfek3dAYQd54rgvS1
         d42yeDaLupNuWPcSUCmGPdhcMgyuS3yhqelNCwcAMP2kNKKKUqbmLziZVLOIoeWDgTRX
         bK4BQ/jZ5WQSKNbj7/ov1LI2sCk3wGkBce//sUdbo1gL6RJa5jxkc+wx1GlCQeZxaFwH
         vJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVBZdlCz89eivV0S2EJ7M170Yj+NIquGdnZCXji9AXs=;
        fh=7X+7xbsNv2UiFGT8RDNC6gsY0l78lrv8xSDbx53RSPY=;
        b=iY+hv3HiX4PC6YtpSpnASRVWc4/ljDWDcBxfAMUsiX1yWURFe1sCYxsoQO4Y9PDT/y
         xzvi4e9v+HmwPUd6yIStBukSfVjAHAZUvYMUp2GIdwjzLpDmrjtsxv2v5luEwxo++eo2
         4CkhNv/YQXeXH9LoQfbMV741lkg3yvP4yd9Ol8zCkHax9zejLzFCVaeQDHdfW/2ST4bD
         RTMfEudP/z0cRrDnhxOqd2werQZIZdFJVtWA2iPMXUQfUPXpj2P3Ywg8Eb1bUHEuR7uf
         9ESIlR/yLrw8CnluygyEeSYfvjKE8PlMcBeusV2ePepcZ9Zml1EQn4T7fRY3ZgzsAZxO
         irMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777607220; x=1778212020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVBZdlCz89eivV0S2EJ7M170Yj+NIquGdnZCXji9AXs=;
        b=sVgnnFIsLxnhvV/B0sCyVh5WweDnXBlDLgeEWQwkReVdvFIs373LwGOXaw+OTl5zKy
         Y8zZeG54p4JyeN8tIZ52FqpS0kg7LbNKt18tBFedKlzfqmKOnY2Ps5lDXLnJOjUkhBe3
         pWhdqRve5wH1QtX11LSjYu+yD5S0RFTLodYl/rGn57jOlObGq5p/o1EFWELbk573BvqH
         YKYN8+2zHhvVSzOEa/hhWksA+lpjCnFUjvGqQziNcvVzfpQGeA8u2K/vplu4l1KUGe9Q
         beCgX61gz54wlVJYT8yHk7p75+6a1GDZwqO4at+T1Qevi8zq5oVdoy4y9WGs7FA3AC1O
         zLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777607220; x=1778212020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVBZdlCz89eivV0S2EJ7M170Yj+NIquGdnZCXji9AXs=;
        b=RkDPr/eAix1FMyklf0RcJigSJZdtY0JkAxkn5T7zFFhCXR/PBuy/u9dOM17bxXUKD8
         3qKqyFwm5QuvF7lgnneDHmbEOQn/jrNvj6nHDyoo16YgTqu9v9Uv1Q5+tt377mejs9yp
         DlZ4DyOgVi5MDzfgv5vP+FniYRV+8bk7pDp5PFRR1xTBF9ztahbS30p6f6N/OBzAUzI6
         kq4GAj6PRNIP0LxKxFJfjwPnW0t1dQbhiYKVkrUcQRY5LuX+OIHweFMH8XcGrbAlPVLV
         4C5U6HGQyeXnMSI3aEyrY+pJ5H+w6W9byjeA/S7lpdIxxI0MiIX+vxKRTXHMrzc7XNle
         KUNA==
X-Forwarded-Encrypted: i=1; AFNElJ97+5UnWAGj5v3BRkaa05VP0UGqwKytzWwF3Nx9k3ASPxI+xzd2mYzHyeOzIWV/TqCUf6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/kSdSRmYGl6qrRmLWiU6pqzYzgtIothYHnKqXwCAT7g+WFXQ
	jcwqf2By4e34Sz5ayZFDDbD1HH1NDWi9OXVQbmtA8YiRhlFAGThm23DQplIDm8zq+6g5sRw0x/4
	OpXOIKViETGekOdScwyK5NgJlCw0uFWODAdZE+Xdd1hVb+2c/n0bnNp5H/7n34hQzKOO7aH0RE0
	JO7cpke5rZQ+j50tINWJEQZpNwtw7Y
X-Gm-Gg: AeBDies9zj/Fnijuccy7PTo5anoMyzRWbtM16OQX/Wl6O904FUrT8Go/mnJEVVoeB6R
	WcL648x1ZarjxWuXCYt0iV5G3+4EC/Fhpptu334wRawU3yEQh+xLLGQ6tkebZ+pGGlDhF90D352
	RWXue5wT8PlwD1fDUdBezZKu7sQvvZoXdv9pWqlldOJalCffPuotQpEIQd7SfoO7bUhWiQcpo15
	GRNRkmkhzNjiRuqXS2HRONi3+drkkmbEGbRZM7fmiXXm/gNrNIC6QuAW0pB8qQsN32Yx5Z57+C7
	N4/23vo94GYHko0=
X-Received: by 2002:a05:6000:4558:b0:441:30d8:f023 with SMTP id ffacd0b85a97d-4494dc52af2mr5337987f8f.6.1777607220193;
        Thu, 30 Apr 2026 20:47:00 -0700 (PDT)
X-Received: by 2002:a05:6000:4558:b0:441:30d8:f023 with SMTP id
 ffacd0b85a97d-4494dc52af2mr5337981f8f.6.1777607219886; Thu, 30 Apr 2026
 20:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <7b4dc292-a2e2-4d42-9e4a-bb1fe37a9013@redhat.com>
 <afOqrUcq6Hi7DuaA@google.com>
In-Reply-To: <afOqrUcq6Hi7DuaA@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 1 May 2026 05:46:48 +0200
X-Gm-Features: AVHnY4KXr64Aoxg-_vK3KXl2jWWLPyCumONYK3JzZ3D2HiExCK-iI3UN4xlFoww
Message-ID: <CABgObfYwuYRk7U9aqYKpLC3tCL+Ks0UwN94FaARPGjKv1tiW=g@mail.gmail.com>
Subject: Re: [PATCH v5 00/28] KVM: combined patchset for MBEC/GMET support
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:17=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> > On 4/30/26 17:07, Paolo Bonzini wrote:
> > > I will once more send you to v3 (https://lore.kernel.org/kvm/20260408=
154217.458420-1-pbonzini@redhat.com/)
> > > for the description of the series.
> > >
> > > v4 incorrectly rebased onto 7.1 KVM and broke the case where L1 disab=
les
> > > NPT.  On top of that I made a few final touches on the patch split, a=
nd
> > > opted to use the XU bit unconditionally in the MMU even if MBEC is di=
sabled.
> > > This is more consistent with the idea of reducing as much as possible
> > > the differences between mbec=3D0 and mbec=3D1 modes.
> >
> > I placed this also at branch kvm-mbec of
> > https://git.kernel.org/pub/scm/virt/kvm/kvm.git.
>
> A decent number of nits, but nothing that truly necessitates a respin or =
rewriting
> of history.  I don't have a strong preference between doing fixups versus=
 cleanups
> on top.

I'll definitely do fixups.

Paolo

