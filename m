Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226B3E00B4
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735935; cv=none; b=FBQIe0dbUiHXyG+T0p7UUjrLXYhtHaixKxXrP9QkjPXJU3uAozcY4KA5TL3++aynqXvnMqkpuxz3bxw7NHdn5Tdy0MlgG50xoPEK4RUYw5oBo6Xb1sMFa3r7J+2BKWRg7B5fI7XeKyia9IpBBBVmv8yTP6uFMgV6kDW6Up7mcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735935; c=relaxed/simple;
	bh=pnbv1cdHILrK3XHy3SSf8zg/Qg2gRvmL7b7jEbqu2SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CYT/MWG2B2ZXiyFnGTnMM14bCksuCrAw5s6utZCpQbH6wFf5sQv8vZwFr9jfA0H9kn3VzfHlpU5OskvtmPFifE6n0EaJy5ge1ogLad66Hw4X+w2Y7056EkEYUnoxw4uuoZW/oKTphLJgek+S97Ga1ej8Ccy7PAjf0e6l5sUAKU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6y0Gecz; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6y0Gecz"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b8088203so1089910a12.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735929; x=1788340729; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xbSTldz0mlkeejSRDvsTzV54cN/f7YMnwUkGWsjOYg=;
        b=f6y0GeczTBGC2qIf4t/91KY+MfufGBHFvIsJmShC4W9MGYfSlzfHDkkoJiFiOdw0Ud
         EzXnnyJ4EznvI0CjDjKK7u6cTRqH06KmmVMNvkTP9RFFnn0QKu2A4NS1E1LuYjXtiAgj
         9bSu8EB+fyDvreJVpmPsdNSpqJfGbP6e+ibJgKzNeR/WA4k/joonfSdsBJrmgPJjegZN
         06dkbLZkvEUqg3UT0l94zxyQ+TSYxAERGxzAl5gDGGOwFe+toqSLfKztHEp5Rv4QUZpQ
         45uR+Pqnj2jB05XavBOGWaMnME0YZQ+cXAtmPNgZRnis9I84oM/LfaSJFlCHDPDg2Zyj
         mlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735929; x=1788340729;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xbSTldz0mlkeejSRDvsTzV54cN/f7YMnwUkGWsjOYg=;
        b=RUJBVdUt3SncD1RQ+L5x/99DOCfxrAISFP704a1RMcy4olpSPE0QdJTI/nNfVHjBxf
         47AnSED9Sa/D0k6LK6mxicof+MYdGImdqgHKJeXgcvd3291xyoJAAizYF5J06g285ALs
         8Cipw8V+3HJYLs3v6AJt2bf2phAAYEyWpmPcDA2cUyAU6zn1st1bswwE6CIs7kmZHvPh
         Wb+vepwBX6KDMXKQaLeQvvXWEYNIl/jh0Z5QlKngNjTWjncxbO+MshPdWLi0veOEgvpl
         SLyq9CJu+PlaWckk9MoRbA8Ka4WVnv6Dwg2gRlCCEWy6fs/2YIHbtB4xCyfzqgPULzFA
         Fuqw==
X-Gm-Message-State: AFuF++mvF3IW5OZOp2I5whdC4X1W34eNmzTI85H84wthFasBq8yfR0RL
	OQI5CrLzt3jZEoQwxQ+2/66AdpRGgKGBo7H8m81BioVueuhvDYQ8V/B3zCOZUFvEGrmgFZNI4AT
	tWE8mq+wJi8Xfy3ekblD/CsgaHQ==
X-Received: from plco20.prod.google.com ([2002:a17:902:e294:b0:2c9:b703:3bfb])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c03:b0:2d6:ee6b:1b08 with SMTP id d9443c01a7336-2d707a2f363mr88247725ad.3.1787735928419;
 Wed, 26 Aug 2026 02:18:48 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:22 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=1693;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=xxgZV80P6tEBI0TS9iatKBLUXrCS72RFfbwoyow/L9Y=; b=I0SLEj0chvLQHB7QukPCMKxNVTQmEiLmipqoJJ+EGN6XfzLrsg82kHlLQjvE5ty/DdT4FbHrE
 xe7LXVIZZMOCZA0s06FUNYPGMQazgE0t9Oi6aKm/qrHRQUgS8sydK6J
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-24-0a15d8a799aa@google.com>
Subject: [PATCH v11 24/46] KVM: guest_memfd: Enable INIT_SHARED on guest_memfd
 for x86 Coco VMs
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Now that guest_memfd supports tracking private vs. shared within gmem
itself, allow userspace to specify INIT_SHARED on a guest_memfd instance
for x86 Confidential Computing (CoCo) VMs, so long as in-place conversion
is enabled, i.e. when it's actually possible for a guest_memfd instance to
contain shared memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/x86.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 147b3e529cd26..45ef4156274ec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10637,14 +10637,15 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
-/*
- * KVM doesn't yet support initializing guest_memfd memory as shared for VMs
- * with private memory (the private vs. shared tracking needs to be moved into
- * guest_memfd).
- */
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 {
-	return !kvm_arch_has_private_mem(kvm);
+	/*
+	 * INIT_SHARED is supported if in-place conversion is enabled, or if
+	 * the VM doesn't support private memory.  If the VM has private memory
+	 * and in-place conversion is disabled, then guest_memfd can _only_ be
+	 * used for private memory.
+	 */
+	return gmem_in_place_conversion || !kvm_arch_has_private_mem(kvm);
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT

-- 
2.55.0.887.g758fc8c411-goog

