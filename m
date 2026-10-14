Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573934E9C1D
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982138; cv=pass; b=sN3hbCBhOV2OHqo+F1AgsTk+E1Dpo2IRckOJQ/riILdGHaZWHf9RpzgorsRdISifd70n1TG7AixmGHPBWARxQGUuZt3+MSP3JtT4PLiaogGoXXDWPrxC6koaMln3xfzTWxFo+Uc5Ydnv0dqnhC3EvIafIVbCtSmgB5NhQ+M1gXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982138; c=relaxed/simple;
	bh=PErefbjRur8+lAPuSaGWtGt6QpUAIajC81LrxVlpFMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpblQ1nU9qxLfME+Y8RqXvAL6WU2VJ0scDjKkzkizmGSY6vM/IiDU5U61aqHxI5Hx70WQF2Kf+ZO5m9IcmN/W+YOjJdW2GwaEAI7Xz7JO9Uvf8Wr3Efj3W1cPGK0zmASplzi1N3vpVMt82YDiQNO1Jrb0wHM/kJV9rd2KMMhR+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5yRYTvh; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5yRYTvh"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so39330a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 05:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982121; cv=none;
        d=google.com; s=arc-20260327;
        b=VbNOJL3zD6TM/iJ42Lfs37I42rAWd9XbBPtkHLxDOHuMoDdCxyUhl7nL5CfD9Ak1H6
         JfeVO92Zuse5XsTzjCB2PpkYR8j72zonz3QNlfkdQX7dTxo2Rnw7WYhhtqgKswgEeUF0
         t1Z0uxcZhEpupiTmTrCIAhMsy0EcFx1XKtzfuplhE5TAX9zXK7GfeYlJNGj8861LfQe8
         XTtxAlFIjsW5XgsbteguZ3clNvbzgiuc1irQhe6V6i2SyBFMJZjs/Lt9lvZlsGUypqfX
         sOAyNj+Too+XkdGQPLQJhKkY9xvaI32KWinr1LDWQLwYpIgOtf8s7RZvaKc7LBzGqRSf
         92JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQL2xas4nG18KleQ+fT63AHqIIDtA2su0UrfgqIbaUY=;
        fh=JOB8G3i7G1VJwDKYsVeMisgynBcKqTNyWcaKnSxbJHI=;
        b=Gcq0JQxa1JK8w9sYqX1ZT0/mli89VpaAA4wfnu2sMmnk8VlRWtPM/MPGXN4WLSIzId
         fa+DCg5TSdT7YZS7hnY0XGJtzbtNeRmVxbvC7iZJDRPf0FqpzRXWm6FpFiipHttHv6dx
         2pDyEnu0tvFhuw1ddEBzD+9rTZc+nM0JG/jFDzwIfRwWDQMBuZ73pJ2e9fQdg2vAF+3u
         I14QHnxl4Y11+n1+yUKXptnkoOkeWF0lpj2e5eAq2hWDVqL//LIWIvV1RXR9WqFKOn6H
         uX7p3o9arfflxh0DZP9t6w1ZmBRe+tDZ1KGY0vX/OaWg/a8Z7S6QBuVfwlIItzx4DxfO
         7blw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791982121; x=1792586921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZQL2xas4nG18KleQ+fT63AHqIIDtA2su0UrfgqIbaUY=;
        b=j5yRYTvhohXuYavC5ABCCkAAn9CrYw6NFyFY2Q3J57I4DPq2ZZAlaknoAfZ6QuyFNb
         6G8NhwktdFbzyV5XRYDz3qPoqPEKM2HP97SuYn+JUE5XpDt8SvrobPC09kBMAnLzwtyg
         zYalfD3EzJEb9YdgK/B+gogXRfNQjq3az23LgoXQXLGv2x+OxEf6rMRMmsM2T5srOcfG
         KPuEydfjDmm7USrqCaAKz9mldbnxzDOWOmnDGc4qwdb5yT0jkpFFiW3+ktwBQCKoStXF
         rM9PGQ91GZFDIMgY0fVtjkdbT9wJ+f8yoowWia7iN0eIH5u9C0rzLRWLr9/gHI1FuAab
         KDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982121; x=1792586921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZQL2xas4nG18KleQ+fT63AHqIIDtA2su0UrfgqIbaUY=;
        b=1LENL4Kn49i5CK17uF6SrHeuzxCX3feOfQd5aTZJJwg57kqJKdgCAnpKqNspGqoOi3
         Www5MDlfnKT8G/fmRfDB/u3luNrXTInW6KDO9rake4yyVTs5tvLYcxZqwm8I/hm4q7Mx
         TLlygJGBjAIqLtnk6ejrZwcEEK+3aeB1plQlZZZqYiXoW5IOAiJzhlZRcsZ2YdAFoRsg
         ZvKph1DmT8DfCtuv8jHV4wR+wR+/u2ro/JkWNPACMRwB0uDDL03rGXCedeEt52RwkKbc
         c+UButyTp+3Dr/QaujGmgNfoVoQkH1HwkJNlKy7/qgNzra+EuOvC7t+qLK3yvnHRFtbv
         Mu9A==
X-Forwarded-Encrypted: i=1; AKwUvBwMgPuSQ30/dZGiEln9b1gXmzzDTdnCHFBIZmlWR+rgYv7aktLLEQQzcTnqUNyvx0OtQo4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLy5iP8IYGrpdXHbWRjrX7eMJrf7XRoEZxNQAstu0ADiwbf9mX6
	LwFw8JgMNCFdpFs9EDdU9Y9Lkv1QLe3A75+vUC3v6FScllxPkt6UUypZxrtxcDP+Zk/VeeepfYN
	KJ1lo58GXhHavAEA4clsLW+MxJKEQuZnOjLVHpIk4
X-Gm-Gg: AYBFou26YZQ9jexut437MLkzPzPNBOSfqOTTLDVAbxzjj4yVfPyXPikK8DPUaX6vWZj
	uekL4lYm2r5dpxwcx7CcwAn6MTTWFHJL4pMukEQMyJoZ9TLUObheNC/SpFEdl8B76Nv/YgLWT6j
	JubHxbmXvkizg83Da664/351lmojucYP5hsIyMyw6AcyuTtfFiLa1syrrwCFOJX1P1Zh/t+9DVB
	+2pzne6zJR1qqBFWz0Neau8stlt6TPOsOD1ochcMzadFP3TYjL0x8vae9Xe5YBX0NqS1Z5Cpmfw
	hoe6EgFLv8MqawgQsEyOIYixtFDY3J2x3d2pa4Hfnz32/ychK5GJdO4=
X-Received: by 2002:a05:6402:424c:20b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b20aad471fmr31158a12.9.1791982116138; Wed, 14 Oct 2026
 05:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013231728.883001-1-yosry@kernel.org> <20261013231728.883001-2-yosry@kernel.org>
In-Reply-To: <20261013231728.883001-2-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 05:48:23 -0700
X-Gm-Features: AclHuK_eUHrZ3upceONbVQEejfpEzwYMGcSk3TlD294BOAEgQl9aP_4IrxL6XqQ
Message-ID: <CALMp9eQ3mz_EiV4AcmMC2CQZ47s_uf7XCbhnn7pfvVjHwsXdTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: WARN, don't BUG, when walking a cached
 root with a PAE MMU
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:17=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Replace the BUG_ON() in shadow_walk_init_using_root() that guards against
> walking a cached (previous) root while the MMU is configured for PAE
> paging with a WARN_ON_ONCE(), and terminate the walk if the WARN fires.
> Walking a cached root with a PAE MMU is a KVM bug, as PAE roots are never
> cached, but there's no need to bring down the host, as KVM can simply
> bail from the walk.
>
> Note, the BUG_ON() is currently reachable by a guest if TDP is disabled,
> as KVM walks cached roots even if they were created for a different MMU
> context, e.g. if L2 executes INVLPG while using PAE paging, L1 doesn't
> intercept INVLPG, and L1's 64-bit root is cached.
>
> Add a common error label for terminating the walk, and use it for the
> existing invalid/dummy root check as well.
>
> Fixes: 7eb77e9f5fcf ("kvm: x86: Add a root_hpa parameter to kvm_mmu->invl=
pg()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index aadd5bdc2c97a..126faef5a6476 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2558,10 +2558,8 @@ static void shadow_walk_init_using_root(struct kvm=
_shadow_walk_iterator *iterato
>         iterator->addr =3D addr;
>         iterator->shadow_addr =3D root;
>
> -       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(root=
)) {
> -               iterator->level =3D 0;
> -               return;
> -       }
> +       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(root=
))
> +               goto error;
>
>         iterator->level =3D vcpu->arch.mmu->root_role.level;
>
> @@ -2575,7 +2573,8 @@ static void shadow_walk_init_using_root(struct kvm_=
shadow_walk_iterator *iterato
>                  * prev_root is currently only used for 64-bit hosts. So =
only
>                  * the active root_hpa is valid here.
>                  */

Can you please rewrite this poorly worded comment that now explains
your code below? What do 64-bit *hosts* have to do with this
bug/warning? I assume that should be 64-bit *guests*. But, even that's
imprecise. Aren't prev_roots tied to 4- or 5- level paging (i.e. long mode)=
?

> -               BUG_ON(root !=3D vcpu->arch.mmu->root.hpa);
> +               if (WARN_ON_ONCE(root !=3D vcpu->arch.mmu->root.hpa))
> +                       goto error;
