Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633729BDB5
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330695; cv=none; b=QHswKZLGoeMeLmlcKWRsdUprlPuBLCx5AQrgiaqN68OgTWA3Kh+fgg23uyF6lW0loBIL/bDneZHca5RFSQWb3B8EPISkfHo+Yd+QMyVc+VYqrsbPFjwgzc7JTBYgSsgVlKv1Glnkkb+iVMlGDiOTQ7NAw7L7bEUDxkA/h/t8Bsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330695; c=relaxed/simple;
	bh=66rLSXQZ6sV2ExoP3kIQsj8deF5TsolFkL0qsgSbVe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nv7i22a4z5Rrr0eBNcArsCv2yB44w6sGJMOgNdflBk9bUw6HGxPQLuTSXHwZ5EjqRwSrdC+TN/I7wcnTiNrss18GHCLcV1CZCpssReCAShLcte64k35VFrOm1d+ka3Y+yBFbyeTxSgqjgxKwxgJo3HOl/kGfe0ijpEbbVVhVkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8dV6Cb7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8dV6Cb7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c1e08848so21331335ad.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780330693; x=1780935493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnCGGbI4RQKFz/qkCw166U8lw1qB/t/53dFCr4FY9AM=;
        b=r8dV6Cb73VMErsFC3k1NgEeeZF1h1bJEDRKUNj8ukAnJOZp2RhZtYpAqzHAAi6EZ3A
         ePpHHVvcmrcKAB6dxeFUX3Dg0LXXgeoYzuHgxoAhCobbDgabbm3JPikkzUpNt3tv0XA0
         5YmJn5bseOncydONXXrMzkaDDQ6u+tIP+HZNmVm8nWAk8rHVGsUuiXJOrvpavHL7C89m
         kArxvj+N/vn354OMsF+Pd8L/PCSxmuC1J47ztrgdimPoeSbo2vu49oBA9DsphboKxMu5
         tMGx9rhUO6CqQPVIaZMmPFUphwrBBnjClFdgZ10K0Sz0o75w6wXTzm0ebb2IJn+qev18
         ns5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330693; x=1780935493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnCGGbI4RQKFz/qkCw166U8lw1qB/t/53dFCr4FY9AM=;
        b=FOtbl/Rp2EbtF0eog0jQK9Jjv6c0VAnDR1zf/xAjvVI1ABNlzEQ6SLGgrqM0/79WoB
         ZBzb1/qBePZxRy0Q46Vyx74OIEpTgVNNjUf/eXiNoJwmWAJxjVzzhc7wsbJrpPWMwh1h
         JmzdtGen8PVeMs4Ak/l9RKT94sUSTlA4aultPZ8SsHipbBvyNsdBmqAVqPkTuHD5LbDZ
         SdMPrLbi3wyfjRmA2YA+HvbMsFKN5STCLEOm7U+U6Wu1X/WIAYF+aNIlrXcn+r9l/IIx
         r7JeBg8Z3GjI8unKtadK8OwNC0NXxYtHIl38JNtcGge+B/IO2pHVCA/0L1cPwP81M5X4
         tozg==
X-Forwarded-Encrypted: i=1; AFNElJ/q4DidUx6jNukjrM2x7Gy7mzImZqYTC/pnJYSFZ2wzFWloVau6Fkzv+KI/0VItkvi4Pw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymg0BT9Wq6+V3P7p+s4XaXgaNFnU6BZMje9wJL5mQuD3WC4ekv
	12PIFEBracPzKakzyxKckA8Fa8O9wXD1byxqtQ/3R9voGMmBnY89JVRMBBbS099ArtQsx0h6kfO
	A3JGt8Q==
X-Received: from pgbcs9.prod.google.com ([2002:a05:6a02:4189:b0:c79:3224:837d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4765:b0:2bf:23c3:34ba
 with SMTP id d9443c01a7336-2bf368463d8mr150005845ad.28.1780330693361; Mon, 01
 Jun 2026 09:18:13 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:18:12 -0700
In-Reply-To: <20260530092947.490971F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529183549.1104619-21-pbonzini@redhat.com> <20260530092947.490971F00893@smtp.kernel.org>
Message-ID: <ah2wxOMC1lqyJ5UD@google.com>
Subject: Re: [PATCH 20/24] KVM: SEV: Return INVALID_EVENT for SNP-only
 #VMGEXIT from non-SNP guest
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 880a2acd77bff..b59adddfdbccb 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> [ ... ]
> > @@ -4527,6 +4537,13 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
> >  		return 1;
> >  	}
> >  
> > +	if (is_snp_only_vmgexit(control->exit_code) && !is_sev_snp_guest(vcpu)) {
> > +		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is SNP-only\n",
> > +			    control->exit_code);
> > +		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
> > +		return 1;
> > +	}
> > +
> >  	ret = sev_es_validate_vmgexit(svm);
> >  	if (ret)
> >  		return ret;
> 
> [Severity: Low]
> Does this consume the GHCB sw_exit_code field before verifying that the
> guest actually marked it as valid?
> 
> By moving the is_snp_only_vmgexit(control->exit_code) check before the
> call to sev_es_validate_vmgexit(), KVM evaluates the exit code before
> kvm_ghcb_sw_exit_code_is_valid() is checked.
> 
> If a non-SNP guest provides a GHCB without setting the valid bit for the
> exit code, but the uninitialized memory coincidentally matches an SNP-only
> exit code, will KVM incorrectly return GHCB_ERR_INVALID_EVENT instead of
> the required GHCB_ERR_MISSING_INPUT?

Super duper technically, yes.  We can't simply swap the order, because exits
like SVM_VMGEXIT_PSC shouldn't exist for non-SNP guests.  But I guess it would
be easy and safe enough to do:

	if (kvm_ghcb_sw_exit_code_is_valid(svm) &&
	    is_snp_only_vmgexit(control->exit_code) && !is_sev_snp_guest(vcpu)) {
		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is SNP-only\n",
			    control->exit_code);
		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
		return 1;
	}

Hmm, I guess the other option would be to split out the "always mandatory" checks


	if (!kvm_ghcb_sw_exit_code_is_valid(svm) ||
	    !kvm_ghcb_sw_exit_info_1_is_valid(svm) ||
	    !kvm_ghcb_sw_exit_info_2_is_valid(svm))
		return false;

e.g. end up with:

	if (!kvm_ghcb_sw_exit_code_is_valid(svm) ||
	    !kvm_ghcb_sw_exit_info_1_is_valid(svm) ||
	    !kvm_ghcb_sw_exit_info_2_is_valid(svm)) {
		/*
		 * Print the exit code even though it may not be marked valid
		 * as it could help with debugging.
		 */
		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx input is not valid\n",
			    control->exit_code);
		dump_ghcb(svm);
		svm_vmgexit_bad_input(svm, GHCB_ERR_MISSING_INPUT);
		return 1;
	}

	if (is_snp_only_vmgexit(control->exit_code) && !is_sev_snp_guest(vcpu)) {
		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is SNP-only\n",
			    control->exit_code);
		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
		return 1;
	}

	if (!sev_es_are_required_ghcb_fields_valid(svm)) {
		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx input is not valid\n",
			    control->exit_code);
		dump_ghcb(svm);
		svm_vmgexit_bad_input(svm, GHCB_ERR_MISSING_INPUT);
		return 1;
	}

Hmm, and if we go with the second option, maybe rename sev_es_are_required_ghcb_fields_valid()
to sev_es_are_ancillary_ghcb_fields_valid()?

I don't particularly love either option, but I think I have a slight (very slight)
preference for this?

	if (!kvm_ghcb_sw_exit_code_is_valid(svm) ||
	    !kvm_ghcb_sw_exit_info_1_is_valid(svm) ||
	    !kvm_ghcb_sw_exit_info_2_is_valid(svm)) {
		/*
		 * Print the exit code even though it may not be marked valid
		 * as it could help with debugging.
		 */
		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx input is not valid\n",
			    control->exit_code);
		dump_ghcb(svm);
		svm_vmgexit_bad_input(svm, GHCB_ERR_MISSING_INPUT);
		return 1;
	}

	if (is_snp_only_vmgexit(control->exit_code) && !is_sev_snp_guest(vcpu)) {
		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx is SNP-only\n",
			    control->exit_code);
		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_EVENT);
		return 1;
	}

	if (!sev_es_are_ancillary_ghcb_fields_valid(svm)) {
		vcpu_unimpl(vcpu, "vmgexit: exit code %#llx input is not valid\n",
			    control->exit_code);
		dump_ghcb(svm);
		svm_vmgexit_bad_input(svm, GHCB_ERR_MISSING_INPUT);
		return 1;
	}
