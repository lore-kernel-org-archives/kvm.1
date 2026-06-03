Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF518872A
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448752; cv=none; b=sHpvNxpu81k0kT8+zak8o0Q/dete3wWyrXWTKhP6AUputLedyb/OBv8UmKW1IIbgtq6Tk8dAF1d287NhzZiq0/aejhjtVt2cys6d6v8o1ebvk7AgxW3SfnwZKd4qZcDI80NZhC3VmxM1+QMim5JX4DasFkhyOn6hG2hMAPcLSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448752; c=relaxed/simple;
	bh=u4ZwvdtqyKkvqfZ4xOXnUQfX+M6r5bs1mqg9vWH4izY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltF4wQI0g3ucEHAoITaeTsiSWxUjKVSf6pTLWnPzpFWh4+p+GXCo32ViM9CaQFaQgipa4LpbnjlqmG4VUCIpDnp7W8DmnC3xZU6vmYL3aEtewsTR7JkPdQ5vd17U7kjQGZI75QuEcWpaRvHIm5lvoawDnif2PhvCcnv9jUK2sgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Vb/IqGD9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vb/IqGD9"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517654b8e28so14606541cf.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 18:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448750; x=1781053550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nF9EObNDEmryj31PflampZ0Pq/iKEgkudnP3BX3S/AU=;
        b=Vb/IqGD9/62/BIaKGrIR97P2I/GXAC662Sggs9S78HDf0fobGJc2/vEkpLplHqBWoB
         xCMzsdzLXXiBVsPblWOR5W/XfIElIfei8vaUSCFIsr90zkcd6jtLr1h70i5l4t2J7DAT
         4O4xbWrrfMMfI1vU0fpwMLEzojfBK1DmxbFeoPvJQ/fa40QsQuYk4h9oaLj/G7Bn1/Fn
         06XMVTzgL9VgtH37FyPgDXp223hu5PfyqJyVlZc7H3JTfQKt1oX2vRbADp1F7/ZJEQ9f
         2SeskE4cOCA7RZ9toCEx8LE7BnROL8gXECEbv41grH/51KjrRrnYeaoy41DPHV1CcoZm
         LZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448750; x=1781053550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF9EObNDEmryj31PflampZ0Pq/iKEgkudnP3BX3S/AU=;
        b=ePqlT/F7re4DhrIniNY3811JHb/ioT4CTG975tygsx85lIrOo6vMCdkSnP3mWGIbZU
         SqyT4Al1IwCE0DVMLY5YAlm2XhzIWVH5Kcqn/8R+HxlxCkqLl+LGlNFeGIJT0selWxEw
         HbZtmC8ugCfzAP6zx7/7Mm4Ove+QyRmazSU2riAgfP1okJkQ7KbgVZMI8Lswr1k4m0zo
         xkuw3361okRYsqRc1DfBkCTKseIlm/0UuKhA3CrTxgpbHWTpSRUVUm6SmwWneJGfbPrs
         9B+0Pogp5H6W+9GHV2GpK3dIYexPad+k/vtU+yrfnQRB3aRSHx4ptfzKdHbTbZUmkDed
         ld6A==
X-Forwarded-Encrypted: i=1; AFNElJ9kcFONYe/zDk2saaYVdVxQ2S+VGw4C9rkgyO/osLPJiZK0E2fU9ynWqw/oYQFv4D5IMCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrfz0ukij8uifh/b614RUApORrMBVxMbb+SLXvQUOe4zGOoDxo
	eRmTUWpaY2bWXv0lpjMEXGQ5K+BKLW8HrO1ZcoA2+YDQH9CStOIP7srcgYjPBwa19Pg=
X-Gm-Gg: Acq92OE1acKLpWNqCWPBbUqRqclRbdEshMtiah7ysvHw/R4QzB7+HilowjQMB0ItkWy
	LA5fAJpsgclVJoh2+7JgNL93TVOYwpuhFBuOyt1DNawLOjfIR0/rtMB3SnRYcz1VtL0vVsqIfWB
	hO3oUCRhmkWNYRggwO/z6//leREzx/9klB+qS4mZbGvR5yVsVEjsBoe8AOqxWt+ka/j7ldRyzTY
	rmmBaOowP1LhfvV0TzSBdP9wVkUyLqIh03MJv5QCIRw2Ws+0l0aFHK5CvQqvlVkGgrkNzPzEWYS
	J6+AVHKNJKH0ngYNYsG4YE28FcCAUmCfh5lzYhLKfbVxjacl2fFtzUxg270h/T4mZC9G/JP4yyV
	d570f7AgRLG4kRjW7RodN+blaKVjr2x22yP+USPfioObHW9Fx/qewcKxaodiIqzw+tBMuCQkBHU
	gg7AEajvmRILf2Gtwr+0WCB6FBw1G2FstBeFacAZ+yo997v/89n4U3sPtq+EJrub4YCDYAATrCB
	qH2Q1s3zqZs934a5qAJM19pJy4=
X-Received: by 2002:ac8:7dd6:0:b0:50f:b257:9301 with SMTP id d75a77b69052e-5177877c12cmr23156881cf.52.1780448749904;
        Tue, 02 Jun 2026 18:05:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c297a8sm12256991cf.8.2026.06.02.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:05:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUa3I-00000004y36-1UNk;
	Tue, 02 Jun 2026 22:05:48 -0300
Date: Tue, 2 Jun 2026 22:05:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] vfio: prevent infinite loop in vfio_mig_get_next_state()
 on blocked arc
Message-ID: <20260603010548.GP2487554@ziepe.ca>
References: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881290BBDE79B61AE6A017FAF122@SYBPR01MB7881.ausprd01.prod.outlook.com>

On Tue, Jun 02, 2026 at 04:58:48PM +0800, Junrui Luo wrote:
> vfio_mig_get_next_state() walks vfio_from_fsm_table[] one step at a time,
> looping to skip optional states the device does not support until
> *next_fsm is supported. A blocked transition is encoded as
> VFIO_DEVICE_STATE_ERROR, which the trailing return reports as -EINVAL.
> 
> The skip loop does not account for the ERROR sentinel.
> state_flags_table[ERROR] is ~0U and vfio_from_fsm_table[ERROR][*] is
> ERROR, so once *next_fsm becomes ERROR the loop condition stays true and
> *next_fsm never changes. The blocked arcs STOP_COPY -> PRE_COPY and
> STOP_COPY -> PRE_COPY_P2P map to ERROR yet pass the support check on a
> precopy-capable device, causing the loop to spin forever while holding
> the driver state mutex. This can result in a soft lockup, and a panic
> with softlockup_panic set.
> 
> Terminate the skip loop on the ERROR sentinel so a blocked transition
> falls through to the existing return and reports -EINVAL.
> 
> Fixes: 4db52602a607 ("vfio: Extend the device migration protocol with PRE_COPY")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/vfio/vfio_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
