Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864D13C456B
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948724; cv=none; b=UJleRUknDj9kyh9VZQPl1htd+SRJQJgDPfm20NrrQQmJad8iw2oKhEPl6UMwx5tYTAJIsV93XM/9iZjcKxXSeL0SOY+ffkxrA43GP2TeSAIHGG7qSSNIVoVQcvFO1Y3JUE/rKqfQ74X5ajyuZLTPsIE1ziRYF/p7qyby/ifvA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948724; c=relaxed/simple;
	bh=sOsdyBoiXmMdokFUU9NitwvAChVZDM4AjqSp3wYEXpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RvyoH/nJUGMGhY3n7Sudaefy+OjDQ92io3KlUF2eitLbGZ2Tp2n/UAlH0EllDLiy997iPVZ29/wfcY1gtNj2YOC/gFfGDWTne+x5vKgUaQFBDX0ejgpcDNo4OMKN5Eu9HqgBZx+Abx7DMViBZ0niWaKou4pS7LPZzQdVu09IyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MdxQ4GZo; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MdxQ4GZo"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e0234967aso1094212b3a.3
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785948723; x=1786553523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xT6qDM8229kackm0k69E3MspU4jCbRhJTWhhWYM4wYM=;
        b=MdxQ4GZoZUlmg/ANGkVDWhlyF2DQwSuQcmn5W4VK6CqQD1lRMqlv3/uHplYFB1DC39
         txKO+gOtwDxOOfBPIqad/f7KAQXuUSkHZxzpmOj9t1fvOVgjA9JhkI3ebHpKjevkGR6p
         6mQlts5UCG4WeZ4gxG9k/KWrVN23A5Z9To1RMLmGRF4C++FIfmF8gPQJCy9iyt78vekM
         JiS6sDRkDk82ztH6R5PPyYnCNt47aK53Now7iDpJCu22O0twbKBb4NI4zR4zlU+zpDS4
         TQ/O+hb1Fse1Ji0Tc3lApqkaDCdse8OmVM6g1wvPgfT40CKutjf62zoMf5N9SP5oTBqn
         bggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948723; x=1786553523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xT6qDM8229kackm0k69E3MspU4jCbRhJTWhhWYM4wYM=;
        b=HcTIbEC9kicZFzPkfPYHfERCEY1gMQbUagcdSryuYMABum4KTQ1opj9vBEAt0cxmp4
         dduh5IJNE4T7sSpWpPaJYFsRdd5cbGsKYnW7ngHNP/fIxuWMGjjOHD6fZa6F8F1HsIvk
         w5MmfEhlyt9dGLuFn0myddBXJQiKfEr2PbCCh2jSEDu56R/rPvsme2JTsDoD4J3OVZux
         2ecFQjgNXqk9yBQtM8+e9yVgerXEGPBJexZAQuulvFVOnpkf+Jr60QcK0TnTCxV4tBtC
         oAXRIlzQ1l2Y5Y4ylU3740JD5DFGuxGlH6FAdvQYMcfF2P9KvJlxGmX59rex3k6h0H7R
         KeOw==
X-Gm-Message-State: AOJu0YxHdhKg+Wak75TzQ6g5W6/uo+TrWDUO+D7zDUAUnU2D8Tgq+4IJ
	wVi5kpecVPCI71ahszUgSkj/SJVoIVSbe87l0E7Bji+68VBrC6MqLXHhSQqZEiYmaivBTXKQRT4
	VSRtO7w==
X-Received: from pfbmy12.prod.google.com ([2002:a05:6a00:6d4c:b0:847:9540:3064])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4392:b0:845:e8b5:8c49
 with SMTP id d2e1a72fcca58-84f2e03173cmr10143997b3a.10.1785948722737; Wed, 05
 Aug 2026 09:52:02 -0700 (PDT)
Date: Wed,  5 Aug 2026 09:46:11 -0700
In-Reply-To: <220260710050442.826777-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709164751.621326-1-hemanth.selam@gmail.com> <20260709174955.628913-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <178594809140.3634744.9965381810030919938.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: selftests: SEV: address two TODOs in the SEV tests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, shuah@kernel.org, 
	Hemanth Selam <hemanth.selam@gmail.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 09 Jul 2026 23:19:53 +0530, Hemanth Selam wrote:
> This small series fills in two pre-existing TODOs in the x86 SEV
> selftests. Both are test-only changes; there is no functional change to
> the kernel.
> 
> Patch 1 adds negative coverage to sev_init2_tests: when the platform
> does not support a given SEV VM type (SEV-ES or SEV-SNP), it verifies
> that KVM_CREATE_VM rejects that type with -EINVAL. Previously the test
> only exercised the VM types that were supported, so a mismatch between
> KVM_CAP_VM_TYPES and the actual KVM_CREATE_VM enforcement would have
> gone unnoticed.
> 
> [...]

Applied to kvm-x86 selftests, with many fixups, thanks!  (FYI, I applied v3; I
tried to fixup In-Reply-To to get the threading right, but just in case I
botched that...)

[1/1] KVM: selftests: Add a test for KVM_CREATE_VM VM type enforcement
      https://github.com/kvm-x86/linux/commit/b18ee21055a7

--
https://github.com/kvm-x86/linux/tree/next
