Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B430478E57
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069857; cv=none; b=TX9mjlIwEHK0ajbePSVPY/naMYeLZF89BGK+TGSJwK3oVnMt2DGcw3hz/K4/ObxBCd8wpoZGYmr3fEMyD6aeqhDGGqHlFrTvBSc3w1yPIVvsyfVQHMSyvM7TTgqxwMI8lFEeAuQU0ILBKAIbEmiUL6Yv9YyaGb6UbZDF209aYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069857; c=relaxed/simple;
	bh=OaMjAIRYRRWnaB4Urk/B3hfxETMkq3K2buSJHt/3KVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7xYsD9+k+FSrCxgSclH+NlFb2K4Bp/KjdB3lL7MuJGtUu6JD/U6OaYP5+qglL0fzcl9wCyDLq4+tf7nhLVlpbsEZF7RKGX59qIb0lW53xZQYDXF7c2GTAHlqgw3SxW7mrB06jk57HnFtcGqVquA2h6uHLuHH+mtLu3hZQIAlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciIlflIr; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciIlflIr"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84857446424so158294b3a.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787069856; x=1787674656; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAGErQQAr795zwyVPFpnw68vb4Hwl1w2+fI9d1XhTw8=;
        b=ciIlflIrNjs/TY/8vUb70kcrdGnIa8AiWoee7wIqFqoihyiBoJL3pHTRbEu44Ql/zO
         np3rVgfSObXFDPq9qJRMh/+fQBA3PSql/ZVfp6rNyZ2BEIuTxrU04w2BlCduVeEDDu53
         xHscwusgJjKJadEfuHbjKYnQsa04cUq/tYJyy/rlRL/tIm7pxW8uvSmYjklNof6rxzlo
         26snud5zKiUcl/BJNGFctrzcRF/uqumE7N/lgrNzO1Qbl0yHJG4zqTKDh5cPuCMchAbw
         P1g0/ou3c7A4eOXCGaKZPaTJ18lfuZzElYZUZx1bZU50WEX2wdSvT87UUqaj0R+aFojT
         OdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069856; x=1787674656;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAGErQQAr795zwyVPFpnw68vb4Hwl1w2+fI9d1XhTw8=;
        b=aKHbE+Tj5Hkf+mds7s/8yLO8eY5jMrnQZVEJ4xCOnB6zdIY10kzn6SB7r7mhBMxLfP
         Qdo4yZxkgKt+KnsdfekMux2JSDWIiFH3L9RAEnqJGiVepIjIFx1vWP0PbHxX/rQycQ/T
         re7yzD3ZeCIhMWCLQy4L7ineYlQ1Okf2CPwTTxeroUGNcP2WzA4aXmJNN3+uCDYL1SQX
         7gEnZZMbqW3Kx8x9fOHRf/RV0GVCWrAnA+WOOxiI6IK+bwBl+TqgjPGTsBLKtlyLVv6b
         YV/jhsenK4p6DaLVGOVNyXx1JHWt69O7dOAiLuPn0+Hc9onIDsQKECCChLVs5z69lDMX
         fPLg==
X-Forwarded-Encrypted: i=1; AHgh+RoITOVskokWIvrIGLLLWsrq2qMlG6luS4RsGsTkLClUFfEIqfkRPBxC+chmnk/LSDIHoDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJI7jNMmvfVh7c/RtR1hFgiPttZ9Uzvh7jxldvtSlqqRgaZ+hA
	LHdYk/WDKJMz3Vu5air1A/Bu6iQhN1a0emFrrfE9HGKzpoKt5QbXW7hcRWA1dg/+gD0qtZutkB6
	Z4X5D7g==
X-Received: from pfbkx25.prod.google.com ([2002:a05:6a00:6f19:b0:847:8449:eef1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e85:b0:842:7296:dba
 with SMTP id d2e1a72fcca58-84fddfa8508mr34166484b3a.7.1787069855548; Tue, 18
 Aug 2026 09:17:35 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:17:34 -0700
In-Reply-To: <94990aef-8b17-4bc6-a5d5-e7da5107d001@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com> <868c0d3c792d789347c767031612977c31cc227f.camel@intel.com>
 <1cf47118-2a19-44d5-ab74-b4c7ffa8890c@intel.com> <an3YFiDbjRs3PUwn@google.com>
 <77567574-d26c-4d2c-b5ce-5da28a7178d6@intel.com> <an84cenJjf7EqhVM@google.com>
 <1dcbf1b2-dc89-4624-b98e-d34f40558cfb@intel.com> <aoNNiAbZUbkWoZ6t@google.com>
 <94990aef-8b17-4bc6-a5d5-e7da5107d001@intel.com>
Message-ID: <aoSFnjABS8HCtWWS@google.com>
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 18, 2026, Xiaoyao Li wrote:
> On 8/18/2026 2:06 AM, Sean Christopherson wrote:
> > On Sat, Aug 15, 2026, Xiaoyao Li wrote:
> > > On 8/14/2026 11:46 PM, Sean Christopherson wrote:
> > > > On Fri, Aug 14, 2026, Xiaoyao Li wrote:
> > > > > On 8/13/2026 10:43 PM, Sean Christopherson wrote:
> > > > > > On Thu, Aug 13, 2026, Xiaoyao Li wrote:
> > > > > > > On 8/13/2026 6:58 AM, Edgecombe, Rick P wrote:
> > > > 
> > > > ...
> > > > 
> > > > > > The more I look at this, the more I'm against shoving garbage into vt->exit_reasons.
> > > > > > With tdx_is_exit_reason_valid(), this is trivially easy to handle, *and* explicitly
> > > > > > captures the logic instead of subtly rerouting KVM away from meaningful handling.
> > > > > 
> > > > > tdx_is_exit_reason_valid() doesn't work unless we update the vp_enter_ret to
> > > > > one that isn't one of the status code with valid Exit Reason. See below.
> > > > 
> > > > Correct.
> > > > 
> > > > > About the idea, isn't the purpose of setting the Exit Reason to a synthesized
> > > > > one is to avoid the undefined Exit Reason causing false-positives when it
> > > > > happens to match one of the existing ones?
> > > > 
> > > > Yes.  The nuance is that I'm against clobbering the *full* exit reason.  I am
> > > > not against setting exit_reason.basic to something like EXIT_REASON_INVALID_STATE.
> > > 
> > > I'm not sure why you are not OK with setting the bit[31:16] to 0 ...
> > 
> > I'm all for that.  I'm against setting them to 1, which is what using -1u does.
> > 
> > Ah, I'm guessing my use of "clobbering" is confusing.  I was mentally viewing
> > setting them to '1' as clobbering, versus setting them to '0' as "doing the right
> > thing.
> > 
> > E.g. the VM-Exit (that didn't happen) wasn't due to a failed guest consistency
> > check; it certainly wasn't an SMI from VMX Root, nor was an MTF pending at the
> > time of the SMI that didn't happen; the guest wasn't in enclave mode; there was
> > no concident bus lock; all other bits are reserved to zero.
> > 
> > Sorry, I should have clarified that writing the full exit reason is ok, but setting
> > arbitrary bits in a way that isn't consistent with reality is not.
> 
> I will add a separate patch in the next version to set
> 
>   vt->exit_reasons.full = TDX_INVALID_EXIT_REASON;
> 
> where TDX_INVALID_EXIT_REASON is U16_MAX, i.e. 0x0000FFFF.

I would rather do:

	vt->exit_reason.full = 0;
	vt->exit_reason.basic = ???;

So that it's abundantly clear that bits 31:16 hold *valid* state, i.e. to make it
more obvious that the value shoved into the basic exit reason is arbitrary, whereas
clearing bits 31:16 is not.
