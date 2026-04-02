Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14A1DC198
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151249; cv=pass; b=uMTwd94W2lR7czbCHP1xRb4U9i7u/s3y3KivTqA/9KwklPTJ5npwdTAqxUG7kVo+UFRuq18FX6HWfZAgltKEPKxVXpxUs+k68d3SElwcP8J7SF9DDU1NwTIFqeRYRlemL7vTpT5ocyumIPpx30zVn54TGEiuJgDd19TsYwOIsus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151249; c=relaxed/simple;
	bh=MYw+ZRtks3mPS0PN5Zr3VN9A5plM841e4jXCHGe1BNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIxgeHzhP7ncaFhjELRqwOY+k3u5GUi9hK6TCCd8KVoUgN8S29Jr+pnXRgtiGiuMLXufiM0B6ZZyhTX+IGQ1bdsUkCzw84Ec3iPieRlJuIi5RVGT79ITKVUF3TxbDfrWoM2Q15kMhEDCp23i3yeE+M2GW3BjB4rI2Z4cODD82lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gjo9ksbm; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gjo9ksbm"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270f10a774so1107c88.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775151247; cv=none;
        d=google.com; s=arc-20240605;
        b=OEIy1dvPInY7GMyBUsOBNu6pQtEZB/vJBO0yiJWQyAul0OiBRGiReHMnwV5xCsowsA
         x3XsDZKKjHv4ZdFA5B3ByvOWP4NiTObWwd8XSPKZruvHaRCdTdwzEEeZ2BRILIc9AFas
         VQ2ckcEtD6asZRVXPFycRAluV8v+ROeWDukuELxZ93K7UMX4coSEMbhB4PCJ+9tTTjM/
         KWrB/5JCf4DmeoH2RsyNRy4mYyhJPvL2S9E09DHg2qkfFeRFUzqfNBLURn9vjwMM7htP
         5KnvXeGor6w7I+IWz2Tcl/Vp0X4VG7QPGQJq8kshqL2Y0Y/pkv/lWKfmJFkQ8RXTTTM8
         Tx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kcd/4lgcB0uGokQQTzwvk0L+mo4TeiP754iofc2dbRo=;
        fh=uTnY4qCF2T/S7ST+pWaIigYSa+Q59CgAm/YYL4qzHfQ=;
        b=DpS8URHPTMtxXmOctz72C0n3KpXZjVGikRmYHbCLU6Ijbd0hEI05sksptXXL7P3osW
         pCTBPVnHZyEaovDycFFMuYc6a1NQYJsNOkP3nA9mCfZ2MDqLG2L755HGLmCvDFbpgy+H
         gmLKcNL3FqGU9egg6falFcTrpxhAqTw7ooiARWGeL4BX4LVYKsO64fR5W1m3t1QK44qC
         YlC+sQUKaBSKFmXrgTAgx8Jlv1ftw+WeLapW4juru9g+d5JIClj26keOnDdf5+gFDbVC
         a7eZSLvg6YhaoWtIZTLWvy1/WMz6b1/rcDyhSAzJyZwk3fAp+lluMP/CI1jVbUcYpejD
         DQ/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151247; x=1775756047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcd/4lgcB0uGokQQTzwvk0L+mo4TeiP754iofc2dbRo=;
        b=Gjo9ksbmQkCV4/BFjY3rJlU9dk/AGF36601QviGK6k8UQqEkzBSwJnvbTEXEcENhe5
         /iC33ElErALO3rHigezoLQ1slK+XGjCGeJ3Vd6QTOdPPhrf20PnUGpZdKQOn5fTZ5P9q
         CzIVs7ViNZAH0V32h1eN+2eL4tBdsWVFOpXuEPAnPdh1+SZ9gOmJbVcZEZggHUPBLY+C
         FgbO2XNFTArsImTjXglOTl8Kvhj6YxxMNSiNvuLsyknerqiGnwi1ijmHYPSvRLZ6kV4S
         agmDmciz3lMuhDFxfVSfxnxfvGnO7ucX4YEsRkEAXXB9uFkb0YO+5CUUTTO7oow5a/AV
         Y7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151247; x=1775756047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcd/4lgcB0uGokQQTzwvk0L+mo4TeiP754iofc2dbRo=;
        b=dNUjLFwhGlGWL4gUhZkDruaWWFlkJWZeVMSfRlNsJrNnuMZjV7pfD5q8Ry8XKlSUMU
         zvwA2SYuVoZqXvg1QB1R1Sujql4DoHcTPhOf+tETpYbTHLzZ/W6BT6pXtOroYbtzunjh
         2MxD7o37y7dilVPB9xjNJ0SmJXY6U5/AtPKyAMR5U5DPgNL2gwjG5x/DhZewgz9Mw/5m
         HcfYDbmU8bIqvZ6BOxvVUfX6xryWOOllbk+/FOA/FcjeTM5NhB/QXNMbHKcNjsXPYoai
         zBiGDrBR6lxrrb0LqYnbhUU0iQ+X/lAhFhyiQp6yJPtVTygQhDKIjaQ/kpdgZkdqtmoS
         +S+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcM7HkAF7Ic6134J6+nZkoRoT7/7Gk8TPVxHfZunfLGPOm6KUqgvsjqF+edMPp1FLx/dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+EOAN3l3GZSJsM7XIHgKjVbcHJBFGLsTJMDXCnUJ7x79gol2
	HdmZJDF0tY3rwxJaRE6praihq7qo0seqDbHRzakktyYcnLoJ2VgBH2FeeBbqORSjSfvBJ2CQ4FT
	BlPgk8HCdgdyyAqXry3kWAFXPwzQCOnQFEWqWHcVR
X-Gm-Gg: ATEYQzxl5eZG77ESvwYyl33qNJsHJEs78u3KJ8/70+LEFDeggMBqTLC75iHQXCHW6Ni
	uBsiGteTM2l2NNkFOZtiiMEygTUcsPlQdm1aiMhrt6hRitFUycsLKvGiDsiIrJ0yw4HvMCd9p0G
	DL+46JQMzZnZvmOMIVM5MSvRY0NVRDR9hDvf2smOnTj8do6dXMCgiYvGUZFzyzM36S+SzVmubBP
	A8hrLisOC+gZ5VqefTxCSv+Ln/BxkrqEjSHzp1hpr1O9sEcBM39ZvxmmVtdUy8kFQTbPIc9SDp7
	RDtoN/z1dE4AMfPYkO1e0lUIIOYGnGNLe3/Ha9i13Xwnrvo=
X-Received: by 2002:a05:7022:1a85:b0:120:5719:624c with SMTP id
 a92af1059eb24-12bf0d7ca98mr116265c88.19.1775151246208; Thu, 02 Apr 2026
 10:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303193822.2526335-1-rananta@google.com> <20260303193822.2526335-9-rananta@google.com>
 <20260311235715.GA2738066.vipinsh@google.com> <CAJHc60yQjfpw9D0VoP0FAfv65g5BpVYddcWQ23q0hRLdcP2k-Q@mail.gmail.com>
 <CALzav=fkKPR1giHyvZ8Awk=OpzNk8b_xVVwt-AyuXjwGGSY4Zw@mail.gmail.com>
 <CAJHc60wUShGosroLv64M_+vQXe_d-N3d=yA7PGSWC=_PyEXL+w@mail.gmail.com>
 <CALzav=dS+4emsbXLg+JoJGMX_RtQ1uocvfEY6r5Y3VT=UQn6eQ@mail.gmail.com>
 <CAJHc60zmnYwg4jFZD5DQAU0Wyfz0ZWjwgigy60+94dRLqFb71g@mail.gmail.com> <CALzav=fJMGnF7VXUP4vGoZ2Uv3=akw2MuEBYYdWJ25+2Q92m6A@mail.gmail.com>
In-Reply-To: <CALzav=fJMGnF7VXUP4vGoZ2Uv3=akw2MuEBYYdWJ25+2Q92m6A@mail.gmail.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 2 Apr 2026 10:33:53 -0700
X-Gm-Features: AQROBzClW5MjkE0ZcnVnh5soYymdWQscAQ4HZJh-M58Tj8qdRAqmXThM8THcAsM
Message-ID: <CAJHc60wDttYyCZOn++5X66JY26gxLXP-xhZjCm8XFkvFBMTLKQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:02=E2=80=AFAM David Matlack <dmatlack@google.com> =
wrote:
>
> On Wed, Apr 1, 2026 at 5:17=E2=80=AFPM Raghavendra Rao Ananta
> <rananta@google.com> wrote:
> >
> > On Wed, Apr 1, 2026 at 4:51=E2=80=AFPM David Matlack <dmatlack@google.c=
om> wrote:
> > >
> > > On Wed, Apr 1, 2026 at 4:46=E2=80=AFPM Raghavendra Rao Ananta
> > > <rananta@google.com> wrote:
> > > >
> > > > On Tue, Mar 31, 2026 at 5:11=E2=80=AFPM David Matlack <dmatlack@goo=
gle.com> wrote:
> > > > >
> > > > > On Tue, Mar 31, 2026 at 4:53=E2=80=AFPM Raghavendra Rao Ananta
> > > > > <rananta@google.com> wrote:
> > > > >
> > > > > > > > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > > > > > > > +{
> > > > > > > > +     char *vf_driver;
> > > > > > > > +     int nr_vfs;
> > > > > > > > +
> > > > > > > > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > > > > > > > +     if (nr_vfs <=3D 0)
> > > > > > > > +             SKIP(return, "SR-IOV may not be supported by =
the PF: %s\n", pf_bdf);
> > > > > > > > +
> > > > > > > > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > > > > > > > +     if (nr_vfs !=3D 0)
> > > > > > > > +             SKIP(return, "SR-IOV already configured for t=
he PF: %s\n", pf_bdf);
> > > > > > > > +
> > > > > > >
> > > > > > > If there is a test failure (ASSERT) then fixture cleanup will=
 not run
> > > > > > > leaving SR-IOV enabled and all subsequent tests will skip.
> > > > > > >
> > > > > > > Since this test is specific to SR-IOV and user is intentional=
ly passing
> > > > > > > a device to test, I think we can just reset the VFs to 0 befo=
re
> > > > > > > proceeding instead of skipping.
> > > > > > >
> > > > > > The idea was to eliminate the assumption that if 'sriov_numvfs'
> > > > > > returns > 0, someone else might be using it. This is based on D=
avid's
> > > > > > suggestion: https://lore.kernel.org/all/aQzcQ0fJd-aCRThS@google=
.com/ .
> > > > > > Moreover, the device might be in a partial state. So, even if t=
he next
> > > > > > test proceeds, it could fail due to other reasons.
> > > > > >
> > > > > > But I see your point about cleanup on failure. I think this is =
a
> > > > > > common issue across all tests. Was the expectation that we rely=
 on
> > > > > > cleanup.sh to take care of all the cleanups, regardless of test
> > > > > > pass/failure?
> > > > >
> > > > > I think we rely on the fact that test cases run in sub-processes =
and
> > > > > so if there is a failure in fixture setup then the child process =
exits
> > > > > and all vfio and iommufd fds are cleaned up. So the device is sti=
ll
> > > > > "clean" for the next test.
> > > > >
> > > > > However if we are modifying system state like the number of VFs
> > > > > enabled on a device, I think Vipin is right we need to clean up a=
fter
> > > > > ourselves if the error occurs in fixture setup.
> > > >
> > > > In that case, since the FIXTURE_TEARDOWN() is not invoked for a
> > > > failure in FIXTURE_SETUP(), the test must install its own cleaning
> > > > handler. Using conventional error handling with goto labels might a=
lso
> > > > be tricky because the sysfs lib contains ASSERTs. Even if we do res=
et
> > > > sriov_nrvfs and exit, since the failure is in FIXTURE_SETUP(), it's
> > > > highly likely that it's going to fail again.
> > > >
> > > > Since we need the VF creation only once, shall we simply do this se=
tup
> > > > in main()?
> > > >
> > > > int main()
> > > > {
> > > >   pf_bdf =3D vfio_selftests_get_bdf(&argc, argv);
> > > >   vf_bdf =3D setup_vf(pf_bdf); // Do all the sysfs stuff here
> > > >   ret =3D test_harness_run(argc, argv);
> > > >   destroy_vf();
> > > >
> > > >   return ret;
> > > > }
> > > >
> > > > Another possible way is to expose the VF from setup.sh itself and p=
ass
> > > > it as an arg to the test.
> > > >
> > > > WDYT?
> > >
> > > Creating and destroying VFs in main() outside of the test harness
> > > sounds like a good solution to me.
> >
> > Gah.. thinking this through, since we use ASSERTs in sysfs setup, we'd
> > still have problems with 'goto label' like error handling. If it's not
> > getting too complicated, I can set up an exit handler (say via
> > exitat()) and destroy VFs there.
>
> That sounds reasonable. Doing the setup in a child process would be
> another viable approach.

Yeah, the latter approach is also a good idea. But I went with the
former in v7 so we would set up and destroy the VF only once, instead
of 45 times (once per sub-test), which also increases testing time
slightly.

Thank you.
Raghavendra
