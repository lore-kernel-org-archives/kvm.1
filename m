Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3944E640
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917524; cv=none; b=TkDc/zJ0vuT8PN1qDMcCDsfzcFepDZPGjMqs0Bn9Mw7XSnNOBUnGvBMLj8smGe7jWw0CRvkzb+yBm1rSHeZ+Zz+hdHe4QE8Sap5IZila2oRxFxEpPAdA4uw7hBuSaJWRfvw9DJew2pC6J3gxvmYwiFX0/qHwHlmEbruNdy0XnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917524; c=relaxed/simple;
	bh=XtTm+pGwswLn5k3c3NvhEmOPMGq1Jl+X2NXZxY2uBas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiPxLdX+2xpLal9OcBbn/Z6tkLdRGtE3QRvIg3epQEPdvgiJgvucrgSanEwz3hskVeCxSvsYKy/RcRvqDb1J4BOJG44QL2ErbJ182hR5sMEssM7uHmuSuC/6g9c2cVUpVqouYbfngvYxIJn15MX7ws2memQMCbonOSVRs0/9KbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKcRkIxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKcRkIxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52FE1F00A3D
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917522;
	bh=EOOm0A/7blxany8fRDeM1goCeMN0cgCQQs8WvTcUjXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YKcRkIxF+3I4eOYBQsppsvYmsVxE0SfGLN+xEaEpyrrlNkrGkzvxJhb4uBleM3ctB
	 jjQSpD2nVQ5Gpxjzpr2AdfWwcyvuUXuKHvSBQVRMYE1WQJZ5srcB5L1NYqdIagGGLp
	 +mFDj2oFUbT1nS6+z+xguMrON1ers3z0hiG9Azy/qIx+A0d6DJF0JtS8ke3yKShHFI
	 1qNawYObgK0LdxOnHnFHrpQBBzcFF4yp2H2DJzMtZ0qRk03tdO+avjlg5mm1UqscIq
	 rDCF9XVjzTCNBRPLfflmYZgQ33UFpohwfaA3jIBmAwFd1XVxzrQThuKBZQTnyfyR6k
	 P7ocXtJv6QiLg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698ab9aae16so1118511a12.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 11:25:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoD5+HXQ0juxtfiOe+tjkugUMUBwRXV0TG9JN9J72zrRlFBE0KiPp0IGYYl/UTUWtujv7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwLNairGKBB3NMa9u9TEz4xRLj0KPWO2zRa6v3bTpEWCK5o9M
	E3UScK/tVMI8rol/qkd64SFZ+1TOn1XVjELJPnRMiWkutpn7+aYZihRgifk92igvoxZsZtfMjW6
	2c1yg9RbOYTxx/LGbvXCv3bxACcbUL+M=
X-Received: by 2002:a17:907:3e19:b0:c16:242a:472f with SMTP id
 a640c23a62f3a-c1c509c495emr419089166b.23.1784917521757; Fri, 24 Jul 2026
 11:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-8-yosry@kernel.org>
 <amOWvrZqRXxxHT1k@google.com> <CAO9r8zN7ditPSQMPpRsWtPXXXoV0iNW5mhGLPb7A356Kd==RLg@mail.gmail.com>
 <amOrCk0KAuq6GtRI@google.com>
In-Reply-To: <amOrCk0KAuq6GtRI@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 11:25:10 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOCB+hMtGib4EkXPuFdNTqWNRenJx3+TiMxuwEZxXzo+w@mail.gmail.com>
X-Gm-Features: AUfX_mwTiZaFlwN_6txATj_zQJt3W7a6Eu91uS-qhsDOUMEp5ri7_1RNWvSHEQg
Message-ID: <CAO9r8zOCB+hMtGib4EkXPuFdNTqWNRenJx3+TiMxuwEZxXzo+w@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] KVM: selftests: Add basic stress test for
 save+restore and #PF handling
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:12=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> > On Fri, Jul 24, 2026 at 9:45=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> > > > @@ -0,0 +1,182 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <string.h>
> > > > +#include <errno.h>
> > > > +#include <sys/types.h>
> > > > +#include <time.h>
> > > > +#include <unistd.h>
> > > > +
> > > > +#include "test_util.h"
> > > > +#include "kvm_util.h"
> > > > +#include "processor.h"
> > > > +
> > > > +#define NR_ITERATIONS                500
> > > > +
> > > > +#define GOTO_PREV_LINE               "\033[A\r"
> > > > +#define PRINT_ITER(s, x)                                     \
> > > > +do {                                                         \
> > > > +     if (x =3D=3D 1)                                             \
> > > > +             printf(s "%d\n", x);                            \
> > > > +     else                                                    \
> > > > +             printf(GOTO_PREV_LINE s "%d\n", x);             \
> > >
> > > Oh c'mon.  I had to Google the escape sequence you're (heh, "you"), u=
sing to
> > > understand this.
> >
> > I named it GOTO_PREV_LINE specifically so that people don't have to
> > Google it. AI wanted to call it something like ESC_SEQ, this is a big
> > improvement :P
> >
> > > Use a little creativity, and then the only magic escape sequence
> > > is the much more familiar carriage return.
> > >
> > >
> > >                 pr_info("\rSave+restore iterations: %d", count);
> > >         }
> > >         pr_info("\n");
> >
> > I had something like this initially and I changed it, but I can't
> > remember exactly why. I *think* when there is a test failure the log
> > is messed up because we didn't print a line break after the last
> > "Save+restore.." message.
>
> Ah, if an assert fires before the loop terminates.  Hrm.  This feels like
> something that should be a generic utility, but using any helper like thi=
s would
> require extreme care (the caller needs to know that *nothing* got printed=
 between
> iterations).
>
> What if we simply add a newline before printing an assertion?

I like that. I will add a separate patch to do this (which will help
other tests using carriage returns), then just use a carriage return
here. Although..

>
> diff --git tools/testing/selftests/kvm/lib/assert.c tools/testing/selftes=
ts/kvm/lib/assert.c
> index 1d72dcdfce3b..3e353ac39eeb 100644
> --- tools/testing/selftests/kvm/lib/assert.c
> +++ tools/testing/selftests/kvm/lib/assert.c
> @@ -74,7 +74,7 @@ test_assert(bool exp, const char *exp_str,
>         if (!(exp)) {
>                 va_start(ap, fmt);
>
> -               fprintf(stderr, "=3D=3D=3D=3D Test Assertion Failure =3D=
=3D=3D=3D\n"
> +               fprintf(stderr, "\n=3D=3D=3D=3D Test Assertion Failure =
=3D=3D=3D=3D\n"
>                         "  %s:%u: %s\n"
>                         "  pid=3D%d tid=3D%d errno=3D%d - %s\n",
>                         file, line, exp_str, getpid(), kvm_gettid(),
>
>
> IMO, that's desirable even when there's a preceding newline, e.g. I find =
this
> ever so slightly easier to parse:

..in this very specific case, you still won't get the extra newline
because of the carriage return :P

>
> $ ./x86/stress_save_restore_pf_test
> Random seed: 0x65f90564
> Save+restore iterations: 500
>
> =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
>   x86/stress_save_restore_pf_test.c:310: guest_faults =3D=3D 0
>   pid=3D4077 tid=3D4077 errno=3D25 - Inappropriate ioctl for device
>      1  0x0000000000403de6: main at stress_save_restore_pf_test.c:310
>      2  0x00007f8ead829d8f: ?? ??:0
>      3  0x00007f8ead829e3f: ?? ??:0
>      4  0x0000000000403fd4: _start at ??:?
>   No guest page faults triggered
>
>
> versus:
>
> $ ./x86/stress_save_restore_pf_test
> Random seed: 0xbc3c1a3
> Save+restore iterations: 500
> =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
>   x86/stress_save_restore_pf_test.c:310: guest_faults =3D=3D 0
>   pid=3D6077 tid=3D6077 errno=3D25 - Inappropriate ioctl for device
>      1  0x0000000000403de6: main at stress_save_restore_pf_test.c:310
>      2  0x00007f4750829d8f: ?? ??:0
>      3  0x00007f4750829e3f: ?? ??:0
>      4  0x0000000000403fd4: _start at ??:?
>   No guest page faults triggered
>
>
>
> > > Hmm, I think we should put this helper in tools/testing/selftests/kvm=
/lib/x86/processor.c,
> > > and then provide a "struct kvm_mmu *guest_mmu;" that is automatically=
 synchronized
> > > to the guest during kvm_arch_vm_post_create().  I think vm->mmu is fu=
lly populated
> > > at that point?
> >
> > Hmm yes, It is initialized in virt_pgd_alloc(), which is called in
> > ____vm_alloc() on the first allocation, which I think will be in
> > kvm_vm_elf_load(). We can probably add an assertion to make sure that
> > holds true.
> >
> > However, I think we can't really provide a full kvm_mmu. We can
> > synchronize the PTE masks, which I assume is what you mean here, but
> > then provide a 'pgd' which isn't really usable because guest PTEs
> > created by virt_map() (and friends) are not automatically sync'd to
> > the guest. I thought about doing that, but it isn't straightforward
> > because we cannot use direct mappings (see
>
> Nit, s/direct/identity.  That's a fairly important distinction for this c=
ode.
>
> > https://lore.kernel.org/all/CAO9r8zNqYA6CACeGTVLcyj4bJ2XPAzEXL+y9tLuCU5=
Y-F=3DD-WA@mail.gmail.com/).
>
> Wait, what?  Me confused.  The PTEs themselves must be "sync'd" to the gu=
est,
> otherwise installing a new mapping would be useless.
>
> IIUC, the problem is that the guest isn't guaranteed to have valid *mappi=
ngs*
> to its own PTEs, which is not the same as the actual PTEs being stale.

Yes, sorry, bad wording.

> IMO, that's totally fine, we just need to document the caveats.  The gues=
t can
> get at its PGD via MOV CR3 anyways.  I.e. all we'd be doing is loading th=
e gun
> for the guest to make it easier to put a hole in its foot.

Right, which is why I think writing pgd=3DNULL (or pgd=3D0 because it's a
GPA) makes it easier (I think) to see the gun?

>
> > > Then this test should be able to use the PTE macros from x86/processo=
r.h, and
> > > future tests don't need to reinvent the wheel.
> >
> > Maybe provide a kvm_mmu with pgd=3DNULL just a placeholder to use the P=
TE masks?
>
> pgd is a GPA.
>
> Oooh, and this test relies on the page tables being identity mapped.

They are actually *not* identity mapped, they couldn't (see above).
They are mapped at a magic VA (i.e. TEST_PGTABLE_GVA_OFFSET).

> In that
> case, it's probably best to keep guest_get_pte() in this test until we ca=
n
> broadly guarantee gPTEs are reachable.  But I still think it makes sense =
to
> sync the MMU to the guest.

We can make the PTEs GVA offset a parameter to guest_get_pte(), but I
think that's not a good API. At least we shouldn't proactively expose
it before we have other users. So yes, I think we should keep
guest_get_pte() in the test, and just expose the placeholder MMU for
the pte masks.
