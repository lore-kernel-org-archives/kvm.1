Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341E1D7E5C;
	Sat, 30 May 2026 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101939; cv=none; b=pgiEEFTD3YNq74hWCqG6KoLPeBUmt5qNoxEYWCN3zVqLI2h4xCImDI6CZcJqzqFhN38ZOA1PUKrA083yoJKeFQsRhMjZtygQddH5CXTc+eji7bW1kkek5NORTPM5JPfU1IJFLaVSGI2eoOlY7WTv5FNEkP6irtiWXeaJRoBDfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101939; c=relaxed/simple;
	bh=q0PYgiYksQ6rU66hJDHbPkOrKmPzpWcJ2nP7nSyVWXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyJ3Z5xEMPG1VQg0l+6Czv+11zz0PpSPuNRFdp3WFD2wsqglr9ZXnk/1FPbnT1a+cBwj6N0VTpC+5qGL1sSzT2/zvGv9BzySoRs4aAaNABNGMEtAppI0apmJO0NL4p0rfhiroK73AKZ6OiA2Yx3V0gPjPIxmDRBqDERWOc6p2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXxdi9O9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXxdi9O9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF80A1F0089A;
	Sat, 30 May 2026 00:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101938;
	bh=RmPJM9/1coWe6M9t8EajFJfZ9J0yMphFfmd5WhaihQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BXxdi9O9jpYgyEtcYYSMFq05NaMNekdBlLG+/lxo/VEEfdle5KX8sHCHP3yjR7hRT
	 i60QBOUnttvrczyGaT/9BC8BCq3hmjEeOgaj8eD9MpuL9ytF/QF5d40EJw/QJUx2Eb
	 fVWfdaHUtoBc361SzZ64qtwSfIQpQC4R9MuFINRr7VqtxtgiSFfbNDRcpVETUoPVnw
	 F9I5j9pOXEuicogIUA3dDQUHazkGTOFeC0ek5Bqz2PukxQ1LdPbDoBdmALX3Cg3C2E
	 69ij+4piQrYXnCdyNyo6grz1lTUlJm5xlGGgiJJ3+5jY1nmadnMKsB2DzDtEjCrdi7
	 Ao4Qz9q3I3w7A==
Date: Sat, 30 May 2026 00:45:36 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 17/40] KVM: x86: Drop defunct vcpu_tsc_khz()
 declaration
Message-ID: <ahozJrtoKz7t9EoE@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-18-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-18-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:00PM -0700, Sean Christopherson wrote:
> Remove a dead vcpu_tsc_khz() declaration.  No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
