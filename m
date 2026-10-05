Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036304BA1D8
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213819; cv=none; b=C7XDMFjyF+f6RJwRn3Mhb+uZ3VTVTO8yJnbOFpMSE7JIUWfonhCuGFl6cKVbbHzrmOtJPHn1BTD+LK+u/ymqaNsH2jX/hrRfxNjAaVFlrOE8E6/3Ifc+8PFkyDEF1BWp8X4VMiItvPr2N8KT91GqBtgfjsq+b9p77ieEZHj7+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213819; c=relaxed/simple;
	bh=JD1wEwvO8EjUBegIh8LI57kW7CEunIWr/ZuKTeMsXB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKNgbg3W9FVUEC2FDOqRNrZoHAkBSTEZ376j2KS4O6/T3AALDLSlpHNUdUPHaxt80K8mMcnLgiehIg45DwtIqPJUcpoPCvD5SHD47d7+KHy+oi90bep7E40Ezw5l/8knbHyQSz9cnAxevEsZvBmFKdHoRu51MaAwQzF9R1w4A+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4gcxRV9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tSSRmXYI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4gcxRV9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tSSRmXYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791213814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iM5Qx2i5nLIc63aAV/JJKuPo4F/ULfC/0lTigpa1vSo=;
	b=A4gcxRV9UMhu7/SELPcDJ+mw1005IGTwAMBdLD+irYQpArZaEBRfC1G3fQ1wX7VcnzEpto
	jFop//vYjoAlxh2c5t2O/vZZ8zZjivu1zSxFEldckXOTaydtUM4MTVzCky+3R309AuU88R
	oAANlthuPqSp3HcVWqLppXnKGp2MnKs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-yDTcHF2HPvS4cMXr3QI83g-1; Mon, 05 Oct 2026 11:23:33 -0400
X-MC-Unique: yDTcHF2HPvS4cMXr3QI83g-1
X-Mimecast-MFC-AGG-ID: yDTcHF2HPvS4cMXr3QI83g_1791213812
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so1331452f8f.1
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791213812; x=1791818612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iM5Qx2i5nLIc63aAV/JJKuPo4F/ULfC/0lTigpa1vSo=;
        b=tSSRmXYIx86XfPvUzpDIcuYoHWNrJfQgjuLm4LBBWJ+as1B7pVuarTyB1f4snUR4rW
         Wr7iowbORSgY71IKLydTW28u+9D/vudgExz7rygL6dhoZtQGJtnMwQ/gLWTGuSUoKyFJ
         0AFJT/czun40HJoEgmoXGMdhE79DGeZjrb72WyeAVB7V9fa1Y+G98m6KFcQPugomWE3Y
         zghoZlobUdF0RqoKLTEh0AsOTiMOedPtSDlox+szilm+4KmWGJGkZnyaIFGdFZ9qDmpG
         qwi7lOjVP1qxtqZnpqhSQZrQ1hX8v5jx3eP0foXh5yiDWwD+ZMFyJTGnYei+zy2f/6pA
         QqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213812; x=1791818612;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iM5Qx2i5nLIc63aAV/JJKuPo4F/ULfC/0lTigpa1vSo=;
        b=gdWTUmQfQ8GAxpHoGeqT8bdHpmPZI9BsRQ+BleLZxJIKvwkCWtVu956EqnizPskAb2
         O6Y4CVruF+XL2qsifnl6OlEXK+iyB1la6yQhL795RPp9efqCcJ81VlOnEXxw/REpML8b
         IS4YspV5l5bC8xAMFSS+d9Khs0tF2b7yBT2cpH7qNIbwwIdQYNo+B4LS1L/h8ZbnGqX8
         WVpuNx9uSboZC/JhiYUQjE9fXZOKNNGgVrijyXYvRX1t+x2ZcIrd4/9XYVZEzu3XpOcW
         yGjVUhGWGB7wFSO1fdRegMLk6P4V4of1WueI9SKayCxjG52QVTbAOGmjtQA5J1HBhLwQ
         b6/Q==
X-Gm-Message-State: AFq9FYINH380OR5MmURNadeDNtsO/CCopIb+QL0LKvgQFO4csfWIy7aB
	50izMfUIChHswapwznJSD+giZvVu9HK8ERhRDVLa5jzaBRwyY2Ia5D13a6RtCl+qLxViV1WDtTQ
	dB/KzTnTVdsF01WVPUuC+HJWcLF0+6n+ZuZNHvAT+eRbVmk/74Nix5wQ9ReWo3qqfM+7NXDYd+c
	ATMUBZej0qIDNpVWgo6ryh5vG/+25XPazLBkUsaw==
X-Gm-Gg: AYBFou2rx7kTc+/LmKzWlsenKaFKIWCNRdv3DZ1AHIncBLA+QJJ6BP5PQP1yPKmc4eW
	wRouYuVs0C2rXqGKbLlp9YsvdbOKejWzbzUwcmAGja0jdZNlhKjOJQdqFbQU+ONcCgHi1JYOmmP
	dc1Eb/fKR4FG1Qfi2RWfuCVGR0eb/ynJMKxYas4N35EJgIeyKKuyfPy2nLeFl2YprCqJRqIJ9zD
	XilC3GHNfOStIn+hD8Sogb6X5EuhWj2/rl2UPv6fvQijp49H+ZJ+9ZBX8j6BCRDTsJp8bl4zFqs
	5gIZ/UYw6rXBcwuw39jZh4JsEtS5Q8osObFPcSlFlUYEl/x4g2ZbaCE+w18=
X-Received: by 2002:a05:6000:2610:b0:48a:f11e:6d57 with SMTP id ffacd0b85a97d-48c47fe6a3fmr13297829f8f.19.1791213812346;
        Mon, 05 Oct 2026 08:23:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2610:b0:48a:f11e:6d57 with SMTP id ffacd0b85a97d-48c47fe6a3fmr13297761f8f.19.1791213811654;
        Mon, 05 Oct 2026 08:23:31 -0700 (PDT)
Received: from imammedo ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622bb172sm8922162f8f.42.2026.10.05.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:23:30 -0700 (PDT)
Date: Mon, 5 Oct 2026 17:23:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, Sean Christopherson <seanjc@google.com>
Subject: Re: [kvm-unit-tests PATCH 0/2] x86/apic: fix false
 test_apic_change_mode failures on stalled vCPUs
Message-ID: <20261005172329.4ce13193@imammedo>
In-Reply-To: <20260428133524.3628482-1-imammedo@redhat.com>
References: <20260428133524.3628482-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 15:35:22 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> test_apic_change_mode sporadically fails in CI on both Intel and AMD
> hosts with errors like:
>   "FAIL: TMCCT should have a non-zero value"
>   "FAIL: TMCCT should be reset to the initial-count"
>   "FAIL: TMCCT should not be reset to TMICT value"
> 
> The root cause is that the APIC timer runs at wall clock time under KVM.
> With the default tmict=0x999999 (~10ms period at 1ns bus cycle).
> 
> A vCPU stall for sufficiently large portion of TMICT leads to false positives
> (reasons could be: host preemption, cross-socket migration, heavy CPU
> contention). It's basically not possible to reliably sample timer values
> while it's running.
> 
> This series adds retry logic with increasing timer periods (10ms, 60ms,
> 700ms) so that transient vCPU stalls don't cause false failures, while
> real bugs still get caught. (most of false failures are handled by 60ms
> timer, and 700ms is one pathological case observed in a week of testing)

looks like this was lost,
ping

> 
> Reproducer (requires 2+ NUMA nodes):
> 
>   stress-ng --cpu 128 --timer 32 --hrtimers 32 --quiet &
>   sleep 2
>   while true; do
>       /usr/libexec/qemu-kvm --no-reboot -nodefaults \
>           -global kvm-pit.lost_tick_policy=discard \
>           -device pc-testdev -device isa-debug-exit,iobase=0xf4,iosize=0x4 \
>           -display none -serial stdio -device pci-testdev \
>           -machine q35 -kernel x86/apic.flat \
>           -smp 1 -cpu qemu64,+x2apic,+tsc-deadline \
>           >> apic_race.log 2>&1 &  
>       QEMU_PID=$!
>       while kill -0 $QEMU_PID 2>/dev/null; do
>           taskset -p -c 0 $QEMU_PID 2>/dev/null
>           sleep 0.001
>           taskset -p -c 1 $QEMU_PID 2>/dev/null
>           sleep 0.001
>       done
>       wait $QEMU_PID 2>/dev/null
>   done
> 
> patches reduce ~4% failure rate (8 FAILs / 216 PASSes in 2 minutes).
> to 0 FAILs over thousands of runs.
> 
> Igor Mammedov (2):
>   x86/apic: separate reporting from actual measurements
>   x86/apic: add retry logic to test_apic_change_mode
> 
>  x86/apic.c | 119 ++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 72 insertions(+), 47 deletions(-)
> 

