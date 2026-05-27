Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717703EBF2D
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896456; cv=none; b=saZ2CvZqwGceFeOKe3ctiqjs7Si1cKgcBFtJOesLSek4WOE7wouB/96NphshjN9iJI5gsu1q27TcinUjhRvZBXa+xCRDpQg6Sk0ZtqDtIInzoQlOEhr38m3RUOqMU4ItnceJVWwGZgC5NpLGJdnNIYr4S4TYJhhnqZEuVERM+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896456; c=relaxed/simple;
	bh=B7bFOCg8mXxDr3DmFzRdk9sNMtcqo/YUrPEihWwKwpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QBO4WQqv0uG9RkKD5CQC5wMiFdj8HD31MJZoBMS2N7EEuujldsUVO2Sb3VtS0WlCfBOhT5iB5xVgHCc3geevpDmBPgSMeSzgvtS+cGfpc3BHPrGn/9RkpvauXDiXVsAE6rCzp8PO6SqtTH3G4UGRzJhM+Y6l5faZUqy/g87bHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN5DHQwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN5DHQwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05E71F000E9;
	Wed, 27 May 2026 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896454;
	bh=+xkyVWO4EnTgT6xO28Sq4vcPJ9PaUgoNFBawneIQqHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nN5DHQwQY+c912cboTEVJsxepe3ZZDnWglBvBiAX6p8HqxBDlrMPYKCR/xTxS9Izm
	 onv0apJPHwLLKV6ZAy0GEpIxhJfyEj3cUHnmpY9VLsozbxb26acGEMv16Hh5dJrbex
	 PAH6HB9BAOYok7AiIKR8m4pJ6uMPTA+XyvFMnLejEDRBHkIrxxLRh/+lmCahOKabWG
	 JQgOiF+Y5zj+Gqe3jm/ZP29rxoHwdx8FGW18tnn0VFS0b9eeYWvfynyQp5L//YAoSN
	 OPyZQEXWxn17r8thotpHYZAnOPAefasD0QYGnYSIUnKXN6QBiDMs1lAVJapN8peU2U
	 jVYq1kX+yjFuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/12] Documentation: KVM: Have actual headings for
 exceptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527-kvm-locking-docs-v1-6-4fe8b602ff47@google.com>
References: <20260527-kvm-locking-docs-v1-6-4fe8b602ff47@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 15:40:54 +0000
Message-Id: <20260527154054.D05E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Inconsistent manual section numbering format in the new headings.
--

commit b82f506fe0814e93c74474bdc07d0928237e5af1
Author: Ackerley Tng <ackerleytng@google.com>

Documentation: KVM: Have actual headings for exceptions

This commit updates the KVM locking documentation by adding explicit
headings for the exception sections. This improves readability by clearly
delineating where each exception description ends.

> diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/=
locking.rst
> index 5161636cec481..fc4537a7659a9 100644
> --- a/Documentation/virt/kvm/locking.rst
> +++ b/Documentation/virt/kvm/locking.rst
> @@ -65,7 +65,8 @@ The general rule in KVM is that any modification to sha=
dow page tables
>  (and their entries (SPTEs)) must be protected by ``kvm->mmu_lock``,
>  with the exceptions described below.
> =20
> -Fast page fault:
> +2.1. Fast page fault
> +^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
This isn't a bug, but there is an inconsistency in the numbering format
between the new headings. This heading uses a trailing period after the
section number ("2.1. ").

[ ... ]

> @@ -217,7 +218,8 @@ Since the spte is "volatile" if it can be updated out=
 of mmu-lock, we always
>  atomically update the spte and the race caused by fast page fault can be=
 avoided.
>  See the comments in spte_needs_atomic_update() and mmu_spte_update().
> =20
> -Lockless Access Tracking:
> +2.2 Lockless Access Tracking
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^

However, this heading omits the trailing period ("2.2 ").

Could this be made consistent across the document? A later patch in the
series continues the convention of omitting the trailing period (e.g.,
"4.1 Overview").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-kvm-lockin=
g-docs-v1-0-4fe8b602ff47@google.com?part=3D6
