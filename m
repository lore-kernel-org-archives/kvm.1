Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF56255F2C
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914442; cv=none; b=B7SypipqKQMC7NnYW8zjeKrukROW+Ycor+7ehm0TvGeJK/U0XUapVArNVV6OK3r0wWVM+zR1YN7aFfCOkjIvlh8ajhQHSGHfR+xxBzDdpdDw99I/9q5reP9s+/0tNLjfJYllS5SNiwhh6ceZTgtXhckd6ggJCrJBUZr8vq6zfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914442; c=relaxed/simple;
	bh=4+CF4D06wokhU4O+NifMVK8cQYxNVxqRt/1c9XuJGcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ERO9iG1u9LsbixXJpKQE5EmmgiTVmuPIbYVD3JZblIM2EX0C/0rnEBZYyYrAa9IAYj0JueY+EcYStbOr3OtlcVpmzE+MiUBt+SJHcvnQ/kK8gdPRPgSOnU35BnFytCRWv5LAmYghndPMEmLdKQDmKju8IZY2zgiSODOnp+GeGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBI1wK2h; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBI1wK2h"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so513518a12.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782914439; x=1783519239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXus0JUDYxgkQTMchRIbdr+tq1wNp1blaxpaHfy1IqU=;
        b=pBI1wK2h/v5oQYqF7Xo75dRhoXMpCTvO489/ixFRu+ABpEJahsNub7Gue0w5DUdTBm
         xqaBOla2NXJvDNgJidKPbocq6L3LBVr335ukNFp8WLaXFpTxnMMXOt7c8kk77axLiMJF
         1VEFmdWPQsyRNvUlOQBNaGJBEG/97aREQdxoMiQbvP2WG1EjMQIGNFP1f4p45lQgvmTE
         myi0qPqF8YrMWPjBYoCfYg2bSFRLrDC4x/KaTcw4zzB7aSIySAD+70HMoo95INcdRLfZ
         TRP6NZ/ZuM048cCIxsNzFptiDejtbl60nsZlVdk4YUEPctggcpHg1vjznJImONYBFB5g
         +zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914439; x=1783519239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXus0JUDYxgkQTMchRIbdr+tq1wNp1blaxpaHfy1IqU=;
        b=UTtTbcki7v1m8YTGd+WePf3Taxo/wfzDjG9RdR49ficXL03TQBHvJzblXNez1z/IgO
         PM3FDzR7CIxf3M+gNY0QYPYJNylcYWyz962ebsFUUh+Me+8bdNlg5/RlSW7RAqaF7BKs
         ekpL+Wq5mbqRtonGLujj/4e5DhvgBxZ/hmwnZnXT3LeXryOgG4P70amuYDXH4QUxOwaX
         yUbta0d2tpO94G4OU6x0oYJCKgdxamwOjhcg5Phr8wv967eV4747DKzj5vGdAinpO08W
         q0T8uURYqyl/GrM/vi2qB3gbjJ82HkuWMGLQPkBhyDVEP0VfnQa6KKWdgSxRrjbrdG87
         kWMA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZcrtQk8a5Gux5jBnF1XaFI2J+zQ9tZa5chp/TK8Bi0GaOyezUll279w7aqCNdWZR+MpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtwscq0+fHgkgz3d1Yaw1uAoiQbZMr8XU8hOUKprN03FO9769n
	D+Yt1inuPHYaqQUSYbu6Rz0VoH74UJgctsEgOGMKcSLJADMyWSiyqc2QYxu2glw4Wq56ZAtgmgX
	tev2KeQ==
X-Received: from pgbcq12.prod.google.com ([2002:a05:6a02:408c:b0:c99:a30a:7619])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a20:b0:3bf:a1e5:ff62
 with SMTP id adf61e73a8af0-3bfed592b05mr1757052637.47.1782914438635; Wed, 01
 Jul 2026 07:00:38 -0700 (PDT)
Date: Wed, 1 Jul 2026 07:00:37 -0700
In-Reply-To: <81caa42d-9d07-4bed-892d-c24e0b298a1d@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-13-6983ae4c3a4d@google.com>
 <CAEvNRgEBiivp9tOHZnFmWvF6ek-Ar-m2B+hb=-H0dgAcM2=z8Q@mail.gmail.com>
 <f8937d16-4aed-44d9-a058-beff56eac4ad@intel.com> <CAEvNRgFLjt+-cO-XT0s8uW2xXgyd+VVZ0g0Os6V0+LBFQzx8cQ@mail.gmail.com>
 <81caa42d-9d07-4bed-892d-c24e0b298a1d@intel.com>
Message-ID: <akUdhVsIb7BEqU7z@google.com>
Subject: Re: [PATCH v13 13/22] KVM: selftests: Set first memory region as
 shared if guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Lisa Wang <wyihan@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Xiaoyao Li wrote:
> On 7/1/2026 2:18 AM, Ackerley Tng wrote:
> > > > I think this patch should fully buy into in-place conversions, so we
> > > > need to also set GUEST_MEMFD_FLAG_MMAP:
> > > > 
> > > > @@ -483,6 +483,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape,
> > > > u32 nr_runnable_vcpus,
> > > >    {
> > > >    	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
> > > >    						 nr_extra_pages);
> > > > +	enum vm_mem_backing_src_type src_type = VM_MEM_SRC_ANONYMOUS;
> > > >    	struct userspace_mem_region *slot0;
> > > >    	u64 gmem_flags = 0;
> > > >    	struct kvm_vm *vm;
> > > > @@ -503,10 +504,16 @@ struct kvm_vm *__vm_create(struct vm_shape
> > > > shape, u32 nr_runnable_vcpus,
> > > >    	 */
> > > >    	if (is_guest_memfd_required(shape)) {
> > > >    		flags |= KVM_MEM_GUEST_MEMFD;
> > > > -		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> > > > +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
> > > GUEST_MEMFD_FLAG_INIT_SHARED is valid only when the memory attributes is
> > > per-gmem.
> > > 
> > GUEST_MEMFD_FLAG_INIT_SHARED was introduced before guest_memfd in-place
> > conversions, so I think it's orthogonal to whether memory attributes is
> > per-gmem.
> 
> But before gmem in-place conversion, i.e., per-gmem attribute,
> GUEST_MEMFD_FLAG_INIT_SHARED is not supported/valid for Coco VMs.
> > > we need to check KVM_CAP_GUEST_MEMFD_FLAGS or kvm_has_gmem_attributes.
> > I think we do want to deprecate the non-in-place-conversions setup, so
> > how about inserting a TEST_REQIRE(kvm_has_gmem_attributes) here?

No.  Unless supporting out-of-place conversion requires orders of magnitude more
effort than just supporting in-place conversion, selftests should play nice with
both.

> Well, then all the TDX and SNP selftest will be skipped on the kernel with
> gmem_in_place_conversion=false.

Exactly.  They'll also be unusable on previous kernels.

Deprecating per-VM PRIVATE tracking does not mean dropping support.  We won't be
able to drop support for years, if ever.  And so from a testing perspective, we
absolutely need to validate both models (again, within reason).
