Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D474C6F11
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594053; cv=none; b=uDCSUCTMyDCBhN5zjfqlFwHKO8M9XIS/3RrJO6Ip/CuMcpjNFbCeR7K15xeY0zQBwH8zbnZ3SxIel2RCT7mULSXzHiE1UHF/ESOBL9kVmAUFrUZ35zejVjc/XullCpV6mbFXOYJvvsk6uKZv847eoB8MWx8M5kLE6mkKCYWFnj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594053; c=relaxed/simple;
	bh=JwWV856tZhQRbvWwA5YTL5FY1rX+zrsPCS+w2CdpZRs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XCvAYgbq7KVDID5FIA7L8IS27mQjJrKOnDznApMF6OFF8AtmhbxMf/FfUNurYwjxxy/MfWzG543eetymJmzww3LEfJdo1he/aqH184fsWylqz3/4geWD3QZRdOUPulrQfjWzhkihKiz23cRvl24ShbBAt3aUN/ydsi3qL2z9f0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rO6laRmP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rO6laRmP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d982d932aso1281604a91.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780594051; x=1781198851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFq5d3x5ye3mknGU4YVD43umBtdzTEPmebuap4yJYfo=;
        b=rO6laRmPEAswEJB9V+go3TLBJboevMaTMRxV/PkZeox+8GT4sJPROoKdjcxLOiwlbs
         pPpWZ2t2KEaZ6WFEmBpebsT6Yo/5NVnVV1WfUP0mvE/P8R/G7GIoMrQ9cgp8qTw2tPoI
         s3i3vaJ8pnQHuL2/ysCMt57pjTDesgCIlIvuS5rBI+ISSYf19oSPWUFUlZG3x/kGQyjV
         gAF1QBM5Ru5uTHsl3Vqykk5oiINvxUcorivd4XMbPFQjnCia2PrvbfI1Dragj9V5Rdtl
         bdVyD76VQHrOXcBYexjz1wV8VVgrAi+iDggesc2hR3ZMacuwabgy87WC7EVsMsd8LPR2
         lkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594051; x=1781198851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFq5d3x5ye3mknGU4YVD43umBtdzTEPmebuap4yJYfo=;
        b=Y3nsseYyptT+mrHLnPBDcRzwuptnqnSgV4YZUkN1I7T1WjEGBE1kamugHtRjkrL8pV
         b5Qc3ubRkMYlH/vy+ay8h2ItddujdaWBE33pbJOdK/3eKTdtpyggvOR6pCgAtiRf3zDp
         r1enpda8/17FRrIv2ghCTzMyHUlzwyI4Fv5SscBAQujVGGl2aiuqg9GPV5AKpxLoNaMF
         VyfpN1SR+ic/ncfnLqtyfWa22vFlKG7jgQ30Dx3Hgv0Mr3Ib0QWmv/YYPCtjFTH0QMkF
         9Vtbj7+jLY/GavKj8jRXUxTROH2qR6HUDIyMktP7Q6JvrePZA4OBwkYeLsOnj5TB0uAq
         yRSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wLw07TekByYnk7MsnSVsDfLu+ZSjIOyzzSVutZz7QawEokaS8lS8HfBixZsZC8CEbE/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5qxcNHnQLxjCQYFXZ/1k9QF/HO2YnqZ8QELBVoI4nTa7YNnG
	gaWAZhp5G93h7c4V+BXih3HFKOwSc0OMFUSbzQv67RPTHuxfrg74/4fSaQIWi7oCsA07gWJru/3
	Uu6uoGQ==
X-Received: from pjto20.prod.google.com ([2002:a17:90a:c714:b0:36b:dbd1:f512])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5628:b0:36b:2179:6d23
 with SMTP id 98e67ed59e1d1-36e3294e53dmr9915991a91.7.1780594049270; Thu, 04
 Jun 2026 10:27:29 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:27:28 -0700
In-Reply-To: <20260604020143.748245-19-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-19-jrhilke@google.com>
Message-ID: <aiG1gOO51IIREKlo@google.com>
Subject: Re: [PATCH v5 18/21] KVM: selftests: Verify vCPU migration during IRQ
 delivery in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Add the '-m' flag to tools/testing/selftests/kvm/irq_test.c to migrate
> vCPU threads across random physical CPUs during the test. This validates
> KVM's ability to handle vCPUs changing physical CPUs while interrupts
> are actively being injected.
> 
> Co-developed-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/kvm/irq_test.c | 33 ++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
> index ed48562318bf..5f7df76005ec 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c
> @@ -18,6 +18,8 @@ static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
>  static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
>  static bool guest_received_irq[KVM_MAX_VCPUS];
>  static bool guest_received_nmi[KVM_MAX_VCPUS];
> +static pid_t vcpu_tids[KVM_MAX_VCPUS];

This doesn't need to exist.

> +static bool migrate_vcpus;

This doesn't need to be globally visible.

>  static bool irq_affinity;
>  static bool block_vcpus;
>  static bool done;
> @@ -67,12 +69,23 @@ static void *vcpu_thread_main(void *arg)
>  	struct kvm_vcpu *vcpu = arg;
>  	struct ucall uc;
>  
> +	WRITE_ONCE(vcpu_tids[vcpu->id], kvm_gettid());

...

> @@ -246,6 +264,14 @@ int main(int argc, char **argv)
>  	 */
>  	irq_cpu = -1;
>  
> +	if (migrate_vcpus) {
> +		kvm_sched_getaffinity(vcpu_tids[0], sizeof(available_cpus), &available_cpus);

This is silly, just use the affinity of the main task.  There's no reason to go
look at a child task's affinity.

> +
> +		if (nr_vcpus > CPU_COUNT(&available_cpus)) {
> +			printf("There are more vCPUs than pCPUs; refusing to migrate.\n");

Why?  Overcommitting vCPUs:pCPUs is quite common, and arguably more interesting
for this test.  And it's not like the test prevents overlap anyways (it is random
after all).

> +			migrate_vcpus = false;
> +		}
> +	}
>  	for (i = 0; i < nr_irqs; i++) {
>  		const bool do_clear_routes = clear_routes && (i & BIT(3));
>  		const bool do_use_nmi = use_nmi && (i & BIT(2));
> @@ -262,6 +288,9 @@ int main(int argc, char **argv)
>  			write_proc_irq_smp_affinity_list(irq_affinity_fp, irq, irq_cpu);
>  		}
>  
> +		if (migrate_vcpus && vcpu->id == 0)
> +			migrate_vcpu_threads(nr_vcpus, vcpu_threads, &available_cpus);

Meh, rather than shuffle everything in a batch, just change the affinity for the
target vCPU.  That makes the code easier to read, and is arguably more interesting
because there's at least some chance the task will be migrated while the interrupt
is being delivered, whereas migrating everything up front means the migrations will
have completed before the interrupt is sent the vast majority of the time.

> +
>  		for (j = 0; j < nr_vcpus; j++) {
>  			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
>  				    "IRQ flag for vCPU %d not clear prior to test",
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 
