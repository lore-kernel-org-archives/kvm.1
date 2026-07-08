Received: from out198-14.us.a.mail.aliyun.com (out198-14.us.a.mail.aliyun.com [47.90.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCB3ABD99;
	Wed,  8 Jul 2026 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783472965; cv=none; b=ArvyRvwByVs0Kqi4rCZ+B7kjy1n1vl5xQLX+VRmcjzDxdC2Rm90KV+hRskKAPnlfaDqJtGtVPkVOKQT2Ty/EgcjPmMdCXzozjxJcOb6ANB23xuxgvei8I6f9TAt3HaJfg7YE9idcP5uVL+v3Mw3D9FzTu1NKnDF4mwz7XdjPoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783472965; c=relaxed/simple;
	bh=4qC54mTYEWQ1nrnfnLFSqKH9SBmC/kjLOY8lESFQn4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5sAeZNBgY8tT9/o6flm0lXF63vpKEjd1q0CqsR5Kk8xhWoq3XMn4A4aOJcjiZMOqY8KJzgu61biuUhkGCgfFnF6D6pVTNeMlDF5mT60W3IjmHcFryL2ZIp99ufrwCMPKHnKuG8+LvWxAhWCDEo8RRiKGKlh0Ajbd9LoLVIWCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1317011|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0477482-0.011172-0.94108;FP=7414045747534480883|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iFoP-Nf_1783471996;
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iFoP-Nf_1783471996 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 08:53:18 +0800
Message-ID: <56649d82-bce1-4fac-b639-345376d219be@open-hieco.net>
Date: Wed, 8 Jul 2026 08:53:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Jim Mattson
 <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <ak1-vF3qUjeszzSC@google.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <ak1-vF3qUjeszzSC@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/2026 6:34 AM, Yosry Ahmed wrote:
> On Mon, Jun 29, 2026 at 08:52:03PM +0800, Tina Zhang wrote:
>> The SVM DecodeAssists feature is reported in CPUID
>> Fn8000_000A_EDX[7].  When available, hardware provides the length and bytes
>> of the intercepted instruction in the VMCB, allowing a hypervisor to consume
>> the decode information directly instead of re-decoding the instruction in
>> software on relevant VM-Exit paths.
>>
>> KVM currently does not expose DecodeAssists to nested SVM guests, even when
>> the host supports it, and does not propagate the hardware-provided
>> instruction length and bytes from VMCB02 to VMCB12 on nested VM-Exit.  This
>> leaves L1 with an incomplete virtual SVM CPUID model and prevents L1 from
>> using the same hardware-assisted decode information that KVM receives for
>> L2 exits.
>>
>> The missing virtualization was observed in practice with Hyper-V as L1,
>> where the absence of DecodeAssists prevented nested SVM from being made
>> available to L2 guests.  The fix is not Hyper-V specific.  Complete nested
>> SVM virtualization of DecodeAssists by advertising the feature to L1 when
>> supported by hardware, and by copying the decode-assist fields into VMCB12
>> on nested VM-Exit.
>>
>> Add a selftest that triggers a nested page fault from L2 and verifies that
>> L1 sees a non-zero instruction length and instruction bytes matching the
>> faulting instruction.
> 
> Taking a large step back from all the discussions in the other replies:
> Is there a measurable performance improvement? Not trying to say we
> shouldn't do this, but we should at least see what we're trading this
> complexity for, it's obviously not straigtforward to fully virtualize
> decode assists.

I don't have a meaningful performance number yet. My current 
understanding is that the main value of the series is more about 
architectural completeness and enabling the Hyper-V L1 use case than 
about a direct performance win.

The practical issue that triggered this is Hyper-V as L1 in Hyper-V 
appears to require DecodeAssists before enabling nested SVM for L2, so 
the visible benefit is enabling that nested virtualization 
configuration. Without exposing DecodeAssists to L1 Hyper-V, the nested 
svm cases like this (L0 KVM + L1 Hyper-V + L2 KVM) would be broken, 
because the Hyper-V doesn't think the platform have the nested 
virtualization capability, although the hardware supports it.

I agree that fully virtualizing DecodeAssists is not straightforward, 
and the complexity needs to be justified.  My intent is to keep the 
implementation biased toward propagating already-available decode state: 
hardware VMCB02 bytes for hardware exits, emulator-provided bytes for 
synthesized exits when available, and only using an on-demand fetch as a 
fallback where no decoded state is available.

Thanks,
Tina

