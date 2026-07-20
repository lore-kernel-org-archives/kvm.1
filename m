Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3964252A8
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563931; cv=none; b=UMP0ngF5eo+6l+5pzj8hBkE3gA9aaY+TfZgfJK8UQUIoVIVUQJ6ua8XTmebVLRujz1LavxYaXxRRlAC7COHgBZIzKoqbKz13OFpGMqN+dIfbV9ISc8lyO5py0B8dSjZde4Sk97/lui2Yl6qWyeHLbJjE3x+l21n6iNXiqLlrj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563931; c=relaxed/simple;
	bh=M/Yq50oUOJW8+alNsNd4Ly3iEGNNNM7urrH+LQWugO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhJs3x/TNtByDDAAzEk8hiYFjjm9ICnfxOzBzb3yXPiNaNanvvcnrtOVs3GTK+WbQSI93aPTx2924OK3G4SKDmW0k0dxHr7kbgqSryOkfO6I/ewL3Ncq14q83ePVJEDD8Ptgxi1ScoDVEnelmPoSqjcgGrpuXdZcg3aZ/N9rnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/sYLTiA; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/sYLTiA"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a3514f912so13836391b3a.3
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784563924; x=1785168724; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++ry5qDy5Ea22Sg9kpftvqPxmfdp1IDpOpObjfqlWCk=;
        b=q/sYLTiAp9Lngdw23f2dlsJ+diYUhZRQOjD3bigSNBwI16Ev7XEXaPMkTJWf44rHbk
         HkGZAnOMYG8LnaevLSV302mm0HfLj5fvmZrJmbKWfDBanKDfXaGuFz7uVU0r67+o5nNc
         GCWjsBHOmozmxy9fmUrx5Z02vabHqrMs2SH1MHWcqWfD/LdWga87zOq7N5AHzBwN8D3z
         C47sY7tL0NcvQzzks9fuGaglaMee8nmupGlm/+3MRSobYTcEbRV0Iq2XfLhbfu2ACac7
         MFyWRnBuEb2erY7EsQhzryUr32AEFRc9lIquYBhbS7AjyZQwoRojYMkJgtH2AcMFpjwp
         95qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563924; x=1785168724;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++ry5qDy5Ea22Sg9kpftvqPxmfdp1IDpOpObjfqlWCk=;
        b=FNjI3wt1d50Da0chitlRYLDJzGnf98v8RH6nF9xlBzM9ijPuvCx4+r60g4eUatw0hZ
         TIe0K5RH9r96CfIKa+rrnRt+UXk0h9p4s6xcyzCffm3c8TRxeozx4qwKtDpqhEiKCJx8
         +o5M0FeRl2FdnczGKLRtNZ7dMjGcMD6MNK/gCjREJUQys3feAjs+TzRVVuNeOFmxgojD
         dJuSk7qqDb8fCs6pRlRpMlQp485HO2Xn31VCyw5RNTvMnQZShRkCi6pFiOXLN8I0+XCH
         J3iP3vdjXeRjHPcFvvd/MrSZXzjUKiiLSlK/4HWIwf+vBUz1n1l8+MyHykxBKxqdqJo8
         1/gg==
X-Forwarded-Encrypted: i=1; AHgh+RoPRsAJrhXTk4kDZKWPe3eBLxhaArzoLBgFjEYi9Q3D5A20eI9MdlAUtDKGEdXT+xqf614=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/TY6xYWqU187d+Dpwf07gph6rOcdke1kDTjvkEu8Qrh2mkOj
	uYKHW+4o4RIcIgERTyALG9xzgVr5AubZtrcLh8OZY1IK02LBRCg3k2WcocQ+7EVqVvnQSW67/cy
	KPV9s5A==
X-Received: from pfbml22.prod.google.com ([2002:a05:6a00:3d96:b0:848:40f5:a538])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b44:b0:845:e19a:1188
 with SMTP id d2e1a72fcca58-84c294fb671mr14217287b3a.52.1784563923309; Mon, 20
 Jul 2026 09:12:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 09:12:02 -0700
In-Reply-To: <al5EPBD0KQDpbNiA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717230542.3555587-1-jmattson@google.com> <20260717230542.3555587-2-jmattson@google.com>
 <al5EPBD0KQDpbNiA@google.com>
Message-ID: <al5I0lV7Qd-ClyDb@google.com>
Subject: Re: [PATCH v2 1/3] KVM: SVM: Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid()
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 20, 2026, Sean Christopherson wrote:
> On Fri, Jul 17, 2026, Jim Mattson wrote:
> > On initial vCPU creation, init_vmcb() is called before userspace configures
> > guest CPUID via KVM_SET_CPUID2. Consequently, ERAP_CONTROL_ALLOW_LARGER_RAP
> > is never set during initial vCPU creation. If an AP later receives an INIT
> > signal after CPUID has been set, init_vmcb() would set the bit for that AP,
> > but the BSP would be left with ALLOW_LARGER_RAP clear.
> > 
> > Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid() to handle the BSP.
> > 
> > Keep the code in init_vmcb() to restore ALLOW_LARGER_RAP after the VMCB has
> > been cleared on the VCPU triple-fault reset path.
> > 
> > Fixes: db5e82496492 ("KVM: SVM: Virtualize and advertise support for ERAPS")
> > Assisted-by: Gemini:Gemini-Next
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/kvm/svm/svm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 4d2bacd00ec4..bf868da14cd2 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -4736,6 +4736,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> >  	if (guest_cpuid_is_intel_compatible(vcpu))
> >  		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
> >  
> > +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
> > +		svm->vmcb01.ptr->control.erap_ctl |= ERAP_CONTROL_ALLOW_LARGER_RAP;
> > +	else
> > +		svm->vmcb01.ptr->control.erap_ctl &= ~ERAP_CONTROL_ALLOW_LARGER_RAP;
> 
> If we handle ERAPS here, can't we drop the code in init_vmcb()?  In the context
> of PML enablement, AMD is updating the APM to clarify that the control area remains
> valid after shutdown, i.e. KVM doesn't need to re-initialize erap_ctl when
> synthesizing INIT from shutdown_interception().
> 
>   "After an intercepted shutdown, the VMCB control area is valid (with the
>    exception of offsets 60h, 61h, and 68h) and the VMCB state save area is
>    undefined."
> 
> https://lore.kernel.org/all/6688fe2e-c723-404a-80e1-3f4c5f5cc4c6@amd.com

LOL, nice, I just saw the Sashiko report from v1.  I think the way to handle this
is to go with this version, and then rework shutdown_interception() as part of PML
enablement to not clear the entire page, only the contents that may be corrupted.
