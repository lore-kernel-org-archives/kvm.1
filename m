Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488902D47F1
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145771; cv=pass; b=F7MNqhvLu2YOovs6NGCQvUzF5A79etIc+ToiGv1awuYuVV2o+mZmV/Y5LCp+9s0ul21WjG40Jh32S2vI90SndI47WQC4FFAMSKmOzSQSofiII4Ny/Z/Xm1Ngcztmt4m0y7FYaGbljwCGaZsZppklUCerYPS6UOZ7Ou004v2UojM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145771; c=relaxed/simple;
	bh=1jdFZmsHHfXVFzPN1tjnITp19qChADYZ8X7dYKz3ccg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw/nut6QXo3j1iAvntFy7BcRYSzyhSHolHGxchA4pimeZFtSLV5y0AC2ShisjkzBBZRWa68pxXHB/mVoiC/qTpYHBkxQ/DTOeqkQOk7yZFh+/uouP6gynuQexwathl0I9ZMZUCyUI7t2oPLz/KzGg/bqw9ycNxf+6j93c0nJrpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMmajeuy; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMmajeuy"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2853b1f8cso1089851e87.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 09:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775145768; cv=none;
        d=google.com; s=arc-20240605;
        b=KdpmXc8nlhfrBQEFXiwSd0593/yLYCanV/J+BuXySICJ8pQHio2/7sEtwWIDwJmqJ0
         fTR4d5SyYT/pwO3HKQZgcynK9gvnmzjaJLJPJSkq+I31WjvRm4W0urWeBRU/hTOsHVOQ
         Eykj55Y74X9+1H4zsafPtTYTxOL35hLNE9t9FDcSUqFsSGm4fF5/fACFOA16m+Y728rz
         rrJiFNL86OVKSMwGWbX6A/SOl0AyDieV7BC+yqvpmUJvE0ItRb+d0zwqgMk6k8YCRRSi
         AK3VV4g/qybpeDZLQyb0bS8oMJv/Zw47jZS+81SZ/dfM6NvT6xSR61PnSF3hr8tSCUUy
         5fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6/4BP8YWmA9cbnXiJZYUEYNLwj97H48ufLk6ZQB7n8E=;
        fh=PKEsU9zVl1HJniHmYgxdAOnTayzUPwaqJsa3V/3g7Xo=;
        b=YIalAQNO72EF+mP4moO92wDpjKlJUWhOyfAIdc7K8ZuWU1EdOpKlTkoycunxaQ7LMB
         cdU4OL8F/9JY48jnohXWWQPV6gD956G+cTJEh7A5KzFdPxiCXzHRyOTf5BJLRduDlPEI
         TE77dI0i7Rm6E9di6iV/WNsn/3ELD6SRa6og+lVj/UuZg0Y4rZn8zUrxKT7YOf2k58Io
         JtBxo0L3cssr/Wk68JcT0kppLwvMnDGt1qPvIxHifGD9QapViHkZL55zOf68+PfQ6psg
         Y1EfgJ4TMSJZD62qpOz7m7zstobsptw9/7pTRidyBY92q7IXvPpWCqNkJ/girx9o65CL
         RkIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775145768; x=1775750568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/4BP8YWmA9cbnXiJZYUEYNLwj97H48ufLk6ZQB7n8E=;
        b=fMmajeuyZ1AgcGwVx/bFBHujxYCJn7DjJePN5V1L3SROZWBujbRkbb2qS98N1hHuvm
         h48a4csQoVp/ZAqBE9WFY0i8dTJHusXww1Jgt9odU6HjPi3klUajfCNxuToxZPitlmOq
         NuqsfguvnvwrNkkOq9yJ7dNhXtpWFw7fgWywqwPm7D4RoJNEabIzLafSyE8bYKFc0hLH
         lgF6v219la5m4V6zQTg+PjRjXSpA3xIXxXjekdeJERdCH1jurszaytdq/UqkmvfshxgE
         B013HUllRAYJZ7dDf0LqWi3cQXDUxYuHQH7VY1nltHQkWVyZzRD6sR6/Tl4rSFHHZYMC
         lQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145768; x=1775750568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/4BP8YWmA9cbnXiJZYUEYNLwj97H48ufLk6ZQB7n8E=;
        b=ExSC8+565lXhqSMyPvuIHrvwDb98C6gpNbspjKR2cAHmEg1KEPi7pN+H6rl1FHl/Wm
         7yv8+rJVEosJrRwTCDRPg3g5Fm9NTHzjF6msY7+okgJ61NRnSLMZEHyqGb1/6OSDasAl
         bTjVCsN2Na57R7QcvyjPOyZafK3zmPD+qiEmIImozG5kZbdR0/PE/Lao6Tty/8YqksIf
         hKkFGzlFf1/AIQO5xLk2zIHkytKEHmG3zRg7qnaGkIjXVjjdx2swHhOo6g6tQderKRlU
         PYnQQ8yOdYXYaNcSiowGsy7/cOVXC0ZwnTuCTLYsteZy6HUDRtA2TTdbN7F1Su+e9H7T
         n2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU67J2LtpBN+Hjf16mxI13CMsUOEdJTUA3UM573MDIBTSNI9OkiXsXOwsJ5xWZ7m2XmybE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdR7iNAIvP2TktaXiBaeDUiTqSCxlCQDZlWBUGxDnbrKUfWrVv
	JvruxOZzFm2JwcT4XmFCIWB5ddAwU/DYaDYq37E6gQFSligZAYdr0w2kiVOZbdRra3g5yQqJZ16
	UL1ZJIBV6gA6tOijHRuTqzrYPEyQ6Whh2nsLY48dkOOKWcGfl2AeuLIML
X-Gm-Gg: ATEYQzz/000Ih11FK/bQOvGpB5sLJeNfRP16Cu5tO5g0UuctsSoZ819OXxTwS6dpIrK
	E1mdOnYD2rLVXXUqsxA4XWL6zxJHXb5esPOKicO5Tm0+3liZiVpYoatuD4AnOmqD3XrGA3X0AY5
	QdJgaRjkKr2/BHe+Trad7O5chdedH/ZFNRCYKdSUVowYjJrzTlfrZ3isjbs5YtjB0RWKGddRCOp
	LMSQFiFkVjPKCZGKvFW2X9eVaGbfPHFFpCeaMPiXQ40Ub+A99WPYMhhO6+sloOp2dvpV2dXjGMe
	ainF7+eB
X-Received: by 2002:a05:6512:3190:b0:5a2:a5f6:dfce with SMTP id
 2adb3069b0e04-5a2c1eec643mr3205470e87.11.1775145767959; Thu, 02 Apr 2026
 09:02:47 -0700 (PDT)
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
 <CALzav=dS+4emsbXLg+JoJGMX_RtQ1uocvfEY6r5Y3VT=UQn6eQ@mail.gmail.com> <CAJHc60zmnYwg4jFZD5DQAU0Wyfz0ZWjwgigy60+94dRLqFb71g@mail.gmail.com>
In-Reply-To: <CAJHc60zmnYwg4jFZD5DQAU0Wyfz0ZWjwgigy60+94dRLqFb71g@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 2 Apr 2026 09:02:18 -0700
X-Gm-Features: AQROBzCQSyxEdq3CG5OfBQZWZIHfqofCp6NsVT72cZV7KXrBzvpuv7k0IGoh2HM
Message-ID: <CALzav=fJMGnF7VXUP4vGoZ2Uv3=akw2MuEBYYdWJ25+2Q92m6A@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:17=E2=80=AFPM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> On Wed, Apr 1, 2026 at 4:51=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
> >
> > On Wed, Apr 1, 2026 at 4:46=E2=80=AFPM Raghavendra Rao Ananta
> > <rananta@google.com> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 5:11=E2=80=AFPM David Matlack <dmatlack@googl=
e.com> wrote:
> > > >
> > > > On Tue, Mar 31, 2026 at 4:53=E2=80=AFPM Raghavendra Rao Ananta
> > > > <rananta@google.com> wrote:
> > > >
> > > > > > > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > > > > > > +{
> > > > > > > +     char *vf_driver;
> > > > > > > +     int nr_vfs;
> > > > > > > +
> > > > > > > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > > > > > > +     if (nr_vfs <=3D 0)
> > > > > > > +             SKIP(return, "SR-IOV may not be supported by th=
e PF: %s\n", pf_bdf);
> > > > > > > +
> > > > > > > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > > > > > > +     if (nr_vfs !=3D 0)
> > > > > > > +             SKIP(return, "SR-IOV already configured for the=
 PF: %s\n", pf_bdf);
> > > > > > > +
> > > > > >
> > > > > > If there is a test failure (ASSERT) then fixture cleanup will n=
ot run
> > > > > > leaving SR-IOV enabled and all subsequent tests will skip.
> > > > > >
> > > > > > Since this test is specific to SR-IOV and user is intentionally=
 passing
> > > > > > a device to test, I think we can just reset the VFs to 0 before
> > > > > > proceeding instead of skipping.
> > > > > >
> > > > > The idea was to eliminate the assumption that if 'sriov_numvfs'
> > > > > returns > 0, someone else might be using it. This is based on Dav=
id's
> > > > > suggestion: https://lore.kernel.org/all/aQzcQ0fJd-aCRThS@google.c=
om/ .
> > > > > Moreover, the device might be in a partial state. So, even if the=
 next
> > > > > test proceeds, it could fail due to other reasons.
> > > > >
> > > > > But I see your point about cleanup on failure. I think this is a
> > > > > common issue across all tests. Was the expectation that we rely o=
n
> > > > > cleanup.sh to take care of all the cleanups, regardless of test
> > > > > pass/failure?
> > > >
> > > > I think we rely on the fact that test cases run in sub-processes an=
d
> > > > so if there is a failure in fixture setup then the child process ex=
its
> > > > and all vfio and iommufd fds are cleaned up. So the device is still
> > > > "clean" for the next test.
> > > >
> > > > However if we are modifying system state like the number of VFs
> > > > enabled on a device, I think Vipin is right we need to clean up aft=
er
> > > > ourselves if the error occurs in fixture setup.
> > >
> > > In that case, since the FIXTURE_TEARDOWN() is not invoked for a
> > > failure in FIXTURE_SETUP(), the test must install its own cleaning
> > > handler. Using conventional error handling with goto labels might als=
o
> > > be tricky because the sysfs lib contains ASSERTs. Even if we do reset
> > > sriov_nrvfs and exit, since the failure is in FIXTURE_SETUP(), it's
> > > highly likely that it's going to fail again.
> > >
> > > Since we need the VF creation only once, shall we simply do this setu=
p
> > > in main()?
> > >
> > > int main()
> > > {
> > >   pf_bdf =3D vfio_selftests_get_bdf(&argc, argv);
> > >   vf_bdf =3D setup_vf(pf_bdf); // Do all the sysfs stuff here
> > >   ret =3D test_harness_run(argc, argv);
> > >   destroy_vf();
> > >
> > >   return ret;
> > > }
> > >
> > > Another possible way is to expose the VF from setup.sh itself and pas=
s
> > > it as an arg to the test.
> > >
> > > WDYT?
> >
> > Creating and destroying VFs in main() outside of the test harness
> > sounds like a good solution to me.
>
> Gah.. thinking this through, since we use ASSERTs in sysfs setup, we'd
> still have problems with 'goto label' like error handling. If it's not
> getting too complicated, I can set up an exit handler (say via
> exitat()) and destroy VFs there.

That sounds reasonable. Doing the setup in a child process would be
another viable approach.
