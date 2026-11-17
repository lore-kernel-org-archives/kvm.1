Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938064;
	b=4Twc2o53AF7AqPh49aLltq2qWZoA1i9k7MPlQpJSvRCLFzQC2Aegs15PIS4HQ/DpD8MY
	 4Ur/rhzoaL6uchLlhSszKe6T2VU3rzdsVNJE3ggKn7LuZ3zZYa5ohSvAY0GD0r/kmbnIu
	 m4gvKNmR4XggbYKFvMugnW2yhHY9DDy+ZOAY3TAV1EG6TVhRE0/jJpR1Pnwou9PEVxQ1+
	 x7rKm0r7vnUCtFWCm/SLWHNeeApU3Z6o+9cbowJ6D94j+F0pPM12q1GkkboqAxGV640rz
	 pw5v5NS8gpstA8iBHr8t1kqIeZ7YotbCmCjUd9HeAekl146JpOanKKFJNk5W4FYT8Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938064;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
	b=0ZiJRI7eo+6U1ryjHGEvzK+qPjeWozJ4nFpaSs+ygwRbmoX3JVBpAQDP2nvQ5KDjlp31
	 UuZD8K0idalAOxQQc0rs/Y2PvJqy5wUZx7RwS5tifI2w2l8Flljai9xJUqDUAraL2CMJt
	 LRN8edy6ksiE07jdJ2fTHe3qIcm3R6YGZBwqF743wKSvQ9LOXlIv0yRYxgIc/QJGgMDGB
	 7rjJKzsE/pdX+QljP0ipRYaxVu3yFMZq1SN9SwqUB/uhj4SzMECgdxkYy4a1RPVGOiPK2
	 BratoHNsekiuiOPCGPs/RRiBtBIW9TBndWLPGOeeiJpTf98KvCB2Q1TqvtXqm9x/8eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AoFabRzQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fI+S5LUU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F127606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 17:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F127606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AoFabRzQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fI+S5LUU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794938062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
	b=AoFabRzQ3ZzAL1OKxoNHUkXizx2khl38oiOiMeepw8odup+MIVHqohF/rAPc7w6Vrcl9Bb
	/OnJ01wtIdJIHLQaV6LoHWeXQEUjW5JIVg0SvncL5Z/B/MD0mpaniM/zPpJ9U3PLNbAW44
	WwtjcIkQiGOf2KsADTzu/CtFt4zsPP8=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-_XCnvJHGNmKKNJeSAqqBag-1; Tue, 17 Nov 2026 12:54:21 -0500
X-MC-Unique: _XCnvJHGNmKKNJeSAqqBag-1
X-Mimecast-MFC-AGG-ID: _XCnvJHGNmKKNJeSAqqBag_1794938061
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67a781c1069so8010279d50.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 09:54:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794938061; cv=none;
        d=google.com; s=arc-20260327;
        b=CqATXUXguMVGcmHDwQAcSDtOnbu7F5kANQmDmuaeHEGPe8IKF9r92WC1imjmQstqYA
         kuANsPBu/6gKszAWldMOJ1CJxRvejdPO7VVC3srtpzqPivfQF1WJAcs6CW64aEUkBp1M
         zbDc05wJ3Z+k2Vaze6Pw0mXToIvzaduJpXAwGMD8GIyaw3g9rBHCj91qg0YlaCPLwrww
         FCZgvMx5K432p9O9OYj8r/kHCOKGs+kVeYsz9mj3l1oTYHzN+QedyBp5QU+Nslc4Orgw
         VY5UNUKvgs6gdlZ16vB7DNZuGS9XbrNCpiFFPDcoDnvyXBRutvtLRaGUzfMDaHWhhBvq
         LvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
        fh=EgQ6HWvtcwr97vMqaio4gHHOPXrXU2cD8ACgESnJYFI=;
        b=GGjn6c4KoXlV7TOATRvCteIFiL32R7H7M3s5aI0cMzhVRQ7QTsQxe2NRO7n0z2EUGp
         sMK+3tXkPIFPWm2iQiSGPpYegLFyfOAqWwTs6+g9qbbWs59QJBCydV8B8C04Wz1L7c5B
         Wz+hbgduNjZ4BmulzTCG8aUQNw2lx+TVltwDHpMzTBzf1GeE0gELz2NIUaCVYJGbR9Lv
         JyOCL7wMn+BMQKj21UDUOVBjNpM3ojDCgtkfY1dvn/GXLtI+5voOVnIbanqk1jah0y71
         ie7o3TNj2AKsq7aH6PdbhtXoRVUCO0aDDvNmAgtqlLZ7oRotAxc6V93oq5+3VK0Behh+
         iNLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794938061; x=1795542861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
        b=fI+S5LUUK5+K+tqkayKq9WrzMUgpkNnqESf1LaPyZFxZAkpTyNJQfVSH9iDQE3xZ4M
         MsI4LSiuahQxEv/k/eyh5dOGQG2ujmQIS2jYrj0wBCJu/kpPoRWuKRR2SaWy2KGR5tbQ
         3oYzRw5VoR3CwssXX9m5IpEp+SthNXkcx//StuVRqOZ8DMRGTnjHjm7EDRzSlhukajdg
         GSwmKVgmAKLJYFA+rWaSIENzriMV0V1yeFKRCv5IiLhlJKLLYOLfGxyus4++pL8OhaZI
         YwOyVgrRdTX7/1b50lgERtGe452SLOZuj0ubnF1wSh1g6g4p0cyoPPL4XUwU5i6fs79/
         bkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794938061; x=1795542861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bcz2C3M0nBV7LPJ6x+8JDDRrADUanvmWqDNeY+7M2RU=;
        b=Kg8y137SUcT7Rqq9VPJTpnivV5VUQvz0b1F9r+jxBOi0mzJpUFhRsKQLNRupjNkHH8
         XfC+j4XxaZ9yZaDRRHeiWQeIt4tL60TKdRmmFIysGYtHqkIM3Vijh283VTG0lMWC+fM3
         3tULx29uNQKeurSe06le0sklARP1tDOMiZttdCE2Hg2qpCIL7pRHQ+cstYdeMZJZvbzS
         h6upx7W1DNLAhIutA1S2UnVYwJ5tVCxEsCn/5lRcJUJj6c+9WvQzy+z7FwLYM361VT1j
         8T5oK5BKxycWBvX+VLsTplWJj2B6WwWQEtNAoRMVJvU8Bfnw2z43Lfa82CTgui+WU5Iv
         9tnw==
X-Forwarded-Encrypted: i=1; AL+hErEh0WP6/6tBSYFp0/6xNLDX2decEsFZQQZdcGfd1A+IlwmzttLqo4HmGqgXr1o4+niNdpI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/53SIBFguo6PaXFR3RHxYAK7XNEecnumxhkTdcuG0QE9aRucoI
	QLxxGqVaqumslHlNHytB+v1QT9z4DC1CfAWbo9WK3psupZ9whybqKAKClPO/gCAXmDeE13D3+tm
	4R/3twvQsufkrmG0RTJ3n4+klF1Lx8ejyNhvxKgAI1/UAvDRSgLzCSvmS9iaoWFgq0Hsr3oIm+6
	xFbfHY/1x2nukGyCK41ypeJhAdvtw2
X-Gm-Gg: AZFdTZd/SstiHNBKbdQeuGpnXK7h9MppwPjRBCASwaT/vi4b/MxfyD01tCbg03WkRw1
	cXFUfYNDP8ivqTdNqQZ7ZdxTScJ+s/YgbupPfzgSsVlGW+yOopvzLHqbIPWH+P1LRK/4UgQfRi3
	rCuDvGIZMS65ZzjQ2hDXxfFl+1Ld9NNEYNCQPWNGDvQ94ndr81nGATe1LpQivZXF4oPKrg11rLG
	IHO9tbTuk24+c+4
X-Received: by 2002:a05:690e:144a:b0:67c:1d44:7897 with SMTP id 956f58d0204a3-67dd3d4f896mr229643d50.12.1794938060602;
        Tue, 17 Nov 2026 09:54:20 -0800 (PST)
X-Received: by 2002:a05:690e:144a:b0:67c:1d44:7897 with SMTP id
 956f58d0204a3-67dd3d4f896mr229622d50.12.1794938060030; Tue, 17 Nov 2026
 09:54:20 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116165002.30939-1-jsnow@redhat.com> <20261116165002.30939-6-jsnow@redhat.com>
 <avxa4ZVUP5GcWi5v@redhat.com>
In-Reply-To: <avxa4ZVUP5GcWi5v@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Nov 2026 12:54:07 -0500
X-Gm-Features: AclHuK9JBg0lxzsrWkkVeYrlg-5ShEC8ITTTmo5RceCDv2_djJuCATVOvfKauC8
Message-ID: <CAFn=p-ZKZ_S_33e_PZ-5tyU=DHczE=cVSCWEvkSZRJsKkbo3PA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] debug/mem: name coroutine stacks
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

On Tue, Nov 17, 2026 at 8:47=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Nov 16, 2026 at 11:50:00AM -0500, John Snow wrote:
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  util/oslib-posix.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> >
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index dc001da66dd..454579c72df 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -60,6 +60,7 @@
> >
> >  #include "qemu/memalign.h"
> >  #include "qemu/mmap-alloc.h"
> > +#include "qemu/mmap-vma.h"
> >
> >  #define MAX_MEM_PREALLOC_THREAD_COUNT 32
> >
> > @@ -742,6 +743,8 @@ void *qemu_alloc_stack(size_t *sz)
> >          abort();
> >      }
> >
> > +    qemu_name_vma(ptr, *sz, "coroutine-stack");
>
> Our coroutines are crying out to be named in the future :-)

I know :)

I looked for five minutes but wasn't exactly sure how to name them. My
understanding is each coroutine stack could theoretically service
different routines, but only one at a time. I am not so clear on our
model that I felt I could confidently give them meaningful names, so I
left it as an exercise to a future reader.

(Naughty, naughty.)

Since we're in freeze and it seems unlikely we'll agree this is rc1
fodder, I'm happy to take some extra time and improve the helpers, but
some pointed suggestions would not go wrong :)

--js

>
> > +
> >      /* Stack grows down -- guard page at the bottom. */
> >      if (mprotect(ptr, pagesz, PROT_NONE) !=3D 0) {
> >          perror("failed to set up stack guard page");
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

