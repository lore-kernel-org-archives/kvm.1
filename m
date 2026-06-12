Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163135675A
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307637; cv=none; b=kidS80nNW8VMplk3ugpqTSzid31ANCM2nlwuEFdtBGVxqSM6fEay6v8cTq1L1PW7JaoHYaVG8SzRjiIrNUbVJfFb2gcHVW+sSX1zfYFcvn6uCr9TAeMSrHh42GvPEyZnWcqpLahIErCrQ3hbuarlOQ8W+YVnoaiSG2kAhHuwmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307637; c=relaxed/simple;
	bh=eFVon+YrAf/45BuPV6opnTWBUUGU9yfkQLoDYNuFbsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rlO5dYmMFrPERdHG/cFHfPyNjVJWAgI8RjaAu0vZ77oOpBqHP6/1D9jIUy5eZkPyRlmfD6djqA/YIvO1bdxQdZAMi5t+sdT2b6yHLdon4DLBjXPc7TNTa6ucSuXFRs/CwGNZ0wTOe8TimwPjOgbNhcDcXsQ6LmrJsQLKxcNKQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0YTK1MR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0YTK1MR"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1dece2ecso15574345ad.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781307636; x=1781912436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWZML54WsHhSWALuTAkkqMxUQNYB4KRizlsryuenX/M=;
        b=d0YTK1MR0LHEF1EPK7tkF9BrMPe1HCerNtuzf3s33ZkUiUzd986/i/pjjJf3TY80bB
         jQxNArSgExGQ64PsCePBsi3COKRTYxcnL5L3EIA9tsns5E2sRBVW+e1SPiDV2RPb2t9h
         26Tdy0d/6N0rG71pCzoBSD2WGchCbQJ9QA+N3b6E119GLkl9+50guvD/j2FywzucdmH3
         b+xW5QHF8CvXHh8nYnXHnTNBo8RZ+GQBF+SKnPt5A58Z2WUs1iY9rcMRN0dT1ivUggf3
         f2d9QJ77JJ9X4VBIel7JBCxYHK6i1S81RsAG7K+E+8uX1E5sfJmV1l3+174xejOgaxb2
         T4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781307636; x=1781912436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWZML54WsHhSWALuTAkkqMxUQNYB4KRizlsryuenX/M=;
        b=eIcLRkDpkHqnYnWHDNk5dlSuqs1Z2/GaDXpLhkipE+dUG7vT8Li3vEeF9G/wh8Atv/
         avseniDJhkzkHF2Qe9bhHcikvGzH4yXU4ae0ucTfZBYZviqGaQ8EGgj/HNhYq3Q3GM6F
         3O5V+oRerdWjUANWEXiqRQFFcU+n/wqQgHqf/cesXU/rPVXFonw5q6LyEX2Lzlt4FPPM
         U7yh1zZ1rASPdAjci++0B0Ye+Lf5yfWhGNd896TQh7L0IiY+eonjKf75/tGgGhQ7eLJg
         xG9OSeZCR8q0kmimCrbdnqOp+brwjzyrTrVwxPRkG9xsQQ2np5i/tSokFjpCvP9/MY7W
         elnA==
X-Gm-Message-State: AOJu0YzFpGZHZgOJsI5fSoLnS7EFwtYI2OBErIknPAMVos8jzzpIiVf6
	no+jOcM4eT1//ZJ84KnLj7AARb5CCMj0hZqqXtEQfZDStFPT4W64JIY7ytQeru7SgGpkSxx4Gsb
	os+LmkQ==
X-Received: from pldp20.prod.google.com ([2002:a17:902:ead4:b0:2bd:52b9:305e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2cb:b0:2c1:c899:1d68
 with SMTP id d9443c01a7336-2c6642b6650mr17080225ad.33.1781307635482; Fri, 12
 Jun 2026 16:40:35 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:40:34 -0700
In-Reply-To: <20260612233017.1F9771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-5-seanjc@google.com> <20260612233017.1F9771F000E9@smtp.kernel.org>
Message-ID: <aiyY8twOOlRKgQre@google.com>
Subject: Re: [PATCH v2 4/8] KVM: Initialize a vCPU's index to '-1' while it's
 being created
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Paul Durrant <paul@xen.org>, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="us-ascii"

+David and Paul

On Fri, Jun 12, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index e44c20c049610..b3d2a678210c3 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -4188,6 +4188,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >  		goto vcpu_decrement;
> >  	}
> >  
> > +	vcpu->vcpu_idx = -1;
> > +
> 
> [Severity: High]
> Does setting vcpu->vcpu_idx to -1 here inadvertently change the default
> initialization of Xen's vcpu_id?

Gah, I spent the better part of an hour going through various architecture code
to make sure nothing consumed vcpu_idx in the vCPU creation paths, and still
missed this.

> Because this is set before kvm_arch_vcpu_create(), the architecture-specific
> creation code will see the -1 value. On x86, kvm_arch_vcpu_create()
> eventually calls kvm_xen_init_vcpu():
> 
> arch/x86/kvm/xen.c:kvm_xen_init_vcpu() {
>     ...
>     vcpu->arch.xen.vcpu_id = vcpu->vcpu_idx;

I don't see how the existing code can be correct.  David/Paul, is this supposed
to be vcpu->vcpu_id?

>     ...
> }
> 
> Since the actual vcpu_idx isn't assigned until later in
> kvm_vm_ioctl_create_vcpu(), this leaves vcpu->arch.xen.vcpu_id as -1 instead
> of its previous default of 0.
> 
> Could this cause guest hypercalls, such as VCPUOP_set_singleshot_timer,
> to fail with -EINVAL if a VMM relies on the previous default of 0 for vCPU 0
> and doesn't explicitly invoke KVM_XEN_VCPU_SET_ATTR?
