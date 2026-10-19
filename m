Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B48285CAE
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406064; cv=none; b=LCXk/9gkeHc0GP/TcBMICDp11BN8Lm2nNyOoikIHx89PnA3T0v8h78b/rKP9l7FCAIZBUTX4mn5Z0AoFK+j2li5+g7WvFfmtYLJjC6ynrVqVe+HtNf0CUMXfchX7PA6+zaq4mbPtr2ZSgur22n5HsRvrG0UKWa9qjcdtuyRk4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406064; c=relaxed/simple;
	bh=5+B9nlU0T41IwyYCcd1PIq5mj1LURM3YXz2QFJ03W7Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HiNd21l4MPqDeLW/2ONgsY4tkqicVdZ+v7OLWBA2PxXCzlruSiunif3k3ZiJnjhSS3NrRXOV6ReghPw5zfmg3/aDDj/LgLWgG8Dvw2EYnc8sl0H2g6TXlXOhnaMgmYNiYREFvxrOV2falm+H7XlraBMsJHo/kscjpOyO/itsK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrSs2HKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrSs2HKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48081F000C4;
	Mon, 19 Oct 2026 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792406063;
	bh=LQhM725lQpkg8hVUi7KzWFsOgWFt/yybUl1jfaFWPMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lrSs2HKilHFu2+KbX04GUN4OzufH7XuG7tYkN/OS3jIjpSaWwXBWmMG41RFy+cT6G
	 lLb2gv5PIro3GFybgLf67Bj0WaDaiC8BfjoaGM6odQBlzBSSHt75yHU53fCnqCvu0w
	 JzKwYRcpWN59rCkTx2Bmg3p1gmRiNIWpJYZ8uCxu/w1qQ1NtFys0MaDVKFDZuOfuHG
	 KHxNnhebIFCI5732Tir/SjUde26iYEX51ISzFZuBq3IDArq+h5lgwXaFps1M7LVy1o
	 3LuAjaw8CQPmhXesZMHG3fu3H5QxAoPmQgX0QO9ZeS8+0r5Io8iSKtOukN80OlTNma
	 9YY0nmh7RJ4cA==
Message-ID: <sashiko-outbox-176997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] powerpc/pseries/eeh: Add RTAS error injection
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019101813.45085-3-nnmlinux@linux.ibm.com>
References: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
 <20261019101813.45085-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 10:34:22 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] powerpc/pseries/eeh: validate_addr_mask_in_pe() matches unassign=
ed BARs
- [Low] powerpc/pseries/eeh: unused static helpers in eeh_pseries.c fail -W=
error build
--

commit 0a875c4e62df7429dee888710961a7609ab3e1b1
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

powerpc/pseries/eeh: Add RTAS error injection helpers

This patch adds helper functions to arch/powerpc/platforms/pseries/eeh_pser=
ies.c
to translate generic EEH error types to RTAS encodings, validate error
injection arguments and PCI bus BAR addresses against the target PE, and
populate the PAPR ibm,errinjct work buffer.

> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/=
platforms/pseries/eeh_pseries.c
> index b12ef382fec70..999b3065e09b6 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
[ ... ]
> @@ -786,6 +789,223 @@ static int pseries_notify_resume(struct eeh_dev *ed=
ev)
>  }
>  #endif
[ ... ]
> +static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long add=
r,
> +				    unsigned long mask)
> +{
[ ... ]
> +	pci_lock_rescan_remove();
> +	eeh_pe_for_each_dev(pe, edev, tmp) {
> +		pdev =3D eeh_dev_to_pci_dev(edev);
> +		if (!pdev)
> +			continue;
> +
> +		/*
> +		 * Validate against standard BARs (BAR0..BAR5) only.
> +		 * ROM and bridge resources are not IOA bus-error targets.
> +		 */
> +		for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++) {
> +			res =3D &pdev->resource[bar];
> +
> +			if (!resource_size(res))
> +				continue;
> +
> +			if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +				continue;
> +
> +			pcibios_resource_to_bus(pdev->bus, &region, res);

[Severity: Medium]
Can validate_addr_mask_in_pe() falsely match unassigned, disabled, or
zero-initialized BARs when called via:

  eeh_pe_inject_err()
    -> pseries_eeh_err_inject()
      -> prepare_errinjct_buffer()
        -> validate_addr_mask_in_pe()

First, resource_size(res) computes res->end - res->start + 1, which
evaluates to 1 rather than 0 when res->start =3D=3D 0 and res->end =3D=3D 0
(unlike pci_resource_len(pdev, bar)).

Second, when a standard BAR is sized but unassigned on powerpc, such as in
pcibios_fixup_resources():

  res->end -=3D res->start;
  res->start =3D 0;
  res->flags |=3D IORESOURCE_UNSET;

res->flags retains IORESOURCE_MEM or IORESOURCE_IO alongside
IORESOURCE_UNSET, with a zero-based range [0, size - 1].

When pcibios_resource_to_bus() is called on an IORESOURCE_UNSET resource:

  resource_list_for_each_entry(window, &bridge->windows) {
          if (resource_contains(window->res, res)) {
                  offset =3D window->offset;
                  break;
          }
  }

  region->start =3D res->start - offset;
  region->end =3D res->end - offset;

resource_contains() returns false because it rejects IORESOURCE_UNSET, so
window->offset is not subtracted and region.start is set to 0 with
region.end set to size - 1 (or left as the untranslated CPU resource
address if of_pci_parse_addrs() shifted res by window->offset without
zero-basing it). Any caller-supplied addr in [0, size) (including addr =3D 0
with a non-zero mask) will then match the unassigned BAR.

Should this check pci_resource_len(pdev, bar) and reject BARs with
IORESOURCE_UNSET | IORESOURCE_DISABLED set in res->flags, similar to
eeh_break_device()?

> +
> +			bus_start =3D region.start;
> +			bus_len =3D resource_size(res);
[ ... ]
> +static int validate_errinjct_args(struct eeh_pe *pe, int type, int func,
> +				  unsigned long addr, unsigned long mask)
> +{
> +	if (!pe || !pe->phb)
> +		return -EINVAL;
> +
> +	if (pseries_eeh_type_to_rtas(type) < 0)
> +		return -EINVAL;
> +
> +	if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
[ ... ]
> +static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
> +				   int rtas_err_type, int func,
> +				   unsigned long addr, unsigned long mask)
> +{

[Severity: Low]
Does compiling arch/powerpc/platforms/pseries/eeh_pseries.o at this commit
fail with -Werror=3Dunused-function when CONFIG_PPC_WERROR=3Dy or
CONFIG_WERROR=3Dy is enabled?

Both validate_errinjct_args() and prepare_errinjct_buffer() are defined as
static without __maybe_unused, and pseries_eeh_err_inject() does not call
them until the subsequent patch in the series ("powerpc/pseries/eeh:
Implement RTAS-based EEH error injection").

The commit message notes:

  "pseries_eeh_err_inject() retains the existing MMIO injection body
   unchanged in this patch.  It is replaced by the full RTAS session
   implementation in the next patch.  This keeps the patch bisectable:
   each commit builds and functions correctly independently."

Should validate_errinjct_args() and prepare_errinjct_buffer() be marked
__maybe_unused in this patch (or folded into the next patch) so bisection
does not hit a build failure under -Werror?

> +	__be64 *buf64 =3D (__be64 *)buf;
> +	__be32 *buf32 =3D (__be32 *)buf;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019101813.4508=
5-1-nnmlinux@linux.ibm.com?part=3D2
