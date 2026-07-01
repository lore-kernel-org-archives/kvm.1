Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940B38E8CE
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931341; cv=none; b=cv58eFhoPxhs3YVr6C7h74vEDjyC4UhDRNAnt28eZ/BpnK+5f+MS7JGHXyv6L+i+O2l9N6Yh1UKvJ2QNG06gP58Y0dMrF+DUQClsOr2ciyFSBkA4Icrwzr17pK7uI7MxbSsZDO1wt3Het9FtfR4iX0/E0ZQxg+EXYhN+HmvBajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931341; c=relaxed/simple;
	bh=66NDd1QfNl3gQTdu/vgEhMi3xLsBCCz4YeXlCCXfRUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JSLLhZu785z1Xmx4mOW3QHQo1Jd5X3qRj5BfV7DHaPR7qyVOZ5R4ZTiFxqEOtpbQay0xgGC85iA5GYB/FjlBv6Y3qbNmz6Tx4hOEMYdNpukUsqXlk7oiPDn3ORW7Wg7DOGi1Qsl8xymyICqSoxriq4DKc5CcGhNqPW2RwiNo/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a44VStf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a44VStf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF471F000E9;
	Wed,  1 Jul 2026 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782931340;
	bh=bS+xuxwc5imenQXjINBaZBdFGVPsK7rX/bG1jkOgpSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a44VStf4fNm/VcGTLhy7wDmivcU9Wuy3MjLsu79RyvhzoGQIJ/IqelHrPSvq51sxh
	 dniOJMEceCW3zTRv7xZOLaRO/pgCRGAlhkGRu/gwKUlrRLa8kgBYNGV+ceClZb54Dm
	 5yRz0Jw5kP+dmXIBq6xz1h6pgjumJmDzXjg1ExkEYJVVCrK2X7qFlB8eP3Zqr/xmB8
	 xiMWAiEwR4J2gpUwGFyY151a/xiZHcQWI2io3LnCTRmvzAAGT3uP3MngW3n74ssq0R
	 xmnzbNQP4jXLvn7xq4Pmi5+f5EhQGzaYfPxgfvo9kzkJFFi2U8GAPeQH5jexKA7Ur7
	 c1BSAYU/MqeYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] KVM: powerpc: Use generic xfer to guest work
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishal Chourasia" <vishalc@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260701183030.3610451-2-vishalc@linux.ibm.com>
References: <20260701183030.3610451-1-vishalc@linux.ibm.com>
 <20260701183030.3610451-2-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 18:42:19 +0000
Message-Id: <20260701184220.5BF471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Early return on pending signals bypasses the vCPU exit tracepoint
--

commit 902f7514807a6e7be76bed1f71c7055f873978b8
Author: Vishal Chourasia <vishalc@linux.ibm.com>

KVM: powerpc: Use generic xfer to guest work function

This commit replaces open-coded need_resched() and cond_resched() checks
with the generic xfer_to_guest_mode_handle_work() infrastructure in powerpc
KVM run loops to properly handle deferred task work like CFS bandwidth
throttling.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3b..a1b2077561bb5 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c

[ ... ]

> @@ -4899,8 +4923,21 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u=
64 time_limit,
>  		}
>  	}
> =20
> -	if (need_resched())
> -		cond_resched();
> +	/*
> +	 * Run pending work before (re-)entering the guest, most importantly
> +	 * task_work queued via TWA_RESUME (e.g. the deferred CFS bandwidth
> +	 * throttle, which only sets TIF_NOTIFY_RESUME). Without this a CPU-bou=
nd
> +	 * vCPU that keeps returning RESUME_GUEST never reaches an exit-to-user
> +	 * point, so the throttle is never enforced and the task runs far beyond
> +	 * its quota. The helper also handles reschedule and signals, replacing
> +	 * the cond_resched() that was here. It may schedule(), so it runs befo=
re
> +	 * preemption and IRQs are disabled, with no vcore/KVM locks held. This
> +	 * is the per-reentry site shared by the bare-metal and pseries (nested)
> +	 * paths, so both are covered.
> +	 */
> +	r =3D kvm_xfer_to_guest_mode_handle_work(vcpu);
> +	if (r)	/* -EINTR: signal pending, exit to userspace (KVM_EXIT_INTR) */
> +		return r;

[Severity: Medium]
When kvm_xfer_to_guest_mode_handle_work() returns a pending signal, this
direct return bypasses the done: label at the end of the function.

Since trace_kvmppc_run_vcpu_enter() is executed unconditionally at the start
of kvmhv_run_single_vcpu(), does this early return cause unbalanced
tracepoints on signal-driven userspace exits? This might break performance
monitoring tools that rely on symmetric enter/exit events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701183030.3610=
451-2-vishalc@linux.ibm.com?part=3D1
