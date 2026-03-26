Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF813845A3
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563895; cv=none; b=VVtDkr1ck9W1xvZHPw3KLPCXPhGjkPkxYQZr11/N9HYyfv80SLrp7e7roJB1SVAPfjAmaNCV9Wv2cFhHVu9/c98J1iU85twB09o4uEnxwSPwyBASZTPYSmA2IOxWL+N+ELanIVmLVGPZuzqqBMC2IeOv+IMTUu9+yrQ13uXDiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563895; c=relaxed/simple;
	bh=+lH9JgLOF707IWKJRbslu6RR2YV0S99MONEW8Yc3BZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s6AGNtaLDUew/XadbcFpAQSQD3X9IimTxZMnKaZ75Rl8wB84zmlPWtBz3kNHc6I1mzMaBGGYGgKQBP6NLXXywANG+jVNZhHm9UEI9gq5S+W7tp6kxKihlU9jOQtR4bCBL9aaakhvAnR4tc+y3FcQdd5Sn+/LpDi3AfyluMTHiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jww/JDN0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jww/JDN0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso977278a12.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563893; x=1775168693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=krjKKoUHOcKbfpf9SpjvgIZEA4m0P+3HWizcMkU39sE=;
        b=Jww/JDN0oJXNwpepT3gekZ53X2HnfrK3ShJdKathHLjd5QeCMjn1p0El18N+F9r8Zu
         5lUs5+dUyMqv2SQdVNfpmmvC6ouzxGq1R6CIw44o3aJI6OaoM4h/n/S+OLqcQ7f0Aevb
         w3bvLIibvZyZPjWi2C57FSabKh+vLQJY9LSYGEViAqihxezUMjcTsS3Qc4cqV5uP9La+
         kQeUBHWFFindUI46h56rMUCLN5Q2qgjdGwtCV2MLFf1l083lEC2ngueVbkxyTuIHr9oD
         Qs17fMSlo3AZD3/vl3RvlITeI+zFjZOy/Jglb6yOtsfkDJvpJhrGqLcPFTiDkVyNAkNb
         mNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563893; x=1775168693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krjKKoUHOcKbfpf9SpjvgIZEA4m0P+3HWizcMkU39sE=;
        b=OIZsywRTc9j6+QZHmLfeb8/eT7j14kqsw1XLpuV+1VXgvRww7YP/pQQIdDzhF8Ftzr
         /m4s+8UuGSjxnzZJFkoo6aBlvx+HqXED8dHpyoxQUwSOALjKREZKfGOqRH8m6ntBByks
         CRksXbzesRvK0GHLvu1MIQJ9RS/7PpRfe206KSO7+pwrgQZ2AgN+6jrmWTeuA52Lu1OK
         VPDfhojApSjkQgoSsPmTR41gXXi/zn9wRSXJXx2Haed9PeGDLs1wdD4P4g07+Pqz9ebI
         35/G9Hwnl0RMOKo0aiER0CRjVtt/+R+zCG7k9N83EBloXWtJ2Jj3E5rG3TZqmt6DgQ05
         lS6Q==
X-Gm-Message-State: AOJu0Ywfe9LmUhq6pckG7eWO/iUrrXlyCIU/vrBCbUIcGceEeKMityWs
	2ol/86dyKqZsqbFoMXwM549veIfbSiik5YM2S3gFdBcRkahOtv6DPKBv679TNCPY6ewJaPV+6kM
	jAwwfd3aq4gJA67uIvBNzv+Yg6g==
X-Received: from pfbfa24.prod.google.com ([2002:a05:6a00:2d18:b0:829:813e:c970])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b12:b0:829:a127:518 with SMTP id d2e1a72fcca58-82c9605434bmr143072b3a.40.1774563893212;
 Thu, 26 Mar 2026 15:24:53 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:23 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3333;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=+lH9JgLOF707IWKJRbslu6RR2YV0S99MONEW8Yc3BZ8=; b=M/Gbb884LE5QPF+3EzZzuqSIO6Odv8JZWUawyA7Mhz//bCISt9epGhctguzMXhMlD/ZE6w0Rj
 EGaXkNBVodNBXGot/DtKS79CF61Z84KbG7KljbyQM3ZQboU3Sv7s68x
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-14-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 14/44] KVM: x86: Add support for applying content modes
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

For x86, override the default implementations of content mode functions to
handle reporting of supported content modes, and application of requested
modes based on x86 VM types.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/x86.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9c29407712580..3bbc8ffbf489e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14078,6 +14078,107 @@ void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 	kvm_x86_call(gmem_invalidate)(start, end);
 }
 #endif
+
+u64 kvm_arch_gmem_supported_content_modes(struct kvm *kvm)
+{
+	switch (kvm->arch.vm_type) {
+	case KVM_X86_SW_PROTECTED_VM:
+		return KVM_SET_MEMORY_ATTRIBUTES2_ZERO |
+		       KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE;
+	case KVM_X86_SNP_VM:
+	case KVM_X86_TDX_VM:
+		return KVM_SET_MEMORY_ATTRIBUTES2_ZERO;
+	default:
+		return 0;
+	}
+}
+
+int kvm_arch_gmem_apply_content_mode_zero(struct kvm *kvm, struct inode *inode,
+					  pgoff_t start, pgoff_t end)
+{
+	switch (kvm->arch.vm_type) {
+	case KVM_X86_SW_PROTECTED_VM:
+	case KVM_X86_SNP_VM:
+	case KVM_X86_TDX_VM:
+		/*
+		 * TDX firmware will zero on unmapping from the
+		 * Secure-EPTs, but suppose a shared page with
+		 * contents was converted to private, and then
+		 * converted back without ever being mapped into
+		 * Secure-EPTs: guest_memfd can't rely on TDX firmware
+		 * for zeroing then.
+		 */
+		return kvm_gmem_apply_content_mode_zero(inode, start, end);
+	default:
+		WARN_ONCE(1, "Unexpected request to zero for vm_type.");
+		return -EOPNOTSUPP;
+	}
+}
+
+int kvm_arch_gmem_apply_content_mode_preserve(struct kvm *kvm,
+					      struct inode *inode,
+					      pgoff_t start, pgoff_t end)
+{
+	switch (kvm->arch.vm_type) {
+	case KVM_X86_SW_PROTECTED_VM:
+		return 0;
+	default:
+		WARN_ONCE(1, "Unexpected request to preserve for vm_type.");
+		return -EOPNOTSUPP;
+	}
+}
+
+static int __scramble_range(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct folio_batch fbatch;
+	struct folio *f;
+	char *kaddr;
+	int ret = 0;
+	int i;
+
+	folio_batch_init(&fbatch);
+	while (!ret && filemap_get_folios(mapping, &start, end - 1, &fbatch)) {
+		for (i = 0; !ret && i < folio_batch_count(&fbatch); ++i) {
+			f = fbatch.folios[i];
+
+			folio_lock(f);
+
+			if (folio_test_hwpoison(f)) {
+				ret = -EHWPOISON;
+			} else {
+				/*
+				 * Hard-coding range to scramble since
+				 * guest_memfd only supports PAGE_SIZE
+				 * folios now.
+				 */
+				kaddr = kmap_local_folio(f, 0);
+				get_random_bytes(kaddr, PAGE_SIZE);
+				kunmap_local(kaddr);
+			}
+
+			folio_unlock(f);
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+
+	return ret;
+}
+
+int kvm_arch_gmem_apply_content_mode_unspecified(struct kvm *kvm,
+						 struct inode *inode,
+						 pgoff_t start, pgoff_t end)
+{
+	switch (kvm->arch.vm_type) {
+	case KVM_X86_SW_PROTECTED_VM:
+		return __scramble_range(inode, start, end);
+	default:
+		return 0;
+	}
+}
+
 #endif
 
 int kvm_spec_ctrl_test_value(u64 value)

-- 
2.53.0.1018.g2bb0e51243-goog

