Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792882835;
	b=n7ZzW3VJWYgtnTJcSRcWHamaNWq3DB0h0qhCr6E6WtaTmlYHYgnGiCYXFhfX4fpdfpcr
	 ziCWIfsK7FXm3L7/8cu0PEF7GaHUkDAxMtWKtM74+qeJ2rDI6tsEFeDdbwHKk8V2k8sIY
	 ytcBrOrHthAI7A7qr/CggqU9w+c3loM+FlczJbhzAXyMKYkG5iHBr89I58rhEuQbMRl0P
	 Ds/afHSA03jrpz4hyWj74EYdYWI4ECt/nhGNnqrDjyj63KAYMTmrM7dKgf0eD9tUpuh1F
	 8HgwJCTeyaEh6oEFcWNAOfIBH0RNm4Q67Vc9gwmi965KqswD3pBBZ9HDEMeBETbbb1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882835;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MIBaBlgFfKNp4SB/CQNEvITaAygX5mK6xOYuzCcBJ2U=;
	b=XmOi8ls3WO06eROnnDf96RbEX1h+pfPORTvvsUUapxB+CbC6K9WJD6h5jHIS1SFI++rp
	 E7Dm1Le6lPSdJkNLX7rNuZ4NYi2MswxA5Of6vnLG4AXECq6ixV3lmxM07/DruWZ7IOPar
	 I5eQghnif+enh+iQE7eKRk90Chik19a+4Oor1cqMHEqqrLBzQRwCOahbeJvzj1xwMciyw
	 DqVodfjRhKaspn1G9aDULL4JDFC4IcwTzn82GanYG9lKZJLirqMBTITc7W996NhL0CyFV
	 pZQSAYo96FZNi59sw20KjDAyAc5CqCNLoCS7jrN1kml+r0s2X+rcQPo7H4tVsFPv7Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zytor.com;
	spf=pass smtp.mailfrom=zytor.com;
	dkim=pass header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=0CBtduUA;
	arc=none smtp.remote-ip=198.137.202.136
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8E606A31B;
	Sat, 24 Oct 2026 23:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FB8E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=0CBtduUA
Received: from [IPV6:2601:646:8001:6901:13a7:2ebc:3952:fbbd] ([IPv6:2601:646:8001:6901:13a7:2ebc:3952:fbbd])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69OMxhmV2132992
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 24 Oct 2026 15:59:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69OMxhmV2132992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792882785;
	bh=MIBaBlgFfKNp4SB/CQNEvITaAygX5mK6xOYuzCcBJ2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0CBtduUAoLw1x5TA22tszcwJQFG+8XVc0R4VuieSyeZD062+rFAtm96hSIDORFy6R
	 wUDecMMQPuDndXw/oMco55pKM52Levm7ukf/T6kiZADrs+qtL/OX1Wi4B7IFjQ9YUS
	 n6132lPn76xoW8mPHJW0H/gqlQz43uzNr4VKt98Jzvs9xA6N7UzvGsdOiFQuEkvS2n
	 g0Q6MTJez4li9x4/PMU4XCn3U0gbdUboV0XOtYhrbFguLGvsTA9wsUkfQnNWeNZRI2
	 jfow8BuNVl06TW5yAaf821zEbU9PrkD9HWJn4YReZk56nrN8/090CJllfTAw1wwXRZ
	 a/Ylk9ohAl//Q==
Message-ID: <9467c7b6-d797-4462-bee1-1406bb8469cd@zytor.com>
Date: Sat, 24 Oct 2026 15:59:37 -0700
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
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
To: Xin Li <xin@zytor.com>, Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski
 <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Shivansh Dhiman <shivansh.dhiman@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
        Binbin Wu <binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
        Yosry Ahmed <yosry@kernel.org>, David Matlack <dmatlack@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <E7D55C5F-91DF-45AC-BCC8-BD2759CEE0C4@zytor.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <E7D55C5F-91DF-45AC-BCC8-BD2759CEE0C4@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026-09-14 23:03, Xin Li wrote:
> 
>> On Sep 11, 2026, at 2:36 PM, Sohil Mehta <sohil.mehta@intel.com> wrote:
>>
>> I mainly rebased the patches to the latest kvm-x86/next branch and fixed
>> a handful of issues reported during internal testing and basic AI
>> reviews. I've avoided making any major code changes or commit message
>> updates as this is the first iteration that I am posting. 
> 
> Thanks a lot for taking care of the patch series.
> 
>>
>> Going forward, based on the feedback, I'll rework the patches as needed.
>> I've listed a few opens below that need additional discussion or
>> clarification. I'm relatively new to the KVM subsystem, so please feel
>> free to provide suggestions on the series structure, code organization
>> as well as commit log clarity to smoothen the review process.
> 
> I’ve been thinking about an optimization: because FRED drops most of the old    
> syscall MSRs (IA32_LSTAR/IA32_CSTAR/IA32_SFMASK), we should be able to omit     
> them from KVM's uret MSR tracking entirely as if host enables FRED (no matter   
> whether a guest uses FRED).
> 
Yes, although they will need to be handled properly between VCPU switches, of
course.

	-hpa

