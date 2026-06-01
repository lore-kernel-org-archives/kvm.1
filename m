Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B526D4CA
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357320; cv=none; b=gvRhp+vo9U8hK8QKvIzXvLplfVc7LC5+tTs5pOcHZdNhesDD0Qt/11/1kMvBc31C3om/X2GUEKFIKBp3yqsLwSTw8GCTP+hAh4ULE0WJgxzcDDhf7/GhYuSO/In8UpOa4UcHon3LzpN3+dnhX24JUjDGEbT4MFi1Ya6OOFF6WQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357320; c=relaxed/simple;
	bh=IG3ElLBXd8D1Ji689S753Rw62sKeQdW0uvVsbcF8HeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7L2C+JcbARWRkB/BeEy0acUCRLKZUjgGxGo8O2b3vDNpAEKLSJU4vjNQECPG02GIJqDWtX/dFrsQ0F3TrSWOrigEQhS/yxW6RNFvGAd7R+QVSywrCFgq/geszBHXRJUClcxde+1/cetKOFWjZQoy5qzKnQKE/12x6wFgSDHsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiBLhQvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiBLhQvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0961C1F00898;
	Mon,  1 Jun 2026 23:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780357319;
	bh=meHN3drxU0cglGmt9m5lwwvmXDqVd+j5hcHiNWCFnxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BiBLhQvzJ6QMScQ0rTyDDtrSldilbVTLmFeBHv0MCYDv0WqEoZndpNVcpfyjNlvlH
	 HnnCNNBtEvGpiDUnhvNOPwIAQ3fwOLOexdiIy0ZaIvWywh/i+wqC+OUmLwBO37K6AY
	 uHI9xOYPobofA/H8jKyVnpj08LRQ/bK8jasChKGT0dowZgrlvJS7toOJRo9x8C2jtt
	 ZoAmiaWrWZK+7ljujnYHsZlb3E08CSsnMBVuCfv5TFStcRP0Jer220z3jppIN61KdL
	 A0X9o0Y/IuZWhBNW81SYAbAjNryKZuCI3ukjsHCeQ29wCjHFa1vOZQMt4qjHkXPy8H
	 YBZi/FCoaI9vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] crypto: ccp: Fix possible deadlock in SEV init
 failure path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601-sev_snp_fixes-v2-3-611891b28a86@meta.com>
References: <20260601-sev_snp_fixes-v2-3-611891b28a86@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 23:41:58 +0000
Message-Id: <20260601234159.0961C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure in snp_prep_cmd_buf permanently leaks the command buffer a=
ctive state in __sev_do_cmd_locked, deadlocking the SEV interface.
- [High] sev_init_ex_buffer is allocated without zeroing, leaking uninitial=
ized kernel memory to the host filesystem.
- [High] Unhandled allocation failure for dev_data->output in spdm_ctrl_all=
oc leads to passing a null physical address to the PSP firmware.
- [High] Retrying SEV-TIO commands after buffer expansion uses stale, freed=
 physical addresses, leading to RMP violations.
- [High] Bounce buffer memory is permanently leaked when firmware page tran=
sitions fail during legacy SEV command preparation.
--

commit 1396d09c5ba264e4a091f5fa101bb062c384525c
Author: Atish Patra <atishp@meta.com>

crypto: ccp: Fix possible deadlock in SEV init failure path

__sev_platform_init_handle_init_ex_path() called
rmp_mark_pages_firmware() with locked=3Dfalse but while the parent
function of init_ex_path already acquired the sev_cmd_mutex.
In case of a rmpupdate failure for any page after the first, the cleanup
path would invoke reclaim pages which would result in a deadlock in
sev_do_cmd.

Pass locked=3Dtrue to honor the lock status of the parent function.

Fixes: 7364a6fbca45 ("crypto: ccp: Handle non-volatile INIT_EX data when SN=
P is enabled")
Reported-by: Chris Mason <clm@meta.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Atish Patra <atishp@meta.com>

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
This is a pre-existing issue, but does this allocation leak uninitialized
memory?

Looking at __sev_platform_init_handle_init_ex_path() in the same file:

drivers/crypto/ccp/sev-dev.c:__sev_platform_init_handle_init_ex_path() {
    ...
    page =3D alloc_pages(GFP_KERNEL, get_order(NV_LENGTH));
    ...
}

If the NV file does not exist, sev_read_init_ex_file() returns 0 without
writing any data. This leaves the 32KB buffer filled with uninitialized
kernel memory before transitioning to firmware state. When
sev_write_init_ex_file() later writes this buffer to the host filesystem,
could this persist kernel heap contents to disk if the firmware did not
fully overwrite it?

[Severity: High]
This is a pre-existing issue, but can this error path leave the command
buffer permanently active?

drivers/crypto/ccp/sev-dev.c:__sev_do_cmd_locked() {
    ...
    ret =3D snp_prep_cmd_buf(cmd, cmd_buf, desc_list);
    if (ret) {
        dev_err(sev->dev, "SEV: failed to prepare buffer...");
        return ret;
    }
    ...
}

Since sev->cmd_buf_active or sev->cmd_buf_backup_active were set to true
before this call, returning directly here bypasses resetting those flags.
Would this cause subsequent commands to fail with -EBUSY and lock up the
interface?

[Severity: High]
This is a pre-existing issue, but does this error path leak the mapped
bounce buffers?

drivers/crypto/ccp/sev-dev.c:snp_prep_cmd_buf() {
    ...
    if (sev_cmd_buf_writable(cmd)) {
        if (rmp_mark_pages_firmware(__pa(cmd_buf), 1, true))
            return -EFAULT;
    }
    ...
}

If this fails, it returns -EFAULT without calling
snp_unmap_cmd_buf_desc_list(), which appears to leave the mapped command
descriptors unmapped.

Similarly, in snp_map_cmd_buf_desc():

drivers/crypto/ccp/sev-dev.c:snp_map_cmd_buf_desc() {
    ...
    if (rmp_mark_pages_firmware(*desc->paddr_ptr, npages, true)) {
        pr_warn("Error moving pages to firmware-owned state...");
        return -EFAULT;
    }
    ...
}

If the firmware transition fails for an individual bounce buffer, the newly
allocated page isn't freed before returning -EFAULT. Could both of these
paths result in permanent memory leaks?

[Severity: High]
This is a pre-existing issue, but does this validation correctly check the
output buffer?

drivers/crypto/ccp/sev-dev-tio.c:spdm_ctrl_alloc() {
    ...
    dev_data->output =3D sla_alloc(dev_data->output_len, true);

    if (IS_SLA_NULL(dev_data->req) || IS_SLA_NULL(dev_data->resp) ||
        IS_SLA_NULL(dev_data->scratch) || IS_SLA_NULL(dev_data->dev_ctx)) {
    ...
}

The check examines dev_ctx instead of the newly allocated output. If the
output allocation fails, dev_data->output will be SLA_NULL (physical frame
number 0). Will returning success here cause the PSP firmware to use
physical page 0 as an output buffer and trigger an RMP violation?

[Severity: High]
This is a pre-existing issue, but does retrying the command use stale
physical addresses?

drivers/crypto/ccp/sev-dev-tio.c:sev_tio_do_cmd() {
    ...
    rc1 =3D sla_expand(&dev_data->output, &dev_data->output_len);
    ...
    rc =3D sev_do_cmd(cmd, data, psp_ret);
    ...
}

When sla_expand() allocates a new buffer and frees the old one, dev_data
pointers are updated. However, the data pointer passed to sev_do_cmd()
comes from the caller and contains a by-value copy of the old spdm_ctrl
fields. Will retrying the command pass the old, freed physical addresses
to the PSP firmware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-sev_snp_fi=
xes-v2-0-611891b28a86@meta.com?part=3D3
