Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792435805;
	b=mLSWrSO5AnBYTMUm2yBZoAetu/1VzIXgrjzXGkip52NhRYQrZZxEJJ3Jig/MiCcnJD9h
	 HFc2yHQbw/SSKErQBH3/5zoNy3TjyMcqf9g90M4oDge6iPJD/AfKve+Li6XPZ4VS5eDxF
	 MMoD9/2uM7g2mYMPnHU47c/Qh5r9F62fBG0h9BXP8uyuqQv8atdXJLKYp0uX2eLLQa0GF
	 oEEhkyXCAVR56B9kOgod31y19x1qZLw2a1R+csQ7M7McrHHqYUphv+x7lYAiI3nUJTSfP
	 DLTHjVvX/stfuwbZBjPAhubWWxhP8n5AVQGSLaLrm1jyglbySTcXDqeqGEasfsOhtcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ysOFk37b7EhjKYs1jlxO5/HNbou30LEDlMbBjMznOzQ=;
	b=Fti9qGVNC1aJe3+Yfypcnx+pYH0C++4CqXkleacmWsXda9EuXS/N4MYNC7OH+jGmJGT3
	 kmCwimGF/GHY58BkkPBYrrSkutZpfm6DN4MGUjn5KNtbknd0g/sLegF4SrKCpCKTuhnZh
	 ih/hp22nVE5vNvn7BWwTX6roZR5oA+EzzJwhij9f8qatmHsknycSJI0TSkRDn7sbo73e7
	 HXV+oZJ68qqDCMP2mWW8UnQZEXBDPdhg4wwjAU1SbVJBnjpkk9+Kk5Q8taZQfpdcIDJTT
	 55nlyzP1vhhXAdHzNwEaR7/nmJNRGjo0sDH/q2k4UzfkShHBZ6cWOM3afoPNA+Os8tQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gp2KVdHC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3C606A31B
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 18:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B3C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gp2KVdHC
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1928a12.0
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 11:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792435803; cv=none;
        d=google.com; s=arc-20260327;
        b=sJ2+IHYnHXP2vmyBCZf/cDQ8G7sk78eMuXYKQ7YHwuRNVXOisbVbUjDK75cLD4AacU
         HhiSJeeU9jE/e0de5g4ZTF3NOG3wCHVKjdT8123iHP/4lctP7dQMq8NlruwQ+Dh5EfOC
         KHw1dqCF+ynexb5cCF340V6wYxUgS1+aORLG1nA0rmrUd9ckpAwXBTrV1QJsXCYV0RH1
         PcF99vbSUkUZ6Wsme14lDWoBljjC0WoKfLKNRyCPyIMXxB9zw6fJ7N/6oy3Inuf0FFYd
         En66/pZxCVApnX6cL+zgp/ha7ka2cMTL3n3yPS53J82Uo2XWfdmNsn1FOxWFDS1XcHtz
         97rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ysOFk37b7EhjKYs1jlxO5/HNbou30LEDlMbBjMznOzQ=;
        fh=LH/BetqEcOo9LgeFc7TX7WmFhpw/B0OgFupXiI2U+80=;
        b=nwMnAi2VzZDRsiONPQK5a3Q16ItSrDPwvcZETbr8u1oqs6twHVUJCAHAkrJ2XNJ1nZ
         7MBz4JulNnU+D/bd74g2mus2xMO6TMG8TEeFZRd9PjUvfyRfopKCMs2sDF8SXsg2+P9z
         AuHpRwyiVSajnOLi61gfHUHkVNzJOLSCdPlzCY5WIqo0RDpUmxgyuMJ4+bwdf/YEv4bF
         KYiKF6Xxw4rbmIJ9Q4mx7IbAyYpPAkhLvGfXcgRO+hJ6N2ewhWkDzHwQmrSA9uTkuPQ4
         ECwB13RqEm/yTLk7TKs94VfjF22XsNjBUlupJUb1H+hivwRaVOxk+hD+PaVU6f2g9oNZ
         3dmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792435803; x=1793040603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ysOFk37b7EhjKYs1jlxO5/HNbou30LEDlMbBjMznOzQ=;
        b=gp2KVdHCF/tHupiE14bhXUoXsrCrfiM3vgC4SszA5Lgw1AZHSl5S1knOomWoE7M7XJ
         3vWoWvWTtYYw7rbdyoepgtCmzQgB/deyFYs6FP7+Ynkb7hjpfDg9PM8UbPYm1xB8EVzy
         FfDZ6hPqvWCqluBvPIuDfpxMIkvIXIno6biDIYBGVv9Nq7VJLFHMvWfur5XVlfFASOwC
         3Y8rsSQMJG3ixI8qLK+WdD1IIg3BBCjsdhmJnxLbIA+v1GThFO+Q3FTlQCFxC1fc8JrY
         /6isrjIe6rw1Vf9cY3dxkk/mQgSadCi1HEwsInW4Pw4iMi3bD0tUiXLXUpuU/YoKFe+w
         6nvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435803; x=1793040603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysOFk37b7EhjKYs1jlxO5/HNbou30LEDlMbBjMznOzQ=;
        b=AavgIgR4aFotGLbkqbJY49LxrIyhq1WrTPHr7t76fKqO3LqTD3tFUPTQtdVVoJwGaE
         XgVAeyczL1iULFwrOzEBULVqhBVjZ+i31AjApAJoaiNpSpQZ9mroBJmTAXvMeASH3ixx
         Y+bg3kPpbytMJtrsmQFyNS5C4J2OnSrLCGAIcZOF/QWFce/Nt3BhKtVyLfgYTZCz3UH2
         cj37/Mmo7LmgGGihm5hFSoX4bc8KuR6z63E89FTliFTgWluKssXaNwL4e1EURSd9VEu5
         6KdY4Ow+f0VCmOfbqoFSDbuycqGp2GfufPvKyyBz3LmVh0JrgolaDoNC+a85waPttZPi
         Hz2A==
X-Forwarded-Encrypted: i=1; AKwUvBzKMq4V5Ml4cgIzdv15b7H8PGwXocp35/b9cBG9MLvco50RmXoopHv1NbKDfAjz8njNoI4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8+7kdxRsxHyfuiNzeFqNovPA5awVGfNKqUAwLnbetYyrA3RM0
	ZWiZh1rmiMzG5OLg1q8r3A3ELb0a1vx84tM21+pyg36IkF6Vw9VJldvak80xt2fL50VzE0DpX1S
	eZGAP95QkgIDNj+CyEAjQ/r8kKKSTL9YZtubX1ekb
X-Gm-Gg: AYBFou3KxoCm/1HxQI0aIgsQyEPnddPimFYKqTQJIE4VhVAdqPk1gfTka0M8zYn6+Rv
	tDOpKSURLbmGb0HAYJa0I+SNCqQJ8Qu8Gum+WMlbLlV8jnEbugd6O0jITb71qIb9+/GYahN5qoZ
	sTXFqD+4jkzLe9nr5sAPhXwO1jzoyeNs12GWqqXmpBSRAWoE2EJ5WRcH+PB2gB3GkJQEDMG6EDS
	mKwFT+m/ifPT+jJLqnrp5GkPhnWjeXoPNiQDoJjsV3pV7u3UlmEkZhJ7ngPNb2+LPwZB9gAbH6T
	s0Dw6vKbt96XRY+a8Id3vgsrM+E/DwaZR9jqbvqZR/qQzsyCcEJeuKE=
X-Received: by 2002:aa7:d68d:0:b0:6a9:d188:2374 with SMTP id
 4fb4d7f45d1cf-6b3e57928cfmr6518a12.1.1792435802430; Mon, 19 Oct 2026 11:50:02
 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com> <atK3Y5XxL-zmAvY-@google.com>
In-Reply-To: <atK3Y5XxL-zmAvY-@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 19 Oct 2026 11:49:50 -0700
X-Gm-Features: AclHuK-HB6pH30iHmiqBTNMP3lFUzo7O87u3CK_c_9C3jbnplSPKBf6ajDasAA0
Message-ID: <CALMp9eRcWZ8fh8_m35RDw-VNrqz4kapVodGoLr=B_iAZaPOA=Q@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 5:25=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Oct 16, 2026 at 02:17:30PM -0700, Jim Mattson wrote:
> > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
[ ... ]
> > Per the APM, volume 2, Section 15.16.1, "TLB Flush":
> >
> > > All TLB entries belonging to all ASIDs are flushed by SMI, RSM, MTRR =
modifications, IORR modifications, and access to other system MSRs that aff=
ect address translation.
> >
> > With two separate ASIDs and the unconditional flush removed, do we
> > flush both ASIDs in the above instances?
>
> SMI and RSM, yeah I think so. kvm_smm_changed() ->
> kvm_mmu_reset_context() deletes all roots, and kvm_mmu_load() will flush
> the current ASID when a new root is loaded.

Okay. Is this mechanism obvious to those who are versed in the ways of
the KVM MMU?

> MTRR writes seem to do nothing beyond store the value, probably since
> 0a7b73559b39 ("KVM: x86: Remove VMX support for virtualizing guest MTRR
> memtypes"). It is documented as an errata but I maybe KVM should still
> flush the TLB? If that's a real bug, it's separate from this series tho.
> We just need to make sure if we fix it, we should flush both ASIDs. We
> can probably just reset the MMU context here too?

Probably. Admittedly, it's orthogonal to this series.

> I can't find anything related to IORR in KVM.

Me neither. :)

> For MSRs, I think the relevant ones are EFER and PAT:
>
> - For EFER, a change to KVM_MMU_EFER_ROLE_BITS resets the MMU similar to
>   SMI/RSM, so covers both ASIDs. Clearing EFER.SVME frees L2's ASID and
>   re-allocating an ASID will flush it by clearing last_asid.

Okay.

> - For PAT, I am not sure if that falls under "system MSRs that affect
>   address translation", but KVM isn't flushing for L1 today on PAT
>   writes anyway, so I hope not?

Maybe not. Intel, at least, puts the burden of flushing TLBs on
software. In volume 3 of the SDM, section 14.12.4, "Programming the
PAT":

> The operating system (OS) is responsible for ensuring that changes to a P=
AT entry occur in a manner that maintains the consistency of the processor =
caches and translation lookaside buffers (TLB). It requires the OS to inval=
idate all affected TLB entries (including global entries) and all entries i=
n all paging-tructure caches.

> >
> > Moreover, does this change the semantics of PV TLB flush? In
> > record_steal_time(), we have:
> >
> > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> >         kvm_vcpu_flush_tlb_guest(vcpu);
> >
> > IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID. In
> > the past, with a shared ASID, L1's ASID was always flushed on emulated
> > VM-exit anyway. Now, L1's ASID will be unaffected. Though I can't find
> > any real documentation on PV TLB flush, it *seems* like the remote
> > vCPU would want L1's ASID to be flushed. OTOH, this change makes nSVM
> > behave just like nVMX.
>
> I am honestly not sure. It seems like we should be flushing the context
> that issued the PV flush. But I also suppose (aside from Hyper-V) all L2
> PV calls should go to L1, not L0, so should we always flush L1's context
> here?
>
> It would be a pre-existing bug, but this series would be adding it to
> SVM as well. Adding David here since his name appears all over the git
> log for that code, so hopefully he'll tell us for sure.

It's just happenstance that the PV TLB flush mechanism works with nSVM
today, but I don't think we should feel free to break it.
