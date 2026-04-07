Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7F30EF7C
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775601989; cv=pass; b=OkIo6+AFSvlePKh1DVkbipxXl7E7KCwlPO0uBuO80p//bk4UYU9mJLqVtRVIKHTvI7JvUIQxHqXp0nxvkHkhXDZ2wStYb0Hq9R2QdN1dQSBkk+fnwFDItchBRZ4S6dNz4zWBx2YzU8fso6AaSC48EptsWyj75ZpHjhkMXZ+KhNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775601989; c=relaxed/simple;
	bh=f3DVo0ZXZA06UkDRfENVdLuwU3uVfDRBKslnEbdqT1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIhETlawdimnDqZjse/SYl8LQzTfzwYjIkpxNbJomAVOXQkx+7R1wjWKwClF2tjdKSVB/zBI3Rp7XUWxaBapXgtJrqzd2Cb7bhfxE3HuX0CrleTj881YT9Usd4DJjrjkO4haPlZ2BlPHSradCqGBlMk6/3Zw8XAmSXOVmzSotJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9Nwn6wP; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9Nwn6wP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d864c23bdso123801cf.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 15:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775601987; cv=none;
        d=google.com; s=arc-20240605;
        b=K6Adj8+55fPD5dih0pZCI61jngQfQ/kKdAJwFeXCj7w/rgyeyscSihJjAac3AewXHT
         5JYqMzyRNANe2HF+Btf9AveFWsinxwW9R0G3WItibhZ9I/oKj/oERO5kiaGJwQKOdvLV
         YNGbpLc2VT4a9M596Or+FYPrQArMaXmKJ3cdzN+9LAruYrwOHgh6pNKPd57hKuacG1HQ
         nNH+zRxCQlEvsbeLuRoo8qL51VOuu0OWs5m7FB3kKBkO/CGBXo6f/rf/fe4xtUhLE3um
         kFMll7W4n3K5v0P7UOprYq2mKp937CV1OkgyXp0PHaPlu4YQQ158iEULJDYlNvMqDhei
         h+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Iz8LE1UTh/b7QSOxn5c6slKUQmiooem4WNvWDC7eLE=;
        fh=/QdHbnLb6j8vclbQdfv1m0mSSe7DV7bMEIIt9obxYeg=;
        b=M5BwhaEnXW+71t/ZSPglhcyENp7lRL735GWjg7vY8MccrI3KzAp0H8pctfVLFoFyQ6
         1AFP4Ac41ytaHNm4z1TXgioPH7XWXpOOUyoGElwkfCBi9OCqtMXjf9+iYsGj++Tlpqhu
         ZIU+AbL5GFmEqqh3eNY6R6bHr7kO18a57Znzj4/DXlag99cCkcifuhleCDiLfP6hEcCa
         6ZLSPgGQH5oeV0bTUggIypYWIAuAIFZUjCiK1Lb3bG1hbGXvF9EaaFbSsVoUogboxEQl
         p1kEgL41s2TrVr2H77zCrpbgheZAiTejeGOl4pPc5+QDVcTg71UCt4r8cf8XvdBIMKrc
         4U1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775601987; x=1776206787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Iz8LE1UTh/b7QSOxn5c6slKUQmiooem4WNvWDC7eLE=;
        b=i9Nwn6wPWvIXtkNO/Zt0+8TryDYUaI042rc4ctrIvd/twhyojzpFC7sDpqlLoeNWbq
         aHkK2RbfNibj8jLN4Z3NoAKKof1sOBi8Z9eocoJJXswpeNOUolwPJ0Z7vX/uj+rm9mLm
         9sOReCm+K9Nffyg1+Na32gVzVWwZrFCiWLg6eC+EURSKdREljI56FyGCpiH/a05cz3kl
         Ra6pBrc8nSYmyWNWVmlh0j85dBlnEg/6XC8GpXGc0+AXoRtEQaKC12JbCgGNjHT2Pi6y
         kd8oZXUujNhxDVN6B+AOjIkQqu2IsufJ/2g3HS+HmViyjI11GOwSDpvXluiVs+QbJPtt
         rpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775601987; x=1776206787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Iz8LE1UTh/b7QSOxn5c6slKUQmiooem4WNvWDC7eLE=;
        b=seI+2cu5MFZuozoF0FHnQELcSDzwXcWxsQ7xXe1Vxfi8VUvkuyj3hDnnwAH4QjEY2P
         ykJGVkIvJXLSofV2SN3icgNjgeZ7rTFDeQRyC3RDATgnwIF5dHFsKAdcC+AJBJQtKlnd
         djC+C9eeEBx8oeRdpkoCzC9JfWLbd2LnNjEUxgK09T1VEvzILexaTmwtrvU/lPaQDWPC
         AAyUHv1KtTBh4GYHMPyrkPkhJbXcU9XbT8gyVJHaBWb9dMB1aDwfMm1Z9TuTXe5NT2Dp
         tv4noaIkC/6Jtr7xpNUNyrWOOIUq7tKhCw+u1LVuC4P9oBaQAbSPmgqUo4KEJbvCsJ+O
         JcxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxdPom+RaE090ceuJAvhbZYmzu/tsaLWpAzBOuNHsiwMlFnC3W0VRdQ7ZiFQ1b4fD1Upg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXvFoAM9WCpnpOjQN1vLcBZOS3G1XbnSUOuH+VvmNW3yfDT4/
	yejfn3K/09cBZ4NraEr843K12GkhlQkKyF859LHsX5zrVSyzHushlu/oo3XME3zYvbHmm5Zk9eU
	lHs3VCpzbprX1WgEXCfsCaT/+gj9dafJSA7lZZvPq
X-Gm-Gg: AeBDievFM8aAt9oIYV4vjwnC5m8mR/OPoMPwiihXyNBsp1FoWfJi/pGCvb4EIbOnRgt
	Csgz1afOZdOdMOUfP7I96UgTBC0tcLIyizr155RatGxuQ1AcahtKKtF0h0IXC6+GyZWxNiNAooG
	vzA2jdujlDB+KIBDlhCrUrts6qIZl/plZfrsbe5XlQO6Ne3utmspt+Leqzxw66ENRPjtUyhi5LU
	5cxetHG863blwoZIscXfwywJXE3t+z5sqC2OfMpbfycYYmnt0QY+oSvuvfmVhJNLLMkfi26kcYh
	qJXd2LfS
X-Received: by 2002:ac8:6907:0:b0:50d:440e:2e5f with SMTP id
 d75a77b69052e-50db3f5196cmr1731601cf.13.1775601986467; Tue, 07 Apr 2026
 15:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com> <20260402173059.1018805-4-rananta@google.com>
 <20260406151234.7bbca348@shazbot.org>
In-Reply-To: <20260406151234.7bbca348@shazbot.org>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 7 Apr 2026 15:46:15 -0700
X-Gm-Features: AQROBzCsEKktHNyaa3IrcPgIhUcWkHbTPn-1Qfq71xz8mXiPhEKuLJIJ7gbJ46o
Message-ID: <CAJHc60wPckr0rhx2OpBdPizZNbG9hjuQ9j0QNR4YMJK12QWPvw@mail.gmail.com>
Subject: Re: [PATCH v7 3/8] vfio: selftests: Introduce a sysfs lib
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 2:12=E2=80=AFPM Alex Williamson <alex@shazbot.org> w=
rote:
>
> On Thu,  2 Apr 2026 17:30:54 +0000
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> > diff --git a/tools/testing/selftests/vfio/lib/sysfs.c b/tools/testing/s=
elftests/vfio/lib/sysfs.c
> > new file mode 100644
> > index 0000000000000..f1e6889556527
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/lib/sysfs.c
> > @@ -0,0 +1,150 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <linux/limits.h>
> > +
> > +#include <libvfio.h>
> > +
> > +/* Enough to hold MODULE_NAME_LEN */
> > +#define DRIVER_NAME_SZ 64
> > +
> > +#define readlink_safe(_path, _buf) ({                                \
> > +     int __ret =3D readlink(_path, _buf, sizeof(_buf) - 1);    \
> > +     if (__ret !=3D -1)                                        \
> > +             _buf[__ret] =3D 0;                                \
> > +     __ret;                                                  \
> > +})
>
> Not a current issue, but the use of sizeof() here is a danger for
> future users that might pass something other than a stack array.  We
> could avoid this by adding a build time test (untested):
>
>     _Static_assert(!__builtin_types_compatible_p(                       \
>                        __typeof__(_buf), char *),                       \
>                    "readlink_safe: _buf must be an array, not a pointer")=
; \
>
> Maybe overkill for an internal helper, but we could avoid the hazard.
>
Good point! It makes sense to have a build-time check for this. I will
incorporate the _Static_assert to avoid the hazard.

> ...
> > +char *sysfs_driver_get(const char *bdf)
> > +{
> > +     char driver_path[PATH_MAX];
> > +     char path[PATH_MAX];
> > +     char *out_driver;
> > +     int ret;
> > +
> > +     out_driver =3D calloc(DRIVER_NAME_SZ, sizeof(char));
> > +     VFIO_ASSERT_NOT_NULL(out_driver);
> > +
> > +     snprintf_assert(path, PATH_MAX, "/sys/bus/pci/devices/%s/driver",=
 bdf);
> > +     ret =3D readlink_safe(path, driver_path);
> > +     if (ret =3D=3D -1) {
> > +             free(out_driver);
> > +
> > +             if (errno =3D=3D ENOENT)
> > +                     return NULL;
> > +
> > +             VFIO_FAIL("Failed to read %s\n", path);
> > +     }
> > +
> > +     strncpy(out_driver, basename(driver_path), DRIVER_NAME_SZ - 1);
>
> Nit, I'm not really sure what DRIVER_NAME_SZ buys us other than an
> artificial limit.  We're already bound by PATH_MAX and could just do a
> strdup() for the return.  Neither are blockers.  Thanks,
>
Ah, why didn't I think of strdup(). It's a better approach. I'll
update this in v8.

Thank you.
Raghavendra
