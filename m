Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937941;
	b=P96Zkl4CFElqhYFR+/1KZSy/JBSqhx1tkRHOrTW80iId+/D3det2VK7K+dUGRwIjtzbM
	 cHC1pFJ7Z0qcGJ78eQtIvVhibeywuFyJHzDS1dZcw/6zXJEZ6Zay+sgg490gzwSjGLS/W
	 7vojYljsk/ejCsNb3PQaMy5DagvSuCpgxLIcULUPrmsjC7q7qnNik/AHs7PvqJG5aYeLq
	 zXlEa3fC/wprZRXNURLHJ0bNhmNOj14DQyYXQEWdIkNw2WUzIiCaXtL2tgWeWAXAeEaZ2
	 TJohK5CAZmSD++mhNQHiPG3Q3C+yGo53jg99IDDEzgyHZSHIUe51by+g/Hd28d8u9zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937941;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
	b=Q8pB5ZVVmR9s/T302OmKFPUEVTp8IZkjfbDRbiKXf33QHnh3BhgeH/XRpFVEhScoWJJn
	 Ad2foQsxQWQKzZzIOXC1kwTN0e/3dw2/L88qyDoXB5M6J8PHMOceUeV4wPhb3vYPdzMC8
	 VEGOzWjXSJzqlyHThJhpjbAC1byFyp77O3BEmThI7CvBa11Cnm6m1lksyf7D3EOaaMTeE
	 GePdwb1sDMDwtsEicys/m+RXf2tC+/FSq3Ed0orimO8J1pcyGGSt84bv8urE0gcO2nf+r
	 HOYJAoBMkJ+K0v6VxmqYLz8wFf7txGzDZ0ZrkDtxqtHpJFLNyEtwl2lpr+PFFb8msHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YDVFDqJF;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kJeHWwub;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E2606A31C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 17:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YDVFDqJF;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kJeHWwub
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794937940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
	b=YDVFDqJFUMRWJAwz6rqcHYd4pDoB3DTeYxYlCimlf6VSzkTCu1Yok+8CDEBegc90/iW9WI
	hg/PXLviYJ/xe5Ix4iFmTy8h8KbXCfhnGFMSzhRevG+XI2clKbRfHW8uGTSWE1bTbf5Tdq
	os6GR6YSualq0UGQsz3x1me0fGCEYTc=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-9iPW-p7cOh6CHznroFlQjQ-1; Tue, 17 Nov 2026 12:52:17 -0500
X-MC-Unique: 9iPW-p7cOh6CHznroFlQjQ-1
X-Mimecast-MFC-AGG-ID: 9iPW-p7cOh6CHznroFlQjQ_1794937936
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-677c4ca22c5so8552497d50.3
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 09:52:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937936; cv=none;
        d=google.com; s=arc-20260327;
        b=PuzGZ0YX6rFuKWkRomQDp4pkayYU3hcv0tQ7wDcGrwo4k8ruuuo6ubW6a+5IgUpNm9
         uFcPNUVzf0ffCPnVAqWC/HKu8iFGtgMiyui+MurrsP6n1SiPozf++WwzYN4A5cTRW2S2
         NTcZZjuo7B8q/8JDH8adRJR7jl8PuUMi3bn6Z07x8J44Yy9BM8nx6kllc4qvlQWx3LiM
         0g0YaYLafTKiRi0PiNUq6wcc4teG9gpcVssybBiTNnG68ZF/qsMI6ENUj4DfVZTetwmB
         gI5hFlbZ9aCgFZ6cb9ypcyobSohbOWdTLsCJMU/rvAOmRDI1CUVkVzx+D6rqH0iUA1JR
         qNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
        fh=rE38JTfPwGNajV+wwJTKqY0ZtzlJukHlDW/4CCw5eYs=;
        b=jadQ6BhmuWZveOHSGyiVqGstcPU9k1WywBu4B5vFjSxU0vTTJtQiphTKaGDaxIxRWh
         9YzHAMkNWUP1cdKiCzpIsLca3mh2oRy5Q53rK2xPHBX825pPFfyLk0v/NeDmZJW4xldn
         BZMvDrpSKGvqtT05fOl902FRcFvAlHRDphBOO+dZdeWrqirPyCPS7eBS9NaS6+tE1yOn
         b3FmCvQhJsFEVKV2aSsq/bKYQRuIOlApdgoM0nLEW3N9ZYRNMCA13iePHhZppClx7f6A
         ZcdrUPr9Z/kJJdg6GvmkouKfXOLMdfjLSZTWh0mB9DTW5jpKkrGUd6egR6YeREB1A9kP
         Td1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794937936; x=1795542736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
        b=kJeHWwub9NOGjI2oxUfU8bSfRisK7xSXksoBXt6Qolw4MKGxDHh7RFZ4g+2b5lEFln
         iPzIG7jn3/AFiuvuQb+FRaPTLWHLybIE/fLv0+aOEb3WCesH1RLg9yx71Jovy61n42MD
         Xw0HB0AskjYblj6gQc81WBmLFZw6OoJIZEwxlLtB0L4fGAYBi9B5PH9wNfealop8UW1X
         9aXuIEvk4O2QpNX/ViN3HWF4stgzRu1reN4SNr9dhcwnV8tiWlyOhRkEBGF5CcHP3bso
         uEE+s2vl9CmLynYDQSzKSsG30LuOeKuW3VgDkpEhGobSU5Mef9vVymZUBJD6Ch5nBSC3
         Spvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937936; x=1795542736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5RsskxPgR1RFtj2rDzNM7VhJwTOakHKGLIowySGlWg4=;
        b=QA6vpai4sY2dY+cVaPxd8+T0LHe4rPUH/OiQuk67ueGCGByOE8WOh0Rt/mYOdTa3rG
         k9yNIIw4VJAcSFkVdg82eawOvfhx0BwVae6yhsrj5Y/JDY2drY5GzjSsKb8FByDeT1ZJ
         5QdibEj0b9sBkhaYOc/OQz3ojgghY5kFxx+fgEez093odzN5MAVPN48SjhaqJ26p+HtX
         NZi3MsLbkZJ3j1RzbmbQPafZ8PUgBeQjFrmE/5wTKc3+F4fRndD6J1u/f+1zaauS3UI5
         +s4txUqwFRROogK9MI/cluJLPs0XhSjrGkJLGERDAKQs7wJIELS4qwAvO/nQQMaPs2bz
         GaNw==
X-Forwarded-Encrypted: i=1; AL+hErE79rHpkqzT3R1AUsGg/m1m0N7gG3P++EBUjpDW4qDQTDQXnx4aBQE2A2BjMUKPHaGZ/Hk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mZRpK8XR9sY9chaVZ9+Q6lc1enByEVDspQx5hpTHhb6E7uyet
	HlSjhog5STNjgHONSfUTFw7QuVqTmfGeldXWT9ifNEbIJXpRNqFDFfIxx1LOAdbe22kOOhGfBRk
	gqmDWMODoEeSH0zeFrueC6wAtlhdBSyycmftEJ2fpqiy9+p1PhMy5QSg5A5D6cDTMWf79YF/8XQ
	0wmBGHwDHEge2sE2XXePmtJcKt/YQC
X-Gm-Gg: AZFdTZea3zWxKGpExT8Tw5JftU7qC34E5vGZdLjpATrP0Lsvqa0j8zhIRGK3oVH1VdK
	Fm3euWVgVQ5LJbDOjgG9qNk2UDNrqj121hkoqGuJVFqRpPMfS9MGp/fVKLNnAPbRg1cXZi/zIeU
	3UEJf0s7YTxt0JAiqO11UdcBkOaIHns/+G+qdRCNJlcOJG0KXjKzIGvj4uW75ij66CvSEI6TVdI
	8hhVxOoEdOTHctQ
X-Received: by 2002:a05:690e:14c8:b0:67d:bdcc:423a with SMTP id 956f58d0204a3-67dd3fed186mr125172d50.58.1794937935967;
        Tue, 17 Nov 2026 09:52:15 -0800 (PST)
X-Received: by 2002:a05:690e:14c8:b0:67d:bdcc:423a with SMTP id
 956f58d0204a3-67dd3fed186mr125164d50.58.1794937935464; Tue, 17 Nov 2026
 09:52:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116165002.30939-1-jsnow@redhat.com> <20261116165002.30939-5-jsnow@redhat.com>
 <avxapBFgrHUV3rfp@redhat.com> <avxbAf6FlGMthTCE@redhat.com>
In-Reply-To: <avxbAf6FlGMthTCE@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Nov 2026 12:52:04 -0500
X-Gm-Features: AclHuK9JtHUiSsE0QAX6QkJYOQtVMKTlxiSmWNUJL3alftMy4VMW9ohnAPmR1JQ
Message-ID: <CAFn=p-aDi5Com_BJaO-bFHZoEghqBbBJXgn=Yhsg1mwwhuD+RQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] debug/mem: name pthreads
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
> On Tue, Nov 17, 2026 at 01:46:12PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Nov 16, 2026 at 11:49:59AM -0500, John Snow wrote:
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  meson.build              |  8 ++++++++
> > >  util/qemu-thread-posix.c | 30 ++++++++++++++++++++++++++++++
> > >  2 files changed, 38 insertions(+)
> > >
> > > diff --git a/meson.build b/meson.build
> > > index d7bcb581c18..ef961df2f64 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -2878,7 +2878,15 @@ config_host_data.set('CONFIG_PTHREAD_GET_NAME_=
NP', cc.links(osdep_prefix + '''
> > >      pthread_get_name_np(pthread_self(), buf, sizeof(buf));
> > >      return 0;
> > >    }''', dependencies: threads))
> > > +config_host_data.set('CONFIG_PTHREAD_GETATTR_NP', cc.links(osdep_pre=
fix + '''
> > > +  #include <pthread.h>
> > >
> > > +  int main(void)
> > > +  {
> > > +    pthread_attr_t attr;
> > > +    pthread_getattr_np(pthread_self(), &attr);
> > > +    return 0;
> > > +  }''', dependencies: threads))
> > >  config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(os=
dep_prefix + '''
> > >    #include <pthread.h>
> > >
> > > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > > index 089606c93fb..967e0f15f6d 100644
> > > --- a/util/qemu-thread-posix.c
> > > +++ b/util/qemu-thread-posix.c
> > > @@ -17,6 +17,7 @@
> > >  #include "qemu-thread-common.h"
> > >  #include "qemu/tsan.h"
> > >  #include "qemu/bitmap.h"
> > > +#include "qemu/mmap-vma.h"
> > >
> > >  #if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GE=
T_NAME_NP)
> > >  #include <pthread_np.h>
> > > @@ -362,6 +363,13 @@ static void qemu_thread_atexit_notify(void *arg)
> > >
> > >  void qemu_thread_set_name(const char *name)
> > >  {
> > > +# if defined(CONFIG_PTHREAD_GETATTR_NP)
> > > +    pthread_attr_t real_attr;
> > > +    void *pthread_addr;
> > > +    size_t stacksize;
> > > +    size_t guardsize;
> > > +# endif
> > > +
> > >      /*
> > >       * Attempt to set the thread name; note that this is for debug, =
so
> > >       * we're not going to fail if we can't set it.
> > > @@ -373,6 +381,28 @@ void qemu_thread_set_name(const char *name)
> > >  # elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> > >      pthread_set_name_np(pthread_self(), name);
> > >  # endif
> > > +
> > > +# if defined(CONFIG_PTHREAD_GETATTR_NP)
> > > +    if (pthread_getattr_np(pthread_self(), &real_attr)) {
> > > +        return;
> > > +    }
> > > +
> > > +    if (pthread_attr_getguardsize(&real_attr, &guardsize)) {
> > > +        goto cleanup;
> > > +    }
> > > +
> > > +    if (pthread_attr_getstack(&real_attr, &pthread_addr, &stacksize)=
) {
> > > +        goto cleanup;
> > > +    }
> > > +
> > > +    /* Though there's a guard page, it isn't actually marked RO, so
> > > +     * just label the entire region */
> > > +    qemu_name_vma(pthread_addr - guardsize, stacksize + guardsize,
> > > +                  "pthread (%s)", name);
> >
> > On the one hand this code is pretty sketchy as it is making
> > some assumptions about glibc allocating thread stack. On
> > the other hand qemu_name_vma() is a no-op on non-Linux
> > platforms, and we ignore fails, so we'll degrade nicely if
> > any C libraries (musl) deal with thread stack differently.
> >
> > I feel that glibc itself really ought to set the VMA name
> > in response to pthread_set_name_np but I'm open to us doing
> > this in QEMU though as I think it is safe enough.

libc will label this, but it will give it a very generic name like
"malloc" or something like that. This is a "free upgrade", but you're
right that it is porcelain as it requires us to know a little bit
about the memory layout.

I'll add a better comment in-line here to warn folks that this is not
necessarily *super* reliable, though in testing it works great...

One concern I have is that even though there is a guard page
allocation here, nothing appears to set permissions on said guard
page: it remains fully RW. That's not a particularly effective guard
page, I'd have thought...

>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

