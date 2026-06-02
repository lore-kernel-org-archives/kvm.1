Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33F3806D5
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441679; cv=none; b=bY74UciOid54m+okhzhEF/Um0pZ5G3WRXoAp1i3hcGGjlz4PwHjgc7ow9zF06m3a+OCX3038HOqzMordnKqIlEMnpwYJRLoHSDJ6S3PyeHRwHK0ICEFo2vumD6bZINX+XQOD9ANlVp8WaHKWjxqWHywukbdj2jkDzqAwDzVDByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441679; c=relaxed/simple;
	bh=CTQ7GCdFil8lE6QG3RKGqTSnvZHCUBN2E3g5S3iPgBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9p0cWxD62xAxcWzOJhF6xMff4Ln+mSpTlZIMAchd8kbcLLUdXrtqvTjNbG0F0LYlnX1dyAtizK9PBnVUxrPAHWonnoojcCYwGRSW3TUmwjrjNyMozJ20qqHvwDmSlj4cDNTXygqAEgDrVKNd+jHp3UIhVW7uhcHhmLBuS3++tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzQp/Xhw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzQp/Xhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2371F00893;
	Tue,  2 Jun 2026 23:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441677;
	bh=x+TeS65ipVzCj/km1LCHhOWINeRjl3kLWER8JJPcMdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TzQp/XhwPKVeS60QfgnbNj1hUvP65GODeV3lfIq52pEli9PjKs/M+CrqC+IDDptjV
	 KkNDnUZUXHEBQR0pfUbwEN4dKOm4C2mFdpOMO+xBOI8pdh7qCXJdkJcmXTH0VICHqT
	 Z9uncDtD9QXMfIjOxVVS46mhH9o2dpfUVomXuXt3VuaYF8VoOaqDpz6s+e01nd+q+i
	 ViAb2q0cN1L7os/OTKu5TApc5/GZmObTFOoyxpNoVeCBGnW+dd9YZ21alZnXeVzi6j
	 bwDp4pdSxkvnRnzy0TAnqN1ri0WwjFqmAECuISei6BSlyaAEGNwHuICDuiz3fAURZ/
	 Al1XV6zqGq5Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] crypto: ccp: Fix possible deadlock in SEV init
 failure path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602-sev_snp_fixes-v3-3-24bfd3ae047c@meta.com>
References: <20260602-sev_snp_fixes-v3-3-24bfd3ae047c@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 23:07:57 +0000
Message-Id: <20260602230757.8F2371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure in `rmp_mark_pages_firmware()` causes `__snp_alloc_firmwar=
e_pages()` to leak memory and return NULL, leading to a cascade invalid poi=
nter dereference.
- [High] Bounce buffers and firmware-owned pages are permanently leaked whe=
n legacy command buffer mapping or preparation fails.
- [High] Command buffer active state flags are leaked on error paths, leadi=
ng to permanent `-EBUSY` exhaustion for all SEV firmware commands.
--

commit 1310cc2bc448794800c5bf6fa91a6d1bce53eafb
Author: Atish Patra <atishp@meta.com>

crypto: ccp: Fix possible deadlock in SEV init failure path
   =20
__sev_platform_init_handle_init_ex_path() calls
rmp_mark_pages_firmware() with locked=3Dfalse while the parent
function of init_ex_path already acquired the sev_cmd_mutex.
In the case of an RMPUPDATE failure for any page after the first, the clean=
up
path would invoke reclaim pages which would result in a deadlock in
sev_do_cmd.

> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index d1e9e0ac63b60..3d4793e8e34b2 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1557,7 +1557,7 @@ static int __sev_platform_init_handle_init_ex_path(=
struct sev_device *sev)
>  		unsigned long npages;
> =20
>  		npages =3D 1UL << get_order(NV_LENGTH);
> -		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, false)) {
> +		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, true)) {
>  			dev_err(sev->dev, "SEV: INIT_EX NV memory page state change failed.\n=
");
>  			return -ENOMEM;
>  		}

[Severity: High]
This is a pre-existing issue, but does __snp_alloc_firmware_pages() leak me=
mory
and return NULL if rmp_mark_pages_firmware() fails?

drivers/crypto/ccp/sev-dev.c:__snp_alloc_firmware_pages()
		if (rmp_mark_pages_firmware(paddr, npages, locked))
			return NULL;

The function appears to return NULL without freeing the allocated page.

Additionally, in __sev_snp_init_locked(), the result of this function is
passed directly to page_address():

drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked()
		void *tio_status =3D page_address(__snp_alloc_firmware_pages(
			GFP_KERNEL_ACCOUNT | __GFP_ZERO, 0, true));

		if (tio_status) {
			sev_tsm_init_locked(sev, tio_status);

Since page_address() applies pointer arithmetic, passing NULL to it results
in a non-NULL invalid virtual address. This bypasses the subsequent
if (tio_status) check, causing a crash upon dereference in
sev_tsm_init_locked(). Can we add a check for the NULL return value before
calling page_address() and ensure the memory is freed on failure?

[Severity: High]
This isn't a bug introduced by this patch, but are bounce buffers and
firmware-owned pages permanently leaked when legacy command buffer mapping =
or
preparation fails?

In snp_map_cmd_buf_desc():
	if (rmp_mark_pages_firmware(*desc->paddr_ptr, npages, true)) {
		pr_warn("Error moving pages to firmware-owned state for SEV legacy comman=
d.\n");
		return -EFAULT;
	}

The function returns without calling __free_pages() for the allocated bounce
buffer.

Also, in snp_map_cmd_buf_desc_list():
err_unmap:
	for (i--; i >=3D 0; i--)
		snp_unmap_cmd_buf_desc(&desc_list[i]);

The error unmap loop decrements i before unmapping, skipping the descriptor
that just failed and leaking its buffer.

Furthermore, in snp_prep_cmd_buf():
		if (rmp_mark_pages_firmware(__pa(cmd_buf), 1, true))
			return -EFAULT;

If this fails, the function returns -EFAULT immediately without calling
snp_unmap_cmd_buf_desc_list(). All previously mapped descriptor pages remain
permanently locked in the firmware-owned state, and their bounce buffers are
leaked.

[Severity: High]
This is a pre-existing issue, but could command buffer active state flags l=
eak
on error paths in __sev_do_cmd_locked()?

drivers/crypto/ccp/sev-dev.c:__sev_do_cmd_locked()
		ret =3D snp_prep_cmd_buf(cmd, cmd_buf, desc_list);
		if (ret) {
			dev_err(sev->dev,
				"SEV: failed to prepare buffer for legacy command 0x%x. Error: %d\n",
				cmd, ret);
			return ret;
		}

If snp_prep_cmd_buf() fails, the function returns immediately without rolli=
ng
back the cmd_buf_active and cmd_buf_backup_active lock tracking variables.

After two such failures, both command buffer slots could be permanently
marked as active, leading to all future firmware commands failing with -EBU=
SY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-sev_snp_fi=
xes-v3-0-24bfd3ae047c@meta.com?part=3D3
