Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC92E11A6
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330837; cv=none; b=lnzH7NHOtiuz8btJIDCaelK2icmnhoa9L+kBYkb6ANsRtkaYwpW/DOVIxfbxR/LCvONoIBrgi1kpufehf+hvEa0rKpJ5VffSyv48baUf4x82r3h2C4GsM0a+XCe/5mwfThW6Z5LGyfP+boahdM7vJi0wW6GuYWr5SIVDIbrOGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330837; c=relaxed/simple;
	bh=+6fDoFCLgMnhc6zDBiLDHez2SDYFtd6gXfTre2bo5bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b4+0kaLfq8BaQk0QrQAfCo/oxMJ/0SFTok26o98F3Gkd/y4EfFrH4cIo/Y55i1LbNT9PsqSIYlibc1evg2rCU7IbBGcvO8qrQ5zjc+IsiAWot7ynE9ceKo0vzxGy2vKzCrDpoNqLjYP8ILmA/BEdjP9kn7pG6NjVzc7ThWoNNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jY6rGpKf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jY6rGpKf"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8581f7723aso1525281a12.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780330834; x=1780935634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj0JbjSpVQ8PMU19bEVL9jVWMkxuYStreByX7gzfW/k=;
        b=jY6rGpKf+MENMaNdwW50esF2Vlbmz8kkymFQvfqkytuhCSX1yJ4SCPCbAQ60Cu1MWs
         Uql0kKJn8me0ewxvYPmdWCZo7PQZ1q2nvj2MpPGihfmtpCwKmLGq6UDwdXS+2Uz3TJV5
         n5yeDOBHx37Vh4M3O8MC2fBSBaDzfxlZTMMUCQfiP/y81qfXS8nq7T6cBFYjq3uGBUqN
         i5ljBB56fmVWnPvbcvVTsKU1FWmQkIWEZ6VoTtV7husUZ+xzhRB6tWm4FfjI1TmFcIon
         PqpGiir08P2kJAFE4Bw1nJ/dLjeGX+zGG4Mek29JLN8bu9LbqKhI9jnlGgksOzJUCccP
         zFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780330834; x=1780935634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj0JbjSpVQ8PMU19bEVL9jVWMkxuYStreByX7gzfW/k=;
        b=EEBY7u1aIEzoisRyRPU2ybzp+q/vhZxnA4qelxK/nky74axrG4Y5D9jWDKH6GV9e5q
         ywZi/4vTRpL2X8xKMNZdFPBLgW9FWickPdOwP6Z0V2aIa/MF3xXv30iLjhO9dQi4vWsr
         +rkx2Du9B82tmd5tUAFsgWkDQ7sznhNRNmXoEHTn4Gd7Ks8YPHcKiW28f95GbtPGgqhS
         3HY5NVq+HOCdtJ5y5OX5yEX3eSIA7VfUpJzzYVpZ09BWvqhwffZkX1Jd1jBwN1OSTa23
         tRwe/JbXllpmzm83bGBBJtsyAr3yTwXw23pl7Z9e2Hksp02ZFJS8caNIIm7SlEwfC9HR
         a9KQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/UPr66XSUOAmTG94QL2BtNcxVDJEOzbS5/Suzva1P7zxUiVdm2Vn3w8ekKeNtKfz/e5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3h2Wx1Q7RvqNLCi0XFunWZC1dEeaoYbU67igwl0nAOnU4tWP
	9ieiAWhKQ3aku4NagwOptY+ZsWxzl8CS2mvS7O+UnkrrknSdzJomwjO8/WPSGF9TliXk2BoJrC2
	FDlhDBA==
X-Received: from plth11.prod.google.com ([2002:a17:902:704b:b0:2b6:417:db8d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4ce:b0:2bd:606d:b339
 with SMTP id d9443c01a7336-2bf3682c1afmr144415775ad.21.1780330833751; Mon, 01
 Jun 2026 09:20:33 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:20:33 -0700
In-Reply-To: <20260529232114.F1D7A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529183549.1104619-12-pbonzini@redhat.com> <20260529232114.F1D7A1F00893@smtp.kernel.org>
Message-ID: <ah2xUUtva9bYaYyG@google.com>
Subject: Re: [PATCH 11/24] KVM: SEV: Make it more obvious when KVM is writing
 back the current PSC index
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -3947,7 +3947,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
> >  	}
> >  
> >  	/* Find the start of the next range which needs processing. */
> > -	for (idx = idx_start; idx <= idx_end; idx++, hdr->cur_entry++) {
> > +	for (idx = idx_start; idx <= idx_end; idx++) {
> >  		entry_start = READ_ONCE(entries[idx]);
> >  
> [ ... ]
> > @@ -3974,6 +3974,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
> >  
> >  		if (npages)
> >  			break;
> > +
> > +		/*
> > +		 * Increment the guest-visible index to communicate the current
> > +		 * entry back to the guest, e.g. in case of failure.  No need
> > +		 * for READ_ONCE() as KVM doesn't consume the field, i.e. a
> > +		 * misbehaving guest can only break itself.
> > +		 */
> > +		hdr->cur_entry++;
> >  	}
> >  
> >  	if (idx > idx_end) {
> 
> [Severity: High]
> This is a pre-existing issue, but since we're examining how a misbehaving 
> guest affects the PSC processing loop, is it possible for a guest to trigger 
> a soft lockup here?
> 
> Looking at snp_begin_psc(), if the guest submits an unsupported PSC operation,
> we hit the default case and loop back:
> 
> next_range:
>     idx_start = READ_ONCE(hdr->cur_entry);
>     ...
>     switch (entry_start.operation) {
>     ...
>     default:
>         __snp_complete_one_psc(svm);
>         goto next_range;
>     }
> 
> If a malicious guest concurrently resets hdr->cur_entry back to 0 in the
> GHCB shared memory, could the host get trapped continuously reading an
> index of 0 and re-processing the same unsupported entry? 

Already fixed in patch 16, "KVM: SEV: Read start/end indices of PSC requests
exactly once per #VMGEXIT".
