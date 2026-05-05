Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4241B355
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976635; cv=none; b=Fldxd/aI+w7MY0ZIa0pR+iF5ESWhbVXrmLtd5T5kaeOyBxoWP17RU1KuZWGqj1Npo9OZGdsSfyeQuErSqsO8/kRG43KdGGF6asnHZ6veFf433I95B8P8rd8KelXM51kuxbyfBW/xIl7jpVLZWyI2jFYaE240Vu8hw/wGXH4ibsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976635; c=relaxed/simple;
	bh=MC2HgpIJADu9jh514/nvet5cV4pIRkR+ZUZnNXgqP7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjlplWpZh1Du3bdKtti319QHHCBkWUoVoyGPBdQKHLT/xfMQz2h4xIu0QGaPFW/seBzJZY+3EH8fc9mXJFOV7MGZQnvYs3KzUTvDq3kVZ//xdfX5JY/9r0xXXjQ8esofssKVXMTJlqqncXvIFL6owTGLy6SOxt2mtRn5amy5CEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aejy0vZC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwc+TQvh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aejy0vZC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwc+TQvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777976632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmSTTBFh7r6Ol2uDpJgUQ4q0wNGdzbbxSw+0iaWifXI=;
	b=Aejy0vZCrLNkmw3pF8qy4oo4xsrs8mhBT0DYIk2MqbLTqk3NNjsBZ6dclR3M65qSJPzpav
	7QrFKnOLeFAq6N/IVz9lmnZVsbyUvpL7D10Bog+UGfMQvvLWNqujfJ66mZU4KHYSKukSG5
	FZgf3YLs5vMZljxFXv613m6q1TavnWw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-XKm5vPKsOy68Y1RMqmE7EQ-1; Tue, 05 May 2026 06:23:51 -0400
X-MC-Unique: XKm5vPKsOy68Y1RMqmE7EQ-1
X-Mimecast-MFC-AGG-ID: XKm5vPKsOy68Y1RMqmE7EQ_1777976630
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d144d3428so7132485e9.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777976630; x=1778581430; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hmSTTBFh7r6Ol2uDpJgUQ4q0wNGdzbbxSw+0iaWifXI=;
        b=iwc+TQvhSDcNxvk8uPp83bPwRKtaUNjtH+RsHmHHOXMTg+KgfQZFmScZnwdl/X4SdN
         HYwG9jFeNLyovN74drlTq63TqqNxWehK2255O/INDP+Fa9/YxI8wSTMW0HV/StBnsu6W
         1Z24YbrC9e/zL1Mws32r3l4+CARozarYjS9kv8QdaRB39bgRj4by3X49Bnhqk6Ec/LhM
         JgHq+wLi/P1j7fH3lJe0E/D08pi5/v53rba3CwafEyLJSKJ2E6MXQaoik7CDGcbnt8ee
         agD7GNQ68U37NqIwgbUoRPBsHiQdjp+ngXIw7yL17ulXB8ui/uZ8Va81rqHvuarK9RPx
         EqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976630; x=1778581430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmSTTBFh7r6Ol2uDpJgUQ4q0wNGdzbbxSw+0iaWifXI=;
        b=rN0l5CzrOutJoL/tNbaJmRC/B0pHgZN34BKsoqCe4XZEmjQnoBhDFnyuhC89wA7A0N
         +LhnZO278isPvxN67N2gifVTXy+mopknLh5fUH3bOytJaAEytAn92ugsDelvCTHz3i/5
         4fqrW/Rl4hkqLHE4Xd2oek+iE/YbU5vXO7lMTeFJOU5dhBO6TDErjPpo6CCz7ZnzEgAx
         Eh/wER0L6CnBDAXcVeR8ej/m9UZWJ4F59sXRl+pR0p/NhPCnuEXpi9cLuZIaxO0T4Ilt
         S9nIwjDReuoCLDurA79S4aFAjk9nIMaThL3yvP4JqAhmg2JX5LUEF/UHDTD+QFZ3ycpi
         R27Q==
X-Forwarded-Encrypted: i=1; AFNElJ+PQ/TramCKKg3Zimi+TEoWP6jNmpdpbzNzw89hUcZwSriFmwvD4s9WTrJDs0G1vTiq4Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYM43u9Z7pWljYVbudynCHoxuGA4EqPqbmh+B6wCSUtewtD7yb
	YJoYaf4TMahBStQtG6w9hd1huZ242lPcGcpDh4nDQjNgbjD9bGnXEHyT92+rEVx/15j/elyd5Jj
	uRH1DeD7dASpjyYHTs05FsxN+YmEu4GSGf7Ez0trOZR6NkP6WGm3Q5A==
X-Gm-Gg: AeBDiesjWnCDYMIC7zjLwIcBEeiLHM4yTOnm0yaeduTUsSFTmK08UYVo5aI1jLnarcF
	LHofHi9E0eOwqj+bN+GU6Kf9S3WUR7lurMRQ+PK4PB38auXwegjBo06gGxy5DBt+N6oIA2DB6k6
	6TIk7EUn+k5hxthaycbjac/Z/LqJtI6/avr4M/IU8rLxtIY7bHlemp0Vrr6yEidATfJBYDD+F9v
	ARr9mc9kK8uczbqXK3VfeknZzS0p4o3DCsZB7p3kzWipdZT8jGEhYaJWqJ8fV3iq/q1u6tuhgzu
	l04wKDXeLRKzxApvXjeeQTuzBKeWaBhca9yzgYwsp+9+ySCsJvkZG0Gu1yXFqGZgS5/OWg4ssn+
	lig7hQvZxDYMoFPJyEhSXzBMT++WIsRFsg+0uyFBKrjC4s/s7kqEsfDos
X-Received: by 2002:a05:600c:1c15:b0:48a:554d:b9a2 with SMTP id 5b1f17b1804b1-48a9852f593mr219974865e9.6.1777976629774;
        Tue, 05 May 2026 03:23:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1c15:b0:48a:554d:b9a2 with SMTP id 5b1f17b1804b1-48a9852f593mr219974235e9.6.1777976629133;
        Tue, 05 May 2026 03:23:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960902sm3744190f8f.28.2026.05.05.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:23:48 -0700 (PDT)
Date: Tue, 5 May 2026 06:23:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
	Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: intel_iommu unit test is also failing
Message-ID: <20260505061927-mutt-send-email-mst@kernel.org>
References: <20240604143507.1041901-1-pbonzini@redhat.com>
 <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>
 <afi_HNJoObF10rwz@x1.local>
 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>

On Tue, May 05, 2026 at 11:45:17AM +0200, Thomas Huth wrote:
> On 05/05/2026 11.27, Clément MATHIEU--DRIF wrote:
> > I had a bit more time to hook into qemu to check the root cause.
> > 
> > It seems that testb issues a single byte read (out of the valid size range), as we can see on the following breakpoint:
> > 
> > ```
> > Thread 6 "CPU 0/TCG" hit Breakpoint 2, memory_region_dispatch_read (mr=0x55d72883cb30, addr=152, pval=0x7f62d25f4590, op=MO_BSWAP, attrs=...) at ../system/memory.c:1473
> > 1473       unsigned size = memop_size(op);
> > (gdb) n
> > 1474       MemTxResult r;
> > (gdb) p size
> > $1 = 1
> > (gdb)
> > ```
> 
> Ouch! That's an excellent finding, Clément ... so GCC 16 is "smart" enough
> to see that we only want to test the lowest bit here, so it optimizes the
> code to access only one byte of memory instead of 4 bytes... which would be
> ok for normal memory, but not for an MMIO register :-/
> 
> Ugly work-around, to force GCC to read 32 bits:
> 
> diff --git a/lib/asm-generic/io.h b/lib/asm-generic/io.h
> --- a/lib/asm-generic/io.h
> +++ b/lib/asm-generic/io.h
> @@ -38,7 +38,9 @@ static inline u16 __raw_readw(const volatile void *addr)
>  #ifndef __raw_readl
>  static inline u32 __raw_readl(const volatile void *addr)
>  {
> -       return *(const volatile u32 *)addr;
> +       u32 val = *(const volatile u32 *)addr;
> +       asm volatile ("\n" : : "r"(addr));
> +       return val;
>  }
>  #endif
> 
> ... but I wonder whether this should rather be treated as a bug in GCC
> instead, since it should IMHO really not change the access size for a
> volatile memory access?
> 
>  Thomas

Wouldn't this break linux generally?

#ifndef __READ_ONCE
#define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
#endif




> 
> > cmd
> > 
> > On Tue, 2026-05-05 at 09:36 +0200, Clement Mathieu--Drif wrote:
> > > Back with some answers:
> > > 
> > > This is the incriminated hunk:
> > > 
> > > ```diff
> > > --- <unnamed>
> > > +++ <unnamed>
> > > @@ -1,17 +1,16 @@
> > > -  404395:       8b 80 98 00 00 00       mov    0x98(%eax),%eax
> > > +  40441d:       8b 43 38                mov    0x38(%ebx),%eax
> > >           edu_reg_writeq(dev, EDU_REG_DMA_DST, to);
> > >           edu_reg_writeq(dev, EDU_REG_DMA_COUNT, size);
> > >           edu_reg_writel(dev, EDU_REG_DMA_CMD, cmd);
> > > 
> > >           /* Wait until DMA finished */
> > >           while (edu_reg_readl(dev, EDU_REG_DMA_CMD) & EDU_CMD_DMA_START)
> > > -  40439b:       a8 01                   test   $0x1,%al
> > > -  40439d:       74 10                   je     4043af <edu_dma+0x121>
> > > -  40439f:       f3 90                   pause
> > > -  4043a1:       48                      dec    %eax
> > > -  4043a2:       8b 43 38                mov    0x38(%ebx),%eax
> > > -  4043a5:       8b 80 98 00 00 00       mov    0x98(%eax),%eax
> > > -  4043ab:       a8 01                   test   $0x1,%al
> > > -  4043ad:       75 f0                   jne    40439f <edu_dma+0x111>
> > > +  404420:       f6 80 98 00 00 00 01    testb  $0x1,0x98(%eax)
> > > +  404427:       74 0f                   je     404438 <edu_dma+0x11f>
> > > +  404429:       f3 90                   pause
> > > +  40442b:       48                      dec    %eax
> > > +  40442c:       8b 43 38                mov    0x38(%ebx),%eax
> > > +  40442f:       f6 80 98 00 00 00 01    testb  $0x1,0x98(%eax)
> > > +  404436:       75 f1                   jne    404429 <edu_dma+0x110>
> > >                   cpu_relax();
> > >   }
> > > 
> > > + is gcc 16
> > > - is gcc 15
> > > 
> > > The instructions generated by gcc 16 always skip the following condition:
> > > 
> > > ```
> > >        /* Wait until DMA finished */
> > >        while (edu_reg_readl(dev, EDU_REG_DMA_CMD) & EDU_CMD_DMA_START)
> > >                cpu_relax();
> > > ```
> > > 
> > > As a consequence, the test performs the second dma operation too early and reads a wrong value.
> > > 
> > > Regards,
> > > cmd

