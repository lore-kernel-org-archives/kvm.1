Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA182D0C62
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303156; cv=none; b=jznOSVfvyLKjBdiUrMBc0+N594XxfqMM2ysA+3SHa4obCSejVCsdmuni/621W5T8At6rFcCTJpfRWK96rPhwOBMpAvdC4KcrFvhVEj3bhd5u/mFmSPqg5Nj2sg8cWRHAgtNSIX9nqN6pRMIqw+Fn5h2mm8mD4gEUoAmQDmxEPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303156; c=relaxed/simple;
	bh=AzJxR17LeggvP5p8IUNi+OFv3fxzePdsrz0neVEdzNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXASPHtzxRrIttNdTsxipd2a6bQd1Ao2yJp1C6qoPqXWzrpZBmVul9PN3gKu5iVqN0LNIACIy5ELOV6wFtspVbErh+QDbImDk8I0mEXL0BbUUiBJX6oTcJHJGaU1sQaM1BG+TQj756NzsLzHI9mcr4cOViOdq4X8oRbAkliM878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YBmQz9P7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YBmQz9P7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ac357c55so8702995e9.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782303154; x=1782907954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=myNo/DEuhpzwm5mdaD3SVg2ivdFiLyKElhtRgaxmzTc=;
        b=YBmQz9P7MESAmznHuEEsfTbHvQU3ktRHb2nh5qU4wapAvDODAG6yJnBxK7Oj+bG2qd
         ATtBtLnXC9DcgIvRsEwKQi2rxZRZgY+3j/yFlWmX+gWMtwhemagu6xukQL8cFtwqb+RX
         KCjB1tQ1pJxB5SXlWCwhHMHLer0uwdurErVe3TjeSyUTA7aIRmgLt5sy1woTw1UVlqXo
         y2l7Cu0APM4LBLWgk8oamz3VpODl6vt9zAgLGa5EfXiGU2iNvTS69Lmcy+weSqmw90yH
         B+BPM1aC6YAqgY3vcZqno5/II3RIvVCKeNwx9bTnfjun/asDcWz5jiYmcZjSIdcMRJey
         2qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303154; x=1782907954;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myNo/DEuhpzwm5mdaD3SVg2ivdFiLyKElhtRgaxmzTc=;
        b=jIDg2XK2SCccFXWKC+zMswPA9ie0xflB44DPZU7xQkdWZtIjbfozQv2D1t/QaQ1TAc
         zIdr35C5myvlW1ugu55fb8Ut0BXRN1H++fByaGDSI2M0EBje5TkMKEHKtA7PtFtpFKhB
         5+IdpFZMd/niMAkK1batjdqSgPlDaSkqB+AD2IVyYU3GnhNceJvv69gZk5kLoMmT5ouW
         uE1LaVPyWkK9qqAKuntWcdHj42M0xCfV/sOvHXNMaE7wL/oCJqLiZ3FBDu1bKbLuZSO0
         1A5gORxI8uUplNEePiBO705xU1wZPBuDUswqV9HXc5uLByezsYm9gNnKDMU63GyMKF+L
         Uq1w==
X-Forwarded-Encrypted: i=1; AFNElJ+HB1knf6bxJ5oBpiwRPkByQRH0UOjPkXksAAotgbTEv5Y6IbASaTYSNel24/FrOgmzgNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLMjcLAfeOAVPxMDCXK6cOqFE9ZZ13Dq/At+SSC6yz0Hq6vah
	vWvclNq7EyVOaMpj4mAkjkZRnYz3pr70g23Q3m//UCJ1w6+GFhbhGDKSfoL7pqROzWE=
X-Gm-Gg: AfdE7ckiSHWpWHIg7OiarOUkh+YIvVuTcjDGnjsPDCrQ2MdDwauf5xMkJU6wQJdib24
	SwiMmdPpdEAn1Qs3tZb2gRiVKQ48uCEExaW/+AHAxXw6/aiilgi5tmPY1qxlTPrY0+Tq+xKRFmU
	+zGVVl31r+96DQvZHZO6SVA/XjtKep/oqtxwkdkfArcYeSolLh5CEk3F0cLnWt40s+TfcMz35uY
	iUx/T+MBfF5B90Qa1WV/H0zn1S4Q5RaW45adGbyWIjWvWC1AxCOM8ThhOBXfk3pTr8EMyhKe/1k
	HGFeML6joXLLJWRInb+XqW9YWujJLULLV/5YP0KBvIUtCwBeDkxPQxol7YmodgKYy9ZC7UYCuJ4
	pStmCVPffQ8IZoPLDGJdRo2LSmv6oIAAVsFzEy0Z0GQxBrTsFt4YCMXl077c3bM7BhxSIzb8gZR
	9sRGlO58B8pOuHy1HNlqWZLTEL3tNgDuzu0Nuy1M9voLmDoEvP
X-Received: by 2002:a05:600c:4899:b0:490:cb90:3e00 with SMTP id 5b1f17b1804b1-4926084b98emr28115875e9.14.1782303153562;
        Wed, 24 Jun 2026 05:12:33 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.67.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944fbbdsm408926155e9.12.2026.06.24.05.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 05:12:32 -0700 (PDT)
Message-ID: <171efe97-fd87-45c1-9913-ff62eacab400@suse.com>
Date: Wed, 24 Jun 2026 15:12:28 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/12] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 Jon Kohler <jon@nutanix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>,
 Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 David Laight <david.laight.linux@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260622-vmscape-bhb-v12-0-76cbda0ae3e5@linux.intel.com>
 <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260622-vmscape-bhb-v12-2-76cbda0ae3e5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23.06.26 г. 20:33 ч., Pawan Gupta wrote:
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrite
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs use the BHI_DIS_S hardware mitigation
> in the kernel.
> 
> Now with VMSCAPE (BHI variant) it is also required to isolate branch
> history between guests and userspace. Since BHI_DIS_S only protects the
> kernel, the newer CPUs also use IBPB.
> 
> A cheaper alternative to the current IBPB mitigation is clear_bhb_loop().
> But it currently does not clear enough BHB entries to be effective on newer
> CPUs with larger BHB. At boot, dynamically set the loop count of
> clear_bhb_loop() such that it is effective on newer CPUs too.
> 
> Introduce global loop counts, initializing them with appropriate value
> based on the hardware feature X86_FEATURE_BHI_CTRL.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Although AI brings up a valid argument about whether guests should be 
pessimized and fallback to the longer sequence ?
