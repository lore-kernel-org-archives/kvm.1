Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D9362133
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708971; cv=none; b=Rw/05Vc2KxSQyINJD1BuTZxKwMDQaBL4SbvrNtaFaTfojC4AXWxuV6axnXgc6P5g+OHk3JZ/2hwJqo69cbW1k2I+dqWrkYPfEyY0CKjyEZrJdBg/8PRgg9g555IT1/VxkNEUCiZVTB+pzcPXfpotai0fV7hj0Mb64zLv3oO8/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708971; c=relaxed/simple;
	bh=u/uf/5TebTnwwwigUUgfYhU8Ar2x/jTcDLF0n5U7HWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g4i+H8kiFNtBf7qly+nx+1FwSsz12vYWKCBFeW1XGHB8vY09yI7L0bpAkDk51cLxow87KVNqYLKoCByiQHm16tb9OouPq6DjIq666Y9QfF9iiiHmGeWV0wdSAB/FJ3jDoJtvB9D+X8gHZ/py15wyH4+TDYHTgyCXE8Z3u/J6mhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUlhphiz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUlhphiz"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so2235858b3a.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783708968; x=1784313768; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UOcm1EtapN4V+PNh2tgwNrzCfsy0dEnjbRRcSkg5zdQ=;
        b=qUlhphiz5Hj4hCPjve2Q1i0RZyRFvvrtkghFenk5yxFnL1h2pc1k+pNCihBrU2vJGt
         oBLWT41vImIXX3/ni4SGyW7hYcycWKtgigNN7YHmRTKW7yiQ+pZPm1Jsj9VtcQcGEji2
         PcI4wYlxmuOIKt8d6n2HwqAw/aJ66aM8JYlTzNPN+6qiVKH3q4AunbAUpVfMd+S4OSDa
         h3U/chdl8Qazo87n/Je5DT1z25NYLHdxNZtgtVAH7xCYm1/QeWI61vVcobUvEs42gWz+
         iPdhOtfs9SKq0nsA0yyXcrWqr4u5CEv3AP+o2V9uXRs/JEuUCRd4OYGdtATipGqFz1pq
         vsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783708968; x=1784313768;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOcm1EtapN4V+PNh2tgwNrzCfsy0dEnjbRRcSkg5zdQ=;
        b=ZSugfLnTSQyPtmPNMlC9ehR5OuzwY81m2uVAQFAlYaKHni+29y+w0mcUthlx9onW7j
         mOrbmgga1PF5TjlFSZkZ4aK+492xCe2QjWD3ZrGOp1KLQ/n2z91bTSR40glkBNL1htoP
         7tinbAz1Qk924luNTeB7ihYL8z+OS8SR/Zb76Hl85htoMlc+1mhd8fmVaSr9kehG7WsB
         sOrz+kj/vlsxfhSxvCe1Pa3C1t1YkxzNi5aoGXGsreCtc9VPPoiJ5MCvBd3rfriW0B2Q
         VOhly6bRh58UO0Glwh02UYjrEXwY+Kj2S3W+FVwIEeL7p9RW6RbfHdJN5CxfdCyWJ9nL
         n0wQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1MR0majCBedHWrYb0VyOhcEk3LSUM4/WpvGYrDk+5KWnQ9vExZHdo4IG0OUVrQZWVzio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6R3C8y1zYkXL0FoLt2d5PLi0teHd8x6noGtGA/ze9Jk7bO0H
	76R+/WxpQLqzT/B3PA7U3nRHdH4bjs4scHbhh3dOep6w6g6lbXudwjKU57RgADKDuwSzo0UQUQY
	ZXbzrCw==
X-Received: from pfbdi7.prod.google.com ([2002:a05:6a00:4807:b0:848:4025:3c1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8b:b0:848:62ab:7b7
 with SMTP id d2e1a72fcca58-84889611818mr239106b3a.16.1783708968177; Fri, 10
 Jul 2026 11:42:48 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:42:47 -0700
In-Reply-To: <20260710134055.16432-1-danielpaziyski@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710134055.16432-1-danielpaziyski@gmail.com>
Message-ID: <alE9J1SjQSNHaV16@google.com>
Subject: Re: [PATCH] KVM: x86: Fix null pointer dereference in trace_kvm_inj_exception
From: Sean Christopherson <seanjc@google.com>
To: Daniel Paziyski <danielpaziyski@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Thomas =?utf-8?Q?Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

+The Other Thomas

Just as an FYI, commit 754e38d2d1ae ("tracing: Use explicit array size instead of
sentinel elements in symbol printing") broke KVM abuse of __print_symbolic() where
KVM deliberately passed in an "null" array to avoid printing 0x0 when there is no
error code.

I did a half-assed search through the other usage of __print_symbolic() and didn't
see anything, but just in case someone else comes complaining...

On Fri, Jul 10, 2026, Daniel Paziyski wrote:
> The trace_kvm_inj_exception tracepoint takes as arguments the exception
> vector, whether the exception has an error code (and subsequently, the
> error code), and whether it is being reinjected. The error code is
> formatted to the trace log as a string using __print_symbolic,
> which takes an integer value and an array of structs containing a mask
> value and a string. An empty struct is being passed, which makes the
> kernel derefence a NULL pointer when the error code is 0. Remove this
> stray struct in the invocation of __print_symbolic.

Fixes: 754e38d2d1ae ("tracing: Use explicit array size instead of sentinel elements in symbol printing")
Cc: stable@vger.kernel.org

In the future please provide a splat in the changelog, especially in this age of
agentic bug hunters that are prone to making things up.  My initial reaction to
this was "no way".  Thankfully, I tried reproducing the bug before making an ass
out of myself :-)

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0 
  Oops: Oops: 0000 [#1] SMP
  CPU: 20 UID: 0 PID: 791 Comm: less Not tainted 7.2.0-rc2-3ffd29d795c9-x86_trace_ex_null_ptr_deref-vm #401 PREEMPT 
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:strlen+0x0/0x20
  Call Trace:
   <TASK>
   trace_seq_puts+0x18/0x80
   trace_print_symbols_seq+0x68/0xa0
   trace_raw_output_kvm_inj_exception+0x64/0xf0 [kvm]
   s_show+0x47/0x110
   seq_read_iter+0x2a5/0x4c0
   seq_read+0xfd/0x130
   vfs_read+0xb6/0x330
   ? vfs_write+0x2f2/0x3f0
   ksys_read+0x61/0xd0
   do_syscall_64+0xb7/0x570
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7ff283714862
   </TASK>

I'll also massage the changelog to explain why KVM is absuing __print_symbolic()
(see commit 21d4c575eb4a ("KVM: x86: Print error code in exception injection
tracepoint iff valid")).

No need for a v2, I'll fixup when applying.

Thanks!

> Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
> ---
>  arch/x86/kvm/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index 0db25bba1..93de876c3 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -490,7 +490,7 @@ TRACE_EVENT(kvm_inj_exception,
>  	TP_printk("%s%s%s%s%s",
>  		  __print_symbolic(__entry->exception, kvm_trace_sym_exc),
>  		  !__entry->has_error ? "" : " (",
> -		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code, { }),
> +		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code),
>  		  !__entry->has_error ? "" : ")",
>  		  __entry->reinjected ? " [reinjected]" : "")
>  );
> -- 
> 2.55.0
> 
