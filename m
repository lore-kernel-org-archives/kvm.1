Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2F30CD85
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260083; cv=pass; b=bMA3X7h3aF3iHJKX8W2LZShRVB1q/Is17RYEku3ySwODM2JxSc8I3ZsKtGb6rriw4Em1DFYZzm3ko46K/HdCEgo6/GS6caNcug6tOu4dWSQelMRyVCPqjd+cNjh8SRhQ8S/SteRf1ahwHN47Q6yyRBMvl55dY58hXyVj29wtXVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260083; c=relaxed/simple;
	bh=kcSIA8QoE0LN3l35tQtfo0jow3WHaPbc3lLYMPju8ik=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mR5QlFFdFG2BOtWupX4l64ah+sBY579Zsrcdym2ge/hC++gQz0L50hMrx53e4gmlfIpMoqAcHacEOEVodnwAzza8iKu/p2meM3YG3pnhALXNCxWxVgTWzIdTsEPNLWBQ21MGwcbOKG1gTQwvJjmKwbkWkFHLeMGjM0BrDIZX6bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLQGNMZN; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLQGNMZN"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13986d61b4eso901037c88.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782260080; cv=none;
        d=google.com; s=arc-20240605;
        b=T7nJDVCZ3y+uPq4JU0oE/Rvn1A1Zp3QhM5FpkNqXMOFE/ch9R9tvDVSIcFCIj5zR7f
         vZOBeQdmEYniCRSy8aMuCthkGjmj7VASB2NkKjeHqssPXeMI+wIHLKvtkorkVvuh48h0
         /1ArvNdM+DJ4CDYDhPUGnOOAawKyxqq7o+8DMu/AecpmC7TYccdE4tZSR1x4tIrwDnCj
         yvcytqCaQBa8RX9pIgOLJgTimQlaETtTSY4ViU3In5cA7BEX1S++MpJhUQHgbo9LUYpl
         GHlzNhhpXB4GB4NhRPhUfkWrWwNlxoFVafP6TRWK7TgszvtIYGPjzbmpqFoTOpFmAmmB
         Ykpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5cZCA67GzL1hK3vWmOV/udgJCrdJrxhZ2WqGtT4YW1w=;
        fh=TQ8llJFzgo7Rm82XjEsE8uSU+yomLrzhyQgnecuND8Q=;
        b=azJQSryQfoysvIysZriOpGwskVg5Ki6BwevAgXkQrB5tXVP6EgIuGMWq9qwtoWGvxG
         lS8rUq6Is2jUkzaYO7M/2VU1hjzq0x6Mecrmd9jjZn3/nMNBkkiR5opp5zFYrHTz2Puc
         pKTW5H0J45H0s3y1gzyBC9qazLddEvAfsAg5vOii9A1KhlE6hVF1kwetDJxeSieDrgXo
         hxuR3UA/Bk+CboVW2A8avzV1rBdoykyNZFciQutRCnbYU8QdOvoa/oC0dxEEH9pDzSvE
         8Yxsk33FLZvwPcaP0oXDt9YfGUtURkGwZ8djDPmx7b4lW3IMVPfzJ/wHu/oppK2w19Jd
         yV0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782260080; x=1782864880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5cZCA67GzL1hK3vWmOV/udgJCrdJrxhZ2WqGtT4YW1w=;
        b=LLQGNMZNBVde46DeOm10QrXFme7gPCLlmzfdjn1u29omu4Ul8I2WMRqAGvKGTWmeug
         p5SzL/dv2Jbb7ZxUU94M9T4VuzT5pDrNWMNqJJJQqzwPd9Evc/PLxdGdpyzdE8Zkwalc
         YSJ/2mV3x9o8WUDzo6vvCjoX6OgPDmoiVdpZ5ltMW2w+SsdnDRolaRUgug5/gZhWLI8n
         26qEZawRYF308lK36dmIOVAm0+eXufYvwMrmcumR62LukVdGOw4+U3dhIfl2YXAYS+MQ
         ZrW5i607QqoyZ1k4daJMagtAkfWdMAPjtxsMWAb2BbuI99lzK7cZviFIBLoI8+LZhjrO
         K8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782260080; x=1782864880;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cZCA67GzL1hK3vWmOV/udgJCrdJrxhZ2WqGtT4YW1w=;
        b=aUU99dOEJF5B0YNkHDdBT4ssRZrXYapw/YWolb4qonL5YmEB+GF8+IXmQh0Ap8UlME
         HEBRvuXAJDoSXtsfIA2xlNOfi0rJoQ9UnzBxsR0gPknIdA/EruujpoPbud2h95bFS9to
         ztlreGTZpfcXK8ByqTL+8o714Az0KJWhOaSlN55+AZYtzkSigzusHI2qY5aXGi7aK4V+
         a8wAg8f3dHokL1xTTGaNJM59gcd8WtyxFWyRHbK4Ks2kMqz/emTx/DvsOVEqHBPNNNJE
         2ClgD2uwwICwYUMJ4xOGe6h78HnAtON7uUbkJDrLp5feg6wvz035UyClJn7sM+US8nW9
         7o3g==
X-Forwarded-Encrypted: i=1; AFNElJ/3+s1NthYrKPKWBue2FwV2SYckCsS6Bq+YK+e5TMtVBzWqMFhTYtHWnLk/jjp6/wSalS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PHCxbsjTDTqAzUGFeQ1lK8NUaqrTOUKhdQJyLCVgj1zuK+kL
	s9OXE5U4N+fGzVrKMKUJJjNfxAYgawkB0sWyYmWrZ2KpGVpCOp+/shMHWT5LKMf/T/xErWdumU5
	ECGbaTSGQYjKLtxkfok3hifyGSV23koNGOXPJBcJz
X-Gm-Gg: AfdE7cmEuvkbrqaUHeC/NsNuuC61Jircgal9pvhk26gw4/qmd1KeR7fsCBL+W8NiP5r
	XE4rC5DwN4JgtyKyix/kL6tFlozRzu9IYPZc1csk3B+JKlwdZnV0wbAPQucwYPKdDbNKYz4sloK
	xTVHkfRW4ZpunVrWmHFwl8L/RN3Ssh8f0sSpyQGoy/k+4mo4MlhR7VSChicivUR7q1Sc6R7l7by
	V9C8GvS1F64X89c0p/1kjaYWRReFsz40QozAAjJRuLyoI40r2RoEXrfwRF429XyABXsOiPkksyI
	fBSooFaaBSzkeypGqJK6lq6W7+eDaCjItte6tQN16MYzD2mQd9BSC8JZe1I=
X-Received: by 2002:a05:7022:7a4:b0:136:5e4c:7aba with SMTP id
 a92af1059eb24-139ad6ac8ccmr13781633c88.16.1782260078995; Tue, 23 Jun 2026
 17:14:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:14:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:14:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajnQVkLvFl_lMuGB@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
 <8e53844c-f2f8-4a4b-bf72-f3140c170d43@gmail.com> <ajnQVkLvFl_lMuGB@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 17:14:38 -0700
X-Gm-Features: AVVi8CcXn2j2iTyhoMEqe261E6HKS7rSa97Iz0Ayq-UgAfPllC9cKLpff9jWWSE
Message-ID: <CAEvNRgGhWL-tWfu8EHf-zsU4C127xKT2wyV7wMBnLKs8g=pEmg@mail.gmail.com>
Subject: Re: [PATCH v8 05/46] KVM: Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable
To: Sean Christopherson <seanjc@google.com>, Julian Braha <julianbraha@gmail.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jun 19, 2026, Julian Braha wrote:
>> Hi Ackerley,
>>
>> On 6/19/26 01:31, Ackerley Tng via B4 Relay wrote:
>>
>> >  config KVM_VM_MEMORY_ATTRIBUTES
>> > -	bool
>> > +	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
>> > +	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
>>
>> Sorry for the style nitpick, but could you keep the type and prompt as
>> the first attribute in the Kconfig option definition (like the other
>> options do)?
>
> No need to be sorry, I've no idea why I put the "depends" first.  I don't even
> know if that qualifies as a nit :-)
>
> Ackerley, if you can provide your SoB (for Fuad's feedback), I can fixup when
> applying (assuming nothing else necessitates v9).

Thanks, didn't notice this when consolidating this revision.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
