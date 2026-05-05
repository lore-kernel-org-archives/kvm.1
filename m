Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228537FF74
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978438; cv=none; b=h0gq3IIEAjDguZUMp3BfNMdzHjr9dqaIl8wZDnX6HIYNc3Egeid3eYBy/AxaBd9yfGgMZN0Q9LuYB4SsH60IwhkVw23h+s1tsTO+OVp5kmTXKGp3tIXNwv1JG0TbrdFt9cNJGgoqZfHS1wTz+C9m8V6froMuh3eoUq3OOQqeZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978438; c=relaxed/simple;
	bh=mKqYXpoMibXKWMHqXRjMGlmfeIz0K9ftytjedTgcHyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ/Gh05TuhoKdqEITkyWIgLNQ8D1PFn5hi8wopsLPJB2g/tf9/F6UZI4iYCgfqPgM3N70jew6rQZ9fhE3hWPT1XY7kZC0M7Lpn5M45PbcSAiy9ry54GT5wDVp1udsIPRCEx3NZBR62+7rSDfrOtjmYvxeD0GKWlccSndlE9lHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cag6iJOw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rf8R0xy7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cag6iJOw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf8R0xy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777978435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3FmP3zW5HjR4LD69Qb9J653nFGosEj+blpNSHoNL6Q=;
	b=Cag6iJOw3D8V8ulGrvkyTbWU+TApvyzKubAkjMHeumfVHw6T8ageA6S7MBrp+MuebDofJ6
	Cosg1EhYXQUW3mZ0EfRpzf7I0ZvWBc1o9RwAG4V8bmXM4rFFTILjLMHgnN64fVHvKpEHZK
	SkwRfJP6d4n/jfqxOf6VvPjfIRO3YXA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Ni2x0XGkOLqIlffntczkPA-1; Tue, 05 May 2026 06:53:53 -0400
X-MC-Unique: Ni2x0XGkOLqIlffntczkPA-1
X-Mimecast-MFC-AGG-ID: Ni2x0XGkOLqIlffntczkPA_1777978432
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso460383f8f.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777978432; x=1778583232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O3FmP3zW5HjR4LD69Qb9J653nFGosEj+blpNSHoNL6Q=;
        b=Rf8R0xy7LLsF1dR+es2en1LIIbB8alWFKrKqFndL95IrIOn/XHA7lERSuhBjnEQrXW
         DKlVtfcZt2aSP+/PDrSXeHB4r7euuP4SSzze6MpMfEiXuE/isepWXEsxMw55C0TzYWkT
         WoSprjOpQOX9bOerHw3AIvHvoo2KmX7cwdYQccG7eqBi/46YqcRDEkXJB7F/Fk0L3rHX
         NQGnA+lgTMe9EcRJQhwI/4XkBc7bREgT1ktTlglrMOk62MMUwkwCBQ0X7cqqWMfdnLEZ
         3FUBfeXeB3J7mOpDONcprRQQuZQc6+Q1qoIgSObEXYe+BBdwC69L17ErrPWt2ZXpMaQ6
         RhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777978432; x=1778583232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3FmP3zW5HjR4LD69Qb9J653nFGosEj+blpNSHoNL6Q=;
        b=ONL5ZflG5Jt0ukBEkD9nviZxL9/RcONcyULaCZuB3xct/QXLSvzYS5QCMFCsWMToYY
         YsqXliBJWZJoCMF34vdYjK4B9MHg48HOnZU5DIwEFDa195rcnsnxW3JLMtOkMQrb2l87
         pIsg2uENbcCTRczCM/pf8+s7lEVafjJmBXne3hdbyTTvAmV/g/Tzg1kq4Ftxx+xD4LpQ
         VW/ex8Oo7/KFfgH5PzqXb5slmat24Lj84oFJbjt79m72UEefnkwg65gh9uezH+ZRfaxQ
         9N28mEY+B2zXK1B5FcYhpVtD78ngbvaFjXsZnD/S2mkiJ3xHPPElCdY0Ne4lQNr/5Hhe
         oSzA==
X-Forwarded-Encrypted: i=1; AFNElJ8jh/w4oACVN0t7WtEoWJt52WIW+w0lJ/Idjt1Sv5mVk0G4JZvNASODvssOugAmRLsc9eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/44fiWqtFjpvqouw1vk/YQaOf0zbfVpFIljizLE225SHtdz2l
	9YTk9irRxOKLCzc1YvwykSbQTQ1KAI5H71puZhsICrR237Ig+rR7+/Wg7pmx2GnyFJdRPQNJ66S
	Uh73lFSATs4YRnRh9bdP55cpuiRqaJora+NZaRh0V7gGSo6jzvWObttXf2vlyYw==
X-Gm-Gg: AeBDievZdhKDbczxNHfP2KwVEP0yEfhRpqIUhpLGQXm+xcBagd7ueEliLQvkF1RvRJY
	cbXanjjqK2ia7sMBkR2Fz0fqIZFz5kpE8mBxTolASZBm02kQqxy/5gJFMlCxFdgjcEgwDbotQRf
	3fKHkRjPc1ecygznzgr/QlFGFpy89yzhk29GgksJ6kSa2ML1EToQyQm033u00XEr22xoYNoA5lC
	PgnOY0J031sd4ZC0N7LglxDGWA4/ngX4nHCVVC130EUv+iUj9geW/fxnIsn5JbyuwFgxnEI7vGz
	dKsZoNWQJMc51sGwn1kgRF8+cqGAVAnZua55MULZMdQ65Ilcyy5hiWcMNNMDHEJKBB8wOz9ex6E
	YDW7uOwq2RECkttde4LIrzh50MAio4T9KMZ+qTvYCErFFamtb/McQq9wm
X-Received: by 2002:a05:6000:18a6:b0:43d:7b7b:ab77 with SMTP id ffacd0b85a97d-450041b05abmr5041855f8f.11.1777978431858;
        Tue, 05 May 2026 03:53:51 -0700 (PDT)
X-Received: by 2002:a05:6000:18a6:b0:43d:7b7b:ab77 with SMTP id ffacd0b85a97d-450041b05abmr5041799f8f.11.1777978431267;
        Tue, 05 May 2026 03:53:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02c5asm3625078f8f.19.2026.05.05.03.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:53:50 -0700 (PDT)
Date: Tue, 5 May 2026 06:53:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
	Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: intel_iommu unit test is also failing
Message-ID: <20260505065122-mutt-send-email-mst@kernel.org>
References: <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>
 <afi_HNJoObF10rwz@x1.local>
 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
 <20260505061927-mutt-send-email-mst@kernel.org>
 <c7b1a006-a67b-4ddc-8e2b-67fbeb23b066@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7b1a006-a67b-4ddc-8e2b-67fbeb23b066@redhat.com>

On Tue, May 05, 2026 at 12:34:41PM +0200, Thomas Huth wrote:
> On 05/05/2026 12.23, Michael S. Tsirkin wrote:
> > On Tue, May 05, 2026 at 11:45:17AM +0200, Thomas Huth wrote:
> > > On 05/05/2026 11.27, Clément MATHIEU--DRIF wrote:
> > > > I had a bit more time to hook into qemu to check the root cause.
> > > > 
> > > > It seems that testb issues a single byte read (out of the valid size range), as we can see on the following breakpoint:
> > > > 
> > > > ```
> > > > Thread 6 "CPU 0/TCG" hit Breakpoint 2, memory_region_dispatch_read (mr=0x55d72883cb30, addr=152, pval=0x7f62d25f4590, op=MO_BSWAP, attrs=...) at ../system/memory.c:1473
> > > > 1473       unsigned size = memop_size(op);
> > > > (gdb) n
> > > > 1474       MemTxResult r;
> > > > (gdb) p size
> > > > $1 = 1
> > > > (gdb)
> > > > ```
> > > 
> > > Ouch! That's an excellent finding, Clément ... so GCC 16 is "smart" enough
> > > to see that we only want to test the lowest bit here, so it optimizes the
> > > code to access only one byte of memory instead of 4 bytes... which would be
> > > ok for normal memory, but not for an MMIO register :-/
> > > 
> > > Ugly work-around, to force GCC to read 32 bits:
> > > 
> > > diff --git a/lib/asm-generic/io.h b/lib/asm-generic/io.h
> > > --- a/lib/asm-generic/io.h
> > > +++ b/lib/asm-generic/io.h
> > > @@ -38,7 +38,9 @@ static inline u16 __raw_readw(const volatile void *addr)
> > >   #ifndef __raw_readl
> > >   static inline u32 __raw_readl(const volatile void *addr)
> > >   {
> > > -       return *(const volatile u32 *)addr;
> > > +       u32 val = *(const volatile u32 *)addr;
> > > +       asm volatile ("\n" : : "r"(addr));
> > > +       return val;
> > >   }
> > >   #endif
> > > 
> > > ... but I wonder whether this should rather be treated as a bug in GCC
> > > instead, since it should IMHO really not change the access size for a
> > > volatile memory access?
> > > 
> > >   Thomas
> > 
> > Wouldn't this break linux generally?
> > 
> > #ifndef __READ_ONCE
> > #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
> > #endif
> 
> I asked myself the very same question, but after googling for "GCC 16 linux
> kernel" issues, I did not find anything related... there is likely something
> specific to kvm-unit-tests in here...
> 
>  Thomas


This seems to be pertinent:
https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

-ffuse-ops-with-volatile-access
Allow limited optimization of operations with volatile memory access when doing so does not change the semantics outlined in See When is a Volatile Object Accessed?.

The default is -ffuse-ops-with-volatile-access

implemented here:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=122343


Try disabling? -fno-fuse-ops-with-volatile-access


-- 
MST

