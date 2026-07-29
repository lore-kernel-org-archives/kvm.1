Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA37303CAB
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369446; cv=none; b=KnuKvFw6do7XxsZxS4m5DdG5CsQcl+BfG2THxN7N3bv4wESWbRqs5Ex6W7HxdVk634JH+c+aCPdvptp2V2KR4rumqzcF+jpZ3+xa3kGySSQ40N/4hvHKDUv5GFS6kNnewNuKdz85xAy1fJX0eLldJfzXVu0ZBb4rRk+kItsBQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369446; c=relaxed/simple;
	bh=x40rpiARFSh3T5lEfW7U0Jp2NGDYvCg2rqs+FMxdw1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxEgX8biEE1JKQRzivsuTKnGF+4DQBcZpRuw9AqoLRwLaNVZMpKmrLcx3WbqxlgxSaC4DEuv3z5XUtI1s4giuqpOrHgGyF8SfHhapAMzUjLtAtaNreEFpOXlE3V7upxao83k2pMw7oPg1sdj3qryutxRvV2NN31N4FHW1mLXLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T96uDIU6; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T96uDIU6"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6823efcso13463995ad.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785369443; x=1785974243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ht1aTs4pO9WHnQaSF7pKvIACIeVphUGRPBFrJ5uIv+8=;
        b=T96uDIU6VfkfEe78RA3/KP22l6Z26FjfTQ+nsGQydcFNmVMtvNNbQTd0TGnLrbEfKe
         pqCY26jImGT1HTveLZyELZRscGp/6VQgj33tE06fPohRhd6xh3mxGmKonuwZfUQXWDgr
         YrbymKH+DfLlvnODoh6H12pQoSbL6+6cCmIMYENZIKQ+yeW+78egLCzfHFjxyOq9XMLC
         /84EMVuDpsYAZyMVp11KoT4ifWAulkjzyU2g250EinAjs5ImfiZ8ndUYMgDE3padlGB+
         GB8kecLNN0seKVftE83RR0R31RP91EUw0QMtlh7P3tOaOupm95C66//BbnW+NOZstN2R
         Sf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785369443; x=1785974243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ht1aTs4pO9WHnQaSF7pKvIACIeVphUGRPBFrJ5uIv+8=;
        b=eNxibMfCjoi2KeDhtSsm3ROui0pVesCFxGb1Yrl3qlEJA14NjWPGq//THwxqnrSh6O
         owSOXnV4MIUvD7O9re5i4A1ApEVnT75QPok/wC70LLG3eVX7lmfAXzz3ryCsyyJBL8/F
         9fW7uLud4sBFi+xa48xc/gcBB5FSbqNAf9NK4MeO4w1f02O5zmlMahh8ny9ltiU5FWJs
         8JsGfUUaYaqxiG+DA/VJD10CO49UZ5EUf8bwDCGeHg0DnVe9MjHqhnCW/retN5Z9L0vz
         vWGC1BIOYMisq0NscsPrL9DU0XAG7X8VGJNlftctsT9Jc1XhZtwYeXjzIsnIKWafyFWw
         MafQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2tWbp7Hl4F0JowKudXwtq5bPteS2Z3FaSSwxaAn4bnGKc6fMCyr0oJDRz5ONvlxgA/ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSYH6KaGA0ylorAhkuqOWKi718faWgSOpn1LPwR1YcJim+vBp
	D9rvX0GtKdB8lHFop59JBMmM4fNryzR5YqYyA18P/4Uug5LwiI8UdHU4nKoFMmYt3RKNUMOJ5dX
	Go1QVuA==
X-Received: from plpw13.prod.google.com ([2002:a17:902:9a8d:b0:2cc:fd6c:c5d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d591:b0:2c9:da58:17dd
 with SMTP id d9443c01a7336-2d035e4b61amr3750695ad.34.1785369443197; Wed, 29
 Jul 2026 16:57:23 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:57:22 -0700
In-Reply-To: <ampBJrSSas_XISim@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729170621.308809-1-dmaluka@chromium.org> <20260729170621.308809-3-dmaluka@chromium.org>
 <20260729172831.5BDE71F00A3A@smtp.kernel.org> <ampBJrSSas_XISim@google.com>
Message-ID: <amqTYv4LtlI4SKcj@google.com>
Subject: Re: [PATCH v2 2/2] KVM: VMX: Fix stale PID-pointer table entry left
 after vCPU free
From: Sean Christopherson <seanjc@google.com>
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 29, 2026, Dmytro Maluka wrote:
> On Wed, Jul 29, 2026 at 05:28:30PM +0000, sashiko-bot@kernel.org wrote:
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 6b96f7aea20bd..ebf26ea84a50b 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -7572,6 +7572,9 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
> > >  	nested_vmx_free_vcpu(vcpu);
> > >  	free_loaded_vmcs(vmx->loaded_vmcs);
> > >  	free_page((unsigned long)vmx->ve_info);
> > > +
> > > +	if (vmx_can_use_ipiv(vcpu))
> > > +		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id], 0);
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does clearing the pid_table
> > entry alone prevent hardware from writing to the freed pi_desc?
> > 
> > According to the Intel SDM (Section 29.1.5), the processor caches PID-pointer
> > table entries in the VPID.
> 
> I can't find this statement in the SDM, and I'm not sure what it has to
> do with VPID, apart from the acronym similarity.

Yeah, I have no idea what Sashiko is talking about.  The PID table is physically
addressed, AFAIK it doesn't have a TLB entry of any kind, let alone one tagged
with the vCPU's VPID.

> > Because KVM immediately frees the vcpu memory into kvm_vcpu_cache after
> > kvm_arch_vcpu_destroy() without issuing a cross-vCPU flush (e.g., via
> > kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH)) to invalidate the VPID
> > caches of other running vCPUs and synchronize with in-flight IPI deliveries,
> > can other vCPUs still send hardware IPIs using the cached pi_desc pointer?
> > 
> > Could this result in the IPI hardware writing to the freed vcpu memory and
> > corrupting another newly created vCPU when the memory is reused from
> > kvm_vcpu_cache?
