Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338438F646
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102594; cv=none; b=i23/n/uHTiL43mHQFJ4TIJzy1w6PtMkYoaR3yEUw9h7AEPKKInw9D9jBdpKwM8fJxP0TsULGav57kMr90Fk+gdq1TljVg0n5Ceeied1lec5FZLCpiVRkxLkNb2sWgnIt4bD/BzRKTPxt54CwH6c9nBxQ4ZN6uf0rhqSV7ZeWHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102594; c=relaxed/simple;
	bh=Fr2Vqtps46/eejn7mcwumYFYgkZG6S//v0L1BZVQvpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ABbQMrIy0bROaJ5UyYeAq9QMG6BJzd5I79Yh1b0YbzHUx+TAsAxFa3wYKhEvUL4wFzLBl6jsJtifhlMoeov7bCAV11tZUEz7F6PqQaF6nTdG5FNNoEfQL17tsXcPi930Y+GhZVG3k3hpmYAq0J+u+SjvezysjdWCLoZutQl2vCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUZ0k0Xr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUZ0k0Xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAAB1F000FF;
	Tue, 22 Sep 2026 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102592;
	bh=gdHLxBTtNj7IpLbEu+05uvU7S/L7yROUHaAebbdbwNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUZ0k0Xrkdhc/WXQH1xuHDqIPp+lTeX8b/Bc2/TivrhVgApGk124BShDFEiizBWMw
	 AuoQhMKsKE3zcYSGd8oMspRn29ja3g+kX7U5dGeohZeSc3ACbmDMf/FHNOkhA1nA1N
	 WoG7/xfam2dm4AtEw9RLQ0jdUhn0etiKIUR87AmdSaIi/16XyLaE8BgYOWYkQ27XVE
	 EFzXup4UadKCKYkf6pFkE5Xz1OuuE/NTgCyFSNpLizSNZ7YDACPC8RAy8KTa0Pe0dU
	 +FL/ayAWVkrD9pJK0Y6bGGC8fo5KO2WrcVNNtGkjo2bEMVbs490EOgeYydP80KCNPu
	 G4eyaXQfXClsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] KVM: PPC: selftests: add support for powerpc
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
 <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 18:43:12 +0000
Message-Id: <20260922184312.9FAAB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: missing save/restore of %r1 and %r2 in ex_regs
--

commit 2e259a0445aae14d6a7262b100f4677735b2217f
Author: Nicholas Piggin <npiggin@gmail.com>

KVM: PPC: selftests: add support for powerpc

This commit implements KVM selftests support for powerpc (Book3S-64). It
provides virtual memory implementation for the radix MMU, ucalls using an
unsupported PAPR hcall number, and real-mode guest interrupts.

Link: https://lore.kernel.org/linuxppc-dev/cover.1781093720.git.ritesh.list=
@gmail.com/

> diff --git a/tools/testing/selftests/kvm/lib/powerpc/handlers.S b/tools/t=
esting/selftests/kvm/lib/powerpc/handlers.S
> new file mode 100644
> index 0000000000000..b860f6a520a13
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/powerpc/handlers.S

[ ... ]

> +virt_handle_interrupt:
> +	stdu	%r1,-INT_FRAME_SIZE(%r1)
> +	mr	%r3,%r31

[ ... ]

> +	mtxer	%r8
> +	mtcr	%r9
> +reg=3D4
> +	ld	%r0,(0*8)(%r31)
> +	ld	%r3,(3*8)(%r31)
> +.rept 28
> +	ld	reg,(reg*8)(%r31)
> +	reg=3Dreg+1
> +.endr

[Severity: Medium]
Does this restore loop in virt_handle_interrupt intentionally skip restoring
%r1 (stack pointer) and %r2 (TOC base)?

Because the loop starts at reg=3D4 and ends at %r31, any changes made to the
stack pointer or TOC base by the C exception handler in the ex_regs
structure will be silently ignored when returning to the guest.

> +	addi	%r1,%r1,INT_FRAME_SIZE
> +	rfid
> +
> +virt_handle_interrupt_p:
> +	.llong virt_handle_interrupt
> +
> +handle_interrupt:
> +reg=3D4
> +.rept 28
> +	std	reg,(reg*8)(%r13)
> +	reg=3Dreg+1
> +.endr

[Severity: Medium]
Similarly, does handle_interrupt skip saving %r1 and %r2 into the ex_regs
structure before routing to the C handler?=20

If a selftest takes an exception and attempts to inspect the interrupted
stack or TOC by reading regs->gprs[1] or regs->gprs[2], won't it receive
uninitialized values instead of the actual register states?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790101179.gi=
t.ritesh.list@gmail.com?part=3D1
