Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE02147E5
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780130217; cv=none; b=Liyufy3VJ/hVeuxQVRmUHxfHXYKoTCZP/WKju/BgRMJeSn025XoLGStffpdJzsLBqhrimxT8jNLriFIjhVmiY7BHqGBfcC0cSKr+W5+RLR1RdI2PgsbxEDVjSmnpz/4VYssDXfY6vKgIzsLkeexNE5FQRAfydrIuf7l8Ty4GYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780130217; c=relaxed/simple;
	bh=pyUmlU5jAhHTPHH7O3E+Q9za5JAjdiapqlHQWrD4feg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EtFiQ0kgsXTlSO/J9RW9aIqIlmVeEMlCihRaCA3njbJk4g0lt4RB5MCG1S4vZygZlUIQkEvqJmOONvPzlE5ROu3aMwpqCrkKCZT7P/zuszb/hWrlS047Br61dz7Hfcs9Qk8y3g2eCkffBBwUa4wcJZ+vTk8dBD7jzOCx6nuWn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi5EI26K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi5EI26K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3260E1F00893;
	Sat, 30 May 2026 08:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780130216;
	bh=jgj/UD57IYfMgxx7BT2dlVdu+j/rSM2ACzj8fj8fD34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mi5EI26Kv6+yOcfP+jUV/NxdmdVJOsukDS/ACh5KWsDJJzb7sCM4N60Ke05gPnWr+
	 Mgw2R71gaF9yAcMd5eSh253uGLYqmtElTPWkkPO1y2cMRk3eUllaCnKTYuiARtC9XU
	 FdC9X0ES3SqiXNSD9DoQf1tpKOuKe5xM/WV8DYjNCAoqxDZ8Ob9WszVhb665tjEy0M
	 N96yw0bsq/ZcR6nq0dVbNItSoWVsPFxf0dSKNJ+9RO1v4G8KcPsjNQTzzoiPee9pnl
	 G122HoI6q12L2ONHf0ox9OxVabRJHGyL7tOC9Svbma49m4b6oiMBV/sjDkFEosOdyP
	 dgUTvOktfWJMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/24] KVM: SEV: Move sev_free_vcpu() down below
 sev_es_unmap_ghcb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-16-pbonzini@redhat.com>
References: <20260529183549.1104619-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 08:36:55 +0000
Message-Id: <20260530083656.3260E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `sev_es_unmap_ghcb` executes a sleepable operation (`kvm_write=
_guest`) while preemption is disabled, causing a sleeping-while-atomic viol=
ation.
--

commit ed02a1ac42db279c6f38774405471c3163d2450b
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()

Relocate sev_free_vcpu() down in sev.c so that it's definition comes after
sev_es_unmap_ghcb().  This will allow sharing unmap functionality between
the two functions without needing a forward declaration (or weird placement
of the common code).

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 4ebe0d4497898..437282f0ea943 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
[ ... ]
> @@ -3618,6 +3587,37 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
>  	svm->sev_es.ghcb =3D NULL;
>  }

[Severity: Critical]
This is a pre-existing issue, but since we are looking at sev_es_unmap_ghcb=
(),
does this unmap routine execute a sleepable operation while preemption is
disabled?

When handling a guest exit where the SEV-ES scratch area is outside the GHC=
B,
ghcb_sa_sync can be set to true. If the IO requires exiting to userspace,
sev_es_unmap_ghcb() is delayed until the next vcpu_enter_guest() execution.

During guest reentry, vcpu_enter_guest() disables preemption before calling
the architecture hook:

arch/x86/kvm/x86.c:vcpu_enter_guest() {
    ...
	preempt_disable();

	kvm_x86_call(prepare_switch_to_guest)(vcpu);
    ...
}

For SVM, this hook resolves to svm_prepare_switch_to_guest(), which calls
sev_es_unmap_ghcb() while preemption is still disabled:

arch/x86/kvm/svm/svm.c:svm_prepare_switch_to_guest() {
    ...
	if (is_sev_es_guest(vcpu))
		sev_es_unmap_ghcb(svm);
    ...
}

Inside sev_es_unmap_ghcb(), if ghcb_sa_sync is true, it calls kvm_write_gue=
st()
which is a sleepable operation:

arch/x86/kvm/svm/sev.c:sev_es_unmap_ghcb() {
    ...
		if (svm->sev_es.ghcb_sa_sync) {
			kvm_write_guest(svm->vcpu.kvm,
					svm->sev_es.sw_scratch,
					svm->sev_es.ghcb_sa,
					svm->sev_es.ghcb_sa_len);
    ...
}

Calling a sleepable function with preemption disabled leads to a "sleeping
function called from invalid context" bug. If the host virtual address
corresponding to the scratch area is not resident in memory, the kernel will
attempt to sleep on the page fault, leading to a "scheduling while atomic"
panic.

Could this be triggered by an unprivileged guest providing an out-of-bounds
scratch area, leading to a host denial of service?

> +void sev_free_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm;
> +
> +	if (!is_sev_es_guest(vcpu))
> +		return;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D15
