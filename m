Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6131E85A;
	Tue, 21 Apr 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813999; cv=none; b=R6YpFqEdnCa1te7ApONMWUF/2mz7uElb+TdwlqaChpn+lzZzFSQcFQCsjvjTwXumH0oSYb3CFcSJDyRPfCoKfr0lMndhEqWDSgw7Z/oPMnZp1Up9dvVfGMEW7ej8yOBo1cjF4lqP/BcMefC96cjSxonR/H9tYxU4yiHI9el7AHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813999; c=relaxed/simple;
	bh=Lz8EL1X2ZM5g7nf1AYJz8AnaVclJoErh1YbS/7Z79gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doAOwcKcJXZ5wjWcGgYW7u1m8F3dRaGkRRrGbLNDLzoPP0WoSdyDflkdM661TFPeSpfziy2DuE4n7xmtB8sBLH9KkrL6gFuGdFmdyLWBb3GrlPODS95/vhucYEoDCZjdXouBah4EJnYJuhgFfvOV43fIcNskbB44FXVa77OEJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkco4w07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkco4w07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2DAC2BCB0;
	Tue, 21 Apr 2026 23:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776813999;
	bh=Lz8EL1X2ZM5g7nf1AYJz8AnaVclJoErh1YbS/7Z79gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkco4w07XJjSM5g/d1XXgTGSQoZScJvP0sIYtSnmzqtYPLZGQR1hU3yKSHTh41y47
	 cwwEO8IoASNs8aTZKp1jW6ayQ8EhejKQkfYTeBts3Ki4y3XJKGE0EZm3IAywZx4fIp
	 pY4V11oD8J/mQ/VyTYLwYd2K5MLFjk9ReXeG2r1SIwXndhZa/g/9Bq3sHyjqrKtzq5
	 rZ6CFJ5wQwpuFI6vt1P1Ch14Hwgow4O+69W2j3gGL+WkMqxow/5Ct1vkTRbkz5g1Mi
	 rbgxt8GeaH4hzmXCOTb6CCEKAY8OpBvNRGahD66Ub6wXzuLkGG/VuFebpGeVBy9Xcl
	 XW8904d9GEGTQ==
Date: Tue, 21 Apr 2026 23:26:37 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] KVM: SVM: Truncate INVLPGA address in
 compatibility mode
Message-ID: <aegHqAQrNGtpAhwk@google.com>
References: <20260409235622.2052730-1-seanjc@google.com>
 <20260409235622.2052730-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409235622.2052730-2-seanjc@google.com>

On Thu, Apr 09, 2026 at 04:56:12PM -0700, Sean Christopherson wrote:
> Check for full 64-bit mode, not just long mode, when truncating the
> virtual address as part of INVLPGA emulation.  Compatibility mode doesn't
> support 64-bit addressing.
> 
> Note, the FIXME still applies, e.g. if the guest deliberately targeted
> EAX while in 64-bit via an address size override.  That flaw isn't worth
> fixing as it would require decoding the code stream, which would open a
> an entirely different can of worms, and in practice no sane guest would
> shove garbage into RAX[63:32] and execute INVLPGA.
> 
> Note #2, VMSAVE, VMLOAD, and VMRUN all suffer from the same architectural
> flaw of not providing the full linear address in a VMCB exit information
> field, because, quoting the APM verbatim:
> 
>   the linear address is available directly from the guest rAX register
> 
> (VMSAVE, VMLOAD, and VMRUN take a physical address, but they're behavior
> with respect to rAX is otherwise identical).
> 
> Fixes: bc9eff67fc35 ("KVM: SVM: Use default rAX size for INVLPGA emulation")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
