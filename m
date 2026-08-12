Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A3315D58
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522830; cv=none; b=NFVtdgHhum/uXRcVtT/C7BiUwFcAAkOqGzSmgjofHbE1PDtbV9FsvAtc2DCqnqpDPJc5iwI/3LYjxQZQJLPtSsX25P/nBXMMos4/f0g3wuC6DDSm9LoRikAeMAKQ0S9LQl7YflcbAIoDYBiUUjr40g32B19WkqoiwcmGq6f7A1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522830; c=relaxed/simple;
	bh=ZKgO587nhfQIgIbEbzW08UbW23adWVH0bgK9hAcPZSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L2Gw23VhRVam2J1whnSwP8mWQ/0GVZusncZ7N6zgBB9eiDvGbwVQKN6npBqf9lJeSIvnkPnco+t4DEWIrT0DB/XJBzifNhy5fIUYDK7eVJFgfgemcLhhiseGbeG/pR4Awm+JpA1ZcWymp226wcYaO86voEGR/zLavmiRRc8DXgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcrQsemN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcrQsemN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118791F000E9;
	Wed, 12 Aug 2026 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786522829;
	bh=xYys+UatYs358SNHA/AXrv/lhFFD9P5q6rcswqcYf/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KcrQsemNpl8rXW/6grdYgR+0ruQPJAV1BpjLpqw+MHZNpar/o6IQv0V1Y3Z44PqTu
	 dlPUI/xzLry9L0AajJgEc7G1PAs+GBGHSXaojXUKRvJMptL+9+9h6LTUbxX6dWISSz
	 XlKKyYCf5/rnYlKjSJxnLhyCl+bx1lK4TgqbMf+rR76SJZm8Gom872j2lSM+7UtQDD
	 Ux66F6Eplw0iaZyCiO1g0go7oTmk5HjA8URTH/6maagLZ2/zRUb5FZCplTjqWeF4Jq
	 8VkT4TYoV0qVZCUQZj6oZ2uTRhUfprJVTiX7IHdwSLTBk+40cHgi8IvkF10UGmOHjr
	 5+uVXKPEzfExg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaoyao Li" <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260812080229.2481439-5-xiaoyao.li@intel.com>
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 08:20:28 +0000
Message-Id: <20260812082029.118791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The preexisting VMX handler vmx_handle_exit() silently drops negat=
ive error codes when a bus lock is detected.
--

--- Patch [4]: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit ---
commit 9ca659baf3acd47c81da72d83946e28ee4de710a
Author: Xiaoyao Li <xiaoyao.li@intel.com>

KVM: TDX: Enable Bus Lock VM exit

This patch enables Bus Lock VM exit functionality for TDX guests by program=
ming
the BUS_LOCK_DETECTION control in the TD VMCS. It also introduces the exit
handler for TDX guests and ensures the bus_lock_detected bit is appropriate=
ly
managed without double-counting.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 598b85d772e37..e7047657ef780 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -2149,6 +2153,22 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpat=
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
> +
> +		vcpu->run->flags |=3D KVM_RUN_X86_BUS_LOCK;
> +	}
> +	return ret;
> +}

[Severity: High]
This isn't a bug introduced by this patch, but while you correctly avoid
overwriting a negative return value here, the pre-existing vmx_handle_exit()
in arch/x86/kvm/vmx/vmx.c appears to still have this flaw.

If __vmx_handle_exit() returns a negative error code (like -EFAULT), and
a bus lock is detected, does vmx_handle_exit() silently drop the negative
error code by unconditionally returning 0?

If this causes ioctl(KVM_RUN) to return 0 instead of -1, could userspace
process stale or uninitialized exit information because
vcpu->run->exit_reason was never updated?=20

Should vmx_handle_exit() receive a similar fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812080229.2481=
439-1-xiaoyao.li@intel.com?part=3D4
