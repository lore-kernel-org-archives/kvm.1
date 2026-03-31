Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2B3BE64D
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001205; cv=pass; b=ZzRNkitXfgkZ4vX7E7HlhFrL5HiycUEC+NQ8HaUYQTYJ+5pEvYD7wTtcg3j9ZAvuHcp6ANEgQUpNaNaE3nfowR+KUf053qVYHjK4XEob3sa16+LQZSdGLwnRIzALw44qXRKQM2HNxSYzqRutcl084S/s/pyRxImTMlKzmPDvPZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001205; c=relaxed/simple;
	bh=SQ2CEnYHvLcViq9qfVWukZzHc4Uv+2v1s0pyMve60GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EC8fjJ5AbaXQUn1CD3BKKmW//fLocvLC4QAP9nHT3Ts+Kee2ji+aStbsTzAg/+mw0XKUgNbQKvjKxNxZeHqqdMzLS/Nu8JYHpFE6KY9sFV0ZqlE12y2hvoWE1cdMAlVSQKJHMI5tPnWrEn5yQB4EXQNX8w1xxKWfbxaKVGIh3z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njw7PWh6; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njw7PWh6"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509069a7a7fso944561cf.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 16:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775001203; cv=none;
        d=google.com; s=arc-20240605;
        b=Hu9XChPDazIfZq5mYpOFx1YNk+IBZnNG04sEi7cHrXLzDKODz3f6QnEQHkIngSAIgD
         0a0OEizuOc4Tw2DJFT6zHjJdKlGz4LmiCdAtgnthixqP+BAf0ElQOYQv4GEQ3efiyr05
         svFPc3YsXEPwu1xSmQ45wcaUOandoozZPA/E5H3yHceRKf4Ph+DDDqsIM24osI6zJdFG
         yTvmsdiGHM/9GKo5vFJmH2zZDRgGh8XDDsvtmU8o+FdUswfCoNodGxWQ6efIBgFK3Wm0
         9oIXPxV/f+1T26CdzucU7aXn6agZFVPtyAAJMMFw6zUR6zhum+is1yVJjJk5q7y6K9gE
         /dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWzA6q8y9lc3jLpixT2wfoVx3d1L7OOFLVR7QVMeF0Y=;
        fh=0hkozetQi6KLgCDu1pJVPrgkISP5JjdVQ/LRYBysQdE=;
        b=FMsTnGK5hSCFNy0NObR54evWr5WGq3bdh3OpfMBe1GSvwLZLKf2JIrXHWYxfuhq998
         2l+ltzMlkoj8Mamg2ITTqup6hI1oqQz/F6IONDu10c5BpU302BjrfldJEO/G4IQtD+cy
         zunGerSx7gbcaXvZmf38gWlO/MxyoR8kTiYxyH3w73mfnP70Fd6prwaibiScRLqNrtZr
         MipdiTVRoqGWC1eilVft90VvpVh1t6CLAbbYWA3J0IKqkHnncU3+eSX+/MkowObKf1S/
         5DOYyPkS50JNqI5Ksp+ZRj7e+GJYCuZJmMbBjPV5mHH/EuJE5Bdkt3rwNxI0XsbLpJ/w
         MZlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775001203; x=1775606003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWzA6q8y9lc3jLpixT2wfoVx3d1L7OOFLVR7QVMeF0Y=;
        b=njw7PWh6GzVdIZQZZLsQQoredfKXgsptjw77CbS49IY87A9ELaYIDRna5UvVThHnHb
         j729QLDNv2dZAPRIrUPfqeK8qfDJ9X3/O1SbmYhZ9eYmFSGCwYpRf4UiorSqFcgadD3C
         TcgeThF83h/ZzbqJlwR8CqqWedGlR/S9yghxmLYfK3Q1BxYt2oZTLFodv49j7ljp22lq
         0CtwVS8RX1ePr5k4U8mRLBqhJ42qIC2W0k4caYsBDWBE12w5y8S+ELBGI++UEm1Vrob4
         y3b8iXl6cJp/UU6L1Rm00IfdR0w4fgnIJfCv9x/JM5amnCvg1rx9c8MxB2omAGdwTtIJ
         e+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775001203; x=1775606003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWzA6q8y9lc3jLpixT2wfoVx3d1L7OOFLVR7QVMeF0Y=;
        b=cDMdj1V++3w591HFBIcf2nrJTx+Fm0ToKBssywBcfRWvUQ9rciiruTAXuLo0dkLheE
         ZdQv1PXgxAy60t7b95Z3mpdIgPaZOSDx6B+kZM4ehsbNneeWD0gyEVUXC7sciEN9Pbdb
         ELDNhyXEXYxYFtG7pcG+MFMeW/qCq0ItRSBjOvNbGIPOoVpBs5UiMKSPMLdKqBxQc2gW
         h8nJfxGHlAm0eVHPFxn23Z8B/ZBfPK5AzDQ9ir8vFzPTfk1OaoZZNX99mICog+6Y4xJ9
         tlcX+AD1beS0cF3sOh8S2m8XwQzR3hFWF2b/1QJaGNqQWzA9xdjnze5a48x+MPkliPgR
         yiIA==
X-Forwarded-Encrypted: i=1; AJvYcCXBVnnkUvIXAXQxQ0ZXR7kPfgRisiwx/l2xiPk3Cjt8g6LfNZlvZrqBMkvO51rDAbhNeY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JdIrikC/I9diw9EGxQXhuHhrqc3l+oMJPuEyKwMjI19ksAMZ
	0mcP7Yjf4RFct6cA5FJSDcPsw++PxQoT61gKc7hVY5qjsDwqoclAPj/NiX18RODB0KfVEFAIzBk
	Qc0lF6CCjlPn4oICcajtNh0lEKMuGpStB2+xRPcuA
X-Gm-Gg: ATEYQzxrnl2mZ+B46k6O8DrFxufvcCvUMBQwucQm6V56VCG4ZKF515IPM6f61YFnQ7e
	LFYsy8Ap2hbegN3g9Ig+0lYgCJGTkfb6wwPdv5Wzie6Vb1MsTpfKguBtbX5C/keJyigfcLyMgdR
	1YHk14bqE6BPysEr4QIpOD6b1ehxUIsebIg0Y/dMSjFlnNuDaQETTDN/lvQ6uh5W3ShmTTo53Ly
	+Q8ve4ep3V6T8R4Rvuq+P33O9afURhzZBgdsZkMHNnCZpLzoFXh2JS/7kB6WND39C0srE/ps/2I
	A/b6pmlt
X-Received: by 2002:a05:622a:9c3:10b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-50d3e6a38d3mr2338011cf.15.1775001202474; Tue, 31 Mar 2026
 16:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303193822.2526335-1-rananta@google.com> <20260303193822.2526335-9-rananta@google.com>
 <20260311235715.GA2738066.vipinsh@google.com>
In-Reply-To: <20260311235715.GA2738066.vipinsh@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 31 Mar 2026 16:53:10 -0700
X-Gm-Features: AQROBzDYWaQRi_3Zy7uSfzBjeuvxGNZnm9Nyioq1oE-LxRcOYPEOMCOcK9DbBe4
Message-ID: <CAJHc60yQjfpw9D0VoP0FAfv65g5BpVYddcWQ23q0hRLdcP2k-Q@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Vipin Sharma <vipinsh@google.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 4:57=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On 2026-03-03 19:38:22, Raghavendra Rao Ananta wrote:
> > +static int container_setup(struct vfio_pci_device *device, const char =
*bdf,
> > +                        const char *vf_token)
> > +{
> > +     vfio_pci_group_setup(device, bdf);
> > +     vfio_container_set_iommu(device);
> > +     __vfio_pci_group_get_device_fd(device, bdf, vf_token);
> > +
> > +     /* The device fd will be -1 in case of mismatched tokens */
> > +     return (device->fd < 0);
> > +}
> > +
>
> This is one is exactly similar to vfio_pci_container_setup() except you
> are calling __vfio_pci_group_get_device_fd() which doesn't do assertion.
>
> Any reason to not create __vfio_pci_container_setup() in the library and
> just write assertion in vfio_pci_container_setup()?
>
Yes, the test is specifically interested in skipping the 'device->fd'
assertion out of the many assertions that vfio_pci_container_setup()
performs. Hence, there's no point in creating
__vfio_pci_container_setup() that skips only this part, as it could be
confusing. If there are more usecases of similar assertions being
skipped, we can consider implementing the functions as needed in the
lib.

> > +static int iommufd_setup(struct vfio_pci_device *device, const char *b=
df,
> > +                      const char *vf_token)
> > +{
> > +     vfio_pci_cdev_open(device, bdf);
> > +     return __vfio_device_bind_iommufd(device->fd,
> > +                                       device->iommu->iommufd, vf_toke=
n);
> > +}
>
> I see these are also similar to the code in library with some
> differences. May be we can refactor library code and reuse it here.
>
> One option can be to split vfio_pci_iommufd_setup() in two parts where
> first part is what your are doing above and second part is attaching PT.
>
I think my above statement applies here too. Moreover,
vfio_pci_iommufd_setup() seems to integrate the three calls really
well, even in terms of readability. Splitting out only
vfio_device_attach_iommufd_pt() (or an other function) just for the
sake of this test didn't make much sense. Hence, I retained the flow.
But again, if we have usecases in the future, we can split it.

> > +
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
> > +}
>
> Same for this one, vfio_pci_device_init() can be composed of two parts,
> first one being alloc and container/iommufd setup and second device
> setup and driver probe.
>
> My reasoning for this is to avoid having separate code for these common
> flows and avoid them diverging down the line.
>
Similar comment to the one above. I avoided refactoring the library
code just to make one-off assertions relevant only to this test.

> > +
> > +static void device_cleanup(struct vfio_pci_device *device)
> > +{
> > +     if (device->fd > 0)
> > +             VFIO_ASSERT_EQ(close(device->fd), 0);
> > +
> > +     if (device->group_fd)
> > +             VFIO_ASSERT_EQ(close(device->group_fd), 0);
> > +
> > +     vfio_pci_device_free(device);
> > +}
> > +
> > +FIXTURE(vfio_pci_sriov_uapi_test) {
> > +     char *vf_bdf;
>
> Nit: Can we just use an array like char vf_bdf[16]?
> Just not sure why we need to do alloc and free for each run.
>
We can. In fact, I initially had that (for getting the driver path
though in v2), but this felt a bit cleaner (suggested by David) and
similar to how we handle most kernel allocations. This way the caller
doesn't have to guess a size, while the library knows an appropriate
size.

> > +};
> > +
> > +FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
> > +{
> > +     char *vf_driver;
> > +     int nr_vfs;
> > +
> > +     nr_vfs =3D sysfs_sriov_totalvfs_get(pf_bdf);
> > +     if (nr_vfs <=3D 0)
> > +             SKIP(return, "SR-IOV may not be supported by the PF: %s\n=
", pf_bdf);
> > +
> > +     nr_vfs =3D sysfs_sriov_numvfs_get(pf_bdf);
> > +     if (nr_vfs !=3D 0)
> > +             SKIP(return, "SR-IOV already configured for the PF: %s\n"=
, pf_bdf);
> > +
>
> If there is a test failure (ASSERT) then fixture cleanup will not run
> leaving SR-IOV enabled and all subsequent tests will skip.
>
> Since this test is specific to SR-IOV and user is intentionally passing
> a device to test, I think we can just reset the VFs to 0 before
> proceeding instead of skipping.
>
The idea was to eliminate the assumption that if 'sriov_numvfs'
returns > 0, someone else might be using it. This is based on David's
suggestion: https://lore.kernel.org/all/aQzcQ0fJd-aCRThS@google.com/ .
Moreover, the device might be in a partial state. So, even if the next
test proceeds, it could fail due to other reasons.

But I see your point about cleanup on failure. I think this is a
common issue across all tests. Was the expectation that we rely on
cleanup.sh to take care of all the cleanups, regardless of test
pass/failure?

> > +     /* Create only one VF for testing */
> > +     sysfs_sriov_numvfs_set(pf_bdf, 1);
> > +     self->vf_bdf =3D sysfs_sriov_vf_bdf_get(pf_bdf, 0);
> > +
> > +     /*
> > +      * The VF inherits the driver from the PF.
> > +      * Ensure this is 'vfio-pci' before proceeding.
> > +      */
> > +     vf_driver =3D sysfs_driver_get(self->vf_bdf);
> > +     ASSERT_NE(vf_driver, NULL);
> > +     ASSERT_EQ(strcmp(vf_driver, "vfio-pci"), 0);
> > +     free(vf_driver);
> > +
> > +     printf("Created 1 VF (%s) under the PF: %s\n", self->vf_bdf, pf_b=
df);
> > +}
> > +
> > +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> > +{
> > +     free(self->vf_bdf);
> > +     sysfs_sriov_numvfs_set(pf_bdf, 0);
> > +}
> > +
> > +FIXTURE_VARIANT(vfio_pci_sriov_uapi_test) {
> > +     const char *iommu_mode;
> > +     char *vf_token;
> > +};
> > +
> > +#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _vf_token) =
               \
> > +FIXTURE_VARIANT_ADD(vfio_pci_sriov_uapi_test, _iommu_mode ## _ ## _nam=
e) {   \
> > +     .iommu_mode =3D #_iommu_mode,                                    =
         \
> > +     .vf_token =3D (_vf_token),                                       =
         \
> > +}
> > +
> > +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(same_uuid, UUID_1);
> > +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(diff_uuid, UUID_2);
> > +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(null_uuid, NULL);
> > +
> > +/*
> > + * PF's token is always set with UUID_1 and VF's token is rotated with
> > + * various tokens (including UUID_1 and NULL).
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
>
> Can this and cleanup go in fixture setup?
>
Isn't 'variant' inaccessible from FIXUTURE_SETUP()?

> > +     pf =3D device_init(pf_bdf, iommu, UUID_1, &ret);
>
> We should assert here as well and in other functions.
>
Good point. I'll add it in v7.

Thank you.
Raghavendra
