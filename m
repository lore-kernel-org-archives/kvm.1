Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A227B353;
	Sat, 30 May 2026 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103487; cv=none; b=V6yD69q+iienYJrYoVHGkQiNUHgrZ8dBXvHgQnmKzbQE1K+TN4n1G8WHm+9eFH/UVcOvEiOj1sekbO1SABBD2JPFPTXpPaQ5UH6IJp+BvfJ4y0by2739P6EBVnGSWJKEcSj9T5h8byYzcyHSvXrONMJGBD3A2k+RAaxZNMNDk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103487; c=relaxed/simple;
	bh=EHiStX81IyL3N0bVJwaE9mIX52w+VqheOwLqZhiYzbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUYV7DwbVQDbssaswKhRUnmwYe+tPgBb0BZbC13l8Os4hHfXkl3M/ZP6ywjJ/ya/246/Ka1k/4GGaaC9vQnCZKkJcfZbJ+zBjKclufbWuGq/6wa0NPZ9XbFdBaKgSVy6OvTDEq/XjjktaodmU4seQgsAOiDua1nEdnIQyKgSx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp/B8kri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp/B8kri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517F91F00893;
	Sat, 30 May 2026 01:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103486;
	bh=HIXsYyS7uDVPYBauuS5J9K1uc+ZNQR2K0QbXpWbJMLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hp/B8kri3nhwuH2z2TnPIVzPU0Jn0IIJlpBwFHJlqqal2D566YLMRAsAjJImbq1Lw
	 B+cTgJGGVAqZRDyrcFHtfum04e4N92wvgDilzFpFx0gcR7x8KqWBtS1+kEvhfNkJ4X
	 N0uGRZaKT3nPAq6q7BFOuiRwthu3CWxW335VfQvr41tPF7XjzZR41Wu0qPQ7BXM7bL
	 hzDZVE6qAIP21sE1VEw3IggQPyOWQsbv7siIum4DdAkh7wi9UB1s0yPWsFawrLzeIU
	 oqFC/Ik4VXuPywa8TJgsSP+Bc7TdnUZPSHFXUk/+X30tZYK5kB0BkwskZP/JkKV/+H
	 Y/Lc2aI//ypXQ==
Date: Sat, 30 May 2026 01:11:25 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 37/40] KVM: x86: Move kvm_pv_send_ipi() declaration
 from kvm_host.h => lapic.h
Message-ID: <aho5Oef00ldJ_3gS@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-38-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-38-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:20PM -0700, Sean Christopherson wrote:
> Move the declaration of kvm_pv_send_ipi() into lapic.h, as its
> implementation is provided by lapic.c (sending PV IPIs relies on the
> optimized APIC map provided by the in-kernel local APIC), and it's only
> used by KVM x86 code.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
