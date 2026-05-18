Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B7313272
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116924; cv=none; b=U6mfEDqmgXke1u9bugSMm5oC4n/uy9GqI05ZGilp8iyEwFTcYqVyvngvhXLAs/Ol8MDHl2/9oWl7IHdEi0568KVgEqJiytEc65Oj4gDtBN9gwyZfpxXIip9noA9ZGf4D0I8GCBs6C+VTeHYbt9EwljvuUQxYJxu9EWC3izMxs90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116924; c=relaxed/simple;
	bh=nvP7U/Dl/xIbO6Hrcjf9FGeD1/9FM39srDJUAU6VEUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctwe98k2wQLdmTD4wd9330O4LrXml3oDgd1QVquyPBTMsOiz0/Pi8+AALqjqtk0wYFW+it4e7D9zIcP81tu+wH83I3kN9tLhrJFA7AyhKOmjxDPV87r+YFweP+ktDACAQBaEW04PEJYRt0CDSR346GVAZvVlL8Lxk3MHDybTnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDchZvvS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDchZvvS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b46da8c48eso2785ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779116922; x=1779721722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPcZ0QcVqHJUaR115s6MSWN7sWOXwruE9IKTdy4RibY=;
        b=EDchZvvS1DjXu7qFBQwph6XSresNopLO5DynjlhjtiRN6OrtNSjgZ7adWmPkbfuJCG
         CJutLJtLnRO638ZZbAzDwgZ9rHFuPOsgnymEp13HEKgWk/lS7PLxOUtHsSoL+9jwzNL/
         9yAANZrEbRk1ZUmGRxxBLPGhMakbDzwn7KBiPxj/TLNjIKrI8c6nYs4e+41rxCoyU9qj
         eiK8ANhuqOfooylvIBc9Rniph463kwoCS6I5SjhcJ14ZBTw0Urd90+RQEYpq+V11uD+a
         TmeSsFY5mNaP7FW4TfuthHt1rFVOKqTNO/KwGRIEsvdh/cI+jFxfNXlgMNGYarVqr3WM
         gVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116922; x=1779721722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPcZ0QcVqHJUaR115s6MSWN7sWOXwruE9IKTdy4RibY=;
        b=GDSqymkUredlIAL8sPiIuZOTCcuQXoTBk7rVwJOrmJEUcFHg1n+FAaDyONInofAUjM
         O5jmCQcuxR79cz/gVXu3gqWsBI3vvTDAYsi9gNXxEQ5xntWiTifmiTSE5VYey9oeykgc
         +/5+cb+n0nrVB6FlAtOWeRjLmFV3gPLy5GdZFF4RtQyIMaM48/2wzliCVZikx69ftCO0
         5OoF1L+ZypgZVFzV5McLEpoiupdS5S2azCDy1jOU3PZkLfz1aTeCxeuQqbEhhy9bNBPU
         GFOTM1vlpuEGCusFue4kQT6idMI2t5kuzJdjiVfF1FauqXjhJHZvYAHqwBu4kCNEzoUh
         85Jw==
X-Forwarded-Encrypted: i=1; AFNElJ+hyt+jjdaYq83g7xIaWb+6j6arVL/XxUgW9d0cpdJcyvEPHCC7N2zPyWkmYqM36BQeRnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EETS4ArDmaufjPoAl2ACrwAaUFJN3TjU+3iy+iZgWBF3RtfU
	a+U3PDGYTX+5F30nS74lLJIBCP/nmVEMzV/vAo+5/uTRkHLFlZ6shBEvLDDwJb7EEA==
X-Gm-Gg: Acq92OErKAFabFM/YcxfTwcf0aSih6rx6IFaEPlU2MJGCGI8vslJQm2sKZ+jSDBVkU1
	XPomYVO7biPZRIy7luRBiJK+ENK4GjMY2YT2OOfVrK3Ru79G5ezIv59ARovCjXz6pCEIQ5KpW3W
	RmH0sRiW1+9SkTrzWXrp8rNOv8FnAfnRnjMgEvONKAiVKUUPqJnw595f0OgbbfhmMUPod0P+24F
	qp+HMheAqvutHU0JHrJ/IsqYksCUXOxNao4TqfjMpRmnlak/prG+0E44a4XqSB4JPLpTJ5Dz01U
	ZxJRwzln5Tfu9KAUwbMm/pmi2+zD5sLhtonIQiNAb3Tb5IAsIvO56u0dNOYKvg3nx3VnOLPjC9F
	sjgO73PWq3YRUFWEcukYN1Rt/TjYUl7w/kFFgU8ByHn5KzEsBKFIsIcsOU5O/Jw8PUi0Du0OAEu
	HQm2YwxZRTfDW8Xesd85jnYvSuTL7VHOjuN3oiTmSwN+LT+ATKUgepnyNI6k29eb8fGHVO
X-Received: by 2002:a17:902:d58b:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2bdb36d252amr2864685ad.25.1779116921506;
        Mon, 18 May 2026 08:08:41 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c264241sm150322355ad.36.2026.05.18.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:08:40 -0700 (PDT)
Date: Mon, 18 May 2026 15:08:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <agsrcKxL53PxFeu2@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
 <agr9ggdY3GYltteV@google.com>
 <2vxz8q9gajwm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz8q9gajwm.fsf@kernel.org>

On Mon, May 18, 2026 at 04:10:01PM +0200, Pratyush Yadav wrote:
> On Mon, May 18 2026, Pranjal Shrivastava wrote:
> 
> > On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
> >
> > [...]
> >
> >> > +
> >> > +/**
> >> > + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
> >> > + * @ref_count: Reference count for the object
> >> > + * @deleted: Flag indicating if the object is deleted
> >> > + * @incoming: Flag indicating if the object was preserved in previous kernel
> >> > + */
> >> > +struct iommu_hdr_ser {
> >> > +	u32 ref_count;
> >> > +	u32 deleted:1;
> >> > +	u32 incoming:1;
> >> 
> >> Are C bitfields safe to use in Live Update ABI?
> >> 
> >
> > AFAIU, they aren't. The C standard does not dictate how bitfields are
> > packed into their underlying types (e.g., whether they are packed MSB to
> > LSB or vice-versa), making them highly dependent on the compiler and arch
> > endianness.
> 
> I had the same question and Jason told me otherwise:
> https://lore.kernel.org/linux-mm/20250909155044.GN789684@nvidia.com/
> 
> I took him at his word and didn't really look much deeper. I use them
> for memfd preservation as well. See struct memfd_luo_folio_ser in
> include/linux/kho/abi/memfd.h.

Ah I see.. I guess I agree if x86 has it.. Arm should too.. I'll try to
check this.

Thanks
Praan
