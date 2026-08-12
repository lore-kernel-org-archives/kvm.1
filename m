Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6C411689
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572819; cv=pass; b=dc1QexJEgQUC410lsXDM7y6EtJf6kpdDQHlDntlTckmUh//ROKGFsgy14R1xQqzHWIOQTWXpDrLt27BaY+ekdDLdddK4TWCfIF1Vt0AqZBkgF8uZt+gN49Tb3824pwQYMzhd4JBPYsOLOUtFrpcT2LyGMPwAyrcaliWHlq8TBgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572819; c=relaxed/simple;
	bh=byyagvsc1UjkE8b+SW2ccxMNYjbe0DMj7QW0GEW3cJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHrtRzzQ/MacU0g4tAp0a2jomA1oPoLpcGtw8vjAcT1uRMBPDWRIechwtRLPttqxDuoKgnc9Z9iKdSdNLcVfLzyXGly6K92YDPVIxIQ4ahD0QY2aX4GKPvkmdf4mObAUhs3V/DLzX9ySBtDnbjXUnkMa20gZprPPkNhoOy+xeeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/9mm1CP; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/9mm1CP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1476695a91.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 15:13:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786572817; cv=none;
        d=google.com; s=arc-20260327;
        b=UMsM1Mqpeqy282AnliUBgWNq+VYl98ALCxWftGp+cxs9w/QD05+wajEf8O2rz0h9eu
         E6kfyuUyTPRLNiYW8ApD5CNt5Mghv8twlYdk43k+HKIYHwyy3PJInM9/9Yxs8cpaPP6O
         vZ5Nwl1PUoQGfta3+dqxR9c0dY6kX7lwn696/jiutUvkm/GprYEBdLqw/JK9Wa71+uDs
         00/UXqH73GNnhoCrZOiSOT8XCcL2eDBMgSNWANK4zD7XUWxDF2aKmGcILfGQCIy5Gb9v
         WHYcYI3MGQnfRzhqI0rWlMqnQ8zxi6jZ9xf3NvjC7ZcIi9hj/lSmpcK6x7mlnRINGLfB
         oFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2diJELU9B/EJYj35M681THFCJwWyYCFNlAAsuJpsCA=;
        fh=32hJ+rT/ixy7KDzRu9IjaiPdWVoFTBUW4Q3Q1epXMeg=;
        b=WocYro3wuYgfyRnEXVkuE8DQHuI2/qicxPYppDz6FnuSZOwr95KZMahHOfe5iCsep/
         uWrtX48Mo0qQ+jqDOxwdEg6mbTqIsbjv6rJbdzYwyu6MJ9KNMwRbISFI7hCiL5XsIa2I
         30V/pXX+ZFL9AxmKGUjdkqODdUe+AJupKgvDmKptd1bpDpy//IEbAXCB4LRA/ImpKOt7
         qcj17s40QD3dj6dO7eLjg+Fi/8pILrHAq9gIiT3v18HKKnmsVYS2IfjCblE1qFjDAnxJ
         JZ/sx6Stw7a8Zu1krsRqH6HARp6yKl0V8swBID27GO4Om3RhmdbATFNbV8obgkc8Yigk
         eMeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786572817; x=1787177617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2diJELU9B/EJYj35M681THFCJwWyYCFNlAAsuJpsCA=;
        b=L/9mm1CPbIdg9Qw7XP9oilnJsDnMJMBwrE+hchPA7UoXCFAg8LDjYqNnw8d1czCwqe
         U/FAs7gTaieY3w0Sgpk7GZ15VWODjeOQR8UXmXUNbDIGwyfiWD6cJlUQ+KUYHwgq8QJa
         taTPO4Kew46OnyqbQyOXvVu4TlDohVnp1+ri6P55Ccu0J8fSWkidBU1MvxGrae+0v7K/
         jMMUxgUEVCJ19Diw1levlv8jEZI4vTq/oTdb0OGP7G4FbNsIw24H5xUpPWCDpAhuh3dx
         67syzg8MXi4C6E4vHJ4BeqZmy4A3eaNyhkIZCmrwParQjn2GJfAtTSz+3YolQ1bMByV9
         564Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786572817; x=1787177617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2diJELU9B/EJYj35M681THFCJwWyYCFNlAAsuJpsCA=;
        b=iHCpFw3xgXygz/M0J9TP6K0RTebenkECXNo0V7ZhjgNHS+GAufcX/1BseNfOC4+xLk
         QQ1sAhk04fmKyHZM4Q1yXKZQijGPGHtJcfjUNw1JHH935Za/wBxHT615xT9eaOYpsXTc
         h3qS2mWdfp5wW18IG/tzjvZ9/yDzHTYglt97F/hu1LkB46kT2TY91ZHmhbFm/mugI+cG
         LyrAZN77KmmLoqMgiOhdxMBcWkA68nx4FREo46hcSvfVDxUV62lbq6BegGns9R32ptfY
         EBvT+kE53LCnsTGvbv4Uc+IjTKpDDE4GUp7YVNOdVXo09uRrTjxC0DziZi/kaSgfy3xi
         zAZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1fVinA+AorJUlh4Tea2sYj0MkNh4qVA1Hj0UyvINd2d/fAtW7IaTSYzPuxneodsA960E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFviPKCJaWreMwQDZ5OhvTNUMT3ecOI3GYiuMBjwCMepYdU2Y
	h1XaLRSbc0Ti+m9bpBx6L/SHG6D/ajxLp+roKc77oXZ/GbIEdi1Uf5QLQuqiSrEwUFF7K71/U3U
	s4lCFP8IobLNyNvnEKwY2mZYBC4gwP/GrfTm5QZYL
X-Gm-Gg: AR+sD12cdodvHE8peZuc+lOfVgtMZGITgakIjY+l/aK7lVC9C8ExuCakz0M8p0GjGjo
	JqSDVSAL88lHyhVUbyWZKRLT48KNg/Bcv5GdjdkAAEEeuyxOa8vf/LmUk4jMBDSTlaYvO49Kg/B
	N6V06Viu+ydBgbHPVcBXaGcXQeQPYmzVt9odeM0IwAm6YnjGGRqGd1MDPer0/dAWWfOJKpVnwg/
	jGkjVmZwB8dkhV3JB4FzlurQ+xy8C5wPbb5pb2mMgLJ0O8b9NjuEVuk1l8ZWBoqykbTt8g99RL4
	HkEz1zpiNcgK1jSkOXqNErhwoS9C2ux7pf1ODPuRpJ9N9tP0nP5RcQY=
X-Received: by 2002:a17:90b:4e8e:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-3931dfd0888mr1664002a91.3.1786572816160; Wed, 12 Aug 2026
 15:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com> <6-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
 <anzvkibgzTae9eV9@google.com>
In-Reply-To: <anzvkibgzTae9eV9@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 12 Aug 2026 15:13:09 -0700
X-Gm-Features: AUfX_mwo8Ob8itM9mFOrvjUREAOlXg8MDm_8-_pKnvDnHzhEXLZf3Bq4dnwstOw
Message-ID: <CALzav=dptFQTKyUAiDVsv4LF79pkhfHaVyaYE8FD4-5rrWHGZg@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] vfio: selftests: Allow drivers to specify
 required region size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 3:11=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-08-12 11:59 AM, Jason Gunthorpe wrote:
> > Add a region_size field to struct vfio_pci_driver_ops so drivers can
> > declare how much DMA-mapped region they need. The mlx5 driver will need
> > ~18MB for firmware pages. Existing drivers pass in the sizeof their sta=
te
> > struct. Since drivers all use only their declared state we can use the
> > value directly and remove the SZ_2M hard coding.
> >
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>
> ...
>
> > diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/=
testing/selftests/vfio/lib/iova_allocator.c
> > index 4a660f636f4972..c8075575e9131d 100644
> > --- a/tools/testing/selftests/vfio/lib/iova_allocator.c
> > +++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
> > @@ -13,8 +13,10 @@
> >
> >  #include <linux/iommufd.h>
> >  #include <linux/limits.h>
> > +#include <linux/log2.h>
> >  #include <linux/mman.h>
> >  #include <linux/overflow.h>
> > +#include <linux/sizes.h>
> >  #include <linux/types.h>
> >  #include <linux/vfio.h>
> >
> > @@ -50,7 +52,8 @@ void iova_allocator_cleanup(struct iova_allocator *al=
locator)
> >  iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t s=
ize)
> >  {
> >       VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> > -     VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power=
-of-2\n");
> > +     /* Adjust the size to the allocator requirements */
> > +     size =3D max_t(u64, roundup_pow_of_two(size), getpagesize());
>
> ...
>
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools=
/testing/selftests/vfio/lib/vfio_pci_driver.c
> > index 5e65434d2318b2..52b9c2a2bbb9b6 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> > @@ -32,6 +32,9 @@ void vfio_pci_driver_probe(struct vfio_pci_device *de=
vice)
> >                       continue;
> >
> >               device->driver.ops =3D ops;
> > +
> > +             VFIO_ASSERT_NE(ops->region_size, 0);
> > +             device->driver.region.size =3D ops->region_size;
>
> I'm seeing failures with the IGB driver with this series. I think it's
> coming from here. The region size needs to be page-aligned so that the
> IOMMU map/unmap calls can work?
>
> The size of struct igb is 0x20080 bytes which is not page-aligned. The
> size of struct mlx5st_device is 0x200D000, which is page-aligned, so
> that's probably why your Claude did not notice.
>
> # #  RUN           vfio_pci_driver_test.iommufd.send_msi ...
> # /usr/local/google/home/dmatlack/kernel/trees/review/tools/testing/selft=
ests/vfio/lib/include/libvfio/iommu.h:42:
> # Assertion Failure
> #
> #   Expression: __iommu_map(iommu, region) =3D=3D 0
> #   Observed: 0xffffffffffffffea =3D=3D 0
> #   [errno: 22 - Invalid argument]
> #
> # # send_msi: Test failed
> # #          FAIL  vfio_pci_driver_test.iommufd.send_msi
> # not ok 33 vfio_pci_driver_test.iommufd.send_msi
>
> Applying this on top fixes things and also avoids a potential overflow
> when doing the roundup_pow_of_two() in the allocator.
>
> diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/te=
sting/selftests/vfio/lib/iova_allocator.c
> index c8075575e913..66a160d4ff9d 100644
> --- a/tools/testing/selftests/vfio/lib/iova_allocator.c
> +++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
> @@ -52,8 +52,11 @@ void iova_allocator_cleanup(struct iova_allocator *all=
ocator)
>  iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t siz=
e)
>  {
>         VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> -       /* Adjust the size to the allocator requirements */
> -       size =3D max_t(u64, roundup_pow_of_two(size), getpagesize());
> +       VFIO_ASSERT_LT(size, rounddown_pow_of_two(SIZE_MAX),

Oops, that should be VFIO_ASSERT_LE().

> +                      "Invalid size arg, too large (%lu)\n", size);
> +
> +       size =3D roundup_pow_of_two(size);
>
>         for (;;) {
>                 struct iommu_iova_range *range;
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/t=
esting/selftests/vfio/lib/vfio_pci_driver.c
> index 96a940ea59b5..b31abfe2c7ff 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> @@ -36,7 +36,8 @@ void vfio_pci_driver_probe(struct vfio_pci_device *devi=
ce)
>                 device->driver.ops =3D ops;
>
>                 VFIO_ASSERT_NE(ops->region_size, 0);
> -               device->driver.region.size =3D ops->region_size;
> +               device->driver.region.size =3D
> +                       round_up(ops->region_size, getpagesize());
>         }
>  }
