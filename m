Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B2182D0
	for <kvm@vger.kernel.org>; Wed,  4 Feb 2026 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770163826; cv=none; b=mXKwhpVrvU/UqFT4tzjjJF3EgOgP2jEpuFhN/Sj9LigSTTa5MLIUk8gTOn1RIvkocuoX6K1J84ckAG1E+UTyE0peKO88eFwebkFjaeY92NDH7Amsl5Agv9vm7Pw/HNUVt29bgdeyH6S0oDNqzQHshYflKdRyb9uIjSzejOO+7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770163826; c=relaxed/simple;
	bh=YS4o7DzeByG2ggozkUaON0L4h7WORuySrP6EPGfzvys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pYETLBs0llcJpSvJ98usU156EuA8KqW6bt2+5KU1PduXZsyN8ov8MtldC63LOcN1eLP+JC50eJ46OdV1J3r2n78sAFVrxFhPvIN4+8cWT8fAB7CmZERSGVjXidO3AvMA6xnfmVNnTclgRn1gl8izoImVDbdxQFnvxJgROaKvFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQ2O452T; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQ2O452T"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a377e15716so165493035ad.3
        for <kvm@vger.kernel.org>; Tue, 03 Feb 2026 16:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770163825; x=1770768625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtmFWIeMNMSsWiL4GytfaYPuqz16OVmvU9wkRSD/Quo=;
        b=CQ2O452T/NQMOQ+JUn9FGg2e1AX9ueCLHuoVPHrmYzdImihOQCxHPdUC0C7cQUno+F
         ZlVF/13AzdednxMd2taRTudiOWCqZx2GRCnotKODYXsCG0UGoSDkWyRwZTJABlDwqquf
         acD/bgSuS9V6p/9f4MreT368OCNb3H1lf/5ypuaM2Cg56UNTJfaiFu1op36n3E9cOafn
         Ln0Od3v+sIYVCKBXlHPkpp1Tg/BLXzdOwHZew09A6z1Z5QM1z4RfwvezTYqIFVLQvzL7
         R4ZEd55517qbL2B+G+94+pzIrv3uaP74zBSgXSleT03/+xpBUojJeaoRDzunKB1ZLqjR
         i0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770163825; x=1770768625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtmFWIeMNMSsWiL4GytfaYPuqz16OVmvU9wkRSD/Quo=;
        b=bwzO1e3qoMk+UT+iZQzKPn8HCq9mOkm0hSrF9mylA4jI3ImgWuUTafjn5QnmzbCZc4
         WIG6h/2LmYaHYRdVAvOIuXGsUOU6PiBo4zLMb7ifndWVl8AN7Hp/ua9m7Zu1+PO1iViU
         0XS3bhK/+WAeobbMR2CTgCOL95v2kQ9PUSr5H17exb0QHBCXu8YxN1e8eHlL65yp+dcW
         oZ7dFcIZo7mjr9flFcam5GECE5TUI61teN3ZVVlqGslNqGM7GJHEfj/TtHPQj8EcEYIk
         iS7WKw/Rllg2/SeBRU+JgWBLjwfNVt4zyEdfS6zliGOtujoMQVSoIMINEUQPiUZVontp
         ESPA==
X-Gm-Message-State: AOJu0Yy2Y6VDZdaV+XTiCn/td72CrtxPHvtCGt8DskgQw3d394RMzLSr
	iTyJYS1w4ve7QVSAuXVZvf1tmW431AIA1UAYEhv5iIWmoWUKvZYZooxvR323fT2NB0+tYQVPcxs
	NThj8Dg==
X-Received: from plcp13.prod.google.com ([2002:a17:902:e34d:b0:2a3:c3f8:c676])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0c:b0:2a7:683c:afb8
 with SMTP id d9443c01a7336-2a933cf2c30mr10094015ad.16.1770163824795; Tue, 03
 Feb 2026 16:10:24 -0800 (PST)
Date: Tue,  3 Feb 2026 16:10:13 -0800
In-Reply-To: <20260123022816.2283567-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123022816.2283567-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <177016367951.574529.16511584559819900521.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Drop WARN on INIT/SIPI being blocked when vCPU
 is in Wait-For-SIPI
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+59f2c3a3fc4f6c09b8cd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"

On Thu, 22 Jan 2026 18:28:16 -0800, Sean Christopherson wrote:
> Drop the sanity check in kvm_apic_accept_events() that attempts to detect
> KVM bugs by asserting that a vCPU isn't in Wait-For-SIPI if INIT/SIPI are
> blocked, because if INIT is blocked, then it should be impossible for a
> vCPU to get into WFS in the first place.  Unfortunately, syzbot is smarter
> than KVM (and its maintainers), and circumvented the guards put in place
> by commit 0fe3e8d804fd ("KVM: x86: Move INIT_RECEIVED vs. INIT/SIPI blocked
> check to KVM_RUN") by swapping the order and stuffing VMXON after INIT, and
> then triggering kvm_apic_accept_events() by way of KVM_GET_MP_STATE.
> 
> [...]

Applied to kvm-x86 misc.

[1/1] KVM: x86: Drop WARN on INIT/SIPI being blocked when vCPU is in Wait-For-SIPI
      https://github.com/kvm-x86/linux/commit/c4a365cd4a4e

--
https://github.com/kvm-x86/linux/tree/next
