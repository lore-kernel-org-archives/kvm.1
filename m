Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6818A92F;
	Sat, 30 May 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101805; cv=none; b=QCNXbgQB1CPqk2t9FRxPF2iOmqEETRGU7H6ZxsFpyhclNnkRScZSNoznZvHm61SWdpOELJiiiC0XIW4JDu/ZrEebHKdj+uRFkY7TNJc8gz5O7qACo3AcAs1bWIe46T5PR2KyzHoieR2mP718NBe9RyfqxuhFMDyXxZbfHptWA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101805; c=relaxed/simple;
	bh=jzp1hqbFK65Ym9ghOlovrnxKkyFjFDJXo1snf6aShzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjgH1MxEpghUj9h+eN0L5OeIso0CslXUsUf6/M2/QtnIje0LcdybFeIJSXRz26pqpDpLlqfYq1hoyWejCDYQfNZwKOckB0zq67b/QuZWT8QVQMoYi3N1M0+PsTKi0lsVfRRCpNh5nKq8N36pklaUfoD6Zmj6O1dHyr89RQHPal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpXFQTmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpXFQTmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C6A1F00893;
	Sat, 30 May 2026 00:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101804;
	bh=awl45865S/EsxhRU9qJtKqIW4zSLi3LEwx/k1d9l1Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KpXFQTmIsM135TzbeeReOokiQv6VBKqOFiPOMKhhllUdwIZE0+1I06v7dRJhUZsnN
	 iYfYzQtODVI7coR+Y5Kz61JKa662Udsaeb3zfVAgE56M43+Zdo9XeLkPVaI3vGUMZW
	 lntMYCi0UxyP38davE73ZSPLqwHnczCrIlMaiDCvItx9oSGgWvE3Ppbo68yYAfJGc0
	 T7gySh5Cam3GhKD324CATBQEc9QEK12MCI/pBSkEmmznyFEvOz1Q9r6YD92ChQiJMb
	 kc46w2+uzRVtq3sg887poyLeVrSBH4aruqfidpbLn8h7PosIIO9K8cLk6vBj+Z8pbd
	 yU16HLmk/niMQ==
Date: Sat, 30 May 2026 00:43:22 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 15/40] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
Message-ID: <ahoyE72rGb1dPrSC@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-16-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-16-seanjc@google.com>

On Fri, May 29, 2026 at 03:21:58PM -0700, Sean Christopherson wrote:
> Introduce regs.c, and move the vast majority of register specific code out
> of x86.c and into regs.c.  Deliberately leave behind MSR code (except for
> EFER, which can hardly be called an MSR), as KVM's MSR support is complex
> enough to warrant its own compilation unit, and doesn't have much in common
> with the other register code.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

This is not just code movement. You're also renaming and introducing new
helpers in the process, making the patch not so easy to review.

A wise mine once told me not to do this:
https://lore.kernel.org/kvm/aYU87QeMg8_kTM-G@google.com/

I have been waiting a few months for this, so here goes:

Stop. Bundling. Things. Together.
