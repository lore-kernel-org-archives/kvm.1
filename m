Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA44369965
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308726; cv=none; b=KUY7034k9c4aQ1lo91LJ+FM0HirAfUf3P+BDg6m/La4FDTcm1wRScqcbrcK569o0r4tYJPpyjNGPaGdxwb1XinF1yLY9wa8UqSsZSTeyTdrXKSH38o99Q4Rp1eRGYQKj+OcEEbmtBySMEk4QxCP+L9UWTw5MRQW2lcBD+APnyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308726; c=relaxed/simple;
	bh=PAO/ZdFHpG8p47uzDf0v9ZshqHFw00+CHAz03syre2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KiT1uTonQgViFJloVdp4wl+QWxOpSo11omFNF9+4E0qX8s1qtq4m4vES5d088PiZQY3rnDyR6X9MVKPkApnWa0DdroL0vKKl0PE8UNRWyhDAOEFKM+hULJ0NMZJaWjfA+e5eoBQYmi9CvWLVLogAHs5lEWCGsv52o0uxBvHp6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ete//sbB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ete//sbB"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8428384f31fso1174506b3a.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781308724; x=1781913524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gk2NaAkgAd4F0bK8xaCGSvSSoNoqRgl1vb4vACV/z+A=;
        b=ete//sbBEoH2luI4TPH/DwQfreFOu18Li1sbkqnH2F8XNYWaRnIp9SLr8DFUOx+A8g
         uGzG5va28/PvazgMAn0Iw8BOS9WtmAbHU/6LjuAeCCP2Keh/4kN8qc1xuCWd+LMOLbAk
         SErIgs1U3f9nLgnaULXRMtaShPGdHZMyUyRbTxRskmQqlm366L3m9oqdBA0kg/nyB4gD
         taogDrUh/mkm5bB8TsXLxi2Q++lkoic2/rA0FuMXvW4QXlyxAS/t4p/BLCbd9yiSarg0
         SyrrA++NJb6SBwcjgmjvkiA2+Ug78pDLzsr90N0wvfqh/LDU8emQ7EKDHsDUMLAeb2Jo
         RV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781308724; x=1781913524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk2NaAkgAd4F0bK8xaCGSvSSoNoqRgl1vb4vACV/z+A=;
        b=DaNPKgJvuJEZa9kcoTVcVpiOCifPDxTLnesVGqmM64nodTccEH0/bkSmvZlDquB5C5
         Nmmmu1cuo1azdDz2mOotEVt6reQnzgeYffx0vDiyw3RyyCWm6biCArJ0D99bL9DGpdqs
         DiGzpKgleFinXlu7W173n+nGqbfZVPc6S8uQMuEsR0eQj+hSuI0AFTplch9QdBFzRj8u
         ghZtxqQiAJ1pA460z/7vlim+hLm32ZhBBbvgnzTURjRnjkKf/V7C9yJ5FbD+NfbKHYcj
         ITznnsg764GNkC9Qo94Znyw5Qv5r9jNsnB/Y9eqwPUV593t20REfrOIXE4EOLONm7jtV
         WT9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8OmgX+W9IGNuo4VcxkUszd/QFH7UKDPeC3pWTF1Q9UV1ru07VOnWC7fuuQrnN+KRgi1Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5TkGNn9MYj/bNGZ0ZnVChKbT3KskbwYRi3j9BFxA6GwgM3D6
	GyoDfEatVsTfKvJtAygEyAl4IR7BmT52gFHNk/xrQnnP5MGelPr4ZesOUBItZEWT15I86aovtGA
	lpwPhxw==
X-Received: from pfaf14.prod.google.com ([2002:a05:6a00:a11e:b0:842:37d7:2fef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2ea5:b0:82c:d7c4:4c5c
 with SMTP id d2e1a72fcca58-8434cd5cf1dmr5684595b3a.20.1781308724122; Fri, 12
 Jun 2026 16:58:44 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:58:43 -0700
In-Reply-To: <20260612211003.2503400-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612211003.2503400-1-jon@nutanix.com>
Message-ID: <aiydM6OKxEhsGF57@google.com>
Subject: Re: [PATCH 6.18.y] KVM: VMX: Update SVI during runtime APICv activation
From: Sean Christopherson <seanjc@google.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jonmkohler@gmail.com, Dongli Zhang <dongli.zhang@oracle.com>, 
	Chao Gao <chao.gao@intel.com>, stable@vger.kernel.org, 
	Gulshan Gabel <gulshan.gabel@nutanix.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 12, 2026, Jon Kohler wrote:
> From: Dongli Zhang <dongli.zhang@oracle.com>
> 
> commit b2849bec936be642b5420801f902337f2507648e upstream.

...

> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Link: https://patch.msgid.link/20251110063212.34902-1-dongli.zhang@oracle.com
> [sean: call out that SVM writes vmcb01 directly, tweak comment]
> Link: https://patch.msgid.link/20251205231913.441872-2-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> (cherry picked from commit b2849bec936be642b5420801f902337f2507648e)
> Cc: stable@vger.kernel.org # 6.6.x and above
> Cc: Gulshan Gabel <gulshan.gabel@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
> 
> This issue is pervasive and has been observed in production with QEMU
> as the VMM. One scenario where this occurs is with Windows guests that
> use the AutoEOI feature, which inhibits APICv
> (APICV_INHIBIT_REASON_HYPERV).

Gah, sorry, my bad.  I don't know why I didn't tag this for stable@.

Acked-by: Sean Christopherson <seanjc@google.com>
