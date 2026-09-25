Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238E2DF6F4
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373869; cv=none; b=NZ6rIQldfd9S0bKRe56ND9Ze29ciAvrxXiXaIa64+ZfuAe+scyX8lLN9pb3ezn2VoZZsiqrHtGidl5J7najN1YUwHk+qE6DYSYeV7KuB71+C4F8mlSzYBfq2EcRSb0Erb5oM4PLUgOwiShEK1+t62yS/YR9Jtfs1G95EguCDmgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373869; c=relaxed/simple;
	bh=HAP/sFklTJPiQKLsjznjzZZN3nbst3jpCvp5m9djKik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k59xNjjqL5jxlFT44s3dGVLuiqqaoxnMztRMGBAnqK2PFF4y+HveBpvOklBdL6gU8Be1E87dA3bcmfWJOVwKhMWHDj0RM2MVmjfAs9Xqt2tdWWczZ54YcdQKe7heRkV3i/+vghPdbG63t2IZFYqiPMVTZyhKPxTh+UID9XH+rM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vn3bnv/r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vn3bnv/r"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d8facae850so21445ad.0
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790373867; x=1790978667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ksyuSwUH2dGx1asD3+Rht2rW0CHu4s19+UlL6wUtms0=;
        b=Vn3bnv/r56IioWKUSiP5ascRSINxgMXtSxvPJU+Jch8/YXzNS8HcmS1cO3AQJrypG7
         DxY0YWyv40gN9phTHEV0agjk+7RMqnoGZ5RYUxyDfjgYl3OgKb2Pj8tZjwmFu9ir3Xlc
         0j0a8U4Skwl30PTHKzrv/TjGUMxZQIgF1l6opYcQ77SaQqQl2gcp1FMHWWEjdsjwpUb/
         rko4FOMiyKaV9RS5lAkzQZNVxSdZio293+5Cem7ZtUBsahg30MyhWPkYr+oFrhI6Dsdd
         B+nbtPmlRrCv/+nLFNZFpALELn9TfoK9pDD4abC1fXaaBVsiEre9kjUcfrWiFrdpyGkX
         +XGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790373867; x=1790978667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksyuSwUH2dGx1asD3+Rht2rW0CHu4s19+UlL6wUtms0=;
        b=B363Gm8aJBEYEAYaIJ7Dtbj6CfuOxogIpK7QQTkrUQBsfGN/U2AUsVjksus6ETLdCq
         hvTTzQ4Q/LOEubPiPoqxhYy2/PNnEXr9ZAGPWEIxcFmsnaDsoM0tS8iX5vWOxCkOBEHJ
         GdnSvrgAcGZjoUAvRbqg8DnLvC9RM0SrWZoSb+n8V4zmBIJXZgWV1LlnXGZhsftLERXd
         QhyQY1uTY81dxUaCR1x3zDgDarUl+abVV7t/lFQqsVklgPmV6Sayb5cApd5otLEszDBb
         TdZg1+6wGWbXPrTbkRb91n5ZtwWuL1lGdAaknqLUTylQHnAg2jSt1xY/Cb8/7Hxthg2h
         72RA==
X-Forwarded-Encrypted: i=1; AKwUvBwVHMI4sxsaDeY7LU88pHDV8SF45LBofwPVhhyg1WFIMx3ufZfrxKrpNCYJ3ORLTX4cwgI=@vger.kernel.org
X-Gm-Message-State: AFuF++m6dbBB5c64KbGEjshZ9SzGwRrhOozp3WDgdBKr9aDhnTyGSvE6
	A+8PtZXksK525jLbWNuHPQAyv+mJhbSOlGSTU+eNJHHb96elkjy4vNaWjX+Pt9AjtA==
X-Gm-Gg: AYBFou2tv7RlivpJztAOvqQ3+OOHZ2vaP1i7UCEdjcd+ZLjdLoLbEINIOKpQjg79GlP
	r213IMw9zlH3PH6YVuF/gm8g2fndOhPXlqeoZyWwm+NNn8hNWABn0CSUBxlMtTWQ6i7bQBd2tZl
	yRhpjEpb0ScKSGWbbS/MwWIciLuhsraZ9xH9/qSdrUfbinu0uEx/d0GK+76nhQe0gMbwp0zIfvk
	5p2cI+ogKz6XigEr2L98s5xm2QkXh4Ko2Z3E9tOfDb0cRW23Zflw1BTrHxUaI/rEi8Zt6CCtDfA
	cNGWtKzZ2B/aJGo4KYfoWCWiGvophCh4JJXevmcYDOmzTZFKxB7QkSOrEEmce4r5jOzGT09QqT9
	BvY72p6pN077KIUDbOkZVgNKELpux0fSRL/lMeEr7JZpOO7Cp3hJybFL/mmzHQ01A+xeS+HqVim
	GGJKWmYq2vUToVgrw2nV2R9jgu6uX0IQdSB18N7VmjpXyPky+EiHjbkVI9/fLu43lZhkl5l7V0B
	DyUID63Q1ev71wN9evdjPhU/Gs9a/7S
X-Received: by 2002:a17:903:46c6:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2dfa968787fmr718815ad.1.1790373866593;
        Fri, 25 Sep 2026 15:04:26 -0700 (PDT)
Received: from google.com (230.0.127.34.bc.googleusercontent.com. [34.127.0.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a097663fd0sm12373594a91.9.2026.09.25.15.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:04:25 -0700 (PDT)
Date: Fri, 25 Sep 2026 22:04:22 +0000
From: Lisa Wang <wyihan@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>,
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v14 12/22] KVM: selftests: Require guest_memfd for TDX VMs
Message-ID: <arbv5jEZ439Yo_UE@google.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-12-15ad654a50db@google.com>
 <ef53ccf8-00c4-4a50-985e-425a2d40583d@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef53ccf8-00c4-4a50-985e-425a2d40583d@intel.com>

On Fri, Aug 14, 2026 at 03:42:48PM +0800, Xiaoyao Li wrote:
> >   static bool is_guest_memfd_required(struct vm_shape shape)
> >   {
> >   #ifdef __x86_64__
> > -	return shape.type == KVM_X86_SNP_VM;
> > +	return (shape.type == KVM_X86_SNP_VM || shape.type == KVM_X86_TDX_VM);
> 
> Instead of updating is_guest_memfd_required(), I'm thinking how about just
> replacing is_guest_memfd_required() with vm_arch_has_protected_memory()?

vm_arch_has_protected_memory() returns true for SEV, but an SEV VM is
expected not to use guest_memfd. If we replace is_guest_memfd_required()
with vm_arch_has_protected_memory(), we need an extra test to ensure
SEV VMs work well without guest_memfd.

Thus, I prefer keeping is_guest_memfd_required().

> > @@ -27,6 +27,7 @@ static struct ucall_header *ucall_pool;
> >   void ucall_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> >   {
> > +	struct userspace_mem_region *region;
> >   	struct ucall_header *hdr;
> >   	struct ucall *uc;
> >   	gva_t gva;
> > @@ -37,6 +38,13 @@ void ucall_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> >   	hdr = (struct ucall_header *)addr_gva2hva(vm, gva);
> >   	memset(hdr, 0, sizeof(*hdr));
> > +	region = vm_get_mem_region(vm, MEM_REGION_DATA);
> > +	if (region->region.flags & KVM_MEM_GUEST_MEMFD) {
> > +		size_t aligned_sz = align_up(sizeof(*hdr), vm->page_size);
> > +
> > +		vm_mem_set_shared(vm, addr_gva2gpa(vm, gva), aligned_sz);
> > +	}
> 
> this diff about the ucall needs to be a separate patch. What's the reason to
> add it to this patch in this version?

Thanks. Will separate in the next version.

> >   	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
> >   		uc = &hdr->ucalls[i];
> >   		uc->hva = uc;
> > 
> 
