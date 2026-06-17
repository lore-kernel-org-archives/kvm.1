Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D110492182
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710247; cv=pass; b=Cju+fNPjJPKFkmF03JWZgtKd6vrTA9cwPZdiRmtaXZpolbnokwXcYwiYrsyHOua62O9M2SlVsmDNdu1PqZfIpJF8hik7I0am1+AqkSom2VR3n9/j4JllTdgZ7WSBzqjzeS7whVLSI8auQgHO8Vw45WCsDNQEvfJy41BgUNJt6Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710247; c=relaxed/simple;
	bh=hZoWH+tzmfw9BZGoI6OlpbQZAksQKMil6t6sUOwkoFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X50B5iuz/IR8nsAAXMCzZMPtz4Tl4KSJvJJxmVjcIcRIxP/L4xf9EbW/m1Ah7ndD02ir9pfjGOE2AI+9MexWj25mwZuyvVchqETotrVJs4DBlUrrZSUe9KhJxuyo6+DlIUEmtYNreLKDzXnIgA/BXLxkqP4oye2Inl+tNMSx55M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqqDFiP/; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqqDFiP/"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13809223fd4so6454404c88.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 08:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781710237; cv=none;
        d=google.com; s=arc-20240605;
        b=F3+M5iDk8n0XA8RonpMuuX5ds++wkdB8sPgG4tg7FAtDa6Fduh6d9JbXb5Z5+3YfUg
         kSIDOs+wpW8YKqJde3uWjXvmtetnbK0bUSj1eAolYECpJck4EmSxZP88s1ZspiRJ8/ql
         WFlpXcAOCuZhV4bfShYbB+Sp/+8rVXPUTGmDOq47wOfawLbwGU8TX/i1DLwI7T7MbWQg
         06ITbbikOCfaAR7Ql9rNxpzH9vquwDEpYjPN19bKMHby0w8TSTkCiIIZjsFaH/2052Yd
         nOvwFfGWlU6wFPhhd9t36EiMIutDYobsD8bwQKIXvc8ELI43oBo8Uhr93/LhNlp3iAFG
         tL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngFih+jQ2ELuwuQpCE5AZDhkpTWG0tYdh6zEUh333vs=;
        fh=EZHbr4AurpZXFXI52NqRhhvTfhMgBPz/o0b4cNXmKro=;
        b=RbdMtGbvFFEsF2q32O6UnoNkxKcXLp/NQGiy9RPqqqdaaAmpV/uMXU6aHo/DL8HSUn
         jxXQCuUqMU2Zfyp4QxP8kAX6MbOZZ4eoovjTEcoOqcHrwZLJaUNm40jDm4PON8HxNRoa
         x9m9MIZ/56/1xkbhEarkl1m3Q8wH+mIryzZw+IJbUwSF1Db8FR5hyTm7QPJRgdcrZfw6
         JXFp28Nd3iN3DfrOBK53QfsFS7U8ejIaCD8IBxVWFS7+czia6eCNnbbh+4gJilBTr2Be
         ZblXsYlGBI8w4zOoq1QA7RQWL7NlkyZD4IeJWU762fzZgN5kJ7qEXQmpV7mvRY8ZzeEQ
         QgKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781710237; x=1782315037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngFih+jQ2ELuwuQpCE5AZDhkpTWG0tYdh6zEUh333vs=;
        b=HqqDFiP/gAiMKOfyIKt5ddk2u5Ox8jwEMbcL2/3Uh6N97FCFx7mwrVvtC3gd+l2gP/
         g9eRceSQ/Q/TPdszP9MXTaidMNhq/gxiiMe2pALQAdw1mXOhrivjZhtC9t86l4Z3E+g2
         r2x6OzsArRgvB4BKtWKrO7By39MAe5107gdyUFLsR4S3SzYL6SMgjd427aM9w7ai7GTt
         BXwrPq9D3JHqN+noXVUP+cqyiyDwYFAh52TCGvf5DNA05itK9B2xhF62gxetsmYXZEH4
         b0TgZbj/H2mnQoSqnU1E0gOdhY5A42l0YUe7kusfaSRu8jrq0ZGnBrGis3aM55xmbUm9
         vcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710237; x=1782315037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngFih+jQ2ELuwuQpCE5AZDhkpTWG0tYdh6zEUh333vs=;
        b=lY+x3EjDBu7mKYUQrbFv3F0g0v55ZdhJvy9C/soC0kPtPfs6tffHo/EZs2mJOVJ3jv
         yEc5M2aQhViCYlTXOlW+QUbqYmVrsBMXgFIwDNDcxM9LhauYuBWWjMZ1mquCf+cHeiKX
         BFakuG/aFAKIs74zBUK0kIJ+gOGtHj1QZVURRJmEmNMcKcv59u4v+5r2kjuM5KzWA1cq
         9e5xyUJJ+QgxwRpy2eMEzHq99LcMjTWzSIElyWIUi+/giE4wqY+Hswb+5vw+avW5aMcx
         DVF7tt9Q/InSJCf5iswqMuaWaNjasP4IG9XRVCbc4lRIlsHdrtGQfGFb3LkUYgrQg4he
         KPJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+y1ASInJgfGb5wafPNGqOS0Mvjx10J8QwBiCs7CnRWmv8zMtt0cCGRV4vOyA/0a/8jiVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEOMAECKELkjwWATnuWnky2vQQNJlV5LahMLUAUNn1dR/i3hJD
	bDm03Ad8aHfeL1i80JPCGTE4N2jtQ4LBm/GGnKpbYI27kOMZnyWOu37+I9Z95EsF5rGQ25kZd7x
	CYA+fE+94HmyW4MmBkurRFbgb5CyVniMVruJw7b1C
X-Gm-Gg: Acq92OHeGmvLtV6hYiHMtryoqTkSKsXSvnmPeZ0QR0p8HiruBrqYDhIvvwBd3ZfGK21
	KSGOjs+EcQk6yAptDzlRs4B80OiVu762J9H9MtIMDwBPFM8RyZGf6zW/lD+SIBg+mk2DSwv311Z
	QRQnThoIYSBM95S8zbtnL/feGO+HjFv4j3bjNxrTMogbVEU2o4Ycg1cd9mgUbWxTTqZHnEJs1tb
	bqfL5rWN/Czn/WaiiKBE1icDoq46oehr6fF7qxKulyjaATKLbB07PsSs3vwEpZTDRRqkeyLboWO
	GUi/Fi8=
X-Received: by 2002:a05:7022:326:b0:138:22f:9a2c with SMTP id
 a92af1059eb24-1398f66b115mr1812057c88.5.1781710236408; Wed, 17 Jun 2026
 08:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
 <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-1-b3798415c72a@fb.com>
 <CALzav=ekpRKjyUTNax17SRMHg21OHa4Jq3OGzu+Y0TXW12EeJQ@mail.gmail.com> <ajF0Fistyj7SXlDi@devgpu015.cco6.facebook.com>
In-Reply-To: <ajF0Fistyj7SXlDi@devgpu015.cco6.facebook.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 17 Jun 2026 08:30:08 -0700
X-Gm-Features: AVVi8CeHk9pkviFn0yqBZwvK95FPCk-wXkr971zts8bYljh9HBFxozbipL582dA
Message-ID: <CALzav=cbgg=09hyRb0nnrjGF8qn2Tn5uSEsZa7i7bTtviVynNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vfio: selftests: Add calloc_assert() helper
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:04=E2=80=AFAM Alex Mastro <amastro@fb.com> wrote:
>
> On Mon, Jun 15, 2026 at 03:51:26PM -0700, David Matlack wrote:
> > On Mon, Jun 15, 2026 at 12:45=E2=80=AFPM Alex Mastro <amastro@fb.com> w=
rote:
> > >
> > > Add a calloc_assert() helper alongside the existing ioctl_assert() an=
d
> > > snprintf_assert() helpers.
> > >
> > > Use it for VFIO selftest allocations that immediately assert a
> > > non-NULL result.
> > >
> > > Assisted-by: Codex:gpt-5.5-high
> > > Signed-off-by: Alex Mastro <amastro@fb.com>
> > > ---
> > >  tools/testing/selftests/vfio/lib/include/libvfio/assert.h    | 10 ++=
++++++++
> > >  tools/testing/selftests/vfio/lib/iommu.c                     | 12 ++=
++--------
> > >  tools/testing/selftests/vfio/lib/iova_allocator.c            |  4 +-=
--
> > >  tools/testing/selftests/vfio/lib/sysfs.c                     |  3 +-=
-
> > >  tools/testing/selftests/vfio/lib/vfio_pci_device.c           |  6 ++=
----
> > >  .../testing/selftests/vfio/vfio_pci_device_init_perf_test.c  |  4 ++=
--
> > >  6 files changed, 20 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.=
h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> > > index 77b68c7129a6..f0490a403826 100644
> > > --- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> > > +++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> > > @@ -3,6 +3,7 @@
> > >  #define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H
> > >
> > >  #include <stdio.h>
> > > +#include <stdlib.h>
> > >  #include <string.h>
> > >  #include <sys/ioctl.h>
> > >
> > > @@ -45,6 +46,15 @@
> > >         VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);                 \
> > >  } while (0)
> > >
> > > +#define calloc_assert(_nmemb, _size) ({                             =
   \
> > > +       size_t __nmemb =3D (_nmemb);                              \
> > > +       size_t __size =3D (_size);                                \
> > > +       void *__ptr =3D calloc(__nmemb, __size);                  \
> > > +       VFIO_ASSERT_NOT_NULL(__ptr, "calloc(%zu, %zu) failed",  \
> > > +                            __nmemb, __size);                  \
> > > +       __ptr;                                                  \
> > > +})
> > > +
> > >  #define ioctl_assert(_fd, _op, _arg) do {                           =
                          \
> > >         void *__arg =3D (_arg);                                      =
                            \
> > >         int __ret =3D ioctl((_fd), (_op), (__arg));                  =
                            \
> > > diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing=
/selftests/vfio/lib/iommu.c
> > > index 035dac069d60..31aba9fda8e5 100644
> > > --- a/tools/testing/selftests/vfio/lib/iommu.c
> > > +++ b/tools/testing/selftests/vfio/lib/iommu.c
> > > @@ -286,8 +286,7 @@ static struct vfio_iommu_type1_info *vfio_iommu_g=
et_info(int container_fd)
> > >  {
> > >         struct vfio_iommu_type1_info *info;
> > >
> > > -       info =3D malloc(sizeof(*info));
> > > -       VFIO_ASSERT_NOT_NULL(info);
> > > +       info =3D calloc_assert(1, sizeof(*info));
> > >
> > >         *info =3D (struct vfio_iommu_type1_info) {
> > >                 .argsz =3D sizeof(*info),
> > > @@ -324,8 +323,7 @@ static struct iommu_iova_range *vfio_iommu_iova_r=
anges(struct iommu *iommu,
> > >         cap_range =3D container_of(hdr, struct vfio_iommu_type1_info_=
cap_iova_range, header);
> > >         VFIO_ASSERT_GT(cap_range->nr_iovas, 0);
> > >
> > > -       ranges =3D calloc(cap_range->nr_iovas, sizeof(*ranges));
> > > -       VFIO_ASSERT_NOT_NULL(ranges);
> > > +       ranges =3D calloc_assert(cap_range->nr_iovas, sizeof(*ranges)=
);
> > >
> > >         for (u32 i =3D 0; i < cap_range->nr_iovas; i++) {
> > >                 ranges[i] =3D (struct iommu_iova_range){
> > > @@ -357,8 +355,7 @@ static struct iommu_iova_range *iommufd_iova_rang=
es(struct iommu *iommu,
> > >         VFIO_ASSERT_EQ(errno, EMSGSIZE);
> > >         VFIO_ASSERT_GT(query.num_iovas, 0);
> > >
> > > -       ranges =3D calloc(query.num_iovas, sizeof(*ranges));
> > > -       VFIO_ASSERT_NOT_NULL(ranges);
> > > +       ranges =3D calloc_assert(query.num_iovas, sizeof(*ranges));
> > >
> > >         query.allowed_iovas =3D (uintptr_t)ranges;
> > >
> > > @@ -424,8 +421,7 @@ struct iommu *iommu_init(const char *iommu_mode)
> > >         struct iommu *iommu;
> > >         int version;
> > >
> > > -       iommu =3D calloc(1, sizeof(*iommu));
> > > -       VFIO_ASSERT_NOT_NULL(iommu);
> > > +       iommu =3D calloc_assert(1, sizeof(*iommu));
> > >
> > >         INIT_LIST_HEAD(&iommu->dma_regions);
> > >
> > > diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tool=
s/testing/selftests/vfio/lib/iova_allocator.c
> > > index 8c1cc86b70cd..2e7d54e1b4c6 100644
> > > --- a/tools/testing/selftests/vfio/lib/iova_allocator.c
> > > +++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
> > > @@ -29,8 +29,7 @@ struct iova_allocator *iova_allocator_init(struct i=
ommu *iommu)
> > >         ranges =3D iommu_iova_ranges(iommu, &nranges);
> > >         VFIO_ASSERT_NOT_NULL(ranges);
> > >
> > > -       allocator =3D malloc(sizeof(*allocator));
> > > -       VFIO_ASSERT_NOT_NULL(allocator);
> > > +       allocator =3D calloc_assert(1, sizeof(*allocator));
> >
> > Did you mean to replace malloc() with calloc()? Feel free to add a
> > malloc_assert().
>
> Yes! Since all malloc() can be expressed as calloc() (because we shouldn'=
t care
> about potentially redundant zeroing overhead), I think the single
> calloc_assert() is fine.

I agree the extra zeroing overhead is not a big deal for these
allocations. But it is odd to see calloc being used where it is not
needed, and there may be future users that truly want a
malloc_assert() over calloc_assert(). Let's just add a malloc_assert()
in this patch. It should be a simple change.

>
> >
> > >
> > >         *allocator =3D (struct iova_allocator){
> > >                 .ranges =3D ranges,
> > > @@ -90,4 +89,3 @@ iova_t iova_allocator_alloc(struct iova_allocator *=
allocator, size_t size)
> > >                 allocator->range_offset =3D 0;
> > >         }
> > >  }
> > > -
> > > diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing=
/selftests/vfio/lib/sysfs.c
> > > index 11415448b2e2..98a46a2543cd 100644
> > > --- a/tools/testing/selftests/vfio/lib/sysfs.c
> > > +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> > > @@ -107,8 +107,7 @@ char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, =
int i)
> > >         char *out_vf_bdf;
> > >
> > >         /* Fit "0000:00:00.0" */
> > > -       out_vf_bdf =3D calloc(16, sizeof(char));
> > > -       VFIO_ASSERT_NOT_NULL(out_vf_bdf);
> > > +       out_vf_bdf =3D calloc_assert(16, sizeof(char));
> > >
> > >         snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/virt=
fn%d", pf_bdf, i);
> > >         readlink_base(path, "%s", out_vf_bdf);
> > > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/too=
ls/testing/selftests/vfio/lib/vfio_pci_device.c
> > > index 94dc5fcecbeb..eb40f7159bae 100644
> > > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > @@ -343,8 +343,7 @@ const char *vfio_pci_get_cdev_path(const char *bd=
f)
> > >         char *cdev_path;
> > >         DIR *dir;
> > >
> > > -       cdev_path =3D calloc(PATH_MAX, 1);
> > > -       VFIO_ASSERT_NOT_NULL(cdev_path);
> > > +       cdev_path =3D calloc_assert(PATH_MAX, 1);
> > >
> > >         snprintf_assert(dir_path, sizeof(dir_path), "/sys/bus/pci/dev=
ices/%s/vfio-dev/", bdf);
> > >
> > > @@ -425,8 +424,7 @@ struct vfio_pci_device *vfio_pci_device_alloc(con=
st char *bdf, struct iommu *iom
> > >  {
> > >         struct vfio_pci_device *device;
> > >
> > > -       device =3D calloc(1, sizeof(*device));
> > > -       VFIO_ASSERT_NOT_NULL(device);
> > > +       device =3D calloc_assert(1, sizeof(*device));
> > >
> > >         VFIO_ASSERT_NOT_NULL(iommu);
> > >         device->iommu =3D iommu;
> > > diff --git a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_t=
est.c b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> > > index 33b0c31fe2ed..e1a54e153cd3 100644
> > > --- a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> > > +++ b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> > > @@ -45,8 +45,8 @@ FIXTURE_SETUP(vfio_pci_device_init_perf_test)
> > >         int i;
> > >
> > >         self->iommu =3D iommu_init(variant->iommu_mode);
> > > -       self->threads =3D calloc(nr_devices, sizeof(self->threads[0])=
);
> > > -       self->thread_args =3D calloc(nr_devices, sizeof(self->thread_=
args[0]));
> > > +       self->threads =3D calloc_assert(nr_devices, sizeof(self->thre=
ads[0]));
> > > +       self->thread_args =3D calloc_assert(nr_devices, sizeof(self->=
thread_args[0]));
> > >
> > >         pthread_barrier_init(&self->barrier, NULL, nr_devices);
> > >
> > >
> > > --
> > > 2.53.0-Meta
> > >
