Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554C1DDC35;
	Mon, 13 Jul 2026 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940554; cv=none; b=fuURqaDgr+PGeKnt8j1mABzEgR0gVc/6XN7icDMJQK/E2N4h/rwQBCT/NnTOzT2CzR3uBwd2XUJjsz6gkuHbUmHc32WitnyKB0Aw6bTBHIRYIzp+G3wu4hrOOkjbCLgSJAGDSr5hLZkkCUTjIZip3VUYyUJfCnF5AfTbk2zMluk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940554; c=relaxed/simple;
	bh=EZAazzo66x7ORudJtvxZhA5ioBOSUboJ9hOFqGI7uuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stIc0k+iU4vW4bCor/K2nUqZSKty1r9W9YfQEBkE8Mh7AGINkhuJrJiOlyf98rI8fCMNtLkf1h82M+95H822GZLGvdZLeY4g/9KWMFiYwGriEvEj+BiVsY4A2EHKZqG4wjdQPSlpWrNDLWOU2aZudSZY3r0iH8aGAVUQ4DnVSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2U/HwIb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIH8bW6x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2U/HwIb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIH8bW6x"
Date: Mon, 13 Jul 2026 13:02:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783940550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4cZpFs4H2e3pr/WEZQZbk3vQfEsgZgb/66i7BAIy4M=;
	b=L2U/HwIbIWwdr5tuyX9T6BENGEwwxGsmfZLRb/C5EMS1v4Msjs0sUyXKTRkPu+vzCI7rQX
	qqNRZHhjsseS5PLrOqXNF9P031VK5gPAe46k6uai01qkoowbAFWcl+/71t03prpGlTlKJv
	FeV4tfmsmy1krEMuv97E/Zejy7MpUgDZi0BrqtwZ1Xfr/vBwMwp9LpoVTJIFv4K+B92lmP
	qO88IqNBpLVEjEeIj5/ThFXsirAZ7srWHanIUEyPgq34VPR7UhIWuPHI+FuyICzAnGgP0z
	xzerj4bK887yAr4fV83Iuh7i1DmFNjuaMnOiTq7LmyUDXIbbvixvp/yq7+DHUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783940550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4cZpFs4H2e3pr/WEZQZbk3vQfEsgZgb/66i7BAIy4M=;
	b=TIH8bW6xGYJsXu0khLzfi+wNlUO3u4xOm+t1InkFnNKVDFWs4wh1PcwcsP9U4dt6t3PUuw
	9RwOBn+KZef0LXBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix null pointer dereference in
 trace_kvm_inj_exception
Message-ID: <20260713123938-0f35bcb6-241a-494c-81a9-d5e17022951f@linutronix.de>
References: <20260710134055.16432-1-danielpaziyski@gmail.com>
 <alE9J1SjQSNHaV16@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alE9J1SjQSNHaV16@google.com>

Hi Sean,

On Fri, Jul 10, 2026 at 11:42:47AM -0700, Sean Christopherson wrote:
> +The Other Thomas

Thanks for the forward.

> Just as an FYI, commit 754e38d2d1ae ("tracing: Use explicit array size instead of
> sentinel elements in symbol printing") broke KVM abuse of __print_symbolic() where
> KVM deliberately passed in an "null" array to avoid printing 0x0 when there is no
> error code.
> 
> I did a half-assed search through the other usage of __print_symbolic() and didn't
> see anything, but just in case someone else comes complaining...
> 
> On Fri, Jul 10, 2026, Daniel Paziyski wrote:
> > The trace_kvm_inj_exception tracepoint takes as arguments the exception
> > vector, whether the exception has an error code (and subsequently, the
> > error code), and whether it is being reinjected. The error code is
> > formatted to the trace log as a string using __print_symbolic,
> > which takes an integer value and an array of structs containing a mask
> > value and a string. An empty struct is being passed, which makes the
> > kernel derefence a NULL pointer when the error code is 0. Remove this
> > stray struct in the invocation of __print_symbolic.
> 
> Fixes: 754e38d2d1ae ("tracing: Use explicit array size instead of sentinel elements in symbol printing")
> Cc: stable@vger.kernel.org
> 
> In the future please provide a splat in the changelog, especially in this age of
> agentic bug hunters that are prone to making things up.  My initial reaction to
> this was "no way".  Thankfully, I tried reproducing the bug before making an ass
> out of myself :-)
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0 
>   Oops: Oops: 0000 [#1] SMP
>   CPU: 20 UID: 0 PID: 791 Comm: less Not tainted 7.2.0-rc2-3ffd29d795c9-x86_trace_ex_null_ptr_deref-vm #401 PREEMPT 
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:strlen+0x0/0x20
>   Call Trace:
>    <TASK>
>    trace_seq_puts+0x18/0x80
>    trace_print_symbols_seq+0x68/0xa0
>    trace_raw_output_kvm_inj_exception+0x64/0xf0 [kvm]
>    s_show+0x47/0x110
>    seq_read_iter+0x2a5/0x4c0
>    seq_read+0xfd/0x130
>    vfs_read+0xb6/0x330
>    ? vfs_write+0x2f2/0x3f0
>    ksys_read+0x61/0xd0
>    do_syscall_64+0xb7/0x570
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   RIP: 0033:0x7ff283714862
>    </TASK>
> 
> I'll also massage the changelog to explain why KVM is absuing __print_symbolic()
> (see commit 21d4c575eb4a ("KVM: x86: Print error code in exception injection
> tracepoint iff valid")).
> 
> No need for a v2, I'll fixup when applying.
> 
> Thanks!
> 
> > Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

> > ---
> >  arch/x86/kvm/trace.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> > index 0db25bba1..93de876c3 100644
> > --- a/arch/x86/kvm/trace.h
> > +++ b/arch/x86/kvm/trace.h
> > @@ -490,7 +490,7 @@ TRACE_EVENT(kvm_inj_exception,
> >  	TP_printk("%s%s%s%s%s",
> >  		  __print_symbolic(__entry->exception, kvm_trace_sym_exc),
> >  		  !__entry->has_error ? "" : " (",
> > -		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code, { }),
> > +		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code),

You could use a printf precision to reduce the hackery and get the desired behavior:

TP_printk("...%.*s...",
          ...
	  __entry->has_error && __entry->error_code != 0 ? 100 : 0,
	  __print_symbolic(__entry->error_code),
          ...

(Unfortunately Linux printf does not handle negative precisions correctly.)

> >  		  !__entry->has_error ? "" : ")",
> >  		  __entry->reinjected ? " [reinjected]" : "")
> >  );
> > -- 
> > 2.55.0
> > 
