Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743498;
	b=zSkmRcpTEm43K71Wibf9Z2odFTqrL2M2ZXIegVg6nTjjh8PY81XvGWUGIYSOXs2SIBOU
	 uxPlapxE05Vg22Ndv5dhoaH+fIb1F+dIa/Xw/3EFzS3CkJJl0LR6rGynQyeODS/MNOeOl
	 Z+sK0YOsAJ8Y6k/I8rRvjrOuzZMxnKH5+UrZQ7ZpAkJ4zu7o/kkkQg8sFRhQ1VsaPNhUF
	 4nFAbgl6c5JuAv3vi4CUFHzIyrqcA7xI5o0oauzcQ4QF3vfGZRdI0ba0s8AKPpK2QPRru
	 alhXhJ7aZ954gkvhCCd+vgKGa76WQZ798l94f0zxbYZnxmSlracM9FhMjV/vvqvu7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
	b=dqZytwQvezMohy0I4cOja14QITqWGh4PBAyHu+NX7yrmo229mQ3XtmNTLlubLf/wqsY4
	 8QNkZCOSA3jomXXFipYLaal80JoZPE45A+pobVULizj94h5ix/VAmz1UziUdBh9t5jvPX
	 bgsiQp94YxkAhe1zosvdvuM9rmroJrkNcwztIA4T4shtno/KR0RW9vs6/ne+iN1iscq9F
	 Qq5NfFMsdjvpjPhwvXrkN4i6gheaiY8z8WKVhVe1/Ro42PMyobKNuh8oMc/G19nWpPs0Q
	 i4w0ZkDx6JTO+AunGfrT5XBSmwlGAv8MTbtGMw+dhbn4r2XySdfkxVALaCLt30WB/Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RrWV1pl+;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA81606A327
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 08:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FA81606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RrWV1pl+
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so3557355e9.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 01:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792743495; x=1793348295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
        b=RrWV1pl+3EtmVhDk3j+FSUjGfIGHBGcq03rhpg7WHleDgWouEuAzLqoTyRgDy5fvz+
         wF4UwPvIifknkCZJ1PyVasiujDFi1GArPhxOLkP1kt0rlZ76Wimqmbi6lRV7CAe335li
         nBN6RuojRiEjRPUXQXtFCRmcizH9AjfxZLYTp9mEVgDdPbIRcaS/V2y+lW/YTHj0zgLN
         3/8M6w9m9KPXRpZeM767NWZkPimFSwtRCFhSCyNwuaWR9n+Yp67SOJtl9ONCDR3PThcC
         Hy2hN4n6do3y8bjEGk7YwetK5ZH6Q27eSVvNfCqUcRHWRJNJuRAwCVBgCixX2iBkqZcn
         E+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743495; x=1793348295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
        b=ds1IS4Qqwr3cGhqxDsjS/9fBrvYXAWg7I+BDRWAoQ4lO77b5vDMbfzRi6muQAtUUAy
         O5XDO2F5IdLDaEga9ryY/b3r/tSFIl9F63z1YdgqCQ6v+GwCiCeJz01Lc5uQaT/VQokf
         TlBRQbTmcM1akMQb1sNgccSzYA7tT2hwBtx15xfEHzeHdZ9cgzVqyxuMZ/sKodP1NTS7
         h1/iTMdGOCRb53Je9wjUuMWvbtro/YuGBDrkVuLdH8P9D8Hq0aLSZCn+3PVOM6BIbziP
         6rSzQrjDkqZhdIj3egmtSwXXODGjUPjZUf7My/fn1ZDIDXlSfBXcC2g2aff42p1aRoGq
         R75g==
X-Forwarded-Encrypted: i=1; AKwUvBwR1vTmdQQQ6nig0fuG8XZoAIvKUfMDmL782oS8gJHJr7DekFEAlQf8IkKXiBnX/I2T1bo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+ZNV3BMYa+s0lzzkzLKF4GX3cFpv3DEKPDZGAMzbtm82jOwl+
	+tERRIpSWPnzS/RF/66BDTRT4T9UDEm8eJk1G+XgkwzxyTqHul0XkmVJMWK93wGGgA==
X-Gm-Gg: AYBFou0gbaG+Q2nJqANwWoPD0tsBT0Kb0wpKcTwggXJNHO3WRVdcCZVFz4SkSHgEN6G
	drNGoijk7Qzm+Oyq+Naq8GdOU+ibKfWFBPNqSpQ/JiaKAXNyxDdRpcShXsONEU+NQZ+pMbJFvzJ
	ZBaVWzYFcih5aQRLXkoaBGnuwNw7Er05lYNVcaRJixVhK9hNouaSPBmWGBF+wossiyUHhyNdEiS
	LRkMqvouljE35gLMQTP5UJmbj4D1yLL+/CGAMlDlD+EHXw021hqEErrvCpjDd0LChdti618chET
	2JtS9fulb+SGdJBEaiKXugIvkJ9Wp3uWw8O3u0hdySCdPYgvcxn1etPgy0oNWYXMGpu55r1sYho
	sNjCjcOCSomJ71ORU0qhcegQbSe0zsYXJCwEPFaQdUa01ClAEaE64MVrI2osJnlx8vfkjHmMsDi
	apxbR+bsHS+tkI7qR6d9KyY7D1+TPFbABdnFUG54S4rpxgIVSxIpq5cxeQcry+LeJ+D6PLT541+
	Jwe21Quimb4nKKpwWK6QGHpKYPRvVFW9D0bUm6f+HJaiQO1MZNwCFPXlyonOaeN6nWT4ZN2IZ35
	V/AehPDtSI0S1tISTe3Y7wvu
X-Received: by 2002:a05:600c:524b:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4a211ed3f5emr23048395e9.24.1792743494996;
        Fri, 23 Oct 2026 01:18:14 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21045df9dsm68556225e9.8.2026.10.23.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:18:14 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:18:10 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <atsYQtXHRH_cCQ5A@google.com>
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
 <20261022181817.49717-1-amachhiw@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022181817.49717-1-amachhiw@linux.ibm.com>

On Thu, Oct 22, 2026 at 11:48:17PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> period from early_trace_init() through smp_init().  defer_init() leaves
> only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> up-front, and on kernels with large static binary footprints (debug
> configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this pool.
> 
> si_mem_available() therefore returns a false negative (often 0-1 pages)
> across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> 
> This failure is false: the buddy allocator is designed to replenish
> ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> short-circuits this on-demand growth entirely.
> 
> deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> completes (it spawns per-node kthreads and blocks until done), which happens
> inside kernel_init_freeable() — before system_state is set to
> SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> and si_mem_available() is accurate.
> 
> Wrap the guard in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT so that on kernels
> without deferred init the original check is preserved unchanged.
> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>

It is usually good practice to not use in-reply-to to link the series between
each other.

> ---
> Changes since v2:
>  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
>    update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)
> 
> Changes since v1:
>  - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
>    trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
>    completes, so the false negative window spans both SYSTEM_BOOTING and
>    SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
>    boundary.  (Sashiko, Vincent Donnefort)
>  - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
>    check unchanged on non-deferred kernels. (Vincent Donnefort)
>  - Drop Tested-by: guard condition changed, requesting fresh test.
> 
>  kernel/trace/ring_buffer.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c4e40847e43..8e5a59a7b69b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2463,10 +2463,27 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * memory. It may not be accurate. But we don't care, we just want
>  		 * to prevent doing any allocation when it is obvious that it is
>  		 * not going to succeed.
> +		 *
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only
> +		 * reflects the initial non-deferred pool during early boot and
> +		 * throughout SMP bring-up (smp_init() runs before
> +		 * page_alloc_init_late() completes deferred initialization).
> +		 * si_mem_available() returns a false negative across this
> +		 * entire window while actual allocations succeed by growing the
> +		 * zone on demand via deferred_grow_zone(). Only re-enable the
> +		 * check from SYSTEM_FREEING_INITMEM onward, after
> +		 * page_alloc_init_late() has finished and si_mem_available() is
> +		 * accurate.

This is quite a massive comment for something simple: When
CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available() will reflect the actual
available memory only after SYSTEM_FREEING_INITMEM.

>  		 */
>  		i = si_mem_available();
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +		if (system_state >= SYSTEM_FREEING_INITMEM &&
> +		    i < (nr_pages << subbuf_order))
> +			return -ENOMEM;
> +#else
>  		if (i < (nr_pages << subbuf_order))
>  			return -ENOMEM;
> +#endif

Could we avoid the double i < (nr_pages << subbuf_order) with something like

if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
    system_state < SYSTEM_FREEING_INITMEM)
       i = LONG_MAX;

>  
>  		user_thread = current->mm != NULL;
>  	}
> 
> base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
> -- 
> 2.54.0 (Apple Git-157)
> 

-- 
Vincent
