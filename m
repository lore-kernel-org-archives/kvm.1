Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B725228C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390841; cv=none; b=qdOjAtlj6kIYPLcEHr7N+Eh4dc8E4sHSbdULOTpiNo3T1zLsFHHUDUhZnjOD2O4KO640ym0SwGPiVTgfDKwQv8T8beqdqMsd4NZxpQwA8dKpE4VjPsaEEE69IRIaBopjDX9uLUL+FMvrOe4eNtKKE4+nk1ILGkWwsZ3qhAttXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390841; c=relaxed/simple;
	bh=H5RPK4R7kmA8KL8UeiTfI7DQjjweVrVbVuh8QO/+S38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=agGqs0J3s8MUorfQpvYh1q8JSkHjtCJsq/Ez2PMHxDNo3SFJRiGlYo1HHJgYQpqyAEiLfYJD98uQTmnV3zMsyuEk++fSHblrw4B0HeG/g1d8MBTuFQ0GeZyL02qST03XHQvos1hutRkchgFisAM1nepHseY09KwkOmbm/Z/fxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6LwaGR4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6LwaGR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780390839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+cRenZ/ZFT3XyadVf117pp4rudLKkztn8jGLitRCK9o=;
	b=c6LwaGR4gdXwYoSARMuX98ASX4JT8PP0TypFvXkD6IXYEKxyg9ZUs+HtHp37TnDy91NmJ1
	Z2U8Rqlv9wJhkgVRb05IxClCa+12ULubro4YxhMWTiYK6XYoAe/VxyICGgkd0NwurzN0St
	X+t2SAxZX3jPn658mWspE7FZet+1JUs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-OYo42HWjPyS8Ya8Ze6VgiA-1; Tue,
 02 Jun 2026 05:00:35 -0400
X-MC-Unique: OYo42HWjPyS8Ya8Ze6VgiA-1
X-Mimecast-MFC-AGG-ID: OYo42HWjPyS8Ya8Ze6VgiA_1780390834
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F046195609F;
	Tue,  2 Jun 2026 09:00:34 +0000 (UTC)
Received: from [10.44.50.110] (unknown [10.44.50.110])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A10391800576;
	Tue,  2 Jun 2026 09:00:32 +0000 (UTC)
Message-ID: <8928c73d-4913-4c67-bf64-7e0c3fb8ff8f@redhat.com>
Date: Tue, 2 Jun 2026 11:00:31 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
To: Anderson Nascimento <anderson@allelesecurity.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, zhao1.liu@intel.com, mtosatti@redhat.com
References: <20260602022048.752453-1-anderson@allelesecurity.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260602022048.752453-1-anderson@allelesecurity.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 6/2/26 04:20, Anderson Nascimento wrote:
> Hello,
> 
> I have implemented support for exposing and enabling APERF/MPERF
> MSR passthrough for x86 QEMU guests when running on KVM.
> 
> As of last year, the Linux kernel supports providing a capability
> to disable APERF/MPERF read intercepts [1]. However, there is
> currently no native way in QEMU to instruct KVM to activate this
> capability or expose the feature bit cleanly via CPUID.
> 
> My patch introduces the `aperfmperf` feature flag via `FEAT_6_ECX`
> (CPUID.06H:ECX[bit 0]). It ties into the existing power management
> framework, so when a user enables power management via
> `-overcommit cpu-pm=on` and passes `+aperfmperf` to the CPU, QEMU
> requests KVM to drop the MSR intercepts.

Mostly looks good, but please mark it as unmigratable as well (similar 
to INVTSC which, not coincidentially, you're also using below).

Paolo

> 
> For testing, I passed the feature via Libvirt XML like so:
> 
>      <qemu:arg value="-overcommit"/>
>      <qemu:arg value="cpu-pm=on"/>
>      <qemu:arg value="-cpu"/>
>      <qemu:arg value="+aperfmperf,+invtsc"/>
> 
> A FreeBSD 16 guest is successfully able to read the changing
> values of the MSRs directly without exiting to the hypervisor:
> 
> root@freebsd16development:/home/user # cpucontrol -i 6 /dev/cpuctl0
> cpuid level 0x6: 0x00000004 0x00000000 0x00000001 0x00000000
> root@freebsd16development:/home/user # cpucontrol -m 0xe7 /dev/cpuctl0
> MSR 0xe7: 0x00007fdf 0x22480f90
> root@freebsd16development:/home/user # cpucontrol -m 0xe7 /dev/cpuctl0
> MSR 0xe7: 0x00007fdf 0x2b8b48b0
> root@freebsd16development:/home/user # cpucontrol -m 0xe8 /dev/cpuctl0
> MSR 0xe8: 0x000050de 0x49270831
> root@freebsd16development:/home/user # cpucontrol -m 0xe8 /dev/cpuctl0
> MSR 0xe8: 0x000050de 0x4ad66ae6
> root@freebsd16development:/home/user #
> 
> I am looking for feedback on the approach, specifically if tying
> this directly into `cpu-pm` makes the most sense to the
> maintainers.
> 
> Based-on: QEMU v11.0.50 (commit 5611a9268d)
> 
> Anderson Nascimento (1):
>    target/i386: Add support for KVM APERF/MPERF passthrough
> 
>   target/i386/cpu.c     | 17 ++++++++++++++++-
>   target/i386/cpu.h     |  2 ++
>   target/i386/kvm/kvm.c |  5 ++++-
>   3 files changed, 22 insertions(+), 2 deletions(-)
> 

