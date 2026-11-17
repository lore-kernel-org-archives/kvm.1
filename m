Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938383;
	b=Z+OeS6Eik3XRbxlbW+MpXBdymsrMc1oyd8aJleY2olyVjba6PurE1O4a3ri9qVrJQLKr
	 ZuONXbzXLJ2tWfIx5LVw2KjqSQfOuP8PKyM32Y2k1KHuvq05epf03nlCQDK658cDiut9k
	 m8Fn5x8iXizlkvF4MpQDCgMSWx+VKpJ3B6HfZA9N5W8KRGZHWYYIQVdfaglc/MONbG8E+
	 sgJcm0G/Ly2LmOj5Nz1Pvorz3o15sNT2btWjeBe821aRjPFm/srdpPIHwpK3pR/Rphive
	 2OHNwXabjDxJI7vSk/j2LSu74VjYVDvvAmeR55uWVw29r2gmSBgdNsmimu716wAiPgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938383;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
	b=xMj81bsRN1Qq3PAsr1fyC1jf9DdI5f4plzD2qh3MXtTrIPPc5g3bznVB9U71Qky+uH9M
	 5pmZ56CNWPZatfX6z0tWSaqaAzG+jGzbZrldLv5VH3Z3/exUBvERIak6t6ZRNGuD+qtzd
	 boK79dzIi8WAJLs7o9hBymDXE9IKwSz1uUFAvYYHJnqeuj1q+oltzCCM6vxmzYywDAFy0
	 uiWXB9TL0KKm8DUy4d6kHv5a2r6rP9LlLsgDpv4+fGOcrpzvIW1GCxA8yyDIMvcMo9BtR
	 VhlT8sY3tWt9aDKUT6Kjt8D70SaAbx7AyGtIEP+XyDGarhgXL5Peqy64bGJWu1v9fow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IF26q7PO;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DRVjlmXT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98E606A32A
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 17:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C98E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IF26q7PO;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=DRVjlmXT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794938381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
	b=IF26q7POpYKm5uiHrwb5bfX7pW/PqftymPpJ4gEJJlnqnMC4ZEmhneXMjIkigcrBwZFYdZ
	17heg/ywjqnh2nQGSbfGg1W0cohM9yOQ+siD7J30HQkc1tHnyMAvIKIEleq3j74aECQau9
	o3TgBCxUqIYxBgTT5OLUlWpTbuuYtDg=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-18y_1guyOhKReV-mpWXSkw-1; Tue, 17 Nov 2026 12:59:37 -0500
X-MC-Unique: 18y_1guyOhKReV-mpWXSkw-1
X-Mimecast-MFC-AGG-ID: 18y_1guyOhKReV-mpWXSkw_1794938376
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67dbb53a803so4158174d50.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 09:59:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794938376; cv=none;
        d=google.com; s=arc-20260327;
        b=HR3RNyvR2cHKF9DIFfT6E30h2bKhv1PQmRtYaYiAnosbIeMZWd2Tcf9Y0OpU4KZhYw
         VBee0pXHjNCbOwnokqT17KzDQlVpkLfmstpW1bZa2WZ7NrD2Wudg896iMpwthDcESs9e
         PI8p8rIQFKZfCS+yntiMc9VmAF6gj6vdiq06q4pbEzWUxLy4jbAXe3yyuOuLMDbglQK8
         m7mu9IjzXVOsTh8qmstSMy1AfFjT+XpxrrkeGYAnzyoDBhLgpaN1yaANlb8VIFzfg5Qg
         odtwhHjyx61IzQTh8CvRXWh1GNPFCF22I6M8Z4hWip5OGESDgVZdbgjeH9WHJ6BHwrYz
         C3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
        fh=c4MhS+e7Nz7GBnXgnPp65alANl/weVsT4MAGazDDHRI=;
        b=PTrLnR0Trb7SWKy1Ja3PAEZgtRFrSReIV8PvYzq3DkJshr3ipQTLNIkfK32BhwZiJv
         KoMQt3yxghmpP5Siecq7h5BR/fIEchJyanwq7tfWo36HVHHE8Z9EFk2iSMW2MsxvLfH5
         7Esovl7rf0K3Lazj3cHZBO8DoQMwqGV6864cEGXeyBnh8zZB719dFQvq4CN+y62Th5rl
         mBlQpYss6z8wPa/X9padxGQSnu7IFWfbjPNifongqOA/ET8KHPTLRsMnGxXGNG8e51Zz
         eb5rBrw4LkX9fPzByVRzyBVH9maDlCHBGliziuFRxT/Qje1FMqOouQfjmnRKEhBgpGpF
         XIdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794938376; x=1795543176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
        b=DRVjlmXT4UCuNPY1mfvl+kRXqlRbmjk3OJleba53n22JuBnEvmqk8wVI9HCOP1sCAP
         hptSyXPpIQe8so2YKUFrWAkuAmYR8ofCCo1EceLD4kxjsNHhrtRBe6asOElRTE44oiyU
         0OOF6DP4ygGvNkn0ph+cTcg1AIKoZE7g6fW/3VrRcX0yQUHBTGZin+BiyKVmyYJPpRDW
         if0rd7cShtZliOsdlWoG25r0UEKSLMMZBIGSzI4Kq8qov6W0Ne4gwSkgMq4Av/qHzT8E
         BCebntqP4sYyphZtK1cRQxF7I6AF1MWJtSPIj7gNl/VzL2DZeiDMF7Ntgs1wMYmwSy2G
         wJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794938376; x=1795543176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vl1CxJaY+02I5u3HjSWg7CDXN1GxJ7x1NMxc1BTQwm0=;
        b=2FR0l/Mjf3ZbeNf96BIrQiU6TuIHr1kwMDoGuQNVIpLMt2LG91n58A2uzkoyO23+bv
         aUDe/ps6DWQNefg9IN5oSZfU0I+9z2wEE3XL9zlPnqqb/5TmcZm9HB0P5AqyaPJDJWmi
         UtGmI4/xktboLfqMz2WkAtocCqZ1xeWotM6wRPPIdK5zboqUMskQGSt00q4xNIKVu7MZ
         xxoDQmtBaBzyU/lVOypyLKu7Y8aVicIR4Jjm3yyb8SS3NoUg07+V/eLP4vRgG+hsOyNm
         MCwl5/UZiOmYVyC8oIx8LPeLDxSn2XchCM0Z+hlXZEksRluHqQlX/MCAnoAoRAKRzea6
         0KCA==
X-Forwarded-Encrypted: i=1; AL+hErG4u+ugUqsK/8W/oJkgAqIe8wD4YecsPH3/AB5OUh6kiv8Q4zYHizomy1ySQ/kx4LujVes=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qDKdLC1Hj2ayOLW0w813Z1dRuacX/G82gtuI3AbMc120hSftH
	/OyImPWnHsAydpoxYEZ/TmaZ2RUofLaw7K6BYPtv66AVOuXd8Tw8vCXw9AJ9Ah9LHiTdbbOE/00
	pPgE3DO2zQebMxREmuEkHUdnzHpgQRaWF8Og8bfvtidpb2qAsa67WD3FdEV2pyMnLtv+f73UTl8
	Gtu117jhGvxGqhLykdjnv53pa2WeKY
X-Gm-Gg: AZFdTZc44+QQmnhLn7evOfRywcFMbTX0eyJ0QGJ1L7GxzGqgitMy5X6oiVzKP1Ha1Vu
	mF1zcxfI1z7ENMmKZik6C8e4uX66GPOcNqPf5MF16ePI314vbUxIIh+s4OFLu3j7ni8T7qC/yTO
	gNpT05owKfCjiohcjYXKYAPr+zlx2gRwwP8b0zowRgm+t+b5utydthrzZxwXjOueYILBM/NUJrQ
	IoocFCbrTfbSf8H
X-Received: by 2002:a05:690e:4182:b0:67c:1ebe:3844 with SMTP id 956f58d0204a3-67dd3cf9c28mr211991d50.2.1794938376329;
        Tue, 17 Nov 2026 09:59:36 -0800 (PST)
X-Received: by 2002:a05:690e:4182:b0:67c:1ebe:3844 with SMTP id
 956f58d0204a3-67dd3cf9c28mr211982d50.2.1794938375902; Tue, 17 Nov 2026
 09:59:35 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116165002.30939-1-jsnow@redhat.com> <20261116165002.30939-2-jsnow@redhat.com>
 <avxZFbMNjEmnY2yK@redhat.com>
In-Reply-To: <avxZFbMNjEmnY2yK@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Nov 2026 12:59:23 -0500
X-Gm-Features: AclHuK_DtNwb7PXUej_MF5pzE6TrIDPiVJKRVs4ZeA6ganrEwOTaTfhsBtGAuDk
Message-ID: <CAFn=p-Z+LoTqzLAirksuHjt8fghkjWOyvMZ=YJdUFQftHdiA3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] debug/mem: add utility to name anonymous memory mappings
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	kvm@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair.francis@wdc.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Stefan Weil <sw@weilnetz.de>, 
	Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
	David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Marcelo Tosatti <mtosatti@redhat.com>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 8:39=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Nov 16, 2026 at 11:49:56AM -0500, John Snow wrote:
> > Add support to name mmap'd memory regions using
> > PR_SET_VMA_ANON_NAME. On unsupported platforms, these QEMU utility
> > functions are no-ops.
> >
> > This is useful primarily for debugging and profiling QEMU; being able
> > to see and correlate each VMA segment with a specific use within QEMU.
> >
> > Support for PR_SET_VMA_ANON_NAME was added in Linux 5.17, and requires
> > CONFIG_ANON_VMA_NAME=3Dy to be set in the kernel configuration. Fedora
> > (and RHEL) do not enable this feature by default. See also
> > https://man7.org/linux/man-pages/man2/pr_set_vma.2const.html
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  include/qemu/mmap-vma.h | 18 +++++++++++
> >  util/mmap-vma.c         | 71 +++++++++++++++++++++++++++++++++++++++++
> >  util/meson.build        |  1 +
> >  3 files changed, 90 insertions(+)
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
> > index 00000000000..7a50965d496
> > --- /dev/null
> > +++ b/util/mmap-vma.c
> > @@ -0,0 +1,71 @@
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
>
> As the comment says above, we can't assume the kernel will have
> the feature enabled.
>
> It is harmless if we try to set the VMA name and it fails
> though. We merely loose a bit of debug info. Thus I'd
> suggest we make the function return type 'void', so that
> it is clear that we do NOT expect callers to check for
> errors.

You're probably right, I think I was holding out for the possibility
of callers being able to check if they got the memory region
boundaries correct (in the case of naming ptmalloc buffers), but....
with the amount of extra work it'd take to make a robust system for
identifying actual mmap regions possible, it'd be just as easy to add
a simple int retcode back in, so... void for now it is, sure.

--js

>
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
> > +    int rc;
> > +    va_list args;
> > +
> > +    va_start(args, fmt);
> > +    rc =3D qemu_vname_vma(ptr, sz, fmt, args);
> > +    va_end(args);
> > +
> > +    return rc;
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
> > 2.56.1
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

