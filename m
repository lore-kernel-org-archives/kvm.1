Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109EB22083
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595711; cv=pass; b=USZ7vNyHAa1WC4i0gD6NQB1dDCrOHpEscpgkzgeTwRau3yN6YLKPUg9HtPAn6RnebJIBMEzkwO6KHGLstvg3w6vffmPVgqaE2F4+I+CxAdBtR/CcimQ5FT9qzc3KRAp5u3azKoPOwcPGsNKQ8G1Oy+2apcyzV/Y9veLYzK7z7As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595711; c=relaxed/simple;
	bh=y4xv4w+N7zOPLMXYJuqB7mLCfl6jABA8lNgVdCJduso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DU9d/XJCYrVNc/hIJMiPd7uKODcnV+uSbepKFggEt6RA3QU0wiD6f1m4Kru3q0rJQwS44wsL0D34EqP7bX+h6T66RwVGB4rxZRLNoQgdMeMecfAIyWJfWhtoCcdDxoQtSKAmu7F2ciLVeF9RgT2oxoUubhao85XneOz/xDonKEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BS8tt2qi; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BS8tt2qi"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a3cf308c54so3181629e87.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 14:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775595708; cv=none;
        d=google.com; s=arc-20240605;
        b=UVV3h7BOy7GgD56D9zn1YE0WmeuIPALHBvtnkQY/7iiryUBVk5vKU3qqxYMJrVqzf7
         yThkTUgK8nXCOJhWnHNXfT6607+pNVqkFyMM922Hh1pDBcEOkyqTiLYWy4cg5dhG6NMd
         rZA71dYJgGspmD1cexYUpjQQNoj7DvAJQLKJ9EcEwPle96WOSwrKyvJXjgjRod8meq+p
         Dlpn3X3vmNOxwnu3/R4wsBHgt+XIh5JapAF9zveM/xUqB6EG/xB3SdBSi8egn2ZX7O0V
         GSr9gDz/jT3aigfw5AHLrP0yQXse3T5CDqNRUj2N+aY8P9SgNEJg1O5wTV9PQgbE/DD+
         Dp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n6nceFR4FTDCl1rL3f3sxSEVv90p1m635ufXlAu9TY8=;
        fh=n9cHQ7kWPdGAakBxoAeD/OnyjDQOjfNKAtqzN5BbC4c=;
        b=PGfLy5t/d+cY2PLAuZznJmS9CTYx7HzV/MiFobMTGm+M6il9tYmKjehz58VMWy4HbZ
         b3zQ8Da3bHoDaouG7GUripVBk0d5tompNhoRjXDhRv5ODM/D/2QeIt+soZbWuiv/Vpnv
         dxuY7+F2mxoN4kBFBa1Z1abc3cg1UB1VKyr+CQD2bCs/+TGwdW0JqMqT2Tr7I3AHkZFr
         h09M2Lc58+NFGjiBcFz5jYoO5EPs0sHEz99aiH0Q7WidoJSS6D4H1De3neNJatxIwK1O
         OgXWVo54S98cPKbyp7bgNbOViUj9OtwIgBbAcMR92cQLbR0ZDuVqz5uOhGTPYGgJTKwX
         H6ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775595708; x=1776200508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6nceFR4FTDCl1rL3f3sxSEVv90p1m635ufXlAu9TY8=;
        b=BS8tt2qiOQiaJYz34CrcA7ovPWR1xrtV/Zki2jLtzBuR86crZvibxfiaoUPf9j85ux
         gdLKgoyEdxibrGVkdXqFB8+ylbthpS/1I4fHG4bg2zDAkD7t1Qm0dgfOzGMz5EC66YHJ
         qVAIP/37piyfZGaPu8eSeew+OrmW4qdHm07NjLc5cvSKeJDBsaOFTQi7+VLevnnMiaSA
         LUCeELb/44Z6vgfN5Xrd2RlIjMt0bBgA49KN9MwdlsEWW9eJiKmgf1gshUDRBB8y2J4t
         pNJxoILmjw+lJQdjQO0425mMCp7B9aSXLepi035PvFKro19jxLGRvlwfPbiu9HfW41D5
         7BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595708; x=1776200508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6nceFR4FTDCl1rL3f3sxSEVv90p1m635ufXlAu9TY8=;
        b=Q6TsbfTZLZMG6Kf7maqrTgrs0Ww8Ql5DWm7lP/lreuWQRc7IPsioFA+524JWeMbkBv
         +DvfRYXxEAxCbFDK/cJ4UCnb2lSwJ/gmcNZIBo5aZy7BDsgXJXQO8zNS7Il8yQ8IUiFH
         80NoAmX7rCYaeJhzrgemiXTMuvs9crgarA9wO37RfDSs1JkjQckolIDdG9Y7EUgxZ/gN
         pZrDZ1PW/7rYX1cSWyRTdELma1yz1mQwoahwW7Z7oOY0mzg2fixpSEago9+YWi0h0Nlo
         1W98iN6FF0vfYUztLCjPXoX9CBPD/fV/c55Pb3KnUy7vpU4WlP+3GIYp47aevO0Odg2h
         b3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVuqNgu8X2hc6ATmhGUA2o/vZ6ynqH57n+Ho++u5/Cqi7vg+BBC/Mdel1/W1k5J3gtQwnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaYGPKIh39J2FO2Xd2EMWmTkMSEUynS7Jfm7c6O1kiHoya2h4
	9sWiGhYW44DZTCodlnlcFHB9DV2JLIZUfbV9/btIbJFqWC85FR54+NGn8u2xU9FltHfSuFIZw6g
	FWCRwJGLDYP5Z9ymWn6ox67t41a89UMqU/i5cX4Cu
X-Gm-Gg: AeBDiet6Fgu/UdPsZnpBfGg2jeUPoQRANiAqXtIkLXlNUdUaJoWK2TaqM5Lnyt/Mrwz
	lY9W4XY5gAAZhau81kDYVEYtQTvLj13zWysYqviZm3Ie2e0Wob6w4+oIi2T8yfKbVxnFRuwTBNJ
	Pc4SZkLsu8bebp+Grx8GuW2vKtGSu5qfBMSn3KE7rSyE3593CNVMCE4FXDoq0YfeknYFcaCszGt
	wsefAB1yYp7dwZYnZHwp1l6cTc5Ue3+Jh+PHRiE3pe67R3LGQvg/JNUx00bZy1uwqVqJGNxmXd4
	chOSB5Hk
X-Received: by 2002:ac2:558b:0:b0:5a3:d100:3c82 with SMTP id
 2adb3069b0e04-5a3d1003da8mr3456929e87.23.1775595707775; Tue, 07 Apr 2026
 14:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com> <20260402173059.1018805-9-rananta@google.com>
 <adQyhegJdEWuUIi4@google.com> <CAJHc60z3gPyGHbL+HuXrCc8OiGBKfAh1MX8rqYrjeaXrrmy7pQ@mail.gmail.com>
In-Reply-To: <CAJHc60z3gPyGHbL+HuXrCc8OiGBKfAh1MX8rqYrjeaXrrmy7pQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 7 Apr 2026 14:01:19 -0700
X-Gm-Features: AQROBzD_vAHAtHU-pFANoy52RUqW_d8wARaAwY6DrCK-Jz_kX-EnCFIMtqZ-v9M
Message-ID: <CALzav=eM8AMEAn9YAa-eqcCV-EiaE6yz1abHjtXsnk5KX35L8g@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:51=E2=80=AFPM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> On Mon, Apr 6, 2026 at 3:24=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
> >
> > On 2026-04-02 05:30 PM, Raghavendra Rao Ananta wrote:
> >
> > > +/* clang-format off */
> > > +FIXTURE(vfio_pci_sriov_uapi_test) {};
> > > +/* clang-format on */
> > > +
> > > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > > +{
> > > +}
> > > +
> > > +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> > > +{
> > > +}
> >
> > Please do iommu_init() iommu_cleanup() here to reduce code duplication
> > and as an added bonus you can drop the clang-format comments above.
> >
> I think even Vipin suggested this. Last time I tried this, IIRC got a
> build error that 'variant' was inaccessible. But I guess I just had to
> re-org my code to make it work.
> I'll do this in v8.
>
> > > +static void vf_teardown(void)
> > > +{
> > > +     /* Destroy the VF only when the main/parent process exits. */
> > > +     if (getpid() !=3D main_pid)
> > > +             return;
> >
> > Is this because the child processes created by test_harness_run() to ru=
n
> > the TEST_F()s inherit the atexit() call? If so please clarify that in
> > the comment in more detail.
> >
> Yes, that's the reason, and I assumed the comment made that clear.
> I'll re-write it if required.
>
> > > +
> > > +     free(vf_bdf);
> > > +     sysfs_sriov_numvfs_set(pf_bdf, 0);
> > > +}
> > > +
> > > +static void vf_setup(void)
> > > +{
> > > +     char *vf_driver;
> > > +     int nr_vfs;
> > > +
> > > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > > +     if (nr_vfs <=3D 0)
> > > +             ksft_exit_skip("SR-IOV may not be supported by the PF: =
%s\n", pf_bdf);
> > > +
> > > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > > +     if (nr_vfs !=3D 0)
> > > +             ksft_exit_skip("SR-IOV already configured for the PF: %=
s\n", pf_bdf);
> > > +
> > > +     /* Create only one VF for testing */
> > > +     sysfs_sriov_numvfs_set(pf_bdf, 1);
> > > +
> > > +     /*
> > > +      * Setup an exit handler to destroy the VF in case of failures
> > > +      * during further setup at the end of the test run.
> > > +      */
> > > +     main_pid =3D getpid();
> > > +     VFIO_ASSERT_EQ(atexit(vf_teardown), 0);
> > > +
> > > +     vf_bdf =3D sysfs_sriov_vf_bdf_get(pf_bdf, 0);
> > > +
> > > +     /*
> > > +      * The VF inherits the driver from the PF.
> > > +      * Ensure this is 'vfio-pci' before proceeding.
> > > +      */
> > > +     vf_driver =3D sysfs_driver_get(vf_bdf);
> > > +     VFIO_ASSERT_NE(vf_driver, NULL);
> > > +     VFIO_ASSERT_EQ(strcmp(vf_driver, "vfio-pci"), 0);
> > > +     free(vf_driver);
> > > +
> > > +     printf("Created 1 VF (%s) under the PF: %s\n", vf_bdf, pf_bdf);
> >
> > Do we actually need atexit()? This code can go into main and we can do
> > the VF cleanup before returning from main after test_harness_run()
> > returns. I don't think you even need to check the VF driver. If the VF
> > is not bound to vfio-pci then that will be caught by the test cases whe=
n
> > they call device_init(vf_bdf, ...).
> >
> Other than the asserts on 'vf_driver', the calls to
> `sysfs_sriov_vf_bdf_get()` and `sysfs_driver_get()` themselves have a
> potential chance of triggering asserts, although this is unlikely.
> But the bigger reason is that test_harness_run() unconditionally calls
> ksft_exit() at the end, forcing it to be the last function called from
> main(), regardless of the tests' outcome. Hence, the exit handler.
>
> I see atexit() used in some selftests, so I thought it was normal and
> acceptable.

Ah ok if test_harness_run() exits instead of returning then I agree
with using atexit(). Thanks for the explanation!
