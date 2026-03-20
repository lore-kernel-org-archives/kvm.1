Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B171221FDE
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967251; cv=none; b=Ns/MlnOm6xhrSfAyPgnJnlf+qbEc3oP1bFzfLHcGPVFzAq6UEWlbeKpTepCPTAxF2A/b5f1xRmwNV2PkzrjrydZyXeJZjgf0Bph66nLgo4G8dq2J3G/709Awy6BnaQC84e+P0vVisTC6+N1nCEa8s7TuC79obUBBQCtgOA09fqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967251; c=relaxed/simple;
	bh=neu/OaclnBTY+LKMUcCOPstS/nZ2GgZTa3D1B2uI0gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7VldX3wvGBWrzvpaDQri3Bwn6f/5A+f2bVkDSbWBa3OmAjsrLR0bcWcSsHd9705pTG+va5kt15gcpJxCL5YcjJBTm12p2TmE2QLmRW9PssDZOeW+xxpqL8zaf5staVQAoedWaLGjWeiRVhe1GegIoYFOAncNbbZRAD2ub9iZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lco4R+4c; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lco4R+4c"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b052562254so44025ad.0
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 17:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773967249; x=1774572049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vcw45TyfehW1ilqcx3lIL5BvMalHuEfy220A2zjHoI=;
        b=Lco4R+4cW9d08m7yK/ij74PEIq8uyDhJ9nN+IaYwln1A7TM9kksH4pNuUfeJOu+Oaw
         A778kQUCBYu9zIhIeoHSyN+XhObCqUR/0Bk5q36HyGB5b5ewZs9rvYFp0rk4CWWZlTDp
         TXcU6Y0FUY65AQkxUf1QOxn7HL2LXPM31S0NTbrcdzBuIOT6Uq0r60vIJmqItN/Z6g3/
         0wUo9uVpnDjWDqyLKek5Hl+KsA6tyC+rqYJX1w2urMl5UnXieUfIFIRQR+NJ8UWU+47f
         h89MVKqrwzjh1dVaniBSE6EUAErDPJlBfUGTQTr+5pQlAKICc/sj7IlVU9o8c4fx3+vP
         GnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967249; x=1774572049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vcw45TyfehW1ilqcx3lIL5BvMalHuEfy220A2zjHoI=;
        b=EWejcjmzb9IqNyaKdFxDkVK4I02JZwQa32OWkRpix+yFvhqpPv87yOeoAxzgNw4ijY
         T4Ze9ySXruL0aIzMaxRWArHFEiQUYPgfGdWtexnSw09YtWPLvVGNIwQ28IdRv2C1ONSg
         Xm3Nob4nmu0IrBWc9uVi1o6myKIhggkr35oXOGl9svA8v52lplQMq0bfC75SpkipWR6a
         yZuiwPVqinTWaExZa0zSwnZa2XgJygMzM7LJgJdu1D6CCT+svgiMT4Qxl7siZ0lBb6Hy
         t1+XN4M6VPw5WAVPE9BdcsnJR/HayVQkFGxEkduXL30aZi0I2MS1m+Qd4UV5r5QDXgyE
         XWyA==
X-Forwarded-Encrypted: i=1; AJvYcCXPgesU3/ZqfblezeLNwp7lw6dt1/OokE/FqFNxfUydC27ZWnCHaoYk07tk+rVumtC31Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqbn760TVfml2yAS5WoLN5uhRNcKSm+Rt3lSMBmWTt2BTvQ6dU
	rAJdbzcttSGjGWAuPSAAIhOlaqyyk45lSf1k88KJMWCXX9BpeldJF2tOPCwlMk5ZbQ==
X-Gm-Gg: ATEYQzz+BpbRmYzcvAdc4HejUkha6n5jB9FiMre3M/6OAdOcRS248V3L9JCxTY72B0v
	Pe20HqH5UBmFVD7knJsRJh6zJDgNE2rapmH8VRqMI77Dprfj3/ozsn6LLsdtV7jgXUU2GHtIKNz
	bPsNN3XK7SGh7+Gsl/PM24YxYtM+tKx5TwJHk+/vsXC0+dUdACet6wb2250LW+amPvbQvdCBg9A
	aNy3+WwCy+FpIaQz9l1cn4SGFmdEcnZnJQVho3k0w9GQ0mcvRAuaqDklmI+O1gxeOHpD43g9oQg
	eWA6xmH+bHms/FdrInB+E7+2Bpk6YIV1VWkhw7Z8PzcXhmeMxgfNKRhLLew/GuslpIN8fA8ao+l
	DO4OIDnycoi2jpP1ovZOkxyE4PzdLjXUphRV0SQB/0uXmb5b5LUgiHhKWANR+nvVaaCXkbsBgoT
	uZJdm3Ial1S04OtrM+RywCrt244VwVS8ECVRo+Vr4h6Tm7KIvLuZDdx+XV6QkRNg==
X-Received: by 2002:a17:903:3bd0:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2b0836fe6aamr851315ad.11.1773967248605;
        Thu, 19 Mar 2026 17:40:48 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a814548sm424719a12.9.2026.03.19.17.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:40:48 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:40:44 +0000
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
Message-ID: <abyU3g-ta6Gg6kEx@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-11-skhawaja@google.com>
 <20260319231331.GB3983821.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260319231331.GB3983821.vipinsh@google.com>

On Thu, Mar 19, 2026 at 04:35:32PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:44PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>> @@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
>>  	bool auto_domain : 1;
>>  	bool enforce_cache_coherency : 1;
>>  	bool nest_parent : 1;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	bool lu_preserve : 1;
>> +	u32 lu_token;
>
>Should we use full name i.e. liveupdate here and other places in this
>series?

I think using full name liveupdate would be too long in other places in
this series. And also there are other examples of "luo" being used as a
short form. Please see:

https://lore.kernel.org/all/20251125165850.3389713-15-pasha.tatashin@soleen.com/
>
>> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
>> index 5cc4b08c25f5..e1a9b3051f65 100644
>> --- a/drivers/iommu/iommufd/main.c
>> +++ b/drivers/iommu/iommufd/main.c
>> @@ -493,6 +493,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>>  		 __reserved),
>>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>>  		 struct iommu_viommu_alloc, out_viommu_id),
>> +	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVE, iommufd_hwpt_lu_set_preserve,
>> +		 struct iommu_hwpt_lu_set_preserve, hwpt_token),
>
>Shouldn't struct iommu_hwpt_lu_set_preserve{} be added to union ucmd_buffer{}
>above in this file?

Agreed. Will update.
>
