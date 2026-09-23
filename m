Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744352F264
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173968; cv=none; b=ROwsPG5kaMvM3pWAAU1bDY80JOPPcGxUuMonH/Yy9owbFpSLqaYCGT3LKO4/TiHfjxKpladwseDRbUM0gPqxOGXXYCwGnCiYIEjbf/zggMz1nR9o3f3ei/lM0zCdRmbI9t4SBaD84QIPQhtobuP043nd0wehF2ZfizlLUY3xu/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173968; c=relaxed/simple;
	bh=S7rAkPuZSZMbYQIfkDVKURs4Ono2lI5WQLQVCr5CGDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxbxLWA8wNrjdzU5mhH4nrbeTq7BDMzeY44+rXgdtJ3Lhb8tk2xDwBhNPk5ZZdm0kXPExkGzDLzeg0ZxTOp1AcouhjHPJjRKIFWiiESjJUVCnWLPl46THcft0zsdJrJQjCw1UQXqgOgqbGPv/V6eAmcitMUxEeoucKUK5BtVJvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mdmqPp28; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdmqPp28"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so563556a91.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790173966; x=1790778766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7rhO8zdKOr8jmD+SfzN1wHrIhUden50az9FhzT+ZY8k=;
        b=mdmqPp28IGHF+NKj9wAayNk7MVkLgVlCNCkixI5BktES03GMQ55V/dYOl5TJicpb2/
         rx5S2YVwHAa0dxHRCK263IEdo7J7HelyXNyXHcFWuHUtzMqXpYsv5fZ2W9T7zIQGxeau
         pQICE4fjlR89YLOoiP/MOut3o5YqXOuE54PprAO18ZKtOJ/Gu5ueyLwcp9IrykmS3g5i
         BrmsFEIspOhCUM4s5qRKzsV4MxYzVwxuz0IH5VGmofBNtoJou3hqnDm+SCTUHKQfbolC
         b3aO4AwR2+AJMKREOAIJk6p1SdWEkAdxkAKDB9fV9XkLqspEuCg4nZkS4OPZQtC7Boh1
         CEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790173966; x=1790778766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rhO8zdKOr8jmD+SfzN1wHrIhUden50az9FhzT+ZY8k=;
        b=NcpYyby/4KXi4zgl2db7htk+B7p7KoW6hozZffoeEQ0xUjBLu+BnpaEJ6OIKnsr8ig
         JO3VpGhBgIxZuMnKlR6FdNLdv4asYlO0wn6tWehKDDU2A6iV4tX3rOlYMryA7dmimb+J
         2JMr1fHyOt5CJ/5N2AIFJ35I+Njj+pAbalMHabKJgHzDaQ/e4oB8HDXOdwUsCY0KseHf
         mfcsXTNHrKHT+E1PAXlsb0NWANSNAeLZEf3ykyBsT8vNL0UnzsuIiW+k2gTQ67Np6qF0
         5Jd815ojXwUD/ECvz2qv+2OVcYXyWqTQrzGzZaGfZHw+PA0+Biqo1qc594K9sbFD3ZpF
         mo0g==
X-Forwarded-Encrypted: i=1; AKwUvByfY2uEbAUnZPUUokmF0v0N8BVChLaDaP/coIOboJtked1jb9N4gyq42aowMnh4LpbdCOk=@vger.kernel.org
X-Gm-Message-State: AFuF++kuJzy4hSniWFxdxTxdBweW5d3srRihUbWQRMZF/I5lawcIuDBe
	lMuRsblDdcDK6r47hKi37Oz50+p+BHNFD9/SpmfSJBJsmr2cdCMi27zUB4iLGsgfSnJy31zhTSw
	pMwi2
X-Gm-Gg: AYBFou3O8eXDSactwrdaa9E+vn6WNjpq/y44qo/8Q55wYCnruzb03yaBYWpiq4xHC3J
	gOA/92QcjJkoP5mI+5rXIFwmQBYpMXC9kgo+3/GYG2DggX1H1OWVeCvxcfcVel3t5hL1hgqRtGE
	oswIp11rRoxZIyQuO4Kvn30Nozo18fdpCo4KNVpziYJfMltj4mQdX/JUeoAQFiE7t6krLGLr+UA
	x6PQL36Hdx0VpOwHX305c79teYFOtRJzHCy26ipwoHlz107+0aBEWo24ljPkTcAwSFwZP3i1jOr
	jZLReSLFnoYrgJVWvTgkNWSSWhbRS+85irHybrwMhxo8UWfU/hQN5tejZLTe6tzsuuLREKMXmjq
	JL53pCOarPJN2olqubgs57nNuHHneYg5T6IDZkQs8nUNXDaoOYGXC69LGr0mFrbiUPnHoqSHUDL
	HI1q19w+tX7Dh9LqAZ+0rxie7hbP7/p8RIbtuKWXg0OKhsHyF1pf9OKSmsq89Ryg2bb1XnEx4M+
	cH8oHOscA==
X-Received: by 2002:a17:90b:2552:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-3a07e51cf1fmr2382544a91.15.1790173965946;
        Wed, 23 Sep 2026 07:32:45 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:b4a:dc6a:68e:2592])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07db882a5sm5446811a91.1.2026.09.23.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:32:45 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:32:41 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, maz@kernel.org, will@kernel.org,
	catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
	oupton@kernel.org, gshan@redhat.com, joey.gouly@arm.com,
	tabba@google.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev,
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com,
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com,
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v18 00/23] KVM: arm64: CCA: Add basic plumbing for Realms
Message-ID: <arPjCZL2IfvTKMml@p14s>
References: <20260915160141.3543048-1-suzuki.poulose@arm.com>
 <aqrsmUTxDVbKJn8k@p14s>
 <yq5aecel3aj3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aecel3aj3.fsf@kernel.org>

On Tue, Sep 22, 2026 at 02:52:56PM +0530, Aneesh Kumar K.V wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
> 
> > Hi Suzuki,
> >
> > On Tue, Sep 15, 2026 at 05:01:18PM +0100, Suzuki K Poulose wrote:
> 
>  [ ... 42 lines skipped ... ] 
> 
> >> 
> >> [0] Arm CCA KVM Support v16 : https://lore.kernel.org/all/20260803134403.80630-1-steven.price@arm.com
> >> [1] Linux firmware RMI https://lore.kernel.org/all/20260912083611.2513845-1-suzuki.poulose@arm.com
> >> [2] Linux GPF Host https://lore.kernel.org/all/20260913070459.2547407-1-suzuki.poulose@arm.com
> >> [3] https://git.gitlab.arm.com/linux-arm/linux-cca/ cca/cca-host/kvm-v18/integration
> >> [4] https://support.arm.com/documentation/den0137/2-0bet3/
> >
> > When testing on the FVP model with the above baselines, I get the following
> > error messagaes in a loop, preventing the system from reaching the command line:
> >
> > [    3.112577] Freeing unused kernel memory: 3520K
> > [    3.115398] Run /sbin/init as init process
> > [    3.142926] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.150111] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.177190] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.197194] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.217188] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.237194] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.257181] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.277189] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.297193] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    3.317188] virtio-pci 0000:00:02.0: swiotlb buffer is full (sz: 4096 bytes),
> > total 512 (slots), used 511 (slots)
> > [    8.157185] swiotlb_tbl_map_single: 241 callbacks suppressed
> >
> > I get the same result with v17.  Have you seen this before?  Perhaps a kernel
> > option that needs to be adjusted?
> >
> 
> This is due to a change in the swiotlb setup.
> 
> https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org
> 
> You can increase the swiotlb size using the swiotlb= kernel command-line

What size do you recommend setting it at?

> option. I also have a patch series in progress to address this issue:
> 
> https://lore.kernel.org/all/20260921063628.362078-1-aneesh.kumar@kernel.org
> 
> -aneesh
> 
