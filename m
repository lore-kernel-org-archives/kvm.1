Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941424;
	b=sxSmKAnxn59KLl9pHcLkT+u3+Mc2/+AiQYI2ukPclitUJTe5fbBCZSVbnfxpNImZfs8I
	 YYYasiwELK+qw6NWoXVOdxmX5uKcdoncRhv3uW+z6vOS8sx2FTaVNhzKO0cttJupJS/il
	 1JjRVK9/udJqMA7O2FSdkU/UQw1yod58gtTptahARsojVZKkPwX9hwxF+lnPiZRnkB149
	 RqiO1P41py3eb+LdeFSVzRn/pOY/KpuAyHWeMLdr5tOWZsiHeYEHL8T3NYQPu3srRUPPR
	 mNdvhudjvwxjcDcvVfwJooobutYqOXvL0993C/dOw100dQKOy/WISQU4CwDRmUZU2rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941424;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=zoawJywOaTBm+laOZNDVSRXudIOW0/uAu16qaS2MLiA=;
	b=G5h4JQ/1P4aePc6GwepWG2c2GL2YTsXzl6/ka/5iFNmU7tTsG3A4am2A38ykki3rc+6J
	 QVocZ3ZPNjfkROHALkFL+fXAhnz9dSboxLlL53H3+kYUXPsujdqGhazjei3gyJI+lufLZ
	 IcyLf9vNLsbjvLqsklJod+eDad20LYNAzzAYPdo5V0wy/o8iuSdAddgk2B6Yt+94+lIgP
	 x0DVNN6/uq9rUyTOkTePozGEApWmDZxvPBTP8PM3T2lPCfESbqkHgCLG9EIrXv4fDZ43W
	 0CYCrVgsBTqGbfyZLwIeCcC7JcsAKTx8p7GcIZYfojKnov6PR5knlE8UtOF78Imx3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XIoHJnMO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021F60A2618
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 18:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A021F60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XIoHJnMO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794941422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zoawJywOaTBm+laOZNDVSRXudIOW0/uAu16qaS2MLiA=;
	b=XIoHJnMOijLOOwb+Q1oKOHFOYYVZxdfQiOCx3ibkgvN6iayok1lCE+AzboQQ0VG58fUdW/
	VlMiYVA6zDroxD8X3dFu9Y+ZYIj2bXjy1jtNGBzijJx6yWaw84Gczy+QsSTNByYgRohAFB
	gAPhfNGFU778176/5Jq2xfpm4vRNlss=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-u_Mb5VU4OweZy85LRGw_kA-1; Tue,
 17 Nov 2026 13:50:18 -0500
X-MC-Unique: u_Mb5VU4OweZy85LRGw_kA-1
X-Mimecast-MFC-AGG-ID: u_Mb5VU4OweZy85LRGw_kA_1794941417
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AE73195604D;
	Tue, 17 Nov 2026 18:50:17 +0000 (UTC)
Received: from [100.90.222.41] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7774C195B3C2;
	Tue, 17 Nov 2026 18:50:15 +0000 (UTC)
Message-ID: <7b4beea2-2bc9-44d8-be6a-ecfe678091dc@redhat.com>
Date: Tue, 17 Nov 2026 19:50:13 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Don't reuse the GPA of a fault on the guest's
 page tables
To: Sasha Levin <sashal@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Kyle Zeng <kylebot@openai.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261027191914.2341911-1-sashal@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20261027191914.2341911-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/27/26 20:19, Sasha Levin wrote:
> DecodeAssist provides the instruction bytes, the read of 0xc0000000 has
> the same page offset as 0x180000, and the emulator turns it into an MMIO
> read of 0x180000:
> 
>    ==== Test Assertion Failure ====
>      set_memory_region_test.c:83: run->mmio.phys_addr == MEM_REGION_GPA
>      ...
>      Unexpected exit mmio address = 0x180000
> 
> If the vCPU is at the next instruction instead, the #NPF happens on the
> code fetch, DecodeAssist provides no bytes, KVM fails to fetch the
> instruction itself and injects a #PF, and the guest shuts down as the
> test expects.  KernelCI sees the failure in about half of the runs on a
> DL345 Gen11 (EPYC).
> 
> The CPU walks the guest's page tables with write accesses, so such faults
> also set EMULTYPE_PF_WRITE, and a write would be redirected the same way.
> 
> Tell the emulator when the fault occurred on the guest's page tables and
> don't use the GPA for the access then, so that the access is translated
> through the guest's page tables.  KVM can't walk the encrypted page tables
                                     ^^^^^^^^^

This is a separate bug; something like "Also, KVM can't walk..." would be
better - but actually a separate patch would be even better.

The non-SEV part looks good.  I'll wait for Sean to shout that it isn't,
or otherwise apply it and send out the SEV patch below.
> +	/*
> +	 * Don't emulate if the #NPF occurred while walking the guest's page
> +	 * tables.  The GPA is that of a guest paging structure, not of the
> +	 * access, and KVM can't walk the guest's encrypted page tables to
> +	 * translate the access itself.  Resume the guest, see below.
> +	 */
> +	if (emul_type & EMULTYPE_PF_GUEST_PAGE)
> +		goto resume_guest;

Here I would return X86EMUL_UNHANDLEABLE, which causes an internal-error
exit or #UD.  Also, even though it's mostly aesthetic, SEV only gets
emulation for #PF and the code is already consulting exit_info_1.  In
fact it is already checking PFERR_GUEST_PAGE_MASK but in the wrong order.
Something like this will do:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index af0deb198a84..4e0f5a8c8275 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5513,19 +5513,29 @@ static int svm_check_emulate_instruction(
  	}
  
  	/*
-	 * Emulate for SEV guests if the insn buffer is not empty.  The buffer
-	 * will be empty if the DecodeAssist microcode cannot fetch bytes for
-	 * the faulting instruction because the code fetch itself faulted, e.g.
-	 * the guest attempted to fetch from emulated MMIO or a guest page
-	 * table used to translate CS:RIP resides in emulated MMIO.
+	 * Under SEV, page tables are encrypted and cannot be read by the
+	 * hypervisor, so there is no way to resolve a fault on page tables.
  	 */
+	error_code = svm->vmcb->control.exit_info_1;
+	if (error_code & PFERR_GUEST_PAGE_MASK)
+		return X86EMUL_UNHANDLEABLE;
+
  	if (likely(insn_len))
  		return X86EMUL_CONTINUE;
  
  	/*
-	 * Detect and workaround Errata 1096 Fam_17h_00_0Fh.
+	 * The insn buffer was empty; the DecodeAssist microcode could not fetch
+	 * bytes for the faulting instruction because the code fetch itself faulted,
+	 * e.g. the guest attempted to fetch from emulated MMIO or a guest page
+	 * table used to translate CS:RIP resides in emulated MMIO.  Just retry.
+	 */
+	if (error_code & PFERR_FETCH_MASK)
+		goto resume_guest;
+
+	/*
+	 * A data fault could actually be Errata 1096 Fam_17h_00_0Fh.
+	 * Detect it to apply a workaround.
  	 *
-	 * Errata:
  	 * When CPU raises #NPF on guest data access and vCPU CR4.SMAP=1, it is
  	 * possible that CPU microcode implementing DecodeAssist will fail to
  	 * read guest memory at CS:RIP and vmcb.GuestIntrBytes will incorrectly
@@ -5552,12 +5562,8 @@ static int svm_check_emulate_instruction(
  	 *       retrieve the instruction bytes is legitimate (see abvoe).
  	 *
  	 * In addition, don't apply the erratum workaround if the #NPF occurred
-	 * while translating guest page tables (see below).
+	 * while translating guest page tables (see above).
  	 */
-	error_code = svm->vmcb->control.exit_info_1;
-	if (error_code & (PFERR_GUEST_PAGE_MASK | PFERR_FETCH_MASK))
-		goto resume_guest;
-
  	smep = kvm_is_cr4_bit_set(vcpu, X86_CR4_SMEP);
  	smap = kvm_is_cr4_bit_set(vcpu, X86_CR4_SMAP);
  	is_user = svm_get_cpl(vcpu) == 3;


Paolo

