Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5B3612FE;
	Thu,  9 Jul 2026 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558843; cv=none; b=JGz3ycuxNUeXBByqL0FE0g1yiBPZzHcKRhnkxT9mn2rQhlZ2DNLG+vpD/qrGLsbpRwUc4xyB2dr63PPKSH9DNLgGxERGoU5GLCjndnyL6VCeLGym8forM+/vvcZmEHFbRZ4foGToxc49DoXXTlsPGds6UA/4HI6mDBi/SFDxXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558843; c=relaxed/simple;
	bh=vHPdmw0HAav8K6TuUujJlaQNOWkb8YcV9GUr9kJyc2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZddq9Ptz1FcME53/xg7wx/d7ZOmR8PGL0TcycoD+e28mep494ZMzoBNELKoWcaAzQs7njvFc5G97cMy97c6wj/VBBYLLRkfBBQTEP8iaYm+ieIvpVlADYL7a5s45HbPsEtIcnCl+IlKG/2EoLRPr9MOwazrQdJZZ2lKkFGDllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08769999|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0356557-0.0132607-0.951084;FP=7486103341572408819|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iGmP6Nc_1783558828;
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iGmP6Nc_1783558828 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 09:00:30 +0800
Message-ID: <f2e91014-2428-4364-a46e-950ad5c1abf4@open-hieco.net>
Date: Thu, 9 Jul 2026 09:00:28 +0800
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
 <56649d82-bce1-4fac-b639-345376d219be@open-hieco.net>
 <CAO9r8zP6vh4dP9j3RDahvm=diwudyfYvUfGtW763ehXavtCi1g@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CAO9r8zP6vh4dP9j3RDahvm=diwudyfYvUfGtW763ehXavtCi1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/9/2026 1:47 AM, Yosry Ahmed wrote:
> On Tue, Jul 7, 2026 at 5:53 PM Tina Zhang <zhang_wei@open-hieco.net> wrote:
>>
>>
>>
>> On 7/8/2026 6:34 AM, Yosry Ahmed wrote:
>>> On Mon, Jun 29, 2026 at 08:52:03PM +0800, Tina Zhang wrote:
>>>> The SVM DecodeAssists feature is reported in CPUID
>>>> Fn8000_000A_EDX[7].  When available, hardware provides the length and bytes
>>>> of the intercepted instruction in the VMCB, allowing a hypervisor to consume
>>>> the decode information directly instead of re-decoding the instruction in
>>>> software on relevant VM-Exit paths.
>>>>
>>>> KVM currently does not expose DecodeAssists to nested SVM guests, even when
>>>> the host supports it, and does not propagate the hardware-provided
>>>> instruction length and bytes from VMCB02 to VMCB12 on nested VM-Exit.  This
>>>> leaves L1 with an incomplete virtual SVM CPUID model and prevents L1 from
>>>> using the same hardware-assisted decode information that KVM receives for
>>>> L2 exits.
>>>>
>>>> The missing virtualization was observed in practice with Hyper-V as L1,
>>>> where the absence of DecodeAssists prevented nested SVM from being made
>>>> available to L2 guests.  The fix is not Hyper-V specific.  Complete nested
>>>> SVM virtualization of DecodeAssists by advertising the feature to L1 when
>>>> supported by hardware, and by copying the decode-assist fields into VMCB12
>>>> on nested VM-Exit.
>>>>
>>>> Add a selftest that triggers a nested page fault from L2 and verifies that
>>>> L1 sees a non-zero instruction length and instruction bytes matching the
>>>> faulting instruction.
>>>
>>> Taking a large step back from all the discussions in the other replies:
>>> Is there a measurable performance improvement? Not trying to say we
>>> shouldn't do this, but we should at least see what we're trading this
>>> complexity for, it's obviously not straigtforward to fully virtualize
>>> decode assists.
>>
>> I don't have a meaningful performance number yet. My current
>> understanding is that the main value of the series is more about
>> architectural completeness and enabling the Hyper-V L1 use case than
>> about a direct performance win.
>>
>> The practical issue that triggered this is Hyper-V as L1 in Hyper-V
>> appears to require DecodeAssists before enabling nested SVM for L2, so
>> the visible benefit is enabling that nested virtualization
>> configuration. Without exposing DecodeAssists to L1 Hyper-V, the nested
>> svm cases like this (L0 KVM + L1 Hyper-V + L2 KVM) would be broken,
>> because the Hyper-V doesn't think the platform have the nested
>> virtualization capability, although the hardware supports it.
> 
> Interesting, that's basically running QEMU in WSL, right? Probably
> worth including the motivation going forward.
Yes, QEMU in WSL is one possible example, but the motivation is simply 
to play nicer with running Hyper-V on top of KVM.

Hyper-V appears to use DecodeAssists as one of the requirements before 
enabling nested SVM for its guests.  Exposing it lets users turn on and 
use Hyper-V virtualization features inside a Windows VM when they need 
them, instead of KVM blocking that setup because the virtual SVM model 
is missing this feature.

I'll include that motivation in the next version.


Thanks,
Tina


> 
>>
>> I agree that fully virtualizing DecodeAssists is not straightforward,
>> and the complexity needs to be justified.  My intent is to keep the
>> implementation biased toward propagating already-available decode state:
>> hardware VMCB02 bytes for hardware exits, emulator-provided bytes for
>> synthesized exits when available, and only using an on-demand fetch as a
>> fallback where no decoded state is available.
>>
>> Thanks,
>> Tina
>>

