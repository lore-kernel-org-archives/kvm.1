Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045533BADB1
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283078; cv=none; b=nPRklvg+Y+bYdzr4qPjVyuwd6eTNsYCmmnOKJIhdikqt7SN4AzriRTqJcW67gkR/ejbq2wKvdOteZPKg2Mq1k8GudqYZsWX9/uWmNtSzUjs+XwjIeM0oM208s+XymiLY2YL/DnWvH6FeRt/qSTa88wzqpv+CyTAZz3yA2d7Iki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283078; c=relaxed/simple;
	bh=0yKI8vbPNzHoqkTV0yKxdFRxvj0/LpVoQRkkpisgLuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNIHkFm3akH403oQr0rMGH08Ki9HXGRqD/OrPpvmG5Pek9k7lAHXsT7jmpXgJqVYJ/GehPYHEuRC6gzN5/uvJc2m91a8BNIdVvIFeE0DMoiZm+gG/l7O1pYXgdaSG+sl0a30kFFb2Ab/FqHPSdJnugkwesrUbTKTX8TnyusfT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzc+JQI0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzc+JQI0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b052562254so202885ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774283076; x=1774887876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3ldqgT6JBnPQmHk8LHvu61BhVbR2PK1lqFwCMwVUO4=;
        b=mzc+JQI0oGSnURDyym4xfap8mtE6ouKPURs/FGmnKu/W8Tdu4gy+c04GEXyaVvqeAm
         tRl4p0JdfbxwPJECB7XsjTq7sIjiwnM9A5jbqKU9Cy8cWq+V2Ny+I9E5vMicIUIAiEb+
         cNaCsUoqNlPoi7M6v9bq2DlMUyAreflLomrb9DIlU1edapCB2YlzlHDKRiGDBuN0egoL
         MVEyAakmxV+0MgNsKJGA03V1mACwWfak1Bn4w1v03hicrk3jTNFoWTTJpa/xUDWaE9L9
         LsZw5lArM3ul4cf07fYZT1+remU6C1r68IjX+Wv63Chzy2P79/4sZ9oRo+xRdHGiKEyQ
         T66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774283076; x=1774887876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3ldqgT6JBnPQmHk8LHvu61BhVbR2PK1lqFwCMwVUO4=;
        b=AizSjsXmY/FymVURiqWQMUrd106xhNsdX5Pk39n/ocR+82AKYQ5P0PJwVkNchr2vLW
         wrq1w2J4uJzuXUEuWR/9LkzcHwwTKoVMMGunGNhkoTD7uYN8W5skRhsgsPftU8Jsug8a
         21zR5Z65kWqGJHlV9Dj0qw7l60uhsUT5auI/cbtIgBQmPdsZnpXN+uVOtD3B0z+ZWk7q
         5xR3VUk4sHHOgCjj/KHGODKb3XaaY+dpyFPwZPciRWOYrGe+yW97m2UPVvfWr+s2ZF+A
         BvsxF0RjhuE+Rh5WsiK04dWMaAEf8Q1RM1bieXp+k+HsEnVT5M0r2Eo5OVFNeK59FSnK
         V48g==
X-Forwarded-Encrypted: i=1; AJvYcCVkwZznNO0gxTYdxjHPtBMhfS8OB8Qv059s7PwY9sjO2LijuUFPYbyFIp3rjdmg9dbnXwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Uc8LWOy4vnelUuLHQIY2sgFtQUr7c++W7wGontWJgyksg7mT
	4u+LZJP08sNoVefZL+dT5DHclLw/PPr3meDygAfNjipHz6PCHKBrkFJRNa6mm4oc4w==
X-Gm-Gg: ATEYQzxVd6mg97jjslOpV+4kQ74k4yJwCklIDfH1iSzlSbQF+BphFC6wx1FhrzjnU23
	0ynToHgofU5/UCwwWvLNUucgNmHPJrGLCuxJt+as6YiqsGYvjMBauxNOeYz+Xt+9Q94GkEHKskc
	h217bEq/1PpoDDjbkd3d+MDEUDRZtxw637zg5nyKYG8mWXNsHSZtU8qfdqGrCPM5VEGpukjp7/2
	40hbTiolQheKR/MfNtn/MilVGXu6lpbZTwTD9Xtu1kZyjuzTDYhc6UBam3d1TAEDRWNMIfsCfQc
	Hqm4ct9dEauzA2ywsUmWYQimk3vKRty5hHj4nPbRWY+I99gjhSTbSmkXIwv9g7nm9VwYt2FaSwu
	gFcbR/2/+PW6G0K5aLbyFg4gqoi2G9CqsdwbOIxoU7w5jnxoE9icrCS+YYt05NvADjgIeifTaUE
	/WwRGGNuaHSn9KVaj17vkvUO2cyl8Bw2Z9K883kEnBB8lQSctRjf0EOgE8wR9ZiA==
X-Received: by 2002:a17:902:fc4b:b0:2ae:4e8e:954e with SMTP id d9443c01a7336-2b08c423bcdmr4886495ad.5.1774283075771;
        Mon, 23 Mar 2026 09:24:35 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff704bsm13278934a91.2.2026.03.23.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:24:35 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:24:30 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark
 an HWPT to be preserved
Message-ID: <acFooviUrdnfudV6@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
 <20260319231331.GB3983821.vipinsh@google.com>
 <abyU3g-ta6Gg6kEx@google.com>
 <20260320232634.GC659132.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260320232634.GC659132.vipinsh@google.com>

On Fri, Mar 20, 2026 at 04:34:41PM -0700, Vipin Sharma wrote:
>On Fri, Mar 20, 2026 at 12:40:44AM +0000, Samiullah Khawaja wrote:
>> On Thu, Mar 19, 2026 at 04:35:32PM -0700, Vipin Sharma wrote:
>> > On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
>> > > From: YiFei Zhu <zhuyifei@google.com>
>> > > @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>> > >  	bool auto_domain : 1;
>> > >  	bool enforce_cache_coherency : 1;
>> > >  	bool nest_parent : 1;
>> > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> > > +	bool lu_preserve : 1;
>> > > +	u32 lu_token;
>> >
>> > Should we use full name i.e. liveupdate here and other places in this
>> > series?
>>
>> I think using full name liveupdate would be too long in other places in
>> this series. And also there are other examples of "luo" being used as a
>> short form. Please see:
>>
>> https://lore.kernel.org/all/20251125165850.3389713-15-pasha.tatashin@soleen.com/
>
>That patch is using "luo" short, which I think is also wrong in saying
>memfd_luo, as there is nothing related to orchestrator (O of LUO) in
>that patch. It is saving memfd state for liveupdate. But that ship has
>sailed.

Yes, I think that makes sense.
>
>In the current patch, I don't think it will be too long, and it also
>easier to read code without someone to know what "lu" is. We have worked
>on it so we know what "lu" stands for and kind of accepted it but I
>agree what Greg k-h was also suggesting.

Agreed, in this patch it won't be too long. I think for the public API
being used in other subsystems we can use "liveupdate", but internally
we can use lu. I will rework this.
>
>https://lore.kernel.org/all/2025093023-frantic-sediment-9849@gregkh/
> - "You have more letters, please use them.  "lu" is too short."
>
>Not a hard no from me, just a suggestion.

Thanks,
Sami
