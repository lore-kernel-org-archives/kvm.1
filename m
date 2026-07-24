Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747BC35E943
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784865355; cv=none; b=PkUdaJZyTLj28S9qdZD30AHrOSeoU5Hz5jOiH+Wh1s41tc0+oJ6LJoJB3wHzwdrvDXRbGiqXWg7PCdMYDfGpMKOxzDC1o3KJWMUbMWoxu115Wk6a8y2wns9kB6bFK7OzFBDBBZWshypn5pbgrEHvoMSuShvNMkBEustFuuKTtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784865355; c=relaxed/simple;
	bh=bY/WEK9yistReSta5XbgiXuBn1CFgZr4/J9CBfX8O9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiW5fkW8U+oC16K3KbTvt6LawqHS2qk+7uG0ojr2eWBLlD6R2jDRrrh7Df1I+mIVLraDUldbz16djZZ6CMzGaSlUgXoQfO4yu5/Y5G7zjUgH2Ca3HXEz7XUMAXdq+AYCOpLHnWXF2U834bCTI3wMsCkc2Xqu9eyzwkbE6Hrh85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TxvTHEFT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TxvTHEFT"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e53581361so107564885a.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 20:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784865352; x=1785470152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HNJfcC8jn5sdQ+MVI+mQj0PijBIpCe3BsXMVP5pD+So=;
        b=TxvTHEFTSPb6PFzdctuA3AIUO4n3oOxPakjyWcXxp2evIBuserE60WS4iDZkVf6mbr
         ek9Kgltwj7vrv41L0+gNvFnVRtj1Q32UL467lTUmu7eiu9BUBxA8E1CIvAAizXK1DBgd
         24dLCxhOkmQwgdfP/DTRoh1nIc1RLvQ7RH231/Si7st0gkbgG3qlbAxZ20aKuzB7CrMO
         cvBQJTGAQzHTBDC32q8qnyMd5zK3AlxA5RuIlHXzTPShxKfV/6VtVFSocKtIO5Q9m1kJ
         Hxcq1sB9EUgeeyMLG+nrY41fcBnGuwi3FEAMv9HBBq0vT/B9TpJ9mSRvKJwCaHmSBWx0
         Dceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784865352; x=1785470152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNJfcC8jn5sdQ+MVI+mQj0PijBIpCe3BsXMVP5pD+So=;
        b=hWr3BgYDFOB1GfwTYZ/UzwWTg6y6vosDZzFfgxVpLUdsATOn3/EbYZCU/UijHdRklf
         meF5vdHlFaDYImEY7caUn5Pr5YiVDG38ly21O96eYnbwCz2PlJbbT0bwAgAcFESw1nQ1
         7qk4LkJLuVheroDTZ3f9rCgC7FciQYYx53de+ZR7hiXbZwj8LDq5D3Af0HWeb4bxUDDp
         Ic5ql69xEetGXPWw1CidmEYPJB/wwJfjkLfT5Tzy+lBu+IFCMX3IdhNMpqXT6e8nYrRR
         YM8TX7/He9l1dhm0m9UsBZ9VHKci3jIwIi3zR/ONBRoXwKRbJEwpA8rI65uHDHN1i7Nl
         ilqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrze5Q5cURfrvNHXwwPmxKxjuqKRbwC/I0njqMWHtj4UPEySk9TZSTPjHWoGZM6qhYrnZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2ZDSGt14sh2eLu19VJ1XfyTMVIxy+OPJS3UUUMmuLhXbvXyW
	EUP1xLgaxhyGP0W1BWDE/WQzKMDBJT0fL51+5C23VRz+mXPWwEMcrwf58Yazm7mk+zY=
X-Gm-Gg: AR+sD11/zgjYvD9b9sl22QKf3XTkWyEy6Eqy0034bANBhe1raDXZo0G994hlfHLhcPe
	eRbtCPHjDfFLPO8ke/4m55eeexAly62jwi5nJsWs9M3CGMRVHuzCmov8Veak+B7UszPxwAqT5VT
	sz7nyNSSFZC4er1GbBuF0Ez0J22M1WH1+qp72KpUMLmVeYO35EclYMOQbH0hBELoryOw/Q2O9q8
	GiiHsEoBIJSN+hAuAoCIrZ/QWuKl+bMpv/MqGSbKyNxMEaSA16woDrNEgQ/zAfhSy7YdJ86Hj3A
	u7SWISYUP2TcnGfL2VhTLP7B+be1L6xNI/5D7IL7oMjvZGfWbJZApkv/5I4MlU0OaTZlXVKXY82
	yfuFj7L/trhmcolUuS5uYJgbNjDuNC/mhIum4XvmAn24LfYrr+An0GtQWd2Jx4U/Va/c9Bf5sOC
	kaCDvFt//kjgf8F3JDOP0DKcu6pcj5Tpa2EsFqEPkdodiu40qf7Oa+BWytR9QAn1Eap/iF
X-Received: by 2002:a05:620a:4509:b0:931:7b8:eb8a with SMTP id af79cd13be357-93107b8ec3amr455545085a.15.1784865352170;
        Thu, 23 Jul 2026 20:55:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f687466esm570122185a.4.2026.07.23.20.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:55:51 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:55:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Sean Christopherson <seanjc@google.com>, Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Neha Gholkar <nehagholkar@gmail.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] mm: mempolicy: fix automatic numa balancing for shmem
Message-ID: <amLhu07IpWfBbWC0@gourry-fedora-PF4VCD3F>
References: <20260629163337.1264881-1-hannes@cmpxchg.org>
 <amGpEEqxoLq/Y7ZO@yzhao56-desk.sh.intel.com>
 <amIcXrS7nGX-adpG@google.com>
 <amIrDncrL4K-JRBO@cmpxchg.org>
 <20260723171515.b5ddbc59c5c36ad01ef8f7fb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723171515.b5ddbc59c5c36ad01ef8f7fb@linux-foundation.org>

On Thu, Jul 23, 2026 at 05:15:15PM -0700, Andrew Morton wrote:
> On Thu, 23 Jul 2026 10:54:06 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > > But in this case, IIUC, this change will "silently" enable NUMA balancing for
> > > shmem-based KVM setups where it was previously disabled (albeit unintentionally).
> > > 
> > > I'm not fundamentally opposed to the change, but I do worry that downstream KVM
> > > users could be in for a nasty surprise.
> 
> It is a bit concerning.
> 
> > This should be very visible in early kernel validation after an
> > upgrade. VM hosts tend to not do much else, with VM memory dominating
> > the host. You'd expect a significant uptick in numa_pte_updates,
> > numa_hint_faults, and a change in per-node nr_shmem stats. And the
> > patch subject makes it trivial to find in a commit delta scan.
> 
> Is there anything we can do to make this process less painful? 
> Documentation of course, but what about detecting the situation and
> emitting a once-off warning?

Maybe a rate-limited or one-time pr_info/warn on the first PROT_NONE
fault affecting KVM in the painful zap path?

Non-invasive, targeted, and helpful.

~Gregory
