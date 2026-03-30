Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09673E6DF0
	for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910027; cv=pass; b=iZHMQQXQsa3Jjh93txaHt9Ta/sRYsQu9UXq57QB4uG1XIbFiyKIVV20e8nqk/zcV624Y4HkYWeP5Tvf45ayNioxD4mhdAa0keaiMMilEK5azOsgSbOerQxM64KOUy3IIx79Ul+uDsPXZ5YF/ln0HLBqBkSOwVPHcCBdwkmVUUFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910027; c=relaxed/simple;
	bh=e9kO4i8JRYHa4vG3b7wxafUDCr6xuJfaRYocvq41hns=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HRO6n0pQV0VnW83oaE8nU/qC+m9Lc69W37D5QihZygLMw9BGMzp/rV7hCZzJARymeqSIq19/kqTR8yIfYG18Br+iBNYU+wAKC4SgjEzubetWsCKzKk2Vc88c7XXfFZ9K/rnd1QnspearN938BH4CsaCiOb3tWnOQuEZC1IhI2So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/BFbV/a; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/BFbV/a"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-650086e46b5so471500d50.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 15:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774910019; cv=none;
        d=google.com; s=arc-20240605;
        b=YjAcVZ8loblISjeEHP+TqFvFS+Y3V2eMrz75GtpbgoHkGyHhNJxM2ORBq3FJJn8f5g
         h8zlxDtPWRrdLabVudWw/AKathAIHujUtrU8fi3YFAzbt4j1I0OSP/ioHD3J+flyQxB0
         b3+D4qoemp1tYgyL7elfifQXNTypRG3BZlgKof7XWBPM5t/s3W9n2fWkhj16DAxR8uCS
         NnQijLYbDSk+BSRWczYhQWjyFrNVBzfNQjRsenyH3qeA/arUKadE6D+l8MKG5y/tHPOr
         XtvBUzs0OdL4KChCOEeQSy9AOLfPD+RHPhBPPH7OOilhyR1pX4qdNze7BOYVvOH9Ju2j
         FM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iSQIVtNwmgy11GPH4hBTtVMQtkU5/chWZgBufGmlYz8=;
        fh=5AO88n8XTjTnUtkbeESv8iKczAdpBtSnA+QD1vYRrnM=;
        b=K7arthXlISuLjjSnxTDkdY5BrqwkJ0QrP9E6KmURXQPjEnE4d+VdlCsF5mrMRnam6q
         ZCiH2k0qvpUhpu5GJefriHDkTYyl/ss1wKIVLZmSodWIfKWjm8+KUjropZybkhjRPqh7
         4501DTachAla/FYTP5ITr5MlYm4QPF9FjUgtQh/3Ar99JXJB1+sUz5A3p6nHeUiTVzMP
         j6IkfQKuSYRhJcPizQdF/JZENvA1BRdzbu0/rpuI0v55Al+Ohh4OHUDMGVC02HTRc1cn
         L5D4FfqEAAvpvJrKM49cr2zFRnzXCY0/02mD8tyYkU6OUzlI9AX/P9VoOpXuuiIyL5uS
         EfIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774910019; x=1775514819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iSQIVtNwmgy11GPH4hBTtVMQtkU5/chWZgBufGmlYz8=;
        b=Q/BFbV/aPAcYVVAzhWfL4G/WJVe9Q65iLiq9EpY3KMc31V4t0yyqvAuqtp4b0iYfMd
         1CezyxPAuigdyBXJrl0SlYDhdMhX4m+hinunTEbvEbAqXmFHlYuBiMESt7mrh0VeBb2d
         kNEx3a169q8WVGanePGIuB9Xs0ZBdpELXmnFSxFn4zl5127SRhUgkawRpPwKSw3iWZhC
         pjoVVe3DtaPdDTDIsW9n0qFIO2pnz3RjPen8q/yKliKLJEMLqkWRdyzpXo4wpjxkH36g
         4dHF18MBUP2dbHHIrBc0KX08O9RPdtoa/0F59TeIqHUddFewfJNRpB6NPqan6bBOBcJQ
         mFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774910019; x=1775514819;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSQIVtNwmgy11GPH4hBTtVMQtkU5/chWZgBufGmlYz8=;
        b=sHQSwAGOPJXcJDhbArB1JyNpqZ/55FIYqiEEz5YC+VP1ZYTiFrJFzt8H5h2h8JlKPL
         MAmRPR7d5TP70eu/xoOU3ON0Wgi3fak6P0RH6CtpkkYtoCUgxvA1tORbDzC8RR4jeEDz
         QMd/aBdXzG3g1gze3rIk5OEL2RbyX24dVpBpt1OpYntN1BFz6fmfzOt70f1qlJXbzO80
         w7w/I524f7hHP9gjyV+a47yB1le7IeqZWu3AQMT2YAwZoAmS4PuMLAI8FnhKLnieNZq3
         1+Ipn0q4osgJq9T2vCsPhkBzzObVxHFL3rKx9u51+nIvutuufHmi39sy169PRJIxJvOr
         1AMw==
X-Forwarded-Encrypted: i=1; AJvYcCUawMnwYmvQHVa1g2HlOZhxXWnGNI834o44rsVGRwq6hf98AdlOJqqlH+cKlN0lMrbiOyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMpCIeWGsqTfDLVqgE83j7RqjlyDyyHpgBEilFq538Ym6hUzT
	wwa3t4mH7C8+1Dg2nsmMMRL8SN3P+2hya2tGbI28v1+rehMwcl1Do6yvv/9nmEZ9wuGQl5ont4x
	GAKR43633GVvTmPtdsP9mVma99N6TZJJ3KZ3SSwk/Tw==
X-Gm-Gg: ATEYQzy4kA+CtoRxr/Svne+CBacCUjmp7YizJB4hZvFrReQfc6MAueIM60SkcWbzo6m
	kpnQOxKSn7v8Sb6VHtFx/7bB2abEi0DzU/DRQ+5hTLquodQVC7hjjOzpED+Mav9Ne4PD/Q0FDn7
	hem5TvNnXZ7NAGAVr/OujhXk2G8SjBjn9UQEB1UTPhjlLUw6UO6iXZZjhGb7JvrHzaUY+w6ZwX9
	R/fIPRmeH5pfVSPSrI93rHUI1d2xx1h+rJ1L69NUTHXYnUwwlNx1YQwel8KOLsbphNtXasc79LX
	+vJSA63+d+dDcCfItX3Kc12jtWQtzcXt603yVoGwEw==
X-Received: by 2002:a05:690c:e363:b0:79f:6e27:a4da with SMTP id
 00721157ae682-79f6e27a8c0mr34255967b3.1.1774910019233; Mon, 30 Mar 2026
 15:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Date: Tue, 31 Mar 2026 01:33:28 +0300
X-Gm-Features: AQROBzBOf-pe5jARXyQ2xtgPPEYRjgNTKCd_ydItIeFDxwB4jvitxg0Ydy4TYnM
Message-ID: <CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com>
Subject: [BUG] x86/tdx: handle_in()/handle_out() use one-bit-too-wide GENMASK
 for port I/O
To: x86@kernel.org
Cc: linux-coco@lists.linux.dev, kvm@vger.kernel.org, kas@kernel.org, 
	dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:

    u64 mask = GENMASK(BITS_PER_BYTE * size, 0);

GENMASK(h, l) includes bit h. For size=1 (INB), this produces
GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
bits). The mask is one bit too wide for all I/O sizes:

    size=1 (INB): GENMASK(8,0)  = 0x1FF       vs correct 0xFF
(extra: bit 8)
    size=2 (INW): GENMASK(16,0) = 0x1FFFF     vs correct 0xFFFF
(extra: bit 16)
    size=4 (INL): GENMASK(32,0) = 0x1FFFFFFFF vs correct 0xFFFFFFFF
(extra: bit 32)

In handle_in(), this causes the VMM response's extra bit to overwrite
one bit of RAX that should be preserved. For INB, bit 8 (AH bit 0) is
overwritten from the VMM response instead of being preserved from the
guest's prior AX. On native x86, INB only modifies AL -- AH is
preserved.

In handle_out(), one extra bit of regs->ax is sent to the VMM beyond
what the I/O width requires.

I did not find a broad exploit in common kernel callers under tested
GCC/Clang toolchains, because many typed u8/u16/u32 paths naturally
truncate or zero-extend the value before reuse. That is not a full
non-exploitability proof, though: some ordinary in-tree caller shapes
may still preserve the primitive, especially read/test/write-back
sequences such as inl(...) followed by a branch and outl(same_value,
...), or inb(...) followed by if (v) outb(v, ...). I am therefore
treating this as a correctness bug in the #VE emulation path with
guest-config-
dependent leak potential, not as a proven broad exploit.

Expected vs observed (INB, size=1)
----------------------------------

Native x86 INB: writes AL (bits 0-7). AH (bit 8+) is preserved.

TDX handle_in() with buggy mask: clears bits 0-8, then sets bits 0-8
from VMM response. AH bit 0 depends on VMM, not the guest's prior AX.

Live reproduction
-----------------

GCP c3-standard-4 Confidential VM (TDX), kernel 6.17.0-1009-gcp, 2026-03-30.

Kernel module sets AX to two values, does INB from CMOS port 0x71, checks AH:

    Test A (AX=0x0000): result AX=0x0026 AL=0x26 AH=0x00
    Test B (AX=0x0100): result AX=0x0026 AL=0x26 AH=0x00
    *** AH same in both tests (0x00) -- bit 8 from VMM, not initial AX ***
    *** GENMASK off-by-one CONFIRMED on live TDX ***

    10x test: bit8 set with AX=0x0000: 0/10
    10x test: bit8 set with AX=0x0100: 0/10
    *** Bit 8 independent of initial AX -- CONFIRMED ***

In test B, AH should be 0x01 (preserved). Instead it is 0x00 --
overwritten from VMM data. 10/10 consistent. Reproduced twice on
2026-03-30, including a fresh rerun on a new GCP TDX VM.

Additional live write-side confirmation
---------------------------------------

Separate raw-asm kernel modules confirmed the write-side primitive
reaches the outbound sink for all widths:

    [outb] before outb A = 0x005a
    [outb] before outb B = 0x015a
    [outw] before outw A = 0x00008086
    [outw] before outw B = 0x00018086
    [outl] before outl A = 0x0000000012378086
    [outl] before outl B = 0x0000000112378086

For correct emulation, only the intended-width values should be
exposed to the VMM: 0x5a / 0x8086 / 0x12378086. With the current
handle_out() mask, the paired local payload simulator gives:

    outb: 0x05a vs 0x15a
    outw: 0x08086 vs 0x18086
    outl: 0x012378086 vs 0x112378086

This is not a host-side capture on a controllable TDX VMM, so I am not
treating it as a full confidentiality exploit. It does strengthen the
claim that the extra-bit write-side primitive is real on live TDX for
outb, outw, and outl.

Secondary issue: missing zero-extension for INL
------------------------------------------------

Separately, handle_in() does not zero-extend bits 32-63 of RAX for
size=4 (INL). On native x86-64, INL writes EAX which zero-extends to
RAX (Intel SDM Vol. 1, 3.4.1.1). handle_in() preserves bits above the
mask instead.

handle_mmio() in the same file handles this correctly:

    case INSN_MMIO_READ:
        /* Zero-extend for 32-bit operation */
        extend_size = size == 4 ? sizeof(*reg) : 0;

read_msr() also does it correctly:

    regs->ax = lower_32_bits(args.r11);

handle_in() has no equivalent. Same compiler truncation caveat applies
-- no known practical impact via standard inl() callers.

A separate raw-asm kernel module reproduced this on the same GCP TDX
kernel. Preloading RAX=0xDEADBEEF00000000 before INL 0xCFC produced
RAX=0xDEADBEEE12378086, and preloading RAX=0x1234567800000000 produced
RAX=0x1234567812378086. Bits 33-63 remain stale from pre-INL RAX; bit
32 reflects VMM-controlled data; lower 32 bits contain the expected
PCI config data.

Fix
---

In both handle_in() and handle_out(), change:

    u64 mask = GENMASK(BITS_PER_BYTE * size, 0);

to:

    u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);

Reproduction modules available on request: portio_test.c (read-side
INB), portio_pure_out_test.c / portio_pure_outw_test.c (write-side),
portio_zeroext_test.c (INL zero-extension).

    Tested on: GCP c3-standard-4 Confidential VM (TDX)
    Kernel:    6.17.0-1009-gcp (Ubuntu 24.04)

Borys Tsyrulnikov
