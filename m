Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174712;
	b=P/B3fPSodjxZr9Z4oYCIaojQ1yVia6DacTxyaRElHEkx6awNF3+IqVSwur3OBfft6rYo
	 /TL7tebqxCDT0UotES946RMji/F9SW+LOqpQTR+IssOdn+1l5NDrL/9aOm9HQwf76Aq6k
	 i0lJspJo7sGCSU4ad8zJqKr9yP83PWgbx8bWhU57NHQWOFDsL0FqbZdmWAZ1FNzrUxftf
	 KPYw2eBYOFqM+A5c+FIVAhGA/oiUsjhElka1V5ysH+GgJZz8WLvsPUO9K4WRr4anoaqcW
	 7Vi5NyHXrZhmYRAJ+FRy6d/nmSpz1EBUAbgUBA5l6EoeKjOKDu+LMtTL7h1pasbdt1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174712;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YkEw3fH+778GygbWBSwzYDLvj4JjWl5hDAY4dcA5t54=;
	b=lrQbUKbNMUCmEnM1vM09+8+CSMtg5XaVLNYmU2ZNyesD17ObXyMxyq62EUzSkgdGnild
	 rvhUbtuoVV0Qz2HPzLmRHyzuL25YCjXsnAvuNRTDPo9ntB7lzDSLqTQUzj992fRb6s+FZ
	 xtSDXBWx6VHmSgUY8TIXA4OO8tM5+5opiWwXwWI0QcG9ZLWOchcPlBSe7k6xItGPauoFA
	 KiFSpo6suSN3eLz0L+b0CqcE/a2VI7QYrVbSwuIuB3FF6kqd/bgM/bibzu/lBFZtieZk4
	 wPrSCoDIEWJGblmRx+nF7c6rAAac7uSQhNBZreuDjRhJvWEbZlwGruVsJCYRCVlZdIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=paemgFwc;
	arc=none smtp.remote-ip=91.218.175.194
Received: from mta0.migadu.com (out-194.mta0.migadu.com [91.218.175.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055B60A2609
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 11:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E055B60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=paemgFwc
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EED0LOn8kMLeT/0F0q+OLC6vYC9sgzoTZhYuEoPU/AE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795174709; v=1; x=1795779509;
 b=paemgFwccE96Gd1wN6op7h712Fvg2jV2Ce5djHCi8nii+XrPJ0EpEHA1ujuQ/9005djk4BRB
 rHhtWYu3h0RxhyeIkSuwmtuK/mg3v8TCmoq55gfGC7Z2m3zL+ZH8TqkwXZKrFmOWLC4444fyc3H
 L2NMb2pPIRnmjXB0wqpKcjrs=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 80c0f1bde74df4e5;
	Fri, 20 Nov 2026 11:38:29 +0000
X-Mizu-Trace-ID: 80c0f1bde74df4e5
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 12:37:59 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 7/8] riscv: initialize ISA extensions
 for all harts in cpu_init
Message-ID: <awAt95G5LR33UsLN@orel>
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

On Thu, Nov 05, 2026 at 04:20:34PM +0800, Xiang W wrote:
> Move `isa_init()` from `thread_info_init()` to `cpu_init()`.
> 
> Previously it only ran for the current hart; now it is called for every
> hart so that ISA extensions are parsed for the whole system.

It was already run on every hart. The boot hart at boot time, the
secondaries at secondary start time. However, I see in the next patch
that you want to query ISA extensions on secondaries that haven't run
secondary start. Since we already initialize some thread info in cpu init
then I think it's reasonable to also init ISA there as you do, but let's
do it like in the following diff instead of anding the loop

diff --git a/lib/riscv/processor.c b/lib/riscv/processor.c
index b055acc94e41..ddecc25e940d 100644
--- a/lib/riscv/processor.c
+++ b/lib/riscv/processor.c
@@ -81,7 +81,6 @@ void thread_info_init(void)
 	unsigned long hartid = csr_read(CSR_SSCRATCH);
 	int cpu = hartid_to_cpu(hartid);
 
-	isa_init(&cpus[cpu]);
 	csr_write(CSR_SSCRATCH, &cpus[cpu]);
 }
 
diff --git a/lib/riscv/setup.c b/lib/riscv/setup.c
index f1121573e81c..547851f532c3 100644
--- a/lib/riscv/setup.c
+++ b/lib/riscv/setup.c
@@ -16,6 +16,7 @@
 #include <on-cpus.h>
 #include <vmalloc.h>
 #include <asm/csr.h>
+#include <asm/isa.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/processor.h>
@@ -61,6 +62,7 @@ static int cpu_set_acpi(struct acpi_subtable_header *header)
 	cpus[cpu].cpu = cpu;
 	cpus[cpu].hartid = intc->hart_id;
 	cpus[cpu].uid = intc->uid;
+	isa_init(&cpus[cpu]);
 
 	if (intc->flags & ACPI_MADT_ENABLED) {
 		if (!sbi_hart_get_status(cpus[cpu].hartid).error)
@@ -79,6 +81,7 @@ static void cpu_set_fdt(int fdtnode __unused, u64 regval, void *info __unused)
 
 	cpus[cpu].cpu = cpu;
 	cpus[cpu].hartid = regval;
+	isa_init(&cpus[cpu]);
 
 	if (!sbi_hart_get_status(cpus[cpu].hartid).error)
 		set_cpu_present(cpu, true);
