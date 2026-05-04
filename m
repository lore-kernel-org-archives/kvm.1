Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587D26ED59
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917115; cv=pass; b=VL06UaX2euOHsR/9Vz7swrhdcLJ+31ZMSgOkZLVXQv8enln6FdVB6KYp+dJVyjZuy0mZo+AElksBeH3FYOSpWsh39WWy1fZai8DMAaK8mbT8LqZtmS2hJSmA2VFSrejp4cr2Y3TY+xQLIUWe/MGSk1TwQM/FylKgFqocUORm7zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917115; c=relaxed/simple;
	bh=FbHsoMsHli5/bczS9MJxSfVWx9qE6HW/Ce3g4P2e/vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1X5ReOLOPzSqR1L6bLzXbSBQfVtOXICDpgmVXCoX9IqvmdMCMIwGT16Gsb7tCZrQS+fdpxL+Lidq0QFGXRPSZkU28ZiZwLh0FhyZvbvqhlUdHBZEr5qiH8SKaARvmif8cLFSpRwxl9ObboT5LwTtRDzZkIcrroH9KTxxnsL8S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hG9uR7gB; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hG9uR7gB"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1270fc2bdf2so2973c88.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 10:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777917113; cv=none;
        d=google.com; s=arc-20240605;
        b=Wr8oO9wE1QeklfSt3yLRHxZLO5jvyNBft/VOXsl732DaOXyaBwEjJ7/tHY+u5qmqN6
         vFT+DpO0Q+FzX/2GEKJoQQ/0EDxwff6AWbaeBiYk0YrlMoncxmukpMdZGU6ndGmJpbxR
         yrhXch6L/zoizHRQpNs1JBEbN/UAARnvAtnMqbvHULSs/+d2EZo3rSu05cYv6I9HwikE
         v+Pe4oU1Y7r4/mqbjqp7Fg6ofOtPk/rgeKpmKkETFYbxQal2ZGDcOlz004jBC1IcrVfA
         a3NVx90wXRE/7x8FBBLNfQL/vksvJdtpbRAvjLrQ2FgmMt4cdHY/donbeotkZllPUmxL
         tAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53bAEBip6nNI98gVRWnP7DW9jlE2Bq/GJ0zf+nAEMWQ=;
        fh=2wOTwsyaqet/brh1AfXSU79KCVPv9g+WADlwtXmC818=;
        b=IVoIQ+LTxhtuzZGydQJwPW0C6AEUIyOXqUpDxyqYvZ760PIlRy1zzpKd//1/R33Gff
         tYksonGNfzf8xC4BayWkv0YV6hPV1ol60Ba5++7/GETqjxaJf/uWmQHJFTElM0xzd1mV
         LKBu2IXGxeE5tevRSmkhMdqTwP+63GES0nhy5A5/Vc+zKQRvWGQBnYwP56pRIYeMX3hW
         qiZZCX6DsIR+NIs0TZ19svCYEqsGAUFx1G0vpxly+K+tSVqV/fCn2nKg8mUahG1w17Ov
         KWJ3iJPEkOpLJF7HUBx81nYkHRa0B2hBQBn/xMdvhzcKiEaTY4YO1DEaPs3AZwc28GSf
         0kJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777917113; x=1778521913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53bAEBip6nNI98gVRWnP7DW9jlE2Bq/GJ0zf+nAEMWQ=;
        b=hG9uR7gBqf3syOhcspyOOP9hvIEGm45F8piePqHN/8FCYVZETtHtn6nNUXnneN5Z59
         YmhDbhczMEjUVvTN/HXD0D8IsdsKBNv6SyAq/U7Z2YjihnlTPjm2DR4eETOyQ3gxIiKj
         T8s8pifqZEWMUAP+3ULLd+Zh3PN4GK7rkQkSEPiVWdqVwnKcyzm0/QKyFs+ZGG1mqLex
         4grg84GSwlEkAUzMifdGtG8C122wqD2KqmKXACq2ZPPt/gRsg7HG++h7hLwv7Q7xAo7h
         +KLOj/sseCCpzJV1gYJYNV9qR3lLICJmrVBIdBvoiOYVlGy78JXW++oGF5aU+Sq6XRtT
         5YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917113; x=1778521913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53bAEBip6nNI98gVRWnP7DW9jlE2Bq/GJ0zf+nAEMWQ=;
        b=bPoU/g5Fw0znSAo5556pNnoWtzxNAgW5xNRJq4LAjXOTdSKXiqUEomjOIPxwoUky+E
         qqxUni/NGL8Sfma7rzxQhBs2VTHBFI5vrZZvEci0Qe+yBAQzerQAYGsE+4IqLeC2tUe1
         xOq97Et1wnoIUOLzM2wvkCmNQB4wwC1ckHDKJXh6P+KL4y51JnUUKWVIVccBCN9Qelb/
         Y1KT/bDpovUu/xtwFccitJHiV+j1nGqibkDgVKVWDmIH+FmnhB5MCdyh/x5ZYn6roB+M
         MKGpJe8QJJAHJ+Y40Lhv3c3RL1QKGHNH1V9/+5BQJMsm/wLdsrzdNMfdu/jBEbIA6lNO
         FVfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FIWj5/cySyUwHwY9n6CxJby2AtArUNx2WMosL3ux9Rk5GEz6WlD+IX+d9NnGxpsSGuew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyUJ7Z2deEYzvcmknljaknqxY5uD7CgdsKGi0UWBJhrmjhZ+S
	XAab2ehaEhLq0ZlHOf/Tk8b0WLy2dswc9T3fYRhPnwfqY2vrgL1wX4LiYjnIjFRyUYhlie5QngE
	rp4d9hW7TPyXYm3QFVHow23aD8A4Oz+A9LamQbgtq
X-Gm-Gg: AeBDievhKHrVSTEai2f3AffHycH+EN5DKqgSjxxgEBGdsDeobGq8dMspmXuIQspk/1t
	hpmHko76qs01UiuYauxI3pwEkLbfzKKQWMx+EXS1hXfePZbvPQA2eFcvquPwFS9RDNlihehAcAK
	8psWIyZu6fo4AIh4X+Ty9JHSCYLQ3RifCRWXCmRHWbXmSLEs7yKlUjWWudw9O46CbkBDNZby2yy
	/51r0MFNJcNAc829yVzA5D4HrEiV0PCErvsFSSgfOcmoRBBejQoNRmBfig7j0y9wca0mAZDkSVU
	dDNXO1s9g/Uq7TwOlhbiSQ0acS5o3H7hs9F7wQxF
X-Received: by 2002:a05:7022:1281:b0:130:aa42:16a4 with SMTP id
 a92af1059eb24-130adaf6a6emr34704c88.6.1777917112470; Mon, 04 May 2026
 10:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com> <20260402173059.1018805-9-rananta@google.com>
 <20260413165308.GA3034974.vipinsh@google.com>
In-Reply-To: <20260413165308.GA3034974.vipinsh@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Mon, 4 May 2026 10:51:41 -0700
X-Gm-Features: AVHnY4IWxi-DqTo-Asd49m8JryWQ1KRx0tVF9GOke2Ulr9MS-_rxSsCVYgxTVvw
Message-ID: <CAJHc60yS==1ZeOPYbPNw+WC8_rZwze16_zOSxFE4o_dP8KKXUw@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Vipin Sharma <vipinsh@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 11:08=E2=80=AFAM Vipin Sharma <vipinsh@google.com> =
wrote:
>
> On Thu, Apr 02, 2026 at 05:30:59PM +0000, Raghavendra Rao Ananta wrote:
> > diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/=
tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
> > +static struct vfio_pci_device *device_init(const char *bdf, struct iom=
mu *iommu,
> > +                                        const char *vf_token, int *out=
_ret)
> > +{
> > +     struct vfio_pci_device *device =3D vfio_pci_device_alloc(bdf, iom=
mu);
> > +
> > +     if (iommu->mode->container_path)
> > +             *out_ret =3D container_setup(device, bdf, vf_token);
> > +     else
> > +             *out_ret =3D iommufd_setup(device, bdf, vf_token);
> > +
> > +     return device;
>
> I will recommend to return the error code and pass struct
> vfio_pci_device **out_dev in the arguments. This seems more natural
> compared to having a last argument as an ret value which is checked in
> the caller.
>
The idea was to keep it in line with vfio_pci_device_init(), so I
returned 'struct vfio_pci_device *'. But, it's not a big deal. I've
changed it to return an 'int' if that's what we prefer.

> > +
> > +/*
> > + * PF's token is always set with UUID_1 and VF's token is rotated with
> > + * various tokens (including UUID_1 and NULL).
>
> Nit: s/UUID_1/UUID_2
>
We rotate with UUID_1, UUID_2, and NULL. I've adjusted the comment to
incude all three.

> > + * This asserts if the VF device is successfully created for a match
> > + * in the token or actually fails during a mismatch.
> > + */
> > +#define ASSERT_VF_CREATION(_ret) do {                                 =
       \
> > +     if (!variant->vf_token || strcmp(UUID_1, variant->vf_token)) {  \
> > +             ASSERT_NE((_ret), 0);                                   \
> > +     } else {                                                        \
> > +             ASSERT_EQ((_ret), 0);                                   \
> > +     }                                                               \
> > +} while (0)
> > +
> > +/*
> > + * Validate if the UAPI handles correctly and incorrectly set token on=
 the VF.
> > + */
> > +TEST_F(vfio_pci_sriov_uapi_test, init_token_match)
> > +{
> > +     struct vfio_pci_device *pf;
> > +     struct vfio_pci_device *vf;
> > +     struct iommu *iommu;
> > +     int ret;
> > +
> > +     iommu =3D iommu_init(variant->iommu_mode);
> > +
> > +     pf =3D device_init(pf_bdf, iommu, UUID_1, &ret);
> > +     ASSERT_EQ(ret, 0);
> > +
> > +     vf =3D device_init(vf_bdf, iommu, variant->vf_token, &ret);
> > +     ASSERT_VF_CREATION(ret);
>
> ASSERT_VF_CREATION() name is confusing, as it is asserting both success
> and failure ret value based on the variant passed.
>
> I will recommend to rename it to ASSERT_COND_VF_CREATION(), or, may be
> create a wrapper function to check if current test is a UUID_1 variant
> or not, and then directly the assert needed.
>
> > +/*
> > + * After setting a token on the PF, validate if the VF can still set t=
he
> > + * expected token.
> > + */
>
> This comment seems incorrect. VF doesn't set the token, it just provides
> the token which is set on a PF.
>
> May be a comment can be "After closing the PF, validate VF access still
> needs the right token.
>
> > +TEST_F(vfio_pci_sriov_uapi_test, override_token)
> > +{
> > +     struct vfio_pci_device *pf;
> > +     struct vfio_pci_device *vf;
> > +     struct iommu *iommu;
> > +     int ret;
> > +
> > +     iommu =3D iommu_init(variant->iommu_mode);
> > +
> > +     pf =3D device_init(pf_bdf, iommu, UUID_2, &ret);
>
> I am assuming because of this, you cannot move device_init and
> device_cleanup calls to FIXTURE_SETUP and FIXTURE_TEARDOWN respectively.
>
> Can we just start this test with device_cleanup(), then do init with
> UUID_2? This will allow to reduce the code in all of the tests by moving
> things to corresponding setup and teardown functions. WDYT?
>
Yes it was intentionally kept this way for the 'override_token' test.
Also see the previous 'pf_early_close' test that performs a premature
cleanup of the PF. To accommodate these (and any future TEST_F()s we
may want to add) based on your suggestion, we'd have to create
special/conditional statements across the tests and I'd like to avoid
that if possible. The current setup clearly shows what each test
does/requires.

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
>
> Why would we want to skip if VFs are already enabled. Just
> set it to 0 if it is already there and set it to 1 unconditionally after
> that.
>
This actually goes back to a previous discussion with David where we
agreed to avoid such situations. For instance, what if the device is
already in use elsewhere.

Other than these, I've addressed other comments.

Thank you.
Raghavendra
