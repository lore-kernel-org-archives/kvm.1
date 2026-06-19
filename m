Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6A54654
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830277; cv=none; b=UJCVr4YF6aXtt3WTPR91tCKGAhGH0H729r7YnqyA6zpz/pxqb0x/d4SWoVWE3wYx6vFWiReiVujV58Ygjr3ng+V214Q5oRi60xxJ2F8GoTuXT6wBmAayCy1EyhMSGZ0J0Q97z3uOIMujtAwa2yOzkkbA1ZWj7HEya/ls31CvfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830277; c=relaxed/simple;
	bh=EnCfmCy+tk30ZElTOXtLCSpv8o0aNw3MqYQQU4oeECI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DG0r/bU4g4FYdLWnqMk0rpZd5kKI2Mqp4jGny2k0E0i7XWMXX+EI1YZ3HUyzfXPsVaa3URaXyhOvBXiPAqOWSQXeui652HISct//5S3ptogKXTftIy776sb27mdFCP8EY95ItqpmMYa/9wGravkt+suGYj0FiuULy9PcCGLkGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfePuhmR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfePuhmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016131F000E9;
	Fri, 19 Jun 2026 00:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830276;
	bh=G9vQlQNvGhcGBdSqGSPyUlFK+9XrQ0U//PjtS7DHY0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IfePuhmRBTGUNb/90duW5rU3dKZHdp4PlfNuJpZky+OuoDyhP8E6Qctp2uYmdsEG7
	 fQohlWQPJM2MZ35SI6CmuwMJ4mdQ33D4ElYHhc2j3GPjP1mkqgqyvZLnALkoGnXfX0
	 ezJ1w3U3gucDZHkqK/fIBupTLKUs6log51OOwATRH7vxrcfGj5oN8KaOdUJVlXgKly
	 Zlpz6k2+lKm8z7UcF5UPI4Bk7pcoOzDSMUgoa+iIxWdySgoXiOkSVScXknHZ/nfBGJ
	 Y6nbPA5Yu/wa0HD6lLl2VZsBSa0qwWv6Sgbp1IOtoAxlK4hjJ1K3uq6IZMzB/EvIW7
	 SDmcimfCz3Afw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/46] KVM: Provide generic interface for checking
 memory private/shared status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-8-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-8-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:51:15 +0000
Message-Id: <20260619005116.016131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete API renaming leaves `kvm_mem_range_is_private` checking =
VM attributes instead of using the generic runtime implementation.
--

commit 0ddb6a37467eac449d5a6333904fa11b3d52cad0
Author: Sean Christopherson <seanjc@google.com>

KVM: Provide generic interface for checking memory private/shared status

Introduce a generic kvm_mem_is_private() interface using a static call to
determine if a GFN is private, allowing the implementation to be set at
runtime. The existing VM-attribute-based check is renamed to
kvm_vm_mem_is_private.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index eb26d4ea8945a..3915da2a61778 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h

[ ... ]

> @@ -2546,7 +2546,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm =
*kvm,
>  bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>  					 struct kvm_gfn_range *range);
> =20
> -static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> +static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
>  	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PR=
IVATE;
>  }
> @@ -2557,6 +2557,16 @@ static inline bool kvm_mem_range_is_private(struct=
 kvm *kvm, gfn_t start,
>  						  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>  						  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>  }

[Severity: Low]
Should kvm_mem_range_is_private() also be renamed to
kvm_vm_mem_range_is_private() for consistency?

Since kvm_mem_is_private() was renamed to explicitly reflect its dependence
on VM memory attributes, leaving this helper with a generic name might
mislead future callers.

If a future caller attempts to use kvm_mem_range_is_private(), it would
bypass the new generic runtime mechanism entirely and incorrectly test VM
attributes instead of using the runtime-dispatched implementation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D8
