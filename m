Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74A2D6E5A
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016240; cv=none; b=KWMYZYH8rDgKEffhUoSWKDcMm6yglOPCvoaCfeDufwwcKp6N0htekcPtA+46N5KTPRNVkXM/FOca56kp2OecSDxZ+Dg4MnCKid5+5vbF8WQ6f0+MuNvFdSwGJvsiowfTnKyn5E//+xp1LQyeGt/2KCUVynm7WqjeUEcBLBc8ZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016240; c=relaxed/simple;
	bh=R1QpTuVJAmEPR1jA3ihXYCoEzZ2EPkr74jVYj2KTdcw=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ViAmBZKPw151DaREdHcOwWXrPnLL1hyJQWVseOTS4wj5Vub/BzXWbpz3AG/eXcNJSsww2PA5xRW7edEChylovbe5+lhf6vyhEhDnjp9we6HuwTGypKCiVsGYdWMH3N2gXfeW9IN1SMWSjj4AUpRMGhx6y0Fl0BzkW4Z1mArgvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK57QYc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK57QYc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5751F000C4;
	Wed, 14 Oct 2026 22:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792016238;
	bh=cwEVg2dnO/lmuuvDx/Q575IVhIbvBPPzLB/Luh0JUPI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FK57QYc521c9PCrCLHpIOQZyLGcC5XVdosvIUkUXZ+/7IVSbqbIOfNQgRlOup53dZ
	 /fTISTAPETrba6EVckGHJvE3yYwc/Y0SlBlTpNnQBiavPHZXYep3bjsBsL2Y4joj4j
	 7Rc6e2FUYxHQdbdPp62pTIdXJczlwRrjyfIafKG+NASYIGRXqGO6W8l4ost4tZcLok
	 lzc1W2AN9fDr4zZZ3FX3ZoR/E2kNYuwOizPxLJBDkQVT2uFjGk6xRD4z0n04GWnbjf
	 XtzOWb1/XaqaUbkfwUf+njgBcLhQA3uR1w7W7I0nW+MlbWZJikt6xOVzHCtuqRYBp8
	 02tKJXHS6qAEw==
Message-ID: <sashiko-outbox-171955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] KVM: x86/xen: Don't lose the timer event when
 delivery fails transiently
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261014220508.518772-6-dwmw2@infradead.org>
References: <20261014220508.518772-1-dwmw2@infradead.org>
 <20261014220508.518772-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 22:17:17 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86/xen: Stale hrtimer expiry used when re-arming past-due ti=
mer in GET_ATTR
--

commit 3d44826b4ceac0133a07269c9831163b8fa3607e
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Don't lose the timer event when delivery fails transiently

This commit modifies the KVM Xen timer injection logic to retry deferred
timer events if the event channel fails to set due to transient issues like
memslot updates. It clears the pending flag on unrecoverable errors while
preserving the expiration to allow migration and retry. It also updates the
GET_ATTR timer path to avoid re-arming the hrtimer when delivery is pending.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index cd1063d659cc5..f1be9022bc6fe 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c

[ ... ]

> @@ -1296,8 +1319,20 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, s=
truct kvm_xen_vcpu_attr *data)
>  		 * That's fine, as the guest won't even have had a chance
>  		 * to run and handle the interrupt. Asserting an already
>  		 * pending event channel is idempotent.
> +		 *
> +		 * Don't re-arm if the flush above failed transiently and
> +		 * left the timer pending: delivery is owned by the retry
> +		 * on the guest entry path, and an immediate hrtimer fire
> +		 * would race it =E2=80=94 the callback's timer_pending suppression
> +		 * check is not serialized against the entry path, so a
> +		 * late callback could re-assert a port the entry path had
> +		 * already delivered and the guest already consumed.
> +		 *
> +		 * An expiry already in the past fires immediately: the
> +		 * event is still owed.
>  		 */
> -		if (vcpu->arch.xen.timer_expires)
> +		if (vcpu->arch.xen.timer_expires &&
> +		    !atomic_read(&vcpu->arch.xen.timer_pending))
>  			hrtimer_start_expires(&vcpu->arch.xen.timer,
>  					      HRTIMER_MODE_ABS_HARD);

[Severity: High]
Does this re-arm the timer using a stale expiry time if the original timer =
was
set in the past?

In kvm_xen_start_timer(), if a guest sets a timer that is already in the pa=
st:

	if (delta <=3D 0)
		xen_timer_callback(&vcpu->arch.xen.timer);
	else
		hrtimer_start(&vcpu->arch.xen.timer,
			      ktime_add_ns(kernel_now, delta),
			      HRTIMER_MODE_ABS_HARD);

KVM directly calls xen_timer_callback() without calling hrtimer_start().
Bypassing hrtimer_start() means the internal expires field of the struct
hrtimer is not updated, retaining whatever previous timestamp it had.

If xen_timer_callback() fails to deliver the event, and then
kvm_xen_inject_timer_irqs() attempts delivery but fails with -EINVAL, this
patch clears timer_pending but keeps timer_expires > 0.

If userspace later calls KVM_XEN_VCPU_GET_ATTR, it sees timer_expires > 0 a=
nd
timer_pending =3D=3D 0, and attempts to re-arm the timer here using
hrtimer_start_expires().

Because the internal hrtimer expiry was never updated, would
hrtimer_start_expires() arm the timer using the stale future expiry time,
effectively delaying the past-due timer and causing it to hang on the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014220508.5187=
72-1-dwmw2@infradead.org?part=3D5
