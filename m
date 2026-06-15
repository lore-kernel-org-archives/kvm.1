Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BF79CD
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563917; cv=pass; b=afqErR0mJLT6AenYSLm3QtYqFCXa8LsyUO5Px38Se33yZePmYDb4AL+bKDbl8X8ToeDe/AoaC7AuPwh+dkVRUv02NGRDUD46lnFL68px3eu1bant06DCF0g4LW+q47nG17vhmr33lkbvzvsQGj/KxX/OuMO2z5/mt3W3sgPwlCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563917; c=relaxed/simple;
	bh=tifnMs3uxqQLI6PjEM34afP6/zTTxzyFpcFDkVzMVEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSQs9+0nkA0wAjaW+vcA/mytMqfo48cKATbxEH3aBMKbjML8tae0cQq82CBbAAIJd11kAIUDLj/WmLrDOm85KWKiMaUpaKOEUcv1SeS+qtYpp8bN9wwgja5SyQUj2Pdz4KCMw7FsWgFF/01r5nGlEvIHrbdt/ApfX7+qQLQU14g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwRydzgr; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwRydzgr"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13986d61b4eso338183c88.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 15:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781563915; cv=none;
        d=google.com; s=arc-20240605;
        b=GBvIB1C2OL4XiRC1qU1+jAwCh1zaIxgLX2YqP2yzou9PSKjFNA90q0ft3u3BYiSPzH
         54nh/160cxZNoB9O7CCK0OwmSzdGJdbhv8sdlboj6wlm3uZpXrYS8PD/X8Mfwkb5aDSK
         fd1LNWT06Gqjak08kIB6E1TzsUrg9ibDsBcCZs/s8Bqc0lYY3md3Kag4t7hYkZaKamCP
         xzrnzNfUt7iMYm8s2NSP4+U3iVx0Qcw0XROWAcKBjv4HvSWvXGgnoe8XujQ2XuCSde0B
         HbBlQQu5WDKN2zsaMXoG5Cn/PPzOqcjUy0TblB4GVMZI40jsSM5HJGdbhb0yfqmVltAA
         VYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V7htDb+Jq/c33orgyhz/QuFvE0iXgDEbc65hqs+kuaU=;
        fh=DLuPipKiLgM1osjHJhY+tkUgUaRNrCYCpNs5HfgtqME=;
        b=QWzVE6Bx66uQKIedSZ3teTMC+O3fAyy05jCYRRB9uqzvEIZU4vR7xDr274xUSkGr/h
         uzlkyZCcxYY0fEQ1P8U5/R2vAaiTnQta88iD0MmBzwFaSLA6x07ZQIlVPABGlbXFI/XL
         OG9qFpevpN56Jftfg5vZ7J2ausqP9rZE20CM5WrpYI6rltgy0aWdlf62hij7u7WCTxy4
         /8VhI2GerhjbBnwp1K9NNRTct5F/5PMerC0+P9LdFcRRIVAnsnf83ZCREODs0tov+G3Q
         2HUHnssa+MbWJ+ndAaAUfP8p/PzHs0xNTpr7ldULjOtRWvyXl0CK3XrnW621MxnbO6kg
         2owA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781563915; x=1782168715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7htDb+Jq/c33orgyhz/QuFvE0iXgDEbc65hqs+kuaU=;
        b=gwRydzgr2Wwh0p9Z2rFLJUbsuo9LDN8uStRFC/a77PTf/3Z6zR+pH2Mbwc80vPCPN7
         V6M4kCBb1EMzAm9aHOWcfHbmQL73g1FTkhStfYWjIgVtlpKRteWRAfEMhVxA3woUvsCh
         N375gN+FBZlVn4kDZ41RXEDpdOJKS7QFn9vUgV5vH6eT11zCfuzblVYbnVFF5KlOo5Wp
         0AcE43tude2GTcX8O39Awy4uOVs/PzNGxnu4j/H40iz0umnPQ9XgBRhn6l4CRM5D/Nml
         GH3Hk0BSSYRymKH0W8/nJ9yWYY0Lo8TTnSAwMYIvqiplR7vhgMCyHiSYC/P3wkKptvX2
         VXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781563915; x=1782168715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V7htDb+Jq/c33orgyhz/QuFvE0iXgDEbc65hqs+kuaU=;
        b=dVhhuIYvgu6IQuJDikXkiFOxUjSjuC+LwmhnREQ7JCQnh7xB2+lVvho9mf+lpsvfds
         XPZZcS5mUBiZYn8kh5G9rIULpRjis3hboZwjmz2Uhmzg3peKTeaxIxpYq3g993ejME20
         hByeiXTPaRb2JQTo+mHL/k9MTtGtsZBmRMylrVzXfiC66lGAJEtVSHXvKQ2iYH43AJM0
         Ox7Q8+cQzkPohuJKX6x/LxXbMDaquGyuzbEoeo0RKrWX5khEXi2NjzPdnR+yDIaFlLLO
         6OuPf8CNajHyedG9gJJlQ+9yoJ8MA0oke8fhcSvW3wvssH/skg84jJFgg1nFvyveQ+La
         1Rew==
X-Forwarded-Encrypted: i=1; AFNElJ8PQfm6VMrevA9xofN51rsicHtlh3irM4CyNXR1BBWAtyXSWm41hBjLTHqm8kqq5nQ2dEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOH7hTqT0t0pnAz7offjI06lC4LqUJUZwpfOG7h749T4bzmYs
	o1dnbHKAIvX9RnD9q/cKI8yiPfE0DGLyuL3DQpbJHwXDqCtaZZr/iJdMcodCpx4MKS0BP5+Xxzx
	GSMp5wvfyc4T6pY9ZtPr+uZ2K6rbp+8jwjrzC7lRi
X-Gm-Gg: Acq92OHbem4KvDkzNumV78Qve7BRLuyzMO6QX3S+oG9GK/+tG7kMZy3+dPBaiAmM7uF
	ezyL5njsTWmF9ok9ps/yRsdoDRKW1NqiDAoFbaUvDRXCBmxTouJ8r0sdmxbUaKqF5+FDEn+NpEI
	wv3O0ft93a7tHuST5baZh2fmXDt6pHIKoeyGfCDqAdrz0uhG0vBY7WsyysXLg192lenKoEe9cXe
	Be3OGMSfyEXW1Xx+JyEFrtfJl+oJnaJEQpU2lV1l8cG/lTl+PdFegVixtvg1q+PEM0c3KObhBDa
	IkirGWNF+Dt1nVGn/Q==
X-Received: by 2002:a05:7022:2585:b0:136:c565:e83a with SMTP id
 a92af1059eb24-13985f08bd5mr605265c88.24.1781563913813; Mon, 15 Jun 2026
 15:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
 <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-1-b3798415c72a@fb.com>
In-Reply-To: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-1-b3798415c72a@fb.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 15 Jun 2026 15:51:26 -0700
X-Gm-Features: AVVi8CeNxoA54KcrcCyWFzTbn8RVwfvTsFJl5AP-We_ewnvrZTx2yIRi0SqUX1U
Message-ID: <CALzav=ekpRKjyUTNax17SRMHg21OHa4Jq3OGzu+Y0TXW12EeJQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vfio: selftests: Add calloc_assert() helper
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 12:45=E2=80=AFPM Alex Mastro <amastro@fb.com> wrote=
:
>
> Add a calloc_assert() helper alongside the existing ioctl_assert() and
> snprintf_assert() helpers.
>
> Use it for VFIO selftest allocations that immediately assert a
> non-NULL result.
>
> Assisted-by: Codex:gpt-5.5-high
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
>  tools/testing/selftests/vfio/lib/include/libvfio/assert.h    | 10 ++++++=
++++
>  tools/testing/selftests/vfio/lib/iommu.c                     | 12 ++++--=
------
>  tools/testing/selftests/vfio/lib/iova_allocator.c            |  4 +---
>  tools/testing/selftests/vfio/lib/sysfs.c                     |  3 +--
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c           |  6 ++----
>  .../testing/selftests/vfio/vfio_pci_device_init_perf_test.c  |  4 ++--
>  6 files changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/=
tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> index 77b68c7129a6..f0490a403826 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
> @@ -3,6 +3,7 @@
>  #define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H
>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
>
> @@ -45,6 +46,15 @@
>         VFIO_LOG_AND_EXIT(_fmt, ##__VA_ARGS__);                 \
>  } while (0)
>
> +#define calloc_assert(_nmemb, _size) ({                                \
> +       size_t __nmemb =3D (_nmemb);                              \
> +       size_t __size =3D (_size);                                \
> +       void *__ptr =3D calloc(__nmemb, __size);                  \
> +       VFIO_ASSERT_NOT_NULL(__ptr, "calloc(%zu, %zu) failed",  \
> +                            __nmemb, __size);                  \
> +       __ptr;                                                  \
> +})
> +
>  #define ioctl_assert(_fd, _op, _arg) do {                               =
                      \
>         void *__arg =3D (_arg);                                          =
                        \
>         int __ret =3D ioctl((_fd), (_op), (__arg));                      =
                        \
> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/sel=
ftests/vfio/lib/iommu.c
> index 035dac069d60..31aba9fda8e5 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c
> @@ -286,8 +286,7 @@ static struct vfio_iommu_type1_info *vfio_iommu_get_i=
nfo(int container_fd)
>  {
>         struct vfio_iommu_type1_info *info;
>
> -       info =3D malloc(sizeof(*info));
> -       VFIO_ASSERT_NOT_NULL(info);
> +       info =3D calloc_assert(1, sizeof(*info));
>
>         *info =3D (struct vfio_iommu_type1_info) {
>                 .argsz =3D sizeof(*info),
> @@ -324,8 +323,7 @@ static struct iommu_iova_range *vfio_iommu_iova_range=
s(struct iommu *iommu,
>         cap_range =3D container_of(hdr, struct vfio_iommu_type1_info_cap_=
iova_range, header);
>         VFIO_ASSERT_GT(cap_range->nr_iovas, 0);
>
> -       ranges =3D calloc(cap_range->nr_iovas, sizeof(*ranges));
> -       VFIO_ASSERT_NOT_NULL(ranges);
> +       ranges =3D calloc_assert(cap_range->nr_iovas, sizeof(*ranges));
>
>         for (u32 i =3D 0; i < cap_range->nr_iovas; i++) {
>                 ranges[i] =3D (struct iommu_iova_range){
> @@ -357,8 +355,7 @@ static struct iommu_iova_range *iommufd_iova_ranges(s=
truct iommu *iommu,
>         VFIO_ASSERT_EQ(errno, EMSGSIZE);
>         VFIO_ASSERT_GT(query.num_iovas, 0);
>
> -       ranges =3D calloc(query.num_iovas, sizeof(*ranges));
> -       VFIO_ASSERT_NOT_NULL(ranges);
> +       ranges =3D calloc_assert(query.num_iovas, sizeof(*ranges));
>
>         query.allowed_iovas =3D (uintptr_t)ranges;
>
> @@ -424,8 +421,7 @@ struct iommu *iommu_init(const char *iommu_mode)
>         struct iommu *iommu;
>         int version;
>
> -       iommu =3D calloc(1, sizeof(*iommu));
> -       VFIO_ASSERT_NOT_NULL(iommu);
> +       iommu =3D calloc_assert(1, sizeof(*iommu));
>
>         INIT_LIST_HEAD(&iommu->dma_regions);
>
> diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/te=
sting/selftests/vfio/lib/iova_allocator.c
> index 8c1cc86b70cd..2e7d54e1b4c6 100644
> --- a/tools/testing/selftests/vfio/lib/iova_allocator.c
> +++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
> @@ -29,8 +29,7 @@ struct iova_allocator *iova_allocator_init(struct iommu=
 *iommu)
>         ranges =3D iommu_iova_ranges(iommu, &nranges);
>         VFIO_ASSERT_NOT_NULL(ranges);
>
> -       allocator =3D malloc(sizeof(*allocator));
> -       VFIO_ASSERT_NOT_NULL(allocator);
> +       allocator =3D calloc_assert(1, sizeof(*allocator));

Did you mean to replace malloc() with calloc()? Feel free to add a
malloc_assert().

>
>         *allocator =3D (struct iova_allocator){
>                 .ranges =3D ranges,
> @@ -90,4 +89,3 @@ iova_t iova_allocator_alloc(struct iova_allocator *allo=
cator, size_t size)
>                 allocator->range_offset =3D 0;
>         }
>  }
> -
> diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/sel=
ftests/vfio/lib/sysfs.c
> index 11415448b2e2..98a46a2543cd 100644
> --- a/tools/testing/selftests/vfio/lib/sysfs.c
> +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> @@ -107,8 +107,7 @@ char *sysfs_sriov_vf_bdf_get(const char *pf_bdf, int =
i)
>         char *out_vf_bdf;
>
>         /* Fit "0000:00:00.0" */
> -       out_vf_bdf =3D calloc(16, sizeof(char));
> -       VFIO_ASSERT_NOT_NULL(out_vf_bdf);
> +       out_vf_bdf =3D calloc_assert(16, sizeof(char));
>
>         snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/virtfn%d=
", pf_bdf, i);
>         readlink_base(path, "%s", out_vf_bdf);
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/t=
esting/selftests/vfio/lib/vfio_pci_device.c
> index 94dc5fcecbeb..eb40f7159bae 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -343,8 +343,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
>         char *cdev_path;
>         DIR *dir;
>
> -       cdev_path =3D calloc(PATH_MAX, 1);
> -       VFIO_ASSERT_NOT_NULL(cdev_path);
> +       cdev_path =3D calloc_assert(PATH_MAX, 1);
>
>         snprintf_assert(dir_path, sizeof(dir_path), "/sys/bus/pci/devices=
/%s/vfio-dev/", bdf);
>
> @@ -425,8 +424,7 @@ struct vfio_pci_device *vfio_pci_device_alloc(const c=
har *bdf, struct iommu *iom
>  {
>         struct vfio_pci_device *device;
>
> -       device =3D calloc(1, sizeof(*device));
> -       VFIO_ASSERT_NOT_NULL(device);
> +       device =3D calloc_assert(1, sizeof(*device));
>
>         VFIO_ASSERT_NOT_NULL(iommu);
>         device->iommu =3D iommu;
> diff --git a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.=
c b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> index 33b0c31fe2ed..e1a54e153cd3 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
> @@ -45,8 +45,8 @@ FIXTURE_SETUP(vfio_pci_device_init_perf_test)
>         int i;
>
>         self->iommu =3D iommu_init(variant->iommu_mode);
> -       self->threads =3D calloc(nr_devices, sizeof(self->threads[0]));
> -       self->thread_args =3D calloc(nr_devices, sizeof(self->thread_args=
[0]));
> +       self->threads =3D calloc_assert(nr_devices, sizeof(self->threads[=
0]));
> +       self->thread_args =3D calloc_assert(nr_devices, sizeof(self->thre=
ad_args[0]));
>
>         pthread_barrier_init(&self->barrier, NULL, nr_devices);
>
>
> --
> 2.53.0-Meta
>
