Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10B5B5AB
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781568287; cv=none; b=PzH2Ovmij53kpRV8X+kaNBNOe/bPJZjmFOKXc9i+qH/q4NZ+EmbvTJJNaDKpbX4vZmL3NvuF9pqT+KpbW23ex938IXGd4pZmdpqeFwaK/6V4EIvfUjoq15O6/inwF2iz/0xmltEtu1uOtCxyIGuk9zp0HhfCT7A0NTbEwGzDCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781568287; c=relaxed/simple;
	bh=ScZO0zTAhAUUrCPn2ItLGHBxZgasFBIGvOq7yrsaQ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiQNpPvVcoG+fn9Nwygpd67gn/P53ZrRLtCj6mFwTrfj/r7brw1NyE8RpkjQmjfNGEsrEEZBAeiMHY0AkUKWVZTxAlGk2zIUEAduDQO/i4+1FrSzAcU/FLXznH0PinrAYbVvanHZauxnsGQOL95jY6XYhSMqE2nvf2J4gmRzdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLZe5R2x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLZe5R2x"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c67ea316caso11845ad.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781568285; x=1782173085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GHN6z9ynbO2Res19U2YVQS85Id9OG0/5Hx4RzpTAx3U=;
        b=tLZe5R2xzc/wZn+OMFt2Z64ViIUbeiRqwBx1w7/C6Sb9i1Lq4BpSEG+6rJg4dYk5q6
         cyM8mzx7a7zpmzsNnWo4Yjsz3BSnvzNPlfSqnS+fMTvCtxLF+sdp3XKoqFk9OZjrsLEJ
         qwLUZ2NvFuolQZEmSH7pNwAeqkiBf51Pd0asO8mgqAyS5W1JfYakoG1Cewp+1fNwtggX
         EsLZVNpScyUUyIx0AhYjYEo35y7s9jqMV7jokXv1fF3+XudA1FS4yQEOrFmSVgotAxfS
         X1kc7YD5luolHDQXCezs/7XO76TQVtOPaIMRoyC8QRYZRHsEU3d1phhDl6oc51s8nqjP
         519w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781568285; x=1782173085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHN6z9ynbO2Res19U2YVQS85Id9OG0/5Hx4RzpTAx3U=;
        b=o+BA7Yb7ioo+/45l2m/vnU/RNUP8NKg1cXX6aRAPqoGWfHWdDV2y2H7BCom4xQP6jQ
         vg/hasNB1CEhWvHwsydO0Zp7XEgqEnbgyQfKfzlX/9LnM/TbPQrgEMTAXYOWJ/ikiwqV
         69iQnPrj55Mj2WgJC+0g5T1/5/HH7tPNPwMOSu6Qg63v+sdJE2mS8QjXMeuwj5bdgsan
         ScRX6T9CblrG0HdG0HnIYSWFvS3h3meUHvJSgpJHlsGDTrHe4+SfZR6lngatWycTByv6
         gZ7OIWit4kKfkGpK9+doFMKSm0phhTJJ4D5l2MI+eYx3P57Y0zmVua4m0D1kcz9WVIlz
         kbOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZEVk9kL3XMCL0/c0LY3SgwDxME313TiNVJh8e9doQ8F0e/b9YiO33M0JV1eF32TZHYH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OLPYPAMR0UUSiFP/TfShCNwLSQUfraOL3nGHAo8OELA/SMAn
	Ul9eFT60jX9S53PLbgAejrfga9+MrkKIgqcnzCV2Rqu16RmiSuJSbX67gw/p0VXv8w==
X-Gm-Gg: Acq92OEf9gQbWNl+FcMYx5e1FBCqDKY02JKpizP4TSr7Xq+GtSC7VOyKMZWIc8dy41x
	ShHgu+zNePVD3fIjb52fgQxq1mCaFCS7rPy8Af+ycAOkntFPVahIH0UI5DitYBj1gdfEpuAK/Ez
	k1CQBVxJhTI4k1HZf22QQK59Ndmggyhoq4WN0YoYcYcnYmGVQGltLkzFOc68IlLW75Pjdog1Xuv
	CH9Jq82/P7ju7qTLubIIzp4Gi6Emwt1aGRACFmDPyp7uiXMkbpkyKFAEvFX1LZWXPBqooMYlEjQ
	UT0kENW/kiVt0t8WHM6KeyKnB0PWy6SQln/ZyJXfMpPv4VgJUZ94koXzl8YHEfwAhkoZiJsX6vB
	HchGdbesxjTrv/CRShgcX01ekzClFz2X1NCq2bX7/gKafxcUU8n1rnutpDk3SiUnWDqiPdrKmf1
	4jCNsv6E4zCQGC5HcdtfZ42ZfYx1M04qySfCmFQtbRanOh7mjo+vMIlQmEgDdMCDhE3cw=
X-Received: by 2002:a17:903:2a84:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2c69a26dea6mr1202495ad.2.1781568284918;
        Mon, 15 Jun 2026 17:04:44 -0700 (PDT)
Received: from google.com (230.0.127.34.bc.googleusercontent.com. [34.127.0.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b03fd0bsm11119220b3a.50.2026.06.15.17.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:04:44 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:04:40 +0000
From: Lisa Wang <wyihan@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>,
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
Subject: Re: [PATCH v13 13/22] KVM: selftests: Set first memory region as
 shared if guest_memfd
Message-ID: <ajCTGGL2k2FO_Bgl@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-13-6983ae4c3a4d@google.com>
 <eab3711d-c5b1-4132-92e4-7f7040fcd17b@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eab3711d-c5b1-4132-92e4-7f7040fcd17b@linux.intel.com>

On Mon, Jun 08, 2026 at 04:03:23PM +0800, Binbin Wu wrote:
> On 5/22/2026 7:16 AM, Lisa Wang wrote:
> > +	 * exactly like other memory providers.
> >  	 */
> > -	flags = 0;
> > -	if (is_guest_memfd_required(shape))
> > +	if (is_guest_memfd_required(shape)) {
> >  		flags |= KVM_MEM_GUEST_MEMFD;
> > +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> > +	}
> >  
> > -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
> > +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
> 
> The build failed due to this:
> 
> lib/kvm_util.c: In function ‘__vm_create’:
> lib/kvm_util.c:507:9: error: too many arguments to function ‘vm_mem_add’
>   507 |         vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
>       |         ^~~~~~~~~~
> In file included from lib/kvm_util.c:9:
> include/kvm_util.h:714:6: note: declared here
>   714 | void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>       |      ^~~~~~~~~~
> lib/kvm_util.c: At top level:
> cc1: note: unrecognized command-line option ‘-Wno-gnu-variable-sized-type-not-at-end’ may have been intended to silence earlier diagnostics
> 
> It seems the patch set doesn't wire gmem_flags parameter to vm_mem_add().

This series need to based on "KVM: selftests: Add support for mmap() on
guest_memfd in core library" for the gmem_flags parameter.

Lisa

> >  	for (i = 0; i < NR_MEM_REGIONS; i++)
> >  		vm->memslots[i] = 0;
> >  
> > 
> 
