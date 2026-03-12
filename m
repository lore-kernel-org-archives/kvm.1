Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9362BDC3F
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315995; cv=none; b=mamOeQCDU0k3gUbhGFyL2HO/46cgoW4qg5tua1DbxlOwo3DoMirBTOgN+rFdMVM/wt/9qb4Q2H7nU+mIPIXVpWfCUJFsDLBEK5eBhkeHJjpTy8MoHXY6KMXJgiraRys79444TFE+gchLWiXWVr7viFPUzyxxOx34tMIt3IGhZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315995; c=relaxed/simple;
	bh=D/ac6jsdi2dxweLwCmUjcDC6XJRKBhz3oUm0sWMUuWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRsPKfEr/FJTASBjBjCaqaDLOPA1/GSJaQXZIGMX4AHdkkVpK74KfXCBkBeCwpMjt6cr5thrwF1l2oxEkTtI6WLIH+5oJfqfeQ6IrXHsP/H0CkaY4MDnJhgKb0I3Poqlf1rSsVQCtg446V2tXAGVytVz10+wWDZk+zLF/Xp89AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxOdysci; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxOdysci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773315993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fMNcOwOlBAEo5btyRLNG+NBGFSH7Zf02kbAJCyhLfuA=;
	b=VxOdysciDG45cmEzT3MmHrcxUYOdo8KPqhTXDQC6QZWxAspUDPT8IkWXVpAy1Lof1KrbRu
	eVCXnie5iYf1UTVoL6seDpBbTI6qYTq5OIyjPqxMTZARNdt7K+xMldcSsAjMcIQvO65GkB
	2DsNev3vS10KfnrvdEatNnP/k+mYa4k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-c6V5cGbvNHCxwoGjWnbimA-1; Thu,
 12 Mar 2026 07:46:29 -0400
X-MC-Unique: c6V5cGbvNHCxwoGjWnbimA-1
X-Mimecast-MFC-AGG-ID: c6V5cGbvNHCxwoGjWnbimA_1773315987
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88E9318002F1;
	Thu, 12 Mar 2026 11:46:27 +0000 (UTC)
Received: from [10.44.32.138] (unknown [10.44.32.138])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C6C31800361;
	Thu, 12 Mar 2026 11:46:23 +0000 (UTC)
Message-ID: <d2cba245-8532-4f89-8a95-0661b4c3eb36@redhat.com>
Date: Thu, 12 Mar 2026 12:46:21 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Add support for cmpxchg16b emulation
To: Sean Christopherson <seanjc@google.com>,
 Sairaj Kodilkar <sarunkod@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, nikunj.dadhania@amd.com, Manali.Shukla@amd.com
References: <20260306102047.29760-1-sarunkod@amd.com>
 <aar082uQQhXKNiSQ@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aar082uQQhXKNiSQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 3/6/26 16:38, Sean Christopherson wrote:
>> -	if (ctxt->dst.bytes == 16)
>> +	/* Use of the REX.W prefix promotes operation to 128 bits */
>> +	if (ctxt->rex_bits & REX_W)
> 
> Uh, yeah, and the caller specifically pivoted on this size.  I'm a-ok with a
> sanity check, but it should be exactly that, e.g.
> 
> 	if (WARN_ON_ONCE(8 + (ctxt->rex_bits & REX_W) * 8 != ctxt->dst.bytes))
> 		return X86EMUL_UNHANDLEABLE;


> And then emulator_cmpxchg_emulated() should be taught to do cmpxchg16b itself:
> 
> 	/* guests cmpxchg8b have to be emulated atomically */
> 	if (bytes > 8 || (bytes & (bytes - 1)))
> 		goto emul_write;
> 
> That might be a big lift, e.g. to get a 16-byte uaccess version.  If it's
> unreasonably difficult, we should reject emulation of LOCK CMPXCHG16B.

It's actually pretty easy because a kind soul already wrote the
cmpxchg8b version of the macros.  Compile-tested only (and checked
that the asm does have the instruction):

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a4410..f40e815263233 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -388,14 +388,13 @@ do {									\
  		*_old = __old;						\
  	likely(success);					})
  
-#ifdef CONFIG_X86_32
-#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label)	({	\
+#define __try_cmpxchg8b_16b_user_asm(_b, _ptr, _pold, _new, label)({	\
  	bool success;							\
  	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
  	__typeof__(*(_ptr)) __old = *_old;				\
  	__typeof__(*(_ptr)) __new = (_new);				\
  	asm_goto_output("\n"						\
-		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
+		     "1: " LOCK_PREFIX "cmpxchg" #_b "b %[ptr]\n"	\
  		     _ASM_EXTABLE_UA(1b, %l[label])			\
  		     : CC_OUT(z) (success),				\
  		       "+A" (__old),					\
@@ -407,7 +406,6 @@ do {									\
  	if (unlikely(!success))						\
  		*_old = __old;						\
  	likely(success);					})
-#endif // CONFIG_X86_32
  #else  // !CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
  #define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label)	({ \
  	int __err = 0;							\
@@ -433,7 +431,6 @@ do {									\
  		*_old = __old;						\
  	likely(success);					})
  
-#ifdef CONFIG_X86_32
  /*
   * Unlike the normal CMPXCHG, use output GPR for both success/fail and error.
   * There are only six GPRs available and four (EAX, EBX, ECX, and EDX) are
@@ -441,13 +438,13 @@ do {									\
   * both ESI and EDI for the memory operand, compilation will fail if the error
   * is an input+output as there will be no register available for input.
   */
-#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label)	({	\
+#define __try_cmpxchg8b_16b_user_asm(_b, _ptr, _pold, _new, label)	({	\
  	int __result;							\
  	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
  	__typeof__(*(_ptr)) __old = *_old;				\
  	__typeof__(*(_ptr)) __new = (_new);				\
  	asm volatile("\n"						\
-		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
+		     "1: " LOCK_PREFIX "cmpxchg" #_b "b %[ptr]\n"	\
  		     "mov $0, %[result]\n\t"				\
  		     "setz %b[result]\n"				\
  		     "2:\n"						\
@@ -464,7 +461,6 @@ do {									\
  	if (unlikely(!__result))					\
  		*_old = __old;						\
  	likely(__result);					})
-#endif // CONFIG_X86_32
  #endif // CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
  
  /* FIXME: this hack is definitely wrong -AK */
@@ -552,9 +549,15 @@ do {										\
  
  extern void __try_cmpxchg_user_wrong_size(void);
  
-#ifndef CONFIG_X86_32
+#ifdef CONFIG_X86_32
+#define __try_cmpxchg64_user_asm(_ptr, _pold, _new, label)		\
+	__try_cmpxchg8b_16b_user_asm(8, _ptr, _pold, _new, label)
+#else
  #define __try_cmpxchg64_user_asm(_ptr, _oldp, _nval, _label)		\
  	__try_cmpxchg_user_asm("q", "r", (_ptr), (_oldp), (_nval), _label)
+
+#define __try_cmpxchg128_user_asm(_ptr, _pold, _new, label)		\
+	__try_cmpxchg8b_16b_user_asm(16, _ptr, _pold, _new, label)
  #endif
  
  /*
@@ -581,6 +584,9 @@ extern void __try_cmpxchg_user_wrong_size(void);
  	case 8:	__ret = __try_cmpxchg64_user_asm((__force u64 *)(_ptr), (_oldp),\
  						 (_nval), _label);		\
  		break;								\
+	case 16:__ret = __try_cmpxchg128_user_asm((__force u128 *)(_ptr), (_oldp),\
+						 (_nval), _label);		\
+		break;								\
  	default: __try_cmpxchg_user_wrong_size();				\
  	}									\
  	__ret;						})
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f2db04aa6a17f..3e1bd9cdd75e6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7973,7 +7973,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
  	int r;
  
  	/* guests cmpxchg8b have to be emulated atomically */
-	if (bytes > 8 || (bytes & (bytes - 1)))
+	if (bytes > 2 * sizeof(unsigned long) || (bytes & (bytes - 1)))
  		goto emul_write;
  
  	gpa = kvm_mmu_gva_to_gpa_write(vcpu, addr, NULL);
@@ -8013,6 +8013,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
  	case 8:
  		r = emulator_try_cmpxchg_user(u64, hva, old, new);
  		break;
+#ifdef CONFIG_X86_64
+	case 16:
+		r = emulator_try_cmpxchg_user(u128, hva, old, new);
+		break;
+#endif
  	default:
  		BUG();
  	}


(with the uaccess.h part to be split in a separate patch, of course).

Paolo

