Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8F33F8A4
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158489; cv=pass; b=Br2Ml0yU0rtQgJZiRXo26MvC4YZFaajZ7HEPWjo+ixcFkb1DpzLAoR2ImfozcYDgp7560+Dmj5M/QenyQzlqbITTvGGqdE8PtFgf+qSOxLBdNaySWfQssnw9WAy8GHNBD01KzrE+XTg7ibMd0qvptlhS5dCrM8MwhvgZDvBFTE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158489; c=relaxed/simple;
	bh=zjwPJ/RDPClqUqK3dNI+PsBLnpyiL2PUTGqKbhgYXKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPL2oQwRU0OOA7ycL4prlh93Y6MsADU8sRt7BBtc/MgFBy0m1EUrY6hVyUn8ZRRfaRE8xxp+agaCLomnSsUJwUE1LLcbadbbRO563BzIwaYk06QIZii8+uhKWGPiygh4ryftO5S7Gz7bXhiJ/x0Wx1TJ/QjF4uDfw/ZEP7jvh7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPT2v4hB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYXSSwOV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPT2v4hB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYXSSwOV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780158487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KFwbDhRstQgRlULxxXcLO373bDVUhgaVz97DA9wG8Y=;
	b=hPT2v4hBrrrTlCZMZd+rwj4UKNVcIBNjJJvGCqCXFrINj8b12Eo1ylB5TYb3pT6L1ArnCh
	UBTwNTWgm9SrW/8YBRn7QC317bx1Xrkc/een10Bc7O+r0nUcv684xTCgw2Z8BByRoCCw1w
	ephHIczDw+5YhfUKwkXbis12sqUwRyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-dMykaC34NyO0gQhUnM-LPQ-1; Sat, 30 May 2026 12:28:04 -0400
X-MC-Unique: dMykaC34NyO0gQhUnM-LPQ-1
X-Mimecast-MFC-AGG-ID: dMykaC34NyO0gQhUnM-LPQ_1780158483
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4909ea0ffbeso11963535e9.1
        for <kvm@vger.kernel.org>; Sat, 30 May 2026 09:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780158483; cv=none;
        d=google.com; s=arc-20240605;
        b=Wi/mTif5auxLs3YsoWxF2PpqxiJCadInUtaZdKJUSuJsJYBSfaMEbJY2R3m5/0xCgD
         pt0a+ex1yaHICD5HDHxtkElLYsuEhOoG8tttn0uBR87OsbFq/Q6u8qPpIiXZ0eDYNF84
         zSTHVaq3vgc/2IyxV8ywYKuPkGyDI0i79iHmz+6WQCWo2V43D9BSHFv8fNEudVj1f2I+
         +e3GPhh6aRvyp3+6gidExsBA5mM6NoW1qWC2cnIWS4KoFhzc7lLl0Gty8HzbzQR3gVSX
         pAKfS1+aGB9sEYrO2ayCH7m/UjhS3xBU+tvtlUkiLm3BVxoY0VSrTYxQmVDE6JL7lNJu
         ERuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9KFwbDhRstQgRlULxxXcLO373bDVUhgaVz97DA9wG8Y=;
        fh=imG1XOGUtyxkjjM1mqJJvMce7aaNh0fOx7+EzU1UAcU=;
        b=fRoLhfiLhy25H1a2G3Ggwdlwp560oqaE1Z0p6iY62O/GVjzaMdqsAx9IUgpzzsbXc7
         gG4ax/2rAxZvN7tGU8O/PuEHfc2pJrdhMkTRkSEi0IpThB5Jr27zAW9EeJq9JFYORLHS
         fzRaG14ZIWQjP158zBzER5irUCBSfTwi+5z3le1uoHz9peEUVxR7zngImKJgtxQyqJeG
         pFvOM+8mZg9vpwjVrSLA1XK3/GsEt0vqIznXi85W8ln7/1NqlGjIx9oltgPZdBKtdzTF
         k6PIus96O2FZTbrVH45m9t8odMlfEPRTL4bphk4IKEBy9GwK4CiUbwKDaS/RpHDZlLyg
         1+Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780158483; x=1780763283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KFwbDhRstQgRlULxxXcLO373bDVUhgaVz97DA9wG8Y=;
        b=hYXSSwOV/7727X1t8acar04oOHYVTATl2pFS4E1Ggvv1UYrDGSUfJB4S02dSDwYRtg
         iB2FeKABveVPUmC6MCAfLLfQHZs0jCckn8Y+3ZysAI5nm4uDpr+xrq5nI3wPd4DqRqTG
         1+4lC32K/hw3DOg80BKbylA6SEzQ9g7kbZoyz3xsZF4IFJLUyuot41TeYGzwUMZrSIVR
         2o0JXskHefVozdZheB7hpwr6jQLxp+lb52uaRvFgYq3ta3af2+ZukPpND+xprxhG0OO8
         MQ3pfAVGZiBaFKwsZSPxdNfHi8/xUU9v279vw1iKOtSjG27fNno78Sm4TK+XHq04zo1r
         LQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780158483; x=1780763283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9KFwbDhRstQgRlULxxXcLO373bDVUhgaVz97DA9wG8Y=;
        b=EJVb/pPDPzkpr/e/E7OqvhYntLkCmUsQYdkfF7fX7rR3QnxXV2TJfb6STfNjKSBwKl
         sXZ0RzZInuBg8ZiTZIuQnc1w8rcUgNpBUosu1yvxm6Jb/GWYAH+NG60WBChZK6NXdWay
         79kHAvCclovsYxto5i5Wq59VR/km4SGUdjos65JDDLk2o+1MoW3ke3ZVvOTTBXIPq9pU
         m7sk9dI5D9AZF2KoUKV8J4tVkPI9V1495b8DWGRNjWj1CZd9HivBzmyxU+wclT3heWtF
         uXUmNxx3MQcL9JFKFTeSjAs9KrhorBm+x2nbgkSNV+sBsxbs04sV98KUcgBtPzV930SU
         R4Sg==
X-Forwarded-Encrypted: i=1; AFNElJ9vbeai6qd02OHw58qL4P+bj87JUeQztDh7k6CBjbwqq0jW2D27Z6tmqhbB+yMuH2XnHnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0uhysLco51P7GTx7Cu96CiPVqpWM4K9rU8ETA7Z6wilVmymne
	5ydWOS9YY7+kgTBellFyncnqmoLAt+pRfKwtadXRlGDnRNH6LWee5Tb6ylH2JArxQcJzsAM5//u
	aiewKFlb9gPxrqryIUo7Pm6q6RULcX4LagjKB1tXX0xxly0EgHEO35THFaz2hcR2+2QS0jCba45
	GdSV0zAmt+u7l+B1N0mUpt/XC18gpp
X-Gm-Gg: Acq92OEx9RhPHHDwjrqZoYUuX8yusNSFVjiA3nU2/k6uvb/2bCeD/zWmPFw+AT/jniV
	UTLcifTH/wB34jNO1vDg5WEC7d7lBBzXcf/HNjIT8onnhPmFUcFNWKw8IQ8MVNLMfpoHI2DkSHH
	DCXSBrFJP6rq6Yy7bNp9dRfq3UEg0uzqybjN22itmrNeCZ3eHpn27nvNyt79mQi0n1Q5n2kjfcX
	1HP1y6nio0XF1PgEBNnNGnptf+anZVTP3hjODslNtsFPuxe5hfmUFr7/KkdfDLK7QOuZ4vazUpL
	8D9hTJIDhBMNzL0MWw==
X-Received: by 2002:a05:600c:34cf:b0:490:6869:46d2 with SMTP id 5b1f17b1804b1-490a28d3b0fmr78478095e9.0.1780158483211;
        Sat, 30 May 2026 09:28:03 -0700 (PDT)
X-Received: by 2002:a05:600c:34cf:b0:490:6869:46d2 with SMTP id
 5b1f17b1804b1-490a28d3b0fmr78477725e9.0.1780158482840; Sat, 30 May 2026
 09:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529183549.1104619-1-pbonzini@redhat.com>
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 May 2026 18:27:50 +0200
X-Gm-Features: AVHnY4Krb2u0hvsXK0lpaGWJgofc3upZvR1fOfgnSVOTjwwirA6obDCZKPlGZIA
Message-ID: <CABgObfY8_vam2OfhPRrCx79ApK9er0SWVsToC0vLjHQNdmzQ_w@mail.gmail.com>
Subject: Re: [PATCH 00/24] KVM: x86: fix various GHCB issues
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: seanjc@google.com, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think patches 11-13 should also be included in 7.1.  Any other opinions?

Paolo

On Fri, May 29, 2026 at 8:35=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The PSC code has a variety of bugs, several of which have to do with
> not following the spec.  It took a while to disentagle and root cause
> everything (the GHCB ain't exactly the easiest spec to decipher), but
> here it is.  The first 10 patches have just been sent to Linus.
>
> For the rest we decided to handle it on-list for 7.2, but it is possible
> that a clever guest could abuse the bugs to cause the host to leak a
> pile of pages (limited by how fast the VM can get recreated).
>
> This can also be found in a sev-for-7.2 branch of kvm.git
>
> Thanks,
>
> Paolo, Sean, Mike, Tom
>
> Michael Roth (1):
>   KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use
>
> Sean Christopherson (23):
>   KVM: SEV: Ignore MMIO requests of length '0'
>   KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
>   KVM: SEV: Ignore Port I/O requests of length '0'
>   KVM: SEV: Use the size of the PSC header as the minimum size for PSC
>     requests
>   KVM: SEV: Compute the correct max length of the in-GHCB scratch area
>   KVM: SEV: WARN if KVM attempts to setup scratch area with min_len=3D=3D=
0
>   KVM: SEV: Don't explicitly pass PSC buffer to snp_begin_psc()
>   KVM: SEV: Check PSC request indices against the actual size of the
>     buffer
>   KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer
>   KVM: SEV: Make it more obvious when KVM is writing back the current
>     PSC index
>   KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata
>   KVM: SEV: Read start/end indices of PSC requests exactly once per
>     #VMGEXIT
>   KVM: Don't WARN if memory is dirtied without a vCPU when the VM is
>     dying
>   KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
>   KVM: SEV: Decouple the need to sync the GHCB SA from the need to free
>     the SA
>   KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free
>   KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a registered
>     GHCB
>   KVM: SEV: Move GHCB "usage" check out of sev_es_validate_vmgexit()
>   KVM: SEV: Return INVALID_EVENT for SNP-only #VMGEXIT from non-SNP
>     guest
>   KVM: SEV: Return INVALID_INPUT, not MISSING_INPUT, for bad
>     GUEST_REQUEST input(s)
>   KVM: SEV: Handle unknown #VMGEXIT reasons in sev_handle_vmgexit()
>   KVM: SEV: Turn sev_es_validate_vmgexit() into a dedicated predicate
>   KVM: SEV: Remove sometimes-used function-scoped "ret" from #VMGEXIT
>     handler
>
>  arch/x86/kvm/svm/sev.c | 554 ++++++++++++++++++++++-------------------
>  arch/x86/kvm/svm/svm.h |   9 +-
>  virt/kvm/kvm_main.c    |   3 +-
>  3 files changed, 302 insertions(+), 264 deletions(-)
>
> --
> 2.54.0

