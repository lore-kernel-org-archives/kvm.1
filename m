Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736F3F0A85
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087948; cv=pass; b=VLa+uuFqc2SfRzZA3hFitdzjzDQmz/7oY/MYuHm+V9qOHLyR4lZEIIkMv8ajl8PhwgoNlJRPCqvBetEF/sO6gX4lVEaKuBeohqUDaWxtQiF/8kQ5v0fgQ/IDZK00ABySQ3iihjaX9aHDZgESUSor69ULSQdax4XZKjDRFLWPkE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087948; c=relaxed/simple;
	bh=SsM94mkfReTTJBuhJqVCS0N03P7iimik4et76Orlxb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7hSUqoVd304746NDl/flONI9/unVfMjcJa/JAD7O/aeEPsLR5LS2RgUk7eBg+TcasFdNld5kmTanBmhTzKMDNAXux7WhJG0ljmoIMXYYiNJGlWd7snrQYUmYLsK4NfEF2Pu0+XSZbqoZs6APA1fNeC0LtqMKLVEmBLneu8bruQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXXo3y5D; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXXo3y5D"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2853b1f8cso343965e87.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 16:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775087945; cv=none;
        d=google.com; s=arc-20240605;
        b=F7Q7JhOEY8nrj7Eai0VYZRdOHw66CPXzJ3u/L6pZkaGvWBje3WuDXtMKd+YTwrwki4
         OWBT47moFni3TDcF8dxkCklmNrMvrCIDYD+yCB1z4bUgYoJJAAfXu7ZkBTxF8Ka2jM8m
         5d5o1FNK+OC+vE1IWNem4h9g7SQQHGOGHxmjlbwM0TuZmhtMWIUPH29L2ZRT75Z65myz
         QYxpaZf9+dN+iRW55CmiiP9UlLqU3Q19yqzeIy8J3Z5bVsM1fYnjbuJGuCQQ0wektExX
         0O2vrdu9dyRODgaZJnYRALftDKgn5Z7ersRIsLyWVFVWSfaBWnzCOXXZ5J/JBveG4RXK
         46qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OlCbgVqmY4UjCJzeUEQd8X6mJbegrCC6w0qjrd8WEIQ=;
        fh=vOjGiqEo/VP+BI7vtb+p4I0uvulA0+KkjaC8aOrw5m0=;
        b=MGw4xy23sD8iqF2iVak8dR+VtBIwNfP6V5lN/Ve8atG+hMVq2B7LEs39r52kvbRa4u
         2xJW9CtxwR9OFdGwBO2kUGD2AIKbIvVgENT5szqo33zhKCiJktT5rwvsMSGbAhkJYUyg
         XPkWKM253W3hBOm+2KyHBy88lpUkgcVvVQkXMHeaxA7KKYQXISFdPXg9aG6mKL0O+VyC
         pSr+XgIlgMRxWy9IfnFfdz6/5wmOP5wX7PG/0J7EvBncrOC4Lr8xMO/5lR7ucDMxXpde
         nX8SWJs4XqP45BN26wNE82NeaKGlsW2c1RhW6yTMUOjkhv+zMZlKMQ9xZekIKoWYSXxM
         DY/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775087945; x=1775692745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlCbgVqmY4UjCJzeUEQd8X6mJbegrCC6w0qjrd8WEIQ=;
        b=vXXo3y5DCVXQCJbK/aIN59RdMtxa9BNLSm1Bcflo61W6urbixVijEC4savFghPknps
         5lx9n5WuR8f8Qgq+PSJPKQEJFsnvnMyK1AW0WCWT3xD6POOAImQbWWctkVOwpGjR7HiM
         NVM5kbjgCRkTOlsz9nSw1GLf+PFxs6w/6XBRVBytKoBtcvCK6NYxm8dBXJZZGqYVoQzF
         YfJmu3/+BMT4LzzELC5Ykeln5ZBX9EN7laWYbqNBraDtVJjMubksMXXYkLSizsGTkH4f
         9Mq68YVouV72yfCvmUH8WyTNvnj4oxB3zoPAjoagMZDMonuYfHxCFIyo1nUWkQB4pj/h
         eDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775087945; x=1775692745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OlCbgVqmY4UjCJzeUEQd8X6mJbegrCC6w0qjrd8WEIQ=;
        b=d4cmeAOq+GWMJXRs2pnfcrQMWj71DAW+6nQ82aSFF1cOZqJ7l24feNGYWV5FNhydMy
         rZq5eQQFsa8cnqhUB+IO0zKDfvK5busVaKE1Hiqcg6E5uHGiTM5WQ8Evr8XZWDl6+D8G
         qd++qKOhlm3jLqW7MLm4vTBUQJ3egH0/tOC+KI5caDwUQsz3wrtUhlew7vU+z0Z6Y03k
         Q60BW99CT0zm4Za1A0lS4jbTCf/LpaYs4nWq/0FRxDgTtFmnwxp5m2R/AMjPGJW5ypDy
         3jFS62aViTQkfnvd+Oi0a4GtDMlIm2Ava12GSwzWUh/eYsCmPDRbxVtXnE7QYoCoGrpj
         ARrw==
X-Forwarded-Encrypted: i=1; AJvYcCVjVi/iNSjnBOPrg6qNkjjjye+vP3P5puZQpeCLkXJSfhZPpEAWlCPIc961Dnz6/dxO+aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyAWxZOVSLJDnyEXVra5X7afy3+0R2gWbkP1Ciy8Hbw2Fze1w
	f2rg0mFl76+RHsS8M9amYMc4C5iIoZGDF/PUD4H6q5EJvJpquFR4fSOEIW1G5jiVw8BpcQMh3PS
	W/xmCe1YBwvZmNd2mQ1Dxegx3YuZKwT0HP8WTAak1
X-Gm-Gg: ATEYQzzr07JqZ5SjcTUnx0TOkIQcvVfH9Vi0ftcpgKimyijs9s70iEtWb/tI1HTbwIZ
	bq+9oYF7icVCkX73V0Afowi+7qUrbCSG1ys6IgRDm+KY2DJPL3XUWMwFoBnhs5RcZTWqnZxsG5+
	HXiZvNBKNngZ9SPOCYiBmuF/nGoUIC8R49GQ3sVo2p15XjAdklb3qgBjFs3YFAkqdjAP3Daxb/+
	69jztllWQbjWVhl4mXiET00bkS3h5ofBJ8RN1iON80iHP9Avyre6JxZjdx4FAPPW1q9iMJPdpqD
	GjkMC18k
X-Received: by 2002:a05:6512:3b82:b0:5a1:3f3f:a29b with SMTP id
 2adb3069b0e04-5a2c1ee2f3amr2191371e87.6.1775087944861; Wed, 01 Apr 2026
 16:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <ac1hI93pEo-x-7YU@google.com>
 <ac1pUx_jYv2yCMnX@google.com> <ac1s55_oLEUQx8Hs@google.com>
 <ac18LHQLalPb4z0-@google.com> <CAAdrzjugqk=APteY4oZNsa2e5kv5-=HBekyYfpzrwFUZ_WapsQ@mail.gmail.com>
In-Reply-To: <CAAdrzjugqk=APteY4oZNsa2e5kv5-=HBekyYfpzrwFUZ_WapsQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 1 Apr 2026 16:58:34 -0700
X-Gm-Features: AQROBzBWedQRj1xrj8aJgE6co8p2Anfj7XyPFIC7uMnrorocDZEWFvoSpznlrR0
Message-ID: <CALzav=cO48f7f8yaN6EsSL4uGpojvY7gmCe9oOy+sP_+Kii4mw@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] KVM: selftests: Link with VFIO selftests lib and
 test device interrupts
To: Josh Hilke <jrhilke@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:42=E2=80=AFPM Josh Hilke <jrhilke@google.com> wrot=
e:
>
> On Wed, Apr 1, 2026 at 1:12=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
> >
> > On 2026-04-01 12:07 PM, Sean Christopherson wrote:
> > > On Wed, Apr 01, 2026, David Matlack wrote:
> > > > On 2026-04-01 11:17 AM, Sean Christopherson wrote:
> > > > > On Tue, Mar 31, 2026, Josh Hilke wrote:
> >
> > > > Agree this would be nice to have. Is this a blocker for this series=
?
> > >
> > > Yes.  KVM selftests need to assert there's a driver before trying to =
proceed.
> >
> > That exists in the new test:
> >
> > static int setup_msi(struct vfio_pci_device *device, bool use_device_ms=
i)
> > {
> >         const int flags =3D MAP_SHARED | MAP_ANONYMOUS;
> >         const int prot =3D PROT_READ | PROT_WRITE;
> >         struct dma_region *region;
> >
> >         if (use_device_msi) {
> >                 /* A driver is required to generate an MSI. */
> >                 TEST_REQUIRE(device->driver.ops);
> >
> > But I think you are also asking to have a helper that prints out the
> > list of available drivers in this case. That should be trivial to add.
> >
> > VFIO selftests could expose add a helper that handles checking for
> > device->driver.ops and, if null, printing an error message and list of
> > available drivers and exiting with KSFT_SKIP.
> >
> > One wrinkle here is we are probably going to merge a driver soon that
> > does not support send_msi():
> >
> >   https://lore.kernel.org/kvm/20260331172241.50456-1-rubind@nvidia.com/
> >
> > So we should also have an API for that. e.g. Add 2 helpsers:
> >
> >   - vfio_pci_has_driver()
> >   - vfio_pci_has_driver_send_msi()
> >
> > This test would use the latter.
>
> Ack. I'll add a patch in the series to add these functions to the vfio
> library in v3.
>
> >
> > > > > struct vfio_pci_device *kvm_vfio_device_init(const char *bdf)
> > > > > {
> > > > >   struct vfio_pci_device *device;
> > > > >   struct iommu *iommu;
> > > > >
> > > > >   iommu =3D iommu_init(default_iommu_mode);
> > > > >
> > > > >   device =3D vfio_pci_device_init(bdf, iommu);
> > > > >   if (!device) {
> > > > >           vfio_pci_device_print_drivers(stderr);
> > > > >           TEST_FAIL("No driver found for BDF '%s'", bdf);
> > > > >   }
> > > > >   return device;
> > > > > }
> > > > >
> > > > > Because as is, this requires way too much a priori knowledge and =
magic for
> > > > > upstream.  The user shouldn't have to dig through code just to un=
derstand what
> > > > > devices are supported.
> > > > >
> > > > > Ideally, VFIO selftests would also provide a script, utility, and=
/or helper to
> > > > > identify BDFs for devices it has drivers for.  In my experience, =
binding a device
> > > > > to VFIO is trivial.  Finding the device in the first place is mor=
e annoying.
> > > >
> > > > Agree this would be nice to have. Is this a blocker for this series=
?
> > >
> > > Yes.  As I mentioned to Josh off-list, I'm not willing to accept a "w=
e pinky-swear
> > > we'll make this stuff user friendly".  It's not that I don't trust yo=
u and Josh
> > > (and others), it's that for me, this level of user-friendly behavior =
isn't nice
> > > to have, it's mandatory for these tests to be usable upstream.
> > >
> > > Internally we can squeak by with barebones, unhelpful tests, because =
the run
> > > commands are often hardcoded somewhere and there is piles of document=
ation elsewhere.
> > > But for upstream, none of that holds true.
> > >
> > > If it were weeks of effort, I would be more open to treating this as =
nice to have,
> > > but AFAICT writing the code should be less than a days worth of work.
> >
> > Yeah that's fine, I don't think it adds too much extra work, and it's
> > something I'd like to have anyway. I just wanted to confirm if it shoul=
d
> > be part (or merged ahead of this series) or can be separate. Thanks!
>
> So I need to add kvm_vfio_device_init() and it will call
> vfio_pci_has_driver(). Then, kvm_vfio_device_init() will TEST_FAIL if
> vfio_pci_has_driver() returns false, correct?
>
> Should kvm_vfio_device_init() live in
> tools/testing/selftests/kvm/lib/kvm_util.c?

I was thinking the new test would do:

  TEST_REQUIRE(vfio_pci_has_driver_send_msi(device));

instead of:

  TEST_REQUIRE(device->driver.ops);

vfio_pci_has_driver_send_msi() would call vfio_pci_has_driver()
internally and also check that send_msi op is non-null. Both functions
would also log error messages if driver/send_msi is missing to help
the user, as Sean requested.

And you'll also need to a patch to add a helper script to print the
list of BDFs on the current host that have a VFIO selftests driver. It
might make sense to send that as a standalone patch if Sean is ok with
that.
