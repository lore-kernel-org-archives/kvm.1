Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5AA37F727
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382443; cv=none; b=la/8cs+aIoLfE/i+j5EylJRWnOZEyVZCVSh/l4N6Bt6kZaa+n/63FQzNaq072IZZpTjK2R0d43ST0CL/9nyxgIo4EVSJnbZpNN3DtoArSN4X+V8MhVqxk/fqLmZjM1r2sB3/cM14yWgKmIARIjBDkYnYHZhhLduFk/YTiyUbBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382443; c=relaxed/simple;
	bh=zi0vFAbqQQTVybzQ4d6S9xx2RZ2vGjUZ7QlD1D8veaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jy2XA+DJ3W4l+E7iUpAmLbq2Z3mV8lLlJkfsUD6gYkuWlxUkmnWw3rxBXlp59PwsobY2MqLcxOgKGEZVliiKkb0G4nT/5kUin3Y3HrBtrXV4pm9tYQFusRVzW4uI6rNUuYLo5a9m91WUmTXHjbcVaasjXEvfvf48GIRs4NFRsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NSJHxO2E; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSJHxO2E"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35a032cdd78so8141615a91.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382434; x=1773987234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GmE625ywHMcKgysjsA+lJI94OnqR7+L6DDyKIjGH1c=;
        b=NSJHxO2E6Valym34TQ0pv27z6yfmWCKC5ppltcn5xnZJjzP/uocDBEghxEzmeVBwcB
         710G/+OI3oDVaQbjW0yzn65wbtBG7cfCBMQufAk7cTmAROvd2BBPGl466pVk7WQegBH8
         x+YsasSnBJnwnPiq+pjl0/hKqW3zpefm3+em+4LnfPsjdUeNhzehF2Bp1PJFG5wGQFI8
         ab0UhqpXmvXmTi6bLhK/fe/vPNwXPeHaja2nbCtPixy/hvm3xfvho44R9FvvvA/Uf7OS
         89eVAqq8fEOhIEM37EeN6rO1ZCp7X5HI2hsBVzFq29E0h7IlwcI78aHPoUvqLVdmWcrm
         VjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382434; x=1773987234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GmE625ywHMcKgysjsA+lJI94OnqR7+L6DDyKIjGH1c=;
        b=McqlbhgzQd2ZSgRKpvDXft7PMsV6xdraNv+CZpcEXxYG/ECFX/0m6buvoMYW3wxltb
         e9XFPiw1SaHxOlY3mRh2xzPyu8IX1xfYGC9asuJsiVXe1eR81UhQ/qS9kYufel6MqMEv
         PX9+Uzezo8yEuYqks8cfTfqxGVaXgV7MfRv9ELlvajHeawoAC1Yjz5wWN9r5XL0Ov4Ij
         hOZkyvbWKWcXBM+j/qrZ87I7W0V7iDMMGegxAJ09fjbUmxrdvI5BXevpUXfsw3tYis4f
         SbwhUdaIqWZQrHcylrkuUSrgRjKH63g5FYvzYomvrWBHa0saPV11eK1PTfTpr7CNwYB+
         LwjQ==
X-Gm-Message-State: AOJu0Ywe/rCAgMpx2gAr8YlAQCgGoFLw2WiPAViVAmZNR0Aw5LRgK7Ri
	pc9Fl14AEVGVenWR7UlVkdJz30OwNXyCV61COWTJB6Ec6HXe5dR3sdPMV6tFimWQiVggi9JJyv1
	NR8UblHYmhjJcLJdtHYD/PVQsMg==
X-Received: from pjzh21.prod.google.com ([2002:a17:90a:ea95:b0:359:f772:3291])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2684:b0:359:f69a:f7b7 with SMTP id 98e67ed59e1d1-35a21eadddcmr1917876a91.10.1773382434257;
 Thu, 12 Mar 2026 23:13:54 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:19 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2407;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=zi0vFAbqQQTVybzQ4d6S9xx2RZ2vGjUZ7QlD1D8veaE=; b=o1BGg3s3hX3T3w6RMc4VBLHIMEPRAJ3qHKModFx1Uwf1TqXidghI4On/BHJNfk1vuJqxWuTQM
 hETvPruZSDoA20O00VnLQLnLa3QLo79hqsbYwTC8q+x8SDSa/B+R6Op
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-40-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 40/43] KVM: x86: Add support for applying content modes
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

For x86, override the default implementations of content mode functions to
handle reporting of supported content modes, and application of requested
modes based on x86 VM types.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/x86.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9c29407712580..49c19897a9c30 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14078,6 +14078,75 @@ void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
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
+	case KVM_X86_SEV_VM:
+	case KVM_X86_SEV_ES_VM:
+	case KVM_X86_SNP_VM:
+	case KVM_X86_TDX_VM:
+		return 0;
+	case KVM_X86_DEFAULT_VM:
+	default:
+		WARN_ONCE(1, "Unexpected conversion request for vm_type.");
+		return 0;
+	}
+}
+
+int kvm_arch_gmem_apply_content_mode_zero(struct kvm *kvm,
+					  struct folio *folio)
+{
+	switch (kvm->arch.vm_type) {
+	case KVM_X86_SW_PROTECTED_VM:
+		return kvm_gmem_apply_content_mode_zero(folio);
+	default:
+		WARN_ONCE(1, "Unexpected request to zero for vm_type.");
+		return -EOPNOTSUPP;
+	}
+}
+
+int kvm_arch_gmem_apply_content_mode_preserve(struct kvm *kvm,
+					      struct folio *folio)
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
+int kvm_arch_gmem_apply_content_mode_unspecified(struct kvm *kvm,
+						 struct folio *folio)
+{
+	switch (kvm->arch.vm_type) {
+	case KVM_X86_SW_PROTECTED_VM: {
+		char *addr;
+		int i;
+
+		/*
+		 * KVM_X86_SW_PROTECTED_VM is a test vehicle, this
+		 * case is just for testing and does not need to be
+		 * performant.
+		 */
+		for (i = 0; i < folio_nr_pages(folio); ++i) {
+			addr = kmap_local_page(folio_page(folio, i));
+			get_random_bytes(addr, PAGE_SIZE);
+			kunmap_local(addr);
+		}
+
+		return 0;
+	}
+	default:
+		return 0;
+	}
+}
+
 #endif
 
 int kvm_spec_ctrl_test_value(u64 value)

-- 
2.53.0.851.ga537e3e6e9-goog

