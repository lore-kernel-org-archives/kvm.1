Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166562;
	b=WD+S2x3IkqLSvcP7Wy7Kg5gn7mzNLnAwWhs33TiWUMfcZrWD7iyVRizsmsPk2MUZV1gL
	 Fz/1KGZtVnN8MnSpX6PTLYIzyQd+la1pzYE/PKsRgZ8sP/iJhAvQrIeaaQpyrk0MFdYgT
	 X+dIFqqFQ8BXsMfrD4X9sM+dp82N2I4evn9rqBzljKSDrYWjjfDWazkNu2aW5ybQiHudW
	 5wD1QUdDcbCkUlwCLbADGvauFv4xTy4PXIEO0a/JSalfZVWp4GZIIlioEqltuRnV0ZYBX
	 Jagyz/B/JxJk0yqdPrIfkK2aeZXYn38YWegLEA0+8aFGQbwGJdoZO+6fXr279iSdjRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166562;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VivwctnKNESR72tT6DdQwvTU8RMUDdx3h6Qlhmvi9bk=;
	b=tlWdp1CmnrtTpFRopE4i7cUoMkbdpvCQ3oBSV8oXyZqm+BgPUs5+UZ9sV0Y/qTKVP8u4
	 4rQrqjtFQN70PROE3Z47XfoqejZmx3zwEWbQOBbjJu/iVBZPk92WJ7AOwHUGwynXKmoqc
	 ZNVq1kNDWSisqcMJAB30dRZAWs++2U+6BQZaODptchhmkA6/iNo9LjJjjQ/mmVr2oPv9w
	 ghSaKY5WfigOLfzURZQYte9vQ3juvG9VpmIOW4phHwGzv7FZ5z/fzIiZLqvLkr8sZNRdr
	 cM/PNkT+e0aeOjZqHY1CF8gW3ob8Qnrh8LT8Ej1iiZUJPQTLKm2va9wp2KQ5Pr134yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zytor.com;
	spf=pass smtp.mailfrom=zytor.com;
	dkim=pass header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=ytsnIIMQ;
	arc=none smtp.remote-ip=198.137.202.136
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C8606A31A;
	Wed, 28 Oct 2026 05:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D31C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=ytsnIIMQ
Received: from [IPV6:2601:646:8001:6901:be1f:9b36:d14e:b747] ([IPv6:2601:646:8001:6901:be1f:9b36:d14e:b747])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69S5m7Ag1855457
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 27 Oct 2026 22:48:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69S5m7Ag1855457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1793166491;
	bh=VivwctnKNESR72tT6DdQwvTU8RMUDdx3h6Qlhmvi9bk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ytsnIIMQ5ORp/7nzaypwJ3rotqZr5IDSfXIW+gRUERdPWmUTXiLOFmvuX64w3ffuW
	 3zNNjso8xdtIQgy2agFoG53uDXA4+ENNbOexRLND2wZHgYhLtpJ7HL0pjuHpD+WBFv
	 k0SkO0cNU+Gcz90ui2VvDsTRn6sXyrp8SHzWBcJpU7+/n7iYbeyb4G5eNt1BcanbBx
	 T+smjtwgTevVeTPs+WkStRp2+/rFbkJHRBIeeT18ZGVE+2r0W9lI0TbHBCXQd3z0R7
	 Do521+IlRbgDULAkJCG99BsMyTGmVfCKXaVBTIAUutMo358Ba8sfds61GIR80lcvqV
	 PHgu8Q0RE2ZDw==
Message-ID: <1008b293-baae-4420-ad83-7902b9c83d6c@zytor.com>
Date: Tue, 27 Oct 2026 22:48:01 -0700
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
To: Shivansh Dhiman <shivansh.dhiman@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sohil Mehta <sohil.mehta@intel.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, Xin Li <xin@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>, Chao Gao <chao.gao@intel.com>,
        Binbin Wu <binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
        Yosry Ahmed <yosry@kernel.org>, David Matlack <dmatlack@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <43fb3d8a-0736-44ae-bd7f-01e701d4b7d9@amd.com>
 <55e7eef19801facfd4ac1cb147ab34f0aed0c331.camel@infradead.org>
 <3901b012-3c13-4ff4-8b6b-007905c380fe@amd.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <3901b012-3c13-4ff4-8b6b-007905c380fe@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-09-25 05:06, Shivansh Dhiman wrote:
>>>
>>> Thanks for the series Sohil. I've been able to run SVM side of vFRED with
>>> changes rebased on top of this series. So, no incompatibilities in common
>>> plumbing as of now. Will let you know if anything comes up.
>>
>> Can I remove the "Some AMD CPUs (Venice) incorrectly..." part of the
>> commit message of
>> https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=fred
> 
> Yes, you may go ahead and drop that sentence. AMD Zen 6 (Venice) supports
> event type 5 for INT1, and the FRED Virtualization spec [1] has been
> updated to reflect this.
> 
That's wonderful!

	-hpa

