Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F21B4F1F;
	Sat, 30 May 2026 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103168; cv=none; b=RYp5EVnLFgakZo9YB4iMeLh0pdnrjaYJJkxszshxhGVe3c2wQVqbrnASntbfM2V80evj23TZCfbSaCIo4ERgmchHW33UI45PshDgNRZKNtjMB3XrNFZTi2LsBRdufilQBW1dliKY9HYbwRhOQyCJ2uC7SmkwwPp9gOptuRsucZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103168; c=relaxed/simple;
	bh=9k1einy4eaXQLJM3Mfvny1Fg219T7Pzj8KqKHwcwGpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3FIJnbMmgsN2vzbGwtfZxtNP/ou2ZP1DULE19GigqSh3Lt0JI/wT8kl8a4EM1sbZ1fxIIs46kyxGFu8/PHT6PcQq+X+yxUviyFWNoNxJclh5H0S43sV3MqVd+x6euitB8+/Vbqg1zrN+XuRU+P2aqX9TVbcMnEvaOv9QMs6rbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0AcoMSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0AcoMSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044D41F00893;
	Sat, 30 May 2026 01:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103167;
	bh=oGsJYfc3UzIyO8mFa9AyZZW6LFn0I9odK8gg3EUafBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X0AcoMSkavxDiH7z71fRPEGO/JjO2Ms4CZfoKUBLo7VZvLAfCbzREQpAIekD+6xwb
	 sE250m/ldKIicf8so++VxbucGMnUIMVaLoTwSG36lsdxVEnapKVe54Hj3XALkBp343
	 HdXgkv9w7IP2s9ax215mwpNzuseOm4CGfLy40vpP+ZfQ+d0HudZvuJi/KS/y9il6cD
	 cHBue/T4cyPOwR+x6lBH0xjlVj+RV+8oqbKVm3p8aOmArGk5kFkhs6W8It4AcGH4nH
	 rXhyXiZvdQWbAjdj//n1slo2KqlDl0b8zg68LsVmVIh6u0RwcRgJ+xJ9DFRAEYup96
	 bZpPj5WqwsSxA==
Date: Sat, 30 May 2026 01:06:05 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 35/40] KVM: x86: Move __kvm_irq_line_state() from
 kvm_host.h => ioapic.h
Message-ID: <aho3-bZD4S7MUGCh@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-36-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-36-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:18PM -0700, Sean Christopherson wrote:
> Bury __kvm_irq_line_state() in CONFIG_KVM_IOAPIC=y code, as it's only used
> by PIC and I/O APIC code.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
