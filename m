Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537449D5BB
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823132; cv=none; b=cFmlAuIst1GOdO3PErh6jAtG9iqS0+JKvPWO2O+9Iotoeif944ZidYmSZN2v+Ib19q+ZnRTlz5quUus66b00IUSv5PCX9a4Q1iz24RGUoMHiO0YF8fUivCdxL4QUmVf3SoBg0bwcmitH6ePzg5UUmSZvxBYYDmocssxNQTM4K0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823132; c=relaxed/simple;
	bh=F1H5MyQMuXam71E+nKkOYHzZwg6EalJS+Z3MC7TNSRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0iP2ipu4l0JYZQYE66ey3CWJYWLiW++yjBFUse/82qOA5Fct020OKTF0y+9MYzqcBgvxwTAdFhwp74P6+lqi/ojN068zh4ONKdOMtQIH4cn68ISEK+LIVYXwIsIyWX2pFQca2R++YyB4NU2mGGZmPA9yv2HQmH2QERrNcLqw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zh9EnPhH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zh9EnPhH"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-487049569b6so1479083f8f.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791823129; x=1792427929; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuWCbCHALjFKQvI6kk2Kyts8iE/+EiR+kuOdFcAFHro=;
        b=Zh9EnPhHZSLzSUBHM5lS5RrxUap0vNq+i18++MPRANoio6c/HxwTzzD4Prl58etJUa
         RdK7Wp8crdicNQ0pfL/bK9hNJInDipmwq9gjObpWJomvpjV89ml6KeRyjIuGePfzB0rN
         FiV8dLmipqYMi98whobcPPR3OWwgiYfEYRpsVkimkRhNfGxc2qRG8ZYH2Vvvk2G2Dh/i
         lqlFjeTm8VSdc9QeRSaG611ROin2iCAvNIzFZ6kIATVQNT9kXT/diYOa9wSZZ7gzk5yw
         xuS8qre6X8YurLcqgYJaflbnAWDB0qrjjjV3z3+aoaLEuS3c//o0TZw54O4UvJK9fPc0
         zXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823129; x=1792427929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HuWCbCHALjFKQvI6kk2Kyts8iE/+EiR+kuOdFcAFHro=;
        b=iZ6K22ClVRgPkIMAcdENQKVYaLs0ktMPY/u2lIknl+qKlWIWeN4gq8UExPZk25nzGf
         AKmtnWEuQLavx0OlC+frxlL8ccbuH/lxEfT19xVWblKcGFeBRdmamaKjsF63lQigcVN1
         ogBQ+miaB7k29mgqZzQlUnTGRGWDccQQXe145MfH0jbKjO1LexCik5oi6URIXJbXT1kj
         vad0Qn3whPhb2sVi7T6gtsXy+W8aUFZ+2Fb2RY7dhgaQyOh/fV9UxP60sAwSUEKBjkx9
         r2ZqP7TQJvMdkdqhn8zqNo6UbUUjiVKn0m3RGTC0DdfxO23rdFfLFEHeLYW3DMkCyaAd
         Tzgg==
X-Forwarded-Encrypted: i=1; AKwUvBxjO9ugE1unXx4uDAqszcK+c9yBp3D0HGbxGreu7tsOPzxEuVPVr9CtOZX+P/BJcNuK8fQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCheuC30X8nCNx2dVajNyKKUkqvL1BDIrn5Myfzk0xU8kZH8SY
	8ZgX9JMkeHV4T9ZH+lankxs3jl3VpTxrBVBP8aVbL3Giw5gy44UjhYXUaIFJTdf79lPA7mpGdvh
	YyAYU+w==
X-Gm-Gg: AYBFou22ySMZujfIUkIOzYvBF6BOSEUnsLZqH4qQc0c/9/yOfELr24v7vK0my1zIE08
	SXoumrl4OcySCjLaertIxglsnMMJM2wDqccdFniGYizBvLciOD1YZ8k+1q4+XAjCbdCukJW1blp
	VFZVG8XDlZ21zc7k63v1iDmEy8jOTnAWbbtsKGLplYBWurHwERFlYzYhTEWNKFmnWhU2TuERhgc
	8GMAhR5voyQOmtfnLb9HL3IrXyQt6AJRCLdp5vpwbppfPx6qdiGEF5HwbRJXtBWXLGbJ667ugE0
	hbKI4KW5NTjUl6g+8IQtxhn+99FpRRzn5ycleu2U70D8RBHgq/RmJb213FnFjPPVvz1jB0Af9z4
	FdzXZ5X5vCpITVNQu+/xPq+ebyuOA51DVBf3A3EELJGHCl5mELSmLF59KEaEaMvXVxx5RTYSf4L
	T8PHu2aNwzjY9/8n53Nhu8GhPzVStVuXfbSCNgHe62b9GumS9XNFaxJqODyeDKQy3NnLuUZxbOk
	aE+7yz6TN1eF173NtbmerLROZMlV5UVZQYXl+JMJs4=
X-Received: by 2002:a05:6000:4a0b:b0:48b:11e1:8bc8 with SMTP id ffacd0b85a97d-48dbace678emr18199465f8f.39.1791823126911;
        Mon, 12 Oct 2026 09:38:46 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc91e2sm297646f8f.55.2026.10.12.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:38:44 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:38:39 +0100
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
	kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ring-buffer: Do not check si_mem_available() during
 SYSTEM_BOOTING
Message-ID: <as0NDyaXsfQnWPQ4@google.com>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
 <20261009163557.88467-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009163557.88467-3-amachhiw@linux.ibm.com>

On Fri, Oct 09, 2026 at 10:05:57PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> defer_init() leaves only a single section per node (e.g.  16 MiB with 64
> KB pages) initialized up-front.  On kernels with large static binary
> footprints (such as debug configurations enabling PAGE_OWNER,
> DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG), the static kernel image and
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this initial pool.
> 
> At T=0.000000, watermarks have not yet been established
> (totalreserve_pages = 0), so si_mem_available() returns the raw free
> page count (often 0-1 pages).  When the snapshot buffer or global trace
> buffer attempts to allocate 2 sub-pages, si_mem_available() returns <
> nr_pages and prematurely aborts with -ENOMEM.
> 
> This failure is false: if the page allocation were actually attempted
> via alloc_pages_node(), the page allocator would trigger
> deferred_grow_zone() on demand to initialise additional deferred memory
> sections.  Checking si_mem_available() before attempting the allocation
> short-circuits this on-demand growth.
> 
> Skip the si_mem_available() check when system_state == SYSTEM_BOOTING.
> Once the system transitions past early boot and page_alloc_init_late()
> initialises all deferred memory, si_mem_available() accurately reflects
> system-wide free memory and the check operates as intended for runtime
> allocations.
> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  kernel/trace/ring_buffer.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..a9f82e2f8fad 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2452,9 +2452,15 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	 * memory. It may not be accurate. But we don't care, we just want
>  	 * to prevent doing any allocation when it is obvious that it is
>  	 * not going to succeed.
> +	 *
> +	 * Skip this check during early boot: with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
> +	 * NR_FREE_PAGES only reflects the initial non-deferred pool at this
> +	 * stage. si_mem_available() returns a false negative while actual
> +	 * allocations succeed by growing the zone on demand via
> +	 * deferred_grow_zone().

As Sashiko pointed-out, if si_mem_available() is only ready after
page_alloc_init_late() when CONFIG_DEFERRED_STRUCT_PAGE_INIT, then checking for
system_state >= SYSTEM_FREEING_INITMEM might be more correct.

Also I wonder if we don't want to guard with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
to keep the verification when CONFIG_DEFERRED_STRUCT_PAGE_INIT is unset.

>  	 */
>  	i = si_mem_available();
> -	if (i < nr_pages)
> +	if (system_state != SYSTEM_BOOTING && i < nr_pages)
>  		return -ENOMEM;
>  
>  	/*
> -- 
> 2.54.0 (Apple Git-157)
> 
> 

-- 
Vincent
