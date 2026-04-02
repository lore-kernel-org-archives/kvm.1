Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67B3D561
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775092593; cv=none; b=lW3UJTxMDJcWu79v0E6U8zKz1dVPgz3nM8T5O4AgJZQrQuUvFQhs7JgaiN0DtbLz9oXAPBqII8EXGD/AVBa93aC044+24Y+n8QU1gyXeyX82SWhr6otiH9T1zyVl4IExbW80gQBzE4kCEnAeUC6t9E5bDPOj9+xIepp/cDVEXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775092593; c=relaxed/simple;
	bh=Pr5phicjKYNdLGRPY8HJaT/SgUx1SjComUd0aOPfJ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuB3euG/6hf17h4oWeY7UF5twVNTeQDmdSImn/LHHlzWSwkFcGROCC6gDgM6/03Vqs7oVaEK90M8qhcuS0R5J+4+5sVnnd8AhecUDqscfAIeTfyJOCbnZFyUWst7QlafTlG6xCncqFpLwlYJptIO+FHbG6vfioR6i9WdU3cjHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5OQAM0v; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5OQAM0v"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b243198058so21265ad.1
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 18:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775092592; x=1775697392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hd5Cg21FW+GHdvlIoCgG4q/KVyzmxH0w705ye9IJfD0=;
        b=R5OQAM0vhQ1aKhpKyetOOvm82cokEpW9rWSzW+mLKr2ToJ5VKORRAMg0xqf02G996L
         gVf5cqdf7GF+gHDhpEHbbIuAHXLd7TBnjpOAVQ9cCGR4+VA0sjhg2YmwYBRMiTLinYnj
         qS+lMNjCEVdNQl2zRLV7L6rM7ILRAxwB2rI5+SfmxJFKsw7bjs62nkU1vhXT/NvIWSlK
         Jdeiwu6jGxohaFN4/QI1NFKDJ9J9yf/AAJoMIRstSW9xSktQ5QvVygdeuxDnyRhh37OX
         GvvorROHmZKotHUFuT4HbqiT6Wi0WcTG/9LCTNh2erizLh6uoHbX/4JjDvSyutkUy0eI
         Lq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775092592; x=1775697392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd5Cg21FW+GHdvlIoCgG4q/KVyzmxH0w705ye9IJfD0=;
        b=XROIq8dDPopqCmUM6M1FzJYdU3kuh6SWaxSyt81pE+2vS1XLg1uIl5sYURGprA3QrV
         N3+ALTsi8IY5dhvQdRLiWo4GM5H5/b+q3hxWzACBY6p5MKaUo2pCrQsKq0iD5Hdqy4ON
         D+r5kgL7XYiUpin79NPi2obo27/x7coctrsE5vGV6hPWEqOy98qSTdNpnE4q+Nptfdg3
         DfE/rSgBalsIIyQGUwaexB75KtXxJNW9yGPRJwHb3zedQNtmqH4X8rvh2TcmEwKdEeEp
         QqWzH0sBv1obgtwm2gqugpakRAtFJ8TawsGL+K4jl23lvNcssncdMhIBiCH6DqRPNP2W
         iE0g==
X-Forwarded-Encrypted: i=1; AJvYcCX/U3Jz9j6FCs8LC7aB7YAbl/RDhaPjy/6lUZSVo37YXtSzAlNZQxIRe0rjiuJlzINWQ1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTte6cjWZ8nBzaZCWPX4XfVsRXVJt+KU9PCGI8Kdal93t+Eec+
	Fj6cvDcYAZb77P3gWKvqmU9Zm3rUrNSZXoAllBw6Jure8e8pt6rECdGL06kSog3P
X-Gm-Gg: ATEYQzx/5plLXo4UA1DCPUdqEdhExs3eEaO1RayDTEX2S7XOtJxzKaU2XXLBz6OuK+C
	Eemx9aE5ox8feua97zEotOOaCGN6pj2edFCYSxpS+neZpvE3g/EHyNOv14B1HOpvgQNbNqmeZcp
	wnhK6RJuuf/3xT7Vpy+PMi8LgJLf/EsEvIhDBYNLNNqNnOnnD5sdUxFhvQhasewp9u402M1UfS2
	uOfjv0eUme0gtO26L6ev/LE+yfnCIXS5mEBBJNzU20IVKIswMLhZCbpz+JzDHAwEBhl0ukRE9WR
	7pUENTPeQhsyaUz2eu0iYzd5G9DQFHk0gv+xIK6D8EggnkvqW4Zg3VCQWjkmy95JR0BdhXMQssO
	1icKvowYfs0DqRm67WxePPE2C9vGUcfNz+aOGo6TVqY35UZRFDzIGChaiazPQOFZ3lGeqIEWUNn
	d4GToNw/vgQ9VOgmfN3z7n42yYz3czIMzxEAqOcSbjKkqO903Jy9HIiXKKqSB9cA==
X-Received: by 2002:a17:903:3806:b0:2b2:4663:abe0 with SMTP id d9443c01a7336-2b27844a367mr409565ad.7.1775092591416;
        Wed, 01 Apr 2026 18:16:31 -0700 (PDT)
Received: from google.com (128.161.199.35.bc.googleusercontent.com. [35.199.161.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd367bfbcsm954686a91.12.2026.04.01.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:16:30 -0700 (PDT)
Date: Thu, 2 Apr 2026 01:16:26 +0000
From: Josh Hilke <jrhilke@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Matlack <dmatlack@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2 05/14] KVM: selftests: Add support for random host IRQ
 affinity
Message-ID: <ac3DaqozN6nMdiHH@google.com>
References: <20260331194033.3890309-1-jrhilke@google.com>
 <20260331194033.3890309-6-jrhilke@google.com>
 <ac15psZs2_EGAVt6@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac15psZs2_EGAVt6@google.com>

On Wed, Apr 01, 2026 at 01:01:42PM -0700, Sean Christopherson wrote:
> On Tue, Mar 31, 2026, Josh Hilke wrote:
> > From: David Matlack <dmatlack@google.com>
> > 
> > Add the '-a' flag to vfio_pci_irq_test to randomly affinitize the
> > device's host IRQ to different physical CPUs throughout the test.  This
> > stresses the kernel's ability to maintain correct interrupt routing and
> > delivery even as the underlying hardware IRQ affinity is changed
> > dynamically via /proc/irq/.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: Josh Hilke <jrhilke@google.com>
> > Co-developed-by: Josh Hilke <jrhilke@google.com>
> 
> Please run checkpatch, the order here is wrong.
> 

Ah, my bad didn't know there was a checkpatch script. Will do.

> > @@ -122,13 +125,19 @@ int main(int argc, char **argv)
> >  	struct vfio_pci_device *device;
> >  	struct iommu *iommu;
> >  	const char *device_bdf;
> > +	FILE *irq_affinity_fp;
> >  	int i, j, c, msi, irq;
> >  	struct kvm_vm *vm;
> > +	int irq_cpu;
> > +	int ret;
> 
> Use the existing "int" declaration.
> 

Will do in v3. 

> >  	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> >  
> > -	while ((c = getopt(argc, argv, "h")) != -1) {
> > +	while ((c = getopt(argc, argv, "ah")) != -1) {
> >  		switch (c) {
> > +		case 'a':
> > +			irq_affinity = true;
> > +			break;
> >  		case 'h':
> >  		default:
> >  			help(argv[0]);
> > @@ -163,6 +172,14 @@ int main(int argc, char **argv)
> >  			continue;
> >  	}
> >  
> > +	if (irq_affinity) {
> > +		char path[PATH_MAX];
> > +
> > +		snprintf(path, sizeof(path), "/proc/irq/%d/smp_affinity_list", irq);
> > +		irq_affinity_fp = fopen(path, "w");
> > +		TEST_ASSERT(irq_affinity_fp, "fopen(%s) failed", path);
> > +	}
> 
> This plus setting the affinity is begging for a library function, probably
> provided by what's currently called get_irq_number() and friends.
> 

I'll create a helper and add it to that library in v3.

> > +
> >  	/* Set a consistent seed so that test are repeatable. */
> >  	srand(0);
> >  
> > @@ -172,6 +189,13 @@ int main(int argc, char **argv)
> >  
> >  		kvm_route_msi(vm, gsi, vcpu, vector);
> >  
> > +		if (irq_affinity && vcpu->id == 0) {
> > +			irq_cpu = rand() % get_nprocs();
> > +
> > +			ret = fprintf(irq_affinity_fp, "%d\n", irq_cpu);
> > +			TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%d to CPU %d", irq, irq_cpu);
> > +		}
> > +
> >  		for (j = 0; j < nr_vcpus; j++) {
> >  			TEST_ASSERT(
> >  				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
> > @@ -189,6 +213,8 @@ int main(int argc, char **argv)
> >  			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
> >  				printf("Timeout waiting for interrupt!\n");
> >  				printf("  vCPU: %d\n", vcpu->id);
> > +				if (irq_affinity)
> > +					printf("  irq_cpu: %d\n", irq_cpu);
> >  
> >  				TEST_FAIL("vCPU never received IRQ!\n");
> >  			}
> > @@ -203,6 +229,9 @@ int main(int argc, char **argv)
> >  		pthread_join(vcpu_threads[i], NULL);
> >  	}
> >  
> > +	if (irq_affinity)
> > +		fclose(irq_affinity_fp);
> > +
> >  	printf("Host interrupts handled:\n");
> >  	printf("  IRQ-%d: %lu\n", irq, get_irq_count(irq) - irq_count);
> >  	printf("  Posted-interrupt notification events: %lu\n",
> > -- 
> > 2.53.0.1118.gaef5881109-goog
> > 
