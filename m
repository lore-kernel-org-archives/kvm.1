Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540435C6B9
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814521; cv=none; b=P28OAksfe+CQzs64bTgYYnRbx/ZiwMkFz3Kx4sDz0SNeSB9Cyhi76rPLnQ1ERr/Yui+eXlsGFfhCwZZWD18KEeXTfBuNm07Ha3qIiGVgEcaHDslcmPdl+olIs7M5HffEEewqtYaxwQqr6dZ+EYj0YbHMXOcmyKGVojEpmeqd7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814521; c=relaxed/simple;
	bh=dQf27oAC4dBGe/SyI1+0GsuR50NE5X8GkWKLYmc4X3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=serom6w/xuZTiZlIw2fdmyb+IHyeQ+uV9wUa3YplkBx4Iyit8Hi06SVJLkzhWBK5kLhgx40tJl0iuDpfZ9cKaTIKJINjqClf7tpkKOiBPu9iS5zjppQEwM+P2jKvkSQhcX8SMU+6qSlNqX6S9XkySznCq4jA7hZapJ/1e5qqNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6zJRpa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6zJRpa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74BE1F00A3D
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814519;
	bh=hm9FQNMTULRI5PbphxoLf0euP/KXUzuUHsfwhItuw4M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i6zJRpa9ogYypqtYJevNbiYc7OWsqazL2hJ9QrDTTHe9zmwgrw1tWKi3sXXnp9j/Z
	 38AuDTWqo8RtQ4tnXbVvdt/EGCd/qNuuX3T4E1n+Ba8usPhdUmF42e/s92cAB2L3xW
	 YMzLKd09nmzXx5bPNNAwaywaaOUXYtBvVZxygPwRxhPltlJs+b0NyCkBZqsvRGeaFl
	 jox8aoEAWlR6NF/ZnXhZcxxNOLX2FjD3HV5X7q26doOX1TffK7dkhRyQtZA0AeTp6N
	 HNajv6kVAd0ETtBSRT83pnHvCbQXK1SWmrKPlto9CikynHoINu+mNkkI29ivz8HpAj
	 JILnKO96vRiag==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2544ff970dso30283766b.2
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 00:08:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq/dzYUsDGXx2CcLc2Hy8AIe5PDyX8+t/SGp94s44oT04IvCwuodhGeia1zAaIAgy4u0l4=@vger.kernel.org
X-Gm-Message-State: AFuF++nsrJsL1NXUpPYQTLjLEoOuCpTg10pVkWvL1geTbamuWhT5jRa5
	QTFkajGXbuYeyNge3T3hT1OPMk0x8NuM7OpiDcvvFGcRIDS8d2BZ7zvZ4QznLWJMCD1j2Gb4Nlb
	j9UtqVQni5b3dsbiMCI6hQhsMOclP9Ls=
X-Received: by 2002:a17:906:2081:b0:c25:2e93:28a6 with SMTP id
 a640c23a62f3a-c252e932fe8mr701170966b.3.1787814518868; Thu, 27 Aug 2026
 00:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-4-seanjc@google.com>
In-Reply-To: <20260826211844.884951-4-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 00:08:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM7KSRX5r-PazJ87QaZze3wkB5WmJL4e6az5akmJLterQ@mail.gmail.com>
X-Gm-Features: AcwNN1UNE2kyRdaKjw4CnNNb1QW-6POFF94C18u1aNFWrrjITYoTs7pQZcwdWYU
Message-ID: <CAO9r8zM7KSRX5r-PazJ87QaZze3wkB5WmJL4e6az5akmJLterQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with
 EFER.LMA=1 && CR4.PAE=0
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Bug the VM if KVM attempts to construct a CPU role with the should-be-
> impossible combination of long mode being active without PAE paging being
> enabled.  KVM's MMU construction assumes that EFER.LMA can be set if and
> only CR4.PAE is set, and will create a completely invalid MMU if that
> assumption fails.  FNAME(walk_addr_generic) already has sanity checks to
> try and mitigate the fallout, but attempt to catch such bugs earlier, as
> this is (at least) the second time KVM has had bugs that escaped into
> FNAME(walk_addr_generic), and it's entirely possible the bad state could
> cause problems elsewhere.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 064ecc33b926..81c30e2c74f3 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5910,6 +5910,9 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct =
kvm_vcpu *vcpu,
>                 return role;
>         }
>
> +       if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vc=
pu->kvm))

Can we shove this into the existing if (____is_efer_lma(regs)) below?

> +               *(u64 *)&regs->efer &=3D ~EFER_LMA;

Why do this if we will crash the VM anyway (and Sashiko doesn't like it)?

> +
>         role.base.efer_nx =3D ____is_efer_nx(regs);
>         role.base.cr0_wp =3D ____is_cr0_wp(regs);
>         role.base.cr4_smep =3D ____is_cr4_smep(regs);
> --
> 2.55.0.887.g758fc8c411-goog
>
