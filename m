Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849541;
	b=eWbmMOL1HtXThnDkjznsIZt4Hzyi4ToqhWORHnpRrew/Mj3R2ZN88fa7kSE33YKs0HyO
	 6ZoOy84jTZ9IXhus3QZicjjKumoTXit5B9iEq5rY53bjM5pariNK1MzuAQSgR55V2cH0R
	 koeh2NNEtVnG5Ys4GDl9YqubRQbMcxoBvuXknVTdOXyNVivLMiJGtV+NjQJeKdUMgmV8J
	 foCunzB5amu/FDcODRe6jd4McrpmKve3G6IuKeLj0KaKwnFJkV2gfIaQHN+PpddwJBTci
	 tEobekNtrqCFdwAKQLda+T4lAkvYKWMAvbPwB3aySybFSbKsj2EvpHVpsjsRVrqlOug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849541;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=OzaqIXPqhSSG4ejd/hB4U1AFDk/wquty1pyzaNNEA1Y=;
	b=C0rY/kH8DJVMHVBR7C+8zFuKVrKWnsIenac6YokTPiD2sCOelMFyEACH37uT38gKRrqh
	 6nTJiFfVuLaaaOlEaXcd/1cxVT5ByKpRA3GyC2ArRo25vGd7WSIWxOVUvQlBlXoLSKndN
	 tD4+fUmt8oeRyuV3qpAmCmcKoOrz4XR2TSGq/o8HINmTaUwqUCd1NXR0PoV9B87lnyyDR
	 fad/dwdFGxyTqO+mXECk0/jGZEyN1UQIAkv0HXmcL+EuF3+V/2pgSlgYTokHu6QgDQ/Dz
	 PMByr5zq1+KAnvCzguloCEvijh/BJzEbpFpC1H7aUHsowi4lLpI3oGaUL2uHmK50y5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZoSV5rIN;
	arc=none smtp.remote-ip=95.215.58.44
Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5912606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 17:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5912606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZoSV5rIN
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PAxYfgYQrRbaE3T1nWWUCpJHJViNiRZaZVomuIz4tHw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794849538; v=1; x=1795454338;
 b=ZoSV5rINn65l40cWzZSH8b6WS496zQWk6wvN+E/+81fz+tLMKT/Pw64TNet3QRkay3RyOX24
 iO62DuF5ZGGsmv7AeDKc1vCnVipFfjsGA0rov0mjQYVkWQ90Cu5HkVuQE47j20ryi6+GTYAfm9G
 fW14WOUuT95o078lFeVsrc0w=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 35f70c988f38104d;
	Mon, 16 Nov 2026 17:18:58 +0000
X-Mizu-Trace-ID: 35f70c988f38104d
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c144eb2f43so9682e87.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 09:18:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFj1M6yv2OH6Aul3MHC1nvnpMEwyX2GMiKUrqHWXVmOLAxCK7N9uDNLMHnJ02DHr7uAubo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zp6RzDAgIDpo17wLhOPNs8bthgONmTUpINulJi7knAdWjUfXq
	G/2wg8i3m9vbTPGASAWAMaFqRw6EIW+aqxj9d6ubaYeSAJ5+uSajuwv5sxATm6sBzv1JZxpeBxu
	Ct1LIODyeHcNqMcciIDkgOU152SFHjyEesXRdEvPV
X-Received: by 2002:a05:6512:110b:b0:5bf:f84f:1d74 with SMTP id
 2adb3069b0e04-5c17e52e81emr262285e87.13.1794849533007; Mon, 16 Nov 2026
 09:18:53 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-2-fuad.tabba@linux.dev> <avM81YcTBTJ8zCMX@seanjc-mac.roam.internal>
 <CA+EHjTz-Nb-g9YQKX2fKk61hC2BfzXfmUHv=2j+eZ18YuTv2Eg@mail.gmail.com>
 <CA+EHjTyqJfGS+5UajX=RYTAG-qfhZ-vmGi=1SixXydWhwGHLUA@mail.gmail.com> <avs5UD79FB_DG1Vs@seanjc-mac.roam.internal>
In-Reply-To: <avs5UD79FB_DG1Vs@seanjc-mac.roam.internal>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 16 Nov 2026 17:18:16 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwXO_Ym1+ErHT9Si6FwHtDaPDmMRwY+RS8LDNK421rchA@mail.gmail.com>
X-Gm-Features: AclHuK9xW32VPDT60mgyMDdb5wXbr3ChwJoDPUUlo1Wmi2N2JEJM_TMFlrp_0kc
Message-ID: <CA+EHjTwXO_Ym1+ErHT9Si6FwHtDaPDmMRwY+RS8LDNK421rchA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: Stop KVM_PRE_FAULT_MEMORY when the vCPU's dirty
 ring is full
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 17:11, Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Nov 16, 2026, Fuad Tabba wrote:
> > Hi Sean,
> >
> > On Tue, 10 Nov 2026 17:18:22 +0000, Fuad Tabba <fuad.tabba@linux.dev> wrote:
> > [...]
> > > > Eh, I vote to just use kvm_dirty_ring_check_request(), I don't see any harm in
> > > > clobbering vcpu->run->exit_reason.
> > >
> > > Will do.
> >
> > After taking a closer look, the clobber is problematic on arm64, where
> > KVM_RUN completes a pending MMIO exit only if run->exit_reason is
> > still KVM_EXIT_MMIO. If a pre-fault stops on a full ring after an MMIO
> > exit, the helper overwrites exit_reason, so the next KVM_RUN doesn't
> > complete the exit and the guest repeats the MMIO access. The ring can
> > be full at that point if the pre-fault dirties pages, or with NV, if
> > the stage-2 walk for the MMIO access does.
>
> Wouldn't that require userspace to do KVM_PRE_FAULT_MEMORY after KVM_RUN with a
> KVM_EXIT_MMIO return?  If so, userspace gets to deal with the fallout of being
> stupid.

Ack, so v2 will be as you suggested.

/fuad
