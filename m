Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A3338904
	for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456994; cv=none; b=QmL1QxpjJhj2xpwIavCTzLL7ioFIAL1ccV5VhB/W8lWEkdBf+Ld6M/K7k7txEZ0Qkf3ANe4bB94VLCeXKU3r3v5q62h3x/yX2pmrSiUBfKfnX6IHiH4CWR505jFIUWNZoqw38r4gt4s5HNIkw8W/zmJZpL6fIxw1HERSwruKRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456994; c=relaxed/simple;
	bh=jb8N9fcXBqBsRGtbsKTEVt5Zt+JuTvWy2MsReVTGviM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRLaCkpuiR5iw5JKtKDRBzZAeXWQm4Ox/BD3o7t3dHvn66Do+Ps2S6srQP4mXe7zeLFQlpZdLxJxr1BxH8EmC7FyQBPdA7DOZc+4TrHZ4GO6OfApmhDmN1tLzPVrfbg4RThTl+YW/18sLMR3ER+xR985Jc8+Skri85sZdIX0978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jqs/NKSb; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jqs/NKSb"
Date: Wed, 18 Feb 2026 23:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771456990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6frpKuihVgv5CskVtLdkgZDKHPjUlZtSPGKwDoB4Ftc=;
	b=jqs/NKSbV4p2tep88ruNqNqp1TXOAH8G1bfXCLk20wiRYWeUfn7DxbkvQvtkRIh9V4GMcL
	x/bCT0eDCmSTmhqqsPPDk0CVBP5aZgAWwhGzYsGmk4zlAXj+Lw5/+awljshKOWDnisCfml
	V3vHJoxAfTn/t8HqKObZes7tu1KyPhg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] KVM: nSVM: Capture svm->nested.ctl as vmcb12_ctrl
 when preparing vmcb02
Message-ID: <5ktimhxt32fraex5vqcdqrr7w4s5a2eyustcbixgjmv6g5ddqr@csjsyxzp2yss>
References: <20260218230958.2877682-1-seanjc@google.com>
 <20260218230958.2877682-9-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218230958.2877682-9-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 18, 2026 at 03:09:58PM -0800, Sean Christopherson wrote:
> Grab svm->nested.ctl as vmcb12_ctrl when preparing the vmcb02 controls to
> make it more obvious that much of the data is coming from vmcb12 (or
> rather, a snapshot of vmcb12 at the time of L1's VMRUN).
> 
> Opportunistically reorder the variable definitions to create a pretty
> reverse fir tree.
> 
> No functional change intended.
> 
> Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
