Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C73DEFFE
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563946; cv=none; b=J08gnskBMzaDspN0uqyZCvRYn9pWOYeqs7pnYIH17wEHDewjP5B7gqFAnbXX2FjPzIUic8JDl9kybXRWBTv/6Y1x+80C6H2USz/fujgixfwmxyxPVLGrVndZmWw3tyzq0hap7aQIzSyeRyF9O5rTwZB7sm+RbEySBRWu3KKEt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563946; c=relaxed/simple;
	bh=TfemElEfdERFkRLsHdlR0kNi3ItobD/8s52eJnmiwi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DA5VJfNossMHsSVuJc38qHslnu3DdzWFVJ79FjR73MMd3hzjzAE7Cy1ipvLvNgo3VE9Uwz0XnoY2rSHZ332Ask/SPbMnXQ+nfLZtSdIooG1QpkgnzSVHa0RWI6G8+ID80/ohNs8gCCFvbUmpVSD9Oy/CEVpg9mLNvTlW42q7c60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPMvGsNG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPMvGsNG"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c74217894d9so943394a12.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563945; x=1775168745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu5GxkLk2ihC25vK1ewNFZZkf5k5QyN5WL/Cx64gQr4=;
        b=dPMvGsNGBERuKUU24DRYIC0oZ1BT6qGoDB1iZjnMTZC+cptXz/l6k+anA1Njha1c3v
         74a9CGqwMA106pFsk5wClT1eIliUDFplIq6M4J6ENUBHFMUNHOmKcLldl64Gn922eZTT
         3UthHX7Wo8VNnXvfrIt5iyc0WlYRrLQzbowSnV3ujDKXeYktsyDlK31Yb9kGs7frTJww
         R2fEKIU4Hm0jb3d1MzcBnSmgOn+kC1zIDnSrJ/H0jAB1YShCFV9T4JMW2Sy0UhtCbp7l
         zVFa7eWK1x5DOEggNQqheEd7DYNP2RRtQ95qNM7VOO3Rymixch9taknipvoHAo+DI55B
         Tlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563945; x=1775168745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu5GxkLk2ihC25vK1ewNFZZkf5k5QyN5WL/Cx64gQr4=;
        b=mKjHHNzulkEpkmrMZE74WadKYl6d4JOK+hzhdEAIPFj8y5CJ4zC1F/jSD54z5vSFpV
         qFaXu9AFPqS72lFH+vfg/9+pWnEWxwDh8ZkXhu3guOl+HGukUl5rFHKbkkqQsk4UkbRF
         O4zpOR68tDWqScDLVovnb9/Zh/lrz6FigpVItwazvh433FNTG7N3sVTj0R5TKL5/FiST
         hhVYE/r/+9UkC5vyo1CsXqZFizJ27nGpwNtBSkYQJPHzQGVWjpKm5mdx+wYD8OfWB20n
         xCtxc/aSxs2NmYTmHyHiUJKTo3jpkDxDULqMqCa2yYP8Exn/5ZiCFY6oMhPdW8B1LdOX
         xWKQ==
X-Gm-Message-State: AOJu0YzXKcnUwHxoKuXMhkUZizzyI8t9qwN/1g2o9ntbImSExFYV6/j0
	uPoW/Vjtsu+GLywlJB1iemlP9qmVUvq5co8alBPX1fukEE8M+g84t4+WNdwVixUyDEYrVI2wHK/
	u4PQhso4jPgnfP6P0s/gAAu7lHQ==
X-Received: from pfbln8.prod.google.com ([2002:a05:6a00:3cc8:b0:7b9:1e6:e516])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1f03:b0:82a:6166:3a9c with SMTP id d2e1a72fcca58-82c9602597fmr137178b3a.29.1774563944430;
 Thu, 26 Mar 2026 15:25:44 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:48 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1297;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=lEdbMLRc9XzFP+/DjPRFPv8Oj2L73VX0SttQ1H+9ibg=; b=Lzqqurlvp5Ti9M3NDoksM02NMKtbbW2WTjtthOuBwY9jkE+E3i27WA/wipcC/9QRLsA8QLCRD
 lkWb3PDIcJtD/RB2l596NV5A74CNdl8PajbjHY1/QAqCHxi6RcLc2od
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-39-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 39/44] KVM: selftests: Check fd/flags provided to
 mmap() when setting up memslot
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Check that a valid fd provided to mmap() must be accompanied by MAP_SHARED.

With an invalid fd (usually used for anonymous mappings), there are no
constraints on mmap() flags.

Add this check to make sure that when a guest_memfd is used as region->fd,
the flag provided to mmap() will include MAP_SHARED.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rephrase assertion message.]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6deb6b333a066..6f7d3adb25d0a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1095,6 +1095,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 	}
 
+	TEST_ASSERT(region->fd == -1 || backing_src_is_shared(src_type),
+		    "A valid fd provided to mmap() must be accompanied by MAP_SHARED.");
+
 	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
 					vm_mem_backing_src_alias(src_type)->flag,
 					region->fd, mmap_offset);

-- 
2.53.0.1018.g2bb0e51243-goog

