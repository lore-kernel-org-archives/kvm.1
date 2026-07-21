Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB004779B3
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628592; cv=pass; b=iqVFXHgymswFNqy5CA7y6HCkf0qM4QepM2iAnoZT28cNVpHWdGaMV4uPtilMF4/NzFkWtQ7WA9asygszbBiYOoTigZIBXIa7iaSZyMFEWal30CDVqOKAL/T/+DjQaJRhrmmqTn8IgbaVePEcplToMBySb4SZFYz8lflpF124Yf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628592; c=relaxed/simple;
	bh=RQEOUv8I8jho1fGK7SS8uVLJdmCgeFOBbwZ9fu8hVC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/DhinBwukLDuOKqczBpUAruQ1CEz/pxVOkE8XErZTK8w1EO14CCIfG1pHSNeFXEQ4qst+00s+g6WS1sQLoOlLHU3IyoJ+SIeJ6fNVIalQ2LCLghNnebaNqYNDb3w1zf6SdHq26O7em4Je2vyF9i4y0iuTudzrl0P37TQz/jbKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXliC+v9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCPVyLBX; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXliC+v9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCPVyLBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784628587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/LcZsIYEi/WvQwQWFUmWBxrZuJIg8BbyzJ3Kz0eMgA=;
	b=IXliC+v94xNxulHrS/n1zW3ANivXNXwoyX9sge+ZzGFpwv2ssadCbb+IGRs3SH6UgMkU48
	lRGQtSCNz0t2iNtQhQvD8TLFCMfIe5ou5wiYAtJk+Zq7+LIB6UqRne/Cst1ulrUH+QLMVm
	HpYjSClaphujiDyqfZemjGvLOXj5/C8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-URq_2ZGiN8ayPaqbRrC42g-1; Tue, 21 Jul 2026 06:09:45 -0400
X-MC-Unique: URq_2ZGiN8ayPaqbRrC42g-1
X-Mimecast-MFC-AGG-ID: URq_2ZGiN8ayPaqbRrC42g_1784628584
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6db77430so2064286f8f.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 03:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784628584; cv=none;
        d=google.com; s=arc-20260327;
        b=cRuIN+dS6qzQUdUOLOyrL4PK9vvzmdt2v0ImPQGE9Z6vQcoZXG2kHB4ApbGI3/Y6zE
         Q9J54S7DhR8/i2oV8WHuL+5aA0a7oFPuVHYHgJIuNZjSaO27E/HQ9/x+ILzjlF12xS/D
         Q0kJvr4txZHHSgarSs1QVsVk3tGyVAojT1Payya49EGFUj3eIvXnld6w1Q9+57uEXr1B
         Bqo/Gmt0oEEfTnMDp/eRThduyvAj2uSmpdOkbbdHwBACi7nHaqv3wKxNsFeDAmmaIszi
         DgCmNWVZ6AzImlVL1thtJ1objpnvGUEaqBkYKJXnfLShTBcnkxs2S2Wd4anelg8U/Bb3
         e1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X/LcZsIYEi/WvQwQWFUmWBxrZuJIg8BbyzJ3Kz0eMgA=;
        fh=a9+0jTHs9k40hyzEDs8Mi4SNk1cxZKaoPdH3XrKY+Hg=;
        b=jP10a5GA/ymReQA/xCj15AVwJzu7iEv6PFA5JzWxwNp4QPox/E3oNi3tOl4W8QAWlv
         YJmYNn5/iod4ZrIFy/JY2vbS7PJdP3TsOy7Fbdioty1v3B+vZDrX4ylEC8Lt7GA9CEfj
         cBr7lTzfOzL+E+IM9sUm2isLf4FKsyJ8mLRbAKRTEwY3vGiJpG1qEYkPec0StRcubCLT
         r3JGo9aYCCeoFRsBE+NpSI0wtc8vKxH0gOqwmhVpnjBe01+I7R1m0fLON7c/6/rKrSgt
         9EXJ1+AaZUFL/z9DJ7rnhECu04flSIt5/kM7lY0XejimkX4T9BnpzcpUbOormCi++2//
         nRHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784628584; x=1785233384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X/LcZsIYEi/WvQwQWFUmWBxrZuJIg8BbyzJ3Kz0eMgA=;
        b=NCPVyLBXyZ+syIXy+VJeeqAyRTTQqspaSZyscLnVPnzeIlcEfKsKutwHDGd05Od16w
         T62QzrysTpurOcI8tFEvdyxo1t/QvJ5Po2b7Shrxm5K2oKTwwSqNVoxJAgQ36ZIRqF0k
         /Yabicxh/f3Tr9nAy1+Vq1XriUYkUCK0YlbJ1Sf7/oUCSLMDrAXjUY3msWCCJ4V/EzIC
         zTRF+1ff8BLOXRcT9DzRkqzAf/Ssect7uVbZwzWJYhvPuylydElEp6nHST4Q/I4ijijP
         Hk8f6AE66ABL/5YJpujyB24Msvhf5JWAGtXAL/PZmIjgBDE8T7jDmuE+Nm3mB1D7j6hr
         GJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628584; x=1785233384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X/LcZsIYEi/WvQwQWFUmWBxrZuJIg8BbyzJ3Kz0eMgA=;
        b=iA2EvpNCQ7m+2gJF084dxXLrIZM44LyXkRmMCJhqGotmO/paJEC4szUL9G1LRcODHy
         61DlaOmbQN/6NcYoNbqU+AYBYDFoZ2NZA9e7bOI++bx7SwDjvFZkLmJvs3sxiMzYhVJ3
         ehqmolfBqrJ+t9lkW4vTbvhg4FSKneLGkJ321Bwa+Vd5SDjh5Oklrf4P8SUxi25JRdXB
         H+FZD1kXHR+1XR6E2ZeYiZ6+p2Z9LCok/KwaNn6ZMRrse3SHaQpIswDFsU+IAWHBGqoQ
         jU7sap+hu+5T5E8rAi4/w42XfOqsTYzcUHzG6ApX7kUccnSHFMgVdKekRkDxTf7sauj2
         BX8A==
X-Forwarded-Encrypted: i=1; AHgh+RrAdDedxUOe98vP4iv0gcfGBgeY/625Q5aKxVQON1opOl+QcwWbLbuHMjisBx44fKjycB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDyqGMceNEBiIjBXZUkbugcEQsy66yeU49vmtdJMmXkNF3Hq0e
	PJ9ie1Iy8qqUBWkPDcuL8Jb86p0GtuPgoRz5wYaFPBsy9OPMxHa1pdrQD5SeE0nsdB6Ls8V1jpO
	A/k0AIfw2CWxKoFdkXpASlkF6NELMVN38MQy24SB7UWYT23+GzIZesREbkiRE+9ps9rfCCWiQ9Q
	QduZYM9zur1UGeMGpg2uqXb19PvcTf
X-Gm-Gg: AfdE7cmKiYxbqHPC4n69tgP6uLBpkWhXWY5+J/WCcxRyH352MmNS+nhahsR8Eh5H71h
	J8HHWYW3YVyC56avVxB8acHo/EpDCH127uOOjP2jn9F0sMNR/1Gvfn4/tYcbo/sv5k5hNK6CIHg
	FNwMU+wQurtiRTs13I6GbLySxXKUqkptE/TvHfF43J0GOhnBRSN1XfLSVcS87AL9TZ1oFir07pZ
	mzFNpI3P+napn9WEJuavNLZkgq+zs9NNaXO1koTOC1yTK7rgXumBUNtiYCU
X-Received: by 2002:a05:600c:4ed0:b0:493:c634:952 with SMTP id 5b1f17b1804b1-4954a3d0872mr196477915e9.7.1784628583631;
        Tue, 21 Jul 2026 03:09:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-4954a3d0872mr196477225e9.7.1784628582637; Tue, 21 Jul 2026
 03:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy2iT3GmYz+n_jzbQ4V_5P7UdfFhmq=BSOgYCDEQ6PPuZA@mail.gmail.com>
In-Reply-To: <CAAhSdy2iT3GmYz+n_jzbQ4V_5P7UdfFhmq=BSOgYCDEQ6PPuZA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Jul 2026 12:09:29 +0200
X-Gm-Features: AUfX_mzqp4co9SVxJ6Oxz0wZJjADoZUw52gPjsL2VGGBD-drbZ_ihcWCOMvdB5w
Message-ID: <CABgObfb5KVNVBj9bDbcW5Y0WFYvC0A33-GBoy_UKuWUMPCBQhQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv fixes for 7.2 take #1
To: Anup Patel <anup@brainfault.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	KVM General <kvm@vger.kernel.org>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 10:03=E2=80=AFAM Anup Patel <anup@brainfault.org> w=
rote:
>
> Hi Paolo,
>
> We have the following fixes for the 7.2 kernel:
> 1) Avoid redundant page-table allocations in ioremap pcache topup
> 2) Apply SBI FWFT LOCK flag only on successful set
> 3) Bound SBI PMU counter mask scan to BITS_PER_LONG
> 4) Skip TLB flush when G-stage PTE becomes valid with Svvptc
> 5) Zicbo[m|z|p] block sizes should be always present in ONE_REG
> 6) Inject instruction access fault on unmapped guest fetch
> 7) Serialize virtual interrupt pending state updates using a raw spinlock
> 8) Fix Spectre-v1 in vector register access via ONE_REG

Pulled, thanks.

Paolo

>
> Please pull.
>
> Regards,
> Anup
>
> The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074=
aa:
>
>   Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-riscv/linux.git tags/kvm-riscv-fixes-7.2-1
>
> for you to fetch changes up to 8d9c9b135b5c23de9811a8426257cbd2fa024a99:
>
>   KVM: riscv: Fix Spectre-v1 in vector register access (2026-07-15
> 18:06:16 +0530)
>
> ----------------------------------------------------------------
> KVM/riscv fixes for 7.2, take #1
>
> - Avoid redundant page-table allocations in ioremap pcache topup
> - Apply SBI FWFT LOCK flag only on successful set
> - Bound SBI PMU counter mask scan to BITS_PER_LONG
> - Skip TLB flush when G-stage PTE becomes valid with Svvptc
> - Zicbo[m|z|p] block sizes should be always present in ONE_REG
> - Inject instruction access fault on unmapped guest fetch
> - Serialize virtual interrupt pending state updates using raw spinlock
> - Fix Spectre-v1 in vector register access via ONE_REG
>
> ----------------------------------------------------------------
> Anup Patel (1):
>       RISC-V: KVM: Zicbo[m|z|p] block sizes should be always present in O=
NE_REG
>
> Dylan.Wu (1):
>       riscv: kvm: Skip TLB flush when G-stage PTE becomes valid with Svvp=
tc
>
> Fangyu Yu (1):
>       RISC-V: KVM: Avoid redundant page-table allocations in ioremap topu=
p
>
> Qingwei Hu (1):
>       RISC-V: KVM: Inject instruction access fault on unmapped guest fetc=
h
>
> SeungJu Cheon (1):
>       KVM: riscv: SBI FWFT: Apply LOCK flag only on successful set
>
> Shengwen Cheng (1):
>       KVM: riscv: PMU: Bound counter mask scan to BITS_PER_LONG
>
> Xie Bo (1):
>       RISC-V: KVM: Serialize virtual interrupt pending state updates
>
> Zongmin Zhou (1):
>       KVM: riscv: Fix Spectre-v1 in vector register access
>
>  arch/riscv/include/asm/kvm_host.h | 10 +++---
>  arch/riscv/kvm/aia.c              | 35 ++++++++++++++++----
>  arch/riscv/kvm/gstage.c           |  6 +++-
>  arch/riscv/kvm/mmu.c              |  3 +-
>  arch/riscv/kvm/vcpu.c             | 68 +++++++++++++++++++++++++++------=
------
>  arch/riscv/kvm/vcpu_exit.c        | 19 +++++++++++
>  arch/riscv/kvm/vcpu_onereg.c      | 46 +++++++-------------------
>  arch/riscv/kvm/vcpu_pmu.c         |  4 +--
>  arch/riscv/kvm/vcpu_sbi_fwft.c    |  6 ++--
>  arch/riscv/kvm/vcpu_vector.c      | 14 ++++++--
>  10 files changed, 137 insertions(+), 74 deletions(-)
>

