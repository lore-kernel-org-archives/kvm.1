Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577698;
	b=DjIGSFz+wIyXaSUcpdqXE7OcIcjYP5Zr/uGJa/+8sItN+flFRQIuVnoYVbgJPyLjb6/T
	 QvOOoaoVfQ26rp9bcWzKVObEMrDRdok49EePDEAjk567uEjBMkl6rrjU6PCNwa2FmYkGS
	 II4tPoUay59AR4RmEoKqLgi2PmwYBng3qQkJxGKXfQb4/DKrAXMRebojDdYp8EfdQGAyu
	 gzsdpeDuPvLfLBnZkIodA2RQe6v6Yyro2fzb9E2J8QMc1p4x3zQ2PoKPSGq9ufYFBd+QW
	 y9HLCpzi7EStp1MRM1gJrU+AVVDG/FyhFVWXNm3U2c0u1sYybVCoywO+sGn3F933Iig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=PHxtB1Gf4ENCC56HT1H7/YouUUYQa+0aDpYwbN8Kj/M=;
	b=KXu+UD2nl86BaL5EMWN2xIib8qUeE3tE25oTGDYb/d21lRxe0SsO3eCZTc+7/ySZQqZb
	 h+fZLwWHS2otyNFf78k7evDuKnS+S0Jq8uxO4xeNwVCmJgQGe3CyazB0tEWsDVMlK+OwR
	 +6YzwcjQ6v+JHj6Hge44re/VMHUuN8U1MQboJQCp26nWAUU/zygn+c1gk2wow/ev6+upr
	 fOmDi67g1T93cz9fR0knXhpRIV7QR9NmPCTmleFH8ytKQAo/HZ8KXMRj96+auwRSR3lBs
	 YewqSXDC/s4sT7Ry1D1Q/MotnKYDUbdaeuKceE7P4RX7iZjS65NfLYzWl+5DzB9Z7bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n5yFHqG6;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32804606A32E
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32804606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n5yFHqG6
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b19aa066afso910044a91.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577698; x=1795182498; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHxtB1Gf4ENCC56HT1H7/YouUUYQa+0aDpYwbN8Kj/M=;
        b=n5yFHqG67oOmruubX+rthq3ghH/8H/n0V5kwPNsuo/bga0lzdJMGUppbPL3nLX0KrI
         fYvXvKn9qTUpaIwrFlNEkXptz4S2Wt79rBj5/d4fG4AEj3XH05uWhyhUFEntMPZMFE7Y
         WQCRbkDhtwyrHTo+7ULy6q4LAyvCBn+DVPtnuuq7AygbybqpArxRoMS9KLEFKqMApKHq
         rxpANoYzz3zFyyyfUD1rFrgRc7K6hmuPWGgwTKFsb4IehgAzqrfgJXVKuTBwImc8pSzN
         MhYibuAXClUTV9NCl8e6a51yuD1H9NyM+xkwHYzKNAezPR8U+NlL8pLU+xDqUtK7qCSF
         740w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577698; x=1795182498;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHxtB1Gf4ENCC56HT1H7/YouUUYQa+0aDpYwbN8Kj/M=;
        b=wRMq0FZT02MFjftvEFr2iPcbFyg96btBPY1I+m+TQwLh13XQT2Nz7/IAe2w2fUqv71
         Sj01h0AUYauSnAvJW3gpE37WVOs/rZS5Mmoun7kBe33wg8wNUpAgjPTBLL2F9liwhvUi
         UFGwbcNXUJqmAQuDin3bcCuv8sj1o45cr+7U1eryMzrk9T4cpscvM7Zc86G+YC6QKrP5
         mAXjh9/vPOjYn4E2ZZY+6MWftnmXBwkKZPk4gMtrXoKQDtJLLeTAZ22DwrDxjs4JI/fg
         D7srTLZCPNWxOKyjVEc1RMJpQ9fUu6HGXjzcH/Iz7kNN18GN0tgoq+31j0UdXC7aQkzi
         /Guw==
X-Forwarded-Encrypted: i=1; AL+hErHdVjnQXN4Px6PvtttixzAWE8zhj94xUxLERYvpbNds2pg30sD0n+7wqONwzCd9rC0fg98=@vger.kernel.org
X-Gm-Message-State: APuU4Z9It86U8QNhP76GaxDerkcVgGDcEzJK8FkmAs9TctYWTKlO/s3h
	FRrOXOj9ODTPMu9zQjP3Gz8WPMXwf5X+b7vy/1cHuweAMZGFQalZCQa+4YIj5Dfz6b2QSdJS+Jp
	FH9UwvA==
X-Received: from pjbfz9.prod.google.com ([2002:a17:90b:249:b0:3a8:8d0:61eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a45:b0:3ac:7406:b49
 with SMTP id 98e67ed59e1d1-3b1b0b5c202mr1376156a91.15.1794577697434; Fri, 13
 Nov 2026 05:48:17 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:22 -0800
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441847158.83355.13758439775824427618.b4-ty@b4>
Subject: Re: [PATCH v4 00/23] KVM: Fix+harden against bad uaccess using dying VM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Fri, 30 Oct 2026 14:20:48 -0700, Sean Christopherson wrote:
> Stupid SMM.  Patches 1-3 need to go to 7.4, everything else can and should wait.
> 
> Fix a class of bugs (limited to nested VMX, as far as we know) where KVM can
> corrupt an unrelated process' memory if KVM (attempts to) write to guest memory
> during VM destruction.  Because current->mm usually isn't kvm->mm when a VM is
> dying, e.g. because the associated kvm->mm process has already exited, writing
> to what KVM thinks is guest memory will corrupt the current address space if
> the associated userspace address happens to be writable in the victim.
> 
> [...]

Applied patch 1-3 to kvm-x86 fixes.  I'll probably create a dedicated topic
branch for the rest based on a later -rc.

[01/23] KVM: Reject user accesses to guest memory if current->mm != kvm->mm
        https://github.com/kvm-x86/linux/commit/2520694e6048
[02/23] KVM: nVMX: Don't force a full nested VM-Exit when destroying a vCPU
        https://github.com/kvm-x86/linux/commit/99872af7b904
[03/23] KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
        https://github.com/kvm-x86/linux/commit/93862ef1afdd

--
https://github.com/kvm-x86/linux/tree/next
