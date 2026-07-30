Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B53441600;
	Thu, 30 Jul 2026 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428810; cv=none; b=iqTpqQyGZhuTSORqZEhRVOGz7rpy9CqnK70AJINBVb2mRAeAn7Qi2BtiJ37FheRmd+AQkTZznUDHz4zAitMOyxe6aiexVMg6zSAiyxQlfa6HvzyL1HIh1HTDmk7SvXYG2URSlUmx0Vni28LuGbAr0OuZydN5CGYK2AdLAY1RIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428810; c=relaxed/simple;
	bh=VntuQUaXJAtYwfKJU77ZigpNhjzwOUaxlM1KKhsH0/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oavTBEd/cUdsT1FcsAeBjlEA3jynV6YaBnSEe+jG3ZEK9WhpdITNy90p/qrNPurh1aGKYVOlGelUHsOt4T0aexpD2JopQWspJyQvYlPJK7xESeZq+qrWc9fKtfXUM18tStO9/GmJGYHi7AWglCKbltXSOTSvom3mo7+Y7/NJhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUCT6PZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUCT6PZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4778D1F000E9;
	Thu, 30 Jul 2026 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785428809;
	bh=XBfSZ0M8SVFyNgY+cIgugpJYtJRw79FUadUaOEFOPDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OUCT6PZpP24nQf+Blfs6PeEYyYPk3VYZ/VfJVLb+jstcEKu7yXpVga/CVuz/WY8C7
	 4geTGkirC27jEfh4wLBYqCHQ+B0sBwuQqXRiKwrsA+gZrTlfrtpDrGv17tghumhQj2
	 jHf8pYCxzL8e9zGWCowcbfIlYZMeS8UZRH4HyXw/NaZzLN1WP83m3Dr/kqs/hIeZRe
	 gSEjWdQhXGcTSXtUcrNTewaIbvCD/7ZNDILD8V+HnvDDWLu+xRRMCiiM5VbG2QWnqd
	 a+mit9t9nsT3k+CmiZSJ6lBdfbDwJ+i5Yx1VECWGOKParY0CpGDb4YlAzHyK8a0zbm
	 S2dW6JrCrRb6Q==
Date: Thu, 30 Jul 2026 10:26:46 -0600
From: Tycho Andersen <tycho@kernel.org>
To: Alexander Lougovski <alougovs@redhat.com>
Cc: bp@alien8.de, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, vkuznets@redhat.com
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
Message-ID: <amt5YCuJhzpxHMK7@tycho.pizza>
References: <amkdorffsAuguuIk@tycho.pizza>
 <20260730110248.49444-1-alougovs@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730110248.49444-1-alougovs@redhat.com>

On Thu, Jul 30, 2026 at 01:02:46PM +0200, Alexander Lougovski wrote:
> On Tue, Jul 28, 2026 at 03:34:36PM -0600, Tycho Andersen wrote:
> > my LLM complained about the '% 2800000', looks like it's selecting
> > from 1..2.8M in a 1.6M table, so the updates above 1.6M don't affect
> > any rows.
> 
> Hi Tycho,
> ah, true. Your LLM is correct. I've been experimenting with the different sizes of DB to ensure more memory churn (avoid sql reading from the cache) but then settled back to 1.6M.

Ok, makes sense. I found enough hardware yesterday to run ~35 VMs with
a bit of memory pressure, so smaller is better for me.

When you say "200 VM hours", I guess that's an average? Or do you find
they need to run that long to see the fault?

Also, how are you detecting the BSOD? I'm just waiting for ssh to stop
responding and screen capping the VNC, but maybe there's a better way.

> 
> Another thing to mention, it looks like 1582 workload version I've shared doesn't work correctly. So I'm attaching an improved version which mitigates problems - the version I shared before, was still generating a noticeable amount of TLB flushes but still wasn't exactly working as it's supposed to. So here is the improved version:

Thanks for this, I'll update. Though based on:

#!/usr/bin/env bpftrace
kprobe:svm_flush_tlb_gva
{
        $vcpu = (struct kvm_vcpu *)arg0;

        printf("%-14llu %-7d %-16s %-4d 0x%lx\n",
               nsecs / 1000000, pid, comm,
               $vcpu->vcpu_id,
               arg1);
}

I was already getting quite a few of these flushes, so your scripts
are working somewhat :)

>   -cpu host,hv-time=on,hv-relaxed=on,hv-vapic=on,hv-spinlocks=0x1fff,hv-vpindex=on,hv-runtime=on,hv-synic=on,hv-reset=on,hv-frequencies=on,hv-tlbflush=on,hv-ipi=on

Thanks for this as well, I only had hv-tlbflush=on, I'll go ahead and
adapt my command line to yours.

Cheers,

Tycho
