Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338AC2F8EB0
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684438; cv=none; b=WOR65BsTXR3NZ3gABKVyCMqhe5rdCYHkbbt4I/pw3EQFb2fJJBKEuF6GlLb8ELgcZTaLC8/pe4RkZ419I/kdKrCukrsqhux4AbXPq2AaAmAG5wC+NnLweiItqhmoLj9oGsrYvwhq2v3ZDlYTmhp0GDXbx+kFaVap+rF7HXyGjTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684438; c=relaxed/simple;
	bh=GKzP/68Cx30dLRfwvdgm3tzrOsu1g6xSMs9K2pPI/uM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ebOTjFjSyJdGxmXwyrrgQ9aHAen/C34qAKxaiiN6+DO4TLW8mB5wyyOATsp3cCHpJEZ1HFh6J/9c45UqZ7z+i/CIKXWrY2wJa7s29HwwOKpL/QSqURvqlDveQvj2dp7eyvE2Xuc+0ZXReVjBvaY9IvX6wMMRAPKXl9bMfOJCX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJ+bmrC+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJ+bmrC+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf1dece2ecso22664125ad.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684436; x=1781289236; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ic/UTtvaCpKICMLZ5PigAUmbpMkd8G2tIeD/PSReYYw=;
        b=XJ+bmrC+rhiRUK43n+xbYlLHgLk+TMeqUZX9demfrVxTHGfBrSO7sJX4w7Z7RH7yO7
         YqwWz1D0yvO0KrgUCju+XuDha1NVodobTj4K6yMfUQmq8HXlNoJ9iAvtzvMrOMBKPJiS
         qi6dCkjQzq2jsx1ThwkU/sqk4RvqeQDxlMCJwJxDMusY+MyoazWKDHWdEl8UnFqu6z5r
         YWJ7KNbSCVUFZgLjU8ImOPauZJi78ik2Vs7pHdRsrhsqqXaZOCJNtxA6TXUOg+oW6Iwf
         knRcN3qBjYvWBhIE/XnyzkDblZEcfOMzjdw645LQOKo00Qr0IH5F8YcRjJyhzWNTPQNR
         35tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684436; x=1781289236;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic/UTtvaCpKICMLZ5PigAUmbpMkd8G2tIeD/PSReYYw=;
        b=Pp8JOp6Mjiz7r5/QKDH0AhqPY7229Tx5T/XZr8EMN3PN6/t1Cj65CabcE2Fk9u+X9q
         Pr08IMPSLONz6nmJ5ADKFHxwF4tsk5BF4HzP0RB6x9HdtvQFwXMJt0TmTe+StLLcZSP7
         YFWu4R6ixIpQyqPVxC24I3RB0A2HCNUrFs6R+I2VNhZ90JZ4Ing8hl1OPS4/EEyjIxvo
         bCNntVOnzZSg1lMe5We0i8xSW9kiGe6aVXq9wIl+ZdAria+d6Pit7U4QTXoE1j+mgNfs
         XeyT6xEQohomaY8223mO7pJ5kfSRdxCGC7P9oeFq17TJFeMF48OluLxy6vjQ2vVvi2Pk
         nU2A==
X-Forwarded-Encrypted: i=1; AFNElJ+L1nja5ojmO1Pmk5l1DtcwD6IUYNDUizSFNH4c1C6uqhXVQggxI3l6Ts3AQlUgelm/2sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1bBnhHVwY1QPF9bfODt/UbVDp0AlOc9aHblpBeDb9/AYZKjt
	OwlkePKVmXiDHGEx5Y8rDpNZGuxg/FhZzrBz/dbGesMB5otP4FEdmR6ounLMipJIRNm5Qm7j64G
	y5m9Aeg==
X-Received: from plbkc11.prod.google.com ([2002:a17:903:33cb:b0:2bf:693:47b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b28:b0:2b0:7d3d:756a
 with SMTP id d9443c01a7336-2c1e89579ccmr48183175ad.35.1780684436307; Fri, 05
 Jun 2026 11:33:56 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:33:51 -0700
In-Reply-To: <20260528031624.1929-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528031624.1929-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <178068442917.2239222.14460208503268580125.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: ioapic: Use old_dest_mode consistently in ioapic_write_indirect()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	lirongqing <lirongqing@baidu.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 27 May 2026 23:16:24 -0400, lirongqing wrote:
> When reconstructing a temporary IRQ state from the historical/old IOAPIC
> redirection table configuration in ioapic_write_indirect(), the code
> previously assigned 'irq.dest_id' from 'old_dest_id', but incorrectly
> queried the live/new 'e->fields.dest_mode' to populate 'irq.dest_mode'.
> 
> Mixing the old destination ID with the new destination mode creates an
> inconsistent, hybrid IRQ state. This discrepancy leads to an incorrect
> vCPU bitmap calculation via kvm_bitmap_or_dest_vcpus(), causing subsequent
> interrupt routing updates (such as RTC interrupt handling) to target the
> wrong set of virtual processors if both fields were modified simultaneously.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: ioapic: Use old_dest_mode consistently in ioapic_write_indirect()
      https://github.com/kvm-x86/linux/commit/555aa0e83b16

--
https://github.com/kvm-x86/linux/tree/next
