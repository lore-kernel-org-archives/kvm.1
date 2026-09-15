Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279637DEA3
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482683; cv=none; b=gOdfg0LQ0eO+aiPcLyIJLZJbd1c6q/4oGJDwIEra8YXAAPRlatRnvbLPMaQyOiEbi2cWYMdDfvc6tA95iUUYa7D7LXlMNPNninNJWjNU+qsMaOQMFbiXZJYEYIsmBJJraq7bwsLan6yyEh4ltLUrLGXsyHMg2Er/fn1XN/KP84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482683; c=relaxed/simple;
	bh=wgiHkbU+yT0wAsLAa4BYS1bLM7Wzx46WXTyUlhOUfAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sBnGME3fBYXJYnu6RLGJUKE6nNTCRKFlr8BtDtsWfyBkKoh22zq2/e71f98vG9Hx26RYBPknHep17rdoijLfqwSiqwBjVULWD6pVKy36tWr/98TymhzZq0bBlYyO1SSINgBJFODn4aj3NzwEd6yxPWHd+gPVzeukM7rYLGHatR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TVsuhdRZ; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVsuhdRZ"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4fc935a11so1115127a12.0
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789482681; x=1790087481; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxCVdsnW3ZSI7KLXQLXPZOQXUZHRc3cqhqBZH7/A718=;
        b=TVsuhdRZRFK+6WTdDzA2xw7g56/0iCU0iFR7USwiH2WraJCyIxMeM4QQaL7GCwbwrZ
         gsT4cA+1H4beBJr8XD4KmYcwPJfgOl/UI4prlEUs5eLxH06HM+7yV0mTvZGxSdt6a2zx
         oDdPP5JvrsCkXjAdiK8Woic2fuNkLUYEblbMpMr+8oIIe15B0Gm3LfMiXZ58XB81sP/X
         8EGBoeyDqQ3btlFyyHJHYgeYwHfeioK6XCz4FYqFjbdvnTxYQdFV9Lp2cp3ggp4N4Qpf
         y+fX0+VyG4QVuEz2prvvmS4O32A+DaDby2HcYsN13FbdVpXYt/2EGpvZS5eNn64wlG4f
         GJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789482681; x=1790087481;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UxCVdsnW3ZSI7KLXQLXPZOQXUZHRc3cqhqBZH7/A718=;
        b=keHGRdIbNUpvKZ9dfJsPjpu/NK0JsluQ0w5BPGhAeZq11ROPji4B6FofkEKbU8ppoD
         GU8tm44dI54ukZfMug/muJ8yCmghno00Mslw+KAoNxz6dx9oml8qLf2b++4r7DJSRTVe
         kwYFPfkuZMgp0O0QSp0SziBs3eHVFTj4aOvFHUFTmb/NuszPBBONf6NKQlJd4w2IcuUH
         o0D+1DJ/y0G/yH4EvKEgycNjFMw+4cf7BS0TB/Eb/8ighfnw5taj9Z608FkXmqcKSwY+
         qRWK5HBaErLONke/dL10C2QWw8c+F3GiTvklqoJmgLOZMr3AXL+hB6suJjl1WA0WWkJ1
         L24g==
X-Forwarded-Encrypted: i=1; AKwUvBw1V5sQCZYAPP90b+E7d19lNIx2QhkeLqQEwSLlYi/3g1Ti5lZzHcSIU5VbQSyxh/IB+nY=@vger.kernel.org
X-Gm-Message-State: AFuF++nZF/f75uc++Rk1CwFTHMLIuPCkLhBhUMkAQ3162Oap+ocewS+g
	gesSUUzi+xgb3TydLzv4iNOvCp9561GaJk/pbi0LtBZNM2PsGVknh/tiCP9I9yJbqTLDUcylxw9
	pg9emmw==
X-Received: from pjyt2.prod.google.com ([2002:a17:90a:e502:b0:39d:94c4:375f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:1697:b0:39e:1310:cb36
 with SMTP id 98e67ed59e1d1-39e1310d234mr1156057a91.20.1789482680587; Tue, 15
 Sep 2026 07:31:20 -0700 (PDT)
Date: Tue, 15 Sep 2026 07:31:19 -0700
In-Reply-To: <0b2d8858-b361-4a64-986a-4c179210fbec@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com> <0b2d8858-b361-4a64-986a-4c179210fbec@amd.com>
Message-ID: <aqlWt4jb4CSPnecN@google.com>
Subject: Re: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jacky Li <jackyli@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>, 
	Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 14, 2026, Tom Lendacky wrote:
> On 9/10/26 16:06, Jacky Li wrote:
> > Currently, snp_handle_(ext_)guest_req() returns -EIO when
> > kvm_{read/write/clear}_guest() fails while accessing guest-provided
> > buffers. Returning -EIO causes KVM_RUN to exit to userspace, likely
> > killing the VM.
> > 
> > Fix this by returning GHCB_HV_RESP_MALFORMED_INPUT with sub-error code
> > GHCB_ERR_INVALID_INPUT to the guest and resuming the vCPU.
> > 
> > Per the GHCB specification, guest-provided GPA buffers that cannot
> > be accessed by the hypervisor (e.g. private pages) should be treated
> > as guest input errors. Because kvm_{read/write/clear}_guest() only
> > returns -EFAULT on failure, treating this failure as an invalid input
> > aligns with the definition of -EFAULT ("Bad address").
> > 
> > Returning GHCB_ERR_INVALID_INPUT also matches existing SNP handling
> > in KVM, which already returns this error code for unaligned or
> > overlapping buffers. It also aligns with other hypercall implementations
> > in KVM (e.g. Hyper-V returning INVALID_HYPERCALL_INPUT on
> > kvm_read_guest() failures in kvm_hv_flush_tlb()).
> > 
> > Performing upfront validation (e.g. via kvm_mem_is_private()) is
> > avoided because it is prone to TOCTOU races with concurrent Page State
> > Changes.
> 
> I'm ok with this approach overall, but will we run into a sequence
> number problem now?
> 
> If the kvm_write_guest() in snp_handle_guest_req() fails, invalid input
> is going to be returned, but we will have successfully called
> SEV_CMD_SNP_GUEST_REQUEST. The sequence number will have advanced in the
> firmware, but I think the guest will not think that it has and not
> increment the sequence number causing subsequent requests to fail. At
> that point the guest will need to zero out the associated VMPCK used and
> move to the next one (there are a max of 4). If this continues happening
> the guest will eventually not be able to make guest requests anymore.
> But, I guess, if the kvm_write_guest() is failing, we're probably
> already in a bad situation, so maybe it is fine.

Oof, "fine" is definitely not ideal though.  

> > @@ -4244,8 +4246,10 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
> >  	if (ret && !fw_err)
> >  		return ret;
> >  
> > -	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE))
> > -		return -EIO;
> > +	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE)) {
> > +		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
> > +		return 1;
> > +	}

What if we keep this one as -EIO (or better, change it to -EFAULT in a separate
patch?), but add a comment explaning why KVM needs to exit to userspace in this
particular case?  That would be a good compromise; if the guest is attempting to
access non-existent memory, the initial READ will fail, i.e. we still get most
of the behavior Jacky wants.  The only fatal case would be where either userspace
really did screw up, or the guest managed to find read-only memory (though I
would probably argue that's likely also a userspace bug?).
