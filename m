Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A836309B
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382377; cv=none; b=sHssw9qo9c4tTvLMm69RjIlrxjLejFZJcpEZu2xIdXSASQ952zqibSltlp+CciUI2A6sMWSEzhba26nFhBlPPfXupv67+QXkylf5eA2v19hAwnCcjsI/CXhZzx+i5MMwIHuYShN7DVn0S9BEB2c7yxIqYu4XPIkJcHY+fg9Pc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382377; c=relaxed/simple;
	bh=f/u8MBDxButqty3WBnBpsVNFR5HY5T58VePQCl+a2Lw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FuNNdi1LWMyFQqW8+Ee7MQIW5KJ0Y/DYL/z8BBriaeuJELXyDCXwoETtUd0AVU8A5ygZ9L2MEPXC05zm5jrHBigCpVHniNdxyBUqTTqpVYcmnGqYAip2CvdP2rHdTz8Yuu9wPBl3G5lXeFkYg3E2AewrDbY1kANlk/zegd8yWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvYKMk1/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvYKMk1/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso2143711a91.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382375; x=1773987175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfqXPeUWEOK3mFRzlMp1M77AHWf7AiKbvJ1Jssn8XG8=;
        b=BvYKMk1/dll3MhQ1E2IgRZkVubf4NXGkH7S4m7b66HHzyr+xvPhzR6R65PyOR5SmJD
         m8WXQ3vE5+8hyZGalq79qXoaG4Eq1BZcrsH76v80oHPmdU6CUKwJTBrVfUj0oTR1XWp3
         rUE70nhlY9vtJNO2EX0hnBGZAcPLIKqmB0kVso8i/HtxdkxGipPIsdR/X4tSZQVDCSUj
         yKoD350ocOnGD5XKVBCSdAGnBfSvUmwyl1jtVUjBqu+6eAXHTXOdEqgxjgZPomnCSU6P
         534k6OCdkcGvofP5zDKZXF/X9+BL4j0bdg9uNErfVIIEYckspMgbU13Yx19Vzt0wPb8l
         gWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382375; x=1773987175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfqXPeUWEOK3mFRzlMp1M77AHWf7AiKbvJ1Jssn8XG8=;
        b=GNYrlmSa5Mmq0zNiTW9g9GrF2E5lsCb0lxyl3GfzFWgWPu7pBw/Xbomyg/TZc1EMAf
         SDc9EAqUG+dMOzTWhe1B5RAz62EtMicfQ2d4v853NsKCTAPAdYJKe+1q09HrFIQpp5gW
         zJqwHXh0yULzjJR22ybCnhVG3hsozV8wFJBqV2JI6eniDGoqnweg32jc5XlCrp08K7yC
         F3OJs0XOBdBZRc7OYfFLbbssu7tXr4yQLkIpIxNNy807eYIJ7szopVoMg50a0t6ARTOR
         XoYKl9ZLyvAEQSro86xC3/mBArbIZC3prifgM5AKXhR32e4HQXJ3i2tNy3S8sbdbuw0O
         xvHA==
X-Gm-Message-State: AOJu0YyCJSeQJ9OhvPvu6WZG+wVQTvdR9uLCU7NL8ql13nTP52ibHRaC
	KR+uADTgDoEaSA85RLFpUudgJOuTP6Yujt3mYbvpARDVY/dTlt1MoiTBA75tNIy3Y/pQABbi5GR
	fSqvUeKDarOHSBlf8QdefsJVrZQ==
X-Received: from pjbgt17.prod.google.com ([2002:a17:90a:f2d1:b0:359:f0e8:29f8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a8f:b0:359:8a78:569c with SMTP id 98e67ed59e1d1-35a2205566amr1686742a91.25.1773382375196;
 Thu, 12 Mar 2026 23:12:55 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:44 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=3888;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=TbzwfWzIJZ9f4hVjCD6QuFLHmDIdFCBsbyhlDASSybw=; b=ApPMO0tHVQBB8+8qRb0igQBkr6D2uQauHnOpA7Zcvx7wKgW4Q/Fjw5jbyvH3RR+9K+UcWadd3
 mQyNl7uH72fAx5ORxla9nJeQT3viD7Tu7q9V1tW8vyFuNe3NybDhkU6
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-5-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
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

Implement kvm_gmem_get_memory_attributes() for guest_memfd to allow the KVM
core and architecture code to query per-GFN memory attributes.

kvm_gmem_get_memory_attributes() finds the memory slot for a given GFN and
queries the guest_memfd file's to determine if the page is marked as
private.

If vm_memory_attributes is not enabled, there is no shared/private tracking
at the VM level. Install the guest_memfd implementation as long as
guest_memfd is enabled to give guest_memfd a chance to respond on
attributes.

guest_memfd should look up attributes regardless of whether this memslot is
gmem-only since attributes are now tracked by gmem regardless of whether
mmap() is enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/guest_memfd.c   | 37 +++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5393854ca5966..0f84421b3f49e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2542,6 +2542,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
+unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 67709af03f39d..e93e95940ec74 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -510,6 +510,43 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	struct inode *inode;
+	unsigned long attrs;
+
+	/*
+	 * If this gfn has no associated memslot, there's no chance of the gfn
+	 * being backed by private memory, since guest_memfd must be used for
+	 * private memory, and guest_memfd must be associated with some memslot.
+	 */
+	if (!slot)
+		return 0;
+
+	CLASS(gmem_get_file, file)(slot);
+	if (!file)
+		return 0;
+
+	inode = file_inode(file);
+
+	/*
+	 * Acquire the filemap lock to ensure the mtree lookup gets a
+	 * stable result.  The caller _must_ still protect consumption
+	 * of private vs. shared by checking
+	 * mmu_invalidate_retry_gfn() under mmu_lock to serialize
+	 * against ongoing attribute updates.  Acquiring the filemap
+	 * lock only ensures a stable _lookup_, the result can become
+	 * stale as soon as the lock is dropped.
+	 */
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	attrs = kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+
+	return attrs;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_memory_attributes);
+
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dbdcef90a4950..7bb59679c9316 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2660,6 +2660,9 @@ static void kvm_init_memory_attributes(void)
 	if (vm_memory_attributes)
 		static_call_update(__kvm_get_memory_attributes,
 				   kvm_get_vm_memory_attributes);
+	else if (IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
+		static_call_update(__kvm_get_memory_attributes,
+				   kvm_gmem_get_memory_attributes);
 	else
 		static_call_update(__kvm_get_memory_attributes,
 				   (void *)__static_call_return0);

-- 
2.53.0.851.ga537e3e6e9-goog

