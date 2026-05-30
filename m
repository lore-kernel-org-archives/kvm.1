Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBE23BCE3;
	Sat, 30 May 2026 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102274; cv=none; b=Rg+hrAebjzE1G/dGKSzaa0NEWqNY6Nq1T/G//ytiqXcYMsmicQr/aWyiRGjccckOesRMFrOQE4olFqMSuj1KNBIX2BZx/YTCYagUQdWUBc9hcCSF+40FKJEc3UrVyJ/OTAIA0hK2iNOwaY+scwzS3QUohh0+/7+j0dZgBqXIi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102274; c=relaxed/simple;
	bh=CfuWkzZ9eodIsrreA3VfYdr+O6tZH7IE8kU5R6UAu8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ccx2rbAyOcmsNd40NqvHmn6wPNDI28YVpfsIXJyzmwF70Csi2Hbalc5XtIytSOYW1SVutXp82H2JQSzl4KKP6xfU+JN5CijO5GIMaaeqxlV+wEV5khzVxaYEv8G3eJaJNLmilI+MrbguwPMmgpJloJcT2wvw+0trS0XMiiEcdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqGt49oh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqGt49oh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0CF1F00893;
	Sat, 30 May 2026 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102273;
	bh=kmi11B6aNHJ0q4JD3SybFjJVSLkmY3de2M0Nrg4zrag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TqGt49ohCLVFkY8L8YyWk9d96eH/tGpk7rqOUXRjnLJQPYpSqV+Af9vppabA7Cp9Y
	 YG1Tt4dyRO7K7I/r0gMrCMuORsaxtFdY8dYYsTxrKSEbErAqmMWLQHKsmiIkp5ta9o
	 8ruIikcU7iuqTaUnisJk3IHbBszNbRNhfggJ/7Zsw3660vtdUrg6RXB4meRdk2HUg+
	 ifPT2cayWHhdgrGwZP3MhWIlhLivdHPmY1DQ/KftCOs52c1WPJKn5LfYAxaBIH3+aJ
	 17AzZiLyTPtD94MrcSnv0fGUotclMGYvYWm6HRnOFYHsX+rWIFKeHxPL/NwWLdiWZW
	 W4bdEcIsLn+2A==
Date: Sat, 30 May 2026 00:51:11 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 20/40] KVM: x86: Move tdp_enabled from kvm_host.h to
 mmu.h
Message-ID: <aho0e-WZ60E2afd1@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-21-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-21-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:03PM -0700, Sean Christopherson wrote:
> Relocated the declaration of tdp_enabled into mmu.h, and opportunistically
> hoist tdp_mmu_enabled up to the top so that the two are co-located.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
