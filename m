Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C13E7BAD;
	Wed,  2 Sep 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388448; cv=none; b=AXhxoEtl63ihqijN34DhSRUs0NUkOnyghC+8p7H/1K/8FaIXwMYYvH53wrhWnFinlBM7lzsitZ+uWNoqoGFkQvdCZpbmpbJoFh8MMKQHFHIOIcz95Dzm+doOIvaSpzHO9bdH0Ys1kXdMKb7tqv6kTgF8DsEiq8QjHjdDX/9J/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388448; c=relaxed/simple;
	bh=RzzA3+1m4Lh5yCkOPK2QYRulDaXKGBlKZqOUzxJyT4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJZTJRLXt4iuL2VtA558NN+wzy9WvnRqFOZ9G2LZtJXhHripYiAaRmZKituneR6d/7T28UbeCKE2TkjdT7IX9vap3z+3wAJZHaK5UARtfa7R6paDwimmrmR5YX2g57MPjM8TampPFKaBqCrd7fd6z86ahwlTVGd0jIpafcCD4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ft6hx2Hv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sVF7NvGl; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ft6hx2Hv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sVF7NvGl"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F78BEC01F2;
	Wed,  2 Sep 2026 18:33:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 18:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788388439;
	 x=1788474839; bh=Lr/zo+MlvOktt23sxpp6Xvc1+8nZHzXSt8jNo3aeeRc=; b=
	ft6hx2HvDfnD14VmVly+vl+HSb3Oj555gXFgzg7MNxQXFTAYKuVxrKzafHuIvx9j
	UWP/mUFCZy9W88JGwmNq29/lb9Le5EfeoupsQ9MRiWIxDm/c4Ou+eEyPfnBCu4Ru
	EhJ1yfaxWzxXtgNVhI9kAJWiLx65E03oJLO2tURNXob08ZuSe0Rs+V3z1xfMWYeI
	eFsxhnPhv8I1AeGQ7OxWhWkCrWDRQHclhXsQNeBW5Kj+jf1WG+3PRoGxT+IQdfZ+
	JaFNwu4w9nLQCr4EMpi/KuwzTQYyXizpqv3VHjgE2EtfuBzAhXlcJeCmRM0udZtc
	52e/GFWC4d+6HnqrsIk3Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788388439; x=
	1788474839; bh=Lr/zo+MlvOktt23sxpp6Xvc1+8nZHzXSt8jNo3aeeRc=; b=s
	VF7NvGlQPY7LQT1KblbBcJO3dZ/38fRLH9hoHQlbQlgK6QN8tFWpi3rPNFFCfZ2f
	LP3XF3CarGyQV1OYss59hnPY+qRlT7FHoHdhIK9D7zXkFIiBESDOB/5hvjbNbLY6
	3j/AC2wUjTUVDyjbx6Uqu59a7SdWkNz/jMwkXFeM23zN3uF32HCym+UYVVM78Frz
	VGcnCK3u8ghr7BH6zIBrE3c+FLJ9IbeiVOZ6R5ueMr2+YtMBaFI+WVkU3jtDxFO3
	YjB6l7atloO8Ts5oNFSI7/jTxci1VcFFhiz/UQtx2Xgolvd1fUJec8Q3DwysScWd
	r02pQpl6bpFdlXAX+QgNg==
X-ME-Sender: <xms:VqSYapq_umquKaXG6a5ONpFuewt_zi98KucnVgSMpgCGQWyQ2l42vg>
    <xme:VqSYatIaQe3sFSXGzzFVQr8emUiEfxcYmG6y771Z3cFjSpcolIFkw7vS-aPkMjIIz
    DeCw8crJZ3tBWKGxd2lEFkQ_AHu2vRizgHYd96E1EvnkJAm-q0BNhA>
X-ME-Received: <xmr:VqSYamTUfo2zZtnhxs8LhanZEAC2Rr_DqbljUbym8uW7ZgB231v8hAYxm5dKYQ>
X-ME-Proxy-Cause: dmFkZTG4fpwdkiwCVBvkqkgJR+jco2a5XAO5Mc3FnRQHTEDdBOVB4n+UKBf45W2FUCaiaf
    vRl7CJ+mYjRIUHoSb23Ewl01cEJBOcfHJqknQN8MEVj1J319WYP6t7vIVyaQ058mHjjZ8N
    ROBBd5x+TtGoJ8TRikC7GZrwMV4F0NsCLBjtFOdFMWgpJphlYa6KgWO47evsr29ELyCGMG
    NEH8LxX+LlJdeG/M5ZujODZVdolH8u5weOTO/Oa+jh6a9Bu3wW1FYCqN1uVpD1f0EiaVT9
    cI1zpjuGwjujRiDAUT7zsA9+6yqupfwKYg27BMB9z7QgRfTusZdaGkRobVaGqGuVPDxih/
    8pg14N0pk6tdxA/lU3lXaEVy5w9s9h2xfHzDRhfofyExct+9QXr6KCbNDWhDBQM9OMWFZW
    umuJmJJ2PNG1J/H2Egug6JKumuLtjZbvCu53vK2RFbUGanHUSMCF1APHgsKdId5ufHI8jP
    IfwPf3G9N6y+ftkgG392OA8zpkPwj/JfkPwUUBBJ2qIM/p75UQaC0OC2NK+ufd0kHGcyFl
    P3xMRtfcXjJBsM9baEqXArpXWAF529ER3SVXFE3WYc6pHcSeriye9e87Leo/L8ILQLOvIQ
    bJ/dk7akKfvq7V4AGfGHj3ZcLZ6IbJlZkW7ePyMB7s1N6whlJL9NIB8Qfwnw
X-ME-Proxy: <xmx:VqSYakug_rkEVcOqmUd5EKKB_-lw8jxMrLac4R9oUEZBGLi4lTmZgg>
    <xmx:VqSYavbpyhp93E0u7E0G9DjrhDYefcXZ2gUXGe0TAo9d-zm_E7t2Bg>
    <xmx:VqSYaiHj0bCk7QgDQzI0lDyjMNpF16ttLV9cuT6ltf53I7z9NqgurQ>
    <xmx:VqSYary1nCSCOA82DJUvuDLLz8AiID20lez7uaGtrLm0PwPWJcJRvQ>
    <xmx:V6SYamu27n4Vytbr2kEf6Y4uS_sP5L9yZynqrt_yJMRdwUpr41uwi6Fj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 18:33:58 -0400 (EDT)
Date: Wed, 2 Sep 2026 16:33:56 -0600
From: Alex Williamson <alex@shazbot.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex.williamson@redhat.com, alex@shazbot.org
Subject: Re: [PATCH] vfio/fsl-mc: prevent read-only region mappings from
 becoming writable
Message-ID: <20260902163356.34649391@shazbot.org>
In-Reply-To: <20260819084209.1543-1-suruurism@gmail.com>
References: <20260819084209.1543-1-suruurism@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 11:42:09 +0300
Abdifatah Suruur <suruurism@gmail.com> wrote:

> vfio_fsl_mc_mmap() rejects writable mappings of regions without the
> WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect(),
> writing to MMIO regions (e.g. response portals) the device marks
> read-only.
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
> its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
> drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
> a5edadbae57e2298a56cf7a4e774a027905a331f).

In reference to both this and the platform version of the same, this is
being positioned relative to CVE fixes, but while these drivers do
include support for exposing read-only regions, it appears there are no
devices that report a read-only region and it's apparently
mathematically impossible for fsl-mc to do so.

They're still logical fixes, they still appear valid, but the commit log
should be blunt that these are effectively unreachable.  Thanks,

Alex

PS.

$ ./scripts/get_maintainer.pl -f drivers/vfio/platform/
Eric Auger <eric.auger@redhat.com> (maintainer:VFIO PLATFORM DRIVER)
Mostafa Saleh <smostafa@google.com> (reviewer:VFIO PLATFORM DRIVER)
Pranjal Shrivastava <praan@google.com> (reviewer:VFIO PLATFORM DRIVER)
Alex Williamson <alex@shazbot.org> (maintainer:VFIO DRIVER)
kvm@vger.kernel.org (open list:VFIO PLATFORM DRIVER)
linux-kernel@vger.kernel.org (open list)

$ ./scripts/get_maintainer.pl -f drivers/vfio/fsl-mc/
Ioana Ciornei <ioana.ciornei@nxp.com> (maintainer:VFIO FSL-MC DRIVER)
Alex Williamson <alex@shazbot.org> (maintainer:VFIO DRIVER)
kvm@vger.kernel.org (open list:VFIO FSL-MC DRIVER)
linux-kernel@vger.kernel.org (open list)
 
> Fixes: fb1ff4c194157 ("vfio/fsl-mc: Add VFIO framework skeleton for fsl-mc devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> 
> ---
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -406,7 +406,11 @@
>  	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
>  			&& (vma->vm_flags & VM_WRITE))
>  		return -EINVAL;
> 
> +	/* Prevent read-only region mappings from being upgraded with mprotect() */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +
>  	vma->vm_private_data = mc_dev;
> 
>  	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);
>  }
> 

