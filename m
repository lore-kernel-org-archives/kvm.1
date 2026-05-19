Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AD223DC6
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151369; cv=none; b=RVCXImOgbxVEPSfxfjtkUErpRDz2wXcZ4UuqcH+KoZCeA+581iNoAiE9W/ybaq2W+Ce8B7OoeWLQLAOEE4Lz7eXguIs96w0aNfOQ5aicDeiCGoEt6GP9ZQqFJyhwNiJ+2WNMIFclNLauDI3bzkrNw/xlb+hntltpuRUtHQZeHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151369; c=relaxed/simple;
	bh=DSiwzr9KXu/KQc0vGQGqrKT6qiN4M3fuLQYo7JDAAjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GrxG9CM/f7hjTQtaDKS2uhxH0VIPPKJPUDtlHIx8lymQMycN4D1sSCWOgPzcVN5AfJ0GkrBgomo0WAKA1gnPmyBQZlZwAzDUoGez2LH6K90QR1uNWLjqTEjVdVxJDFaQ9gSgW9Q9LbcLYrJrEXkO8f4tJFVw/LB+lkhKnBg4g8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2qwuXW4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2qwuXW4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8271fb4407so4658908a12.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151368; x=1779756168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se41lHn0+isi3pefn1yerJHCk/B//+pbs+CFQCqc+6c=;
        b=f2qwuXW4cEaBwEgN3unohBKRsbMwsjQaEMBG0Grbw0RdXVOmnwS+RziI8RFmtXz/3k
         6d6/Z4Cb3yRiXSLoWSJtNTY31Tgz9NY9epe33ec1I0fQn/ba6EdXtslmRzJ5UdcOn+ET
         iHhItRBc4sI3JTWChohQ+949LP3sYlQlIkDPI7MdNBcWDUqd5n2eyY2GJt70pPPFDwQf
         10AG+h2eiiRF24OnXHoc3lvNGo2ydp6meu7TTIXoNCUStE5bSdVQUsYJ8gZz3eVax0QN
         nx87YZmFsSCgHcpLqbFPUGr9GSxe3q0B+fMTDHTeU9C2Mv1QZhhBPR10USpblEMYwBPp
         QJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151368; x=1779756168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se41lHn0+isi3pefn1yerJHCk/B//+pbs+CFQCqc+6c=;
        b=RDKil4azwMgy9Q5g9zhXJW9SOAThAuYLonry0tJ5+4WpRQRErYTD4ePiR8TmKzGDZL
         dYMt9TFsItbxCkR1AF0f0v3WzeluK1zzy/u+9iBCjwAOlukAVWpz9bzcwRfCreJ6PnfT
         yypSk4DO/uDWewETvTRrHyJjwfYYalUdppQK/MUUH40Typo/DVC6oFz6LU2nHGK1K8/V
         23tARXFfS2DXnJPUvy+K4KRZ32Cf3OgtNFEIkNe9zJmUubiYzwR0ez/zsm56GkusYFLb
         Q7a03KgWqQpLNdJDQpkY8V3dlk7lU+OPLrQTklSvpXOSkeHvnxkSDrv0qZNIw1hvwEkm
         P9Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/GEz8feiI8dX1I4WysLvVKIcOjq7BHQLKmdEb4p1sFfVLy0jQE6Z+1rF568GOeXotht1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWSR1NPnsDeoIamGSn87qSDiwleDg9Fuix+ic4fy/zlBN0Ohk
	mH5NFtK3SyK5YOCCldbhfRgbm5YuIWagLGtEULdpG+eENFo3KjooHyDk9Yo+UizCpSBstrgwYlh
	W1T6hcw==
X-Received: from pfbeq4.prod.google.com ([2002:a05:6a00:37c4:b0:82f:344e:386a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2454:b0:3a1:76d3:c1b4
 with SMTP id adf61e73a8af0-3b22ec96ae7mr19078348637.30.1779151367995; Mon, 18
 May 2026 17:42:47 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:46 -0700
In-Reply-To: <20251208233910.1000465-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251208233910.1000465-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915043003.2224218.18325944210139637316.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] Skip PMU portion of vmware_backdoors test
 if PMU is not enabled.
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 08 Dec 2025 18:39:10 -0500, Maxim Levitsky wrote:
> Since 2019, KVM has an explicit check that if guest's PMC is disabled,
> then VMware backdoor via RDPCM is disabled as well.
> 
>  commit 672ff6cff80ca43bf3258410d2b887036969df5f
>  Author: Liran Alon <liran.alon@oracle.com>
>  Date:   Mon Mar 25 21:10:17 2019 +0200
>  KVM: x86: Raise #GP when guest vCPU do not support PMU
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] Skip PMU portion of vmware_backdoors test if PMU is not enabled.
      https://github.com/kvm-x86/kvm-unit-tests/commit/bf60564d1994

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
