Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21329B799
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251862; cv=none; b=CP3WXfENhEvtQc6CxfQiAUxtm+4O7jzB1VmuvRUYlp9g0vgoM0k19/BuyaHUIBdJY0VJLTG3w+MkStBhk8s3gQtr/CLu/K2xQBxVDZUe211f37uGd+SuEkxvRV0/xl8EdEwLBgrotFDeD34HmxN5WTop+bNoCx3qMnlqA5TxoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251862; c=relaxed/simple;
	bh=RQXhrAxS+5HMJzlpC3+4RLRmV4wVi8m+dvohboxdEBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nDB28M2b6qMF5uVUp9yQIgrTkKtk7mVvtQfoxffuqVFSwcst7OW1W3TsHD3d1QhOtUfX+4G24q9TieqdIvPfAnq/0Rd2b8+XUzbdrAlP+FaMjHO3sefMwcNiK3lGik5YwIRv1pRPGS7e75tpRlnRludQkwI+JnZJN2XdESMZgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR5ihCHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR5ihCHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15F61F000E9;
	Tue, 28 Jul 2026 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251861;
	bh=qthhGJMWKVoWosHs5b9lU2LM+DmbpVrz/rpiE1e/EZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JR5ihCHfwDzhSkdrE441P4pe+fYg0/GN2h0ETpdXaY5SE3l3+82Ym3d8LBTia7gMG
	 C4JknwZ3ffd/Q7v0xEdVfXzu0sCIhKpEpZkQre4S59VBJC0Wh3mS701BRIakFUDOws
	 DsStJ3EMZGnHvraFrzXOIaeISVBgCFT29C/KQj6Cb7Uv93brXj+d+16dzG72wVR7EP
	 V6fCohj8l4kefICZ6d+WUi0DJHx8n5jLYBpTm2O6/+b9sXqJO0Insr/SsS2NnFBXTH
	 LTRq64IR7pYimDhPPtvuUWEreM+TUNVtR8tXZ9daiMarWuMHVr0oD1wIyP7o9cnDG0
	 /gsiR795XaOkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/36] KVM: x86: Activate master clock immediately on
 vCPU creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-4-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:17:40 +0000
Message-Id: <20260728151740.E15F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent executions of `kvm_update_masterclock()` result in the =
premature clearing of `KVM_REQ_MCLOCK_INPROGRESS`, breaking the masterclock=
 lockstep guarantee and potentially causing guest time monotonicity violati=
ons.
--

--- Patch [3]: [PATCH v7 03/36] KVM: x86: Activate master clock immediately=
 on vCPU creation ---
commit 18307085611864bcc1224b0b19ac499526c3034f
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Activate master clock immediately on vCPU creation

This commit calls kvm_update_masterclock() directly from
kvm_arch_vcpu_postcreate() to ensure the master clock is active immediately
after a vCPU is created. This allows KVM_GET_CLOCK to return a valid host_t=
sc
and realtime pair right away, avoiding the need for a dummy vCPU run.

> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9385,6 +9385,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  		return;
>  	vcpu_load(vcpu);
>  	kvm_synchronize_tsc(vcpu, NULL);
> +	if (!vcpu->kvm->arch.use_master_clock)
> +		kvm_update_masterclock(vcpu->kvm);

[Severity: High]
This isn't a bug introduced by this patch, but can this new call trigger a
pre-existing race if multiple vCPUs are created concurrently?

Looking at how vCPU creation is handled, kvm_arch_vcpu_postcreate() executes
after kvm->lock is dropped. If multiple threads create vCPUs concurrently,
they can call kvm_update_masterclock() at the same time.

In kvm_start_pvclock_update(), the in-progress request is set before
acquiring the lock:

	kvm_make_mclock_inprogress_request(kvm);
=09
	/* no guest entries from this point */
	__kvm_start_pvclock_update(kvm); // acquires tsc_write_lock

If Thread A sets the request and blocks on tsc_write_lock, and Thread B
finishes its update, Thread B will execute kvm_end_pvclock_update(), drop
the lock, and then clear the request unconditionally:

	raw_spin_unlock_irq(&ka->tsc_write_lock);
	kvm_for_each_vcpu(i, vcpu, kvm)
		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);

	/* guest entries allowed */
	kvm_for_each_vcpu(i, vcpu, kvm)
		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);

Would this clear KVM_REQ_MCLOCK_INPROGRESS while Thread A is still
waiting, prematurely breaking the lockstep guarantee and allowing vCPUs
to enter the guest with partially updated or stale clock data?

>  	vcpu_put(vcpu);
> =20
>  	/* poll control enabled by default */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D3
