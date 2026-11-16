Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858736;
	b=DqyTuKi0AmWobo73Pn2vxTOLcEiyUYUTDmMnjLqtuxF+qEb+31H5kpXkzmAmJJiuWPoS
	 plgU4eqhD5ZGcdd1Cz8Ek2P6sKAXihG4L6pcRip/lKH++udw6iLmFfz/KGGtuRonl51Vd
	 LWtWX+Qcx263hkveoHDmB3TrQK0W/s/2YQeZx+YmhW0wNHRFOkB/28dfVDE9heE2BOIVD
	 HpU6LhfuoT/z2Jeoa3DmFUgKxnlQlWFtYCqQBelAqqxBiXIg4Ld++EioCmXzyC0O4JH5O
	 sbRqKMp0ZxYgKrwWaQEg3zMKUY4+Y1emjZtoLUW8HEJjebNP9T70+r690lAjScmuZLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
	b=n0JL/g/6F+62bYxcs48GIjvqL7o8Uhg7SFZgr/Y2f0RszQPstMe8RIKecMl5fv69ky66
	 zwp8Y41PQJNYglz3ROZpoSweR1edZe3pNROgY+XIwCqHh3hw/XW3TEjCQ0XFcVeWVbYay
	 t37Fdl7/TC3Hc2sY5jxGPEljS12a+K47+OFNnjJn94RRef2F6gProWQ+7c57py6mLyl7M
	 WUlbzXqifyRdFTf6eF+Dn4itWEyUNR8xgbsZjSU3D896MSmefj/IIrFkoo9rhVaeP+f2p
	 ZraDVQD4yfLCleZT47R7TUZ3CXzcNqH5FRjTqH97Y+8dxgl7R9Do3Pqt1UXZCVQuquA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YcqWJI31;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72D606A335
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 19:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E72D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YcqWJI31
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55c38cdd5b7so33737821cf.2
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794858735; x=1795463535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
        b=YcqWJI31Q3We3zqNvL52aNkFr++cowdUSJ0aOSCLtCZgOyPTfxfZMV4aawKPfLKj7g
         4m2sGeUiA0CXGadMrFuMRIl89TE0lacup406nbrhvwqwPIX8FxoVlYidwE8/s7P7Wszm
         OrbfdLGk33YGmzpkBYmsq4F3Mxnt+4Lu+TymHPjdbgW2SfeAeQs52uRWqh/1XVhhLOxn
         GvpMlDfLIXvCkNJG/BKPMpLBeKmXfFzSUPrKKeUURMUv+fsornqCLKr9GiRTo2LK7Tab
         rlciZWXd7u0mEyCoyMVRbS74CtgQ2ZcTLr22IpH7H7u3DgVnSQkVWAwVkGPORAQHY8UQ
         R7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858735; x=1795463535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqnrRoTh5TcWr/Py+gEgzzX7wdMhzTlFxFkfLcpGuJM=;
        b=tK2LPJlbYNT59tIFQBT5k2VrTfJNlOrYGHVRleWJzZqeV3zVSP2Dd/Ad6XRFnmgjdh
         hHHkr0jfjOPQKGe1oW1Izb32+ihfzx0hZ4fkJjCNXmz8qIXprCOacHUxXgGMRkTJdKnf
         NnxZQVS4LZ45CoRjjvYrZmDrht+V+BpHn86stjdcd8+gasjgR4ZMK18Ruu4n5VaxeQhv
         G3x3P1fDcPR/YytwEpUwehJ9+eYb/ZM9B0lEOrNU8zOW4dOWotk76TalvFX2JDoaMkUA
         0UH2jl4i+ZWSExF6Kkk9LaiUfJaLOX4vqwywGkh2V1svqE57hhfS+UXdXRaNnJgK0Gdi
         ucBw==
X-Forwarded-Encrypted: i=1; AL+hErE02SFHwbmb+kqKwQrluFZulp0HxCjPR5htcIT0V2RM0OBrji0h2bl86/tjv5s5axaei/8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JrkjswfB/fBrLdmCdM2EufNiQytODVLkZpCrCgrmOo75YrtL1
	QTP4s2uLqOiLFH7C5cFqRYiLBJGwKRXqwVuopwY9qc0OdbcK70D3gdy1hBYnZyCWQvU=
X-Gm-Gg: AYBFou18T0RW2bQ3n8mXmfIZk/UfbvUsF5t0QmalP9AiNTB5J9tSDpRKjXJzshVXEyR
	6IwSRy8qZ+ly1Wnzh44FtPmp4x6n9YMwFbYouP8Up7JyDbH/njK6m2n3CjGyetVf7+l98ncmZOa
	vMnvMaZN6FvOxrXNIcDe9Df8G0ZM31mhNwKHVuJPCSQe6clURl4R9SQaHbdLncz7dUM8XvYNa02
	QDEGFyLmlUH01OKCEQX0UZP+4cv6r8BtuvHKgkifzyKrjkSEQzS7WZw/YJVkx1C9hedJsas+v4S
	mkv4oCPahG6GedY0743Xal4EbFRRnASPKze2FRjlCgCOvLbBUJgjvINh2fGwUaXQSWi8W6nJEfY
	R6gOLXlniweXAiCrdm9UPHYOqg5dwDwzRNZcsqBmTDtdNHgiM72EvQNOnSoGjkHIt11lPSVmQjI
	tTMY0CpOcA8YUxdjm/v+N/Ct2Nkenf8NHY+MY4L/XUKuBNxt0dSy+xCjebH19kPQxTPIKIqA4nG
	WSJbwRsY04JcXdBoesQP8Kubgc+5JFzq8qBe4gSe1BVS4wZkC6OERcUOR1xVioXVN8OqjDs/k98
	9At+bA==
X-Received: by 2002:a05:622a:13c6:b0:55c:c7ab:4445 with SMTP id d75a77b69052e-55cc7ab469bmr121785021cf.29.1794858734926;
        Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f8319d44bsm48973876d6.4.2026.11.16.11.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:52:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2kP-0000000ALbT-12cG;
	Mon, 16 Nov 2026 15:52:13 -0400
Date: Mon, 16 Nov 2026 15:52:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
	loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
	christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
	will@kernel.org, linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
	mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
	harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 5/7] iommufd: account the hw_queue page array to memcg
Message-ID: <20261116195213.GF2452510@ziepe.ca>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-6-cui.tao@linux.dev>
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
In-Reply-To: <20261106131829.3228926-6-cui.tao@linux.dev>

On Fri, Nov 06, 2026 at 09:18:27PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> IOMMUFD_CMD_HW_QUEUE_ALLOC pins up to max_npages pages just to check
> that a user supplied queue region is physically contiguous, and the
> page array for that check is plain GFP_KERNEL.  The size comes from
> cmd->length, a u64 that is only overflow checked, and the array is
> freed again as soon as the contiguity check fails, so the allocation
> can be repeated concurrently: a 1GB region costs about 2MB of
> uncharged memory per attempt.
> 
> Every other iommufd allocation that scales with user input is already
> charged, and the pinned pages charge the mapper at map time.  Charge
> this array like the rest.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  drivers/iommu/iommufd/viommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
