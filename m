Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279912BEFF6
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131045; cv=none; b=aRiP81AHN0k8bzRNOzpVlPfmDuc5t8HZJdsii7FoyYvBhqQdAUrpJHThzMTBX8jG7BPJElaChFjb8BW7V9mYA4HcvO4/mUYbYzzjhU/SQ36i4SA3PgITM6CdjSpKF9bnv1IuPGSvMyKby29qsBOcP7PZRDnCFjPfjOjy75nmjTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131045; c=relaxed/simple;
	bh=Ry09G0zkHpVTjZmE8iU2xI7W6qpK2g0KFZ7nsvfFTbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJqE5iYQmAhqOmDD58qQ0Rfo/EiqTzIROSIQcVlLgkh9he6t01fXLBqU0NTdywUpCDtk2Q4SshJonJVwN6qXWonmA4nz80iAcilmN1xSlnm3L9IKsX9euhFqHOMLyjZ/CtqgmK4ts9e9p+GYmXstPySDqB+oARnq6mbjqYUFE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ahFonT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ahFonT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927231F00893;
	Sat, 30 May 2026 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780131043;
	bh=vS20d9kZuPpZ+hX4ldYFf/oIjwqE6QRvVNtCgIjKWJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/ahFonTTFdSU5mAL9gRtYsBcn4cV/Ug9r4XveLRoJXtuNNTTxJuu9m5ZzUZNAZx0
	 Zjr7o61HrbOqr/ogXQaGwCxko7ZUM5WgkZtS05bIVRUAmMAyKSg7WQyrTi6snYDV0h
	 XyA8JZsrqzdqOdf3GS6rqA2TPrvjW/IE64ArqAGe9o28ye4sNLX2/5Gw5TtzPpFbck
	 aUztEwCEwRWvU2wMPeXpWwUPLQKT/ONto2UZV6L10XwvVXRS9l38NX2zU7hxvz9MfL
	 3DlNLfcu+yD/gp9iA3+6CjXuEfCZ8Ol9/gFNaLSRymuVZR646EEl75LeX5eLwY/zDD
	 a3affyUh1UGVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/24] KVM: SEV: Decouple the need to sync the GHCB SA
 from the need to free the SA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-17-pbonzini@redhat.com>
References: <20260529183549.1104619-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 08:50:43 +0000
Message-Id: <20260530085043.927231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] kvm_write_guest() is called with preemption disabled, which can tr=
igger a kernel warning or silent guest memory corruption.
--

commit 5732decf12690466d8d24cbb274489189ae7d7b2
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Decouple the need to sync the GHCB SA from the need to free the SA
   =20
This commit decouples synchronizing the GHCB scratch area from freeing and
unpinning it. This change allows the free and unpin path to be reused when
freeing a vCPU, and opportunistically adds a warning to prevent stomping ov=
er
an already-allocated scratch area.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 437282f0ea943..11d46600cbdc0 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3560,20 +3560,17 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
>  	if (!svm->sev_es.ghcb)
>  		return;
> =20
> -	if (svm->sev_es.ghcb_sa_free) {
> -		/*
> -		 * The scratch area lives outside the GHCB, so there is a
> -		 * buffer that, depending on the operation performed, may
> -		 * need to be synced, then freed.
> -		 */
> -		if (svm->sev_es.ghcb_sa_sync) {
> -			kvm_write_guest(svm->vcpu.kvm,
> -					svm->sev_es.sw_scratch,
> -					svm->sev_es.ghcb_sa,
> -					svm->sev_es.ghcb_sa_len);
> -			svm->sev_es.ghcb_sa_sync =3D false;
> -		}
> +	/*
> +	 * If the scratch area lives outside the GHCB, there's a buffer that,
> +	 * depending on the operation performed, may need to be synced.
> +	 */
> +	if (svm->sev_es.ghcb_sa_sync) {
> +		kvm_write_guest(svm->vcpu.kvm, svm->sev_es.sw_scratch,
> +				svm->sev_es.ghcb_sa, svm->sev_es.ghcb_sa_len);
> +		svm->sev_es.ghcb_sa_sync =3D false;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but can this call to
kvm_write_guest() trigger a warning or cause silent guest memory corruption?

In arch/x86/kvm/x86.c:vcpu_enter_guest(), KVM disables preemption before
calling prepare_switch_to_guest():

	preempt_disable();

	kvm_x86_call(prepare_switch_to_guest)(vcpu);

For SEV-ES guests, this invokes svm_prepare_switch_to_guest() ->
sev_es_unmap_ghcb(). Within sev_es_unmap_ghcb(), if svm->sev_es.ghcb_sa_syn=
c is
true, KVM calls kvm_write_guest().

Since kvm_write_guest() is a sleepable function and preemption is disabled,
this could trigger a warning in might_fault(), potentially leading to a host
denial of service if panic_on_warn is set.

Additionally, if the user address faults, the page fault handler might dete=
ct
the atomic context and fail the fault, causing the copy to fail silently and
corrupting the guest's execution.

Could a guest using GHCB version 1 force ghcb_sa_sync to true by supplying a
scratch area outside the GHCB, thereby triggering this path?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D16
