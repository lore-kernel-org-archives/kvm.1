Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0AB3E2751;
	Tue, 15 Sep 2026 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500358; cv=none; b=rVYECw/Rwm4XbaGNbSXzs6Ypfvunb97aA2En/nap+Rzs0EWJ5CENrF5S/9NnppAS3hjVDqcw5tQZWbTk3yDi2zdOz4ve1Fb9oaP6RxYrjnBrsQWBkVkMZvrzIDJz/4REnnk4fFKrhAF3JqqflnpablodkEFgyihZRmnz9T5gJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500358; c=relaxed/simple;
	bh=Dk28pIxzzW4aPOAlPcQBczd3T2L1VYdigLIEOJGcYQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNsZhtGJgVbIBwBxxGHMedoPa+jzI9g2D43KqWhb9xswmYg6jhugp/AGBGwItdHPs0YkxCNMzslfcl8BILsbcWjLMmymjSmje0iGQqFh/Ne2iTVS0mdLaD+mCiAMAyh5FPKfFK22zj/cGw1wq8BJB/XzhVyTzqO/lU1mju1r2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=mLIgKZBB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQUMS5VO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="mLIgKZBB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQUMS5VO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 207907A000F;
	Tue, 15 Sep 2026 15:25:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 15 Sep 2026 15:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789500353;
	 x=1789586753; bh=vyKUSpi9woKgL8lhAxq3JSS1SRiZb5RxcXQIgvhEpgs=; b=
	mLIgKZBBM8JuS0jIHSN0vXdTuIkOlOlauggVg1LG9vJbYnWOX/OINXIK1NiUaBTA
	QKX5xSUO17BOvtfCgFWudSgelBN0LhrhMQUz7BflbDh2qdroVWTVXAi7XPwHAwYK
	3W/eLamM55p3ranwZqhtEAQsk+raFat3/26SPELPkrqgN76I1mOGNt6unhw+S5Xm
	35viLGOhhhjjCI3K+ek1xO67qMEVMPLCEQYr7bmMujxCVQoEAXS3tkoF9a/VZ18z
	sbnGvVT+H7080jUjNBykmOygh4Rbfo93SNl2jaEBJgLiWb6Mc8d3gnDBwgkCEWSV
	Wx8/9JE8hb8P++m6n8zvzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789500353; x=
	1789586753; bh=vyKUSpi9woKgL8lhAxq3JSS1SRiZb5RxcXQIgvhEpgs=; b=g
	QUMS5VOpzrF8f5izYNAbY52PfDXCl7Yp3HyCK5GkfMlk4ZjYVE9qIT9KXPi3tKgg
	RnGNHJjlFYPL7F3SH1Of/jAr/snREUMVkCFIjEE+cOHkftbO7TTzBcvhCHQV1kcS
	BfjwGEzftTUrF5aMTA8TaaDPqH95CUUqvF+PgN7h8+yWZR5o4b4qP2x8dRv+o73J
	PkvxCiSbU0aKKXvsPJusHNDxIjlvSU+0GACNlvubwHzxkgHDYdkaVYnSLiee/0EV
	PpM55v3PK8lq83vqg0SDl8MjjW8tTNIF43eQy4PorSIAbQAkuPgXxWkQXfR/WbV5
	SZ25ZN9joDWN2Pisk+Uwg==
X-ME-Sender: <xms:wZupatlJFBddSWwiNYu1Bv39_kPPUkJK0UJw_JeKHMNzPKRz0qiaQw>
    <xme:wZupaiLX9TMc_fAGFJ7duBd4wZjxEgZO9xcfKCWxcZ6UBgFcjIWkhH4Z87rRZBmfl
    xCVMNRgC2SxfVuSrTXLez1lGKCtnKImS2heraS3LAqxYwb8PLvDw7g>
X-ME-Received: <xmr:wZupaq70wjRya49gwt770BBa-FGDrpfvL0iN-HDmZIgco7cO9JK3ofMLGE2zVQ>
X-ME-Proxy-Cause: dmFkZTFB5hMkQ/+xRhSiQV2xngg1umSSs9G52yafLe0v6Erq8UvOOEUT3/O+CH0fu1kFdZ
    rdW2yPSAOqJ4EWk29MI8Oi2g36d2lCaNw/DWZpXCyYt8JFWr1f/MM0G49C2CePYZnywHz6
    IIAV0H22xvENWEc++WnwYvT4pm0e3JgLCiE3po60poF71m1qDEzE2/61k3LztKwsfpWUXY
    36nouQIZxHngXJxcz/KprUG82NHzH7mWHwy9vnUrF+x9KA1ruol+cbT2mJ9zAiBhOsgXDB
    l9gvbi9cXoJsh1DXrxbMizMwvkaD4pGLq+EmYsZKS79r3i7RIZGM+9neyuK8sZtwPQotmS
    zU0ekQhUNt7PfR5D25pD+Te6ibaOYLIdRnGjQFoV9nXyS0jEslMMqAgtR3ghSSGrRM4w6e
    wCWX+X5M8vqCStEBtSkpz3oiletJBG00/E6vzTiZKgSP8Fxk7/c81CmoEsSrryjutzgMXV
    G9Mm/BCh/ZsxuldFVf0W6OsDEnvIR+c6un8Qk48fHVbiQzZwB0ec/5WOu1K21J6W90XgjD
    7rLhzKwiheoAw05IbPUBqyigbtR++YH8CMDuuy5vg1ufJQMoM2+MuO0NH647CyAjhlD6aa
    4/oYNA4HK+80EsqL5RKsodrLWSZ6uycjwog0qTZVRPKncJyZCU7SAovrq1Uw
X-ME-Proxy: <xmx:wZupau2gbqLwbY1oIa63p6oGbCztafsX4G2J8LZouxtrKQQK7XfGMw>
    <xmx:wZupaofpM3zCX1vtsMfWqfs3qr5JNvqt1MRoUIIqJq_5IRd3k-pYpg>
    <xmx:wZupase8K9_sXSRLG6NvWuq5Ru2wiqhN79camjHPv664VMWSZGA-Rg>
    <xmx:wZuparwG8tUECED8oy5Cm80HB0LkGsWqXDP69cET71E1zJnhl9bvgw>
    <xmx:wZupah2AZSXdgwYazwcbG8fEDPxwwd2tlo_CFenEEIjFSXzK4j67FYW->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 15:25:52 -0400 (EDT)
Date: Tue, 15 Sep 2026 13:25:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Cc: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "anthony.pighin@nokia.com" <anthony.pighin@nokia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, alex@shazbot.org
Subject: Re: [RFC PATCH] vfio/pci: Block for the upstream bridge lock in
 vfio_pci_core_disable()
Message-ID: <20260915132550.5516b466@shazbot.org>
In-Reply-To: <PH0PR12MB7010CE4CF2192FED40DF5B6289BA2@PH0PR12MB7010.namprd12.prod.outlook.com>
References: <20260908080946.2235849-1-YuanShang.Mao@amd.com>
	<PH0PR12MB7010CE4CF2192FED40DF5B6289BA2@PH0PR12MB7010.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 08:08:56 +0000
"Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com> wrote:

> AMD General
> 
> Hi @alex@shazbot.org, @anthony.pighin@nokia.com,
> 
> Just following up on the RFC below. Have you had a chance to take a look?
> I'd appreciate any feedback on the proposed blocking bridge lock approach.

Sashiko already outlined the locking issue:

https://sashiko.dev/#/patchset/20260908080946.2235849-1-YuanShang.Mao@amd.com

So no, it's not safe to promote this to a blocking lock.  Subsequent
opens will reset the device, the only remaining gap that I'm aware of
is an unbind with the device unreset, where there's some current
discussion[1] that devices should be reset on unbind if dirty.  Thanks,

Alex

[1]https://lore.kernel.org/all/20260818143906.1f58aecb@nvidia.com/

> -----Original Message-----
> From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
> Sent: Tuesday, September 8, 2026 4:10 PM
> To: alex@shazbot.org; anthony.pighin@nokia.com
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Tiantian (Celine) <Tiantian.Zhang@amd.com>
> Subject: [RFC PATCH] vfio/pci: Block for the upstream bridge lock in vfio_pci_core_disable()
> 
> An upstream bridge is shared by every function below it, so taking it with pci_dev_trylock() makes the release-time reset fail whenever two functions under the same bridge are released at the same time.  One wins the trylock and resets; the others take the goto and are handed back to the next user without ever being reset.  Nothing is logged.
> 
> This is easy to hit with SR-IOV, where all VFs of a device sit behind the same bridge.  Releasing just two VFs concurrently is already enough; which one wins the trylock is random between runs.
> 
> Take the bridge lock blocking instead.  The lock order (bridge, then
> device) matches pci_bus_lock(), which takes both blocking.  The trylock on the device itself is left alone.
> 
> Concurrent releases now serialise their resets, so a teardown of many functions under one bridge pays one FLR settling time per function.
> 
> Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
> ---
> Hi Alex, Anthony,
> 
> Sending this as an RFC because I would like to know whether the approach is acceptable before going further.
> 
> I hit this with SR-IOV: all VFs of a device share one upstream bridge, so when several VFs are released at the same time only one of them wins the trylock and gets reset.  The rest silently skip the reset.  Two concurrent releases are enough to reproduce it here.
> 
> My question is whether taking the bridge lock blocking is safe.  I have run this without problems, but I do not fully understand what the trylock on the bridge was protecting against -- 962ae6892d8b added it to silence the unlocked-SBR warning, and it is not obvious to me whether blocking there can deadlock.  If there is a path I am missing, I would rather hear it now.
> 
> An alternative would be to keep the trylock but at least log when the reset is skipped, since today it is completely silent.
> 
> Not yet tested under lockdep; I am setting that up.
> 
>  drivers/vfio/pci/vfio_pci_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 362c375a0579..8966a5bea406 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -790,8 +790,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>          */
>         if (vdev->reset_works) {
>                 bridge = pci_upstream_bridge(pdev);
> -               if (bridge && !pci_dev_trylock(bridge))
> -                       goto out_restore_state;
> +               if (bridge)
> +                       pci_dev_lock(bridge);
>                 if (pci_dev_trylock(pdev)) {
>                         if (!__pci_reset_function_locked(pdev))
>                                 vdev->needs_reset = false;
> @@ -801,7 +801,6 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>                         pci_dev_unlock(bridge);
>         }
> 
> -out_restore_state:
>         pci_restore_state(pdev);
>  out:
>         pci_disable_device(pdev);
> --
> 2.25.1
> 

