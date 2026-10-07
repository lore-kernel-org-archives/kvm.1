Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA93F99E3
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398860; cv=none; b=WL1lKmw+kR+LfVII8nWXPZqG13qr21owS2PTmQvJ3VH50IQljTsvLyGjL9UtspcZDF8Pa6kDi8VAJfnWPQn5FQBeJVZPxb+9POgCdFJv4+OWMSGs2zYbUoT/VzOztFxuqG15gxDfYuZyO7dETzMfaPo+Fi2kHxHDL1FE4HdyaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398860; c=relaxed/simple;
	bh=PE0QOIKRTkqLEbYLhE+1t6CYgYqRn3RknBLUViZS9FY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RX4mu9cjR8FzobF9tw5XJzxj4FTanqnuHlLOlgEtp+mi6SgsEy1OvvpYDL9bQt9R+wGK77/HdcTBSLlkEmlmzsl75MEBqYtmI0u+YIokvWKBGmgt4UTzigMIBUioMYN93xkddqRxZt2wMeD9wBxTS6WehzeKqURrKyHEG0TaTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0tB/BCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0tB/BCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B471F000FF;
	Wed,  7 Oct 2026 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791398859;
	bh=L9Z1yagLVw1E68feq8pFcVxkjMpuMzHUr0zQlJxNYho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0tB/BCVFymHoL8ZblKGm1EiksWK1QfzT9fRmOgCbQiIYE3n2pChcfNFAp2tdPC8k
	 Ta2RrVN7EWtTNuv3ZgWj76l/7ruS1r/tyR4dSCdbkAJJIqEJY4l7Ql+BVaMDiOmYaj
	 z3TgYrQCSDm2/8tQIKRZ3Joe8ljYXA5xjCYNr0pHC8r8f2BeJ+LN9R7/u8ocshs2Su
	 ey0RhVOj3WQFoGdSkE0fzQOh4b6s9l74e6t89+M8c1/OgZFT915XPqYrDucVbQ4sUD
	 MGXHjKb/UjiqIPY+SpP2AxXK6XneofVszxaCqR582EN0brEvWQzDF732Cn7KCGhmMl
	 aEHHFH7LKTSQw==
Message-ID: <sashiko-outbox-163301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] KVM: PPC: Book3S HV: Add preempt_disable()
 around virtual-mode HPTE bit-lock users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261007182116.12479-3-amachhiw@linux.ibm.com>
References: <20261007182116.12479-1-amachhiw@linux.ibm.com>
 <20261007182116.12479-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 18:47:38 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: deadlock in kvm_test_age_rmapp() due to missing preempt_disab=
le()
--

commit 6b1add31442320e6307f450d080fd72f64ee2368
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-loc=
k users

This commit enforces that threads acquiring HPTE or RMAP bit-locks run with
preemption disabled to prevent CPU hangs. It adds preempt_disable() and
preempt_enable() pairs around various bit-lock acquisition paths.

> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 2ccb3d138f46c..e8f73c8f97803 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -890,6 +913,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm=
_memory_slot *memslot,
> =20
>  	rmapp =3D &memslot->arch.rmap[gfn - memslot->base_gfn];
>   retry:
> +	preempt_disable();
>  	lock_rmap(rmapp);
>  	if (*rmapp & KVMPPC_RMAP_REFERENCED) {
>  		*rmapp &=3D ~KVMPPC_RMAP_REFERENCED;

[Severity: High]
Does kvm_test_age_rmapp() also need to disable preemption before acquiring
the rmap lock?

Looking at arch/powerpc/kvm/book3s_64_mmu_hv.c:kvm_test_age_rmapp():

	lock_rmap(rmapp);
	if (*rmapp & KVMPPC_RMAP_REFERENCED)
		goto out;

This MMU notifier callback still acquires the KVMPPC_RMAP_LOCK_BIT without
disabling preemption.

If a thread is preempted while holding this bit-lock, and another thread on
the same CPU begins spinning for the same lock with preemption disabled
(such as in the newly patched paths), couldn't this result in a permanent
CPU hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007182116.1247=
9-1-amachhiw@linux.ibm.com?part=3D2
