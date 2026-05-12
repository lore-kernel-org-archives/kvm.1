Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB51372049
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591837; cv=none; b=hq4pgVPzLVlOwgTiDNo3iTYCJBp7VArvQ8Z/3iBv3NsRiAhFaPIAQoG9SUbaDQIpJ5h7Kjl9hgo5PEQC4SAh27AaUNH1aWz6XulelF0Q/21qCO8QFJGDPhVIYVUtOy1c24HT7c2eStZ+Dd4OnAAM9Owr9MNBxwqNDTr/1pYMlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591837; c=relaxed/simple;
	bh=wwNRLIF1JFp5xt9HeapzPaIKxk407Y01fVL/BIECwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0zUuXNGNlcwdGHvojP+ssoI2DKKmd2i+CDkzsCPmTAcw7gaVJfTkbmnUMrCz6IAv8h5qKz8tjIMUVvhx9VDpfDO5+54G3rVLVw5YrErIbTn1pc8ioc47zIOkgWAesHqJQ/xz5EZLtLSJARELjvceeythSqxJ6sbTSElaGYmevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqGiBWlv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqGiBWlv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so50826365e9.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591833; x=1779196633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSTTjErtCCV7PDluuTX4InQQCaNvPmqczetdbYZrylo=;
        b=KqGiBWlvJ97L0+fCiJN2zFlQUEtHbxwmSSaIiI9BZw0QSZZdWxwf6xfhEoGYFtFqvJ
         MluAmPRVS4y1+rbAk9nlVmf5byTvQHLYsr1+cTlywgRFgfyUQV5Ak4z4ylIQElAkAfbA
         iZkJHoMVX5RgJXfXDI990SZo1g1Lzz5zjCIbV+CDrisEegNQCHuqveQq58KwzrJLWAig
         1ouhNbypuJKjFscYnw0iMAWbAWZ4KIdYBYaBIdJvwDd1L+1bIrF3e+Bt++4QZ5mr6B95
         iBlU0oSzui1Xc2rFJ0J4fCIuYE4mu9+lVbgpbtiJHKCHC2hZv/v54uuiMff9t2lnc27n
         1nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591833; x=1779196633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSTTjErtCCV7PDluuTX4InQQCaNvPmqczetdbYZrylo=;
        b=FuAQDI2YL3wo5O7gv2t7vjK3U9XXW8UokxmOWPQyM3Vt6E/OxAfFYMTiVwceakT3K0
         P9Cbdrin7gfxUQFqDLg3X/yeOUZAD4+UHsMv0XN9eMKoENizuyKMi2Tu/pC+d1pFGVls
         CbeN/fJOiryF4UEDdvuQ9vvDuo8zynCDJDhN7ZKjNWisfSwOh3O4yXajAQCN7bQeDkgu
         90xbwesWMHNOf5x3HYG2r5pNshZ7WBi9Y3IZhIgRvsFbCbZmxy0JEve6CuCBh48xlk3k
         BA8+kBL5d1SiS8OsQXTypjm7VSzGoJw+q0qUBYVJ9tZEYuzxGryCRtn5XC6LXiwg0L8Q
         u6hQ==
X-Forwarded-Encrypted: i=1; AFNElJ9boNeON4KE/fy8kK6eW6AKoS7lRlrDti7yhbflfuChTXMdxi3wR2rIkOtIJbU6dpmwNxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzos3PWGZ+W889odEzR8rGdAl9Clip41L2uB//Ash3U8nkVLn29
	T4K5rrtjSKMmkAmZ4TGzpTC/h/bcEPj0hnt+Grvr0Ul8pqsIstvB0AIy
X-Gm-Gg: Acq92OFvmERG+2RHbNZREwVG12faaIRwhmXgzTUdXJl7eg8j4/h9F5dekvitbF18LE+
	XgrefRorQRoSlYQJ9a8iIt1+pmuHwULqqpTOw+Hqqv1/11vCbCURixn9MxsFO/4Rze1teyEOEeX
	9tFZs9yk1GCAhYdIu6oJa5Zg/lS1uOJh9ASxEAKdqPzz8hNW3Nsg3HjXkTh05u2vI0/zydphv27
	SXDsN+jHO/gQjvnAEkJWhgS5xUzkBfAols9dMVl3WoT29ef5a9h5i5NwlLaSPRp59w/pvctgaEg
	VBu8aWdOaIg4cYXq9FyFBNvXCnMM8w1b1kfMI9ZKeI5sFw3Hq+q7AhXvWNxiPyHFHefQp8tsgv3
	4hU9MHwXErjhRumIzGhawzx1gB/+o44L+n3lZog/S0UGjZUcq0nj83p5J6BsP+xq7IUhdiTFdYm
	MdpmVAX23n6/uGWn3yYveShKuWBOwyanzxBRyUDreU6pYAwoskknqDGxQ1t2/3
X-Received: by 2002:a05:600c:6299:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48e706f11d0mr232288505e9.17.1778591832718;
        Tue, 12 May 2026 06:17:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f42a845sm17282245e9.20.2026.05.12.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:17:12 -0700 (PDT)
Date: Tue, 12 May 2026 14:17:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
 rananta@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/pci: Fix racy bitfields and tighten struct
 layout
Message-ID: <20260512141711.70c49471@pumpkin>
In-Reply-To: <20260511221609.3837652-2-alex.williamson@nvidia.com>
References: <20260511221609.3837652-1-alex.williamson@nvidia.com>
	<20260511221609.3837652-2-alex.williamson@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 16:16:02 -0600
Alex Williamson <alex.williamson@nvidia.com> wrote:

> Bitfield operations are not atomic, they use a read-modify-write
> pattern, therefore we should be careful not to pack bitfields that
> can be concurrently updated into the same storage unit.
> 
> The split fields (virq_disabled, bardirty, pm_intx_masked,
> pm_runtime_engaged, sriov_pwr_active) are mutated post-init from
> contexts that don't serialize against the other writers in the same
> storage unit, so a bitfield RMW could drop an adjacent field's
> update.  The remaining bitfields are touched only during probe or
> close where no concurrent writer exists, so they stay packed.
> 
> While reordering, place virq_disabled and bardirty earlier to fill
> an existing alignment hole.
> 
> Fixes: 9cd0f6d5cbb6 ("vfio/pci: Use bitfield for struct vfio_pci_core_device flags")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> ---
>  include/linux/vfio_pci_core.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 2ebba746c18f..24e8db5b1c0d 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -101,6 +101,8 @@ struct vfio_pci_core_device {
>  	const struct vfio_pci_device_ops *pci_ops;
>  	void __iomem		*barmap[PCI_STD_NUM_BARS];
>  	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
> +	bool			virq_disabled;
> +	bool			bardirty;

I'd put those two after the :1 fields to avoid an extra hole.

-- David

>  	u8			*pci_config_map;
>  	u8			*vconfig;
>  	struct perm_bits	*msi_perm;
> @@ -117,16 +119,14 @@ struct vfio_pci_core_device {
>  	u32			rbar[7];
>  	bool			has_dyn_msix:1;
>  	bool			pci_2_3:1;
> -	bool			virq_disabled:1;
>  	bool			reset_works:1;
>  	bool			extended_caps:1;
> -	bool			bardirty:1;
>  	bool			has_vga:1;
>  	bool			needs_reset:1;
>  	bool			nointx:1;
>  	bool			needs_pm_restore:1;
> -	bool			pm_intx_masked:1;
> -	bool			pm_runtime_engaged:1;
> +	bool			pm_intx_masked;
> +	bool			pm_runtime_engaged;
>  	struct pci_saved_state	*pci_saved_state;
>  	struct pci_saved_state	*pm_save;
>  	int			ioeventfds_nr;

