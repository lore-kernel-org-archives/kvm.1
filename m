Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7DE284693
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873513; cv=none; b=YrSGJtQY5rPUo0IWjekc0X5JA1VKDtiJQXFpOUuIBDwY7NSnWX7URyA2gmvrlj2jL23WUpKtM0L9JjxaYrTVZiCjDQin0H1S6h3Lh9Jf+frx3xmxKSAriA2kdUwM+kurkHkwF2cH6qDvKvXl/NSzcwN0GUHBg9zT9ufQe/58hZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873513; c=relaxed/simple;
	bh=AoSchuXJGAayDzDPFIuHozNVcqm/iWheUa1nSVya5uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+Lh1OJ1w3d2uJRZgbeT64Us0FzEzs/IBGIQGCfIyCqNZY1RG6YfDQr9NgGwZZU1G3mm7N5Pa3R+aDH880DNJWoqPSDy5D9OtS7cNhmIP9v2rJGb0Aom75cORYVBEMLcsuCkDvsjnTUCq77ZiRI3IsyHe9G/Opd76Z7VFSDfIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6G6hYoQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6G6hYoQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso21061065e9.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781873510; x=1782478310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=laROZbWnzE0hCDsDDd6yA+mJoystSAqNpvIVq0sPclE=;
        b=M6G6hYoQGyEFSHNFdRWBdU4G7ykRDxlAROTSMAlGePNeLH6fwR2d2KwGFBeEjya4rC
         BRr787JIbVdi566ccw22qNGtfsdczdqKskU/r6th6LF/XO1W4RTPjDvJOEFwDwcX8tWN
         RBnFtBY6AuYGPkhzKAQrGFCtaLpIxcRVixGOH4fegOPJ5UowVOqCf5cAIeNCNJZ8hDup
         qz5s3dFSMMomrLxtqxUvwyl/SBfZTK1ylwbeLWnXudrPTqQQbXpRViclUOlHlmy9AP4w
         NFz5R1imyhysVzPS3PZmBxVKnDZWwqB8qgCxNP4yX1s8Xs6rgA9q4gryRQbXbqd88BBI
         Mk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781873510; x=1782478310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laROZbWnzE0hCDsDDd6yA+mJoystSAqNpvIVq0sPclE=;
        b=WQgE6fjTKng/fNJwJUYvWjcOY5AiPFy6cQtx96wK4GJmE3JPb85HanXr6Kd7KfsuVb
         chmg68z08blo/NyAHUq8RIjedjF9cPVWs1fdRwzOJwU6ghKRiPG73jtuYHKwo6yRU0Pk
         oPzB0fOFl6Yg/rL1S4YFLLAR/aMYMDdOdexQfNNW0k1zh0nI2OPKyv4dgcZcw162HkM7
         BzMMoePhsUfyIwsruT2fTS28yQ1nzdKZn0FDMruuNc0rtkYsSBrOH4ALes11MUJiBtum
         HchlCKr5dGvMHa+JvxJE8Ugwpn04uwG88wtkBfi4l2WCeCH12NIzPShExI1csls7+7k6
         1XsA==
X-Gm-Message-State: AOJu0YwbMkE3QnBzpRHI7lPM3Esa34ik1Y0czVBSr0p3YamHSG0PGeGl
	+sZJL8pydZ75ktOZiRnl/2hGRyVru2i3BeGWlfpSLu2ncw6+v/7GDSxV
X-Gm-Gg: AfdE7cnNcii7jDPSpxd9gHIHjBwaZgnZf8Dbrwvn3KZYM1EeQvqprypoo8JK0IYf0UL
	GVVc5cmLqL0GHUMX70iRC3PMMGCyzIXGFk0G4ZLnrABATlHdx1EVd2KyHuYt30D7VEVfvPKn4JC
	kRjyinsPFpwP8lZvLDt4gVKqUz9Og/7Cc5hNk3En+RcvUZl6ovoklMAV3sXr9q7enJlDVQYtzH/
	MMacTc2NU+TEns0V/Z4lJrhH4TOuw6JrcNsS0wVhAmDpxber6s27Ik5K1drd0ueSKCdAGEQGbt6
	vGAmPhNlL9o5pdVLYoHCWmVFoPU6lJjJkO8/mAFW0p+ZL3qo6azkX5UsQmESG5v/KIJXyax3i8u
	lzDLRdCHrG5RD41zOdRLw7fKz/58sKxZzt2FZ9GE51LkEvKHD6V+Zo4S9lDUlOcVO+FDUHSzmrC
	KTaDqDeWatSmZiSDK9V6w4kTri4y+n8yKQ9pw6SRne/llJ99uMylOT31f7zCqaorINaW+pA2jJD
	C5eNYo=
X-Received: by 2002:a05:600c:8b10:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-4923f58988dmr65892965e9.28.1781873510164;
        Fri, 19 Jun 2026 05:51:50 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650c115fd8sm7984157f8f.35.2026.06.19.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 05:51:48 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <8e53844c-f2f8-4a4b-bf72-f3140c170d43@gmail.com>
Date: Fri, 19 Jun 2026 13:51:45 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/46] KVM: Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 selectable
To: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev,
 binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com,
 david@kernel.org, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com,
 aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ackerley,

On 6/19/26 01:31, Ackerley Tng via B4 Relay wrote:

>  config KVM_VM_MEMORY_ATTRIBUTES
> -	bool
> +	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
> +	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"

Sorry for the style nitpick, but could you keep the type and prompt as
the first attribute in the Kconfig option definition (like the other
options do)?

- Julian Braha
