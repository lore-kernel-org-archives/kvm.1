Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5D1D54FA;
	Sat, 30 May 2026 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102792; cv=none; b=ZhoNyco0LTj+P7jTs79VvQwtnxG3D1P4ssy1Exb/nxkwGUArcZGhpEjsuGrPSHvtOUQG3EUz4cwm83bHJI+rCOgLsmz4VNVWFP6+cyUM058ZAKWZcvnZeADv0mrylLEfMPUXt6AgxGGywb7TYmJhNkBvXHcbfdSpmsaPxJxZzYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102792; c=relaxed/simple;
	bh=yCkRBnspTuVneGADgp6nxIio5dmxSv5+cJ6nG9I4inY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9PXQEk6umMHKvon4DC3DhUknVMKMGAco/DJRCxPUweZoD+REn2kBI6k7DW9ZpqH2WdEtZ6VWxFuyrUKqq0s+vbzKBMg62jgayJGMGO2okdhahen6ycjwzToBEDMCLl0JkgkCLwsWqt/MGpf6Squ0xzTkxyoPSZQbLOniqJDF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQMEJ5rG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQMEJ5rG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF5F1F00893;
	Sat, 30 May 2026 00:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102791;
	bh=gdC+QmRcEDBjgDVYxkldfrYenC4fK0CfHjKTPQYQeUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XQMEJ5rGB94YO4Tnh8WGBsIaq6BOU8Zm7fkXS9Ijo9zPA62juu2yjYMoJqtl2t7cN
	 9+ocZPga9/UndrA8kl4hn+eACn9/YtUnqfqUJW5qv/D03N/t1enHdECS+2hNSYlGzw
	 9bug7OZQfUVsX5/95jXsdI/ZZ80D5yk4UYWQTw1t91pUXNhd3fwaJehm28deLwolp9
	 vCuV6w0YXtQtmiZzmTjhDvQOcA6EhLJ1X00P5KCjvVtiBspgR7TchUvRAohPq4ORIS
	 WZ41axEIXoGmx7VJAuCoDI67bG69yIiNs2MVc9TTGHnabYepNXtU5ECfa/9/BfYNEv
	 FOo+B31KFmx9g==
Date: Sat, 30 May 2026 00:59:50 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
Message-ID: <aho2gIKKQ9titduu@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-32-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-32-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:14PM -0700, Sean Christopherson wrote:
> Move a pile of MMU helper declarations into mmu.h, as they are very much
> KVM x86 internal APIs and not intended to be exposed to arch-neutral KVM,
> and certainly not to the broader kernel.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
