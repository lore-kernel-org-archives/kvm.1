Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AA3C9EE5
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165950; cv=none; b=OYYsd5pw07ovYMk/HLv3Cu6aP9tYzYWce2TF6P44wndF7EQAJD2hcxu/pX+Q0+AadEylkmDjvGNky+O6Dz9OWG9mxR5aUMk7Rsi6ZRmf3mH81h1krMjs+7rwk8agFxTSrHB8wOL5dqPymlRCvEWP/wZXuV8sqmjVdQkJosZbfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165950; c=relaxed/simple;
	bh=gZoR97JW0joDFYHuqjrefOk2t5F+yD+simwxvY6UNk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uVqD8fgAohOfl7wV7W/8jIf2Va4FGZmgw2XUK/Hl3/8L4Ulwph+Ax3I9K24pOiwJurM4RdNojvFLnfpbnhwczeY2VeQQ5/fzMeY7GxWyBCnzrIkREHChA7G5+7JQ1+yg+X84S4xWxIL7x3JvPBDWR63BaRbYt1zYTfeOIN6gIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1K4uqQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1K4uqQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E481F000FF;
	Fri, 11 Sep 2026 22:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165946;
	bh=hzKROixjrML89MqE5pt09N0963+0oqxM94iFSiC9e/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1K4uqQftf6rzAanmY4uVgLB30ooEh7D4rlPOQtVlago+nWQ2cYY6Zbojv/wiOQjJ
	 wWduAcaBlhniYuaICPOFPbj8f0oAWjhCYeyX2Ln6kQt32dtXMkHcixWTbs9u25QHul
	 /pTdVQOQa82BlQ37eClaMnnEOba1vExy+tN6jK61l2AtIoZ1RhFBmm5Y3uDeL+n8Yl
	 vN94jC1KCFTS3++yeNxjBwN3wqszbZmwuZ7b2JETDG/pt9MuE1bWPLhpMyXvIbqnXL
	 O+F1NG4kEsDv6qMZ1iPhhLcU4EfYWVSaztaGS8vz4lXYX0n3lKkdWgKO9ObYkYL8SW
	 BVpbaaiP9UP1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] KVM: Bound per-VM GFN materialization in
 KVM_SET_MEMORY_ATTRIBUTES
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Ballesteros" <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911221302.53013-2-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
 <20260911203238.30088-1-davimaba.v@proton.me>
 <20260911221302.53013-1-davimaba.v@proton.me>
 <20260911221302.53013-2-davimaba.v@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:32:26 +0000
Message-Id: <20260911223226.96E481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Conservative quota bound check over-accounts overlapping requests =
and restricts maximum VM memory to 128 GiB.
--

commit 458d355532cc6dd4b9524cc1a387ddd8644cc6f6
Author: David Ballesteros <davimaba.v@proton.me>

KVM: Bound per-VM GFN materialization in KVM_SET_MEMORY_ATTRIBUTES

This commit adds a bound to the number of GFNs that can be materialized
in the memory attributes xarray. This ensures unprivileged users cannot
exhaust host memory when creating private memory VMs.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3dd04605f2e55..bb03dc20d3f98 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
[ ... ]
> @@ -573,6 +573,13 @@ static inline int kvm_vcpu_exiting_guest_mode(struct=
 kvm_vcpu *vcpu)
>   * This number must be determined not to exceed such limits.
>   */
>  #define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
> +/*
> + * Hardening bound: maximum number of GFNs with a materialized entry in
> + * mem_attr_array per VM (~300 MiB of xa_nodes at 2^25).  Without it,
> + * KVM_SET_MEMORY_ATTRIBUTES grows the array without limit (~9.3 bytes of
> + * kernel memory per GFN) on GFNs with no backing memory.
> + */
> +#define KVM_MEM_ATTR_MAX_GFNS	(1UL << 25)

[ ... ]
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 108d42c5c1d6a..c0696bd88461a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -2579,14 +2602,67 @@ static int kvm_vm_set_mem_attributes(struct kvm *=
kvm, gfn_t start, gfn_t end,
[ ... ]
> +	/*
> +	 * Bound the number of materialized GFNs per VM.  See the comment on
> +	 * KVM_MEM_ATTR_MAX_GFNS.
> +	 */
> +	if (kvm->mem_attr_gfn_count + (end - start) > KVM_MEM_ATTR_MAX_GFNS) {
> +		r =3D -ENOSPC;
> +		goto out_unlock;
> +	}

[Severity: High]
Does this boundary check over-account for overlapping requests?

If a VM issues a request over a large range that overlaps with mostly=20
populated entries, this check assumes every GFN in the range is a new entry=
=20
by adding end - start to the current count.

Could this cause valid requests on large VMs (e.g. bulk memory attribute
updates during a reboot) to fail with a spurious -ENOSPC, effectively=20
preventing operations even when the actual number of new entries being=20
added would remain well under the limit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911221302.5301=
3-1-davimaba.v@proton.me?part=3D1
