Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DEE22D7A1
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766546; cv=none; b=kBR1LXxz+UC71AjjMLfbA41UTrwHcsgL/xxr3rSJ3YI3yTGeSIsZfFwVQkIZVYbcPnZ6oD4Xa0zY6kslrUM6+5SKBfHT1tBKMdEA1X2xo5ZTOtmhQslOZDWBgmjH+wzIxPSzRfizzxf+Yi4674GNL1r63Sd0fvPk3KMyAFAK4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766546; c=relaxed/simple;
	bh=vmbJhWj8Aa9Pvuzo+Tr8DTU4m5eUBxBAQhIigxV0Fis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GXYYOnjWrbckXISW09ZBfDZSMEN8Xk/fzIZ+uN6G0Q0yKQDxi3x+vgEx6eb9okMrB+25g7FOACMkeI2Xcp1O9k9pdJmiI1lrY4PXC2MYKNaln5Gs1CEmtbevtlO1m6Hm+ecf1MWU9hXXUTKBaqQ6HP5sdgFUgdfCu8NUSz7N1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=biwXGZxj; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="biwXGZxj"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484f26852dso69096b3a.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784766545; x=1785371345; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZD5tBEV6w1v68pl+srm0MM99xs9srwZXavWyR6SKje8=;
        b=biwXGZxjVRO0Qj3CgBy6UXqU/fot588cn84/VBAn8sVDGA7nEtwyOTpOESiXmJz+na
         1ER0AUvgmYXiUCe/EJw3Y1c98WucxvZ1IKiNAOybtU0ZWLiSP6NLnGOCfmrlH5rOtlo/
         5GS2fd5lt9STX9IFdjZnRA07Sxf9pYWOooxRlWw9ZZlWs13e11+a4wRVoQiCiCancm80
         Z8Uq4bh/c5AKvo9eJ5h5mKyB+mtCpuk4O9ikalnRlm7SPoqi9n+cXl2Mwi4CoAVvCTJ4
         dhhR86WIuVn95oR5kMHy+ADugz966s5T9FD+KW4aJJYrKjCUCOdf4jediXhIgu0e9zeu
         IVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784766545; x=1785371345;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZD5tBEV6w1v68pl+srm0MM99xs9srwZXavWyR6SKje8=;
        b=bSEdGYJL/Hylhqzvh+OGCT2uYYy/lElwFMz/q92R4spmYOauMtjKa4d+aF5WTQox3W
         GKOloqDpdiS4fsbc7TzHMYeSABbPp32IM4ibbdW9GQxg4t4o7FN6twpDwWDQXZOWLF/9
         FSLpapSfqUBJYu5YiY9gI6PcnotD+oDrwOXVkrhKKHnvCIxQiGV7Vtzk127Tp/HGgByT
         PXDHTxl3MQ/eMVe5ikIq3uAGJ5YmKLi50myP2xl7H394tJ8sPEFvkJTCYmwNnMiOrNxn
         dQL3VnreYDLm8eaX3YyKHdkL5xGZX7MnDtgJQy0bcGsY9F0wstAkJIW+NgubVLkBTVL8
         +25g==
X-Forwarded-Encrypted: i=1; AHgh+RrR2VcaJdRUXkC1qhiJh0DvsxV7RizDjzG3tfEIWb0aWufU4Tuk3pfAbeCDUCNQL9LD160=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRz/dojZEZm0ku7NAFqWum+n+Gb2PclMcmRCbyIIbR1pTORiHi
	AYScILKi7mX/QVdHWBgjaLkGIUg/5bqZNSTmi1BrdYqOyFMkK2oICpG+l8Th77yULt/J5vqr09O
	f75mbsA==
X-Received: from pfbfc30.prod.google.com ([2002:a05:6a00:2e1e:b0:845:f28c:430e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1802:b0:845:d274:c021
 with SMTP id d2e1a72fcca58-84e2bbb39f6mr1139713b3a.58.1784766544415; Wed, 22
 Jul 2026 17:29:04 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:29:03 -0700
In-Reply-To: <20260616004155.1435766-7-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-7-yosry@kernel.org>
Message-ID: <amFgT4pmhypNtgk-@google.com>
Subject: Re: [RFC PATCH v2 06/25] KVM: SVM: Fallback to flush everything if
 FLUSHBYASID is not available
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Yosry Ahmed wrote:
> Currently, if FLUSHBYASID is not available when performing a TLB flush,
> the fallback is decrementing the ASID generation to trigger allocating a
> new ASID. In preparation for using a static ASID per vCPU (like VMX),
> just fallback to flushing everything if FLUSHBYASID is not available.
> This is probably worse from a performance perspective, but FLUSHBYASID
> has been around for ~15 years and it's not worth carrying the
> complexity.
> 
> The fallback logic is moved within vmcb_set_flush_asid(), as more

Phrase this as a command, not a description, i.e. "Move the fallback logic into
blah blah blah...".

> callers will be added and will need the fallback as well. The only other
> current caller is from SEV code, and no CPUs support SEV but not
> FLUSHBYASID (at least according to AI).
