Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584F78F26
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089071; cv=pass; b=ZlQh27DWup5VMXeHxNMTscgMX/bET/kAN5wFt4bFu86npASYYEW7rPOR1TM9TNFmZENZt+GKtiUcNPv7vQ0icWHFslgzBQIxLr0hwDlbaou6vD5zHMv5mcut+frVv6FXw7NM66Np+aFsuUKeFCST7YjQAm8zgRlzyh2gIpYmhuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089071; c=relaxed/simple;
	bh=Xx2XLbKS8Zk9kBbhJ0d+CQnT50VHDG3yvs10dIgOatc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmHLMA+p6UCzGMHP6ELy5mNTVQJm1rcXwE+XEIZDbE7OLDDcrpoekebbSMs4Jpg6sGw3Cv9tWrHy1DEL3Ilv9R6gZ1riR2W5jh4yS61mKkQtsd30waBXiCMemYYp5oA98lavDozsrStucuxk0lF0DO/eGxd5HsL/2yzh6LW7u70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsSWs3gE; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsSWs3gE"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50b6c45781aso308891cf.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 17:17:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775089069; cv=none;
        d=google.com; s=arc-20240605;
        b=jr9x/FPN03hi6TmqaejyqmYGTI/dSePWNyJu5n0UwSdpVqSB1pH6CeJryY2pxphYew
         bjIgA1d6TdTpriWGIMTYmTS8xOv9cXaYwkhhWhcIwCHBaP8WTme0bYh3cu/TVttXHGmg
         NC4nuy1mjWdV2+Kt0dE5wk/4X/4NH6b15xnT915pnDCEi71aNHFJ5AF/eS2n2s6MsYpM
         UtqE8lOBIeQnZAriwDPaTALov/2tsygGJ3UwrUlL5YmzZKjzrX44vVyRwktCdVHJwEeY
         3gPjRiGERazkalbaFKmIkUrczgij8qcI5I15GAgxKCHZSBRNO6rOmy7yvwooffEqUjlp
         sx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XaXp/6khXbzGh8S95Ys1JHV/6w/rASl+d+sNNjFsjXI=;
        fh=Qnt/3mBGT5a1aUQQObjE/uvW9Z1ls22liGyjghJOlCg=;
        b=YVJhL0FPx7B45Wxck80cwRSjO4JA+gzTET6Ss8KeEuGeoWhBQjTrytwAEBzlX2wGwI
         Y8hDsZET3x9emt1fdsuwjx66IH5F6w64CXZlswoUK61JTRR6E6MiY3xSvjqPrjfS8K42
         vo/YQUiux2p9L8YBetZHQApnyVHlhOvzz3rryjKrVlyCcsG5fiwdr7FNdyVovOn9ptaj
         dTwXmP4BssGr8VNRPj9yEREcS45frALIGrshe57NofTbF83aWxy3Lst7MbTTa8GKYKe3
         Q4i3N9kz1hbBEiJYp/VyoavaRscLmxSTKQwYvDJxHf+fFsVofpwHeDgYwrznhp420tiq
         BXQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775089069; x=1775693869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaXp/6khXbzGh8S95Ys1JHV/6w/rASl+d+sNNjFsjXI=;
        b=MsSWs3gEWvgQva3WFfJU3XMhgLXle3jnD1ixiK0W15EP/NVQqX8xjIKA0n1rOk4NxN
         hHXTYFO/POPLrWCloZ6x/4tmV3v9f6kUweGlX9dFEDc59aVIDToJyMF+0S0Pqq5mmGvR
         ++HgHdeJ+wHdcVEfma7SnWIuE3x6o1d9SPKiltpbWTtiSzfEedvUtbmqNpltLfcExCBq
         argWr0eBCcaRQCvHFkQj7mVuLL26k5j7kp5G1G8wVS/WB3DW2esEyDj4dTuybme1G5Fr
         VcvEfunB7rHcOdl/6Yl0i82ZRTtrNXiMDsnOpalsc/ItFLg/4vzmnSs60MYlOa0kV89p
         Kmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089069; x=1775693869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XaXp/6khXbzGh8S95Ys1JHV/6w/rASl+d+sNNjFsjXI=;
        b=QswTdrVslD/Fg0zyztQ7k5sAV3xLFiG2jPiBiMFD6026LEXVLKTwLQIh81rduqGP1Y
         Ru4EI5fghhO6/uft06JPrbViw7i6lT3h7/RltLVV5e8fSje0OhSJOMuDSBYC2KKQG1Qu
         jVn0boXHIWhqwLe711hU4I70Yusrf7BLkZQQL793eJp/WdOn8Dhrmz/lI8YrTZFXbBA8
         WkjJJTio2bbsv+bsW60wCSDsMehTyvM2wMZhrbph3/dth0SiyfCDz0aEn5TBhaPFSMQq
         cEXoSPyBSmElya4bbe6VPtq6X4ik+IyRKqYfXqYCjnaI//xzmcnjhzYtH9pQ0NG3TO1D
         TcIA==
X-Forwarded-Encrypted: i=1; AJvYcCXblD2WWJzKz9dtMNFXHdIZCpPHHQLV6OsqIIkw+MNnuCL+x6zulSFT50WMj6O8sQwcsaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbLjLYWOHPSpH7a6NUQi2bczM557Sm62LQdD0j2vkgBzz5aDzW
	YVFc56vPV7OsG/H34mjP3Dk8LAx8SXZqb2cW9jOk3grUt629U4YIRhR72JqOXmeTIOJzjdaFXfG
	VUiHPiQC1DkOGyLINLbzRTunor6TPNuaRoEVDtceB
X-Gm-Gg: ATEYQzwPkKPTgHmArPqaQoZbgTgryzX/+uOODq0XsN6NW4vYK6BZMVammXos6p2JWcd
	JtQaOKfqi0tQ2zXs5H2j4N22/HxbP6mb6P/XmFMPV9kQmLD4BLwFnvcl5WCFKEh9tLz7Yy6CPI4
	I7wPNz5myV2soJqkMJzxqNE6TcsEAS7bc0Xe08Pk8ZTnemCLmDq3qdFHtHFK4WQT/p0uzyLnnBp
	rrGzZYjYKE0N/VA4q5vD/KgWpKzgIsAhkZdpLBUhHGAIvlrrQx6QSfwIoJayJlM2KbTd3iKuxCH
	kzkLy/xV
X-Received: by 2002:a05:622a:4204:b0:509:25c5:42b4 with SMTP id
 d75a77b69052e-50d507aabc6mr1517261cf.13.1775089068494; Wed, 01 Apr 2026
 17:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303193822.2526335-1-rananta@google.com> <20260303193822.2526335-9-rananta@google.com>
 <20260311235715.GA2738066.vipinsh@google.com> <CAJHc60yQjfpw9D0VoP0FAfv65g5BpVYddcWQ23q0hRLdcP2k-Q@mail.gmail.com>
 <CALzav=fkKPR1giHyvZ8Awk=OpzNk8b_xVVwt-AyuXjwGGSY4Zw@mail.gmail.com>
 <CAJHc60wUShGosroLv64M_+vQXe_d-N3d=yA7PGSWC=_PyEXL+w@mail.gmail.com> <CALzav=dS+4emsbXLg+JoJGMX_RtQ1uocvfEY6r5Y3VT=UQn6eQ@mail.gmail.com>
In-Reply-To: <CALzav=dS+4emsbXLg+JoJGMX_RtQ1uocvfEY6r5Y3VT=UQn6eQ@mail.gmail.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Wed, 1 Apr 2026 17:17:36 -0700
X-Gm-Features: AQROBzBtyV05quHyEyHtQdNo68XIdslJp4UChRV2JizBSERHY3quhSx6z-NhDpI
Message-ID: <CAJHc60zmnYwg4jFZD5DQAU0Wyfz0ZWjwgigy60+94dRLqFb71g@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 4:51=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On Wed, Apr 1, 2026 at 4:46=E2=80=AFPM Raghavendra Rao Ananta
> <rananta@google.com> wrote:
> >
> > On Tue, Mar 31, 2026 at 5:11=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 4:53=E2=80=AFPM Raghavendra Rao Ananta
> > > <rananta@google.com> wrote:
> > >
> > > > > > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > > > > > +{
> > > > > > +     char *vf_driver;
> > > > > > +     int nr_vfs;
> > > > > > +
> > > > > > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > > > > > +     if (nr_vfs <=3D 0)
> > > > > > +             SKIP(return, "SR-IOV may not be supported by the =
PF: %s\n", pf_bdf);
> > > > > > +
> > > > > > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > > > > > +     if (nr_vfs !=3D 0)
> > > > > > +             SKIP(return, "SR-IOV already configured for the P=
F: %s\n", pf_bdf);
> > > > > > +
> > > > >
> > > > > If there is a test failure (ASSERT) then fixture cleanup will not=
 run
> > > > > leaving SR-IOV enabled and all subsequent tests will skip.
> > > > >
> > > > > Since this test is specific to SR-IOV and user is intentionally p=
assing
> > > > > a device to test, I think we can just reset the VFs to 0 before
> > > > > proceeding instead of skipping.
> > > > >
> > > > The idea was to eliminate the assumption that if 'sriov_numvfs'
> > > > returns > 0, someone else might be using it. This is based on David=
's
> > > > suggestion: https://lore.kernel.org/all/aQzcQ0fJd-aCRThS@google.com=
/ .
> > > > Moreover, the device might be in a partial state. So, even if the n=
ext
> > > > test proceeds, it could fail due to other reasons.
> > > >
> > > > But I see your point about cleanup on failure. I think this is a
> > > > common issue across all tests. Was the expectation that we rely on
> > > > cleanup.sh to take care of all the cleanups, regardless of test
> > > > pass/failure?
> > >
> > > I think we rely on the fact that test cases run in sub-processes and
> > > so if there is a failure in fixture setup then the child process exit=
s
> > > and all vfio and iommufd fds are cleaned up. So the device is still
> > > "clean" for the next test.
> > >
> > > However if we are modifying system state like the number of VFs
> > > enabled on a device, I think Vipin is right we need to clean up after
> > > ourselves if the error occurs in fixture setup.
> >
> > In that case, since the FIXTURE_TEARDOWN() is not invoked for a
> > failure in FIXTURE_SETUP(), the test must install its own cleaning
> > handler. Using conventional error handling with goto labels might also
> > be tricky because the sysfs lib contains ASSERTs. Even if we do reset
> > sriov_nrvfs and exit, since the failure is in FIXTURE_SETUP(), it's
> > highly likely that it's going to fail again.
> >
> > Since we need the VF creation only once, shall we simply do this setup
> > in main()?
> >
> > int main()
> > {
> >   pf_bdf =3D vfio_selftests_get_bdf(&argc, argv);
> >   vf_bdf =3D setup_vf(pf_bdf); // Do all the sysfs stuff here
> >   ret =3D test_harness_run(argc, argv);
> >   destroy_vf();
> >
> >   return ret;
> > }
> >
> > Another possible way is to expose the VF from setup.sh itself and pass
> > it as an arg to the test.
> >
> > WDYT?
>
> Creating and destroying VFs in main() outside of the test harness
> sounds like a good solution to me.

Gah.. thinking this through, since we use ASSERTs in sysfs setup, we'd
still have problems with 'goto label' like error handling. If it's not
getting too complicated, I can set up an exit handler (say via
exitat()) and destroy VFs there.
