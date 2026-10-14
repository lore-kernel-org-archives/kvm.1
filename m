Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3C37E5D7
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004999; cv=none; b=WTVVrVWQet/7avjJxneI9hXqzSZEGO5jxJhCwje973ju9MwPHHRPdCaYI1RSjxnwagYodCm4AJTt7JVR2mtCiviRYx6wtR3OdKTjhZms94vSKIjUYB1RTfb2R56laSyh+KcW3IAFwDoHOkf5pS84wOMYm0RXb3T51EwmZSWKYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004999; c=relaxed/simple;
	bh=AZumQ/MyBylnYpWy5mkdsMGT7C0uzs0HGB2JsqiPx34=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=e30ohVg4HyUqY1Dg4RzKywWhy6ST61dlBRsSaDlUDH9v58pYccXROb9bv63mT5T5XJHKrQMa/4/8+XG8UL5OwQmDBMgmappAMDxVAwsIEbLp9sypvMQnzsaJCkAxOBB5DNb4QtwtJUuRzGj7v96zboOd2S5FFhkvMW8ctmt91XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0a3dyWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0a3dyWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B7B1F000C4;
	Wed, 14 Oct 2026 19:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792004998;
	bh=+G+yt4W88sE5Md2tBsC9gw9lr5fNouURpoR05tLCTbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B0a3dyWGyWjfI1EXprV06jUR+ZXc9uGgjL5NSao289XO4zDc5V10j+XaHHy/58Q1F
	 pDfKwUM8KUj3+Yywu7k3TwXKMMEVVre1iTYQw4Z37O9/VirWV2tShI/DdJ55R/eZN8
	 WREq9MqDNsITTN72YHzWabCxkRkc1lCH8NvuMGIqXuLhQQ3KByEpbjQ032QpmE1jxb
	 T57Y18PEQztC+De7GSH6N6KGidHtM313PgjGtTCSF3IN23ELvTiF6prJbWyPfh1vAF
	 aLU+0220spN94KLuZzvLo6/2zECu5aDZZSjFqyVMp2FtWMBWfL0+tVOZqAa/YzreOG
	 byaR02TXhir6w==
Message-ID: <sashiko-outbox-171754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Disable preemption around
 host-side HPT lock users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261014185215.71832-1-amachhiw@linux.ibm.com>
References: <20261014185215.71832-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 19:09:57 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: missing preempt_disable() in kvm_test_age_rmapp() leading to =
deadlock
--

commit dbd9d3f82d3dd2c11f69c26045433b125bc70408
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock users

This commit disables preemption around host-side virtual-mode paths that
acquire HPTE_V_HVLOCK and lock_rmap(). This prevents a permanent CPU hang
where a preempted host thread holding either bit-lock blocks a spinning
guest vCPU thread.

> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 2ccb3d138f46c..8d85ce3440ae3 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
[ ... ]
> @@ -890,6 +913,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm=
_memory_slot *memslot,
> =20
>  	rmapp =3D &memslot->arch.rmap[gfn - memslot->base_gfn];
>   retry:
> +	preempt_disable();
>  	lock_rmap(rmapp);

[Severity: High]
Does this same deadlock risk apply to kvm_test_age_rmapp()?

Looking at kvm_test_age_rmapp() in the same file, it also acquires
the spinning rmap bit-lock without explicitly disabling preemption:

arch/powerpc/kvm/book3s_64_mmu_hv.c:kvm_test_age_rmapp() {
	...
	lock_rmap(rmapp);
	if (*rmapp & KVMPPC_RMAP_REFERENCED)
		goto out;
	...
}

kvm_test_age_rmapp() is invoked via MMU notifiers (like
mmu_notifier_test_young) holding the PTE lock. Under PREEMPT_RT, the PTE
lock is sleepable and does not disable preemption, so lock_rmap() is
acquired in a preemptible context.

If a host thread holding this bit-lock is preempted, and a guest vCPU
thread on the same CPU executes a virtual-mode path like
kvmppc_virtmode_do_h_remove() (which disables preemption) and attempts to
acquire the same rmap lock via remove_revmap_chain(), could it spin
indefinitely without yielding?

>  	if (*rmapp & KVMPPC_RMAP_REFERENCED) {
>  		*rmapp &=3D ~KVMPPC_RMAP_REFERENCED;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014185215.7183=
2-1-amachhiw@linux.ibm.com?part=3D1
