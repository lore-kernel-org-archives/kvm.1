Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCC2EEE82
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933942; cv=none; b=kOVv90uWUjE7tTmQedelKf3mMZ1BYhUwtdPIn8sStzCg1Jqli5Oih6K6CEvIUfR3ujBQsD5OyRZ+FojD9tDdtYdsGclv9vpHm5scJUtdkqnEuX8ZnNUMIgf029cLtkejxQNirX6PeUCxZNIxP0oE64Jh/HSTs/xBY/+tg8arEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933942; c=relaxed/simple;
	bh=tYkBCGJHkkMqroZsdgYXZZi1vwGR1g+xjqwL0BPDqXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tgIhTAmX99RsEuEWMF2sYFMBRD4Om6d+RPCI0uopkydGYh2bJlcA6Q5iDRUYIL232mPlOe2HlEt7fOl1Un3PvAoKgvnlsV3MXLchLDxpKvljj9pcgyBx4DrbwzFlLEJYlC3Xod9AkaO7M+OjZVi8Oa5iFN6bECmXMsAtE8npM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UInD1laG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UInD1laG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060AC1F00893;
	Mon,  8 Jun 2026 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933941;
	bh=fccFPHu3eQ5T4FMNbkVXCanlszbejFQFax9MsfLkimk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UInD1laGBoegUAeaqSmHCrFhRgNCTiOcdGZ/hTZ7MJ4ChLxF8hRShbiAf8tAJ9fAU
	 bkAbTES5j3ccfyiXdMbAaHDC5SV8dKWa4Gi4HHAhw3yYEn2ulGYMzrp5LrJy/OpPqE
	 9FWkU8an50y5mX8mVRvH8SRmeLsINvj2t7+zMQrvisEDxUjGCk0V8G+qANBiHCpvTI
	 Dk3oUPfPjddXlivyREJ6aA/gpNT+sddGE30gsw4ApmesUlK6fB5Pj2gKEiaSpZcyGH
	 vdNPr9Rgm+Ib+9NZwpPoCj5wV9PSLEw3xBi040Sd0jMU/xHqdqVMPAy1BmoQQ6pP2B
	 SqW3GIcgLGqXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/60] kvm: Move vcpu accounting to struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-13-joro@8bytes.org>
References: <20260608144252.351443-13-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:52:20 +0000
Message-Id: <20260608155221.060AC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Concurrent KVM_CREATE_VCPU ioctls can bypass the VM's `max_vcpus` =
limit due to a TOCTOU race.
- [High] Concurrent vCPU creation assigns identical `vcpu_idx` values, lead=
ing to `xa_insert()` collisions and a host-reachable `WARN_ON_ONCE`.
- [High] Mixing goto-based error handling with `__free()` cleanup in `kvm_v=
cpu_init_common()`.
--

commit 13e7e9109dee4a6b84e351c0217863b5f716ad31
Author: Joerg Roedel <joerg.roedel@amd.com>
Subject: kvm: Move vcpu accounting to struct kvm_vcpu_common

This patch moves vCPU accounting and sanity checks into a common structure
(`kvm_vcpu_common`) to perform them only once per plane.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 71c806ad469c8..700f65f3ad037 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -438,18 +438,58 @@ void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_mem=
ory_cache *mc)
>  }
>  #endif
> =20
> -static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm)
> +static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, =
unsigned long id)
>  {
> -	struct kvm_vcpu_common *common =3D kzalloc(sizeof(*common), GFP_KERNEL_=
ACCOUNT);
> +	struct kvm_vcpu_common *common __free(kfree) =3D kzalloc(sizeof(*common=
), GFP_KERNEL_ACCOUNT);
> +	int r;

[Severity: High]
Does using __free(kfree) here conflict with the goto-based unwinding at
out_drop_counter below?

The cleanup guidelines state that usage of goto and cleanup helpers should
never be mixed in the same function.

> +
> +	/*
> +	 * KVM tracks vCPU IDs as 'int', be kind to userspace and reject
> +	 * too-large values instead of silently truncating.
> +	 *
> +	 * Ensure KVM_MAX_VCPU_IDS isn't pushed above INT_MAX without first
> +	 * changing the storage type (at the very least, IDs should be tracked
> +	 * as unsigned ints).
> +	 */
> +	BUILD_BUG_ON(KVM_MAX_VCPU_IDS > INT_MAX);
> +	if (id >=3D KVM_MAX_VCPU_IDS)
> +		return -EINVAL;
> +
> +	mutex_lock(&kvm->lock);
> +	kvm->created_vcpus++;
> +	mutex_unlock(&kvm->lock);
> +
> +	if (common =3D=3D NULL) {
> +		r =3D -ENOMEM;
> +		goto out_drop_counter;
> +	}
> +
> +	common->vcpu_idx =3D atomic_read(&kvm->online_vcpus);

[Severity: High]
Can concurrent vCPU creations read the same value for vcpu_idx here?

Because this is read outside of kvm->lock, multiple threads could obtain
identical indices, which would later cause an xa_insert() collision in
kvm_vm_ioctl_create_vcpu().

> =20
>  	common->kvm =3D kvm;
>  	common->current_vcpu =3D vcpu;
> -	vcpu->common =3D common;
> +	vcpu->common =3D no_free_ptr(common);
> =20
>  	return 0;
> +
> +out_drop_counter:
> +	mutex_lock(&kvm->lock);
> +	kvm->created_vcpus--;
> +	mutex_unlock(&kvm->lock);
> +
> +	return r;
> +}

[ ... ]

> @@ -4234,22 +4283,10 @@ static void kvm_create_vcpu_debugfs(struct kvm_vc=
pu *vcpu)
>   */
>  static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>  {
> -	int r;
> +	int r =3D -EINVAL;
>  	struct kvm_vcpu *vcpu;
>  	struct page *page;
> =20
> -	/*
> -	 * KVM tracks vCPU IDs as 'int', be kind to userspace and reject
> -	 * too-large values instead of silently truncating.
> -	 *
> -	 * Ensure KVM_MAX_VCPU_IDS isn't pushed above INT_MAX without first
> -	 * changing the storage type (at the very least, IDs should be tracked
> -	 * as unsigned ints).
> -	 */
> -	BUILD_BUG_ON(KVM_MAX_VCPU_IDS > INT_MAX);
> -	if (id >=3D KVM_MAX_VCPU_IDS)
> -		return -EINVAL;
> -
>  	mutex_lock(&kvm->lock);
>  	if (kvm->created_vcpus >=3D kvm->max_vcpus) {
>  		mutex_unlock(&kvm->lock);
> @@ -4257,24 +4294,20 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *k=
vm, unsigned long id)
>  	}
> =20
>  	r =3D kvm_arch_vcpu_precreate(kvm, id);
> -	if (r) {
> -		mutex_unlock(&kvm->lock);
> -		return r;
> -	}
> -
> -	kvm->created_vcpus++;
>  	mutex_unlock(&kvm->lock);

[Severity: High]
Does dropping kvm->lock here create a race with the kvm->created_vcpus
increment now located in kvm_vcpu_init_common()?

Multiple concurrent threads could pass the max_vcpus check above, drop the
lock here, and then indiscriminately increment created_vcpus. This would
allow an unprivileged host-userspace process to bypass the VM's configured
max_vcpus limit.

> +	if (r)
> +		return r;
> =20
>  	vcpu =3D kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL_ACCOUNT);
> -	if (!vcpu) {
> -		r =3D -ENOMEM;
> -		goto vcpu_decrement;
> -	}
> +	if (!vcpu)
> +		return -ENOMEM;
> =20
> -	r =3D kvm_vcpu_init_common(vcpu, kvm);
> +	r =3D kvm_vcpu_init_common(vcpu, kvm, id);
>  	if (r)
>  		goto vcpu_free;
> =20
> +	vcpu->vcpu_idx =3D vcpu->common->vcpu_idx;
> +
>  	BUILD_BUG_ON(sizeof(struct kvm_run) > PAGE_SIZE);
>  	page =3D alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
>  	if (!page) {
> @@ -4303,7 +4336,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
>  		goto unlock_vcpu_destroy;
>  	}
> =20
> -	vcpu->vcpu_idx =3D atomic_read(&kvm->online_vcpus);
>  	r =3D xa_insert(&kvm->planes[0]->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_=
KERNEL_ACCOUNT);
>  	WARN_ON_ONCE(r =3D=3D -EBUSY);

[Severity: High]
Can a vcpu_idx collision from kvm_vcpu_init_common() trigger this
WARN_ON_ONCE?

If concurrent vCPU creations get the same vcpu_idx, this xa_insert() will
fail with -EBUSY. Since this WARN_ON_ONCE is reachable by an unprivileged
host-userspace process, it could be used to arbitrarily flood the kernel log
or crash the host if panic_on_warn is set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D12
