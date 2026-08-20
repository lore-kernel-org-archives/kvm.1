Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32137DE89
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242435; cv=pass; b=VM1/08UroIa4hG4xzW7jdpTSj4PXyMbJpeDzAWEAAjRQIvnjT7pbcLtHsT/jWCHHz1tOgkyIanQeo0hRfvtcAUmOySusIsbfAI5Sw0X/cl/0ugCfC0fdFAnTFJj8t6mYnHEgU23fT80nFuryBslZZy6rpEm9kNDHWUb+Nzmve0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242435; c=relaxed/simple;
	bh=R4MPBvVJo4QUrqfGiyzEHUoLl/o6jIbnVOLSKCY5MYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNgaAygUYrtJSPLL4ZHrwBmPAbiJPFeCE0fsQobVUm1YdJMPSOPIKfGq5jDaffJkM3bjGgYeKIO/jQoBycjawQ5pLHrSbX6ckqdLAojwll2A4D1tB0xu1NouD4+r5j3Ob/LIFRHv1rAngPOk/pzQoF8RvPI2+V++j6mKoa01qPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7LSrBqh; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7LSrBqh"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so2459026e87.2
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 09:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787242432; cv=none;
        d=google.com; s=arc-20260327;
        b=l4JX6EA4l0n2omxuR9wfyEn+fTxBZhQq3R5vL0lmQGm3cW/WjlAgNsEiBs60dIRpRa
         3AwIUpX2PpfqUae9225S9byf1D0x7V6aqNy6he5enLuzecIJI/ij5MvnyH4suFomgh0I
         GNVPNiBmmYuGvBhH5FZuVSW7L0hem22dcbC69BV+N9llnQ1hrHT6ajT46TiTng99YAUU
         oG7RkExtxsBcWkTbEJyCUlCDufzCtjzwJqGqtjK5Qn3d2bllACu2FyG58ly9FG3fIbKh
         q68HHYRxocDdBL1022qUHoBW96M5YWKog5i4dr8KnOIXu/KAi++klwgS1VAD9m0Rpi+t
         lDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ztOfkRWaJIQKbe97d8qKHuDqRSY1ntMmOF6ikBWIndo=;
        fh=1Bgm8q0cgkBUApdZcI0E8xWUeP9Wp9QTAcN/qv+ZSh8=;
        b=OwZIrU+l8BQxbpdInzCim6AW5IGcKyaEN0qpztIinPjpuUrvgXiOB1or0yHo66ZtBz
         qsMC4Z7aD4Qj6FCqOo1wgM1BgDMF7lAi6aCXhL1+GdiiEyfe1cndDtSLB2ghtKDST3Qi
         moYrV9Vkc6/w5Uqk9+zwCAsS7uF8SGmRJt8JfPWfIiJyW/+uoAto9qbkDoOztKEvDHq8
         66x1QRV+RQBgBN2awAKlVWv+TfALDff3ga9Yis6RakpmGLjm9jWbUTUh3OW4Xd2uVeMB
         Ju+kjObEwWzCIgO93+6Iye+kDZZWNGISpnxkanOWbinttEekSWBnMftGlO7eeGHI//eZ
         lp1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787242432; x=1787847232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ztOfkRWaJIQKbe97d8qKHuDqRSY1ntMmOF6ikBWIndo=;
        b=k7LSrBqhGmZpQB3jf1SzAcJQ9lNIYnvntjR/GnOUdCMePaob0RmpMh3YVMxOyyRD6y
         GjmpTO8rj53bKy5hMlzsAoNaOJxdPz/YVGetptmUfXRGvlYJG63WSzJil/pdLwkQQP0S
         xiXDdtZrdgK9QXiubCKHsqmBH7d0j3tbbA+RKXrJyq97gJMDiImq4qTZu9djWDTkCsUp
         HgglrPNVS9CvtMXl7eXvUZRW3vkIbh0LBhlPnro8biQtkDFOmSiiee/oVzWVaFR/XLKY
         PDp8cgJvmdLeeHkBSADc4xIQKtr/NMnI8K9ry/hn4I/nUCX0IEKzrjBSHzGbeAnqaLqo
         YWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787242432; x=1787847232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztOfkRWaJIQKbe97d8qKHuDqRSY1ntMmOF6ikBWIndo=;
        b=ikga/44DPAQfDoqT+5jn8WUsjNpJt09zSwbi8VhJ0aeaMpmnDHAmImeqZbcrHAFTym
         9G2026eUOzgC0ECWSCLehRFyXEq02vQ0/TOvOBZQllGGIPKdsuolqvfqCU/ED39BqkN/
         VH4PKkj2oKTwn9dQs4lRhT69oiZaa8b7/hsv2fWNL1gxN74vDA5mgFEuRKpMRMfrviGw
         IP8MBNLFZbMXraecBlkAD6GJJ/o0aSvhyXor0RLYX+WHUzO9WfpLQppG/dzH4vbfIqc4
         ox6cI6bd9AkDUUeM/HHcX+KBifrFw8wDWg+F0+5QbzPiUVKxgH+3uA+7ERq/M/OcSiIX
         yY9w==
X-Forwarded-Encrypted: i=1; AHgh+Rrs+ZiemewcqWWLdVJwqvQEOEAIAJwEW5s+paqhTxuv7XieOiUDqPMxPtxBvhyKJCO1vCE=@vger.kernel.org
X-Gm-Message-State: AFuF++lGCwdSLSh2bdJuNk56h8EKmuUYxtTfIlNqyIoj3wuhOtcCdJrz
	9Dz+j/idjk1B0fQBqC+T/XqUtqHFD/t9BxtSu+q781gwRvfq/KXrYjkwqtZtYCQX/QgxcgW9zt3
	HB0ninl41b5wK1HAtYY1YyVKAuLeOghuIm1F8cl54
X-Gm-Gg: AR+sD10Gt4QZh4A8ZWubeDBTo9H14ljrz5zxD325xNd/v1+zHIe/hAMcxTslVHhholT
	VEOqNs/vFwK9OjQcIM4WSWJzwWPCHm1jepVW5cXB0IBt4WLYgI4QaS/0C3W/4o3u1zqqy/bpP98
	qdZ35jBpay0s/CMb13DpnQKBxoo8PpcM0tUvPPfpLYpF7/nJtQrRtZzZlEx7xlx+Ax+qhIXJhz5
	ZTwO06uaDW2FS8BxwvKvpxEIHIVMEe4df2+BzQeO8Xe7UFfSde5ugtNOHCM12N3eiSl5vUHBW27
	3d8yFOkmyCaTqkV791q3m2ThR8FmDkMSH+OUrBsNS4VH6Q==
X-Received: by 2002:a2e:bea4:0:b0:394:5c9a:f315 with SMTP id
 38308e7fff4ca-3a189a50d6emr37194921fa.14.1787242431336; Thu, 20 Aug 2026
 09:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803170825.925561-4-hisamshar@gmail.com> <20260817220457.554823-3-hisamshar@gmail.com>
 <aoOKMeua-cNeTxXT@google.com> <8d069fe1-a5b6-4a86-9604-26aebe2dc243@gmail.com>
 <aoSIBnFfy4osa6wt@google.com> <c2f7e904-2646-4b01-864d-d185221c7f56@gmail.com>
 <aoSyYtxBpEaoBwGY@google.com> <c9ee5f08-81c3-4c91-9189-002b260ea641@gmail.com>
In-Reply-To: <c9ee5f08-81c3-4c91-9189-002b260ea641@gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 20 Aug 2026 09:13:17 -0700
X-Gm-Features: AcwNN1XO2VnQdgDq24rSrB6pOvu040FA9J1FBskyMqv9L255R8Q4VMJYArlZmn4
Message-ID: <CALzav=fs4bqMM7BXNPXqhtbqGzA+LW5fgx2-1Q5=sTN5+krYhw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
To: Hisam Mehboob <hisamshar@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 2:03=E2=80=AFPM Hisam Mehboob <hisamshar@gmail.com>=
 wrote:
>
> On 8/19/26 00:28, Sean Christopherson wrote:
> > +David for the VFIO thing
> >
> > On Tue, Aug 18, 2026, Hisam Mehboob wrote:
> >> On 8/18/26 21:27, Sean Christopherson wrote:
> >>
> >>> Oh, so on top of "https://github.com/kvm-x86/linux.git next", this *i=
s* the last
> >>> blocker?  If so, then I'll grab this for 7.3.
> >>
> >> Not quite -- I tested kvm-x86/next + this patch with musl-gcc, and the
> >> build still fails. On top of the steal_time fix already in your tree,
> >> two more musl blockers remain, both from code that is only in
> >> kvm-x86/next so far:
> >>
> >> 1. hardware_disable_test.c, from 496779b54943 ("Pre-set threads affini=
ty
> >>     in hardware disable test when possible"):
> >>
> >>       hardware_disable_test.c:75: error: implicit declaration of funct=
ion
> >>       'pthread_attr_setaffinity_np'
> >>
> >>     The call sits under #ifdef _GNU_SOURCE, but lib.mk defines _GNU_SO=
URCE
> >>     unconditionally, so the path is always taken and musl (which lacks=
 the
> >>     function) breaks.
> >
> > Heh, Sashiko flagged that as problematic, and I was trying to figure ou=
t which
> > macro to key off of[*], but was (obviously) unsuccessful.  I don't supp=
ose you
> > know the canonical way for checking for support of glibc-only functiona=
lity of
> > this nature?
> >
> > [*] https://lore.kernel.org/all/am0KqJOD-FiC9BXs@google.com
> >
>
> __GLIBC__ is the pragmatic in-tree answer.
> _GNU_SOURCE is a request macro (input to the libc headers), not an
> availability indicator -- lib.mk defines it unconditionally, so it
> cannot detect anything. __USE_GNU works but is glibc-internal.
> __GLIBC__ is defined by glibc's <features.h>, which any libc header
> pulls in, and is the established idiom in selftests already:
> kvm/lib/assert.c uses "#ifdef __GLIBC__" for execinfo.h, as do
> bpf/test_progs.c and nolibc. musl deliberately provides no __MUSL__ --
> its FAQ's stance is "test for properties, don't assume them", which
> strictly implies a compile test (autoconf-style); with no configure
> step in selftests, __GLIBC__ is the established in-tree idiom. For
> hardware_disable_test.c that is s/_GNU_SOURCE/__GLIBC__/ in the three
> spots; build-tested with musl-gcc, passes.
>
> >>
> >> 2. The libvfio wiring from a262fc49e0aa ("Build and link
> >>     selftests/vfio/lib into KVM selftests"):
> >>
> >>       vfio_pci_device.c:25: fatal error: uuid/uuid.h: No such file or
> >> directory
> >>       sysfs.c:31: error: implicit declaration of function 'basename'
> >>
> >>     The former adds a hard libuuid dependency (its headers aren't visi=
ble
> >>     to musl-gcc here);
> >
> > Can you elaborate on what you mean by "its headers aren't visible to mu=
sl-gcc"?
>
> musl-gcc searches only its own include directories
> (here: /usr/include/x86_64-linux-musl and gcc's internal dir) and
> deliberately not /usr/include, to avoid mixing glibc-oriented headers
> with musl. uuid/uuid.h comes from libuuid (util-linux) and is installed
> at /usr/include/uuid/uuid.h for the glibc toolchain, so glibc builds
> find it and musl builds cannot. I see 2f0c30d0d1 already limits the
> libvfio link to x86; the remaining gap on x86 is that libuuid is now a
> hard dependency of the KVM selftests build (libvfio.mk adds -luuid),
> and for musl-x86 the header is not visible at all without a
> musl-targeted libuuid install. A uuid.h compile check to skip the vfio
> pieces would keep it optional; otherwise the new dependency is probably
> worth documenting.

libuuid is required to build libvfio, which VFIO and KVM selftests
both depend on.

How is this problem solved for other libraries, like -lpthread?

> >
> >>     the latter because musl declares basename only in
> >>     <libgen.h>, while glibc exposes it via <string.h> under _GNU_SOURC=
E.
> >
> > IIUC, sysfs.c just needs to explicitly include libgen.h?
>
> Yes, adding <libgen.h> suffices. One nuance: there are two
> flavors -- glibc under _GNU_SOURCE provides the GNU variant via
> <string.h> (char *basename(const char *), non-modifying), while
> <libgen.h> provides the POSIX variant (char *basename(char *), may
> modify) and takes precedence on glibc as well. Safe at this call site:
> rl_path is a writable buffer filled by readlink() (no trailing
> slashes), used once by sscanf(). Verified with compile tests on both
> libcs, and with <libgen.h> added, uuid/uuid.h is the only remaining
> musl failure in the whole build.

Feel free to send a patch, or I can if you prefer.


>
> >> The rseq __GNUC_PREREQ failure is already covered by my patch in
> >> linux-next. With the above sorted, the musl build passes.
>
