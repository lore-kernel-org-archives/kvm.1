Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A3375ADF;
	Tue,  7 Jul 2026 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392292; cv=none; b=ptfopZRQSV9SikE9k3LPzJSh4qVQV9ym0r6QcAu8U1rB21oqKHNOiDOdCfv4ge7bIkIEeJjIZ1dyB193ayi9O5n+rR+YFaBfnDitVuI15vkJq5EN22Yw0AQCBbCSU2brg2iQimU8yKuVkPQDhQ5LheabxQ7zhKvffsOyQ0TOI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392292; c=relaxed/simple;
	bh=s8le8rz75dPMvH3KLAL0pyss5QP5CG9SRaMBPk1Lkrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCnjDn2FSRyPZbDQP8PflU8ezVIMugcXifVG+O4Cop8305tIjayZbGqdkIIL/fMZDTB0i7Uf9JSwZcmNOnBbt+If8P3ByZamNs/iKUU9g3kelqcXSw96qYrFZ9/iCJ9StP4oA7gqxNjNwOpp6s2u6G7afPngqjeqWy6NyWkwCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1020282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00380951-0.000328731-0.995862;FP=9179448279238174455|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iEvCEd._1783392276;
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEvCEd._1783392276 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 10:44:39 +0800
Message-ID: <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net>
Date: Tue, 7 Jul 2026 10:44:34 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Jim Mattson <jmattson@google.com>
Cc: mlevitsk@redhat.com, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net>
 <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/7/2026 9:32 AM, Jim Mattson wrote:
> On Mon, Jul 6, 2026 at 5:02 PM Tina Zhang <zhang_wei@open-hieco.net> wrote:
> 
>> I will take another look for the next version and try to handle the
>> remaining pieces properly, while also making sure we don't expose stale
>> or incorrectly synthesized decode-assist state for emulated exits.
> 
> Naples erratum 1096 seems to imply that the instruction bytes stored
> in the VMCB are not necessarily the same instruction bytes that were
> fetched and decoded to lead to the #PF/#NPF. Hence, in the case of
> emulation, it might be sufficient to read the instruction bytes quite
> late in nested_svm_vmexit(). That would certainly simplify the
> plumbing.

Thanks for the suggestion, and for pointing me at Naples erratum 1096. 
I wasn't aware of that erratum.

My understanding is that late fetching/decoding from guest RIP is not 
strictly equivalent to preserving the exact bytes observed by the 
original decoder, as the code bytes or translations could theoretically 
change in between. But the suggested workaround for erratum 1096 also 
tells the hypervisor to decode the instruction at the instruction 
pointer when GuestInstrBytes cannot be used, so it seems that this is an 
acceptable model/fallback.

For KVM-synthesized/emulated #PF/#NPF nested VM-Exits there is no fresh 
hardware GuestInstrBytes state to propagate to VMCB12. So I agree that 
it should be simpler to avoid plumbing instruction bytes from the 
emulator, and instead fetch the bytes late when constructing the nested 
VM-Exit for L1.

I'll try this direction first.



Thanks,
Tina

