Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517EE403E8E
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374783; cv=none; b=Tpit6FWtWjM2ven/rl9bN9MKvfd84Y5A30ilWUu9sB0Oii7ygoYzIT0NKgwzkCdy+SVLZCcR7lIiCLhTuaUov2AX95abK2eGVgwGIUtR4BZ9uAZAaqFxa+/Brf1adVbqY1jsLy05Bws/6Nrm4tcdU0mxeP+KhcGUCMpuy5pOpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374783; c=relaxed/simple;
	bh=e8a82G3vdF1gTRu9deHGJJWozJtJR+he1ppv5OSrv/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZI88Y23G6pdtCj293eBkoMREJrqRGkynM9Buly0Q7QkNzzl1a579DSp9hJsDrvNnE3xhVoyiEA3rfr33C7wgplktCaI0vRioVO3wTfp7ivrmHVpz9aM3Hi1PpzSUj0YGdQdAmsK4MvvJU3z0AnvGobZozRLpbrkNpE/f7Yg9gZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IT+sDP8O; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IT+sDP8O"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8488ac68185so5491393b3a.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786374781; x=1786979581; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jP6OZG+k89vE4yr/pvKA0W8zcNVpjbJQrQC8mI91fW0=;
        b=IT+sDP8OZWdknMBCj+jUaT5LnA6Ow5v22niPqrSYGF8L3nwkcru4ObO6PsTsHvwhRu
         w0wPRpwxMaeyCoHuK9oxL94vmEBYdVRu0hQ9XYpavkER5C5Ne7ulYtTzG/z5bWzR/mLp
         FYc4Kc4bUdb/C5AsSTzaWM7KYzlWM5Rn5zt6r9sUo1VHLZ94QiWUOPt76o3U6EwrL0hd
         9krDBH/9KF1A3DejRttnMAPLDQzC74v5anj8WcRnk0CnHQVtIdHH9xg0ZG0gtr5TS3JB
         HtYy67mhe0xL27wczJGVc3tpVC66+b875u92KVVsm70ffLdeatf0JOzMlaYEW9tjLPtm
         2zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374781; x=1786979581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jP6OZG+k89vE4yr/pvKA0W8zcNVpjbJQrQC8mI91fW0=;
        b=PPxK7bAG6HiKe8GeWLl+p1JgC79NxPPirWaAkJH3t9t68NabfoF9kfDLX6KzLz+tZe
         FfBlfWs3o2dFMeGFNWmsGfh6FhADCC4GjtBvymBJpIHvzpLymK3AA/ISoOWYHTNZA2Ej
         yDmmBXT8B1DXS9Np0L+5xIHNBmbWz1fS1enhcDSzPVJXrlCYqaquJUWMjYmbgdha+EGx
         V1a7LZDjC1wvkaMIaTWmK4wrol5BF2XcCCL4mUwlt6sQwqoo2GU3zBP9Z5uW8If0hICo
         Q547NxXYuqCnUsROrUGzLG8xTJQQmwrUbK6xz+4+OkBcCosFKhXuposQNlJq4rtbAa//
         ZPuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvTrZ/dZ/UsQWHAQ9At7mH+BDi7nwIfTmxfa4L3KV9JR/X+ZpF81OAcL3SVK4sBNK4F0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8++m8jiURtz2VoelDX9ch3LUh8fCKaonJhldlYwSRXQ7oVhU
	4W9EpMW4YWBJNkOqvQTIIcLYMeFWNusr7DCJgjjQgh3VMjRABQH7uY/rgu75EtmmhLzUw6xzcvE
	AzBr/VA==
X-Received: from pfqf14.prod.google.com ([2002:aa7:9d8e:0:b0:84d:f9cf:1f3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2286:b0:848:76af:db37
 with SMTP id d2e1a72fcca58-84f694200b5mr21737517b3a.7.1786374779939; Mon, 10
 Aug 2026 08:12:59 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:12:59 -0700
In-Reply-To: <20260807-gmem-inplace-conversion-v10-2-2fc18ee6d3ba@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com> <20260807-gmem-inplace-conversion-v10-2-2fc18ee6d3ba@google.com>
Message-ID: <annqex-kBOc0UJvp@google.com>
Subject: Re: [PATCH v10 02/41] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, Ackerley Tng wrote:
>  static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
> @@ -61,9 +69,25 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>  	return gfn - slot->base_gfn + slot->gmem.pgoff;
>  }
>  
> +static u64 kvm_gmem_get_attributes(struct inode *inode, void *entry)
> +{
> +	if (WARN_ON_ONCE(!entry)) {
> +		bool initially_shared = GMEM_I(inode)->flags &
> +					GUEST_MEMFD_FLAG_INIT_SHARED;
> +
> +		return initially_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;

As David pointed out in v9[*], a helper would make this code in particular much
easier to read.  Though my vote is to add "get" and make it plural, because this
function is also plural.  I.e. this as fixup:

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f2bec0d49747..b7435a8d2405 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -69,14 +69,17 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
        return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
+static u64 kvm_gmem_get_default_attributes(struct inode *inode)
+{
+       bool init_shared = GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED;
+
+       return init_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+}
+
 static u64 kvm_gmem_get_attributes(struct inode *inode, void *entry)
 {
-       if (WARN_ON_ONCE(!entry)) {
-               bool initially_shared = GMEM_I(inode)->flags &
-                                       GUEST_MEMFD_FLAG_INIT_SHARED;
-
-               return initially_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
-       }
+       if (WARN_ON_ONCE(!entry))
+               return kvm_gmem_get_default_attributes(inode);
 
        return xa_to_value(entry);
 }
@@ -833,7 +836,7 @@ static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
         * index is represented in the maple tree at all times simplifies the
         * conversion and merging logic.
         */
-       attrs = gi->flags & GUEST_MEMFD_FLAG_INIT_SHARED ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+       attrs = kvm_gmem_get_default_attributes(inode);
 
        /*
         * Acquire the invalidation lock purely to make lockdep happy.  The


[*] https://lore.kernel.org/all/0a85b27a-121e-40a3-92b6-3927fc298e4e@kernel.org
