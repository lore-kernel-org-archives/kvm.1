Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165D4B7A5D
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596652; cv=none; b=j6dfH2J/dH0B0bqSsXFM7yHd8cKDndMUXMQsRCO+7dmYk87jzkiZg5bnd3rfTWrg8X25j2p2GEwRBb3IlM180CGTgIfpxb34DMXWAXFNLB7R64p2HaObgcodZttrYaw2rCK3oSiHysGQNKIOocb5aeT3TDj6DDbM247cqJsEn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596652; c=relaxed/simple;
	bh=zJJc3iDmiqfZWD1GmDyXQ8dCs+surDxnB5XRqzPxIhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QepMgMLHSu1Wd9rpTRvOijqmA1Nno/BHpErCK/URSclXLfiqyjw5VgNZIAAN+qybPZz2U7idiIqftwG3/o/VhLgAWkPBBgCtpMpL67iFLbJCPvl/CLtK0t+HxHa+7IWoB4sm/A9gZlmUkjjzbLmLSvT9dg/2fm+UZeRPtuBTJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNdB5Zgs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNdB5Zgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E05B1F000FF;
	Mon, 28 Sep 2026 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596651;
	bh=KR3p0YL3OPXQ1Lq0CxFQXBboTf9iegewunBJnYsnVhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNdB5Zgs3763U1/8lbcFuL2chG4pI1DUZKVh8avxeYJswq5WsIxBHfsRN7trjA+3y
	 PEznxjYlrJbYoP13MN5DLwbl9FyGtsyncxs/XUuwLzO7o4RBTV15lHiFTBmts23ruV
	 akNT3jW9O9mf3041DMZGrIQcxpz1jVn7bT26Gm6t7IDC11KLCqWGSC0egSLK2Od6vh
	 2q7C2tMsBQhhuCSCHDwrMOqBmaeNo8DIb3zXccMwATOozrPGJ8uZgp/AupT5NEKVoZ
	 Ss7KrOPmtswt9cfHXTTZxY6XSmwrLUFrQD4rdL+W5tw3wfVo/3QS43SN4kSoxtJENo
	 AIF4A5GvQTFdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around
 virtual-mode HPTE bit-lock users
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260928113704.48912-2-amachhiw@linux.ibm.com>
References: <20260928113704.48912-1-amachhiw@linux.ibm.com>
 <20260928113704.48912-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 11:57:30 +0000
Message-Id: <20260928115731.4E05B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: ppc: hard deadlock due to asymmetric preemption in HPTE bit-l=
ock
--

commit 4ab3d02887c651ee39ea07438e210fdda4821de1
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-loc=
k users
   =20
This commit wraps virtual-mode HPTE bit-lock users in
kvmppc_pseries_do_hcall() and kvmppc_handle_exit_hv() with
preempt_disable() and preempt_enable() pairs. This is intended to prevent
indefinite spinning if a vCPU thread is preempted while holding the bit-loc=
k.

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index aa51968e206a7..52f72f30baf0a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1212,9 +1212,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  	case H_CLEAR_REF:
>  	case H_PROTECT:
>  	case H_BULK_REMOVE:
> +		preempt_disable();

[Severity: High]
Does disabling preemption here expose the system to a hard deadlock?

While this patch ensures the virtual-mode spin loop won't be preempted,
host-side HPTE bit-lock owners like kvm_unmap_rmapp() still acquire the
lock and execute their critical sections with preemption enabled.

For example, when called from kvmppc_core_flush_memslot_hv() under
slots_arch_lock mutex, preemption is not disabled:

arch/powerpc/kvm/book3s_64_mmu_hv.c:kvmppc_core_flush_memslot_hv() {
	for (n =3D memslot->npages; n; --n, ++gfn) {
		...
		if (*rmapp & KVMPPC_RMAP_PRESENT)
			kvm_unmap_rmapp(kvm, memslot, gfn);
		++rmapp;
	}
}

The lock is acquired and held without disabling preemption:

arch/powerpc/kvm/book3s_64_mmu_hv.c:kvm_unmap_rmapp() {
	if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
		/* unlock rmap before spinning on the HPTE lock */
		unlock_rmap(rmapp);
		while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
			cpu_relax();
		continue;
	}

	kvmppc_unmap_hpte(kvm, i, memslot, rmapp, gfn);
	unlock_rmap(rmapp);
	__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
}

If the host-side thread executing kvm_unmap_rmapp() is preempted while
holding HPTE_V_HVLOCK, and a vCPU thread on the same CPU subsequently enters
kvmppc_pseries_do_hpt_hcall(), the vCPU thread will spin indefinitely trying
to acquire the lock because preemption is now disabled here. The preempted
lock owner will never be scheduled on that CPU to release the lock.

>  		idx =3D srcu_read_lock(&kvm->srcu);
>  		ret =3D kvmppc_pseries_do_hpt_hcall(vcpu, req);
>  		srcu_read_unlock(&kvm->srcu, idx);
> +		preempt_enable();
>  		if (ret =3D=3D H_TOO_HARD)
>  			return RESUME_HOST;
>  		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928113704.4891=
2-4-amachhiw@linux.ibm.com?part=3D2
