Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0037AA97
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595075; cv=pass; b=jRRmS2ldz+nmxGoqjw1+oiAoetgSE4/n9AWTc8MWHjWkI5sBk4F5EIGDbjUOgTDhyoiQKYcRWR01s5FbHm+WBOyXGgn0Bi2h2Stx0/kNpc/BN1Q2xvphImfv9st8cXu0zZ6HY9CHQWSom24pI3ap6lnmahU8ESHhQjiW24E2lNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595075; c=relaxed/simple;
	bh=qw1i/kNUgFCOk8hcUsfpHQ2rxcfG8E8Z2nW2Y2fLyvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRWCdP7srgANeLlv8V9jj3wpjxy4CYq568FCx8olhlYECF0e7IdTCFlSFnmWpqZ94SB7wjyt+ksXmLG19dfyVvkxVWXlSa/crY/VXlTT1cTcdXikmJfPY16K8XrtxYbSkazLGdRzqtRDr2Fg6IMuElp22ISkN+bVm5Q3CrTJMQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dr7dV1QQ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dr7dV1QQ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d864c23bdso66931cf.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 13:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775595073; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/X4F/X83w9wVi8b32OeTS5DnJQta2CW6RFax9DH7Bjg+M7MEWwA9JSCm9NmmAxhrT
         Ej0i0L1Ew9hRlx3Ocli89ASlKoMRDpZ1K4fyiL+2jeqTaH//Cf1WYgzZBRi3MUFkltgF
         X+BXCq/sFtPxHyborrA1IHFI3zC11l455Ge3SGnrae/SYM2uSObM9ea0g3EG5bXK5skd
         EndydzjnPPivwgyUZ7wpbKsxU7gMBpZJXi1VCRYOEoVNuet+axjJCJjjZYprl6wFd06r
         p/A/fqCprsOZOyVBNWwoy3zWQZHk1mx3xbcUzTnRM8WI0Z3ZDKaLM5F7L7PTYHooOtMW
         GXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Eh35AgEHRpkv/hvOUW4lNtpWQC4FmbZCA+wbGD+GUXE=;
        fh=Wzf6xvQBbl6wOYqOzOB2OtVlOD+JYHlxv1Ytx80lqVg=;
        b=O43qg5jESdKCz7NfxpREu02ti7tiwSc9pkGLP1xlBEsdHs6AaPbN4DTEIyEB0BOjqQ
         PPMCHoIf9rAmww8ApzK9R32G320TkehsgghoiaQBt80Ch+BADAl4gEIjvgLW7akpJM7V
         4V+d1kilJ5ea0UimTttVpGvtoWJwFM+jUmPM/OWU5jivk0YMrBmc484nhqAO0J+kRtRx
         I7Oo3w7LJgDiggH0+XIlx8/WSTKoKenDutDtIOrOUsCkO5Yx78Hpkfh4jigXGGEUzdeJ
         6l7Epmb7hAUSJuR2bpx/NnKEMAY+ssdbP/6dxeIsqGEyPdLnW28dg5Q+RjfUmCwg/T+W
         7EXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775595073; x=1776199873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh35AgEHRpkv/hvOUW4lNtpWQC4FmbZCA+wbGD+GUXE=;
        b=dr7dV1QQwPOoMD13I/YGtFSFAfSD7W9V/GQ0ENpV3XtqylxU9HvyqvjzsqpE0QeKR7
         vTo4CWcx2pdtayn78eEbyY2jqd4dpqRP/C6AhE+3zmZRguogIbuAjKvV89pvxlQb2sy7
         BRY9MJQDNaTRTrNfRSBAkI/e6umR4C3fdjPe3aAYag9s4Ee2hrjQjOkwUj4UtXSb2wih
         kHq+XVLDfX9EEhDgKhGgDJGTkFF/GymuDMqs34p3MljSUd4L7UbW0ayxOlKwEo3ehe8l
         rVEn/I6yv10dfFB/Xd/0oGcCwfqVg2k/UYrSi4VU+Qf1vtKGz0Rt2RL+2R0iSbTrvhEr
         6HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595073; x=1776199873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eh35AgEHRpkv/hvOUW4lNtpWQC4FmbZCA+wbGD+GUXE=;
        b=Z/sTxlcn8P93JnW+yRU36uy0FVPKtgy4BJwkKBgBHftTHw1G1YDv7ZzDLD3j/Y3v1z
         NDpOWkaF3s75e/g+EXxjwo8+i4/NFu1c1u1YHbrgALd49Fn2/J17syyD6bZObinnz41/
         4OuPuDEfcoh4Pz6NEd3pX3X1bHFZc7Pzajbjhkwwz1hzcxKZrR+bE2AeX+XEyrzHoPrl
         iA1OX9TWRJ4rPzMiWottvUMq3Z18eefFTNQVml+pGHvLjuwrKUEDtPVJTOOmmU2HT4Lx
         t8gOtjTErLdIw5wLd8r9xV84gstGirmGRmXs2q4tWcaHp5qc9afbzfwJ+0qiGLRQEDTp
         Ul4g==
X-Forwarded-Encrypted: i=1; AJvYcCWVkpkd7dOPDI0NsZ7LT0Vgl0mFBSMmFfuUAYBZXXzHn9/mFnVrVg0jtq2wMcD51Z9mgDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzciByB4+8FSbIL1APcVZt7o9SYAvvB5zpghaWGyHB23XBVRFXJ
	VunltuKlXkkCX3u3gWdW8TEocJBZNquRhGWOTrNohwpwwJtSprD1GhzRKlOh3MazsDJ+QTkltCz
	PKoq9RPRk5FCjruR/m+8r8+0ASsSmGdkmcy/oAuM5
X-Gm-Gg: AeBDieuAC4P/OwOYra3EKymHOd9BAzYq32dg/24McKJVNi7mD++juGLm4S7ljsvpYxZ
	8wZGHd4hsyAH0qH6K873tbp5Ktg75U8CSeHVBPjojUDzQLMqYr5Gtd+ZK64NJk+yhZ75d3tgKH5
	3yKI1meGElifGZq2bxzcpq9hOzziEi3x6YdbT4Q5cOQa9rYB1ZiyDT8q0dfQNn2KNcXJdIUlLG1
	ycWzBf0KF4IHSEt5peDrSVxUfXPf4cXC+DIXccR1QhFSuh5tbbSWoENBRVgqq4iaoV1pUlr/mLQ
	Y145pFw4
X-Received: by 2002:a05:622a:5c10:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-50db3e123eemr77631cf.14.1775595072424; Tue, 07 Apr 2026
 13:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com> <20260402173059.1018805-9-rananta@google.com>
 <adQyhegJdEWuUIi4@google.com>
In-Reply-To: <adQyhegJdEWuUIi4@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 7 Apr 2026 13:51:00 -0700
X-Gm-Features: AQROBzDjxJkHCq0U6QSNxGDe9QH83Sxbpsys3LUwIMzBE9t_vuVEYFUtACYsyww
Message-ID: <CAJHc60z3gPyGHbL+HuXrCc8OiGBKfAh1MX8rqYrjeaXrrmy7pQ@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 3:24=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2026-04-02 05:30 PM, Raghavendra Rao Ananta wrote:
>
> > +/* clang-format off */
> > +FIXTURE(vfio_pci_sriov_uapi_test) {};
> > +/* clang-format on */
> > +
> > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > +{
> > +}
> > +
> > +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> > +{
> > +}
>
> Please do iommu_init() iommu_cleanup() here to reduce code duplication
> and as an added bonus you can drop the clang-format comments above.
>
I think even Vipin suggested this. Last time I tried this, IIRC got a
build error that 'variant' was inaccessible. But I guess I just had to
re-org my code to make it work.
I'll do this in v8.

> > +static void vf_teardown(void)
> > +{
> > +     /* Destroy the VF only when the main/parent process exits. */
> > +     if (getpid() !=3D main_pid)
> > +             return;
>
> Is this because the child processes created by test_harness_run() to run
> the TEST_F()s inherit the atexit() call? If so please clarify that in
> the comment in more detail.
>
Yes, that's the reason, and I assumed the comment made that clear.
I'll re-write it if required.

> > +
> > +     free(vf_bdf);
> > +     sysfs_sriov_numvfs_set(pf_bdf, 0);
> > +}
> > +
> > +static void vf_setup(void)
> > +{
> > +     char *vf_driver;
> > +     int nr_vfs;
> > +
> > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > +     if (nr_vfs <=3D 0)
> > +             ksft_exit_skip("SR-IOV may not be supported by the PF: %s=
\n", pf_bdf);
> > +
> > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > +     if (nr_vfs !=3D 0)
> > +             ksft_exit_skip("SR-IOV already configured for the PF: %s\=
n", pf_bdf);
> > +
> > +     /* Create only one VF for testing */
> > +     sysfs_sriov_numvfs_set(pf_bdf, 1);
> > +
> > +     /*
> > +      * Setup an exit handler to destroy the VF in case of failures
> > +      * during further setup at the end of the test run.
> > +      */
> > +     main_pid =3D getpid();
> > +     VFIO_ASSERT_EQ(atexit(vf_teardown), 0);
> > +
> > +     vf_bdf =3D sysfs_sriov_vf_bdf_get(pf_bdf, 0);
> > +
> > +     /*
> > +      * The VF inherits the driver from the PF.
> > +      * Ensure this is 'vfio-pci' before proceeding.
> > +      */
> > +     vf_driver =3D sysfs_driver_get(vf_bdf);
> > +     VFIO_ASSERT_NE(vf_driver, NULL);
> > +     VFIO_ASSERT_EQ(strcmp(vf_driver, "vfio-pci"), 0);
> > +     free(vf_driver);
> > +
> > +     printf("Created 1 VF (%s) under the PF: %s\n", vf_bdf, pf_bdf);
>
> Do we actually need atexit()? This code can go into main and we can do
> the VF cleanup before returning from main after test_harness_run()
> returns. I don't think you even need to check the VF driver. If the VF
> is not bound to vfio-pci then that will be caught by the test cases when
> they call device_init(vf_bdf, ...).
>
Other than the asserts on 'vf_driver', the calls to
`sysfs_sriov_vf_bdf_get()` and `sysfs_driver_get()` themselves have a
potential chance of triggering asserts, although this is unlikely.
But the bigger reason is that test_harness_run() unconditionally calls
ksft_exit() at the end, forcing it to be the last function called from
main(), regardless of the tests' outcome. Hence, the exit handler.

I see atexit() used in some selftests, so I thought it was normal and
acceptable.

Thank you.
Raghavendra
