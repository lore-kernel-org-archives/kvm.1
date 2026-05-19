Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6726B2AD
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151270; cv=none; b=HzRsf+QvDcOVz4m33w0cRSXmyLu+HbMP3G24ig/TCJn4TjD0ShWPZSzu7Y4VYajTJQetRfWL7QeECCX3nBz7a0tbFjrkZXtAUr7+9TG10BZJeQbgOFUFEQPcLOEQa5mIgfxytE8vHnD7gIN1ERDapHp5ExBuS4q2bVsb/HDlbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151270; c=relaxed/simple;
	bh=M4yR/TGS0aKaxvHMuYh78LqHccBoHB+nrx0dbjt1fEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HXPU8JrByKJmu4+q6GzjYlblE+eHBgeVulPal32Cy7R0XNgUYVzNt8YtRxq5/C+B7Vygew7xN6U8evbpGPXnIvAipKtl+0b84e6wcXTUCWf/E+DzXky4BtJD4uBPqSYKdQi4wNobBdcOhHyxOAL2TfMFxkUGcWeP3Lu/1FAJ+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQ7Tc71N; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQ7Tc71N"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8397b14a689so2012464b3a.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151266; x=1779756066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UgejwXpA76RlgjxhDipr5RyURxN47D1+kEzNjcYgSYo=;
        b=JQ7Tc71N/nFDEN79oPcy6rTuhFB9UxsvT0AA0WcliyBGlK8Bto/9SkX32t8QsimdRE
         4bGkZI9E4lBWWJJXpPDtOMe21p9Wrs+R70r679DyiPVJj6B78j4p7Sdz9TvG4Xoi+u/x
         Sk11AkPz/b86GVyxQ5H+u6aX/55DHW/yM8JBm5KHLSwJJgd8muv8ZBV+2x6XETBSVCsS
         YOiX2ML+qToeI10MJ6X2L7UFalUQ7euf5ZAx/KWS+tbrtTF0yHbsmsSuBKSbMHcQcoAT
         eAYkwGEDqcJzuv+vSMlAikLnqWyNzLevkhTc1UUkTNpKB2u/sDeDyX3YjP0aXq813zXt
         9g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151266; x=1779756066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgejwXpA76RlgjxhDipr5RyURxN47D1+kEzNjcYgSYo=;
        b=qCTJzuFl6BRfnCoag/pBDx2c7Z1lc3vaZnLUrgqp3PTviKPlD7XHBOwuo3kujhHu/C
         /iGedUX+CHXclfd3rqhRxNCYaTrObuniH4J/KVen8n0RKVG3xluoAiRC1GsVZPP9+9Bp
         OHdstZ5R7pfpC6BsP6epkzBgs0aPWPHPVbZAW1IBUCZbmGo1CjbwGW+ekVA+Da+DTz8q
         HvJHnpk05yL11iHa+AFKWXP12Zjwo6UVa1HYV9DXEmySXXySefmpYjWEgbnbDijtG+dV
         9HNVshCw2F6midxv2nIC/OPZaSHWpP0eANL+/Rk4V7taqW/zBTc14PYf1QhKXAjdWxr5
         xsew==
X-Forwarded-Encrypted: i=1; AFNElJ/x7FbTHNFiJicLfS5vUbpohswks3xiypVdE9DE7uijgbOMqorUuGmZwXr26KFAOHC/+L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCxfC2yEbmyJtJOdRxwuWFrK5lPOrGjTG/NCaIOeOpuTqkkmI
	B85322JS5UuDeKUiBD6Lt5sm1t3OX8cU+rWKSLwqQCnq1UAQ/H1Vo3KWUGYnkmUd2iJR1d5YcR3
	vPVJuzg==
X-Received: from pfbeh8.prod.google.com ([2002:a05:6a00:8088:b0:829:7f86:623])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:908a:b0:838:3404:c2b1
 with SMTP id d2e1a72fcca58-83f33c9cf52mr17409038b3a.18.1779151266273; Mon, 18
 May 2026 17:41:06 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:34 -0700
In-Reply-To: <20260504235435.90957-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com> <20260504235435.90957-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915109934.2230748.6117009696710843760.b4-ty@google.com>
Subject: Re: [PATCH v2] x86/virt: Silence RCU lockdep splat in emergency virt
 callback path
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, djbw@kernel.org, 
	chao.gao@intel.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 05 May 2026 04:54:35 +0500, Mikhail Gavrilov wrote:
> x86_virt_invoke_kvm_emergency_callback() reaches rcu_dereference()
> through machine_crash_shutdown() with IRQs disabled but with RCU not
> necessarily watching the crashing CPU, which triggers a suspicious
> RCU usage splat on debug kernels (CONFIG_PROVE_RCU=y) during
> panic/kdump:
> 
>   WARNING: suspicious RCU usage
>   arch/x86/virt/hw.c:52 suspicious rcu_dereference_check() usage!
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] x86/virt: Silence RCU lockdep splat in emergency virt callback path
      https://github.com/kvm-x86/linux/commit/fff82ea9d900

--
https://github.com/kvm-x86/linux/tree/next
