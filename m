Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A53C3441
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260691; cv=none; b=imCbF6lV8PtnuV3NZAGmGFphDcYAn7EusQyoYHIMJYyECecT0glaEyzDg1UVgl7R4Ixeakd5bwd6El6a9ZW47dkuUGeyVM9oYOt8Kmm3p9pt69GfULgkBjr5n35GY0AF7iMnbp3Fry/gK7HibsR+Y+qDpKXXt2zZ6TIpFIzYqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260691; c=relaxed/simple;
	bh=RSpilntTvG1mwzgK/Vsni4Q4Wxdtnv4dgMaLfnUtYAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhF1O5jnJdT4eUZFcyzkPh39K531Z9iEpo+YyDGdgHwhYlL+i4G+jnBgqsG9gObDDCTSGhX4Ap3xg4WswHyKTKHW5AWLDe/D+U9BdvXSwYdwrGZzUks2lEto/B38lF+EhBXtRqONwjNp80baqSStsuLgv6CgvqBQX2J3Pym+hsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhpOf53U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhpOf53U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1791F000E9
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260689;
	bh=GuiyXR/ZKIy6AJZxb3DqNFA9Kf/zY1C/UHvLo0+KvNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QhpOf53U+23Zu2HRffdpOmsNBVTeE2p9fmtjh3OLQlwxaE+6wecHcwjcBOmvnArf1
	 G3ctJX3wRrT1QiQB+sU7LkBhn5PKbvVCPCAj9IE/FiN4aDOBETn8SsalEIs4DrXHke
	 pDAK5nJxm9EF2++Pd7uFWJlshT6rQMamMNMFrb8FNXE9fusJu58Wl2sUzJvUm2xban
	 C5KteoI4kILZqZmhzdeSTxcIESjlQ/MQ0D/fcBlc007WLp3QiqP+gu+s10EnvE+yj6
	 FKwM1r8HwNzWvKUNc/OnGuQD0+tiVFSfprPzpH4XTUW5OEuSptvgERrvxY/V8/bAUv
	 hHYgY8SHYArRg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15f020a223so16552866b.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 10:44:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoyGkkVdEnCzWqzOAqoo44yaLOZLnVqmQfyq/ImEVGYmQrU02WpadpigjaoVitPbiZbELw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVfAYSvqHODVFse/HYzBQaVuRZSQ0baDcWKws4zVbhWvZhD46x
	vlSdKYid7XRb6ZYG50tIo5FUi7whvsppoylE3bSj9Fv/LwZH0RITgO+BLfXN+cNcj9L2DzlFtGK
	UfuqAtVb+ecgT8j+sXupE014ExQKPKFQ=
X-Received: by 2002:a17:907:94d5:b0:c12:86a5:3ada with SMTP id
 a640c23a62f3a-c1f72142f16mr213343866b.36.1785260688801; Tue, 28 Jul 2026
 10:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727235228.1007324-1-yosry@kernel.org> <20260727235228.1007324-12-yosry@kernel.org>
 <amjAJQ1VZIcoefYg@google.com>
In-Reply-To: <amjAJQ1VZIcoefYg@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 28 Jul 2026 10:44:36 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMAzdWsJ_7EyxbSOa3jR3hq9xqCmJr0JdEQZfgq4Z3Ujg@mail.gmail.com>
X-Gm-Features: AUfX_mzsE5ZmYwCw8VvAY_801zohiIpyLR3TqDWIz2mEqpFglYFXzsYDgBCtSMQ
Message-ID: <CAO9r8zMAzdWsJ_7EyxbSOa3jR3hq9xqCmJr0JdEQZfgq4Z3Ujg@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] KVM: selftests: Support running stress
 save+restore and #PF test in L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 7:43=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jul 27, 2026, Yosry Ahmed wrote:
> > Extend the stress test to allow running the access+#PF code in L2
> > instead of L1 by adding proper L1 guest code to bootstrap L2. By
> > default, the test runs in L2 after running in L1 if nested is supported=
.
> >
> > Assisted-by: Gemini:gemini-3.1-pro
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  .../kvm/x86/save_restore_pf_stress_test.c     | 61 ++++++++++++++++++-
> >  1 file changed, 58 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_tes=
t.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> > index 664ed280b2e76..0e5ddeb5af444 100644
> > --- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> > +++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> > @@ -8,10 +8,13 @@
> >  #include <pthread.h>
> >  #include <signal.h>
> >  #include <unistd.h>
> > +#include <getopt.h>
> >
> >  #include "test_util.h"
> >  #include "kvm_util.h"
> >  #include "processor.h"
> > +#include "svm_util.h"
> > +#include "vmx.h"
> >
> >  #define NR_ITERATIONS                500
> >
> > @@ -81,6 +84,36 @@ static void guest_access_memory(void *arg)
> >       }
> >  }
> >
> > +static void l1_svm_code(struct svm_test_data *svm)
> > +{
> > +     generic_svm_setup(svm, guest_access_memory);
> > +     run_guest(svm->vmcb, svm->vmcb_gpa);
> > +     GUEST_ASSERT(false);
> > +}
> > +
> > +static void l1_vmx_code(struct vmx_pages *vmx)
> > +{
> > +     GUEST_ASSERT(prepare_for_vmx_operation(vmx));
> > +     GUEST_ASSERT(load_vmcs(vmx));
> > +     prepare_vmcs(vmx, guest_access_memory);
> > +
> > +     /* Ignore any #PF */
>
> This comment is rather ambiguous, especially when the #UD interception co=
mes
> along, because unless the reader is reading carefully and sees the PFEC_M=
ASK
> and PFEC_MATCH logic below, it's quite easy to read this as "intercept #P=
F to
> ignore them".
>
> I don't see any reason to write the code this way.  Yeah yeah, it's the S=
DM's
> suggested way to ignore #PFs, but IMO that's unnecessarily convoluted.  T=
he more
> obvious way is to leave all fields '0'.
>
> In other words, just delete this entire block of code and rely on the def=
ault
> VMX allocation logic to disable interception of all exceptions.
>
> Oh, damnit.  Argh.  I see why you need this.  init_vmcs_control_fields() =
is buggy
> and actually configures #PF for interception.  Apparently Paolo didn't re=
ad the
> "If there is inequality, the meaning of that bit is reversed (for example=
, a VM
> exit occurs if that bit is clear)." part :-D
>
> So, let's fix that in a prep patch (AFAICT, no existing tests cares about=
 #PF
> interception) so that this test doesn't have to carry confusing code, and=
 because
> intercpeting #PF but nothing else by default is bound to cause problems.

Yeah that felt weird, but the comment "Never match" made it feel like
it was intentional. Anyway, I just sent v5 with your diff below as a
patch, thanks!

>
> diff --git tools/testing/selftests/kvm/lib/x86/vmx.c tools/testing/selfte=
sts/kvm/lib/x86/vmx.c
> index cd09c9de4485..089e1a8af53f 100644
> --- tools/testing/selftests/kvm/lib/x86/vmx.c
> +++ tools/testing/selftests/kvm/lib/x86/vmx.c
> @@ -232,7 +232,7 @@ static inline void init_vmcs_control_fields(struct vm=
x_pages *vmx)
>
>         vmwrite(EXCEPTION_BITMAP, 0);
>         vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0);
> -       vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1); /* Never match */
> +       vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, 0);
>         vmwrite(CR3_TARGET_COUNT, 0);
>         vmwrite(VM_EXIT_CONTROLS, rdmsr(MSR_IA32_VMX_EXIT_CTLS) |
>                 VM_EXIT_HOST_ADDR_SPACE_SIZE);    /* 64-bit host */
>
> > +     GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(PF_VECTOR)));
> > +     GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0));
> > +     GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1));
> > +
> > +     GUEST_ASSERT(!vmlaunch());
> > +     GUEST_ASSERT(false);
> > +}
