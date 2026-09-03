Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73593546E0;
	Thu,  3 Sep 2026 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403303; cv=none; b=NkEVnkxlZioMeZ+cwKZcwEwzqnFFojxrF/XywVk5R4KlzC3HJ24kwr6WLzXUv6dDRbydeGmMSSpQ98Y/g3WLoeXnL1+Vwd0vfL9uwpo8rEhZ1iiAnq8Q9zSvFCMff70dv/Jva7D1Fxaz6vckBpcb5zJ4y9g8nL5Ibdu6BA0Wvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403303; c=relaxed/simple;
	bh=6u4PHAZ/H4x65SWpE7IYKnikm6E+U38Lj4eVkpdhFKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bj7teHrbiciLcnlX0MP1SzNQ7BdavcX31/B+6JznCg6aJldUZD+y91G7/5UYNQKKE9RGuJv2j1tgHUlMNU7FPtbRPUHgJEAvqrQpmrMOdZzUmKj9KcXaeaDSS89j7feOkmV40gNY0SRpsXL5L7qSiQmT0cazb/c9x1S98DyS8Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09446921|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00875414-0.00211812-0.989128;FP=7200128259874146027|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.j429d-8_1788403282;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.j429d-8_1788403282 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 10:41:26 +0800
Message-ID: <9515a124-5c18-4015-b64a-e80bb6b84264@open-hieco.net>
Date: Thu, 3 Sep 2026 10:41:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] KVM: nSVM: Enable DecodeAssists for nested guests
To: Sean Christopherson <seanjc@google.com>, Jim Mattson
 <jmattson@google.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <20260824123954.315112-1-zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean and Jim,

A gentle ping on this series. I believe v5 addresses all the comments 
from the previous review rounds. Could you please take another look when 
you have a chance? Any further comments would be appreciated.

Thanks,
Tina


On 8/24/2026 8:39 PM, Tina Zhang wrote:
> The SVM DecodeAssists feature provides decode state for selected
> VM-Exits.  KVM currently does not expose this feature to L1.  Some L1
> hypervisors may therefore treat the platform's SVM support as
> incomplete.
> 
> In practice, this was observed with Hyper-V running on top of KVM.
> Hyper-V appears to require DecodeAssists before enabling nested SVM for
> its guests.  Virtualizing the feature lets users enable Hyper-V
> virtualization features inside a Windows VM when needed, e.g. to run
> QEMU/KVM in WSL.  Without DecodeAssists, Hyper-V does not enable nested
> SVM because DecodeAssists is missing from KVM's virtual SVM model.
> 
> Virtualize both parts of DecodeAssists for nested SVM.  For emulated
> MOV CR/DR, INTn, INVLPG, and INVLPGA intercepts, synthesize the
> architectural EXITINFO state that hardware would provide to L1.
> 
> For data #PF and #NPF VM-Exits, provide GuestInstrBytes from fresh
> VMCB02 state, matching emulator fetch bytes, or an on-demand fetch from
> the current L2 CS:RIP, depending on how the nested VM-Exit was produced.
> Instruction-fetch faults report no instruction bytes, and encrypted
> guests do not use the on-demand fallback.
> 
> Add a focused selftest covering synthesized EXITINFO, hardware and
> synthesized GuestInstrBytes, truncated instruction fetching, and
> instruction-fetch faults.  The test has been run with
> kvm.force_emulation_prefix both disabled and enabled.
> 
> Changes since v4:
> - Drop the generic queued-exception provenance tracking for delayed and
>    synthesized #PF VM-Exits.  Fetch their instruction bytes from the
>    current L2 CS:RIP when constructing VMCB12 instead.
> - Keep matching emulator fetch bytes only for synthesized #NPF exits,
>    and use the on-demand fetch to fill any missing tail.
> - Reduce the series from nine to eight patches by removing the generic
>    x86 exception-tracking patch.
> - Trim the selftest to focused cases that cover distinct implementation
>    paths and regressions, removing redundant instruction variants,
>    overlapping boundary cases, and userspace event-state coverage.
> 
> v4:
> https://lore.kernel.org/r/cover.1787116250.git.zhang_wei@open-hieco.net
> 
> Changes since v3:
> - Rebase onto kvm-x86/next.
> - Register DecodeAssists in the CPUID 0x8000000A SVM capability
>    initializer so that common code validates its CPUID word before the
>    SVM code enables it for nested guests.
> - Make the VMCB02 instruction-byte source const and simplify the
>    synthesized-byte copy and fallback-fetch flow.
> 
> v3:
> https://lore.kernel.org/r/cover.1785411877.git.zhang_wei@open-hieco.net
> 
> Changes since v2:
> - Rebase onto kvm-x86/next.
> - Track hardware-provided instruction bytes independently of the VMCB02
>    exit code, and preserve the bytes when L0 handles an intercepted #PF
>    before reflecting it to L1.
> - Select the instruction-byte source using host-owned VMCB02 state
>    instead of control fields in guest-owned VMCB12.
> - Record whether a queued #PF VM-Exit has a matching emulator context,
>    so userspace-injected #PF exits do not consume stale emulator bytes.
> - Stop fallback instruction fetches at noncanonical addresses and at the
>    32-bit linear-address boundary.
> - Extend the selftest with regression coverage for replacing a hardware
>    #NPF with a synthesized #NPF and for userspace-injected #PF during
>    emulation, and harden its page layout and ucall handling.
> 
> v2:
> https://lore.kernel.org/r/cover.1783999988.git.zhang_wei@open-hieco.net
> 
> Changes since v1:
> - Split the implementation into seven patches to make the individual
>    pieces easier to review.
> - Add EXITINFO virtualization for emulator-generated MOV CR/DR, INTn,
>    INVLPG, and INVLPGA intercepts.
> - Limit GuestInstrBytes propagation to data #NPF and intercepted #PF
>    exits, and clear the fields for instruction-fetch and unrelated exits.
> - Provide GuestInstrBytes for KVM-synthesized data #PF/#NPF exits.  Use
>    matching emulator bytes first and fetch missing bytes from L2 RIP as a
>    fallback, while avoiding fallback reads for SEV guests.
> - Expand the selftest beyond hardware #NPF and stale-state coverage to
>    exercise hardware, synthesized, userspace-injected, instruction-fetch,
>    page-boundary, and CS-limit cases.
> 
> v1:
> https://lore.kernel.org/r/20260629125205.52394-1-zhang_wei@open-hieco.net
> 
> Tina Zhang (8):
>    KVM: x86: Add helper to provide intercept linear addresses
>    KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
>    KVM: nSVM: Track fresh hardware DecodeAssist bytes
>    KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
>    KVM: nSVM: Use emulator bytes for synthesized nested #NPF
>    KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF
>    KVM: nSVM: Advertise DecodeAssists to L1
>    KVM: selftests: Add nested SVM DecodeAssists test
> 
>   arch/x86/kvm/cpuid.c                          |   1 +
>   arch/x86/kvm/emulate.c                        |  29 +-
>   arch/x86/kvm/kvm_emulate.h                    |   1 +
>   arch/x86/kvm/svm/nested.c                     | 180 ++++++-
>   arch/x86/kvm/svm/svm.c                        |  56 +-
>   arch/x86/kvm/svm/svm.h                        |  17 +-
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../selftests/kvm/include/x86/processor.h     |   1 +
>   .../kvm/x86/svm_nested_decode_assists_test.c  | 482 ++++++++++++++++++
>   9 files changed, 754 insertions(+), 14 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
> 
> 
> base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e

