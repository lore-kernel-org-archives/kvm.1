Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB637FF67
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382428; cv=none; b=hwlDykMr4Bk34ymdcQZ9QnSpn77/fJ42O82XlO1azdWw0mxWf4FyRcb/aO1EpQADKn+ds9Y5K3bI5i3nJjYKcydDjXkBAnlQWe8BsR74vanc/owdQGzNLGxaKNhPdnPXb/VHJs4QYCmsW/iU2+cFQlELI8jU8Senhmza4j+w7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382428; c=relaxed/simple;
	bh=pZ6v+xP1DHhPqvyCuFHofjd5+OY1APZufY1JisJXeEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R0Syhrheroirn0voYkkR/P8hZL16M88y5ooHKM7SjYvhssfskDVadTPX3I8fuN2j1v4dMI/3vaKhHuuUg52NRkR2ISqXhpiEj2qjkPc9eRS+0iU+tGMRhwcwX1YskQAAV90mH0zu/bS1zBbXk3x+1QUP8OPdIkTonztj65kP3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhGpauTF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhGpauTF"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a0337930eso1292444a91.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382421; x=1773987221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3pm+yxpNJ4bjwMx7Ok0ozOrfDqq2giI/WA9S2QCn4I=;
        b=RhGpauTF0HLVvP6UuTYHGx59xarynXbVDr2Nd5cFoI6ZBk0nJoPJ3cp/OVXkH3X2G5
         2tNbPp5bA+HFrXJ2O8tQHiawIQoD5eSGCvaKZ2PviFEb2kWAIuDV7N2jqUOdIEp5B2XG
         nhhOSo9myuSD7A7qbHkIwErWvsiHoLiiKynTar3CitVq2aBGEkxZNYM0qjgEMAyb1ukC
         inDvS6w6Z3jNpbU9zvRM2wzYjYVdTx6FKrv5w1Wj59sQcx8guLdJduidmmfxBIsM97wH
         dZTXxbkd0D05BbC+Z8XZM/+ZqP6CVFYh2LZRsQsUveqswcO7KTC2jyW+uCqw4PbiO3uk
         9VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382421; x=1773987221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3pm+yxpNJ4bjwMx7Ok0ozOrfDqq2giI/WA9S2QCn4I=;
        b=A/JV7I3kb76c52w/OiEU8qinVJVs9+SIk3+oxDwBAX2YU67ZUQsPk0obPYJcz9Yh+0
         RORQO2jGZkegBHL3Ip52C4x8DIySdFumcxDwhLrGvepxIsumM6JLTYCeX6652jmCSIRO
         YaLPh+xyBBdLk5XCbtEYB3zMiHVtAEH+X80zv/JkCPNM050ZUlxrrJG/ncsjtgtzrqee
         9OY+MsNKc9vcWJU2hjT8/mGsuVbPPCWUM1Kdei3uXbQbsoOMp4UkzALpUzBJH64C6yGD
         rrUsgswGKCEJfbn9/IcWvXNUr/t6X/C3rojkbQn31r34m2fJYxIFbyRWT0CBi4XKIvPA
         YvAA==
X-Gm-Message-State: AOJu0YzVfLovmBOqgpldLRwEBx22boYJks9qHyd08Og/m1VLIgpmvZid
	onP5SQRWEasqcc8ZnQOXks9I65/87CQDlAU7nUKDeKZm5BssUQ38kO4KEnAVKcjq/pWwoau9rDS
	qpK+R3QufMzjkuG6FuxEd3oiJFQ==
X-Received: from pgam23.prod.google.com ([2002:a05:6a02:2b57:b0:c1d:a753:c89c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b0d:b0:359:8ef8:7a77 with SMTP id 98e67ed59e1d1-35a21e9856fmr1976153a91.9.1773382421157;
 Thu, 12 Mar 2026 23:13:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:11 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=1296;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=2ixRhmKM6wBtzpBxyab3JJ4WtVOqoaynTYQ6b4ldkEw=; b=jT40ITR3BJfZenzh9aLy+3m9D07lyaX2Q0JABVIxCnVdwmo1loWSA2A8EGWXkC3EXk/xxd6Jc
 r6zcCInNS3jCw44Ylno1BpElXVZVhJBcj0DUXytmGS/K2n5bvB1aRce
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-32-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 32/43] KVM: selftests: Check fd/flags provided to
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
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
2.53.0.851.ga537e3e6e9-goog

