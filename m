Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C13D3499
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937395; cv=none; b=mQB4BY01Wq0XnvfaQRFwzoPTDQ7+RErntj1oILxFX1OLMPU+NyAlXo+0rEQ2TCeMv8fvOi0f0gJoIusCeV9BnxNgZ8qZRcWPn8eFhtL5r1ztPX8wy1Ms38UF2Lq0q2o1FcJ/93n3sAarPiq9xHjTU2oBVvrSMCqnIIn4QQRjz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937395; c=relaxed/simple;
	bh=4qK/CSLVlbGQRjhXEesSEAqEBdUq6XswTumOKF4+ocw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwVXEL32aGRqx0R31o1Rv05ZCyYINwPQ+bn3zVq+eIWPzGXu0O2VFbPR3zx+XX7QFHCvg5RQMWQsPh/a6NGvnxk5UXe8Qmoohkbfz3v+tgl+uMXIL8CQ0V3zuZTEZi+YVb7frNJTnkET0G9FLRC1JfelcBvdgVpwXE6UNvJHsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0l6voRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0l6voRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005711F00893;
	Mon,  8 Jun 2026 16:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780937394;
	bh=ArybaLcEZseiRPM21haBWFHHBurMC/iNCPBfyTSqETw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0l6voRCxYodSB3AqNFtj5+Sg1aing40tTS75sGcbFhsTVVlxMwbmjKVC2CXyFfEe
	 9//+EsT9tIzA6mZtRtloLlk0Ee2dwByk/IAfSO3rtPAW+s5K7HMWOgs6wP06E8n0nf
	 OzNz9C/OFJug8gZdjczRctWx6s0y79JGW8vUvKkHz1564u9KsnyrHMVQczDSGcA/NG
	 EDNb6e5Ac+RmONKtMCp9R3tMy/dVa3r3wyk/+NeMWgSJtpILZWI0AntBbeV7jj3H1U
	 RfPxV0ACfL9zzXlL6ULWG/8huZcsg5seuYPTcqEI2zYZgAq+K1BZQc6oPuBTtXgtnR
	 AhJhUjLr04l3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/60] kvm: Move kvm_vcpu sigset members to struct
 kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-24-joro@8bytes.org>
References: <20260608144252.351443-24-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:49:53 +0000
Message-Id: <20260608164954.005711F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The KVM_SET_SIGNAL_MASK compat ioctl modifies the shared `vcpu->co=
mmon->sigset` and `sigset_active` without acquiring `kvm_vcpu_mutex(vcpu)`,=
 allowing concurrent modification and permanent signal mask corruption.
--

commit fe2892452671dd3008aaa8107b23e79098e1de7b
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Move kvm_vcpu sigset members to struct kvm_vcpu_common

These are the same across all planes for one VCPU, so make then
shared.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index df4d9952ee5ee..2a446a03b8cce 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
>  void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
>  {
> -	if (!vcpu->sigset_active)
> +	struct kvm_vcpu_common *common =3D vcpu->common;
> +
> +	if (!common->sigset_active)
>  		return;
> =20
>  	sigprocmask(SIG_SETMASK, &current->real_blocked, NULL);
[ ... ]
>  static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *s=
igset)
>  {
> +	struct kvm_vcpu_common *common =3D vcpu->common;
> +
>  	if (sigset) {
>  		sigdelsetmask(sigset, sigmask(SIGKILL)|sigmask(SIGSTOP));
> -		vcpu->sigset_active =3D 1;
> -		vcpu->sigset =3D *sigset;
> +		common->sigset_active =3D 1;
> +		common->sigset =3D *sigset;
>  	} else
> -		vcpu->sigset_active =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but does moving this state to the
shared common struct expose a race condition across planes?

Looking at kvm_vcpu_compat_ioctl(), it handles KVM_SET_SIGNAL_MASK by
delegating to kvm_vcpu_ioctl_set_sigmask() directly without acquiring the v=
cpu
mutex.

Since common->sigset_active is now shared across VCPU planes, if one plane =
is
running KVM_RUN and a userspace process calls the compat ioctl on another
plane's file descriptor, could it locklessly clear common->sigset_active?

If that happens, when the running plane exits and calls
kvm_sigset_deactivate():

void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
{
        struct kvm_vcpu_common *common =3D vcpu->common;

        if (!common->sigset_active)
                return;

It would see common->sigset_active as 0 and return early, failing to restore
current->real_blocked.

Could this leave the host thread permanently using the guest's signal mask?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D23
