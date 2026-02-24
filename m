Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD311D5147
	for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771895844; cv=none; b=JFCFRMXTgqki+Z/uQR5JSQU33osJKpBI6x8b4tswSf7zJiNrZpxipBZbHZG2n+WSSrElYINe/II0FJd55lChhl2nAUToGl80ND4oU0lyog0ZwWhW64taazj5Qk2A0GTLE+VxzOkIJbmpOpSVTfMyu69rMz/KkdjUvtoxjlBbzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771895844; c=relaxed/simple;
	bh=p8H5A0cWs42UL3akO8wLtDpZcdWp3ZP170VyCPvtqj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=haAKGeB2K0Gb3mq5yUGdr3YivDaEUAoz6PIg3DhIT+2rPig4PAfHFPZ/SlqiRmSt9q9JSsj5DxC7ReNowz0hFUXkzvpPD7OrYw+qXqkEKxr1Lzj4StvGQqwz7Ou/EWvul7gzJouoBt4uTewE9pY9gMQF0vPPmjpTwehQBeZIsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U7cHlaf9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7cHlaf9"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aae3810558so54481185ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Feb 2026 17:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771895843; x=1772500643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kChrrW250LzJPu0oBX9hRHHO4cuW/vqalTK9qkJ2fwQ=;
        b=U7cHlaf9AKum8TbciDM4iX4H/eSQc8T1bo+T6KiJxQd+pFuAExsH0sEB99yuREWdV1
         E3cLrCRC24vbgVoJ8IZDteHT82U9Q8sJmlfx03pgQQnvMl3Z85lhAuFZ70627GzNiF4O
         EP/4cddDvJOLrHa0V3ZNdeOHVAQlRZ38pRSo2yJNjyjG3e/4t+mthBm3TkxBJsfEu71B
         Z3sYIDmiD4JlO26YXBbmcQkbPud5tWNLcupisysl3CD5aCOVetvZIaF+Oe1M5zwG617z
         ilrkcqpaQ+uHucqBpty1XEQp0WXpZXJGtyANhQpQhyzcAWBSzuKgZHpsafs71/NOhWag
         PQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771895843; x=1772500643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kChrrW250LzJPu0oBX9hRHHO4cuW/vqalTK9qkJ2fwQ=;
        b=pAuBots79+9C03SQ7R7D8zT/ctTxDvwUrMVpNXIKENJmRRyFd4XDBxFsg3tkT5mzOH
         F7WPN2LcIHoWLx7+gMQAoR5qwRzQmaD4ju6BkXvQeI3g6qXar08lf7HX5QEob44UG+KS
         OLj1iEmW6stS9SLqrcuukCrdseI5f/EjzypZGYXjsG3C+9l1MHR8QwZ3fyueKGZfXv3G
         vM2tso/EOqj397yeRTP3GyGdPwDoUtQ8ysR4AbcSs7RL9ME73P7RmsQ3OQ9amsNJ2mEG
         GbEqtv2bfAfDGLYpJw97D/s0bjrKMW5n5rh/kH3J0pLL6qrOWkUogjXcTT1IVVl5L5/O
         kDLw==
X-Forwarded-Encrypted: i=1; AJvYcCXl11Ot5iUtil0K1N/JNFnDwsGLGPYcmQ+lDau2VdgAxhP+uIxQAfinmRf+X3LfgBrLfdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0SXm4fYT71QOQ6GnyOopZ5aVxz+QxmiL6aSJTW6shnpM0G38
	I6dGzO7uV5+GKCvWQjuJnEntut5S4FQXipcHrXBdGHyFklWgAqYlHRLdZHLG8VFfPLvN8NCVFV9
	WcGnQfQ==
X-Received: from plcb18.prod.google.com ([2002:a17:902:d312:b0:2aa:d2b9:ae45])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1210:b0:2aa:f9d7:68a8
 with SMTP id d9443c01a7336-2ad74511d60mr88062385ad.28.1771895842481; Mon, 23
 Feb 2026 17:17:22 -0800 (PST)
Date: Mon, 23 Feb 2026 17:17:20 -0800
In-Reply-To: <CAO9r8zMv6E5j7=c-1oqpOihWk0w6a0rexf5FRaP-7PZSwV4vBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206190851.860662-1-yosry.ahmed@linux.dev>
 <20260206190851.860662-7-yosry.ahmed@linux.dev> <aZzyanOAcoAnh01A@google.com> <CAO9r8zMv6E5j7=c-1oqpOihWk0w6a0rexf5FRaP-7PZSwV4vBQ@mail.gmail.com>
Message-ID: <aZz8IGGbrMurzgox@google.com>
Subject: Re: [PATCH v5 06/26] KVM: nSVM: Triple fault if mapping VMCB12 fails
 on nested #VMEXIT
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 23, 2026, Yosry Ahmed wrote:
> > > @@ -1146,8 +1136,16 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
> > >       /* in case we halted in L2 */
> > >       kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
> > >
> > > +     svm->nested.vmcb12_gpa = 0;
> > > +
> > > +     if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map)) {
> > > +             kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> > > +             return 1;
> >
> > Returning early isn't entirely correct.  In fact, I think it's worse than the
> > current behavior in many aspects.
> >
> > By doing leave_guest_mode() and not switching back to vmcb01 and not putting
> > vcpu->arch.mmu back to root_mmu, the vCPU will be in L1 but with vmcb02 and L2's
> > MMU active.
> 
> Hmm yeah, the same problem also exists in
> nested_svm_vmrun_error_vmexit() after "KVM: nSVM: Restrict mapping
> VMCB12 on nested VMRUN". In that path, we only need to map vmcb12 to
> zero event_inj in __nested_svm_vmexit(). We can probably move them to
> the callers (nested_svm_vmrun_error_vmexit() and nested_svm_vmexit())
> to make it easier to skip if mapping fails.

Agreed, I don't see a better option.

> > The idea I can come up with is to isolate the vmcb12 writes (which is suprisingly
> > straightforward), and then simply skip the vmcb12 updates.  E.g.
> >
> > ---
> [..]
> > @@ -1184,14 +1168,53 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
> >         if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
> >                 vmcb12->control.next_rip  = vmcb02->control.next_rip;
> >
> > +       if (nested_vmcb12_has_lbrv(vcpu))
> > +               svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
> > +
> >         vmcb12->control.int_ctl           = svm->nested.ctl.int_ctl;
> >         vmcb12->control.event_inj         = svm->nested.ctl.event_inj;
> >         vmcb12->control.event_inj_err     = svm->nested.ctl.event_inj_err;
> >
> > +       trace_kvm_nested_vmexit_inject(vmcb12->control.exit_code,
> > +                                      vmcb12->control.exit_info_1,
> > +                                      vmcb12->control.exit_info_2,
> > +                                      vmcb12->control.exit_int_info,
> > +                                      vmcb12->control.exit_int_info_err,
> > +                                      KVM_ISA_SVM);
> > +}
> > +
> > +int nested_svm_vmexit(struct vcpu_svm *svm)
> > +{
> > +       struct kvm_vcpu *vcpu = &svm->vcpu;
> > +       struct vmcb *vmcb01 = svm->vmcb01.ptr;
> > +       struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
> > +       struct vmcb *vmcb12;
> > +       struct kvm_host_map map;
> > +       int rc;
> > +
> > +       if (!kvm_vcpu_map(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa), &map)) {
> > +               vmcb12 = map.hva;
> 
> Maybe also kvm_vcpu_map() mapping call to
> nested_svm_vmexit_update_vmcb12() and inject a tripe fault if it
> fails? Probably plays nicer with "KVM: nSVM: Restrict mapping VMCB12
> on nested VMRUN".

Oh, yeah, good call!  That would be way cleaner (I initially didn't move all
vmcb12 reference, but that's a *really* good argument for doing so).

> Otherwise it looks good to me.
> 
> Should I send a new version to add all the changes?

Yes please.  Thanks!
