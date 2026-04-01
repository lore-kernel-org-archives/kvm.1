Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29744400
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002266; cv=pass; b=ST/caBqt50TsEqXnWZ0EcDESycX9VvM4Q+/qzMK0OXL0V+zSa52Q23mEgxQscmPZ1dCDCuEBaPjjyHX4VOX5K1vWe73Ws5QLNGjgbr0U5IoZgRmcl8Xyz74V+y9yWwqdEsNpd01qpof3PFCeV8An3ZCWtx/+v2XhA+tnlb8o+pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002266; c=relaxed/simple;
	bh=Cig+xfZTT3yCFM0ZCdk6LjsnSFT+IDeX8Tm1vUkRL5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip1yIGbms4Kh8CBA//tbpzo0fKwFKxpXHOKLCmS6cuFpvGH9TBnVvp4YhBSTrXbMBw7ci6d25Im2AfMP+uuNUSHEQdwMnWxBQJTGf0rVNSO2HAqY2ndMjhx/g2+JUoOavWmwFsiRvr4oNXynVBTm6B8J4aOmyTnwMQrJOtjcxys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZZpbji2o; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZpbji2o"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3870778358aso42329621fa.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 17:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775002263; cv=none;
        d=google.com; s=arc-20240605;
        b=IZwdX2azGDezkvi1SaRm5b0FQAypi3UGqp8OcyuB4Jmv1Blu8/0rmW3HzCEa4A9Nk8
         eS4qRSFADBPtFbbY6xidKgKGKo4A/EN82g6zJq+734uRqEphiJ4Y4VyRDRwhuvFGg7v4
         IeJ51LriqMuxn2Z3f62rUaR9frfjF7KPuPo4MoeZncXVvNtu7MovnXJP8MAc4/mwLAY6
         kS6qxqUnnkvDSDpaZ7Gw2zU/oG6uptHT32Mxe7yNwkAm63rv/g96vtVIhrQq/clqYwFk
         vlBEGuwv1waoBEvrAXYrmpdpSEZ6TiI2iA9SSu0sql3CiuYbn8pO4t4GOgqg5n8B5lNI
         nVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vnUNyB+eZcwdtIoRoUhBCluK7wmAHk27A0fmtoddn98=;
        fh=mFC5EG6H2QZp33n3fpu4D39FbSsLOkRfUHphcGYffwI=;
        b=W1qgD1B1RM3ek8pecUyX+x3ZjTHEJZK0nYhyLUO9BS1pq61V+sROxCQz2enC40g2ge
         AKTcNrQQuz3VNVwR3KUeA0/xbW7KBdrO1XZVSxOLz0NuXBdut0+iXL+gZRA2ROhEWIe/
         7B7z2xOB8m5+WvAq05W4Y60N9eWColUoRAteGmcME2ZUa5BNgSKfiuqYRp6mmc/bk/gl
         Zff4kqvtnz/eC4AEaDrhAXGg+so/PHBBAf9mbc3OtIIn7xeG/7k2xu2DqGMBQcujb5h9
         4YNYmsMqzh3/z40KevWMzpJMXWouKfeU55p/L5FYKWGQjt7BDPjeGGZMV7+26tdCAWd4
         7leA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775002263; x=1775607063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnUNyB+eZcwdtIoRoUhBCluK7wmAHk27A0fmtoddn98=;
        b=ZZpbji2oM0EQkheJSK8i8TwSXNmU5Ykdp/z4y8Xlpygr0lkZf42ed6p3RhOZE7Y8Ep
         HYbLvi/rb/cLWN8wyPxMHmPZB3schN+Gvi0fA720MM2FmiQsccMlYp7LEjZwLlRmCql8
         PWxj/PEqnUDTqMG0Xta3vB9pnFOyWUl+5kMcx5xAlxrHwzKgJ6ap/TAccHLuKDDGlnTZ
         5HwU5qZCwEqntMJKUL/HhG7CLEa3TZmxirwAwj7gW2UI3xh7dwG54lZLx+tzpgDPsalX
         oECaMizj66dM4saKFwoNVqpp5N3ahw/Thc1cVCZuKlF+cZYybrLuHipLKWHuRcHWFZBH
         c0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775002263; x=1775607063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnUNyB+eZcwdtIoRoUhBCluK7wmAHk27A0fmtoddn98=;
        b=jWIQ887TDskuFf3pPC7rKkjnHcAPsGlFf5HkiwwHUaBsY6K6zP4GUw2wXTWHRHbzig
         j4iITlF8+lyiw+zbTOaLTAXJq+W/7Fyd4kkpwO4RYvv1qHNKrwhzQapMomvfmbGCAHqc
         mtWfZx1VSNOWwNSu7WtorROHVwey1low/mQ87FCcy0O2AmH+1BogFgnJv2iaoJHA6Bfx
         zi7IUjP3MwzogIPxky57WsDzaJj85ScnbYQEwjIAn9rPExRjQX0Ag1RC5zyiPZu4IrM2
         N7TT2DybpnKXRrzgHNjc2yltQR0eC9k0/UFk5AijA78MZKfzvw/jXm3GFR2AmES4aYg4
         mPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzNiMtFMMJazBu+CdWDuYgHkmtoZ0DQrKF82fzpUuS1fYlDxXJoHKQldIcfUaL6cn1dXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw2DsTwV+fE+sKLrHEnvKLfnIjzQANm6UcqC2P0sNptAh9Lslw
	d5B53hMSUB4JWmQROXF0mAsg0KE0HHfYdy/XGvO2hohBsBPXw9X/3dK/CE4sEIdeYIQmn1xlLNY
	2qjA4Fy2UruL4J62n13rlFeC/1kiL31fvKtvoXQpG
X-Gm-Gg: ATEYQzxOZO6+2HZRE/hUFOHNJnGROn7NB1LH4sWgvJliHnv4oyXNiyP0zdax6P66yrW
	oR/nFZGLMLc2hvAbrXrH6+iODTOq84uTpwbm6A3qv6wVlepr6kdT97jdRYj4cYUkQJALftHrkLo
	LqLJdrwhSpwO8BFL3pX4ze+0I7tlH1mZ8driiS/KutXJoouBpEpEFo7otxD2PuOZxrP1vQP9om5
	yyVP6dcupZTPTGS7xRoT1ov4GnfsBl8ZguJyUdcCrrUkEpG0TZYz721RhAmaYIVLPCfU/IjPP0t
	rQ9mgFLv
X-Received: by 2002:a2e:bc13:0:b0:38c:c068:1665 with SMTP id
 38308e7fff4ca-38cc2f1992amr3602511fa.7.1775002262694; Tue, 31 Mar 2026
 17:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303193822.2526335-1-rananta@google.com> <20260303193822.2526335-9-rananta@google.com>
 <20260311235715.GA2738066.vipinsh@google.com> <CAJHc60yQjfpw9D0VoP0FAfv65g5BpVYddcWQ23q0hRLdcP2k-Q@mail.gmail.com>
In-Reply-To: <CAJHc60yQjfpw9D0VoP0FAfv65g5BpVYddcWQ23q0hRLdcP2k-Q@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 31 Mar 2026 17:10:34 -0700
X-Gm-Features: AQROBzAKrRaQRHSJv-MrB9iCHc5cCTyEduY12grpOZ4h8dPUCuyseyRhwWjr2JY
Message-ID: <CALzav=fkKPR1giHyvZ8Awk=OpzNk8b_xVVwt-AyuXjwGGSY4Zw@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:53=E2=80=AFPM Raghavendra Rao Ananta
<rananta@google.com> wrote:

> > > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > > +{
> > > +     char *vf_driver;
> > > +     int nr_vfs;
> > > +
> > > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > > +     if (nr_vfs <=3D 0)
> > > +             SKIP(return, "SR-IOV may not be supported by the PF: %s=
\n", pf_bdf);
> > > +
> > > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > > +     if (nr_vfs !=3D 0)
> > > +             SKIP(return, "SR-IOV already configured for the PF: %s\=
n", pf_bdf);
> > > +
> >
> > If there is a test failure (ASSERT) then fixture cleanup will not run
> > leaving SR-IOV enabled and all subsequent tests will skip.
> >
> > Since this test is specific to SR-IOV and user is intentionally passing
> > a device to test, I think we can just reset the VFs to 0 before
> > proceeding instead of skipping.
> >
> The idea was to eliminate the assumption that if 'sriov_numvfs'
> returns > 0, someone else might be using it. This is based on David's
> suggestion: https://lore.kernel.org/all/aQzcQ0fJd-aCRThS@google.com/ .
> Moreover, the device might be in a partial state. So, even if the next
> test proceeds, it could fail due to other reasons.
>
> But I see your point about cleanup on failure. I think this is a
> common issue across all tests. Was the expectation that we rely on
> cleanup.sh to take care of all the cleanups, regardless of test
> pass/failure?

I think we rely on the fact that test cases run in sub-processes and
so if there is a failure in fixture setup then the child process exits
and all vfio and iommufd fds are cleaned up. So the device is still
"clean" for the next test.

However if we are modifying system state like the number of VFs
enabled on a device, I think Vipin is right we need to clean up after
ourselves if the error occurs in fixture setup.
