Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323139;
	b=QFi7+E1xjjuMr7gLIuHZVt81nTeDCpQrdX8oLGYH4HX8ZGOBjimIfKV9m/B4vA0GxjPb
	 i74y50o1OJz4VauzQ36wXTwkGN2wvmfI1N64+vqNIRzGxTwK3u8W1gO4/SoThmLI9YaZ+
	 mTPJdGt+mQZtUQlGjfTM4mteprfqq8OC/U7ae6qK5T39kh7UGj11kBUOAA8QhDMVOv8x1
	 JvBO4LQRFgRiRUYUlGyIaeJ0b0sdQU1lce1ENss1W/IU/76nCXipStEhxL1svShIryhcX
	 dNnWkjLhfAHsFiQLHXGCLmM91/2W7QIO0Xbu2GqJ/G+z9ysQjrLPcernhYjS+l2Lmuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323139;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
	b=5gQTKhwt3UjysXdSZ+hK439ftbrdq+8pht/jJ5dL+ZQwYPeERtf+NHEfVRntYVd8WF4X
	 Oq7ctKb0CHwjg3TtU1oivpHQwS4vw9FrssX9j0CE6HSLuEbWlRxoK6VX2K4HEPl0r1DBx
	 5IHy1y+0b0T5L24f/oitP6gI7LZgkxRRvKamACk4+5A9L3tuEn0ehoZ0ehrYd9+ESM668
	 rmz9TleOFsNrDAn0aPCNdi7KjpMP3mZrQfYx+oggtYk2NQ0TbQTmYmtHmwptqvy9rFJD1
	 HAsI3Hhs3QgwKl5DkhZ7LhCTi4FoEbhATLBgvl7lPFojITk13sgdw0/6ubkk6mnfSZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1TN2dJY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NVHEAzKb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A7606A31C
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 15:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 538A7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1TN2dJY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NVHEAzKb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794323137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
	b=a1TN2dJYjxxYZ7iuRRHE8dbahSGPAzNPy0bRBarANkdw2dJwqgrM3N8DBaB7H+O6zneOmw
	cViXtjC8b5C9BeMyR7p+BIxemkgAM3jNIrCbyF4hdPoLLXYQjn76biIP3+toXWzaH1fm4r
	nXMO1QY+cPxL5e6yUNtzBhdsjOgfJ7Q=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-WG_bnHlpOwigVDnbdBHo5Q-1; Tue, 10 Nov 2026 10:05:00 -0500
X-MC-Unique: WG_bnHlpOwigVDnbdBHo5Q-1
X-Mimecast-MFC-AGG-ID: WG_bnHlpOwigVDnbdBHo5Q_1794323093
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67c2852e5e9so2457195d50.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 07:04:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794323085; cv=none;
        d=google.com; s=arc-20260327;
        b=EiBVvJUbIELuAgX01yyCOkvt+Oa25jqX6upHn2IUHKS4pLD3SHjRL1D9nD4eZysgPB
         0NKJAWIIWu2Nmve55FefZNMiftJqJB47XO/v556nbCaC5hT2z5LsKNb51AwSApGaWMRd
         aGtG8lQVQMmvuhf3MO2WDlmRO1LhlY0Jvx5RZ6/2/Uj/XuZ/a4DalmU9QXYTaU/1aRMk
         raaEQftJp72Cu4BM7Rt0dpYAT0RgjE/x/HXGH0Uv51Pd1pxUTeTHZraVqpTw7kQDYuJP
         rw5kjthPthgKXwdtaLcv7y0ZpVCOiL5VFYLmihZR0ELwrn+B/0s6Z/YbAaMfM0pXzmYR
         p7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
        fh=kq7fGH3MWb2hKv/8kwB9OQp47PKzaJPLOe71ZzQzm5g=;
        b=eFvVUrGUIn5ShafuDJkKaQABsEmN/0FjK+HP67T+7rN3VgdxY8Li7KahY4Jd5ZaH6v
         dGspBxQDHkct3WNErOcqTLJ3ro+fM2g686krBvmK22YegViZeik+7uwifTm4ZYaXmnU0
         yDuMiSvy0I7nnHAJfuVi/c3I5ghvUqh9RLHZUIDbFccFY1tuZnBJX+7sGfokjRsUKMRA
         feVI7OA3EpkkWYiS3apofUweKLarULpLRFMZV684ym5WUBDM+A+Z6k++Xkxt72mPMLsN
         HIUGzEzKuyrwx4tL+pHTmoT4jXrBF1x0sAgVsY1VC4jCgSUSEkHs+pDe5sEcm17OI5dv
         TzXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794323085; x=1794927885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
        b=NVHEAzKb9tlxqral2NIAUZFI4gQlzOaC+lwnm/KdzVV0cazWG8fnfc+f0koB86Pkus
         MWDk5xVSPqXHQx8/GL2x+g2Qc6g8gCVPGe7ZyouYOA1yjwYectCtRSY8++LrInznfPnn
         upMb3YL/F6f1WR5HAqC36LBH8Fa0huy9yuyrWmKGLPdOwGPGx7+3ldPbDFDirzyVBHjl
         vaA4q93u9c3BNp8ytWTOlmm28lyt642AsHHxjGSLRIKekHjrNnWYFDknnrcQAVK+DpQb
         zy93ZphrQfGxlRQ+8XgoEx/cX3WhEuu9v40eFVotLTBUBvCwipLsYQg2RizkMs6GbE0A
         SzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323085; x=1794927885;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C3dTQBmQ7Ro/FRBuP6MEDULAZwn/rEe5iVobQPAYtrQ=;
        b=dlXf25pjg8OABnM5w8p7r0NNUC0gB7IiI3Q60U6aCAQJPpeqrsgQTB7eFPPEMH2Nv7
         Hpcux/7oOMp6ITqnkyhkcubg8nz9uvMDXoenejMwgPPhByrTs/mtEfJ/1rnwBTnM7mOC
         8DXQmJ1SenFod2r9cDPp4LeFx4FyG6CH/4jqaUbHs3FRtpgaXxZqpXRU6gU6buziRQQh
         9bZd036n2DjLJ1ubmuuwFIDzq2/+0ryc3DzpPhXb/jChVHBKarvZpa7Gm2ag+HS+q3zH
         n3IKpTJSbNTGZYZGuMsaad9y2+AHKUrllppJ49hfjYvTPqE+lRFdGmQz7izZbwdG6qnb
         7U0w==
X-Forwarded-Encrypted: i=1; AL+hErH+rIuD2+NZXpatTRo8wU4RQLVDz4BlaC3PlZooAeb+YH4D+5UiBJ2kqT5yKDeXgJkJY/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rCHJa6BjdiazCBYaz4ds2RRbhKi65lIAQ1rGvZvI7YxkMugpF
	8U8P9hRipM99GIcClJCqSjvm/SzMTrEMPwN4nx1MAvtW/Jo1LdgIfm0IXcuMUOcyOjE518EXB6Q
	dZf+mui12gRQhxB6DD3BmdwI6iTvVRnIV2zk9U3FGaUZB+9OswxplrGXSwyzu9HHiTDZl9Md1AK
	Vz9lpNMARtJod01EhTwP/xd5DQwZ9O
X-Gm-Gg: AYBFou1Zuf1i7qR0zjsPr4kvXxiHwuRj2zHn5tdoz2+1q71szgaQHCsmUhk5xfhOtlE
	CAunQSXKY1OzIn4QfeGVC3wdtKlM1hEnErEehJ7Xga9z4cat38I/e8ol9pTBVO2yiyw5075KNqK
	YYDPbnvp2Vxpu6A94OcqN4//bHJTqtQU4k8ApOeX3zjlCTAiszALwYTorEIfSijp28yDe6sKJEi
	y1Qw5mp18mn/G/l
X-Received: by 2002:a05:690e:1445:b0:67c:2ae8:dc65 with SMTP id 956f58d0204a3-67c571f47c4mr1777307d50.46.1794323085203;
        Tue, 10 Nov 2026 07:04:45 -0800 (PST)
X-Received: by 2002:a05:690e:1445:b0:67c:2ae8:dc65 with SMTP id
 956f58d0204a3-67c571f47c4mr1777275d50.46.1794323084529; Tue, 10 Nov 2026
 07:04:44 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109185907.3220584-1-jsnow@redhat.com> <20261109185907.3220584-2-jsnow@redhat.com>
 <avIfJqbcTHFAGvqf@redhat.com>
In-Reply-To: <avIfJqbcTHFAGvqf@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 10 Nov 2026 10:04:33 -0500
X-Gm-Features: AclHuK89ddUpEjdZmrDY9p7C0TaBdkuYPC7pwqYL_axC9xBTOSqnLEorhZ8PJuo
Message-ID: <CAFn=p-b4dE9=5NYuvK-4SXaiiCsDHszCiz_HzEtWREcAzdhaRg@mail.gmail.com>
Subject: Re: [PATCH 1/7] debug/mem: add utility to name anonymous memory mappings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Marcelo Tosatti <mtosatti@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, 
	Alistair Francis <alistair.francis@wdc.com>, Stefan Weil <sw@weilnetz.de>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 2:29=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Mon, Nov 09, 2026 at 01:59:01PM -0500, John Snow wrote:
> > Add support to name mmap'd memory regions using
> > PR_SET_VMA_ANON_NAME. On supported platforms, the QEMU utility
> > functions are no-ops.
> >
> > This is useful primarily for debugging and profiling QEMU; beind able
> > to see and correlate each VMA segment with a specific use within QEMU.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  include/qemu/mmap-vma.h | 18 +++++++++++
> >  util/mmap-vma.c         | 67 +++++++++++++++++++++++++++++++++++++++++
> >  util/meson.build        |  1 +
> >  3 files changed, 86 insertions(+)
> >  create mode 100644 include/qemu/mmap-vma.h
> >  create mode 100644 util/mmap-vma.c
> >
> > diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
> > new file mode 100644
> > index 00000000000..763ea5a5cab
> > --- /dev/null
> > +++ b/include/qemu/mmap-vma.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * Utility for naming VMA allocations in linux
> > + *
> > + * Copyright (c) Red Hat, Inc 2026
> > + *
> > + * SPDX-License-Identifier: LGPL-2.1-or-later
> > + */
> > +
> > +#ifndef __QEMU_MMAP_VMA_H
> > +#define __QEMU_MMAP_VMA_H
> > +
> > +#include <stddef.h>
> > +#include "osdep.h"
> > +
> > +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> > +    G_GNUC_PRINTF(3, 4);
> > +
> > +#endif
> > diff --git a/util/mmap-vma.c b/util/mmap-vma.c
> > new file mode 100644
> > index 00000000000..7dcef3b7455
> > --- /dev/null
> > +++ b/util/mmap-vma.c
> > @@ -0,0 +1,67 @@
> > +/*
> > + * Utility for naming VMA allocations in linux
> > + *
> > + * Copyright (c) Red Hat, Inc 2026
> > + *
> > + * SPDX-License-Identifier: LGPL-2.1-or-later
> > + */
> > +#include "qemu/mmap-vma.h"
> > +#include "qemu/osdep.h"
> > +
> > +#include <errno.h>
> > +#include <stddef.h>
> > +#include <stdio.h>
> > +
> > +#if defined(__linux__)
> > +#include <sys/prctl.h>
> > +#endif
> > +
> > +#define VMA_PREFIX " qemu: "
> > +#define VMA_MAXLEN 80
> > +
> > +/*
> > + * Give a human-readable name to a previously mmap'd memory segment.
> > + * This feature is only available on Linux >=3D 5.17, and only when th=
e
> > + * kernel was configured with CONFIG_ANON_VMA_NAME=3Dy.
> > + *
> > + * For systems without this option, prctl() will return -1 and set
> > + * errno to EINVAL, and can be safely ignored.
> > + *
> > + * For systems with this option, these human-readable names will be
> > + * visible in /proc/$pid/[s]maps, pmap output, etc.
> > + */
> > +G_GNUC_PRINTF(3, 0)
> > +static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_li=
st args)
> > +{
> > +    int rc =3D 0;
> > +
> > +#if defined(PR_SET_VMA_ANON_NAME)
> > +    char strbuf[VMA_MAXLEN];
> > +
> > +    assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
> > +    strncpy(strbuf, VMA_PREFIX, sizeof(strbuf));
> > +    rc =3D vsnprintf(strbuf + sizeof(VMA_PREFIX),
> > +                   sizeof(strbuf) - sizeof(VMA_PREFIX), fmt, args);
> > +    if (rc < 0) {
> > +        return -errno;
> > +    } else if (rc >=3D (sizeof(strbuf) - sizeof(VMA_PREFIX))) {
> > +        sprintf(strbuf + sizeof(strbuf) - 4, "...");
> > +    }
> > +
> > +    rc =3D prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
> > +    if (rc) {
> > +        return -errno;
> > +    }
> > +#endif
> > +
> > +    return rc;
> > +}
> > +
> > +G_GNUC_PRINTF(3, 4)
> > +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> > +{
> > +    va_list args;
> > +
> > +    va_start(args, fmt);
> > +    return qemu_vname_vma(ptr, sz, fmt, args);
>
> We need a va_end here too.

Definitely spent too long in the python mines...

Thanks, and thanks for the pre-submission review as well. ... and
thanks for figuring out that the entire feature needed a configuration
variable, and thanks for proposing we enable that variable in our
Fedora debug builds. :)

It's been a *massive* help, even more than "massif" ;)

(Note to international audiences: effusive praise is typical for
Americans, they are just like this. If you should find yourself the
subject of overwhelming praise by an American, do not panic, they are
not likely to propose to you. They may just offer to buy you a drink
should you meet, or perhaps stand a little less than six feet apart
should you happen to be waiting for a bus/train together.)

>
> > +}
> > diff --git a/util/meson.build b/util/meson.build
> > index fa174c07a57..861ee228d5b 100644
> > --- a/util/meson.build
> > +++ b/util/meson.build
> > @@ -1,5 +1,6 @@
> >  util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-comm=
on.c'))
> >  util_ss.add(files('thread-context.c'), numa)
> > +util_ss.add(files('mmap-vma.c'))
> >  if host_os !=3D 'windows'
> >    util_ss.add(files('aio-posix.c'))
> >    util_ss.add(files('fdmon-poll.c'))
> > --
> > 2.56.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

