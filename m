Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083619;
	b=4EB2NhVY/5Ltp6xQ/UAemuyr+pxw6nQOYq9aj8X80Ra0Wlj/faY7PG7bT4Y5GX1Vvfca
	 +Bc3Bm/7sBmJTk2oHHIRpCg0+zQEpBS/St6jaNwKQVxHaZEQkiuMMroRInEZAW8Hz014A
	 tig60G4fkxTI5p7v+E4+IuRQilS9UCw4Hb0yAaa955evia9q5xDCrzSoJRF1aQbuNUvVw
	 1xyM9Au8EBOjgNWQiKS7/sN6Y2ziJ6as6AFyDxmfoVZVIUPxWjmG1Oby6sL0Ub2qThHBO
	 tzEju2w5ESn+h4sj/C0/OzeuqCT8+mvF6lt1+1L83L2dY7h7aqv5ZtrOnDPuK0YPubQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JcaGUQbRazqsv6mT2YuGwgADTFeIvqCswJSmdStymkM=;
	b=bpOVSmvgAhk5B4zrYRbsOPJefu/9iSC5EcA5cNdkoa5gqmL4H5wBwxP1FTBvDypnU6fL
	 W+/sCr0qc6r/xvagKJp7HSWTNDLB1dWowkhXgaij67BEu1ILOUFyn8mY6KFdGTA/XfWvJ
	 LiGUsnA4P3jfCatPiTmXQ5/KKQ6UdhX6p3H9zcZsw/TWTAWHk5JUwYtwQRtTSCl9uijgY
	 P3MaBS5je4kSSjAQ//0C+cCw1CVoQYcJdqgmADTpZSY9y/5LJlX373N1XamENhrYLdGrp
	 zDxS1IO/mXjCiI91lnMtRGgPw0FVTGU0vKwhrNmyn4VlAgLGxHowK7faeJD0W2hwPDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aoYG9MVV;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E16606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 06:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aoYG9MVV
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e4831c028so2128958f8f.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 23:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793083617; x=1793688417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JcaGUQbRazqsv6mT2YuGwgADTFeIvqCswJSmdStymkM=;
        b=aoYG9MVVv2kdAHg5xrumowJ/Zuwm+S41V+U/YtgjSziVxJGO9TTcFt3e6gC1YZrGdH
         gdgInILPjDt8vfGHPSr9IVS05UHfMSnysg8PPKfKeKPL1Pd6Wx9fcbM1nfobRiLAV4mQ
         beVTyk5FiQOt7Kb/AqDJ0SntYRjcRTvsw1Zxh6DTPB/q5PFg/d/6dnzsGhWRLhhkY7ql
         BjIVZThStZSHAh3+fAF79rl2ssHOhe3cESJS6iEtJessdsuyl19HgJ6JPn7uWMc1C8Mb
         ilG1V+MvOMMG+YqJwh0G2HCuZ+zDjH3RY0KkxZsRkPIxLOZ23drpYSGgt7Y/Z/nJuJfD
         BtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793083617; x=1793688417;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JcaGUQbRazqsv6mT2YuGwgADTFeIvqCswJSmdStymkM=;
        b=Lphi1ZtLJJgQOELNXd+LxAka8uhiyS+BVR4QN0iolN4zK7/Ar04MCGwDJ2mvKZ7/Ht
         Sbo2HLxiaXqIoPP40arrMoZUL8QuBTsmoDDxtQtUqrBjvLPdQ7+eknu9GnZCmszzC5ys
         FZMa78Mj3Yc9ottNvfJz1ZnvtpKGjkbKOuCVqWmGYMghABM636bGTrblAsxYEmgmwFow
         Lz+O9ii1zdut96JYvIge5rwPp4LvGKFyjr+ScK0Gk8VRxxdCAvRsha8m2aQz8jdm1IfH
         9wIkKlSX9PTH9m2i8oqVlY1b47HdfvO/6md/rZEPxcs6jx4/pJsPLxXd/GKaY0ZRUqMZ
         /uNA==
X-Forwarded-Encrypted: i=1; AKwUvBwphUs/qttKmeMBCRG6KduCuAGaVklBTH7QD/KH2E8q7zymbTpmUhFC05QTYTjqCUcSAGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtkloJioP4GhcOL7mt0jl2OoOUTHkfnJk/1nht/9OSwsZGBOsv
	VLUQBfSN4aJpSDTY5s6LUYiRG9ffHjSmUfX+TVzhAUEqTwuB24x8pDr8Shg9UjkiUYg=
X-Gm-Gg: AYBFou3oEJVcYtTWWmZ7YomQS/ZBJoGuUYyKfyOjhZhVjCn05UojBWDarhZHpKA7Y+j
	dV+mGKgsNmpoawv/beSHM0xT2yxBSWtSn16OqKBAFUyvs12JPBugXn2bahdzAMZbhHk/BzXzExR
	BMEsXq7hFO3gitvvw2DR2dTfMNdNxP/TME9RKjLYGwfsp5YYCyuUe0gHhpi+eJF0M2mkSdVq7Fv
	lo/Kl5p923ilWnaApOqRPyxsWjlE9rpNFCMp0oeTDu6TkBr1vcVb3EPc3pn8QEDDbSX1sA7Qfdl
	ywJr8d3Jx546tfGIgXt7dW2+8//cpXJb9zXLZXIVC8ZeoFQ0b663z79Ho98s6n0xoQDgPJQTVp7
	9B7Zd9ZhrwWkvKXFLu3+kfkA2iS+h5zFPo6TueIhf3o+X5xCvJgUkwf1I6PnaoGXu04x0OsyUqh
	2Axsi2rstyOp2zQKyfxU+eR8MTmKJISVNrwCuyU8RAmZaZ5NozQS4tijF9QrMFTimLuZNeoDcIW
	22R68wSRxPynUjjXNvfnJeyVWb9tjIjkL/cs+RPBNW8TvaVsBkTlxy3Q8DJ85PY4b8Hh9j/THvH
	IhmU
X-Received: by 2002:a05:6000:3104:b0:488:8232:d16e with SMTP id ffacd0b85a97d-48e3eb86a37mr16372061f8f.45.1793083616708;
        Mon, 26 Oct 2026 23:46:56 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm21829653f8f.28.2026.10.26.23.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 23:46:56 -0700 (PDT)
Message-ID: <5b26f7b4-0156-4165-a86c-45f5ae7736d7@suse.com>
Date: Tue, 27 Oct 2026 08:46:54 +0200
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
Subject: Re: [PATCH v5 0/5] KVM: TDX: Validate directly configurable CPUID
 bits
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, xiaoyao.li@intel.com,
 chao.gao@intel.com, tony.lindgren@linux.intel.com, kishen.maloor@intel.com,
 dedekind1@gmail.com, adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <fe3eaf31-acc3-4132-b768-9451c00aa746@suse.com>
 <c2fbd673-6f2a-446e-b5d3-04a97bb86930@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <c2fbd673-6f2a-446e-b5d3-04a97bb86930@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.10.26 г. 5:17 ч., Binbin Wu wrote:
> On 10/22/2026 1:43 AM, Nikolay Borisov wrote:
>>
>>
>> On 16.10.26 г. 12:14 ч., Binbin Wu wrote:
>>> The TDX module reports a set of CPUID bits that the VMM can directly
>>> configure for a TD, but KVM cannot blindly expose all module-supported
>>> bits to userspace.  Certain features imply additional architectural state
>>> (such as one or more MSRs) that KVM must explicitly manage across
>>> host/guest transitions to prevent host state corruption.
>>>
>>> Today, KVM hardcodes a denylist to filter out host state clobbering
>>> features that KVM doesn't support.  However, a denylist doesn't scale as
>>> the TDX module evolves, i.e. host state clobbering features added by a
>>> future TDX module are not covered by the denylist, and userspace could
>>> enable a feature that KVM doesn't support.
>>>
>>> This series builds an allowlist for directly configurable CPUID bits, and
>>> filters and validates userspace input against it, so that newly introduced
>>> TDX directly configurable CPUID feature bits can only be enabled by
>>> userspace after KVM explicitly opts in.  Except for a few fixed-1 bits
>>> required for basic TDX support, host state clobbering features are either
>>> directly configurable or gated by TD ATTRIBUTES/XFAM.  KVM already
>>> validates ATTRIBUTES/XFAM, so the allowlist only needs to cover directly
>>> configurable bits.
>>>
>>> Patch 1 is a standalone fix for the existing denylist check, which uses
>>> the index of the matched userspace entry instead of the subleaf reported
>>> by the TDX module, i.e. userspace can bypass the HLE/RTM/WAITPKG check.
>>> It is tagged for stable so that it can be backported independently of
>>> the rest of the series.
>>>
>>> Patches 2-5 build the allowlist, add CORE_CAPABILITIES to it, filter
>>> KVM_TDX_CAPABILITIES, and validate the CPUID input of KVM_TDX_INIT_VM.
>>> The last two patches are user-visible changes, which are now called out
>>> in their changelogs, along with why existing userspace and guests are not
>>> expected to be affected.
>>>
>>> For this version, I'm hoping to continue to collect some RBs and Acks.
>>> The key discussions from v3/v4 [1] are summarized below.  Note, FRED KVM
>>> support is in progress upstream [2], and no TDX module with FRED support
>>> exists yet, so there is no immediate issue.  But it would be nice to get
>>> this series merged sooner rather than later.
>>>
>>> Discussions from v3/v4:
>>> - Rick asked whether the assumption that the reserved bits in
>>>     CPUID.0x1.EAX, CPUID.{0x4,0x18,0x1F} and CPUID.0x80000008.EAX won't be
>>>     used to enumerate features can be confirmed by the x86 architects [3].
>>>     Confirmation is still pending.  Per the SDM/APM, these leaves/registers
>>>     are defined for specific information (version, cache/TLB parameters,
>>>     topology, and address sizes), so the reserved bits are expected to be
>>>     used to extend the existing information rather than to enumerate
>>>     features.  Allowing these registers in full is a best guess, but it's
>>>     still far better than the existing denylist-based check.
>>>
>>> - Whether to restrict the TDX feature bits to kvm_cpu_caps[].
>>>     The conclusion from the discussions is to construct the allowlist based
>>>     on kvm_cpu_caps[], plus a few bits that KVM can support for TDs
>>>     independently of kvm_cpu_caps[].  If TDX feature enabling turns out to
>>>     be consistently blocked by non-TDX VM enabling, a solution can be worked
>>>     out then.
>>>
>>> - New opt-in interface vs. backporting.
>>>     There are two options for old KVM versions that don't do the filtering
>>>     and validation:
>>>     1) Add a new opt-in interface to expose features newly introduced by the
>>>        TDX module.
>>>     2) Backport this series to LTS/stable branches.
>>>
>>>     The opt-in design vs. backport decision is deferred, since this series
>>>     is correct and an improvement either way.
>>>
>>> - Potential backward compatibility issue when an effective fixed-1 bit
>>>     becomes directly configurable due to x86 feature deprecation.
>>>     This is left for the future, i.e. it can be addressed if and when such a
>>>     deprecation actually happens, e.g. by adding an opt-in interface to let
>>>     users/admins choose between migration flexibility and backwards
>>>     compatibility on old platforms.
>>>
>>> Changes since v4 [1]:
>>> - Split the CPUID entry index check out into a standalone fix, which
>>>     allows it to be backported to stable independently of the rest of the
>>>     series.
>>> - Exclude XTPR from the allowlist, as neither TDX nor KVM actually
>>>     virtualizes the feature and guests don't need it. (Xiaoyao, Rick)
>>> - Rename TDX_CFG_EXTRA_F() to TDX_CFG_INDEPENDENT_F(). (Xiaoyao)
>>> - Fix AMX_COMPLEX to be added for CPUID_7_1_EDX instead of CPUID_1E_1_EAX.
>>> - Drop the descriptions in the TDX documentation and the uapi header, as
>>>     the ioctl interfaces for KVM_TDX_CAPABILITIES and KVM_TDX_INIT_VM are
>>>     unchanged by this patch series.
>>> - Improve changelogs and comments. (Xiaoyao, Rick)
>>>
>>> The series follows the CSV version of the CPUID virtualization document
>>> from "Intel TDX Module ABI Definitions" [4], updated in June 2026.
>>>
>>> AI tools were used to:
>>> - Polish the cover letter and commit messages.
>>> - Do code review.
>>>
>>> [1] v4: https://lore.kernel.org/all/20260917072548.2314491-1-binbin.wu@linux.intel.com
>>>       v3: https://lore.kernel.org/all/20260827031837.2863609-1-binbin.wu@linux.intel.com
>>>       v2: https://lore.kernel.org/all/20260604023314.3907511-1-binbin.wu@linux.intel.com
>>>       v1: https://lore.kernel.org/all/20260417073610.3246316-1-binbin.wu@linux.intel.com
>>> [2] https://lore.kernel.org/all/20260911213659.2025974-1-sohil.mehta@intel.com
>>> [3] https://lore.kernel.org/all/e7182b3c03a0e39cb60392b4d75111255418d6cf.camel@intel.com
>>> [4] https://cdrdv2.intel.com/v1/dl/getContent/795381
>>>
>>> Binbin Wu (5):
>>>     KVM: TDX: Check unsupported CPUID bits against the TDX module's
>>>       subleaf
>>>     KVM: TDX: Track configurable CPUID bits allowed by KVM
>>>     KVM: TDX: Add CORE_CAPABILITIES to the allowlist
>>>     KVM: TDX: Report only KVM-allowed CPUIDs in KVM_TDX_CAPABILITIES
>>>     KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
>>>
>>>    arch/x86/kvm/vmx/tdx.c | 258 ++++++++++++++++++++++++++++++++++++-----
>>>    1 file changed, 231 insertions(+), 27 deletions(-)
>>>
>>>
>>> base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
>>
>>
>> For the series:
>>
>> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> Hi Nikolay,
> 
> Thanks for your reviews!
> 
> I noticed you later gave separate RBs for patches 2 and 3. Is that because
> patches 4-5 conflict with Sean's series [1] during rebase?

Yep, overall the whole series LGTM in isolation but given that it 
intersects with Sean's series I decided to give explicit RB to the 
patches that won't change.

> 
> For now, I'll carry your RB only on patches 2 and 3 in the next version.
> 
> [1] https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com/
> 

