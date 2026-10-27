Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126052;
	b=vTmexj2OQHVRKM4C+tMXKw/CfQsauVHCfvrXtNn5GMtyFseDX8D97QDshU/A/jH/VFGV
	 QF6dglLtBb9CqJtglDCQ893ScPDOFqNGUbIle+QhIBktWMeKzn8LEKO2c65+6qDWRVKsr
	 uX2agicjbuIzCRZHdZlZuZZZ1wqpPiMBJc5u4FRGdSRP5gciXcnhuUP6S/b5707B5pCHb
	 xDLeczHA9QrUsIPHhH4KuwHzIitxyQzgip13lD7SiYEMJTFeGzUa9qWrNp83GY90HcqrT
	 SyKYwc5FtfcST3eyKiOHmGhtLMJUisCcwd6HcX3aoRebIWhVLcbdzZ8wvd/fPh6QAeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UniKk5AYxlz27k0utCoft4rYwT9OHlNQ0I8mnMTe3W0=;
	b=RFYoCCuMxGW+ynJqzwEMDYJNN2LCW+1ED90qcin8v7YzRcACs/8buQQPrdIRayvg0h5t
	 EgivZzwAI1yjOthc30ipWuwpjn0SzWXdd+lCE1cYId/qvA1orGx6tQ+A9ZLY7Lcn08PSv
	 SDdoEGbq9dRMfpdSI7pBeN5Vv0eP+KbifuM0AFy/eZ5/IDxhyEQI2QleABvESW39GzbQu
	 Bic1Ke246+hHtVF4YANnjELlvKC9LCukJVsAt9nDliNLTDLIS4bEI9m2APlp3W8jdtBLW
	 +CE0u9vprde2xDMWu2HS3jYKC/9Z/cr1dards949fJ418e2AHWK1owHSkoOKINrTtvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPA8V9RM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE8606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPA8V9RM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163CD1F01825;
	Tue, 27 Oct 2026 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793126052;
	bh=UniKk5AYxlz27k0utCoft4rYwT9OHlNQ0I8mnMTe3W0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPA8V9RMO6gIYXAzhHN/v4nf8qqyKnfT4ubjuhWtiE1Hvo21Menly34SwivyVnTMc
	 P+lU8eD/Orb0cONMGNLvCyuYOzzMlgn3Aup4Ye727okeFy3kq2EN7/Wi+hO51lNE7w
	 8C4frMQ831A7nzfOs/7o++5ezbuQb6E8qnvRprCOIQBypVbo0SBMQGOnA+x1UxS8Tl
	 MMjXwVTsTTQZhT6vnJT6LBrRa+SEKL6/6vZoCzmChF21BWUWNcfYL/VaNDuo2i6z79
	 NftoOAahcM1WPyFnggRc7RjhOGoLlqX/TmvZBpradhyL+XpS3POvpRoQt0S0EgeIsF
	 A10J1FgWvIOtA==
Message-ID: <sashiko-outbox-187032@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: optionally post write on ioeventfd write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thanos Makatos" <thanos.makatos@nutanix.com>
Cc: =?utf-8?b?a3ZtQHZnZXIua2VybmVsLm9yZw==?= <kvm@vger.kernel.org>
In-Reply-To: <20261027180903.1008-1-thanos.makatos@nutanix.com>
References: <arK05GrLtiBvbfmm@google.com>
 <20261027180903.1008-1-thanos.makatos@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 18:34:11 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: eventfd: require natural alignment for post_addr in kvm_ass=
ign_ioeventfd_idx()
--

commit c6cd7519e7f3bd3af324596a345f4b346eac3929
Author: Thanos Makatos <thanos.makatos@nutanix.com>

KVM: optionally post write on ioeventfd write

This commit introduces KVM_IOEVENTFD_FLAG_POST_WRITE to copy the value
written by a guest on an ioeventfd MMIO or PIO access to a user-provided
address before signaling the eventfd, along with documentation and x86
selftests.

> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index f43b8b25bc854..b0f2a6b43e354 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c

[ ... ]

> @@ -811,8 +819,36 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct kvm_io=
_device *this, gpa_t addr,
>  	if (!ioeventfd_in_range(p, addr, len, val))
>  		return -EOPNOTSUPP;
> =20
> +	if (p->post_addr) {
> +		u64 _val =3D ioeventfd_get_val(val, len, unsupported_len);
> +		int r;
> +
> +		switch (len) {
> +		case 1:
> +			r =3D put_user(_val, (u8 __user *)p->post_addr);
> +			break;
> +		case 2:
> +			r =3D put_user(_val, (u16 __user *)p->post_addr);
> +			break;
> +		case 4:
> +			r =3D put_user(_val, (u32 __user *)p->post_addr);
> +			break;
> +		case 8:
> +			r =3D put_user(_val, (u64 __user *)p->post_addr);
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			r =3D 0;
> +			break;
> +		}
> +		if (r)
> +			return r;
> +	}
> +
>  	eventfd_signal(p->eventfd);
>  	return 0;
> +unsupported_len:
> +	return -EOPNOTSUPP;
>  }
> =20
>  /*
> @@ -872,6 +908,18 @@ static int kvm_assign_ioeventfd_idx(struct kvm *kvm,
>  	if (IS_ERR(eventfd))
>  		return PTR_ERR(eventfd);
> =20
> +	/*
> +	 * Disallow posting to virtual address 0 so that KVM can treat
> +	 * a NULL user pointer as "no posted write".
> +	 */
> +	if ((args->flags & KVM_IOEVENTFD_FLAG_POST_WRITE) &&
> +	    (!args->len || !u64_to_user_ptr(args->post_addr) ||
> +	     args->post_addr !=3D untagged_addr(args->post_addr) ||
> +	     !access_ok(u64_to_user_ptr(args->post_addr), args->len))) {
> +		ret =3D -EINVAL;
> +		goto fail;
> +	}

[Severity: Medium]
Should kvm_assign_ioeventfd_idx() in virt/kvm/eventfd.c also require
args->post_addr to be naturally aligned to args->len via
IS_ALIGNED(args->post_addr, args->len)?

In Documentation/virt/kvm/api.rst, KVM_IOEVENTFD_FLAG_POST_WRITE documents
that when multiple vCPUs write to the same ioeventfd concurrently, the value
at post_addr reflects one of the writes, and that if the copy to post_addr
fails, the eventfd is not signaled and the write is reported to userspace as
a regular MMIO/PIO exit.

When userspace registers an ioeventfd with KVM_IOEVENTFD_FLAG_POST_WRITE,
args->len in {2, 4, 8}, and an unaligned args->post_addr, subsequent guest
writes invoke ioeventfd_write() -> put_user() on p->post_addr:

1. On x86 and arm64, an unaligned 2-, 4-, or 8-byte put_user() store that
   crosses a cache-line (or 16-byte on arm64) or page boundary is split into
   multiple memory transactions and is not single-copy atomic, so concurrent
   vCPU writes can tear.

2. On RISC-V without CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
   __put_user_nocheck() in arch/riscv/include/asm/uaccess.h checks
   !IS_ALIGNED((uintptr_t)__gu_ptr, sizeof(*__gu_ptr)) and falls back to
   __asm_copy_to_user_sum_enabled(), which copies byte-by-byte in
   arch/riscv/lib/uaccess.S and tears on any unaligned post_addr.

3. If an unaligned post_addr straddles a mapped page and an unmapped page,
   put_user() partially overwrites the first page before faulting on the
   second page and returning -EFAULT.

4. On architectures such as MIPS (do_ade() in arch/mips/kernel/unaligned.c
   when unaligned_action =3D=3D UNALIGNED_ACTION_SIGNAL) and LoongArch (do_=
ale()
   in arch/loongarch/kernel/traps.c when unaligned emulation is disabled or
   absent), an unaligned put_user() traps in kernel mode and calls
   die_if_kernel() without running fixup_exception().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027180903.1008=
-1-thanos.makatos@nutanix.com?part=3D1
