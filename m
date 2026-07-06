Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B69A2D1931
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343108; cv=none; b=fZXEYjqUDOZrgcP+cyqFJNoM1ITeaZFkYPcOFWBvT+wcgNte/UInvUDcvKZbUz/Z3GD8lXrt9pLl2xAImY3mCvNr0iPgXtp0FfR2RUoX2oHMhMCYw3LQofP/7uLqrrzzDf08VM7pGrmBKSUVLQ+DRn8uXAA0XKwPRWYyRFmXnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343108; c=relaxed/simple;
	bh=VRbkijzHlk465V48tu/W9c52SmEgHDhAUxxTQEEVc6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEQOvZnZPxZRzIshYYa1QGtP2r9Nqn4ke2EcP0NL2wCUANRfSrUpnL6cf2mSZHWPmduqrhHWqK3GcLuAViQKwsvUXHNnTMxj8wFRCCyFu9epdmNdoHUqUaAnSGNgqI1j200JJEykEI0uNm3bAokeSsPKxcThsG3RgyKABfd4tVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nZ9OJYHR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nZ9OJYHR"
Received: from example.com (unknown [167.220.208.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id D353F20B716B;
	Mon,  6 Jul 2026 06:04:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D353F20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783343102;
	bh=42ZU0Iw+ebDa0/X5YhAcUnBEM087OQr1GBPIsBa3FnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZ9OJYHR63/bEOzubXphlQMJ7E1M4wExiXdSbfdHvzASazJByZiZh792Q+8afv4z8
	 DdfFlS9aaPFEOH4tHQP6l1IYG0EUAMIMpvsiOCz855WIkcbXFONjUx4JPRkLfXyxLY
	 0F/HyOZdF6HEJXz4mkwRo6IICRFtyJMhKYNbVTAQ=
Date: Mon, 6 Jul 2026 15:05:00 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 26/34] accel/mshv: introduce SaveVMHandler
Message-ID: <akun/POlVcGDKoxK@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
 <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>
 <akfvt0nTdVKZFOmJ@example.com>
 <CABgObfagW4TRZ5YcB-8SHizsjd2BafrcvTnu2fAkyV3_4_GT2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfagW4TRZ5YcB-8SHizsjd2BafrcvTnu2fAkyV3_4_GT2A@mail.gmail.com>

On Fri, Jul 03, 2026 at 07:50:43PM +0200, Paolo Bonzini wrote:
> There are different "schools of thought" for that. Freezing introduces an
> incorrect timing on the destination, not freezing introduces a jump.
> 
> If you choose to freeze that's fine, QEMU does the same for KVM even though
> KVM has alternative ioctls that allow not freezing.
> 
> But currently it's the wrong
> > place. I'll find some more fitting place to perform this ceremony.
> >
> 
> KVM uses a device for that, see kvnclock.c.

Makes sense, kvmclock looks like a good template. I'll use a similar object.

> 
> Curiously the time-frozen source was obscuring another potentially more
> > serious bug. The mshv vcpu dispatch loop currently does not honor a
> > cpu->exit_request
> 
> 
> Was that related to the other patch that was touching the vcpu thread loop?
> 

yup, we need the same here, I'll address it as part of a migration-pt2
series. we only need to check for cpu->exit_request and break the loop
if set.

best,

magnus
