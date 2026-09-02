Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097A49364B
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352887; cv=none; b=boyGMPs9rQIuMORcukyLCIEhaLBb6Oan5Hhss9lrX6yvnWHJ3ToYloTCzWWyc/N7mtAN63un21XGUljXz0RFMjQlqles09oqtNVmgbwq6p6YJoDZtFPcPu9GWZ4PpOOQxY972HSSm9I/1OkWo2FFX3TxXmXiP6L9WLmUoB4HW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352887; c=relaxed/simple;
	bh=G+lYeOOKmDDA7vGsZcnldrVLSAUqszDTx32jDkEhPlw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ElKVit3v39KgUMhhVfJfr4g/HAV2Oew2p70F1q75lD9IsNsyx8mq/cwsS4dDPZmt2clMNLaZ71iZBLIMUCLKFfZhe3NemLUn6n7t3h4yNmOWsAReJWK8JDnRr0OdnQ9IU5BalP2YFmTpRliaQezbLciE5W59lmRmPdeKQql8Rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbpWcDm6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbpWcDm6"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c250f28f1cdso163657766b.0
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352884; x=1788957684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mxFp9sQLUO1dX2aGvnd0BTgUuZ5fJWW6y/rR0ghk3rQ=;
        b=qbpWcDm6qQmmEfqES8ga9anX9VIeGZ9ZWVyzagDBEnsdhwbRNp8hfnmJt3QPGDif/m
         3O+MJPSRyQjnznB8u3dBfrhBi606rYcH6goZKpobVZXx6Vey1ZHQLPGRb7mBkMG6XAG5
         9GIHbzqyXcOXEl9GPp52l9446BTnpiZeSg9Cii2U2xt0uCsX9l80rueQmDWtJXsUzpSh
         lWZ9i/W+0i0LftGZtTIns6UkoXSTEwVMM1BqJKye/w3vWMScaUrgIEKEupe3HX2mq1vB
         7Qq92Ol9AZXG2VK2ylJ+LsOZGuhyDs95ivk6I8Hsw7yl90xycvFO+lhWVYQwdikufTx4
         JLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352884; x=1788957684;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mxFp9sQLUO1dX2aGvnd0BTgUuZ5fJWW6y/rR0ghk3rQ=;
        b=nZ6evzzJqzITsnkpDBvfiYA4oRFQlm3XatBzPHCbwucR0HS4Y7dt/wavIyIm4aMPAE
         Nh/JT1aYixCfgAvTPzodXEUvWJ7HpoVmtkGH3YcUjvafQ+1HeIl9Hv9cUWqlLW0ToWPX
         Mo7vIwTQXHlDzER0UbrpjQHYgBStGc7Jt7+JhnuVE1VluohDz0ZnwGn8coiLUa6TSdA8
         hZ9zzIfRfbCit39iVPptkCqCY5qmhs10M/YjknpQByiIp6BvBJY40rIS//49x5YhTdAV
         gs/B7S758eRxYFXrZzBAaMSFigRHDWBCkQyY+yUKbBiTADqngmZFsaU79dRMmyNq6W1b
         pzuw==
X-Forwarded-Encrypted: i=1; AHgh+RrnUast798nIRe5HvH5iEpzUCUy+4VbmY7HzcqVfmnmS9Rb9K+52hh3Ee4eaaWn+w9LKOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kxwL54SSdnHmPumS9D38Aq5vnMnPRW94mtjaUnSK4Y6K9tqe4A
	4dLZZXxP61zd9cv8kJNvpHjzR3G9xMlr9lGGwsdlDkhFoWHMdZ1W1RNh
X-Gm-Gg: AYBFou2LVfFUTLZCIjRqCdPM08mEPLpdkQhgLvG+tyu5x6moC/3SoZtR+ckVqSKHLKA
	dF3z4dgKMKMx/CPC1Ta21N/OnNViECClhWNnfrMtDqieEyJ8yr6gyt9xYDXNev5cL8gCVUP4NH+
	8yHu8DoWCHFeTo8LNDU+5PQGcbTIqArPC7Jpd5GgIoKnXfVg31zlrhO1cXAhj6jLkoq+hzAfI1G
	kiVnkjYyx/t9huQSddpkQ5K/B9BzHAhAYe+DwJ2bcfZV0Y5n5Y9zdIVmhu2EcN7MlrkgLLp2OzU
	rZFrAe9moz5/XAwak7SZfAYPI0HROCqJfWKUVUxT0FlBwmyVsjyxkngf9y2cMtZcTWru24cqn1V
	XTm2Rl9u7NsIFZu1PlAteMwdkcSqZ3MWorDu/BGZ123kTXznfq9eJOOiuUG6eXULcx3HgHEM8qG
	uCQgumjD/Ito53w1FRGkMiI074rc+gxgsivcJYOXYbCm/Fi9oMLazWJENspAheYeZgMgk=
X-Received: by 2002:a17:907:9445:b0:c24:e1e9:69c with SMTP id a640c23a62f3a-c25d4de3f33mr302715266b.0.1788352883908;
        Wed, 02 Sep 2026 05:41:23 -0700 (PDT)
Received: from [10.45.18.37] ([15.248.2.233])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002f1dcsm127213466b.19.2026.09.02.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:41:23 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <37f8d783-3305-44de-8ba0-ab0d2134a83e@xen.org>
Date: Wed, 2 Sep 2026 13:41:21 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] KVM: x86/xen: Use atomic*() APIs instead of open
 coded equivalents
To: David Woodhouse <dwmw2@infradead.org>, seanjc@google.com,
 pbonzini@redhat.com
Cc: joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 ankur.a.arora@oracle.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, suryasaimadhu369@gmail.com, lkp@intel.com,
 nicoyip.dev@gmail.com, frn1furkan10@gmail.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260831213632.81023-1-dwmw2@infradead.org>
 <20260831213632.81023-10-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20260831213632.81023-10-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 22:26, David Woodhouse wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Replace the open coded atomic asm blobs in the Xen event injection code
> with equivalent atomic{,64}_xxx() operations.  Casting the event channel
> to atomic types is ugly, but not as ugly as asm blobs.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/xen.c | 35 ++++++++++++-----------------------
>   1 file changed, 12 insertions(+), 23 deletions(-)
> 
Not entirely clear why going to the trouble of replacing the asm blobs 
in patch 8 was necessary only to remove them here but, if that's 
preferable to squashing this into patch 8...

Reviewed-by: Paul Durrant <paul@xen.org>
