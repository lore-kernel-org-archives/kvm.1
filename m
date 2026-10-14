Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB736B906
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016668; cv=none; b=CdLsQBA/7xPrFdmZD/5Ip4UQSmwrpprEV7kvF5DqqVapKQVFb9goITlIVcDygp37YaWU7ioevjXlCMwXa5XPZHzxbW5tTl9FtP5Ewbq8+RG1yPAq5aGOmFqcgMTzv1VyfgjF7hRj+nGS/WaRfsZP/Q5kujn+h2M2WVm3o4Ede8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016668; c=relaxed/simple;
	bh=wZFf1lLb0RKRlB0m19hXdRImJYHOmu4dWMzcXH9VIGs=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=TZ9fWup+H9dIxlLawsxd3AyV06JVwJj+BrXRcow9ISXrprAGPSW6Axo+Ad/wIQoNezYAw0vBwl+dktNNYK2tJxbo5xqn+AlBGSG1W82zuhl7QzX5iXIc6ZEGtSNWYuJ+BM4MXOLVv1r86okNhTfc1lM+9AdGVeI89d+hbtrJmRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK7+/Vkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK7+/Vkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3911F000C4;
	Wed, 14 Oct 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792016667;
	bh=mRPhTiGpr6b/m30MQStUlf874dqnDK5mvAqebat84So=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eK7+/VklObrsNngRSlqtE6VYcE3jyhrqmIqKqBqRGpM/s4VuNSZb7W4BbchuLdytY
	 J9UGJ7Hbj+DvPMd5ceegouixBrzZbH4M6UlxIxVvzAJ90P6lGp3lltfvbKIB2ZYP+6
	 xPfMdIaCJAlB0G/o9DKedyJeThgeMeO45Yt5rMwsGvKeq2wjyOTUG2b6Z3JkbM6wSv
	 1+/ScNmUAugKPNVNIXzaR6Ka4uI9SsOP2LxEQ8Zn7e1CtMLmQce5y+jydpespwLKmC
	 fzwQd1taMe0JonFFzD+1U7TeMNfdZAIVGDifjNaqnmm6reGfuBSm1nC7N4D8pp611t
	 YMxnNm/UvTAJA==
Message-ID: <sashiko-outbox-171969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] KVM: x86/xen: Wait out memslot updates in the
 Xen attribute ioctls
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261014220508.518772-5-dwmw2@infradead.org>
References: <20261014220508.518772-1-dwmw2@infradead.org>
 <20261014220508.518772-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 22:24:26 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: unprotected kvm_memslots() dereference in kvm_xen_start_timer=
() due to missing srcu_read_lock()
--

commit 4fa2fbe5b2a708cc92e83f1efa33364d90021a44
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls

Activating a shared_info, vcpu_info, pvclock or runstate cache can fail if =
it
races a memslot update: previously with -EFAULT, now with -EAGAIN. These
ioctls may sleep, so pass wait and let the activation ride the update out.
The overarching SRCU read sections around the activation calls are removed
to prevent deadlocks against memslot updates.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 74dad6789e428..cd1063d659cc5 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c

[ ... ]

> @@ -937,7 +938,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, stru=
ct kvm_xen_vcpu_attr *data)
>  	int idx, r =3D -ENOENT;
> =20
>  	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
> -	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> =20
>  	switch (data->type) {
>  	case KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO:

[Severity: High]
With the overarching SRCU read lock removed here, are there paths in the
switch statement that still require the lock but were missed?

For example, in the KVM_XEN_VCPU_ATTR_TYPE_TIMER case:

arch/x86/kvm/xen.c:kvm_xen_vcpu_set_attr() {
    ...
    case KVM_XEN_VCPU_ATTR_TYPE_TIMER:
        ...
        if (data->u.timer.port && data->u.timer.expires_ns)
            kvm_xen_start_timer(vcpu, data->u.timer.expires_ns, false);
    ...
}

This calls down into xen_get_guest_pvclock() and kvm_gpc_check(), which
then accesses kvm_memslots(gpc->kvm):

virt/kvm/pfncache.c:kvm_gpc_check() {
    struct kvm_memslots *slots =3D kvm_memslots(gpc->kvm);
    ...
}

Accessing kvm_memslots() triggers a srcu_dereference_check() that fails
without the SRCU lock held, and could result in a use-after-free if
kvm->memslots is freed concurrently.

Will this path now result in a lockdep splat ('suspicious RCU usage') and
potential use-after-free when a userspace process calls the
KVM_XEN_VCPU_SET_ATTR ioctl with KVM_XEN_VCPU_ATTR_TYPE_TIMER?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014220508.5187=
72-1-dwmw2@infradead.org?part=3D4
