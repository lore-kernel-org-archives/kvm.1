Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434127F72C
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570545; cv=none; b=F5UgtkQY2W3EmYyfk4yl3whq6dXIjiTC+7Mw/CMbcLfggvlM6oaeeHdFKTOyntfmy6NwK0VVdT/tE5oeMiVVBXAQPWvsrSpl1eBcWEvx/5Kjc4T5iEoy8lwZFPu/NyUJDObjbo6huzpNNjJsj/qBUciQs3SuRRZ5aZXbZVicbnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570545; c=relaxed/simple;
	bh=dLd2xq2uaf3rRXOHvRSNS0csxsbcSNNyU4+pJRavd9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYTgPLxl25RYv/2b9ZCNkPhLB3ABnIpYbNRxA7xq/wv6BigeiEuP6OIEI/PcPlSxxypSJ+Wwon/dLuM00jfE6YntgVv7d17SyDC8x6Cj/G0YcOa15VqHpfd7XqwugQxZ3lNcJBCcKRh/oAT6iEjuCxhttelLfvAciCSpTJ46fR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syowSQf8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syowSQf8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf22c18ad3so25255ad.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781570543; x=1782175343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLd2xq2uaf3rRXOHvRSNS0csxsbcSNNyU4+pJRavd9E=;
        b=syowSQf8wLSWGtS1PgGodgassz1O0d3yWQC/H8bw1NwhJXnr2zJeiuj2E9Ro7P8b6l
         0sKRW0UZFDTu+eESKF29TzoeA+btPajRdmHAwn8Fq68xybv5XIGq84mQ5N/mCzA9iv90
         tqL76uIuG5kg5s11jGw7XA/DJp7SuL2b7rLOnd+J61Tp2e9hVRkxujRfT3N8Z4G5V+iT
         JRdBHxN17iGa6R1QsD9eJ30qxHswfPElKqYT+dbJCj9baxjbVpYy0TVxWpgBH9lXGUre
         FFWVCLGYk9RnLU9bmUm53V0robpx5+adag8sZtrLrwcaCjFlJYvIEQjn9orrqr/AMG8f
         TzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570543; x=1782175343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLd2xq2uaf3rRXOHvRSNS0csxsbcSNNyU4+pJRavd9E=;
        b=WAFXpd4JX1tSUpPbV0ty2lI8ioDqm9SGHxgwtPoL+nePq/zdXLEmZi5ueuBti/gzf/
         YQ2B/nidtFx1rf4ZKlt2whDen8zc95N5eiaRbRgRVyIaOkXmclrjmnfo+jF0g7wcgYs9
         ckxXTxRtfjh8M0G9xaSNRkkSza1/VHVCO4D3Dd+D3QlkSyKrNbH75OKXAXkC9QgPu90n
         moz5SGm35pdNhSrEZbTtEommAiKksYW8Xr4k6+MC4Y8lYG4O1Ki0G1WhYy+ePXuqK9wl
         Ob9V+WzMJYCrZQurQce3Qst0V7IwhgD3qbN1m0LOGUiPkWIs/TGRYAcz/bWBekVD5ga9
         eK0g==
X-Forwarded-Encrypted: i=1; AFNElJ8PhPYebGDpRJBLKHxM/ptAE66ZpqMcvX5TsZ4sca/Hd3BDoVQh/FISVjGb0fMIQhAfEvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEj9hxMstqnnwLa82EKsoHelWiZTwczehJ0AWHXwjii4Yg4qy
	/AnWkgAl8iH5jFtg1F2/vmlWTsvKxu5LXmwAQJNOeDCdNuarzSADe0/LKILIyfUO8w==
X-Gm-Gg: Acq92OFlpi3gwIMB1lFjuYxUN8QYwGe7rFrfed//S1TQcRrnPO8jAA8c+wX9xrI9fsd
	OzNvkVNgF14U+Lo6RdLlccSVpahvqEdDhfeIX6XmEI4ez2b750NuswRFrKIuVS1/4hbMx3308Es
	QJCCVtwon2vlr6y6kjuTjnfXfDzxHoIa17shpltcvzwsgiQxaRrvUKOcSCst4v5rhF8nw0YfZlu
	tYeny/Am7CLwl1HMpaUTEeU5c1Iv4oWyGjjT1HFdl4TGXB9l1HDk9FvHXSMIaa9JTWt+EUuC9e2
	BU5qjRRVDIrkg2Dc9YFjbLXJJ01z1JcDxWwcwJDgeYRj/M5wRuLcpoFkfNiNPos4bg5G+jhv2S+
	/NNY3OUGF2mUTXFK9U4SGAsGHnQirGSkWz1bJZQ+O6EwDQeFC4RbMBA7SrxpJkBAjCz3LDEJD0j
	KYeTMEjCTLfIBHunQU4uRgQ45HzKP27vKpCrMxlXJ9tvY1ERiVddaUKh8XsMLitYJFJgv63b8wE
	ROpItWLwvK2bC1qM3k=
X-Received: by 2002:a17:902:ef02:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2c69c1d4b35mr692755ad.13.1781570542499;
        Mon, 15 Jun 2026 17:42:22 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5e509sm10014682a12.3.2026.06.15.17.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:42:22 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:42:19 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Alex Williamson <alex@shazbot.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <ajCaTmrYQvKDoP_I@google.com>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
 <airI0VIb563jHTcy@google.com>
 <20260611221447.GH1066031@ziepe.ca>
 <aiwcquSgAonkh_6L@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiwcquSgAonkh_6L@google.com>

On Fri, Jun 12, 2026 at 02:50:18PM +0000, Pranjal Shrivastava wrote:
>On Thu, Jun 11, 2026 at 07:14:47PM -0300, Jason Gunthorpe wrote:
>> On Thu, Jun 11, 2026 at 02:40:17PM +0000, Pranjal Shrivastava wrote:
>> > On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
>> > > On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
>> > >

[snip]
>
>Yea, that's going to be tricky.. I'm thinking if we can have a zap model
>there somehow? If the device is gone / going through a reset, we can
>handle the refcounts accordingly?

IIUC zapping will only work if userspace is using these, but if you feed
this memory into another device through NFS and the pages are pinned by
gup (or that device) then the dmabuf move_notify/revoke logic on device
reset will be tricky as now the pages for that device BAR are pinned.
>
>>
>> Come to think of it, since the sysfs API cannot do that in the way
>> VFIO wants I actually think you can't use it..
>
>Ack. Baking this into the VFIO DMABUF allows us to enforce the right
>lifecycle.
>
>My plan for RFC v2 is to add a flag like VFIO_DMA_BUF_FLAG_ZONE_DEVICE
>to struct vfio_device_feature_dma_buf which allows the caller to opt-in
>to ZONE_DEVICE backing specifically for that export.
>
>Does this opt-in flag sound like a reasonable uAPI or do you see any
>concerns with this direction?
>
>Otherwise, as you noted, the lifecycle and the mmap path remain the main
>problems to solve.
>
>Thanks,
>Praan

Sami
