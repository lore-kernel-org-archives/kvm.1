Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577836;
	b=uvaCUCNKKKgw7nDKaAUsWOEHMlG5COjLGUBjac+yKVDmpP+3UTKanghAUumsityL1Pxi
	 CzqAhJC3yDUEgx/fXoYlNCkdxsqmCvpmWzSAh60VkBhMxJAXN5ykuC5dJaI0VjSHk8Al2
	 x3gimt26GUIf4P/Lha/EULJObfYkr4lWkuK9/Tlj8C0UM+02H8U37oUc8yar8dlKjBMis
	 PgA4kShkQ+vRsqQ7XBTLd1TiYzN7FZYhvZgfXpNHhl2HlFW/qk46gz0TLVVylbken8atA
	 +bgyKlNEbEUHxgMWZ2svF54yK+Fd9tQDHqP9BF49WCKtNUolSdPrQP10mzJhv64ZiTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=lxsRKtRhiH1ZTa67KbxNQlQN1NFxbGP66GjG0MBIUXw=;
	b=agI4mW3OVfdPgl58XZXw2m/IdJn5CpDq4kfeM0ZxPCxuEHOeVWJ1hhqaGTkwG22m+gdw
	 0yg96s4vzmgugO1Dvc2r7qu7T+TmvbSmTMQH4nENy6fBSeCo4Rpt57ilEq++jI4Jp1Xta
	 TqxGAYEqSf1HPfsxeUa1xC1ij8S/6AvC4t4/XRFXHjSPf+OCFA5Pcu07qw1dSrmInbUzI
	 ij6kgVc136y0SMtjabp0t/7brAcAdNRoSb4QjBS0RYcIFHluQ2vmZgVhB0OaNnBXhD45T
	 uwOI/DpQiMLjhZhJTdfAEupGPvGqP+xvfp1KDsC6hSpXbx2Udzykj2t+N7tesHjckuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rwc6PPep;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590C606A8A3
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0590C606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rwc6PPep
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0ac277beaso842538a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577835; x=1795182635; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxsRKtRhiH1ZTa67KbxNQlQN1NFxbGP66GjG0MBIUXw=;
        b=Rwc6PPep+hI4XTzQBshalaAcYm7Xcoe+pXgDrGFMYECHoaNI2ZfsiRiBm3KsTcaa16
         TJuHntbnuGFtql6t69FyUPKTQK7B+iZQ9CN9SOEwt6DsDaUAguHg6Op1Wt52g0kzYy6E
         LVcxlquPdShFS0Eq5k2b7QYcJ0X/soiJUCZyNqFbosQs5k+vPXIaqVg8N9sqn67nUIuJ
         LR00yM2vmNLtPvj7QdQrE3Ck3YzHnQh/uAqtpTu5Hyo/W0YMYHDYAYxetPX9QXEc06Rk
         QnqmE5qxke/tCJ/qb1K8yOOMgnFsK6dBFmCaEXkq9p0BgC49twye8iyMMQ/a+A2v/A1F
         R61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577835; x=1795182635;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxsRKtRhiH1ZTa67KbxNQlQN1NFxbGP66GjG0MBIUXw=;
        b=CT7n52NwVjoBMSTyuF2uM2DDBoIgNziVkLz9X89BuGsM2VnUGane7+yEzSyR8XdZHi
         DJJyRshbmPzUAFVEP/QIJT3VcBoZ+lluHBt/14Hdw0tOQchd6AEaosRWql6h2cwv7EOw
         Z45IUGdf5/OmOD2XwqZZqDQ0SmZbqV/FdeL1F1k5KuHpYuwbn416JB0Ztd4tiXl8/ME1
         YFalRaT/zpjjpUJGnG+2fgOL1acOrAPYu8VUggZVTO1xa1kqe/SQ+v08RcxvradFO+Ff
         Q76TZ4lnd2RYg+sjJKG2kKs9RHeqPI4NpGpAphXgWTiXqO0OemXIQ/thQNydvtL0FZ0u
         MP3A==
X-Gm-Message-State: APuU4Z+X+wrLYp1T5fAlyeDoLaj/GH7Fqnn0pV1tx2hDtKY+2O29CYDj
	ohRx2u5Tb2afRylEk0hrOXhy3SCYJ6+XuJkxwHOcFwv7E+GjMsTiLggGms2h0FH9LEceuVZedfk
	sXGmfMQ==
X-Received: from pjgo16.prod.google.com ([2002:a17:90a:4210:b0:3b0:a2c4:246b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37d0:b0:3ac:aa8d:19eb
 with SMTP id 98e67ed59e1d1-3b1b07e9b1amr2418366a91.3.1794577835192; Fri, 13
 Nov 2026 05:50:35 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:58 -0800
In-Reply-To: <20261027223038.1566931-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223038.1566931-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441791333.77463.12077075015092050063.b4-ty@b4>
Subject: Re: [PATCH v3 0/3] KVM: x86: Drop deferred updates of EOI bitmaps
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset="utf-8"

On Tue, 27 Oct 2026 15:30:35 -0700, Sean Christopherson wrote:
> Stop deferring EOI bitmap updates.  As pointed out by Amirmohammad, I missed
> this one when removing all the other cases where KVM defers an update until
> vmcs01 is active.
> 
> Patch 1 fixes a pre-existing bug Sashiko pointed out where KVM doesn't update
> the EOI bitmaps if APICv is temporarily inhibited.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/3] KVM: VMX: Update EOI bitmaps even if APICv is (temporarily) inhibited
      https://github.com/kvm-x86/linux/commit/224c5cbd9194
[2/3] KVM: x86: Switch to vmcs01 to update EOI exiting bitmap on-demand if L2 is active
      https://github.com/kvm-x86/linux/commit/70ab7673336b
[3/3] KVM: x86: Consolidate invocations of kvm_x86_ops.load_eoi_exitmap()
      https://github.com/kvm-x86/linux/commit/77eb3b1f9bf8

--
https://github.com/kvm-x86/linux/tree/next
