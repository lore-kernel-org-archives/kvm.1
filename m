Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38538491592
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048321; cv=none; b=O3ZNMWmfY62OYFAzyhzZQ1st9Cwiq9hfRkrfOMYXstuVw9ltCaMBOoRWhhW8Sjlavy7tMem4X0lAm8yL0QlkpSY08jFyoPV+eBaEyFKSM+jiVaKx7LYii7Rhzxe86/JntAvuRwxzdKkNwEbF+seU26kKaYMbmcpKbsDdpO0FtoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048321; c=relaxed/simple;
	bh=XgIZtELb1ZIkrmHhfzgcSOPlpUFR8nECZHZzvS4SnIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed0fbA8f/ThjcnsFVdBJrZ38TLuOsYTzGxdQ+zwKfrLEP+LEAyl5q6E76ezo1MOtagpKPPyDCeMqEUYDYoymwQ92P57X9hfr96EHXV+9Osnffyf5TS02AAjVksEZaBlbL3Bkp5eN401+NpPOtMR6wcb4BRP1dLlf6XuJvhoWMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pITLEDXA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pITLEDXA"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9309d4ea213so779647185a.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789048318; x=1789653118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aIspwDR6Ddr/0LRMfUMSZKdiTeMmO/Ea9KmPXL0TMZs=;
        b=pITLEDXAxmwHnFTCkriI43qvVnHHVpno8YtYIvEI/l+wJ/43QM1H1TD9NhSRhxoWm7
         i/lhnd93kJ1xoLa5f/bO+87z8qb402lsqHX8bk0iY3Q3PE9+4GPQfRUqPw7qX9wofrDG
         FZWSoFgWPifVAtmmUX+93Jsjtq/cPxtrdqIQxo+JhF5WDa6Prkv76QtNJhFQqveH0BL/
         dwRpm+F5Bv6yh+y1b/tMv/7iu4zF3seMFW1WsuLvNQEVEYl7ksbvXj05zbZacLCywsRb
         2Y+TqH8g/3DT7a5IIxb1rsYkTvM/XW+ERMMraz6TGk+TGCAI2jsdn8ZUzH5rKCXwCZzT
         WFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048318; x=1789653118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIspwDR6Ddr/0LRMfUMSZKdiTeMmO/Ea9KmPXL0TMZs=;
        b=J1UQhOAgVKiFzW1uY3D+ANN9SXkHVAlD7IOFYML4HUOZGAeHDPj1O5qHcFBVYDtk8c
         v+nmLb2VgszMlYSsIIxAIaQt5uJzZ1cgc5wacvoeeoXKKo3HMJ/1X+UGJ9J+sQD3liPp
         GcPx/TASeNHclD+BymO3PmjXGh5eKDk0T6a2X9AsR042uoeQO4JX8VP1GNF6FPuk4SXV
         yB0QZ4Yy5JWeMYF7MqAy1aVyuUBdlI23xgmjbpw3eoXbsaFFnj06Zi0kWCGZfaxYOehh
         /e47BwJel5GqlPJ9xExBemh+pIMic/PTPI5B0xmTIH/BY8oN0vhTeVQp9nxO1OLaR/0p
         +1VA==
X-Forwarded-Encrypted: i=1; AKwUvBzqY6uDe5KtL7Y4UoI0At27pPsU/RZMWPKpQPLkoreTYDrpKXQ/k5oP+i8DPzRptmi78UI=@vger.kernel.org
X-Gm-Message-State: AFuF++mxW6ovWglFJP8Uj71qL6BoanNzBbTtXjRhWYY2mjHAKJblx81r
	WOEVBCSFnwtUAVswKeNN10FXg4Hf+26EH1tmSm7gxJowbvwfgJRxbZwR1QEFaYurH7mO5dkL4He
	nWW7r
X-Gm-Gg: AYBFou23snrxuIdSRNA0QBq3saqYKlNjkdbDWgZEJSirYbKtEi3cm0n+cTxcToclQWR
	cdn7GVKmyv5vjnN3m+I7debx6BTclf2+hZrQeS0NNc+x8BamBde3lzDWwenZ4WwPebZjoa9GsXA
	EARlmR8Qhb2EWOMJbqCalz5CE/+/z0HrucEFu4vNyqSXmdlmryqcgWi8pe8TxveRzHc1ug6LMDa
	pSdcsXnJwkydThfkE5BgcrONL9XwqiDXerLTVq6DJSCzdwu7mlHZcppbnzkGW/y4JhlwQ8qUw3+
	Z7upezKJ3ZJNb7vXjViY22Q/y6AB4xGB76enb/Qq/S4HDDl88CMbhIV6IYAmdBRpWfF/E5d9Jeo
	mAs6K4TEa39JLinpy5RJUxszb82anyMzTWrmrkD9IoCco+xMtm0UjBYLYrnF1HGcRGdYDe3fC/N
	livbK4FYdFQm17bInRe0SOWVr4kacYR+Nv60ASVVx8HOzO/dd6rchG+0KD7ybZ7G3Ps4n7mbHLF
	+wXA/DTZKN+tch6q1gnLHeCSw487FcVpb+SY3Dwzqbhz9jLyos/lkqg
X-Received: by 2002:a05:620a:25d4:b0:939:6df9:1996 with SMTP id af79cd13be357-9398077453bmr4519596285a.50.1789048317562;
        Thu, 10 Sep 2026 06:51:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e2b5f2c6sm62668785a.5.2026.09.10.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:51:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x4fC0-00000002Vsb-1nwc;
	Thu, 10 Sep 2026 10:51:56 -0300
Date: Thu, 10 Sep 2026 10:51:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH 1/4] vfio: Reject a second cdev open before mutating
 shared device state
Message-ID: <20260910135156.GD4083318@ziepe.ca>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
 <20260901215358.2421359-2-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901215358.2421359-2-alex.williamson@nvidia.com>

On Tue, Sep 01, 2026 at 03:53:54PM -0600, Alex Williamson wrote:
> The cdev single-open check lives in vfio_df_open(), which runs at the
> end of the bind ioctl, after vfio_df_ioctl_bind_iommufd() has already
> updated state shared across all opens: vfio_df_check_token() can set
> the PF vf_token and vfio_df_get_kvm_safe() records the caller's KVM
> pointer in device->kvm and takes a reference.
> 
> A second cdev bind of an already-open device runs both, only to be
> rejected in vfio_df_open().  The error path clears device->kvm and
> drops the reference, tearing down the current opener's KVM association
> and potentially resulting in an unbalanced reference on close or
> premature release, while the vf_token remains clobbered.
> 
> Move the single-open check into vfio_df_ioctl_bind_iommufd() ahead of
> both mutations, so a bind that cannot complete leaves the current
> opener's state untouched.  df->group is NULL on this path, so a
> non-zero open_count is exactly what vfio_df_open() rejected.  The test
> in vfio_df_open() becomes redundant and is removed.
> 
> Return -EBUSY rather than -EINVAL here.  The arguments are not invalid,
> the device is in use, which could be a transient condition due to a
> delayed fput if the prior user is terminated.  This provides
> compatibility with the group path, where a group open returns -EBUSY,
> and users may choose bounded polling to detect such a transient
> condition.
> 
> Fixes: 839e692fa4eb ("vfio: Make vfio_df_open() single open for device cdev path")
> Fixes: 5fcc26969a16 ("vfio: Add VFIO_DEVICE_BIND_IOMMUFD")
> Fixes: 86624ba3b522 ("vfio/pci: Do vf_token checks for VFIO_DEVICE_BIND_IOMMUFD")
> Assisted-by: claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> ---
>  drivers/vfio/device_cdev.c | 12 ++++++++++++
>  drivers/vfio/vfio_main.c   |  7 -------
>  2 files changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
