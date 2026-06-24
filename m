Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8464
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782259769; cv=pass; b=j9VQ/G6xrCLKO+VMzZndLzEqKriD869bfnFiDNV2x7hysVFHO9aupVCwI0pGBSlUZWKMddxhvXYyXbEVTGoC2zrBbsWN5AqJDER9Ocxl6LwPOfuxBFCeYcFKgFi146wWdcDeN6szCOYZNBai+oVL0RkRVYJgWiXR95CI0+bhwis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782259769; c=relaxed/simple;
	bh=rQfqkBaw/xkmyQgEiFlC2Kezzoeugio7gq7U/cPAgVE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPB1FMLW8v3gHs7goyyVcQ28Nv8DCrjR+4qU5FdNxYyOf94yV9FWYS5+3LTNl4/NQKVEmGlW6L094l/xa1omDqC+4Czc6pAQLt4isNDhI+eeTXK2M9Z+Jha+YLxIlQCRH+UHXT/TR8I7RxPiHYT0M9OWXVcy8iK5s7/q22e4qPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veUsiC1C; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veUsiC1C"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139b5e604b9so540338c88.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782259768; cv=none;
        d=google.com; s=arc-20240605;
        b=CYxF37Ljmh+O3iCAcgjucPWEB7gUNhroudJMFGPt1ahzfMWTYipKtHELib+lG7l1Wi
         CtDd56Ix8P0FUqSpSZhXYxVI4IsW8WR7ktCBHQlb4urqDWbmR15Q+vxVdBRZA3I75mtb
         P8VdZFIYsHAiq09rcccpmVQFKWku8UJ8Z1rOf0ZeuYxwUYdp061sC+d8Azc3xkt1mXQk
         KXenutxGwWH8FtC0ppAQt4GvlOFQ22jWnB/UMAWN5zSibRt+scDwzvIakITvOaLJkCZt
         8Mp/cYD4wm8FnJBts9+5EBzUgye7E9IUyTBHoAQmQDiG+U4KkeHuXZM8iAMtjP0yzps1
         VQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LOf9tviNFkAeKYv+XoLw2pXVKZU7weWckYUjDtw8Ax8=;
        fh=mpnfDqicJm0eSh+t5CToJOsDgAmq+n6r37bwy7bJE1c=;
        b=JD+EEEjjUEG7kR8/Jn1leA5zr0QU1m8PKxDEctA4S4byoJcHK6WkIrjALo0PdCftCS
         V7swS2Im7Rgh5jlROd3LZP2A6hVFFTbNxTyk4AsF6YfA3sgvoSLgG6X81Znazu7QnFTU
         K77EWNLfiPnylZUVdMR/edrV0p9rPfTrjuyvd6tSkbxB4UCyyqd/taci+YKdmy5qkTHy
         QSIF8rwmQSFtiBPf/PbeV306lPkmbauwER/RfjIJTHCUWe8tDlbBi+XfQnJoO3mg84rl
         bTS/GI8D/0gDozK0dVkOguIh5iTcp1eFFKCfYb7gbtJztpBRIl7jrh3Rk25yPr+ziHCG
         VBbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782259768; x=1782864568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOf9tviNFkAeKYv+XoLw2pXVKZU7weWckYUjDtw8Ax8=;
        b=veUsiC1C69EY+fW+phEEcbGGJR1QtHjfW0d5G1V91rsvTaqXDyiTLhXXS9KvXQDxcZ
         oWZfD4aPELOrcjBl0S4WaAofqhRsh7rEZ5pQO3FCfS3ra6aku162Pf0qCkXR+xXopq1O
         IQKeS/G6Yi915cxG1Q5coGJU9a+qvcY+2pF5iSXRniVzMo3wiX9bpO5siiQcu5hv10zG
         IRNmijyT3ZTFPax8idXSgIdxbUpbhO10FVExLS2PxXXeKQXDrr99e5Cw7mM91YAKYLN/
         5W7OT8L10Oa4D+7xzkF7MBH1sJvrlSEyXhHEhhSosvwz7SMH4/WDaSXCQlJ4lOg1Sf2i
         XC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782259768; x=1782864568;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOf9tviNFkAeKYv+XoLw2pXVKZU7weWckYUjDtw8Ax8=;
        b=Gy9keKFZR2SBksqlaf2/QMNv4kLxx50O5qeu8nwaet1o0uxCnCkM2+6U48kNf9+8At
         Je75dbP6NoSx216FwL6mz3hUFRrOnzbA90CHUXa2Ef+VOBXYEINWdPTEGsiPC1ARj1TQ
         XSvP1my6Szlj/uDAuGJmg+PfDZIyG+QTju8Q/D7XZV2CHyVNcDn7fUtz+EzhuM7fkdri
         jt7n4BXX5K5uNXzXdAEqud0xqf/YRMrhofb9VTYL2xCjxW/OBK2EmIo+d0qc9Lg/6FSa
         G9tK5TrgHZuKB8x2Dfvuxetr7Uh49Ryh5kXD5pDqeYDVW27b5/OfCcbIEvBPztT3wAEH
         hPlg==
X-Forwarded-Encrypted: i=1; AFNElJ9sgYrPZz812P0+qQ/q4tL5XFIjuYrYLL8QWLQSUw7tBuGHUc0W/ymmw+8ssgCiHSZW50I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLxz09GF3/MNZ3TryTqOV7JaMTLcgVM4Mpv512r2uHdGEuMrr
	49aDSNvKnJ/H5lqeHnZdtBdMOEjNrDLRmforyp4xjzaoLtsFo5xHBkwlEpGbbWws2PCesA8/Wm/
	bzTbg6Tql8MnCSraj1HQnmrGApVNu9VRJp0wIniYp
X-Gm-Gg: AfdE7cnQ2Bu0vm+l+bhAZ+SnwGhxNatsAK2s1MPjS7EoT5mRFAGmraJzLdH+ajjw3Yy
	cMHF0jj54n7HZEdRBRers12m8uYL9r0iOoa7vO4UsggWvZyVNmM9/yfYJy3MRbYlg80yRQae4HW
	1hKvWqG5NMf2S4WYeLqHci1dLRcSdEE4xRR1QsXJ94hSnqBbpikAfKH7VGhba+rRzomPEf35spV
	901zrk/KERHkgnY1LW44VeQFrrmjpO961GxVE0BMhg6yaAb8pTK6EM/IGVMhzoXBx85AwIaHpR6
	XexcLUxZ+2PHyieY+VVjuHgJ8gsloJ47JRKplK6ma8xLCx3aqYdgzsSyT+M=
X-Received: by 2002:a05:7022:45a4:b0:127:3f2a:af21 with SMTP id
 a92af1059eb24-139c5cff378mr4117596c88.15.1782259766886; Tue, 23 Jun 2026
 17:09:26 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:09:25 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:09:25 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajnjTJdQKD1Kz3tf@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-1-9d2959357853@google.com>
 <aceb07e1-77bc-49b6-a932-5fd9b5a21727@linux.intel.com> <ajnjTJdQKD1Kz3tf@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 17:09:25 -0700
X-Gm-Features: AVVi8Cdk7fD1H5RbfHSz0rAk7YN_q01NbBdLx3di9F5nnt4X6vdgAPFTH7tGEuQ
Message-ID: <CAEvNRgFU4H5FrjQvLMQm9DOQ9ujiHfFfsV6zVKNVi-rzC_zSxA@mail.gmail.com>
Subject: Re: [PATCH v8 01/46] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Jun 22, 2026, Binbin Wu wrote:
>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>
>> [...]
>>
>> >
>> > +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
>> > +{
>> > +	struct maple_tree *mt = &GMEM_I(inode)->attributes;
>> > +	void *entry = mtree_load(mt, index);
>> > +
>> > +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
>>
>> If the entry is unexpectedly missing, returning 0 means the attribute would
>> be treated as shared.  And then in kvm_gmem_fault_user_mapping(), it would
>> allow the userspace to fault in the folio.
>>
>> Should gmem deny such edge case?
>
> After several bugs this year where a WARN_ON_ONCE() fired, but was entirely
> insufficient to prevent true badness, I'm definitely senstive to making the "bad"
> behavior as harmless as possible.
>

I guess both are indeed awkward.

> However, in this case I think we're just hosed.  If KVM treats the memory as
> private, KVM will incorrectly do prepare(), incorrectly allow populate(), and
> will caused missed invalidations (though I suppose __kvm_gmem_set_attributes()
> "only" lies to userspace in that case).
>
> That said, assuming SHARED is definitely odd for cases where guest_memfd *can't*
> hold shared memory.  Ditto for assuming PRIVATE.  What if we instead fall back to
> the "init" state, e.g.?
>
> static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
> {
> 	struct maple_tree *mt = &GMEM_I(inode)->attributes;
> 	void *entry = mtree_load(mt, index);
>
> 	if (WARN_ON_ONCE(!entry)) {
> 		bool shared = GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED;
>
> 		return shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;

I was wondering if we should not only return the init state but also set
the init state, but that would involve performing a conversion to the
init state... Too complicated for an edge case.

> 	}
>
> 	return xa_to_value(entry);
> }

Thanks Binbin and Sean!
