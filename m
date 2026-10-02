Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C224718D0
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932416; cv=none; b=LCt5Ns/0mLRbrVwVHBniQhRzP3oekuZi0IpRaLm1ov08NwhbV98+i2JsuDFsT0pt4D6OWQcq/61bn9jRIPeWdxWSq9ZG7b6dKof+B13AjW4UVyn5fZ0LHTdYppORBkLYyco9i85pjr7QvizY6jIrSlGgPMpnWI9x91Mlf1N4wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932416; c=relaxed/simple;
	bh=mLIT5OTk04hYXKBpmUUNhNY7vUUMHQX1B22RI5IPxJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cOT+6X4FY0H8JLUCoOul0qsdalp6ujZcOcwWvwpsx4nrxmsnkcJ3mmUFJ6AyWvcfndeQlGeGB3Z+6VmZk8BNUVg/TS+wA0vnNBRfB74VNhnhXHlNEwEE5knV2X+98CPqYgThwf7ujrhE+4YpOnZZwDLnVVPmay3tco93oxrijjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGQ2Gl2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGQ2Gl2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3553E1F00893;
	Fri,  2 Oct 2026 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932414;
	bh=gl/uF+zaUm8QouRG7kpikr9T+2Oa4exg482URXZ5ylY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGQ2Gl2bYYmgNb7tl9rZbyJdLgmrW6P7MMLuSS3o2OYfWTFmYwU13lcBO8tRxqLhf
	 XNBuMfF1ywmZWohaFAcHc5OcBsySFnR+989knBnzcJNdLJly0O+xiBT5RmxSWWQDHJ
	 zQd25S+ajiF/RV0lTQeuWiOJAvfktQXnRUZOhbbcy7oyuD3zh1Shf/7YMJD7sdobie
	 sjrNhtA2WbiAYuUdl2Q6feW/vdeuB4XwwMen7LY8OWorRcNXB1zalqyncmbxABrOLB
	 0YvMFJTBzLRwvz411M4xdRaN2TIugCtLzGYv+v029Yjt4QDULS5FcKamsRwQoqOE9j
	 8lCzbdJPlLqQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 20/23] KVM: selftests: Add a helper to issue
 TDVMCALLs from the TDX vm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-20-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-20-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:33 +0000
Message-Id: <20261002091334.3553E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: __tdvmcall silently masks TDCALL hardware failur=
es
--

commit 7709c4e900a0fe6433017aebbf708ee2946d3f19
Author: Erdem Aktas <erdemaktas@google.com>

KVM: selftests: Add a helper to issue TDVMCALLs from the TDX vm

This commit introduces a helper function __tdvmcall() to allow TDX VMs
to issue TDG.VP.VMCALL with a single function call, abstracting the
register setup. The function passes the GHCI sub-function and arguments,
and returns the TDVMCALL status.

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S b/tools/testin=
g/selftests/kvm/lib/x86/tdx/tdx.S
> new file mode 100644
> index 0000000000000..e3f0f7f2232bf
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
> @@ -0,0 +1,39 @@
[ ... ]
> +	mov $0, %rax		/* TDCALL leaf 0: TDG.VP.VMCALL */
> +	mov $0xFC00, %rcx	/* Expose R10-R15 */
> +	mov $0, %r10		/* Standard GHCI call */
> +
> +	/* TDCALL instruction */
> +	.byte 0x66, 0x0f, 0x01, 0xcc
> +
> +	/* Extract status */
> +	mov %r10, %rax

[Severity: Medium]
Does this code inadvertently discard the TDCALL hardware failure status?

The TDCALL instruction returns its module-level execution status in %rax.
If TDCALL fails (e.g., due to invalid arguments or incorrect VM state), %rax
contains a non-zero error code and output registers like %r10 are left
unmodified (which was initialized to 0 prior to the call).

By unconditionally overwriting %rax with %r10, any TDCALL failure status
appears to be silently masked and converted into a false success. Should
this code check or preserve the error code in %rax before overwriting it?

> +
> +	pop %r15
> +	pop %r14
> +	pop %r13
> +	pop %r12
> +	ret

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D20
