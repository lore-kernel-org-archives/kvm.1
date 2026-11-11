Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436159;
	b=X3BgBeI1/9Q5oTe+ACkc0oCYrdshXJ5pMUqFgoKvD9NxXAOKSX4qkoEvYjcqtICoqlI7
	 haA8lhYcvZ6OQaS6hDh2w/fcijfKDPKcaSIU/MBREuSxhArhDqb61IvjPQNIqRNqxh6gH
	 jyQcguqclwrVaytO35igvNvC2vLrCzQl1i4kMvWIogH6UL8WYvCCHmIjujn96yKeGwR3N
	 1FBYRgAJIBNJs8I0iF6CW9hFIZ33sRLaRn2TnQ0wdl6WOgMruAgD/Qv4Hyd3569R+T2XK
	 601DQdgryeBgsQuSzWcG+6UcuS+/Ncv09FfHl/ZIN1a24rsUrIohBBow61X55av+eKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436159;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rVF1T5AUbkGAT78csvYzkk+scpgBy3gKIJhbgAeeR4M=;
	b=iGGWsFxJWOH7akbqsHrgw4KLMp7NfI5r47ZpUckKoPyfQ+stT8JioearsFK8RMH5HAyy
	 qvmBi85Pd20hxd7YbWn1XD9V4O+XpEQUi8RbcMUwXBq/oRJJ+lsOVcl+E1DXCOgxnCphc
	 h5V0ULACNu4V1jgA0gLm4Ai4tpZdaDjzhaRd0/XlLID97RzK2VXLmuwiMIgAd124ujWhn
	 RkzpGOgO1betM5yMLSSq+6+zf4D7PDgYwD738yUdcwAjYo9tWRrWbsVFtV2PcXPdD17O7
	 rfs/Gxd5pyDk/TFYzfKS8eDy/nCYFRTM32OdVkZ1pHfiTR7+wAMnmDTe68m2ACRgHHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlS3+DlC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58160A381C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlS3+DlC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AB01F00AD2;
	Wed, 11 Nov 2026 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436159;
	bh=rVF1T5AUbkGAT78csvYzkk+scpgBy3gKIJhbgAeeR4M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZlS3+DlCnHzWr5uR4/CVlFGGuWpVBWWeKPqdVD/8faNp+eotuTnDnRh/66OsC3BwV
	 JsKwAquaHNkcs3ID/RG5PYyd+wakHQeR96UA8f3V0SmXtYDjNwHjbEx/0XcDXj4r70
	 S1qLwpe/5r5paXXtgPI6WWU3wUlLE0QDmV0QAZ3YdGmvbqJIjFYf0vEGYkY2lBNBB1
	 RzmUpG7nvjqKWoVsyrCntVPAJAFDEBc/NwSnhTJyELPPB6SVOxggfFWSMlCjTseOsj
	 FopWDyS/Oa7Umbg4SnMYov1YYBINdC/tEoMyQudKizZl90A2RhinLCMjLMtCQv4VrJ
	 I8lnKQ5pRvwYA==
Message-ID: <sashiko-outbox-209792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 16/26] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261111180922.4177927-17-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
 <20261111180922.4177927-17-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 22:29:19 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: x86: stale masterclock state in
  kvm_vcpu_ioctl_get_clock_guest()
--

commit 06987440f414497c2402ac529d8fa56884dbca59
Author: Jack Allister <jalliste@amazon.com>

KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration

This commit adds the KVM_GET_CLOCK_GUEST and KVM_SET_CLOCK_GUEST per-vCPU
ioctls to save and restore the PV clock parameters in terms of the guest
TSC across migration.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 743da71cd84d7..16383c71131d0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -3941,6 +3944,218 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_v=
cpu *vcpu,
>  	}
>  }
> =20
> +#ifdef CONFIG_X86_64
> +static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __use=
r *argp)
> +{
> +	struct pvclock_vcpu_time_info hv_clock =3D {};
> +	struct kvm_arch *ka =3D &v->kvm->arch;
> +	bool use_master_clock;
> +	unsigned int seq;
[ ... ]
> +	if (kvm_test_request(KVM_REQ_MASTERCLOCK_UPDATE, v))
> +		kvm_update_masterclock(v->kvm, v);

[Severity: Medium]
Can kvm_vcpu_ioctl_get_clock_guest() read stale VM-wide masterclock state
when KVM_REQ_MASTERCLOCK_UPDATE is queued on a different vCPU?

While host resume and gtod updates broadcast KVM_REQ_MASTERCLOCK_UPDATE
to all vCPUs, per-vCPU TSC and frequency synchronization paths queue it
only on the vCPU being modified:

arch/x86/kvm/x86.c:kvm_track_tsc_matching() {
    ...
	if ((ka->use_master_clock && update_mclock) ||
	    (ka->use_master_clock !=3D use_master_clock))
		kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
}

If userspace changes vCPU 1's TSC frequency via KVM_SET_TSC_KHZ so that
ka->all_vcpus_matched_freq becomes false, KVM_REQ_MASTERCLOCK_UPDATE is
set only on vCPU 1 while ka->use_master_clock remains true.  Calling
KVM_GET_CLOCK_GUEST on vCPU 0 before vCPU 1 enters the guest sees no
pending request on vCPU 0, skips kvm_update_masterclock(), and returns
the stale masterclock parameters instead of -ENODATA (or conversely
returns -ENODATA after vCPU 1 restores frequency matching).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111180922.4177=
927-1-dwmw2@infradead.org?part=3D16
