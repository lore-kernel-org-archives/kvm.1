Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793287069;
	b=tOxuPth/C8TjYQgwmJn0w0lfngv3DoPuvxnW72CDmFwIEEg8YajyGpkrrcqF1kOs32D9
	 ShzN/eSfZmiRSEuaGg5XYuFx2elilKot2iVIGmQwaYe04ZiEcb5gWGhC0j+JVKn+5CeZd
	 DDkX+Ui7iaeIfAp7OCSQpp8WIl64q2j1l8rgp3OnhvkHJDEB8pSBQyuarmaea0wfN/4fT
	 vwkjBco8nFmuAcnwsqZp9P2uDoxRqT/G5V+FN3i4NXayv7rKkDvO4BYlawWoXDRATAiG6
	 FXqhoX6nm+wEmVtIlqAEO6Vz7RRl/5/5vTUGaRrPwf15hWorlggNz6BsZ98Lym/mEbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AbTJQnBlN+pvqKG1klAFs8PHaT7iP4av50nNUNBWkKw=;
	b=RfCIs0QdaKTefJzWC4d4CQLdfTFE7pw+BBB1c+U4XTL8bZXYtgbrH6oZBF8X0r99GsVe
	 IED4WTvyRCfy41ObDtGJCiJmNUwLk4FKFTbGZcz4SnJCIh1IW5M1toriBt4bQsBvvO8hl
	 FG79xCWUcr08peZXtEco0lGMV6Bs+cw99VDB86HtVm2HbozQ+HXl+G6GlLE8r+SWlj7uI
	 B/gHt+FroSQa5o3NpY/CdNfuFpKtUEUoRC2i+BWKzNiOTDotPgSsg9n2iHMCqHtxozSB+
	 0rUU8WZY6z7DSb6+k218lZYHnrTPuwZAH8aLAhK7Z/DtE4P3iufqOGFjIAsrivH5T4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pdkgTWm7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76523606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76523606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pdkgTWm7
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso11522a12.1
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 08:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793287067; cv=none;
        d=google.com; s=arc-20260327;
        b=r7arltXljTf2PLAsVeO+I09HJl6Wwoaiqro/ZfYRaWcn3wKA4Tavk+LvtERoHTue53
         cuINgJJSWfCLCx5SulRqFEo/IXPu5gmyPWoLhpeMEbC1qEfpi9M2WtebAnFpqXWHXs7c
         ee5WZ+feF3AUM/gGxhjNTX/hWwIDiMPcTg8BgEWk81fxdC+w8YEO9YXhzwTRT96eK3T/
         3pNNh/qBxRYSADyZaq3lWeTsFqfrhx942AIK5IUa2rbENZ6aVvrn/bhupoSUpPhSdNdY
         H6JDTCq7hzbVP9BYzVqFRr2sKc996RfsyPav3wAddi/5uTwkCidNKO8kioQzofEt0MFs
         mLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AbTJQnBlN+pvqKG1klAFs8PHaT7iP4av50nNUNBWkKw=;
        fh=xrvlYIkJmb2v0Pl6FN4mYz3xY+EPChQpx/RIsm5embA=;
        b=Io9hU+dx+KnHEf637W4kv813G4peLaEDLbYnhPObf+9XRGcAW0wDaCLIGETDcwu/XH
         L39NtYC1fbjLr2+PP6QnVjX1W1FQRUYR0nf1yE/PJmkysWrskM2PLH+QjOPHrO3Dpd3J
         VWK3b2//6bkJfoHrGatZFEfEDXTtdHyci8VoOsJwLSllL4NpdgbUmQnyKu6IqYpy88ul
         pTromA2LKYxUpmi/30R+NA+kEvAMSB+Pe+b5Hh1K4yv5KeGJGgiElDf00QQq5L/jksRL
         mYBFWa0wfPtHGE4lB0C7tgE7Wm5zlbX6JdhI5L/ZULQW7O00H84AypYlfkZRxwrv5JTy
         TL8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793287067; x=1793891867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AbTJQnBlN+pvqKG1klAFs8PHaT7iP4av50nNUNBWkKw=;
        b=pdkgTWm7tofy1O2oXfWkE6Y6P9fz0F3R+LY9mPxymq4mh3t9QTc+C85u42unFHOkgP
         1nJrysrqvWDmImETri83vopaH2eAaWAYDmkD662fqjMriP6igDBB66tnFswHkOj2kSUp
         FmEB2l9BSB7fnGylR03Isbbpa3HbHG+d2gNFBDI2XQohDomQ6XrQs2xeD9DyzMQNb77y
         tE6QK85CCp8SCPmCFShGCgVxR+e4dJvt6fR4p2+IJbn0OYwnq8bDxo2t3iIoyIO7WmfF
         WSXcFRJHq61aV0GkPrzwKaRcQNMRjzj0bkfjZ1EP5v0Xfuc3UOGd+owErnAT8Qlhkwr9
         FfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287067; x=1793891867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AbTJQnBlN+pvqKG1klAFs8PHaT7iP4av50nNUNBWkKw=;
        b=Qqp8SPGzBTqU3+4boCQ2sxRkAAid+RvZE5tYKhyMLZHrwnfuFeM4EfLdleifzF5TCN
         3/xwAy7ttnhYlvBI0jSdnyPSY2stwdU4PXPjrC0eWjmJn4pVzByBNgptPOKZSWuBmp3Q
         RfR2WekgSjV0YNsk2iKllmmlgQedCUAlZz8lSa3rdSgbCP7d7D3x1p3+8uVqNKSchwcT
         litzW/0uM1984hYiYBb4wP4wOaskOXCQeftnQcTVan0HemUDOgPpZWdCBsrwHk94qRaB
         hNlAUswgTOt+azi8FgrfwhBHcS90x2clKXFZCWANIzaIwD7M+kUNDC9UDIiGmhNT+jgg
         2Sjg==
X-Forwarded-Encrypted: i=1; AKwUvByK9vcUQORczHNiIgB6mxpNREc34IasI1GHeuoedx76iwRVB74r+aZxX47bgjYY6D5+GOs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJU/OX1Wz1QhVkvn0eZes/VQ8wuv1Z6gdP7DjLgcdHLhp2LK7Xi
	8wUrFbVM1aRzi6Ao2sr7rm9ZppfKXIuHASPssU5pmj4NiUB5tDIlsZMmfDuC7IbMm1KZJWYQJke
	uZ0ZU3sUg0+4yntb55JyqBdQF1eYxyjBq4zdy8/HG3oyVDUNwu+7NxfUNMhI=
X-Gm-Gg: AYBFou0oIXpMc0/OVPLuWSM6sSb3CQC9UUzXSRh2n3bEixcDCVcAwH69DdB4yBwtSRM
	/YrYieFAq5JyaE9zLFmPG3tpMpzYxWp9rjS86d4Tz98NLJ45JlYqRWhC+kXK71AvNeesKQkTw+o
	UQliGiw+nKGNWbYy6hyOukXC+wrJmLX1Ln0pP45tSb0TnM2ZqlmXibhHwHY9MOiiNVyVGkxsoxt
	4Z0c6oI/N+QbiyIfReW7CB9rM38MLiO3Qllkg8lQwcjXzoo8ia+wCW5f2DcLgpHn4CeyNc2RRc7
	JJcl2eK4CWkmXmIvYq8AFjJ3s7wnXe+3OoN1dBjspNGn9JTQj9DxnwRq1QH8YcXpbpbnTy0APk5
	26RsuMmkXnHEgWbiRsdzEM1EBQ3lSFjErE6xA
X-Received: by 2002:a05:6402:305b:20b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b4b38e71bamr62668a12.9.1793287066191; Thu, 29 Oct 2026
 08:17:46 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029024005.575065-1-chengkev@google.com>
In-Reply-To: <20261029024005.575065-1-chengkev@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 29 Oct 2026 08:17:34 -0700
X-Gm-Features: AclHuK-ibUT22cMMhhMbZ12t_iaUe3kZdk_OoF1b8jtJuWxJeYHY-_Y434LwOJ8
Message-ID: <CALMp9eSvG5Kfur_3JfmrBjwAGi0+oJqCnFk4LqADCJfeh+0k6g@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Synthesize advanced VM-Exit info for emulated
 EPT Violations
To: Kevin Cheng <chengkev@google.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:40=E2=80=AFPM Kevin Cheng <chengkev@google.com> w=
rote:
>
> When synthesizing an EPT Violation to inject into L1 in response to a
> fault detected while emulating an L2 GVA access, populate bits 11:9 of
> EXIT_QUALIFICATION, i.e. the "advanced VM-Exit information", with the U/S=
,
> R/W, and X/NX attributes of the L2 linear address' translation.
>
> KVM has advertised VMX_EPT_ADVANCED_VMEXIT_INFO_BIT to L1 since
> commit a0efd8cb221f ("KVM: nVMX: pass advanced EPT violation vmexit info
> to guest"), but has never correctly populated bits 11:9 for synthesized
> faults.  Originally the bits were pulled from vmcs02.EXIT_QUALIFICATION,
> which is stale and/or holds unrelated data when the fault didn't come
> from an EPT Violation VM-Exit.  Commit 96b067b59ad9 ("KVM: VMX:
> Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits")
> correctly stopped consuming the stale vmcs02 data for synthesized faults,
> but nothing in the synthesized path sets bits 11:9, and so L1 now always
> observes a supervisor, read-only, executable translation for every
> synthesized EPT Violation.  Per the SDM, bits 11:9 are valid whenever
> bits 7 and 8 (GVA_IS_VALID and GVA_TRANSLATED) are set and advanced
> VM-Exit information is supported.
>
> Fill in the bits from vmx_translate_nested_gpa(), which already receives
> the effective L2 pte_access (for MBEC), rather than from the EPT walker
> in paging_tmpl.h: the L2 page attributes are not EPT properties and so
> are not visible to the EPT walker, and the nonpaging L2 case (CR0.PG=3D0,
> where every linear address is architecturally user-mode, writable, and
> executable) is handled for free as nonpaging_gva_to_gpa() passes ACC_ALL.
>
> Skip the synthesis for EPT Misconfigs, as the walker doesn't initialize
> exit_qualification for misconfigs and the injection path ignores it, and
> leave bits 11:9 clear when GVA_TRANSLATED is clear, as the bits are
> architecturally undefined in that case.
>
> Explicitly strip bits 11:9 from the synthesized fault's exit qualificatio=
n
> in nested_ept_inject_page_fault() when L1 isn't advertised advanced
> VM-Exit information. Previously that was implicitly guaranteed because
> nothing set the bits in the synthesized fault, but now that
> vmx_translate_nested_gpa() does, relying on the bits being outside the
> "take from the fault" mask would leak them to L1.
>
> Fixes: a0efd8cb221f ("KVM: nVMX: pass advanced EPT violation vmexit info =
to guest")
> Signed-off-by: Kevin Cheng <chengkev@google.com>
> Assisted-by: LLM
> ---
> Tested on hardware with advanced VM-Exit information support by running
> the vmx kvm-unit-tests, including a new ept_access_test_adv_info test
> (will be sent separately) that exercises bits 11:9 for both native
> accesses, where the bits are propagated from vmcs02, and emulated accesse=
s
> (string I/O), where KVM must synthesize the bits.  The emulated cases fai=
l
> without this patch and pass with it.

Doesn't this break tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
on hardware that supports VMX_EPT_ADVANCED_VMEXIT_INFO_BIT?

In that test, l2_test_page is mapped writable in L2's page tables via
vm_alloc(), and l1_vmx_code() asserts exact equality on EXIT_QUALIFICATION
without expecting EPT_VIOLATION_GVA_WRITABLE in TEST_FINAL_PAGE_UNMAPPED
and TEST_FINAL_PAGE_WRITE_PROTECTED.

Also, rather than only adding a test to kvm-unit-tests, please update and
extend nested_tdp_fault_test.c to cover the advanced VM-Exit information
bits.

[ ... ]

> -                       exit_qualification =3D fault->exit_qualification =
& ~mask;
> +                       /*
> +                        * Always drop the advanced VM-Exit information b=
its from
> +                        * the synthesized fault, as they are undefined u=
nless L1
> +                        * is advertised support, in which case they'll b=
e filled
> +                        * in below from the appropriate source.
> +                        */
> +                       exit_qualification =3D fault->exit_qualification =
& ~(mask | adv_info);

Why set these bits in vmx_translate_nested_gpa() when
VMX_EPT_ADVANCED_VMEXIT_INFO_BIT isn't set in vmx->nested.msrs.ept_caps,
only to strip them out here?

If you gate the synthesis in vmx_translate_nested_gpa() on
VMX_EPT_ADVANCED_VMEXIT_INFO_BIT, then nested_ept_inject_page_fault()
doesn't need to be touched at all (or better yet, the mask dance in
nested_ept_inject_page_fault() can be confined to the 'if (from_hardware)'
block.
