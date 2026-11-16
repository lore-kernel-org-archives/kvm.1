Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823097;
	b=VJX8cgRVYLXKmMLj8LthgsXSVSmmdM9pJj/Agifm8mm9LCR5HLCMNKd2Boufm6aqL0Nj
	 pbF3QgsBjk57gZS64QzAbXim5W4JIgwdFBopavMeWspoKtIG/CPOt5qPacfktcWs09ICO
	 nbAi1bCqcpxfHYHQqB5p44m3s8WuYauf1fJdJysfj65fpl3Z/i4mUgdNvpr74Y/dLe65Q
	 /NSgy25Ol1a7xnDh/i+pyUso4qQmCvWYc9veE7LMKvsK7HDMJYq1z1MSeBB+NTyT+V5uc
	 VaciaDeSZw6Gl4oTj5S8mpn9LPNKRNIUj2ygxNC/95dGU66CRuEUuzDYYIyeu38Jhww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823097;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Q0MVmf4IpYCilnXIvfcMMwMLhYICnhyuqiHiEkoOO1o=;
	b=XGylIsFDWS2EpBH7A7c/BFNCUuijNL3KQ4XyF8Ps8AGzPq1BnMT9MtHOlsItW4+SDTh+
	 0ukZApFliK03zDQr03GV9QARS51pc/lFmpzqh/xk4IVpLd1RHhhq9+Az8RDdt5nn3KrRM
	 p8vRbWU5pxiEYjoLe4bgCrSAYui9Fcdr54a8IA7dM91znHQFgi2zEtPpWegZf+cQ1XcRI
	 eav4A7x9tTKZ4Ff+LHp2JguM9UlFDX+GMsQfrs1NG9SPPpC7kD4PhBC1fMDMKBUfPS5Ox
	 16NAjkPlQR2EOpAB1x+c2jL0Q8iXqwuH2tO3JbUNRb2jkwngrO9Bn9JSklszFuIA0IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YqOTzBVX;
	arc=none smtp.remote-ip=95.215.58.54
Received: from mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F5606A331
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 09:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 585F5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YqOTzBVX
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mvr8JUoj4s8hurTRT0oqyf6HkIMals3cteGiU9PnGfg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794823094; v=1; x=1795427894;
 b=YqOTzBVX2lhLigK8b//5mVRKkZ2c3Xyu9RuTODu854LGnt5Y9R2LTkxIObax6IOsY1cfAtBt
 9MGUR96JgS600nkQDbVk+FZEwzTsyfsRjbbxgii/CexTqNZUd3BzbFHeNc7bqUdzwaYCJvRSJ6N
 4TSzqnnx8DrfaJ+IjrwqBmT0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 588e2ca7296569e9;
	Mon, 16 Nov 2026 09:58:14 +0000
X-Mizu-Trace-ID: 588e2ca7296569e9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so8001e87.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 01:58:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFA7zaMSkuu1+jVI4MzuUupWZ6uTY4c8/34zicWtSZHlB1k2eQK5kmKG6NbLG87jjG+pDI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+STI9ILYQ6XDBKZrJ20AyAkLyQk25CFCV2K2WwAjFFLSIJ5oT0
	PwL/sb1mnPTi+zHTwp39nwZelUy9bgFgmvw79JF6rNh6pIK4vXGEticKGKgmFHnn7KA2sWAq2Bp
	WI/oxW/16KJMIC6QX3lsMLNgernLgyORQ8oFo6cg3
X-Received: by 2002:ac2:4e05:0:b0:5bf:a911:7ee3 with SMTP id
 2adb3069b0e04-5c17d90d3b4mr171778e87.3.1794823093196; Mon, 16 Nov 2026
 01:58:13 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111085448.1130701-1-fuad.tabba@linux.dev>
 <20261111085448.1130701-8-fuad.tabba@linux.dev> <b5927ae8-edef-4042-bf64-da873eff0117@infradead.org>
In-Reply-To: <b5927ae8-edef-4042-bf64-da873eff0117@infradead.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 16 Nov 2026 09:57:36 +0000
X-Gmail-Original-Message-ID: <CA+EHjTx=SMYSs6Qwmd0BrhbeftsBFs_hzg0T6qE2ZTSYbxW1cw@mail.gmail.com>
X-Gm-Features: AclHuK_nHTjmC_GW6HrL1qkYjVqq18uEdOE3VTq_9PAn58E74FUTCJeR_dnGLlo
Message-ID: <CA+EHjTx=SMYSs6Qwmd0BrhbeftsBFs_hzg0T6qE2ZTSYbxW1cw@mail.gmail.com>
Subject: Re: [PATCH 7/7] KVM: Fix typos in comments
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 17:05, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/11/26 12:54 AM, Fuad Tabba wrote:
> > @@ -2526,7 +2526,7 @@ static inline int kvm_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
> >
> >  /*
> >   * If more than one page is being (un)accounted, @virt must be the address of
> > - * the first page of a block of pages what were allocated together (i.e
> > + * the first page of a block of pages that were allocated together (i.e
>
>                                                                        i.e.
> >   * accounted together).

Will fix that in v2.

>
> Anyway, these changes look good.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.

Thanks for the reviews and acks.

Cheers,
/fuad
