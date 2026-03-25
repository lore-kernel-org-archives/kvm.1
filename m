Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CB351C38
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430960; cv=pass; b=YApAZkSLZfFZCNnaXhyJw8D165diUeJKGL1L4Jj1g488YetjcMXZEwE5Jtad+k5kjJxrPD7AvWhm804TG/zz7NKbmNORfy15vVQnZOhLB1wyMWQtxH+ddliMqIYDLEtMT+9aGkvaNYjP39tbDjX0q/qOjSyj3ug3yxwPU+pkG6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430960; c=relaxed/simple;
	bh=3MaiwrUL8OyMmMiiuBDOCXKtNHOfHHGQdbhboldHDDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFkW2/IeA5aPqHCI9kaPp4ztpvKIaS6UV2+IGtdGuMbtBzS0r4gdlmf6S0A3Syzsvf/a0Y7QJEtpnfGtvHx8nejWMoiZzDfdrgfuvgCyGnWXRPRk6QJPien5cn6+xmlPCZnAbVwOB39O3ezQMfwfWwUE2BcM3d+x2ivXkTvQ8NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGo7GCtS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ay+Npd72; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGo7GCtS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ay+Npd72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774430957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPJ9mYAyImPC1rxY/xdbUPaYl4ORZ5nuhtNznxaYiMg=;
	b=WGo7GCtS9nX7CHygTYJaaZv6rhZQLDyYM7W+J/uHPV2LydG+ph6Kt79YvIn+il6Wc4+t+o
	SOPBqxWkyWKTVg0WekVEDQbLkKTexEe6jaigj+vi+CsCIf+VtwSLSj/g/mCzYl7VfhtDQt
	Jevu9Wj8GW76LyjJ3YgrHui2PA3njnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-xyUL-rCGPoOAFkNb3tC6FA-1; Wed, 25 Mar 2026 05:29:15 -0400
X-MC-Unique: xyUL-rCGPoOAFkNb3tC6FA-1
X-Mimecast-MFC-AGG-ID: xyUL-rCGPoOAFkNb3tC6FA_1774430954
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b4085da48so2161101f8f.2
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 02:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774430954; cv=none;
        d=google.com; s=arc-20240605;
        b=L98bPfHj1lnsn1vdtyYDtXoBOPvXJklvtBfRUNXl2ua7H6WOI/RMbdXz5LBj1hLvdO
         6ts9iAzbE+sEIxoWYl3PMMOcOaTfjYXEdLQCGRQEqLHCZwdBtKSyqGU8WAdyX20Id6Ep
         PPiayMycE4X/PgFN9qi3K2oqXiUEBdFmnAglM+FbYC4jS1UyW78uVfD1AQDNX/IF4MU5
         tuWArE7Peccd07X2XudT7iSbylxBrSWugboXyVbSrgccqBfeTWUu1BpvBZr89wYmseOM
         HuI+RdYxVFtlaJRgqrUZoh+Cj+zscRvV+9kQrDHJqBirAwgUKPJhHruKDrhPAI+a/mdY
         A/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xPJ9mYAyImPC1rxY/xdbUPaYl4ORZ5nuhtNznxaYiMg=;
        fh=2Z8CQlCsJnpdEX7tErd6CINYf3Kh1hr7MssJPFEXabk=;
        b=PQ4DduCje83BfXzUJyoeEMIhB2K68TUYzLwvK7LAKR6y1N2zauqFQ8iIPcvj2wmcnA
         Bvxu0D7ykfusj2vAJakqfAPkDZnil/7jr3kFKBgKJCnjJk9VxBLL1rmbx9Jr5Kl060cR
         HsWIGcFfwYWLfYNpEbwQTHlDOaYIHt7LUZs65aGXGqvWr4BX13KvAwS0qgHttPxChfzo
         mnBB+6mu9qf0QGpMAkPPsD57A0DfeQ0En9+TBbN1WfZAB1E+oMX2+IWG4d5d1W/UQn68
         mYMboWIzhYPCn1bRdYMIBBL0noBMxHiDywGIOkZ7DSL13KjyOJSiFMfgFoD7PAz8axRS
         Byow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774430954; x=1775035754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPJ9mYAyImPC1rxY/xdbUPaYl4ORZ5nuhtNznxaYiMg=;
        b=Ay+Npd72sUADmVxJRDwXoZEom5Gv4ikH+tVpEfZynrP+U/EnOhPSon80Kkrhcq8MKe
         cZ9laa4pUt6GD24mKothTMfmGj37+UrPZL4YNjcfOzYLjaS6ud1t9hEidToOYcu3f67h
         C1uFjET69Msn6EiyCfLwjhDC6YB8j+laQjcwKnofRAsPCtOicbD7gQZJx0yi7wVfrX1r
         s47LA9kD+cjs9d+x22sywnLEwkQMaJkBwHU7szrLlOiVdL+ccKhuOGsyiVkMgZLcUMkn
         c+Owf0SmfrLz4Zo/uPczJkiK74lTRW5onQ7aV41s8//U5IUZzj1jr91PBD3gsTZhm4wp
         EFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774430954; x=1775035754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPJ9mYAyImPC1rxY/xdbUPaYl4ORZ5nuhtNznxaYiMg=;
        b=QMrtI78ZcU43Et8XXoSzxWgUqH7hXq+8ubCst2ubrMOKp9UIzPft726mGPJ4TzvL+O
         C/1+o4Uh+UrlRO1eIblCM+lHV/ZTC7boXpNRLYVXE9Nc/Dz/J95IviA7C6TeziFUPhAa
         ZFlj+p1E7YVEsXw4exBjr39SK/Q8tEukBLQ+Jfsv6iFvTP/+rtxp9ao5sC9kkvmO6Xwq
         SK4P26KtdT12UYjvpbXL3gCJlVl9bUj6mFD8OBD9Lgx2wdjN5+7FTPTTKmP1yUAt8z4H
         SMvyR9068nv9oBzSnyZYACoUheYf69qHLxjK3GPQ+bFQYg64je6okHmkTxyDCGy3J6Yn
         C8ng==
X-Forwarded-Encrypted: i=1; AJvYcCV6jr6YTTaeEjQm9JxvSl0vdU87ifXV/L0RJz3NztTjY9B5VpoehVO3VKDjXop6OJ67AWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlPuGjB1NtvCyOAkeh2P99+UhvgDL8z2WtY0V1BFHDKJFDHdm
	AlDdyC6+klooP+XCOXgzmyytF7DWwkLtKA86oT769W8rcCMcSVjA2SOuOcpQWOh20noGiGteE/j
	Q8aaO1SkzKW+89ruDkop+warkuccPjlzV0NESW2fblCPw0ZNhRnHevpw+pbmkP/wY7MdHwz9umM
	V9XCWQr+pH+HpqBAIzRVueP8HPS+G0
X-Gm-Gg: ATEYQzxmhuxJeAzNQQ75GlP79Rc/4hHBvHNNLtz59QeNAg85qD8CJYmjbWQDLjgOkO6
	WwVG3Z3G1QBW0nt1ky0ph9gdqfK6wiegAUH26wh2NysrwTe78RVLEz6syUUYCc6zwf2b/J5PhgC
	JppW1fKrGidw0S+TjkDt6sxAuUhu51741O6pgAh0qO2WQGQ682wHCL4GV4NTwDImPFwm3Yzsmvc
	eX9cDCDhPLQ+8hTQcwMYIaVaS+xm9sMuuFZxiSNheJabf4yjgI+15eSeTpyKCYU7qxmQ9WLwSIh
	vB/b
X-Received: by 2002:a5d:5d07:0:b0:439:b652:af34 with SMTP id ffacd0b85a97d-43b887f32cfmr3560929f8f.0.1774430954267;
        Wed, 25 Mar 2026 02:29:14 -0700 (PDT)
X-Received: by 2002:a5d:5d07:0:b0:439:b652:af34 with SMTP id
 ffacd0b85a97d-43b887f32cfmr3560902f8f.0.1774430953824; Wed, 25 Mar 2026
 02:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321000931.1947084-1-pbonzini@redhat.com> <20260321000931.1947084-21-pbonzini@redhat.com>
 <ca466041-18e6-4935-aa0e-8c1501e120df@amd.com>
In-Reply-To: <ca466041-18e6-4935-aa0e-8c1501e120df@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 25 Mar 2026 10:29:01 +0100
X-Gm-Features: AQROBzDK8pVXaErvp8r8RjDHSSvZs8ESQZDJ2HzL5jhwqrHbZT2EN_ZASEm4rP8
Message-ID: <CABgObfYL5T1K6VUQPjor+G-GjOoKGaGS6rcX0wriOa27ipG51w@mail.gmail.com>
Subject: Re: [PATCH 20/22] KVM: SVM: enable GMET and set it in MMU role
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>, Amit Shah <amit.shah@amd.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:26=E2=80=AFAM Nikunj A. Dadhania <nikunj@amd.com=
> wrote:
>
>
>
> On 3/21/2026 5:39 AM, Paolo Bonzini wrote:
> > @@ -1184,6 +1187,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
> >               save->g_pat =3D vcpu->arch.pat;
> >               save->cr3 =3D 0;
> >       }
> > +
> > + if (gmet_enabled)
>
> if (gmet_enabled && guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))

No, this is the non-nested case (vmcb01) and I'm enabling GMET on
purpose for easier testing.

guest_cpu_cap_has(GMET) only matters for nested guests and is added by patc=
h 22:

        vmcb02->control.nested_ctl &=3D ~SVM_NESTED_CTL_GMET_ENABLE;
        if (guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
             vmcb02->control.nested_ctl |=3D
                 (svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE);

Paolo

