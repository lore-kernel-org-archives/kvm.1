Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C741432E7A
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240708; cv=none; b=jaMymTHTxOjDYBQtsAaavnwvyUwfMFS6pAiPRv0FeJsPhM9ljgL4+JTXH6OnjO4KQlvo7OtIxaTEpz3AS4o+oNgczDv1K27IKDy8wXaZceH9ms8/sWPgMWIBYi5lLQXaqpbIy1676MenpEQ4HOoRp7Y5aGZQ76jE+qA26+bZDOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240708; c=relaxed/simple;
	bh=ZCz6AmYTU8FxXnWNZdQqQYmBRxWh1wvH2S06+HipCfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nbX0Vonc/qjK78kSNNYC+XtilXd7ghmhqvzG0C8l4ld6eF9N2hGWIfnE4x4FqYwIk/lXiADSV4vWq2Z5+hrujp3c2bAQzG6mEfNnh9b+kZH5xoish8sYKkIfGuKetsXFrs4NF543tVGCf38tF93NkyzRMrFYwfXWpQhdKcxxLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMx10qpT; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMx10qpT"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15ddb61f13so382916466b.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240705; x=1785845505; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MlhSbTxVjdyQy53nJTV53rS/2kuy2sPn8hGnbbTr+U4=;
        b=QMx10qpT8YuuBhjmdqNy7xNvXAyvNhLMj8d0jiaZy1sGQ7sdFEUYlJAcs7H7srWjlK
         l4AkRLD901b/UTsT+xl/8lr9wXzrZaY+3kMRGsXSex5fs10k1yT+EfcUzJhZ2kTxRK/K
         VOPkstf1Nqnrh9zTl14pzBxy93S3BoS/D2QV7IbE/dT5Bfjt12WyjFLtuAsXC7O6R4DH
         wqlHW8ZFdrRnC/nLF2+bpYQNLzSt+5E0vF3gc8RxTrVuC4um4YrlwhY+AF/qns2hzbUo
         egOtDCkxlCqZkfpbkkuAy07xX/j6bH2ECm/VhrqgFE4yWVCjLOP5MNn01NV+FdSkrqu6
         VRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240705; x=1785845505;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlhSbTxVjdyQy53nJTV53rS/2kuy2sPn8hGnbbTr+U4=;
        b=rohQ4ElnRObXDP4YumQkhcUcEeaIDJ9wHNzGSCxyZEkqipVQpYI0G98j+d8EunqOnV
         +bsj0zlKsEzVSlZggYlBQyJJZgApkjy6EbfGzxPZ9Q5hRPktuaii5I4jJhzffzUQLI+L
         GGFNiMU+aXiIAIgxIzCGPcfJTXhnlm9zBkUp59RDH5JsOIHA1LGNt1H1tbrGs8qyML8p
         iUr6akWX6bXFpoeHt28VZOkILqEH5FJUnZw7ixYb5TWp7DcuBUO+aShQP5YWA19FaIAM
         1GEZkaM0gRMqYbhrDHmpHj/EVhxxuGyp90ezYzBPCqvRk+ThZ0wgSdkeaUbbT0z9T8Fb
         IV5g==
X-Forwarded-Encrypted: i=1; AHgh+Rqc5xyPieHpLJZZ+fmalZcglsDuXf8d9jZVooeqlLlwumcjQHag8lAxS4wnrFto5r8vG4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6TBLCdjWDDBfFjjfZebqT0+7URzoF76eFwgIuNA9HB2MMCZ+8
	O0VBIQOiAnML5fqnv3APZFam6Gn3MRvlureUZF43soRl9gInlrj24WdALk7C3n+mY8acmA702rm
	7YA0tG45kGEDLl9S9yg==
X-Received: from ejqm4.prod.google.com ([2002:a17:906:5804:b0:c12:3a41:5220])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c0a:b0:c12:8b1c:454f with SMTP id a640c23a62f3a-c1f71cf9b88mr103366866b.2.1785240704443;
 Tue, 28 Jul 2026 05:11:44 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:30 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-4-tarunsahu@google.com>
Subject: [PATCH v4 03/11] KVM: Export kvm_uevent_notify_vm_create()
From: Tarun Sahu <tarunsahu@google.com>
To: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

- Export kvm_uevent_notify_vm_create() to allow triggering KVM event
  notifications during VM creation.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 79b084887cdb..d9908c19e42f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1076,6 +1076,7 @@ void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 struct file *kvm_create_vm_file(unsigned long type, const char *fdname);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
+void kvm_uevent_notify_vm_create(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3339b8fcd59f..701d4596a91c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6348,6 +6348,11 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	kfree(env);
 }
 
+void kvm_uevent_notify_vm_create(struct kvm *kvm)
+{
+	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
+}
+
 static void kvm_init_debug(void)
 {
 	const struct file_operations *fops;
-- 
2.55.0.229.g6434b31f56-goog

