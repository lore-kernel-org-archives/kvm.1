Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCE33AD92
	for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456811; cv=none; b=Tmr8HtdxADyg19fJqAw987PXpHeRhGfenuhYYU1+npmVX/vaH1nYX7BUoSnuOwOvLsmWW6CS4t/K9wt51gV12SmxvablaGnbW2ZdfY3mMonpXQy0LjRJS9Ps2EdtydhmFSrIrS4QEgSckToz+spcBwAuHQi4QU1PepqcVROEKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456811; c=relaxed/simple;
	bh=T2LBunHYDCyyAhnDiLIy6aex5rrQTT0m6VtjkBLduE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJO/fk9VBfWUgs3fc35ZfxQTjU6CveXr42J1nwabF3seEVf/73KXsbdaOZKzHcmTTe3p/CjbzyaRv/e0sTu0hwPcV1o+VbibuGnXE6j15kPi2lyTY5ZK1Y0ZGDJYzEKQoMJwJKal9vfu4SAuKxYW/XcwJ5Mj57OFcsXSmWEgGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YmsiCGYm; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YmsiCGYm"
Date: Wed, 18 Feb 2026 23:19:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771456797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zMQVlWHh9HlDl1Z5Rz8rwZPvBWNM0YIOdiVlh3GaJOg=;
	b=YmsiCGYmgYOXoExyKb5BDxs+AYIN56O3SlEEUyMrBdYuNmwhpnLp7HvksOT/E+L9C84Igg
	mVLaXZRs9dxPCaoEtTlw+fWY+0cM+59fLvZ3sVhpcot5EUeAQaKfKqadhz8RWDauVct2RJ
	inOYV6bgRD6+6mWIKsTNJhxzd7DxpS8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] KVM: SVM: Separate recalc_intercepts() into
 nested vs. non-nested parts
Message-ID: <xwe2vpjzsycygihteyz7xawfz4y3psxyoc7t5ugnxfvskyknwo@oztj7jd356tx>
References: <20260218230958.2877682-1-seanjc@google.com>
 <20260218230958.2877682-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218230958.2877682-3-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 18, 2026 at 03:09:52PM -0800, Sean Christopherson wrote:
> Extract the non-nested aspects of recalc_intercepts() into a separate
> helper, svm_mark_intercepts_dirty(), to make it clear that the call isn't
> *just* recalculating (vmcb02's) intercepts, and to not bury non-nested
> code in nested.c.
> 
> As suggested by Yosry, opportunistically prepend "nested_vmbc02_" to
> recalc_intercepts() so that it's obvious the function specifically deals
> with recomputing intercepts for L2.
> 
> No functional change intended.
> 
> Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
