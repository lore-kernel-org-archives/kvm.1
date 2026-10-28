Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146146;
	b=V1YAWyRm6KoGE2Fy7tNPcVTKSUVHjy0zBZacx/6vXi0hrYGBBydevkPnw7ulpaEGzNrF
	 Plr19OsC1iE1ijkJus3L48HHny0gt58ObmjobQ5rlY1hHag2rtgHS61c1vce8NP2/l9IA
	 RqSMcoIdba5LRDBggrVg+ODFeHBHovNH2YSX+ky1UD9VbW892Kfyxbt84BGukWAWdPe5N
	 ILTgziia/fTuuyLySCns2jtQNN6WLmAszxB4PC9Wd0mCFsIehEe/Iq4ftSPSvhcVvy32c
	 OPSvIUYSfhU0EBjpk++lDltL+jNTe9DfRhbtNgWlf+Bev4zihjEBGjGsfzfcotJ1SAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146146;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qoZTvO7HPBuwi7zu6wCZADYHypiiKkS/7OSEkTq3rbA=;
	b=GrGjmRu6CinK4kPwjTEx0CRlZ8x9hcwmT5cbvKMfPhWm30fNPyptxNMGDEZpKdKDs7Vy
	 RoDgH/Ew4yxXibFTySLye9owYJsX/YgWAUUkG29DVicopEzisg1n3GXLiN4VxlkCo7RuV
	 Jlcz8Vm9bURO4kjiS2lCcttopAoua7U+a1MuzBMfKYalAq+7llYYdtS1WocUG8yeykljt
	 FU/nJWQYNri1f/HV1B1zGXgBxzBMVbO5KMClD+Oxt+GjsQSw5OzDtCkLySJ3+3r5jkz2f
	 IYkFU1kVb1oBc30eGdsbA/zrryZB1uA+Eto1y1W7vl3kssduXSoFRzP35h1fuxXzBPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BAMRpe/b";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531E606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAMRpe/b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1FA1F031E0
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 00:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146145;
	bh=qoZTvO7HPBuwi7zu6wCZADYHypiiKkS/7OSEkTq3rbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BAMRpe/bfqHEK6Z/S+iNnYC/kUBtqSFjKAZNHZ0FHJgOQyYo1WV3IFfiAZ5rC8+vq
	 GVDqT3K/HtOB5PMH1xOwYb3DPugo1q31W2xf7iIW6yGzLlkqMkyk53qRsukLkg0e0i
	 NwJC60kkDn/OP6s8S7FfYG8kzuxTmLg5hN4KYvjsTTLx7O1+jnW0wAu3ODhwdDgeuC
	 txMJPAuh1hOLrMpi7L+4uN7zmgxg8NtSuUBp+bFX4vjdkskwYRVkdoj3099nXW4Uwb
	 TgVum8pYK7DCU7e4oUIpnSu3i43GGnjnX5lx9VnUvA5T8xET3CI53aMlSgu4Q7U6oQ
	 nAdfsKBIeocBQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso849421a12.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:09:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1xkbwccB6y2ZNJwWMWN5NJMqr6H8hvtJc/Caxl8YAi4BDR0cW808zowaCZRV5UGKzdic=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQOhsL1u8yQ/2LeFi976oQjGSLNRwQoyOiRdilV2dur4VbrNON
	tsmgfMmzN6tSXRsOy14xbTJ7HWXHopEVuXkIcgN/nLJtTujYyWYGfqCNOj4GAy+CBxRZugV9GHC
	LdiUBx3w5L4zkKkvE3OxpFeGGXv4JnM4=
X-Received: by 2002:a17:907:7f9e:b0:c40:d920:746f with SMTP id
 a640c23a62f3a-c49be05475fmr53932766b.46.1793146144119; Tue, 27 Oct 2026
 17:09:04 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027224914.1574319-1-seanjc@google.com> <20261027224914.1574319-3-seanjc@google.com>
In-Reply-To: <20261027224914.1574319-3-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 27 Oct 2026 17:08:52 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOnf_AiBJfTJTO9jS6cYj6bUxhDoBsNdmbeP_jaQnLCkw@mail.gmail.com>
X-Gm-Features: AclHuK-ToaICiNYWBcFsl-_AQjXaid1IVR5C1nX8SmWpfHreqpgdnSwjFdhwDPI
Message-ID: <CAO9r8zOnf_AiBJfTJTO9jS6cYj6bUxhDoBsNdmbeP_jaQnLCkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] KVM: x86: Reject clearing EFER.SVME via
 KVM_SYNC_X86_SREGS if L2 is active
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:49=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Disallow clearing EFER.SVME via KVM_SYNC_X86_SREGS if L2 is active so tha=
t
> svm_set_efer() can treat yanking the vCPU out of L2 during KVM_RUN as a K=
VM
> bug.  Ideally, kvm_is_valid_sregs() itself would reject attempts to clear
> SVME while L2 is active, but the risk of breaking userspace, e.g. across
> save/restore, is too high.

I am confused. This says we shouldn't disallow clearing SVME while L2
is active because we may break userspace..

> On the other hand, yanking the vCPU out of L2
> during save/restore is already "broken" as doing so would queue a triple
> fault for L1.

..and this says it's already broken.

I suspect you in the first paragraph were referring to userspace
restoring a vCPU not in guest mode on top of a vCPU in guest mode or
similar? Might be worth clarifying what exactly we don't wanna break.

>
> Link: https://lore.kernel.org/all/sashiko-outbox-182127@kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/regs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index 3621f1a47d37..e53496fdeb82 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c
> @@ -738,6 +738,10 @@ int kvm_run_sync_regs_from_user(struct kvm_vcpu *vcp=
u)
>         if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_SREGS) {
>                 struct kvm_sregs sregs =3D vcpu->run->s.regs.sregs;
>
> +               if (is_guest_mode(vcpu) &&
> +                   (vcpu->arch.efer & EFER_SVME) && !(sregs.efer & EFER_=
SVME))
> +                       return -EINVAL;

Do we need to check (vcpu->arch.efer & EFER_SVME)?

If that's not set, we already lost, right?

IIUC, we can't be in the middle of save/restore here. Is this intended
to check for the situation where userspace cleared SVME while L2 is
running? Or maybe L1 cleared EFER_SVME from under L2 but the shutdown
didn't happen yet?

I suppose it makes sense for the sync to only fail if it's actually
changing something. Mostly just thinking out loud.

> +
>                 if (__set_sregs(vcpu, &sregs))
>                         return -EINVAL;
>
> --
> 2.56.0.307.g5fe7bd680c-goog
>
>
