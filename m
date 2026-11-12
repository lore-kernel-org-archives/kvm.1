Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466138;
	b=TaYrz3+R02tLVK8Lyg1pSWXD5z3PH3X2L8X25rb7P4hBfE2zmb89WhLWVXrVBFvn5nMg
	 61i0+9qRC6qhu5ApQyghHZbunF/QBo1SGyqGNe5dSVtbryBmdMssMaSScpB4FgNI96KfO
	 SvUFYzAIaXbfLAJ8m1d6etdUDPbLH0v+qkwOY6pT5qUFdUq8gltyoBbSPezX/3cUYFbv1
	 9EMTcUtGgh+TrQDWc57xF/YWUaft/RdWriwF3WtubyTa9EtJWpRdZ1winvIzsBk7ZNwN5
	 COV/CVezPY4xyHba7rbXEz5At1E3o7pgCLZJRvB/CJAOE8uxWKMlzn30pv2YVre+d7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466138;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZQQ5BZ67+Yu7oZXfyXrk4L5CWILlviRHC34FAgj9QMs=;
	b=HKaEfPlqtgc2btJ9dUtVX8J3GA9ft9+Arx0XdiVDPgPxDSrBo1r2ibXkLbPMUKGoZfgC
	 UcyM89f4CykBLqFvg2x6bprrYLpWVug7iExqAgE/siqu/L6fL5sgYucJaCOREMnIgrvmB
	 PnpLjYmHwEDpZH5yfKwG0TBhoMPofUIVWxZJ0OkrsODRrNBWOVPU2z40t8ML+Wc4e5xTy
	 KJ0VJGZfraavLftPAq9AmrB5Tr5EEf8MeeYHimMOarMmxeO1kEIOrO3wUyHLsYrWHq0Hp
	 a9AHtcKmBMZrJWsMCwqiU74CY20gbsLJ/HcnBzJfga7tEHTMmTI5ZwGUXIjL+m5FWSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMuYjr5Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29A606A321
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VMuYjr5Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E921F00A05;
	Thu, 12 Nov 2026 06:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794466137;
	bh=ZQQ5BZ67+Yu7oZXfyXrk4L5CWILlviRHC34FAgj9QMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VMuYjr5YdWqP8+q4v0T09lBth5sg1bqzYGcUOUJ6m/gF8HD2rn8gWYUTBiypeiwRZ
	 5wC1/+AB8ecbE3y8yEepsivMHHBDM6mmzClqF1wvSl0B+PKFsu1BM0p7/XHyA83oj/
	 SbXwO8JZv+nfOnvKg6I2QT2v+BiFcLS8uVrvoHj/XBWRWL1cthcrlR2vP0eIwG7IHO
	 q59hn7wfJ/h4sKVKKMMXzyWcDAyeP/NYLkcx7CldkaIAYAsr9pGAarmCGAEANawWIT
	 b02fIIihJj1JuXGgo/A3POHFzjyOt08pa8objIG+EF9mwxQytsKMv/Goc/5exDG28w
	 HB/EQ3GZjNpsQ==
Message-ID: <sashiko-outbox-210535@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nSVM: Check full nested state size before writing
 to user buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyanka Mani" <priyankamani2100@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <57324d544da1e92cf3b30ff7c40595dfbca1933d.1794465097.git.priyankamani2100@gmail.com>
References: <57324d544da1e92cf3b30ff7c40595dfbca1933d.1794465097.git.priyankamani2100@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:48:57 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] KVM: SVM: guest mode and MMU leak in svm_set_nested_state() [1]
--

commit 69ab785aa5333f3d6749b1f4b937158e7dfed5c6
Author: Priyanka Mani <priyankamani2100@gmail.com>

KVM: nSVM: Check full nested state size before writing to user buffer

This commit adds KVM_STATE_NESTED_SVM_VMCB_SIZE to kvm_state.size before
checking user_data_size in svm_get_nested_state() when the vCPU is in
guest mode, preventing writes past the end of a too-small userspace
buffer.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 1cecb82702e2c..9a70136172f38 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1916,6 +1916,9 @@ static int svm_get_nested_state(struct kvm_vcpu *vc=
pu,
> =20
>  	svm =3D to_svm(vcpu);
> =20
> +	if (is_guest_mode(vcpu))
> +		kvm_state.size +=3D KVM_STATE_NESTED_SVM_VMCB_SIZE;
> +
>  	if (user_data_size < kvm_state.size)
>  		goto out;
> =20
> @@ -1925,7 +1928,6 @@ static int svm_get_nested_state(struct kvm_vcpu *vc=
pu,
>  		kvm_state.hdr.svm.gpat =3D 0;
>  		if (l2_has_separate_pat(vcpu))
>  			kvm_state.hdr.svm.gpat =3D svm->vmcb->save.g_pat;
> -		kvm_state.size +=3D KVM_STATE_NESTED_SVM_VMCB_SIZE;
>  		kvm_state.flags |=3D KVM_STATE_NESTED_GUEST_MODE;
> =20
>  		if (vcpu->arch.nested_run_pending)

[Severity: High]
This problem wasn't introduced by this patch, but in the paired setter
svm_set_nested_state() [1], does a failed nested_svm_load_cr3()
leave the vCPU in guest mode with an active nested MMU context?

arch/x86/kvm/svm/nested.c:svm_set_nested_state() {
    ...
	nested_vmcb02_prepare_control(svm);
    ...
	ret =3D nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
				  nested_npt_enabled(svm), false);
	if (ret)
		goto out_free;
    ...
}

nested_vmcb02_prepare_control() enters guest mode and initializes the
nested MMU context, but the out_free error path only frees save and ctl
without calling leave_guest_mode() or nested_svm_uninit_mmu_context().
If userspace passes an invalid guest CR3 and then continues running the
vCPU after KVM_SET_NESTED_STATE fails, the vCPU runs with a corrupted
nested state and leaked MMU state.

[1] https://sashiko.dev/#/bug/linux-2c0d7c2c-169f-45d3-9953-b6aaf919e66b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/57324d544da1e92cf3b=
30ff7c40595dfbca1933d.1794465097.git.priyankamani2100@gmail.com?part=3D1
