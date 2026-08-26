Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681403B3C01
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776645; cv=none; b=AQd3erbc1bn3iJzJqoqIhzxiKRB6Ed0eUF/Ta3D3DXBxukjEYzkuKRDI5aAGy67+jCZSNLNHaxIUTPUxy2eRuiNjeQyrUv8T4TSQAWqZA+wZ/yC9UpaN/YgUCT1/6VjC+xF6M3qRgOX474KdQlplDhYsZfex8kITVdvP3PtDm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776645; c=relaxed/simple;
	bh=YBYb28lJo+o6sWxWkJtKpwJvq7b6MSb+mLIbxMdLQwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3DIN36IUtWEjNBmCATZEuVd4pNaJpFbu9RJ6/m8MHeOa5Y7rNG/KUYYje89nFE0R6YjqLeulxyb0CxvtV+lQNUSEuHWaF4RApfZhCZYjXHcMgn3abtr6qLOm19E5hcFrQtSTBJ5awUzcI51xk3H5ae4F17nJAk7u7ILQp6XIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UmTA5jyg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UmTA5jyg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d3b440b97aso8565ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787776644; x=1788381444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YBYb28lJo+o6sWxWkJtKpwJvq7b6MSb+mLIbxMdLQwU=;
        b=UmTA5jygbGLVv57VODY1QuVX+2StkJ/6WCNDnZp6KmYiMa2eS2RXD8rr63itsLF/Rk
         Frv2ILod8FyqJR0kNbMw9lAmU9zefHZm+gi9MSKLKUDXfW9AM2ss+LUqS0YzSdJFbIuf
         jfSkJSmfeAvfky9JuBJuESoe9VeYya/TOUMn5EN+k6tab9Nnbo9n+4Lc4BMn5v8yavzF
         HrX5jbrsXj9kC8RDiDM2BKLgfwETb1PWkIJ53c+hFMqCJpOO0RhfEWn6DsXMYxxr1lYD
         y99fEPa/LKDfqCItGTiM0cnvAQ83ZwEADDBRtGM7qZXN4fPNz//ie5Uw37C3wP7uor3D
         pyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776644; x=1788381444;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBYb28lJo+o6sWxWkJtKpwJvq7b6MSb+mLIbxMdLQwU=;
        b=sVYTq98V4GiOn/F+meJ1VFhv75hNG+iVmjf3RvhpRU3ag/QoY0AOmlcKwIY/NL6AIu
         jPdBNULO94Gfs6zGbOSHSxsCO4yqTGIVpNYPLlz1NzB+ijR+wcS5abUTD8kfiLpKPSzZ
         E60xLhdUjgwvWezcMB/6ALsCjkbl6upvGzZEbNkgoQjb7rl4jHwc0V/en1+Nc5mKXIuY
         bkKse9e1Kkg5tcaQLHmq3vzYMLT3TGsIArUpMIdBhNKQsh30ubN/A+rSyokCwGBVo0mb
         iBE/xBVwEmVEpdkAc/JCg0D3HFhZJIFiCPdVfRRsZMhJ9vs94xJUZZMFknCvbsDeIHkP
         qf6g==
X-Forwarded-Encrypted: i=1; AHgh+RrWSjnAT/29USf2E3s8HF/PZgpOk8myZcVpkqYQyOLaskIUaXpCoiNY2OWGpAVtiTuI/Cw=@vger.kernel.org
X-Gm-Message-State: AFuF++nf3I4I+DoXaoDsCXdq1NoKDnetVhHLv67wS2VdMojX1//uE4Ls
	KXRqBACdjRR7AlHKSD08Hc3kvd39UZnD8ZgZTPoHKyenYlDINepsYMrWRC1VuRRNng==
X-Gm-Gg: AR+sD13foEeKP6RELxmwO8/zJ8IaGSnAnZMFG/zS+ynAeZOMZa1gujNNa0n2wCxzgpd
	MvBhmJ9foxV+33XChAWcnA/2u6uIyT21900Md5yKl8PLiXZMRVOGz1dNXj+3gzv5lqGJGtrvQnG
	3TyVVo6j3WihbVt0szkTFdXHFFcJJR2Rk1dXznto1G47rF8BT6Phsk9sFRJu3qjdsC0XyggwJE4
	YXfWg0eboFlnwl1pnGVGw2pNh324lkVOhCH7cIaos/+TWj8Vh5hjYAGzMlpz4R1ttHqXK8Ga77R
	rY8Axm4s+ztm9PwwU5UZd5LgUlJG2VGETKiLejo/7TutNJ31p0c+p/m8f9495rzrPkkNt7w4iDg
	WZwAlEpaPmkGiCwQ/jle4qwVABFzy6qeWZj70K2ESh2kPh9GyL8bT9M7AZn1T3FtK7MqyaB42Jd
	MQLdExgcf0toM6xijaurs6YMvF+iEH5cefq1CfI/QKx/oeNYDbgjMFVCljGgfLci3j2eS+yFkKW
	Cbjh6baHl0za2DeDuBiNLKsthGK8DnmJqd4F2bhiAhqho2z5N+AuY5KOpZT/rwtsV5CyA==
X-Received: by 2002:a17:902:f545:b0:2d1:1d3d:97c3 with SMTP id d9443c01a7336-2d733662a3fmr39975ad.13.1787776643126;
        Wed, 26 Aug 2026 13:37:23 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cf3e982sm1302094b3a.54.2026.08.26.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:37:22 -0700 (PDT)
Date: Wed, 26 Aug 2026 20:37:18 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <ao9ONwUblaEqIpot@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
 <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
 <ao7ccBlV9_RXT6Fe@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ao7ccBlV9_RXT6Fe@google.com>

On Wed, Aug 26, 2026 at 12:30:40PM +0000, Pranjal Shrivastava wrote:
>On Wed, Aug 26, 2026 at 04:05:51PM +0800, Baolu Lu wrote:
>> On 8/8/26 10:27, Samiullah Khawaja wrote:
>> > During normal shutdown the iommu translation is disabled. Since the root
>> > table is preserved during live update, it needs to be cleaned up and the
>> > context entries of the unpreserved devices and root entries for the
>> > unpreserved context tables need to be cleared.
>>
>> The key assumption here seems to be that, during a live-update kexec,
>> most devices do not go through the normal iommu release path. Otherwise,
>> their context entries should already be torn down in the
>> iommu_release_device path.
>>
>> Could you please confirm this assumption and add some short note in the
>> comments or commit message?
>>
>
>Yes, that's correct
>
>During the normal shutdown paths (i.e power-off, normal reboot, & kexec),
>the kernel only calls device_shutdown(). This path bypasses driver
>unbinding, as a result, devres_release_all() and iommu_release_device()
>are never called. Those devres teardown paths are only triggered when a
>driver is explicitly unloaded / device is unplugged.
>
>Since live-update piggybacks on the kexec/shutdown path the unpreserved
>devices never have their context entries naturally torn down by the core
>driver's devres model, necessitating this explicit cleanup.
>
>I think we can add a line in the commit msg for this because comments
>might create confusion if similar comments don't exist in other drivers
>performing Live Update. What do you think, Sami?

Agreed. I am going to add it both places.
>
>Thanks,
>Praan
