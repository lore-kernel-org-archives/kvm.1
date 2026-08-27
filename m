Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFD332615
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814347; cv=none; b=U+4eEgMiQOdtcP/Fo51OIjKbLwUR2KzhMkJf4JNSzGkkMIbxA1JpqHdMsqZst9iowuWa/UBGabDLsXV69bbozEgZPfKfSA0TZbTpe8ZkMjE2jSvYI9UuXcamCi9OunrH6fMsN7ckOZX6C5j53ogZwFP/iBtIg5IWhYZOHYl9P4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814347; c=relaxed/simple;
	bh=nMTbEVw3RcNjJfD1vTgvqY4FAbMk8rOLmwGPWcIVMTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ3haMVF8D0vmPrHpGnQlJ38gZuQrB6CKEtrW7W3doW2AVzBY0FFJ23B2Yj+blfjFPMr7+jyBk2oqEcsoV6NaFY8kn9EIj1v9jmvgvDpyXgUnk2hylXiH+6yhM+nIqA6l0yffI9KlQ2tFscq/rvwmkrVfsHVHD3OGMYiUW38q1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWrqvU4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWrqvU4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960FB1F00A3E
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814345;
	bh=LWlFzFyjeGVWa3x/W+d9uSXivZwkp/VMFn82P2+QEZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cWrqvU4pg2E68pi2/8NQrXvAWC1z3J/NaT4PK4ocWBdH6oV+PhKO2lToplRSnly7N
	 CCoB4aDoDAyOC3HL+WcZcyX+1zfQuKIHCeekqBR3RqXyuy3Ts9myyNAi3MpwHg1mom
	 PaZu+WC0O5gyyoGGFS3ezdJh3vKEQmcA2wyKBjqZO/nNs/zWxUnsDiB5mLV7b125wx
	 F3n611Qj4QMmG/z558zzB3SpLyEdBDI9lFEBysba+bgHvy8p3gpy09SAms2qxnyrKG
	 d6YRTBA3gWkUyHK89YSfObQnV5OzLdHGkGI+pjArd2dNKVcolasyOHNFayW7MpSyCg
	 ouhIJoZkzFsqA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso2768315a12.0
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 00:05:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoLdMbu0Umqf+Z67y9S/9/etp6jNiKdvwM5CVb7cAD4iGsTbJH+2n5UNFQqmSQ3b6Dg+Uw=@vger.kernel.org
X-Gm-Message-State: AFuF++myZRgiJxs3/ZMd9yvEMt0IG9C0KLiIl9AwcM3+BbPIaNGZ0o90
	w+i0UNUpeWOoPkLsxcGR0xLgbxICAYWBOWVe4xSyXLGSshK9KcffoGXLkm8CJ3a0XcR6GjZjYSR
	d54p2nTt93RyaYmjPuZ89sfaMmCPBO7c=
X-Received: by 2002:a17:906:fe08:b0:c1f:e9d9:64d4 with SMTP id
 a640c23a62f3a-c250bc2dc95mr1393749566b.11.1787814344469; Thu, 27 Aug 2026
 00:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-3-seanjc@google.com>
In-Reply-To: <20260826211844.884951-3-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 27 Aug 2026 00:05:32 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMA-E7UYzNDT=0rn7sv7+=Ydxy2zzikMPV1_YarH9sOeg@mail.gmail.com>
X-Gm-Features: AcwNN1XM6PuhzQ_j2HN5IXmQM0Vec6jv-s7HRnmZUMa7bCnwGWQzzSHKWS76EvM
Message-ID: <CAO9r8zMA-E7UYzNDT=0rn7sv7+=Ydxy2zzikMPV1_YarH9sOeg@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Bug the VM if KVM attempts to walk more
 levels than the MMU has
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Extend the "EFER.LMA && !CR4.PAE" check, which exists largely to guard
> against KVM configuring a paging32 MMU with more than 2 levels of paging,

Is there value in keeping the original check? I suppose yes as you
said it exists "largely" for this, but it would probably be nice to
spell it out (if we know).

> with a very explicit check for exactly that: that KVM isn't trying to wal=
k
> more levels of paging than the MMU template provides.  I.e. harden KVM
> against all bugs that would cause KVM to generates accesses beyond the
> bounds of guest_walker's arrays, regardless of how KVM ended up with the
> misconfigured MMU.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 27427e7f22fa..46a0f7796e55 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -368,13 +368,14 @@ static int FNAME(walk_addr_generic)(struct guest_wa=
lker *walker,
>         pte_access =3D ~0;
>
>         /*
> -        * Queue a page fault for injection if this assertion fails, as c=
allers
> -        * assume that walker.fault contains sane info on a walk failure.=
  I.e.
> -        * avoid making the situation worse by inducing even worse badnes=
s
> -        * between when the assertion fails and when KVM kicks the vCPU o=
ut to
> -        * userspace (because the VM is bugged).
> +        * Queue a page fault for injection if any of the below assertion=
s fail,
> +        * as callers assume that walker.fault contains sane info on a wa=
lk
> +        * failure.  I.e. avoid making the situation worse by inducing ev=
en
> +        * worse badness between when the assertion fails and when KVM ki=
cks
> +        * the vCPU out to userspace (because the VM is bugged).
>          */
> -       if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm))
> +       if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||
> +           KVM_BUG_ON(w->cpu_role.base.level > PT_MAX_FULL_LEVELS, vcpu-=
>kvm))
>                 goto error;
>
>         ++walker->level;
> --
> 2.55.0.887.g758fc8c411-goog
>
