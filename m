Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885D2F3C07
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780256723; cv=none; b=PFMpbBiDqz8mFg+DbFaQUNfhiPqtqyQ8zEIloyoPy75EO6BtsNaedt5Ayt5fVZeQw6gJJc0bAhvKw58EGPkTVJtogJCNs6vGK8F6uMMJ2xKujWETpsb4a3e8qPf0zqNSe/3m5nysApBOBh9uIiz632t6PgFVJU5ZLiz4hvlKnak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780256723; c=relaxed/simple;
	bh=f3PeY+7CEBRUeBiTTPrz8JWS1R1kqVsX2B3U3zqytP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qFcg6LkDyuSRVii4WGr9AlIxv61pLDXVERQR8Bqin7jkMkAQMsDV4e+YLyBkCWtO2uP5cvv7+NcxXrImX8I9Elno7J+0x5d0t1IvKTIHnP4cz1mbLZvg97+irFg49NfFlnzBY+HR7wT6MhoK3tNa6Rv9eKsEeAUAMh6Se++BA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFynYPa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFynYPa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC971F00893;
	Sun, 31 May 2026 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780256721;
	bh=W8xoUoaM2nYGxo771N637ptlxdsZLID5iUx9XHAZe8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bFynYPa15KBW6dCU+t/QVqiENx3+ICQUXEPImR+W8OpsFeMeT/vQbFSBx5lQIEN3H
	 6sc8w9cNy9CHy+yQqrmUpdNZCUKXgxhJdCLVW3UmI0JqPcRykwbSMDWrmmda7O9UXk
	 R5VzI0RjXwTrKDk12ihEr6KeU/oD2Brf2n8YNhnn0AnTvPb5RG7au9yG6RTCekKBii
	 uxMavvmrjDXsD8VxxJBSIIztKlZZ2aPESPhO9esUOJFtxwDTtchBrKl2ILYfWlCCXk
	 zjVDyZCKoPxUWL3ZKYQUhsHBooIdXOk2OHS5RrYHWr0+B0tYApt1UnqTRRf4lh2MqK
	 aZmnTJXeqcDyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
Reply-To: sashiko-reviews@lists.linux.dev
To: "Douglas Freimuth" <freimuth@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531190353.204317-4-freimuth@linux.ibm.com>
References: <20260531190353.204317-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 19:45:21 +0000
Message-Id: <20260531194521.8DC971F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The rollback path in `adapter_indicators_set_fast` early-exits if =
`ind_info` is missing, failing to clear the summary bit and permanently coa=
lescing future interrupts.
- [High] Adversary-reachable memory allocation failure triggers `WARN_ON_ON=
CE`.
- [High] Use of GFP_ATOMIC in a preemption-disabled context (kvm_arch_set_i=
rq_inatomic) includes __GFP_KSWAPD_RECLAIM, which risks lock recursion and =
deadlocks.

Pre-existing issues:
- [High] Uninitialized stack variable `inti.parm` is passed to `trace_kvm_s=
390_inject_vm`, leaking kernel stack memory to the trace buffer.
--

commit db19d981b8f8dcf62bd14e1ad3e06ee6ac4f4929
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

This commit introduces a fast path for irq injection=20
(kvm_arch_set_irq_inatomic) instead of placing all interrupts on the global
work queue. It adds map/unmap functions for adapter indicators, switches fr=
om
mutexes and semaphores to spinlocks for shared resources, and implements
memory allocations on the fast path using GFP_ATOMIC.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index a7cff4289f4ad..5cfa781e349a0 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> @@ -2972,6 +3001,44 @@ static int adapter_indicators_set(struct kvm *kvm,
>  	return summary_set ? 0 : 1;
>  }
> =20
> +static int adapter_indicators_set_fast(struct kvm *kvm,
> +				       struct s390_io_adapter *adapter,
> +				       struct kvm_s390_adapter_int *adapter_int,
> +				       int setbit)
> +{
> +	unsigned long bit;
> +	int summary_set;
> +	struct s390_map_info *ind_info, *summary_info;
> +	void *map;
> +
> +	spin_lock(&adapter->maps_lock);
> +	ind_info =3D get_map_info(adapter, adapter_int->ind_addr);
> +	if (!ind_info) {
> +		spin_unlock(&adapter->maps_lock);
> +		return -EWOULDBLOCK;
> +	}

[Severity: High]
When an allocation or injection fails in kvm_arch_set_irq_inatomic(), it
calls adapter_indicators_set_fast() with setbit=3D0 to roll back the summary
bit. If the indicator page was unmapped concurrently, get_map_info() returns
NULL and we early-return -EWOULDBLOCK.

Does this early return skip clearing the summary bit? If the summary bit
remains stuck, could this cause all future interrupts for any indicator
sharing that summary page to be silently dropped?

> +	map =3D page_address(ind_info->page);
> +	bit =3D get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->s=
wap);
[ ... ]
> +	ret =3D adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
> +	if (ret < 0)
> +		return -EWOULDBLOCK;
> +	if (!ret || adapter->masked) {
> +		kvm->stat.io_390_inatomic_no_inject++;
> +		return 0;
> +	}
> +
> +	inti =3D kzalloc_obj(*inti, GFP_ATOMIC);

[Severity: High]
Does this GFP_ATOMIC allocation risk lock recursion?

kvm_arch_set_irq_inatomic() is invoked as a fast-path for irqfd injection,
executing from the eventfd wait queue callback with the waitqueue spinlock
held (preemption disabled).

GFP_ATOMIC inherently includes __GFP_KSWAPD_RECLAIM, which triggers
wakeup_kswapd() and re-enters the scheduler machinery via try_to_wake_up().

Should we strip the __GFP_KSWAPD_RECLAIM bit or use a bare flag like
__GFP_NOWARN instead?

> +	if (!inti) {
> +		setbit =3D 0;
> +		adapter_indicators_set_fast(kvm, adapter, &e->adapter, setbit);
> +		return -EWOULDBLOCK;
> +	}
[ ... ]
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 0d39c1375de21..98e7d807d6204 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -4379,19 +4389,28 @@ int kvm_s390_try_set_tod_clock(struct kvm *kvm, c=
onst struct kvm_s390_vm_tod_clo
>  }
> =20
>  static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_=
token,
> -				      unsigned long token)
> +				     unsigned long token)
>  {
>  	struct kvm_s390_interrupt inti;

[Severity: High]
This isn't a bug introduced by this patch, but the stack variable inti is
declared without initialization. While inti.type and inti.parm64 are
subsequently populated, inti.parm remains uninitialized.

When inti is passed into kvm_s390_inject_vm(), trace_kvm_s390_inject_vm()
unconditionally logs s390int->parm. Could this leak 32 bits of uninitialized
kernel stack memory to userspace via the trace ring buffer?

>  	struct kvm_s390_irq irq;
> +	struct kvm_s390_interrupt_info *inti_mem =3D NULL;
> +	int ret =3D 0;
> =20
>  	if (start_token) {
>  		irq.u.ext.ext_params2 =3D token;
>  		irq.type =3D KVM_S390_INT_PFAULT_INIT;
>  		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
>  	} else {
> +		inti_mem =3D kzalloc_obj(*inti_mem, GFP_KERNEL_ACCOUNT);
> +		if (WARN_ON_ONCE(!inti_mem))
> +			return;

[Severity: High]
Is it safe to use WARN_ON_ONCE() for this memory allocation failure?

Since this path is reachable by a guest triggering async page faults, a
malicious guest could spray memory to induce host memory pressure, hit this
allocation failure, and trigger a host panic if panic_on_warn is set.

Could we handle this failure gracefully or return an error without the WARN?

> +
>  		inti.type =3D KVM_S390_INT_PFAULT_DONE;
>  		inti.parm64 =3D token;
> -		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
> +		ret =3D kvm_s390_inject_vm(vcpu->kvm, &inti, inti_mem);
> +		if (ret)
> +			kfree(inti_mem);
> +		WARN_ON_ONCE(ret);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531190353.2043=
17-1-freimuth@linux.ibm.com?part=3D3
