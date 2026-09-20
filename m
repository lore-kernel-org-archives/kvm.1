Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5F434992
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908625; cv=none; b=s8NOA/wEWY8b77RAji6LJu4WLTHNfRdQsXKKZRtIQItXdqM8oepVsL15mK7vZrtfE+QVsUnhsMC6temGAbzywNT4H5fJdbdIEMc+nmdeH6OhRmHFKC5GFJsCOtPAeVIX8jQGUlnCRR9mBwsl2ZQ/c0E9rmojmnl2RD86WyWhhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908625; c=relaxed/simple;
	bh=zp6SDC6KmiFn/QD5z9H419yKUXCLBlibh/2R1OaaRvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j3sz/ZPMzNLd3X6STzPeWXJIk9eYuBHgj5kft92hinO+CfOOTYwG9AiSXltIwLSUJ+n/p7FC318Wih1nGi1K614DtDEyGKJrM0iAlDxECUAiXdjGf1T31n3c+3NXCONOHjmYWJdDOzj4Fl+DnyrorSTjG19O07FadTmrc3KEdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrgzsrLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrgzsrLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A37B1F000FF;
	Sun, 20 Sep 2026 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789908612;
	bh=p1qjPTAsscumYVSGeS7YgOdQ7LDUajSBnnXl2JmmeMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RrgzsrLy8zOmtFHXX5ay+dZAnu+VsGv9E6Ur2tQrphOAweHnHko+jKU1lSLHo3ZB7
	 ttuBdM0gljt/b3No/j/2hw/eYNs64wrJ4yq19+/4J1slBzjs0Gm33GFlVzNGsySRdw
	 K4EmczeIL67smR4gxBNJdUEHKuYmTIQvopPl0QkANMdJAfGAtr9PQzI3jvlt5yphKt
	 Pk2bYpSb5tDDD67zu84jc5XVO38EXLl3LQ5ZyldI+4n081hlU//U9rOfPDQ+rzKWQs
	 P1yqWjfBEvavusqqlro8qzoRozmmFm3NFYLDYofoN56qNRMPwkj849lmvQsd73p+JB
	 A6cFl7jWoX6ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Free detached G-stage page tables outside
 mmu_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Can Qi" <qican5708@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260920123117.49830-1-qican5708@163.com>
References: <20260920123117.49830-1-qican5708@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 12:50:11 +0000
Message-Id: <20260920125012.6A37B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: riscv: read_unlock() with IRQs disabled triggers PREEMPT_RT W=
ARN
--

commit 4942abf031219dcd47ba5f900125f636dc95e221
Author: Can Qi <qican5708@163.com>

KVM: riscv: Free detached G-stage page tables outside mmu_lock

This commit modifies the KVM RISC-V MMU to detach and free G-stage page
tables outside of mmu_lock to reduce lock contention during large VM
teardown. It quiesces guest and host hardware users before freeing the
detached tree, and replaces the KVM-wide split page cache with a
per-operation cache.

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 88e0c369b3544..da3308a3d0203 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -90,7 +90,21 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vc=
pu *vcpu,
>  	register unsigned long ttmp asm("a1");
>  	unsigned long flags, val, tmp, old_stvec, old_hstatus;
> =20
> +	/*
> +	 * Prevent G-stage teardown while HLV/HLVX can walk the page tables.
> +	 * The active-root check prevents a new walk from starting after detach.
> +	 */
> +	read_lock(&vcpu->kvm->mmu_lock);
> +	if (!vcpu->kvm->arch.pgd) {
> +		read_unlock(&vcpu->kvm->mmu_lock);
> +		trap->scause =3D EXC_LOAD_GUEST_PAGE_FAULT;
> +		trap->stval =3D guest_addr;
> +		return 0;
> +	}
>  	local_irq_save(flags);
> +	/* Publish the hardware walk before dropping the root lifetime lock. */
> +	smp_store_mb(vcpu->mode, READING_SHADOW_PAGE_TABLES);
> +	read_unlock(&vcpu->kvm->mmu_lock);

[Severity: High]
Does this sequence trigger a kernel warning on PREEMPT_RT systems?

On PREEMPT_RT, rwlocks are sleepable rt_rwlocks, and read_unlock() calls
migrate_enable(), which explicitly warns if called with interrupts disabled.
Since local_irq_save() disables interrupts just before
read_unlock(&vcpu->kvm->mmu_lock) is called, it seems this would cause a
WARN/BUG splat in kvm_riscv_vcpu_unpriv_read().

This path appears to be reachable by any untrusted guest capable of issuing
unprivileged accesses that trap to KVM, making it a guest-triggerable host
issue in PREEMPT_RT environments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920123117.4983=
0-1-qican5708@163.com?part=3D1
