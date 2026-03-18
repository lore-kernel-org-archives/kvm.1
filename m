Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1864291C10
	for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856167; cv=none; b=kOGhxsuVS/1dEXRRtHdz+QL64Qh9ruKiiSLPC0sLFetVYNZkne7BwOPSqODqRj1l2Sd6dyC38QulAUMDPzY/FYSKvlHFrParQCfz4sF0iz0GCY5EVcbnpCouSDsDNXy3NEXpwfrdevsHtl/wUB9ZIgFptY7xT+ZtjZkipHVkark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856167; c=relaxed/simple;
	bh=Y2/o/ebxsdPQbPCrZDWTV82JL/XtU45w5Gvly4ZT4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyAiSC2xWLqaGKbm2pC7cRs/K3jZ9v9A/pYKXTKMT+9/kQxdTpNwFe06HjunCIjmOo/Vs0x6ztDBeV8YD8uG4tdXy2gJUZvz/NIeD9yMQMCXTcjaW72gKWA2FTPxPcE/sh+0tagGCF9CNP6MWsh8axbsJM156jShY4PDi2kiIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xnz98Nui; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xnz98Nui"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b052562254so7975ad.0
        for <kvm@vger.kernel.org>; Wed, 18 Mar 2026 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773856165; x=1774460965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2/o/ebxsdPQbPCrZDWTV82JL/XtU45w5Gvly4ZT4qk=;
        b=Xnz98NuiMHg/pmlDDcEM8Bw+P6M2Wb1pTyk2leV7ytvTOE/hd4kac2zJGA5TM2NTLo
         QAYzaS4hhwo3WUr30EERqA9U7W7AVimarqr66EThps6b7cvkXTvi6o2uKwYPNo4fQdPc
         2ovdtQSzO/jPciiIhDzO/rmUFbQBMWrfwF3JOuhCuXx/VB4IvA+NnDWXsDqgbXIi4YJB
         Nup6lyK1cJpoWFAh0odagm+D8Abvg8DyEMwfausFDGkF8CzNmwYsmFxG+YMZ81Hv44xS
         dMR7/wAmEBHbfFI8rlLRWNucwJoG8T/QjkZkImK3dZt9XncdL5lBZMhv8rtlHrezqBm2
         nrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856165; x=1774460965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2/o/ebxsdPQbPCrZDWTV82JL/XtU45w5Gvly4ZT4qk=;
        b=ixCJrlrJg8STBUW0KHR+7/Jm1CtLup0v9n9pZF7sotD57/cRyYgcFXmeZsYjUqdNIe
         qx6UD/JQAmHLxXLWoHOQuuZxY4ZvSwcu9040JdUJRHLEO1k/9KZ98Ve9OFo9UZD4IaWp
         +m6vT56fzHav5LZwTaCUgUWPH8S674m1IFf7BBiMfR/wdBZxpUnem+HpQvT9h2t5puzS
         BjO0ljc/4UqpX8QIxuo8s4MhtE58rbhfmi9/rXZIndtpg7z77QJ6gzmQuYwCISF8xIhk
         zoTAeE8gQ5POQwyfbmINm6H9Yc7GQmaY96XFJnKb7f0wjwiV10V22kKM2i7K3xUhs/Q7
         5KKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTCALLdjrHp28zsfBdknvzpikZXxYBtRkKOQjaLGpMPCIxninzrDv3Fj6JacmzlPZ1G9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ONnHEQ3B5sNUqTB0jk3oCyTWpIMP8FUj8NFtimG8v6VT6IPI
	Hju8IBSRTsTBEPGgNC1g6FHbInj0L1hFFIMGj4e0wsoEmZJxt1WiZhTNVHns/9+naQ==
X-Gm-Gg: ATEYQzwTfYfL3otM85uB+lvqWRZ1oC21PAWFT9sIw//tMvrnN/fMm83ySSYgR4YZ7nE
	ykrY/zj9ejzus9Yqai47lmMm9YyggXLHuVMne1wWuRkhlaNfUptBWg5x+ACp4tr7NoAiaMOSyuj
	2gmVVf8BpxVHYixHyQR//M/c5DVF7WasJwMEbQkiVB97MCRqowIRS0i1EZlJh9r7qOFvWKC78rE
	6v+hjVify8MNKmMBUYxBQlRxkRXDEa8srLo5YmWrzVeGbFeOye0os0Ff5R7P2c789oUVW9AmhXY
	o6QM8xhS6HCJ2ZvZ/rIf3b6LozcxUDmXUWEtVHFuRE6s0+rHAaQNbgcMDdhBVyVQRWvikbsV7K1
	W6EJ1ZF624Lkfy8mmnZGmh3cq4yd7tEnlMjHoWygIabs5FKuhL1xhaeNoX66gZGyh5lzFPG4m7U
	AEr8Y/qxmVXACw/mwsLPTyMgWem9/+oY/kUzr6KHufcl4KusxKfE9vaQrdn+MknA==
X-Received: by 2002:a17:902:f544:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2b077df8c89mr179905ad.20.1773856164572;
        Wed, 18 Mar 2026 10:49:24 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe6162sm3180791b3a.42.2026.03.18.10.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:49:23 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:49:20 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <abrk39_M8k45myXJ@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <abNH7LAj9thuGOoG@google.com>
 <abROLLfSUK8pXM5J@google.com>
 <abm09vCaAMtiQPVs@google.com>
 <abm1esL1dzN7NTC7@google.com>
 <abm4ShqPTxIujDlt@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abm4ShqPTxIujDlt@google.com>

On Tue, Mar 17, 2026 at 08:23:38PM +0000, Pranjal Shrivastava wrote:
>On Tue, Mar 17, 2026 at 08:13:47PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 17, 2026 at 08:09:26PM +0000, Pranjal Shrivastava wrote:
>> > On Fri, Mar 13, 2026 at 06:42:05PM +0000, Samiullah Khawaja wrote:
>> > > On Thu, Mar 12, 2026 at 11:10:36PM +0000, Pranjal Shrivastava wrote:
>> > > > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
>> > > > > +EXPORT_SYMBOL(iommu_get_preserved_data);
>> > > > > +
>> >
>> > Also, I don't see these helpers being used anywhere in this series yet?
>> > Should we add them with the phase-2 series? When we actually "Restore"
>> > the domain?
>>
>> Phase 1 does restore the iommu and domains during boot. But the
>> iommufd/hwpt state is not restored or re-associated with the restored
>> domains.
>>
>> These helpers are used to fetch the preserved state during boot.
>>
>> Thanks,
>> Sami
>
>I see these are used in PATCH 8, should we introduce these helpers in
>PATCH 8 where we actually use them? As we introduce iommu_restore_domain
>in PATCH 8?

Agreed. I will move the helper for getting the device state into PATCH
8. But the one that is used to fetch the iommu state is used by the vt-d
driver in the PATCH 7. I will add a new patch before PATCH 7 to add that
helper.

Thanks,
Sami
>
>Thanks,
>Praan
>
