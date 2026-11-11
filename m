Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392234;
	b=08Co27VnyiWErrLxNKCzktvfS1CvOp/G41yyL5C/uLCRHOa3OqPJScZjpGmXSf9iQOvr
	 A6FApT/OY+wQc4E1GCwcSJO+0tRWSLUPjxgpNcMcZjIH4tYANm41JAGdorJw3u67I82Tl
	 j5k+v3Mmcx1YzSfWNftSwl71v8FIyMtOHMEw0EpaWPIJyRBfV8gfMLkyFW1AsC/I5WIW+
	 u1+xziWy4gTN0O+iMhgkHUwpDtSR0SnOopOdkwNJhyD7xXvqNM8oql6MLJmiDPhjJ4s+V
	 bYPK7dLns1yciN4cUFoa/YahH8EqciCjxoikC25JwujRXZExZmuyw4vFK3EA+kb/vog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JbBNsjPSZF1wcC+Lzw7Db1u6xr38qqIN65CXWEk/Dng=;
	b=d/3eS36lp0IMZTw8yE77cbkTOfH1BweoVi9NckNF2B1MNjL4X5DwcNRzEeJwP3p2flFa
	 0xgmYYL3uBFoj3zw+laM3VMhtabF6QAa1lp1dKR5SQNkTmZc5g3QlTKM+a9j/61o0+Xaf
	 yND4DEu87S3zUGnBoF3xXrGfA7TYTXUfVyBjPbQ8Se9k93OQ0BPFio/b0zYFuxJN2oN7U
	 GEyWC8Nb1CGLo0pyg8wIBhKU/z4/jK6uKFyaIw3vYuElMR2htU4jSKVUubIHP8C7kJAtu
	 /GrOKD08BphDF3E8NZsYY/T43AhD1AHUb8JkaNhrE0AGQEMPBQulyw5gC+JlhxXZF7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoULDpR0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF1606A321
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoULDpR0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1E31F00A06;
	Wed, 11 Nov 2026 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392234;
	bh=JbBNsjPSZF1wcC+Lzw7Db1u6xr38qqIN65CXWEk/Dng=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QoULDpR01MJbsbsH7yEegxZxaMD+DWmBPOLXxPoIWmJRTVEGCDQj7Z4XCblr3KfRr
	 EX4jQGVON5a5bwiZ0HTcxD4tRwA0/OA9C2qmEdKbApZiUQIW08n1H1ckP9j1WChjWM
	 Zrwsgq58JypLITIq1hQ3mcLGIWNdZXQ9qoXqEg5h4bXcogbae6MpARfN3wePaeEthp
	 0d0bxLapW/ZOGOc49dE2lWbk/SIwMCPtAUDiFaf+E7uDT5I6Xok7XunkBQ5Tu9bf/x
	 gP88h7fgK0jx85dDQ1Qk9iSUlzCeIQdGLCiTH4ijJIw/u4uAF7j7/hLfx0dGHAGmHK
	 ATao1cAvq6qSQ==
Message-ID: <sashiko-outbox-208769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH]  x86/kvm: Use RCU for svm_vm_data_hash
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261111100246.4425-1-sarunkod@amd.com>
References: <20261111100246.4425-1-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:17:14 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] KVM: SVM: UAF in avic_ga_log_notifier() and
  avic_vm_pre_destroy() with RCU
- [Low] KVM: SVM: unnecessary guard() removal in
  avic_add_vm_to_ga_log_list()
--

commit 460915a518276bc08e3b21ecfcfa94bc27d07493
Author: Sairaj Kodilkar <sarunkod@amd.com>

x86/kvm: Use RCU for svm_vm_data_hash

This commit replaces the spinlock-protected lookup of svm_vm_data_hash in
avic_ga_log_notifier() with an RCU read-side critical section, and updates
insertion and removal to use hash_add_rcu() and hash_del_rcu().

> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 3b037e3855234..ba12aa5872255 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -250,7 +250,6 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
>   */
>  static int avic_ga_log_notifier(u32 ga_tag)
>  {
> -	unsigned long flags;
>  	struct kvm_svm *kvm_svm;
>  	struct kvm_vcpu *vcpu =3D NULL;
>  	u32 vm_id =3D AVIC_GATAG_TO_VMID(ga_tag);
> @@ -259,14 +258,14 @@ static int avic_ga_log_notifier(u32 ga_tag)
>  	pr_debug("SVM: %s: vm_id=3D%#x, vcpu_idx=3D%#x\n", __func__, vm_id, vcp=
u_idx);
>  	trace_kvm_avic_ga_log(vm_id, vcpu_idx);
> =20
> -	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
> -	hash_for_each_possible(svm_vm_data_hash, kvm_svm, hnode, vm_id) {
> +	rcu_read_lock();
> +	hash_for_each_possible_rcu(svm_vm_data_hash, kvm_svm, hnode, vm_id) {
>  		if (kvm_svm->avic_vm_id !=3D vm_id)
>  			continue;
>  		vcpu =3D kvm_get_vcpu(&kvm_svm->kvm, vcpu_idx);
>  		break;
>  	}
> -	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
> +	rcu_read_unlock();
> =20
>  	/* Note:
>  	 * At this point, the IOMMU should have already set the pending
> @@ -319,13 +318,14 @@ static void avic_add_vm_to_ga_log_list(struct kvm *=
kvm)
>  	struct kvm_svm *kvm_svm =3D to_kvm_svm(kvm);
>  	struct kvm_svm *k2;
>  	u32 vm_id;
> +	unsigned long flags;
> =20
>  	lockdep_assert_held(&kvm->lock);
> =20
>  	if (kvm_svm->avic_vm_id)
>  		return;
> =20
> -	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
> +	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
>   again:
>  	vm_id =3D next_vm_id =3D (next_vm_id + 1) & AVIC_VM_ID_MASK;
>  	if (vm_id =3D=3D 0) { /* id is 1-based, zero is not okay */
> @@ -340,7 +340,8 @@ static void avic_add_vm_to_ga_log_list(struct kvm *kv=
m)
>  		}
>  	}
>  	kvm_svm->avic_vm_id =3D vm_id;
> -	hash_add(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
> +	hash_add_rcu(svm_vm_data_hash, &kvm_svm->hnode, kvm_svm->avic_vm_id);
> +	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
>  }

[Severity: Low]
This isn't a bug, but commits 4fa9a3767d1a ("KVM: SVM: Do all per-VM AVIC
initialization during vCPU precreation phase") and 78684b65fcc0 ("KVM: SVM:
Remove VM from the GA Log notifier list before VM destruction") switched
avic_add_vm_to_ga_log_list() and avic_vm_pre_destroy() to
guard(spinlock_irqsave)(&svm_vm_data_hash_lock), which can still be kept
here instead of open-coding spin_lock_irqsave() and spin_unlock_irqrestore(=
).

>  int avic_vcpu_precreate(struct kvm *kvm)
> @@ -369,13 +370,14 @@ int avic_vcpu_precreate(struct kvm *kvm)
>  void avic_vm_pre_destroy(struct kvm *kvm)
>  {
>  	struct kvm_svm *kvm_svm =3D to_kvm_svm(kvm);
> +	unsigned long flags;
> =20
>  	if (WARN_ON_ONCE(!enable_apicv) || !kvm_svm->avic_vm_id)
>  		return;
> =20
> -	guard(spinlock_irqsave)(&svm_vm_data_hash_lock);
> -
> -	hash_del(&kvm_svm->hnode);
> +	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
> +	hash_del_rcu(&kvm_svm->hnode);
> +	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
>  }

[Severity: High]
Can this cause a use-after-free on struct kvm_svm and struct kvm_vcpu
when a VM is destroyed concurrently with avic_ga_log_notifier()?

CPU0                              CPU1
avic_ga_log_notifier()            kvm_destroy_vm()
  rcu_read_lock()                   ...
  hash_for_each_possible_rcu(...)   avic_vm_pre_destroy()
    vcpu =3D kvm_get_vcpu(...)          hash_del_rcu(&kvm_svm->hnode)
  rcu_read_unlock()                 ...
                                    kvm_destroy_vcpus()
                                      kmem_cache_free(..., vcpu)
                                    kvm_arch_free_vm()
                                      vfree(kvm)
  kvm_vcpu_wake_up(vcpu)  <-- use-after-free

avic_vm_pre_destroy() unlinks kvm_svm->hnode with hash_del_rcu(), but
nothing waits for an RCU grace period before kvm_destroy_vcpus() frees the
vCPUs and kvm_arch_free_vm() frees struct kvm_svm (the intervening SRCU
synchronizations in kvm_destroy_vm() only cover private SRCU domains). An
in-flight reader on the same hash bucket can therefore dereference freed
kvm_svm or vcpu memory.

In addition, avic_ga_log_notifier() calls rcu_read_unlock() before
kvm_vcpu_wake_up(vcpu). Because kvm_get_vcpu() does not take a reference,
dropping the RCU read lock early leaves vcpu unpinned even if
avic_vm_pre_destroy() waits for a grace period. Calling kvm_vcpu_wake_up()
inside the rcu_read_lock() critical section and adding synchronize_rcu()
after hash_del_rcu() in avic_vm_pre_destroy() would close both windows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111100246.4425=
-1-sarunkod@amd.com?part=3D1
