Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C1304BB3
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720078; cv=none; b=gbHFw7KE8rwr+h0to0vzpAweyZdxlCEPdBODlAq/V+p6qlt9j8lUcejW2UcW/iA45XFe8G/ikt4uYEmQFQKfBfakHUFc2EcuNgIALbdTmUsyE5i0Jrckgd96yGTvnwEDJSHVa3/qAu449fYCQ70Ghp0wJ6Q3uPn9fjWFRk/I0t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720078; c=relaxed/simple;
	bh=4PuqYb7beV0sxPZIjHWM/BgJmlle7WYBZlCYl2ioXFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q2W9FT05jf2ji4p+wxz7mUyX773SybLVRyOlKq50v3bMMffIS7QVVlJ77CR8udbo43Ny/+ww4rIU8aUQc/f20uLO/3XtY624s6vA1exbzbtLBp/JQV87EGzVtkNweIj7EjXYwc4+6FpfFkr9ecn9Ni2ETzD1YGUh7p+t90MyQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyeodpPf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyeodpPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D291F000FF;
	Fri, 18 Sep 2026 08:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720076;
	bh=X1TL1ZXU6ilBqzdu9Ab/DHLXQsTY3BH4HM6dQYo/KL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iyeodpPfEGIKdn2Ao40lC5mCmKW40pRAz8dzJ1hPFww0ggdy9v4EnDS6yk5n/Zjvr
	 Tio6RYFd7XggEzHcIfSIir9aPOtmlx0nW0QeFvvJccf1FUv233UrSfJmDKGJlTgYXm
	 9scOXPp9svs0LuAJbXPhj0jnVpMib9NwDgSxQkZzzpRrr5jhgdx99RWQDhNV/2wjkw
	 sK946IwSW3TVbibI32m3T5y+wCN6UyJVjFe2zasiT++VY0MKAqBz2VEOS8k1DOnEfI
	 RFQqVqIhRgWQfx/gQ4PhzBJ0cXuVj/gxrRuODzgla/ZLCSEwhndqD8qQYzDrS4XoPE
	 oiPmBgF4Mh7cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/28] KVM: Define and communicate
 KVM_EXIT_MEMORY_FAULT RWX flags to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-3-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:27:56 +0000
Message-Id: <20260918082756.81D291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: missing mirror sync in tools/include/uapi/linux/kvm.h for memo=
ry exit flags
--

commit bde51f2cf0c01c45785fd4f593b721d8c5b218c8
Author: Anish Moorthy <amoorthy@google.com>

KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to userspace

This commit adds new read, write, and execute flags to the
KVM_EXIT_MEMORY_FAULT UAPI structure to communicate the faulting access
type to userspace.

Link: https://lore.kernel.org/kvm/ZR4N8cwzTMDanPUY@google.com/

[ ... ]

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index ac2d77d149635..15a3090f067e5 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -457,6 +457,9 @@ struct kvm_run {
>  		} notify;
>  		/* KVM_EXIT_MEMORY_FAULT */
>  		struct {
> +#define KVM_MEMORY_EXIT_FLAG_READ       (1ULL << 0)
> +#define KVM_MEMORY_EXIT_FLAG_WRITE      (1ULL << 1)
> +#define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)
>  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)

[Severity: Low]
Does this patch also need to sync the mirrored UAPI header in
tools/include/uapi/linux/kvm.h?

The new KVM_MEMORY_EXIT_FLAG_READ, KVM_MEMORY_EXIT_FLAG_WRITE, and
KVM_MEMORY_EXIT_FLAG_EXEC macros are missing from the tools directory
copy of the UAPI header. This will leave tools building against the
mirrored header without the required definitions.

>  			__u64 flags;
>  			__u64 gpa;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D2
