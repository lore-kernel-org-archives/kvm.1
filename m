Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1AF36F407
	for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622650; cv=pass; b=NeSS16imeYINIVzuof5otp4DMl54lraRxGDFaQQfa4BVqbjmOdomgc++jUUFOAItrcjK39g+bStuuEZ8ydSkf3PvpMEizsRApgMyzxbWsahl7pEJjJ5yEhegoFaKlK1uo2mDCFujKKXnVDxP3IpjMNJHzYIfgAhzbwmvoLkqe7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622650; c=relaxed/simple;
	bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDn5tv+6NurGcqU1EOqvYb7QTSZTlN7/3JrLOQIWsDYqF2tQEi9X1PYKUCEZIBv8bnO717L2SkkNqdX8RGqIE/lnWCaJ8y/NuwbKNbDIatkhAZ8cbTKh9dTNliBUmTYrN+REw/z7+VbM90K0Wfsil+tz/1UaJVjHSdg9pp+jB4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHT6jDVr; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHT6jDVr"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5f1b9fe06b8so90500137.0
        for <kvm@vger.kernel.org>; Wed, 28 Jan 2026 09:50:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769622648; cv=none;
        d=google.com; s=arc-20240605;
        b=XAOa3M4IxPm6UnpfnhR/7D1zquWBw+9AnaGaYfg5Q5ym72ndl+wBIZmTcMPHnCujZD
         touxfAEghe4bR/pOdXrydR2hzqc6YVkmE6jQooDjHPjozduKw9eZn2m9zXp4ogiqvUUL
         TJPTFUwtSL81vFKQTppJ3Ysxlj3+DfDhdfuOZpysNmSDhguXpepxUR4UrzNriJVzohq1
         kJFmXdaaEvGhS4rTva+4cSh/LRMd12bsdLNsMQwk8Z+9fcPHMbxC25WGAzeYm7XwIdC5
         CXVZ1K9idkm54eI6GuZwmN3Z8SxKVaNzYU67bcJ06T9J/iWv4xylwgYHhsXqENNrnUGh
         P2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        fh=DKqjhzBaVNysPHT7tn/liqzdc4vl7I2hNN/aMDYnG7k=;
        b=UHTdPKi6aZ9JkbRSDDxw84XBP3diktv2SEGvgj0DFylnC0lmIAdrKIy45+5TiTxcxO
         sHdx6KIuH7a8lLumXcQxTsnkuI4WaY/VTpEAvkG3rVRAwoXr16hCqqkX4kausWUWOnOT
         QagZ7ZSCBV/kayuMqBtZ6tFqkIQUsJZJ6HhHgwcjVOruUQl+8YXhKCKlwpliFFpbPa5/
         deAdGzccDGwcWmOjPvHDAHqRUTD625U1VodtOFpBkUBAo4qbGAYlWEaXhI++jOYGQDML
         mM51WowWhhif43lQdkqDNUnxWEXvH8Mfbtqzo1Dxq8BAL5KVzc9fK/5A1pokohLrIScZ
         Fvow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769622648; x=1770227448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        b=bHT6jDVrWJ3mgE3zOdEbPbOXVylCYhJBKidSCHid9ahabufnkQjUDopdWEfUqt8bcF
         lg0R+SYljdK33OM6QbmD4IhWOpcBNORKLrkG/r3rwpBjibP+7XSbTyhpPWf/Fn5tZoXG
         8iXgSC9hofYXikgaLaloBdRIqBSk7PoXv8JMfHLccDyPyNZL1MmlvTj9jVtKoXD1qDdr
         wGJ+WPgGFHT1cBh2DDqw7vc9Y6e98IyTzsVBo90UqQBLxExjeR3YeBxx4KvuntNjJPy/
         oooOPZS5Ffb5yQ3ok1gMnfZO5miSxDmK11nKDNg0N79NN8NPBkqtA39yLQ4KYC7ZycF7
         5tOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769622648; x=1770227448;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNqWkOyueD1v7WuaKUDdc+x4jRQ5s6ulmoL4RqUerEM=;
        b=tTRNB3iRWzjoWDHE/3BXjna1R6SexSLPPhi5UY70GyJFOvUn61ABADcER5Jf4/dXsQ
         k272oDWd9Xt/E2CmDpx8+Z9U0vWVfdyYsMCQ38Cjbm0aK1y5lWbBlHn+0aRRGskTfM4F
         eO2h9I825uNpHWhjqUbw/vo5fHKsK+HSz+lGzqY58f6f7ULkECMKvxdwa7AqQwdZdrjI
         5B/ZRwY0jt68Vj3tUIXE3hOzT3UtAn9hxrDelRUXospmAQznfNvbO05Vy9C386+n3F5k
         RX/MHsM6VI2nY9UqTZ6XMBPo8IFtI3tedwh3UDId0Qcv6Fg2TeELV0FwabGycwfS0hqO
         8YqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqKp31z5pshWfZgCBidm/mIam3yc4gnIMuxz/zNnGxKep0NB4rntQmJKjn9OWCQEeW9gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXcb5uXHMF4mhEX8bbQXuUw6MXb4JkTR+0WF3i+hXJ0MEQ+KWU
	vFdIo1H7PHH/w65bVq04FwWKvQl2kfAXnGvXlHdUMlEOnOwN1PCfyoObYbMrd3AiL6Rr6/cVxRx
	nO6egc179i8iRrsqwf4B4tXK49Vks9iFUxmm4Fzbk
X-Gm-Gg: AZuq6aLTUxme0hvz+Zd4Fqvc+4yQo1xZjMSvXdKW2SDGpQF2FLfhhLCu7xqEHdaoqnP
	EUFssbWMISo+7GiAdKMiHKGxoSISI9WY0a1b0Jj4/FTnJ6XawvuQvqRQsk3M5XeZ/xV3ztjLqsf
	+gpdC+AuQxfQ8G4HhMhAEMqRX+RBnQ0EO0xm36xsip4FxQmSoKej/nd8srgfQUjlXofHg2hTcI9
	AiehM0zdNKTiu4WSIPKp+ghqE88ynChpT2xjIFllggSs3ujE2sYeUxMP+/l4uVapZkK+X1rkCB2
	v/4XlCNwSeAtCaRQBv7+BzyaeA==
X-Received: by 2002:a05:6102:390c:b0:5db:e2c2:81a1 with SMTP id
 ada2fe7eead31-5f723765badmr2717805137.14.1769622647325; Wed, 28 Jan 2026
 09:50:47 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 09:50:46 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 09:50:46 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aW3kOgKL7TjpW4AT@yzhao56-desk.sh.intel.com>
References: <cover.1760731772.git.ackerleytng@google.com> <638600e19c6e23959bad60cf61582f387dff6445.1760731772.git.ackerleytng@google.com>
 <aW3kOgKL7TjpW4AT@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Jan 2026 09:50:46 -0800
X-Gm-Features: AZwV_QifG6FXcq-qNYCcE_MoQgt6DAo9uPq6fzN3xKHneI_AD0mm_Yxu6BjCe84
Message-ID: <CAEvNRgEjo5idG7OtMqHt+kCRCQnWjzWzQN7nwNGDExwmf4fyvA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/37] KVM: guest_memfd: Introduce per-gmem
 attributes, use to guard user mappings
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

>
> [...snip...]
>
>
> So, it's possible for kvm_mem_is_private() to access invalid mtree data and hit
> the WARN_ON_ONCE() in kvm_gmem_get_attributes().
>
> I reported a similar error in [*].
>
> [*] https://lore.kernel.org/all/aIwD5kGbMibV7ksk@yzhao56-desk.sh.intel.com
>

Will add locking in the next revision. Thanks!
