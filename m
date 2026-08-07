Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30511D9A66
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134639; cv=none; b=VsXwieN7m0mYfUUhyuml01a27QIGxd7GxnJqrU4LyctzG8n3n77qydTDXzxKSb954ANDCDRmgnaBcjudiZsvESjZ8hza2TzLbA9e0SQVmjExn5QvkX7MvTo35HWMMUKyv1tXGfPeFI6WgPnbr2woHV/lyCSw93lgnPNkbFFGJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134639; c=relaxed/simple;
	bh=xz0XDgkvdR68yVE5ToFe5vlKcZfCJcRnNPgBcNLh4TM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iUximt4Ct2YlsomYgjbywqeeXLZcAZVB7wn4JupjTgemSAT9KXZZ0lGkGzZ63Q2vkthxVaDhyRLnGW5DjLEniAZ1ZfaO+xsrS7AT9LGqXTM56cSDu50GYCD+eFbdkNP4Ln6vBwkhEhv1y//IRG47IMCpX95KOkmSjCCTs6qgpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ05TGVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ05TGVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BBC1F000E9;
	Fri,  7 Aug 2026 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786134637;
	bh=3ZjULBF3wqVmdjm+Q7+xlziWEOcPzloTE2KABlYkdlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQ05TGVTKHF8oV5u3OW+xHNvTwevm5JVHgGIqTPEbH25F+EbqScHacDiMmaglQGF2
	 /7vqxLfOt81H+FP4EXfH9s6Vk0p5OjcJeMT6LdTh1kUiEdLEPqKepvG83Kj1D33eVJ
	 z9E+n+Bq5C3YE9cnQExyj06iS/w535pLKCSaozdyM4LnmlI8TepKzrcA99yTQJ2MUm
	 aYUEc0ku7TjNkTY+r+oHSLCqbIV/Udv3j5+UezV8ppjA/fTbrQII9Ye5sixd4p2roG
	 /iPaJBP2CIAfN0Ca5qF+nUf9BsYvifYvTWWv8QPWnbz+KIvHjjb7HW5KwsasD7qZdU
	 DWoWgi3JY0ldg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 1/1] vfio/pci: Revoke BARs and DMABUFs during
 sysfs-triggered PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260807201405.3717430-2-praan@google.com>
References: <20260807201405.3717430-1-praan@google.com>
 <20260807201405.3717430-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 20:30:36 +0000
Message-Id: <20260807203037.53BBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Self-deadlock in config-space triggered FLR due to double acqu=
isition of rw_semaphore.
- [Critical] Variant VFIO drivers bypass lock protection and DMABUF revocat=
ion during hardware resets.
- [Low] Unreachable `goto err_out` dead code in the lock unwinding path.
--

--- Patch [1]: [RFC PATCH v1 1/1] vfio/pci: Revoke BARs and DMABUFs during =
sysfs-triggered PCI reset ---
commit 40a15b781e5d64ee9f9f0c183f4f1df4fd3d6a7a
Author: Pranjal Shrivastava <praan@google.com>

vfio/pci: Revoke BARs and DMABUFs during sysfs-triggered PCI reset
   =20
Currently, vfio-pci does not implement the .reset_prepare and .reset_done
ops in its struct pci_error_handlers. During a sysfs-triggered PCI reset
(echo 1 > /sys/bus/pci/.../reset), the PCI core resets the device using
Function Level Reset (FLR) or Secondary Bus Reset (SBR), which isn't
propagated to the vfio-pci driver. Due to this, the exported DMABUFs and
BARs aren't zapped or revoked and the importer continues to use them.

Implement reset_prepare and reset_done hooks for the vfio-pci driver
that zap the BARs and revoke the exported DMABUFs while holding the
memory_lock.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index a113c55845e10..e46b0b1d8a598 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1334,12 +1334,14 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_c=
ore_device *vdev,
>  	 */
>  	vfio_pci_set_power_state(vdev, PCI_D0);
> =20
> -	vfio_pci_dma_buf_move(vdev, true);
> -	ret =3D pci_try_reset_function(vdev->pdev);
> -	if (__vfio_pci_memory_enabled(vdev))
> -		vfio_pci_dma_buf_move(vdev, false);
> +	/*
> +	 * Drop the lock before entering the PCI core.
> +	 * The PCI core will re-acquire it via our .reset_prepare hook.
> +	 */
>  	up_write(&vdev->memory_lock);

[Severity: Critical]
Does this leave variant VFIO drivers unprotected during hardware resets?

The modified ioctl handlers now explicitly drop memory_lock and skip DMABUF
revocation, relying on the PCI core to invoke the new .reset_prepare hook
to handle these tasks.

However, vfio_pci_core_reset_prepare() is declared statically below, making
it unavailable to variant drivers like mlx5vf or nvgrace_gpu that define
their own pci_error_handlers.

When variant drivers undergo a reset, won't the PCI core invoke a NULL or
unrelated reset_prepare hook, resulting in devices being completely
unlocked and DMABUFs unrevoked during the reset?

> =20
> +	ret =3D pci_try_reset_function(vdev->pdev);
> +
>  	return ret;
>  }
> =20

[ ... ]

> @@ -2418,8 +2420,33 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_=
core_device *vdev,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
> =20
> +static void vfio_pci_core_reset_prepare(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
> +
> +	if (vdev) {
> +		down_write(&vdev->memory_lock);

[Severity: Critical]
Could this cause a self-deadlock when a Function Level Reset is triggered
through the PCI config space?

In drivers/vfio/pci/vfio_pci_config.c, both vfio_exp_config_write() and
vfio_af_config_write() acquire the lock before initiating the reset:

vfio_exp_config_write() {
    ...
    vfio_pci_zap_and_down_write_memory_lock(vdev);
    vfio_pci_dma_buf_move(vdev, true);
    pci_try_reset_function(vdev->pdev);
    ...
}

Since pci_try_reset_function() propagates down to this new .reset_prepare
hook, won't calling down_write() again on the same memory_lock lead to
an indefinite hang, as rw_semaphores are not recursive?

> +		vfio_pci_set_power_state(vdev, PCI_D0);
> +		vfio_pci_zap_bars(vdev);
> +		vfio_pci_dma_buf_move(vdev, true);
> +	}
> +}

[ ... ]

> @@ -2561,55 +2588,52 @@ static int vfio_pci_dev_set_hot_reset(struct vfio=
_device_set *dev_set,
> =20
>  		if (!owned) {
>  			ret =3D -EINVAL;
> -			break;
> +			goto err_out;
>  		}
> +	}
> =20
> +	/* Zap, and set power state */
> +	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
>  		/*
> -		 * Take the memory write lock for each device and zap BAR
> -		 * mappings to prevent the user accessing the device while in
> -		 * reset.  Locking multiple devices is prone to deadlock,
> +		 * Take the memory write lock for each device, zap BAR
> +		 * mappings, and restore power state before reset.
> +		 * Locking multiple devices is prone to deadlock,
>  		 * runaway and unwind if we hit contention.
>  		 */
>  		if (!down_write_trylock(&vdev->memory_lock)) {
>  			ret =3D -EBUSY;
> -			break;
> +
> +			/*
> +			 * We failed to lock THIS device. We must step back one
> +			 * device so err_undo only unlocks devices that succeeded.
> +			 */
> +			if (!list_entry_is_head(vdev, &dev_set->device_list, vdev.dev_set_lis=
t)) {
> +				vdev =3D list_prev_entry(vdev, vdev.dev_set_list);
> +				goto err_undo;
> +			}
> +			goto err_out;
>  		}

[Severity: Low]
Is the goto err_out jump here unreachable dead code?

Because vdev is the current iterator inside the list_for_each_entry() loop,
it can never be the list head. The !list_entry_is_head() condition will
always evaluate to true, meaning the failure path will unconditionally
take the goto err_undo jump.

> =20
> -		vfio_pci_dma_buf_move(vdev, true);
>  		vfio_pci_zap_bars(vdev);
> +		vfio_pci_set_power_state(vdev, PCI_D0);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807201405.3717=
430-2-praan@google.com?part=3D1
