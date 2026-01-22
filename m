Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E72D0C63
	for <kvm@vger.kernel.org>; Thu, 22 Jan 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045302; cv=none; b=gxWzNu+2wc8TX3R6lgD6nlCA1LMBILCIK1nsjayW/9XjQXsdLOUn0uj+mE2hchQPreHUYIIrdxWlG3E9P2UVebHG5+GtqSyN4mrvIZSymZUg5IZit1qrKN6XoBpLHk18+8xhbSpnyu4LRp2LFy7RXr7i3UuyoL4U0ZO8C1IG20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045302; c=relaxed/simple;
	bh=bS3uJGcSc8XzWKau3wF/igzdk6MwAfqPuCz3Fm6ZEdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSYiH7CnQHOBdbxGYLY4deHupj1r4gbpWfftU5JsdoQuW9uQ3ld4rR8nZ80l5owYm6Hkr1nonRRE3bPvcxwk+akVbnjs5/dJcRsCXaGNYLddrFTFp16AZatjb9zSDm4plEdOwO8X0V7HRSv3PoApFD8zaWkD5Z1fYueJ2cz3W50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cq00LJrY; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cq00LJrY"
Date: Thu, 22 Jan 2026 01:28:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769045287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F2ablW7VskYcPWkbB6tN0UjDv6XdHdkGDUS5v3E2wMM=;
	b=cq00LJrYkg7S808DLke5tkuUy+pERkK/OFMo68an51rUDlOY7Rfw8eKVQCyIW1ovfvoMWr
	OH9D7FhIa2W+72Iz5CEJ502gT1Mc2c9m1TzEuDO4IHnYrRAl5MYMkzr0ugyk06gMCLUGf3
	gvvoVsMM1lO0dM0/AocOlAndPoZIrQc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/8] KVM: x86: nSVM: Cache g_pat in
 vmcb_save_area_cached
Message-ID: <e3j5qgrdjad7ura7kodfzcagynvrkxv227ddg3jfjknzewvyay@h5pb67muiycd>
References: <20260115232154.3021475-1-jmattson@google.com>
 <20260115232154.3021475-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115232154.3021475-3-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 15, 2026 at 03:21:41PM -0800, Jim Mattson wrote:
> To avoid TOCTTOU issues, all fields in the vmcb12 save area that are
> subject to validation must be copied to svm->nested.save prior to
> validation, since vmcb12 is writable by the guest. Add g_pat to this set in
> preparation for validting it.
> 
> Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")

g_pat is not currently used from VMCB12, so this patch isn't technically
fixing an issue, right? I suspect this only applies to patch 3.

Anyway, I think it's probably best to squash this into patch 3. Also
maybe CC stable?

> Signed-off-by: Jim Mattson <jmattson@google.com>

If you decide to keep this as an individual patch, feel free to add:

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  arch/x86/kvm/svm/nested.c | 2 ++
>  arch/x86/kvm/svm/svm.h    | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index f295a41ec659..07a57a43fc3b 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -506,6 +506,8 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
>  
>  	to->dr6 = from->dr6;
>  	to->dr7 = from->dr7;
> +
> +	to->g_pat = from->g_pat;
>  }
>  
>  void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 7d28a739865f..39138378531e 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -145,6 +145,7 @@ struct vmcb_save_area_cached {
>  	u64 cr0;
>  	u64 dr7;
>  	u64 dr6;
> +	u64 g_pat;
>  };
>  
>  struct vmcb_ctrl_area_cached {
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
