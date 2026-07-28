Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF730BB94
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252954; cv=pass; b=aFL044mJwwf4ubNsWbdBfuh8Ctn8xMIaBy475Vc1PLY8oShmkYPAJu5eibsAM9ohrE163xzVeQPIbqtj6wRib5of+5MnsG/0bNj2yiCySlR9/NYe5lWeEXcAHvhDBWP/LjD5NtHqZisJSP5n4pU5YyjfUHb0zTvnwE5EJiNiTpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252954; c=relaxed/simple;
	bh=AViFMS0ewOoq1cL1NaPq6qKbymiWEx2DbacEkdjRd2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHMSk+U/+5+Ru1ZmECocUvSLlHCerLyfOpF9QAlH23/QfxINq4z5IDqbUvaStkUzK/hL6izN4tMth0UIPvUFALViW2PJfh6/cf6GLVSthP3OIaLMExrhEXNRJKnVErYkwYd/cg7ZjQFmCucM9pPRC+7gkd6JpxJJ43HkTKUw018=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=TaIZ5FYO; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="TaIZ5FYO"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f707e5d75so8625f8f.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 08:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252951; cv=none;
        d=google.com; s=arc-20260327;
        b=LYEL8Mn9I6E+J3e4qhJP1H63+nMmTw7YDzmP/e8QXv4w/z91KHV+vP3q31wr4uBzG5
         zhwWWLWa3Hej6SIEGEptXBDWJ0f3F3KQZmkyn6GvGEGnPPK1lO/u8CKNlzPOQQfPRB5T
         9XoD8aahRskrEFrS4sn2SeBKciHZDvegdplxRK5ukcbsPhxbPeHJ1pv/p2JbIMCISMa2
         fYJ25jAy3AeYkpVlHkzFJjcCsfFmtjovIJl7yMcfccqGuCvYUxpi8MDcsorycEXOYSRi
         aTezwO2gJjwGEE1Zw3DEIdSUO6+4WQ2ey7hswQorvFNUDlnwR2nN4Y/0oCNZr2hfjfZH
         pJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AViFMS0ewOoq1cL1NaPq6qKbymiWEx2DbacEkdjRd2Q=;
        fh=ShGBO0rP6bCT9mW56AUAmJTJdmeq3X9dQ3oJQg+Zwv0=;
        b=GyLTF06xzi5mdFY+Y/EuIk25pr8e3C/gsmsemKux23mdY2H6w08VJScLPAY1ueQzS9
         B72c71bYXFr7uWi8gHKJVse15fTf2U629liYb+gIkR8gV8/9enizvD8P/SfLpZxe51XR
         Ql7WdR93BSLsnkrSXG7DiDXcq82rDCqqQNU4jtk5FnEAM+A+c8ie2FtjT20qGBbY2H/6
         5NxCZnC9y8jEXEYNRb72SW+dpe0bqlTj0psucP/9ROABSliehZ9aCsMD8ud3JEPXriyq
         HjtNgwhfEM0/eoq3JdG0x+QXpTh6WortbuLEArPDJ1tmqwB11PJXmRMcGWGNCVMgptYg
         6cFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785252951; x=1785857751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AViFMS0ewOoq1cL1NaPq6qKbymiWEx2DbacEkdjRd2Q=;
        b=TaIZ5FYOP7kjMD2spjN8nKTndgTz1qrXF1ZGBikX4GyEsQAT196z/5lwckOrsPcCwa
         Qe3m8PiqUSlIUcfGRaspD4sB/Eavw5StqqZSNr+EoSqM/r2G4Y3nMfVVMhLB0eZozKfV
         TkC92HzgUYiUas0ToiPwfJ7CRgqompG3XR5HpBD+0YiQtxrG21yxZfcsPzX1tM+jWm6t
         3MYNXL2GQn/RjXY82x0HVIC/RWxpmfTPRITLkz0qrgV32+XTR+cfJQ+gPRN6n9aFmiSv
         0IQ5giFYQaF9EdkBZxXewoLWqhBOHwqAbv1CXrb7Qib2/jPzYtemGo+Sc8NiXBgRBhbA
         VnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785252951; x=1785857751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AViFMS0ewOoq1cL1NaPq6qKbymiWEx2DbacEkdjRd2Q=;
        b=r3PE+WJde5nhd8y8Rm0PWHrwKAUgbaVAlKNujx13+5o7ZEtJ8bmAzqZ0qaABTjjMuW
         3AWT/RA0OLQxulfKTMc/Y9iOGCHvJj8rZvVr9zTkLEvV/KRFtyo4bWaiJNSVxAdSOkDg
         wAb+w8IJhZEBZsvIMzSqzU4MGRqk3PsVYIpdHAqTxNcHVNb4BbrLSx7raD/fekj7esAZ
         md8Gq/sn9/rVmwtL99acejE4p+CqR/wdbCOj7O5MFocNIm/aGts3R/iUaCF19d2z2YYB
         svjighJJDXQBsgYAKWqpmW+eLUR5KE7he+yGzixbJtpcm7NRqsXNrExKLu0EhnE7vPV+
         wGWA==
X-Forwarded-Encrypted: i=1; AHgh+RrcBv7UuGHbG4kSyx6RDOyiC8Ww4rNkdeFGNpXoZIf9FuFckH9C3hLXg9ByfY0w8W4AcM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMbwo8SMIkbpWxUGJDkcvU+AWhlkBns81MEmUGUVOogWYCt04
	l2DsfSoXw8TIlN6ghW5WrEtSBqfERZ2iV9Pdr5j2NYXgyoQ4voQ9nmWiXf4jND+MMrmFyx5wzJU
	aGY/8lFCNveBE1RNjanDYQq13VQNjlKcTOdbt/j92Nw==
X-Gm-Gg: AR+sD139I8nLZvoSEbUoDA8mxnJwQQB3voI7fpEx+KxCNRzWv+ACfKWc2Z5y62jF34W
	wFuEf4oKPpONaxiFZ1jKCJUzJ8WTUncpD3DqjKy376fx7KH7ndV1afRUvEz1xFPQ/e3bjvKbM8N
	vYKDvO2vXDG5ODdRPaCpSpauqxxyAkzYg8rrA48dMTpx6iappi09Qx6Q/ori8xKeKmvT70gQRhV
	1nHGV6xeLZd/4EQVZDYBK4q4yEoJlhr9aBWAV+U3K+vGZJH6woUpoo/rYyVm3o5VpvH7PK53Rl+
	Cun7nfzxP2qZjOufo3fLpucl7Z7nkZ2UvfJ4FNcTkxYKkqP30GmAUUZqV0ihWuTGq4MbyqTxyMT
	UauNP
X-Received: by 2002:a05:6000:606:b0:47f:2634:b5a with SMTP id
 ffacd0b85a97d-47fb1ea7d51mr3223821f8f.33.1785252951217; Tue, 28 Jul 2026
 08:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626103619.174179-1-yhchen312@gmail.com>
In-Reply-To: <20260626103619.174179-1-yhchen312@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 28 Jul 2026 21:05:39 +0530
X-Gm-Features: AUfX_mxshNrjU_4DhTQT2LcNdq_XRUYgd4f2QGjF33GZ2jYUBKW7SoamrV0OVuE
Message-ID: <CAAhSdy2Qa2DGFzb27MgmoH5Pf1BOrgwaZBqP__U9eejs5-5Bsw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Add arch-specific tracepoints
To: "Yuhang.chen" <yhchen312@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Quan Zhou <zhouquan@iscas.ac.cn>, "bingyu . xian" <shanbeenyoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 4:07=E2=80=AFPM Yuhang.chen <yhchen312@gmail.com> w=
rote:
>
> Add RISC-V KVM tracepoints for events that are useful when debugging
> guest exits and in-kernel emulation paths. The existing kvm_entry and
> kvm_exit tracepoints are kept, with the kvm_entry PC format fixed to use
> zero-padded hexadecimal output.
>
> The newly added tracepoints cover:
>
> * kvm_guest_fault for G-stage page faults
> * kvm_irq_line for userspace IRQ injection
> * kvm_mmio_emulate for MMIO load/store emulation
> * kvm_timer_update_irq for VS timer interrupt updates
> * kvm_wait_riscv for trapped WFI/WRS instructions
> * kvm_sbi_ecall for SBI ecalls
> * kvm_csr_access for CSR emulation

Drop kvm_guest_fault, kvm_sbi_ecall, kvm_wait_riscv, and
kvm_csr_access tracepoints. Instead add common
kvm_vcpu_exit tracepoint for all vcpu exits just before the
switch case in kvm_riscv_vcpu_exit() function.

Drop the kvm_irq_line and kvm_timer_update_irq tracepoints.
Instead add common kvm_vcpu_irq tracepoint called from
kvm_riscv_vcpu_set/unset_interrupt() function.

The kvm_mmio_emulate tracepoint is fine.

Regards,
Anup
