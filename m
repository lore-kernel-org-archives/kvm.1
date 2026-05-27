Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482446AEC6
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905421; cv=none; b=KkfU1PgJ8n1Ct0hIcGBgzbCHKmct57SBinQFqOfvlbBjdegLkIppd+ByN/eZLVp57A+T89fhj4xXxZqTkBv9VY4yXROEqYqWStiYHnGn7MoQFlM5Fu/TzSKyjBNXQdKDSPz6nxG6tF3AtFs9x3MQpKxZgTaTvp6hEi+aaCE6Wrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905421; c=relaxed/simple;
	bh=5zl8e/A1KoLtPg6u5QbxHA0r+R97ox9RL3KVxEpYmiw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=svJ7N8jeE3/JaEYSPDVyFcRlecMA0moe9ubme1niUolPphpVtSCwZJWr/jUfHC05+N9bG5DkJTfxCE4ZXdrszTDJCsef3lqlg+mMZIdfkJ4WofOIXzJeL6rpN73uLMATQUXkRK7pJbiqVEhMJUvqz+h3MNjdg1Poxk9mJ7IDpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZEkznF/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZEkznF/"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82ac893940so5851038a12.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905420; x=1780510220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AD/8sQmRknyN8/U6ovarcCCTn0cz6hpFAK5PQG0kOEE=;
        b=KZEkznF/diNJGUcdGB+yG2dWgQn+Se4gA8AfoYfGJPqshscIIsIo/OII6QUuqNu9oe
         bjo3DBfPXGkM0ZqDVqg6XFZH3z6bBTGh7bgMfKir6Jtyj6MBZIzxAROIjXnrDl18cryb
         1F6XZB3OEonLb0bIuPnkCOyyVLdsuYSuT/sVue7hwXUwgBOsfdgfpzevLvWDc5u1Jbi2
         SSMfdNOJgo62FpwllOc8zk/ONSXKOO2uFMhpmrSxR3UirxpJDYUNP81JnCIV2W87MCxI
         cthpbbnpN3yVkwpUINHjOHvHl6+E5Mbh1Yyg7emFgd2z9F/6GYsSWcXJaXu6oBJ+EJGz
         08og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905420; x=1780510220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD/8sQmRknyN8/U6ovarcCCTn0cz6hpFAK5PQG0kOEE=;
        b=Us9bdIM3XDFk5LyGWlxUAxby7o31mSB21bArOv//TSeumkqGtZS726Qgq0TCYiMZ6e
         US3WACg0ibBKcfg8EgCzCMhj8r++stUxPrKo76K1QWH44HoB7iWFyTfC6VtGW73DjrSQ
         Kh0u3wVGRLRaZIIfHpfnV01IS2AtxmO7/gcs8l0ldSrpctvel8yRycSU+G2Era+rAlwk
         dIjaYQxkYtGx16XR1JtVITtUh3CqowK/0bWxbPwuWFEnwQDKz+LxJwpG4Q/irWX/JOz+
         f97I81JM63JXhrGiUiHU8eKbokucsiNap44C6mYI0kNdK+1k3NCeK2c6s7pLrJYXhoVV
         iX9A==
X-Forwarded-Encrypted: i=1; AFNElJ+qWJyHHbRtlBVbx/bx7XRD6RdvXaIKZlQrAgusk5IDVN3DaU3ioGhJF0Mr98s8DuDwsJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Jt+YEIvm+QK5p5Do0GVIbc34EcFqoZArf340eqLR3ZqqMRsw
	wPQBJUU6FIacXZyMDEVgSd5sPXI08LHtuMu7IBfEgY8+vR2jtXaGecnHsvVstfWlg1kGkX0kLq4
	3wVfE0A==
X-Received: from pfn28.prod.google.com ([2002:a05:6a00:a21c:b0:835:38e9:3254])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244c:b0:3a2:e0d3:37d2
 with SMTP id adf61e73a8af0-3b328eac3d1mr25378066637.35.1779905419338; Wed, 27
 May 2026 11:10:19 -0700 (PDT)
Date: Wed, 27 May 2026 11:09:58 -0700
In-Reply-To: <20260501144413.49419-1-jiun.jeong.cs@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501144413.49419-1-jiun.jeong.cs@gmail.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990518753.4120614.9381718109027994009.b4-ty@google.com>
Subject: Re: [PATCH] kvm: fix typo in call_once.h comment
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jiun Jeong <jiun.jeong.cs@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 01 May 2026 23:44:13 +0900, Jiun Jeong wrote:
> Change "succesfully" to "successfully" in the kerneldoc
> comment of call_once().

Applied to kvm-x86 generic, with a slightly different shortlog since this
isn't truly KVM code, KVM just happens to be the only user.  Thanks!

[1/1] call_once:: Fix typo in comment for call_once()
      https://github.com/kvm-x86/linux/commit/5804f58901af

--
https://github.com/kvm-x86/linux/tree/next
