Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC035C69E;
	Sat, 29 Aug 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787995812; cv=none; b=QbKLsdbe/I92i7VzBPNSsrDdqHYKH+zTQRTacT+RlluQJahQR71qOopfqZ7RX1vzFz3DWMQFGNfckQxlIudquOlMQXHo6z+ydscdrooKllxCCrX7FXh+Jc5k3XjL08VFfD44ZZv6tb3jPBwhX7enkLcSdeC2/GvKwkoY/P48Ahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787995812; c=relaxed/simple;
	bh=ym0MykUvUjJXX1KCG0YZF7RRDSajs7wCDeaj9AC+BP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMk1dAgvwi8WBsMbNWl0ihkQFnzLUBLvz7Bik2SITBCIbaVGwmnEINfjtHyvQwr12u1VSjG3KkwmJX3+AYJtcW1z1QWmhEQoIKCf3Xazrq8sNGYysrO++95y/fNCMk7lpd1QlJtMZZTgbr+53gkd26xoDOEIDhObjxThnba63lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c+PSepnP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c+PSepnP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kRIBKpBz05QwiPb/yIKNgZo76o/OxYBuBuuTaVtctD0=; b=c+PSepnPm970sIBDHf+LxUavJE
	Q3qlfpescV66z6N4W0u2bOkIpH8FguGfnVskDQGEBY4QcG0ZZxH0agzy2OEIFWQAdDFcq3ZuJe3xl
	RWOZdadFDqewYeZpPbYyrVTDbJI5+7z5cY7o8PunLR85d1sXNrzpANrGryu2I9Iq2i1N6UFDAI/aI
	IO72hGkFUvr30jlJHlYud1o0abTmqRWgoDmk0mZWOFlTtzLcZ4sM9S8pRPzvKZ2mfyfducN5anqmL
	vicIFboW0I4dlJ8omWpE/FP0WArmQzVrwhG8lWP+3N//3Rz5OLgVqM+FMP8cp6rwvaJ7C6rU2H6ZW
	harnrQqA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0FNz-0000000GGpB-1qZt;
	Sat, 29 Aug 2026 09:30:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5500A300382; Sat, 29 Aug 2026 11:30:02 +0200 (CEST)
Date: Sat, 29 Aug 2026 11:30:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>, Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH] KVM: x86/pmu: Add mediated vPMU PerfMon v5 support
Message-ID: <20260829093002.GC776954@noisy.programming.kicks-ass.net>
References: <20260827223755.143247-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827223755.143247-1-zide.chen@intel.com>

On Thu, Aug 27, 2026 at 03:37:39PM -0700, Zide Chen wrote:

> Dapeng Mi (6):
>   perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
>   perf/x86: Remove num_counters_{gp,fixed} from x86_pmu_capability

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
