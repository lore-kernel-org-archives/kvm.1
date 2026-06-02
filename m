Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A33F4110
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415686; cv=none; b=EAyrjhINOQX4YB1mjvInfsuMGxy0xDN73ieH5U52Ni7b+bkcOIVKPhmAnax4hcGjzoNCvtStJZYf/O1+B5Kj4e9RL5nhk8qunJxP/3OK8cWHXehJrPWe83nCTIllEeQthRn1wu1FPVgqgVhvR7LoV8odCWE1sDQ83PengEvi4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415686; c=relaxed/simple;
	bh=ozM8AZ9eoQgjnPdvuzcKsMt8u6SHZRjDVsKbDJZjWcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DszQZdwbBt511R8ygrorQCKcV3iZXAeswCVYdGhT/PTR/dfDQ3TCWFcwq514sBAJ5VBs6GBrghFe6C+qfZc4kSqEpUJca2Pep2ryenQrX+il6k12+bGlQQYGoWifvUPN4+hXAH5fGYt2qfrx07bNKVgnbKq/YzeOhVK3mLhTcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zc8ywOEH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zc8ywOEH"
Date: Tue, 2 Jun 2026 10:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780415682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7D3Hfi0Dpuf1GZg49Dj/JWwEeIPExhLmM7yWKRJcKE=;
	b=Zc8ywOEHAOTHCeJMDiLqrbZHl+VQh6Fmd2t+5oknS5CMq6ehvHBrBX1ljRMtdGw+uVP3yd
	7aaOJDWVYJinMXzjj3gLMefi+qtY7czMEU/vF3g0SNzHpaO3wibMxyrw3l24HFFN9OE14F
	jxVv/V8PM1kj6h7BHoOyHMPYTQ7kDT4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: thuth@redhat.com, npiggin@gmail.com, harshpb@linux.ibm.com, 
	lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	sbhat@linux.ibm.com
Subject: Re: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a
 first-class entity
Message-ID: <emxfxob3hs2kqjmdbtucwr65dlywqapsz76ow7ebnqhf5vmrtq@i2wodbzjs5cb>
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-3-rathc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602064806.3101025-3-rathc@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 02, 2026 at 12:18:02PM +0530, Chinmay Rath wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> arch_libdir was brought in to improve the heuristic determination of
> the lib/ directory based on arch and testdir names, but it did not
> entirely clean that mess up.
> 
> Remove the arch_libdir->arch->testdir heuristic and just require
> everybody sets arch_libdir correctly. Fail if the lib/arch or
> lib/arch/asm directories can not be found.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  Makefile  |  2 +-
>  configure | 20 ++++++++++++--------
>  2 files changed, 13 insertions(+), 9 deletions(-)
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
