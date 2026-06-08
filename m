Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A43D3CE3
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949482; cv=none; b=sz0R6gvlIF6mPCLlklWuvw5PkWbPbh6PgjnxyBoS0mD08AqWUPlSmK80epJ0+bs05uax54MHNoI3nGMo7IDEU/nn5iTtddq32XT3DjsRNErujaDfFRvHM9S2I9YDangmls/T5MjKBGbobCzegQpOGMndIX2CLofBek8niXI0Zys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949482; c=relaxed/simple;
	bh=+mpuGq841gxQTV/8nlwvWk1sZuOjJ25GtruijKEhnlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m+TIUXNSw2GUf950ZqPXEd756ROhLnN4bZHRYa8o+9j5EuS6k9ZW0XVk0wuFC9LFtBE+btvDl7tmXxmVfQGdI8GhzVbiR5ZWCRpaJTTM/WqgnY4M3JpgmH5fAqLqeVlMsB2hWR/zDlyM7E6UKUCL1s9ANbFfrAvb51rWWRcrDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMXk2o3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMXk2o3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A511F00893;
	Mon,  8 Jun 2026 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949480;
	bh=GdLOMIbO/B40UYos8zIlhiKkSSoWUkJrzunDp+dSrZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LMXk2o3g5GZK8FwIEWGakqEIPRcu7ahE/rny5kZGqJhydW3vtDtbts6eC2rv6p9wn
	 9ujCSEXxg5Tm4JP3WtFc+xyyNDB9ByLMzk11dlGuFftA810EZRewvIlh8jAyTRFGSN
	 UDXLTCf9PA2KcxIuV51dSZGST6ck40+t7tu0JLWmngnKcz6Q16nwyvlTEV9cj6Sdw6
	 s5LVIiRcPAVqoirnBZEoa4NH1NlJBcJvJZdcH91diWXm8aidUZFTy+AMENgk25bBpb
	 avNDqinH27t+m9pgaB7mN/zrZAZAEYXOsCxMiSP8TifIs3WMRirA/N1OgeOp8wa3vI
	 +QBe5wMbb9Zxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 26/34] KVM: x86: Avoid redundant masterclock updates
 from multiple vCPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-27-dwmw2@infradead.org>
References: <20260608145455.89187-27-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:11:20 +0000
Message-Id: <20260608201120.B2A511F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] O(N) vCPU iteration loops moved inside a raw spinlock and seqcount=
 writer critical section, causing severe O(N^2) latency spikes.
- [High] Unilateral clearing of KVM_REQ_MCLOCK_INPROGRESS in the bailout pa=
th creates a race condition allowing premature guest entries.
--

commit c617628fa6cacec7b404452ff34e7359195be099
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Fix redundant pvclock updates

When a masterclock update is triggered, KVM_REQ_MASTERCLOCK_UPDATE is set on
all vCPUs. This patch adds a check in __kvm_start_pvclock_update() to preve=
nt
redundant updates by having it bail out if another vCPU already processed t=
he
request. It also clears the request on all other vCPUs once the lock is
acquired.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3288,10 +3288,39 @@ static void kvm_make_mclock_inprogress_request(st=
ruct kvm *kvm)
>  	kvm_make_all_cpus_request(kvm, KVM_REQ_MCLOCK_INPROGRESS);
>  }
> =20
> -static void __kvm_start_pvclock_update(struct kvm *kvm)
> +static void kvm_clear_mclock_inprogress_request(struct kvm *kvm)
>  {
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
> +}
> +
> +static bool __kvm_start_pvclock_update(struct kvm *kvm, struct kvm_vcpu =
*requesting_vcpu)
> +{
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
>  	raw_spin_lock_irq(&kvm->arch.tsc_write_lock);
> +
> +	/*
> +	 * If another vCPU already did the update while we were waiting
> +	 * for the lock, our request will have been cleared. Bail out.
> +	 */
> +	if (requesting_vcpu &&
> +	    !kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, requesting_vcpu)) {
> +		kvm_clear_mclock_inprogress_request(kvm);
> +		raw_spin_unlock_irq(&kvm->arch.tsc_write_lock);
> +		return false;
> +	}

[Severity: High]
Does this bailout path risk prematurely clearing the protection set by
another concurrent update?

If a concurrent masterclock update is initiated (for example, by
kvm_arch_vcpu_postcreate() calling kvm_update_masterclock() with a NULL
requesting_vcpu), that thread will set KVM_REQ_MCLOCK_INPROGRESS to
prevent guest entries.

If the bailing vCPU holds the lock, sees its bailout condition met, and
calls kvm_clear_mclock_inprogress_request(), could this clear the newly
set protection flag globally? This might leave the system without
protection and allow other vCPUs to enter the guest without
KVM_REQ_CLOCK_UPDATE being set, causing them to observe an inconsistent
clock state.

[Severity: High]
Is it safe to execute this O(N) vCPU iteration loop inside the
tsc_write_lock raw spinlock?

Since kvm_clear_mclock_inprogress_request() iterates over all vCPUs, and
up to N vCPUs might sequentially take this bailout path, could this lead
to O(N^2) lock hold times with IRQs disabled? In large VMs, this might
result in significant latency spikes and potential soft lockups.

> +
> +	/* The update is VM-wide; prevent other vCPUs from redoing it. */
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		kvm_clear_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);

[Severity: High]
Similarly, does adding this O(N) vCPU iteration inside the raw spinlock
create a risk of latency spikes on the fast path for large VMs?

[ ... ]

>  static void kvm_end_pvclock_update(struct kvm *kvm)
>  {
>  	struct kvm_arch *ka =3D &kvm->arch;
>  	struct kvm_vcpu *vcpu;
>  	unsigned long i;
> =20
> -	write_seqcount_end(&ka->pvclock_sc);
> -	raw_spin_unlock_irq(&ka->tsc_write_lock);
>  	kvm_for_each_vcpu(i, vcpu, kvm)
>  		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
> =20
>  	/* guest entries allowed */
> -	kvm_for_each_vcpu(i, vcpu, kvm)
> -		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
> +	kvm_clear_mclock_inprogress_request(kvm);
> +
> +	write_seqcount_end(&ka->pvclock_sc);
> +	raw_spin_unlock_irq(&ka->tsc_write_lock);
>  }

[Severity: High]
Does moving write_seqcount_end() and raw_spin_unlock_irq() after the two
O(N) vCPU iteration loops risk stalling seqcount readers indefinitely?

Performing O(N) atomic bit operations inside the seqcount writer critical
section and with IRQs disabled could cause severe latency spikes, RT
constraint violations, and potentially stall readers spinning on the
seqcount in NMI context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D26
