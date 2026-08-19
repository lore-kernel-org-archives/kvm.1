Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643714F70
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787097790; cv=none; b=fOYQTHlQOkapsqKlPPM2q0hILtEba4RUlb/Irwi0uywpncbE5UyVAZA1+5r1LfXc87A8Js3RoRrdfl1cnf3rlL9ETrWQ9iUe2NcR/sx36pOwP/eMIiOPNSTQaJlBriK8PXe5t343tOyjYyEga0+8hwh0HLNlLErIQwhKkAL42jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787097790; c=relaxed/simple;
	bh=d2+YlxuyI0m04X0gn1WPNC51Lo21iOXPDoMIO1Ga1aE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dsGkI5efiz03HtMYi3FWRAq9421V4vPZ0k1yNUMvGQTW4hLEyWJ1dUkJoIBM25MBPONJuUAhuY5lFDdhFtgY1W0rBHCIOkFCO1yTZLd/Ovolvh5cW7Bsw8GIJM6Z4AvpTlHABjjAEuitUIfjEHq2UMjmjhSnOXOeb1GfMcsEvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irIvT5AZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irIvT5AZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30AA1F000E9;
	Wed, 19 Aug 2026 00:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787097789;
	bh=kQPwYWYuVn2HpKL49NiRj63swGF/mYOH3Z12aQDpVqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=irIvT5AZ2nvHo4TxvZWHjfD8JbB2ZFjwsgSzqgn8LK9nhJSI9MVM5MKftybPmUQ7C
	 zd+NxzjPGMoSXzVcTmnKnPR8wbxrGpDoleWV1RrOfZOK51EHvsHYLx5H2A6xIbtKGf
	 2hW6YyyRvY4B8VXgTVhXyJE6uYsSBTabrQ6UFYjEFhuz0zRTATuIARWlG4+X2h/n6v
	 PL6NLVgmiQrGigCKKkIt07QNDc9QH3HeAt+2UBNiGBJ+aHR1KgJJbsXnGSCge2cl4H
	 qupnzh97EQ/6gRyOT9NLMRpooZoftv42kyTQTByI93tiGM3f8S71ey39MUFdZ8DVcz
	 FSyJwvOnB+N6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] KVM: x86: lapic: update apic_base and APIC ID
 together
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dongli Zhang" <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260818234238.618158-1-dongli.zhang@oracle.com>
References: <20260818234238.618158-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 00:03:08 +0000
Message-Id: <20260819000308.F30AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lock inversion (ABBA deadlock) between `cpus_read_lock()` and `api=
c_map_lock`.
--

--- Patch [1]: [PATCH 1/1] KVM: x86: lapic: update apic_base and APIC ID to=
gether ---
commit 01695608c13ffe0ad80fe486aaf7e61b96936d9e
Author: Dongli Zhang <dongli.zhang@oracle.com>

KVM: x86: lapic: update apic_base and APIC ID together

This commit aims to resolve a runtime apicv inhibition issue by atomically
updating apic_base and the APIC ID. It introduces conditional lock protecti=
on
using apic_map_lock within __kvm_apic_set_base() to serialize the updates
with APIC map recalculation.

> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2793,17 +2793,29 @@ static void __kvm_apic_set_base(struct kvm_vcpu *=
vcpu, u64 value)
>  {
>  	u64 old_value =3D vcpu->arch.apic_base;
>  	struct kvm_lapic *apic =3D vcpu->arch.apic;
> +	u64 changed =3D old_value ^ value;
> +	bool apicbase_enable_changed =3D changed & MSR_IA32_APICBASE_ENABLE;
> +	bool x2apic_enable_changed =3D changed & X2APIC_ENABLE;
> +	bool apic_mode_changed =3D apicbase_enable_changed || x2apic_enable_cha=
nged;
> +	bool need_lock =3D apic && apic_mode_changed;
> +
> +	/*
> +	 * Serialize apic_base and APIC ID updates with APIC map
> +	 * recalculation.
> +	 */
> +	if (need_lock)
> +		mutex_lock(&vcpu->kvm->arch.apic_map_lock);
> =20
>  	vcpu->arch.apic_base =3D value;
> =20
> [ ... ]
>
>  	/* update jump label if enable bit changes */
> -	if ((old_value ^ value) & MSR_IA32_APICBASE_ENABLE) {
> +	if (apicbase_enable_changed) {
>  		if (value & MSR_IA32_APICBASE_ENABLE) {
>  			kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
>  			static_branch_slow_dec_deferred(&apic_hw_disabled);
>  			/* Check if there are APF page ready requests pending */
>  			kvm_make_request(KVM_REQ_APF_READY, vcpu);
>  		} else {
>  			static_branch_inc(&apic_hw_disabled.key);

[Severity: High]
Does this introduce a lock inversion between apic_map_lock and
cpus_read_lock()?

By acquiring apic_map_lock at the beginning of __kvm_apic_set_base() and
calling static_branch_inc() here, we might be taking the global
cpus_read_lock() while holding a per-VM lock.

Because static_branch_inc() internally calls static_key_slow_inc(), which
unconditionally acquires cpus_read_lock(), this establishes a dependency of:
apic_map_lock -> cpus_read_lock()

However, CPU hotplug operations (like kvm_online_cpu()) take KVM locks under
cpus_write_lock(). Since KVM commonly acquires vcpu->mutex under kvm_lock,
and apic_map_lock is nested further inside vcpu->mutex, this appears to
create a circular dependency:

cpus_read_lock() -> kvm_lock -> vcpu->mutex -> apic_map_lock

Can a guest triggering this path by clearing the APIC enable bit via WRMSR,
while racing with a host CPU hotplug operation, cause an ABBA deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818234238.6181=
58-1-dongli.zhang@oracle.com?part=3D1
