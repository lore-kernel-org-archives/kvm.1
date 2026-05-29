Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B8F37E31E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075379; cv=none; b=YuL48vOz5aomt9rAmsvWZunqsVhhqbGCP2DWrCWosFf1l/+SWkyIwwFhGFFT5BZYaxlsN6tSkCEAfLMTDlbbNcfbFEP0YwQ0b0VopFt27re/nSD7+PL3fxOvvxdJ9ed2od35OjLGQk0Mps3zQBqyhSTGErFN4zF/yix/OgkPGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075379; c=relaxed/simple;
	bh=r6lrI6HDkrZuYjaN5VU8rHj5jPC8UGo+3qBNkQ/Cud8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EkLc5e06eYbDt8KqpD+enWBxvBKKHc8EgozCqx7VaGAl7kHY+dpztgXD0WoD/+P8Vg3DRg0YNBk3ANQk3gP5mU4Fb4bykMVExhg62B0guKOw+QO5mjg9KEiwzpPB0L025pFgkadneLkbNo0RS215Yuthqy9vBaEWcMn0I/HzXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9McPdHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9McPdHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3671F00898;
	Fri, 29 May 2026 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075378;
	bh=ScPmv/yoP+hrWeoAdXFzwRPzMPWJfsneMhCzDNuXCp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A9McPdHzUk6Dxa1c0YuBt4FFAf9wwBC1Iz3xxT7hfw6EAHAMZ6WQp8Q/PJb3htLOV
	 VUWQ9NpDKWUhIqw5ZZ5djc0FFpg+PTbRCCRODBbVG7NclAtm7mrTI4o9yOlaFShKA8
	 IoRbTtgyaoyDpdRy66dDPpMC1ffa6F6hT1Nwr1FP3vvX19XtubFAVNBC/fGbS+Nm98
	 QaND4qnHBrbNLY0hRQgpn5a264aJRP7LCG0QrLAgBhDY5QCBnclrFfIdK3h9ssn4jC
	 vL7WtJIL7TpVPrfvGOS8P9mAUdNRLb7Vww6Dhkd12tP/Dhw0JfX3tso/6mHqVgpUds
	 B7kAgLarCJWpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/27] KVM, vfio: remove symbol_get(kvm_put_kvm) from
 vfio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-4-seiden@linux.ibm.com>
References: <20260529155050.2902245-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:22:58 +0000
Message-Id: <20260529172258.8C3671F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unlocking `kvm->lock` after calling `kvm_put_kvm()` results in=
 a Use-After-Free if it was the last reference.
--

commit 79e5304c707c4ed618be6e55a950250edf9a7337
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio

This patch replaces the symbol_get() approach for KVM/VFIO interaction
by storing the address of kvm_destroy_vm in "struct kvm" to handle
kvm_put_kvm calls. This allows removing the cross-module dependencies
and directs kvm_put_kvm to the correct architecture implementation.

[ ... ]

> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index 4cb68c71a13cd..8a9be07cb8dd6 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h

[ ... ]

> @@ -162,6 +163,13 @@ static inline bool kvm_get_kvm_safe(struct kvm *kvm)
>  	return refcount_inc_not_zero(&rc->users_count);
>  }
> =20
> +static inline void kvm_put_kvm(struct kvm *kvm)
> +{
> +	struct kvm_refcount *rc =3D (struct kvm_refcount *)kvm;
> +	if (refcount_dec_and_test(&rc->users_count))
> +		rc->destroy(kvm);
> +}

[Severity: Critical]
This is a pre-existing issue, but can calling kvm_put_kvm() here lead to a
use-after-free in vfio_ap_mdev_unset_kvm()?

Looking at vfio_ap_mdev_unset_kvm() in drivers/s390/crypto/vfio_ap_ops.c, it
calls get_update_locks_for_kvm(kvm) which acquires mutex_lock(&kvm->lock).

It then calls kvm_put_kvm(kvm) which decrements the reference count and
can trigger kvm_destroy_vm(), completely freeing the kvm struct memory:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_unset_kvm() {
    ...
		get_update_locks_for_kvm(kvm);

		kvm_arch_crypto_clear_masks(kvm);
		vfio_ap_mdev_reset_queues(matrix_mdev);
		kvm_put_kvm(kvm);
		matrix_mdev->kvm =3D NULL;

		release_update_locks_for_kvm(kvm);
    ...
}

If the KVM file descriptor has already been closed by userspace, this could=
 be
the final reference to the KVM object. When release_update_locks_for_kvm(kv=
m)
is subsequently called, it will attempt to execute mutex_unlock(&kvm->lock)
on the freed kvm pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D3
