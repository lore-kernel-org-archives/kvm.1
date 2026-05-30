Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57901CDFCA;
	Sat, 30 May 2026 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101334; cv=none; b=CLGxdBlkYLxBaUKCUNnw3naqaY1ZWVgRcKEV3ltXAJPyxt51prUO47x3dSySUsZz/8ixwjoUU37Rhit3lbsXTsn929KlLzVClGy+ANijba93D57kpe6/Uwjmw0HItCXBc5PL8WW617/2F3l5s9dXIVD3hZtrWdjaPZYWJPN5Xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101334; c=relaxed/simple;
	bh=QBSA7KxeRwUeH6FtW65RaU9Y7wPPtW/DMSO06v0QWhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJCUo2S3lr+saFSB3w8beQiogd3CD93UuoVE2OezOUtS8SECDwllg8o5McUnp+rNbIwk89nMpm8KVYz91WRXRmjkRdSQx57prnEPAU3EFtbrH1gZRg4xHL6ErZga7mxkgamsQzYkEkC93nhws8xZdFilwnVGtWkvueLYZwtrrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccE8Z2vn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccE8Z2vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0945E1F00893;
	Sat, 30 May 2026 00:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101333;
	bh=Ov1ZbnQKtJAv3U1mliYh4/D8shMvlzaAI8o/hPk/6Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ccE8Z2vnFJXgp0uZ04vJ+EjscvkAzyMPnYgJRhv13njnYQPHRxQ/TanA34a0Jri6q
	 qdBw0lhtDsKmpu3ib5/V5qKk8WSxgGZ6FagNxQLO3Whvw+wVVrWhMRChmxuYIpIrvw
	 MsRLM/y2WmqzhE+udlZbM11avSimJ7UQ65PZBSfFXkc8uFnLHfeptBHESXgq4G5gV5
	 FWOzbH2RHZS7y4kaEsKrubZn1qk//XAyTg4C2pYp68z6cpFobTtIyOJ1P7NRcjfpG/
	 bwmRNwsvLOnaTOvNYcwqNnxw2i+0INS2EpLr1kYXUJtjEUamVJmESDXVisKmbuVp+M
	 azLo7mRL6kArw==
Date: Sat, 30 May 2026 00:35:31 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 13/40] KVM: x86: Move update_cr8_intercept() to lapic.c
Message-ID: <ahowzByZvJKCwYHR@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-14-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-14-seanjc@google.com>

On Fri, May 29, 2026 at 03:21:56PM -0700, Sean Christopherson wrote:
> Move update_cr8_intercept() to lapic.c so that it's globally visible
> in anticipation of extracting most of the register-specific code out of
> x86.c and into a new compilation unit.  Opportunistically prefix the
> helper kvm_lapic_ to make its role/scope more obvious.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
