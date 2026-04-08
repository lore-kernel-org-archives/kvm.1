Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380503AE71C
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662608; cv=none; b=GRxFM6bQ6BsYdT2i8/FYUArFQZGJz3s8vsZddOArjQlld63mQMkiFCm7CJj5Mbx2KP+T+qVY1jIEVhTqNvRhHTu7TfI+QsS79gArIUP9a83t46PnRiyYvjF7+fZfMfcHqA0iLixNMzLbcxbjSVguyT5lnGfMAYi2aB1ROvs7YF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662608; c=relaxed/simple;
	bh=aqhil9we3JUp3ItbzJCqovQ0GaIdQRgbBTssmIXfeD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKnM1ZYSBz2Da+pOFOmAFZ2qIgFz35JpGhp1GRFUJf76tU7EViu6BXa2AnC7hcMiALkHyGDmlYrpwuMcywtrGWX3/r1PKSmoqBHpibeDxKKtf90F0mul1HvTfc528bR0DFenloFxpW65sA+nNH4A6/ao1OmFUlVBUSS2fPCJQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA+LsyCc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA+LsyCc"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso706808666b.1
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 08:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775662603; x=1776267403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqhil9we3JUp3ItbzJCqovQ0GaIdQRgbBTssmIXfeD4=;
        b=KA+LsyCcnSMVA0NtieFeMO6cFIeeUtIv5LqanAssSzGSQxmeiWc/7DC9GMQ6MxRV5q
         SUn5W8RnSFieWn+QNMSvMMA44DhlB+8lxHEYm7U5MQ6A+I77pn+WHtXcnRwZDbuA6jFu
         xsQOWVkyzYRw1H70IdaY+pqAgQoA47/VZVRPNNxmmqVwNsI7F2GgeV8xtHKTReKLfvMA
         28TWfGWANMIcWYfC+ZKfBGW98i6/zvH4hjGVMDch7WTLdjV1FlI3DghM3lbnlvvLrFIu
         4XCHt7tU1jViuwAoxs6J3ZLoDgFTJDKS9v6bgSVqkbRAU1IKICVw8BBr/PFu300f37mF
         045Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662603; x=1776267403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqhil9we3JUp3ItbzJCqovQ0GaIdQRgbBTssmIXfeD4=;
        b=agsSB/ytxA+p7k4GCzBivlcSdCiPqFUX4wPI03vG4XcxH7cWOUYwTptSonH6vj7rku
         8I/V+eoioDSCanXm6K+lRBzkbvQeM9ZgWiojG3tWgPYPBr7rZ+Q5SSofFKiuSrXugSJI
         vMwbd9DO5/wFHnUPX6ffJudTs1+RU3HObt2Znt2YVqPjTcxfkqgqJ+VcmguygBN9ytTg
         3nkDnYSIRjMFBbl5C3oLWidBJAJrj54VePhfbC53o8i+qTFRhuHTL5j/tzzS0deWF/F9
         f+GxPtHKr6tyDCivqEJHod1cLHM6CONqvYWn0pRBLT31Z9c0XxSK+PgAbYP5acaJki8p
         lZ7w==
X-Gm-Message-State: AOJu0Yxbg5vRrYNeI3pwMRnvUbRvh//O/G+tYsFy8rghjAZpPOEW4AFi
	7PlAPiIUAI0VEXTVW+Qcr0dITDiPWb4sGs5mLx24Rwr+ox1a/OkqnCZC
X-Gm-Gg: AeBDievcxiulPeSrO6BZfZgRNehOp8nVpsJUQ3Yjjm+T83JSkP3r+MzS+6/YTzT2zsP
	3qhdNwerHHUzhNUlV7UmSBmNfYMcFe468TIMz3mtyMv4T3jtXUL8zz7vkb1XqxGH4Py1gJRM7Hv
	7rqtajEIGvNXll9g6OOEEyl5gXDe1zwSIDIuVJIQApYVbEa9KWQvwGnWZraPAH+Js/HnQAyr+N5
	wbpnUkDEKYts0mn2qaDxCzeUGMkiFrteKpYV4KD/F18tcMtneVjSaIEJEN1PI4vIuxa10/HhmPC
	M/46ppyvUbSZhUtg/mDEwTQ1gZoBsXPbi3tchM9BXG92agznOxJFOLgeQowwLHlUxtrqf1uET/B
	ipQCIZRgIuQo7bTGaGa0m3+KrZDphNKavnmGk9LhnqwnY23tNSntJLsw66LL5Nzce2L4Fj0PrwH
	ZpybgXDsUC3hC3NPgNYZQjNyo1cP1g
X-Received: by 2002:a17:906:c156:b0:b9c:2f1d:7157 with SMTP id a640c23a62f3a-b9c67b7ea40mr1143330766b.39.1775662602651;
        Wed, 08 Apr 2026 08:36:42 -0700 (PDT)
Received: from nuna ([154.160.21.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972293sm657782466b.11.2026.04.08.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:36:42 -0700 (PDT)
From: punixcorn <ohyunwoods663@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	punixcorn <ohyunwoods663@gmail.com>
Subject: Re: [BUG] KVM: NULL pointer dereference in kvm_tdp_mmu_map under memory pressure
Date: Wed,  8 Apr 2026 15:36:50 +0000
Message-ID: <20260408153650.34484-1-ohyunwoods663@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <202604081418.sean.christopherson@intel.com>
References: <202604081418.sean.christopherson@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sean,

I attempted to trigger your debug patch via fault injection (zeroing
page_private on the allocated sp before it's linked), but the resulting
logs aren't meaningful -- every captured entry shows spte =
8000000000000000, a non-present SPTE, which doesn't reflect the real
crash scenario where the SPTE is present but page_private returns 0.
So I'm not sending those.

Natural reproduction is rare and I haven't caught it yet
with your patch applied.

Given that, what would you recommend as a next step? Would lockdep,
KASAN, or RCU debugging (CONFIG_PROVE_RCU) be worth enabling to catch
the violation when it happens naturally?

Environment:
- CPU: 13th Gen Intel(R) Core(TM) i5-13420H (12) @ 4.60 GHz
- RAM: 16GB (15Gi usable, 16Gi swap)
- OS: Arch Linux
- Kernel: 6.19.10-dirty #1 SMP PREEMPT_DYNAMIC Wed Apr 8 06:08:08 GMT 2026 x86_64
- /proc/cpuinfo: https://pastebin.com/pwvNYsCu
- .config: https://pastebin.com/z4fVZENs

The crash occurs while running an Android emulator (QEMU) under host
memory pressure.

Signed-off-by: punixcorn <ohyunwoods663@gmail.com>
