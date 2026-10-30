Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389347;
	b=VAovhmCD66fGqyniPaq8TjziXEOw1NWSutrZ1GX4FyEpvBqFvx7QIVJYENEEOdCGCuad
	 t0Pcdk5ZDCO7q1o3jK8KGPUX1ykdDm685KZ2+LF7K+mMmx8F0ZfM+yogeAViwT5mq7R1D
	 NvlUOp39SE0Ro2WId1MU78EnKkF5o08bjDOiidayzWJbOytQG5bK5oXkmiBl0rh/Zpp1H
	 3y4DSuNd6Xhnr+PmIb6aOke8tMchuMEbESvvJViiieC3j1k0Ruae5RLCHYiVGHcJiSWlj
	 mqIoUpRaV0vihzoNIp1f4mMqIqb1XAG6nkG9Bxi1PLM6XUxNoyDUkmThiBhd4sPeaoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vK8srcbyjFHPzlTR1mgLENgg8K+rOF0C+tBALqScXrA=;
	b=VKs+gF2I7QTvwzNkxc240HZ5f1+4pULUzWeAqpqmKBg2h2I60z52F13KNwFwmmia40SM
	 R+dh71QUG0BavvXfyg1ejV7HDdeDP5figo8K2rzh/7Tksx7eaS+rHwNHth+8pdaGtQVkS
	 sWa7updrBpPm/Zv5qf+hSVAYnONKpD9Bp7QUsmmFPWDW6f0VMl2XWpTbJ3kTEijWeYS8m
	 TaM0apwDdnTVS3UTlFNWFwmgc5rDmQdVCh+C3/5Lqjt9OvHwp1wSdM0AtHWxreFLa3uVN
	 Ud37ZUbhylIL9A8IZsLOCzSLYCw1v+cZAd93mq6nSy+4HGp4/yWb/rEpjFl3V7C4+ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n+cR8LUT;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B1606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 19:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 520B1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n+cR8LUT
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9f6a16afcso11745ad.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793389347; x=1793994147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vK8srcbyjFHPzlTR1mgLENgg8K+rOF0C+tBALqScXrA=;
        b=n+cR8LUTPsSYyEztW1Xd53zSgs2w5fEda/2TDsvkFHyDtU5r2EN1NbVU2uEfYkDMR0
         gYcVpLgx4PJ8WsOAix7AkB9wVd1t6sOBxNpuDXy6A2+UoFD/dxUQtSQ3kdh3Yea2F5el
         yf5U1o4qYS5E3eftNezUY6nejAsLwvjVaa8RXHRICCVR5A9iaxY6aUO0IbJKZvaPkChU
         VpeASB4YKj01XOkZ7airupCqXro5NF0YWdK029qG6gxFlFDr6/lz/eUq8PF/WNCCvcwQ
         jk9R94w6ZMQSznUdt7K0wpVjo/mtPPxxRDkcwM1l6pXHV/a2yx8DHFgP9U9dxDMsakI0
         NNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389347; x=1793994147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK8srcbyjFHPzlTR1mgLENgg8K+rOF0C+tBALqScXrA=;
        b=11S555fiVPY/1ToK+UYVlt9+tPhZThigsCqrDcnAZfzQcdV6xiDy2lZQc2G8HREaoR
         hteety+EgbgdiowQNqRBCxHknMk4pOUs2P4KQG4yq/KqhuF3PPkH3DdX6/S2RrTCyKtr
         j36BnUd7+NUsFDns+puD5Mje51OhS7pBaPeMiRmy8YWECmEv5f5BtssEvrPdwaK0J6S9
         RMq2eUie418/nyWoIeFyOIsy6KP7cevhw1t59wVjHriLuBgIK1FTpOm/UfqKQ4huF881
         rM/yvz0aMC+6BjphrCRCkHA6VXMdc2a1C2FyvH5L1D3FXxIXruLVWBGFeHydUyE1ibVF
         giHQ==
X-Forwarded-Encrypted: i=1; AKwUvByqfudc1h0CDswtbSp53K32KfmuuM5irC4zLQa/eNfXZ2OAtHwrng7HAH8RF3wbb1FF8t8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfnhm0yVCTTkdMdqO3n6A+Onv9MsM3oYF0urn3By6BOmOKoTdM
	AH6AIJON9GUdI/T/ftRPAkAQa/jYoaXrZieYJn0+LNFJdzK9UyWgQzvUBToEzPxjFA==
X-Gm-Gg: AYBFou2kjgaPq0fK7PqCYA4Z+zlvEDuYpr1IAiynYy4+CCzwusT+Rj6WA+cT5pnJxeo
	+UupXn8T2+exGgCSGxvhwgU6oKLIdwPMRFZuj6WlfydXfYRjo3Dxp8DBbniOncLrxyGgbJldJ3h
	6F56UtdiglFmSH411hbWFK9Lna5SMz+nSmIEQfA+PnYjS2JOB+s404lpr/AqAPfS51mWGy0wsOb
	f4SlFi12QNzLqqq9zS8FgjnmbtqASsv7j4xCAIYT94iPUnho+OvQiyNvEJIFo2c7GkrsKmGN9Cl
	xAKrwpYf4StsPzziYpygIMBVGuScPGa2ZO5GX1zJIcGhSwVjudjLhbGIIxY9+Pcm+DRG04B/9nD
	6TZyzrLijpUiewHQDu9g7MBTczZHWDnGyAG8X3pmJPPk+cu1u2tPsXJLPx6eNz4DU9TKzR/PcyQ
	rUi7jpFCFVYin8dXxddYtpeVFH7B523DV+tB6N1Indz/VxTr12XIu/Pud21tIx+YqlZRklhcVEt
	TErwKcoRzFSxKQWhEE97BU/huGpfGFkQLAA8rpoBuNlR9jGHD5JpSWVCSehuYj88DEMJYhpLN/o
	WncH7SlqRPS54if/JqsFFSSq5P0lQzaUVuke8R+OGY/Um39pd26eGb91rt1p1J8SmWaAYUH1+qN
	XaxyaZ/J7QYhCp2iwD/pBzktFJvAnbpnoVZOM1VpNmdY=
X-Received: by 2002:a17:903:19cb:b0:2e6:23e5:4934 with SMTP id d9443c01a7336-2eb1ec7beb1mr12096545ad.14.1793389346146;
        Fri, 30 Oct 2026 12:42:26 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052bb1sm12148735ad.1.2026.10.30.12.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:42:24 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:42:21 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 03/18] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <auTzCsfpkxOWRPHJ@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-4-skhawaja@google.com>
 <14cf71cd-35cd-45b1-a0fe-94d4a76e9e06@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <14cf71cd-35cd-45b1-a0fe-94d4a76e9e06@linux.intel.com>

On Fri, Oct 30, 2026 at 11:07:20AM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>Add iommupt ops for presevation, unpresevation and restoration of iommu
>
>... preservation, unpreservation ...

Will fix.
>
>>page tables for liveupdate. Use the existing page walker to preserve the
>>ioptdesc of the top_table and the lower tables.
>>
>>Preserve top_level, VASZ and FEAT Sign Extended to restore the domain in
>>the next kernel. On restore, the domain has only the preserved features
>>enabled and all the other features are zeroed. This is ok since the
>>restored domain is made immutable and can only be freed. A kunit test is
>>added to verify that the IOMMU domain free can be done with trimmed
>>features.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/generic_pt/iommu_pt.h       | 155 ++++++++++++++++++++++
>>  drivers/iommu/generic_pt/kunit_iommu_pt.h |  30 +++++
>>  include/linux/generic_pt/iommu.h          |  30 +++++
>>  3 files changed, 215 insertions(+)
>
>This patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
