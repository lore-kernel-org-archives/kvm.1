Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD123C50A;
	Sat, 30 May 2026 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101481; cv=none; b=kJ+plNG3Zbw4uKhk4ceLh/ydBEZhP7rKra5cV944rrfAW97wOz2OcSxkfgDQU4yl+jgioHVeyzjNyqc/DbyfjgrvapdrB7voeSoCUnU/k471asRlh2qBbKUIjIVkxv2Mq6Sl5x/xUFtMB5/o+KyWSlpW1GLODmS6VDvDXufSrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101481; c=relaxed/simple;
	bh=GaauZXPOs5p6qKgNrufuUVdmSfNezS16/zfJ01shabM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGNHtfiDIin050VlkCjywulGK4Etgpil7oPAVeZNmfZrz5j8HT6YpCFpE7k3EI6u7pzUcSnyodpKtU5sWGrd7hb3K6QmEvnJhIcECjs57CGdESrRY193oADDfPrpHnuCuH+xZM6ZbB4uxGExBcB4lyKiT0yItlvOJYOi4UpSCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8RY/ki6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8RY/ki6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D80D1F00893;
	Sat, 30 May 2026 00:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101480;
	bh=040VMWCDSP0EmPaEzZHNz7FVB72vyg9e2SuN+CYF6pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N8RY/ki6ORESwAkgkykaCIeKuVwUpBRRAOWCjnCL7vK4enVOeRepAZb/n/wG/pRmx
	 JMn1sB53hjAQBV07vmZiIpaO2p+3SnHOOnJgqxCUwo4fuCY5+Gk5WpyVqvv3LxyPQ9
	 bN83GCUMv8WPSmAwDB3DVUvEXSqN/efRtikrfDcE9cM0G4zSwXctt15Ox82zah+B2j
	 eqY4hf8qwpJIrUJogGafeGVB8aRgkO6VCTCcGVT5SS8d7K73vXm2iJ6vLMWuR39XvK
	 WBz2eiHj416Gk9VaCba6cnto8/fuawo/gDOJNbrqzRoBthRQ3m5HY681Pam7QrCKhF
	 JLcgLv9b9DQxQ==
Date: Sat, 30 May 2026 00:37:59 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 16/40] KVM: x86: Move local APIC specific helpers out
 of asm/kvm_host.h
Message-ID: <ahoxYcRHkKVPtc-t@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-17-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-17-seanjc@google.com>

On Fri, May 29, 2026 at 03:21:59PM -0700, Sean Christopherson wrote:
> Move single-use local APIC IRQ helpers out of asm/kvm_host.h so that they
> are co-located with their user, and not exposed to the broader world.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
