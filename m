Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033861C5D72
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015881; cv=none; b=gUgc/dXzgJJbaaXKk/4JeMz1ozE7rZipYYTxmRc2EjP2b3EvJD7wdLQYRMmfmqtMob5SvMNF/hcKgJqKE1t6hTDSspODixN4Y7mvK2UfB+k3HYvHTa7E4mSH79GfD4Mg87Q3FWkDbe8HfNthKRQ1/DxmLLVc2CiPa1NpppWM6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015881; c=relaxed/simple;
	bh=yO0KuAq5x+PbnK2f5rNDaVKIqU6uZvQMHtUNgASqHl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n1mf2+NVXbu+8Gj2G6HTtFPQ37ALu1/qwTLJrV2lmQS9VQSk8AWB0A0tQ7aQUd/YWXFiMVa6nd+q2G+Mlenb3XIupbfFoJZ0z1kJMe+F0W0aHR/P3ivmDl7/B+8nIhvytzlFqJfAytdlXfgPSPRTVFdbm0zCIRKGa/aYkUGDcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S39qNf5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S39qNf5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFF11F000E9;
	Fri, 29 May 2026 00:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780015879;
	bh=XduVUdS/Ktwl16RqgCgzitUaF4ClHLMtr5yK3XIVKU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S39qNf5TWgnYgDwcQxGKVOdmu04CNBmj2HlwNJeTAh9KVt2bA4K1QCVQYkDVBWXX9
	 3dweEeH1AFUJyRHbYavk8pJpQR6E78Jh6ynMreaEcnIREI/0P0swrhupeu9ymC1XXy
	 z880+Po8E9wvcCKBdah44aKqbwEeVn1Mdlj/TZbghsqpeF+zwNGoe0JIvAvPK2GHsL
	 w/u6xf0l36AN7ER+wMabd/v0H1KZ8D+t0G9zXCJu0v8zZdHO/v2yU3+Ure8/d47fcE
	 i0l1rz30JlbJm+VtiqXTIaDQV2UxTvp92hHIgWS87wNtQdGCACQ7S4AlueL4A8FVyl
	 KAPT+vOt+1k7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] crypto: ccp: Fix possible deadlock in SEV init
 failure path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528-sev_snp_fixes-v1-2-d67a08151779@meta.com>
References: <20260528-sev_snp_fixes-v1-2-d67a08151779@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 00:51:18 +0000
Message-Id: <20260529005119.8CFF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Host kernel panics due to RMP violation when reading `sev_init=
_ex_buffer` in `sev_write_init_ex_file()`.
- [High] Memory allocated for `sev_init_ex_buffer` is leaked and leaves the=
 device in a broken state if initialization fails in `__sev_platform_init_h=
andle_init_ex_path()`.
- [High] Uninitialized kernel memory is allocated and provided to the SEV f=
irmware and disk if the NV initialization file does not exist.
--

commit 405e31473bcf0fe9d84a37db761b7cf915973108
Author: Atish Patra <atishp@meta.com>

crypto: ccp: Fix possible deadlock in SEV init failure path

This commit modifies __sev_platform_init_handle_init_ex_path() to pass
locked=3Dtrue to rmp_mark_pages_firmware(). This prevents a potential
deadlock on the sev_cmd_mutex when an rmpupdate fails and attempts to
reclaim pages during cleanup.

> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index d1e9e0ac63b60..3d4793e8e34b2 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1557,7 +1557,7 @@ static int __sev_platform_init_handle_init_ex_path(=
struct sev_device *sev)
>  		unsigned long npages;
> =20
>  		npages =3D 1UL << get_order(NV_LENGTH);

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of leaking
uninitialized kernel memory to the SEV firmware and disk?

Earlier in this function, the NV buffer is allocated without zeroing the
memory:

	page =3D alloc_pages(GFP_KERNEL, get_order(NV_LENGTH));
	...
	sev_init_ex_buffer =3D page_address(page);
	rc =3D sev_read_init_ex_file();

If the NV initialization file does not exist, sev_read_init_ex_file()
handles the -ENOENT error and returns 0 without reading any data, leaving
the 32KB buffer filled with uninitialized kernel memory. This buffer is
then provided to the SEV firmware.

Later, when state changes occur, sev_write_init_ex_file() writes this memory
back to the host filesystem.

Should alloc_pages() be called with __GFP_ZERO to prevent this?

> -		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, false)) {
> +		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, true)) {
>  			dev_err(sev->dev, "SEV: INIT_EX NV memory page state change failed.\n=
");
>  			return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but is it possible this error path leaves the
device in a broken state?

If the page state transition fails, the function returns an error without
freeing the buffer or resetting sev_init_ex_buffer to NULL. Because it is a
static global, subsequent initialization attempts will return 0 immediately:

	if (sev_init_ex_buffer)
		return 0;

This bypasses the file reading and the required firmware page state
transition, passing an improperly initialized, host-owned buffer to the
firmware during the INIT_EX command.

Could this permanently break SEV initialization until the system reboots?

[Severity: Critical]
This is also a pre-existing issue, but will reading from sev_init_ex_buffer
trigger a host kernel panic?

Once the sev_init_ex_buffer pages are transitioned to a firmware-owned state
(RMP private) by rmp_mark_pages_firmware(), they are no longer accessible to
the host.

Later, sev_write_init_ex_file() is called to save the NV memory back to disk
and invokes kernel_write() using sev_init_ex_buffer as the buffer.

Since there is no code to reclaim the pages back to a host-accessible state
before this VFS write operation, won't the host CPU's attempt to read from
sev_init_ex_buffer trigger a Page Fault with the RMP bit set?

>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-sev_snp_fi=
xes-v1-0-d67a08151779@meta.com?part=3D2
