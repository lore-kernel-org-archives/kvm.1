Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795041565;
	b=455szzW1e9Uw0LL+Ufkhza6msXNzxJXXWZhGJkGw9Ztt7SXbBPjeFClwoakQvFPM/8Xr
	 B1vCslCwSzwD3gTgP809kVJazK0xHZrB1kZWdLlseBu/IBVc9XBdrCuqt1lYerJY5DM4h
	 e64ixjmd8z9m1+Z9WDOXPlKOwLBznL9RKO6qzPbGl6kNv1qdxeqMNunKkvS0yoTxMJ37v
	 gewtcph/axlpIZtZfoEcUZS8cYo2Y2QyWenTC22+0aVfJXcdqDLoC0+tiIQlqUu+xnSzx
	 SZzpg2umcloE7QuIcYDUp9dN6HF3z+n0D3zhyiSmRW4+WtwlBpz9Gth5hifk5ah7PCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6Cqoa4dXqZaAiS8aE3G3lsewapMXlB21+rBhXzkkWJw=;
	b=GIfGr+C2YV4Xp2vdpgMV/WBo8d1FsLOK20gYdSKOVqia9VeXJFY3EQ+fY47cd7MzGe+f
	 Os6BRnXYmnAmKTU6jiMHd2qm/DDx7WiejtIm99PHF0Lfsg/nXo/ecB+oxuZMnOmMR+1ZX
	 hdjMnUjU42aKKFAhhILb/8qLZLUfx4QNNyuJh83wQ7kH2CFv3PA+J0/EIc1vdrL4whds1
	 kE1jvdRFpKLavnXUGQl0U4EFsrqAoWiapbP0StEBut4N1o0DcALg/b3fgLd8WXpCqivpt
	 XhgnBRVEBmPMjeml8GWbiYz4tzKXySmfEca0fmRy2Ncvfau9Cm1QEB7bS1NIYaQSzWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lz1EDrTy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B9606B615
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 22:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675B9606B615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lz1EDrTy
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so5517a12.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 14:39:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795041563; cv=none;
        d=google.com; s=arc-20260327;
        b=iIedShw7geZojf/raUdUw/OQT7IShdYFQwcyFMuKSL3ox0Le20JNe4IEFHRh5ri2yW
         v92kSMkOTVYD2MELGl2N2yCzlh2AOjfgPGqcWpVwy/Xr7l+yHAfjkkYiN5ysOK7bt+Q0
         YGv2V4VbkTtmpXMUVCj4z7UsU9SEkFBhDkIJWPBzmpxNGB1dxJ4Rk71g0uUTq6N4c9V0
         6cJvAsuyikTuVLpBuliGPzkljMB7pesM29xNBVcv27lqtHW6KkFq7la+j/EVeLLXe9Qp
         7t9JZdvg7DwHMqICLGEAsgrcBwImTLAwm5MeuQKTlTStDhWiDEneOFxTCVecKAeiSsud
         h3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Cqoa4dXqZaAiS8aE3G3lsewapMXlB21+rBhXzkkWJw=;
        fh=UTttTVqtgVoF2T2bCWdp1w8WlI0HD9lj0tDVUbIELNQ=;
        b=Q2KidqPeH7SnMqCqBkZhfEm/Mld4I1APvmUV353gXpGToXCRfC0thzrWCHfyp8c7qc
         WZhonzsOO2aJuOovBA13ovlf9U5qVQEQAaYCL2gFneHfIT24iBXxr9kUneiGEcxwQyik
         eTgmDNYXA2WnUDnAHiB41Vf07jqQv2vBK6s1mEb9evIKJCsPk+nEWmtLCsoX11CHJPno
         MGeqeo0YVHkkQNr1vjbAL/NWTk0VzoLKnFVAjI1M9ua4SfQO32gf4hIIgdn+EjD9RePY
         vguKb3NdCViqt2sEQfHA0q4ELItgCKD15aUYSQuQs3mebNXqQlLHCymJFFyOYI2Ch8MN
         gE7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041563; x=1795646363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Cqoa4dXqZaAiS8aE3G3lsewapMXlB21+rBhXzkkWJw=;
        b=lz1EDrTyj31KliJAr+PKfNyfjGnRXeaanIf/XEWQ+VBkdKslFrXPb5W5vzYRB0SGOs
         0hNna0LZ9+AT7BqrU/qf+Z7tVEHupXiVqKQXfrO9Q4VT3KTtaDNT5/ca7SQG+KE/TLPo
         IHwuyxZdbruhaCoBwa5zCMh8I2KrUy1wJg3f/FKE9VyUD/a28wpK1T4NsLGTuRqZYGDK
         Nwq/3MqIIRtdG7EUVqwyLgDKjuQQJV/agqJOb4YgoZMRdpzEGjIaSMHdI90v4q5FQ+Sv
         Hge7975rEq74XfHxH9g36sERI07lpLv5nw+phw79GVP4M4vuKF/xyxdMBRe5CKiKfHIU
         FCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041563; x=1795646363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Cqoa4dXqZaAiS8aE3G3lsewapMXlB21+rBhXzkkWJw=;
        b=jTq+2s+PLR1KUeyAXD6BaylnrVqqkQAeFgSlg2PwkI1igyPQkh5GuJSW3lYhSgv8Vz
         5AzKqDgDYiISUrK/hBANP5gJn4AhaDN4eZ6JMm9rhm/Ne0tzzn/mxGlSWKw7Cm7PV5Th
         m8Rn7whmNJSOJFKh7ciJT018if3wwLZsYIvrB0SQDlOs3LXgqxy1aBay5XJAG6YduOrI
         iu8fd7N8+4VZgyV3ftOjMjmZzx/bnLYbxBxSSXwp1i4uwQrNun9ib2TKUe5eZo3/oOYR
         do6ZFd6Yq2Q5tLQZcQk8AS3Jm+dOyibt5CYrTBIC9apd1ZQQEGOiP8jxwnn7jCqti+PQ
         6y2g==
X-Forwarded-Encrypted: i=1; AL+hErEOuC2cW/N71PmmMYHh31COnkHbhBaOYREY2rFnrRGckIGaLnQj4Qru1PlF11oI18S8PPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OBQcG1nvZ7mzW1vOPSSGEkm8KUJiKg3ZuC2nKGqvlyFGGd7Dp
	HyW3Zrf5wcHzI+CpwwCZ7uXDBGrZd8solMLgoDeVuC+eW0TzqwvkcxASdC9XDEtdVF9wFKvoymJ
	Ue5PRf5gVRdOJW3YlaJzws//f7gcwnkNdWsjZUQ5Jcf7jrpCDZzHCWfGb1zs=
X-Gm-Gg: AYBFou0s4xd/0X3OSfx2feDkzPCGSQuKFnsV65NmitcQQI50XRG++vML+aJRl4cfCiJ
	2A5Hx24Dqm0hNgdCtliSvWp+ZOXtukLugai78QSyQYwx/aaeOwt9ZHZlNzVJc7irplfemLCS5DK
	kjKHgDgtFCZmwBlSXiWl2pkADFrKLT+jzW3ua/2+fbaPvzMdtCdMd9yE6kxuiWPEH1C0bniN367
	EMJRLdQeZg6ALyAHto7hBLCsbtBYhbCFXk7yjNssFDBLV7JlWmCVxerbJyQeY+1Me7VOReFc6Tx
	NO5M+BD9Ch27XjFXSWbZRm7zc4I26ka6072mOZDvREjm/u39H5whBjp6XAOd+fRmpuRGnpSIDdO
	mnM+o7OhsAekCT9NVF9kPWbXM8CoKIOU4AopWqoMzlrRZGiHcCiwIejs2x+U6+ea3/xhjGUhdG7
	NEVKllYGyRTNX9QK79TOdCGsl3w8Ou+vrqcsROVY+VEfma3ucZ+SINig==
X-Received: by 2002:a05:6402:446:b0:6b9:de8f:cb86 with SMTP id
 4fb4d7f45d1cf-6ba11bd2370mr12316a12.16.1795041562272; Wed, 18 Nov 2026
 14:39:22 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-5-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-5-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 18 Nov 2026 14:39:10 -0800
X-Gm-Features: AclHuK_mZOQNLAW_jVpbBx4gG_MzABTDZgOD2t-o1slK_xleWXPR03CJnChaVWc
Message-ID: <CALMp9eQABxnk2EV64xXXeH+V03LWrnK8qWOcWcDeX3tiY_N3zQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/20] KVM: x86: Support APX state for XSAVE ABI
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:31=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> Introduce a facility to copy APX state between the VCPU cache and the
> userspace buffer as the VCPU cache is the single source of truth.
>
> The existing fpstate copy functions historically sync all XSTATEs in
> between userspace and kernel buffers [1]. In this regard, any additional
> state handling logic should be consistent with them -- i.e. validation of
> XSTATE_BV against the supported XCR0 mask.
>
> Now the two copy paths requires to take care of these facts:

 s/requires to take care of/must account for/

>
>   * When exporting to userspace, copy fpstate first, since it zeros the
>     area of any component that is absent or inactive. Then copy the APX
>     state from the VCPU cache.
>
>   * When importing from userspace, the APX state is copied to both
>     fpstate and the VCPU cache. Avoiding the duplicate copy would need
>     special care in the common code or in XSTATE_BV/XCR0 which isn't
>     worth that much for a slow path, so keep it simple.
>
> [1] Except for PKRU state, as stored in struct thread_struct.
>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> V8 -> V9:
>  * Fix XSTATE_BV[APX]=3D0 behavior (Jim Mattson)
>  * On the way to the kernel buffer, switch the copy ordering (Jim Mattson=
)
> ---

[ ... ]

> +#ifdef CONFIG_KVM_APX
> +static void kvm_copy_vcpu_regs_to_uabi(struct kvm_vcpu *vcpu, void *buf,=
 u64 supported_xcr0)
> +{
> +       union fpregs_state *xstate =3D (union fpregs_state *)buf;
> +
> +       BUILD_BUG_ON(NR_VCPU_GENERAL_PURPOSE_REGS <=3D VCPU_REGS_R31);
> +
> +       if (!(supported_xcr0 & XFEATURE_MASK_APX))
> +               return;

Now that this is called only after fpu_copy_uabi_to_guest_fpstate()
succeeds, this condition cannot be true. fpu_copy_uabi_to_guest_fpstate()
has already rejected any XSTATE_BV bits that aren't in
kvm_caps.supported_xcr0. (That was the second half of my comment on v8.)

[ ... ]

> +       /*
> +        * The APX state was also copied into fpstate above, but the VCPU=
 cache
> +        * is the single source of truth. Skipping the redundant copy ten=
ds to
> +        * introduce special-case handling. Since this lies in a slow pat=
h, keep
> +        * the implementation simple.
> +        */

With vcpu->arch.regs[] being the single source of truth, how hard would it
be to keep the APX state out of guest_fpu altogether? It seems like that
would be cleaner.
