Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7653D890C
	for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088409; cv=pass; b=RZRfKGceGMOuBRD0797pN75zLbH/rHbwStbdRxMc2/PM4fQBlF5nNvT9mwFGZgjjDSZaGHZrCJkCUzKrTV/7R6YslMUuRZwVAvjkSthb2duJubTv07mTv9rrjxjyAsZ/vWq7ZHrVDCdc8i80UZRFn7z30B7qW79pK1lnErhTfwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088409; c=relaxed/simple;
	bh=B18H+yF/nk5BYRxpPwrPE1ER1rQtHvufZyUjNFJO29s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRPZhf1DGHM7kr5KhFvSiIMR7oIb39b28u68LTKxFuB1I0QeBBrh9d59HHkvaB0XXxcoI232WSOTPtLQhFaDQemRDj8NpjWkpBJobdfznxHOGzCo2Lkt5K3iuQdi7RQ9IVBqGlYLCw2YtOLQdmzJcc1d2pEuVHaPropz/fKqbBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxqMC+IQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDvoPM0f; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxqMC+IQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDvoPM0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785088402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIi4J1lETdJXnYiMKEJJBoPZhci+fIKHPnY2NG53otA=;
	b=QxqMC+IQfp9WXtshhSehozTDaBSV5bfPBTssJ1QKfG6W0N3OtUnH1P2cbWl4hJdunUaDLH
	NWGqZQqrsl4tdghBIzvUMEGLurYsXMEMJ6DiyE6WJ7FoHxUvglBZyrxwXahHO+aH3Ct/Yf
	IeoDpOU0Koi6yC5O8895dHKcp9Hs5pw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-eacwA_GMPcSXf-jl5FYxBw-1; Sun, 26 Jul 2026 13:53:18 -0400
X-MC-Unique: eacwA_GMPcSXf-jl5FYxBw-1
X-Mimecast-MFC-AGG-ID: eacwA_GMPcSXf-jl5FYxBw_1785088398
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486ffba174so3219369b3a.1
        for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 10:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785088398; cv=none;
        d=google.com; s=arc-20260327;
        b=Ot+c0zHHDpymrWnt+Ns/fZt+ylqX2TbZFYMHiAuZcWQAyie/9UI4Ooq4MdlBZpZMS6
         QRZKwtw9YquW4brBf1H6e+aBvOw56pE58Y6fOk9HN3rXzre4dooQuUN7eFEOHHnJhwoE
         /zFfMfpxwz01W9PnXzF9D6XbhHBTs73w+OMq1XgpDMzcjANx54lt+FxfEbZBaNJ2V7zj
         1FsXmcyuGcbmsxjLjzhXBnqjjxs9w5hyOXwLFEHcMI1Vak/WtUuBQEHQctcaETJvYWhW
         1vpOqjIuLHpHQZaC67vcHBkJM8+jgsavkYQ1PbpCQ1lBJP8SqulSOWjs1pCi9ihZ5Txw
         wnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jIi4J1lETdJXnYiMKEJJBoPZhci+fIKHPnY2NG53otA=;
        fh=DkofCbZTPBdIKnhHHwocGvtoJqgYu16sB9aB6qR5JZc=;
        b=Q8sT8XmSaZZ1icKuQFSpZsOXy+LM9c/w+0Eh4BUu3jZvprXZahrzVjtHQndrXblNoO
         +ZDS9zEgj/35kqHPHq3sXUPT8a1ykpH2REL6MTD4wK/It6aVRpK8MoLRYb/yZhk8Zi5k
         BpM5BGh7KafCuFKABvGtETRKcleFebLbPVcN3NBGelkLilRXZadU9tw5u4Gsf2juRITz
         jUDAoO3Z72wsmO5z7dyBANqGD1zbCkaRgGcR2ODTPILJVGKBI19rK34/ui3dGvZ23vv3
         S/ty/WQXU4EsnRWcz3aoUERGF6M5DWni2+DujICIZRWErgYkSjkKoUst/uWuMh8jYAnJ
         iH/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785088398; x=1785693198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jIi4J1lETdJXnYiMKEJJBoPZhci+fIKHPnY2NG53otA=;
        b=TDvoPM0fOYv1uFmFui1vOqnIsx88JLifKBY9rQqnpw+MobLye5uUA2BMVdMdQO17Cy
         Oa4VKTfNK6Oki0D491nyL3Izn2sOChzU28ZBCba6BqZYDL87n+8rI75lBgEb3lIANVuR
         5JiNf/m54eRn7+qaam2Xl61Rk3bhcZG+NVUPGGcMhYAtvfiriq9wDhoSU1LLfPs5tbBg
         7fFydMpSZ6ASPch6Z7Udv62Qj8tkCFe/14AVp3zpz6RQfrtjy1i1oWPKeBTDMrmvbxGg
         ymgTXESSkeUjuC1c24gvWOwL07SI5lnyb8RRaPwb/tZrcLoQjmoJY4CsNNuMzeHGeX6T
         baoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785088398; x=1785693198;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIi4J1lETdJXnYiMKEJJBoPZhci+fIKHPnY2NG53otA=;
        b=hBJdpFaKGxnZzKSupjR8b4Fk/9baR/z/NOBZU+9WftmM5aFUZbvbp6S92SpIDZr9Gm
         rsejAsCUsyMvveW1fYC+GFGzpWgKhp1Vfp5zLURnrv3h6OfCM+u69wde0uJX5MH2lnCQ
         JS5+01vLcONqB2bR0hCqjwKh3gE8VStnzloX0GotRmK6CcFG0r6hDi4cLZheHsNxlyIf
         CuGmeiqR3xuwFYhm2fHogLVvxqVn25gMxzkaK8Ss2iUGW4f7d7BAE1k04aEEJ2gN13QE
         +fLMFqFyUtL8ATbx+EUjQ8huEgjlf2vgJSE74M4IKVXp2WHzOL0h5rwfjAl4flny6i3p
         UQ3A==
X-Forwarded-Encrypted: i=1; AHgh+RpQdbl89nSIdelaNHJd4nLVmSP4WVAUuokuIuZHUYvDcjgElTQn1ZlY66ibg0BNYDCIuAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAO+RpESZydSe0vHbf0Ba7yoWSFwnPT0Kgm8tsQGmcZIhrvcw
	BacJH0Nj5q8iouNoFa652Tl6MViCpQwsmnAowqUTcZfA3LIdTBaGbofV9/wK3qebI1zFUJTBS5c
	zaPiXP/vYbzwo+1bBudLyR7eFAbuz576knaaQNndE8VMfMoSkvQMjdiUCIgpk4Lq9/JTdc/IByw
	iZHobJymIl84x+CGXHfT/pp2X7PLBx4fWEa2kY
X-Gm-Gg: AR+sD11/iGEh3qrST3EcCE5aqQdW+QfrxeA82APuJ8Ygx2TdafrCrWi1sZKYT4ra4Ut
	EVHhYEVfya/vt4WVgYEvr+T+qXZKJnlfadiiEIhRaMz1NaUnr9a23ir9nWoORGvuZzj4IQlmYNO
	53giy25HBMuNilUkEBWrbRPA1lvkJN3mE7AnLtqUpbMq9A/UAbbMLZ7R/LTyRgugfIooinmHcrD
	9+PdLCKfXzpI+ECaKDClOaAcKLQueDYlrDXxjk4kSUx14TtMhVKvyG8Pf52ewt4BiDOU37yj+GG
	cw==
X-Received: by 2002:a05:6a00:99e:b0:847:7ece:3426 with SMTP id d2e1a72fcca58-84e595b6f99mr4490078b3a.58.1785088397756;
        Sun, 26 Jul 2026 10:53:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:99e:b0:847:7ece:3426 with SMTP id
 d2e1a72fcca58-84e595b6f99mr4490059b3a.58.1785088397248; Sun, 26 Jul 2026
 10:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com> <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
 <f83491f5-6ef7-45ba-bb84-26341835cb25@tls.msk.ru> <CAMxuvaxUWc=Qr9pQQ6wW6XnAzp4mf77aYpcFuXvret1KL_W9kA@mail.gmail.com>
 <0b2bf915-d2d5-4a21-8ee1-d11427476d40@tls.msk.ru>
In-Reply-To: <0b2bf915-d2d5-4a21-8ee1-d11427476d40@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 26 Jul 2026 21:53:05 +0400
X-Gm-Features: AUfX_mzdyOTg7oGlxIx6xGY_PtSWre_pu099X_1m5CsN4Ftnt1xnlq8cov7GDHA
Message-ID: <CAMxuvaxU3HJwkyvD0WtifFCMfcivNiUTK4U9Yg0j7cpc5LXLaw@mail.gmail.com>
Subject: Re: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Jul 26, 2026 at 9:14=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 7/26/26 20:07, Marc-Andr=C3=A9 Lureau wrote:
> ...>> Unfortunately this (additional) fix does not mention the
> >> previous fix, so there's some confusion about which commit
> >> actually fixed this issue.  It looks like the first fix was
> >> incomplete and this additional fix were needed.
> >
> > That's correct, we reused the same CVE
> >
> > Daniel P. Berrang=C3=A9 said on the issue:
> > We didn't release master yet. As long as we also didn't release any
> > stable branches that claimed to fix it, we could re-use it IMHO.
>
> Heh.  This is exactly what actually happened - there were
> 2 stable releases on Jun-25 (v10.0.11 and v11.0.2) which
> contained the first half.  Now there are 2 more stable
> releases from Jul-24 which contains the second half.
>
> Unfortunately I haven't noticed this duplicated CVE#,
> or else I'd add a note to the second half in the stable
> pick-ups.
>
> I know you don't like me rushing things to the stable
> series, and this is an example why this might be bad.
> Fortunately this is not a regression, at least.  And
> usually security fixes come in faster anyway.  Ohwell..
> I'm sorry to disappoint you further.

for the record, I do appreciate your work, and I make mistake too :)
Next time I'll check if a release was made already with the CVE#

