Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1915B998
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779844; cv=none; b=N5GrXFGgqfWv2Jz6Y70/dL5+9HK8f1C/xjTsz8SNTYGci60v/D8jvGe+S36R9PPJf4L7QmrYI4ZBR/0ZDOFsALk2hdU2GISvKG79gaM8+5mVFaeTGDHYx+V2RsmAZOnCN3YZPDAoEFxWpLOdBRVEyinTthxzkh4YotaueV+vDNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779844; c=relaxed/simple;
	bh=dGW4RFk+phOZLtM3wOZBLttvDNqv+AwSk9KuOQKGHa0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eIPwUzwZysmR6X5jFBesZW3RCRqj7xm9GjQ3IgNN8LSPtaqcE4DPniJFucERT9p+5f/FV9lXxsK/zUwWoa4c8F7lpXAhWBaMRXlCNufpMuXHtUCDTC9JpuvoqxgJSEnM9Raq0fpARvldmX99YWGI1e8YjTm2FIkJUiSzrZCD9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryDEglHI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryDEglHI"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8969083f23so2104683a12.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 17:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782779842; x=1783384642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKV7MubbT236XgrwpvmR2un3HfsGFp5e/uG2tY2I0c4=;
        b=ryDEglHI9LF+P/IRZaDnHV/jvGBE4T7M4omYEuXl9R49WuJdWgKWK5+b35kAa8E91s
         gK9nPdU0SjNsQiE8FEWAUT43y4fNAzFq0OBYey/qv8o+CJTYTZfOEh6IZ6pMTbPbzcnw
         LFFUn9mPD/+PhjpE6TyZpAWI74V9aIAUWvSmekxR39U9yluaHZoFMSZFMpFa4qjxFADh
         sxoOL8Q4NhC/H4FMP06UPi+tOMji53JDFsMlcGYnAWcNGIyAmYe3tw+e/Fcl/Tz4dU+U
         8CMQkDa763Cj10EfA6AIBLALCQPhPtcI9jFbELXnnIQp082S3bkwltFlyp/orMyi1Hsq
         3xrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782779842; x=1783384642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKV7MubbT236XgrwpvmR2un3HfsGFp5e/uG2tY2I0c4=;
        b=HVxJfsrMJoeEKLzPOFHTRNYCP253tSjzT/JVivrdIpzHvYjh7v5dzQwlFnonhO8TNm
         VHkqfhdR/6rJhp7dWZKt2wXx09sm+3eq79IC7iOD9AyEm4P4KM4BNFiC2Pvbdib9ZL8D
         kVG0/5JGfjSg7L8PIBIYAWSVLFhcZ9Lrnsq0EBgAJnPXom5V0/2rMDGGLf8LDn5PAh61
         EvhnrVi+YsmEoMpfdUYPX48Vo6acC0OimkoBvHvFsSFZ3iRdgaALB4J/iUdejARS9son
         qa6pqP56ZDk0+1MAB17HTlteGPkdSvtcULty+PSXm2CQnk+MorA83vL/xjeaeGv5ukdF
         j3ug==
X-Gm-Message-State: AOJu0Yz1DL0ta4WlZziPOOychYInVFJSrnt6CN251ju4EoI9kiSDz6Ka
	sopWGqbeH8GftUcX7u77CFlABfGqFnaGBpPENZ4Rp+YjWzqMicG529Rw6D5Dvuy90DDso4YPAz6
	j0tlygg==
X-Received: from pfbfc21.prod.google.com ([2002:a05:6a00:2e15:b0:847:8c62:85d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a27:b0:847:80c8:dfdb
 with SMTP id d2e1a72fcca58-8479f4482a5mr1155351b3a.55.1782779841830; Mon, 29
 Jun 2026 17:37:21 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:37:21 -0700
In-Reply-To: <e6515066-3768-459d-8ae4-82c0243556a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
 <20260604023314.3907511-2-binbin.wu@linux.intel.com> <aj1fi_0SBxMK5WOB@google.com>
 <e6515066-3768-459d-8ae4-82c0243556a1@linux.intel.com>
Message-ID: <akMPwaQ9nFDnGbYg@google.com>
Subject: Re: [RFC PATCH v2 1/4] KVM: x86: TDX: Track supported configurable
 CPUID bits
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Binbin Wu wrote:
> On 6/26/2026 1:04 AM, Sean Christopherson wrote:
> > On Thu, Jun 04, 2026, Binbin Wu wrote:
> > CPUID.0x1E is a bit different because it's kinda sorta a feature?  That one is
> > probably worth restricting, but again that's easy to do in a case-statement.
> 
> Only CPUID.0x1E.EAX has TDX directly configurable bits currently, no special
> handling needed for the rest of CPUID.0x1E.

But isn't the whole point to guard against TDX Modules gaining support for features
KVM doesn't know about?  What happens if hardware extends into CPUID.0x1E.ECX,
and the TDX Module follows suit?

I guess that applies to all the feature leaves?
