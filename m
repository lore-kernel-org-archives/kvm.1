Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782D3A7F61
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969285; cv=none; b=YIuEsBXbJmO83Ri2I9LRMC33rZAhs20F0ZQPnvH5T05ATTnMVYW9al1UrkdW2s/9FX6nvuvhcrgJkRGcQtE1t7OB1aC3KCuxsrkjmKVCquBMyV+IX0IQODwX0XlGLw3y6ByZaxWXOLqBOdpsLyJr42NQsIGB7FfGSfRo8ySjEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969285; c=relaxed/simple;
	bh=NVz1Kr0qE63FsLDj/oNYi6IFrc3n87HfsCTK8W+L2s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mm5XTTZZ1I3xzvKh+PA6JMOdWCN7pxKCiMqKxML704Xaw6L7fYNfAjWFFfoIOHPt9aQ0/LT3SIS7HGF3V06XL4CrUmOzkOIOeoyQSo334bI0PGTtOpz6aNR3arbNYVRh7N6boEClR5tnS964oWOz+FegmstamL3DUByI3QsyFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YiDJXxhP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YiDJXxhP"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f460260cfso7257819b3a.2
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776969283; x=1777574083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NxrUD6qTbjo1W4xW1U0cuK75GKmXClrYS1Ro/7xiFY0=;
        b=YiDJXxhPYrshviUP7JDrUhpRf2Iu8pGuAWAyahKE6RK21ipm6cMY6RzUVRAcB1KwUm
         71bQbsxTAV3aaVn36Atiwui8omAYB91ggnDqjBSDY0DHVlXWLVCKFGSPrSzKQiCr5hfX
         HmvHAw3tnW/iokd1yaesKerx2WLB/aqG9GdOQJmmULulVjmaDENoUIHD22oYkfWqXw7T
         Uos8GDlqyFb5enZXDsazQ6yiqQ3TfUptuUHbfxIewSnp8Idlrej57AgFXdZuCt0lTVPD
         zj0LgnL69fTnuT8WsZ0pNaLLnrp1bjIsrAKBpEnFxH6zaoDVN9CKH+XewBtP0TuE4khd
         j7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969283; x=1777574083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxrUD6qTbjo1W4xW1U0cuK75GKmXClrYS1Ro/7xiFY0=;
        b=Gndkuxp36WXy1NqI76lwzHSLiIlqDp98sKrBSOXgCZw3YpOUtXNe8TCqwInrw/8Yev
         39c8qMQ9yvzdqvmvKyVjZZ2akp39hfa4yigfGtsVR7k5C18KC/LK1bQwKito15YuTjrW
         10VsxtiVyrRx1ExmzBwdMyien7GfBlNp0PK2IHeEQgtNHCMcA9Svnix8dFM6LjB/ZzY8
         oqQM8pRol91ekX2OmV43u6oUPbU2YCiZkZN4wTJJShmfRwG3cQC2MOzJujWWmYw6EocJ
         vLyU+de7kKB6kT6PFEHes62Lj4z6/wapAs3PHj4C3rxHhXkm0fo9tw6QF/uA3tHTpS+A
         IN6Q==
X-Gm-Message-State: AOJu0Yy997dwy5Bqo/kIG7vRLnxpcKMxYPRnYkkyOqM4TfzKp8/dkNIy
	QnfWe/seILnHV8cy/M8QzGOM/9eps4EfOGLIj1wypQecIcmhPmm0sEiub+AffD5HYlHU3Zpeg+D
	rPx3gQw==
X-Received: from pfbif1.prod.google.com ([2002:a05:6a00:8b01:b0:82f:a396:2229])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d16:b0:82a:79b8:2049
 with SMTP id d2e1a72fcca58-82f8c8c2a97mr30979563b3a.25.1776969282975; Thu, 23
 Apr 2026 11:34:42 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:34:39 -0700
In-Reply-To: <20260420212004.3938325-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420212004.3938325-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <177696924512.540717.6991894985950292004.b4-ty@google.com>
Subject: Re: [PATCH v3 00/19] KVM: selftests: Use kernel-style integer and
 g[vp]a_t types
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 20 Apr 2026 14:19:45 -0700, Sean Christopherson wrote:
> David's series to renames types across all KVM selftests.  I'm going to apply
> this ~now in order to get it into -next ASAP.  Unless someone screams in the
> next few days, I'm going to send a pull request on Thursday, with the goal of
> getting this into -rc1 so that all architectures (and developers) can use the
> new types straightaway.
> 
> Fully tested on x86, and I verified a handful of tests generate identical
> code.  I tried to do the same for other architectures, but gcc at least doesn't
> seem to provide reproducible builds for other architectures.  E.g. on arm64 and
> LoongArch, a completely benign vaddr_t => gva_t rename would sometimes result
> in different offsets in the generated code.  But based on manual diffs from
> objdump, I'm fairly confident in the result.
> 
> [...]

Applied to kvm-x86 selftests_kernel_types (a few days ago, spaced on sending
"thanks").

[01/19] KVM: selftests: Use gva_t instead of vm_vaddr_t
        https://github.com/kvm-x86/linux/commit/5567fc9dcd7e
[02/19] KVM: selftests: Use gpa_t instead of vm_paddr_t
        https://github.com/kvm-x86/linux/commit/97dcda3fdce5
[03/19] KVM: selftests: Use gpa_t for GPAs in Hyper-V selftests
        https://github.com/kvm-x86/linux/commit/6d3494255ac0
[04/19] KVM: selftests: Use u64 instead of uint64_t
        https://github.com/kvm-x86/linux/commit/26f8453288d4
[05/19] KVM: selftests: Use s64 instead of int64_t
        https://github.com/kvm-x86/linux/commit/286e8903aed1
[06/19] KVM: selftests: Use u32 instead of uint32_t
        https://github.com/kvm-x86/linux/commit/0c3a8774692a
[07/19] KVM: selftests: Use s32 instead of int32_t
        https://github.com/kvm-x86/linux/commit/7b609187684d
[08/19] KVM: selftests: Use u16 instead of uint16_t
        https://github.com/kvm-x86/linux/commit/19d091492004
[09/19] KVM: selftests: Use s16 instead of int16_t
        https://github.com/kvm-x86/linux/commit/2540ebd60349
[10/19] KVM: selftests: Use u8 instead of uint8_t
        https://github.com/kvm-x86/linux/commit/6ec982b5a2c7
[11/19] KVM: selftests: Drop "vaddr_" from APIs that allocate memory for a given VM
        https://github.com/kvm-x86/linux/commit/85819fa0e3b9
[12/19] KVM: selftests: Rename vm_vaddr_unused_gap() => vm_unused_gva_gap()
        https://github.com/kvm-x86/linux/commit/48321f609a73
[13/19] KVM: selftests: Rename vm_vaddr_populate_bitmap() => vm_populate_gva_bitmap()
        https://github.com/kvm-x86/linux/commit/3fd995905b71
[14/19] KVM: selftests: Rename translate_to_host_paddr() => translate_hva_to_hpa()
        https://github.com/kvm-x86/linux/commit/4babae4ca10a
[15/19] KVM: selftests: Clarify that arm64's inject_uer() takes a host PA, not a guest PA
        https://github.com/kvm-x86/linux/commit/a662c4e03853
[16/19] KVM: selftests: Replace "vaddr" with "gva" throughout
        https://github.com/kvm-x86/linux/commit/014dfb7b9bf3
[17/19] KVM: selftests: Replace "u64 gpa" with "gpa_t" throughout
        https://github.com/kvm-x86/linux/commit/df079910f981
[18/19] KVM: selftests: Replace "u64 nested_paddr" with "gpa_t l2_gpa"
        https://github.com/kvm-x86/linux/commit/abc374191dc2
[19/19] KVM: selftests: Replace "paddr" with "gpa" throughout
        https://github.com/kvm-x86/linux/commit/dfd2a8b07c6c

--
https://github.com/kvm-x86/linux/tree/next
