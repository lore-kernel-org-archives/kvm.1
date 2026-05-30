Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE826B2D3;
	Sat, 30 May 2026 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102617; cv=none; b=dam9gdARjkw7NGWrOU+ZCs1GQfIiguEptuqG7malDhEqdW1TFYmezgMCtz7eFQ5okDNzMhmzqYUeZZp1mRACrF+XEswZEMdrJQq3jmT20iy8Vg9qxr/b4l0czeG9KaIGklvuHcuKmCjxSt0xXlmt8iCm3hDY3BkM0W01Xgon7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102617; c=relaxed/simple;
	bh=PQ4dHJr/jeDCJDnyK5l/Iku+inWWI+OFHCY53D+AYHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f04DXStAvuOLnGZh8LgEyWh7unO7cZRRwU5QLDzFwM/eo3FfAhOrT/GUYJFF4kbYEFXui9YL3K3RoS7Qx6+bYaBNhT9qx5CUquq55pMnV7NMWuVUjfBUyWQxpWhMXWZTm0a9LVkE5Rb/4hEGaVHhKPcSF7gi/CE7hkH24V443E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB8e6BLE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB8e6BLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FECF1F00893;
	Sat, 30 May 2026 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102616;
	bh=LsL8bY5Nb2bPBRiVP3XGffaPEQPZqfY4yC/B84vPftc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NB8e6BLEPD2Jzk2UTJhmotBVT0iGf1wfLFafhWvUWevky7coFVy+I0kS9VapL43yP
	 qE3y7tPnliseCo6RMX1BBTQssvr4p84M64U7d/tSrGUZRw9adB6XvE/OWm0pao0ox7
	 iXH/t7Q37VtaACsrmx1YnfQ55g+AdndDs//uy80iYLpmdsWLE20OaX99fDWgHqzlFl
	 M2VErwqVAWhsjKsqqHeJ1vn3kh0AQpyDjqQAWwxAI8RVmjh3zp5huLxzchpek4BXGg
	 bc4+53tE4jBZYbjo3SmJmoduG+MW5nvnkyJo77RftmjhTZhIUobCzJV5fVWHy8GiFG
	 qSkUTnn5G2KJw==
Date: Sat, 30 May 2026 00:56:54 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 27/40] KVM: x86: Move register helper declarations
 from kvm_host.h => regs.h
Message-ID: <aho1wgNn8pSgaBUU@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-28-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-28-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:10PM -0700, Sean Christopherson wrote:
> Relocate declarations of Control/Debug Register, EFLAGS and RIP helpers
> from x86's kvm_host.h to regs.h, to continue trimming down kvm_host.h.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 17 -----------------
>  arch/x86/kvm/regs.h             | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 19091d89d3cc..0f4b16b26a27 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2186,8 +2186,6 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
>  void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
>  void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
>  
> -int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);

Why are pdptrs helpers bundled with register helpers?
