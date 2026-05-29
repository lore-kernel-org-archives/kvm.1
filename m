Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1623909AC
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076832; cv=none; b=rAwWzrMxbPmfL0sGTgpPnygU9zdcCsJmY/zGAioTA7yzKKEBriIdQwUNfUh3puSigDXChGQfeC4URwjWGcrCd6Q514ebjZUFSG8nH7xqb1VMbJ0Wt58W5RYGFU6Owi0TMFxlK69l6swTFx8lf1yN7XoPW3xJG7IgKmRBpzXZae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076832; c=relaxed/simple;
	bh=ELdnNERh6aDwhLvKWZa+Q6NznONvgxW7jZfgKUteqek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NyZWmk+GRDYdVRnyjQtS91XEhWsImObZF3H8jkxdn7WXBTZmSYV2UKV7zqSo5Sa5DcyFPiLcyxXNSx3/CiB95o2TIN+enPDW2CYksWiTCp+dry7NXNYipx76gAQ2gAH9xJQ+lJPjA+j2enMy9K5jQ8BhpfMLnKI84eJhWMpG84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdZvSEzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdZvSEzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CB31F00893;
	Fri, 29 May 2026 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780076830;
	bh=pM9jcOr/lr0/BvCb3wUrSTN3BhpEm8XIPGeYyb11+2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdZvSEzmV8XWudtARz8G9ER7Xn7zn0zsxNbLNElexJX0s7BAUDpAnVGO92iCS/Z1s
	 g74lKKhjPbrxr2gDHhzg6q2nb8d8y2z1OLGiFZmL+KRkR+rxdWwpGYd31atSTvsnM4
	 TunVcL2DeCMv9C7895c9+3GnR/6PajrF+a3g5wI0ZgSsle0WQu+JOdu5iK7F9jfMSO
	 xeZtELukYmWpbcUV6WcGjmQOehLnuToilEyViiYWL0Gj2Eek+rOY+x+QU6jtnJBumP
	 PmwRASHpMjlKOkw4K6MSGRFv/h81Aa/OTgh2j5C8cyqGq3nsOOB/nFjWyy6a96uE/k
	 gRSJ219sWsOkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/20] KVM: x86/xen: Extract delivery of event to
 vCPU into a separate helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529165114.748639-8-seanjc@google.com>
References: <20260529165114.748639-8-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:47:09 +0000
Message-Id: <20260529174710.29CB31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Lockless reads of `kvm->arch.xen.long_mode` across multiple ch=
ecks allow TOCTOU races, leading to out-of-bounds memory corruption in both=
 host kernel state and guest state.
--

commit f4fd761232e8e0f394f8395cfeec34caad9f061d
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
   =20
This commit extracts the fastpath delivery of an event to a vCPU into a
separate helper function to allow CLASS()-based gpc locking and checking.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index 0c6b74b974080..020ef0ddab013 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
[ ... ]
> @@ -1775,6 +1775,57 @@ static void kvm_xen_check_poller(struct kvm_vcpu *=
vcpu, int port)
>  	}
>  }
> =20
> +static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_wo=
rd_bit)
> +{
> +	struct gfn_to_pfn_cache *gpc =3D &vcpu->arch.xen.vcpu_info_cache;
> +	bool kick_vcpu =3D false;
> +
> +	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel =
*/
> +	if (!read_trylock(&gpc->lock)) {
> +		/*
> +		 * Could not access the vcpu_info. Set the bit in-kernel and
> +		 * prod the vCPU to deliver it for itself.
> +		 */
> +		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_se=
l))

[Severity: Critical]
This is a pre-existing issue, but can the lockless evaluation of long_mode
lead to out-of-bounds memory corruption here?

If userspace races KVM_XEN_HVM_SET_ATTR (setting long_mode =3D 0) with event
channel delivery (e.g., via KVM_XEN_HVM_EVTCHN_SEND), could the initial
max_evtchn_port() check observe long_mode =3D=3D 1, permitting xe->port up =
to
4095?

If the subsequent check inside kvm_xen_set_evtchn_fast() observes
long_mode =3D=3D 0, it falls into the 32-bit compat block, computing
port_word_bit =3D xe->port / 32, which could yield a bit index up to 127.

When this out-of-bounds port_word_bit is passed to test_and_set_bit(), it
would write past the 8-byte evtchn_pending_sel field, potentially corrupting
the adjacent vcpu_id and timer_virq fields in struct kvm_vcpu_xen.

> +			kick_vcpu =3D true;
> +		goto out_kick;
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529165114.7486=
39-1-seanjc@google.com?part=3D7
