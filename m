Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB36413D87
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694885; cv=none; b=Mp5AJlIScmDFDsXD/i+8Hvuwbg8nVuEsbhUWTnGGkH4mFIryutZ9I9/URfe030t4+p9Purghl7Y9zEpu553+GKTW5e3wJ7C6aFYAe/+Nk/vc+2r2rlL+KXrxg6ebGV1zvpZyaDaDFyWGka/Cch2C7PB1H573mWnBH2LKTU4/r0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694885; c=relaxed/simple;
	bh=9/BUljy6TNRY9n09ZmVql69eTpV3ZFcHR2xOX8xQaBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GSrLB/Orv47mXG6i0ltuUngiUEf2HyiVeSXLTSBPLUvBtXHKp41I/jINS34xU6NoRcynLog7nu8s9ilww3Iwzvi1PwKndem9zdw6siSelKKqRWEN0yXRrcRvFxpOrXYv2+VdklFsAeGoL6/w0vd3szzYUtEAcoZsAijJCiyoo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovCh2KPn; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovCh2KPn"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1653956a12.0
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783694884; x=1784299684; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMyY/scxQTo0tXtbyEdWPI4W0NbSwCug6oGYu+Luc9M=;
        b=ovCh2KPndgoRd6q1k5thvXwHVVvWo9yGJR4Xt+guCSgYoC8Kz36fHaNl6V7Y0rTxm2
         FGgLJcnRW482X/0owfXQJWGbP2SzBwUt9d/AQ9CaB2pTzMNVX89tz7Q8+1GOsYlN80uk
         TPyFye+44xmNC/6Bn+eSPttnNWajp+tmEcKosH2GcCWmvUbfvUKU71MnSOYtuQkzDc/h
         TBsOe7adZvif/p6L/xfFsGLU5P/FmOmhW80WmdGeKZ7hg3iPPp5ko6lYqM66dELfaZ6I
         l2Wf1YYvig0c06lZhx8ld2o9c8IYj9B3/muwLTKk2Ygd/qMnZ1GAqw0WGXC96tc/+qM1
         aQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783694884; x=1784299684;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BMyY/scxQTo0tXtbyEdWPI4W0NbSwCug6oGYu+Luc9M=;
        b=hNC7jwTTDs2mtJQSYGYJd6ftKXlfdKBLbaa+l97jwoYqZ/buhkhrlH/9yckGdBcBfK
         RzlbDJfoL96pkZ6tGWPnwxZfTuU5YBgxdhJWtIk1INnm1Prb+V8CC6aWNB5z11+VSMvn
         5/xcIZfxe8TnQDbu59wNzgVrsCen9PKQOMbcZ/b+k5gFXkmW04iAYcfVPb+xcYYWQvp3
         m3JDDPFUMfvKhTyZS7OtBmBIw5PJ5kKpJ8VJdLphAm4GZ7gtxxeQqVrfX5fY+42+jWQb
         qFS5vPChlBTXHLYNy1zh+9RmmRwjBx4SEw3DTq5F/5Xa0Ic5aTId7q3FH97Xompgj9AS
         yeWA==
X-Forwarded-Encrypted: i=1; AHgh+RpF77qx11WQbm6Nhfc9uC5wCPTnHZORRlyihRxFXC3/mWS/ynuy2Gz9amudbB5vjoAr5IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmjmMMC8TxSqn96ObTCJNYdQ07mlQr6uWA8A+cIxQ91N35rvj
	bbywIJqXHa10sUItejt0WEtZ1jakMlC43chGTsv2X6k58a6rBFRuj/RsgZthB6ke6QTcxEdZLL1
	aryTPWw==
X-Received: from pghi22.prod.google.com ([2002:a63:e916:0:b0:c99:7baf:126d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a2:b0:3bf:a0e5:99a5
 with SMTP id adf61e73a8af0-3c0bcea2f0cmr16321169637.47.1783694883588; Fri, 10
 Jul 2026 07:48:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 07:48:02 -0700
In-Reply-To: <20260710125211.GB2816371@pedri>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com> <ak7DMwbF4viiVoO5@google.com>
 <20260710125211.GB2816371@pedri>
Message-ID: <alEGIrWhQvzf2wAV@google.com>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, djbw@kernel.org, 
	kas@kernel.org, rick.p.edgecombe@intel.com, yilun.xu@intel.com, 
	xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 10, 2026, Peter Fang wrote:
> On Wed, Jul 08, 2026 at 02:37:55PM -0700, Sean Christopherson wrote:
> > On Thu, Jun 18, 2026, Xu Yilun wrote:
> > And is keying off tdx_quote_enabled() and only tdx_quote_enabled() backwards
> > compatible?  How do we know that cutting userspace out of the loop wont' break
> > anything?
> 
> Yeah this needs explaining:
> 
> The guest-observable difference between the two paths is that it sees
> quotes in different formats (the TDX module uses newer formats of
> course). And an old guest must be able to continue using its
> TDVMCALL<GetQuote> interface for quotes. The guest sends the quote to an
> external verifier to authenticate itself. The verifier (part of the
> cloud infrastructure) must know how to parse this format. So in other
> words, it's the verifier that must maintain backward compatibility if it
> wants to continue accepting old quotes. And it needs to be updated to
> support newer formats as well.

Uh, no, that's not how KVM's guest/host ABI works.  Updating the host kernel and
breaking existing guest is not acceptable.

> > > +{
> > > +	gfn_t gfn_start, gfn_end;
> > > +	u64 end;
> > > +
> > > +	if (!size)
> > > +		return TDVMCALL_STATUS_INVALID_OPERAND;
> > > +
> > > +	if (!PAGE_ALIGNED(gpa) || !PAGE_ALIGNED(size))
> > > +		return TDVMCALL_STATUS_ALIGN_ERROR;
> > > +
> > > +	if (check_add_overflow(gpa, size, &end))
> > > +		return TDVMCALL_STATUS_INVALID_OPERAND;
> > > +
> > > +	gfn_start = gpa_to_gfn(gpa);
> > > +	gfn_end = gpa_to_gfn(end);
> > > +
> > > +	/*
> > > +	 * Reject if the guest didn't explicitly convert its quote pages to
> > > +	 * shared.
> > > +	 */
> > > +	if (!kvm_range_has_memory_attributes(vcpu->kvm, gfn_start, gfn_end,
> > > +					     KVM_MEMORY_ATTRIBUTE_PRIVATE, 0))
> > 
> > TOCTOU?
> 
> I struggled a bit with this actually... I can't just grab
> kvm->slots_lock here, and dropping kvm->srcu seems bad because the quote
> will be written to guest memory later. I settled on the idea that the
> guest should make sure these pages are converted to shared first. If it
> tries to convert them back to private after this check, before this
> TDVMCALL returns, then it's kind of a self-inflicted race and I don't
> see KVM doing any self damage in this case. Not sure if this makes sense
> to you? Or maybe I should just drop this check and go straight to
> kvm_vcpu_read_guest()?

Yes, drop it and rely on uaccess to do the right thing.
