Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760496;
	b=kkR5OwKshNjnyDlBOkQcnAziEmYX/sgZSuE+80qHoOojZYuy8O3bBgvHXM3pnXrBPafk
	 jqVjDhp9yAZWlRKHvqc5aliPnvmltRd+F47C27LQS/bJHxV6A8J0eMvb5y0U5Axjfahm1
	 fInITLTIAcFMbycCCkyixLZAjfMXGzacvRBuisPKhu8fmB4AMhiHKVrRdatwMhiDe3Van
	 5N/ZwIbrRTTlULqa56iXxSfr+MZLe45Gptd+U3GsZIoDpx4GVLlkR5k1iRSoskgAUjvDv
	 kTXSmJTZLb01yrODsE/8MI6EZ1k3UrWH1eOq3CsWOKkqGm9ybf/UvOeTUfrRVwTHhkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1f6kYcZtrUYkUfjtStdqQg00V0eNduZavh/6mKW3Q/4=;
	b=5aPSbbpU/iIhSLXMWhRmLhqBupwooqxnLu5D2IajqCMNOt/uZDw7Fpd3V+HOhEtJHx1k
	 svCIYavBkT1q855LWtXQa8beG6MCp0VHrI1NzjQhntLztIjgJhtA/0h0tN8NqMU7H1GDX
	 gMaA2aqQnRitYhSH5azqaWwXIq1TFfi4JrvXehaqV+2e+DZo9SQe82gjcEXQiCe7dupYZ
	 NdhW5s5Iu+2p47Vt6LmeRummMzgdsK4U8HxMClQALyTLLHjWzXh58qNac7RWLBX+r0ZsD
	 +8ZEpEvqHRVuUhUEYvs5SAfHqv4fRP8qLzu7XgTgloh6Uh2MIsh7tL8mtvCADmv+L5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=dA+0fYF5;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C063606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 13:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C063606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=dA+0fYF5
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso5779075e9.1
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1792760495; x=1793365295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1f6kYcZtrUYkUfjtStdqQg00V0eNduZavh/6mKW3Q/4=;
        b=dA+0fYF5NJO5vxhD6WsfE3GuOrunJPEPXuH20p/OWeGyCAQgyez/yng8gcWtHHKDRW
         aNNEpTkgJ/DjomFukcZkpeb6Q7E/kWVRL9G1dBUB0P9OUUvF+ziO60N0H3rvhfPEkMkS
         8IPds4ztnx4D+xQpBrTJ0QwMrWzos9Yj4MBRMbVDPujBjU79BQGF9Oxb7qG76rknzGE4
         a5iwk9PZe8SqreUHjx76aszDfzAo9TOoODm74vaYhGYt/lMjoiSK1vLwpZFU3R4Zw7F0
         7HoIGhXLOxKs0+6hz0CBwmLnam0DcpMdiubzbHtmfRhLHWC4gJvsvSCGUFlitbgTI2Kv
         /hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760495; x=1793365295;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1f6kYcZtrUYkUfjtStdqQg00V0eNduZavh/6mKW3Q/4=;
        b=xG6mzu6Q0tGyHIaYl9+nfQ++JbpbqoBgd8Cmqmql2foSuBY2q44us3Tyb1nQBE59D+
         ej2LTp6Y2sGm+pvO2EMw547VgaRNKDmvJ57O+Jii+Gc59q1sPQdgFL7GOso5WGZSB7vu
         HmEdyJfzFkY7SpnhcF1R74vH+p/uJqw423c5dj/mBWtEamCyix9TghIipbobPG3snK+0
         lJ9+bQ+xvcdF/tT9r2aZsCv+mVVgBvKE1BjASjS5Eml9uid7WowBFU3IJuUg+IAPzcAZ
         YhaOfnZyzTXyPEH31ZamqpB/vGHO8D3walQ9A35JeZZK71OmBQsF5gpRh2HAdr5wZdos
         RGvA==
X-Forwarded-Encrypted: i=1; AKwUvBxYm+r8GPeVTKXEsRkX/gLADi4wDfdDQiRE65BQZWzVK2JemBJZMy5G9X5KEJ4UpO2B75Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2awxm0xMdUcptiO33EL3IQ1+BdZ4RRx0qJB2/WadDJpESAlhz
	o/AroW1JsCCsNSRldu56z7Bp46g6iUpk3qPkkgUFt7xNrzTQBb7qyGlwRvZHTMzJnco=
X-Gm-Gg: AYBFou3q/qFCtO2+i8az2txMAgefHhWttUOaJvhIbH4KpBKwSaMPgAmK3dpUODAMeE3
	LQMZIdVzolD+Js2Y3i9bVE6vrjp9q7fvWO4LbkkfaKY5wez0ps0+2GJpiJS8MmkR9nTeeXyg+29
	I8KROSRhGi47XIRfJOeFMP1jUdcBZXJhlUGWRwDP9p/9vt564bg5u4hMLAAd4nmnEeK8ESsUT8p
	hkNUJALBOmp+V5+pGIWkSsr0P2DSaOZg7g0mzIxV9rRHl5PtCY+puu0zkSgaGSqpHhL98hpHRRh
	uvH7NF8wJqiKfA9f1ReGJ80taTzmEMC2Q4W63v91vsVFGdGCitX8spaDUZQIUfMDxpPrEqbyz9q
	ZRfZiWT3k5dhyiQ4IS5+IyLghaqE5WH3PuSxUv6cMu07RbjIYGLP14qJXio+AW9r5juw3bGy12T
	KsLKhCRXQesL/mseiV6AKwNtbsJZBHzkAHqNELAWaMjcjhfoVIVg187Fz5Ab7TwM9aylgDYF8EG
	u6IO6tB7QYf4YZm/FVfvhnoXBcUrIBS/PiKJ2ob2fJUXYRrz9tcDPr9+lcrwx2dcB4=
X-Received: by 2002:a05:600c:19ca:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4a211c8fa81mr35809955e9.8.1792760494721;
        Fri, 23 Oct 2026 06:01:34 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a29cdb75cfsm3940865e9.9.2026.10.23.06.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:01:34 -0700 (PDT)
Date: Fri, 23 Oct 2026 15:01:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	david.quigley@intel.com, lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, drdeeglaze@gmail.com, 
	James.Bottomley@hansenpartnership.com, aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, 
	pgonda@google.com, jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com
Subject: Re: [PATCH RFC 13/20] Documentation: ctlv: Describe how to write a
 family
Message-ID: <attaLkZFIGSKLmgZ@FV6GYCPJ69>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-14-jiri@resnulli.us>
 <179245258505.58760.3972297562218204862.b4-review@b4>
 <atjEgLYpgbZNzfkZ@FV6GYCPJ69>
 <20261021144951.GR3008132@nvidia.com>
 <atjiW8bnqDZ8zb5t@FV6GYCPJ69>
 <20261021164857.GT3008132@nvidia.com>
 <atnGniIHxIV-vzVC@FV6GYCPJ69>
 <20261022192118.GC3746973@nvidia.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022192118.GC3746973@nvidia.com>

Thu, Oct 22, 2026 at 09:21:18PM +0200, jgg@nvidia.com wrote:
>On Thu, Oct 22, 2026 at 10:22:55AM +0200, Jiri Pirko wrote:
>
>> >But it does work well here, and matches what rdma and fwctl did as
>> >well. So maybe iommufd is weird.
>> 
>> Well, one CTLV chardev is always backed by one device. I think this 1:1
>> mapping is clear in the device model. Iommufd indeed looks weird in this
>> matter.
>
>iommufd doesn't do 1:1 with a device..
>
>It is more like netlink where it talks to all the devices in the
>system concurrently.
>
>> >> Depends on the user/subsystem. Either families_dump op could be used of
>> >> udev uvevents that also carry family inheritance chain:
>> >>     CTLV_FAMILY=ctlv-attestation-tdx
>> >>     CTLV_COMPATIBLE_0=ctlv
>> >>     CTLV_COMPATIBLE_1=ctlv-attestation
>> >>     CTLV_COMPATIBLE_2=ctlv-attestation-tdx
>> >>     CTLV_COMPATIBLE_N=3
>> >
>> >I wouldn't try to link it to udev either, by the time some userspace
>> >uses the cdev the udev information is gone, and may be unreachable
>> >from inside a container or similar..
>> 
>> This just gives possibility for udev to work properly. Depends on
>> the user/usecase if it's going to be used or not. Not sure what you mean
>> by "udev information is gone". Udev might use these uevent info to do
>> aliases, similar to dev/disk/by-*
>
>I don't know if you can encode N compatible strings into a file name.

Yeah, the udev rule would have to have some logic on top of them, sure.


>
>And in a container or something you can't get the uevent, so no client
>software could rely on this information.

Okay.


>
>Jason
