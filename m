Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0B3644A2
	for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996790; cv=none; b=pqWk38w3e1LkJKNy9/l9uVQk5EEhPihvT3Esm8kQIlG2DtgUQLcA9QCgn3VChVPN8Mf4WpUDTHfpjLG02/CNE1upMCH4HRDPckEfhV7V2/5RHXDpGkJUR+5psAMgthsRfNzC4fmizq5nN7Xs+ainuNTFBeppABx8fLXRmCMcL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996790; c=relaxed/simple;
	bh=87Bmg0bsgTHErqF94egtYjinKP/VBL0B4ChUpbtAQYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF70krrCffmx9E0w3jLLy4/MRXp/Qhkl+p92Lh19cpzK+Nf1lWeRXDPABrZjCbaYWCxa20kkTRofwNCgDL0al/F2dWXpf+CxTz2EALd+ZAtZSTFPHUbJsCfA6U6XaauxHN5r4pak7B5thVgFJqOvvhp1EVLYk13m3dAcVyws47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xanud9XO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xanud9XO"
Date: Fri, 13 Feb 2026 15:32:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770996784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tKIFwnbhpfJvjUHjpVvdck30pJDlJLYora8lqwV6g70=;
	b=xanud9XOtzROFRSQ0I+UZrkia5ilU3IWFmfHzsMkz/bPMRcUhEKzMjFb7UaytHanIiVkOf
	t6uLP6hXPbRtYyb8XlGl5Ro9ZBZkx+9iTfBr6zo+Es8zwZ2ju541b6atU8ne0V4HjkWcQ+
	2+M5GnWIoBvJ/gz0/jLK04xgYjXe/hs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/8] KVM: x86: nSVM: Clear VMCB_NPT clean bit when
 updating hPAT from guest mode
Message-ID: <phcxxcpm2uum4pa4ny3icvy7u2d5kp4ctey6mff36xnz4u3hzz@oyjzgp2eobry>
References: <20260212155905.3448571-1-jmattson@google.com>
 <20260212155905.3448571-2-jmattson@google.com>
 <f72gve6ia3aqcpkqxzuwnleaxzxmesapzmoaus6bwaibsq5f2g@hgq4z5mqxykh>
 <aY9CqmlpZb2Unh0y@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY9CqmlpZb2Unh0y@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 13, 2026 at 07:26:34AM -0800, Sean Christopherson wrote:
> On Fri, Feb 13, 2026, Yosry Ahmed wrote:
> > On Thu, Feb 12, 2026 at 07:58:49AM -0800, Jim Mattson wrote:
> > > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > > index 0bb93879abfe..9850ed01e16e 100644
> > > --- a/arch/x86/kvm/svm/svm.h
> > > +++ b/arch/x86/kvm/svm/svm.h
> > > @@ -434,14 +434,15 @@ static inline void vmcb_mark_dirty(struct vmcb *vmcb, int bit)
> > >  	vmcb->control.clean &= ~(1 << bit);
> > >  }
> > >  
> > > -static inline bool vmcb_is_dirty(struct vmcb *vmcb, int bit)
> > 
> > Huh, I assume the removed of vmcb_is_dirty() was not intentional?
> 
> Regardless of whether or not it was intentional, IMO it's a good change.  KVM
> should never check vmcb12 directly, and I can't think of a legitimate case where
> KVM should condition its behavior on vmcb0{1,2} being clean/dirty.

Funny enough, I removed all usages of vmcb_is_dirty() in my series, I
just didn't drop it:

https://lore.kernel.org/kvm/20260206190851.860662-24-yosry.ahmed@linux.dev/

So Jim was cleaning up after me :)

> 
> Unless a v5 is needed, I'll split it to a separate patch when applying.
