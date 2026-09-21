Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512347AF6B
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033024; cv=pass; b=qdcEBUPeru6RddmLnwxxO/QpR6BLgJf9wjKMaAuE3zScjHpxEBRClqCpB4/2Pv3xoKl0ZzR1r5HMLjW9jvh2Pv3X3VtXlpwYsuMyesO2fthCt/h62sJQ9OVkSZSVIzkCk55JaC5YpDIoRXdygM77xhQ1jvfH4iZCTIR2etuDW1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033024; c=relaxed/simple;
	bh=r5QiXqCchrMFvJCvPkpRAqULLs7ZFYORWPkOWSHrFEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9rRsX5F+2KgFFekPBV0s1E+9DfBscVK+TFzTRJsouTfQGocMQUdjDa1MX9Q+2OK8PjrMW7fbBAq/mCtu3IioV1jNxbwP3MbL9jLbmfraRdLSABFQ4dl/KLyhPH7nC8AWE5m6yH4N4oknzMkncLqIJ7vRoamCnjwvQX+d3wkOBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJsaF3z9; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJsaF3z9"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c254f6c7a56so416613466b.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 16:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790033020; cv=none;
        d=google.com; s=arc-20260327;
        b=eGC8iszqPOidoplVES//q3SuvIqrlCTFkbcP0kiJfLyCxKar7iAAGAsgHpJkvPLZyy
         4TI8Mgep1CKHGy5HkyUMmkt5beyiI3quUzpClMxSkUaxnY+y4WtKgcxjcu2fUM9KFQYl
         yct7q2Tal0AyZ1AtOfPcf0Sl/cIYRqji0a4K8qyqJ1y8usS9mpV2b6jW4bmgGwCWuosk
         FzptbcYkWGONJ5XTBmx+qr7tlv5BxNfNiHuHVTVT5b1AJcFsIOOAjI5tY7v/HQa31tnI
         Xu6Mm8AC4Zq3vJAoxML2d0ICvc2vWyHFd5fTDijQd6KMOPU1+JXpVPvhGrUIlwVbXi0n
         IreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XzhMZejNm2OuVwr+sOWIYUKaW7eYVVaE8fuZkrcloXQ=;
        fh=5jFwovXV3uZqd97kGK7kVQAiFSk6eyTAY5CG9tnBkcc=;
        b=PMIkjqU8AtMJvYYo0vZgQ3TJhtCervCEnUIENXTDUBMloW9836G3aTqSjrGMgQOJiu
         eysK4YcQvmba56OD72rm1Ar9FekjMSoB5ycMvYUAJFUtBeVv18m0N0685TsY4JMIbOti
         ZeeSy5994d4NkWPO4E0QgnQh4FCdK5nXSVvnJs9lZRv94iVzYglDIjiG62KBsSg2ojrh
         /YF+jRaBkL2rXbmSNUBcAqoI5yKrBImON15F3/jDf+YKoaPNeFHxbHstjQP/kQySMSXK
         susC1bBpEmVr4HsBpbLEPpqQ/3Kn2vTTSs2oNXB98BiO/9ugs6UqDI51olSbwXVJyUtE
         WMHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790033020; x=1790637820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XzhMZejNm2OuVwr+sOWIYUKaW7eYVVaE8fuZkrcloXQ=;
        b=LJsaF3z9qmDPc76EGdkwArfBoOqODb+tC58zWWyORms8jSvx0aWty8rZQm9UtlQxef
         h51/3f3i/2c+tj147fYezJ2Jqc+lSS6UJyPNar6jwD3YrrGyALyTy219rnT5wNWnFkaq
         zS3GoHs4fo+It3hu4L8wW+RqUtx0IGsGstuFxV0uqyoGHMCXwj9KaaJOjo6gV8rq7wpY
         psSRoY4MyN4/gFVxhxg/ZDo5977pbAwIZKdYvSU39QIXLagRcWhH1PLl8Vf7K6FpgJ2N
         BgIe71+2/emYk+/QJqIOQ9h/wxQD4a/WFeR43yIYXJGMgdw2em9eY+Z0XhlSTUWUya0o
         HR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790033020; x=1790637820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XzhMZejNm2OuVwr+sOWIYUKaW7eYVVaE8fuZkrcloXQ=;
        b=kXv7b7cypwkPEYkR2OcM8q8aDR9h0do3SivZjspggCGtDt3keZbCbK9g/7AciVLJnD
         3Fx1x8IYlFxNs3/PqjbDq+GEMVvndYpwSrpDbYKAoHNm32+GQneBjBceCs/b0+2R01RI
         ps1rHkSZ/22dOcd0rEs+BFk6UtncD/cmeAXSj03ql9xEAyq1OM0cM4mhp1PZlzm8WsMb
         mY7aMFALIh7Tkcb6z4v05HBs9Oh19VL1WXuzT2PSHrYz43dtbUQ7rELkjkmvTQg5AaKY
         z8Xo/Bu+lklDsOV4yugQB5G9dix1GUJChZYcRKNYBByMqvJYt5HdezhOLvP07OqMPaFj
         ll4g==
X-Forwarded-Encrypted: i=1; AKwUvByWwReTa9pXwXiUqy3hJuTUPzA4xfvlb5xDd+XaXjL5S6WXaDW5uNJAhb6qhxrRAbkcwD0=@vger.kernel.org
X-Gm-Message-State: AFuF++nv5w3IIoKrMqWXUMXNfJz/YT6DBhfti4FMgq9U6jv+MU/uLMAn
	W9HmUv93eWIzhurrv1CiYVB+ko50otsUjxKCgs1J6YJMGHZvsGwf5+NB4f/NpLKNpMRGM/RYvWG
	5Ts64817ZUy3J6qDHp/dEzV/HDk4zNfE69bPZiruE
X-Gm-Gg: AYBFou2eGo+klFiNcDiFddGVPTSdcIR/DquO2Y9nLcuSGmBgc8lN0/hxZhEsWUMAoRo
	MuexiCr5qxmOWUK5EwAHtIK4hvqb+8iIpK479d6e2ShFvCv6a53yEt6+tykJjLdENtyLOhI3YWk
	SACi4fL0Aaz9jrne0qcq9Kq9KSQL2kP8o1Fc2BkZSmvdREHoQBiBvCDobLZPJNsqniboSvtXhRv
	fKTcC0XvCrGhKkCaJv4evQidtQCSewBPZb/kyIQG5ukPrWjovXt3pRFpJcyQSCcS92CNqTledtL
	LHoFRqig3jt4wetqCQCR4afKjeLZjrc9LmLOoOeIG6F9ilK12bqdwyNVvcu2WLxzosGeFpoTEis
	iUG1wfQV4BVsLtCeWf9AzsZ76kgGwrYPXquWJcJZ5EsRLGHCv8auKnrWSmbGjTqCwQKrqcghWUo
	YihWqNbZZy8fy/S6n6JjDcIMc=
X-Received: by 2002:a17:907:3ccc:b0:c26:1649:47b2 with SMTP id
 a640c23a62f3a-c2a15b8fc3fmr982971466b.40.1790033019478; Mon, 21 Sep 2026
 16:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918094322.152817-1-pbonzini@redhat.com> <arG1Nh2yuMQyAdhV@google.com>
 <CABgObfatLAp3AsPktQVtVq0MgeJV1Bw+54i5LKye5KzjVPqbyQ@mail.gmail.com>
 <arG3L3TL5_xCBtc9@google.com> <CABgObfZTbj7cSUdGEcA2xgGkSgFqZ2NnNrHJ7+uYAHP3_9idqg@mail.gmail.com>
 <arG5raFJQO0hA-Uz@google.com>
In-Reply-To: <arG5raFJQO0hA-Uz@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 21 Sep 2026 16:23:01 -0700
X-Gm-Features: AcwNN1WrtY-_nAjdTWchzxwWf21dZZ0mCHbeT76HDCZYCUnYfKxEQhEABcRdrp8
Message-ID: <CADrL8HWS3SLqGfj0CrHhODscUq3fPdKd6Mg1M_53BFdFh4eLvw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow
 SIGNAL_EVENT hypercall
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:11=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> +James for real this time.
>
> On Tue, Sep 22, 2026, Paolo Bonzini wrote:
> > On Tue, Sep 22, 2026 at 1:01=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > +James
> > >
> > > On Tue, Sep 22, 2026, Paolo Bonzini wrote:
> > > > (BTW, I would like to talk about memory attributes and kvm-userfaul=
t
> > > > next Wednesday... and whether those are two different things at all=
).
> > >
> > > By "next" Wednesday, do you mean the 23rd or the 30th?  I want to mak=
e sure James
> > > is pulled into the discussion as he know a lot more than I do with re=
spect to
> > > Google's use cases for KVM Userfault.
> >
> > Either is fine, of course 23rd is better if there are no other topics p=
lanned.
>
> James, how are you feeling about an early morning PUCK in the near future=
?

No problems here; the 23rd is fine. The only day I can't do in the
near-ish future is Oct 14. Thanks!
