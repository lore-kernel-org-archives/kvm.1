Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE636493F
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087475; cv=pass; b=tplj1bQvFcKwtFt1uMQw+JyrgHlX4MkNwrve4htvQhydn5+3fF6QZ3nCAxQOfp/dIAApisNblHs+asPSbCJMv3z6mglWFwYxdnGnakxA8N/BobV/hrclemVX0s/94odz1bzyno3eWRHWTyyWQVpiMJlvqQgZTwBKrzzljJcOMVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087475; c=relaxed/simple;
	bh=yzjtUkfkiMnp1+jnYEQszUfxDN2987B+o/b9DTHb5fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvVQ8IiLEPgy2vqW1JQ/yrHrP5spuyKccC7o7p4NjwkBDWVFIGYuBH2256ohW6daltE3aewUoMuXl+llLDXiJ6G8DV2jaYOvk4tXbebj4o9sZs8/vaabU14sOZHboqyzXigXq0GcgMNuoElCrDE2pUTHHb3embLr0pOkvS5sOMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QeD2awcW; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeD2awcW"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38b13652c87so3170141fa.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 16:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775087472; cv=none;
        d=google.com; s=arc-20240605;
        b=HCosPw6ZpRUOsnVptZzndnVFhzsSJo/t82YYsTQvgPMdRVQ56nY49vvQqach8/VzWk
         63JKue4gkc8DnbN9ujR/lG7eQqlGQVBusV9mp0eq12m1bS759As/bpORs2JkGBPxH0DM
         l7t70YWoxAossck4iGzlmRco+pjs25mmC43Muo7CEhR708Bcb1q4sawS7vcrzq8ES4l/
         dpX7NxM0i8BsAdZiKd6+NgTRvGHxk8U0xMQQxy7rXH8YfRVVMDKaTiHYygxuF5znO0wA
         86S7lrJEUaiWyKOSMNhMyqXZBba6tbPUvFsRMxXaRFJMDelUovRcvEohaw5T4A7VIrBS
         J9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KrtPc1BoZKzf+l9BeRZJghfFWfe/poRp7LJs2i1Q0GA=;
        fh=D9+0oKKI02G9hFABkgt2VPermnBQI76X0AB010iXeEo=;
        b=afx8qlclKINnMgOJ7GvZ5Bo5I/V5wNMwJ6bzOdBLvoXgDEFaZzlab9CuuX8VcGakdS
         CEqXYTPiYbOdJuu/cm1oLgYfEbWFFTbCbwnJw7HvsmiZS2WrkuzrV9TEOFxDZuxHitXS
         fmc8kc9Pfb5AMp5Nc5llc6cDv7s9hQB4PZATulba59WhKn+4J97KwmdCNMibqRvDDR/H
         QzAZjL9VNK+OoekFSOsPgm5Ag8Sq/arZRWqA1AbJcXU5HRm4ngM5yxQkoBOBBvAU3KrW
         96gM5g0zcqj8odWdTsgpyTJx7PWZBPblCd7Nl40GPfn7iH+ROn89IBDWb3if+IfwCRyT
         GoCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775087472; x=1775692272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrtPc1BoZKzf+l9BeRZJghfFWfe/poRp7LJs2i1Q0GA=;
        b=QeD2awcWlUpAoKmUdiSOIYjp4oiJWS0NhME6RllF4WkbqnvOyUPY/t8HWZngy83l5s
         OgyiI+67BCet+ZnldGlZpd4CjyeV/NlYnC7kr+bd/2Ag9Bv1s+b4otmOl1XIek8ruSyy
         Yyu/yQN7LBUTuwZXm9PGpJe0pW/uBEEUu5q/0a8QIXFOSeix0UfvBAorjc3DsYCC2BUb
         IoQ6dawkQL8JtC1irKQU5GsCHJppadcvmf6/Tx4qUzx2FQsLVcQQSQFQGuy+Fzdir/EX
         MNIHanmNtNuLJu9XFrw7z0JFRl8DGBgdUBKSEq4VQbtWycWTIZjghYgj3w1QMtm3xY9l
         AvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775087472; x=1775692272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrtPc1BoZKzf+l9BeRZJghfFWfe/poRp7LJs2i1Q0GA=;
        b=qlFeX5D7Ksn2zd40n9lxk6yPr6i6UEcRjQNAbeJQ9Ue/X/ADxHWoV70gTtUVSutkCD
         2TgqKhKLMNaEwylwXtv01FWIw+umeuo6GMPqtbMbSmKp75MJf358FNj3hlO2gsc++3gz
         Kgx9ZC5mNVPJV4WLHlc9WN0Bp+gcu1IZxhJ0ide37FOiNsu2HsODKXUm47MsV8jojW8x
         A6u2IW4MjCX7S9FM4nxt7CAqLkxvYZpJc3hO3dsd4n/iVn/t7LlWzGFtLuRLDtDxONtZ
         Q4Lb5qa/WaqnOxPfTYRr6qXI2D/3vlZZZlcJnKZQpMvyvzASoJhKPLvh2ZCpQAUrLLj9
         W7bg==
X-Forwarded-Encrypted: i=1; AJvYcCXvZCr2T7ihDqSCMgO+1C09bI20h/EegsYO9urlw4fdjfsZzj9G2j0smfOKE84pBayO8m0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/jg2rGLEOeagb5E22vtQWbyK+3Tq6DS6qXdVWKHqP2bmj/gH
	tWhNRKotULwG4BBkSVOuVFhJlhVFmsc379X7V5uBvsfSD2byPT3A2kHRtGDB+X1M23YCOXgcSB+
	x2Q8sp+m0SJEnhxvtmWj6VWM1GY38imAQxbJQB2sG
X-Gm-Gg: ATEYQzxBAjTrQxTvFyrRJztgPK0AGAcvbJ2F9S4+kKCGE+9iB1Izer/709fi1HhpP3e
	/TC6lMLOZEdUJkgBjm4xZMp69+ZosEZ0m7g5zKiUI9EsrsuGnBEmF0GH8OqvZ6Ds/5WScI3JkV2
	k4pwoTUsLHQ6FQsD/KSJdH/Y8vC5HhgHVxwZI1alOqWhgVeA0nwZWnsGlkP3ovb7Yob+hfOs+/W
	qqfl/woSsdMoundQBdQcJw1O52eFGT4ICiyGPWIlI0gPQ0KerO9tMB2ppyiF7G3jPALsAt/Dq6R
	rD28FGSX
X-Received: by 2002:a2e:3801:0:b0:38a:212d:2bc2 with SMTP id
 38308e7fff4ca-38cc30bc722mr15162431fa.30.1775087471480; Wed, 01 Apr 2026
 16:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303193822.2526335-1-rananta@google.com> <20260303193822.2526335-9-rananta@google.com>
 <20260311235715.GA2738066.vipinsh@google.com> <CAJHc60yQjfpw9D0VoP0FAfv65g5BpVYddcWQ23q0hRLdcP2k-Q@mail.gmail.com>
 <CALzav=fkKPR1giHyvZ8Awk=OpzNk8b_xVVwt-AyuXjwGGSY4Zw@mail.gmail.com> <CAJHc60wUShGosroLv64M_+vQXe_d-N3d=yA7PGSWC=_PyEXL+w@mail.gmail.com>
In-Reply-To: <CAJHc60wUShGosroLv64M_+vQXe_d-N3d=yA7PGSWC=_PyEXL+w@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 1 Apr 2026 16:50:43 -0700
X-Gm-Features: AQROBzAa-OL6cm9pjYX4FsodMS92uETdidHj5Zi3X3d1bOUQgTJZa2-8JRb8NHQ
Message-ID: <CALzav=dS+4emsbXLg+JoJGMX_RtQ1uocvfEY6r5Y3VT=UQn6eQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:46=E2=80=AFPM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> On Tue, Mar 31, 2026 at 5:11=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On Tue, Mar 31, 2026 at 4:53=E2=80=AFPM Raghavendra Rao Ananta
> > <rananta@google.com> wrote:
> >
> > > > > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > > > > +{
> > > > > +     char *vf_driver;
> > > > > +     int nr_vfs;
> > > > > +
> > > > > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > > > > +     if (nr_vfs <=3D 0)
> > > > > +             SKIP(return, "SR-IOV may not be supported by the PF=
: %s\n", pf_bdf);
> > > > > +
> > > > > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > > > > +     if (nr_vfs !=3D 0)
> > > > > +             SKIP(return, "SR-IOV already configured for the PF:=
 %s\n", pf_bdf);
> > > > > +
> > > >
> > > > If there is a test failure (ASSERT) then fixture cleanup will not r=
un
> > > > leaving SR-IOV enabled and all subsequent tests will skip.
> > > >
> > > > Since this test is specific to SR-IOV and user is intentionally pas=
sing
> > > > a device to test, I think we can just reset the VFs to 0 before
> > > > proceeding instead of skipping.
> > > >
> > > The idea was to eliminate the assumption that if 'sriov_numvfs'
> > > returns > 0, someone else might be using it. This is based on David's
> > > suggestion: https://lore.kernel.org/all/aQzcQ0fJd-aCRThS@google.com/ =
.
> > > Moreover, the device might be in a partial state. So, even if the nex=
t
> > > test proceeds, it could fail due to other reasons.
> > >
> > > But I see your point about cleanup on failure. I think this is a
> > > common issue across all tests. Was the expectation that we rely on
> > > cleanup.sh to take care of all the cleanups, regardless of test
> > > pass/failure?
> >
> > I think we rely on the fact that test cases run in sub-processes and
> > so if there is a failure in fixture setup then the child process exits
> > and all vfio and iommufd fds are cleaned up. So the device is still
> > "clean" for the next test.
> >
> > However if we are modifying system state like the number of VFs
> > enabled on a device, I think Vipin is right we need to clean up after
> > ourselves if the error occurs in fixture setup.
>
> In that case, since the FIXTURE_TEARDOWN() is not invoked for a
> failure in FIXTURE_SETUP(), the test must install its own cleaning
> handler. Using conventional error handling with goto labels might also
> be tricky because the sysfs lib contains ASSERTs. Even if we do reset
> sriov_nrvfs and exit, since the failure is in FIXTURE_SETUP(), it's
> highly likely that it's going to fail again.
>
> Since we need the VF creation only once, shall we simply do this setup
> in main()?
>
> int main()
> {
>   pf_bdf =3D vfio_selftests_get_bdf(&argc, argv);
>   vf_bdf =3D setup_vf(pf_bdf); // Do all the sysfs stuff here
>   ret =3D test_harness_run(argc, argv);
>   destroy_vf();
>
>   return ret;
> }
>
> Another possible way is to expose the VF from setup.sh itself and pass
> it as an arg to the test.
>
> WDYT?

Creating and destroying VFs in main() outside of the test harness
sounds like a good solution to me.
