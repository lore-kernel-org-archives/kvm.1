Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577730;
	b=hHNWXlADvzHv2F+RW1TZpLL0JRXujhWFw3HBOzj5hFtVy/WHJljby+AJnNjtFNVKwPww
	 LrqHbPJpqOs9Lp0xAHVzETI96hayTlMgjU1xHZviu1qP1W83T4r1qgZ1jLjRx0qnHzt+J
	 XllVT2Z3kPHKqIk3ZFKsPC23MG2n/Ri8t/Oq2YbLrOweWUfDgUSDmlYzuhsB7e0gs03At
	 7Ow4oPrTAXxXNd21uZPVcJgpyffFqq+te/HRzxznkISr/SI9Shf3gPshk8Pvpr0Sn/rbp
	 PxUeOHbEs5uaSVCrzfI9Hyh++AkUqYXhZAVeVN98eAli8v3Ay9CabI3P3o1qvgW9hDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=owQijkkt4PGB+i0XYnWR09SeC4OwCpHMumuAGD1MVVI=;
	b=A/U1wh98Q7a1uh6rq6Dap/M4xolZKn9DFgxILnFmbi+Uiby/I+I8hpcVs/p2Lwa+PXIl
	 8CLSLRWALOUFdDQ0e86LIxnwLsSRSz+ZhNDfQrHb2a8Kn5PRHmRG+fRvAF8QlhEf2gq9m
	 J1HnyRMImr78kTZnUPxa29paUUD6kvsA1/p/HzMg5HSakmw9L19N3FYbwdR8mg2HtJ6op
	 KCxXQ94QLrurPLgMN4CiXg1EScQQdRIrll0KHOS+D3/4++zAkDk7y7fzHrbHZzUuACE3o
	 PNt0hWb5YU/GYTTNhXiVW4XP66Qffm/Z8PH5NkgBUXXblsfj1FlI289R9W7ELjnXC5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B9aYRATs;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4C606A889
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D4C606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B9aYRATs
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b847ab3fd3so1333856b3a.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577730; x=1795182530; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owQijkkt4PGB+i0XYnWR09SeC4OwCpHMumuAGD1MVVI=;
        b=B9aYRATsr6AjwFdmMFe+QqETDSJS8V+FIDOZb9ABXD+4Ee9sHeSAzpr6Wg0xnPQ22Y
         +grnUbNyqtaKo5Z0+NPmgalzhswXvyqpVeI131Yd4l33OSiYSlKof50xrlkIYYqR1CFJ
         BetSPA0vNGW4IDtCx6b2Mz8hgSw+WFvtJ4B29zYNmHN9blYTy9sA9LGiaf16t/ervrup
         wWgRimuEyWjsB1hXFpbNyAC7KW6GIBY9PffjMGYdhWRTPB97u5PnZBx2MQP5zjzw8uU6
         SgOPzW096mP6trUDFYAAiFkbHFe240dNEdcIfNLuouDdnFKEguPinZsPv0aws5hDOnXC
         27VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577730; x=1795182530;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owQijkkt4PGB+i0XYnWR09SeC4OwCpHMumuAGD1MVVI=;
        b=f/hSqc+YfuIhYyvWugOZ8TNJ2wiwm+3ngyNZa89xLu365nSNbPwDQQhAgIaMQhq5TJ
         TrkFIMlvf2jzOLpyWLpTNcQFtuBTOGCALxz21R4HwWu6dHXYbY9uQHehp9MA9jM3OvCm
         x6jrle8/QeJEoVNrtps0nOHF3g8dBv3dhSKKMrYkzcPsjnurgcQmvGGdWyYF2A14XOLV
         CfojKFn5hDEpmJxiEf/n0PcQcGZ63WNaVuaq+Kqv92FeFQOjaWm6JxNxP9cChnA0VI4c
         v7Y6lOhQivL/aDp7i6D2gezhpKeCcMe8aEhB+RVuiUG9SvDfTlGZ+Xuh1SsJqY5ePdbh
         I3Dg==
X-Gm-Message-State: APuU4Z8qtzmHLtJkxJ0Cx6+TcRnAfX9jA3IbG1/aPap+ZWSkQ0n0SdgT
	xiSj9A8kivpIpFztSWs8C8ATyMf349YhEjqld2HEnlStN8OxTAJymknZx6iMO6TRzLBf5bfeAUv
	yr67spQ==
X-Received: from pfblt8.prod.google.com ([2002:a05:6a00:7448:b0:8a2:7343:1d03])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:807:b0:8a0:58c3:8ceb
 with SMTP id d2e1a72fcca58-8beb753d1b7mr2666112b3a.45.1794577729376; Fri, 13
 Nov 2026 05:48:49 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:30 -0800
In-Reply-To: <20261020175818.375700-1-borntraeger@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020175818.375700-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441818685.80121.18041691595252974773.b4-ty@b4>
Subject: Re: [PATCH v2 0/2] Fix error handling for async_pf
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 20 Oct 2026 19:58:16 +0200, Christian Borntraeger wrote:
> Return mapping errors also for async_pf cases. Otherwise guests
> will loop forever. Nothing critical just missing error handling.
> 
> v1->v2:
> - !npages instead of npages == 0 (Sean)
> - new block comment (Sean)
> - fix testcase to build with 7.3 and 7.4-rc
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/2] KVM: Set up async page faults only for faults that need to wait
      https://github.com/kvm-x86/linux/commit/9e03117114b6
[2/2] KVM: selftests: Test that KVM_RUN fails for unresolvable host faults
      https://github.com/kvm-x86/linux/commit/05bb06acb180

--
https://github.com/kvm-x86/linux/tree/next
