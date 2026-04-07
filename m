Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180C21D3F5
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585839; cv=pass; b=I2vjvP5miP2kKJCf3kxuy3r9y9npnYF+sTSxMmN0aeG0gmkrJCV8mtERRfOjzGSKWREq/UFENds20dkJz9ql/e45mWg1FiXqST068ZofGVs2QETBjTba0DN5Rr5s3igwZmfd22Caz/rmPIBkfIR740amVeeavxAn5cU/VXyn1iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585839; c=relaxed/simple;
	bh=2Bwix/zSYySrc0kX3jTfLMril1Sl9tnjFwAF2XKAmeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efIImVhwPNWC6WC0j6P87Q90Ux0J82YgypZZIDWmcq8MzvnmmasTp6Bej59wluMOnIPllzLTZgsarzGFnM2x7/LVxNyY83/i9AjsYV7FkJAKGiWV70B7m2h8G3YDfTCo4+jGJ5mkbJmCSsooOT6i090xSJdWj3FTX3Uzlss2LJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgjLx+Tl; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgjLx+Tl"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2a70bb69eso5755604e87.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775585836; cv=none;
        d=google.com; s=arc-20240605;
        b=iwNU5o55Qc57IrA8a5hyf4yUoxdwKqEGS0kNgaWN1UDW8uPXmT3UEL9v5m3ipG6aVV
         w/xYH/a4hZUHF5uyGmJR12K6n+qytWOmw+d+qdyXFySbj3u4VkDgWIJaimganRhCq3wZ
         p9h1lEl4tN7g0Ox9jseFI6IqpTo8PXE8UR6PCe8KkE0CnSGX8jzr5me9HG1HOTlaP7lK
         sx9sZUl2uNbtlFWuN6MRX+VvKA3LdrYuA4HVNyZOFfuvQqitsn7zAUDCM4GJAinVKKt1
         TVLs8NnYJLst17oBIx0kE8qJMFhV+cyoYU3dlfAbyFPfOLczxEidPbpSiJg15/EejL1i
         wOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mt4g02G5AbOpgUgPWuwj2Ob36owO6ize2P391N5zN/M=;
        fh=/mmN3yB4Pq8UbvE1xvcH7BTeUW36sO9v80ZBtG1GtUE=;
        b=PuFMfLMgSrYzMlEOIGdRNes3COLLHTdCwC5wPeTfhCXkNAUZvi4IBSVOf8b1s19E+X
         T13LZz8K9lm4TQjgbrgyEze6MF57P+uD2kagWc2uYV1L1YH/HNJ463qtaWyZDtwTvYEq
         rCi5HwzqMxfRZVTcLos78gn9f9cA104+fcIaJp6CMuSCsKWmvOz4g7pqYXxp2IeSZVUC
         vZ/HtusZDEjtztsoTX91RkUPUPsDSfLQr+2gr9X3kMlrlYxUs3qAmmPCWdH4AIWo8QB8
         Vuh6mwnpyO3Qb3klzAyryPg0W4t3i1QNo6rOpFDnh/l9bKVQpVRK9lsVE6kIzaARZPkN
         x5Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775585836; x=1776190636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt4g02G5AbOpgUgPWuwj2Ob36owO6ize2P391N5zN/M=;
        b=tgjLx+TlXee41BqkT7AE2S1L5FzvJXAT5MKE7OspLFEOcZwJmrbFMSLzSBI+ckoBYr
         gT3XQg6PTVJMNn9mqllFOoxCtHxsuWmHUN/Bra5qftGuXlCp1+960G7Fuek+PbEhYt+3
         s9VMqicnwWLqMEDdFIexbSKES9b2go4qytLTvj27CXEkJEn8NG4UgWcQ7HJxiEgAWXmb
         uWKy/JbnYKx3k+zPu0mcNxIZyf50aVL9Jg0T5xG2C4UbREBuycZ8VkqtQ99G4b4oLHP3
         WetZvD/tCRbqIZpBmQs0MmQzpx/AQ9uc0IXHZn+zitk+ljegdAG4kq1Eb5679GBqzEuD
         SQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775585836; x=1776190636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mt4g02G5AbOpgUgPWuwj2Ob36owO6ize2P391N5zN/M=;
        b=QCZaiBCjs4vUmea1GPTk9sgyFByjzf07NWGDaaZXG+3x/Rka0yllUnXhW1Oj3eH5yD
         HQzr9/IYX1MFxpjbGJ5688LLagqQiAg4KglrRgTylDhFMuQiF1QllkCyIfHUVULfDUYd
         FrbamV3H5ZX++ZlgDGi3v73GgyrIk8LR5hLu5s6tjKJnn6ywqvpfsILMkQ2PFtdpJ9u9
         s22G8R9iDyNMZktEIhUicU0CCaE9CzN3mdm/cLARl9WiNKrjQURTYFBAZznkvNUG75+c
         pmsTXSRi+x2u1NPSgcY+MGAcENsAuSiHJYcj21E1QZPCBvOdFObZ9TZM2lND49qdbhfi
         TK/A==
X-Gm-Message-State: AOJu0YxKvwPXXiklcTEf6XN5xcSRiVjI0RMeI+SidwAdlfEy4nhMpxoJ
	n72w282nTh9pPzIgnWr7pw28PTerKYq+1z0P4yS20jZMKURzRniAWF8SgOyIxUJDR3Ovu6qV5ce
	FkRdychCy8bE/8Byjgk5xlcG8QuTOnzMrC9al0hNo
X-Gm-Gg: AeBDiet425YLKYeNP+afIUuDdsVjyQTMzjdTRr0Uka/uArRTSUiPed9BZiN0/6uUp+T
	VckJ1iKjAaXAIe6lH6TVXfTHBr327mt4wYo8dTegTEzvLUOE+SvqO11F/F8lbvJZmnhumb+ufn4
	r1gI2NHeSKpfLZejIeOxGPDuSSP0UAMzwKSQ7q5LgNuPxNhFlG+vhjprBwJ/PW4DulK6o01Obnq
	a1U7GMJMy0ERP2r/Dzwc5lfb6OywB0XFb1LZVUkwioG/t3ZRgXlzd2MVGVgkSslVvaeZNUKnti5
	M4pVzonLlA5QbpU54dQCTGf8zjQTtU0SmnRj7nU8
X-Received: by 2002:ac2:4c4e:0:b0:5a2:b58e:e3d6 with SMTP id
 2adb3069b0e04-5a337580637mr5275968e87.25.1775585835705; Tue, 07 Apr 2026
 11:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316224349.2360482-1-jingzhangos@google.com>
 <20260316224349.2360482-3-jingzhangos@google.com> <86wlza6fog.wl-maz@kernel.org>
In-Reply-To: <86wlza6fog.wl-maz@kernel.org>
From: Jing Zhang <jingzhangos@google.com>
Date: Tue, 7 Apr 2026 11:17:04 -0700
X-Gm-Features: AQROBzDWsswtw1Rj_NegdrANYiqOmmNN9TBoPQpPwwIZCvHJYinhIoSTY4-KYF8
Message-ID: <CAAdAUth2QJfZ+jtWFKWWiVeaK0AyodJXvig6zwz+5Yr6OhHvDQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v1 2/3] lib: arm64: Add bare-metal guest
 execution framework
To: Marc Zyngier <maz@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Andrew Jones <andrew.jones@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 1:09=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Mon, 16 Mar 2026 22:43:48 +0000,
> Jing Zhang <jingzhangos@google.com> wrote:
> >
> > To test advanced KVM features such as nested virtualization (NV) and
> > GICv4 direct interrupt injection, kvm-unit-tests needs the ability to
> > act as an L1 hypervisor running at EL2 and manage its own L2 guests.
> >
> > Introduce a lightweight guest management library that provides the
> > infrastructure to create, configure, and execute nested guests.
> >
> > This framework includes:
> > - Guest lifecycle management: `guest_create()` and `guest_destroy()`
> >   APIs to allocate guest context and setup Stage-2 identity mappings
> >   for code and stack using the s2mmu library.
> > - Context switching: The `guest_run()` assembly routine handles
> >   saving the host (L1) callee-saved registers and loading the guest
> >   (L2) GPRs and EL1 system registers.
> > - VM-Exit handling: Installs an EL2 trap handler (`guest_hyp_vectors`)
> >   to intercept guest exits and route them to `guest_c_exception_handler=
`
> >   to determine whether to return to the host test logic or resume.
> > - Guest-internal exceptions: Provides `guest_el1_vectors` to catch
> >   Sync, IRQ, FIQ, and SError exceptions occurring entirely within the
> >   guest (EL1) without trapping to the host.
> >
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >  arm/Makefile.arm64     |   2 +
> >  lib/arm64/asm/guest.h  | 156 ++++++++++++++++++++++++
> >  lib/arm64/guest.c      | 197 ++++++++++++++++++++++++++++++
> >  lib/arm64/guest_arch.S | 263 +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 618 insertions(+)
> >  create mode 100644 lib/arm64/asm/guest.h
> >  create mode 100644 lib/arm64/guest.c
> >  create mode 100644 lib/arm64/guest_arch.S
> >
> > diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
> > index 5e50f5ba..9026fd71 100644
> > --- a/arm/Makefile.arm64
> > +++ b/arm/Makefile.arm64
> > @@ -41,6 +41,8 @@ cflatobjs +=3D lib/arm64/processor.o
> >  cflatobjs +=3D lib/arm64/spinlock.o
> >  cflatobjs +=3D lib/arm64/gic-v3-its.o lib/arm64/gic-v3-its-cmd.o
> >  cflatobjs +=3D lib/arm64/stage2_mmu.o
> > +cflatobjs +=3D lib/arm64/guest.o
> > +cflatobjs +=3D lib/arm64/guest_arch.o
> >
> >  ifeq ($(CONFIG_EFI),y)
> >  cflatobjs +=3D lib/acpi.o
> > diff --git a/lib/arm64/asm/guest.h b/lib/arm64/asm/guest.h
> > new file mode 100644
> > index 00000000..1d70873d
> > --- /dev/null
> > +++ b/lib/arm64/asm/guest.h
> > @@ -0,0 +1,156 @@
> > +/*
> > + * Copyright (C) 2026, Google LLC.
> > + * Author: Jing Zhang <jingzhangos@google.com>
> > + *
> > + * SPDX-License-Identifier: LGPL-2.0-or-later
> > + */
> > +#ifndef _ASMARM64_GUEST_H_
> > +#define _ASMARM64_GUEST_H_
> > +
> > +/* Offsets for assembly (Must match struct guest) */
> > +#define GUEST_X_OFFSET                       0
> > +#define GUEST_ELR_OFFSET             248
> > +#define GUEST_SPSR_OFFSET            256
> > +#define GUEST_HCR_OFFSET             264
> > +#define GUEST_VTTBR_OFFSET           272
> > +#define GUEST_SCTLR_OFFSET           280
> > +#define GUEST_VBAR_OFFSET            288
> > +#define GUEST_SP_EL1_OFFSET          296
> > +#define GUEST_ESR_OFFSET             304
> > +#define GUEST_FAR_OFFSET             312
> > +#define GUEST_HPFAR_OFFSET           320
> > +#define GUEST_EXIT_CODE_OFFSET               328
> > +#define GUEST_TPIDR_EL1_OFFSET               336
> > +#define GUEST_ICH_VMCR_EL2_OFFSET    344
>
> Don't hardcode offsets. Generate them.
>

I'll fix that.

> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <libcflat.h>
> > +#include <asm/stage2_mmu.h>
> > +
> > +/* HCR_EL2 Definitions */
> > +#define HCR_VM               (1UL << 0)      /* Virtualization Enable =
*/
> > +#define HCR_FMO              (1UL << 3)      /* Physical FIQ Routing *=
/
> > +#define HCR_IMO              (1UL << 4)      /* Physical IRQ Routing *=
/
> > +#define HCR_AMO              (1UL << 5)      /* Physical SError Interr=
upt Routing */
> > +#define HCR_RW               (1UL << 31)     /* Execution State: AArch=
64 */
> > +#define HCR_DC               (1UL << 12)     /* Default Cacheable */
> > +#define HCR_E2H              (1UL << 34)     /* EL2 Host */
>
> Please consider importing the kernel's sysreg definition, or generate
> them from an official source (the architecture JSON file, for
> example).
>

Sure, I'll do that.

> > +
> > +#define HCR_GUEST_FLAGS (HCR_VM | HCR_FMO | HCR_IMO | HCR_AMO | HCR_RW=
 | \
> > +                      HCR_DC | HCR_E2H)
>
> Just to set expectations: HCR_EL2.DC is not supported by KVM, and
> likely never will. I'm hopeful that this bit (and a few others) will
> eventually be deprecated because it serves no purpose. If you need a
> 1:1 S1 mapping, create it using (surprise!) page tables.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Got it. I'll make adjustments accordingly.

Thanks,
Jing
