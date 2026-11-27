Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768427;
	b=QaFKwcz/Ds/ZsSLOnc4TJWTROhU3oQN/e30/DAhyUKYDSjbX2JLrZfjdKNi1ZW+dmYBd
	 tbvYaN6X/7nwOqnvb6egcdGiRJkzFW/7UXocL0AXHCm5Q0xwZN1RUa6WI58BFnRCASaPz
	 WBf41VWLvTTV2k73ytwHOlbNKRBQECKpicNIjc6xlbZ/CrUpWE4Amp5EvldDjdue8RkFy
	 FcK497ZDFN0T6Dc6gkyc4kR75HL0Kw5Dgc9Sd1RNEnAfVjWKWtcuO0iY476qyq4oU8k/6
	 Piq08J9PGQgUbeFFe5YHntroqIoYCPDNEmEn42Q/dGnj5Lvp5NQBnBpOD4junzRft1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=j9Zg3IRwPaEItCVJjtZ7ABfU8BAnRz64CWJLFsRd0ss=;
	b=qVBCM8CAoWAMJTuGiZRhs/UjGq/DS9oLOzbMA+NN3nqCM2LLIzk1/msy8l2ajloepK1l
	 Xy+qG96TZX0SGi/UyRx6rFqhkpdN6LYfxD2abiS4zWYBEXwPku8wSBfMdCJLQtcPFre0n
	 Ld47s2E7aub9FVo++DJNyag6xQx1IkyXuu546WXVyVkXMPZt78o5yxzt8+6KmUFi2VzLQ
	 tFeRqsHaDUkmEUGMcOx0yebjajc7iA+WoiuGvCn1UZ/EyL989JwY3Ov/FWbrtLSH44oxu
	 VfziOWqi0gr1oRolis9yl+t9mXGb5XGmVq8BqoL93eEb9bid9anMrvuzZS67guBJVGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iWNKeeWc;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A6606A321
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 08:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 800A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iWNKeeWc
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so82823155e9.0
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 00:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795768426; x=1796373226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j9Zg3IRwPaEItCVJjtZ7ABfU8BAnRz64CWJLFsRd0ss=;
        b=iWNKeeWcho9VCmkyk32ICsg7YKfO2HRFtSgPfp2clJUPlpnnHZeROE9ysqAZjmzzU7
         etCSJ+3OKjkPB82nI2pwNIz+wwUdW8X9DbJ0+wmVEviwil6RSkEaVEXs6BAA5SwZG3Ip
         M2bL11cmT0GUA3lrmSOTPx/ku5m/56zP+tf1HrtfL3FfIn8WMbcwL/+ASqK6nrp1Kfpk
         l3TTRWWbrAlIPbzwqlmzLAPIvDAPxsBJ4qk+vvO7l/sJecmZuw6Df3IY8I0qFJ6QybNI
         mUGAA5MTitxvgmn5sct4cJeFPKVsFnDSi0O8hsMHSboYsfmdAxTl84MadLayxe1gf13p
         ONxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795768426; x=1796373226;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9Zg3IRwPaEItCVJjtZ7ABfU8BAnRz64CWJLFsRd0ss=;
        b=pDi2lHt/nQMc/Ub7jmruk/adIhe5ePPSvhq+E2fFuIXeHeyp5sDDB/1RIku4UXrPxf
         PPo91x3V2806LL92/5Ivz4bo036Fvu8mt4ZEZJhk9uQE0j6DXIimPq144xldg9dN0Ej6
         Cg8cAbrYE7U/oFKmnnqL5KgXddz1qvTd7t7ChOtxwm7SAMk4XnAE+4D+9mEN2gf2W1xp
         rdRPnCcRnFE4GE50CQC/uyhyRNAoldS8UYCiT/RVUp928KGXkD7PJ9u7PGKSYKJH1fxn
         nDbaJ7bLRkh0qekUPTsvI67lR02s+yb+2gC8J8CyKaaU1GxZ4nwBazc/xXT1OBTA+AYd
         p5SQ==
X-Forwarded-Encrypted: i=1; AL+hErGP57REFOf5kBbgaHqEfGYPhdUkRJpoyJNoNoBhkopbSKKoVpAqRoXGC7QkqEuiPaU6oKI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NAOOcvSVfVVTSh34xUQG/KuENehamzZvmqZ294b8og7vdppcz
	8C8VW6OKS1vh/z9/ra7itX/303x25sZjLf1SxIa3Jp71+T7eMkL1AeowIUIN3LO7CdEYXyCn
X-Gm-Gg: AZFdTZf2/x96zORDzRrD0X2Y20v4cAE+UGdJHuTBRez34X4yrCPXOMQ6TkCg2dci0Dp
	lWWzyuTwvs6trVH0BCK/QkcBedrsQO2qdvaPJj+0zFOO9KggEP5JWvcMQpKQ5AEEA/yXDeQITA8
	Kt1neyu7dyHU9E5mDSwjFhM4E+vhW8UisDI43mN7ulyH335E+as+hLE0CnXrBgw4JfxGE7RIXkd
	IvsdnbkIhOnSXXEmfygDoslLCz24Y/FR9BCPogSPnlp2DN5OudQoMVaKKMZZy5p33OChCUQexbx
	H4PShyhlamKv2REz6MsLFLd6oPD+rvTYswRxW/5rBaw3TMCdyUpS0EGhMbThqM9AgJBvKqfavYB
	OtQHdJIx2KY45K35G6DudxeVGB2HvrV11BtOZP/Flpzp4N+tntGtZ9tfMH5xmLU5zwy078ljZPq
	8HTdu3HHaHdJNhKfzoNr9KR39QTqKoRl9crf9Do/0jvWtfIqUKuEtqc4KF3gZhVQi/pWizFN/pN
	zx6o1YfT10P294giDIGdoWpE8uZaF/9dJi0e2Kb4U5aVub7zGE8bIvJmZMtyJN6P5/NFBE1Paq2
	LqZb7LHILhHLZR03oZSAshNbjJtuC9I=
X-Received: by 2002:a05:600c:37c6:b0:4bb:7033:c938 with SMTP id 5b1f17b1804b1-4bb888147b7mr473593745e9.14.1795768425627;
        Fri, 27 Nov 2026 00:33:45 -0800 (PST)
Received: from [10.245.245.79] ([134.191.227.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm922312255e9.13.2026.11.27.00.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:33:44 -0800 (PST)
Message-ID: <74c6eec32fec9b7db75a8b4cd7f8e00d581eab5f.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional
 KVM_CAP_LIVE_MIGRATION and KVM_MIGRATE_CMD
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini
	 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Jon Grimm
	 <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky	
 <thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton	
 <oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel	
 <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>, Jakub
 =?UTF-8?Q?R=C5=AF=C5=BEi=C4=8Dka?=	 <jakub.ruzicka@matfyz.cz>,
 =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,  Vishal Annapurve
 <vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>,
 Kishen Maloor	 <kishen.maloor@intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>,  Peter Fang <peter.fang@intel.com>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li	 <xiaoyao.li@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, 	kvm@vger.kernel.org
Date: Fri, 27 Nov 2026 10:33:40 +0200
In-Reply-To: <20260831071304.762939-3-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-08-31 at 10:13 +0300, Tony Lindgren wrote:
> +struct kvm_migrate_cmd {
> +	__u16 command;
> +	__u16 flags;
> +	__u32 reserved;
> +	struct kvm_transfer_buffer buf;
> +};

In addition to dropping 'struct kvm_transfer_buffer', we need=C2=A0separate
input=C2=A0and output buffers. Reasons:

 - TDX requires them to be separate: using one buffer for both does not wor=
k
   in corner cases such as update-while-setup.
 - We can't assume other CoCo implementations can use the input buffer as
   the output buffer either.
 - It is also a cleaner API.

So I'd like the next version to have two buffers, each with its own pointer
and size: one for input, one for output.

Artem
