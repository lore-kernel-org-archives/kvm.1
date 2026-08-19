Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24F18E02A
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160409; cv=none; b=HN3AmA7+l0yRln3bz8winWeYd2sfyY7vyQMYnRvWrgCAMa9nCZl2Ez0ZHhm7TYD/dcKZdRROeae6PRdTiMBNUYGpwHdUiQTPMHcWjp25MrFjeUp1HrYCKGlg2Iv3HAdnnvVyR2VJ14QyfuPsvjDaW798/xQLQTsRu0A+WL0kEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160409; c=relaxed/simple;
	bh=cUnX+9G1jhe1+uFL3NHstLdTJfc8g3JEdUPKhHzG+C4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lnoAwqk0dk1OvsvjdGlS3sMKn4nrdcOQcVkffIlfWu3KLlhXskqdYGgtcxXFWgOb4cgUmFYBVCNPcb9fGEx52qmKOUFf2lLXULWSvgPzoHhIykzTONQUhNkcb43awbnVvTZpMFm81UXt3rQf4gfIWoooFxPo8smIXfHeP6szp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKo9O3NT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uF839Q6z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKo9O3NT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uF839Q6z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787160406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HAcg1kOG/R1cDKIFXfda5V/aWJ0s4cWHtf0wJKt4lM=;
	b=VKo9O3NTcEv7ZruUA8beJvYBGpkCwpJ4ZV+qU2Ja5Ekqm/Cs6c31bpOnOZ++uZ709vuTxN
	ntqnilkOe5H3i62wK3++vxhJNfky0ctGvYbZibLrpq9HRxSnxRSI9cQ/r9XdpxsofGVWp6
	NRrpCyAKR0qiQU/rw8TvubDXaBdDw+g=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-OzZP9TRwNXSNxf2_VC-uWA-1; Wed, 19 Aug 2026 13:26:43 -0400
X-MC-Unique: OzZP9TRwNXSNxf2_VC-uWA-1
X-Mimecast-MFC-AGG-ID: OzZP9TRwNXSNxf2_VC-uWA_1787160402
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-45ecb9dd589so631314fac.0
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787160401; x=1787765201; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7HAcg1kOG/R1cDKIFXfda5V/aWJ0s4cWHtf0wJKt4lM=;
        b=uF839Q6ztsIqCiEJ5N7a/VB6m1c9giHlogB2htyVrtJ4FcW5PjuHl86jMy3hUmM1zo
         Gn8/BlQo9T+a6W9yVNMsk1mvOymmcDWkRdQzrHY3xfXZSBNLffsv6OiDB8/c1q8b4FRy
         7eRPGJn4Yuk1b3pV8DXrNSmnt5w0VIAM541GoySMSnCvFiJPfWEof2gEIutUj41SJ46L
         8w/HmeXaTDqY150XvdfpI9/wxKiXgxDl/4t4L+hdVxPNI54cLzc9siNQKyXneKhYWo5I
         6XvSim7iWGd2kznOsn8mhQvjnBYRmS+m0o3kKKjDnldnDLULOXynxZaAFpnPBXoRE3XV
         yoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160401; x=1787765201;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HAcg1kOG/R1cDKIFXfda5V/aWJ0s4cWHtf0wJKt4lM=;
        b=ArrAbe7cgtsXQqHhcon4m+8mkOi7NSD7OA587iiC8nOUbY/+b2EaOWTuawUhAp7eE0
         teDrfu7dS2mn/Dgt3BUZ3CeWN5FomQYZX4IQQj1dvJsrdzChLozGeLS/wC4fsyZX4epO
         ShvB9JYZWQ4i1mt2Qdvpfvo3nfNbXYtAXGCgf203LvUF1dP9vcP/E+BGtTpNRHhkeXmU
         aZMMo0G0ry9k8M2zGQ8BkM8ProL79jjoC8JFoQzUL5nXPTzSBmtsh8eN9O7uQuQAnmQH
         K1sYeJFZ7Lcd2B+ErzFlsDiE6U7YWHuTAm6SopfbLWiIod0G3XF+8bmrU9HzgBN6IZe9
         Pj9g==
X-Gm-Message-State: AFuF++nByqXMpU2kccI8vM4fur4Gh8fSd6gzype0Fm5F7HGiMc2bTLGm
	1ExY8oc4NCPO2M+t3feEAmrMiVopEbsw4jdKc5US7Ue5VbF3jmMl2UBGCXVXGRm1HkdiUWjM2mn
	DMcYVo4xjLvmkZLmDvUSrnjafjz9nT1lDYaPWdPqCwbx8M9UmgaRAdw==
X-Gm-Gg: AR+sD119+CCjyToeKDc1WgDUsse0BZB3R64glJ41IBPUegUyEXG4pF8ZUmEmsdue+II
	726KeoQO2e9ZnKEI1fLH9+uLlQyMAWlzZDQ6YRmGiTln9UF/PBCfvBElmcz0K6UB88NR6ytbsAo
	eLIac287fWDZEJpTZCaNxBW36lsdy03A9/DwvPmLFq83SvBVfLqcXmla3AaZ2DybIoDkEPmaxBB
	BoNNMyC21ZgM9ugCd1wvrO4NOaUkp+a7tJQWthjfr4QczGl+oRxZpkNH4BRoaYq6UVWiiBlGMoL
	tPz0SuDcRna7tTGm/WEae96hPLKLQahtQdUlgeGn/Zua7TUadroqMHRzSPb1aTaUn/veQ9IImb1
	76RqSnTcdH0E7UFI3kFp61mWVnZ2u2fZgPqCvqI0MwXC2T0+S1r4cMjg=
X-Received: by 2002:a05:6870:288d:b0:456:dbed:6b60 with SMTP id 586e51a60fabf-462f6335ba8mr6903600fac.1.1787160401570;
        Wed, 19 Aug 2026 10:26:41 -0700 (PDT)
X-Received: by 2002:a05:6870:288d:b0:456:dbed:6b60 with SMTP id 586e51a60fabf-462f6335ba8mr6903537fac.1.1787160401044;
        Wed, 19 Aug 2026 10:26:41 -0700 (PDT)
Received: from intellaptop.lan (pool-173-33-204-162.cpe.net.cable.rogers.com. [173.33.204.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45f22a80c6dsm5828362fac.2.2026.08.19.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:26:40 -0700 (PDT)
Message-ID: <0027ab40a40894324c51411ede63c5cadcc6c0b4.camel@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] svm: Add SMI handler for
 svm_intr_intercept_mix_smi test
From: mlevitsk@redhat.com
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, pbonzini@redhat.com
Cc: kvm@vger.kernel.org
Date: Wed, 19 Aug 2026 13:26:39 -0400
In-Reply-To: <20260818133445.8688-1-ryasuoka@redhat.com>
References: <20260818133445.8688-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

On Tue, 2026-08-18 at 13:34 +0000, Ryosuke Yasuoka wrote:
> L1 intercepts L2's SMI and the SMI is still pending at L0. When L1
> re-enables GIF via stgi(), L0 delivers the SMI to L1. Without an SMI
> handler, L1 enters SMM and aborts.

Can we add an explanation on why this happens:

This happens when KVM support SMM but the BIOS doesn't, and therefore
BIOS doesn't relocate/lock the SMRAM.

(If KVM doesn't support SMM, the VM will probably crash anyway with no way =
of=20
doing anything about it.

>=20
> Install a trivial RSM handler at the default SMBASE entry point so L1
> can return from SMM.
>=20
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> =C2=A0x86/svm_tests.c | 20 ++++++++++++++++++++
> =C2=A01 file changed, 20 insertions(+)
>=20
> diff --git a/x86/svm_tests.c b/x86/svm_tests.c
> index ccbab1d0..11770854 100644
> --- a/x86/svm_tests.c
> +++ b/x86/svm_tests.c
> @@ -3543,8 +3543,28 @@ static void svm_intr_intercept_mix_smi_guest(struc=
t svm_test *test)
> =C2=A0	report(0, "must not reach here");
> =C2=A0}
> =C2=A0
> +#define SMBASE	0x30000
> +#define SMBASE_ENTRY	(SMBASE + 0x8000)
> +#define RSM_OPCODE	0xaa0f
> +
> +/*
> + * Install a trivial SMI handler that executes RSM at the default SMBASE
> + * entry point. Without this, entering SMM causes an abort.
> + */

I would say that this is a fallback handler for cases when the BIOS didn't
install one.

Something like that:

Install a trivial SMI handler that executes RSM at the default SMBASE to su=
pport
case in which the unit test runs with a BIOS which doesn't support SMM.

In the case of running with a BIOS that does support SMM, this handler=C2=
=A0
won't be called, but there is no harm in that.

This comment is warranted especially since someone might expect this handle=
r
to be always called and add an assert to it, although this won't work for a=
ll
BIOSes that do support SMM.

Another thing that worries me, is that I don't know if 0x30000 area can alr=
eady be occupied
by something else, requiring us to reserve this memory.

Our flat.lds reserves first 4M of memory,
and the physical page allocator starts allocating after 'edata',
so this should be OK:

...
SECTIONS
{
    . =3D 4M + SIZEOF_HEADERS;
    stext =3D .;
    .text : { *(.init) *(.text) *(.text.*) } :text
...
    edata =3D .;
}
...

But maybe a comment that justifies this is also warranted here.


> +static void install_smi_handler(void)
> +{
> +	WRITE_ONCE(*(u16 *)SMBASE_ENTRY, RSM_OPCODE);
> +}
> +
> =C2=A0static void svm_intr_intercept_mix_smi(void)
> =C2=A0{
> +	/*
> +	 * L1 intercepts L2's SMI. It makes L0 deliver the SMI to L1
> +	 * when L1 re-enables GIF via stgi(), so L1 needs an SMI handler
> +	 * to avoid aborting.
> +	 */
> +	install_smi_handler();
> +
> =C2=A0	vmcb_set_intercept(INTERCEPT_SMI);
> =C2=A0	vmcb->control.int_ctl &=3D ~V_INTR_MASKING_MASK;
> =C2=A0	test_set_guest(svm_intr_intercept_mix_smi_guest);

Besides remarks on the comments, this is a very good and simple solution to=
 this problem.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

