Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943078;
	b=nMdVTkQWfmjkTlYlNUBQpo/3Rk/3taopnsncdz9Tic1eaBxSsDgb7IMppaZTdJxs5HEP
	 FHYEOQQ4pT4fq6+NRpgE67fHZHHJIQzyEpQnmPSODUXE0w78avwI/aGWPH12diy8oso/f
	 B5pDX9N6uhi/uTLHzOltmCUgQDsbgpt/lnWCE8up6wNUmlfWvj/czlyqjd5ulVQH11NHk
	 0KoGjTIVpaB88X2AD40dMZiK+Tn48Xoe+ZI8rhhF66j/zIzGvq6aQfOF1QitpzqhWOQKw
	 ioD3NABClVu3D5JfNl0pMdB+tbWj0A8D88rrd59rN39Xbl08bNsGX/P2pCnbwWmubmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fzfTGzPrNRGAcFjD94LRWoBBCVsFTkInc3NXv4RHT6Q=;
	b=SqZ6kYOUZqB3ELwZcy6DPUVZerFUF2QIQ62MYjwGlHqaECaeaZQKNP4YZYZAsGrY5r7z
	 84ZOQoJ4ky1kxTOUIVw26XQdoA2D27cqdfDZsnsFxMVMUe6JH3CXyTH9OCQOcML42Ss1S
	 icwc685dCdLacM1EEJ/Uy+ngEET1GZcYA350fVEdLYq54xA+zd73bkKmPNRfDKRRiAz02
	 WF/yT0/LGBOWPH33tnB4YLaXO3DvDVy+SZ9Mb6L1oN28RHIpjzNUM3mza+zyZX4PVGW1N
	 22YcKARaT223g/kzJJr2sPleAzVclIj9PuVs2MNLVE2plW1y9XGPXYWEfj717psqIzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nOHyOW4e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AD606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 05:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C0AD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nOHyOW4e
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso2076a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 21:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793943076; cv=none;
        d=google.com; s=arc-20260327;
        b=EhOns2CPnP56qZQ1bw56lI4AevacEfGhZMRjYIYGDyHFDUSFC6bZ0Jq13OKwZkoWu6
         8819vXsbNz3tujpMkSLG5R6mfbDT9QOobm/xGJ+M9sxDIIlcJpLye6yv9hcNbxArpBmw
         BOa/mF3qTUgAXYd2iiCnpvRrsIBSLx+iwpglDRdpwXZyyyqabtqTyVVjXkwElb/smRAV
         MxIFJrCFFNKLsPhjeoF0kdocjlMIP/KNTytq/op08K+ji64Sfl3b+tVxa4cGqb9DJBUs
         e3kEpf4RcouGYsx1EWfP6Uo9d4lgPaoOo33WPRg/oHPikMXwrGD0gnreTYA5wLOFk5wc
         OQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fzfTGzPrNRGAcFjD94LRWoBBCVsFTkInc3NXv4RHT6Q=;
        fh=5I++Y2uPpeTCltAsA7fvVLinuAe3YsC+gmd5ZOpT1hk=;
        b=EBsh8c1IxFyQ3td5ERcZPMloodxslTOVpygzocmgvuXAd7xDrmxtPadU1ClrdgZAIJ
         qiyqz42MKj8M2s5w4N89uo04080HSzQ8gUWUA4yPK+/jdKBrHRAN0g+YSb/fAjDfhOHk
         eMqN3b19yQN4ZghRiK3i7EYSU7lIgqYxCu59xxrxtwl3roIr9IPg0CCKl2bsdKOxmnoP
         UI/vUSJKpB/751/gIxGk+zaqw2nCkfZP6Fqbpas+WSNd3o6fui6YKehPQofP9v6jccfy
         g50iFQn3U3qNd9GX+uneb/6ToK3acl+yyaLnn5c+umjqvw5S0te1d3JwOFKs6JE7a9f0
         LB7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793943076; x=1794547876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fzfTGzPrNRGAcFjD94LRWoBBCVsFTkInc3NXv4RHT6Q=;
        b=nOHyOW4eilzQUjweHtdZoqa3L4evOLihPWeJ/jbooTuK+9eiqIKicgfHFFIrUF/SwJ
         puPhEAgDcUnUjyVN6CddjQ/H++Obuu321SDUJ/Qg6IF0FwrSdLypyfbgjRmCC+QiUw6F
         LT0p98eRjdBwN1r0nfIuv2DlFv0yJ1Kxd5UoQLiy4hshmRNuq+C+xEZyn2ZB/aquQRFl
         rZaJikW+I8igR7sx5rpY3et1FapVm9bEiaI6dMFtZHOL1qp6Z2xM1oDrLFgiRR7qbR9v
         VB4dPScpf8HEqamt0sBhEAKobNzqKE29RFIZ/D289J4UsA5HZAAeLuuR4BOSKofm7TjN
         pbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793943076; x=1794547876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzfTGzPrNRGAcFjD94LRWoBBCVsFTkInc3NXv4RHT6Q=;
        b=dflN20Svbc6+ewF+DNRXb+SOvx+DVx0psPzcJImPJeIe1gRpTI34DzszDkCLKLVr4p
         FyfNrmbR93+XaBnuOHkD7xGWDPhY/mjdJ3zdmpQpXp/iX1fKmfoElt6DBr5VbJprOu6G
         o6xt6UKJzUL01bkrgmmTE85dhIX0qOCeuK3zty3pJLlasyiYiq9I/dMF3GsWuCQ8sKkS
         YxQHnXCr10ITKY6uAUOaXIN8QhrH9cvGBrAW7ZQq9bO+oIaNC5Sx3sb6SF3Y/LI072Ui
         TRcgfK1VuC2wZr+Hn5m7fUKQu9yLduEQHqxIhIiJ4FGu6kX2khtlScf0cHbdrRhWKf9S
         zuHA==
X-Forwarded-Encrypted: i=1; AKwUvBxaF07BP/Hi6JUk7/8ZiNNWzmpv8uByj33OM1ujdA8WMxpBuZktGlB8KTajGDrvlm3kf6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/XZ6EQqmcjMxUQc7Ji7UGVgKgjd/Bv3Fv6ONZ4g8yNavi+gbT
	ipvD8SvBx5mNsdQ11BU7SHZSQCm+HLdjwM6+3bhrHXI+ZAMlX8S4WaNM30DonCugTuIKbkuAh66
	saF20Bg0WO+bQVwmlQMXsYWEfTOT1wkrd83zAxBQF
X-Gm-Gg: AYBFou1uj7NvpgYlh1zxOkI/r8qlfQkp08BsE7RnhV6/yMf0sjqXy5sW1byXiYKLqsu
	ML81mhHvHqNUQNplCvuvhaBHCZX6k0xX4MWFQMFOlW2NsxiPUPedMf47JQO3hH31pvW6z4m+uIK
	DyCSatakZ3bW9GumT2rttd4yOm6oftFZD/svGsE28/mhsm49mc8FlSdyFOZHK4g3kd2wGvrcAmX
	l8JuywdDanm6h4ckhAmjCQR9LofFw2FWTIMteXii15RCRu5IfJrs/i7WKbnYGlJQ/ZvDnvN0XiQ
	CuW+aQSrE2aeDZJMCI96XkBtWxcdQA/eINmySmmrgkmDa5gXTrOUfWw2mYJSmL+c68IzNwNfc8W
	YcHO6AVXkTR3hXHjWJC/ekko/TQ6o95UGU56wBQS2iwb/k6eF4N7GrfkBdVtS9sWPv4ktJi/lL6
	ePK/UXzLbO9f0FqTlU/IvvNugM
X-Received: by 2002:aa7:d14e:0:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b6e7992f9cmr5378a12.14.1793943075854; Thu, 05 Nov 2026
 21:31:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-20-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-20-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 21:31:03 -0800
X-Gm-Features: AclHuK_4ZgaZlELwLWkVgY6tOe7DDAFE30KwSfP5ql7kytff2mRaro17GdlkHwg
Message-ID: <CALMp9eQvzZpcL6fnJcpqV_95S=3ka_xVpBMyhjV6KBsokFrkuQ@mail.gmail.com>
Subject: Re: [PATCH v8 19/20] KVM: x86: selftests: Add APX state and ABI test
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:07=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Test APX-specific behavior and ABI interactions as these are unique
> comparing to other state components:
>
>   * EGPR state is saved on VM entry assembly (unlike other components).
>   * The saved state is retained even if the guest disables APX.
>   * EGPR state is exposed via the XSAVE ABI while not stored in the
>     kernel XSAVE buffer.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/include/x86/processor.h     | 120 +++++++++++
>  tools/testing/selftests/kvm/x86/apx_test.c    | 191 ++++++++++++++++++
>  3 files changed, 312 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 96bab7002d39..2bd5c77047a8 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -166,6 +166,7 @@ TEST_GEN_PROGS_x86 +=3D rseq_test
>  TEST_GEN_PROGS_x86 +=3D steal_time
>  TEST_GEN_PROGS_x86 +=3D system_counter_offset_test
>  TEST_GEN_PROGS_x86 +=3D pre_fault_memory_test
> +TEST_GEN_PROGS_x86 +=3D x86/apx_test

Nit: please group x86/apx_test with the other x86/ tests above (e.g. next
to x86/amx_test), rather than after the common tests.

[ ... ]

> +static inline void xstatebv_set(void *xsave, uint64_t mask)
> +{
> +       *(uint64_t *)(xsave + XSAVE_HDR_OFFSET) |=3D mask;

Nit: u64.

[ ... ]

> +               case UCALL_SYNC: {
> +                       stage =3D uc.args[1];
> +                       vcpu_xsave2_get(vcpu, xsave);
> +                       if (stage =3D=3D USERSPACE_UPDATE) {
> +                               write_xsave_egprs(xsave, stage);
> +                       } else {
> +                               TEST_ASSERT(validate_xsave_egprs(xsave, s=
tage),
> +                                           "EGPR state mismatch in users=
pace XSAVE buffer");
> +                       }
> +                       vcpu_xsave_set(vcpu, xsave);

vcpu_xsave_set() should only be called when stage =3D=3D USERSPACE_UPDATE.
Calling it unconditionally on every UCALL_SYNC overwrites the vCPU's XSAVE
state from userspace during GUEST_UPDATE and GUEST_APXOFF, which defeats
the purpose of verifying that KVM preserves the guest's EGPRs across
VM-exit/VM-entry and across XCR0.APX transitions on its own.

Also, please add a stage where userspace clears XFEATURE_MASK_APX in
XSTATE_BV (while leaving non-zero values in the XSAVE APX payload) and
calls vcpu_xsave_set(), then verifies that R16-R31 have been reset to 0 in
the guest (per patch 3).
