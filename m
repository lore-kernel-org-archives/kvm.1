Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503367;
	b=OWU0pcGXageA3lz7jEshOBsEe4X4qgGA7R842qafpLenJd5jCbbvwypnzQapyn5D1oS4
	 o6bOkw7EF/OoOwAEBwtzRbdWDiqvrHacV/xWKusTxOCHrZeJcIahbJeTyQGDOqvGdOhwa
	 E/1N816T4rDD1ml7A/d1Knl61VsEL1QxMkhcRaqjV97Xxhb65518rjCX+H2hg4W6Io5Aw
	 RwIw9zc74JMqYPUNPvGp/VawvBvN+5Ll1GjusNe1LafwHLqt3/eSqkuyPBI7uv1W385l4
	 lWhHo9V2of2FZyO45Hptl/+VCVqKMmQaB0sKjCeOtXfPlMTx6bxocVqS3/vdoDi/CUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XgO6TvwkTbETFKtMuKfDtt/v/BUeO0jfQ5e64t9KyAY=;
	b=14IASUnN6UHxuYa3gjQaUj6MgxSYjkc8YO4IPD8CrFKMHKKNpAl7T6kyydtY2+Oo9JN7
	 d5K3vwQXUpmK1/i0T/3w2huElQaYTagML/x1X5f0x20ME0YZGk9K2FSA0G2CTxT8Ez0qq
	 mAw5ag0imdu0CFzelfVwycxKYDGEAV/YcX5ZnApjYnVpVN5OvhIehO+lOAgr/8p8H3lLe
	 BTF7LBcNLoLFDEbPUQX5ADEhOCmyjBcyFsAP4qeN6tL309pO+Rnrxh89nixv1Gxs9VVUF
	 wYQmWGBlYLzu3f4BeZaI0egvSgPtLUgxXfk9oxqE3Fk/ikqnexWqGgVgd/a+cc1Ko6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jet4S+gw;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D5606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 17:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D3D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jet4S+gw
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b15e47e57fso2526256a91.3
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794503366; x=1795108166; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XgO6TvwkTbETFKtMuKfDtt/v/BUeO0jfQ5e64t9KyAY=;
        b=Jet4S+gwLGLCtxSH/m59uliIMh/vAV2Eb40A8ex8cq5/T7tOyXRa7tMbM2KAmEMLpF
         jl7FGsFUO19SQaX4XdQ6K9U47wsYXh3VyijUjVWMkgL3uEPIYgDMpZJTY3qvFlUp4yf3
         d4qhMZy7/RLBFKooSr2bsOTLaqdNlvwtESMGJit/AmdGxbTmoU44zwUpJjBFrVKTeN1H
         3GcqwKeI29EIsqASDXnHfLcvZB9r7nq8qtZ6bZcfP4TzykCHMEZOBw3j/3dDEgF/1URR
         BkjztNJVWNa8HqwKyDUInlZFx21816iWFbpzl75P9zGLTjFMrjYtZglsT0TdSxl83zUe
         TgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503366; x=1795108166;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgO6TvwkTbETFKtMuKfDtt/v/BUeO0jfQ5e64t9KyAY=;
        b=h/pxifvV3zxnPpHQe3pKtGidrc0CwMhjWVkeuQNxa4VoFU1Wg89MRRjAkPSl2ta5d6
         CQ53wC+gqeUylAQD8zuByfSdbaLB449yzTqiqSCfn5pvdp5rwABF9Lm9DrLhWA7GQ7Uy
         3yvzH95K822lmX3BpaLRIbfbNtcycZE74auqJc42n1NTk4KsOvjHfZv+D/VqoXVeYq4W
         TQBxFdx/u5YvHO7jOlq5l/QVpcAlyoE0siFfhfvZXJOe4Ed2sngOxq9eqbfZMCZ+DxV4
         lJTGSzWmMEOdso/ldWWrlIDXF2j9BIm6Xll6B56uaUaaIdh5VHrkCaKCFYzmoG2i5HLW
         fW5g==
X-Forwarded-Encrypted: i=1; AL+hErFvSlhL0wJivjhG/oLc8IDx1GY+bIw5JLBXyxSRsqbRw3do+RuKtlRt1qxgk/PdISdWEvI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ekK0AA7XB9T/Uy6k37qNbW2ov1NS8HpMTTfTaj76WV14ZIGFX
	uupVSr23Ld0HPtROKX0tZD2VmfHoiYQv2Z+FsnWaLHIvekQwfMyKqb+ULNGS08yJiQ0+It5wTI2
	PSgQIwQ==
X-Received: from pjgo16.prod.google.com ([2002:a17:90a:4210:b0:3b0:a2c4:246b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec3:b0:3a4:b0a1:c7ed
 with SMTP id 98e67ed59e1d1-3b182eebe02mr6104935a91.13.1794503365644; Thu, 12
 Nov 2026 09:09:25 -0800 (PST)
Date: Thu, 12 Nov 2026 09:09:24 -0800
In-Reply-To: <3d4804e9-3e5a-447e-8a54-8fa5d1c28f5b@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106013927.166209-14-zide.chen@intel.com> <au491iiV7koeP0t6@google.com>
 <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com> <f12bcb27-9c17-4b8c-b48c-c36a17e70ab6@linux.intel.com>
 <5f129d63-10c6-414b-86a9-a604e42038ce@intel.com> <51089074-1be0-47e3-8d53-732ca33f29a2@intel.com>
 <fceb4f61-621a-4d62-a648-a1cdd0de1671@linux.intel.com> <970e231b-c3ce-4159-ab27-ac371426500c@intel.com>
 <avSLss14zigMfUww@seanjc-mac.roam.internal> <3d4804e9-3e5a-447e-8a54-8fa5d1c28f5b@intel.com>
Message-ID: <avXyxMgGzRBGbBN3@google.com>
Subject: Re: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Yosry Ahmed <yosry@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 11, 2026, Zide Chen wrote:
> On 11/11/2026 9:37 AM, Sean Christopherson wrote:
> > On Tue, Nov 10, 2026, Zide Chen wrote:
> >>>>> KVM's principle of "not policing guest CPUID" means KVM allows userspace
> >>>>> to configure an arbitrary guest CPUID without rejecting the ioctl or
> >>>>> mutating the vCPUID entries.

...

> > Just because we *can* do something in KVM doesn't mean we *should* do that thing
> > in KVM.    
> 
> Got it.
> 
> >>>> - Features that actually need host hardware support need to be checked
> >>>> against both guest and host PMU capabilities.
> >>>>
> >>>> I'd propose something like this instead, leaving pmu->version unclamped:
> > 
> > Why?  What real world use case is there for KVM actively supporting a PMU version
> > "greater" than the underlying hardware?  E.g. emulating AnyThread deprecation is
> > (presumably) easy, emulating *all* of v5 on a v3 host, not so much...
> 
> Got it. I can think of a few discrepancies:
> 
> For example, the guest is supposed to handle Freeze_LBRs_On_PMI (legacy
> vs. streamlined) based on the guest PMU version. If KVM emulates the
> legacy behavior, but a v4+ guest expects the streamlined one, it may
> run into issues.

Well, yeah.  Because I'm saying KVM should *NOT* support running guests with a
"greater" vPMU version than is present in underlying hardware.  That's nothing
new; KVM rarely emulates features that don't exist in underlying hardare.

KVM doesn't generally enforce the virtual CPU model presented to the guest though,
because (a) userspace can do all of the same checks KVM can, e.g. by validating
its configuration against KVM_GET_SUPPORTED_CPUID, (b) adding that validation
in KVM would require a ton of code and create all kinds of ABI issues, and (c)
there are legitimate use cases for exposing a virtual CPU model that appears to
be insane/nonsensical.
