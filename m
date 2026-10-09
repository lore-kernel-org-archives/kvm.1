Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB724FECE7
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570978; cv=pass; b=VSE3eIEUcBwu6Nc4wPBy4Es3mg74+eie35y1iVoZg3D/VQWU5iBFN5Er+ZIxkTI4wwNK/pNyo0TEkyeob7JM/4SgE81bIUk0TX9jVSuIL6dQxkPzxM0y4uE8QEydoPlTE0YqgKDCsmRhNddoUoa9tzZxC8WJZHhPeHArUIkUizE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570978; c=relaxed/simple;
	bh=aAdMtSkSU+PJixhSHS4YKBFzW6UF4o8VzS6cRINAxt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf/tqM7QiLs4JOjjJCfyOf+wGTJSQwDAnkNyGd46Syp0+D4qp9JclO26v+mP8ZBVfNkDekiIK4Ubk7/JLUPUvSSv5XGI4LI47Zir3PZSLw5Ebphj+4lnqZhOHfy4sJ57/hFAiqBB5Bkjq4HeXINr5P2ym/Yr28BXc4ZWwURsFgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=k9eYx0lv; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="k9eYx0lv"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b001cd92bso57161f8f.2
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 11:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791570974; cv=none;
        d=google.com; s=arc-20260327;
        b=dv3VohKh4Jb5fQaYM8KrBosBs4U0WhR5bj77DuaGiKfUL3tcEeZhms7MmmgSwcChph
         MtSOalcyK8DJdI4if1BjRWXmDNbC5kYoViTdt8paGzOtv79VGZqyC6nJTJ4HO5KKgQ1h
         Ztd76+s1LCTWVjjXlzH10S0xvDHTkf9GniU6XaVDtuwWw7XwaxRJRGiDlRD6HF/Fc8aa
         zWpCLfBZO2/+ah3Fwuz7ihQyzaV9XIdXBc1l8n+XuYNG6LnjrFbqG2LBGsh20L7awAY8
         TtzknbH8Zf8QgZs3F5VQrVrvvMge+NdvS4WzkCVFQAI8fogTXwrXthAJ7js3UhWuxXSt
         Mfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aAdMtSkSU+PJixhSHS4YKBFzW6UF4o8VzS6cRINAxt8=;
        fh=qvsc2dyos4t7DOdYuZv68GDfePZeYE+fDxH1tZ4DhyY=;
        b=qxJFOX30q9bdiJffn3A3jbuCw4hKxbbUJNSbfkKT9Et0PLd3INHhqPB3gb7h0Pf2+w
         AfNHR4yFDHNdH6H7OSvTEsOt/oPiKU5+zIBc9RedtRVcFcIGtdDSkB4EMp00NZbLLxUB
         SIXWaVPghEbeceHN4SP0LYO8AtF+XksAdkIWAAa6/6Y+6CXg/x7Low7NFM6q4934fg4J
         I9l1Tfta/gd+dnCm04tTE4G6GK+pBGJnLWY17kH/lrxK+LBsw2hfdzgURVtcXB52lK3y
         oEaBx42m+uCxrECZJfxyGkvV/85uDxGCE77+7D1Uu8TSxwVJnbYuT959q3kkxMfa+8Xs
         WQ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1791570974; x=1792175774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aAdMtSkSU+PJixhSHS4YKBFzW6UF4o8VzS6cRINAxt8=;
        b=k9eYx0lvd6ClbXWu1/rU9LCv9IhiHYv8T8KKL57dpQzmVoSUAdE9C8WfYFPb0kk8Vz
         d+drXQFJVg/4tEt9R/JMDAJkc9TxpgssBMxOu2FZ9TtbA9Pn/Bd9GbBBe13+aHVOyL6e
         PB9LBQ2VCWXc4lpkmZzQeDfDYPtK6amAwrHnv5XGu+EGDNuyumS8MS5WCajLg3VJ3EEA
         YdSapmFe9INRXGkF6yEw8YmbwoURlIqU2QV6mlwhwzxlg6qlIWWjGSSGHhUk23IYgWqd
         7ehds6Wtv6pmeNANxhLCbkWkzhZLsi79rH0RAPP5SDG2dQQIT8Uv1a39uy9bNS8kX6Zw
         BbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570974; x=1792175774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAdMtSkSU+PJixhSHS4YKBFzW6UF4o8VzS6cRINAxt8=;
        b=ceWIPJeawCnpIpEItXyzYXtQulAZpL5WFKNGwbovd1Ffr8BhpNcpO5JCGT0ViCyUps
         pSjUUDcOCzOCgxvXxB1U0SRTGZpdSoy7ow3XAJGHmdyGKu1fbUs9Q4EbF0DPVGWYyNMg
         D6ZkshfSYlGw+QehESibE272osEI55oxOvZFi9/Z55Lnzd5QSx4nhx0zcxTPi/MV6ZUj
         nn6GHID43DSYzwbTs1d1R+zRNm1TXMS4IQIJ7TnRpnnoQ9z0Iu3YXEYmDItSgasFv4+4
         A5ABoNLX5PmsMC4Kx0bgZRV7dsYBoZPOPKBhtBSPdrKltW973yvWbxEjHLI0R8TL2d9s
         IINw==
X-Forwarded-Encrypted: i=1; AKwUvBwoz5N27eyy3XCNj9NnDjus5ZF5IdIUoyXX8C//8F953FIPi5FR75BoZpyUh4lXN8JQQM0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjA1in4pa+8XebNYcEEROWM+S+LhQRPaz0ckanEtdvoI1Sy9oD
	n54GcUZGI5XBokBYC+JXccQg0l56OBd+A3WK3FSYnPiZofbTmblIK6ErfwebS3QHoHS8roIRCCl
	LjndqyNLcYkisfiLqrgN2zHe3wGbd90al4DjKM2+WvQ==
X-Gm-Gg: AYBFou1R14TGX+CA2SbRC5vWSL5gGCvRmZffPUbhQU0TDZP338ijyKqTdn5ZVSGhdaw
	Lj4fDEq9xuNqe8z7l6EXF4GbtYanSExRAn1QmmnZyneA+6PzGvVlCr1JS1Bbk9NOq+ziHX3oLgm
	o5EAZvhjhh5W+6la+OdfPpBme9yxAILH/TTtlhHIQi/hkUXVdqLvLXCj940+5q3iZZDEy0kEsby
	3/Jdq9+BF9zDz8fe17nseaxIBzmXxKZDJsAhHkbDIw0a1MLnrYfKVCAEE9VT1cqUSm4vP67r79C
	H4Bpl/HJcYAYJ85nOqD9sXDklcVTYkh7fXDZpj+/5BAd8DChOkmL84flrlD7F5QjCFgPTc52rie
	5ljEn8SwAe5IlU8bUe5j6DtEEA4wooGQzGGFZLQmwG5PuhGkVNUGIZr0nD+YGIfbPyA+fkKWg6w
	==
X-Received: by 2002:adf:f147:0:b0:488:8ab9:f73e with SMTP id
 ffacd0b85a97d-48dbaae4878mr3989428f8f.24.1791570973627; Fri, 09 Oct 2026
 11:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911152314.1076817-1-wenlongli486@gmail.com>
In-Reply-To: <20260911152314.1076817-1-wenlongli486@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 9 Oct 2026 20:36:02 +0200
X-Gm-Features: AclHuK-TLWsKgkGzLv0QJ_8v3oC-5fn5auBcEXlemKFFcSbIf24vnAAecN-RL7k
Message-ID: <CAAhSdy0zM+g=roVNZcQi5eV_=kpPM1TvsgenTd8WEeoX7-tyWA@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: KVM: Avoid synchronous IPIs on VMID rollover
To: Wenlong Li <wenlongli486@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Quan Zhou <zhouquan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:24=E2=80=AFPM Wenlong Li <wenlongli486@gmail.com>=
 wrote:
>
> The current VMID rollover path synchronously invokes HFENCE.GVMA on
> all online CPUs using on_each_cpu_mask(). This sends IPIs to remote
> CPUs and causes a vCPU running in guest mode on a targeted CPU to exit.
> The rollover path then waits for all CPUs to complete their local TLB
> flushes before VMID allocation can continue.
>
> Make VMID rollover lazy to remove this cross-CPU synchronization.
>
> Track active and reserved software VMIDs for each possible CPU. On
> rollover, preserve hardware VMIDs that may still have stale
> translations, clear the active VMID, and mark a local TLB flush
> pending for each CPU.
>
> Do not send IPIs or otherwise force remote vCPUs to exit during
> rollover. Instead, when a CPU next activates a VMID before guest
> entry, perform the pending local HFENCE.GVMA, install the current
> hardware VMID in HGATP, and only then publish the new active VMID.
>
> Use the same software VMID snapshot for both HGATP programming and
> active publication. When switching identities on the fast path, program
> HGATP before cmpxchg. A concurrent rollover clears active, making the
> cmpxchg fail and forcing activation through the locked slow path.
>
> Perform VMID activation after preemption is disabled in the guest
> entry path. This keeps the per-CPU active VMID and pending flush state
> associated with the same CPU that subsequently enters guest mode.
>
> Keep reserved hardware VMIDs unavailable to the bitmap allocator
> while stale translations associated with them may still exist. This
> prevents a hardware VMID from being reused prematurely after a
> generation rollover.
>
> Represent a software VMID as a 64-bit value combining a generation
> with a hardware VMID, independent of XLEN. This keeps the generation
> space large on RV32 while hardware VMIDs and bitmap indices remain
> native unsigned long values. Extract only the hardware VMID when
> programming HGATP or issuing VMID-specific fences.
>
> Reserve software VMID 0 as the unallocated identifier. When the
> generation counter wraps to 0, compute the next nonzero generation
> locally and publish it atomically, so generation 0 is never visible to
> lockless readers.
>
> Reserve hardware VMID 0. Disable VMID allocation when the hardware
> VMID space is too small to retain one reserved VMID per possible CPU
> while still leaving a VMID available for a new allocation.
>
> Invalidate the per-CPU VMID bookkeeping when virtualization is
> disabled, so stale G-stage translations are flushed before the CPU
> next enters a guest.
>
> This removes IPIs and remote CPU synchronization from the VMID
> rollover path, avoiding VM exits caused solely by VMID exhaustion on
> another CPU.
>
> Tested on QEMU with two host CPUs and the VMID width temporarily
> forced to 2 bits. Repeated rollover, protection against premature VMID
> reuse, activation-versus-rollover stress, and vCPU migration were
> exercised with multiple concurrent guests without guest failures or
> host warnings.

NACK.

The synchronous IPI on VMID roll-over is required for correctness so
that all running Guests/VMs immediatly update their VMID.

Regards,
Anup
