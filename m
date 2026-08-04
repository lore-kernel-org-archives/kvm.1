Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F903468C2E
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851185; cv=pass; b=gkiUgSEaxnqMA1JWJGd/ZfsibKM+9f4ImpGKWc4BtClDVL3sXXB+CMhQKKklNiUAMtV3f6O7H2VBOkqam4Io436je8w8X83HnCY1dnCI7twDkY6GOivs9UnX3SmyroEx8EKpEOFJDvZCzWBtzlDdDncOjyLQiqm/VPJ2Cud5OW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851185; c=relaxed/simple;
	bh=G5AgHHHY9jv0ygOB7Vo21BSZnxPwBZqAq4GmulyN/nE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcoYXi17+lWdTMsSCDZ8fBIPmA/7890XDgCxKQxj20gci74Y0VOQeKxUk4lOOdNBNTGOmP2I5RvGHB9Zp6iyREO6wR/JSsegbbCUfeDQLM4KDOYrcj3v4ko6jQT7kNJFSrbypqoLN+eBfR683oUWNm8GmvNk4qwZK0/d9aj6yLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqlekOsZ; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqlekOsZ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso2840316a12.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 06:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851182; cv=none;
        d=google.com; s=arc-20260327;
        b=gJHxePjsiXEN5VU48Xes0OoarkojIsyasfBXlcKH7Z7bAkILZuUtIRKhN/yNL6Inqr
         Cs8EpCLpuBV7oAe9n4A6s5M1z3hHz/k1Ex6vbRmhJKI4mANFSjBfeWfrAg3KOq1/lOgU
         Dl4fwSmgvJz9ChLfZzY7T/cUbK6LkIkuIga1GwUmF3k5BWTKoTcqkXqWtxbWnLntRxJw
         z4jjmIp0w3/4fyStr44QG92YoZv9RcyrCcp8TCJqchUuNkJDzcpbVlDt7PAjK89x/MC0
         qCr14xUPThQCfqKUgWnIpilvRCC1rmuOgs/LOYX9FCq+8qPa57cQCN84WWy4+dCu+4Pm
         A+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=53G6mJGAaV7ofRwgRemJGkr5zkTXgvKFenxfcvtRtyE=;
        fh=VKhsv+ir+uADAWUJ2PLB+2Mmt+1iEAof75IyxaLORUw=;
        b=YU1tGnMo8D3wVfNps3AHaMmS9ygrZl7GZF15DE/5yqkgk/+fkeb/lTUslX+nxXWXjU
         /LfAqICcDMWgqEH2zocjtutopbBMvmIy6/ZtP/7i9gZ8rLShNg/qxyWTzgJG/nwsHf9T
         EskQpVt/b/uFjKYb9dTG8ojhjYTe3Eo+VPwuWrl3Xc0RYmhXfRMEFC2cM0tOr+XGKJnq
         NkNzPi4HB5Y9Mb6a/SdxOKZLSO0RXrtiHeiXZ8vWygUjEyMgcpXDqk5R0Nx8HJaOqaLJ
         q8VeNpkltSQpFUe6lGeT4kFmSzt+5kKXVluv4uM8JWKpx0kNbiIo9JNAP85vp9jHhLQe
         JPMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785851182; x=1786455982; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53G6mJGAaV7ofRwgRemJGkr5zkTXgvKFenxfcvtRtyE=;
        b=XqlekOsZRglZftD2ptxrZu3uoozVSQvDOl2p08SpnYWJzmu9DTJeFsgq8+uEMsazyC
         NkkGBIYU+sF18XZ/MVEMVEj3q1eo422cNCkuNM5ssGyDYzjMJ+xg4ISHCJbKob0qNJnk
         IX20e7rI1LLtZAdcqYzpct6QNlxyOYNYN0fwHQ03OeZ1q1TSHkzSIrlMzyUACkv/xpdZ
         MZzkHy0TeS/LTFJNQQY6BwUK94OYpn5a+5hDMIPYOin0Io2lXx2knouuxaOKc/tCwGrp
         wk/pfgkmjMlpnDego0X7PbYvDzAGxwynFp861knzLZe98s4myQFC012qVhZVKWweodfm
         s2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851182; x=1786455982;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53G6mJGAaV7ofRwgRemJGkr5zkTXgvKFenxfcvtRtyE=;
        b=Fzx4U2GECKOyWSBxVAcJ0GI641zYke5YG/4kEUzf0miai2lxgRIaua/feaTyhF0pC6
         k+7YPqeXUKi98JypeCIyuDLtkpa6jkb+jDB7hG3WtEHrU8y2wFVX5farZJSUMV/Si2jl
         wsoQvp2MMiPQKFqbw0gRfNVrVr1VZHhnzRubYwPST0O3RkI+fZVHduSNHj8Q4B6+Zyl8
         bHgytvsdaMVijYrmFeR/kyh4xkWzaBNf+CeEjjR2p9RvNkEX9dgirIogGLCztjXt/Zj5
         RPomCMOzM1ayi6zm2bVPvtzZfixbT+hnfLomSc5KMjJUb2boDizIdco6sBvjuKvb0WFg
         kVrw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+ejWUohCo5hHTSRlHRE2bsmHDkxyr++zHAHmER6A6c3tSzU99oWnt0Pf46ateROIDmU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTaMRyLRSwsdA1zAZ55zxbA7zeOtuj32hM1WTGiwkwQBZbQYQu
	2ngB5+n5Zx1tNgJnoCQ+zM5yQ+piolUdeakmYJeLwyAFZ0NWxdFaAsp33sksQcfk0AbXADlpvnm
	3iZTziVJQUw24v/b8aoydKN7S46mo8t2yH0epuOiP
X-Gm-Gg: AR+sD12p3aIN4YCOG3e8peOYtAo9L1vY6uaXm5jjHDIstmA/DW+3UD+xLYoKIuAzLrR
	0YNlm9PXZNjn59dMJgkGYpZvp+tL3wlqiO4Gixx82wa/AXJpWhnTfPbxNBfssfCyo6TDRQQRS51
	nopGQK0pS8mYReLyeoh2DXa72TVd80OCj0pI2MsosZVNDwhiXpPDh+yR1GhVqV/FJxxETkEyUgs
	d8pkxkowcCq2Usnz7qvotsv6vfJVsH3O2qzZEeicti4xPoncvy3OVEMW8G9LqcX7hOADwSdrsdq
	YD41jRztkFdNfE97d6aT2LP64Wu+gWyexwHnfX+tElhb/D1fm/liDqZmaxT/SVq9El/SwpPSq24
	rbrWWKLwL6Sg=
X-Received: by 2002:a05:6a21:9f10:b0:3b4:931c:3c7c with SMTP id
 adf61e73a8af0-3c92a7bb452mr15042590637.44.1785851181842; Tue, 04 Aug 2026
 06:46:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 06:46:21 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 06:46:20 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amzIckjuwf0JfINI@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-1-35f9aec2aed2@google.com>
 <b78bfee9-29f3-4044-8ac7-f294b3cd0ad8@intel.com> <amzIckjuwf0JfINI@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Aug 2026 06:46:20 -0700
X-Gm-Features: AUfX_mxGk5RmzD5OeFVHjblIz9X-b3hzxwJd1etRfElQwBfbfA_qJlZkICUGG7E
Message-ID: <CAEvNRgGJ4DQuOVafc8ipd8NGP+6y=dcwSZPGOjtrHBAGO7sB9g@mail.gmail.com>
Subject: Re: [PATCH v9 01/41] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jul 31, 2026, Xiaoyao Li wrote:
>> On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
>> > From: Sean Christopherson<seanjc@google.com>
>> >
>> > Start plumbing in guest_memfd support for in-place private<=>shared
>> > conversions by tracking attributes via a maple tree.  KVM currently tracks
>> > private vs. shared attributes on a per-VM basis, which made sense when a
>> > guest_memfd_only_ supported private memory, but tracking per-VM simply
>> > can't work for in-place conversions as the shared/private status of a given
>> > page needs to be per-gmem_inode, not per-VM.
>> >
>> > Use the filemap invalidation lock to protect the maple tree, as taking the
>> > lock for read when faulting in memory (for userspace or the guest) isn't
>> > expected to result in meaningful contention, and using a separate lock
>> > would add significant complexity (avoiding deadlock is quite difficult).
>> >
>> > Co-developed-by: Vishal Annapurve<vannapurve@google.com>
>> > Signed-off-by: Vishal Annapurve<vannapurve@google.com>
>> > Co-developed-by: Fuad Tabba<tabba@google.com>
>> > Signed-off-by: Fuad Tabba<tabba@google.com>
>> > Signed-off-by: Sean Christopherson<seanjc@google.com>
>> > Tested-by: Shivank Garg<shivankg@amd.com>
>> > Co-developed-by: Ackerley Tng<ackerleytng@google.com>
>> > Signed-off-by: Ackerley Tng<ackerleytng@google.com>
>>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> <...>
>>
>> >   static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
>> > @@ -60,9 +68,25 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>> >   	return gfn - slot->base_gfn + slot->gmem.pgoff;
>> >   }
>> > +static u64 kvm_gmem_interpret_entry(struct inode *inode, void *entry)
>>
>> Ummm, I'm not sure on the name. It doesn't look like KVM's style?
>>
>> Maybe, just kvm_gmem_get_attributes()?
>
> +1000, "interpret_entry" is extremely vague.

Was a little stuck with naming, my frame of mind was that "entry" is the
attributes, so I can't get attributes from attributes. After you pointed
this out, getting attributes out of an entry makes sense.

Will rename to kvm_gmem_get_attributes().
