Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33D2F39CE
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153251; cv=pass; b=WuRe9k9BfJ3n0XylPzvw0Dz+QwlUFAJdxYGEHcdyN6b+y52YpHJ5qUa0Nb/2xmSCheMiS04TMER29bg7Iwxm/544Mh9OLusaM+fsCdqrzFOp0UUefspfhMySEjyVE/8wpZh/wXw9ccdR9k9umLo0zmoxnEq4qu64D3SN9SJNkyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153251; c=relaxed/simple;
	bh=32dunLOu0xLh29iUMcJlh+tE1m1GN02XAtITUnvH9Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IR19xMR+kBUBbjSPbXuf8D9+x0InO4M+NkgNU+x9ymqpPPcDwQkSQflWbkB95w8lYM6iSSO4frRuvThkgKjYr6w22hrAJfujv7/ORobEv0rBd6KdLLtSLFyK/MCh4GR4R84Uq0EOADwI7jrEjF7Dq5qRVkucfk9tAB+u8HLQtDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7+LoyMk; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7+LoyMk"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50b6c45781aso94791cf.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 11:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775153249; cv=none;
        d=google.com; s=arc-20240605;
        b=Yb3NinvoLONngEAUyxiXr9iBv8r1lT0mgOG4JWWzPUazgt1XLV6+4aT4wWvI478hsz
         NnDHUN+ni/PtyatsAxJ/CIvlqe9en3AIjpRuYyAXg9vjkqwMH08tYSS2HahRRIDyzfyY
         yQCH1OZ9KNjJXFgcwFUu/YoOI8DFQmYiqlXWzt17wEegVUG1E/Tva0BzEUxMO/0LoiVs
         ikdsyI8WSQEYDxqTpdgjfK+sN0KyI40jCvUJ/C4hU05CLDFVVNOKEqS2q76Fiu+1TFUS
         jmDzJ+wfzl/KNT2T3l3GylSuw2d27LDkK7rxQJ5hRzLzbZCFD1jND3BkjQp4kS7raWxD
         tg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o+pQMSFdDBQJeZ1ngz+G6eBRPzDEREyVI+8FTyhyuug=;
        fh=Wq2Je+M8uqngCUuces8yBb92bLqURJsD3rYAb1xyidQ=;
        b=Kbll71TycaI0DXCaeRSoqpLR1IsFuRHJ1JihZjDPtaMYMFMazZzG8CzG7FiiA0BydX
         zvLgf9S7LaDsaUgbE9AEU/SGfxB+PEc7xJsLEpVkaMFH889vu1CvlVNp1MvqspLhHILH
         a2bzpVSQRwREe1ve/ZR991FuBsTWzR2lkPDDzmYJqywLP5I7SWh7dQy/QM5Q84/mcO6O
         KpzdfqsHCB9DT9RhwoKFl1I2bi0ldWozDizx2oJPdeFaQqg4O8vnSGgMIOFxuWlZLXCB
         QdHXStuC/9JNNwylC3PGnfs68enXu3/dI8timvFULijBTleDiMG0rnTQ9J4ZLT0B54Po
         gC8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775153249; x=1775758049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+pQMSFdDBQJeZ1ngz+G6eBRPzDEREyVI+8FTyhyuug=;
        b=n7+LoyMkD/TyvauWaYkN6zX4aCfCwFp3seFqp7aZ3zqSEgfmp5Ju8q0yQnQTxKUvEd
         FtFq/BSREA/QcyUqIQHBx3ni/gR95UgCuKD7kMOfXUBv/m0XDuB5/OC/haHs1ybOpwS3
         gx1BtoXKvzVPeGRgOcxZNef4hFbZkM2hcyqgwRpE1UHRMdipjgeBIMnQXq9M8VLKUhLl
         thMXkBFKh2fBJcxaQeUYXeUQwQQdGjkoOqdJXgDWVRHXV6WfmZ9wZLu+SWVHVzBR8j91
         Ghi9BiHdTHASqRJ0HAbUDXcX9yciDds9Q3CkXM/CPXtz6/K6YUmynxatqyb0ZPORIxPo
         U85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775153249; x=1775758049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+pQMSFdDBQJeZ1ngz+G6eBRPzDEREyVI+8FTyhyuug=;
        b=REO1ESLuSX/niDKFsEM9m7w8zQ4qocsmS0ainmgzmZcY/BoVI/CQ1lZGRErjxB6g40
         dVsF3Xr7s1P4rEy7fKIexHui8K/TibDk3LHElby+Q9bw/I5J7Jzcsx5cIVvAORUBFsSb
         CNkXhAQcXSD+B8F5sH4VzzBTn/CX9KA0ezVHYj1ArUtfmDMU/cgC7RaIrs19ATGIBHL0
         4oTJy8OJYw7t7nWu3CvL+lgb02bILWTPLWcC3xWkFtCZHLJIhNCj931s8M4ZQqZLkyLO
         GNKybhBAx8077VSNt2cpkeCFROPAysPDRjEmuAK6JqPwE58MA83Y1VKB8uacQcpxmErx
         Bc2g==
X-Forwarded-Encrypted: i=1; AJvYcCXBqmQYdVSIv8wma1wXDE6WiLcqKqC/XUUyKYdobFRUBuk9gTPc5a+CG+ZXIqoHb6I6nak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHnAMWrhw6KA9Ct8CMeurHjpWPlZNuXERz7K4ouxd96khBWtu
	j6CfULzbwGeEzDA2w1VsT9c3cqVZERUMmzFcgBNYCR2C6tPf0dDRKDL8Z4upihxZJY8vzfUO8OK
	sySzBcRX/Xfr1tIcr2xZVdEsMDmrM/FUQYuPMaNU=
X-Gm-Gg: ATEYQzyYnu2P398Y8PW5Fl4crDZDzqPUDllyLkgXdjjARgAM441vWeTQ7arMsshOjFq
	DyV2hM1/QVuNjnV0A3OjMXy+eW4Yo64G5nOJ+Gib6ueWU0+Hd9NDTke+iFqc+DruAdEJVjfBhq6
	ZofOt+8RveaEm+krA0JBi7jJJtVAN+CILJQCB2L16TN4DW8Bn1JMBIexWT5dJzV5BCbjPOfq/8b
	X+PbiDLAcXLeqrSBj5q/sMbFrV2Y2s7YWlpeBwpb4mmi5wX1iC7CEl+/vpjstni7Yv2u5ovBMti
	Z4woVW4n7phVhLiFGKgnS419+QnWX7P/Rf9I
X-Received: by 2002:a05:622a:4204:b0:509:25c5:42b4 with SMTP id
 d75a77b69052e-50d507aabc6mr16012291cf.13.1775153248166; Thu, 02 Apr 2026
 11:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com> <ac1s55_oLEUQx8Hs@google.com>
 <ac18LHQLalPb4z0-@google.com> <CAAdrzjugqk=APteY4oZNsa2e5kv5-=HBekyYfpzrwFUZ_WapsQ@mail.gmail.com>
 <CALzav=cO48f7f8yaN6EsSL4uGpojvY7gmCe9oOy+sP_+Kii4mw@mail.gmail.com>
 <ac26haU_7nXYWke1@google.com> <CAAdrzjvvxX3eEkCBUvSud7qyaSUdzecgAkX1=f+ZQe7Q6ws69A@mail.gmail.com>
 <ac6o2Z_cs0HA6PpG@google.com> <CALzav=cnT1EQY4DQbqj3vNuG2ino+RSFkZ6UJ0-zDc8bQhBJPg@mail.gmail.com>
In-Reply-To: <CALzav=cnT1EQY4DQbqj3vNuG2ino+RSFkZ6UJ0-zDc8bQhBJPg@mail.gmail.com>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 2 Apr 2026 11:07:16 -0700
X-Gm-Features: AQROBzDl2njxjXOizwUsOucvzROFaIhMGpzBF94ZkQCaZsKWp8mIVKoYDNHpjUk
Message-ID: <CAAdrzjumSUHkQ20RjoX_2d_ebj8SpFKbjSQLjaxF7iH3k30d3Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 10:57=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Thu, Apr 2, 2026 at 10:35=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
>
> > However!  We _do_ have a KVM testing gap that can be trivially filled a=
s there
> > is no existing eventfd_signal() =3D> KVM IRQ injection selftest.  And t=
his test is
> > pretty much exactly that.  I just don't want to deal with jumping throu=
gh VFIO
> > hoops for effectively no coverage (for KVM).
> >
> > If we strip out that fluff, then the test is runnable without _any_ VFI=
O
> > involvement, which means it can run by default, e.g. in n environments =
without
> > VFIO or VFIO-able devices, e.g. in automated CI testgrids.
> >
> > Something like so.  And then we should also rename the test to drop vfi=
o_pci from
> > the name, as the VFIO aspect becomes purely optional.
>
> That plan sounds good to me!

Awesome, thanks for the thorough example, Sean!
I'll go with this approach in v3 :)
