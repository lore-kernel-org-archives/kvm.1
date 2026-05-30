Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408C23BCE3;
	Sat, 30 May 2026 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102300; cv=none; b=hHnAZMRNEMkIJPcb/p+HBPo7O0vMvMsF8eKcszGTVqf0W0zwBsT8X94EhWZA8CItcfarQQA3AHZ8g+aVuoi5QcHpNqTg4iwFbBHyUS0fyx48lAEvMbaGDnwep2+i440MXZoISEPo+a54Q2u0z4tgamZyMoJLnO0vXgtJVMkiZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102300; c=relaxed/simple;
	bh=CAHBf1X+7mGonrBu2bUj8QeEoZ+z5SBSI+Emkiccs20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpLhVETn6pi0c9XrXqKtkyMlotZQJTn48XFuImknGGrhGexC67zq3tM3fkjSnkDskpYwORvKjG98sAcNS1slxXlA50IHjzWl/TVB8mnqO6kdhsAk85gESwltCbJzP9QpwGqfHifk1bdrzOcJxWSnE6ETu0Chk82yx1waCd2dWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqI01lie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqI01lie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B23F1F00893;
	Sat, 30 May 2026 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102299;
	bh=EnaWYzO1b/JANA84iu16nQZY8ilevGECf4LAyfkKzGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QqI01lieU+ryNYS9mA/U3Aohh9XhGmYBg1s5iXAe+ehtGEbMy+p8mHzCZ4deBtTvu
	 NNEmRnNMxRBqm3k9bkl4exu8CGpY1KibuYmh8Iw3giI4aFzGdWd9jPQYNFyWCHxODy
	 3fqQfbGv+FPscUZCCUzw8qKFpvR3Pl7GOmThKNp39w2iPD50lkDkA3wkRYKnWAAp81
	 +/lGCN3peD27yXPbZaHctXyExC8wCpxUjKAcAxMeMoFC8gHPPJN35t10VMm3eGdv/4
	 k1ECufO/gy8uG/nxybz7fCgGFrPOt5pwzQZfzdHk1dP8qJMBXf9rk0Y2JgtfMPb+fX
	 7yHZipgbGraXQ==
Date: Sat, 30 May 2026 00:51:38 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 21/40] KVM: x86: Move eager_page_split to mmu.{c,h}
Message-ID: <aho0ldo-GaPaUede@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-22-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-22-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:04PM -0700, Sean Christopherson wrote:
> Move KVM's eager_page_split module param to the MMU, as it is very much an
> MMU knob.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
