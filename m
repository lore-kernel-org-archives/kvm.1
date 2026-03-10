Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA72385501
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113212; cv=none; b=FzwAn6wIacrGwx9uv3CUWRH+SpEjn1mln595l6jRIHwDr8t5ReLW1WylVMXBLMuBxF7s7RssOWUd5+Zyh3K49LS76yb+zHReg60stVuv/pH6P2/oxGS86seFjO/gTn5Acth64snVON52G4o6jEMsLGPJxcz6gIM8gbC1zaNhvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113212; c=relaxed/simple;
	bh=zwQ0w1WX3o6PWRSVmotXMBuOjQSh4o7Ox2tjItokEHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFbd2lXKNuhW6SAUHmj/W9/Xrukm9YNYoVxhMnsJIPOg8tVDzuvJFUvD9ywJDIoUoKJfomsklCHAV5w0MQLH9d9XlVGXXN01c8zPP3t3LpOjBtS2H/UGaD5rJtBt5PeenMRW49roVcyiJvp8Z18it7RS+4Uhq7r5SUWVs/b0yNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vj9sDCUz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vj9sDCUz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae3f822163so47765ad.0
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 20:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773113210; x=1773718010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QgFRu6ww+X4eKkkmrkBaNqzfyYluZEMATZgmk40+ZI=;
        b=Vj9sDCUzlkx915B6pAAeWHZSTNeGQMR0BoVemdmhKJroupD8UWJo/w6TiJfi+yZm6O
         eqVtSnjVPVVmlMQ9gA8I8OzJcXm3y0rvSRrX1nLTubxqCmFE3liH8RX7XkFw69l804OR
         pmoMShE+8k0FUQfvwHLeyKEs3Tps4zff9hT043kHaUverDk/g6Plx1y0VMNorazDKBvg
         VcD/NBoViRhAbhm1iRD21ZqDVdITEO8SPLLKfWCROXm5aXzaFaKkYyUy9sDbmRNlOwsw
         NVVH4YgNgtQP23ocWnsK06EyUe1iDgTq/Uu2jDaxPkCfUUgMmkZ2A3nSNDDuwLx97+qj
         3uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773113210; x=1773718010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QgFRu6ww+X4eKkkmrkBaNqzfyYluZEMATZgmk40+ZI=;
        b=HBPlAipMFYX4NqgtB72s7GGZEFEue76x3svZY6LZy2+8XGzs8VTmfOhmwQKohO0BOf
         RsNCW41rpba+OGd43tkACtlwmD5OGTWsInRpYcGawUYg3tPlTpURHKPuveIWg/fXwaSx
         EoRz6/BwkLvoN+lfMarDO5rk2bZmKLxNx0+wq8nNDW5peG1Ag0KSgdL0s+atb5etFe3H
         542I1EM5Lw3D61WWOZUaVn1SQ19wl2aotNQQ7wrNBe2/b0N29n9D4FEaxkC1MU6eiZMY
         orwl9gt2G3juIYTfn3d6/e0/+qBzFGypyuAXSRQ4FGyF0Myk22bmiXExqBtYZFQcGp29
         fSBA==
X-Forwarded-Encrypted: i=1; AJvYcCWxCczJF4i7C8qpm5/vMnGyPcJRjSMNeTmmkGm0tb7iOKYAokmDDnYcRTcWjqU/wWa/O98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFe01kuSbCxQOAxt+38DrjD30JM4oZFjO0trfyTVzFadPwYW/o
	WsyDi4Q2u9uXFvQDUrt3nrY44PnZWcoRDCMho+Iagdhw8Bwbmib7hnI3tb1aHv4H3Vnn9JNpZE6
	+v/6BNA==
X-Gm-Gg: ATEYQzzJWsYPjhEgEyci57PqzLUahbaYCU1e5/MqKoB4dgOgnu5tQlEb1Fp15TFCv0h
	OXZP6qhon2NcN2F0c/1VwvrGfQeyb+Fo2WQ9iK7amOo2cBR3jq3BklMhw5bPCIezLIP4u5003MN
	BMhXJPDu8aMSGkanuK1E/uFxS3MfnM4O+/+xYYQMbRHsM3p3v1Ve46Wi6MAQ4esItDGyJjjhZEj
	FlvCcTmJThXnrelCEHj0HMK/dHVzWCLzb6lRLRxk1im36LldC3W9kNVFZ7QzTX6Nd5+plY3+riJ
	x0AvHUEbstJXW6FSc6YC89hMnWA2oEwvQFSc6z90Cebey7I/DRiHFYQuNhay17y1Py0bDvtHP9h
	QnFYCOlxaXaonKXzTIbplPqfu0cYzsVyvnag3FS+wp7fGIOgsxnZ07aJAWNgfThXyYG1+foDiPk
	nujC/FQr9gFYpNG+Gco4H8sTKx8pJ/9JJ+HhzPzHuCifq2uVsXrWOyOkKLRu0rTg==
X-Received: by 2002:a17:903:1a07:b0:2ad:6f9b:7817 with SMTP id d9443c01a7336-2aea30c2c43mr124325ad.22.1773113209615;
        Mon, 09 Mar 2026 20:26:49 -0700 (PDT)
Received: from google.com (154.52.125.34.bc.googleusercontent.com. [34.125.52.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e585b3sm152536955ad.10.2026.03.09.20.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:26:48 -0700 (PDT)
Date: Tue, 10 Mar 2026 03:26:44 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	kvmarm <kvmarm@lists.cs.columbia.edu>, kvm@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH v4 09/17] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
Message-ID: <aa-PdKMKz5SndqB0@google.com>
References: <20211111020738.2512932-1-seanjc@google.com>
 <20211111020738.2512932-10-seanjc@google.com>
 <YfrQzoIWyv9lNljh@google.com>
 <CABCJKufg=ONNOvF8+BRXfLoTUfeiZZsdd8TnpV-GaNK_o-HuaA@mail.gmail.com>
 <202202061011.A255DE55B@keescook>
 <YgAvhG4wvnslbTqP@hirez.programming.kicks-ass.net>
 <202202061854.B5B11282@keescook>
 <aa8fNT3P54t5W53T@google.com>
 <20260309223156.GA73501@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309223156.GA73501@google.com>

On Mon, Mar 09, 2026 at 10:31:56PM +0000, Sami Tolvanen wrote:
> Hi Carlos,
> 
> If you need a stub with a matching CFI type for an arbitrary function,
> perhaps you can do something like this (arm64, untested):
> 
>   #define DEFINE_TYPED_STUB_RET0(name, reffunc)			\
> 	typeof(reffunc) name;					\
> 	__ADDRESSABLE(name);					\
> 	asm(							\
> 	"	" __ALIGN_STR "				\n"	\
> 	"	.4byte	__kcfi_typeid_" #name "		\n"	\
> 	#name ":					\n"	\
> 	"	bti c					\n"	\
> 	"	mov x0, xzr				\n"	\
> 	"	ret					"	\
> 	)
> 
> For the !CONFIG_CFI case, or architectures that implement static calls,
> you can probably just point the stub to __static_call_return0:
> 
>   #define DEFINE_TYPED_STUB_RET0(name, reffunc) \
> 	typeof(reffunc) name __asm__("__static_call_return0")
> 
> Sami

Oh that is pretty cool it worked for me. This is the patch I tested
with. Still needs a bit more plumbing but no more CFI issues.

---
diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index 40bd17add539..708dbdf2c9fe 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -5,8 +5,10 @@
 #include <asm/assembler.h>
 #endif
 
+#include <linux/stringify.h>
+
 #define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT
-#define __ALIGN_STR	".balign " #CONFIG_FUNCTION_ALIGNMENT
+#define __ALIGN_STR	__stringify(__ALIGN)
 
 /*
  * When using in-kernel BTI we need to ensure that PCS-conformant
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 78a77a4ae0ea..8b96eb66d2c8 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -184,6 +184,9 @@ extern int static_call_text_reserved(void *start, void *end);
 
 extern long __static_call_return0(void);
 
+#define static_call_update_stub(name)					\
+	static_call_update(name, __static_call_return0)
+
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -270,6 +273,9 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 extern long __static_call_return0(void);
 
+#define static_call_update_stub(name)					\
+	static_call_update(name, __static_call_return0)
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -306,8 +312,25 @@ static inline long __static_call_return0(void)
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	__DEFINE_STATIC_CALL(name, _func, NULL)
 
+/* Move somewhere under arch/arm64/... */
+#define ARCH_DEFINE_TYPED_STUB_RET0(name, reffunc)			\
+	typeof(reffunc) name;						\
+	__ADDRESSABLE(name);						\
+	asm(								\
+	"	" __ALIGN_STR "\n"					\
+	"	.4byte	__kcfi_typeid_" #name "\n"			\
+	#name ":\n"							\
+	"	bti c\n"						\
+	"	mov x0, xzr\n"						\
+	"	ret"							\
+	);
+
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
-	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
+	ARCH_DEFINE_TYPED_STUB_RET0(__static_call_##name, _func)	\
+	__DEFINE_STATIC_CALL(name, _func, __static_call_##name)
+
+#define static_call_update_stub(name)					\
+	static_call_update(name, __static_call_##name)
 
 static inline void __static_call_nop(void) { }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..b60a1991474b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7701,10 +7701,10 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 		return;
 
 	rcu_assign_pointer(perf_guest_cbs, NULL);
-	static_call_update(__perf_guest_state, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_get_ip, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_handle_intel_pt_intr, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_handle_mediated_pmi, (void *)&__static_call_return0);
+	static_call_update_stub(__perf_guest_state);
+	static_call_update_stub(__perf_guest_get_ip);
+	static_call_update_stub(__perf_guest_handle_intel_pt_intr);
+	static_call_update_stub(__perf_guest_handle_mediated_pmi);
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
