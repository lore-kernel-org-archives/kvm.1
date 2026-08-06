Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD0438AC75
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045667; cv=none; b=JR52CyAuLlWSqm+WIxIPDA7ZcKYq8sZ5RnwOEcCua1dn00iZIOZMujDj9bNSmL7gcr75XyX94wcKlqTyDF6UTz7MmyrIf7MorEh8eOZ7FKbtQQPPNIR5hwPYhGmr4adola52Svl5QTFnmvO2J9L0zDY3hAxZtTZokWI7ubxSk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045667; c=relaxed/simple;
	bh=a9GePtSgIas837wyg13CpFZrQH6LYH/QdAFKmNODC/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMwUWiWwnSDCx8AuBcSD+gU3Ncao1npoOQXM+1QI+x3E4CY8udAlzad9zCXx9hBtw8kqVu6416HNf/ODxg/AasVXc4+4KJyXCh2+lZ4KJEWgNvcex0eJABB/THwzMJZyIcPxxISGv+Vc88FSHX1MvAOymFcGO82Z6A+5YOHxo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dc/0PQQx; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dc/0PQQx"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e53581361so148485485a.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786045661; x=1786650461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i4zn10CTEB0hgDoZsByJF29MpPwaAKvjrTCMgqoaY6Y=;
        b=dc/0PQQxJm5jidQF/9G4/cMRNCKdH/Qw5lYByTQju24kLACqVICtk+qqxOiSAswMOz
         g0NP7REBbpbSyMCAQdMGBbxaPQwP5cUksdNuRawOpVCCU/RGAbrCobfJDdUD7q+GGnID
         y/4YPrKqfG5K0EyztVZqgIlq8tlg6x4SJTibeOTktQyIIdlQi3ekOD9dZb9I5CTErs19
         TolAodeGPGvyqJ3hu1M2aOTYWWXT1Z9omDbaW9eYRKvO7Cc3CvF3tKxIYvVE36VXeAha
         7FBuNLaph5PN3WZXUHprMM/BFm8QEqrsG+vIy3Vl4nzlfH/SFBH+iubKHPH1BOnuyEH1
         RX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045661; x=1786650461;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4zn10CTEB0hgDoZsByJF29MpPwaAKvjrTCMgqoaY6Y=;
        b=mEl5X7w3RdslJU1SF23qvF7L6uqt69Ud1gVfVc+yhNwQYY6w5vErcWTDEHaT31hyG8
         US3xj1ck+u5Tvw8T4Y2h/iV4zeoBmkm3AfT2rr0wgYpSVWXjENRLNG30SaYy13n3Dbs6
         YRjoRGVNei9Szk507QqwXP+n5QYGr8hWoxfKOjuGRp9rGViI82Qg4ek5DvHuftBCd9rV
         sbnFcCZcLSc6FySKU+kyFsxA7qcVa0I3JcTVBERc9F4xBWZ3cb/HmEV496Mo3ltij8MQ
         F6tKMZWgaHJQm20xasvHXTaZIScfCfYuDgrjjAiqHFT/+6oD7XgSTENmDhJ00PVLie7w
         fdEw==
X-Forwarded-Encrypted: i=1; AHgh+Rpc6kuH+oMHB3sxqyGZwnr6xpQg505M3mA8Ipxf1gWhq3O3jBivwVpjJKLiMq6cf1b6GCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XV73ax8ECyvzeDjqsQ7ib6Q2xIQu+yhG3l9M+RD90BG9/ECH
	HhZf15LNXdTSB2W6M61BokZGIzE0bIJEoDp4CV+13HbIX+lr1Is1W1qcWK5I77XR4L4=
X-Gm-Gg: AR+sD10A2fOR6dEnvYNQ9a3BwLLels1chK3sZabTivemZOnItDQemdI4ZZG17v5fszu
	Xi4+X5QRDAvGL6JvyABl4ZwCGjakYZ4SKhtbTuudNSTHa4gv25fh4hme1HS8kttD2rbSFTYYZ8q
	oD1rYZpy3f9tngztrnezp3kSjag+J51VbMZLQc+EAyJvbzsiL7fhXx00wvLEgRouX7/PpMPG5zI
	/aq3o4rXBES/Oufk3BDX4+VBr3FnyLJTExT0GCVz6/gaQy9xXw6yUdiYI9TW+a0I1YiEaGa6MGB
	TcCHhjXVjghsK3hP5RdRA3fBphQvD9iBWTeJgonat+5+AeSUB/Q8UvWD6aGPSASz2MD+u8PH3ZL
	ZE7JNgERky4H5hVqd4JAq6qdUkCTe1flqTxxedphytpNhxRnLygrHtAXsd7qw2cjWr2bmuf0mvZ
	aubQNgY2a0qFl6893e9IvN4jqGs7E3EbGzKgEbDg==
X-Received: by 2002:a05:620a:a915:b0:92e:5f90:c0de with SMTP id af79cd13be357-936490c7c2amr1707105185a.22.1786045661363;
        Thu, 06 Aug 2026 12:47:41 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93657e1afefsm333826785a.30.2026.08.06.12.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:47:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ws443-00000000hmj-3UT1;
	Thu, 06 Aug 2026 16:47:39 -0300
Date: Thu, 6 Aug 2026 16:47:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, bhelgaas@google.com,
	Kevin Tian <kevin.tian@intel.com>,
	Leon Romanovsky <leon@kernel.org>, dmatlack@google.com,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] vfio/pci: Disable sriov on PF device close
Message-ID: <20260806194739.GH28508@ziepe.ca>
References: <20260805003355.728299-1-skhawaja@google.com>
 <20260805003355.728299-2-skhawaja@google.com>
 <20260805090323.01b1a36f@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805090323.01b1a36f@shazbot.org>

On Wed, Aug 05, 2026 at 09:03:23AM -0600, Alex Williamson wrote:
> On Wed,  5 Aug 2026 00:33:55 +0000
> Samiullah Khawaja <skhawaja@google.com> wrote:
> 
> > When userspace closes a VFIO device file descriptor, the vfio driver
> > performs a hardware reset on the PCIe device to ensure it is returned to
> > a clean state. However, if the closed device is an SR-IOV Physical
> > Function (PF), it may have instantiated Virtual Functions (VFs) that are
> > actively bound to host kernel drivers (or other vfio instances).
> 
> Wait, what?  We actively try to prevent VFs from a vfio-pci owned PF
> from being bound to host drivers other than vfio-pci.  You need to
> overwrite the imposed driver_override to make this happen and you're in
> a very precarious security model to have the VF owned by a trusted
> in-kernel driver while the PF is owned by userspace.

Maybe, it really depends on the device. I can easially see someone
using a device where this would be safe. mlx5 for instance is pretty
OK.

So I don't really mind someone doing this, we should block it and warn
it and so on, but like noiommu and the other vfio insecure modes, why
not give an opt in?

> It's possible there are gaps that closing the PF can interrupt the VFs
> and we need to defer a reset until the VFs are closed, 

Oh definately, when running in a SRIOV mode it is really problematic
for the PF to reset while there are any active VFs. The PF controls a
number of shared items (MMIO, ATS, etc) and when it blips everyone is
at risk of unexpected fairly catastrophic system crashing errors
related to the shared items going away.

So resetting the PF device unconditionally when vfio closes is
definately wrong in principal. I can see it maybe working for simple
systems, especially ones that don't MCE..

I don't think we can skip the PF reset on close because of dev_set
reasons and leave a rouge device for the next user, so the thing looks
somewhat troubled?

Adding the sriov disable here at least makes it defensibly safe, that
we do still clear the PF on close, and we don't take risks that the
active VFs will crash the system during the FLR blip.

Though I understand it was not the original intention, I feel we have
ended up in a strange place with the SRIOV PF feature ..

Jason
