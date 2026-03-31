Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43B4218BE
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992889; cv=pass; b=fgmx4HBOY6+3acycPsu7n6TX6Kn8tPHZ856QscmL1DsCiY9ksKE3qieFZwR68uBdfrYcGtrs4msMukIeWRAPdhNjKYLOAjqpTYuLnG70PY/t7GsSwjrSmFDhph16D/+dxe6ZMVFt9UurRY4t4c1PJ3KkWg2U/l9xsODN4w7VyLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992889; c=relaxed/simple;
	bh=QzUPqDJEPd1YPPGYhhzq1TweiVOWNxPzejx3dcly70E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUkR4gGDwO8B79bTeCv/iDVL5eZgdaSxhvUnL0tRCN6bzYyn74ZE8a24/c43BevBK72R4Fsli1JLJodg23pRzoY6AF8Ekar1waabh8m78t7EgSOkdf59MwiowSXV/o+5/VderDeNwtIjDHi7aNtmyS+5U1hSdX8Y/HIR2LrfQqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRVL9azi; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRVL9azi"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50b6c45781aso987631cf.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 14:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992887; cv=none;
        d=google.com; s=arc-20240605;
        b=SisVthhtVZFuZX5dlKcqszviq4Wqr2RPJFdXmAHrs4q4S1XZkBDmU6cksSm26CAkkh
         QjFvKuzB01vkNLDN08hqNgfZVl80orZ3hvPezChQpnG38/7OAOEtvAXiEYWNOYEY/SwJ
         /aKFQJAdpWGOSS86LH5jed0HvnQ4l3YVVKfCj1lE9wkW+049vTPVxvaCVD/eHsB0hUYr
         UYxn2ZxmcWakS1hOtZpPHI9eBtj80sD1HKF222ruOO8xK+4Ycvj6E/qaqxVTpy5B7h5j
         tVONDf8lFdMo4EQh/mka4Uq0IS64+kGUm45NfEqhyo3UN+UKfITnDoIUfEEaOdKC+U0M
         aFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SgXl+oPmqXAVyjJVj9PGIPVfwIzvSW+YSUqYMpO0WuA=;
        fh=BD3fcD1Kd9hybUfSFl9Oq03qpWVZb0M8U66Ss1b0Sfs=;
        b=AUG0MCh7SP3MhsbLNvjR68ASrf/4ZrgGGDG8ekY/FRV7q6DeNDqdi/iDVtDuP1Kg07
         X/5QWp6I0ZZOKjgbHOpaqtDn8XoN0kX7tiBgwkwakKAXRBb3KI9iaOIWbUEcLQrF4eWv
         H6DlM4w5kDXBkJmYdqITis8A5j4Tf2vlKeUNBJmRX/guu7h/C8c2ool7s7LgW9jj1Z6d
         hami+UTg2mKvBVJxpkEOCSTYJZ31aHNsvQDNHkczw/AEjdl8K+RWem8uYvqdYoNQPqFV
         29p9fsAJs1UrHaae/IrknV647ESfD3uvEO4RlxEl41zrJmSh4SaJOlA4cV0gQkZVRN7R
         W+Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774992887; x=1775597687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgXl+oPmqXAVyjJVj9PGIPVfwIzvSW+YSUqYMpO0WuA=;
        b=qRVL9aziIB9wpy/2zCyXC1nEThrNr/0idupL5ESkflfPbRAHa6Flg1yDDQwf7v2FES
         bufODo1p4YqXjzUqSCXtIWKHo7PPdYKKCzfOvybejitoPeoUja7Kdi5VkJgaQvtzbC6V
         TdfXZ4nhfuqki3IYHOcZz9dYcAnbxolWk6ZAgik0OyEvCcoERupTHT/fudTr1b2pgUar
         c5mcBHKxCAJpVp2IoRYyuKzqS4E+6odZ2aQig7yneCUmq3Zzx/sKZTI3sfwRXSxJsyv/
         NehWcOuXoJdT5M1J3ni+sOjYF9okGOX6jr98TuIAFSFAxHG5mx7AUeOzzDWYtkO42A6s
         fWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992887; x=1775597687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SgXl+oPmqXAVyjJVj9PGIPVfwIzvSW+YSUqYMpO0WuA=;
        b=sZm7Zso6rPo3s5HKtHgHqHxWz4Mep5ygOrRs8huXoaPLMb8KQcmCQOWTa0kwrpgOyM
         ngza4XqO19LOFQzW4dLOSKJKlLlbhDk4nuUuSXxQqqrMzGUlq5+tN26V8DssrD//fQco
         vEcMEu6gu/9+8CVfUJBMDw0saE5E3Rt73mNw9xWCsYgD5YLOV+XNPL7bKueR89S5tFJ0
         yk6IIZza+4XC9v1WznWIK1mkMw/TIPzWZ3wVtUPnAZo7byXl4hwILpBXN0UJP58mTDp3
         WulFq0LZbpol0+L4Ibdsp3O5D1TOQzC8cdJsugSN/x7HajSGKOJ4jz83bVXzIfyqWDIH
         7/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUCH2cCkq4fbZq7QQW7DCAky8Ts7nY98gJy4UIZrLc7AUVRr/K1ADFEFlN4Sa4KCDHtXTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8t9qPBQsN7dZ2arwfS7J9/zcQCroB+HMnWctI+ckexPNmRAt
	jGImCarjRHLCf4lCZHSozcC0INEIeVOxO8XClZn+6l6CfBLWGubVb5KGzc9nl5sQUx4AXeDJ0K1
	Th9NeHFFEfTzJ5I+8GrQjzKGhYDuwJgcANHkw6vuS
X-Gm-Gg: ATEYQzzm4yn48rvH72TM7cre7I+tt5kuY8STkcFdu3kFcQzmxUTFYxF1dCh7MapWOlR
	zUNqVIr0ewwBt/AmAJzbnryKlKO0l+r8ihLGE2xM6vbKRjjwqVhplcYSHWRv23hTObqznSTASG9
	b/KBwfs5eXJkLEmGdk7SO8P2R8YjuQp+1V7gc5ORX9a3bAEDhnJGjTK5Kb1X6GqCnTtrLp5bNve
	r1BkkREQYh9+oB/xtTeqP88fgd7szOOd0bFWpECAD57TH/GuasBRL62wzx1IKGu6A0hMHloEy8c
	NvoLObYR
X-Received: by 2002:ac8:7c4a:0:b0:509:1cf9:ea11 with SMTP id
 d75a77b69052e-50d3e581ed4mr645001cf.7.1774992886606; Tue, 31 Mar 2026
 14:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303193822.2526335-1-rananta@google.com> <20260303193822.2526335-4-rananta@google.com>
 <20260309220638.GA690765.vipinsh@google.com>
In-Reply-To: <20260309220638.GA690765.vipinsh@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 31 Mar 2026 14:34:35 -0700
X-Gm-Features: AQROBzB731GOJOMnnXD7Z6-6JN_kS0fyfEUIk4EXYSaYHZ_0wibjjiAyq1TRSrs
Message-ID: <CAJHc60zLs3eC=u22zYv2u1L2TOuqWKAHPVkmCfL=PwVu_PFyPQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] vfio: selftests: Introduce a sysfs lib
To: Vipin Sharma <vipinsh@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 3:06=E2=80=AFPM Vipin Sharma <vipinsh@google.com> wr=
ote:
>
> On 2026-03-03 19:38:17, Raghavendra Rao Ananta wrote:
> > +char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int i)
> > +{
> > +     char vf_path[PATH_MAX];
> > +     char path[PATH_MAX];
> > +     char *out_vf_bdf;
> > +     int ret;
> > +
> > +     out_vf_bdf =3D calloc(16, sizeof(char));
>
> A comment of /* ../0000:00:00.0 */ would be nice to tell why 16 is
> chosen.
>
Sure, will add it in v7.

> > +     VFIO_ASSERT_NOT_NULL(out_vf_bdf);
> > +
> > +     snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/virtfn%d=
", pf_bdf, i);
> > +
> > +     ret =3D readlink(path, vf_path, PATH_MAX);
> > +     VFIO_ASSERT_NE(ret, -1);
> > +     vf_path[ret] =3D '\0';
>
> Can we just initialize vf_path to {0} at the beginning and not worry
> here?
>
Hmm, we can but we don't want to fill 4K (PATH_MAX) worth of 0s for
every function call. Hence, I preferred to set it after the call to
readlink(). This also seems to be the common practise, at least by
looking in the "tools/" dir. With David's suggestion of introducing
readlink_safe(), the caller need not even worry about this. Same
response to the similar comments below.

> > +
> > +     ret =3D sscanf(basename(vf_path), "%s", out_vf_bdf);
> > +     VFIO_ASSERT_EQ(ret, 1);
> > +
> > +     return out_vf_bdf;
> > +}
> > +
> > +unsigned int sysfs_iommu_group_get(const char *bdf)
> > +{
> > +     char dev_iommu_group_path[PATH_MAX];
> > +     char path[PATH_MAX];
> > +     unsigned int group;
>
> Why unsigned int? In kernel iommu_group id is int itself. Caller of this
> function also casting it to int.
>
Ah, it should be 'int'. I guess I copied the original code as is. I'll
update it in v7.

> > +     int ret;
> > +
> > +     snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/iommu_gr=
oup", bdf);
> > +
> > +     ret =3D readlink(path, dev_iommu_group_path, sizeof(dev_iommu_gro=
up_path));
> > +     VFIO_ASSERT_NE(ret, -1, "Failed to get the IOMMU group for device=
: %s\n", bdf);
> > +     dev_iommu_group_path[ret] =3D '\0';
>
> Same, initialize at beginning.
>
> > +
> > +     ret =3D sscanf(basename(dev_iommu_group_path), "%u", &group);
>
> Can we combine these operations into a single function? Seems like vfio,
> iommu_group and driver all use the same pattern.
>
I think we can, at least for the vf_driver and the iommu_group. The
'sysfs_driver_get' handles things slightly differently. I'll update in
v7.

> > +     VFIO_ASSERT_EQ(ret, 1, "Failed to get the IOMMU group for device:=
 %s\n", bdf);
> > +
> > +     return group;
> > +}
> > +
> > +char *sysfs_driver_get(const char *bdf)
> > +{
> > +     char driver_path[PATH_MAX];
> > +     char path[PATH_MAX];
> > +     char *out_driver;
> > +     int ret;
> > +
> > +     out_driver =3D calloc(64, sizeof(char));
>
> Comment on why 64?
>
Will do in v7.

> > +     VFIO_ASSERT_NOT_NULL(out_driver);
> > +
> > +     snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/driver",=
 bdf);
> > +     ret =3D readlink(path, driver_path, PATH_MAX);
> > +     if (ret =3D=3D -1) {
> > +             free(out_driver);
> > +
> > +             if (errno =3D=3D ENOENT)
> > +                     return NULL;
> > +
> > +             VFIO_FAIL("Failed to read %s\n", path);
> > +     }
> > +     driver_path[ret] =3D '\0';
>
> Same, initialize at beginning.
>
> > +
> > +     strcpy(out_driver, basename(driver_path));
>
> They both have different lengths. Should we use strncpy()?
>
The assumption was that 'out_driver' is allocated to accommodate a max
driver length and should fit any driver name. But I can switch to
strncpy() to make this more clear in v7.

Thank you.
Raghavendra
