Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D5367B92
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382168; cv=none; b=BW0viZg9XgBVPf4/e6UZapaLYpfyLC8zdOJAzMc2+BLTqTyQqwqsWneb/VTiGolF8cHc+LmRnkp/TCpeoSzZnPBQ23aIXChE1JpXMnraG9MW0nulywjl24nFPQOn/YazDoevixK13q2blcqBEMFSvozzVKMDS2vn0UNFkzaEM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382168; c=relaxed/simple;
	bh=d3eFT79e+sYwxEQtn0wpMt7MmXkuJULAfjVLUFhy2Jw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iu00TuRWF4hRGEDVAadG7iZdvF2szOFcKFxelMIK4RnFwQIsE/92yYku2gN9P5LBW58iEEwSO8NZ1CVRsyl3hexTY12zv3Cdztk76rhA2jbe+AMkSBa7MfL4/XPYk0VAu2FSyWVrsKu4HivsoUNLoPBMa+hRrowVlYtuHbqnHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocSnmRuv; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocSnmRuv"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d9336581a2so25973145ad.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788382166; x=1788986966; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w5M2n78XakxQe9dAtPYQIzOqOSJtPDxO02ooAB0+0oI=;
        b=ocSnmRuvMO7GC25eenktLo8mRjF8c7OmXTwTpsl+d6HUOd/9wlRbkdwwXkol+e7HPh
         SAQCb+g6LZhbWrV/bioXdfNClNuXPV9UZsqznovjyP1jRTVRHUfVZ4t2/5cauuRzqeWn
         O2ZgCtgsiObJxjTFPj5p0s0QOAZTlZgIE+IGQdGx7YaXZfyWQAQhOGT7uqTfPD4HVS2j
         kYH+/Z8r9/IpU7jt5TuBy/sUTZGKgHWe1IfhYKjRRKnZIxJFllGP41UKGueBSdL2IqtA
         QJWTYfG5EBB4tsepl87u4QDkikDMdUPoULkmKCJnDbBi6MbpVYIa5dA3fCzgU9QuiPNz
         J78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788382166; x=1788986966;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5M2n78XakxQe9dAtPYQIzOqOSJtPDxO02ooAB0+0oI=;
        b=lsNTQOOu6RS2thVVqOBRsv9c6EkEJ9NdFlsk2CSw3LylcfhoshDL9GblvY0j4cOnxN
         +ha+yB3vB3419ObYAavjEAlVMMeuwsAnmgQ7x38NRDAOKsa0wsspSYuG/d+NqQwts3Pp
         zNmTG4H8h3Bm5EeyxvwJf9sDZOGjfa4rHuvOmesOjZgRm/5UATl9bDBrA+Rb8mi7Wawc
         mRmhwL9lHvx1SM6HR030OXgTEwfHuuNUNsttTMdMAl3p0NjpMfbDL0iJeOo/ChJAB3P2
         QJ1t6BhD4bL0dMuKTeRh7DdPyuLusNU+41OYwfcthTvSi7HaveM2Bt7KgQeHKupKqiR0
         lQSQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1OcQFQnLGDPF2sADyFUE2YKNw2xRFisl3e1kZ3ducpKke/Lamw21uJlXpXtjUSMGDi1U=@vger.kernel.org
X-Gm-Message-State: AFuF++lHZnkLtmYAix1FQwxtuNMFFvNRf0j1qSilpMLbOqc0SNtt9mkR
	seKVFUhklVUjARB6YMHDA9z9hEWUWapE3o2fnM1sfJrHioOWImMwNLY5MMnUTt//z7arR6J1+oE
	IkcjYrQ==
X-Received: from pluo3.prod.google.com ([2002:a17:903:4b03:b0:2d9:1a52:2094])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a30:b0:2d9:2688:8be6
 with SMTP id d9443c01a7336-2daec71ddddmr102163065ad.19.1788382166025; Wed, 02
 Sep 2026 13:49:26 -0700 (PDT)
Date: Wed, 2 Sep 2026 13:49:25 -0700
In-Reply-To: <649c7d7a-f042-4fe2-a3e8-eb15e4d76a46@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026201911.505204-19-xin@zytor.com> <20260902142336.9955-1-ehemily@amazon.de>
 <649c7d7a-f042-4fe2-a3e8-eb15e4d76a46@intel.com>
Message-ID: <apiL1WmN3j4ceDHI@google.com>
Subject: Re: [PATCH v9 19/26] KVM: nVMX: Enable support for secondary VM exit controls
From: Sean Christopherson <seanjc@google.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Emily Ehlert <ehemily@amazon.de>, xin@zytor.com, andrew.cooper3@citrix.com, 
	bp@alien8.de, chao.gao@intel.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	hch@infradead.org, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org, 
	tglx@linutronix.de, x86@kernel.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Sohil Mehta wrote:
> > The write side already validates against
> > 
> > vmcs_config.nested.secondary_exit_ctls; the read side should likewise gate
> > 
> > on the control being advertised:
> > 
> > 
> 
> You are right, the read can be gated on the control being advertised.
> Looking at the rest of the read function, it doesn't seem to have any
> other equivalent check. I think there might be others that have similar
> behavior.

Yes.  Secondary controls, tertiary controls, VMFUNC, EPT/VPID, etc.

> But, I don't see any harm in adding the below check to match the bare
> metal behavior for the new code. I'll add it to v10 unless someone objects.

Normally I want MSR accesses to have the same fault semantics for userspace and
guest accesses, but for the VMX MSRs, I think we should let userspace read at all
times since they're feature MSRs.  E.g. I don't want to end up in a state where
userspace can't read an MSR because it restored/set MSRs in the "wrong" order.

We could plumb in @host_initiated to vmx_get_vmx_msr(), but I think I would rather
add the check in vmx_get_msr().  E.g. shoot for something like:

diff --git arch/x86/kvm/vmx/vmx.c arch/x86/kvm/vmx/vmx.c
index 504630f0eb40..a99cebfe50e0 100644
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@ -2200,6 +2200,10 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
        case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
                if (!guest_cpu_cap_has(vcpu, X86_FEATURE_VMX))
                        return 1;
+               if (!msr_info->host_initiated &&
+                   !guest_cpu_has_vmx_msr(msr_info->index))
+                       return 1;
+
                if (vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
                                    &msr_info->data))
                        return 1;


That'll require yet another switch(), but reading these MSRs should never be a
hot path.

> > 	case MSR_IA32_VMX_EXIT_CTLS2:
> > 
> > +		if (!(msrs->exit_ctls_high & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS))
> > 
> > +			return 1;
> > 
> > 		*pdata = msrs->secondary_exit_ctls;
> > 
> > 		break;
> > 
> 
