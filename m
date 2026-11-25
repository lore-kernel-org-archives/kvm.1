Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605164;
	b=QL9DcJpLtx2i+U7rZOJoOE/gxwdP13F3xbK3fVMri/TjLbu65uW+8xKyjy6CRjl+p9lq
	 xVHDufJKws8GgwBMgHgBbUM72YYmufOOB8RbfML/OIJmtY7nil//FLXNOsJgq1tbM3/jy
	 8+gPZBdgtHSExefNVc2X20rWkjOtoO1G1v2AYVe2Gk5hIjX2uBewAGoHW/6/lzxsUovk7
	 OPFOX8NIlck32rpc998wMerfABkmYYRJ8mKUeYj/GxAvXD/rAC/h/n2BakgxGX/YH6bzs
	 B3JDNvxMcL00OR+6fxtg+2FBpQNuR4dwCsLRXhxZWMGp0OAwFMINSJCUGKR8JRXGt4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pEX7sSGGqH9r9dbED+AryYL0YCArWKQ+VCNohAWeAkk=;
	b=WGCe9BqIbK/XabvQJddf1/r8TlLFKQB/SYw6+QlvLZBgAZqrmVO9/3Avu5cv3kuivXKu
	 OOEGjmhlTsb7aCxDU52hctTbeIDWLvWFFjCnOokrrOGsFTMFoRJ/eJ9gvCAHOUaa8uU2I
	 5UNKo0zGuV64PyP6SoFDiujUYxEMCGm1ZmzQS0XY33tyZS9CwUmUdr0GtI1+VqWlJPkI4
	 Sr1SNlO4weerS/ovIvNF9vbQLvmYuNVkoSyIuqd3o0N5NHU5+JYL7b2MyDCFDbXkmY0jl
	 /oJey4yp/I5AEQeIYASqOCvq+H09n+Me4WvxsErM71MsV6uUKtqxSkI4DCiE68trgBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y75xttMi;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D0606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC3D0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y75xttMi
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c51a02ad3acso67667266b.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 03:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605162; x=1796209962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pEX7sSGGqH9r9dbED+AryYL0YCArWKQ+VCNohAWeAkk=;
        b=Y75xttMilgwAEkqPfXAaixykmDKt+Oz1NZW46raWBkm3GGShv8XX1Qmoi6r5QDpCFU
         e7j3L0ZvDGBvthLFtrxOj+7FrC+rZEB3nawP/XiY0/Oni0QmF9V9m3TFkquhYXaj73fB
         GCX2l+JFXJ1Ewj5UttMwHNMs4QNNpdtflT3MxEFumG5MQhsCAsod8ckOitAlIGNDrgjF
         V7fzUQBQILoAuVhKzOU0+qk5elua2+kPt8oFA9/MfPw4iomjQ7xyJEw+4R3NC4LVeIuF
         SrqHT/Wn7c/ONmAzECwObKHtTkzJH8Ve1bEa66D5t6g18v4VyuonPoZA4Yqv2W3E87fy
         p5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605162; x=1796209962;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pEX7sSGGqH9r9dbED+AryYL0YCArWKQ+VCNohAWeAkk=;
        b=datstLvb0X1JaEkVyDCywGPRQxylCegn4YWppka7Ws8EvyncczewsA/KVJcQXHBZ+a
         jwVQU4bblGTXpKwRDoAM0KOjzSih33KWtsdXubIxs6plZ5EkTzfBeurKtLDbhjMM/w6N
         RNhuOW4wk7ODQIlrWo4Vnuj/f/cslrz5yXrIyfHL8qw/a6tGOOrMSzqXYDMZflf0uJT6
         oxrGnWbA2nzZP7OXHGVBt1LJGfJMn0omjL/ZZZV6bPw1VPrMhE7dBbpl++0Dk3V/C4rt
         u6KUGrCVKGxRosl6KuSxXBCLtNiVFrHbu+/6d7ye9hKYMIA3aZ1F+OLq7KYGtxd+E2Bh
         81qQ==
X-Forwarded-Encrypted: i=1; AL+hErEdwm3JA9T8tNAKLxVCAYANx+nJBZth6DxUcYmVZlvaEqVqcYMBwNYCAbBtpGtYVak39y0=@vger.kernel.org
X-Gm-Message-State: APuU4Z824e0Vimr6VzrBHse/05uLzp16y68aSITKmxmgplG4fw4RfA/I
	mfTEM8qVVA98Zt7haDBoP1spvreqyEAU6dMBNVsCua43RPnk7h5hC/IO
X-Gm-Gg: AZFdTZdejz10HqLPnzjVqNggL2k3SZwEpeZYM6Trjy/wFmwe/rjABUgQwPDvJ0cvbEl
	v4ZxuwBv6P79yzqzeycbRPscQvJ+dK+MPibcqHV2pOZ9fbYJRSmH/oF+EHe4XPCrLJfYtNSe00n
	DGjCrrvlE7eXkHjn0PKZbplYop490TGnIZ6/j8NAC1U659PBYyq62uszhCUoraLU3Ng78UF9eAx
	IrhFG5lsBhXYfoGmLJnfKwwcLflPDplb9MqVvpakKH8LO1JuEuimp1HlnwedKkr8pxFaWlXiEgL
	IdELMf2Jz8TcW6RG5+oA54ROv7sw43QaanBdtyJj0LfQxqsPfilGbY5i2g618ofZHsWuyv7v/6q
	A/TG7CDCbkJ4X3z+f5y6k2HvbSpz0OLt67kom5Xm9f4cQBAnHwHGWE5GHLT0PIRqpb+V6RaGT1N
	pmzkmW32AYkdfsbTMT29hFgZMU317I7LZsaPCF6nzhVVKgv/6JsJYfg2W6xqXLf1tqnuAm2MDZh
	0MQRGbgJA0kviVPzYUI878zFnyXA2ZCpVa40TIuj4yBpcXZmzRRKBR4MLlb1/lCjU9hlZZuIpYR
	hbkn4Qkm5lg68y5OWktrR1MTGppRoiorv1M=
X-Received: by 2002:a17:906:3388:b0:c3e:e726:9548 with SMTP id a640c23a62f3a-c513a5ec801mr1091772566b.14.1795605161989;
        Wed, 25 Nov 2026 03:12:41 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6841asm632892366b.24.2026.11.25.03.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:12:41 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ce509f0c-8c79-43e1-81b3-b1a864db5abd@xen.org>
Date: Wed, 25 Nov 2026 11:12:40 +0000
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
Subject: Re: [PATCH v1 07/21] hw/i386/kvm/xen_evtchn: Validate PIRQ numbers in
 physdev operations
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-8-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> xen_physdev_eoi_pirq() and xen_physdev_query_pirq() used the given PIRQ
> number to index the PIRQ tables without checking it against nr_pirqs.
> Reject out-of-range values, and reject PIRQ 0 in bind_pirq and
> map_pirq. PIRQs 0-15 are reserved for the initial domain's identity
> claims of the legacy ISA IRQs — the allocators, Xen's and ours alike,
> never hand them out — and an HVM guest has no such claim. QEMU's
> gsi_pirq[] and MSI target lookups both treat 0 as "no PIRQ", so a
> guest-mapped pirq 0 could never deliver anything; better to refuse it
> than to create a silently dead mapping.
> 
> Fixes: CVE-2026-123070
> Fixes: 799c23548f0d ("i386/xen: Implement HYPERVISOR_physdev_op")
> Reported-by: bubblehuntr <https://gitlab.com/bubblehuntr>
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3639
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/i386/kvm/xen_evtchn.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>
