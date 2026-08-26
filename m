Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C33AA195
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731325; cv=none; b=FL2WFqdt/gpMaqYfNIv3J9rk2kf25UGPT2NQv3H68U3jmaAdnbdbJ5dImBoB0oQ+f83X9ytcE1E4lJmjVUHMSOMSVtGXqhnIL3do8+e0dE1MPZKX3mg+K5UcfqgWCPFWTo1VCIiAuDvww6Ytwi9oW4w8hGyR4i64WQUfA8X/LBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731325; c=relaxed/simple;
	bh=FZPpQ+6HDmsXv/VsQ3QThQFW8uS0Qsoh7QRVInqqWN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hU8c3veFnbiCnrILBRZX61DqqdYDErRyCb9fFKt0WiAlpRqcZgBE0CJ+xQku+8btLOF0rZWfOu36YBUWIqcX30LUIidP+aetUpcwcFH98eQ44tgQXLWMfu35iObTBVhqGoGoFXHu+D+l/Y4NqzYUVxb5XkS0ZhrLWORUKya/kdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kufcpYSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kufcpYSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A0C1F000E9;
	Wed, 26 Aug 2026 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787731324;
	bh=jF+dx1qioKmf3Na8ovuADPl0HWsxbpfjxJUHXf7nhZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kufcpYSkrjm5Tjxkti77KVw0CExtuigPzU2V5PiONddN1ZXOGL26KTsgtmQOW+5/q
	 NH1yLz9p/bkZJDotjO8F3MB/DvP08BmqfQLxSBsMc3lxNOuXbkKEWI9ZCNKFWGcsUi
	 vqGQa9s3pZOcGLY2vc8byPL2pujHk01zkVe7Bizp8wAJ8h9KHGGRgDd6kqYSkMbXOf
	 UoIGRHstNytnPEj4VNSNARy793IpiHlrUg5tBI/Ee8LT/pLA4cIMPCDkVJ/nuu4l/y
	 6oC8G1pZlp/q04ZKF34NdEw3Rh/YjyWpFLAcwbYFUdZiISAvDduYtfKUJi1ri2j4Vt
	 R7PNv+LWA1Lzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Fix NACL hfence entry update order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zongmin Zhou" <min_halo@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826075009.68952-1-min_halo@163.com>
References: <20260826075009.68952-1-min_halo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 08:02:03 +0000
Message-Id: <20260826080204.09A0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Using `smp_wmb()` instead of `dma_wmb()` or `wmb()` to synchronize=
 with a hardware device or external agent.

Pre-existing issues:
- [High] The retry loop in `__kvm_riscv_nacl_hfence` can spin indefinitely =
because `try_count` is never decremented.
--

commit 7e01a77077e49fef54c573574fad3624c0817345
Author: Zongmin Zhou <zhouzongmin@kylinos.cn>

KVM: riscv: Fix NACL hfence entry update order

The commit fixes the order in which nested HFENCE entries are populated
by writing the page number and count first, then the config word. It uses
WRITE_ONCE() and smp_wmb() to prevent hardware or firmware from observing
incomplete entries.

[Severity: High]
This isn't a bug introduced by this patch, but looking at the retry logic in
arch/riscv/kvm/nacl.c:__kvm_riscv_nacl_hfence():

    if (ent < 0) {
        if (try_count) {
            nacl_sync_hfence(-1UL);
            goto again;
        } else {
            ...

Does this loop run indefinitely? I noticed try_count is initialized to 5
but doesn't appear to be decremented anywhere in this path. If the NACL
hardware or SBI implementation stalls and fails to clear pending entries,
could this cause a host CPU soft lockup?

> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
> index 08a95ad9ada2c..f922e9f62fee3 100644
> --- a/arch/riscv/kvm/nacl.c
> +++ b/arch/riscv/kvm/nacl.c
[ ... ]
> @@ -42,12 +42,24 @@ void __kvm_riscv_nacl_hfence(void *shmem,
>  		}
>  	}
> =20
> -	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> -	*entp =3D cpu_to_lelong(control);
> +	/*
> +	 * Per SBI v3.0 section 15.1.2, the Page_Number and Page_Count
> +	 * words must be updated before the Config word with its Pending
> +	 * bit set. WRITE_ONCE() stops the compiler from reordering the
> +	 * stores and smp_wmb() makes the parameter words globally
> +	 * visible to the SBI implementation (or NACL hardware) before
> +	 * the Pending bit is set.
> +	 */
>  	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
> -	*entp =3D cpu_to_lelong(page_num);
> +	WRITE_ONCE(*entp, cpu_to_lelong(page_num));
>  	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
> -	*entp =3D cpu_to_lelong(page_count);
> +	WRITE_ONCE(*entp, cpu_to_lelong(page_count));
> +
> +	/* Ensure the parameter words are visible before the Pending bit */
> +	smp_wmb();
> +

[Severity: High]
Does smp_wmb() provide the necessary hardware ordering guarantees on all
configurations?

Looking at arch/riscv/kvm/nacl.c:__kvm_riscv_nacl_hfence(), since the
memory is coherent and shared with an external agent or NACL hardware, I am
concerned about non-SMP kernel builds (!CONFIG_SMP) where smp_wmb()
degrades to a simple compiler barrier (barrier()) and emits no actual
hardware fence instructions.

Would it be safer to use dma_wmb() or wmb() here to ensure the memory
ordering is strictly enforced against external hardware, regardless of
the kernel's SMP configuration?

> +	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> +	WRITE_ONCE(*entp, cpu_to_lelong(control));
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826075009.6895=
2-1-min_halo@163.com?part=3D1
