Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4E3FF8BA
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105289; cv=none; b=ktO+QDKsJFpwHCeryYHFUGxsQZuhJe46zuCIPa4SeA5og45CGRBnIAhKNDUAe54b95bK6HH0+cFlEbyHl+0eafpQuRN6eZlBBjdcdXl+X3LEfvTT0xKXaD7FwRCaHL2CiZA7SfYjnRSneMeJfudTswM/uDdBmLdl8bSrQhevMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105289; c=relaxed/simple;
	bh=UfgjSrJv5x93WLnwBClpKnVXrgqeDqs+cM42kwPrScc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2nTIqsYPqPWI6f3CiqdNXnMPo9AH6yC+LC3STZ+S5PT+aFnC73GBuyMima6JNF028wTqjahgHaQc+wnxghd3ZQRAdFy7j+6BR73f3mqCU2f31CvBqFQHA1YDJSjn92WLJkWt39N5rLtMvAcR1fjqRz3gnmJMaTuTxCpn4CYvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UuSViu1U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuSViu1U"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2911f93cso74085ad.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781105286; x=1781710086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRGcDEeCGM58JoYwcY0kneIT0WSa4bKVwTj3Opbvtug=;
        b=UuSViu1UGKFFX74cajjbEFJ7xVtKBndYL0DocayMpjiMCsactJBZLNsehZDDcNwHxe
         9Y16F8huDvl8pFGidJdOj5VuQKJhzwbyDnFjQLX55kqZzZKPq4WnTUtttIrBeHKPmU7W
         ceq2lnQf6ix+EV5EdvezEfcykpr9JzMM6dcC8Cuw68texJofrOajMHd+g5a+0Uwu8+Ga
         pX5A5PAzKTNsbpc2aQ59MpTXwHPPqSpL6gozLRpd7UKJdiE/GSXAr0wEkfJ5pjA4Qsxd
         2PmDP9E3SI+/f6a45Hm64sgUtW6zXT7OBmu9iiWXEoZU8K/tum7ISPuugiozydhP8RAx
         1buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105286; x=1781710086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRGcDEeCGM58JoYwcY0kneIT0WSa4bKVwTj3Opbvtug=;
        b=HYm4wnQ7NANOWrR2n2gb1dzMnRGFJ0qZ3F1Hbt5o03Uoixy0iPiK521gzlfiuqiUNW
         KXZkjmhuRtquT1ImSoKquT+xTHxzlJ3EW1ac0C/IFDs4XpO5z+ZGGRyMaa8E5AUG4Itn
         ZGENVBiHSo3zeABr0YX9KsI5HBq9e/h2Z+YIGwK9DKvhHIAwergqPG92xd3jY6oUILKW
         lbzRvldu0fDosojMkOlDS/fpSD9TN8x3YsIyOdWrsFoWaIlymaLuQxcdUSfk5zfiYZKb
         crtJwnTRSQucFgPyBJFSjy8FNY/V4YMnruIH0uXFfyt/ST4DIWDaNtJA45kDBWoIANZq
         zMvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hQTHUQpDg+x+P+snOLxKypHerRHDCN7seE9kS4BiixfZQkqs4JV+HU8R1hX55dHnlB+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzObUYi88A/DUrSrMvUCLXHQkp9OJf91M0byGYV4WhUTiNmNccU
	s0Z7o4OocK/bsYPAOIk3YS0lAjmHzztglfg82Kib0SldvaZKYNlkF+aPaxyx4j86bA==
X-Gm-Gg: Acq92OGcmrxbLTdFFWhg/zgIFXTy0QujfYMxYknER/Byv5F51xV2fvvoo/2+JoFmKns
	z5pRAwenZCx4LTddliFquM4N4vbgtsVVwBcFPilt4/tLCxPJDACxx5MpMY1NpifENM22Ov+WmeO
	+0CMpH9EzPwwTuaf1suzxQn5zjgeRXBJMiC4S2u/6CtmyV96r5q9x0QkjWmGQP2KMJ2AFl1t919
	Exun8BSkNHffCeGJNQgXOVtXC1JfuAzUnEfQ02t/L4Rn6qiqOHz7EQ9jxltbETsDxRVlCyaaNCY
	f43iPR3lug0UHdv0F6XTsUxiNexU7aAfzrzYcH+9O6B9T9McXWzVTkGUP6lfwI6eJuAkeOZibV4
	nUA1ii3i/S1eTgdXrtQosRC+mck2DLseBdzD77TPpDIj6qUC24cEQhjL49DDhzdPYS1ueJ3DVfc
	WyNmF9u3FM8WK74fp9/qZR7eMIfQhhVeiB6j1E9B8VIPe+XwphJ6tFYMiCD0j573/VLZZvP3E=
X-Received: by 2002:a17:903:1ad0:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2c2d941bcf3mr118265ad.19.1781105285671;
        Wed, 10 Jun 2026 08:28:05 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa00b3sm237800395ad.32.2026.06.10.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:28:05 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:27:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Matt Evans <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>,
	Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <aimCfaCM-m4TS2g9@google.com>
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
 <20260527150946.312b3042@nvidia.com>
 <20260529230553.GE3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529230553.GE3195266@nvidia.com>

On Fri, May 29, 2026 at 08:05:53PM -0300, Jason Gunthorpe wrote:
> On Wed, May 27, 2026 at 03:09:46PM -0600, Alex Williamson wrote:
> > This deserves a /* CONFIG_PCI_P2PDMA */ reference like the previous
> > long span, though potentially a better solution would be to split the
> > core code out to a separate file with shared header.  I asked opus to
> > see what this would look like and it generated the patch below
> > (unverified, compile tested only).  Bigger diff, harder to follow
> > blame, but the shape of the core is much more apparent.  You're welcome
> > to take or leave it.
> 
> I think it is a good idea, it will make it easier to add more stuff to
> these different aspects.
> 
> Really they are now two different things with one layered on top of
> the other.
> 

A little late to this party. I agree with this split per status quo.
Although, one observation from me, I've posted a concurrent RFC [1] that
implements ZONE_DEVICE P2P registration for VFIO. That work relies on
pci_p2pdma_add_resource(), which requires ZONE_DEVICE and the full
CONFIG_PCI_P2PDMA stack rather than just the CORE part.

I guess I can be careful to guard the ZONE_DEVICE P2P registration 
feature in VFIO with the full PCI_P2PDMA config. Apart from that, this
split provides a clean foundation for both series to coexist.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260610151853.3608948-1-praan@google.com/
