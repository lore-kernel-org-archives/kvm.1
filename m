Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000554;
	b=vXUVQNswFXtyMQ/QwrKVmivfSsgKr8L5y7S+8HWafqhzYbY0zFuqbAEQSEoMeSTv94Li
	 C0HwIqKcRLkFJVp2ayYv0kpbL+1p5y2BlVRbdVnXbBMCnd3nSBa1WVqjZoC4JlTk628XY
	 spQ3SEFRazrMUFEBLXH5QyQDdBBUvqNb9Tu8rwAwV0Zr4LpGiqPbMt+GRRmnyjZrlWAxi
	 kJBsFUYdYNaW1VrDQ+p6bacP5GnuoBJpuaN5hwRTndzilRmJOL3K+PuvlrW+t4zkxhWHS
	 8fuBE6MIstSHLJ4hm2Hm007Mcg+dk/GAD05uKknzsiz4YrR1W6QKZbAFTwaOd6eIs1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=dxJkUC24im2bGryNLkAlqWRfHL6XOBwDY6Gegry7bnQ=;
	b=ScNCP+g3CJTndNrFlAFO40gH9H9y/7UhJ1rTSCltf4u6dl29GJGoIPkvppi2A/fibz+t
	 TiTUmQGdhX4IFl0yqj8TUyFjqCffbctoOko4f5svwn59ZjmvYlSGSMiFqh2TiITkOcnXi
	 p5ZevfJexmZdEkIp3CMw1SaabnnUdNh84O3nkXUEs8/7WPzTMphs2aM9em1+GdUg6KqTX
	 o/WZ2iQXOa365Gpwko24BF68iUcMOCd/d0FtWG43GzWygXrFGTAp1zZ9I86KbFLYPU9tK
	 SpalkU79uwmPM04Hk/2nfh9NmUCOZ6M/Rv9HpbYy2FJELtVsrKMmonKGd34vtX4XrvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uaOzwvJl;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1462606A335
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 11:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1462606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uaOzwvJl
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-382c3c9671fso855277eec.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000553; x=1795605353; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dxJkUC24im2bGryNLkAlqWRfHL6XOBwDY6Gegry7bnQ=;
        b=uaOzwvJlXdLXRb5c3IRYdXU/DOmkiIO6NOQBOqasbjI8XCIEoWbvLTrdaN7bTuEPlO
         2rWC1tssxCYoMzYBmxPsy1zQ7g8YZOW4z90dICP7PJdtMBAK1ZQ7MUQ7jJNM6kERY7Br
         PIaPsg0Bubj+y7n7Xd01xZuLPXZICusjVAIgeoRiZK1kqPLWHugOcXIMYH3rfPZJREvi
         JLfEfS79UjMmYnk++Iw80BQ/34XknetnUNAoUUR+j9peJREOFWLKhfdG/38JNp7q0O63
         pIT5EIAtx5gPR1w1T+zMsgUYQ+c6A/IjwR2v+VQ+By3rcFDzBWAHkSy6vWdG6QsYJvnI
         YHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000553; x=1795605353;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxJkUC24im2bGryNLkAlqWRfHL6XOBwDY6Gegry7bnQ=;
        b=uFhxkOD9LsrANC2BOCJf+2bo2ta90mCGu2I8CkoqkU/rHl8oTSwImap3zUn4aOI9Wf
         RMmFXaZR+CsPXsn5izA/llzWPsk3zhrCgTjAg/pknlYxnoRgZQVn5mULV8OE8GiFZvBQ
         LpV26Tj5GRk2j4ygdCkVHEu+cdp28Vc0GEdL2guPEtK3idjlMiCZPyeLMPC/JrQUq/9R
         WXrhjIa9UvpV2OyktXlji2y+OGBIbhJFHlYLBWAVo6D+PuQkob6NUbntfHpQMo+coKG7
         DOq10t17LAyHozUvoLbjq0jqIWsS3iYGt7hA3zcYiSzASaXf215yc57JiBDlDaKzzzNR
         PHug==
X-Forwarded-Encrypted: i=1; AL+hErEn2PRtfrttFX8NzaHKBYfWMPgIKjKJRFY2qiFVnG7iRRbObfsCFZGvb5biWG7yRJCux4Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YL5+MIbL3c6eHMsxMGqCDwokjxncMyE6Y3EA3MsTQ3KDhacqN
	FohWCOUBgnw+WTvnKRwJjEvkwNXbmR7sBq3B6PyI/LiN0K05YuMbF8+u
X-Gm-Gg: AZFdTZdn55l4qyoQIxi6/zz9KD3cwlGmG0Ptv8cjklp1qkTRzJugiY7KOiv1zDGSaNp
	iFDioobNK1qFbvejgdrySsIc/+r4M8mo35oFViPLRhpn37WSNesyD9/5HJAo0RZckVp0iUbic2x
	K4dzv4TE5tueluVlP3RZlX3aIHyqo8LX/zTghbi5FG60Xk7peJBag1IHGvSOqFy6ajbIZwjOgjp
	suHmlL1WeMSwDsmBeev7PMwOU3G/Leo9smn9VqITlnnnS1eyoUWBpwgoUM+p52FssxaQFFZJwwO
	seRXMyUg60EzBnOuWV+AmcEfEFXhGBLZrhvlfQlX0Ijy+vKMgp1v4UZK8eSdj3k3FEFjDUfZ78m
	nd9vVQOwuFgpIZn+wU79Nq8P0kUureGVoAbQfbem69s8LY+4OAgmSOkyiSLDjk5Gl00zWp0m1TJ
	OOL2JVz7BVHd11aSM+iCdi04DAXg/WTIq86pdwn2AJaVMToOCHu4+EV5xwG9eF6Kn0fnr+6b5T9
	JnyqjsRA5wItWtyH4aMtoPC+WWDaBxcPrXIa7GfwFciUXQr4S6k9V9cb3DYTM8Y3RPA0lheC+Mj
	gAn1y4NuTWWhG5qPWysz+oQV+Tc=
X-Received: by 2002:a05:693c:3881:b0:36f:83e7:fb7b with SMTP id 5a478bee46e88-38281cf6999mr2106174eec.40.1795000552950;
        Wed, 18 Nov 2026 03:15:52 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a80bc19bsm7085645eec.29.2026.11.18.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:15:52 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, farosas@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Clean up on uvmem initialization failure
In-Reply-To: <20261118102012.2252221-1-haoxiang_li2024@163.com>
Date: Wed, 18 Nov 2026 16:44:01 +0530
Message-ID: <mrr675om.ritesh.list@gmail.com>
References: <20261118102012.2252221-1-haoxiang_li2024@163.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Haoxiang Li <haoxiang_li2024@163.com> writes:

> When kvmppc_uvmem_init() fails, kvmppc_book3s_init_hv() returns
> directly, bypassing the existing error path. Jump to the existing
> error path to clean up before returning the error.
>
> Fixes: 175be7e5800e ("KVM: PPC: Book3S HV: Free allocated memory if module init fails")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

