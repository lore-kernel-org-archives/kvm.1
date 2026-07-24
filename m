Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEF3D34B6
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927263; cv=none; b=g/PXMQ6thFTkUSptbkhF8kDN3B7NAPCNNXRY/OiXUzFIU0n52Uz+lS6PZK+B6Lu+uWuNPrLq+5p3eUaIl3vxNJrBmlDGEhG1blC9VORAYaphW+G0+S8YjTdIEN9/1QurociWusEw9UfZIrSjKM2gNG1p4vnn9nUP1VBelYZyPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927263; c=relaxed/simple;
	bh=Pw2tqvos94mI7QGPy3m2a/zY5Z2tGHFm3BFgYMdBLOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg7Jg+jt/as8GdpxmYODItq5VB0jDBmkHaaRgZnOmqer7TxMQM3XTuhYqHXgvszV653U2rxd0DgHRabq+FbDZSohzfsDDKPEaZMuV2xxWwcTSNdFdJh4/sWNNbFVSGOadUa0s5bn1UtkVaiMaXBEzO3cJVjbd/AOceBTXPABsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1aq4PvS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pDgxh27u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1aq4PvS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pDgxh27u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784927257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3+l6zQ2UyUka+UgzsNomoD+GF98S9wcKfqgbKY9mofg=;
	b=c1aq4PvSPV2FsJPHeBPb61ZEe2tzWlqz9/2jX7L2cEpDZJIVZ7+3WRjgFjhCtnr0rfmz/6
	8jkiBpKVD5xKj2qeRlDkzZt3ajurSgeLTLnR9WJ/G0V93P2fM5H3HneoUQajuNqZWsrofq
	xgpDvwCOl+j2bsj84otijcZL5q10Ji0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-y6uv41hdMWet8KAz7nPBcA-1; Fri, 24 Jul 2026 17:07:36 -0400
X-MC-Unique: y6uv41hdMWet8KAz7nPBcA-1
X-Mimecast-MFC-AGG-ID: y6uv41hdMWet8KAz7nPBcA_1784927255
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495569acf8dso5678445e9.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784927255; x=1785532055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3+l6zQ2UyUka+UgzsNomoD+GF98S9wcKfqgbKY9mofg=;
        b=pDgxh27uec8OcWm0AW4Prb77q+U+jZqzCIQoBBWBZQEu6ux18XlBTWt9kPHyEinlNX
         UDi6KXJRXcdHm+YqNpQRqelmZBKYIJrrC2PW3lRTdCXzXsnFsulzNthwMslNIcNpbgqf
         HbhjWiPacYs/DithsriKXqUSKRyftgqnLPWO35GrSJH8dlNFHIbvqmoTNpZE+mE1aVOm
         B1Z0lWbWTexmxeGH3qPLCEIdCND3XP//eH42NJQDxVGpEGqbFdw0/U0Ni7vy4ERZKkPL
         Q90L3VXVxte+0pFxNM8K8aMlIh3BXPCf6WtbR1VlK8zHuKM8UwNFszpI5zaOkzi0Havz
         iJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927255; x=1785532055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+l6zQ2UyUka+UgzsNomoD+GF98S9wcKfqgbKY9mofg=;
        b=MZ01clQzYuUYLXfrtPVQnaeILFUsySLeo0KcdcuEF7VZSTjxSKtuwjljWaP8rR3hzJ
         2tmuTy8HuC0jh/He0ZUUFlSkf5nHAMNpJGIcXdH3fAInjnIJQOb3o+c7VZEQTv87dlFM
         vVN5qzz4AoIZPyGyHBqdyjqJ1Iz/I7jSXJ/RsoxVVeAroo+xQVvXBA2uDx8kWef9zCur
         L/v5I+sk0P9sB6xHnzAFlb6kyC7PIxy1cKguRz6O5yY+dzweq8QXAIgHklbGtuZ69KBR
         W/DJc77deBoP6RQ4oJugnpefdSw6LCaA3TLmUyzlwFrMTGRLkmPVdlKVbMJXDKl6jX2y
         pJZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDLBQfH2PcFtWYzY8ejrm3Mo1pIxKO00C+94JglPOoiOz3D1u2G4CoS/X+ngGBCs3LaH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywBUQyXBL2/CMdFFUsvUSyCwxJ3TxYB09HS5j4IwGoiMPlchVR
	H1DvIb+Y1y1T9Q1uPBDm4L2q46+8fW3nzPFmGMJWdL0q2TgyEt/XdAmX30jInq1fdlXwj/gRYVX
	rHB8e2vIT2ER9hWcJv2tV+nb1CFluYaAHyl4egryAiJi7SR9GQX+SxQ==
X-Gm-Gg: AR+sD13eeGFKR5tg4iUsaVNoKAZeukjwPPOAkYUsCUMKvgTdYHRVBSwd3JB2YOSDsZa
	uQN1glbdv1BoDhEKiqoRSG9MnNXKe8A0T/r1ofwHy+py8yzzGdVXHyWSw/wKRf0NTGtOd+LPgWt
	BPxjdz5jBxq3ixKjgbpPih+A4f8IowQzlvs1OnmEzGHb+hoeNJBE6uW7rU6N9vE1sFJUSBmERrb
	9Q2SVOPMV/Z3yzoPHbgoTmB6ByWfbzairZl5dCo38kr7tBX8s7ZJvVFdYSuHl3i0vNgP8QuxofU
	qJuyH1uUxrb+zf+08UFCA4idLxdhGDeb/pIUiNboJN3HyZCyoNFsm1wfT4tJHEYN8LMkMtVQFAM
	kI5KPgXy5RW4pLXkScUXRAv0qKc3UxWw=
X-Received: by 2002:a05:600c:4d06:b0:495:7a23:1eee with SMTP id 5b1f17b1804b1-496b56f39d0mr18925e9.12.1784927254850;
        Fri, 24 Jul 2026 14:07:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4d06:b0:495:7a23:1eee with SMTP id 5b1f17b1804b1-496b56f39d0mr18715e9.12.1784927254347;
        Fri, 24 Jul 2026 14:07:34 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee4504sm11539515e9.6.2026.07.24.14.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:07:33 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:07:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
Message-ID: <20260724170606-mutt-send-email-mst@kernel.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-6-willy@infradead.org>
 <amNeKcDZ66VrQ5PL@casper.infradead.org>
 <amOByZH4oWzmO3Zj@google.com>
 <amOpRMpkyFGm0j9c@casper.infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amOpRMpkyFGm0j9c@casper.infradead.org>

On Fri, Jul 24, 2026 at 07:04:52PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 24, 2026 at 08:16:25AM -0700, Sean Christopherson wrote:
> > Heh, you don't want to sign up for a week or two of onion peeling?
> 
> Oh, you have no idea!
> 
> Here's my onion so far ...
> 
> 1. I want to simplify filemap_fault()
> 2. That requires changing all the architecture fault handlers
> 3. So let's push some of that down to the MM with a new wrapper around
>    handle_mm_fault()
> 4. This would be easier if we could hoist the creation of struct
>    vm_fault from __handle_mm_fault() to handle_mm_fault()
> 5. Which would be possible if Jane's series to fix hugetlb use of pgoff
>    had landed
> 6. Oh, hang on, handling hwpoison on hugetlb is actually broken in a
>    few different ways (some pointed out by Sashiko, some I noticed
>    myself)
> 
> I honestly thought I was just going to rearrange Jane's patch series
> a bit and resubmit it, but fixing the hugetlb hwpoison handling has
> consumed me for the past couple of weeks.


Last time I tried to fix hwpoison, i wasted untold hours on it, only
to decide that it was always racy and does not seem to be worth fixing.
At least yours isn't a race.

-- 
MST

