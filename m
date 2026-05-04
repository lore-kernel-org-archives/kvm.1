Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8F38D6AD
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935809; cv=none; b=YLwL8nJlfINDYOw6+gZv3F6WlfsI3ZuVSw8r/ywXKg7Ld2BTYtHO3ouB9YdT1Q2vftnq8pCqxnBYHAlALwUeUTeMr9w7IbAPdAxXG9frjhdYX9lWWUs1KBGT9EVLhOqdyStvD7CeImoLB7nHEA9pFXZ34QY1lJJvC+rfltTLVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935809; c=relaxed/simple;
	bh=gB1YeXZjOLidRaaBER9ixl9cpdeIZX4jkYyGOiGcZ2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSCpzd46Zg84U2h3Rt1+9ohuZq4pgcl1QStDTDAiO65tPU5DKdioEDVJKlCCrbN1Lo1xwzQeYP6+j4Rf/0M/qzXxi9yyJKw6L4+3uMpnd63WWzmTncALbpx/9vVRnrjdVLVQzTUYFCE2cITigLQSSWwm7p6Y7d9s1tDlTWZMPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhMjk3tK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhMjk3tK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c799ee56bd6so1701317a12.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777935807; x=1778540607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5u0NRaaVg1firf+FEu7AwSnY3aSrTVvAGDevzmZHuA=;
        b=QhMjk3tKYQbY5FjD0vCvPMnrVX6sUN2fmSg6WiqMKjnsVgzBlEm/T2Cu+2MHx2TCRf
         SYQPxfybB7UR5CRLZyEj4eUm4u7y/56fPPa1wPPrvY9HM/WbgZibgI7pJ7/EdkE0T7BE
         dx/7JnEcmuPLBpdt+Ia3eAzAElHPrjgbXPX4Xh/yOjoQI5JgPF3rnYdcyDBmgwuKf2ua
         85SCXuFgtvaSj3QsghIg/K/L3rfBVvEp1SOBNfkToneKe/2qkFO/CwL1492O6uGdGsiV
         8y+oEGefjcuZRNl2AFx3acfY/dBe0kWE4X6HqCmyeR6ZLyMM3tSDmbN7TGgwfWhliYzP
         M6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935807; x=1778540607;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5u0NRaaVg1firf+FEu7AwSnY3aSrTVvAGDevzmZHuA=;
        b=eoI3Wvz9waInr/x8dHB9kjyEafvumX1o0Vl3ZVPPIwt+RuHIRrAkMgNPuwWd/y1xk2
         zocuYL4gygPo9UCITAKN/hPnFJSw7J+YD/qtPeKufBEmEo0IV4gT4STdVYAq9yFh0Drw
         UATejD2Uw2R898lKb4ErOOfAkymVZYcCgF5RrEJ9OJm9+61Sw1QlfKAhcxijpvtXZqWr
         VI3LIFkcq4oCHfhOZk75IhciMbiGeDhg7t/7/4YBMJj8uoosYYOlccIqXs1PMdGuES6c
         7UC7nzKPuISTSJAF6zt0GsncqFk2Rw/lTGkPxyORwd78bndXLl5IZI++9+GIMIR8MG77
         ZRXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ogtyz8B0bbZAutFPdcnwwonhBg8o6xXPHWnJSoRJefrezCATQL/KVdjAI259gYJZkHb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywggd/xIm9w9imBchbaiGWvhtwNhmQmJAJDjSX5TUuAN60Zjhse
	ACSl0VIrd09P+aXRsHo53gUOPr/R4vCda0uxlsIY8/BtsbZ4rkFpQc+H93oR3ezOM3Hga5LLhcz
	5JMupfg==
X-Received: from pfbit6.prod.google.com ([2002:a05:6a00:4586:b0:82f:cdc8:c871])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1586:b0:39e:badd:c1d8
 with SMTP id adf61e73a8af0-3a7f1bc3fa6mr11902179637.31.1777935807188; Mon, 04
 May 2026 16:03:27 -0700 (PDT)
Date: Mon, 4 May 2026 16:03:25 -0700
In-Reply-To: <CABXGCsO5RCdgE0rhY_NXOmvKCDX0q=sifNryMK3qYwUuDze5AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com>
 <afjcCBGzuZU2iON9@google.com> <CABXGCsPTbCdfrwWAtXOb7wOMUOgtL=hpsYYXXQrosoUjj_WkYw@mail.gmail.com>
 <CABXGCsO5RCdgE0rhY_NXOmvKCDX0q=sifNryMK3qYwUuDze5AQ@mail.gmail.com>
Message-ID: <afklvRDc4wwzjkhJ@google.com>
Subject: Re: [PATCH] x86/virt: Fix RCU lockdep splat in emergency virt
 callback path
From: Sean Christopherson <seanjc@google.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Dan Williams <djbw@kernel.org>, Chao Gao <chao.gao@intel.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026, Mikhail Gavrilov wrote:
> On Mon, May 4, 2026 at 11:50=E2=80=AFPM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > What direction would you prefer? I'm happy to spin v2 as needed.
> >
>=20
> After looking at how other places in the kernel handle this =E2=80=94 ker=
nel/notifier.c,
> kernel/cgroup/cgroup.c, kernel/fork.c, kernel/sched/fair.c all use
> rcu_dereference_raw() when the caller has context-specific knowledge that
> makes lockdep checks inappropriate.
>=20
> I'll send v2 using rcu_dereference_raw() with a comment explaining the
> panic-context reasoning. The diff would look like:
>=20
>   /*
>    * The crashing CPU may be outside RCU's watching set in panic context.
>    * Use rcu_dereference_raw() to avoid lockdep complaints =E2=80=94 the =
writers
>    * (KVM module load/unload) cannot run during emergency virt callback
>    * invocation, so the pointer is effectively stable here.

AFAIK, nothing actually prevents module unload when the kernel is panicking=
 and/or
rebooting.  E.g. see commit 2baa33a8ddd6 ("KVM: x86: Leave user-return noti=
fier
registered on reboot/shutdown").

>    */
>   kvm_callback =3D rcu_dereference_raw(kvm_emergency_callback);
>=20
> Let me know if you'd prefer a different approach (option (b) from my
> previous mail =E2=80=94 converting away from RCU entirely =E2=80=94 is a =
bigger change
> but I can do that instead).

For "normal" usage, if there really is even such a thing for this case,
smp_store_release() / smp_load_acquire() won't suffice, because the kernel =
needs
to ensure the module text isn't freed while the callback is in-flight.

But as you noted before, if the kernel is panicking, (a) the window for any=
thing
to go wrong is comically small, and (b) at some point the kernel _can't_ gu=
arantee
that everything will be "fine".  So I'd probably be ok with just sweeping t=
his
under the rug?  Assuming we can't come up with an easy-ish solution that do=
esn't
require taking locks (which to me, would have a higher probability of causi=
ng
problems).
