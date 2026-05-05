Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0E1FC0EA
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984406; cv=none; b=XVQcSCPq3pUzmku+7AwXH/FAyXyZcbRt6S1EDarpPkHeWxrSFAkfdH07VfiTVSVd2jhG+mVuwZXoVUEI8JQGwprom6q01uoyy0aPLXaA26BzpeRhtq3l987BHhAHTSRb3Bsi0rdzkgMGkLyPe9d5ZPb9oG1fY3pM+ee5BEklw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984406; c=relaxed/simple;
	bh=sP47eRscCaT3uVSCrMtg2yrLp8kXjDiCXS6A+m0T96k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3NmkfThgCin9iiX+O52976sCaNM6tVzf3gZIj+JmacXbNNxY7EBNGWNr9WF594VXDC5WUWP7dqG4Hs+/7owLA5Yy4LfzjaU4yz3iVNYUOc7KUmAXT67wFL27h6sUg+iqPim9Ekkgo1SRkKmfqZ/S4DxRDARnu5PacZHwdqLdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAbdvItb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ia6nyHdj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAbdvItb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia6nyHdj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777984403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gw6HRxntIGc8pezkmH9AUc0dIB1QCUnD3UqyanJ83PQ=;
	b=QAbdvItbGTIIj1Ak3VazQxvzACUwGU92/33d4cuuN4Dc7lnVfmJITuUJAIgXOuZPVjzVcQ
	GXeKxxFFIITV2U8hcbANsKpUxODnNQZzDLhGp0Zb0rKLwU4/lkWqAHMG3dvYZ6nb0XIa0D
	iALKya9L2tCydkOWa+RMUAqZ2EIXYNY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-XAAtEitbPliLyyEqlvq3oQ-1; Tue, 05 May 2026 08:33:22 -0400
X-MC-Unique: XAAtEitbPliLyyEqlvq3oQ-1
X-Mimecast-MFC-AGG-ID: XAAtEitbPliLyyEqlvq3oQ_1777984401
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8f5bce308dso405725966b.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777984401; x=1778589201; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gw6HRxntIGc8pezkmH9AUc0dIB1QCUnD3UqyanJ83PQ=;
        b=Ia6nyHdjOBWIBQIoFeTs6wxaVDElBUN3tZpI6XHG1Vp6KbEbBoNQPKsh2VqLwRnbd3
         CYCVaJGxtfJXdic+8KTxWKaXpennKTuU2UGyKaMPi3WJOG0zG3okFTg+LUsxtlcgAnLP
         Os4fLIi5oJZwS5ZTG2QdbMBFnshfIRqBBMpHhYyq1dKQLBlVxb8C4swOOQxYYr59QYIv
         liCNNj7Re0dvqB4SGa3Pk/qGYBZj6tDBA2wEZmS+oPTO6AUARXh7MD1lvOBSo0i4Lfhy
         OAU5tdzTDD9p+6HJ6J8R+ftgMB9nhtDtGNLEAldhd02n19MnZb/wTmAhEiAjB4rJ+n5X
         Z/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984401; x=1778589201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gw6HRxntIGc8pezkmH9AUc0dIB1QCUnD3UqyanJ83PQ=;
        b=M0H8amKWi7Omg2FWY8MszebIgsf/X+DIIZuD5A5dqnS/l4Jzcofrghy4V7o46UUkhH
         yCYQ+YYlOjNVXxA7sbgCX4im9Nd42ZTDP9nMAUmu/DqI3VVZtNql/JA4GoMsMU9W8+RN
         oKCMmwOLDwVmXVsJxHDwcsETy2DT6Uw0YCRiBdBIQGHWxiQKI+BZMmn4o7G5Pijn8P73
         axVcX9sx/+tP3HFq1wmIruhz8S3MI6V+itE8yDScyNyNAYMXtOm3MgmoVj9BwOkaOLj0
         o4mrdRwO5y9JFiH0qBB4c9WfxOeQVWKmCDWJjhWelMq+zOiQoiW20aul7wxRT4PUEBcJ
         X86g==
X-Forwarded-Encrypted: i=1; AFNElJ9MJGELOU9CfnjIRQUyGysO7qclUH/lZdc+7AGw7swnPnUv1CLc+NM7F+X7B1yWBg9Sg6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPm9gFg0qXGhUSjyQlWtNfKLAcYUgfFel4hOXgYklWgiXaEIF
	LbFy2ult5OeKwekrEJa5kZWIhY+JylymdcDxEHfJfYCRH68TR+uGerl9434kK51nIaLe1FPZ0Zy
	FfeZBi/C2IxLPHnYlRuykPyB97OORfGtr1z/XtkE7nYdl4uZb7GKNHQ==
X-Gm-Gg: AeBDiessNQ+t/r2SfDrbQ/BmxXyuvfZMXlQtRaPCqzRHdlM6OW/Fk5FeUfhJRsDYI7N
	A2FQgrDa7jBovWNmLws1EjWFro27BWz+zSrhuKR87UU9UocXR3UC+f7SNaayoUmeWcdnJ8/gk94
	L/m0qBI+rSqa8QCFUiML7at16kFXTANo9lNTkBP1xKRbVp1juT1tZT+5x0SFUW6fVkhqJ4U4QYq
	Sdm3moQQR47iTjE1xnN8o+gGpYUtqncNS1tTEZZhvTpZ3DgcOT1s0yTLBxFDVJv/YxyGSUy5e9n
	E/VtT7RPbYeu2GZnGu+AJ7pIrX5CSXteYABXNi1u/xvl5t6EHSixrKI2wPY/1i9ze4w8gXiQ8Je
	v12AAH8p55yU+GblN5y/AKw6sz/sAvat+q78kTjZJlAH4kWlI+v7yTgjQ
X-Received: by 2002:a17:907:1b09:b0:bbe:37ee:8a2b with SMTP id a640c23a62f3a-bbffd8c81c6mr767783066b.33.1777984400899;
        Tue, 05 May 2026 05:33:20 -0700 (PDT)
X-Received: by 2002:a17:907:1b09:b0:bbe:37ee:8a2b with SMTP id a640c23a62f3a-bbffd8c81c6mr767774366b.33.1777984400045;
        Tue, 05 May 2026 05:33:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48b23sm4543844f8f.14.2026.05.05.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:33:19 -0700 (PDT)
Date: Tue, 5 May 2026 08:33:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
	Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: intel_iommu unit test is also failing
Message-ID: <20260505081337-mutt-send-email-mst@kernel.org>
References: <afi_HNJoObF10rwz@x1.local>
 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
 <20260505061927-mutt-send-email-mst@kernel.org>
 <c7b1a006-a67b-4ddc-8e2b-67fbeb23b066@redhat.com>
 <20260505065122-mutt-send-email-mst@kernel.org>
 <48384da2-7eb5-4044-bc3a-201b09d9cf81@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48384da2-7eb5-4044-bc3a-201b09d9cf81@redhat.com>

On Tue, May 05, 2026 at 01:38:26PM +0200, Thomas Huth wrote:
> On 05/05/2026 12.53, Michael S. Tsirkin wrote:
> > On Tue, May 05, 2026 at 12:34:41PM +0200, Thomas Huth wrote:
> > > On 05/05/2026 12.23, Michael S. Tsirkin wrote:
> > > > On Tue, May 05, 2026 at 11:45:17AM +0200, Thomas Huth wrote:
> > > > > On 05/05/2026 11.27, Clément MATHIEU--DRIF wrote:
> > > > > > I had a bit more time to hook into qemu to check the root cause.
> > > > > > 
> > > > > > It seems that testb issues a single byte read (out of the valid size range), as we can see on the following breakpoint:
> > > > > > 
> > > > > > ```
> > > > > > Thread 6 "CPU 0/TCG" hit Breakpoint 2, memory_region_dispatch_read (mr=0x55d72883cb30, addr=152, pval=0x7f62d25f4590, op=MO_BSWAP, attrs=...) at ../system/memory.c:1473
> > > > > > 1473       unsigned size = memop_size(op);
> > > > > > (gdb) n
> > > > > > 1474       MemTxResult r;
> > > > > > (gdb) p size
> > > > > > $1 = 1
> > > > > > (gdb)
> > > > > > ```
> > > > > 
> > > > > Ouch! That's an excellent finding, Clément ... so GCC 16 is "smart" enough
> > > > > to see that we only want to test the lowest bit here, so it optimizes the
> > > > > code to access only one byte of memory instead of 4 bytes... which would be
> > > > > ok for normal memory, but not for an MMIO register :-/
> > > > > 
> > > > > Ugly work-around, to force GCC to read 32 bits:
> > > > > 
> > > > > diff --git a/lib/asm-generic/io.h b/lib/asm-generic/io.h
> > > > > --- a/lib/asm-generic/io.h
> > > > > +++ b/lib/asm-generic/io.h
> > > > > @@ -38,7 +38,9 @@ static inline u16 __raw_readw(const volatile void *addr)
> > > > >    #ifndef __raw_readl
> > > > >    static inline u32 __raw_readl(const volatile void *addr)
> > > > >    {
> > > > > -       return *(const volatile u32 *)addr;
> > > > > +       u32 val = *(const volatile u32 *)addr;
> > > > > +       asm volatile ("\n" : : "r"(addr));
> > > > > +       return val;
> > > > >    }
> > > > >    #endif
> > > > > 
> > > > > ... but I wonder whether this should rather be treated as a bug in GCC
> > > > > instead, since it should IMHO really not change the access size for a
> > > > > volatile memory access?
> > > > > 
> > > > >    Thomas
> > > > 
> > > > Wouldn't this break linux generally?
> > > > 
> > > > #ifndef __READ_ONCE
> > > > #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
> > > > #endif
> > > 
> > > I asked myself the very same question, but after googling for "GCC 16 linux
> > > kernel" issues, I did not find anything related... there is likely something
> > > specific to kvm-unit-tests in here...
> > > 
> > >   Thomas
> > 
> > 
> > This seems to be pertinent:
> > https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
> > 
> > -ffuse-ops-with-volatile-access
> > Allow limited optimization of operations with volatile memory access when doing so does not change the semantics outlined in See When is a Volatile Object Accessed?.
> > 
> > The default is -ffuse-ops-with-volatile-access
> > 
> > implemented here:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=122343
> > 
> > Try disabling? -fno-fuse-ops-with-volatile-access
> 
> Thanks, this seems to fix the issue, indeed!
> 
> Would you like to send a patch for it?
> 
>  Thomas


So then it's this bug apparently:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125180

will likely be in 16.2?

Maybe just wait?


-- 
MST

