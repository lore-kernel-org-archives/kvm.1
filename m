Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A733F59D
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916749; cv=none; b=ttjRqB04kS+R0lic9vhVicxvWP35v3pHxZRwHQzmwiE+CJZnTd9HZJC/NxUzC5QqQlqVRene7Iw7kKqUFGkU7Oc8XKqH983Z8Dt4J5afae3qv1xu/ix4JG08nN17HcungvBtxIoZFyPSEirpRqKg1QZAphTXPcn8YtJyK4DmV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916749; c=relaxed/simple;
	bh=dJKpphxH3KSZe9w2Jp3qO7dh+/MedRZT+Md7c56ANK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2jyxzheJXtjYvfa7kR1ZMflgjJHyL7wYDdwAhdNzmgwlhlo5yURA7GlJkcK/HNKmjne3CffrAbZ9ZaI4K9f49uSVhYI9TxE28Diac7ga0mL/ytXpwr8LqBhkOWCOnCU2mCndCVe0axdopv6h2VcXvkUI6JBvWvdG4al3D8Izbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItnCdlp3; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItnCdlp3"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso1167169a12.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784916748; x=1785521548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7oVFIBDsM6fsMl/ijVaOPlE36PygbD5WDcrnvpAxH1o=;
        b=ItnCdlp3ZiQV+bMk80iJMPEZQFsfD9zrXhyabhYrZ0YAO6/T8EuXR7bvIMXSTDFCfd
         G8ojDW0UlwpcGfVI872ybzJZvUXaB3bse2tzrUGlb7ERsjqJDuH1wiDHKO2XpseLPPmK
         rChli1OQMLPAGREORIjoqJOL1KASKZHxiehOnJBbzvAbG3tbLFiODgx0hinTO3cQMORW
         tVv1qs707Mf2lYNqU9EAN9H4abVQ1PGfFtpbm0Hf7S07t0vH/0Fw7wy8nZpE7H1nRZEy
         MApJS+0yNr9B3bf4X4IqnoJ99hrMY9IBbpVois+Mqebw2G7uANwpWhfEydqTPxllonsS
         8dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784916748; x=1785521548;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7oVFIBDsM6fsMl/ijVaOPlE36PygbD5WDcrnvpAxH1o=;
        b=OPfoQ/N9yY6Ubqw5VB6YyUspW6C+ZKszskM42kHT8TUHHoS9B04+NFFlUHn1UQIGDE
         uj8j2M6eQ4kY0VMzp3zE8x60G6APwjNJNO1QwMukHRxmnRiZb2l54fa3UC4hdZV4hYOk
         zQq8LEHa/TadqPtNvOuwGnGFpjeBXmbHZV32gVpBfkHIuMoy3a9+FgENSxaLdUbpClA8
         YUtS3ItONUvCG1mmOx4Nf3CMS27jPwuKsd8JCHn5mrhLFjgmD3+Ae/r5yMEZCiPjP5/S
         GNgntgwTWAwDsbgTWLBpipMTmvPGpBVtX9qb4NMyTH1K35FNVEDkGhIcbRoGleI2Bdt4
         UbMg==
X-Forwarded-Encrypted: i=1; AHgh+Rr9UCtyMRDSzE8J24pfWJ4cH1SE21SM6oszdwwNIavdD9ilEoyUGij5BmBHyZkNa1pUW5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTtY9XP1dUPbjwW/2eX51zzTZTc8LWeIGtsbWY6HjQMvLZuWW
	XmvfqB+gU+vLtxyepPP6K3R0IGPYo6ZabZ+LgLODHwvvr0WBQA5CG3L1+rT+hq/rFiIfHrNC96a
	r7wgnrg==
X-Received: from pgqs24.prod.google.com ([2002:a65:6918:0:b0:cbb:676d:ab19])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1eb0:b0:3c3:9557:3b56
 with SMTP id adf61e73a8af0-3c44b246ef1mr9773220637.72.1784916747612; Fri, 24
 Jul 2026 11:12:27 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:12:26 -0700
In-Reply-To: <CAO9r8zN7ditPSQMPpRsWtPXXXoV0iNW5mhGLPb7A356Kd==RLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-8-yosry@kernel.org>
 <amOWvrZqRXxxHT1k@google.com> <CAO9r8zN7ditPSQMPpRsWtPXXXoV0iNW5mhGLPb7A356Kd==RLg@mail.gmail.com>
Message-ID: <amOrCk0KAuq6GtRI@google.com>
Subject: Re: [PATCH v3 07/10] KVM: selftests: Add basic stress test for
 save+restore and #PF handling
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> On Fri, Jul 24, 2026 at 9:45=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> > > @@ -0,0 +1,182 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <errno.h>
> > > +#include <sys/types.h>
> > > +#include <time.h>
> > > +#include <unistd.h>
> > > +
> > > +#include "test_util.h"
> > > +#include "kvm_util.h"
> > > +#include "processor.h"
> > > +
> > > +#define NR_ITERATIONS                500
> > > +
> > > +#define GOTO_PREV_LINE               "\033[A\r"
> > > +#define PRINT_ITER(s, x)                                     \
> > > +do {                                                         \
> > > +     if (x =3D=3D 1)                                             \
> > > +             printf(s "%d\n", x);                            \
> > > +     else                                                    \
> > > +             printf(GOTO_PREV_LINE s "%d\n", x);             \
> >
> > Oh c'mon.  I had to Google the escape sequence you're (heh, "you"), usi=
ng to
> > understand this.
>=20
> I named it GOTO_PREV_LINE specifically so that people don't have to
> Google it. AI wanted to call it something like ESC_SEQ, this is a big
> improvement :P
>=20
> > Use a little creativity, and then the only magic escape sequence
> > is the much more familiar carriage return.
> >
> >
> >                 pr_info("\rSave+restore iterations: %d", count);
> >         }
> >         pr_info("\n");
>=20
> I had something like this initially and I changed it, but I can't
> remember exactly why. I *think* when there is a test failure the log
> is messed up because we didn't print a line break after the last
> "Save+restore.." message.

Ah, if an assert fires before the loop terminates.  Hrm.  This feels like
something that should be a generic utility, but using any helper like this =
would
require extreme care (the caller needs to know that *nothing* got printed b=
etween
iterations).

What if we simply add a newline before printing an assertion?

diff --git tools/testing/selftests/kvm/lib/assert.c tools/testing/selftests=
/kvm/lib/assert.c
index 1d72dcdfce3b..3e353ac39eeb 100644
--- tools/testing/selftests/kvm/lib/assert.c
+++ tools/testing/selftests/kvm/lib/assert.c
@@ -74,7 +74,7 @@ test_assert(bool exp, const char *exp_str,
        if (!(exp)) {
                va_start(ap, fmt);
=20
-               fprintf(stderr, "=3D=3D=3D=3D Test Assertion Failure =3D=3D=
=3D=3D\n"
+               fprintf(stderr, "\n=3D=3D=3D=3D Test Assertion Failure =3D=
=3D=3D=3D\n"
                        "  %s:%u: %s\n"
                        "  pid=3D%d tid=3D%d errno=3D%d - %s\n",
                        file, line, exp_str, getpid(), kvm_gettid(),


IMO, that's desirable even when there's a preceding newline, e.g. I find th=
is
ever so slightly easier to parse:

$ ./x86/stress_save_restore_pf_test=20
Random seed: 0x65f90564
Save+restore iterations: 500

=3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
  x86/stress_save_restore_pf_test.c:310: guest_faults =3D=3D 0
  pid=3D4077 tid=3D4077 errno=3D25 - Inappropriate ioctl for device
     1	0x0000000000403de6: main at stress_save_restore_pf_test.c:310
     2	0x00007f8ead829d8f: ?? ??:0
     3	0x00007f8ead829e3f: ?? ??:0
     4	0x0000000000403fd4: _start at ??:?
  No guest page faults triggered


versus:

$ ./x86/stress_save_restore_pf_test=20
Random seed: 0xbc3c1a3
Save+restore iterations: 500
=3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
  x86/stress_save_restore_pf_test.c:310: guest_faults =3D=3D 0
  pid=3D6077 tid=3D6077 errno=3D25 - Inappropriate ioctl for device
     1	0x0000000000403de6: main at stress_save_restore_pf_test.c:310
     2	0x00007f4750829d8f: ?? ??:0
     3	0x00007f4750829e3f: ?? ??:0
     4	0x0000000000403fd4: _start at ??:?
  No guest page faults triggered



> > Hmm, I think we should put this helper in tools/testing/selftests/kvm/l=
ib/x86/processor.c,
> > and then provide a "struct kvm_mmu *guest_mmu;" that is automatically s=
ynchronized
> > to the guest during kvm_arch_vm_post_create().  I think vm->mmu is full=
y populated
> > at that point?
>=20
> Hmm yes, It is initialized in virt_pgd_alloc(), which is called in
> ____vm_alloc() on the first allocation, which I think will be in
> kvm_vm_elf_load(). We can probably add an assertion to make sure that
> holds true.
>=20
> However, I think we can't really provide a full kvm_mmu. We can
> synchronize the PTE masks, which I assume is what you mean here, but
> then provide a 'pgd' which isn't really usable because guest PTEs
> created by virt_map() (and friends) are not automatically sync'd to
> the guest. I thought about doing that, but it isn't straightforward
> because we cannot use direct mappings (see

Nit, s/direct/identity.  That's a fairly important distinction for this cod=
e.

> https://lore.kernel.org/all/CAO9r8zNqYA6CACeGTVLcyj4bJ2XPAzEXL+y9tLuCU5Y-=
F=3DD-WA@mail.gmail.com/).

Wait, what?  Me confused.  The PTEs themselves must be "sync'd" to the gues=
t,
otherwise installing a new mapping would be useless.

IIUC, the problem is that the guest isn't guaranteed to have valid *mapping=
s*
to its own PTEs, which is not the same as the actual PTEs being stale.

IMO, that's totally fine, we just need to document the caveats.  The guest =
can
get at its PGD via MOV CR3 anyways.  I.e. all we'd be doing is loading the =
gun
for the guest to make it easier to put a hole in its foot.

> > Then this test should be able to use the PTE macros from x86/processor.=
h, and
> > future tests don't need to reinvent the wheel.
>=20
> Maybe provide a kvm_mmu with pgd=3DNULL just a placeholder to use the PTE=
 masks?

pgd is a GPA.

Oooh, and this test relies on the page tables being identity mapped.  In th=
at
case, it's probably best to keep guest_get_pte() in this test until we can
broadly guarantee gPTEs are reachable.  But I still think it makes sense to
sync the MMU to the guest.
