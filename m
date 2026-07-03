Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3C2F9D82;
	Fri,  3 Jul 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096028; cv=none; b=FobgsdUWE3TYqlOj8nIBRMfO7MqbyDHIyAFZT4SdnIdMF3utV7xQbv4iai03cqnOCOk5f9fJkEJZUWqtVV/InTPCLI8D1d5aY1epPmjjkP5a39WysL6q4Kb+0azMnuMbeSt1jeexbsPcRVjdSE160JtTUT2tvS+xwz4Z32aUkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096028; c=relaxed/simple;
	bh=E5YdC0EUxSIqPrzUkLzrNcsW+fvOn9/6E2UGyhWAL1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idh8+SRlUzbP01rgieIqxIwBTOpjxlNtjgSoJqdS/sXHFwTjsGn+EMesbSnAC8CEpRYAIaiBfdCJ/1LKJJC2pzoxS+457i/B659heoCyuvqSmpdyqVxom3ZvlMpFFxDKlWX2V36NwxHAZE3xnO/WtK9PaoR+7/RxvEo1YvTQxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlKW4eTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlKW4eTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2D71F000E9;
	Fri,  3 Jul 2026 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783096026;
	bh=7jIwC2dc6aHQmSKX7i7Er/g6tQpp6jzUJ58r7lRAw/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AlKW4eTKNsB6Wu16dpfssBXDe12TuZYtLh0w1xrBst9rH+u6m4iDBN4F8pwSk7LbX
	 bkcQHcZCISz4UEJ0jSpIjIAF+D4xgU1rylNf5sscBifdAAdqgsrUcL5Ssh+RAjZTj4
	 /pUoEg2X2IsNjvWl3npOKQZHvbkoLvX3wYcSsRuTlAwfGXH1om93w+R3w0KjURzXBN
	 /2FvTtgrpR6datbgdC3zoZhmaFLd6R5zdhhDI6fPimll5vYk8BHoXeApMhgXAX2MX5
	 OhX9NYXKEyUUPf2JZ3DbN5kv4mzPDFrGv1z3PSOa0Rf5S5aQwDgcC+Y9BNA2w49/hb
	 SRXV6cO6JhNOw==
Date: Fri, 3 Jul 2026 21:55:16 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiao Wu <xiaowu.417@qq.com>
Subject: Re: [PATCH v2 1/3] KVM: SVM: Make kvm_x86_ops.vcpu_precreate() hook
 fully AVIC specific
Message-ID: <akfiPEKZguDXPs6I@blrnaveerao1>
References: <20260630210156.457151-1-seanjc@google.com>
 <20260630210156.457151-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630210156.457151-2-seanjc@google.com>

On Tue, Jun 30, 2026 at 02:01:54PM -0700, Sean Christopherson wrote:
> In anticipation of deferring all per-VM AVIC initialization until a vCPU
> is first created, move SVM's kvm_x86_ops.vcpu_precreate() hook into avic.c
> as avic_vcpu_pre_create() and nullify the hook if AVIC is disabled (and
     ^^^^^^^^^^^^^^^^^^^^ avic_vcpu_precreate()

> WARN if the hook is somehow invoked without AVIC enabled).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 13 +++++++++----
>  arch/x86/kvm/svm/svm.c  |  8 ++------
>  arch/x86/kvm/svm/svm.h  |  2 +-
>  3 files changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen

