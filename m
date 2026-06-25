Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C783B7754
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782428238; cv=none; b=TMw7n7AzBHsFGdk5CO1gT5BroiFrjzos6gRCd57Rr9PAcWBVjopBKRFsK5/+24MPpEHVBCmxu/6GKG+1r3cZGiCLIzLi8VHJipuS679T9mIU2A4llYLSmK6IvwAVHlv81NcNadrR8W9ba9lbXd4K6qdMIrYRrF+7kZjmRNWmZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782428238; c=relaxed/simple;
	bh=4iBOLBh9vx38vwoAxdrV+cmXuvZnykWaTVOT2+FmiQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ifnDBEkmloY/vvbJtXvlZO4VBhblpDQBkIalWqjHIOv7dHljVtVDlH+fyzBgCVQWqoAcr9dOoOWFA4cZOBsoPcrAxVKpLOYh4Y7FUTVhsQs2qt0ZjK0n9HcnHFFyAFqjFANMzCHlc63dsrub/LIUlUEkOinEgaTavp4fGQD6big=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRqNTeY2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRqNTeY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5102D1F000E9;
	Thu, 25 Jun 2026 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782428235;
	bh=diZ++eicb9IvpvwVbueDHXKKAovGcgmMahlFkbgdX4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fRqNTeY2FjxxpsGxKpaQSTpIZOQrhlPwbCPCwFSkhdYA1rDvvwRo7kHnAHCFN7+tA
	 H6KrqxZRbcFyzl+kPLHUrcITnp2KCwKTCGOJT/8DAu6HSyt+RXnrXbGZ1BtfIKTwN6
	 17T813ofJzARY2yP9wLzwDdRs6ByocrpeCV95Y00DHESXYt51ThnfKCKObcMpAC/KS
	 ovp73w50fhds2MHKLa5x+xJupNRql23OajYgeRb7e0e1kjRihZCJVT8HqFPNSUvElk
	 4nQqAaZOrM2a94sG1N9ll2dKz9Y+V7vNhq0HQRMc0EdKtHhoqZ2/ms1LpeJAJSX9dB
	 gjYtX9yjeOH0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] KVM: Initialize a vCPU's index to '-1' while
 it's being created
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625223623.3376478-7-seanjc@google.com>
References: <20260625223623.3376478-1-seanjc@google.com>
 <20260625223623.3376478-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:57:14 +0000
Message-Id: <20260625225715.5102D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The vCPU index is not unwound back to -1 on the `create_vcpu_fd(=
)` error path, defeating the patch's attempt to suppress false-positive loc=
kdep assertions for unreachable vCPUs.
--

commit 9b2b93c21cc41f8ad615424559c365580d248898
Author: Sean Christopherson <seanjc@google.com>

KVM: Initialize a vCPU's index to '-1' while it's being created

This commit initializes a vCPU's index to -1 during creation to prevent KVM
from incorrectly treating an unreachable vCPU as vCPU0. It also unwinds the
index back to -1 if inserting the vCPU into the array fails, suppressing
false positive lockdep assertions during teardown.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e44c20c049610..98da4c889ffc6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -4216,11 +4218,18 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *k=
vm, unsigned long id)
>  		goto unlock_vcpu_destroy;
>  	}
> =20
> +	/*
> +	 * Set the vCPU's index *before* the vCPU is reachable by other tasks.
> +	 * Unwind the index back to -1 on failure so that KVM can use the index
> +	 * to detect that the vCPU is unreachable, e.g. for lockdep asserts.
> +	 */
>  	vcpu->vcpu_idx =3D atomic_read(&kvm->online_vcpus);
>  	r =3D xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCO=
UNT);
>  	WARN_ON_ONCE(r =3D=3D -EBUSY);
> -	if (r)
> +	if (r) {
> +		vcpu->vcpu_idx =3D -1;
>  		goto unlock_vcpu_destroy;
> +	}
> =20
>  	/*
>  	 * Now it's all set up, let userspace reach it.  Grab the vCPU's mutex

[Severity: Medium]
Should the vCPU index also be unwound back to -1 on the create_vcpu_fd()
error path?

If a local process exhausts its file descriptor limit, create_vcpu_fd()
will fail and jump to the kvm_put_xa_erase label in kvm_vm_ioctl_create_vcp=
u():

kvm_put_xa_erase:
	mutex_unlock(&vcpu->mutex);
	kvm_put_kvm_no_destroy(kvm);
	xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
unlock_vcpu_destroy:
	mutex_unlock(&kvm->lock);

Since xa_erase() is called here without resetting vcpu->vcpu_idx =3D -1, do=
es this
leave the vCPU with a valid index during the subsequent kvm_arch_vcpu_destr=
oy()
call, potentially triggering the same lockdep assertion splats this patch
is trying to prevent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625223623.3376=
478-1-seanjc@google.com?part=3D6
