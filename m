Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC88314D1A
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787278862; cv=none; b=SrgSd+KA2xGmuNmy+2Ij7esitHu4fj9xogp1xjhceopYUTDUDnCwJhHH53oHXUb7FX86rwOiBZ/0pM7UjlYf5BADCFgAUuwwS6UUPJnafeRbtUzkhter9htodBo0uAvHVdqfhx9Qou4qxrblmG5CWbsQTbTKPcFpiVwkIpuxDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787278862; c=relaxed/simple;
	bh=ODEamyaNinz8ndZY25u31wy9kg0XuQk5tLuO7i1Q1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5NL9nciIG//gfAiOe9sGNPleaKsd3RPiYoHG9mC2cqYHz12jvANETqJ+3jPds6qzg1n0uFLxlcq5ybddXi1oeeqDBr0Cm8rR4SRr8Ts43P0eJJPA9i7ue8Iud0yB9+8BrwTUY3KynkbBvy9wOqrpdryaINSc95fAQVf1VMZnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnrbBEe2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnrbBEe2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cede6375caso48135ad.0
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787278861; x=1787883661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vTISns22lLz3uE6OmdCyn6vQB2Si1JaLhFBQroGqygQ=;
        b=MnrbBEe2gHTV25ZX4gF0Ym6wkOXP1uUcryATFQ/+9qu9+v3yxiiHVhhujZS9iVhYeG
         h50K5uwjsmqNMP30lUy7sjnNhbPp/mwstvWO4TAsODYUbxHwqvPq/NqOFt1F5IsEFQRK
         2nCj+rtKcO0rsG6U5v2kBeDqPfGDn+9fqBLCtrN6fLphhkTx+/vnWyx/qm7zwfBvzIFK
         Pglp60ZllhKzR8KytEEROBPnmZjqEGYTjoKyZIEN9cQoARqBwAGXmEmSQMVN7M5HAz67
         EMuC2zmW+3odmR74swgDcASAeIgi2m7PKMsBHhNtqWPG5VlsZ2t69pmTjTFO1fhsQ7Fw
         Pbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787278861; x=1787883661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTISns22lLz3uE6OmdCyn6vQB2Si1JaLhFBQroGqygQ=;
        b=E5hxmXJH3VJpAkXHil/ZGQKkC67o6yCU4SoigNmvaC7zNIwZqswUu2r9Cr32+ujzue
         9ie0G+nAX413DMPAnuTR0Ak303Fxr8l6prhM0WmaXo0yDg4YJjhPgPiW5rZa5umMMxr+
         dR1L6csQlHUd0PkMKNiS5UjJn56aCIma/SdVy97buMRTeAjRDc0a9VdvveACzqp83uhT
         z+OwzcIs3/OUm3K9hUKp8GKkUsP60gl1KtrSPw/Ogt8urY8CWy4+ejZxB1qirIrCaKx+
         OuYxf2reAhGOPDj94EWQAWAWL9nXlb0yzEWcjY0Ecke0/mkrZk3ljRgUZMs8W62McXXt
         gPuw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3WqQBdcVXqGwl48MvRpIWJvJRtYPmx+bYciDMT7wlIM76j1cHRUQVJkYSRaXeOFdu4V8=@vger.kernel.org
X-Gm-Message-State: AFuF++ke29xlXzaMrvMIGJdcASgOlweWJHIOljs+FfO177OcjqX/ooli
	WeSNWHY2egVRBtkjZ8Ge083pMEvyebhbUcqUxBR1lUQwN/UA9dOyJo34Y9duTJ8t+k89ITXfioL
	cndaTCQ==
X-Gm-Gg: AR+sD117zC9Faa5E0svFp8VcYQCbtIlsGGmNDFzNcDcrkISbLss7Gz4DEuwAycZs5Ng
	c8ncsG1C1HtIrya5zFUAuAPS0vlzTXNgsULE4EbHFcYzanoW4IZtOQBHkx80QRT6eg5Teci2L5R
	UcaQJkHdSp/uq8rHez9cm92/WwksCoMNxRNvv5X9fljL7ODnjEf4K220+fvPbxKlsghV8zM/0q9
	BkYk9cs/Kzbytdksn+bO0TP+RztACQtevJCgtvPqrLwGi962UeuOSqmDILAuvTC+ModlEjl36r1
	2tCrNt7Or1Sei2KD6hjm2Tk3p5y1aTH0hMX/LSNCvM/lYi6jnz6Hxaz1UEmSSnPLoRrC7GiVxWo
	CBinv6gAtWVt2pe5LtBfdnIrsf9Edv4uXT9nh/kcV8y8Dt2PRcuA1afO28ubeeqgMNSXNRiUKf7
	KZVz0NsewKxKEbiqs6+cineGxyvv/dZoGC1gnzjVjEStpPONsBMGybMNVF6ZEoVv5pRjCzD1Esl
	P4RCdKffnBL+xaPySAMw3RjTw5pADrxc8PL2/mVPwBdu7ktOOgHyuS/qGM=
X-Received: by 2002:a17:902:f552:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2d650dacb5cmr1955855ad.13.1787278860193;
        Thu, 20 Aug 2026 19:21:00 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4b82e5csm1054937a91.16.2026.08.20.19.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:20:59 -0700 (PDT)
Date: Fri, 21 Aug 2026 02:20:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, 
	Alex Williamson <alex.williamson@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, kvm <kvm@vger.kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <aoeffe1v--CgRK0a@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <aod22_H66eUth9av@google.com>
 <20260820233722.GA1110819@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820233722.GA1110819@ziepe.ca>

On Thu, Aug 20, 2026 at 08:37:22PM -0300, Jason Gunthorpe wrote:
>On Thu, Aug 20, 2026 at 10:38:07PM +0000, Samiullah Khawaja wrote:
>
>> > The blocking domain operation looks like it might be simplest to
>> > implement in the IOMMU core.  We can set a flag for a default blocking
>> > domain on the IOMMU group when we take_dma_ownership of the group.  Then
>> > release_dma_ownership picks the blocking rather than default domain.
>> >
>> > This is then unwound in use_default_domain, called via dma_configure,
>> > attaching the device to the default domain in probe of the next driver.
>> > Therefore until probe by another driver, a device used by vfio would
>> > remain in a blocking domain even while unused and unbound.
>>
>> The devices are expected to be attached to the default_domain even when
>> these are unbound and the use_default_domain assumes that, and it only
>> checks the ownership and doesn't switch the domain to default_domain. I
>> guess we should add a WARN in use_default_domain() if that is not true.
>> I will probably send out a patch for that separately.
>>
>> I think we can move the device back to default_domain after reset after
>> unbind, maybe it can be done in pci_dma_cleanup() based on
>> driver_managed_dma?
>
>This blocking domain stuff sounds very similar to what Nicolin
>implemented for the per-function ATS issue?

I see you are talking about this invalidation stuff:

https://lore.kernel.org/all/348c50ab6e95b5ec6d48ee3fa05d529a784a34c3.1765834788.git.nicolinc@nvidia.com/

But this was the case where the device is going to be reset and to
prevent ATS issues, we attach it to blocking domain before doing the
reset. But of course, with the PF reset here, it induces the same kind
of ATS issues on the VFs.

>
>Broadly we must setup a blocking domain in the iommu if ATS is
>available across reset or you get these ATS related issues.
>
>I think at the time he looked at doing SRIOV as well but it was
>tricky..

Hmm... doing that for SRIOV also, by allowing PF reset but attaching the
VFs to blocking domains before the PF is reset, will only resolve the
ATS issues. But the software state is still out of sync with hardware
state.
>
>Jason

Sami
