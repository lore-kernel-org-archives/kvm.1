Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EED2FB969
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782422403; cv=none; b=dUSGGio3E99BykQvmzdOXTYnAJiBIQ32BgLLAEbP98GpQ5ARDYVGYvV+IAO6i6v+LOP66zexXFFIXXfXm9JfujD4iB0ETZ+4x+6Aq2uXa5Cq0bGlMc2W3EXRp+Zj6nYNL+yFwLtcDJtoxFShw+GaH7qXa9+0FtLz9kYYxa6EHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782422403; c=relaxed/simple;
	bh=enNGGewEjICbgNZ1Btny9TYC3LtlQbIimwOrtBKRFbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYBKqDAV2f/LWcF3CGlJUkr6PEsHV6wkgdppVjqJdcQyJyzufl78MapLj5bJT9gvg6UxZllnvHvKi33ubJbzKAKvaQq3PPixIUYzOk2mRfo8po2M3pLviFvXOwPpofy+a7CJ9J0/y9GpF70UOwkUxlVQydu+Czq3hyD8Nh0A1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQENWvqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQENWvqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6561F000E9;
	Thu, 25 Jun 2026 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782422401;
	bh=ev7R62aBFc0Tf+FUvJtxX8WlXB4Eq3xrpDz2gQy9pow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KQENWvqShr2aqWJommpy6pixZ3Eto+D2CE4tWbZ2iUi6F1+WJbXr3W4+tmUzt56QR
	 DTfxAxeHe42sqhxSimpBO+KQAEe6kOY97kfYF/Rztb8urvhl50rGuusAUqgrY5GTUJ
	 eFRLZFKhTxQdiiTdeDUwMFUGl5j5W/lwUa9tNKr2627muG/n2n+m8x0aE+F+rM+b78
	 LnZyxRLD04ylgm1aF3xDsuMY6AxEXs2X5AjuZEdsVaVycJKpGS/kyF/8OzgUYSwLhu
	 PP3aZTxujHEKvlIZ1aMqw6VCUYBM64o7Rr/iDYugU2l5s8ybRI8Y4XcnpiYwVMzW7T
	 R7bRYXmGwj21Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: x86: Exempt in-kernel PIC from "disappearing"
 interrupt warning
Reply-To: sashiko-reviews@lists.linux.dev
To: syzbot <syzbot@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <86078441-92eb-4461-b823-7d3539ac5859@mail.kernel.org>
References: <86078441-92eb-4461-b823-7d3539ac5859@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 21:20:00 +0000
Message-Id: <20260625212001.3B6561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `!pic_in_kernel(vcpu->kvm)` check inadvertently suppresses t=
he warning for APIC bugs in the default full-irqchip mode, contradicting th=
e commit's intent.

Pre-existing issues:
- [High] A malicious guest can still trigger the `WARN_ON_ONCE` in `kvm_che=
ck_and_inject_events` when KVM is configured with a split irqchip and Xen e=
mulation is enabled.
--

commit a01ce83aaf4bff44e757aa3ac163f97e316b3056
Author: Alexander Potapenko <glider@google.com>

KVM: x86: Exempt in-kernel PIC from "disappearing" interrupt warning

This commit addresses a time-of-check to time-of-use race condition in the
in-kernel PIC that triggers a kernel warning when an interrupt disappears
between check and fetch. It modifies kvm_check_and_inject_events() to exempt
the in-kernel PIC from this warning. The intent is to preserve the warning
for other interrupt sources like the APIC.

Link: https://syzkaller.appspot.com/ai_job?id=3D0b59ccd5-8820-460d-84d3-94d=
f6307bd6a

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -10857,7 +10857,9 @@ static int kvm_check_and_inject_events(struct kvm=
_vcpu *vcpu,
>  		if (r) {
>  			int irq =3D kvm_cpu_get_interrupt(vcpu);
> =20
> -			if (!WARN_ON_ONCE(irq =3D=3D -1)) {
> +			WARN_ON_ONCE(irq =3D=3D -1 && !pic_in_kernel(vcpu->kvm));

[Severity: Medium]
Does this inadvertently suppress the warning for APIC bugs in the default
full-irqchip mode?

Since pic_in_kernel() evaluates to true when the in-kernel PIC is present,
checking !pic_in_kernel() disables the warning entirely for all interrupt
sources in that configuration. This appears to contradict the commit message
intent of preserving the warning for other sources like the APIC.

[Severity: High]
This is a pre-existing issue, but can a malicious guest still trigger this
warning when KVM is configured with a split irqchip and Xen emulation is
enabled?

If a guest concurrently toggles its evtchn_upcall_pending flag in memory
while the host executes the event injection loop, it seems this path is
directly reachable. Because pic_in_kernel() is false for a split irqchip,
the warning could still fire and potentially lead to a host panic if
panic_on_warn is enabled.

> +
> +			if (irq !=3D -1) {
>  				kvm_queue_interrupt(vcpu, irq, false);
>  				kvm_x86_call(inject_irq)(vcpu, false);
>  				WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/86078441-92eb-4461-=
b823-7d3539ac5859@mail.kernel.org?part=3D1
