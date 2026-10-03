Received: from mail-dy2-f39.google.com (mail-dy2-f39.google.com [74.125.229.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832711B4138
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791171821; cv=none; b=rN/0924UFHLVpq/9d1DOM6NNsy0JVJHSmNK93xCY1FkkRlNOcZWcQUtvIhw3w1VG/atWES3ggWWQ9JOdBZaja1M06ejtgWKI8OgrQgDWNR12lO4O3DEt3/7lbiZ1S1K4nbqAcdhS0i2I+8wF+gZeTzg99WJW7eaoKW1rUlEGJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791171821; c=relaxed/simple;
	bh=kLBUT6vlOnJkls8hhLvjNyrBIlLdYaeftYindRKhgaA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=g8KHvTB5rxkX1ZdwnSbGi+qSmXmUBlJPqvL+YVw7xzSIOkmszjTaWO8CEVe75zNQ6IofM/B3QaJL9GbUs8pCkjNFNmJjp+r15rNvlp/UXj7sc0Y1SlfBMdCYguT3Z0IMd2Vgbc/HFVHhpgf2kYyvB6hIrNWebp+yCTN2CypQU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR42R7j1; arc=none smtp.client-ip=74.125.229.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR42R7j1"
Received: by mail-dy2-f39.google.com with SMTP id 5a478bee46e88-34b3a9cd8edso591068eec.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 20:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791171819; x=1791776619; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M3GmJfAIymRvAtsrt3eqOBHmB18YZ66xoxLnv39f0iU=;
        b=lR42R7j1VVdY1DnH2shetr7+ZOrrKXL0yQi/LZc5yZM2WUVeV9l1vsT+lYzByhOEKX
         HZk/tnMWWqVagknHqpCsGl578XhygdEOR+JxuZDwoXa4BlsVe5BoE9FQsdWbJhMlwmr9
         7WnigxdfDwAYXJ7XisQUK0VId9dxwzcQNdAC4343AQO5CFmbFUohLrN2vIhTRubLyAjS
         29jSHYaAevvvppx8gw50dDEUfNup2/Vm8/BklxM8j+GMyIOK6WPR8oiKDii7VoGLnraS
         UdlGEewwK+taMn+8QClxAxjF8jdEM1z4eUeehjvrfuzOwWqexjM8/s/WLOZ9tLWwEJay
         Jxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791171819; x=1791776619;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3GmJfAIymRvAtsrt3eqOBHmB18YZ66xoxLnv39f0iU=;
        b=T7uHDoqSXhljURuiRcehSqpvsaU3cHM50veztuuzU0mnBt4hpM54yxcObjlQhW0KTp
         /ZENQOFTRuPovqtH6S0SelMuJ/L4D24N3GfKYCvP5o8z4U0xP6YGi/5IGJ+sxsKDxUVY
         ynWEJszpOKNDxCdDPkTv1oxmkQ/pUjPjxbGK4Xn0GQUjN+NBYQArYlxYXmdX3MbRaKUa
         7KSSSU74B/7S1TuOVff5GhZ9WFaWnvS6Mv1vrn21ogS3BiVlUq4gn6I4BfhQAxC+xPP7
         lEPfZhdOp+jNmrQ6i2L2reukwFbtHzgvJ3/W3HC/nNDzuBw6SyApH0dS/1gRwCtIQzT5
         VVcQ==
X-Gm-Message-State: AFq9FYLoNBGEQ5Ho6OBE+jDPBCSLxawfrvo/fTD+2pDqx/jjhpRbUcma
	o85b8q1nNaqQfwut71IF4CqDrtjk4Ek2G5OviSje5YsEEDIva+Y2UrfnHwNdtQ==
X-Gm-Gg: AYBFou1bN9FRPHeDEwITrTLh+EeRpQOG3cK0JR3RpjoYwgrelZphW5PxgSoz3SMNvOS
	sfChteRw/yfdfUnVKeDOMqCG2B/GyVVgpsNoVVQhM1NW/etkZLT8/RrOg3ZGe0Ux2099gT5I/xq
	xIrm/HaqavB2QfZ5idBzX4KZ6+APRlBn4J63p8jmxyWVsWnXarViYvmblZmojZI6G2+ljMKOlh0
	WpJxm+1mhvy8iqn6d9uho94FJ0iR5QPbJTkGgF387p/qeWZ9LFAY3SKCSSPRZALfCGln8tNwjMw
	GhWnnQd+ErfjM2Av6hy1wQSA4dGkjEfhDE/i5NnzZqb4NSBLSoz0qNXJE2Q82sqTOQmVhRxM47y
	wS6MHm3RtR6nqHGiBlNdqdu/egVh56zNHsZlJKUq0ODiFOvVcHhRRyH3JzPcISZpRw3ztgIXSK2
	4Rm0V8/HJeSJyJt8oDSIstsBywCex5E9RfLu/iEkqnfdi2tY0B/SR6N6Zf9lVUB3EN05px7ZrDL
	UBUEYcemSTlXAuEhjjUtvdepc26rg5IIhVuY/b4NsJ0+aG1HMZESQ==
X-Received: by 2002:a05:693c:65c5:b0:33c:43c:f3dd with SMTP id 5a478bee46e88-34f2196cd67mr10917502eec.11.1791171819348;
        Sun, 04 Oct 2026 20:43:39 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512717cc1esm9601422eec.16.2026.10.04.20.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:43:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 1/9] KVM: PPC: selftests: add support for powerpc
In-Reply-To: <asAsTMn8naXCxhno@google.com>
Date: Sat, 03 Oct 2026 10:07:11 +0530
Message-ID: <ld8fjt6w.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com> <de328dc973a135a956a148dd83d8353b7157d452.1790101179.git.ritesh.list@gmail.com> <asAsTMn8naXCxhno@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Sep 22, 2026, Ritesh Harjani (IBM) wrote:
>> ---
>>  MAINTAINERS                                   |   2 +
>>  tools/testing/selftests/kvm/Makefile          |   2 +-
>>  tools/testing/selftests/kvm/Makefile.kvm      |  10 +
>>  .../testing/selftests/kvm/include/kvm_util.h  |   9 +
>>  .../selftests/kvm/include/powerpc/hcall.h     |  17 +
>>  .../kvm/include/powerpc/kvm_util_arch.h       |  22 +
>>  .../selftests/kvm/include/powerpc/ppc_asm.h   |  32 ++
>>  .../selftests/kvm/include/powerpc/processor.h |  39 ++
>>  .../selftests/kvm/include/powerpc/ucall.h     |  21 +
>>  tools/testing/selftests/kvm/lib/guest_modes.c |  20 +-
>>  tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
>>  .../selftests/kvm/lib/powerpc/handlers.S      |  93 ++++
>>  .../testing/selftests/kvm/lib/powerpc/hcall.c |  45 ++
>>  .../selftests/kvm/lib/powerpc/processor.c     | 512 ++++++++++++++++++
>>  .../testing/selftests/kvm/lib/powerpc/ucall.c |  22 +
>>  15 files changed, 851 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/hcall.h
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/kvm_util_arch.h
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ppc_asm.h
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/processor.h
>>  create mode 100644 tools/testing/selftests/kvm/include/powerpc/ucall.h
>>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/handlers.S
>>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fc320b373656..35df0c39e991 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14349,6 +14349,8 @@ F:	arch/powerpc/include/asm/kvm*
>>  F:	arch/powerpc/include/uapi/asm/kvm*
>>  F:	arch/powerpc/kernel/kvm*
>>  F:	arch/powerpc/kvm/
>> +F:	tools/testing/selftests/kvm/*/powerpc/
>> +F:	tools/testing/selftests/kvm/powerpc/
>
> I don't think sending KVM PPC selftests changes through the PPC tree will work.
> It's "fine" for KVM PPC changes because the volume of KVM PPC changes is low and
> rarely modifies anything outside of arch/powerpc.
>
> KVM selftests tend to have a lot more cross-arch and/or common code modifications,
> i.e. I think we'll be setting ourselves up for pain if we don't route all KVM
> selftests changes through Paolo's tree.
>

Sure, since enabling kvm selftests on powerpc has quite a few common
changes in cross-arch, so it make sense to take it via common tree which
it already uses.

BTW - the above file name paths are just so that we can have people cc
linuxppc-dev too, for powerpc kvm selftests changes.

> Does it maybe make sense to have all of KVM PPC route through Paolo?  Punting to
> PPC made sense when KVM PPC was on life support, but it looks like resuscitation
> was successful for at least some flavors of KVM PPC?

Today, I think it is getting managed, as long as the core/UAPI changes
are routed via Paolo and/or via ACK from both maintainers.

However, for PPC kvm selftests - let's do as discussed - to take it via
common kvm tree.


Thanks again Sean, for the review. I will soon post v6 with the
suggested approach.

-ritesh
