Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208135DA67
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009320; cv=pass; b=hhTYb3ZBKQLNlACPv+m2knC8s7CuKPdmNxg/M+6k6Ka2+YrhfgfZcJpVEKrSFeXcrdvywInZHBdCTrWjZ3AUIETBX3QdyAaOaYIyXMwaTdZno7KTZVAqRkTbCM9eqFr01rsSXTfle7eA1HIIGUWdCFNZjWU0Izv+OZNEQ6s1dnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009320; c=relaxed/simple;
	bh=Xve8aLUi5OW2l7XvVZ+cyBw42wv5umNGiE60ft+BWpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fadieZ35lh6KPUH97hW8hJYZ6zDuQa+noNRX249hgx3kvGJTSlNIVHXOWyAIPt6+9yRqzgHAJUyrt88auHtTGP5FP68ApR6IVf81ro4whrFNUU/go/gR8OYsWiF/roMSy1dUwBz+lrbNzP9p6riPEdFr0idqsGY9poptRY/vLuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtkMyt1F; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtkMyt1F"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e61648f10so8511cf.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780009315; cv=none;
        d=google.com; s=arc-20240605;
        b=AkgBDtGwJzdmYVHvyStqNiXqtC7WUrxv9nGYMLgfYaJxGDXAsdlAXlyruQ0s+bMK1Y
         oJewEafPP2qUZZ6fEKgF8QdMLWEBJOMcnBtnB1T/+Oy0+1bDfNqmKIb0h8B4EVeTViPG
         XQPCkpbA5MnfHd5xyz5j5TdxRgteUC22NlU2ugz+FJUelgS9b0i/DYH0tVhcNcuAWZY9
         yp71Rgx6XgaD5Yl9u57o+wyA3jN1ZtVuDPbiPTrut2TJqTYnhdb9Vab51HdsowaHPiO4
         uoK7r8NqkKrzYWjBFstxo6NJVWDWmhw8d58brM40t7CraC7WY+TjyVYHZ8x0lfK8nGlY
         g+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KD4/g47gQI6881l1Qs6X6fqNtCS39zwmjVVuUfl+fKw=;
        fh=h3tm/bT19HT9jFeeXclccP7RfT7JNbrZ9lpc+cJxOwU=;
        b=UrFlmmoQol2R19Rkoy+KhEngUo14HQ+OAKYAQrPDoq6Yj949Sl+u3wv2qlvR7Sjmr6
         qXdz7t2wyL2J20DH1tWfbNABjRMpVek0vx2j42YkGs7f8C9LGHhZERj2/3Egz8uta8O/
         pnSzPXZI32nsk32zvO8jDTlH8O1mtUMbYhKAO7vH4NxV8VKmusQvLK1ayQn6ANE9tyPb
         8wWbT4cMQ5nsdM69bBaWClwCEDjM4/EaUZLxkKCsij/qyerL2p32GU4OUJz8JysthkGQ
         kfInQTrISVRrB9xiPdbVBSoKPqrvGfKSWV0odkSrDlUpdLdYta9y0/z5ESZ1hHDqIy6t
         rYwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780009315; x=1780614115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD4/g47gQI6881l1Qs6X6fqNtCS39zwmjVVuUfl+fKw=;
        b=MtkMyt1FbMOFCo0aoQrM+X62/kCIPpPhvrI9JapEHn6ZufmhyDWPAWaNcwh7XFCfZs
         0nrYB+SV7MXgEbfYj0ek7z6bctwpQfp7qe2Imafmwkvi1Wlt3hYMH2UBTH/xHxtemPAH
         uIZDk58xW/smIyCStP+BGxQ30luwnWHHVpaJ1fkGskJCewuOH8IFZkVtl7ctHCCIXJCs
         hoH2YnhB7w47acI/GpM4QVsUfdY8Bq/gjYggeAudi3srFg+P1Pi47daLPplu8jaMooBN
         gUKo1kvJNofeliZez5k4RbHmOjrISJk054UYrFrGZHPSW1Y27N5vRHZzmBRJTzk98XWV
         bSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009315; x=1780614115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KD4/g47gQI6881l1Qs6X6fqNtCS39zwmjVVuUfl+fKw=;
        b=stnssBraxOy/oVsD5apIKWJj8nOX+3PkjyCAQ9/mFfkg5cp9oIJuLYmP61nfI7CX6H
         NgJPrzHLyn/ff9jHY7ZZZcvJOX3q8sWGQw8J7H1bHxYNdMXRzlb6Xp9Z+CL+q5va0fdy
         4pXZ7A+e5g302UZFAFnd4TCebFncbhoI/4w6Wh1VKj9SkFBshMQ61IrDsqdkWl6smK8o
         aRJnJMEFK4ZxjiNLQmQLsKMMyMOZmpcGd4n2WZ/fsExpVFlWAN0jp4D9KIRXvYq+uitL
         DtLbYafXaU+gkE4msJfG7YO3ZrYPhwcPsVXhNy155NLrqEJ49eC0wPl/WV4ZOTulaV+j
         9RKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/siCPrByJ5VC4GHlFhXI/hJ0dJBfboYsA8erSOBkWGbuVpFLOtVYIC5xv5pLFHYnHjFfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcVCFjZlhE28HBuXQt5/mOLZO1CJ7T53Y9j4zaDiggyXjoVRb
	HSpl4ARfi15gsHkUSdJ/9FiB4v8y8SO+Rnz8LFyfdiMO9JY99U53o1gkeO5V+9zJJyEhscWlFbx
	uTEZC64Hv2/YDOQu5YVEMM2KJHIQANp4DAR2vTTQq7uuEjH/CjzUuqlU=
X-Gm-Gg: Acq92OEBfoJdcBV5EPTccK+SAqBDozZRNJQIJOnMoKxNw5jLiayiXaVNKZ+mZSgwqqf
	WKWmqEY+y/2AVHgsk3rsGQRzhZ27/Lq1bYtLhisLd5s++0Mw4r+IisXWCfpxuKof3SVjbRBj/n4
	mAhuvdQpBrH0bjmSzXibK9wFXXydJFIGHAizIfDm6PegssV7PuA9zg3yekwhsO7moZNULJddxLZ
	LgCRGwjCcGANrqMUz0nrjztJkKOExVe9/wHjTo1gPV3sLHf6dbtxsqU4OfeEPqNu4tBMpKy5lgf
	xlRA0PROULL/rKZ18epCPBI/opSY/P6nw8IhEZpch4bEP74=
X-Received: by 2002:ac8:7251:0:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-5172df012edmr1272551cf.13.1780009313643; Thu, 28 May 2026
 16:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-4-jrhilke@google.com>
 <ahZOebR5XXQNkyW0@google.com>
In-Reply-To: <ahZOebR5XXQNkyW0@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 28 May 2026 16:01:41 -0700
X-Gm-Features: AVHnY4JCPgoKA8byu7qFbF6L31Fd-cOMKDuHPe9A-amiFpazD_zxgIFAeXCw1CI
Message-ID: <CAAdrzjuJbLF19HeQ+_NC5boxmXVEczoMu4UX70i4v0zoP1ofDQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] KVM: selftests: Add guest read/write macros
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:52=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 21, 2026, Josh Hilke wrote:
> > diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/s=
elftests/kvm/steal_time.c
> > index 7be8adfe5dd3..23380de79817 100644
> > --- a/tools/testing/selftests/kvm/steal_time.c
> > +++ b/tools/testing/selftests/kvm/steal_time.c
> > @@ -72,8 +72,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, ui=
nt32_t i)
> >       int ret;
> >
> >       /* ST_GPA_BASE is identity mapped */
> > -     st_gva[i] =3D (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
> > -     sync_global_to_guest(vcpu->vm, st_gva[i]);
> > +     WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i], (void *)(ST_GPA_BASE=
 + i * STEAL_TIME_SIZE));
>
> Please wrap these.  80 chars is a soft limit (and so is 100 chars), but t=
he purpose
> of the rules *and* their exceptions is to make the code easier to read.  =
This is
> hard to parse, because there's so much going on in one line, whereas I fi=
nd this
> easier to tease apart:
>
>         WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i],
>                                 (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZ=
E));
>
> >
> >       ret =3D _vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME,
> >                           (ulong)st_gva[i] | KVM_STEAL_RESERVED_MASK);

Will do.
