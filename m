Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033518;
	b=m0WWirPOwU18O9du3tema0+lQSd9VtZlREK283MU9AG7uelmom3NvQk0V0JPXXTUKrSv
	 QVwGf2W3/6Dy2BjD5yAkEXeQsQr7XGZ3Pt3zxOIMXUKm5e38cbScuhAwqeOskZfdf2wIe
	 VF9jgu+77fxs4vUlacjdAzWD+tF2F+Mx5miJqmNftDQUpaAPTeQJZxEioSk4H+1xTGhM+
	 /flcgjMbGeHz7H1PQDEO7HH9x3KBQ+RGpWVfxrQ24HYZ9f5gWa++5x1s+guZtfbAhHCK9
	 CNT9FCJa2jxFnVFo18SeA/4yY16iZj0xNtagyPIrrkSGaSIBcWPdzFvUqbyK2+WyHKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
	b=KpM4k39o5E9LSOLz5WvcKZmg7x9AuWmt7N9PaKmPWl9yWLeTWLZps8zNEk23cLq/wxnf
	 7ysJhMD3Z80I45PVU1FOQ1Aea2OGQ9OY7337NRRwdoSL08D4hbk7tYCx/BR5NYca9laY/
	 79TBYh2XeiymciaXQ/WeFlnbvluoLPnczpCbBhAcp9tUS4mod576r0xzFxA6ckJ4/I2LC
	 2u1b68JSTbk2D25puT5/dR/WUfGVCltCvGpWeLIujXfAdqodh7zGA2uP3XCo/U+vKt8cp
	 4L99iVew//j4fy8yn7MZuOiYQ+PvefyB0MR9AWNzSLu6mIeCEY8N6Q7F216sPGQ3jbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uMdD4p6K;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CD606A32D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 16:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291CD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uMdD4p6K
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so11886525e9.2
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793033516; x=1793638316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
        b=uMdD4p6KVakawh179kk8FHBLF5CXO9wel4SSzout3Cv109M7RXUmUmrC9sJPIgWsSH
         9ABB0JV8Z5NUOTGY7GHDP30lVe2PF06Z5Rb3sGZu9AHhb2etfX/cHvQCyiGlPRRn3Cbe
         CFLeOIxpliD0sRukb/bWQTt0J7k1R+JKXgZVJ1KMgCeuSSmAA57l+zaNLFl6HnQ/Ahaw
         zQi33bNvGhiw52l+kM3vvg4nLkAUFO3pt8PlK45P8ZDXb1WCt8rTiBonnjcILrrKElFt
         fjlgVO/cXdwsEDjIa5uw8AyiN4qBUQXEww/1M11No4eGietgwgSL41okjBF4DwT+0EjC
         VbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033516; x=1793638316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
        b=ZjwHY9183ko+ez/C9Lw5FbaSQVF5nZgE28PCmc8ehC8uMjuk2IINk/3CIhgxVc5VMi
         NylFfuwif0gdfn+csMGrPXa7I/kZpnAOOo71SGsqiVzA9kid8B6Zyu2RRPTspa4sD+Pt
         UtI2KDRgKcPRCURyu6jJUOSksCu75J3Zqa38VbtlKRwEnfP/obXEKatN0F+QawuXNX3Z
         zjHSJ5k+Bjsai4QxwBeq5vzTFU03bInomO5ZRfSHBQHaTe06sKE/wCBofOwsnIWuYNL1
         BFdeqpYkr8CvnwaSp6TpsUcX0JEOyacFyeh4q3CLFuvi/bWAZuU7iEFNoPtPQ1WLi/YF
         uftQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuCE8aLh15CskOcCPo1oWo5BhbjJhoCvkX+uqbFda9kKBXzKt1dffYGpLVnOCPDALRfeo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJggmesUuIjMq3qAg8OWoYzIAphXzJtXVw0/u5OBw5dEJccSbYt
	y94Nl2GtS94C/CaH7bnicMfvpI0Ae2vknzAHT2jbhT2+z19bjLU3C/IdWQl6okHyTg==
X-Gm-Gg: AYBFou3F6E3TwIo5YasFsI1yD28+/qIyfT9D09HVxYfI0t/ETZ0XyLw4BPVEtX1DC57
	wcCvyLe18Tzmzvl+SoLhkELE5ntJttvfg4r/AS6mi5ojZooVEOaCgdPg5g9fG3qJHDi+t0C4Gv5
	y5iT8qiVkAHwH1Khq5duIR2eN1nHuMVHKHZdh2JnLhrehlDR6mcsbr1j49OdMRepCktSToBtneK
	2juM+Ze+v5uygGAzeOfJ0NPqDPIXhMZgdl1WsNeGqq8hDwTh06f8oFXl13L8OrAZHNrJLZKI1uf
	FTw0BtUpYdkDM1lC5kElxU0qvdDUzeWI1COOsF3Ov2K/Dz5rIN4se8+rZB/13hlB1che0bdTN8O
	Fc0qZU8eTccvZ+ii4FhjxsoEbVk68L+uZVzNMpGNV/8VUiR503R/RoboavU/X1VO+C7VZkV3N54
	Go/dAnvJNOsxN1qOQ9nGzbgxQiYisen7Q/6SJsJyNkxU3rdJSCQEvm0Jvwde4gqYOQ2b8yUSzGJ
	9o2ULwlygdbr4h8uHObq62tyMCjFFy5f+RgkLGhS3NIFBth1b8nd7kVUzCsz88M3wbrH9HZlwrx
	tomhQtwh9VZ609QpXZXw4UFr
X-Received: by 2002:a05:600c:46c5:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4a35acba20dmr143926245e9.35.1793033515974;
        Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a293sm204540985e9.12.2026.10.26.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:51:52 +0000
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
Subject: Re: [PATCH v4] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <at-FKOk_-OrKTP8H@google.com>
References: <20261023145459.47516-1-amachhiw@linux.ibm.com>
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
In-Reply-To: <20261023145459.47516-1-amachhiw@linux.ibm.com>

On Fri, Oct 23, 2026 at 08:24:59PM +0530, Amit Machhiwal wrote:
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
> Use IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) to set i = LONG_MAX during
> this window, unconditionally bypassing the threshold check.  On kernels
> without deferred init IS_ENABLED() compiles the branch away and the original
> check is preserved unchanged.

Commit messages are not LLMs' strong suit.

Otherwise.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes since v3:
>  - Replace #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT / #else / #endif with
>    IS_ENABLED() + i = LONG_MAX to avoid duplicating the threshold check.
>    (Vincent Donnefort)
>  - Trim the in-code comment to one sentence. (Vincent Donnefort)
> 
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
>  kernel/trace/ring_buffer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c4e40847e43..09c02e838c4d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2463,8 +2463,16 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * memory. It may not be accurate. But we don't care, we just want
>  		 * to prevent doing any allocation when it is obvious that it is
>  		 * not going to succeed.
> +		 *
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
> +		 * will reflect the actual available memory only after
> +		 * SYSTEM_FREEING_INITMEM.
>  		 */
>  		i = si_mem_available();
> +		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
> +		    system_state < SYSTEM_FREEING_INITMEM)
> +			i = LONG_MAX;
> +
>  		if (i < (nr_pages << subbuf_order))
>  			return -ENOMEM;
>  
> 
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> -- 
> 2.54.0 (Apple Git-157)
> 
