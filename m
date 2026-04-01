Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B913A9DA6
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077240; cv=none; b=JFGZqeBZfUhu97OpJJV8sOK87c36gI6p/oS9t7OZ6gFgP6oqoYRMuxZ/E2YHCFSiExVfm+qRcjgPbpDY098LOvTScS4ZMHHl7BlsQfqcce6EuMCTv0OsxkLfXC/hYP/zGbMwzzxBFfvgfVi1w3ayCjB5YtmXp7Xq+gQkeyZgYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077240; c=relaxed/simple;
	bh=rwCTMhhW1mlm2pQN2PUj1MkMfhRFEtQPzL6FszfFEdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mMNyuXedozE2dk7EZ0NlRYgpINnYZQFtWAWJrTJwGdZmQjUsEAKA7gWSazq2qKEha7mD8Rqw4Ze+ZttS39J2hvOw62Lke1lLfNk8Y2I9CptbQuXCv6uU6qUwBa9V92deg97EDCSketEgLIs2I6kro9Sdodn46qCDkt3g5h7ERTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3bC+BZ8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3bC+BZ8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b23af7d7e8so5566435ad.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775077239; x=1775682039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Onj4oOQCUP+/EEd8Xnfd/XRtqXrJLCIkDndkOebLk=;
        b=E3bC+BZ8x4/SPCTvD+ufe1mlHOyqjLXeUQPuxbIUQW5QGD1t+FAM5Q7E2b4PqH3ttr
         R4i/vfvUEqKcQCiqANvC1gUQcPqcKWLhAp7QUa4X1aSs1sU0/NAwrlAbyAp6zDbCOvpa
         zBqPwEOIpGuIZrHVkBRRIPxhpZNwzPHgaMs3gnMsien25j9WEer1jpqNJh+HT8nzvUPX
         43rn5084rbAwkkEk8vsRgyx+hWQniwIWA7NF6wCVhR7sXEVzf26GL4q72f83Uf7hxhLE
         5bLr3Qsp6Wg2Ry1d3lW0K9YEnytYlO8NJ/Yli7BhaZ+HkvtlB8sanwdoVMatWXPg2pqS
         3FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077239; x=1775682039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Onj4oOQCUP+/EEd8Xnfd/XRtqXrJLCIkDndkOebLk=;
        b=QtHEmWmP5tB+dfGyB9KA6M91L6NnNMKC557RjLk4B6ttGSzPG6gE8ZkoUQF/Is6ITg
         boxD7qI4fALsJQsKEnrYeZepjnw/k8tTLFDFUAmHxaOa8qdr13SFdcQLts/h/U9dcyTK
         MhYmSeg2X0KQumkWUNu/wgb1SxzRserGxnkIEsorB7kFLecQ3DE6elGeANz+qnU8cBA/
         sKNojgmQ0umCqJSHl9h6J+GD+WdoDH9gHOSusWRihDe5/UkLo1Z1c+5l3zmtGJpcXkpT
         tXGwMPMFLKxjcv8eGx3MMy9bqISvuQEX6SItRiI33b7zt3GCqQTsmmw0CHxDZ8BE34UJ
         qmVA==
X-Forwarded-Encrypted: i=1; AJvYcCVts1+dWhwsoapWstcsA/FUEccuQ9Q/Kdk9oDFmHKSEc67oii+d18CQE0NiEXWzg3mHDM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+xMeGK2bXwxBdU9rd0Oo3siQjAYZJlwHxIUmXJooEd5UbC2a
	vbR+1zNUhr46mudwKaT930qhIQG3QNNEHIaclwyO41zmX5kevu44DlHUBoFIyYdMX0Zjy9NYsWu
	E/kri+g==
X-Received: from plgy11.prod.google.com ([2002:a17:903:22cb:b0:2b0:4ce1:a0e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1250:b0:2b0:60f1:de58
 with SMTP id d9443c01a7336-2b275dc23b8mr6460715ad.45.1775077238622; Wed, 01
 Apr 2026 14:00:38 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:00:37 -0700
In-Reply-To: <20260331194033.3890309-15-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-15-jrhilke@google.com>
Message-ID: <ac2HdXsXyQ0U_-WR@google.com>
Subject: Re: [PATCH v2 14/14] KVM: selftests: Make vfio_pci_irq_test timeout configurable
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> Add a '-t' flag to vfio_pci_irq_test to allow configuring the
> interrupt timeout. This provides flexibility for running the test in
> different environments where interrupt delivery times may vary.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>  tools/testing/selftests/kvm/vfio_pci_irq_test.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
> index 2dcac6fbc009..807e9aecc887 100644
> --- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
> +++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
> @@ -25,7 +25,7 @@ static bool guest_received_nmi[KVM_MAX_VCPUS];
>  
>  static pid_t vcpu_tids[KVM_MAX_VCPUS];
>  
> -#define TIMEOUT_NS (2ULL * 1000 * 1000 * 1000)

Aren't there defines for this sort of thing?

> +static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
>  
>  static u32 guest_get_vcpu_id(void)
>  {
> @@ -196,7 +196,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
>  
>  static void help(const char *name)
>  {
> -	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] [-v nr_vcpus] [-x] segment:bus:device.function\n",
> +	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] [-t timeout] [-v nr_vcpus] [-x] segment:bus:device.function\n",
>  	       name);
>  	printf("\n");
>  	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
> @@ -210,6 +210,7 @@ static void help(const char *name)
>  	printf("  -n: Route some of the device interrupts to be delivered as\n"
>  	       "      an NMI into the guest.\n");
>  	printf("  -p: Pin vCPU threads to random pCPUs throughout the test.\n");
> +	printf("  -t: The timeout in seconds to wait for an interrupt.\n");

Uh, for *each* interrupt?  That's insane.  Something is massively wrong if an IRQ
isn't delivered in waaay under a second.  If this is purely a "sometimes IRQs get
delayed for a long time because the host is massively overloaded", set the timeout
to something absurd, e.g. 10 seconds, and call it good.  Then rely on the runner
to deal with the total runtime.
