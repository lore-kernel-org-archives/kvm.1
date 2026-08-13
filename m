Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD37431E74
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654922; cv=pass; b=AVKxqU9hMbjzcYGAsidvLfMCZwBwye95frV+Ikui5AXeeugcMx4357kfg6+NMvcKlFk612x5XBxfv1KOe5wkbff+l5U3qZ2SLd+s4t/NuZg5UNw+eJ/4d8da7hK88NV/cRRU0/qDXf68i7a5ypQeFOPs8qOsDMQs5o/AuFKp/Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654922; c=relaxed/simple;
	bh=4zrSQCT5vVjl4UEAlv+oAw5eKuOMF43JfK53dz2A/cQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pid+Mvo+6OsQwc8qtCAgGTG7mThhmfg/RvjEU2V1mwpqgjtEfPn2ewe759/ZaYXwJXdBpaelW25toPPkcoomD/UTBIawCv1mRYYzljuPC2QSaVvdfVaEhGib6WPRdUIMHj05/te/UGXtRdhafE/dbaZZEyq07jPoX7zUMWMz758=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2tTPiCy; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2tTPiCy"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so249166a91.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 14:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786654917; cv=none;
        d=google.com; s=arc-20260327;
        b=oyFYg8uIHgxxCk4MfR5kA/hIs2DS9xe76RapCp4pJBoVm5PxIQI/b1AeM6BMBM4PY+
         eswiVrmgFUXXpqtZzYqzWCF7O2aDYORLlvmKByt+eR9Ipk5Vr5iEjaTnu3f4FR9D0n3F
         6IRWGnQBmPtp7M6w/3YkUnKuKoMUMnhNhsrOLCjqT7RttWsQKpKsyHpGcFB5SFqST4n8
         aV+L6HjhndmHV4+eUQe+p7VbdS7FhkOJ23wUS9BzrwABwZf73WjwijK0ZKkrDS2zJG8V
         b6yYpMxswjwxh5GDtwtvGR4aVix8hL5oJyCXNGG9SFL6Yu+r8Y53Ux82F8PQBLuf2pLS
         uLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=ScWN871Op0fwwgzG1qLzviyqH/P4Azji6iscDLhHJjo=;
        fh=VQ2nlyty4qBgPNncGHDWSaxTyTNar9hGjNFiv7m8yoA=;
        b=devAN65n1+Lqj0bEdicxxLtHKVkqCyxDwlFKDmQkIgB+GciUArhTHenwiSxxNpgCJ9
         Z8czO0WenPQis7Hsr9DqiZE8klCTwoBtb2bE61LmdJlD/yPPZKK7mjaEwa0YYfFzTVsN
         EGfrZ/nbC+9Ey7sRgRzFPU7W5fppoHD68No3+bHZPIg/9ERaDEXtaWRDrgiohf+EKeTn
         ZZFz0Vtxk2fCNcr19IN2pOTAseyIxcegk2WQwlm6KDqhME15r/q/J4HtfBl5XUySfrXh
         4U6P5uuuCSOFT3AMXlGXRkWiRtkoTidrvWkxtgu6RTg2sPMV+1Ijp3iFYA4CK66cti7o
         hm2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786654917; x=1787259717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ScWN871Op0fwwgzG1qLzviyqH/P4Azji6iscDLhHJjo=;
        b=e2tTPiCyhzn5HYv2cDsvj1Jm1CbEC2B1xT7QzEg2dSK116FfrQfKCo4m9IaWHOeyW3
         K/s8UE3DPBCvyhK9xR0E5+WpFd/bYBocyotK3JTkfEKRp1i4SkE2K7PG+2zFoo7j7vC0
         uKtoTqZBSP85NQ3B8aW5WKgH0r9+1z+zPSFPQVvt7Wgd4Ywn8NVtqdvyDzhk0PN4HlHX
         Wv8g1MhgHKGSA2WOs0XYV6l47zZi/qzXyHukDE4t/aV/su1slL0cMYZ/rJwVZIJphClU
         8u7UXgdjl57tzNmJKcourbKM319dhhbefdyZU7/dnCCri3ruWyHdTKhk5tv5oKWsdhS+
         8wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654917; x=1787259717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ScWN871Op0fwwgzG1qLzviyqH/P4Azji6iscDLhHJjo=;
        b=fDG8Yrb3SqfCYq7uVq2Xn9NFyHGVAl1rvvLLvCVAucxsGi6/JvOIvSoibXCrJshHQe
         Sijg2anjP1kL7DdQT3/1a0OaXj6IshR9QJlVbRrsKFVUZHB73ryoRc41tGGHx9SXvaYB
         Ebrb1YCYnONv8xq07C0xQDB0wq6klRPhdVIm5nOPyl847ltXbmGDRrwuNpx/SkUfiZG6
         yFARRwUu75J+sVrnRQ2iH+gn49ojx6MrCog5yto0mxaDFRmF3laGE/3Xid3B1gQ1gw12
         J+I2wr/9+c0nhxvhor9KDFzjxxdRbflA7FN+o0O0hc4a21oEtqkkvxYFM5qxvk+a8LS7
         ePOA==
X-Forwarded-Encrypted: i=1; AHgh+RoQo5DR+7RaDdpwsdeaGw6cz1lTbHOd4KE1NZmvKgIC0FVy3adO3ZM71NU88nTX0/974jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoR7JUyOdTCCZEpCiKeRDvsEahiC5k7YYOT5PD38rMs+BnAse
	IjcGlIR/fLw4QspdV/452t+l9MKYkJeHItV/5viHZVI7naEmtq/MwsuTeMTbUUk4A7zSJ7UW+mK
	3AzXZNGwS370t5nX1yNZhe3n7tNXD5jQPquRu+EwG
X-Gm-Gg: AR+sD10AHlzPaf0YrbHuz9yEGvNDFtE2ZFhNxaAczIV0cKXllKdQQwE8jY/Ame6z4SW
	P5RU+QLSl/lugkWO0u4ug1gzYV89edPgWWgsL/38zYtoF6xYII6reQ7X3N40guH+9kfXnqLw6Vj
	uuDO527qFPyq0VoAVv0M++bFP3mvEqPfEkya3stUhqs/PCJiyc1Xzm4E3voinOtfKPLYWVoX9iE
	+bA5Np4J5YYCS6zRhT7wS0Yvy3HJTr2zZiP2vJwFqG65ymI/Q4tM96XP7JDFYCpHAgR/0C24I1b
	MH1Zinb55Asl/BB4KiUFAY5h+KvienKqfv0FLTneGP9UKSWUEU22GqQ8NZHUb800MeAZ2giRiP/
	5TOhQKIOcBEKpNItAzfZu4oYCx4WN8A==
X-Received: by 2002:a17:90b:3147:b0:38f:1a2e:6e56 with SMTP id
 98e67ed59e1d1-3933b8825fdmr709898a91.9.1786654916555; Thu, 13 Aug 2026
 14:01:56 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 14:01:55 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 14:01:55 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <an3o4h-E8mj6CUaM@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-12-2fc18ee6d3ba@google.com>
 <1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com> <an3o4h-E8mj6CUaM@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 14:01:55 -0700
X-Gm-Features: AUfX_mxCp5gPchMRxL80fZacuO-M5ybDdte9e0UhxtiZjcdkxnSatGLDZOBypz0
Message-ID: <CAEvNRgGpCVCGVjc9jCt9Yr+XypF=71h6eBahkXNkrXhfrtGY+g@mail.gmail.com>
Subject: Re: [PATCH v10 12/41] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
To: Sean Christopherson <seanjc@google.com>, Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Aug 13, 2026, Binbin Wu wrote:
>> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
>> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, =
pgoff_t end)
>> > +{
>> > +	struct folio_batch fbatch;
>> > +	pgoff_t next =3D start;
>> > +	int i;
>> > +
>> > +	folio_batch_init(&fbatch);
>> > +	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)=
) {
>> > +		for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
>> > +			struct folio *folio =3D fbatch.folios[i];
>> > +			pgoff_t start_index, end_index;
>> > +			kvm_pfn_t start_pfn;
>> > +			kvm_pfn_t nr_pages;
>> > +
>> > +			start_index =3D max(start, folio->index);
>> > +			end_index =3D min(end, folio_next_index(folio));
>> > +			/*
>> > +			 * end_index is either in folio or points to
>> > +			 * the first page of the next folio. Hence,
>> > +			 * all pages in range [start_index, end_index)
>> > +			 * are contiguous.
>> > +			 */
>> > +			start_pfn =3D folio_file_pfn(folio, start_index);
>> > +			nr_pages =3D end_index - start_index;
>> > +
>> > +			kvm_arch_gmem_make_shared(start_pfn, nr_pages);
>> > +		}
>> > +
>> > +		folio_batch_release(&fbatch);
>> > +		cond_resched();
>> > +	}
>> > +}
>> > +#else
>> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, =
pgoff_t end) {}
>> > +#endif
>> > +
>> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t sta=
rt,
>> >  				     size_t nr_pages, uint64_t attrs,
>> >  				     pgoff_t *err_index)
>> > @@ -599,7 +636,12 @@ static int __kvm_gmem_set_attributes(struct inode=
 *inode, pgoff_t start,
>> >
>> >  	filter =3D to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
>> >  	kvm_gmem_invalidate_start(inode, start, end, filter);
>> > +
>> > +	if (!to_private)

Should I make this condition

	if (!to_private && kvm_x86_ops.gmem_make_shared)

instead?

Will that help?

>> > +		kvm_gmem_make_shared(inode, start, end);
>>
>> If both KVM_AMD_SEV and KVM_INTEL_TDX are enabled, HAVE_KVM_ARCH_GMEM_CO=
NVERT
>> will be enabled and the logic in kvm_gmem_make_shared() introduces unnec=
essary
>> overhead for TDX.
>> Not sure about CSPs, but in a standard distribution kernel, it's very li=
kely
>> that both are enabled, right=EF=BC=9F
>
> Yep.
>
>> Should kvm_gmem_make_shared() do some optimization or the overhead is re=
lative
>> small in the conversion to shared path so that the optimization is not w=
orth it?
>
> I assume it's relatively small, but it's probably a good idea to gets num=
bers so
> that we can make a semi-informed decision.  E.g. if processing 1GiB work =
of 4KiB
> folios is <100 cycles, I think we generally don't care.  But if it's more=
 like
> tens of microseconds, then I think we do care enough to optimize the walk=
ing for
> TDX.
