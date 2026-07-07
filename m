Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D958346FD2
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783459256; cv=none; b=U2ok9aFRlzvPiuu/zmAAsriVbuMI9vY6GPq/tVbwyyStjh9u4LLCX79cVFoWyCJIFPngk2HPAEEDUwLgTYFPRsG/oxgNU40ylRfR7q7FkN5Yj0oMf6goiONBtDqAVP5Llcu083I/7rE828QqHno4ueLf1FTST5JiURXfpOI+sN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783459256; c=relaxed/simple;
	bh=FndKch3GTGLdrOHB6rKSa6u3R6HrF3DsPw6ggmU46L4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cLPq/FHWYuy2AQfRgaZZiNmYRRPRoID3OWrpdJllGUxozh4qep38+SAjrB03kbmF0u2bY+8fo44Eal4ivD8ngEIzqvR7/b30nsti9TFQytK0BTBHNGtCy14wQrJt+69dq24RRtaSAu5dGAvZ7xYwO6RVKEBb+yV02hTKitb8ro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHWMxe8H; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHWMxe8H"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca0481106cso452495ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783459255; x=1784064055; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vX8Nu+AP3Cdd2yHmgHkvoGDwsjNpoGwkK+Tsrh06/Hc=;
        b=mHWMxe8HsKLCAyOY2DcLazBfuF4j3yF0XKHLf+7O55eaaAK0MU4gF/iuskYKW76iOl
         gWjyjOCmHN+DOxIr7KP4pND5lfWrc3nt7fyE6mhOPOWcSK7dAHEQ+snb7ToELssvQicd
         easaJKE4B06wSVmYHzAlstWVUcYH7FIRgmKVGMphWkjEleIalF3hHxO1mUIADmrQqQzp
         pSgKQTpp/+ozo4QkogXtgVIGEotvKomFeHjFVDCzzth4svpLeSoIWDy3r3aaFzmIpNHB
         Ut9oZpPZle+eOsDGTDTrQkejNPiR+R/ny0he3vschArdAJ5tJXyTzwb5LmBmjBOFK5R1
         yfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783459255; x=1784064055;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vX8Nu+AP3Cdd2yHmgHkvoGDwsjNpoGwkK+Tsrh06/Hc=;
        b=LSPIGcRuPFgAbHBCQlf7m+7GzyZ7cpyDZLJBH6QVbM0Af/rLpL4wfGVNOU+FDA5WHJ
         uS8Nfu44U6BkYzkCNGjxk6rpZBkx7vZCDHwVwVLx1WnIkUouqNyrdvQ+kwH0ttruzOe3
         go+M4pnng5LNOCU/eTcjuxwybyOvlbS132QUu5zuaOpuyXmMvERCYPMdOljkqATgdSfk
         zn0qxIp/ZSqMZ7KTEESXvsfor9wpnVdytLPKUCZ7McY9YelkibxuEAiJpVbrHZm29V9l
         +/d4SW0dN9pyphpINcx0C9vGMwrqtjrF2uxQTZphCzgmpyrEZdFDteWptAWEgVSqSTKi
         ++jQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkzsCNmVHFCJXQBP+405fMWJWFjDk80tqzzGyfTM3/VlgnZbLwxn+/7Q+11QxYqWePzqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5rX0x0XnX3z8B4dWL+GnqJizA5Qvv32+QVoXlj/2UJ7NzJRO
	cTJRmZsfICCL5t+Qkiv4hhBi0sGKlt9NxvmN2NBf88DCXOhP0HqYv/4zqaiDQU8OL8ScTIcyr1X
	H/u6i6w==
X-Received: from plbkb6.prod.google.com ([2002:a17:903:3386:b0:2ca:cbc9:76fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce01:b0:2ca:52ce:6f91
 with SMTP id d9443c01a7336-2ccbf056a99mr71748395ad.27.1783459254740; Tue, 07
 Jul 2026 14:20:54 -0700 (PDT)
Date: Tue, 7 Jul 2026 14:20:54 -0700
In-Reply-To: <ebce06ba-9d7f-43ef-9b3f-aa858348fd06@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com> <ebce06ba-9d7f-43ef-9b3f-aa858348fd06@amd.com>
Message-ID: <ak1tthJaCZyQOvlG@google.com>
Subject: Re: [PATCH v3 00/12] KVM: SEV: Fix RMP #PF due to freeing in-use VMSA
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Michael Roth <michael.roth@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 07, 2026, Tom Lendacky wrote:
> On 6/30/26 17:25, Sean Christopherson wrote:
> > Rework KVM's handling of guest-provided (and always guest_memfd-backed) VMSAs
> > to forcefully reclaim VMSA pages when the pages are being freed from their
> > backing gmem instance, e.g. in response to PUNCH_HOLE.  In the worst case
> > scenario, marking the page SHARED in the RMP will fail due to the page being
> > IN_USE, ultimately leading to RMP #PF violations due to guest_memfd freeing
> > the memory back to the kernel while it's still assigned to a VM.
> > 
> > Note, the implementation nearly identical to that used by KVM for VMX's APIC
> > access page (which isn't guest controlled, but is migratable and whose PA is
> > shoved directly into a vCPU control structure).
> 
> Looks good. If you wanted, you could replace some of those quick
> mutex_lock()/mutex_unlock() and write_lock()/write_unlock() calls with
> scoped guards, e.g. in patch #8:
> 
> 	scoped_guard(write_lock, &kvm->mmu_lock)
> 		__kvm_mmu_zap_all_fast_front_half(kvm);

How do (KVM x86) people feel in general about scoped_guard()?  I love the "regular"
guard(), but for the most part I dislike scoped_guard(), as I find it (slightly)
harder to read than "raw" lock/unlock() calls.  I think because I mentally think
of anything like this:

	blah() {
		foo();
	}

as being a control-flow statement of some kind, i.e. code that is conditionally
executed.  So outside of flows where the benefits of the cleanup behavior are a
clear win, I prefer doing manual lock/unlock.
