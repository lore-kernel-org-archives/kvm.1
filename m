Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725309;
	b=aLOfbhtrWSznNcjps57XAi7n8Ux+0u+7VpkxrZ1sfb0U9CwiTh+/iYIH1/UUOmYTJhAc
	 yf+citKVOjy5i9/pDlwbWISWDlx4kXB/gYe1KHfBm3Xk2SGDGNdNwM29bofevg6VfinKr
	 1Ft/k/YmIfe8hFisL0MlJ1rvFrpJsr44LYZiJElxVBB/+j3QMNaZY91/Y3kOCLRnzjTwW
	 dIRFo/ANx/c3mG7PJHfgfNFHWhDxWfssodl+mZNNhu59ZwOoxTWfz/GTbN9zjKSKY5rPN
	 vi7BWfp4YPsvMfiWoN3xbBlBij9yQ3Hf2Qvj9BsX+YY/oSMJPOtMMyg7Yt5oFG4Zccw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Xe0tRFQ6oz0C6PHY93xA0SxlfYSQl1kZj6MPIgpGjrU=;
	b=t6Pciv7k1BpLIT+MdsRVNXBYmSAdrsud7Iefk1HErTkFWE5Be4gxCuPybkbgTOAPhAk3
	 WRPQrYOREvsSSm6+zHAzUulJXKNPCOYnk2a9mWuIh/xQFO8NrpjoP8cQ5s31q/qT2EvxQ
	 ybHgYuIg1RRBqGFQiBt9orZXkzEuOOGjSYYiK6d1LdpwkHT2XZ1G9MD8k2e+PAPAYtrTJ
	 G9agyZH+g+W0zWUn1LDxtGsR46+NnL/9+dbk8XjJVivGkluoSExPxK4ff/BHLYzrxbyxs
	 0QxkxrfjyoQtrae5Rc+aPO+NjqHvoNX6X8N/2AnVvz1cdhEcn8qQ9QG3BXwosR9M5NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="iqBR/VtS";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C35606A323
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 20:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C35606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iqBR/VtS
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso21301555e9.1
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 12:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795725307; x=1796330107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xe0tRFQ6oz0C6PHY93xA0SxlfYSQl1kZj6MPIgpGjrU=;
        b=iqBR/VtSmHkU1aXQgKUkObmS6ZgzoBTUy2n8oV9tyleT4NXSE/sWiaKB8E+lh/YX1Q
         CrE/aIoYhAfV/+lpRVdTRhpy7q/1QVkRtJi5OiWRE6R932ejEp2F0fJySS+cIXKU6XDt
         xbaN2ZdqqR8DuHi+AZppUPXInlYNJaRe59EIoUrYFVHP7Et3lDwSp2+1M23JoQx4QMEL
         CTATg+ycw3GkINWbdt5xJsFS5i/7VRcRN+7zEdyCixP+/k4Cx67PClYDExzrDYJ5qAmh
         HE67Dj4inPkeO53LWEyhmAfq6LNUwB76YXuky0BLUvG7PcAXF9kMiQGKp+TlZQs4voWk
         n+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795725307; x=1796330107;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xe0tRFQ6oz0C6PHY93xA0SxlfYSQl1kZj6MPIgpGjrU=;
        b=FgxLyNIh4unG5qv+JKNKIaFbBSWWK4/aJ9GjL5nx5PaIutsG5HoET9ZgkQ33ycAf5G
         BD4Nb1AqCyxuMyHlYP5hqgHFr6ocABGIxI+6z/gOz/v+EixsHhqLXchLWTbPu5IEnA0a
         AL5kYYsaHAENPAK0pGn2Q8hpIM3STRj2rrBbyOy7N2gOpy7I/R8xXE50w3UdJgRZpz/A
         /W6asxRoyQH+rHUn7yJhJxwCuDgpk+wv+9wforg8PxCMCJGD2Ubqi30GUVy/skitXJdo
         1kCx7wokqmZekhRN16Czlnb2B/pnL/ysHwXTb3nHWqjAPp0NP15BGk1CYLszBGMoSyNc
         anMA==
X-Forwarded-Encrypted: i=1; AL+hErEk9PvarpJd4rds8eBlctSpQD1pLAC45QIiwlb1fVRUQ30PSYlp6I3oZlVc2QsBWDv/cEY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yH/BV/YwvDWpzto4vuoZQin4Rh44i995C2sccHiQfXdofveVb
	jIGvZK+PT0PXpO2d3o6C6ZKq6HHSQd6rQncSeRdrcTEkTKTS/Lnv/A80KhVhR0BCeQ==
X-Gm-Gg: AZFdTZdL2dt+69G/mL/kRxG4fI8liJ/MxT0/vh1MmPa3kYJVj1qfgaAQ1JdfkrraSiU
	rloEgQP9AJppKPVm2nAZJwO//sBbBHLBZ+yfELG/c/6286bW+LC8zXe1DYwQ5tT1mD/wBm7YQhM
	73yqLgjta914OkccCwp6/SZyBHjubl3oEPXVSRDBP9hDv8Q9PLMJH6x6TQW2EmfKLSbLfdglohs
	jdkyC9Ehvf2ooXmyaSlPDtL8UKjXzle3/ESLFeh8c7PtUKJA+YeYuZQq2ymF8SrW4gIDPke66Uo
	rbKCUyplaVfS4PI+viYUanwJjPCtChtQ/ar2hkJ1rCEwMDjvJRFu5oF/na2/DazBcN6e96uIiUX
	lkARELHSW4WgAyvcGwsoBlll7jbGCX2XvcWa2Hw3d9AnH+SdKf+P4SIKADCQJ2eob3DqklrCHPd
	LAv5l3SQ/WQGCtaQxSeJgFSj2VLkBkuXapa4k3rdta0ngi5UNlmWCfMJOioheQcQZ9l35FyfdXs
	N7Jh554dP7Vkje/kwO6MAeG/ZuPF80WC3Zf9CjAnjBLQ17xprOAWeWbmK7Ahj8/0fpWNCkwHQCr
	5blrWbSXJeWqU7I4uL3sPvBQG8uotpQT1JxNJV1ZJruk+bMZ/x0AdMlljm4lAR91lmpXg14bAkO
	ZkZDiWVEMakFcKoH/K2za3A==
X-Received: by 2002:a05:600c:19d0:b0:4bb:ac6c:de67 with SMTP id 5b1f17b1804b1-4bbac6ce1aemr59511575e9.14.1795725306615;
        Thu, 26 Nov 2026 12:35:06 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9066f6e6sm298463905e9.3.2026.11.26.12.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:35:06 -0800 (PST)
Date: Thu, 26 Nov 2026 20:35:01 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Will Deacon <will@kernel.org>
Cc: julien.thierry.kdev@gmail.com, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	maz@kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com,
	alexandru.elisei@arm.com, andre.przywara@arm.com
Subject: Re: [PATCH kvmtool] arm64: THPs for systems with pages bigger than 4K
Message-ID: <awiX9cEDByf7d40x@google.com>
References: <20261019145949.1922019-1-vdonnefort@google.com>
 <awhZk3NrkqeGvQxC@willie-the-truck>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awhZk3NrkqeGvQxC@willie-the-truck>

On Thu, Nov 26, 2026 at 04:08:51PM +0000, Will Deacon wrote:
> On Mon, Oct 19, 2026 at 03:59:49PM +0100, Vincent Donnefort wrote:
> > The THP support imposes an alignment of the memslot userspace address to
> > the size of a THP (PMD_SIZE). To do so, kvmtool overallocates the RAM
> > size and aligns it. However it assumes PMD_SIZE is 2MiB, which is only
> > true on 4KiB page systems.
> > 
> > Use a huge-page size, based on the system page size. This value can be
> > massive for a 64KiB page system, so skip the alignment if we couldn't
> > even install one THP.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/arm64/kvm.c b/arm64/kvm.c
> > index 36b3284e4a92..2c01dc32fa9a 100644
> > --- a/arm64/kvm.c
> > +++ b/arm64/kvm.c
> > @@ -18,6 +18,8 @@
> >  
> >  #include <asm/image.h>
> >  
> > +#define HUGEPAGE_SIZE (PAGE_SIZE * (PAGE_SIZE / 8UL))
> 
> Does this invoke sysconf() twice per invocation?
> 
> Will

It does. 

How about I use for PAGE_SIZE a memoized version of the existing
host_page_size() function?

kvm/util.h:

   unsigned long host_page_size(void);
   
   #define PAGE_SIZE host_page_size()


util.c:

  unsigned long host_page_size(void)
  {
  	static unsigned long page_size;

	if (!page_size)
		page_size = sysconf(_SC_PAGE_SIZE);

	return page_size;
  }

-- 
Vincent
