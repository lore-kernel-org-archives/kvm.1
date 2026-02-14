Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A032E2EEE
	for <kvm@vger.kernel.org>; Sat, 14 Feb 2026 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032455; cv=none; b=GZmuO6p/C6UwstrJ6tAg5LoQuj4XlotKObjEe7yUbFFSXndob5nBFkvwBeFsup4dLwXhN+oDx9OI7Nfk8uLVAjsS5Ve7WJrSCV53mIeSymRXP/2/6tK9bzwHvq9H90K8sSE16M7mMJm24sGHGojzq43CAHholR+ChT/TudSSqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032455; c=relaxed/simple;
	bh=2jURTAzz81y5fmKZ0nkZ+MRnOfqPxSPZP5ZzXKImRwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hbr59/ArjFuOKf96bsvZDxwJyiLTBV6HlnyaDJftrIcEVXwQsewsSSvow+tM76zoQQ++lvWUyviyITTuQcv2+SfyhaOHUzC1S/EICI2xoosA3/ZoA0tX9pBq5NO/Jd5sLnN/TQfnnusVLUScEGuBJFHG+EqyzDSFYoS8fw9XXlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oPrtfbDX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPrtfbDX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aaeafeadbcso16554485ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Feb 2026 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032451; x=1771637251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hrsNdfLewzqAJ4j/aZKlf6lqr1ErBy4WWW6V+vzZ7i0=;
        b=oPrtfbDXpFGF+Nvkp/7SPz/60rjY57PFvdBOlFwHU5fwCuBzhGjsGWna5Im7oClNHv
         MJGiWSypeq8hFLRPSuY92UbEomAGadSJGH87KJUMwMEBJ9HZHG9yF6ZwFGdK3YjlxEXe
         GicFYao3t4s9zoz42mnUn0IcW+gxrpVmk/T8BVTAxyuFORmQP21G1lae/Eq6rQbwR6IR
         kxMJWhfQHvSi/5t9uneEPMh1ImLYKeaSa2tysv5066X5Lp2FI+bUPXENiK7eX5KHqRoe
         xM/VPZKpDsPq2xXKNsyd8aOIckZB3c8kz61rUloAV+AK0oJPzCTh9h2lARHmEYT2upOO
         HKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032451; x=1771637251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrsNdfLewzqAJ4j/aZKlf6lqr1ErBy4WWW6V+vzZ7i0=;
        b=LbuJvTJrt2c3nq2Z+n4uULQSU8G2Pg9QH6fdGGWcCEDjjtYffHIk4Jho4ZZdVJhhJ/
         WPs7y5jxhCcn/eUa3MCv+b0LnHuhduFzsaoyePzG1NQY+ycyj6QrJCEiTW9Sz0wNcMrU
         uqy+hvPFt0e6zjsnjOpA/JGXdv8bL6VlWzOsP05TZrILN2Q/BmKzsDBmU4cKP3IQlPls
         Yt5sTfLcU+ocgwcn7SIgHnLyHBwgw+iGW65T6g1YExovyMZBYPwtPJ+tQbJh4wnlBxN5
         XA9musZ2hlOrxpI08tMYEY/AfXuln+M57Q0/qKwosEijA1r1PPDhoBjYeeBjop18occB
         qAag==
X-Forwarded-Encrypted: i=1; AJvYcCX8+kQhUXSu4lHoSYXpQ7NskKLCYOu5J48eXbgd3KgxKUS5Xi5LO+5L5vn3BV5Y3M54PwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8Z9rM4weNLO45ZAVXv+typ1gZIMancdrwP6uIF32Qn8gwgcU
	zZyUn+gUTGD7EVoCpKmxJl6id2BrVHCs0WHl2NfAStaOKa3yr99vY3FzN+sdQZEMVo+PySsENoR
	1b/yQdg==
X-Received: from plqu18.prod.google.com ([2002:a17:902:a612:b0:2a7:8c71:aa97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c947:b0:2aa:d647:b3ed
 with SMTP id d9443c01a7336-2ab505bd0fdmr36326685ad.34.1771032450744; Fri, 13
 Feb 2026 17:27:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:27:00 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-15-seanjc@google.com>
Subject: [PATCH v3 14/16] x86/virt/tdx: Use ida_is_empty() to detect if any
 TDs may be running
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop nr_configured_hkid and instead use ida_is_empty() to detect if any
HKIDs have been allocated/configured.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ddbab87d2467..bdee937b84d4 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -59,8 +59,6 @@ static LIST_HEAD(tdx_memlist);
 static struct tdx_sys_info tdx_sysinfo __ro_after_init;
 static bool tdx_module_initialized __ro_after_init;
 
-static atomic_t nr_configured_hkid;
-
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -194,7 +192,7 @@ static int tdx_offline_cpu(unsigned int cpu)
 	int i;
 
 	/* No TD is running.  Allow any cpu to be offline. */
-	if (!atomic_read(&nr_configured_hkid))
+	if (ida_is_empty(&tdx_guest_keyid_pool))
 		goto done;
 
 	/*
@@ -1545,22 +1543,15 @@ EXPORT_SYMBOL_FOR_KVM(tdx_get_nr_guest_keyids);
 
 int tdx_guest_keyid_alloc(void)
 {
-	int ret;
-
-	ret = ida_alloc_range(&tdx_guest_keyid_pool, tdx_guest_keyid_start,
-			      tdx_guest_keyid_start + tdx_nr_guest_keyids - 1,
-			      GFP_KERNEL);
-	if (ret >= 0)
-		atomic_inc(&nr_configured_hkid);
-
-	return ret;
+	return ida_alloc_range(&tdx_guest_keyid_pool, tdx_guest_keyid_start,
+			       tdx_guest_keyid_start + tdx_nr_guest_keyids - 1,
+			       GFP_KERNEL);
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_guest_keyid_alloc);
 
 void tdx_guest_keyid_free(unsigned int keyid)
 {
 	ida_free(&tdx_guest_keyid_pool, keyid);
-	atomic_dec(&nr_configured_hkid);
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_guest_keyid_free);
 
-- 
2.53.0.310.g728cabbaf7-goog

