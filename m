Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8363009F6;
	Sat, 30 May 2026 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103640; cv=none; b=TFOUIpyvpxbfwtZjrLZyqJHuaIJRBi8z6WnXc0XOVwZxlDsLFx013ejJqAeaits4cFj8FEJSnOXFdDdWwd1HGohJoxH8r3wbgSxJfrd2D1IpaLYqw28ziu8XSM3JvYTJOf1b+a+MoDDGTKp6gTbz+5KPGqvcudrwt/A5xJi7uYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103640; c=relaxed/simple;
	bh=i4CE6Grdtke4vZk23r7Kbd32RlsXp9u3f6sUqZ3Uhog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRq/PJvpM6WJpt9Om0pNc2LBoZHI3C4NJ24SbGEgHMphNR5VzaTXAPnu8Y7S4I6fKDCAeecxraqaqtEc6s8vt1Znx5WGJRieXVpu/GIXO8vm64kYi5t7Vt6qBs/1HJXOBpRuM3wiOWKMpYrzAagCu2/R9ORVW3KPbzw5gJUENbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niegSwDO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niegSwDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B031F00898;
	Sat, 30 May 2026 01:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103638;
	bh=G811STGc+pZtGvytfcu867pbCemqUfncn32U69vG9xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=niegSwDOSx6JUHJUmwWDby0ayimv4mny4SuWKPzV89bDLPXq0koEegx7SC3bKnXAV
	 Ci0YiJMlSUWzOXDcZ/LXSIxEdhRtVpa9Gp0QCsV6jZZvV0DQdaWqTdQDskk7YdPu6C
	 jHpMoPgiRJmTfOUTZDzyfxKa0AXkIitywpdqpD1ExEzFBNm1gB6EZWmF8OncnNP15C
	 QH/rlGM1/huAKPMV2VzCpCr1nvBa/vj+Es2j6cGaBtLv4voiyOwk2xnuS1H0RU3eTP
	 t1NG92NTkNPDpC3XfLwZnRc9wFj1GWAzBB+GmuzeERFx1PqdZq2kV57xkq3xUwdJgs
	 WHjtIfcy69O0w==
Date: Sat, 30 May 2026 01:13:56 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 39/40] KVM: x86/mmu: Move kvm_mmu_do_page_fault() from
 mmu_internal.h => mmu.c
Message-ID: <aho5u4b5Sx26Uc_U@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-40-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-40-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:22PM -0700, Sean Christopherson wrote:
> Move kvm_mmu_do_page_fault() into mmu.c, as there are no users outside of
> mmu.c, and the function typically isn't inlined by the compiler anyways.
> This will allow moving the EMULTYPE_xxx definitions into x86.h without
> having to include x86.h in mmu_internal.h, i.e. will help preserve the
> goal of making x86.h KVM x86's "top-level" include.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

[..]
> +	/*
> +	 * Not sure what's happening, but punt to userspace and hope that
> +	 * they can fix it by changing memory to shared, or they can
> +	 * provide a better error.
> +	 */

LOL

> +	if (r == RET_PF_EMULATE && fault.is_private) {
> +		pr_warn_ratelimited("kvm: unexpected emulation request on private memory\n");
> +		kvm_mmu_prepare_memory_fault_exit(vcpu, &fault);
> +		return -EFAULT;
> +	}
> +
> +	if (fault.write_fault_to_shadow_pgtable && emulation_type)
> +		*emulation_type |= EMULTYPE_WRITE_PF_TO_SP;
> +	if (level)
> +		*level = fault.goal_level;
> +
> +	return r;
> +}
