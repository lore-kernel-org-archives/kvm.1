Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941944;
	b=aWmGL1uRO9GDZjc2xTjexZkGTHGSMZsm7wuwK2ZrjqpswtYBuMOTMHmJUUImqRV7bEv5
	 y3Sd3Bq8DWtvmTPWacHm3e/dqsyfGb6pNDrU02jL1i4IWAePcfuIXrp60hP1hg9fsIhm9
	 iGyELdi7xmaYr7U7rCxr1KClcCapvVnLcrPW73gDJQ3DUr42fzrJKxyBa7cEn3wcIMEUl
	 oFGOtmR/rFjljDcoMXlaRzzeWgnZb6eEc8668dwEFfJTTLW7rBSwlI0o/E4VMHErqPNgK
	 F8yrqWNTbjeKxFWvb10ilSDAZLYKnq1sp21P0XNPMuSQJx9osSppSZ36K3v05JefGYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=L0E8qwKq9tI0TeHTVwDsi/hq8uyC0B0sTmXnOqBK0ms=;
	b=kFx4rd9Kz1M5iMW4tHYnG0k8c3q2/xXwhZaVUu2SRRcArDmbWs0rS4xxVL0iGl2+qUhR
	 sg6XtzWPGEixtqFfPJqrHVm2XcySMqfK5dUJ8habqTTKl/8jbiVB1CphTY3rpef01Feph
	 A1gYceCAVNm4QuUFVWFc7IE+VOBDPu8I4FcH59NqfYwv9aKyq3WucPGSCn53SzFwt3BAH
	 0qtvdS/diQMBTMz3ldoftXJ2dXuMSsOkbGLeyeGVqxpOeETOWcM1iT9jEmzR+za4JwlsJ
	 rPrOUgeeb7r2JwZcIh2mqO9Bcmcdhk5Cz6lr4wZ9mc86j0onFjlWIKj3Cn+8RIY8tKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="oIgbNl1/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45737606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45737606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oIgbNl1/
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso1995a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:12:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793941943; cv=none;
        d=google.com; s=arc-20260327;
        b=VoTTfixmVF/s34VJo8a/1jpuq/a4CK3xsCpkBHIlcBzD5iQ3OSPq5FXKOjxTtAeYj0
         tkllw+UAZVw+/ezfRg+rUuz9ElKauDA3r+ZTdzfz1IwdxCSJj/ViUCxyRaqbN4PMsdVO
         hz3SnkSkgSpVyCERQfQz3U+65gkH38yAaw28l4yWijYKMddOIqfRyx3tQFfon8fMez9h
         OzThAkzwDvaHS0wO+QqfAZbAOTnl+b3/qSXpy6sA3/jJrwlThczWSx7LAh3U8ZrtwjB6
         ZCldOGpowy+V4rM+CwiiFV9zGPclGvKrbhqyO5o1/Xm0/DjwAWh7my2bOOGDdxpsu7Hs
         tofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L0E8qwKq9tI0TeHTVwDsi/hq8uyC0B0sTmXnOqBK0ms=;
        fh=/Ur0soFXrcUNuU5Sn+FxemRodCD7o2RvPzsuQf71HNU=;
        b=CW3/OQHTsRyBsosU1uLhLrGMLAwHCZPaFno7fni9oa/BMmgnegg75xNhnIIM7uZrTl
         PAIsL29P0rOvkOIqS5YOV3ItNMKbkQMkq8wCUPvQiK/nu0lF84GJWx263Q8OL0gbsCmy
         pmScs9rfjXoZp6uqpJmxTuE/0OhOwrBjXSWtVHyYBUVTc44Fvrz6xDZD1KlecQk0tTjk
         m5xLLZLAKxlVDWgy795e19PBlZIIbO6gB9JI2AV0nsHbGAL6HiZeBNPD9e0hKfeZiqip
         yX+AaFIj0Ox0CZ2z0CTcoRKxrRMP4n+Z73B5reoNGRDc+dzi1cOASC/+eK8M3xmlLe35
         fiqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793941943; x=1794546743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L0E8qwKq9tI0TeHTVwDsi/hq8uyC0B0sTmXnOqBK0ms=;
        b=oIgbNl1/Q1nF4uodqrrjdCYfUb+UfcL4xxtLPNA/QST1KgVM8d9k+ZQWlvtNsgiGcD
         mjSqmz+ZcRAw3AKIzEV7nsH2RWtjPZgIDZpNg9mS3nYY6DBl35BskHf1uQB3eHKa2TiJ
         BKlOPlnVR+zUtmb9TWYIH8TF9XVpybVlbBGKaNc+CqpLXzJ4rsFrBxGS2bdQyP85eMbZ
         hgWr64cSaTp0mvmhRgfs6bY6DGadAHVvXCLSX7IVS9MeUnuX6DffvGWCejVIIR2ydVEh
         Z2/Zb5mTiAgXhzMeVb+99ygt3Pe/usTn9WTti6wQQo6+ej+VCyUgzXXkSGXGoRxQfXCB
         qe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793941943; x=1794546743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L0E8qwKq9tI0TeHTVwDsi/hq8uyC0B0sTmXnOqBK0ms=;
        b=bIYS4LO3zd0nptnCQapDI7ffzHfb4vT7lhMPl2itJjnslCS9qq6RQ0eVol9bMizZwo
         QcJ4YHnRG4nph+KaNUd2Fa4nuiMSx3IzBBHNOlggLSAQjlWyofPOCmziYEg8wEFJf01X
         7LQIA/6SNxwPsGwtfXh7s7J545T/ZBa2vc6rPmPtHq0nO1JuR5K+anj8K1xigJhOgPA+
         qZS8j5ZaMPfWIaPwSdQKd3uPwP9xBa6urstVE0jxl4wY6gKeJvUuB2Oy0NxMaOfZ9CUd
         Tpl56BnPNDUnjiFzxy0Xc+p5k3cj/yiFeZrkKySFBSTv0LKYloktAbfQX6xZjm8BHWWR
         kjrQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6QKh0br/JHy9b8B5JON+4lFCFLRg/mSWHmcQTjWNGigv/W5l9btXTBf5F1Ncd2psxKUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z947p5h90dZ8Jr8jJbIcf8pZosk7cWRUrGL9u/lrEL8pyuLMHdG
	ggMN/5Plitow6KAIX1sZbTu9WjY8I90rgQEd/Yb8tGhFnSlENx1H23zluX8Syix3/ENrQRpirFO
	YhOLS9RYPiNNb3P76K8DM6t5VOm0NNwVSD3WfOfxRDyBmzRAGS4QI8rfVCsA=
X-Gm-Gg: AYBFou32t3acNWnQCu4++J9CX5YkTMPGc4iX0qD1JIWN8WvLEUwEYfvJG7n0+UJkR9T
	rN8xUlSlw32ZLbej/ZBjCcbcu84EoaGzLcrUsf75WES4H4giIL5H6AtmphozUvHfMsqdtuiQ6hi
	xqVQZ4at6X2W8yOiA1LxnFyZT2sUE7woZ0Djt2tg7SUGyji3b6dgeL6QGeAQ3tnN6bTs3MPb5L5
	YrcXTDGW2eFYmoIUHs8MRg8jeCwd+L383dW6GnbhO+oth5gEJC8GSyg9MPuGrJuc6HQWEmM9l9e
	O1JLCW1kISWrFZAaeLOA/FvDPRg9B6iedIDYynPCRb1m7stLLIFRjYmTM4/3kK4PqBYj7ge6u7Q
	HIvpx48idpz0/aLZxeqouGaU99wax88fA38OAouaWcUHAdEHtavZFoNgwVi17bRlrawXptrr/cG
	Mhiruw6JReW+Y3yJoEUHKFTGSJ
X-Received: by 2002:aa7:c2d5:0:b0:6b4:9221:8932 with SMTP id
 4fb4d7f45d1cf-6b6e7867b67mr4141a12.10.1793941942269; Thu, 05 Nov 2026
 21:12:22 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-19-chang.seok.bae@intel.com> <20260930214337.90CD51F0089A@smtp.kernel.org>
 <2b4779f4-c3d9-4b58-bc97-f31dba58fc7f@intel.com>
In-Reply-To: <2b4779f4-c3d9-4b58-bc97-f31dba58fc7f@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 21:12:09 -0800
X-Gm-Features: AclHuK_opVd9yhWh8shRW90UNd702LBlE68EsvOSF_68yFBs47J1mEWVZ_Maozw
Message-ID: <CALMp9eRJVdROXGE55qa3VGZBxaMPLoyMhZTwpkHPjA0nu9Xnvw@mail.gmail.com>
Subject: Re: [PATCH v8 18/20] KVM: x86: Expose APX sub-features to userspace
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 1:35=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.c=
om> wrote:
>
> On 9/30/2026 2:43 PM, sashiko-bot@kernel.org wrote:
> >
> >> @@ -1733,7 +1737,8 @@ static inline int __do_cpuid_func(struct kvm_cpu=
id_array *array, u32 function)
> >>      }
> >>      /* APX sub-features */
> >>      case 0x29:
> >> -            entry->eax =3D entry->ebx =3D entry->ecx =3D entry->edx =
=3D 0;
> >> +            if (!kvm_cpu_cap_has(X86_FEATURE_APX))
> >> +                    entry->eax =3D entry->ebx =3D entry->ecx =3D entr=
y->edx =3D 0;
> >>              break;
> >
> > [Severity: Medium]
> > Does this code leak unfiltered host CPUID capabilities for leaf 0x29 to=
 the
> > guest?
> >
> > If the host supports X86_FEATURE_APX, KVM fails to apply
> > cpuid_entry_override(entry, CPUID_29_0_EBX) or explicitly clear the
> > unvirtualized registers (eax, ecx, edx) for leaf 0x29 in __do_cpuid_fun=
c().
> >
> > This could bypass the capability mask initialized in
> > kvm_initialize_cpu_caps(), violating the KVM invariant that new
> > guest-visible features must default off and be explicitly enumerated.
> > This might break capability negotiation and live migration between host=
s
> > with varying hardware support.
> >
>
> Leaf 0x29 currently defines only one sub-feature bit, which comes when
> APXF presents. Additional filtering may be necessary when more feature
> bits are introduced and then filtering becomes more necessary in
> practice.

Sashiko is right. The whole point of masking CPUID leaves in KVM *now* is
so that an older kernel running on future hardware does not blindly
advertise new sub-leaves or new APX sub-features in EAX/EBX/ECX/EDX that
KVM does not yet know how to virtualize. Adding the filtering only after
future hardware defines more bits is too late for legacy kernels.

Why did you define CPUID_29_0_EBX and initialize it in
kvm_initialize_cpu_caps() if you didn't intend to use it?
