Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767864;
	b=10F/2oFUdv6bQc264n+guizs/6IYeYW1QWk17eFEuEfW9Rpp04f9t/k0kO19siCjF6Zb
	 DsZnpZj9u7E+l+BkQyPl4dlLtx+omu0kt1njf9QhxO7f7+HUYe+tRV9mFtOQ0Y50GOVmP
	 VR5EXY891QJokzafctMsfbqRaD+dP06lIQfgd2hSbRK4yWWijrxiFctjVpRdCuaJXxd7h
	 1VWYUoTDw/pun6foyAK4iIhUJQVqFvB+Hqs7YuLONqRLr4JvfWnIhCw+CQVlxjGLc748O
	 rmXj1kQhDg9OUWEXJpo8yz2y3aYSFo3H2+Z/iuJcbFdBot4ii466kEQGg1MmwJe2lDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767864;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u0fv7wGzCPLuIrRmUrscALXK3fs5v8cwxjXo0aahob4=;
	b=n9BJMK0d2zGHsIoykALS4eTJe30wd9QYuXTEVrUPyNksUcFgx1VssfGVltc+eUfitl36
	 TODmYhb4auA0XU8cF+Ta50mhARYbbvpYKN4Td5iDlKdJhy82XpOjvTSoVcG1v440EAjZb
	 y3g4wZm9bfgDkWfEEqQgip+W554DGvCSoCKYxRAIoBTCoKnY7VW92hTQpz4yEZJ8BLD8U
	 vs55vvZkXZII2AriLjJboYfebRJ/ZgcIVRhHbfncoKfxf7Y5GlULyMPQPMnrs3FnfPIsf
	 xf0c3IBuCsVRr6E1sr7qgh5kcmz8QQ9lqpH4nW59v9k2y67gbzxAROiXl53lDKc6ILg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mxs4b4Vp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8601606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mxs4b4Vp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765D91F031E0
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792767863;
	bh=u0fv7wGzCPLuIrRmUrscALXK3fs5v8cwxjXo0aahob4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mxs4b4VpZIA+E+aiA0I6Y7j0UDb0+ayMpDUyqkRFhZSyQ6AwGvRpqVRM4Eos0Awbh
	 T4zQ5bzkXLwh6n2YDfCWtiK0bStdyVpYepX92s0biKbu8SqXorC0SU2H/TcbLJ29DB
	 XsVj8wJZe22FGU8SHPG6eUhoXKXYUL7uDTQ4gP4rZ2XkYv0oz4Vc/4ACvYEPuxry9R
	 yT3nH1XMAmXoJo4ELkdGETBFT3WLxKF2qQOkgLkISGSOFym/Tt8QW18YCwA6CM5oVl
	 t+4b+tBWJ+dG96qtlZGncwLOmm+rRGpdtqDHtNOm2TiIRBbcw+LyXNR2Gg/WrzSadc
	 8Q/8D0UcCQODw==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f3c89594cso67378885a.2
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 08:04:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw138sJmQDvBxPgSQxzXGVhwRZHTr9jYL7er+rp0DHVXxGWDLmmyxn66cqKqSyJ3k3cDVk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIseu7eWqsdu43jTD98KKjz0DHnXUZYpa0y6DpVmecVFF1wT03v
	OawiYv++Q+rHYvnqNjTfqRSC/r15Bmux4hyuuxqkMAfYY2DJMxHmNZ3LsPHdimWOlX1xxyUF+at
	wZ7MUq2FXQtUHyZ28kuGrauFqBvnUrz8=
X-Received: by 2002:a05:620a:1a07:b0:93f:33a8:8e99 with SMTP id
 af79cd13be357-93f6f91d470mr470425985a.13.1792767862790; Fri, 23 Oct 2026
 08:04:22 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com> <20261022223052.646891-4-seanjc@google.com>
In-Reply-To: <20261022223052.646891-4-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 23 Oct 2026 08:04:09 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNbieeCQKLjfC4vhaeS_mgFJc3Ex9xKKmKQHL_43j9axw@mail.gmail.com>
X-Gm-Features: AclHuK8ZFr3SLm5B6kfF7hHd2gH0cRTFJfA9qLmdpH9cNhAFwIHzQjPjX3UFpHs
Message-ID: <CAO9r8zNbieeCQKLjfC4vhaeS_mgFJc3Ex9xKKmKQHL_43j9axw@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: x86: Recompute EFER.LMA instead of inheriting
 the current value on EFER writes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:31=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Recompute EFER.LMA on bare writes to EFER (via WRMSR or KVM_SET_MSRS)
> instead of carrying forward the current EFER.LMA.  While it _should_ be
> impossible for EFER.LMA to end up in an inconsistent state on such a writ=
e,
> KVM has had a rash of exactly those bugs, mostly because SVM is quite lax
> when it comes to consistenty checks, which in turn bleeds into KVM's nest=
ed
> SVM implementation.  Retaining the existing EFER is also rather confusing=
,
> as understanding why keeping EFER.LMA is correct requires a lot of a prio=
ri
> knowledge of both x86-64 and KVM.
>
> Keep the core concept of the existing logic as a sanity check: WARN and
> reject the write if the computed EFER.LMA would be toggled, because as
> described above, that _should_ be impossible.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/msrs.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index c3cb1575fe66..41f3ec6eb286 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -638,8 +638,18 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
>             (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
>                 return 1;
>
> -       efer &=3D ~EFER_LMA;
> -       efer |=3D vcpu->arch.efer & EFER_LMA;
> +       if ((efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu))
> +               efer |=3D EFER_LMA;
> +       else
> +               efer &=3D ~EFER_LMA;

Does this mean we can effectively revert this patch:
https://lore.kernel.org/kvm/20260902232028.2767071-3-seanjc@google.com/?

> +
> +       /*
> +        * Toggling EFER.LMA on a bare write to EFER should be impossible=
, as
> +        * it means KVM allowed architecturally invalid state at some poi=
nt in
> +        * the past, i.e. allowed EFER.LMA=3D1 && (!CR0.PG || !CR4.PAE).
> +        */
> +       if (WARN_ON_ONCE((efer & EFER_LMA) !=3D (vcpu->arch.efer & EFER_L=
MA)))
> +               return 1;
>
>         r =3D kvm_x86_call(set_efer)(vcpu, efer);
>         if (r) {
> --
> 2.56.0.257.gf7497c7d27-goog
>
>
