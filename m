Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F741DEDF
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747451; cv=none; b=uM9KhAyFBonrLEKTm9itvm3B9YQch2tx1z2IuQjK/Q7Tdfw1yDdT+t2QvpR/NUQVrVoR5DueJcCGBaOwb+mSDLDMxk+EZxY9Wt1BHwm2s4K4MkJkdmfGVVdawYCGHSw7UP7f4Wq9Uzw52sfs6TAYX0UQUAoL8wuRFZKyfVtIr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747451; c=relaxed/simple;
	bh=8dVVSO4XdHCx4KOZSduD/f39KYIfwpqzYrSSt2RuZ4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myTI17oBvh0fZxbxBnrb4aokF4nDV8NLkF1pv9oIZxVHVSnFHOETGUpP0akFizeLvZWD4JSZa5/CqnCeqa4lj4+jeQZu0GoRCJRmMFoEk0w7WwWzaqpuzwiJhITEjlo3dupNlMErwcm5qPLTGBZpPasoaQLMhdF5FDiFBkGVY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5zl/SXc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5zl/SXc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d3b445a84fso88475ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787747449; x=1788352249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtDyfAId4c9pmXSo6AkYFWKqGY/dpqg4gomEyUaZ1rc=;
        b=P5zl/SXcD8sz+TC4+hyuwZkqaZPHNXvywNGiQevr461CMvJNkvqiM7hrcaqs2G3gve
         XAHjRZiNo9XhOiIbDbhtU0OcSHa2HAOIC4Vsmpa5Vy0dxB2C1LrK96yLPgwHzIb2id/5
         W+3d2EzQ6cIhg/I9ZLzxXb+jutIfQbHBUNAZwboqtgNxkE4s6qEQWz98RkdFhormfg9z
         QIHP/+0Sjhk6iJKJXOrSEk0XCfu7C2yw/jL3L8uZHWR0MVJozxfj8gJLSHV7HtV3eT/t
         E15xeyzDIHD41GALpjxUOY3BHkBslYo5TLgZO0RanQEKYe47kjNwW8pElk05X5e1YgOr
         dqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747449; x=1788352249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtDyfAId4c9pmXSo6AkYFWKqGY/dpqg4gomEyUaZ1rc=;
        b=X6caoEq4L5SYUs+oPK3WQ13aKWaX7Q5gvLsMhgaGN4eX2yNI49e5PhrBwUZ+T1/ZdU
         tAM6qjjVy2c0dEu9zaOtd868t9ItlcH4ghh0+JnFYNTE24rFC0V0F+an+A0v4dbfdgHL
         35KyV+OGU4I3ZIWNlydhhHYnsV78m3ju+0hWx8sNvDh2X6Ef9OYXyfm0yHcoAuGCtMgg
         rProq9b92tWNoToz1tO4qg7DHZtE6EHrxA69GeKdbg3/966yE6LOXo+SuRp0peInzZJL
         82wiDXgLLtl//cU091wtXPXMWHAnTSQT2vhu7uWGsF2iJL0jtwVMJc/8ZaqtBcEj609U
         /yfw==
X-Forwarded-Encrypted: i=1; AHgh+Rpa0ex/X4s7j2iSSMMhOYjbyAP/jJ0BxqhhWmb7TTp3HfhljviUnZGmad6KDhyPKtla6Pc=@vger.kernel.org
X-Gm-Message-State: AFuF++kJsNDEMsgVJFMSRroqzahJOPH0MY4Kp/VQkpyEXR803oLKqHZx
	IbhF/Z5CwneY6VYXg7k6ie33uE2jDvQc5VxeHIwoNDkhgX7BV95r+Q6MdHxdZhGHdQ==
X-Gm-Gg: AR+sD12qXoeZ4vixuZ3i/OBvgDcAEqULfNDp6pIpbS+sPjONYEhRmBOFvDmlObJZ6IK
	MkAJuWkyZjOjpUWCWe+ZzPnsQ0qobLjIwj2dYhsL4NNXxAGb3xjvpn6Cmd6cuR2YhoaNBDbSwWh
	X/GbwBZ5NOUgR9VKXvPP+tASZSwTX7be5IGyWe/BqOvOkJAb761qPYaSVvy00350cTx7bUV6x6Q
	iGrSrkjPqpb8o2NN6ZvMufqFFifZJ5/MgClkaWFYbjWV97LBRv7wRVFmLfQl3xYABO3M7C5v/d4
	0j6v2J9NpSzKRg9Uu6ZYTZDJYR7Y8E063+E8Wy3yQ9lWWx6DDj84PlFj/wLeJXVkLu0mw9jhIj1
	J+w5QOXej8vOMlJJ5cU6BKqZeKN3k+bsQWspEIogECT04XgNqqEjEdm+d/3wXecPJ1LtOO/2rg7
	SIEmIrNyOhXbpm3rudecuPsR6ohuQ0cdq5XqCwJRLAy6FLs/CwslBDZHYc9eymcSY4NxByl9ozf
	fD7D2XtelWsvuCKKRgKVGhB5g==
X-Received: by 2002:a17:903:22cc:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2d70baa90a8mr5053075ad.2.1787747448020;
        Wed, 26 Aug 2026 05:30:48 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b07394sm7933816a91.4.2026.08.26.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:30:47 -0700 (PDT)
Date: Wed, 26 Aug 2026 12:30:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <ao7ccBlV9_RXT6Fe@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
 <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>

On Wed, Aug 26, 2026 at 04:05:51PM +0800, Baolu Lu wrote:
> On 8/8/26 10:27, Samiullah Khawaja wrote:
> > During normal shutdown the iommu translation is disabled. Since the root
> > table is preserved during live update, it needs to be cleaned up and the
> > context entries of the unpreserved devices and root entries for the
> > unpreserved context tables need to be cleared.
> 
> The key assumption here seems to be that, during a live-update kexec,
> most devices do not go through the normal iommu release path. Otherwise,
> their context entries should already be torn down in the
> iommu_release_device path.
> 
> Could you please confirm this assumption and add some short note in the
> comments or commit message?
> 

Yes, that's correct

During the normal shutdown paths (i.e power-off, normal reboot, & kexec),
the kernel only calls device_shutdown(). This path bypasses driver 
unbinding, as a result, devres_release_all() and iommu_release_device()
are never called. Those devres teardown paths are only triggered when a
driver is explicitly unloaded / device is unplugged.

Since live-update piggybacks on the kexec/shutdown path the unpreserved
devices never have their context entries naturally torn down by the core
driver's devres model, necessitating this explicit cleanup.

I think we can add a line in the commit msg for this because comments
might create confusion if similar comments don't exist in other drivers
performing Live Update. What do you think, Sami?

Thanks,
Praan
