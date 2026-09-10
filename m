Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34247A87A
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051625; cv=none; b=fE7IpZIM1qroSKw9BTi7j8nptgdD1/jIGutJLgJPUWYmxPqFOJpRPmhBMdXFg8FSmPAjZKSngtyoUxjNV+a0UrHcybCuOFgiTSPA3qCB0t17yLx275eCPEt9tzOA8n2zDHkQZK6kI/yNIweK3OZDGnyDwBpaPid/nZRjk2PcExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051625; c=relaxed/simple;
	bh=h8iMGTXNDfX416b2xMAs1icLiy2Uqo2H7u5+lxwE2RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6a+z581lFs6Vs2P/S6rQDwSikG0VFDEWsrlTDxVZvxydHQvpPcvci3x4GmgtdsdactD0s8Il+A8EQExgG4UZWxqjZtBOEuKzVVUTnqYwjsGwkcViXUQBxHmqquuzN0jg/xG5PdQTi03FaWDXC/vsOmXKUT85IS2g4CGqrzFisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jJ+qeFzO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jJ+qeFzO"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9399d91ee7aso556781385a.0
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789051622; x=1789656422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kKkfTdA2RhAgMUbRVAzf0FG3CakpaY+N8UoEfITRbZc=;
        b=jJ+qeFzOZisIC61FODF8T/Lvvbm58PRoJAFp5egn/iacWl2ZbLqfekB4/dzC/QyZUz
         ETCZM6+WtNa2fedVTROcsfeKvhSG4BAXNjrcYqewGUwL7RbsHDTHqdh/A4Y400Se5iJg
         cStvWvyRMjFvJ4gYRD3PjC7VLCrpvrDe5t/GXGUrzksCVO9N7PgIO/kKJPP4pieR8kxk
         lT/8raeUqd6zWYJEaLyTeiVLmo9KsIhjXK8CmJdtvlZ8EkT0y6vGWmXq3o81QnvnT/zi
         FPgNTkXvO62Vem3n4BSzI+exFyraI6Cd5br9DBawia6/av1zXMiWBNuOpFKWn8jFPh5h
         gCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051622; x=1789656422;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kKkfTdA2RhAgMUbRVAzf0FG3CakpaY+N8UoEfITRbZc=;
        b=Mn8eTA20F8lRx8rgVQQOpq+GC5wGk8vD3Y+fkhja68hEHMgnNKEB7SPOw8H/LzqH/g
         JRuOlMumBmAB5t6A5VvePj0MK41cDxYW0CWU6EqSTiSj4m5/FZfWreidbpcpWOw6cDCx
         RVLFPVTsS+Hn9VAOafYe7MK61QxwnSmv+XFbJ3mXiOBEalvwJPo+Ng52viChMiKwdVzy
         NicvkL1jej+tuS7biWYTo/19+1MP6EsPN9i7wDMRqx+Afx0Uje9dXg/UL3Zj+DiqTct7
         +ETpORF4b9/xAqDOP5FJDFdRm2i5857xiKk9RHzYBYHLjWlaBjEB0S5tqHRmZRvyi2lk
         VgWA==
X-Forwarded-Encrypted: i=1; AKwUvBxzb/gLFLC7lo/8LgYpwfTiLRIiUvCY0maguD/Z9ePOO5o0qVRaEgoNR+lqqfeW0Io0lV0=@vger.kernel.org
X-Gm-Message-State: AFuF++mAtQgD/jxnXbCwrJ00kHyqiTF+TIFRih+N2gREMFAM2qBKBvDa
	jXOACDu/3WHD46MYHXJMml5J29YqR7+WHsLDXXtKIIdwI9jy9s3LOuZ+9FP4zq5XV3w=
X-Gm-Gg: AYBFou3xqOtJLm9EzekmfBBEmJvBGSgTXYWqdhhduaHu/yVPszeKJlO83+Zunis9JEN
	2FeYTWFOPeyVsBik1moN2qrW5eSWpyrV6vUl9EE3jxZ3AEA1Pt2RGcHxbTNa8AeNR6zVMks4zGg
	BC229Sy+MpqrhY6k6zDiqxblqVpSYE5eBPbdKEfBBdPU5lUApRs69TpSWMJWode1syOCLAaUBdb
	o/kZVmIpwdGml8wgTjvL0y/SQqyul1dkMxiSI+o5dqzOg6DhA0kHCBYXUbvCmbTMJTe1vtv2TIk
	3BaM46o4KZuHlwBhFPVpLUd+uIcLFM53/6+gKAwYeWsSgJcU5ng3eBJr4icX9/aPYMvKBNWHSGp
	MAVyvbDD6I/+kd61H3rqYQ8a1FJ1+04hXDJV5/n7Fbi1wz1otJGejmsndTMD1UIEac6hSSPylbi
	SHNJwUgqAt/bipTyOatU97wQozad6VR5AZvMAdIqEFAYfeY7wbGPPkOlSJxxFXxBGFYQlmSgGIT
	6/t3XdjusmDFp48rXGfi85cu9Usrr0P+qcdadtadu39gGw8T9KkMRk=
X-Received: by 2002:a05:620a:46a7:b0:939:744:b5a3 with SMTP id af79cd13be357-939806da02cmr4694331285a.29.1789051621645;
        Thu, 10 Sep 2026 07:47:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7da5f59sm1310085a.1.2026.09.10.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:47:01 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:46:59 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	pbonzini@redhat.com, seanjc@google.com, akpm@linux-foundation.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH 0/5] KVM: guest_memfd: bind backing memory to a NUMA node
Message-ID: <aqK6aj44Tn3bilry@gourry-fedora-PF4VCD3F>
References: <20260902194657.79075-1-gourry@gourry.net>
 <9b67424d-70e5-442b-9ec7-22b1d3db12f4@kernel.org>
 <aqKzIO3DD66Dhkdw@gourry-fedora-PF4VCD3F>
 <6285ebc9-fee5-4f51-9ce6-b840f9dba65a@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6285ebc9-fee5-4f51-9ce6-b840f9dba65a@kernel.org>

On Thu, Sep 10, 2026 at 04:05:36PM +0200, David Hildenbrand (Arm) wrote:
> On 9/10/26 15:40, Gregory Price wrote:
> > On Thu, Sep 10, 2026 at 01:30:04PM +0200, David Hildenbrand (Arm) wrote:
> >> On 9/2/26 21:46, Gregory Price wrote:
> >>> guest_memfd allocates its folios through a per-inode shared mempolicy.
> >>>
> >>> Today that policy can only be set after the fact, with mbind() on a host
> >>> mmap of the fd. That requires the fd to be mappable, and it cannot reach
> >>> folios that are only ever guest-faulted. Neither holds for a
> >>> non-mappable (confidential) guest_memfd.
> >>
> >> That looks like an investment into a mechanism we will soon consider legacy, so
> >> I am not convinced this is the right approach?
> >>
> > 
> > Hm, I think i've missed recent work in this space / this context.
> > Any suggested reading here? Don't want to eat too much of your time.
> 
> So the big development happening right now is in-place conversion (having shared
> and private pages managed in guest_memfd):
> 
> https://lore.kernel.org/r/20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com
> 
> 
> The final series where we added mempolicy support should be:
> 
> https://lore.kernel.org/linux-mm/20250827175247.83322-2-shivankg@amd.com/
> 
> (I think you are aware of that, you commented on some)
> 
> See my other reply regarding the use of GUEST_MEMFD_FLAG_MMAP on private-only
> guest_memfd.
> 

Ah yes, i do remember this series.  In fact...

https://lore.kernel.org/linux-mm/aPD-dbl5KWNSHu5R@gourry-fedora-PF4VCD3F/

```
So this inode mempolicy in guest_memfd is really acting more as a the
filesystem-default mempolicy, which you want to survive even if userland
never maps the memory/unmaps the memory.

So the relationship is more like

guest_memfd -> creates fd/inode <- copies task mempolicy (if set)
  vm:  allocates memory via filemap_get_folio_mpol()
  userland mmap(fd):
  	creates new inode<->vma mapping
	vma->mpol = kvm_gmem_get_policy()
	calls to set/get_policy/mbind go through kvm_gmem
```

And quick skim of in-place conversion (wow that's dense) 

```
  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)

  Set attributes for a range of offsets within a guest_memfd to
  KVM_MEMORY_ATTRIBUTE_PRIVATE to limit the specified guest_memfd backed
  memory range for guest use. Even if KVM_CAP_GUEST_MEMFD_MMAP is
  supported, after a successful call to set KVM_MEMORY_ATTRIBUTE_PRIVATE,
  the requested range will not be mappable into host userspace and will
  only be mappable by the guest.
```

I guess the thought here would be something like...

1. create guest memfd
2. mmap(fd)               -> prior to full guest setup
3. mbind(buf)             -> shared policy hits the inode
4. munmap(buf)            -> policy is NOT reaped
5. set ATTRIBUTE_PRIVATE
6. no longer user mappable

That doesn't seem unreasonable

~Gregory
