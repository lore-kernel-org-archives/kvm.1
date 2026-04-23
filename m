Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59C1E5724
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776982373; cv=none; b=IH+RLAAAKVEdNqoFzDpuGmbZwXLzT73PjdOsXArKAcCgNPc+Kt0ShUEneJPoudhAqRPA3dMMfCQt0L2SbMigmDihPOo/TUXn9pXL4YKMvVda6eIDSBtHrYh9+rb8xqNt/vWwAkWIGmsGZFDGlR+IRpUH+ZMTe7c7WNa9Ukh7a7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776982373; c=relaxed/simple;
	bh=u3nIfu0ARrXotLiU7S6XYqA5tFTvlMiZuppDlpWxz5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NnzEMWFHp77JPFDVDzCuW011PJ82sJAYU2syy4S/VcAY6txOBt+9D7E5ZjQG0tCYiXQKEJbYmJCQMzaSiUm4ywbrP+2IL5XYG78lCp8qg5dj++BgnRfMSGdfUB4uJhe/pjuNVshEsNEF6rH9B3ceVx9QPKmCGyXFNlRoAPRNZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZaUyOoW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZaUyOoW"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c799ee56bd6so1053892a12.2
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 15:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776982372; x=1777587172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHGWnjVaTdWBNd+8TRgPXuKPR0G6Xu1chE1RN30Ecns=;
        b=TZaUyOoWPM3IEFLTAsQkKl0luGutHwDfT2R/pM00d8zIsuYtyLoNw8ZWCgayK7p3q9
         U7WSUyrx5KaIhJTjwNOp2+O2akTu91KOLveDybhSoq2aerkbpbYT5SXdGV2utQoK2CX5
         w1p7JXb14Np99T51PsqTwGnWPxhqWYLA+D5eLcZvhDtkUs+InB6a7sClQ0F4x2kduhoy
         wAyWdv7hj23/DwB2GFNmCNEXrG9wbuW7sMs7lSO7BIJHi1i5SAN3pzDzGrAunotcM/iI
         jVyMhql9QudDyUaNGaB4YfPvJ3ll+rPWuMhWdx1cm7+3x8tU3kGQ4nxkyLbhSzjKj9HZ
         BjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776982372; x=1777587172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHGWnjVaTdWBNd+8TRgPXuKPR0G6Xu1chE1RN30Ecns=;
        b=ZQ1f/1++L4PFogWiX1C1mDSWXQ+bM3siZlMhpEa25bOV+BK8B9q1+BXi7PP5yeDfKe
         fCkh4MuiJoaQp0+gCaBBdK/PWABEC1Sn/C26XFK3avZs/66zQW3PxNP7NZfzTlhyqKtJ
         5gWm82AGv57q5vmrRpNUZcY/DsrftAMoaJ9tIfZv6ZsNSASR46TmeGmGYP2EwinQgsJl
         Le0JuSzTsAJZ6jjH0J7Au9KoGnHNe0neG/5U4gRHkiR+m4Rt5s7V2a9MK06Pgu/+K9wh
         /ZTqxNWBv8/xPADdIDYrCYxc5R3zFtkAVn9NEvuUzub+mMJiLyp1Y50pA5+bvxi5l+rn
         PkjQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eobvKF7yfvehJBS4FoQxMPurH4P4hAWzgNE/HrdfLpOk68oWvs7HcjYuPlzOIukNzN34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkMPnQ586yEszGGwAfY87/2xKhAZNLiUftSjhmDJ6NIhEGG1OA
	Rx8AzraG3ceNj6MaD5IiAh8xosC1cD9o14ZvVpzNXEV7rVVcMsQWlWwgQtDd5+zXoPNkLx1sVrH
	Wi/PaPQ==
X-Received: from pfbk21.prod.google.com ([2002:a05:6a00:b015:b0:82f:790c:3922])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:27a8:b0:82f:18fa:1668
 with SMTP id d2e1a72fcca58-82f8c91e3cbmr28259374b3a.44.1776982371472; Thu, 23
 Apr 2026 15:12:51 -0700 (PDT)
Date: Thu, 23 Apr 2026 15:12:50 -0700
In-Reply-To: <7c1afcda-5a7d-40b6-a992-5f38caa80462@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com> <20260409235622.2052730-8-seanjc@google.com>
 <7c1afcda-5a7d-40b6-a992-5f38caa80462@linux.intel.com>
Message-ID: <aeqZYv2Kvx_yYI9Q@google.com>
Subject: Re: [PATCH 07/11] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 14, 2026, Binbin Wu wrote:
> On 4/10/2026 7:56 AM, Sean Christopherson wrote:
> > @@ -2542,18 +2542,18 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
> >  
> >  #ifdef CONFIG_X86_64
> >  	if (is_64_bit_hypercall(vcpu)) {
> > -		hc.param = kvm_rcx_read(vcpu);
> > -		hc.ingpa = kvm_rdx_read(vcpu);
> > -		hc.outgpa = kvm_r8_read(vcpu);
> > +		hc.param = kvm_rcx_read_raw(vcpu);
> > +		hc.ingpa = kvm_rdx_read_raw(vcpu);
> > +		hc.outgpa = kvm_r8_read_raw(vcpu);
> >  	} else
> >  #endif
> >  	{
> > -		hc.param = ((u64)kvm_rdx_read(vcpu) << 32) |
> > -			    (kvm_rax_read(vcpu) & 0xffffffff);
> > -		hc.ingpa = ((u64)kvm_rbx_read(vcpu) << 32) |
> > -			    (kvm_rcx_read(vcpu) & 0xffffffff);
> > -		hc.outgpa = ((u64)kvm_rdi_read(vcpu) << 32) |
> > -			     (kvm_rsi_read(vcpu) & 0xffffffff);
> > +		hc.param = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
> > +			    (kvm_rdx_read_raw(vcpu) & 0xffffffff);
> > +		hc.ingpa = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
> > +			    (kvm_rdx_read_raw(vcpu) & 0xffffffff);
> > +		hc.outgpa = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
> > +			     (kvm_rdx_read_raw(vcpu) & 0xffffffff);
> 
> All registers become RDX, which seems not right.

Heh, that's an understatement.

> Also, should "e" versions used here?  

Yep.

Thanks for the reviews!
