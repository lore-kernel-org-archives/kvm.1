Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B69238E8CB
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486884; cv=none; b=qdX17/DuK3aslYMDkkIUrBi/GLJ8Bvv6VV3rdAArskifi0I/uL+331RUJkpKmXoW5F8ZgGreQWj8e0au7OUemOaL2a1B0Q6fN2EqblzFS5Yg7rPYOuVL0iWRyPaSqUsgL+ZGGvLIBAMaff20qxMoqAtzh1BA9c1KPIAchWObGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486884; c=relaxed/simple;
	bh=D/fQcMI3rb4tIMYDgQZzkxz8rYqZC2LZKeWK6pQcpbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfbevSJOrt4bE0Fb/yWkazwKfYWlzRm4yjEKc5BqOwbb7MfQIo/apiu5CimB30yKIALwv5u/BEnDHEnHsz33wBkl8it1owYgL/+tK0FtSVxfObwE+YSDU2Jp55wcC2sVHpjayEEE3VmLFdnZ7esc9xp8YMt/GgFgpqzOZqp/nbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxp5NbfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxp5NbfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E711F000E9;
	Fri, 22 May 2026 21:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486883;
	bh=OA3ooAFxhEAbM/6zd0Ql8NsiLAosvtxGpeJvKUEPqQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uxp5NbfMeFuBxm8ER079MTb3qxK1Vb43uFL7mEUpwY4x+CXurcUx9fjiXwbPlseYz
	 jb9n2nK5s6P4U80vTi+mv7khXGIMXhAfXQ8xfl990M2tM6iIzvusXyP7S/kinhqhUE
	 pg4xnLbQdsqROpjPvEeTGYvP1aMkgRP3j4JmcZhdbGILyXcDmp/ki45YgByMiuw2Th
	 U/ay1B8agJtWhYlSgjfMWQ9CDh1cvZnXMt5QaPyCIQptZOcHt+J/rSbYWdZzTPdr25
	 fn4UYC/U246nHJeHYzxxO+xqBqdYbJXxIDsT2j77ozxZ1VKdsHIYwzF9Q6yyV/BuTE
	 zLzt4Ru8Tjq7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: guest_memfd: Fix possible signed integer
 overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v1-2-9fc8d6437b65@google.com>
References: <20260522-fix-sev-gmem-post-populate-v1-2-9fc8d6437b65@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 21:54:42 +0000
Message-Id: <20260522215442.F0E711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The fallback stub definition of `kvm_gmem_bind()` for `!CONFIG_KVM_=
GUEST_MEMFD` was not updated to reflect the new `u64 offset` parameter type.
--

commit d25bb3b9adbe143acc8b3b7339c4bf637a62df32
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Fix possible signed integer overflow

This commit changes the type of the offset parameter in kvm_gmem_bind() from
loff_t to u64 to prevent potential signed integer overflow issues when pass=
ing
large 64-bit offsets. It also updates the local size variable to size_t.

> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
> index 9fcc5d5b7f8d0..23813d74ce709 100644
> --- a/virt/kvm/kvm_mm.h
> +++ b/virt/kvm/kvm_mm.h
> @@ -72,7 +72,7 @@ int kvm_gmem_init(struct module *module);
>  void kvm_gmem_exit(void);
>  int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args=
);
>  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> -		  unsigned int fd, loff_t offset);
> +		  unsigned int fd, u64 offset);
>  void kvm_gmem_unbind(struct kvm_memory_slot *slot);
>  #else
>  static inline int kvm_gmem_init(struct module *module)

[Severity: Low]
Does the fallback stub definition of kvm_gmem_bind() for !CONFIG_KVM_GUEST_=
MEMFD
also need to be updated to match this new signature?

It looks like the static inline stub in the #else block might still be expe=
cting
loff_t offset, which could cause an inconsistent API signature and potentia=
lly
trigger compiler warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-fix-sev-gm=
em-post-populate-v1-0-9fc8d6437b65@google.com?part=3D2
