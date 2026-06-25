Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF72F690F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782427853; cv=none; b=SHAGe+dQM1EsDublDZc1u6HE4GSw0shwAJSNhOor/vzg+6uSXOn6d4Cb6wc7SEVcBms0c6RRt8nfHGcEjIKGrQ9rFF8JdjPEYmrf2fuq4h/Cf08FvI2UA9GcuZ8kzz5wBp/S0Wc8WtQEWfKHz36cNzWrZRTbvDXfDqng3XNj6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782427853; c=relaxed/simple;
	bh=VCoRoNU8punqOk/SxRzeLQ6mGaXOndK78nrS5aZ1FM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JArHKn+mCv+ePuhUV+oWRv+AVzrTjnYFuIlKhci7m6D4faFY20E/OcKXyAK+mdCJQV8NmX4v1uvfFZGblhBr7deoDrzc6acHJdGCE5EsKC1a51tq7EKEQGfvsxN7z/eLFalaZbhK2Vu2B5jLtdlkSbYJzyGM7V61gyptqkLnEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHktboP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHktboP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D061F00A3A;
	Thu, 25 Jun 2026 22:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782427852;
	bh=usknHV9c/O/K6M5qiySmYYy8QHXjiDr8mkj6E/SEwmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cHktboP+wnoBHMa6g2TuCbbpdRlPF7x2xg8tuAQVWLGDjocADPalAWi4h0ahFlRr9
	 jGvkVUL1sMXLqEqFgxpIVMHA4SDVXZ4rIGI8eW5geh65sQBDNSaM5BdvM1FXZtCLkD
	 vZx5nnzX835b/k4igdZ5ZHQBEiyzh5mFWB3AK528hUy/NaZbfSbIKDwXuI++0o/V7L
	 gAf6quyPWQytKvwS5AD7h16SKnJ4FDg7X5YpPrWEEL0iA9L/pcLaNtpk0OPeFpNVrh
	 Lwheb8lTB+7eAWURo4X+KwzgdqDmHjAwDJfb1X6z64nyiWUn5+O3zMs7RZNFJ+JOwn
	 he59svBNBbM0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] KVM: x86: Treat a vCPU as unreachable if its
 index is invalid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625223623.3376478-9-seanjc@google.com>
References: <20260625223623.3376478-1-seanjc@google.com>
 <20260625223623.3376478-9-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:50:51 +0000
Message-Id: <20260625225052.25D061F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete Error Handling / False Positive Lockdep splat in `kvm_v=
m_ioctl_create_vcpu` error path.
--

commit 726fb8156ac4915c6ef069eb4dbdc2204c9bf2fb
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Treat a vCPU as unreachable if its index is invalid

This commit modifies the vCPU lockdep assertion to treat vCPUs with a
negative index as unreachable, aiming to avoid false positives while the
vCPU is in the process of being created.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index b10814f99a50b..0bdfa36993527 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -992,6 +992,7 @@ static inline struct kvm_io_bus *kvm_get_bus(struct k=
vm *kvm, enum kvm_bus idx)
>  static inline void kvm_lockdep_assert_vcpu_is_locked_or_unreachable(stru=
ct kvm_vcpu *vcpu)
>  {
>  	lockdep_assert_once(lockdep_is_held(&vcpu->mutex) ||
> +			    vcpu->vcpu_idx < 0 ||

[Severity: High]
Does this check fully cover the failure path in kvm_vm_ioctl_create_vcpu()
when create_vcpu_fd() fails?

If an unprivileged user exhausts their file descriptor limit,
create_vcpu_fd() can fail after the vCPU is successfully inserted into the
xarray (setting vcpu->vcpu_idx >=3D 0). The error handler then does this:

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu() {
    ...
kvm_put_xa_erase:
        mutex_unlock(&vcpu->mutex);
        kvm_put_kvm_no_destroy(kvm);
        xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
unlock_vcpu_destroy:
        kvm_arch_vcpu_destroy(vcpu);
    ...
}

Since xa_erase() is called but vcpu->vcpu_idx is not reset to -1, the index
remains >=3D 0. When cleanup proceeds to kvm_arch_vcpu_destroy() and
eventually evaluates this lockdep assertion, the mutex is unlocked and
vcpu_idx >=3D 0.

Could this result in a false positive lockdep splat that panics the host if
panic_on_warn is enabled?

>  			    !refcount_read(&vcpu->kvm->users_count));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625223623.3376=
478-1-seanjc@google.com?part=3D8
