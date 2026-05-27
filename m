Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF544CAE6
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901877; cv=none; b=ejcvyS4DRo+UkZ0LYB6igebO54wG5hA5AFhSCHeQ201ncI0OR5Omt81PdsxWMM0SZRNOzbX+bufOifhTk6kHNNOiVMntI3ZicX0wjlnGLeRainF2MvRG0gQGx4PyHIITGFZh0xtaM4TH+e8NAkTSPx9pO36rfupw2idZ44eo52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901877; c=relaxed/simple;
	bh=5dhYnTz29zgsmBRPPybd5CWIS+uX9bZsxkT+ovNyCbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQWfaHQUoFJewwq6JOzL3CLIOWCGUhDLg1QG4mESjj+wykgsDOC2tlEAyodj8zdjsmMa53ojqWDOm5q0xH89LniTi8FHi+EdL+uOekTca+FU72rLHb6dQ41odtxwX7e6UeDL8NjxNCa/XaPBJ3ioQ4k6+EFy8WtBddipX7/1Ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psOXRPVE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psOXRPVE"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso365ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779901876; x=1780506676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvAhvfUYiK9fAI1qqXG1UgLn6BZJB8NhaqamtOZNNLY=;
        b=psOXRPVEppGh9alOZQ3lctmfbl8QmOGUHYva1K3WlZOko/2PjFcgUk3yrnCTPRQFeW
         JpO96BJPHkj+UW0zvnsffqXZhRaw/N/hg5bAiwy9exeXu8v1OifCQk5Ypl/xTj424gut
         YCbK3G4Jxvkh6iDcZUQvcpftmM27ccOR+S4TbgLoFHDEuboakxaIK1fHmkusxzeGHHz3
         qvsicdymSYhy3aU822S3HFiERQ5UMElbbfk30f4zklK1tP0lyOxunhLvSxxX/5J1tWVT
         PFqs8usXwzNqKFZv3BamQ7NWbQTCABrW1w/nUKjJSYpHrEp6jj435ZQaK1miv2YtL8Ys
         G7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901876; x=1780506676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvAhvfUYiK9fAI1qqXG1UgLn6BZJB8NhaqamtOZNNLY=;
        b=bqMyEC+6dkjNTYPdfBGEJoL6oZICVGsP/T+ExSJlLdUhb9HncjWnX39CbdxhLGOGfq
         5EYE7gVFRK//oXYAK43Riayv/D6aNd+AlBZC1MDZcpYeYhu5d7ETE5jBSgCndE6scmg4
         oBTL2uH/Ybqt0IpqI2IBDzKxebxLuYR5rUUOxONLwJJKFV0YTQGdR//nneY7eTYbVRAy
         HJL25h8APwNUGa8Z0juKxj7XmUsnz5B2AOgAkViSqwthsxJS5qJjiN0KLwuJ9ePKE36v
         q/rQHVCJy7egPcwMhNmwO2tV0s+PIC3/H1qf/SkA1jBWI+gCWCZO0GtjGynUs7mXNVKr
         6Vcg==
X-Forwarded-Encrypted: i=1; AFNElJ+/pWSscfbQVzBwbcEQ5R+8zHmRJui49xcgVJKBdbqcv6DE2I6Q/Bta4q8DbVlwhsrbZfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTQ1JfHka4GkYfjoUZkvWRZD9Bcd7Yt2uAb2OaWwkEV6GiHMt
	7XUnDX+WZ0DWdB+BYBsBNVzw7K35/H+TLw4T3AjC6CMV26lyc+3xNubF29nXqA/kcg==
X-Gm-Gg: Acq92OFPO+Nr/Cfy1TG9f/eRxf0mCsUy8elFPihPKedzLnTwmgxT/Knci9BAQH+HA/g
	Fl1VdxnyYbsM1nBQS9pZEP4/l15jxX2zI8qAx5jNVMx3ls0pa/gT5MVJrmIl/kN/PPYPQOjm5zM
	E1YLcVUfT3wcBpLu+sxVZ0RyMzjLGBCtUHEqHJpbgd+eUxlhdXuqodk8CvAfb932/qX/Wu1R18J
	qHMwqy4qA80GXVce+t3reLU+IRAVV7G/JS1odnWjY5JH8fuH6tZx86+9569Pjr5L+ylJpBhzcAu
	nrJN98PC2GVcOB6QVT1rKVW1k4AIkHUzwvpCmsZ6KwNqpswv3ycE1/Zd9qt5eVWup8BMw5jPc/e
	B16CpbT4WTYZmtdCaL6p55n7h6IJFLmkXlb60R5eQDJD1s/VYeDbm+ERe+paWDHhMmfk3MxkB3B
	ZGysxP+sVGmFRCNkjMer8hzVPpR6jmdB6CMDDB/8EkO1brTstgUfsK3G4M2tAWoini2Ved5w==
X-Received: by 2002:a17:902:cf11:b0:2bd:7bec:f0e6 with SMTP id d9443c01a7336-2bec116b716mr9444575ad.1.1779901875118;
        Wed, 27 May 2026 10:11:15 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5900b8bsm155801785ad.76.2026.05.27.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:11:14 -0700 (PDT)
Date: Wed, 27 May 2026 17:11:10 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <ahclK4Pky0huLpoJ@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
 <20260523133357.GH7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260523133357.GH7702@ziepe.ca>

On Sat, May 23, 2026 at 10:33:57AM -0300, Jason Gunthorpe wrote:
>On Mon, Apr 27, 2026 at 05:56:23PM +0000, Samiullah Khawaja wrote:
>> @@ -266,12 +273,22 @@ struct pt_iommu_cfg {
>>  	};                              \
>>  	IOMMU_PROTOTYPES(fmt)
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
>> +	, .preserve = &pt_iommu_##fmt##_preserve,	\
>> +	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
>> +	.restore = &pt_iommu_##fmt##_restore
>> +#else
>> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)
>> +#endif
>
>Don't do it like this at all, new iommupt unique ops should be routed
>through struct pt_iommu_ops
>
>See how map_range/unmap_range now work

Ah yes. That also looks much cleaner. I will update this.
>
>Jason

Sami
