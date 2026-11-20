Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182601;
	b=z+pmnhzsOlG+Qjobp5/1TTEey7ElD5Ji2eXPdw5Us+sj2j7m7tJ6S9uxgjF1UHHHKF1U
	 4x44Sw0Hw8tUJQtdQbVix1krQo9lnkX1p0tHh9Xo3zRZUB6OqwkmHIVEQcplpU5X/ShbB
	 0U4mE6USHsy4K8DsQx52ev+JEfpN3uZ7UIDg2cIUebAAkA9IvbXZuO+DuvO8sC2mB30TX
	 icC74qJHRsO1N0FWc8NLv9xHCs9puTF/N2cRopuP9Epqk/EwcV/vu8s2MZLuXana6S88V
	 1VQd7494Cu1ejgVfJ7DyCtTQjPJKN6kUZYgPBtpL5QeP+vhcdADUQuE23yiyF+QzQDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182601;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BWuntrYZKLmbGJDcepGI0+XkvJsR4/iUmqxL36v3osE=;
	b=CAOIEA7+x1fQUglgK33nfwd5F6XFtyqo4gqdlk/BaK49ex5iUFNeEhfLZEfyIEGSSNgd
	 BRzAtMd+8qWyp8rd8mB0rVNe9yc+0yi4GwW2mrsHBYCs1LMa5angfcNEWalR74oXo//iV
	 WYodJCdENALzWD5YjREvGs+u/32yEHedhklmvg/oYuZkaDcLgYIgJhA10alNnI4zcMnLN
	 rkIeCrU9tzY4Y6XX0/98TLbaEe2KYEHqKu6mYRRpKpVLj2ve1GQwFfRPIJCD+pRDmWi+0
	 L2B8wWyw/rgSek5cupIHX/SF/s96NfFLQbggSVmFj3c9f2yazV8aroTCxVOthZlbXoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d22FHTaa;
	arc=none smtp.remote-ip=91.218.175.219
Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA7606A32A
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 13:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6CA7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d22FHTaa
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mseadl3+prfV3Njbj2odlN7ph9bWDdh3UmBz/VyOYco=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795182597; v=1; x=1795787397;
 b=d22FHTaaGQa1/D4Q5Ht21DMci3OqGuuFl6t6pWV49ADz5XmOJ91DRc7uAbaqGKWvJq6ubBIO
 6KTGDYiwk4WD6oaEKWqqAijDfLFzBInGDz6jpU4eTn8AVWchD6gFayg+oU1y8M7oSuAR6BHjc6y
 kbvLQh+ikLKMa3Mp387ZtDqE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 60c44ff64fed04d7;
	Fri, 20 Nov 2026 13:49:57 +0000
X-Mizu-Trace-ID: 60c44ff64fed04d7
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 14:49:26 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 7/8] riscv: initialize ISA extensions
 for all harts in cpu_init
Message-ID: <awBPzACbLy95U5yE@orel>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
 <20261105082035.133680-8-wangxiang@iscas.ac.cn>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105082035.133680-8-wangxiang@iscas.ac.cn>

"initialize" should be capitalized in the patch summary.

On Thu, Nov 05, 2026 at 04:20:34PM +0800, Xiang W wrote:
> Move `isa_init()` from `thread_info_init()` to `cpu_init()`.
> 
> Previously it only ran for the current hart; now it is called for every
> hart so that ISA extensions are parsed for the whole system.
> 
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> ---
>  lib/riscv/processor.c | 1 -
>  lib/riscv/setup.c     | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/riscv/processor.c b/lib/riscv/processor.c
> index b055acc9..ddecc25e 100644
> --- a/lib/riscv/processor.c
> +++ b/lib/riscv/processor.c
> @@ -81,7 +81,6 @@ void thread_info_init(void)
>  	unsigned long hartid = csr_read(CSR_SSCRATCH);
>  	int cpu = hartid_to_cpu(hartid);
>  
> -	isa_init(&cpus[cpu]);
>  	csr_write(CSR_SSCRATCH, &cpus[cpu]);
>  }
>  
> diff --git a/lib/riscv/setup.c b/lib/riscv/setup.c
> index f1121573..8c16686f 100644
> --- a/lib/riscv/setup.c
> +++ b/lib/riscv/setup.c
> @@ -16,6 +16,7 @@
>  #include <on-cpus.h>
>  #include <vmalloc.h>
>  #include <asm/csr.h>
> +#include <asm/isa.h>
>  #include <asm/mmu.h>
>  #include <asm/page.h>
>  #include <asm/processor.h>
> @@ -105,6 +106,9 @@ static void cpu_init(void)
>  		cpu_init_acpi();
>  	}
>  
> +	for (int cpu = 0; cpu < nr_cpus; cpu++)
> +		isa_init(&cpus[cpu]);
> +
>  	me = hartid_to_cpu(csr_read(CSR_SSCRATCH));
>  	assert(cpu_present(me));
>  	set_cpu_online(me, true);
> -- 
> 2.47.3
> 
