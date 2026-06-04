Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED2C39BFE0
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602371; cv=none; b=ROg++WmYnC+F5uhttDP0AgQ6FV3SbvUoRlWkrD6WCkZ1S+c9mX0x2kYfPShlrP51QXEbLR4KNE8qq4Vv14mSKEB8fD0Doc/UhGcGZUzJk6kSpIrcPOznXiqSUySDNb8/CFs0o9W+7tdjF3fLKjaIiQqhdY6RnMeENG3p/0IiU0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602371; c=relaxed/simple;
	bh=ZS6Q4NW/QnWykvaT6dckPok4js/bj/ShuiAEc8zsH8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uakf41tXtmBYveZSL18kNDsKEfmSdAUqJGn+CkRxSzyhVAb9p0YoMCd9ABvSnsda2ayMb6VxqEsIzUX+q6kaAh30A3KqWJ1SzPpLeAi4W8XNwvtTIDAl3rTCN/5BPtODLPDUJAdt6RP11x27qW6Nd1RerwBGSrfq+RpqL7Z92nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWDiOvgc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWDiOvgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4C41F00893;
	Thu,  4 Jun 2026 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780602369;
	bh=EBxzc2MiQOdw/CPhZlpEji0OPQLWzxXKwvaf+3JGSHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IWDiOvgcHXBetGsab9NMUTqMtOLiVla4tkyhmUZFdGMv9AlCEnyxT2siBDx6/zJzC
	 RaqvNvoQjNnA5FGZOudplAzMpnLtR9pCiZKDvtEaoGDd4hEb5Z+xrjaPY8/+ppNUk8
	 lFIeNkmnUqAYE/AD+Kx9xPL4qqfEZLsi/v8+hVeHX5Ox1S3udiCTD+f1+5hJr+qXP+
	 zyANVyWcaLYxDeVSpZ6ahORVJtnVcbaEoTkILTB7muWB0Z0fd6bQLf2RN/8qk264E4
	 +ScssZsXTMY9pB5dvRxfpuT743O8/gwWDlQ31BuDphU5H0ng+L8EdfZCNji8Swzl5T
	 IIMMh7EdCGxVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/3] KVM: s390: Introducing
 kvm_arch_set_irq_inatomic fast inject
Reply-To: sashiko-reviews@lists.linux.dev
To: "Douglas Freimuth" <freimuth@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604192755.203143-4-freimuth@linux.ibm.com>
References: <20260604192755.203143-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:46:09 +0000
Message-Id: <20260604194609.7F4C41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing KVM Dirty Page Tracking during Fast IRQ Injection.

Pre-existing issues:
- [High] Guest-Triggerable WARNING / Denial of Service on memory allocation=
 failure.
--

commit 87294ba489c0602b2b9baebf0c40ddd4f77205c0
Author: Douglas Freimuth <freimuth@linux.ibm.com>
Subject: KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

This patch introduces a fast path for irq injection on s390 via
kvm_arch_set_irq_inatomic. It avoids placing interrupts on the global
work queue by directly mapping adapter indicator pages and accessing
shared resources using spinlocks instead of mutexes.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index b5304816aaa04..9e3e6b0d72ad6 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
[ ... ]
> @@ -2969,6 +2998,44 @@ static int adapter_indicators_set(struct kvm *kvm,
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
> +	map =3D page_address(ind_info->page);
> +	bit =3D get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->s=
wap);
> +	if (setbit)
> +		set_bit(bit, map);

[Severity: High]
Does this bypass dirty page tracking? Since the guest memory is directly
mutated here using the kernel virtual address mapping, the hardware dirty
bit won't be set.

It appears KVM must explicitly invoke mark_page_dirty() (or an equivalent) =
to
record this modification in the memory slot's dirty bitmap. Without it, pen=
ding
interrupts injected via the fast path might be lost after live migration,
leading to guest I/O hangs or data corruption.

> +	summary_info =3D get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		spin_unlock(&adapter->maps_lock);
> +		return -EWOULDBLOCK;
> +	}
> +	map =3D page_address(summary_info->page);
> +	bit =3D get_ind_bit(summary_info->addr, adapter_int->summary_offset,
> +			  adapter->swap);
> +	/* If setbit then set summary bit. Else if falling back to the slow pat=
h */
> +	/* with setbit=3D=3D0 then clear the summary bit so the slow path re-in=
jects */
> +	if (setbit)
> +		summary_set =3D test_and_set_bit(bit, map);
> +	else
> +		summary_set =3D test_and_clear_bit(bit, map);

[Severity: High]
Similarly, does the summary page modification here also need explicit dirty=
=20
page tracking?

> +	spin_unlock(&adapter->maps_lock);
> +	return summary_set ? 0 : 1;
> +}
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
This isn't a bug introduced by this patch, but does this guest-triggerable
warning create a Denial of Service risk?

The KVM subsystem guidelines explicitly state there should be no guest- or=
=20
host-userspace-reachable WARN_ON or BUG_ON. If this allocation fails (e.g.=
=20
under host memory pressure, or if a malicious guest deliberately exhausts i=
ts=20
memory cgroup limits via asynchronous page faults), it will hit this warnin=
g.=20
On systems configured with panic_on_warn=3D1, an unprivileged guest could=20
intentionally crash the host.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604192755.2031=
43-1-freimuth@linux.ibm.com?part=3D3
