Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21962273D8F
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856194; cv=none; b=APJofsTcJKraZk0jTAW83WaUqgjOD07eCj/TMM/yeLpvbWXH/aG5GVZ5jn/aYazfl6HfwbuPTTzjfgso5Gyz98zvI7YWt5S/M7uHNRJTymH+oPJ7YKUWqsVTuu3MWVQKTBe76HM5ZAQoPm3OTwOpkFgjstLB6MW57e27jVxWZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856194; c=relaxed/simple;
	bh=5oHZM1G/pB5uVo8VNfJ7qIsnV3vePY3BtDHPoQJS7ag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a7n8QD+sQlttsyXCOxMH8SHvaq5iwu4oIrkjAp6yqTy+u92QQiHvBmbO9kHnJUvwrp5q+JuLbUlZSGfR/r2ZShMTI3bR0eHXO3sRlvjKeVSNT6tBL5dzi4TRSf3wFSgCDG3NgA+RSbvSN6b5eVQs+E6UwWgrZku82twiq3we0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGKaJ085; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGKaJ085"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C851F000E9;
	Tue, 30 Jun 2026 21:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782856192;
	bh=n3odR8yjDIctjxr0hgGl14/ZpKv3Rz/gcceMw8EOtCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SGKaJ0856559ryFmwtD5eGPWYO7+knw52/F8yVqOv9WafkfTjxITahALAmQfFZX1v
	 MD2O0i8I1LQOtDj0bLPPCKIufpz+mYsdZEyfiRGUmWcEtqylAPq1BTnMSua0NAamX9
	 XK8OxaOVq2RuZ7l49XoAiBva1gJ7BxObTKDAjnjPz6PhYS8t29w/0ZCoFX6YG0+kSn
	 /ltxlp7zH0pkGigw+GxRIpI/DXbwX8a0e++HMtlxCs2iO/Y7mPxoD2PFzHJL+BED+L
	 v0w9nuZ+it5jroOQsrv5bZy0FDkbEP/3/UQTiCDE+Z6iMnRl/u2xt+FK3cJS1cGzhf
	 QiG5lkp7NvTLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for
 NULL INIT_MEM_REGION source
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260630213711.479692-3-seanjc@google.com>
References: <20260630213711.479692-1-seanjc@google.com>
 <20260630213711.479692-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 21:49:52 +0000
Message-Id: <20260630214952.98C851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `region.nr_pages << PAGE_SHIFT` calculation can overflow a 64-=
bit integer, bypassing GPA boundary validation and leading to a host denial=
 of service.
--

commit a54da29c3e4be3226e4ebf9df2f4182c350df998
Author: Sean Christopherson <seanjc@google.com>

KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL INIT_MEM_REGION source

Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
consistent between TDX and SNP.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ffe9d0db58c59..b0ec054732b90 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c

[ ... ]

> @@ -3247,8 +3244,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu=
 *vcpu, struct kvm_tdx_cmd *c
>  	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
>  		return -EFAULT;
> =20
> -	if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
> -	    !region.nr_pages ||
> +	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
> +	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
>  	    region.gpa + (region.nr_pages << PAGE_SHIFT) <=3D region.gpa ||
>  	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
>  	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_S=
HIFT) - 1))

[Severity: High]
This is a pre-existing issue, but in tdx_vcpu_init_mem_region(), does the
calculation region.nr_pages << PAGE_SHIFT overflow a 64-bit integer?

If userspace calls KVM_TDX_INIT_MEM_REGION with region.nr_pages set to a
value where the top 12 bits are non-zero (e.g., (1ULL << 52) + 1), the left
shift by PAGE_SHIFT discards the top 12 bits, evaluating to a small value.

Does this allow a malicious host userspace to bypass the overflow check
region.gpa + (region.nr_pages << PAGE_SHIFT) <=3D region.gpa and the
vt_is_tdx_private_gpa bounds check?

If bypassed, the while loop would then iterate based on the large un-shifted
region.nr_pages value. If a guest_memfd is mapped at a shared GPA and
initialization is started just before it, the loop could incrementally walk
into the shared GPA space.

Since KVM invokes tdh_mr_extend on that shared GPA, which the TDX module
rejects, could this trigger KVM's TDX_BUG_ON_2 and cause a host denial of
service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630213711.4796=
92-1-seanjc@google.com?part=3D2
