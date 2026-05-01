Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8233CAE65
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646336; cv=none; b=hdAO1ImVHmEgBKaH31vnB2nxRIfztUp2RDNt9cqMC1F5mN7JkzCVddNd19l78jqggp1bxm1GWllEXh1KOb1yHjuG2faDkck746g7v/PYgkZ8DJX3GrrOTCgpu5way5fO3AorIQoEnjASNr2au4kuPtS7P7fcp4Ww9w8+54lIVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646336; c=relaxed/simple;
	bh=Z+IuMEI+mjsG+X87wysF0aQRS0jmq1mcpBw4B+9Pbd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YtHA3qcvqz6ZH4qZmTuSbvDQwfkbc/hTaAw7tKfJQ8yja+jB1dPxaq/igr5NHpyet7yKCcRRKzRcHZ39jzLKoJyRNntbzLve+TG1yRSF8vh8brDHgiEduA+USqhYr+XwucDOib1ZenrNbYiJR1vUuw4NOg4w4fx6ncDs80boBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQao9CrP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQao9CrP"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f9aa52c92so2283938b3a.1
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777646334; x=1778251134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk8uEZa0eDL7AYTDA5NuGODhsEPf2eVrq3K/VEvlvkQ=;
        b=dQao9CrPTrIShMH1HhRcC6Uk6SXMMkEK1Iys29xQU/PVuiXln7LtFusTjOxD/qGJ9q
         hY9OBohOJ5P047EOrr1juQFK3QUFd1yDVOY9h1h0vftq0XFfJvOXbrT2HySeLZ7zoUIo
         0CpBdjLjmCZWZIBJEA1EnVtbVdNxzVukS7uzYFyvdPEGGPgXAbusNn+BhMP0WE2n5pG3
         qviBm7c7rUM4MXVZWG2fDzSbFBPFP6XVoq6i4ReFPfKxXKC+0vspr4ZX6LqPPheAcDIq
         hefYc9rz2Jb01w2iqsH6nAaiH5SqK6AZmoRFV1h+C6BfPXFHHLd7xB9SbjsnoclzBdT3
         qCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646334; x=1778251134;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uk8uEZa0eDL7AYTDA5NuGODhsEPf2eVrq3K/VEvlvkQ=;
        b=UQKxPely+IqeNgr3ONGusAsdp/pCigm40354FwIwi+enJLIh4mHlrJQeF72HOqgEf1
         MEGQBdN6fUIftswKJoh73armJp0ATSw8md/H7sM32awZOJppIst2D1EFpOLGH+HCRZr7
         Hps3eUYzy5aE/YEKEF43YD6XywazJShPPXUug0Gwg2vcdy+4PoG5dKjm6wzE2u5lDc8D
         biBxa4MFuwhhS6xz7q33bN/jM+SkaMl/rleGZax44M1LaRyoUJM+mLOCMuAgjStlSyev
         c5V90n6N6hV2Jl0Yw90ZPzMmXeBTyTqYBhBuqJtoLtuJ9TE22BtFZfhC6fcb3PqdUq4h
         20VA==
X-Forwarded-Encrypted: i=1; AFNElJ/rmS/GX9SAI8enkrm5lw9Q7KWwzSWNQeccWifhPI4VAIeGMlVm1qv4ViBSigaVdy4CuqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwaWgPL7WMro/4FArD7IIq3VxM2qu0LTbEDA8dbI4kV96mJwsW
	TE1o2yqrRu12GyN99v8a5OvCKVyPfT+UvvFN3L/by6hARIsmr2WSs0beeSJtdOfusIhRyBWa/Cy
	RcK89SA==
X-Received: from pfmy21.prod.google.com ([2002:aa7:8055:0:b0:82f:7ce1:182])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d9a:b0:82f:aae5:c795
 with SMTP id d2e1a72fcca58-834fdc9aa92mr9170785b3a.48.1777646334099; Fri, 01
 May 2026 07:38:54 -0700 (PDT)
Date: Fri, 1 May 2026 07:38:52 -0700
In-Reply-To: <CABgObfaCVaKfn1Jh7SdzzjwFpSURJTQw9fP0tjM2==PAwfP_pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-27-pbonzini@redhat.com>
 <afOqSkJnemK1B0PE@google.com> <CABgObfaCVaKfn1Jh7SdzzjwFpSURJTQw9fP0tjM2==PAwfP_pQ@mail.gmail.com>
Message-ID: <afS6_AM9AuwJJUr2@google.com>
Subject: Re: [PATCH 26/28] KVM: SVM: enable GMET and set it in MMU role
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2026, Paolo Bonzini wrote:
> On Thu, Apr 30, 2026 at 9:15=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index e7fdd7a9c280..3895d8794366 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -138,6 +138,9 @@ module_param(pause_filter_count_max, ushort, 0444=
);
> > >  bool __ro_after_init npt_enabled =3D true;
> > >  module_param_named(npt, npt_enabled, bool, 0444);
> > >
> > > +bool gmet_enabled =3D true;
> >
> > This really should be hardcoded false, with no module param, until "ena=
ble GMET
> > for guests".  Otherwise stopping here means KVM is over-reporting suppo=
rt.
>=20
> Are module parameters reporting support of nested features?

Not strictly speaking, no.  But I do think most users, myself included, ass=
ume
that feature xyz is fully supported if its associated module param exist.  =
Though
I completely agree this is an unusual case since the MBEC/GMET aren't reall=
y
supported for non-nested, but KVM still consumes the module param.

> This is I think the only point where I disagree, I think.

No worries, I'm a-ok with this one as-is.  And I can see it being useful as=
 a
bisection point.
