Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112921;
	b=E30L15EOPDQy1zJ5uxX1WfFJUyeRYNfw1n7Bs+erQ0tmOC8tuqQwwgQmHXgkeen3aPYE
	 yM1m1hecu1pqWMapB0YLuwMF4nFztPXVwfT6GojiiaY22q8ObVjWhoVDHfiLBiE4rsH0a
	 K9OJ6foxyplUhLw7KoY9kk1aBBXNiM1s0Sgb4Co0fcq6dDjJxUlZ03eiWG94K0rmDjbCf
	 gV35+moDjqWP1GiUlE5QCC+r2TUOloEObSbHmQ1d/64nhcKQeYYV/9jB4EuAKtoc9Wfa5
	 jU+rFt1S5ZOixrzw3EWvR8WKvtkSuzaimfjdUfV/Y0Hvj92n3qtSS/d7vQsjsaKyvJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=1DehjZ5BL8d0YnBEeJuu65Ld1wB1OE7I+m9Hy0VoO3I=;
	b=f0MtzeuRyS3HauDhIqu1hXnDxLlrHdasjcr+YpLoc+npB0ga4XHwm8mZjLzk7co8xE7B
	 /OUVhfVZTbTpMgwU1iDEUZ5ZhdVrIEaj95gPtHmoBQcUwyeY3pMl6vRDnVPty1s8smTHD
	 YPDLTVrsG6S3+yGipLIqgkJXZ3osGv7/5Bzot5j7fz+p5Zd9dqbNcUhLC61bncZuDHIyP
	 i5is5yQaXBsc6QhjiVNCDXW2NM6gtfsa5e2MmQL9r9QR2O5Ue2Mn0mdKHOad7S+3I3thZ
	 j1UWKWVNbs5XMX93o9FdfMhsrzIHwpFNVMbsd77Lwqu0EdKcLqzuHoIrsPxKRG1qHqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gO8jXOfi;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF62606A31B
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF62606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gO8jXOfi
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab67ff8ec3so3085187a91.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793112920; x=1793717720; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1DehjZ5BL8d0YnBEeJuu65Ld1wB1OE7I+m9Hy0VoO3I=;
        b=gO8jXOfiP+TwEFj4a7G3XZMsl9Jf9enBFTAin8mpQQGJxAfRLf/BpCTqgSDYDLEP2a
         GwMZnfrfppp7Vj2BHI9qnhNHgFRtvJ+ikqI5mbhD+8bzGy6l7KF7a3rpOATQRj5/hKIS
         59p06nk156+E+gwg8H/JmahwIxSE7ybCXTjVCsY8qNRhYAmlbRd88KBbLU0zTxhjQaZe
         oHdSGHT6odYbRzVzp6sTylTqckfRhNl3FPoTA8pe847tCe9EWWzI0QAqNj3Olyl4K3OI
         jBPAhRcq3jmhfnk/J+Zs1sG/OtgxAat3ZVkxjsnWCRQFjl87lazytSjyWvScXS45L1F1
         9voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112920; x=1793717720;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DehjZ5BL8d0YnBEeJuu65Ld1wB1OE7I+m9Hy0VoO3I=;
        b=K6aeZWh7NCno/hsZQZ8CVEOc3Y3cixGAGXnIelXUYpFVR61BDk0uTN2SN6kGRcOI67
         pRE3Ib1zLF8xF6q+QiXNIk9vs9sY3NA+/8jVn+FT/iDVPcRox7xiJyM9AfmdqU6/JrFp
         McS5k5jUxgzo+0iJcuGw1I+MzFxhJ5/MbMn1qenWwfVyO/OoV50vmE3AoFl/ljEw17N4
         0LY+LEn4x59K4AyAFu3R3jvgzoLoTz3IMAp5DTpCoYlgfNUeE8HV5t0FE1Bhomq/rVOA
         6tiCpmdAFBEKdGaK7PCEcaImRlpwIV+qIFInKCAL9PoQG+uaxaZxeG7CV0VFy2qsR6O8
         LmdQ==
X-Forwarded-Encrypted: i=1; AKwUvByUX0culdX87qu1Ic24dofsRsj+jL7F4IpQ/fqS4KsaikYr7qLLX4AqPN0lC3eBVy7TrHg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOZ449Ui1Vv5PpdGSbsqhGxSWpB5Zi1VlfxFZlFa8zOfHmDEE6
	RhS1DtVfzLv89YljmNpU1k0j2/L/78YCy5bj1H3sYo52SMGqGhpn1U0cJKtlsR0Oqi81NKDrwC6
	KGvUwFw==
X-Received: from pjtn20.prod.google.com ([2002:a17:90a:c694:b0:3ae:1810:840c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:590f:b0:39e:4c81:6c5f
 with SMTP id 98e67ed59e1d1-3adeaae86acmr7469745a91.26.1793112919756; Tue, 27
 Oct 2026 07:55:19 -0700 (PDT)
Date: Tue, 27 Oct 2026 07:55:18 -0700
In-Reply-To: <6c156bb3-a04f-4d4e-8611-b1e93359e8ad@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210134.612848-1-seanjc@google.com> <20261022210134.612848-3-seanjc@google.com>
 <741bfe7c-5d21-4c6b-98c0-95b01a2a21f3@intel.com> <auCvuyY7tTg7ISwR@google.com>
 <6c156bb3-a04f-4d4e-8611-b1e93359e8ad@intel.com>
Message-ID: <auC7VoynSWStxCg3@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate
 when filling CPUID entries
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>, 
	Changyuan Lyu <changyuanl@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 27, 2026, Xiaoyao Li wrote:
> On 10/27/2026 10:05 PM, Sean Christopherson wrote:
> > On Tue, Oct 27, 2026, Xiaoyao Li wrote:
> >> On 10/23/2026 5:01 AM, Sean Christopherson wrote:
> >>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> >>> index 271c2f94b8dd..37d088f6f7a8 100644
> >>> --- a/arch/x86/kvm/vmx/tdx.c
> >>> +++ b/arch/x86/kvm/vmx/tdx.c
> >>> @@ -2,6 +2,7 @@
> >>>  #include <linux/cleanup.h>
> >>>  #include <linux/cpu.h>
> >>>  #include <asm/cpufeature.h>
> >>> +#include <asm/cpuid/api.h>
> >>>  #include <asm/fpu/xcr.h>
> >>>  #include <linux/misc_cgroup.h>
> >>>  #include <linux/mmu_context.h>
> >>> @@ -163,12 +164,23 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
> >>>  
> >>>  	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
> >>>  	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
> >>> +	entry->flags = 0;
> >>>  	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
> >>>  	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
> >>>  	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
> >>>  	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
> >>>  
> >>> -	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
> >>> +	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
> >>> +		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
> >>
> >> I think the WARN_ON_ONCE() is very likely to be triggered in the future when
> >> people run old kernel with new TDX modules.
> > 
> > Then upstream patches to make that not happen.  Intel insists on treating the TDX
> > Module like hardware.  So, treat new TDX Modules like new hardware.  Upstream
> > support for the new "hardware" before it ships, cc'd to stable@vger.kernel.org
> > if necessary.
> > 
> > Because IMO, the WARN is doing exactly what it's intended to do: alerting the
> > admin that they are running a potentially dangerous setup.
> 
> For this specific case, does it mean every later patch to add a new leaf in
> cpuid_function_is_indexed() needs to be backported to stable?

If you want to ship a new TDX Module that enumerates features in those leaves and
works as-is on older kernels, yes.  Again, this isn't really any different than
enabling new hardware.  E.g. a kernel from 2024 generally doesn't work flawlessly
on a CPU being released in 2026.
