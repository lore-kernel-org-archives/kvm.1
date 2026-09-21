Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40994A3D20
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999570; cv=none; b=e/eFoJcOx9cuqpS2iP6Ks+q/Rn3cwjvO8Vy7PL4Zt+Fb51nemLqNDFE3iWFdJzrBjiqAoccBlVpsrNVSClcM7Iej/hnUD39YjHrVXBs1d4cqG3MBb6vKdti4TkhX4FzMlx+ESH4s4Ml4+orCHVuGrJrk85mcYmddwzm0rae4T5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999570; c=relaxed/simple;
	bh=0dZ5YbDbJH39c/54d7+b7KJ43/iKdc3mwamBtUR777Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQ72z1CYV98Bf5qZf5oS7tMWsWM8LOpeuAe5u914lxj1TWXJ8fHUCOAFDuy+Yz6LCSfy9tM0krYj9hD7tSu1KewHOal00YbwxQMEcPYNqVUiPthu4AxppNHKsbFfaX2Fxmdq4VYvRw26IKt5XCQu090KK27j+SeZMAFHmaku2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oyEakO62; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyEakO62"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86ab8302b54so3452547b3a.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999568; x=1790604368; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36Xgc8CFAqUqBdMyUYpwMuSstU8OP86gmDCHoH0Yjzs=;
        b=oyEakO62fWq/dA9SucaYqgYInijGBMEstSQq/6uRMpmixvL5OXPUlOq4+DWBub72nb
         OxlfFWvZ6OYitZAMk4x/cMC/iI3IY6Rb7VaTnKe4eahmubxp5I5kWO9KSsill+G+KTYt
         EAAkBQYmP+WtbN/yiy8VNpKC8q7qBnceQUG9dwieaD9a/8/mMIwixswp13GMX1QYJSIB
         lSKfYy4zQJYwhFq3G3MdDWbQ3Cir9WCNTealXnRrh+YEvnBKkGnTMo81S0yJjhWaFeUo
         JcBLeuSzORf8+vdoaumUaYXhrN/hSFAihjwj3TzpI/fXPDHTz1m3Kh+G1hmfy6ehq5r7
         coHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999568; x=1790604368;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=36Xgc8CFAqUqBdMyUYpwMuSstU8OP86gmDCHoH0Yjzs=;
        b=gp0ea8gRrG/jHvUhgC7+LOmwB+BbCzU/UJaQcjeVubT/yT9EQ/gnlrNZdEI+U9FZUk
         kBOZEM3vzVqvgwknDApaXczFWJpMoXPYCgWxeRwUWA+IJCVEKIFyV3pb2TxuD/H8L6qm
         pQwWvLmEz894wdQqpj1xJnk55m8f240mGtRWfJpSNToh4aqEEWMsgmk5meDPEdcBU0Ir
         onWhXFFbGE95Wp//i3dwJBxMoQ9p0rTCsXrmwbujsNWEen95vCjKR9O0o6dnS+Llo4np
         lN9OhwPYvP/ME/3DZ63H8EBd/RcvhUTCyB4gFeknnKV6nbLx0CkDCpClKW1XTd8yZa7H
         WLTA==
X-Gm-Message-State: AFuF++kEMF0qRHXM69Roe/XJHk/xB74FcvZa+2yj5I3Xxmam9wP74A+d
	o1wfB1DZBHBYodU+/cBJjcGzRFHEnlopx7fUh7eDfs1p/PBNWQvGUM3D08e9YEUu8cqEb4H167/
	VeCDh3A==
X-Received: from pfux1.prod.google.com ([2002:a05:6a00:bc1:b0:879:b29a:eb0d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f06:b0:857:73e2:9108
 with SMTP id d2e1a72fcca58-874ddbffd9bmr14371131b3a.24.1789999567863; Mon, 21
 Sep 2026 07:06:07 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:08 -0700
In-Reply-To: <20260826184449.814130-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826184449.814130-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999678766.712354.13131811120139507103.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Zero reserved synic flags when delivering
 message to avoid stack leak
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Aug 2026 11:44:49 -0700, Sean Christopherson wrote:
> Ensure all reserved flags are zeroed when setting the msg_pending flag as
> part of SynIC message delivery, as setting only msg_pending can leak seven
> bits of kernel stack data to the guest.  E.g. gcc typically uses a
> bitwise-OR to set the msg_pending flag, without initializing the on-stack
> variable.
> 
> Precisely zero the flags, e.g. as opposed to zeroing the entire structure,
> to make it somewhat more obvious that the flags *need* to be zeroed.  E.g.
> it would be quite easy to misread the initial read of guest memory and
> think that zeroing the entire structure is completely superfluous.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Zero reserved synic flags when delivering message to avoid stack leak
      https://github.com/kvm-x86/linux/commit/2616f497506a

--
https://github.com/kvm-x86/linux/tree/next
