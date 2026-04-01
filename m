Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1522D7DD7
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087711; cv=pass; b=nmuM/e+QVRnKOO9E4LF0hdzOGwoD/0c4yEgZz6AafwAh+qFkC0Xg8Ihao05BvJpu7Kvh/butX9er8VAAj2hvCtwtnnuIYUoyPubFTngH/8Hw85ZGQcrcZDXwMlDgMx4uoKNkkQqwJSGSxthh07OSa44OIRSETOb9MI7n3l2+EHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087711; c=relaxed/simple;
	bh=aJ2yct5Kkw0n6gUO9KxXdQuNsdLObItTFFlPjUE3bQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0OX9Gdd8jLirZDhfnUUimy/Ou+gZEmqBAGBLRpE9mgtNIcnWZeLQURwuwbzYZyuMj35USVZ/pSgOlTuVV+ZDM8LVA9Jozzlju81WPnXL7MPmfMtOwXPDnossrmAFHRELcC5SPjU2vRO4d18UchaVsonjKigA7bzAEXZvOtqoTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4CtWIhB; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4CtWIhB"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5091ed02c54so127381cf.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 16:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775087709; cv=none;
        d=google.com; s=arc-20240605;
        b=BlUcftxMeaAVqL4jnAdS8KT8USVTTol9pCmEqo8nQxId4MTq/+dqfqqPTTGgECNTVX
         BxEsMj0AsaKOKLb7O3XDuG/2/7h7oxxHXnB9j15GQeuAF9Y/gqCCqWtsfSqxzN4JppWe
         YiuYhLcGnj0N5dvtzLcj25TPuAp9lKZpYuI/G4XYPhNIDeXPyqwFUb2Q7depWSSnI3wx
         9ccw4n82gmdjMDHbVCEOSFEbGCV1bOLDA1UzlWK0z5PuPbAEPYpjeUz0Img9vbQW4fvz
         ilpSWi+i2CuwNv4FNCTctTdhOy130grxQ9UOrNyWm4q4pKnXWqukrL4Ha0M7EYKvfTWE
         29/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yN2FfHSX2DNGo/uX0BVAtbaUpS5gt4WX2yTayBAcXFY=;
        fh=AE5R8WVBO59OQwuJ600PQDEIxoDKIy0zVk9yACGfLMk=;
        b=jzqlsUIGlQVy2nI3noFzfsyUedTgRou0dtAM0yRVWCDUws9AR3Dzz386hYIc/riX5n
         +K0reDdd7ndB/z5PFA6B8upEqPAEvTQJ34/guS3P+9LFcsXz5SitOH+4dBFGSy7hmBhq
         CLfL1CsdLDPbohwffcG0GkxYTwoAsFlaNBSxSEindVU2TZVCp+iZT+jpxg9Rhz/E0xVL
         CKIvDHOz0OJO9St+yakf/oIkqb8vsTjJQdiyc5bEmRmlu9nzheylgyM7Byc18dHxidyS
         GcDaGeb/bfRzGbvWoifLJsdqsfmSaJzIerNuwfnooeQsYFz0cUlZR4BjLfDmNceiZyqC
         I+8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775087709; x=1775692509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN2FfHSX2DNGo/uX0BVAtbaUpS5gt4WX2yTayBAcXFY=;
        b=v4CtWIhBO0Gi2X667C4eO+LtcUJxL4mOaqY5INT/ZB5j7FcN8ZdkPuOjp1TK8b93MZ
         Zmy2l5Bf9eKximMQZrU2VTnvq/A3ppS8AVTpvapcE0xhJybojKcGkvti1DzRczybUZoJ
         LnKTlteoRXdrMWgoLqVVmjgFDPAF340VNMP5wGFWq36nKUgLLfU5AzHFcFYgBl5h5a5P
         JulPvqSgqNlk9TDPT3kiZFQDnrqhUpUCjtLNokTIpouUxtxp0mUWtkp6qjrsXK/hxIPd
         6iEIv4xhHqd7/f5nGKG+fa5li+QE33BJj0772m/8Uta6FR7P/nEvx5KklJIVKujaemHF
         3lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775087709; x=1775692509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yN2FfHSX2DNGo/uX0BVAtbaUpS5gt4WX2yTayBAcXFY=;
        b=PYcDegUUcfkRylXdoomPMS/SIIFAr/nrkv4TDRZyKBSoOrRwC9E7I17ExU79KvLAhd
         2CfMIsuDphAZ8I+/11dwWmuhsVLwkfFokygJIjMDrzZKmDKIAh5Z61X43eFdJ+v0bgVN
         MHtqNuYuTquh/59m8EfozPIQhHrkQzOVx08DgfDDNEyG7xSpsaMm57ELNkojCO1RywRA
         07lNkyYryppUwVJ248rvrmnoqZeZ1tNk2EmBo4fglRYf/nHlu/Aqfvgf1fuehX/Jg6tA
         FbSS8FfhtubT97QVReCJkdux85iiZDSvxhhiZzbL9L4o8gbyCXEuM7kiGpd4erdH4zKt
         kAGw==
X-Forwarded-Encrypted: i=1; AJvYcCX83I3FlqgYkawIkxKpp0WIQKf3IBed/dbDzcQfYxb6VD6AVaJhiSr5VS7FMNjkdh+TUBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kulGbE1RdIgdcqfql4rJRMwhCAuRTjcYUDwMk27zmPv1DdDG
	T0URmeLICm8EDSeBmD4USuJMAP+zVdguHVMx67LYi3j01kkb5AhHQd29Gm2AcW0HyzJ/G0TsJG6
	p4uqrMgHhcfWEU3JWLQLXXJODRWEFcKU5BHaRyOo=
X-Gm-Gg: ATEYQzzhQXWdL/sCsSYQ8NjBq1Bm0QpJQWjiNVqOwLpELCUEJhmVs4ExcRuskC1UGXE
	fxfG7UG1Zqg7XgUaiwDPJblXF4wNgshhqSCh+zc67kefVIxB6YkSKx9gYQ6XaAmcXQc9P1dM59b
	mRM2mH7mPiwGr1rM+7jAEmHBQmo4H8TCSN9Grl4zZtid6HxTbSnItqSHabD3Svll24keZrmpMgj
	710s4eAMJ36JndeOsuBy92l2P9osr1yaeSggLwHqQfmepozMLtVrbiRufyItVP3JIgp5VZVqrEF
	HUwBbL2/t3Em6po53gtdjvg0AR8GmxwtVZYA
X-Received: by 2002:a05:622a:8597:b0:50d:418a:9770 with SMTP id
 d75a77b69052e-50d504aab45mr1137611cf.2.1775087708736; Wed, 01 Apr 2026
 16:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-3-jrhilke@google.com>
 <ac1jO1e2_BIs1Kx0@google.com>
In-Reply-To: <ac1jO1e2_BIs1Kx0@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Wed, 1 Apr 2026 16:54:57 -0700
X-Gm-Features: AQROBzAIv4cRKWl8fn3xuVKEBXhaYUo87GYS4vTohxiQqWx7phVq0rr5K9YYp0Y
Message-ID: <CAAdrzjv3G6j2KvNevv=1qSEtaKN8xeFc4N89xrerXZm5TnU2oQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] KVM: selftests: Add helper functions for IRQ testing
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 11:26=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Mar 31, 2026, Josh Hilke wrote:
> > diff --git a/tools/testing/selftests/kvm/include/irq_util.h b/tools/tes=
ting/selftests/kvm/include/irq_util.h
> > new file mode 100644
> > index 000000000000..a5d6b63b30da
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/irq_util.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef SELFTEST_KVM_PROC_UTIL_H
> > +#define SELFTEST_KVM_PROC_UTIL_H
> > +
> > +#include <stdint.h>
> > +
> > +int get_irq_number(const char *device_bdf, int msi);
> > +uint64_t get_irq_count(int irq);
> > +uint64_t get_irq_count_by_name(const char *name);
>
> These are far too generic.  I'm also not convinced these should exist at =
all.
> I'll add more context in the next patch.

Ack. Responded to your comments on this in patch 3.

>
> > +#endif /* SELFTEST_KVM_PROC_UTIL_H */
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/tes=
ting/selftests/kvm/include/kvm_util.h
> > index 8b39cb919f4f..8be02e7980eb 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -1144,6 +1144,17 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mod=
e, unsigned int num_guest_pages)
> >       memcpy(&(g), _p, sizeof(g));                            \
> >  })
> >
> > +#define READ_FROM_GUEST(_vm, _variable) ({           \
> > +     sync_global_from_guest(_vm, _variable);         \
> > +     READ_ONCE(_variable);                           \
> > +})
> > +
> > +#define WRITE_TO_GUEST(_vm, _variable, _value) do {  \
> > +     WRITE_ONCE(_variable, _value);                  \
> > +     sync_global_to_guest(_vm, _variable);           \
> > +} while (0)
>
> These belong in a separate patch.  I also think we should convert as many=
 users
> as possible when they're introduced.
>
> We might want a better name than WRITE_TO_GUEST(), because that suggests =
it _just_
> writes to guest, but it also writes to the host value.  Maybe SYNC_FROM_G=
UEST_AND_READ()
> and WRITE_AND_SYNC_TO_GUEST()?  Stupidly verbose, but IMO it doesn't look=
 too weird
> in the code.

Ok, I'll put this in a separate patch and update the macro names in v3.

>
> > +
> > +
>
> Unnecessary newline.

Will remove in v3.



>
> >  /*
> >   * Write a global value, but only in the VM's (guest's) domain.  Prima=
rily used
> >   * for "globals" that hold per-VM values (VMs always duplicate code an=
d global
