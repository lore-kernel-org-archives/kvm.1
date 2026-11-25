Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642862;
	b=CKdI5MjnmsMoGz7MMFNikfN04WqkXLOIN/dTLGPDYmnMDBibvBLs2MAlHAlSUnjlXciG
	 0aBgTOc+qgIbGory+2rcV6nP0VvvFE5p14tad0BmWaHJQA/n5XuDHEAaQoj9gteZzgPJu
	 kKaaePWE9g8LBwhq0AyLow/GYl/j4JxiOe6qSi2W7N+ncCK7FVqpRBU0Az/WcBEfGWGOc
	 ymHs0Afvs3dTibxXh9FcrTZnX8sOSOLV6zWOJ6g1FXUmELZ5Q7ZNDX4jmLl5tbkdsVMOH
	 71rT6Dyq1iogROO+KglsEF0KFXE/1s8bOEaTEbhhp4rDITNPiS0OxS8kO5jKZQ6co6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642862;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NcWgHvdLtb/0W3sgf0a6rdFoC0yfIF4KP6bkd69RC+g=;
	b=pTtnwkitzE058zLqcjOvrE5sK/vofs6B1LvANQ1KEgLSACJKQQfo3VhKeyP4tOiz+GrW
	 h3pKDTz9U0Me379PShs8JLiox5kbAi57uaRwPbo4Dz1sEzM3xSvsujBUtRJnYlpsxSRiO
	 9U8XD4kPQxsMyfwZC//wgMZw5Zb+EhwXO38uiPJ/lBkU6DIjsEzXMA7Sb3dSCXSXQJ07n
	 J+auWwXCYQT6ce21oUEctzEk2Jtlf9YZWczgAtS+TD1po26TJS03OSaxbUKVbrQmQqwOr
	 yx7t8/J4zgaLVZFW0XiflfKhCkF4QsZZGkOwA4a3NflR3hsUuCWnkOfGvZbk9v7SPOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFKxmrrF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C8606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nFKxmrrF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52641F000CA
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642861;
	bh=NcWgHvdLtb/0W3sgf0a6rdFoC0yfIF4KP6bkd69RC+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nFKxmrrFBPr3+4u9fTN8/PH8lRveoBOqOweE600oKGJTHnX1jF00Q94a/Kx1QofVe
	 zSS+J5v4WaxN41RuCbNYDSOEBARMH0KIym1kK7+MJGubKnY0AUN7H1Kni6ByFbkZa4
	 W6RdYVbTjpJ5F+6vEa5LxLtcE6MjryV2vHjArbh0LyCKvI7KqHW0sHPJVHIMfTqARR
	 h8OOJr6neXKMrUFo99Iwfa2UxHpXN5WLry+Tf1k9GG+pUA8nY1pZG1v6njNb/oY0uF
	 XSu6O3Dz0InQMBseJHsVXeeCKgyc2A/7IJnuCGgiQ2ZbQdFEh0OL9UVTmz3YKCMIJC
	 trOoRkh8Xl97g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c51a02ad3acso201383266b.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 13:41:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHiq6qZolWUaS2SyO4FEBtChklxTCXFCBiF4sYR/enGPfnMjAiNMVQdUr1v51AI7hifQt4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sVMBI9H3wB30J+uYQ7U/UnxMbTdBBqfArmpGTph83G7LE1yKF
	cNFrXLa8jJBrlj8JdqwWgHH67iPD6o0RCciGGjT8Tb7KQdz5c6yBQ/9JTcUHWlYHtKqftNHL5Ga
	iYO3FgSPo3Jq66cN3XI6y5C3S8lh95T8=
X-Received: by 2002:a17:907:9d1a:b0:c51:3b58:b99b with SMTP id
 a640c23a62f3a-c513b58bc59mr1582831066b.19.1795642860883; Wed, 25 Nov 2026
 13:41:00 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117210934.7765-1-seanjc@google.com> <20261117210934.7765-5-seanjc@google.com>
In-Reply-To: <20261117210934.7765-5-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Nov 2026 13:40:49 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMTVS+8SroFTemKR4V35zCE6HumtyBdpk_E5WDdHDKKfw@mail.gmail.com>
X-Gm-Features: Aa3M54oF-_4v1lLITcpl34IaUJcHbkhnUHduorV4iD_-VChitIN-7SEzfJqk0NY
Message-ID: <CAO9r8zMTVS+8SroFTemKR4V35zCE6HumtyBdpk_E5WDdHDKKfw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] KVM: x86: Consolidate nVMX vs. nSVM logic for
 loading CR3 on nested xfer
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 1:09=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Dedup nested_{svm,vmx}_load_cr3() into kvm_nested_load_cr3(), and drop
> several MMU exports that existed purely to support the related vendor cod=
e.
> Except for slight differences around PDPTRs, the logic and reasoning for
> handling CR3 and PDPTRs on nested transitions is identical between Intel
> and AMD.
>
> Add a KVM_BUG_ON() in nested_vmx_load_cr3() to ensure that the new helper
> doesn't unexpectedly fail when PDPTRs aren't being reloaded.
>
> No functional change intended (the new KVM_BUG_ON() is unreachable).
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Code looks good, a couple of nits below:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

[..]
> -/*
> - * Load guest's/host's cr3 on nested vmentry or vmexit. @nested_npt is t=
rue
> - * if we are emulating VM-Entry into a guest with NPT enabled.
> - */
>  static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
>                                bool nested_npt, bool reload_pdptrs)
>  {
> -       if (reload_pdptrs && is_pae_paging(vcpu)) {
> -               if (nested_npt)
> -                       kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR=
);
> -               else if (CC(!load_pdptrs(vcpu, cr3)))
> -                       return -EINVAL;
> -       }
> +       if (reload_pdptrs && is_pae_paging(vcpu) && nested_npt)

Check nested_npt first like kvm_nested_load_cr3()?

> +               kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
>
> -       vcpu->arch.cr3 =3D cr3;
> -       kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
> -
> -       /* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. *=
/
> -       kvm_init_mmu(vcpu);
> -
> -       if (!nested_npt)
> -               kvm_mmu_new_pgd(vcpu, cr3);
> -
> -       return 0;
> +       return kvm_nested_load_cr3(vcpu, cr3, nested_npt, reload_pdptrs);

We dropped CC() here. Do we also want KVM_BUG_ON(!reload_pdptrs) here?
