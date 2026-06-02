Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F432A3E5
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423924; cv=none; b=lgikrzGHwTJkqxJopgX4/ydWY1FkyuKQ00+xgM1N/JD5BfQBgQGky/URWLQpXVdZQdnZeA+ijKgiMlzzMIFnGfs5Jp29vz7QhMv1yE1QY+V+HlJH57wKO7r/0/LKuXJfpzE45AYmbs2ABK5XmPjIL7cWaA7BePZMhmxeAIe2yUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423924; c=relaxed/simple;
	bh=7miV3U1UkDCQw7la4UOXsdnmRvJ6cn4oXdPz70MtnKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pM4duHXdMN1FzNIQbqHogtKG14kyenIK9arSggi2T6XqZaxuAgZFW/Jz1boKxmMiFjI+jME/l8r6jfoRb8huagdpHK77CWMUF4W5WxrA8lBC7KukjAMZSTZBdbKFNV6WfrR0SitTqon5si2WqMfs3u2y9OVzEsrJtkVquRep80A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2jzuEHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2jzuEHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A84A1F00893;
	Tue,  2 Jun 2026 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423922;
	bh=+oaV/X0empPmiWcMhG5fc+d1D6opoMo8pfQSCtfVNBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T2jzuEHSSiHAm/xwdkpvcBBbwYxAtLLdU/lIDeVhxu7hWw6i7tV2DcAoA/O52aqBp
	 mfnksdTV27sHiw0QmYHBPJHrxALcackSCgCWNLYb76e4PyHYaspENoZs4ZRyBMi3xY
	 EgORqjJ71a1z3WeW/2VF5slxyPhcrEsB157ALam1CRZMAypIhQPRcqPoLZni8rSMPk
	 Mug9SU1BPwliEmnanGVOVtELvHjDhj/EdLvGq8ktiV6xLijd9mO/3l5s6XfBFplw69
	 XIGAlbYY/9PHKTgBNDMKC26XzCmc9zepU7a4XNrChiJkAUHlvUc3gXhFQfCGy3o/00
	 DT2drVDQ05xzg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 08/10] KVM: s390: Prevent memslots outside the
 ASCE range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602174819.255785-9-imbrenda@linux.ibm.com>
References: <20260602174819.255785-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 18:12:01 +0000
Message-Id: <20260602181202.6A84A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The KVM_S390_VM_MEM_LIMIT_SIZE setter fails to store the request=
ed limit, causing incorrect limit enforcement for new memslots and breaking=
 the GET ioctl.

Pre-existing issues:
- [Critical] Modifying the ASCE limit via KVM_S390_VM_MEM_LIMIT_SIZE after =
a VM is converted to protected mode (KVM_PV_ENABLE) causes a Use-After-Free=
 in the Ultravisor.
- [High] Decreasing the VM ASCE limit via KVM_S390_VM_MEM_LIMIT_SIZE perman=
ently leaks intermediate page tables from deleted memslots.
--

commit c42cdbb0094295e8d486830cbb2f739b157e39b0
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Prevent memslots outside the ASCE range

This patch adds validation to KVM_S390_VM_MEM_LIMIT_SIZE to prevent
shrinking the VM maximum memory address below existing memslots. It also
adds a check during memslot creation to prevent new memslots from being
created beyond the ASCE limit.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e09960c2e6ed1..ffb20a64d328f 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -999,7 +999,10 @@ static int kvm_s390_set_mem_control(struct kvm *kvm,=
 struct kvm_device_attr *att
>  		break;
>  	}
>  	case KVM_S390_VM_MEM_LIMIT_SIZE: {

[Severity: Critical]
This is a pre-existing issue, but does shrinking the ASCE limit after a VM
is converted to protected mode cause a Use-After-Free in the Ultravisor?

If userspace calls KVM_PV_ENABLE before creating vCPUs, the VM's ASCE is
registered with the Ultravisor. If KVM_S390_VM_MEM_LIMIT_SIZE is then
called, it doesn't check kvm_s390_pv_is_protected() and proceeds to
dat_set_asce_limit() which frees the old top-level ASCE page table.

Since the Ultravisor is unaware, does it continue using the freed page
table, potentially leading to host memory corruption when the kernel
reuses the freed page?

> +		struct kvm_memslots *slots;
> +		struct kvm_memory_slot *ms;
>  		unsigned long new_limit;
> +		int bkt;
> =20
>  		if (kvm_is_ucontrol(kvm))
>  			return -EINVAL;
[ ... ]
> @@ -1014,12 +1020,27 @@ static int kvm_s390_set_mem_control(struct kvm *k=
vm, struct kvm_device_attr *att
>  		if (!new_limit)
>  			return -EINVAL;
> =20
> -		ret =3D -EBUSY;
> -		if (!kvm->created_vcpus)
> -			ret =3D gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));
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
> +			if (!ret)
> +				ret =3D gmap_set_limit(kvm->arch.gmap, gpa_to_gfn(new_limit));

[Severity: High]
This is a pre-existing issue, but does shrinking the ASCE limit permanently
leak intermediate page tables from deleted memslots?

When a memslot is deleted, dat_delete_slot() invalidates leaf entries but
doesn't reap empty intermediate page tables. When gmap_set_limit() calls
dat_set_asce_limit(), it assumes higher-address mappings are empty:

arch/s390/kvm/dat.c:dat_set_asce_limit() {
    ...
    while (asce->dt > newtype) {
        table =3D dereference_asce(*asce);
        crste =3D table->crstes[0];
    ...
}

It only traverses table->crstes[0] and ignores any populated child page
tables in table->crstes[1..2047]. Are these child tables leaked when the
root table is freed, potentially allowing a malicious userspace to cause
an OOM by repeatedly creating and deleting memslots at high addresses
before shrinking the limit?


[Severity: Medium]
Also, does this code successfully record the new limit for future checks?

The exact user limit is passed to the gmap here, but kvm->arch.mem_limit
does not appear to be updated to match new_limit. Since the ASCE rounds
up to the next architectural boundary, could this cause future queries to
return the old hardware maximum limit instead of the user's configured
limit?

> +		}
> +		if (ret)
> +			break;
>  		VM_EVENT(kvm, 3, "SET: max guest address: %lu", new_limit);
[ ... ]
> @@ -5672,6 +5693,8 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>  			return -EINVAL;
>  		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
>  			return -EINVAL;
> +		if (!asce_contains_gfn(kvm->arch.gmap->asce, new->base_gfn + new->npag=
es - 1))
> +			return -EINVAL;

[Severity: Medium]
Does this correctly enforce the exact user-requested limit for new memslots?

Because kvm->arch.mem_limit is not updated in kvm_s390_set_mem_control(),
this check relies on asce_contains_gfn(), which evaluates against the
rounded ASCE limit. Could this allow a user to create new memslots that
exceed their originally requested exact byte limit?

>  	}
> =20
>  	if (!kvm->arch.migration_mode)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602174819.2557=
85-1-imbrenda@linux.ibm.com?part=3D8
