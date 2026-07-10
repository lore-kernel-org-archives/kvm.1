Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753A73B635F
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718468; cv=none; b=dkHYjjSOrnmRv0BdnwYHoybMXM3VpAB4n0x12v/QcBHAsTxHfwqLtF4ZhByhTFWrPW+4Cnrjydh2RrGalihOGN+U2cqnUVU8qH//+zU7Aoal85CcQlVKGGLG2J5K8pzSVdxzbnPMHPoAxk9z8JmTxl+kbb91Hyz4zvt5AGpfTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718468; c=relaxed/simple;
	bh=OrArmp546t2joLiGKmZojGNI2jG19j2P4RpxQaXcMQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB5pL9t2iop2qF1XyvHYcWsJckR6puSaD+it7hEm9yQmGzJs3QBQmOsD8VwawHWMwJNiuW9mCIbZIfjVY5Knm5sOPjNqVzogg+CeTUErUeOkfNMfmVU80yqUzw7S4i1cmBAnV26AqpTsJv9p3zzWgmhd5pXmfBdgJZwnBfCz8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WrsZLakZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WrsZLakZ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bf2479349so8904921cf.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718463; x=1784323263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=WrsZLakZJT/5oETG2Se79/v9kdjkpEQDr7Yp+OGw79X3NAKPcDAh1QSIBTgD1APIk9
         PcNtWnmXjzVyA/ekAuc9J1Ldf1520O+Ezw0w/Ib2rmg9zLzxvlAdRLVhZhEA8PmWUNiK
         TQNQjHvefwSfVxq1+ZCz986aNPT/4H/tI61eQYAsQJpO4szsu8Cjyex71k+0GpxpujLy
         wBnlnlMi5HipUbm2ZzOkDOrRTbcr6VJAyIpY72aJ/E32HuOp1s4SJDdzj0BVE5V3xg8/
         VUpFjW6w8Fy4sl1gdFaDfoPbhesiNrFc9fyD8+l3IKOSNiiupFoFQbmh3CqhrxND/l+7
         UddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718463; x=1784323263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBOMvPUpfjw5N1/s9nVKhxGNiyKZIoN9dPtD8sVM7ho=;
        b=UDQoO2GshhubG3a0JUpNExHbw9GgazU3T3YX8MgMInc4NogMBWW19SVqZFZ1ip/d8F
         20i9ArdK+GJvR8TeJzLgklOXC/wlKrYoDZ/wojkwEDYLO2wzfNdoYN/uFvl39Rc+0zWC
         dPreqRjhEYUU7XOsWz1XTZD45spcuFCqUpCK2lBA/PJzakr/SP6SVps9wIJ0CnOQdE0F
         4IbtV1zuliG3EtfZXyULWq/tg1If3rScjMMx7Co+gHAYCoIbyJ0J4hbIbYTbr7boJymy
         kJNRVJUJ7/RW80IpRk2+VvCoNgEMNbUUHLN2bF6SBlUCFlRQnE9Cj+NMDbcUI8bf5iXy
         McwA==
X-Forwarded-Encrypted: i=1; AHgh+RrZcwqt6q/WzmFIp9HmL5NiZTfgo/KQYbNN5LlDwxUE+axBCDBdvlbani+7ZqAmqawQlC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOb/1DYk3jz/4Nj/Z/gNimJ8/va5yYjo8vYHA9xTsF3kDm32V/
	al1SB2w7wZBAQ/ACt9Bk4fx+6CYY5zWFuj/QbhaMHX2LoKEkWLWXUqld7IGtnyTssVM=
X-Gm-Gg: AfdE7clsVYs8VTD0OkUtx4IMmgghpSdLAPof8pZJTKX124xmQzUJqdLQDhl4FJ3+1DT
	3+Mcdl+JwGXo6EcOBhOyzsmiZtgxZjufjZ1Bm/+j0E28rsSBtS2lxPSdKyUxWSMYYEqJ5374VMs
	Yh3U4CHFE2CA2DAL0SYM5BWxISybTMcx27drOdQb0eq7OWZULI0DBm5Qlv/vSMgdW2WLRuXbeiB
	LIRZI9KmpSFRy+XXf56yUniXRjQpcXd2axXTDCZi4Y9WkDOYJP6KC+KH8HQQqU7ZT/vD/F7Kdm3
	lr/Um9T0WdS4CDZRMp48qT50QIxMVsTXQQQU5gpIIbn7/H9aAJlxuAs5u9w6Vnp97yqK0IKbNvB
	dSY4mvuH29owsfRl7e325CbiuhapOTPiVcwcb+YOt19J8YvihZFanDajTjK8Bza/pJVysbp1VOk
	3OqUh178EoloifDk1Uk+ge9zRRmJlUpqnYh8V4s8dBFO5K7SMoc991bs8thEKoC+7rOggm
X-Received: by 2002:ac8:5ace:0:b0:51c:7b11:41ae with SMTP id d75a77b69052e-51cbf2dffb2mr6287721cf.74.1783718463047;
        Fri, 10 Jul 2026 14:21:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm23894971cf.24.2026.07.10.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:21:01 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:20:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 26/33] mm/vma: update vma_shrink() to not pass start,
 pgoff parameters
Message-ID: <alFiODVaGwd_wYl4@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-26-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:07PM +0100, Lorenzo Stoakes wrote:
> vma_shrink() is only used by relocate_vma_down() to shrink the tail of a
> VMA. Therefore neither the start nor the pgoff parameters make any sense.
> 
> It seemed we were passing the pgoff parameter solely to satisfy
> vma_set_range()'s requirement for pgoff being specified.
> 
> Since vma_set_range() is now isolated to vma.c, we can simply introduce
> __vma_set_range() which sets only vma->vm_[start, end], and invoke this
> instead, removing start and pgoff from vma_shrink() altogether.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carry over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>

