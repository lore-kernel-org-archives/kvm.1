Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577830;
	b=FI/h4wyUvNXncHdsHEbCf+uS4DFByDMdAAd+RnsD7ljTsqqfSWFTuKbUMqfLwipJkiA0
	 SXOPaUFphxADo+ggUnFLh4KzxEDQIEDfHPK+k9UmMoRpInhI9jCF6ynu5ooE7/c9Aeh43
	 jW8mx7IMiTg4JdHjJ3bc7b5f9mUhPzK2JzFfAHUTuA/4sHxmH9EDEuFU18uZHp4oANXyt
	 ooq4y4fO8yUr9rHxmyPkSNxXs9VAvotIXX3Oe4c354XX/019k54+zewDHS2ItLV5MRBHQ
	 hmWypIT+jXVgnoD52nPGdAxMGlVfSPr1wYhz/JRjQ98lIChLLD8rc6y6nxjNiDQUavA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2kWLdQ8WhuFeA8Ma+7E3DsD5x9VuqgJji8AqVGlcvTQ=;
	b=baY89yz76yOSeuBO8OClMtxRh9BspL3PSc8Qjnlgfgjw9LUUdsupsncK1zg3jltOz7UW
	 MEuKdNrY8LSNRQtIDXZlJFd1rvTGy352RbsZKGNU6zbPQKiF5qExO8brBTb/0h71qU8PL
	 RjyCphM+1tDjE7KQz3AchQvPPWnfIg2E7QWQMVkEVBsjqdCrf5BHeKKt0FPfKCGk9R/Hf
	 k0yfua/UF8hpv32IhWH+hFuyImmwSnULJkX8Vzh5yhb+9IVUMF//mIxDCgo0MQrKsOtCB
	 IsYGfN0iOpzonYR8or2fmPFyGO52nqVjcfNbFRi2/YvyygDx4vALlizJWKWXZAEGkdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mrqfOkvO;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902160A6F6B
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B902160A6F6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mrqfOkvO
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed34e33913so6527475ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577829; x=1795182629; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kWLdQ8WhuFeA8Ma+7E3DsD5x9VuqgJji8AqVGlcvTQ=;
        b=mrqfOkvOWKoh2MMsWkAZdkHqQb2QLn7JmSDUaYjn9sgc1FfEXWqq9J36rTEgChgFyG
         hPljzlqrSMNYA1rYeneH623YSZwwGUfLNWAux6lOVWYxXWstu7NLpimGZrotM7lLr4jk
         aImEju6AuyOqM1tw29hw2iQ9ikEn//L7ZDNz7Rbm53c8rj/tsPledIW/4elpkWRhgONE
         uqOERufrZfaO5hZa7RTuWyFWUjmCUmnB+CodqH7aN7pF/Gt9JYy+JF6GK0ayrWuYuMG0
         RGn7iJAwgofJc+GYfOfFG9XcKimtFlxt4Yu5NbHcVy2qBdlFV7/61zzQLbb4FHlhBpT4
         NTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577829; x=1795182629;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kWLdQ8WhuFeA8Ma+7E3DsD5x9VuqgJji8AqVGlcvTQ=;
        b=ZesPclm6IpfQjQL5NRm3Saozmu/+4xsGpMOY3h/RLyLJYHy3py246hxsOJcv+3Xm06
         cTQ5hqYR5AiojTWOgq35esGm89UWn9m3D+GhWSpbPSOzfHSLYRORGFBqnlEcbFq1tvqc
         MxKziwb5SgRD8q3DHQy4ANJG/klS/anTDPp9lrc1OO8Pwi2bWkNbpvd9aCSfWn9ZEVim
         KgWE1AMMgU/D+WZyji0QM86bQL3/O1Jq7PJBW0AgX8rsv3Efm2I2ABiTn+VatzjMpYqX
         7ayUHj13OoWdEFTxXAgykUC1TCbxWmqb83hmxClfDMwWy6fvoGlN0b2O7x6I2dDC66pA
         HDsw==
X-Gm-Message-State: APuU4Z8tdal5nc4VSbwDlQN299L/rwtP6Hiz/VcbNe8Vu4/VrTy+p2K9
	UtRrPIHwVAIk5Vm5q9eu9AVzOo+k4Cx4r+JGxUOFesy1KGwjOZ7KnzMqJKwVcmBpOXlj7YR7lel
	a1xvvKQ==
X-Received: from pjbiq5.prod.google.com ([2002:a17:90a:fb45:b0:3a9:ccc3:cbae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0e:b0:3aa:f4af:1e16
 with SMTP id 98e67ed59e1d1-3b1b08183c4mr2391477a91.7.1794577828910; Fri, 13
 Nov 2026 05:50:28 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:56 -0800
In-Reply-To: <20261028184136.1803336-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028184136.1803336-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441796850.78088.18130497766298569234.b4-ty@b4>
Subject: Re: [PATCH v2 0/2] KVM: x86: Convert all runtime WARNs to ONCE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 28 Oct 2026 11:41:34 -0700, Sean Christopherson wrote:
> Convert all bare WARN() and WARN_ON() runtime usage, i.e. WARNs that aren't
> strictly scoped to module init/exit, or similar, to ONCE() variants for what
> should be fairly obvious reasons at this point.
> 
> v2: Convert the WARN_ON() in kvm_mmu_uninit_tdp_mmu(). [Sashiko]
> 
> v1: https://lore.kernel.org/all/20261022215541.631694-1-seanjc@google.com
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Convert WARN_ON(preemptible()) to lockdep assertion
      https://github.com/kvm-x86/linux/commit/bcb00f11d70a
[2/2] KVM: x86: Convert all runtime WARNs to ONCE variants
      https://github.com/kvm-x86/linux/commit/e7e4f00974c1

--
https://github.com/kvm-x86/linux/tree/next
