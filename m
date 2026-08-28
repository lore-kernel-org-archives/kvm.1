Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB8C394E8A
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787940458; cv=none; b=Srj5eJvJmq9p0escfEwsEoZfD9nh20a5H4pxBtIZkB6JcEsDvwDZtYDVWCjQmXRS/hHYxPon+y/kgT18Pf/uHJhs6fM/unakfFsCgfFYPHdyS1GDaff44hxyfNexQncos3MjviRO3JU8t3LI0tKyko9ykkcbMNghZEdOhlAxbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787940458; c=relaxed/simple;
	bh=c1tEVigf+FQrayaN3giFFn+kO+lE6WXq/YykkjI8cpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/K6y5Tkskp2J6cf0oMl5H2l5P2601vYLvAEI5MwfCs3GiK55QlgNHgya2Zm/9MxrXOoraWNSKsxzOet9qtCV6ilsyP0qnJ41bR7+x8tcQuk/7GDGBUR4onwgafInO+mJNHXAFRj9Jcp1a1qcutjggXJiuRcCnMRTc3uUbIe0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6+vKQyC; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6+vKQyC"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso1192225a12.1
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787940456; x=1788545256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lD64MUyngIsCQv9tUBdkcgzvyMQxFZ53ZEBy5BtZu7g=;
        b=J6+vKQyCAzeTpFgZrh6n9oQiqB9N3nMFkma2DPsv+7avkPsAzKRd3h88EbYlTgprkk
         BJaoGWvD4ONLupzcEElnEVjWUDMp/SigKXyM60PT7cLarVr6QTBHexKhau9nYAoDrU1r
         orMPT4WXPWOrj6ExBObzILjq1N06ki3cmbmUiiSzMNGuNE0Imxp/0FCrZLXY6VLqk51n
         uthiFvUzw0L2nlCeDas7jwzv6IqWyVlZRPUEah6I4YU2+lQZDoNKL5GSLjuyB4pqOykC
         Xf1JPMsGtgD1mqDehIX/roQjbRr80ctkhuymYwuPxtjbsYYouZ1oXJxJqDWbUFVyOcfH
         FEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787940456; x=1788545256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD64MUyngIsCQv9tUBdkcgzvyMQxFZ53ZEBy5BtZu7g=;
        b=amx3MHlGVzwyCxPDfZYj4tMxwsqQGda7alkVp0O6KErXlbftzaBkSPIWEJwf2ajJnY
         8Ov+ELyF2VNDnxRdji/mVbu+vr/dKMAu6wFJOKnZHvmvUpdESU59lXANN99FgEUin7Wh
         D+cKZLT2IUZoZ7tzaogEYHa7q7vSDHNCFUnKJQJOXVZ7wP3J44jLRoy3UsZ7DxjAr5Db
         9AEeGv0Ea0tdAjhkIH2MOncmCyaklWUHSdtDSFu9v+KNFTSxujNiTkJfss74uGG5X4BP
         QAbtzgLfzxfCjkR5jAgiEb7muT1qPUA4evmX0DHIAXLxlENA5QYEwncN4VbcxTqPDX2h
         UF8g==
X-Forwarded-Encrypted: i=1; AHgh+RoY+ICjVixsF0nWQ1rBtB2/DQhxdPDCGqQy8hoDsQW2PmmPYtw9gT93EwwH1utYcl1h6U4=@vger.kernel.org
X-Gm-Message-State: AFuF++lO5FGJrBc8Tt12CQaBxeGLcmoQbqmb9kHuJZlfPIbSdJTIvDeW
	l+uOGNo2NINdw/va0Ds1j9QU3eHenijJoQkrNwMka45dhJSWSETyU7SiJe1p03dhO8E1ZIDOrO8
	29lbvng==
X-Received: from pgtk26.prod.google.com ([2002:a65:68da:0:b0:cc1:4794:1471])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:160e:b0:3d0:e034:a26f
 with SMTP id adf61e73a8af0-3d2688bd551mr19120799637.17.1787940455451; Fri, 28
 Aug 2026 11:07:35 -0700 (PDT)
Date: Fri, 28 Aug 2026 11:07:34 -0700
In-Reply-To: <20260828195848.2d14e9aa@p-imbrenda>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com> <20260826230511.972824-3-seanjc@google.com>
 <20260828195848.2d14e9aa@p-imbrenda>
Message-ID: <apHOZouaLKs5CgpI@google.com>
Subject: Re: [PATCH 02/20] KVM: selftests: Bump the minimum GPA for page
 tables to 0x200000
From: Sean Christopherson <seanjc@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 28, 2026, Claudio Imbrenda wrote:
> On Wed, 26 Aug 2026 16:04:53 -0700
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > Bump selftests completely arbitrary minimum GPA for page tables from
> > 0x180000 to 0x200000 (LoongArch's minimum), so that LoongArch can use
> > vm_alloc_page_table() instead of open coding a rough equivalent.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  tools/testing/selftests/kvm/include/kvm_util.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index 5a7a455b5387..70906a0d1003 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -175,7 +175,7 @@ static inline struct userspace_mem_region *vm_get_mem_region(struct kvm_vm *vm,
> >  
> >  /* Minimum allocated guest virtual and physical addresses */
> >  #define KVM_UTIL_MIN_VADDR		0x2000
> > -#define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x180000
> > +#define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x200000
> >  
> >  #define DEFAULT_GUEST_STACK_VADDR_MIN	0xab6000
> >  #define DEFAULT_STACK_PGS		5
> 
> this breaks s390/cmma_test
> 
> I tried a quick fix, but nope... I will need to actually invest some
> time (i.e. next week) to understand why the quick fix is not enough,
> and come up with a proper fix
> 
> the good news is: it seems like cmma_test is the only test that is
> negatively affected by this series.

Is it this change specifically that's problematic?  Because if so, you can probably
just do nothing, because Sashiko (argh, just remembered that Sashiko doesn't Cc
everyone) pointed out that this will likely break some arm64 tests as well[*].

The LoongArch folks confirmed that using KVM_GUEST_PAGE_TABLE_MIN_PADDR as-is
should be a-ok, so my plan is to drop this patch and instead have LoongArch use
KVM_GUEST_PAGE_TABLE_MIN_PADDR.  I.e. make LoongArch match everyone else, instead
of making everyone else match LoongArch.

[*] https://lore.kernel.org/all/20260826232224.782021F000E9@smtp.kernel.org

