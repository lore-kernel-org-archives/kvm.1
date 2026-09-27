Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2683C10BB
	for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790496703; cv=none; b=SHFw3QZ+zU/4xifG2qh7LtA27FIJfGuht1CqNTR0S2llIsoe7A53d5hf6QgBnYlh13m1356xdGTMY8bKLUPH2U5lP5ZTBAnJOrn6fgLONvhGKr1tg3PKglfePZqfT9sXdAbBfMaDFVoDOpNHWajWsmDqLzipd+NKuE1v6Xn2kq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790496703; c=relaxed/simple;
	bh=TPvs3QQQOfRrKdnSi+/hoqODV0WBh4yTcnGfA3v5bvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dhTvKewGpynCqeAocfS0CUzjZW63URDGXTpWSyD2PagUhHEls2driWpgKE3z+BvyponoX32sg/Eal553byH6ghYX6B49QyTvLOA1Yw3OHH2cacf4L6BRErtSQ3q93junaQzBcHuGUhIIIGwOajmdy02deWae7yGs7R1UCQvrbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAaZYgj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAaZYgj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D741F00893;
	Sun, 27 Sep 2026 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790496701;
	bh=ZzEWVBE41Bu7ZT/3rI6hmY4fx/4Va2K1CEelumts1As=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IAaZYgj9Z1h8wRISEciPAFUTyWGMNAPPFC44oY+rc1R4+WM1mMQUxtOLfKvLYLIq7
	 0iCFCrTNbzjxidmrx6Qni4Qc5IYlgZRlj6ee3OTIku7LpvTSOBvBElKrbZ/rJWRpCl
	 0aJxEfZiNZXblVtbQ6mtXSqGkjnOr2Xuatsf3fScTMWJa8PpFqqaRs2QxBXlJPCrRR
	 7a1AlwZpAFYDWnAqG1cXwqhkcFH19Gol7Vmd0GV6emzDo9BPERqrN9yLvcnR+mixRP
	 KuzLSjvc8wIrG3Vhz5F/sG5wfnJiygUYqRy9lMCKDOMN1CAavnldwW8rcdUpDbeLKS
	 JugaS0h+F0KBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] LoongArch: KVM: Rebase steal time counter in vcpu
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260927075240.3007947-5-cui.tao@linux.dev>
References: <20260927075240.3007947-1-cui.tao@linux.dev>
 <20260927075240.3007947-5-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 08:11:40 +0000
Message-Id: <20260927081141.68D741F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: LoongArch: steal time drops first preemption delay due to 0=
 sentinel
--

commit c0824aa7f32e751198a471b8af7a3432b9a7ad2e
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Rebase steal time counter in vcpu context

KVM_SET_DEVICE_ATTR(PVTIME GPA) initializes st.last_steal from the
ioctl thread's run_delay, but kvm_update_stolen_time() accumulates the
vcpu thread's run_delay; the first delta can be negative and wraps in
u64, so the guest reads a steal time close to 2^64.

Drop the initialization from the attr path and lazily rebase the
counter on the first steal update, which runs in vcpu context like the
hypercall path.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index ed9e092c97ba7..714bd87d1cea5 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
[ ... ]
> @@ -187,8 +188,14 @@ static void kvm_update_stolen_time(struct kvm_vcpu *=
vcpu)
>  	smp_wmb();
> =20
>  	unsafe_get_user(steal, &st->steal, out);
> -	steal +=3D current->sched_info.run_delay - vcpu->arch.st.last_steal;
> -	vcpu->arch.st.last_steal =3D current->sched_info.run_delay;
> +	/* acquire pairs with the smp_wmb in the attr path */
> +	smp_rmb();
> +	last_steal =3D READ_ONCE(vcpu->arch.st.last_steal);
> +	if (!last_steal)
> +		/* first update in vcpu context: rebase the counter */
> +		last_steal =3D current->sched_info.run_delay;
> +	steal +=3D current->sched_info.run_delay - last_steal;
> +	WRITE_ONCE(vcpu->arch.st.last_steal, current->sched_info.run_delay);

[Severity: Medium]
Since last_steal uses 0 as a sentinel value to indicate an uninitialized
baseline, what happens if a fresh VCPU thread's current->sched_info.run_del=
ay
is exactly 0 during its first call to kvm_update_stolen_time()?

If run_delay is 0, last_steal remains 0. When the VCPU is later preempted
and run_delay grows, the next update will still see last_steal =3D=3D 0.
It appears this treats it as an uninitialized state, rebasing to the new
run_delay without adding the preemption delay to the guest's steal time.
Does this permanently swallow the first preemption delay?

[ ... ]
> @@ -1204,8 +1211,10 @@ static int kvm_loongarch_pvtime_set_attr(struct kv=
m_vcpu *vcpu,
>  	srcu_read_unlock(&kvm->srcu, idx);
> =20
>  	if (!ret) {
> -		vcpu->arch.st.guest_addr =3D gpa;
> -		vcpu->arch.st.last_steal =3D current->sched_info.run_delay;
> +		WRITE_ONCE(vcpu->arch.st.last_steal, 0);

[Severity: Medium]
This sets 0 as the sentinel, establishing the ambiguity between an
uninitialized state and a valid run_delay value of 0. Could a different
sentinel value (like U64_MAX) be used instead to avoid overlapping with
a zero run_delay?

> +		/* publish the new address only after clearing the rebase sentinel */
> +		smp_wmb();
> +		WRITE_ONCE(vcpu->arch.st.guest_addr, gpa);
>  		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927075240.3007=
947-1-cui.tao@linux.dev?part=3D4
