Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21237DE84
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708525; cv=none; b=dJJSFTsOmIXHzjibuFMPH7BQ6+cXt/bdcjpVTGjRGtqAucICd4BAvVX7uv4aknRTG3XpkfejID3AxCtuVuuROilmLf2W/trG7TLmiJ+pOVqehj/JNr803c1bduj8yz5H+m8lIKhPBrELa1UP158GjDJA8ytpQwQkdBnRfWvce1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708525; c=relaxed/simple;
	bh=cVwSutYXyxu2kAs+M/fqvlMTLCP40ylY2LRCvNSraqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jriq2oYZaU8/Cb1gjTsVEWg6SjW0GHKs4edla1oK3t3RnkLtGify1Yn4zQAvv20KynmPdQPyDmxPxL++fzU1/FrfCBxdl9zSwLu/pMNasSmQLJizWre6xq0TKoWmEMWbRL3pdschM9zckZ/ojTLalm/CkLAIHMVXV43sqYV1JGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Av65lYSB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Av65lYSB"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8482b95574dso1307352b3a.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783708522; x=1784313322; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJss+Nyx//3KxfsXosZCusg05vSosR0BprDgk0IeJw4=;
        b=Av65lYSBQw5YZgD7X1tlREBGFmfcfSzmXSmXNbSipPRfOoVzgZ8tT4eWFNDfnEqZx8
         E2D4XIFP81YL+6HPZKfsCffX08KSk+8HukobTYCE7OB+3DssiT1gr/7BElI4WdiHoLpn
         EGhP9RMkupEUIMs6ahit/WOTxf5tVMTwv9Bx2/LOoMNLPSYwghJro5qYV59Yq6pqGDSc
         vX7Fm+Kb3YBIMVAnSqgNTrbC9bhKpTL3W95//vNw7ua3n8lcMT/bAFcg2qKdCnNXQNse
         J5bDcyrNuSVr6I6ytfPcHO2xUejCvn1yrrcdooNCZOdBkRLfbr5Lvrk1hhvFvOAU5pe6
         VtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783708522; x=1784313322;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJss+Nyx//3KxfsXosZCusg05vSosR0BprDgk0IeJw4=;
        b=QZkfVGmOSe6JcKntuQuNJRcBPmhNZX8dKFxdbXOTwhRR9cfGZ3Wy9kwtqUF0VGMjCD
         AD/GO0Uab2JnnQxmu4TJ8Zj9qrFEGIkP4HY9aPYKJirMuExy1+pK6rym3CE0BK01DIEs
         IsRpgDrmk6vNl+N9+sVbcjJB5hCk12vBdOQX25EWr9T+1CO+0OkuzbSwGBDUwWpoXa9j
         sFfD1VDrUJfcUMJx2PIP+tRg1bVBuiZDqbvM5Boucxgx9hvYPirMp31UaW8ho3HRY9Ta
         7JYaocxllWzttMYsoR++3BMTMGkvCELJXQKtVkQcd9a+AXLnRdceL/j+h9Wg7hH2sTEy
         5afw==
X-Forwarded-Encrypted: i=1; AHgh+RpSmObcxZzQDQTIDMg1kbLZ70IQ/uNjG5NfI+3yC5gTvhB2eWhgZZrFc97tFDWDb6zd3+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4yH7GNYon5mjEEivEhAkz4IxDy194BcEvOKjtx4/OFs6UQiT
	oew8C0kskTEW8CEBecx7bmIhhsp17szXLPWHoez+iGFAKd07pP+/C4O/hsKbVj4tef6kA0NIaaq
	SxPscJA==
X-Received: from pfdb8.prod.google.com ([2002:a05:6a00:94e8:b0:847:878f:44fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cd4:b0:847:712d:19ac
 with SMTP id d2e1a72fcca58-84889637560mr217734b3a.8.1783708522009; Fri, 10
 Jul 2026 11:35:22 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:35:21 -0700
In-Reply-To: <20260710135312.AD74F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710134055.16432-1-danielpaziyski@gmail.com> <20260710135312.AD74F1F000E9@smtp.kernel.org>
Message-ID: <alE7aTGmUIWKJf9a@google.com>
Subject: Re: [PATCH] KVM: x86: Fix null pointer dereference in trace_kvm_inj_exception
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 10, 2026, sashiko-bot@kernel.org wrote:
> > An empty struct is being passed, which makes the
> > kernel derefence a NULL pointer when the error code is 0. Remove this
> > stray struct in the invocation of __print_symbolic.
> 
> [Severity: Medium]
> Is this description of a null pointer dereference accurate?

Yes, it is.  Sashiko apparently applied to an old base (pre-7.1).  As of commit
754e38d2d1ae ("tracing: Use explicit array size instead of sentinel elements in
symbol printing") (spoiler alert), trace_print_symbols_seq() is:

	for (i = 0; i < symbol_array_size; i++) {

		if (val != symbol_array[i].mask)
			continue;

		trace_seq_puts(p, symbol_array[i].name);
		break;
	}

> Looking at how __print_symbolic expands, the empty struct { } safely
> initializes the first element's name pointer to NULL. When
> trace_print_symbols_seq() is called, it handles this gracefully:
> 
> kernel/trace/trace_output.c:trace_print_symbols_seq() {
>     ...
>     for (i = 0;  symbol_array[i].name; i++) {
>     ...
> }
> 
> Since the name field is NULL for the first element, the loop is bypassed
> entirely and the function safely falls back to printing the error code as a
> hex string without dereferencing a NULL pointer.
> 
> > diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> > --- a/arch/x86/kvm/trace.h
> > +++ b/arch/x86/kvm/trace.h
> > @@ -490,7 +490,7 @@ TRACE_EVENT(kvm_inj_exception,
> >  	TP_printk("%s%s%s%s%s",
> >  		  __print_symbolic(__entry->exception, kvm_trace_sym_exc),
> >  		  !__entry->has_error ? "" : " (",
> > -		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code, { }),
> > +		  !__entry->has_error ? "" : __print_symbolic(__entry->error_code),
> 
> [Severity: Low]
> Will this change break the kernel build?

No, beacuse again, Sashiko applied to an old base for some reason.
