Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2A3B42CA
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782345016; cv=none; b=MfIvdg+ozZmmSDW4o46t1lvaJ217CV72h+oVyB1pVqK6x2g0NkaJV4bp0MXYp1IkrCkoBsYOlqP8TTi3OQmdvKYYs2iTcVtmlkVjuxN18YucE8DfZgHbEmlbH5phxoIz2Tw103699Q7c5WCXdVBz2DvKe7/cesX5pLDnTdR31lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782345016; c=relaxed/simple;
	bh=jFwTgMVyvPSe2l2h8xYHy/RhaF5bRwpBGbC2LGmMwX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn8pnYNIsTouMqspiCXayuUsJwMPDt1JmLYrezDcINm+VzUanyNa2YLNGmHL6RSZkj3+0J0S6n5kD6UUS+6KowK+jcXdnZBBnCuycpig71sEf9eBG9cFxyQa+FVIJ1o8Uvu8kx5gt1CR+f6cQf4feZgBR5WKrFTKUpgLugR6dws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+e+0WEb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+e+0WEb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso21305ad.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 16:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782345015; x=1782949815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=re80BiDMtfSQEgMKbr3zmDreG+eTyRX3VIJM0LJKtgI=;
        b=T+e+0WEbglhMLvcp1R3B6LVjYkz65SF5Zzgyfqo7Uj2JJAXsd17y5vlkoZJSaRk/bj
         vpX7kGr8yDyGH9CqeJ9G++WLVSDut4VmfbH85Zkyo4aa3OVo6ggKrNc3Hbbs3vEDd/BJ
         ncotSJ3kS2ltCsy0AzFrQSjZ07z1tcfPlkcJH1bDveSibn58QApgSJ7CUdOI5Sis+Dsl
         apDwoUHMPqhLSi6NBlhB9iGm2wsTmyrWKdSS+9aWvcfT/4S9NUrqpQyeIhx+ihGQDZC9
         3RrflyKZx90q4iNGb3Ym9Z15425ITP96GOPdi2UHp1RY0cNcyPvo5qsbOJRURU23on+7
         3Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782345015; x=1782949815;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=re80BiDMtfSQEgMKbr3zmDreG+eTyRX3VIJM0LJKtgI=;
        b=C1V1Bf7Sqv38SqIod7Uen9TWvP0yzbVMcF5reaGX+XeH53GvTVgKSid62T25RqIQrm
         nDVTkB9MStv0PBs+MiBMmEyAksioF/dFMaYx3Tl3HJzhWDFwViRNj1kgVoAKJS5mAYh5
         K8/EHXpUjGXpM04qTJWNZhCBBk/IJE0XN4nVljnznvTg/N/qa//imfkql/XeA7Zca/qH
         hF3lbI7l3qhJ3EgVDFhzc3J5ZKQ2c4RUL7uqKtk21UtB1LAUf4miGmk7OnZ4YhnA82Pr
         UASoGTzYqFt/Vokfg8XXp9AaDWu82Ca91GZ2lZQObUQHfP4K3ndPQtTVfljXgLROJhHb
         ZskQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpq0r+1wNTWTOF6SPAlm7kiiMt5oLGvRnk8IN7ZBYv2IUOWV09FkSief4yCLLm8rl6HutU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7f5eK1ZG8k9KCj4HpmJwJDu0zc52h9L4WnYIO7N3cA65o7G2
	0AaQBBAubkSbA6yDuUvYbzWOsKrHvVOT5SWcZOal1Dvxt2KNY62Qc+rPYFcDc2bPig==
X-Gm-Gg: AfdE7cl9ggDLVcA9/Jtra0gFKjyMqO6IfEMzgs31BZjCkLa0tvAIBR3Fczr+k73iqBj
	foePx2bW5ppPwjGbA9gYJiJdM9PIYhlYdtNFKKt7RhwLXziuKV6Zt21TVrkoXekEE5ytpPHKgT4
	EdMr0HYcdjOi3UxdJ5QSZJXsbZaQlwgFYHoL4S75CZwvvgMqqnv9oo8ChQWaocQ/9EXqFYNp68e
	l+IPf9G9rkGs3BuvkZlnD6QZRuTW+8dFH7Zs2HNh2AMPEXrJtgAW3xndF457fwcG2QYWPvDaAf3
	Di0GiQugdWtEGI9KjbVqdZA7HlQ5RqitMpZPPbOGuvnCZ/3rQVtxIIPUTslySitw3Elcb+CTIMc
	TgFZ1WPGqtEkHYjp405gJMvOGmPbABw4DirZ+m/cTORQNL3MDmvCp6opLS7TcoiMXM9dLFEgSHd
	UnL6dlbM8+YyBQEzJz1D5sSdAmA7+gH5EaaAxHyN57r3g=
X-Received: by 2002:a17:902:f687:b0:2bf:193b:a195 with SMTP id d9443c01a7336-2c7fae6b840mr507585ad.11.1782345014009;
        Wed, 24 Jun 2026 16:50:14 -0700 (PDT)
Received: from google.com (74.67.83.34.bc.googleusercontent.com. [34.83.67.74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1df037sm546294a12.17.2026.06.24.16.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 16:50:13 -0700 (PDT)
Date: Wed, 24 Jun 2026 23:50:09 +0000
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
Subject: Re: [PATCH v13 03/22] KVM: selftests: Initialize the TDX VM
Message-ID: <ajxtMdOFCPiMU0Pw@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-3-6983ae4c3a4d@google.com>
 <d27cce6a-da0b-46dc-96b3-5f2f699907eb@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27cce6a-da0b-46dc-96b3-5f2f699907eb@intel.com>

On Wed, Jun 17, 2026 at 11:21:49AM +0800, Xiaoyao Li wrote:
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > @@ -11,4 +11,34 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
> >   	return vm->type == KVM_X86_TDX_VM;
> >   }

Thanks for the review. I will change all comments for this patch I did
not reply here in the next version.

> > +/*
> > + * TDX ioctls
> > + * Use underscores to avoid collisions with struct member names.
> > + */
> > +#define __tdx_vm_ioctl(vm, cmd, _flags, arg)				\
> > +({									\
> > +	int r;								\
> > +									\
> > +	union {								\
> > +		struct kvm_tdx_cmd c;					\
> > +		unsigned long raw;					\
> > +	} tdx_cmd = { .c = {						\
> > +		.id = (cmd),						\
> > +		.flags = (u32)(_flags),				\
> > +		.data = (u64)(arg),				\
> > +	} };								\
> > +									\
> > +	r = __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
> > +	r ?: tdx_cmd.c.hw_error;					\
> > +})
> 
> It looks __tdx_vm_ioctl() can be implemented as the static inline function.
> 
> Given all the existing xxx_ioctl() are implmeneted as MACRO, I'm OK with it.

Most vm_ioctl() and vcpu_ioctl() used MACRO.
I prefer to use MACRO for `tdx_vm_ioctl()` for the `#cmd`, but I am ok
to change `__tdx_vm_ioctl()` to static inline function.
If we can only change part of it, do you think it is better to change it
as the static inline fucntion ?

> > +}
> > +
> > +static struct kvm_cpuid_entry2 *tdx_find_cpuid_config(struct kvm_tdx_capabilities *cap,
> > +						      u32 leaf, u32 sub_leaf)
> > +{
> > +	struct kvm_cpuid_entry2 *config;
> > +	u32 i;
> > +
> > +	for (i = 0; i < cap->cpuid.nent; i++) {
> > +		config = &cap->cpuid.entries[i];
> > +
> > +		if (config->function == leaf && config->index == sub_leaf)
> > +			return config;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> No need to introduce a new fucntin. We can use get_cpuid_entry().

I think we cannot use `get_cpuid_entry()` directly here.
This function is called by `tdx_filter_cpuid()` to check if KVM's
supported CPUID entries are present in the TDX capabilities list. Since
the TDX list only contains a subset of CPUID leaves, some queries will
naturally return NULL (which we want to gracefully filter out) However,
`get_cpuid_entry()` has an embedded TEST_FAIL(), which would abort for
any missing leaf.
How about I add a `__get_cpuid_entry()` to share the same part of them?

Lisa
