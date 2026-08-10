Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F43C3F41
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786362410; cv=none; b=diSrqwgh8IIlK9oj+4o1l9AICpeKgh9/acTer9ut20Nmvizj4aTjXC5kuP3Dr1S2DLDCdTes1lwajlyFAu2E/QmPL4UVASiWXkhOy7RE26M3G1EiXHZK2bcgAa04JX5owwKDShLAFKhZBDG+xn4gflxuy1ayl4pQVReWutW+eB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786362410; c=relaxed/simple;
	bh=9ieyRkmRNh938e+J1souDyrjoKZ5EwunOdnVgxaB4Eg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S+aOfKWb374qoqjoVsgkkUWX2YbPf2INzZntbLfahDqA4+GkibT/4Bfp39jXEVkcTQBE+SrJCqxF4LxvB6lePEpkOS76P27bDl0psk+eGZr63Cqm0HxDlMOfggWUpU6dZv7ZQni2mC6gQgk8yPt+/KOrHmkGtmwqBTM/9rpXNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5tbzth2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5tbzth2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758541F000E9;
	Mon, 10 Aug 2026 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786362408;
	bh=fRrPML5uixVcDG6OtHetKNdl4lN7nXNTrur7dQnwi5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5tbzth2+f8VJ/Qrp0FElqYJ3+KS2ADqJTjtvna13k4D/oM/1ZRM7M2xFzZHJF+IM
	 At8IlWn+cH0mXv8uJ6hRSQgGv04H9OFAd3hNKekcvvrVfpg7sJuC+XA7MRRYxz1btK
	 aJ+Q83tNSvKxlr0ZtCTr1wZkt8duKfUExni2AAzGh2Zbacz2JLDVxfZRM+wMKq9FQv
	 R4x1puVSMflzXiFEIfY1B/E1A6aMe4baHpAQsDfgqi63r1jbaT6O7LQt97BInZQfTY
	 Xa6w4Hd6H8PPjdI+7Lo/bC9yDAXelgbjmWpCRo+3g0cBzNOcp8YWdi5D9IMPnZIOv1
	 o6BLrUoS+MrOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] KVM: TDX: Enable Bus Lock VM exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaoyao Li" <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260810112200.2326727-4-xiaoyao.li@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-4-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 11:46:48 +0000
Message-Id: <20260810114648.758541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `vmx_handle_exit()` function silently drops negative error cod=
es (fatal errors) when `bus_lock_detected` is true.
--

--- Patch [3]: [PATCH v2 3/3] KVM: TDX: Enable Bus Lock VM exit ---
commit 573aa824013208febeaa70c68e452e3344dd518c
Author: Xiaoyao Li <xiaoyao.li@intel.com>

KVM: TDX: Enable Bus Lock VM exit

This patch enables Bus Lock VM exit functionality for TDX guests by
programming the BUS_LOCK_DETECTION control in the TD VMCS and adding the
exit handler. It also handles clearing the bus_lock_detected bit to avoid
issues during the wait_for_sept_zap case.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 2c8844acbd43e..ee3c7a32361a4 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c

[ ... ]

> @@ -2150,6 +2154,22 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpat=
h_t fastpath)
>  	return 0;
>  }
> =20
> +int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
> +{
> +	int ret =3D __tdx_handle_exit(vcpu, fastpath);
> +
> +	/* Exit to user space when bus lock was detected */
> +	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
> +		if (ret > 0) {
> +			vcpu->run->exit_reason =3D KVM_EXIT_X86_BUS_LOCK;
> +			ret =3D 0;
> +		}

[Severity: High]
This is a pre-existing issue, but since you fixed the negative return value
handling here for tdx_handle_exit() in v2, should a similar fix be applied
to the pre-existing vmx_handle_exit() in arch/x86/kvm/vmx/vmx.c?

Looking at vmx_handle_exit(), if __vmx_handle_exit() returns a negative
error code (e.g. -ENOMEM) and bus_lock_detected is true, it unconditionally
overrides the negative return value to 0:

    if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
        if (ret > 0)
            vcpu->run->exit_reason =3D KVM_EXIT_X86_BUS_LOCK;

        vcpu->run->flags |=3D KVM_RUN_X86_BUS_LOCK;
        return 0;
    }

Because ret > 0 is false, it skips setting vcpu->run->exit_reason but still
returns 0 (success) to userspace.

Does this result in userspace receiving a successful return code but with a
stale or uninitialized exit_reason, likely leading to a VMM crash or
unexpected termination if a guest triggers a bus lock exit while KVM
hits an internal error?

> +
> +		vcpu->run->flags |=3D KVM_RUN_X86_BUS_LOCK;
> +	}
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810112200.2326=
727-1-xiaoyao.li@intel.com?part=3D3
