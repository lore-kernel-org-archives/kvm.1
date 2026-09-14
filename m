Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF6489875
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399443; cv=none; b=eF1QHE4a0y/9xJXmES3L4gKNdlXrXUDCwlEqek/7sAr2GvmeM6B0wFqs1l9rtOkUfAE/81xKLZ4yauHXC8/dcs1Y2JOSQpQlxpgQD3VTgGhG7S9SxVprlL5XSQi3p19u2+6aZE/BGS5h12mXoV232aYMMgam1N9F4GwEt7PXRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399443; c=relaxed/simple;
	bh=Dp1r9+b5Hs9Uh3OVe9GcXcWDzCu2xvMsVrqQUoo0b6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EoD5/ieryi9ZmHeVIroT6/XASUM+0/cVXFRcXOG0QmOl6QhexkKjDt64mUH+SP2Xb9Q1YvmUUpAcx1Op/oRUY+f1S3Z4IfgvXjMDDfSINvP2P8jy+5FyK/IUmsNVuRHPg9Z/8r5OQMBzbRj/RV6zxaXGp+p8ulTaFbtxIHrtc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSgclG00; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSgclG00"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so1073560b3a.1
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789399440; x=1790004240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PBy5/r8Ty8ZUvAoaRhMuHW5wuQOXtAxIcP8jqfHdgR8=;
        b=rSgclG00ZsR0FrRm5TmrmODSdbg2tgsyxnzBA9N04AlBVkBR4cqdMC6VTQocHYjDwK
         LIfGkKKIKnBUEg0gLVWsH5Qy9LsBy0zBBIRoQ7vAj1O8MK7mHcxn4Y7XyBkbO2diL0MB
         4TMRbLzrQhHNIL+THKaF3F2YkWfl9fkibi9XL9iJAj6ETHKpDKii5XoYN7eqRlHTEQD2
         AntXot+C9m/A4pdIyWqJ6rGP/PrHci7TiPEax3l7ZpGI8RV2Te+aQwr4Orb+a2myb8Q2
         wP3MiArneieywivkDqceVKdbB9NwPe3iBDBnvRGxh4Htn8QHhThEaT99zJX+gxIcIY3U
         G9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789399440; x=1790004240;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBy5/r8Ty8ZUvAoaRhMuHW5wuQOXtAxIcP8jqfHdgR8=;
        b=oNkGLQKz7rSXVIskLM9W9jHvhtLlaKoZ49G/7smsbfM47cjHxUHAmLmm6ZX77Zopuq
         sFKiZPwSgLUrb2HdXsebgqXg+PNfTeeZydiqW5im3EU+lHaS9lHEjuoF6D97Mm++ov0u
         a3mntCrUUqw/DGYGEjNrRkpcWGRZDts0yi7qPtHPI/KNKtpMkJXKd7CLiFUploUnXwfW
         1GjMNJzUfjLAC1UJSTG8lq2wgSXdwlHLI1PUdsJ8pdjgmBOGHKb8HqMYzpdXC3k3F+il
         YFPm/qy3Y+TQ5SoMfeEwuL7VMj6tCqxU5ReJ/Kz1dDF4w/Q5CNX9sxjHX0GBmWqJ9Yin
         2qKg==
X-Gm-Message-State: AFuF++nq8c6/Y9YS0Oo7rEJFVW5sbNWBI2REpf2n5zSFfDLCmCAZkgf2
	csT1SlnTF5/qt+z5DTdWFcs40Dx2IH+FZI9/Op85Aiaz0vn6rCjazFNZKPux8u8LJsVvXiH1jKv
	4U+KKLA==
X-Received: from pfgf9-n1.prod.google.com ([2002:a05:6a00:c589:10b0:84a:3ba8:3bf2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1791:b0:86b:43f6:67b7
 with SMTP id d2e1a72fcca58-86f82e5c9admr5856724b3a.4.1789399440212; Mon, 14
 Sep 2026 08:24:00 -0700 (PDT)
Date: Mon, 14 Sep 2026 08:23:59 -0700
In-Reply-To: <20260914143702.915401-3-aharivel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914143702.915401-1-aharivel@redhat.com> <20260914143702.915401-3-aharivel@redhat.com>
Message-ID: <aqgRj7mfDhCUqWw4@google.com>
Subject: Re: [PATCH RFC v3 2/3] KVM: x86: add KVM_CAP_CSTATE_POLICY for per-VM
 C-state enforcement
From: Sean Christopherson <seanjc@google.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026, Anthony Harivel wrote:
> Add a new VM-scoped capability that allows userspace to set a maximum
> C-state ceiling for host cpuidle when vCPUs halt.
>=20
> When a vCPU enters kvm_vcpu_block(), KVM temporarily disables cpuidle
> states deeper than max_cstate on the current pCPU using the existing
> states_usage[].disable mechanism (CPUIDLE_STATE_DISABLED_BY_DRIVER).
> After wakeup, the original disable flags are restored.
>=20
> The capability follows the same pattern as KVM_CAP_HALT_POLL:
>   - VM-scoped ioctl via KVM_ENABLE_CAP
>   - args[0] =3D max_cstate (-1 to 6, -1 disables the policy)
>   - Re-callable at runtime without VM restart
>   - Memory ordering via smp_wmb/rmb
>=20
> This fills an operational gap for NFV and latency-sensitive deployments
> where the host operator needs per-VM control over idle depth without
> requiring guest cooperation. The enforcement is scoped to pinned-core
> configurations where the disable flags do not race with other tasks.

Sorry, NAK, this doesn't belong in KVM.  Given that the only way this can w=
ork
is if vCPU are pinned 1:1 to pCPUs, then it should be very doable for the c=
puidle
subystem to provide an interface to let (privileged?) userspace restrict th=
e
maximum C-state on a per-CPU basis.

My apologies for not responding to v1 or v2, I am guilty of Jim's axiom tha=
t
upstream doesn't respond to RFCs without code.

Pulling in the other options here:

+    The enforcement point is kvm_vcpu_halt() =E2=86=92 kvm_vcpu_block() =
=E2=86=92
+    schedule() =E2=86=92 cpuidle. The problem: cpuidle has no per-task
+    C-state constraint. states_usage[].disable is per-CPU, and
+    forced_idle_latency_limit_ns is also per-CPU.

I don't understand why per-CPU controls are a bad thing.  A task-based sche=
me can
really only work if vCPUs are pinned to pCPUs, i.e. you effectively need pe=
r-CPU
controls anyways.  And explicit per-CPU controls would allow for more relax=
ed
scheduling too, e.g. would allow affining vCPUs to a set of pCPUs without n=
eeding
to have strict 1:1 pinning.

+
+    Three options I see:
+
+      Option A: Temporarily toggle states_usage[i].disable on the
+      pinned pCPU before/after kvm_vcpu_block(). Set
+      CPUIDLE_STATE_DISABLED_BY_DRIVER for states > max_cstate,
+      restore after wakeup. Simple, works with existing API, but
+      only correct with dedicated pinning =E2=80=94 overcommit with mixed
+      policies would race on the disable flags.
+
+      Option B: Use forced_idle_latency_limit_ns on the pCPU.
+      Same per-CPU limitation, and latency-based rather than
+      state-index-based =E2=80=94 less precise.

Conceptually, (b) seems like the right approach.  Per-task will be a mess b=
ecause
similar to a KVM-based interface, it can probably only work if tasks are pi=
nned
to pCPUs.

And isn't abstracting away the exact C-state via forced_idle_latency_limit_=
ns a
*good* thing?  Without that, userspace will need to tune its configuration =
for
each individual uarch based on the properties of various C-states for a giv=
en CPU.

+
+      Option C: Propose a new cpuidle API for per-task idle
+      constraints (e.g. a per-task_struct annotation checked by
+      the governor during select()). Correct for all cases, but
+      bigger scope and needs cpuidle maintainer buy-in.
