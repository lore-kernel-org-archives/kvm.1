Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A44D2EC7
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046441; cv=none; b=hH32LtrCTF+2mFTno24L6iqh/2xBcegS3s6UwxM/qhalL6BGJ2xGR0/01fjwvChkpafsv25tWnYsutZybrk8rPyFtv+FWMonKGW4vM5nZiNbLvL6A5ss5HYucxrH6zKSw9mB928JT/oJBrqHrUigapKWwBDFfBUjzdb/KicY2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046441; c=relaxed/simple;
	bh=CHVAubWcDJFm2OCyKYq7MVSyyULKGL95xCv2x5OW9QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy+8fBuLStBfrkZ5GsUKkKdfJPJGS5r7Qca9HKV/GyKuVx0gDJb/6Exb6DiMnwUrSsLy1bZCeXVjZwrZfBK6W2n71UEI6KLAcA7dyzntmR5h4Vea/1gZ/5qWiKkGFrOTNN6PxWG05N7EQL8TCDggmWubSwv3+mWRO5ssgRnl89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMp7RZ96; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMp7RZ96"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383cb94f742so4162365a91.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784046433; x=1784651233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lAQKPZvcYFxKdB/psGyEb68scveBzJExKE2LOhYH/p4=;
        b=lMp7RZ96OfLGCL4LR8lGTsCFYGTHD+LbxhnJ3/IyzcTSxQReeLZm87/RPC0QmUkF2i
         IdQ9nC/gg7cU6oT0GaMGg4MxtWgJdUu0BoQB5X9VQL+rSgjLtMK5/C8myW5ARP4cA/Qp
         w7aRJMgYd8HEgBIsPuCj8VWFTZ+aMiT/wWn6F3eVmsU0ivFsWDgjeOQityeoXGVU7eJs
         o3rnTkiK1H4R7hFF2ndgNAGptYrhRfkKwZb21HZ1vueMijIXnAk/wn9RJRpTb8kc87Xr
         g+p3Tp3V6lfAhFgAwAPG7k07gp7NSAdldz3YnrHlhEd16m0iidNgCR6oeI/6efsL8f+B
         y+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784046433; x=1784651233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lAQKPZvcYFxKdB/psGyEb68scveBzJExKE2LOhYH/p4=;
        b=S+WA7O3CGbIrrLDVZSL/BW66zD4G1CvDhLm+XKGhTTzeKI6U6SIbcT/Epsl8E7tlvH
         Gq8FuFczURTiFoFJrJB52gBkgxV9clRPwDBCIkOtLghNdzetUPeyITFdYmOk8HXnHLk9
         NMyUui8Uc6wSbmoOErZdNzzdBcuDd/dMQbLh2F9BI0DB62h6rqQTgp/LzF+zWrposgtz
         ruq46+M6aOfPSq7NOTXvSw1BTzjgvrcrQKYPqZ2/OmTOY7/Dhsvl5tZDwwE0uCvJSfig
         sqVYCSDraX9kc415rQ8qPkQYuc+q1jk4xjbXMUheGw2ZfNcylpLzhWjoICYX9+viQr75
         Y3rw==
X-Gm-Message-State: AOJu0YzpOX3k6eyBAL09fD1XXuQS2kzfHkUddX6g7UF/yqy/oIn4xEao
	r6IWXIwpRuSdjuS5IWs/T0o+V3iFlRL0CkBsQ7NXOpt+pTutkJokJBdd0rx+WNPlIw==
X-Gm-Gg: AfdE7ckQ+Y86UfO32ZOhPylzO4WW1acRJGM6xDf8AQPx0b6PTo8G9P7OzSCuYZnF6xc
	WWz+UqxkUF13cA334jLPatXCs8h5eD4Xp6d3c5cRIU4U75W4GSexEYy7WF1yCcSJxtX3kJ/Auvx
	uhNCvhkL6KKw45jJj3ct1ZLkxUsLoYv7+2ckyWsqPJ6sbEEzVR/fU4XRRZLdwoQXOdTdtZeBsaR
	sSORlhaBlNTUYokyE1fBccwSTUzFLLqxCbNykDc/CrTWw8CLWZJdxzUPuMP00UHM3x5eiR90+ts
	ebTrM8NFbe2qdwxfjdAVhPJOCuFYmZnTtUZEcNaNsCq+CmlL6mEs5mZMWeSbfHh+diW68HLIweS
	/IXxU6nkO3ARpiX6C/hEp4ARwtL6QhtzeMzH0Iinmr+Ta4LInSIQcZr8vNOP4KR/PQ8GMfMZpzx
	ouBEhqL37gRskZE9cFjttlUVqru78I0AWA7mHC33EBHYOIsch/JoSWFOFeiJdImg==
X-Received: by 2002:a17:90b:3508:b0:37e:1430:769b with SMTP id 98e67ed59e1d1-38dc7b37b53mr12079684a91.24.1784046432917;
        Tue, 14 Jul 2026 09:27:12 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e1745a86esm1706179a91.16.2026.07.14.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 09:27:12 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:27:08 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH 0/4] Introduce vfio_dma_mapping_perf_test
Message-ID: <alZjXMjmiwhjVO3G@google.com>
References: <20260701203311.326798-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701203311.326798-1-aaronlewis@google.com>

On 2026-07-01 08:33 PM, Aaron Lewis wrote:
> Add a new VFIO selftest, vfio_dma_mapping_perf_test, to provide a
> configurable tool for measuring DMA mapping and unmapping latencies.
> 
> This selftest introduces command-line parameters to provide a convenient
> way to tune the test for specific situations. For example, it can be used
> to observe the lengthy unmap times of the Type 1 IOMMU on large memory
> regions, or to compare DMA mapping performance between the Type 1 IOMMU
> and IOMMUFD. These scenarios can now be easily configured and run via the
> command line.
> 
> During development, I abandoned an approach where I initialized memfd
> globally in main() for all tests. While that allowed memfd to be
> initialized once for all test variants, it proved awkward because a
> different memfd would be needed for each supported page size (e.g., 4K,
> 2M, 1G). Also, If a user is only running a single test variant,
> pre-allocating all sizes is unnecessary overhead. Therefore, I dropped
> that approach in favor of test-local allocation. However, I'm open to
> ideas on a better way to handle this.
> 
> Aaron Lewis (4):
>   vfio: selftests: Introduce vfio_dma_mapping_perf_test
>   vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
>   vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
>   vfio: selftests: Allow the flag MAP_POPULATE to be set on the cmdline

Please respond inline to the Sashiko feedback and address any findings
in v2. I'll be doing a review as well shortly.
