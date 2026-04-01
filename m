Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79913DDAE
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087208; cv=pass; b=pPymQCEtxkLiIHhVr+FkqpwhU94Ay2VoUl1Xtu41MLm7FLSoeaV5rRUF9lKggTUuShIB4AeQ299VNM8C3T2JIlnPrNJ3znD2yB3c/c16rOXlxCg9VCL2xSC8GZCCLyEPn1lxDem4ZLz2z2PO23VwsN414QBN6HZ2cojRIVNoSWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087208; c=relaxed/simple;
	bh=fS633Zf4iDLF371saMHUWTQqyHSeuQUrZf9CvEtWgE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+/3Htim+xA0Fa2BAI/4JVyqnzo9ZCnwmd8JFFL9J6Bnb4CWYSorAsnwn+aD+rePcOx5t+k3y5CxWZOCtnA/w2vkU4/h36zsY2ltfs1fcHrLpwESPL/cGC8S7HNJAb74cIOb1IYXOU2Jz/AZsLsV6af7GOJkQRbmTDXQoA/+9W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kDY0LtV4; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDY0LtV4"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5091ed02c54so123081cf.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 16:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775087206; cv=none;
        d=google.com; s=arc-20240605;
        b=V8AxdE981+CuCxUwDDjoSASRsaf73fT2Ca29K8ZWquHkkhfltFTVOW/bhY72kv4nJG
         cyJiFTp/VY98p8GSQ0JUk+Dils0Ppo+8sw1RdNMC9xJ4YWGMk9tFBxWSQX/ExknCNM1Q
         VVtJzEynXKoJ8qmCoW3W/1bixugJ+uO/braFwJ+F0h6TdLO9jc0Ib+2WLwsuKbOaq+SW
         w4dubaVWz5pcwe6VEn7seLDJ+y06coPKfo73Vfr5XUkWdJloKhNd17eUH6vq8YoUTZiz
         jJnzZ72n7ictCdXqo3xYHFaTm2ERqdAgY4lnmLhAFL360B7bqTQopynxBx7ihXkJ9Yxy
         Dfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8jcYeTpqMmnHux/E23IvhDqoMvCbLFG6WSfRiMsqHog=;
        fh=aWngvwM2buczE5QAHCbpBTGbw+V3uh2kw8fjfJ580vg=;
        b=WyYt/Xg8CAcELdAAkOFJRLIQUK0xaC8nm64RO2Gdpty81NxZ8LSDOlaZUZtInyvv34
         I+G1Lb6aAsRrZW4cJlqYug/PGrVFuWf5lbQQbARYvB/rWzKqij9FgLFR1Ue1QTh8SVyE
         +OYW883AayU2yAdECabNVsL/zzMYmqd++X2Tlm5xm/1gfmC+ALyd4Bn9q6fz1bDDxq/x
         XkVSxisPmGrE8Ob9RzA871AkcE4Dyf9XYHd2iDzMuacyFzR2oJ3l8xwhJ1G9jQCYbVUN
         /V+8NHRa15A+VA9+BAr0dnLLWsCSoFq7NEiX4WI7IRlm+MenmvVa9s7tHQCHWBvYPAQC
         SJJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775087206; x=1775692006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jcYeTpqMmnHux/E23IvhDqoMvCbLFG6WSfRiMsqHog=;
        b=kDY0LtV452o77EbzNOE5NcGoL2BsHQSBDy67AjgpIOlkBE1H8Rlf/KSt7/bD5PkpVq
         hKONDH6oYIXMIFOqtomxXiY5uTnB9wv7MxUjeGzJotG/EwTDN/d9VGqeeoRbjcZ3/7t4
         htNOazM6L1nTb2XSTTGpbYVGwTkQlRA/79hrHLhAo2+mZvuDjwA8biiVTc36k8ubvnLN
         lQxUvobIoReUFhf+qSvirjCBi2W3WoBMhDRhLG8PypoxWiwi5WDnOzTjjUKMbJCc5ioM
         QTW4IDJi8il8MYwUeYifEuciJjrqcPkEn4rlXQoqEahaX5iygjv3XWUrZcbIymOe//yH
         tFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775087206; x=1775692006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8jcYeTpqMmnHux/E23IvhDqoMvCbLFG6WSfRiMsqHog=;
        b=XCcctYauVZ+X1sS6pGbm57Z+YWCGUtiakYsc3dqFHO/b39wyU0OlRzmC7a2jdEOfpt
         c9pKe42XCB8dnKQSrP6VjWpoxjuTi3U+ExRXQ5558K/sYq1F9IOkK/RxJwpEO9RNgjie
         A6S5XOVWaz8ZyLeMIRH+p6ST+T/PM5s5pgM2g+GaSEztIz/6tIeJQqUBsBvQ8MaQSAAy
         vUQuWlS5hh7jjLG8QJhwcSoRGEIzNtvM/BeqZp26FzW11AQuECyWuZPX1Ce0MfOJn33v
         wYNwq7Gypbzxyb9rPEFIn0KaUfbXp5Lw6ExOHLRFKaINKxdq0ggcj7jv2UTI2qkw+aS/
         +dPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMyZRQAqZne24zp3Fp5QA8sKAXyQbo5i/JpD/sBdzowcRu4XKBxfwOm3pies68oJ8ZROc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTr2de5VT2ot9oRm+UrdiZtl3vZw17TH5bsY11EGhZVYhWnYO
	9mP2wIxYLr02vfOFE/3vaBf/R/uHWiQb7QHU8HL75Ief+GuYXS8DGi+dt3VuCpa494xWK/YD3Si
	aJKhFL897TuLWU/L4+Er4ylg0IguZTLpA7N9KCl39
X-Gm-Gg: ATEYQzwjq4r+6NEQUc2+oVB8WXRQp7D3GUR1JlfidQwAfVf53MGThch+LB+O+v5Ar6b
	U6EyJFY+RJ4b0DI5OMEno2Ezqy/3zeBDoXm9RkV8CBtFHLsX2s65wIP+opJxYtzzEzv5S+nYLDz
	6Gadfa++q61wrn7X11u8MFwQ4jSC/YE3xm4qQVDlIAbX9Et7UN8aistWp+SRvDd0cf2NgcAHgOv
	qSUOiSfKRrasU7NVL+PrtyzjV0aEjBqAFWelxLgmiMd9AXY6U+CctywmamX5eviqLUlI88+bJIo
	xbrdl5IB
X-Received: by 2002:a05:622a:5e16:b0:50b:71e4:878c with SMTP id
 d75a77b69052e-50d508c1b8bmr934061cf.15.1775087205473; Wed, 01 Apr 2026
 16:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303193822.2526335-1-rananta@google.com> <20260303193822.2526335-9-rananta@google.com>
 <20260311235715.GA2738066.vipinsh@google.com> <CAJHc60yQjfpw9D0VoP0FAfv65g5BpVYddcWQ23q0hRLdcP2k-Q@mail.gmail.com>
 <CALzav=fkKPR1giHyvZ8Awk=OpzNk8b_xVVwt-AyuXjwGGSY4Zw@mail.gmail.com>
In-Reply-To: <CALzav=fkKPR1giHyvZ8Awk=OpzNk8b_xVVwt-AyuXjwGGSY4Zw@mail.gmail.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Wed, 1 Apr 2026 16:46:33 -0700
X-Gm-Features: AQROBzDMA3OR253xpX_gkbAY-xRnRJ4m0tmwUmz70xBGaXmuDnmx6nHNOzLixO4
Message-ID: <CAJHc60wUShGosroLv64M_+vQXe_d-N3d=yA7PGSWC=_PyEXL+w@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 5:11=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Tue, Mar 31, 2026 at 4:53=E2=80=AFPM Raghavendra Rao Ananta
> <rananta@google.com> wrote:
>
> > > > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > > > +{
> > > > +     char *vf_driver;
> > > > +     int nr_vfs;
> > > > +
> > > > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > > > +     if (nr_vfs <=3D 0)
> > > > +             SKIP(return, "SR-IOV may not be supported by the PF: =
%s\n", pf_bdf);
> > > > +
> > > > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > > > +     if (nr_vfs !=3D 0)
> > > > +             SKIP(return, "SR-IOV already configured for the PF: %=
s\n", pf_bdf);
> > > > +
> > >
> > > If there is a test failure (ASSERT) then fixture cleanup will not run
> > > leaving SR-IOV enabled and all subsequent tests will skip.
> > >
> > > Since this test is specific to SR-IOV and user is intentionally passi=
ng
> > > a device to test, I think we can just reset the VFs to 0 before
> > > proceeding instead of skipping.
> > >
> > The idea was to eliminate the assumption that if 'sriov_numvfs'
> > returns > 0, someone else might be using it. This is based on David's
> > suggestion: https://lore.kernel.org/all/aQzcQ0fJd-aCRThS@google.com/ .
> > Moreover, the device might be in a partial state. So, even if the next
> > test proceeds, it could fail due to other reasons.
> >
> > But I see your point about cleanup on failure. I think this is a
> > common issue across all tests. Was the expectation that we rely on
> > cleanup.sh to take care of all the cleanups, regardless of test
> > pass/failure?
>
> I think we rely on the fact that test cases run in sub-processes and
> so if there is a failure in fixture setup then the child process exits
> and all vfio and iommufd fds are cleaned up. So the device is still
> "clean" for the next test.
>
> However if we are modifying system state like the number of VFs
> enabled on a device, I think Vipin is right we need to clean up after
> ourselves if the error occurs in fixture setup.

In that case, since the FIXTURE_TEARDOWN() is not invoked for a
failure in FIXTURE_SETUP(), the test must install its own cleaning
handler. Using conventional error handling with goto labels might also
be tricky because the sysfs lib contains ASSERTs. Even if we do reset
sriov_nrvfs and exit, since the failure is in FIXTURE_SETUP(), it's
highly likely that it's going to fail again.

Since we need the VF creation only once, shall we simply do this setup
in main()?

int main()
{
  pf_bdf =3D vfio_selftests_get_bdf(&argc, argv);
  vf_bdf =3D setup_vf(pf_bdf); // Do all the sysfs stuff here
  ret =3D test_harness_run(argc, argv);
  destroy_vf();

  return ret;
}

Another possible way is to expose the VF from setup.sh itself and pass
it as an arg to the test.

WDYT?

Thank you.
Raghavendra
