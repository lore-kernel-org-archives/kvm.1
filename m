Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A6B3D8916
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366998; cv=none; b=Mng1NsNmQ/rRg1e3Ntn3+W40r9gKmq+GPZd8dANTrlLClDfmUo4VJh6YG5Nt13YWHzs1F6tms3kKzNeZKXG4j4GHiwycSJy2Ne+iat3fnvtBR3qZflp/fHzqRNSGsi6zAJ6NX6wg3DZ7DuGA+/WaGZKxixRlIQbty+68aw5ObNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366998; c=relaxed/simple;
	bh=PuRjaPNGg8zwp562gNbKI7bIhMCQUosNU18ZBHzNvUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7yx2kO2akU/pZCUdHqlb/DvASWa0zAdqSP5ihWAE74+191RDNL6Z4OU01QjH3dnoJ9AIU5ven88s+34tB75Xg4vNSZQtBXU90DOdgTlDEdVlHn5PptIhs6dv2iIWPRM/9TkyvI4BM7I4MFz7b/gmMuMlj2ed2pfCaESfon3G30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuCLzS8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuCLzS8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777366995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YRev9QIrjG17RBBPhibL6wbLwyAtaO32+8AMzElDcdo=;
	b=MuCLzS8JqbIT0Qy0QYZD/IhF/YSPmw8bXb83YJMV+aZuxJjsWKRNTHeMybAGA4S5QVjts1
	Brn5xbvH8V0ukzDhwCnp37YoqfTH0oolD6nsjPPFKa8Fdq5vV2Ifr4IuwnPVxVoNKB57uR
	9OHf11wzOBB4VnXW/KmR44x9tX7MYB4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-_I9uCbmUPRy8pJu0LlXhgw-1; Tue,
 28 Apr 2026 05:03:12 -0400
X-MC-Unique: _I9uCbmUPRy8pJu0LlXhgw-1
X-Mimecast-MFC-AGG-ID: _I9uCbmUPRy8pJu0LlXhgw_1777366991
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56C251800345;
	Tue, 28 Apr 2026 09:03:11 +0000 (UTC)
Received: from [10.32.181.22] (unknown [10.32.181.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F4671800349;
	Tue, 28 Apr 2026 09:03:09 +0000 (UTC)
Message-ID: <6e67df0e-e5f0-43f5-aa86-22e8b01b75d2@redhat.com>
Date: Tue, 28 Apr 2026 11:03:08 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/20] KVM: VMX: Macrofy 64-bit GPR swapping in
 __vmx_vcpu_run()
To: "Chang S. Bae" <chang.seok.bae@intel.com>, seanjc@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, chao.gao@intel.com
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
 <20260428050111.39323-2-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20260428050111.39323-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 4/28/26 07:00, Chang S. Bae wrote:
>   	mov VCPU_RBP(%_ASM_DI), %_ASM_BP
>   	mov VCPU_RSI(%_ASM_DI), %_ASM_SI
>   #ifdef CONFIG_X86_64
> -	mov VCPU_R8 (%_ASM_DI),  %r8
> -	mov VCPU_R9 (%_ASM_DI),  %r9
> -	mov VCPU_R10(%_ASM_DI), %r10
> -	mov VCPU_R11(%_ASM_DI), %r11
> -	mov VCPU_R12(%_ASM_DI), %r12
> -	mov VCPU_R13(%_ASM_DI), %r13
> -	mov VCPU_R14(%_ASM_DI), %r14
> -	mov VCPU_R15(%_ASM_DI), %r15
> +	VMX_LOAD_REGS %_ASM_DI, 8,9,10,11,12,13,14,15

Please pass in VMX_vcpu_arch_regs so that you can use the same
macro for Intel and AMD, similar to the SPEC_CTRL macros.

I would also consider using inst.h's name-to-index conversion:

.macro LOAD_GPRS src:req, regs_ofs:req, regs:vararg
.irp reg, \regs
#ifdef CONFIG_X86_64
	R64_NUM reg_num \reg
#else
	R32_NUM reg_num \reg
#endif
	.if \reg_num <> REG_NUM_INVALID
	mov (\regs_ofs + \reg_num * WORD_SIZE)(%_ASM_DI), \reg
	.else
	.err invalid register \reg
	.endif
.endr
.endm

	LOAD_GPRS %_ASM_DI, VMX_vcpu_arch_regs, \
		%_ASM_AX, %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
#ifdef CONFIG_X86_64
	LOAD_GPRS %_ASM_DI, VMX_vcpu_arch_regs, \
		%r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
#endif
         /* Load guest RDI.  This kills the @vmx pointer! */
	LOAD_GPRS %_ASM_DI, VMX_vcpu_arch_regs, %_ASM_DI

(same for STORE_GPRS).

Note however that inst.h is currently dead code, so it would have to
move into arch/x86/kvm/ as in the patch after my signature.

Paolo


diff --git a/arch/x86/include/asm/inst.h b/arch/x86/kvm/inst.h
similarity index 66%
rename from arch/x86/include/asm/inst.h
rename to arch/x86/kvm/inst.h
index e48a00b3311d..95ca0826effd 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/kvm/inst.h
@@ -1,19 +1,16 @@
  /* SPDX-License-Identifier: GPL-2.0 */
  /*
- * Generate .byte code for some instructions not supported by old
- * binutils.
+ * Convert register names to their sizes and the indices used when
+ * encoding instructions.
   */
-#ifndef X86_ASM_INST_H
-#define X86_ASM_INST_H
+#ifndef X86_KVM_INST_H
+#define X86_KVM_INST_H
  
  #ifdef __ASSEMBLER__
  
  #define REG_NUM_INVALID		100
  
-#define REG_TYPE_R32		0
-#define REG_TYPE_R64		1
-#define REG_TYPE_INVALID	100
-
  	.macro R32_NUM opd r32
  	\opd = REG_NUM_INVALID
  	.ifc \r32,%eax
@@ -121,28 +114,6 @@
  	.endif
  #endif
  	.endm
-
-	.macro REG_TYPE type reg
-	R32_NUM reg_type_r32 \reg
-	R64_NUM reg_type_r64 \reg
-	.if reg_type_r64 <> REG_NUM_INVALID
-	\type = REG_TYPE_R64
-	.elseif reg_type_r32 <> REG_NUM_INVALID
-	\type = REG_TYPE_R32
-	.else
-	\type = REG_TYPE_INVALID
-	.endif
-	.endm
-
-	.macro PFX_REX opd1 opd2 W=0
-	.if ((\opd1 | \opd2) & 8) || \W
-	.byte 0x40 | ((\opd1 & 8) >> 3) | ((\opd2 & 8) >> 1) | (\W << 3)
-	.endif
-	.endm
-
-	.macro MODRM mod opd1 opd2
-	.byte \mod | (\opd1 & 7) | ((\opd2 & 7) << 3)
-	.endm
  #endif
  
  #endif

