Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB13D0900
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215182; cv=none; b=XHEO9FldO653Xk3KU8NbZeaPZYL3XpoqOz6jqKOWj+dkEpR4EEAPHYxx4Xs1f3HG90EQAH9j2Cat/xlk6Su1VULGQQajZhp0Up0oF9n6wiQGeFkCFmyE8QEPj+7SjhllSrvDqWzdAdF1mVlRabqK/c7InOBOCru/xXnK9LbQ3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215182; c=relaxed/simple;
	bh=/j4i5uRM9CfDoimZAimFxAHLg+HtSls+D9mWuiA2GSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pxc7ToWFggQ3I/8ZfTaiXbLZc2s0a104nHmj5t3mYBxJ1fZ1dea7BwYpl2pYejUjWGMfCa40IjELwaCh+n4CkiEoDYqpMowBKHuCZ05+P8ewDW/JGtn6q8vNsub6WMcHEppjoSgtKT72R6m/QQtLD7rick7C5fVpy4S+WyQdQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=algjO7LK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="algjO7LK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b9318997so38055385e9.2
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782215180; x=1782819980; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+RzNiQK0pXiSgFzNYp0CdnQlJdQX5A5EGONITWSYq0=;
        b=algjO7LKcgPhVrrqqxqz1bJ7fWz8dFwLDCIupa46Oe0pLfokXYKfqVJcfc/cE7Ja8f
         0mDAApCo58Zt+L2lOC5XElCqG5TA4DiN7Av5DSk1n4w94eMNzOhC8qY6jyZ8oOokJuCy
         mqnlnV3TdYM8QSVOQgROVUGDpEd51WrLJ/2JxkMuOeBJ+zgPb1V9J5dqQOVkelsCqZ8R
         d1O9z73U71E0Bdb2IWk7q2bxqOlmKfAY0gzHGxUkItX86wbsqMPC4ykyCd6CIPAY3+W7
         qE1NoJLqB9hUrKjo8duWZUQ8BDTSlLw84qlRNKYNpJeQp8mNRIJ0evODjC0MXVJgLth4
         lTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782215180; x=1782819980;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+RzNiQK0pXiSgFzNYp0CdnQlJdQX5A5EGONITWSYq0=;
        b=tBj03ze6dLYlhxlBEsCzJqGSQWKNtRU0sDscYE8vVu/+G5RyGbQvOMRL7nXDIRe+M/
         mkvlonKAm2KfxkeQbvv7H70CUNKsSfQA9b5oN61tCSJwMsjxSkYbSFazoy2XKA20IJCm
         fLiIEZL2s/vuO8zPkS01NyTjS5NLPXH2HQeItYyn9gXwjUXlrYR5OKg+iLzBJ4d7q+5t
         k5gaVxPwXy7ivKzXvDj1cUmaO6JJzjfZZs1UTBkWwMZzLjvaap6fXSWpSEf7hIRaUU3u
         9v2FaWaDm7Q9bSmIrSPrBhM+3WoldYIbwnHvPt2z4lYRRxttKi0nE17qRqG//ekJ0pSU
         DSKw==
X-Forwarded-Encrypted: i=1; AFNElJ/t0bNk/lrpq5kUmatkNYriKM3a1/jsWdbydbRVZ4uo4CO4pkXtrAYj5XCiSr8UkvPtngs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cwq2RFnnc32jmDd5Xao9z6QY+FbYvVxx6dYA2shkCuyuwl39
	GtuOBP0BJdFw60D+8Dp1NiVHDSERrk5HXvf3eRBHtjXwTLteU8wCID2p
X-Gm-Gg: AfdE7cknWAsjdiuffv2y9bHcAgtrvDowa8SewdfLAOHF2vimS/shYQ0D/fxnM0b9Dzk
	G0Vb2MyM862FDT8d9RDdEkEaY25wE6XtB5xKJxgG37REQQjWSXLwAm5B4it5BM5wfJlKd6NaFGK
	7JkUQ6lD81jwOfI+PIKirI1TpsQGkdo591yyJk+8qp320gYU93DJ525TM29XPZia6ZCYxx/Ng/A
	BIhSVEmJkxXfSp+4u/D+o7ym2zeLkEOA8RA0xaPF+h4Jsqyg2ZNFcuoiVLaepKIfLP21Tr/x7ne
	5xnC1lGjfWAkmu3cM8/GYuy5cdCZR7ET8ZlKNzp2T3F/s5d1LuuAgU27lCeJDbpe2zmUxxpzv95
	aj10a4tdfPZe2Og6AjKQf0ZH+NqHVkiEET1Ne6IMsmrPCr4oNtGUNvOCwObDJimQI7UR9CmB/Tw
	eVFGUKw5+UcAAqz+v/20OC3jm8+odd3SboFbFn
X-Received: by 2002:a05:600c:68d3:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4925b3bbac7mr25901405e9.33.1782215179473;
        Tue, 23 Jun 2026 04:46:19 -0700 (PDT)
Received: from build-server.lab.ber ([62.96.37.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7ba08sm370719855e9.11.2026.06.23.04.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:46:18 -0700 (PDT)
From: Mikhail Malyshev <mike.malyshev@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] KVM: x86/mmu: Emulate, don't kill the VM, on access
 to a disabled passthrough BAR
Date: Tue, 23 Jun 2026 11:46:18 +0000
Message-ID: <178221517808.3589966.15538835749975810737@gmail.com>
In-Reply-To: <ajnEAkFGyJWmomhq@google.com>
References: <20260621133708.3454718-1-mike.malyshev@gmail.com>
 <20260621133708.3454718-2-mike.malyshev@gmail.com>
 <ajnEAkFGyJWmomhq@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Jun 22, 2026, Sean Christopherson wrote:
> I really don't like this.  It's an ABI change that affects years of precedent,
> and the ABI it creates is very haphazard.  E.g. why should PFNMAP memory get
> emulate MMIO semantics for this case?  And a PROT_NONE VMA really shouldn't get
> MMIO semantics either.
>
> I would rather have KVM exit to userspace with KVM_EXIT_MEMORY_FAULT and fill
> run->memory_fault, i.e.

Agreed, thanks - that's the right layer, and the PROT_NONE case alone is reason
enough not to overload the pfn classification the way I did.

For context on v1's shape: localizing the fix in KVM was a deliberate scoping
choice - it was the smallest change that stopped the crash without updating
another major component (the VMM) at the same time. I agree that optimizing for
a single-component change put the policy in the wrong layer; KVM reporting
KVM_EXIT_MEMORY_FAULT and the VMM applying device semantics is the right split.

Plan: implement your suggestion (kvm_mmu_prepare_memory_fault_exit() in
kvm_handle_error_pfn()) and pair it with a QEMU change that recognizes a
memory-fault on a vfio-pci BAR whose memory space is currently disabled and
emulates it as an Unsupported Request (reads all ones, writes dropped) rather
than aborting. Note QEMU's current KVM_EXIT_MEMORY_FAULT handling only covers
guest_memfd shared/private conversion, so this is new vfio-pci handling on the
VMM side - I'll test the kernel + QEMU pair against the reproducer before
sending v2.

FWIW this is the concrete user the 2024 KVM_CAP_MEMORY_FAULT_INFO work
(Zr-8M9rYplgN6IS3) was missing: an assigned Intel iGPU whose guest driver clears
PCI_COMMAND.MEM on one vCPU while another is mid-MMIO to the BAR, which kills the
VM. Reproducible on demand and seen in the field.

Two questions before I respin:

- Prefer I revive Anish's x86 patch from that series (rebased), or a fresh
  minimal change against kvm-x86/next? The tree has moved a lot since 2024
  (kvm_follow_pfn, etc.), so I was leaning fresh with a Link: to the original
  and Suggested-by: you.
- You'd asked for KVM_BUG_ON() + -EIO conversions on that x86 patch - still want
  those folded in, and should this stay x86-only or also cover arm64?

Thanks,
Mike
