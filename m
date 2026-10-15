Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95D320CAD
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071123; cv=none; b=iwDvGqyIeSMhK8HC2pmqyKMqDmYZSkxYZDlSE8e09IGBF1cDfnA+LMmj0ca2PVbFGk96uvJgOrGtbrRPHBgDbMepV02rUOv0b30zLsFDccPpHRTVDl0Rp9bhia2lv92il/D2HF1fcTG6EDIjXe4Z4LoPgq7mw7WBY8E73N7FPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071123; c=relaxed/simple;
	bh=DM+/4dpobs60R7WsyZ1su1V+Wmh+fgDiyg9humHU08o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZNPdqpzAJiW/F1ssQH6pgHFE6AL6+kTHzdDgdWlewwUsH5FZpfYSpkOCiBK6yEqbF4WjzeAaUXc3AY9r6bs7uwEyE9A33jZ5nieDzzV8P5qE5i2WQflEcV2d2kIojvmN5CVMjeaZOvJPvu0RB5PJOY67XIgA4EjUokX9TE2jWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLNih6th; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLNih6th"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so2546668a12.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 06:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792071122; x=1792675922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKlAjlVXQ4jJGW7uqpZqIO3+PQyX2/sjL4lY5mEwx8s=;
        b=kLNih6th6UOXndaxNipIjJ5ebSJuJklYNYwjTob0MxaTRmqMrcVh95VM+iiBaya0dS
         rGkZStZ4ZAY19GneUWp1BfWR6t530EgBUu9WpH4pdshKQmPKm6z7qRo1FzSMOtwvGijs
         wMRr5VAnPK3U7PlwA4M98XZtXLOJvR5Dtfo6lH/7/7DsE7zVUiFymrqtuMAFHceDBtok
         qdT2jahJtS7PdMgmN7h5grWubJVVSy3hMBTpatOpSp8/sDEnrEwkYTrTYyyUqDOoHJD3
         R8IhR6bee9ZPQUhUNdothgyyTd+3cz/smzYE2UZb3zdxqwNxXkf5WDcAeinmLvNkRbvY
         KWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792071122; x=1792675922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKlAjlVXQ4jJGW7uqpZqIO3+PQyX2/sjL4lY5mEwx8s=;
        b=fWTSmkkCj9BYXNE9GTjYx+EQAH6J0cgeE6kpKRQGyUyx30SUhd/zl7ekU+yCDIDgKM
         LTtDlr6K75dSat1NY9xDYG1tU+++eBKDjUcto3VHmHy93bN4K7bsx18SfgekFRUiVGS4
         OSy5h3Y+5O1ckDnjOCIaZWni1ovJZiBwS6DjRItMLWszpEzWCMI3S7D9DbLYjqroQIzO
         l8AXyUOlHtE2ML/UhSo03T67kLUAtvnO0wUlrcl4ONonvoY620xZx58SGfxu5a5Y34n/
         KmCCoZQ2k8A89+TN8Rqg3pDBZ/8nyk+5+c4CKHjlxyKmetj43Bi7S7phWh6zyC7yMJbM
         smEw==
X-Forwarded-Encrypted: i=1; AKwUvBwDQItxSUDM+X/9BJ73cxzsdhS5QOi1ZqFdMDmYYd2q3h6VNzluT7o5V1KTTR78HWtJCSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM38GdS/CbOZh23XkWpBrtNzZgTtgA2hIVxqEqtig+CIIXZ02W
	NrzzIQODEuGJ7SZimyhQypFZvPPS+1mHtRQx/tlHVR0TnZ5519RCeJ8e07N/QUY4Ryi4K6YhsKz
	kLfboGg==
X-Received: from pgdo18-n1.prod.google.com ([2002:a05:6a02:6212:10b0:cc4:aa77:305b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:46c5:b0:3e1:1689:1eb8
 with SMTP id adf61e73a8af0-3e16baddb4amr18528802637.2.1792071121607; Thu, 15
 Oct 2026 06:32:01 -0700 (PDT)
Date: Thu, 15 Oct 2026 06:31:53 -0700
In-Reply-To: <asXlwARv1cE1RREu@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1783490022.git.naveen@kernel.org> <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
 <5f6bcceb-1c48-43e5-bafc-8f86676c4092@amd.com> <alX59ewiXXSx7J3R@blrnaveerao1>
 <asSSU2huZDlusYdG@google.com> <asXlwARv1cE1RREu@blrnaveerao1>
Message-ID: <atDVyVCeUFafWPHm@google.com>
Subject: Re: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of
 native_apic_msr_eoi() for Secure AVIC
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tianyu Lan <tiala@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 08, 2026, Naveen N Rao wrote:
> On Mon, Oct 05, 2026 at 11:16:51PM -0700, Sean Christopherson wrote:
> > On Tue, Jul 14, 2026, Naveen N Rao wrote:
> > > On Mon, Jul 13, 2026 at 12:43:45PM -0500, Tom Lendacky wrote:
> > > > On 7/8/26 01:32, Naveen N Rao (AMD) wrote:
> > > > > Drop savic_eoi() in favor of using the native helper that writes to the
> > > > > APIC_EOI MSR. savic_eoi() was added mainly to be able to handle
> > > > > level-triggered interrupts. However, it relies on APIC_TMR indicating a
> > > > > vector to be level-triggered, but APIC_TMR can never have a bit set
> > > > > since it is only updated when the LAPIC accepts a level-triggered
> > > > > interrupt. In the case of a Secure AVIC SEV-SNP guest, all
> > > > > level-triggered interrupt sources are in the VMM (emulated IOAPIC
> > > > > primarily) and KVM accepts them on behalf of the guest resulting in the
> > > > > APIC_TMR in KVM APIC backing page having a bit set. This is never seen
> > > > > by the guest, which has its own private APIC backing page. As such, the
> > > > > savic_eoi() handler is dead code. Remove it.
> > > > > 
> > > > > Fixes: 43b6687ac877 ("x86/apic: Handle EOI writes for Secure AVIC guests")
> > > > > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> > > > 
> > > > Another guest change which should be separate from this series.
> > > 
> > > Yes, I have called this out in the cover letter. I see now that I should 
> > > have used a better subject for the cover letter though.
> > > 
> > > > 
> > > > Is this causing issues with this hypervisor support or is just code that
> > > > is never invoked? Do other hypervisors behave the same way and will
> > > > removing this break them?
> > > 
> > > This is code that is never invoked and is independent of the hypervisor.  
> > > No impact to hypervisor code.
> > 
> > Doesn't that mean level-triggered interrupts are fundamentally incompatible with
> > Secure AVIC?
> 
> I think so, at least from the hypervisor front. Secure AVIC uses a 
> guest-private, encrypted APIC backing page. KVM's APIC_TMR is not 
> visible to the guest and the only injection mechanism is via 
> VMCB->Requested_IRR field, which can only carry vectors. This means 
> APIC_TMR in the guest backing page will never be set. So, all guest 
> writes to APIC_EOI are accelerated and do not cause an exit.
> 
> The guest could track level-triggered interrupts and notify the 
> hypervisor though. But, it isn't clear to me that is necessarily better.  
> Linux already seems to have a fallback which works for I/O APIC (see 
> below).
> 
> I believe TDX has similar restrictions?

No.  VMX lets the hypervisor select exactly which vectors will trigger a VM-Exit
on EOI, via a dedicated bitmap.  Only SVM's approach of keying off the TMR is
problematic.  FWIW, SVM's approach is flawed in general because it makes assumptions
about hypervisor behavior that don't hold true, e.g. see the games that have to
be played to deal with RTC tick stuffing when it's wired up as an edge-triggered
interrupt.
