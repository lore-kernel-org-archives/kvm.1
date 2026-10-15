Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEE4CE68E
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102803; cv=pass; b=HwwpCBsjTamYjVap9PJaj/9B5YhIsHtqD/99kqANGQkoNTjjHE1GQQsfqhMhoJvY6JXNBBv+1GCmwfakMq/LRVmDzyNW/OHkCQC+u+fc+XhC4FZAj3eEMxOPPX/WjOfBun4zmMRctUT+mWGK7uafjleWDr2ZrAE4pdR4sJ343L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102803; c=relaxed/simple;
	bh=1GkfmmTRxWbu/MUtgXkR/+YBy+TL6aN5OmAB8cTrNrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTOEVz8Z3/obS1a3px6bmQBcvZIu1j9w2ViRSHi17sIR39D2DPuUfk3/c9EDKeVQ7DNvDLwL9ufHc3XAZ/Fmt+d97mc5mPZLwtW6ai8yN0mX5uc0mv6l/C0thKlnZyS8LtuTil92Pz/AYHT3IlbvU4SZHhOyuVKO8AARMGGgXWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kV6R6a9F; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kV6R6a9F"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533202fe429so118421cf.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792102801; cv=none;
        d=google.com; s=arc-20260327;
        b=lZiuKMzAFwx0rkSnzya56g8Axaj+hzgOCvAmLcqQG3X7uywuXoDZK6Hdv08Ta9ygFC
         kyIrdHoAGmyvDN0rdk6sq2gC/qGKxd13YTkSBiHQ1m8Ljd9QCae3nyJlRtWfIu3wfhNA
         VRpyX7Yw88b+H6lLmXzLP1C5XBGGyz1PIrjxrL8L1WRM2egdzzkUawjxtaJnlazbYxQR
         d7pVfhw8e474bvxQ5iQApORLu5fzOIqD0npb2acBrmX8E7V2V2W2BEaLM/hBGDqJ5/oh
         01XSuXCI39MmIga0wMws7wpko+ew8LtI1L05ULxuUkyzlOFA+OUOXNh3b3qzzW9DTBJN
         eyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=szmjy0cblE8XnXn4Fw1g4VyNcoow3dCxiKswAyvRGYg=;
        fh=IN4X/tiTv+ijo4RUOluQuSJyh8wu2x875Zh3VUtigSg=;
        b=fUJDVH++DjNybUC5b99owu976MQHe32nLcl+6hrFTEeCHtZmLbbfrkIhj3NsUmYRBJ
         btB6tEO0CtZ1k/sZYPadOoSbCKO9dSQOPn/zpQSITvvwXQcFRrB99t/0MxpPNjrHAFCc
         sjfCTAZYC0NWkheIMeE20U7Gk0SmK8qICN+oeElOkHZXr9zj06BeJ0TLRwOJ1pK6V5qb
         8oOVSOkZ5uQXwwO9pyFT/q0NJeZEcJ0Y8uWZZt8oOPWODZNVurDsZmuEPo7/Xq56XF9u
         0LaCYEpSR2aHlKdYQyOrxG8FSYn4QjCguFdq/7Yb8SvdRxWKy/c9XOBeWc5j3Vvpcpfo
         wDTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792102801; x=1792707601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=szmjy0cblE8XnXn4Fw1g4VyNcoow3dCxiKswAyvRGYg=;
        b=kV6R6a9F8W5UHaSlBLbrUXvBx70yCuuGkIGqzVtSMC8/p1oTPtAme1glPLaATs+c4m
         bpwAlu9ZvjD3hNGqQO/21GbGQmBSQeClhrtfNl/RrKkmO3m1LImzJXjvBokBH48RU835
         2gG2jwL449kkBvH/rMRpKsLLI6P51Ru2dxYzR7DHYfNtmcQ5d7IvzZqS6s5Kl6XmqCU2
         6i3fYBEXmy+IwNIP4dimhjlGjLDyvFPi2srAslJ3dYtRrCQqQCUT+S02BXILS5ur6WZH
         3DBYUEp/YJhoVIhm8LhGBardC+55FBFW4kHscv6nO7bZtxSBX2YwN/RfY39iK9UH0zYR
         hpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792102801; x=1792707601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szmjy0cblE8XnXn4Fw1g4VyNcoow3dCxiKswAyvRGYg=;
        b=VUiJd0BsfK7IZQtjQPhy++XkJX2zyInOAZqiOG6p5bGYhBoyoCrsmks+UXIWflQKAy
         Yfh0oYf0HiovbjjLzVnA0GefMfHCOknzL0U7l9LaX0W+y6IbNetUcMXOhb76hlAIlT1Y
         320d2tO9uaQCFyOkDSqfXwHKJIV/F4EsEcv7ePaAtAX9taYBdkdh2N3oAW9qUWlEU0Pf
         ODkEFTEmmZK643Wbb5LZzIEHERBlqnrDjDoIf/PTD1TkxfMMjy/nMeL/5FpWmAL22B5S
         vX3jippEP/0V4fBmZiZJiXdSuPCFVqVbTgvG2MFl/kL6hcS7Nw40Kjq7enLjayNm3Y5m
         TVbg==
X-Forwarded-Encrypted: i=1; AKwUvBxJo1Tb7Yhc+ZGlHnmSw8q2+WQIKLjiTQpg8Idk61zIVV77HA8fVAlPKirWTkX6epHlBE4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwh8KcXkXcFeiFn6Sk3vPNcW5dEKaRkvGb8C/LTosz1v9/ZnGM
	IOrbCXfYiAfyLqkv4c+mkF14GHI6o4RT4FUEf9cCtDjutb5TaTs09akMtKZQ6h1cW4pd70Ie2dW
	Uu8VjgIYgw3C3hwjli5Ol44ifsEKxdXvw21UVjznW9w7EQXfr2S9bpasbUHk=
X-Gm-Gg: AYBFou1tLwCDrqCcjHl4PMYGgoThgO+T9P8DvnlgmemBCeUs5jUx7BozLfbTgAaG013
	Lgmmaxfs10n03jM4v/S1Hh34dvTT4tf9nPtnCxpHIKHbfhFt57DGe5OKjETjHuxLsTiG8vzCmIU
	eyAn6ggKHrMjH5UCSqXZdw82semBhE0u2ye38WE8bROMhADUWHiJw+gUa6hb2Tgfid2pS3DlJVt
	C/JhkhcYg0gTVVxsEfi91YGOqrocis2PWGqFihKVmDPd6jV2AU20VKuunMMjEjyKeEovdAB1gY/
	Kvmt9IsBORnaAGElit0zF1njW4EQz5MWVQBTVsUzoq8beoZMJc1A9LU=
X-Received: by 2002:a05:622a:c05:b0:536:d46:ffa7 with SMTP id
 d75a77b69052e-5362b40f017mr3315281cf.12.1792102800408; Thu, 15 Oct 2026
 15:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-20-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-20-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 15:19:47 -0700
X-Gm-Features: AclHuK9pn6iw2-XSdhvtKYxB1Jis-OaHm0rG-azDJVuUxSdzBjHfIalhoskrHxY
Message-ID: <CALMp9eRd3COQijFU8AdcJKo+usr4A7dC6GOYT3YS93UBZ0yHRA@mail.gmail.com>
Subject: Re: [PATCH v3 19/27] KVM: nSVM: Service local TLB flushes before
 nested transitions
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Service pending TLB flushes for a specific context (L1 vs. L2) before
> entering/leaving guest mode, as KVM does not track TLB flush requests
> for L1 vs. L2. This is not currently required as KVM always flushes the
> TLB on nested transitions, but it is a requirement to drop the
> unconditional flushes.
>
> TLB flushes are performed through the VMCB's TLB_CONTROL field, so
> service the flushes before every VMCB switch (except the precautionary
> switch in svm_free_nested()). Servicing flushes may end up purging the
> relevant HV TLB flush FIFO, which is based on guest_mode, so make sure
> local TLB flushes are handled before calling {enter/leave}_guest_mode().
>
> This is conceptually similar to how nVMX calls
> kvm_service_local_tlb_flush_requests(), except that the VMX calls only
> have ordering requirements on {enter/leave}_guest_mode(), and not
> switching the VMCS, because VPID used for TLB flushes depends on
> guest_mode, and flushes are not VMCS-based.
>
> Note that nested_svm_{entry/exit}_tlb_flush() must be called after
> kvm_service_local_tlb_flush_requests(), otherwise the TLB flushes will
> be immediately applied on the outgoing VMCB rather than the incoming
> one.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

[ ... ]

> @@ -1549,6 +1567,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
>                 vcpu->arch.nested_run_pending =3D 0;
>                 svm->nested.vmcb12_gpa =3D INVALID_GPA;
>
> +               nested_svm_service_local_tlb_flushes(vcpu);
> +

When called from svm_vcpu_free() during teardown,
kvm_service_local_tlb_flush_requests() will be called for a vCPU that
is being destroyed--and isn't loaded. By that point, the MMU has
already been unloaded. Is that safe?
