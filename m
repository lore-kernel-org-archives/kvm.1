Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212003CF96D
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603659; cv=none; b=XXMcSz/h4pGym0L5faqLBn+1DnisMyPh/csffhrCJXGvs0L39+qSkT9LHAHe6pVctXj+fR4E2b//FiVQhXxU0Y85fAugv1EaWntE2N+5qE4LDmw2lf/vc9wk/4IiQS4iwykDLhI0TsnNeLQKYr5QpzxLz+t2zFnTUKRmrsV8/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603659; c=relaxed/simple;
	bh=AMPs021IOLM19tgxvI/u21IzrVMAenSfk4Og2CvBOho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WvhpmyTVtepZhBP5YL9KTQ67mawROuhzE7080q0UmS0H0qrTWeqqu77EboBLf1HVcSITFnpPVGkd/EIPqhrW0UxliIsw9xnL/aGIbyeXbQqYmXSszX9U8Sr0DOUFEOtYLU31MfE4SAGm4DZXUlagIo0760R+lIISJlRyXKi7vlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGTfd+tH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGTfd+tH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778603656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+j+EDk3PqU7zShLYl+C1OtT3b/AcW4wapeMIOiSceRM=;
	b=ZGTfd+tH5R8UuxBLggI7REkAP1vwgL1ef7LqjG3i89W0W4ccKSEh7RcGcAK/jkbGZBAhBk
	N7z4Fs52U8uducyyeAkCb31CuSZyN+ZhHmXEix8Kec9uwKa5ao6xQBboHLeicaOB5xRfZR
	yRZMX31kq8/DNxiesm6ww5LNbsxnvA0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-DQk1tlW8O2632RXPaMubFA-1; Tue,
 12 May 2026 12:34:13 -0400
X-MC-Unique: DQk1tlW8O2632RXPaMubFA-1
X-Mimecast-MFC-AGG-ID: DQk1tlW8O2632RXPaMubFA_1778603651
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41B02195609E;
	Tue, 12 May 2026 16:34:11 +0000 (UTC)
Received: from [10.44.34.100] (unknown [10.44.34.100])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 093041955D84;
	Tue, 12 May 2026 16:34:09 +0000 (UTC)
Message-ID: <e0fe1c94-9823-4945-ba36-d46bdd85b646@redhat.com>
Date: Tue, 12 May 2026 18:34:08 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Riley <d.riley@proxmox.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jon@nutanix.com
References: <20260505195226.563317-1-pbonzini@redhat.com>
 <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
 <CABgObfZ-UOjO4q3e9o5JGXXCO8VZ50vEZkjNMB44rdcCVxEHxg@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CABgObfZ-UOjO4q3e9o5JGXXCO8VZ50vEZkjNMB44rdcCVxEHxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 5/12/26 16:32, Paolo Bonzini wrote:
The trace shows that CET is not used at all unless MBEC is
> present. In particular (after "trace-cmd record -e kvm ...") I can do:
> 
> $ trace-cmd report |grep  -e msr_write.*da0| sed 's/.*kvm_/kvm_/' | sort -u
> 
> and it shows as expected this with +vmx-mbec,+cet-ss,+cet-ibt:
> 
> kvm_msr:              msr_write da0 = 0x800
> 
> but not with -vmx-mbec,+cet-ss,+cet-ibt.  This initialization is
> performed by Hyper-V even before VMXON, and the breakage happens even
> if Memory Integrity is disabled inside Windows.
> 
> Knowing that Hyper-V was not running any nested guest at the time of
> the hang, I changed __vmcs_writel() to have
> 
>          if (field == SECONDARY_VM_EXEC_CONTROL) value &=
> ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;

I have now reproduced the guest hang with a one line change on top of 
kvm/master:

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 937aeb474af7..43e0f20e4e26 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7231,6 +7231,7 @@ static void nested_vmx_setup_secondary_ctls(u32 
ept_caps,
         if (enable_ept) {
                 /* nested EPT: emulate EPT also to L1 */
                 msrs->secondary_ctls_high |=
+                       SECONDARY_EXEC_MODE_BASED_EPT_EXEC | /* hem hem */
                         SECONDARY_EXEC_ENABLE_EPT;
                 msrs->ept_caps =
                         VMX_EPT_PAGE_WALK_4_BIT |

(which would break very badly if Hyper-V were to start a nested guest, 
but the trace says it doesn't).

Can you check what behavior you get from this (actually silly) change? 
It should allow you to exercise Hyper-V's CET paths without the burden 
of the MMU changes.

Paolo

