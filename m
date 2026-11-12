Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504160;
	b=oVsyoSbKkPWs2bZFb9kpxvdagtW8EpU4wyjB8rATHR6Rk9lzL4kSk8g4EtjYTgehUctH
	 N5LfLfYRYnX7Rxm+vzyFctYzRxlPWV5UskIMTfP6c1VXNBlbmqWJs5CLjAENWexOCaiLX
	 /q1Ep5+QiuM0Wc3AcnNaihRH0giKR1tgkljgO58Ww/aYQfBExULHonZA1ToziVZxiZwIx
	 9M2bJys0mcMx5e7J2ONGsEl0QAr+2pGUr1d5PpkOcOSEvDYRvD9Y+e0Jr8gG87Y6NzxLQ
	 q1TYWoqz5FGKjRHFcYk0Pw8Q1GLyFq03j/TXgdRsWMd5ylacbwIbLtwGgPcFq0l4ktQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/AzCjpFBcsxFuApem78XlXxlBTt4SuIRCgZJ1fWdV1M=;
	b=LIaRSsTLPJMxp3OJrH0DvlcyfMMVkZtQYckFaQHMNimVRDKPn8iLS9pMl8pRzq4GWaHB
	 vK6Ff4REXKSzgGUO8wCbKoR3W+yW0JbfJ7cubD9NFyGyooH+0rFr/JTWWlMzmiZsMnaZI
	 eFkicdGQFObqmnbn9wz1iZqa/qU/X0NpBlOPMYDMOmC0mDDvwsPCq4KY0f1ShZU3wQZOG
	 r0bVSjftMnOpvAPC2ODnOuj/2gtqrbmVH7DKK9vXwqv3AAn902i8Ol7rj6NJJx6jMuMZH
	 Zl+plm6SjgKIEfw+UxE5+OdhUdBOi3mGUF1+tfKmWsoWGpZF8ZPR7+Ta40d6v7SivDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=El2U0FFa;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A00606A327
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 17:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A00606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=El2U0FFa
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed05900df7so817735ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 09:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794504159; x=1795108959; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AzCjpFBcsxFuApem78XlXxlBTt4SuIRCgZJ1fWdV1M=;
        b=El2U0FFa/1kTNlfAoi4s3lVxhBnMS+TuFDyQDMzpDozCU6OYPkMXzTzlLBheS9ebNi
         V0Yd3DCF7EeGNz2s9mFP+56Ruqn5gQnxeYbpeRRJbqvh/Lp4jyBdq8ocd/vt5KAPkAKT
         D2VNZQrDAoe3xJRCdLhvJxcSdqmg8Zi8tz0zysXNjqZDq7aPJfbnYWJP5HY08syecLfA
         bcg/mgjsaMvtszdLpZzl6hLZpgAK2xSBvLRHDKfm82rvyrOvqxUJhgBscGukgwQfbg2B
         92fjHtg2Yb2kMZDDZug49EaL6Pb0qkXMtcPvRdekwPocdqBwhwGYlBYOHOlmPkMzVAR7
         BhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504159; x=1795108959;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/AzCjpFBcsxFuApem78XlXxlBTt4SuIRCgZJ1fWdV1M=;
        b=smXQRb2dcV+cdc2EIvl5IRx9ID2WtxuU8PytcM3WDwjm24FNy4uUTpOraTEhSbPkyS
         yG3YlL78b+CVqICM9100ruoBhi37wJ4AmTr3V4h415Q8QN6lmxxc2GcjQWQWWTAb66Cm
         uwua+3He1iuJs9MNJtTRFIxYXZNP0iDWSvkG56vzUxdRzaRBwP98zAJ/TRheVDv/byBD
         8demdfe7AxBNQhvh7xPqeDmzNu8y86ZBGhdBPXHudLMOcQgxS+PPDXamma1gQ3Kg/IXL
         oQh2Dnc6XxQs2izYzsq2KrJb94Cqnt2kVxgjX1nWO/K17ckDQtaJRuD4NbVv5bpYqNON
         G17Q==
X-Gm-Message-State: APuU4Z8edF1or1XKo+xjB4mDHqLoCKPc5IePgx08Tq6K+9VR0l6RhgUE
	jQEG5aTvta8bardIfMAxdOMNRCz1r5hW720PDSt/iRBTQMltHDXvN8po4ASJNk4LCHS3YYC/4Fw
	GbW4A2w==
X-Received: from plgs10.prod.google.com ([2002:a17:902:ea0a:b0:2e9:5b68:4b7d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c8:b0:2eb:4a05:4b4b
 with SMTP id d9443c01a7336-2ee0dcc3023mr420945ad.49.1794504159130; Thu, 12
 Nov 2026 09:22:39 -0800 (PST)
Date: Thu, 12 Nov 2026 09:22:38 -0800
In-Reply-To: <20261112144220.30801-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112144220.30801-1-dwmw2@infradead.org>
Message-ID: <avX13o0qRkidIwWo@google.com>
Subject: Re: [PATCH] KVM: selftests: Drop stale exact flags check in private_mem_kvm_exits_test
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Anish Moorthy <amoorthy@google.com>, Shuah Khan <shuah@kernel.org>, 
	Nicolas Saenz Julienne <nsaenz@amazon.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 12, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Commit 7d0afe669374 ("KVM: selftests: Take into account mixed memory
> fault flags") relaxed the memory_fault.flags checks so that they only
> test for KVM_MEMORY_EXIT_FLAG_PRIVATE, since KVM may report the access
> type alongside it. In test_private_access_memslot_deleted() it added
> the relaxed check but left the exact match above it, and with the
> READ flag now reported the test fails for me there:

Ah, this is against kvm/kvm-memprot-v4.

Paolo, what are your plans with that branch?  Sashiko had valid complaints, e.g.
against patch 1[*], so I assume the branch won't be merged as-is.

[*] https://lore.kernel.org/all/sashiko-outbox-193903@kernel.org
