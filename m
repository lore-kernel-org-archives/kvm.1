Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3723C503
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580437; cv=none; b=YSras1YsYIR//2F6VD4DCywCTPF18K/udJQfJwqEF2HvkJgpVMksElxF1zvRR2SI7j6CDB3fEOtFb0eWrXPiuGiCP3gFwF8SMwMutQwdXBbaqkfGwaQaPYRv3dL3JWe6h38dYUInC5uu7/9UIfMCI5aJgoT0EgRgsSAT3pskHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580437; c=relaxed/simple;
	bh=Sxrwx/3H6vvFb4P3DmxA3ygoHV+JvbXJNwmyBv4uFDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IoEPoJkPHmsqqMR5plpqZC+dOsPTLhZK+P3dBw9A4J2hMsJwtXiBldawIDWh+Oy4rjhMIwo5NQV9uNrtkM3ZKe5/jOlZ1w8+XtRoZYF9GXJLGEDfsmC83edf5S4TjEpilkAB+VCMjNFrbPgBbb3SiqlGLxWpyQvCpKQpFuZxaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpMfV5XA; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpMfV5XA"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so303660b3a.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 17:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786580436; x=1787185236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eTTJxbYDLzilzFrnq/ue/6XV3N0/n+FGwD1ynmItG2U=;
        b=VpMfV5XAm4ip0qJ8Hgl8a/LLt2uzS8PtkFGb9TMUXFSPeh10C4Aoxed5Vn3HJSoCfa
         Vbjmwso7z35CuwCiBVhWbwpwDVnAn7Ln7DQSkgWw0s5FJ7iRA6riv75NLqmITA1/lRB7
         x6gdpMG+0Ku5Yt1c55xqb31OruG1RieALVSlTnmDWFtRgKzLxx36rIJ/ZUjZ7aQpVGWV
         nB5n1yJI8MFBQVjsKOHmtHAzo+qphmXhtqSyvGGRv+22Y48iyoVOZTN3GexS/rmbW8Ge
         9Up5njxxUG2v7sINs4nz3L1h1Kg3uWBtwfyrwpZOpcIdVZomFEZ8zU6NkwbWdmYR/pXf
         yEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580436; x=1787185236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTTJxbYDLzilzFrnq/ue/6XV3N0/n+FGwD1ynmItG2U=;
        b=nXITk2Aihk9d2OfyqCmxnx5kRbnVtMa/R02Gkw5rE3Nv6i01CH4GfcI65JHbqyHDdF
         Otv/eQ7jUANW13HBevJwzKrXbNNaBdd3r3uF6uJwRg1N8QFCzhJ1Lvj3wtVi8uQi9J50
         mnHbJeVBJCPYX+/SBYgteEF7MO37/yjElhiIqlyWH9bc1aa9m/kS6RDCmYo2burzhBsP
         Xby6YuoZdmwLS+PQgp2LFtMM+Qt0sN/dRXid16YOrRcPjXNTQtcC5CdVNGJ09eOZ3SJk
         IXQIsNo+K3GH4nfQD/4nSecNajBvQDid8JSL8gwNBXuF3oB4xDJCPwO0046NmhsUb3wv
         gVzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpn1zGHoizNZss3rynSq181b79dD3WGegsT17lQVG5R1sbRqAYPOD8pXX1UJkfUSk2EcnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9iCPRNhgImjmun6YrS5ZjB5o5I3vdfeRUWUiGnP/t3t5CVHZ1
	f7BscsnIUeVamwK2CW349J0M4Tq1WUZMvGJcBL1s9f8d2BW2fy18I1M1mGdk45HO+qsMII92mlj
	0xsu0IA==
X-Received: from pfbhu19.prod.google.com ([2002:a05:6a00:6993:b0:84b:62d1:9fe3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a257:b0:848:3e74:85eb
 with SMTP id d2e1a72fcca58-84fc74936d1mr1770176b3a.1.1786580435517; Wed, 12
 Aug 2026 17:20:35 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:20:34 -0700
In-Reply-To: <07df932f-ca83-463d-b830-aa10a8fa11f2@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com> <20260810113924.4ACBE1F000E9@smtp.kernel.org>
 <13ea6279-a342-493b-a0f8-15ac5b4c59ad@intel.com> <anplcWfYReCMeu1A@google.com>
 <07df932f-ca83-463d-b830-aa10a8fa11f2@intel.com>
Message-ID: <an0N0vHwsYEqjpRe@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 11, 2026, Xiaoyao Li wrote:
> On 8/11/2026 7:57 AM, Sean Christopherson wrote:
> > On Mon, Aug 10, 2026, Xiaoyao Li wrote:
> > > On 8/10/2026 7:39 PM, sashiko-bot@kernel.org wrote:
> > > > > @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
> > > > >    	struct vcpu_tdx *tdx = to_tdx(vcpu);
> > > > >    	*reason = tdx->vt.exit_reason.full;
> > > > > -	if (*reason != -1u) {
> > > > > +	if (tdx->vt.exit_reason.basic != -1) {
> > > > [Severity: Medium]
> > > > Will this check always evaluate to true due to C integer promotion rules?
> > > > 
> > > > The basic field in union vmx_exit_reason is a 16-bit unsigned bitfield. When
> > > > comparing it to -1, the unsigned 16-bit value is promoted to a signed 32-bit
> > > > integer. If the value was set to -1 (65535), the comparison evaluates as
> > > > 65535 != -1, which is always true.
> > > > 
> > > 
> > > Well, how about something below on top of this patch?
> > 
> > No, we need to not rely on magic exit_reason.basic values.  Can't this be?
> > 
> > 	if ((tdx->vp_enter_ret & TDX_SW_ERROR) != TDX_SW_ERROR) {
> 
> I think the reason of checking if (*reason != -1u) in the original commit
> 095b71a03f49 ("KVM: TDX: Add a place holder to handle TDX VM exit") was
> that, -1u means there is no valid Exit Reason in the lower 32 bits in
> vp_enter_ret.
> 
> Change it to check TDX_SW_ERROR, doesn't look correct to me. Set the
> EPT_MISCONFIG magic handling aside, TDX_SW_ERROR only means the SEAMCALL
> instruction faults, e.g., hitting #UD, #GP, or VMFAILINVALID. Just a small
> subset of the cases where there is no valid Exit Reason.

Surely we can enumerate those cases?  I.e. why can't that be something like:

	if (tdx_is_exit_reason_valid(vcpu))

where tdx_is_exit_reason_valid() decodes vp_enter_ret.  Clobbering the entire
exit reason and then _relying_ on that clobbered state is gross and brittle.
