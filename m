Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DD29CE1
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334808; cv=none; b=Ui4ginWHca47fjpi+kSvv8GqpbzC0gp0bbTgO/aO/X5MQDwy/cM4FKH4rsol/Pj4hQI2JeFRElIEVLgAhgU6+megefBlhgTOW5YmIN/thJnMltYbKk+ND8OAr9BrMoBeV8q19/6bE2h914VSUr7qHShrw8EQw1GyGcM8/avLYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334808; c=relaxed/simple;
	bh=MCJZFEX/2OkBfOTPKuLBZXK++uyiQhnCsGSLg4b0H3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NiVmCIv9GzvS1eegvHoOuGG09TQrahYYqnaCQVLkKBYTmAiLUdpA5ZrTi73iGaKmIkqYMCKL86WeQt1SlNkgqTUb7kcjq/vPp2ledJO9SQWys0tf1fJFVEl5WzaEko0mrxdt0gvSLDM0XCK6aJWB1V4mp0Zjng9cckdTj9AH91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ1GEv8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ1GEv8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC09E1F00893;
	Mon,  1 Jun 2026 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780334807;
	bh=AfEvNTHG/mWf903etYK6Nfla8DxbPv7BIpcmIXha4y4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZ1GEv8cIdTwkdJzrDkqj8lGmSKvRD70nm4TS7DQWzMlb4l4JteqHQKsYEQLUH5ru
	 mG2AgJ3KaLXgj8nG/tBGNBa2gE8W0GyLbRYFUF2YarGQcT3YopneT1UFEAf6vEYEVD
	 4Jm86JL1x/8sZt3YKhTvFbQsmQahN+aLmsnAm3TRwBTLnarm1WTJcq963AEcaIzCrW
	 i6X5vZZwbFrpyEsTmWgegzuROTruB+DzZDjVNpWHGtfENHGJ3jDrIzYts8JQJbponY
	 +5ffiJgtTSUBYeWNFcf3H7szQqeFjuPAfTFL+j39EvtUSUMEjivodgKKXLGVcFbaov
	 TqGuKVvNRjfvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] KVM: s390: Prevent memslots outside the ASCE
 range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601152951.196859-9-imbrenda@linux.ibm.com>
References: <20260601152951.196859-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 17:26:46 +0000
Message-Id: <20260601172646.EC09E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Dropping `kvm->slots_lock` before updating the ASCE limit creates =
a TOCTOU race and data race condition that allows memslots to bypass the ne=
w limit and risk reading torn values.
- [High] The exact user-provided memory limit is discarded and new memslots=
 are checked against a coarse, rounded-up hardware ASCE boundary, allowing =
userspace to bypass the exact limit.

Pre-existing issues:
- [High] Setting a sub-page limit (e.g., 4095 bytes) silently removes the m=
emory limit by expanding the VM address space to the maximum 16 Exabytes.
--

commit afeca87ebcc558baee29b01c63a93364ae7ae27f
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Prevent memslots outside the ASCE range

With KVM_S390_VM_MEM_LIMIT_SIZE, userspace can set the highest address
allowed for the VM. This patch prevents creation of memslots over the
maximum address, and prevents the maximum address from being reduced
below the end of existing memslots.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e09960c2e6ed1..1796a7c645a9d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1014,12 +1019,27 @@ static int kvm_s390_set_mem_control(struct kvm *k=
vm, struct kvm_device_attr *att
>  		if (!new_limit)
>  			return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this check fail to reject sub-page
size limits that truncate to 0 GFNs?

If a sub-page limit (e.g., 4095) is passed, it passes this zero check but
truncates to 0 when converted via gpa_to_gfn(new_limit) later in the functi=
on.

When gmap_set_limit() is called with a 0 limit, gmap_limit_to_type(0)
returns TABLE_TYPE_REGION1, granting the maximum 16 EB limit. Could this
allow an extremely restricted address limit to silently grant the maximum
possible address space?

> -		ret =3D -EBUSY;
> -		if (!kvm->created_vcpus)
> +		if (kvm->created_vcpus)
> +			return -EBUSY;
> +
> +		ret =3D 0;
> +		scoped_guard(mutex, &kvm->slots_lock) {
> +			slots =3D kvm_memslots(kvm);
> +			if (slots && !kvm_memslots_empty(slots)) {
> +				kvm_for_each_memslot(ms, bkt, slots) {
> +					if (gpa_to_gfn(new_limit) < ms->base_gfn + ms->npages) {
> +						ret =3D -EBUSY;
> +						break;
> +					}
> +				}
> +			}
> +		}
> +		if (!ret)
>  			ret =3D gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));

[Severity: High]
Is there a Time-of-Check to Time-of-Use (TOCTOU) race here by dropping
kvm->slots_lock before updating the ASCE limit?

By dropping slots_lock before calling gmap_set_limit(), the 64-bit
gmap->asce value is modified non-atomically under mmu_lock.

Concurrently, KVM_SET_USER_MEMORY_REGION can take slots_lock and call
kvm_arch_prepare_memory_region(), which reads gmap->asce locklessly:

kvm_arch_prepare_memory_region() {
    ...
    if (!asce_contains_gfn(kvm->arch.gmap->asce, ...))
        return -EINVAL;
}

Could this allow kvm_arch_prepare_memory_region() to read the old, larger
ASCE limit and validate a memslot that violates the newly requested limit?
Additionally, is there a risk of reading a torn gmap->asce struct value
during the non-atomic modification?

[ ... ]

> @@ -5672,6 +5692,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  			return -EINVAL;
>  		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
>  			return -EINVAL;
> +		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npag=
es - 1))
> +			return -EINVAL;

[Severity: High]
Does this allow userspace to bypass the exact requested memory limit?

Earlier in kvm_s390_set_mem_control(), the exact new_limit (e.g., 1 GB)
is verified against existing memslots, but it is discarded and never stored
in kvm->arch.mem_limit.

gmap_set_limit() then converts the exact limit to a coarse ASCE boundary,
rounding it up to the next hardware limit (e.g., 2 GB).

Because this new check in kvm_arch_prepare_memory_region() only evaluates
against the coarse ASCE boundary via asce_contains_gfn(), could userspace
request a strict limit but silently allocate memslots up to the next
hardware boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601152951.1968=
59-1-imbrenda@linux.ibm.com?part=3D8
