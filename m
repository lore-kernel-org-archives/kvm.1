Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443219D8BC
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198686; cv=none; b=nkaAt/Q/xiG35xGP/rh9eIitdoo1S35mAhlQ8P/fWlkVpdapIwFjUOesixqCgUZWVvqMBHmC6IxgQGZwYIzvIS3lfCD3iPq0NJlk+HsZgrNT6zs1Azs+gofZZl7CEa9PDNklmvSCc+O5IwrGkfgKtyfRDjITQ5vfrmlzcr1CMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198686; c=relaxed/simple;
	bh=zhLWzvquObb/lwUgHOxL+sR2Iaop9sAAzOmuNNY2CWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1ocDbB+L52ZDGNMKFkClR1LWMSVeDEYF8PO8ZtwsH/ogDnMAd9HnMtWdOEEHOeg0CSoBuXL0IafAGjVfkJS0Khv+afDuR9x166KAm9AvHE6MdwtrLwymurXTlvfmtMS0RtfGvMA1umy5CnAfjgKbvSAl/wq0knESCZKobECvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcqI6Lkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcqI6Lkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F991F000E9
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198685;
	bh=rpgNln62D24F3jNStKJlDZ181aadejYayC6EiuxfjcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PcqI6LkmsJTZJRq4g4MnP6wGHqV8jxSWNpS3pBFvvhcYetL3fF6xER+jGD43p6hN+
	 e30vAvKK+vrnRSzTg5MgZ8WeQX+wDkRggKyO2H95+Xd9w1zSBBseujbPUeFlr3jcdx
	 tsTXPL09WZat9ffSzGreENM/MJ0BXbW8PlnF40f/PaIxYPaAIy6cULFHoJeSd0jldB
	 d5uEOU6J78PFTk8ixhN5MPd87LlFMwBugoZnhxXUoA6xRJaul7TnxmeSzfW+oVtQmv
	 gmjrwPokWJPpe9TRcU5u6G8eVKbNl1cCH7pQYZDlMFT1l2dre8zsNo72VUpksAfKHJ
	 XPLbDZegl9+6w==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1600d040e4so69220066b.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:31:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YzeBowHotdUKKqqIqY9pxIBVG8dcucnfdDMahiz1Mue0Bm+34sp
	XUxcO2OkX3owDYbB2OgSfVqVou+szhlESsi2W9xDwA7P0yqszGQqohduLiRT4xvRfQElKwrALEL
	lB208Hv+c5c39ZvVO7RaCopF6TG6X3Tc=
X-Received: by 2002:a17:906:9f8a:b0:c1f:1009:93cb with SMTP id
 a640c23a62f3a-c1f720f9f51mr6839066b.31.1785198683941; Mon, 27 Jul 2026
 17:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727235228.1007324-1-yosry@kernel.org> <20260727235228.1007324-13-yosry@kernel.org>
 <20260728000925.3C6051F000E9@smtp.kernel.org>
In-Reply-To: <20260728000925.3C6051F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 17:31:12 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMbokukK-atix85WH-SkUtt9=qL9tjJf4y7c_dcwkQJyQ@mail.gmail.com>
X-Gm-Features: AUfX_myimOngv78WFirAWnB-Gl-zJYz1mtK_LTAtVhBnsm11vwsxiG5heniDFto
Message-ID: <CAO9r8zMbokukK-atix85WH-SkUtt9=qL9tjJf4y7c_dcwkQJyQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The test unconditionally enables `KVM_CAP_EXCEPTION_PAYLOAD` i=
n `run_test()`, causing the test to crash on older kernels before reaching =
the capability check in `main()`.
> --
>
> --- Patch [12]: [PATCH v4 12/12] KVM: selftests: Trigger L2->L1 exits str=
ess save+restore and #PF test ---
> commit 30592840747b18628e46af30e613a95b722da3cc
> Author: Yosry Ahmed <yosry@kernel.org>
>
> KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test
>
> This commit extends the testing coverage in L2 by forcing a nested VM-Exi=
t
> from L2 to L1 right after restore on every other iteration. To force the
> nested VM-Exit, it injects a #UD into the saved vCPU state and intercepts
> #UD from L1.
>
> > diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_tes=
t.c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> > index 0e5ddeb5af444..ba1d723001e94 100644
> > --- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> > +++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> [ ... ]
> > @@ -156,6 +178,7 @@ static void run_test(bool nested)
> >
> >       vm =3D vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : gu=
est_access_memory);
> >       vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
> > +     vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
> >
> >       if (nested) {
> >               if (kvm_cpu_has(X86_FEATURE_SVM))
> [ ... ]
> > @@ -247,7 +278,9 @@ int main(int argc, char *argv[])
> >       pr_info("Running save+restore stress test...\n");
> >       run_test(/*nested=3D*/false);
> >
> > -     if (!kvm_cpu_has(X86_FEATURE_SVM) && !kvm_cpu_has(X86_FEATURE_VMX=
)) {
> > +     if (!kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD) ||
> > +         !kvm_has_cap(KVM_CAP_NESTED_STATE) ||
> > +         (!kvm_cpu_has(X86_FEATURE_SVM) && !kvm_cpu_has(X86_FEATURE_VM=
X))) {
>
> [Severity: Medium]
> Will this test crash on older kernels that lack KVM_CAP_EXCEPTION_PAYLOAD=
?
>
> Because run_test(false) is called before this capability check in main(),
> run_test() will unconditionally call vm_enable_cap() for
> KVM_CAP_EXCEPTION_PAYLOAD.
>
> Could this prevent the test from gracefully skipping on environments with=
out
> this capability?

Oh I missed this. Yeah we need to make enabling the CAP conditional on
nested=3Dtrue.
