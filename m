Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FA233A70F
	for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967526; cv=none; b=Y5atrHi4FeSsLZiPbJJoaBitVJ3lYCglWCW9Ff+zN24v3NbSFCz1OEVFjsA6m8W1Q8oapo3qLI4SRH9De3FrZOeis2HpQyZrF1hXMVM1UiqXTsps0/9PgwMrAWT3Tet9U2j/0Bo/LmZ1N7iql+TWZGOmSPb4ULykVf7ZMwKzMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967526; c=relaxed/simple;
	bh=o2XZhoStTauDKWELbYgjl0TfZM824nSbVdrRhcJHmeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsjGJvzQogfZz9nOyZWbBxIyr7MASZCbKWeMUumfw6VLeRt8I7xSP55OFUZ74GHFxQLPssJTfZMdpQzDq/n5yub5xEHg9pYDcsSazEeeOjUziycM4vZ5/07ptqb5wx4YF1gNFT3+4KONPGdMtuldqjhs0A2ttyZQ4m0we9oo5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1vuzOi-0000000DESC-2xFT;
	Tue, 24 Feb 2026 21:52:48 +0100
Message-ID: <79f110e1-b217-4a70-81f7-d596f822dde5@maciej.szmigiero.name>
Date: Tue, 24 Feb 2026 21:52:43 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/kvm: Configure proper KVM SEOIB behavior
To: Khushit Shah <khushit.shah@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sean Christopherson <seanjc@google.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20251126093742.2110483-1-khushit.shah@nutanix.com>
 <F09B2DC7-6825-48B4-94A9-741260832167@nutanix.com>
 <C1DC0AAE-AE34-42E1-A15C-E03D1EE4D770@nutanix.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
In-Reply-To: <C1DC0AAE-AE34-42E1-A15C-E03D1EE4D770@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mhej@vps-ovh.mhejs.net

On 10.12.2025 06:23, Khushit Shah wrote:
> Hi,
> 
> I wanted to follow up on this patch to see if there are any review comments
> or feedback. I'm planning to prepare a v2 that addresses the following:
> 
> 1. Move the SEOIB configuration code from x86-common.c to KVM-specific code
>     (kvm_arch_init()).
> 
> 2. Refactor as per the changes on the KVM side of the patch.
> 
> Before proceeding with v2, I have a design question regarding the scope of
> the fix:
> 
> Currently, the patch sets the SEOIB state for all machine types on new power-ons
> based on the IOAPIC version. This means that any new VM powered on with a
> patched QEMU will get the proper SEOIB behavior.
> 
> However, I'm wondering if we should instead:
> - Define a new machine property (i.e, "seoib-policy") that defines the SEOIB
>    behavior.
> - Only enable the new SEOIB behavior in the latest machine type version
>    (10.2?), keeping older machine types in QUIRKED mode.
> 
> The question is: should new power-ons of *all* machine types set the SEOIB
> state automatically, or should we scope this fix to the latest machine type
> versions only via a machine property?
> 
> I'd appreciate your thoughts on this design decision before I finalise v2.

Now that the KVM side of this patch is in Linus tree are there any plans
to submit a v2 for visibility and with updated flag naming even before
getting the questions above answered?

> Regards,
> Khushit
> 

Thanks,
Maciej

