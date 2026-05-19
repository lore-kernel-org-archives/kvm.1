Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00EF24E4AF
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151392; cv=none; b=TEOxn1aOPYxHjAue3We+cd7RwsDU6o6waTV9qulaWHAMWscB7c9Ny4iUSr9NoOvER1yqULNfYeg/bAb4vKHUVHCyojRlKKrEOpAncg8biVThHDjyTQkriVB8EVhoeZwmFCZQiAc7U3JbFimcLfIriErwPTdu5EzVH/wWPnfcbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151392; c=relaxed/simple;
	bh=hRpkoofSCNkgz9QWWxdhKmOg5On0J15eE0yAgzNdzec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YxDcfSDTUs6yeUsh6/ipgErlq0b0mZ/sBFKZ5imR68qEcN1clDciS0oRmCUde6fJyuqsPUOG0f0xGGSFa0ffrBx8iLYYa0GkEi+iGTaajolc/+ASpSTlCVChHGCIpRgALePiVhzyRTalJ53LBUH5039fmwjJ4QPC+oSjFKQMlg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNUM5Ju7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNUM5Ju7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so3776117b3a.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151390; x=1779756190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=65ZWZmlMjQXH6rRW2s3lL81WVV8X9kVkZMvPYyumS5g=;
        b=eNUM5Ju7LMnbEA4sPtpS/Csix67zAz/696B43jNtijQlkO/vV1NLVnB0tu/F9249kk
         ipNO8MXuxPEtp8uGx6YvGRCaq2IF5fkmiwk2NlRugnX4P7wyEBDdEHAkQOvNK00gfb6z
         DshJwXTylhxIBK+4ijG4ViEAxyKz8FP9xwEQSz7wbJDyizdxCTEGHuUAimYILlCJLRkC
         HAoIa0PS2hu8UcNcolZQ2jsKefKGcmX/0bAsglmka53zLOOkPaqzdMONoaN+2leO3Rke
         Hq/NeRqjWrCjObOGMIXZ7SI+LfrsNvmo3fI7pCkKeT+awHx/aMx45XywK4aZG3DY7rxt
         Y2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151390; x=1779756190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65ZWZmlMjQXH6rRW2s3lL81WVV8X9kVkZMvPYyumS5g=;
        b=ouUWTglkvsoWTlnFt4EHKRWLehDnsV4tTjtBgqb9nElyLUlI0pgS86FpktWvmjvWwJ
         YdVe+X1rH4zD0d+7Eowo/i2neBCNPHUBvWPfWiIE00qICrQRugZ+xvOXTIpN0ub5Nypy
         95bptj57Qzb2OVwbT7upYT5CApsEPMoTBlnAj4brq0kmfHiAwwl3VAZTH77jKlj08Gs9
         uZNk9gZIz0xtEsDeyxpEjMpcwYjUR4Kj9Mcu176ZHe5aVnoHYhm+YNhvyQU2ej2JrNrG
         yHgOhvTPl9hfEnpIMTIM7m0yRVH0kL7m9ygZGOeaGTlc42djaUe7TSHcW9Xy9PqTq6Wi
         iIPA==
X-Gm-Message-State: AOJu0YzCLAsGGbgC4pb3/9WdXSsRyge6J3M27qLa4ZV4Zc1bFUIjnPqr
	j9baqdFyeQzZ0nRFb22qDOv8lRs/7lxt7yr7lPvufiiTdQ5cEE8OGl53Bx+gnTAETtqxhv9KEkI
	bRPC7lg==
X-Received: from pfbg7.prod.google.com ([2002:a05:6a00:ae07:b0:837:c09c:9cce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:27a2:b0:827:33cb:c7a3
 with SMTP id d2e1a72fcca58-83f18d8a106mr14551657b3a.10.1779151389833; Mon, 18
 May 2026 17:43:09 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:54 -0700
In-Reply-To: <20260407144914.2621843-1-mayuresh.chitale@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407144914.2621843-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915061790.2225898.7317274073067106040.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: selftests: memslot_perf_test: make host wait
 timeout configurable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Apr 2026 20:19:12 +0530, Mayuresh Chitale wrote:
> When memslot_perf_test is run on the Qemu Risc-V Virt machine,
> sometimes the RW subtest fails due to sigalarm, indicating that the
> guest sync did not finish within the expected duration of 10 seconds.
> Since the current timeout value is itself a bump up from the original
> 2s, making the host timeout value configurable via a new command line
> parameter. The test can be invoked with '-t' option to set a suitable
> timeout value for the host.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: memslot_perf_test: make host wait timeout configurable
      https://github.com/kvm-x86/linux/commit/41d37c42e0c6

--
https://github.com/kvm-x86/linux/tree/next
