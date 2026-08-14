Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543648F824
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786726647; cv=none; b=ZTseSpx5fEVXpbbEbNSYZU585uPFlEBerr+pwsUM+1ijR9mK8BCRW1PuHC8H5pd/d5f7mVw1c44v2ic0JciwJc0l7u/ctCr70Cj/eNbkzcC0/7DekEjrUY2aSnsVQsQ/mDfr+haTjT4acITOWW3JxQE8gzGtVt5XkExB7/OfP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786726647; c=relaxed/simple;
	bh=P6TsHROzGFuvuQhbbFjiY+3j2uy9Mvh2w6OicTyhP+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ssdCxJrlaqFMi3NpMw/w2pjJfJiteyDTIGyREMTxeiYrSLOtlrbiTNLuaa3qI5JttaMrQ88gVd0tt+SM7HqpcyjahKkoLeI302cFn1JWxTwY6R8GFWLfa+0uOGy7ArepnGmvprO0dP4F6s9C1sslVxDIsT5xihhpbLnRAoeX74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJIfzpYP; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJIfzpYP"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1397761a91.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786726645; x=1787331445; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2uuaYXrIG65WiBuHQ7NDeP7zvEjj+v6bDkDWDXYLIs=;
        b=AJIfzpYP7ZOCo0Y0NYaXmZzmOg1LUTSoNOlQ5e9z/q5JgcRbE+1QijDFzAvNPwrFsO
         3ZoQPn354oZU0XPq4sdIq4X8cdL4iYMoROGXUjrIdUSm8XNucEp+ii/cT4bYn3JgUEGo
         j+giJo1V4bYIPEkzkvB7M13JnQdn2FvYJ+pUIFiQ1fkThcUFlR+qIhGzHuWYW3hc1FSU
         cICp59phLHLHbBhh7dpHFT1durglijsi1PnMvB1MoXhYEIwBAqGyrJNSxIe7966KB+Z8
         ZnwVubVq0Qp7bE4RN18/2g49B4/yPX+7x337Ob39qwQVTKRxAHPeUCTFcBNfuX0ng5lX
         0hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786726645; x=1787331445;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2uuaYXrIG65WiBuHQ7NDeP7zvEjj+v6bDkDWDXYLIs=;
        b=h0p/AlEIEBeyBFj+f4Gve6Fh3m8L/Bzc7QgmgQ+Q1kgznpcGeezFu3D9WgVzSA4S6z
         cZRfamwupv+OUzhgrwbRJ0bVn9LJ1fweauZprMKJEHbEnn3rPAUobZj8myvhkWqLznpH
         AQQbc3p1lR1DZLGdbW0T3iHzZ2v6iWOYVG8pkjPll56FEZZYm4bwp3aawZD+M+B5Is2f
         Hz/+UfUAtuLql+9kPjqozjmjWhRYG04MH1+AXCbUcnWsO4OXSZK4c+U5ccN+5TFqhgr3
         DFnMZYYz843Za6SozTQ/H1GjdR2e7tP1fCUVLsF14y106E22BfrzO4opKgFb/4rMEq2T
         uH0A==
X-Forwarded-Encrypted: i=1; AHgh+RpkA5dCE70GcjbNaCYG942biKQyVfh3MRnNE5futwTr2rLfkT0n8fHVK/Iw5CHtnP2hI7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAERyfmy7tK1dM+eNrPc3az6/A9uU6V02v4AWhAxP0vwK+p3YJ
	iC8Ev02Ekc+vgT5vE6Ic6XjH4hezoLPxiNfTzhE1CxVPl0BDT5ou2BSgDHZ9+DzGFzlAj4CXfNx
	/NcqINg==
X-Received: from pgmu38.prod.google.com ([2002:a63:2366:0:b0:c99:90dc:7b3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6708:b0:3b4:6026:6c5d
 with SMTP id adf61e73a8af0-3cc7196e726mr8567420637.5.1786726645347; Fri, 14
 Aug 2026 09:57:25 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:57:24 -0700
In-Reply-To: <4f58be1f-74de-411b-9aac-896ad7af57ee@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com> <aauJ80pZrw_SfF31@google.com>
 <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com> <an0BbcxUNRKqnUSJ@google.com>
 <fede3476-5c56-4cee-b0a9-2e89e5a334ae@amd.com> <an5XdrvIoMKreMLp@google.com> <4f58be1f-74de-411b-9aac-896ad7af57ee@amd.com>
Message-ID: <an9I9Lhw4zoDFQWE@google.com>
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: Shivansh Dhiman <shivansh.dhiman@amd.com>, pbonzini@redhat.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, xin@zytor.com, nikunj.dadhania@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Nikunj A. Dadhania wrote:
> 
> 
> On 8/14/2026 5:17 AM, Sean Christopherson wrote:
> > On Thu, Aug 13, 2026, Nikunj A. Dadhania wrote:
> >> On 8/13/2026 4:57 AM, Sean Christopherson wrote:
> >>> On Mon, Aug 10, 2026, Shivansh Dhiman wrote:
> >>>> Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
> >>>> while setting intercepts? Or is there a better way to deal with this?
> >>>
> >>> Take a hard dependency on an upcoming APM update that states the control area
> >>> is valid after shutdown, and rework KVM to not clobber control fields on shutdown
> >>> interception.
> >>
> >> AMD APM 3.45 [1] is now publicly available and has the updated wording:
> >>
> >>     "After an intercepted shutdown, the VMCB control area is valid (with
> >>      the exception of offsets 60h, 61h, and 68h) and the VMCB state save
> >>      area is undefined."
> > 
> > Very tangential side topic: are combined versions (all five volumes in one PDF)
> > of the APM available?  	Having to open five different PDFs to find information
> > is a pain in the rear, especially since I can never remember what's in which
> > volume.  I can manually splice the PDFs together, but that's far from ideal.
> 
> Yes, combined version (Vol 1-5) is available here:
> 
>   https://docs.amd.com/v/u/en-US/40332_4.10_APM_Vol1-5

Awesome, thanks!
