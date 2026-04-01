Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406363C942D
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063857; cv=pass; b=FuqAubcd4HzvQItxOUF74mfGB6eG/AD6pOV2Rh8BONot9bNK+a99llz06OlbhESQnlG0JheqJBSl98NIH2ls9oyMxoO90VxReTLvU4I6+bMldNpOnjxmLoVG0rzGgMQ0DxJTsCIqmQqwennaDZcdSHwne0hRg1x5l8E6VMl82nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063857; c=relaxed/simple;
	bh=YLA8Bxr0qjhGeJBT1dfMNIXODC0ytUsNS8MvnzBHm54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUXTjibB5uDYZIUuCf0h9XZFi7sgRYBIa/8PqurgF1XdmzO9mddHLzdpwIa7AmhtwKH/lEStR0w+HmMd/WOISTxr7o6pzOtN0AlHnNaSzCV7oxUH5oOLVcRxXO6JHaMbUeXMD4vcvGuLq8WP9Ivn8q9l3mxIdkYwG1AzPPtAMMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/d58QtE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyMHXd9B; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/d58QtE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyMHXd9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775063855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guYSzBv4ZfXSiUmPyjqlFgw8GTvAEvrhowJxXPh2gBY=;
	b=E/d58QtEIlJYHg5u74n2vH3xDNVWMMkJQiyKZUpknH/pbm+DE49ompfWM1chrqs3k8qH+a
	6jZYH4MkydWbAlsSoo0iEEkfINDY0g7o9scOcemjUMufiRw+QShVPPhEj3ylwQncN9EywB
	OV7pmio+mB5Lh4I0KbdUafRqf8YYous=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-YaFmMRzbOuKr-tkw7ELLCA-1; Wed, 01 Apr 2026 13:17:34 -0400
X-MC-Unique: YaFmMRzbOuKr-tkw7ELLCA-1
X-Mimecast-MFC-AGG-ID: YaFmMRzbOuKr-tkw7ELLCA_1775063853
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cff5ef652so14924f8f.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 10:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775063853; cv=none;
        d=google.com; s=arc-20240605;
        b=fQ8JOF95qYYpQ2LHXMZGSmxEnPI4Ssa5oTRCX+mY1tCEMZxE3suZuxqXuL8eiAxp7n
         exR9iAT0MkaBEMx0xZqVtECt4lZA7FamNl0Kk/jP1VNcERJTyvYHhTgzv56f9d8N4nrG
         5dxRF/pVh/272Avyx7pagSLefW0WpPhAqaYBXQ+e1PBHeQ5ykmR9YoUwaPwNlxmP8w5K
         b7ZlGM8OdOULbnAjm3+rUGW3MWX1Re6FzIBr4xnlxT2Mtd5IC/HK346gQNFkpDloXEIW
         Zdaq0hea/W0kCUmCwvtPdwLetAzodjhz/UPipYE+oOhx0q3HdzrPk+EOE1cg9vnhcTJO
         GhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=guYSzBv4ZfXSiUmPyjqlFgw8GTvAEvrhowJxXPh2gBY=;
        fh=SUOYXOTADRtKHDJio2YsV2hO9PoO0gwcEiY3PDh7dWM=;
        b=TyRZxdrWczlajOp7hWr7Xzg5Q5Ymd4vWdATpPSlft5Dk38YJXScq/GaCd8BPQwsJYe
         OTZ6osYF7h3qTdrSrcXLMnROwHgDZE5lg9+cIvhJLoWon5vSKEntg1GCPKAotC95uVKW
         0ELFfjbYQuoBAsLU7geXpqq+nN271qnxpElYJGlUJQUd3s2KZDlq9H8wFwVDBH+mlHQH
         S6lcfaB7I1zZlBVLbO7C/LdUe/BRULkjhNcg4StqnIeqwZcmjCpcVrcTIJOsus032gP4
         sgy9f8O6ia+i092VO5ml0HQusBnl9JELKrI98XZY3nUEDS5HMfUiePpKnIbxOUkbM18d
         GxTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775063853; x=1775668653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guYSzBv4ZfXSiUmPyjqlFgw8GTvAEvrhowJxXPh2gBY=;
        b=GyMHXd9BXTHtGBZvInn8507/ZVtWc5+OAjpodmIFJJ9U8S91FBcwCVzFuM3yhCNSM8
         jQy7MrdmH29CaHRQ2g8E6wwGQaT6N538o4SaV/4Uq4+3kU5RaWh4juXb+yqkhe16nSUM
         sUozVy5CEf51sdq0YsTYhng2UCBLlkUNuFJbPuWZmvTxjD51W2GbIHNxxGyw/B2GtzPm
         ujHPThgU7SvkEXGPGzsci9hxMapAFjlrJveGYdDeUiiWdz35WC6hgkGu/l6M4bf2GyK6
         kIipJh/zSFFmVgjTtu+/v9CeekRkAqv6AoLbXIE0N5f7NbGl7gUVYWksBXL1wUvJlhCX
         AdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775063853; x=1775668653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guYSzBv4ZfXSiUmPyjqlFgw8GTvAEvrhowJxXPh2gBY=;
        b=mc8EDUziSj3Lk2nmEObxVyLINBl05gvB8qidpIREL00Wm3oFHgNY3vyMJ7q/EZjTHY
         yKBSWH01A/Sm7NeG+GKsCYlVHH28E1MyDpvLyRu8QrPAgLx214DCrmIvbq+xKiDxAeuf
         8Tvxjia5O7q9AxkvnMPu0X2ul5HSmUkSbLJnuwYeZxHqc3rP+XbltcWJ4dE0LfHUqPo+
         pwBmxmZspuUClblWV/p9qLBaNKFXlxwcfVOPahr7fNn4bayB43fXMIZSCgtDK3R48rq8
         aWoUZNXS/T7rgEmLOGLwGAWpVmgG4NNj7Cbx9bji5GKs02yccF3qkQ9ETTe5koh9YBY+
         5kmw==
X-Forwarded-Encrypted: i=1; AJvYcCUPGC3fWFkJnoYcUjdU/V7IXbfbYHeX3L2/2vkH2V+5WrK4aaQ0RUB+7cIi+sRoSVWciWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpG6b4TLfRMhnIhlPdBHiJR83Z9oHWJDba2WwS4d62Lg7Ve1T
	pgXr0V29TQyokgy6FI9FGsnvGRx3m1WhhH1LbPuo8sgyMsV9OEPnmJiOkgzjkRAJqoXf3rYjf1W
	p9sKyrJgT4qef0/if0M4iyoAVTdb2JHb8QxdK0hFhrXxGDP5M2M6yMPW7X5sxxT8MhQsCJgVxz3
	2qgw8ib36QPXGHJM8oMgLPv/QzNAex
X-Gm-Gg: ATEYQzyEU7NLs/mOgNoPJ6zR1HjfGsZknHaNnHrTVkq1TFGRVrB7fRgOlOoMsW7lLAC
	yJoA07ybQyAZn/3L6GO2v6V6/RU9VD98uI1uoFjmKPlAVgQcVediU79T5EZslhpt/XWom5LGab7
	/G2ULm6LCKdRtjFZ2vnsxLCKW9CPnZCGVt2x6ZBLKNLfdMSgFjK3hK7ciEZ4Xlf/Hh2NxqjVGd3
	pprUqLPzLYsM3o/SPlwcSSVPHwwkprsW13veEWwSlJDWorqvOl9CP7RDXFwgzPZ4mzUICPwyaL6
	VRGq
X-Received: by 2002:a05:6000:2586:b0:43d:30f:122c with SMTP id ffacd0b85a97d-43d1504d1f5mr8918895f8f.5.1775063852761;
        Wed, 01 Apr 2026 10:17:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2586:b0:43d:30f:122c with SMTP id
 ffacd0b85a97d-43d1504d1f5mr8918848f8f.5.1775063852343; Wed, 01 Apr 2026
 10:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
 <ac1OXbMbAY4snEPg@google.com>
In-Reply-To: <ac1OXbMbAY4snEPg@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 1 Apr 2026 19:17:21 +0200
X-Gm-Features: AQROBzA7J9iEyyUEEArbNfiwRRdKe1_iXF1bfQR4_kkhyOWkd834h_Vr9iUaSzg
Message-ID: <CABgObfZJV5hU_7WoPWLRH3-EvKts+UBZOwtCXmwVZYJP8dDo2A@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race
To: Sean Christopherson <seanjc@google.com>
Cc: =?UTF-8?B?7ZmN6ri464+Z?= <jeon1691951@gmail.com>, kvm@vger.kernel.org, 
	gregkh@linuxfoundation.org, yosryahmed@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 6:57=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> Eh, I wouldn't call this dangerous per se.  Problematic, sure, but AFAICT=
 the
> host is never at risk.  My official stance is that any panics due to KVM =
WARNs
> when running with panic_on_warn=3D1 are NOT considered KVM DoS issues.

Yes. More in general panic_on_warn=3D1 is only a good idea in two cases:
1) because there's a much bigger vulnerability that you know about and
can't patch, and you want to somehow mitigate it 2) because you
(relatively speaking) don't care about availability, which means that
treating WARNs as vulnerabilities is misleading.

If someone (like a distro or an Android vendor, I don't know) sets
panic_on_warn=3D1 without having evaluated (2), it's entirely on them.
(Please, no bickering about the definition of vulnerability. It's
perfectly possible for CNAs to describe configurations where reduced
definitions of vulnerability apply, and "the user asked for it" can be
one such configuration.)

> KVM WARNs are 100% worth fixing, especially if they're guest- and/or user=
-triggerable,
> but the WARNs themselves aren't security/DoS issues, because in my very s=
trong
> opinion, allowing use of /dev/kvm with panic_on_warn=3D1 when the platfor=
m owner
> cares about host uptime is user/admin error.

Yes.

> There are many, many nSVM issues that need to be fixed, many of which are=
 functional
> problems for well-behaved setups.  For me, those are by far the priority.=
  I also
> want to fix the a guest-triggerable WARN_ON_ONCE(), but it's not urgent, =
and not
> something I want to spend a lot of effort on with respect to providing an=
 LTS-friendly
> commit (though if we can get one cheaply, that'd be great).

Plus in the presence of large-scale refactorings and fixes over the
years presence of issues is hard to ascertain mechanically. Older LTS
versions won't even have struct vmcb_save_area_cached and may
incorrectly register as "not having this issue", while the actual
situation of nSVM there is much worse than top of tree.

And for the same reason backports can be hard to evaluate. Sure WARNs
tend to be of the "ok, I was overly conservative and didn't think of
these circumstances", which is on the easy side, but there is a reason
why KVM requested no stable autoselect.

Paolo

