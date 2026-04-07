Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B833C192
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584374; cv=none; b=rPtZTp/hJUH9zZ6tBm6aD7DpTWfJO5JSwJNNISBqV+6yGcAr4UZKsUIl71+cj9MFN4DKw38MG2mBT1JzWjyN7Zjwufm3x/0xBvMsWzF56JYShYXxNRALDmlW8wYzg19Vj+1KHypOH17gA/Om4MP6njlEmn7uPI0c9+EAB2gmRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584374; c=relaxed/simple;
	bh=SFi+MQ6VGcPjgdgikIOtIRVkkflB5tN7WyaTIpXX2RU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S39YTZJ6eMzqVJnEPr5ZPR4adkWGOohx57cRmU6yNX7wNb18Paxb8cLC29RP066fiZOzCqOhlWIsUFIyziPbvgfgwpf8nYvxDXTcyV02++HANGeoqWvvbFHaWacwlsqAuS2xD1PweKngLcOOyzrEKF3WAZUk+ERJuFzaTI/UD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4Bo4FbS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4Bo4FbS"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3594620fe97so12613546a91.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775584372; x=1776189172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/MSOJp/AJlf7hUTMD/NXnVkTNNfR/Z7vvW8KkUYbLI=;
        b=I4Bo4FbSttL88AXhPH6u8HhjhPmKz2qac1+xxSJ5a6EhZK2/KRxwsAWODPyfvzC+zh
         99PY4dstQUDSlp0grg7wPlSHeaKr0xKrod+cG9apSsloXe/5pa+eCV5fjbFVS4mBSlN1
         7W4FiU2RkK6wSIiglUblm+jk4/ICA0M+NMhxn33zNbBUst2g6O0naWMoQ5ztomj+NfLm
         sS2e0M+dZ5/E2nr0HOKH4gwBKlgAGgZiU2MHhXApuQbfC2RKO8bEO/ViGP4A4URyb+NO
         okmvk/Z6IdyLJFD9KsGr97DRYcZFbraPId+hxI9mdMX2NWMPEidcvLtS04fzliIMiQlV
         imfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584372; x=1776189172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/MSOJp/AJlf7hUTMD/NXnVkTNNfR/Z7vvW8KkUYbLI=;
        b=DnZ4Zarcy3+FPpJv6lYGnq0CoALkOGxhM6QImRgnllGUccfjJ0lftrqM8yhn9X6Nm8
         PSw3ApRRnjtoAcYI6mePGMzg1NF+D+bmNucY6i81LmjZSxZasabgBeoS80/ggyJ+5hdS
         33iYwOY0RsS6yIfDFfV7XBjVpS13fjoE3CB7ResOpOQDGzcEOM5Qt9HfRCYv5H0RhdHG
         DLFl+/KFzr3FCzqSoO0iP2v+IOTm6+YdW7sZWVXU8Lr4DJob/7d/olXcj2E6c6X7AMIX
         LXM6Qz+lz39Qczsvg3us+ru+tH19ClVKdONwAScUJcZ+6TBsxv9lSWsWZP9EW07E+E7B
         MycQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1p4POC7ov/WnI3Eh2korKgzqzczvayA58SGjFxOxkcguSGiVmOQl8R1by7Pgexz13vq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1Q5DPIByTimStOCxR4+AIS9w6GLH0jOQoehm521qpiGCMgw7
	CT79efi7eWIo7NftBWTHbiDfXafgSkT8E/gLLSslqAZHP7Nn3FEFsbLju1dQYeFFtFSlatboBNg
	I9f/u2w==
X-Received: from pjps16.prod.google.com ([2002:a17:90a:a110:b0:35d:94b3:bd6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2885:b0:35d:974d:8f7
 with SMTP id 98e67ed59e1d1-35de679c8ecmr16179304a91.1.1775584372473; Tue, 07
 Apr 2026 10:52:52 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:52:51 -0700
In-Reply-To: <2a216ee2-aebb-42ba-b2aa-826488448bbe@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
 <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local> <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
 <adBJTXeE6G2vQNKX@google.com> <2a216ee2-aebb-42ba-b2aa-826488448bbe@linux.alibaba.com>
Message-ID: <adVEc4zUVVxRiEJG@google.com>
Subject: Re: [PATCH 6/6] mm: change to return bool for the MMU notifier's
 young flag check
From: Sean Christopherson <seanjc@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, akpm@linux-foundation.org, david@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Baolin Wang wrote:
> On 4/4/26 7:12 AM, Sean Christopherson wrote:
> > On Fri, Mar 20, 2026, Baolin Wang wrote:
> > > > > -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
> > > > > -						unsigned long start,
> > > > > -						unsigned long end,
> > > > > -						gfn_handler_t handler,
> > > > > -						bool flush_on_ret)
> > > > > +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > > > > +					      unsigned long start,
> > > > > +					      unsigned long end,
> > > > > +					      gfn_handler_t handler,
> > > > > +					      bool flush_on_ret)
> > > > 
> > > > Can we please fix this terrrible indentation while we're here :)?
> > > > 
> > > > static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > > > 		unsigned long start, unsigned long end, gfn_handler_t handler,
> > > > 		bool flush_on_ret)
> > > > 
> > > > Would be nicer, thanks!
> > 
> > No, please keep this as-is.  KVM's preferred style is exactly this (and I personally
> > find mm's style much harder to parse).
> 
> Um, Andrew has already queued v2[1] into the mm-stable branch. Do you want
> me to send a follow-up patch to restore the original KVM coding style?

Nah, not worth the churn.  Thanks though!
