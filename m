Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635810;
	b=YfvnkJes8ikpDJqpocJQu77aFfqk88gykhdz6vYhxMfvwleJUwrZDILgN+g1vJ64QPqy
	 lE0gfxiuJi8rAoivOZMTxPFvPdlJ43knidIa644M/TxfoG/aCOHWzSWIWfJk61w/lP6dt
	 mfoyIFzXVHOBoDD7GBCmrMluu57Nd6QW+7mwHtXnc3ShSZfAxKFlj4V9czgtw3Jew+eH6
	 yXmRDMVcPbk3hAg3cAWCD5NtNRU7WbhtaWuG3yCkAMZRqIYyrfieEZdo7CkTdQrdSNGBR
	 QYeLvfzObWd/K2NHeCF8tOkbAWlzjk96xW32lPM+Emd1t3j71lgtgXqmP34jLj6pUSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=0SJ/IT6cl7PvbBfdwOVaYMI9Ri7oNYteO3BRN3/eb9Q=;
	b=cjhGagz9U7AdQ0Cs8/mWFR5z5M34mSJd+AhaWZhUH5k3UorjrC5e84Fd5WDACzZIb+ay
	 A8QOSvTOOO20/l61Z0ke8SF8tsL3ctZ0JwjQaZ3RT9LT23dZ5A7JlWTzcU9nqSy/mCHXs
	 SWXRhQ1S9XnUc7JsS31NaPsewZ1S6NDmZXq15W9AdD+q5bmGGtjxXWor8M7308NQqTgVT
	 Rb9h3YQiElxuMbeCysvVKnuz71dWsNnYgbbL3N+1FEhbLdrkrvP2V9wWsavhQZvzBbKoo
	 uCJufFd2mpVtDvnJ/mRNhmxHEZKJ68KtepjRYhKOlCypCqHMZfBhochjvqEG/CRF8Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g2Q72u81;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944C606A31D
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 02:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4944C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g2Q72u81
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so1298078a91.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 19:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792635809; x=1793240609; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SJ/IT6cl7PvbBfdwOVaYMI9Ri7oNYteO3BRN3/eb9Q=;
        b=g2Q72u81CpNuihVK9M4KPq3rL3w9Ttm3yJo+AuQlZn4TTWFpoAseCpajS0YF2wCnjx
         XUx20E/l2f7uZ9k/vtIfA0up4tgnlUjRIfYhJywE2IPKQVWF64C3faCvZYwxJO+xKiNb
         R2fILNT039mg0p3K3ye9dK/AP31MVX9doIiXc06GwDJEbbZZOKhSRfMS2byVFaeSZ8K6
         ryJQ/MnKy6h+4PKvPlqELr1xGjAkvSdBI8jupfdZCeDz89huMs8xvqhwnfQNq0/iMqNz
         LwIh9pX7MV0/4mT7/ukSQzqCcfdhSIPEbjxtj0lDPgDLAxZ8/5gDgqDri+9c51Auy7bE
         1/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635809; x=1793240609;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SJ/IT6cl7PvbBfdwOVaYMI9Ri7oNYteO3BRN3/eb9Q=;
        b=xVZ+XuE092E0xMI1dHFfDvj0FbSIM3vK6NOIMiF0cHB3HWbZagiPvxVpmH9ren6CiK
         9pC0Nu9HoJXkjXBetMGQtLnoWTQ+DOt62wLgfhGbNmK2xcuhNvEknjnvk/ZfV6OYxz/z
         4DgI6HIaG93ZXWF0yap6tcl8sTLsBP/XCG9U3fGYNLwZbUOcjmxjKvLoaiEiqNUJFW7z
         xvHRt1JIcD/nRFb2Pwr8xo89aELrdd/cxVbrJhsWuweNLCmvc59c1u4vnNDRBoSDv2P5
         IBTfqEmS5zl7H086Hw07MwKGhePSN10eFR2wHczPjf6hdXfW3J2IjBmuRuNnZf4GmB0L
         +R2w==
X-Forwarded-Encrypted: i=1; AKwUvBxTLdtnQzNIgsTk9H86L8WaobHBSRB+MHS8GmJFQbfcHToJEeA/K+6+H72Z2OrWzh5/M30=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBzecTNS3B/RHMX/qeKayMkRG5MCj1LBx/m2wVbHzY3Qy+eCMp
	9k+PfOFmxy3QnQrg81aIMeU+LOOi8ppqB0fPVyCohXt9Fcn8BHqq5+iiKCewsxBs8Q7B45JDJkf
	NF8+4vw==
X-Received: from pjbli16.prod.google.com ([2002:a17:90b:48d0:b0:3a4:b36f:8bb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28cc:b0:3ac:86a0:5764
 with SMTP id 98e67ed59e1d1-3ad86f43109mr2940095a91.64.1792635809433; Wed, 21
 Oct 2026 19:23:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:23:28 -0700
In-Reply-To: <20261020175818.375700-2-borntraeger@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020175818.375700-1-borntraeger@linux.ibm.com> <20261020175818.375700-2-borntraeger@linux.ibm.com>
Message-ID: <atlzoKxKxaM9ymGm@google.com>
Subject: Re: [PATCH v2 1/2] KVM: Set up async page faults only for faults that
 need to wait
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Christian Borntraeger wrote:
> hva_to_pfn() checks a FOLL_NOWAIT gup() for EINTR, EAGAIN and EHWPOISON.
> There might be others like -EFAULT for VM_FAULT_SIGBUS.  For those other
> errors, reporting KVM_PFN_ERR_NEEDS_IO would be wrong as it triggers an
> async_pf resulting in endless retries.
> 
> Return KVM_PFN_ERR_NEEDS_IO only if gup() returned 0 pages and report
> the error otherwise.
> 
> Fixes: 0857b9e95c1a ("KVM: Enable async page fault processing")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
