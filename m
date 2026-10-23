Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743651;
	b=0B3RNtUbALPFKw4yU9IzcYYxXW/IxqWxnycfEfaPKhNW/HqpTbfhBVLrlYOLdt3v8CpP
	 BMvLqY0oAH0KSHQ9k/iPKmrK9YM2huGTGjkeflh04ktFtSydQBPTmpy7Ey00BWIVzFG1r
	 O6s9qKn/UpZ0SzMevBbd3eMSFSZ0+zYRMQHTLKLoZAPp64U+6mkTQ1PG8K5NGzw3p2Vh+
	 sC+iArh9nI8t4KYrzC7inespAGyKFWylVhfIHhBAcTA7HK1fmF6ipD81BOouBTqhZZ/MZ
	 mQMTQYPNvSDVj3gyZzmD+LpZavOqVUEJ4lwNZzVWHYU+iJBBqioLc4Xis/XZ31X+XjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=SXFzVxbt3rTWSbyQVYsDzyVGHc2RBqghX5A01kRz5f8=;
	b=y0MG28rhK7WAHcGuKTH0a8NVkWNwQheManeocV7+hBuONRzPGXEoAjjw9hsRx5IfKJTV
	 uc/0IOQZpE8y1Zc/24iIThyQtvBiZxiHRpZrXjumzWSUEFjgBBxzhWQ6cExvHl8gL3IBw
	 NrI0w0/U4M8ogPV3/O3uUtC5k403iwpXlR+PMHv+mX+72e6c1VA45PWlueYtx/3O2jKUa
	 I7FGaV9E9MqatsJUtyGr0dMBQ6HTAmUQ8QhGGKwQa8u6IbK/0oNWTbwCJCPmRNvhRlxY8
	 LegA+A7gML2wt+ri1IlQzgHIp/M0CcqRAOpI7VpqxiguUhOdnu3Gb1LAhipzjy30f7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=H4AeHGOC;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8D606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 08:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C8D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=H4AeHGOC
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2074a66beso3898275e9.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792743649; x=1793348449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXFzVxbt3rTWSbyQVYsDzyVGHc2RBqghX5A01kRz5f8=;
        b=H4AeHGOCM7ZUSFzB4sjFH1pf83lax+Py/Zk8Gvw+38AgRIDCvWlIst48ESKJeAAou8
         Uv/RD76Moe2gg4HEpnViGnKeAXxIyTJi5vXOl7Gyp+FOZWXp4iFVVxclMDBIJJw/3r+A
         SJxKDipX8r+eoM/EcofkTd3u6MsF0L56xgTHf1fsWciXFLNwDHDSRgoc2W8fgc4Qvt4S
         lbMlwQPlIup6UOr+zJ7/1KGlLBCVAuqu8iGYQC/N6VkalGMU7J6KRSsZheb5Qm8h2QG9
         uLrH5x0TzEDJOOtRRXHbr6qMUAUg/y1107mMB++PlRwypJotx0Grwrw1yLAq7TiEd98W
         mYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743649; x=1793348449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SXFzVxbt3rTWSbyQVYsDzyVGHc2RBqghX5A01kRz5f8=;
        b=ZTv/EZ1z2cUlu17TCSPbaU/Rf9Z9TqZpNeqZ736yiPxWCghWssvwm6DZYCGFADl2qt
         L8nx6mQ6P6S5/OnS0H+QGeYyziDrMHvHCI5/VOFSgNsQuesEnxc9j5NWsZO/0Jax3ACM
         BluKt5IS2ZxdZ2bvBNK5gJQX8rrEw+rezoi7z1UPJUF/hYCTdtAuFxpxcrR8JUg6dAfN
         0nzagIcsojwkyas3KmaQmjsijO9J8MXV7/NW8YiJNdGqUSdrpmkPsjgjO3x+OFx0/l3F
         Wp2Elmpas3AxzCklXLWqcyFfCtRaP05WTfgd1qr/f+MHB8gMwRZTHy0/yxbw3N6lKF9T
         qOVg==
X-Forwarded-Encrypted: i=1; AKwUvBy/TDTl6gBYxR2Lkcn+dSAXrSHkuOtH6RlkWLHx6NWT8UAlxT8C0fL+3Lspy+Bl0FbmCzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzQq0PXdKi0k/qCa5k8wXdeakvwP+UJ/8/YekCFiRkeL9M0SNv
	YbLZu0wIEJ/LNAGVeiqrkkOrita7Vg7bb7BIbixqWaPQ8fFD827px1p0IEURc6NziQ==
X-Gm-Gg: AYBFou1eavUmaAO8FBr5UvcmoL2zip2SBVJriBhR3QkGSyn4daG9HiX8OjVTuhDBOYK
	D46v6cI8gxb/ikmy95VML1DRjvbLxKA4u1mvIPLh4wBFBO8BPI9RmvqpXX7EpQTYlW4PbNRUwuM
	v4H9FecTuo7Re2hh0USvOnG307+jDLupBqcMz53GPMG/YhGk6le885tEGmWL8n8iHBstSJ5IALd
	ygL9JeBsMygGVfvnvkT7wDz+qhfOf+wa4BjbRQNUmTthY2zEbHsj5RU38wqFGJbMhJ8J7MyLnNs
	9mXDfYm17kaBbQQmiUmqXwm2HUpGQqTmLRAxJQ7ico3RxOALwEfUZDNTNOHyzyIKhKKvD7A5egf
	w5wgUP53ikCDM+6TLb7oZPXSa6/xyCDOWqGDck9fSQaC3B2YxB6DsE49irBIuW5nQDiNcI8Bdhw
	wsJW9G/N5sPGC91cKGXvxGhevKXaJ3v227geggdubLDGfOtGPyVQKaQgUFMSh/D+hQixF0bcFo/
	HT29yErE9wRVZPx1IWuX4uiCs5uF1ChuhAkp222aP6EE59vzxrkwidfo2Gvht8Z+gc/N4MTtyh2
	kbJ4EpMRrg11+87mGZTIQ8Li3Q==
X-Received: by 2002:a05:600c:1c05:b0:4a1:83f0:7c8a with SMTP id 5b1f17b1804b1-4a211c45f89mr27907715e9.1.1792743648308;
        Fri, 23 Oct 2026 01:20:48 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38031488sm3623513f8f.24.2026.10.23.01.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:20:47 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:20:44 +0100
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
Message-ID: <atsY3MXXEUe2YopQ@google.com>
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
 <20261022181817.49717-1-amachhiw@linux.ibm.com>
 <atsYQtXHRH_cCQ5A@google.com>
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
In-Reply-To: <atsYQtXHRH_cCQ5A@google.com>

On Fri, Oct 23, 2026 at 09:18:10AM +0100, Vincent Donnefort wrote:
> On Thu, Oct 22, 2026 at 11:48:17PM +0530, Amit Machhiwal wrote:
> > During early boot (early_trace_init() called from start_kernel()),
> > tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> > snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> > smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> > 
> > Before attempting page allocation, __rb_allocate_pages() performs a
> > heuristic check using si_mem_available() to return early with -ENOMEM if
> > memory appears insufficient.
> > 
> > However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> > NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> > period from early_trace_init() through smp_init().  defer_init() leaves
> > only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> > up-front, and on kernels with large static binary footprints (debug
> > configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> > early core initialisations (SLUB caches, vmalloc, static ftrace records)
> > consume virtually all managed pages in this pool.
> > 
> > si_mem_available() therefore returns a false negative (often 0-1 pages)
> > across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> > SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> > causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> > 
> > This failure is false: the buddy allocator is designed to replenish
> > ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> > is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> > short-circuits this on-demand growth entirely.
> > 
> > deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> > completes (it spawns per-node kthreads and blocks until done), which happens
> > inside kernel_init_freeable() — before system_state is set to
> > SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> > SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> > and si_mem_available() is accurate.
> > 
> > Wrap the guard in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT so that on kernels
> > without deferred init the original check is preserved unchanged.
> > 
> > Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> > Cc: stable@vger.kernel.org
> > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> It is usually good practice to not use in-reply-to to link the series between
> each other.
> 
> > ---
> > Changes since v2:
> >  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
> >    update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)
> > 
> > Changes since v1:
> >  - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
> >    trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
> >    completes, so the false negative window spans both SYSTEM_BOOTING and
> >    SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
> >    boundary.  (Sashiko, Vincent Donnefort)
> >  - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
> >    check unchanged on non-deferred kernels. (Vincent Donnefort)
> >  - Drop Tested-by: guard condition changed, requesting fresh test.
> > 
> >  kernel/trace/ring_buffer.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 9c4e40847e43..8e5a59a7b69b 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2463,10 +2463,27 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> >  		 * memory. It may not be accurate. But we don't care, we just want
> >  		 * to prevent doing any allocation when it is obvious that it is
> >  		 * not going to succeed.
> > +		 *
> > +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only
> > +		 * reflects the initial non-deferred pool during early boot and
> > +		 * throughout SMP bring-up (smp_init() runs before
> > +		 * page_alloc_init_late() completes deferred initialization).
> > +		 * si_mem_available() returns a false negative across this
> > +		 * entire window while actual allocations succeed by growing the
> > +		 * zone on demand via deferred_grow_zone(). Only re-enable the
> > +		 * check from SYSTEM_FREEING_INITMEM onward, after
> > +		 * page_alloc_init_late() has finished and si_mem_available() is
> > +		 * accurate.
> 
> This is quite a massive comment for something simple: When
> CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available() will reflect the actual
> available memory only after SYSTEM_FREEING_INITMEM.
> 
> >  		 */
> >  		i = si_mem_available();
> > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > +		if (system_state >= SYSTEM_FREEING_INITMEM &&
> > +		    i < (nr_pages << subbuf_order))
> > +			return -ENOMEM;
> > +#else
> >  		if (i < (nr_pages << subbuf_order))
> >  			return -ENOMEM;
> > +#endif
> 
> Could we avoid the double i < (nr_pages << subbuf_order) with something like
> 
> if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
>     system_state < SYSTEM_FREEING_INITMEM)
>        i = LONG_MAX;
> 

or even i = totalram_pages()? 

> >  
> >  		user_thread = current->mm != NULL;
> >  	}
> > 
> > base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
> > -- 
> > 2.54.0 (Apple Git-157)
> > 
> 
> -- 
> Vincent

-- 
Vincent
