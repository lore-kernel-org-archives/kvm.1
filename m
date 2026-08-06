Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D383A7189
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024203; cv=none; b=bOT8QRPnsduCztlpTf69KdHzUoReefVgg2lEWy7OEhsL6mEmiH0yVxIe/TBoM2vXM1AzazZ6EmrLfKwqJdvWyvoXTVXZo7Rm4Eg/BhB5Id/MHIwrnmUuW8uKF9rPMEKs+arLRULXKptwAx0G/PYVp+2IcOTissHbdvFqn/dhQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024203; c=relaxed/simple;
	bh=HcX99Vmru2wvkma2CqrssqCH8aNGuIUa28xbRJ1pWpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N2wazsgjfQOEuvR5YpJC0SUxIpaUuUynEgDhx9iOWIcvAoGdsWEpC63fYTox4f3Ifx+uRlsLOIXWnYpmSZg/RksQIQgj+71ESTixdwwkDUnu8/jZJo93qmrWPWHB4q98mjSvVkIphU/ass9xINtUbPaMz0COebwdEfcDnk+lDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlN1d+hn; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlN1d+hn"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso2348114a91.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 06:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786024202; x=1786629002; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l6H3PlwGy5wcplG+ZQMBL2JSeCsm1wL8Fnu7CjOYnzs=;
        b=dlN1d+hn8IKORLf+K8o9jAtU30KHZ7Ti3di0OHFn0AjfVxj4eYl32gEa/e6zt7fCyJ
         sxVrBf/zrPVsiPYu2ZvNkXJs8KrG24Uqf5inJlhl7gr7FdIqGsn0PitQUd4eZbv6EwVz
         Y6Bk2tW485YY9hQQA9ysEu4Vzi2nYwHAH09frV4VV9/W8DQDTsvBqynxTkMQRwLu3vIr
         fISBe+7Qq0ZiBCGFUH78V9Y/NbUZovig1kMBqcEO6yR3viOOb9sYluU5NnvbDvo5ZlYO
         1StN05+p9VnLP3Zzd2nV25w8z5IRvXVxxvUaj30tLM3W3iVJhNnB9ZfQzU7xanvpu1NP
         XUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024202; x=1786629002;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6H3PlwGy5wcplG+ZQMBL2JSeCsm1wL8Fnu7CjOYnzs=;
        b=PH//4HHRyBLRgorBjhPp++lWb4Nl0+1WxshUMnUw1bbvibxPnLPz2Ad65ozQO9cjjM
         s40PPWw2eBk/spoymN27uR/Exvgyet0vai03+1tXiLKXcpwQcKjyZumep8cERj/2ypOr
         MWthSoqINsDkZEAMbkak8qWTJiexxq+H9ab3xUDw3VXXQSVSe3pUlqbxJWUpndsPVyLH
         b71lGlNSav6rkE60zEeLBhEdojsMDMKB8va34WxJBwVVBg3M+YxkA5ig02wLc3k/BeUL
         bD0TAXrAraSlK6PQSGgeAdj6HcN6Om59iOvXfGJPpEXx7P5XOKYgBbsrHp7X3cZ1uniA
         nr6g==
X-Forwarded-Encrypted: i=1; AHgh+Rrhq9h6Z08vUYpcqIis3UgF7a0yC0BArZRYkeiMvrgzVQbBPcQm87ErgAm9n4psBJUhBaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxorxJDQqhru3JIaf1mPGPKd/5BqVsRi/QmL1+qTq5dvwEqmYuZ
	wsdCPrB/03FqgcAKpH+VgC59/F2apo7jGTE9SkxloKRPpx4W2dJ+nNlTSCVnvzaSPC0+WYEZIKN
	I333+5A==
X-Received: from pjbgp15.prod.google.com ([2002:a17:90a:df0f:b0:36b:8abb:86c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52c6:b0:38e:75f3:ad4d
 with SMTP id 98e67ed59e1d1-3903c5381efmr14259219a91.7.1786024201470; Thu, 06
 Aug 2026 06:50:01 -0700 (PDT)
Date: Thu, 6 Aug 2026 06:50:00 -0700
In-Reply-To: <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com> <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com>
Message-ID: <anSRCBhWi2BK9kYB@google.com>
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
From: Sean Christopherson <seanjc@google.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"

+Chang

On Thu, Aug 06, 2026, Nikolay Borisov wrote:
> On 8/5/26 06:12, Xiaoyao Li wrote:
> > Enable Notify VM exit functionality for TDX guests.
> > 
> > Notify VM exit is an existing feature supported by KVM. Userspace can
> > enable Notify VM exit through KVM_CAP_X86_NOTIFY_VMEXIT when it's
> > reported as supported. However, KVM reports the support of this CAP just
> > based on the hardware capability but doesn't differentiate between VMX
> > and TDX. This leads to the issue that userspace can enable this cap for
> > TDX guests without getting an error, but the feature is not actually
> > enabled because KVM doesn't call the TDX module API to program the
> > relevant TD VMCS fields.
> > 
> > Enable Notify VM exit for TDX guests by:
> > 
> >    - Invoking TDX module API calls to set NOTIFY_VM_EXITING and Notify
> >      Window in TD VMCS. It's done in tdx_vcpu_init() where other TD VMCS
> >      bits are set. Since TDX vCPU cannot be reset, it only needs to be
> >      configured once when initializing the TDX vCPU.
> > 
> >    - Adding corresponding exit handler for TDX Notify VM Exit.
> 
> 
> nit: That feature is completely misnamed in the kernel.

Well that's bloody annoying.  The feature was called "NOTIFY VM EXIT" in the
December 2022 version of the ISE, but indeed is called Instruction Timeout in
the March 2023 versio of the SDM.  Intel isn't exactly building a stellar track
record with ISE publications...

Chang, please forward this to the right people as well.  Changing the name of a
feature isn't the end of the world, but things like this add friction and make
it quite clear that ISEs are very much "pre-production" drafts.  Which is totally
fine, and there is most definitely value in publishing early drafts of features,
but it means I'm going to be very hesitant to merge features in advance of them
being formally defined in the SDM.

> It should be instruction timeout (as is in the SDM). Please reword the
> changelog to refer to the name of the features as they are in the SDM. I.e if
> you search for NOTIFY_VMEXIT or NOTIFY_WINDOW absolutely nothing can be found
> in the SDM.  The changelog should ideally mention both - SDM's nomenclature
> and linux's nomenclature.

No, let's change Linux's nomenclature before merging this, "Notify" was always
vague and confusing.  It's unfortunate that we let that bleed into uAPI headers,
but we can simply #define aliases (or just force userspace to update as well, if
they use kernel headers directly).
