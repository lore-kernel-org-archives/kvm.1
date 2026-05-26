Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1333B636B
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803048; cv=none; b=md1iIBKZMJLGRzBvE9Nrl4JLOUkklzzjkV4TCIHF82w/G7XAvfM6LefINvgZEBEDTn1qipjpqeHFCHVUbdee6e/fyYMo/UfSJJCzboBPK3+fG1TFeODXTlSNkWWNY3j2ELnfTZmjC1yIGCFepruxkIpIrmz21gczqxSvZkyTYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803048; c=relaxed/simple;
	bh=GJ9DgMZa8kYB/ILeKJMB971i6Uol4lApFbbbiG/3cvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rzazhavqb+wIiHO9mj2a9eND+en3SBAdxhVSsbg3oHStAHTE5pqisFFkfSVbo08xEvXQXHwSLFujxd3S0d/kOeYNyaHs0Xy+zawZNNQzPbtzq/PA22z6JHKVyA1ybCfSBTsusR5axslnsvE6u7wv1MDWbdKbfW2kVjXziDciW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHdZ7urO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHdZ7urO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F481F00A3A;
	Tue, 26 May 2026 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803047;
	bh=nRns69xLDvUPv8JBIFtxhwkOib8hk9n4G0ekgPI7K/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nHdZ7urO3f3dIwyCF/zwWhNqzWzlJkULWdbc9valLKkKqxcNhL+94WY4Ib9UC+rdF
	 /XIhG8ByeRdI8sTku218jXFAWNc2Hp9anL/fuaQQvvMgbUBk+giu0gHF8320xVK68+
	 4Yt/UM4hte42PtLrORAYISqV9DB1Vr+KyrXfCI3ApbG2JZGYRvCfOxvNvWB34XgjdY
	 N/vx6N5tRztD8F+XVwHIH1tPmks2MCUk4pvGOSCscasldisn/+qa4uKBoxEhQrjNF6
	 oSZGXvtIGu0kFqKgTh8ETZlNYLYAO3xcgwEneVBVIGhpZjh1z76MUrJjC2sP+KYQxy
	 ua7r8eBho8Ytg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/18] userfaultfd: gate must_wait writability check
 on pte_present()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-4-kirill@shutemov.name>
References: <20260526130509.2748441-4-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:44:07 +0000
Message-Id: <20260526134407.92F481F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] userfaultfd_must_wait() and userfaultfd_huge_must_wait() cause a t=
hread to sleep infinitely if it encounters a poison marker.
--

commit bd3d83c0669b044a367277284d21f8c9e82fd131
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: gate must_wait writability check on pte_present()

This commit gates the writability checks in userfaultfd_must_wait() and
userfaultfd_huge_must_wait() on pte_present() to avoid incorrectly
evaluating random offset bits from swap or migration entries as present
PTE flags.

Cc: stable@vger.kernel.org

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 35b206cc9aa6f..f6d2a1c67019e 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2535,6 +2535,15 @@ static inline bool userfaultfd_huge_must_wait(stru=
ct userfaultfd_ctx *ctx,
>  	/* UFFD PTE markers require userspace to resolve the fault. */
>  	if (pte_is_uffd_marker(pte))
>  		return true;

[Severity: High]
This is a pre-existing issue, but does this logic cause a thread to sleep
infinitely if it encounters a poison marker?

When a missing fault is resolved by userspace using UFFDIO_POISON, a
PTE_MARKER_POISONED swap entry is installed and the waitqueue is woken up.
If the faulting thread is preempted and misses this wakeup (i.e., it is not
yet on the waitqueue), it will later add itself to the waitqueue and call
userfaultfd_huge_must_wait() to check if the fault was resolved.

Because pte_is_uffd_marker() returns true for poison markers, this
returns true and the thread stays asleep indefinitely. Shouldn't this return
false for poison markers so the thread can retry the fault and receive
a VM_FAULT_HWPOISON -> SIGBUS?

> +	/*
> +	 * Concurrent migration may have replaced the present PTE with a
> +	 * non-marker swap entry between fault delivery and this lockless

[ ... ]

> @@ -2621,6 +2630,17 @@ static inline bool userfaultfd_must_wait(struct us=
erfaultfd_ctx *ctx,
>  	/* UFFD PTE markers require userspace to resolve the fault. */
>  	if (pte_is_uffd_marker(ptent))
>  		goto out;

[Severity: High]
This is a pre-existing issue, but similarly here, does returning true via
the goto out for a poison marker cause an indefinite hang if the thread
missed the UFFDIO_POISON wakeup?

> +	/*
> +	 * Concurrent swap-out / migration may have replaced the present PTE
> +	 * with a non-marker swap entry between fault delivery and this
> +	 * lockless re-check. pte_write() on a swap entry decodes random

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D3
