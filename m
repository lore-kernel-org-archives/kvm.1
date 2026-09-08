Received: from mta0.migadu.com (out-44.mta0.migadu.com [91.218.175.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7FD3AD51F
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854935; cv=none; b=aOsiWPwt5r1YoMWGzNs/VZmQbtbfH+JWMVPwbGDZZlpwe8PMBR6UL9qdHIcl2iNsDOxo5rMPHWw7o/i3E715MQqQfVFiQnBuYnmJBQPoQ9mWbi6HT05hTMbXA7v3QErKo/Mh6sqNSLa4dlKMxgxrKIuBkFtWzPCSGieQ7SzTlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854935; c=relaxed/simple;
	bh=XGg4zKBZIdsYlLMLs2Et22MQ6qSUt/Oz2PZF17USj98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtPImf++QdcGsCNI8KpajkA8zIAz7NXMXTorQyq4NoXj2K6I0V37j89YWIIxrzHgU7NCFTL8fQTpGHmtZdkjpC91y8CuZilnrlVb1zxHTSGzDCDlGbR91XiZsZ9bKY1vCZj4V5rKRk9XHWGOghabwvFoTv5THfTk7cv65fnJg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DG4GiXxQ; arc=none smtp.client-ip=91.218.175.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DG4GiXxQ"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XGg4zKBZIdsYlLMLs2Et22MQ6qSUt/Oz2PZF17USj98=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788854931; v=1; x=1789459731;
 b=DG4GiXxQq92UBx05UZButsQOV6WSH87CIuYUacgr98dWyHdFi69DWOYOJrRjAMjMLCgnXlJL
 1BBQN5um/AFRAlQVJSmHZeJX+daHrOE0HCmaGGGUiTmlMjyPtRtMdU4YOKmfBWFe28IT0stBtBC
 DifgKR3c8gZDqVGMBhQ4A2DE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5875bd9d5941d221;
	Tue, 08 Sep 2026 08:08:51 +0000
X-Mizu-Trace-ID: 5875bd9d5941d221
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b17359so14292e87.0
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 01:08:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBweeG2vEcNwSbHj1qUOYbu8b4E4PF169dLS2VXhB7sut5qQuWNMscami2A0s31CaHm6YJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++ltXEJMW9ULtXA78ZCjD0GOxCeyaqsGdiY8mVY6xLtLHhgHq7xt
	aAr9yL0kW9yv0DavEimkIgJJsrNyc63FKK+BV1qm0LHXdH+eaKckLmEqpr61n2/RNp1bSqzRR6Y
	XPDd+Y6KICwXOYv8TYRhdqJT/iw0aYSIAZK9xtJeX
X-Received: by 2002:a05:6512:1344:b0:5b6:186e:682f with SMTP id
 2adb3069b0e04-5b751a5bf63mr134070e87.0.1788854927331; Tue, 08 Sep 2026
 01:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com>
 <20260826-arm64-52bit-va-v1-2-14ec98211363@fujitsu.com> <CA+EHjTyJpPd8HjaWBw0V6pHF9UR0w2UFmaKDe7U3O+Sj8wiyPg@mail.gmail.com>
 <ap8rnTINMJQqfYGL@sm-arm-grace07>
In-Reply-To: <ap8rnTINMJQqfYGL@sm-arm-grace07>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 8 Sep 2026 09:08:11 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwhoZEORBjJcUb1WQbFT1TtX8x=BeeMJAcdpEBVJJ265Q@mail.gmail.com>
X-Gm-Features: AcwNN1UAtKldnq8E5xQ_R8tgfkqEMJun_timebwDOYCwtGlMYwbA3T-yjMp633c
Message-ID: <CA+EHjTwhoZEORBjJcUb1WQbFT1TtX8x=BeeMJAcdpEBVJJ265Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: arm64: Add 52-bit VA guest modes
To: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Takayuki Okamoto <tokamoto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Sept 2026 at 22:24, Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
>
> Hi Fuad,
> On Fri, Sep 04, 2026 at 09:45:30AM +0100, Fuad Tabba wrote:
> > Hi Itaru,
> >
> > On Tue, 25 Aug 2026 at 22:18, Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
> > ...
> > > diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
> > > index 9108e14a9b5b..bcdf670c9eb8 100644
> > > --- a/tools/testing/selftests/kvm/lib/arm64/processor.c
> > > +++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
> > > @@ -46,7 +46,7 @@ static u64 pud_index(struct kvm_vm *vm, gva_t gva)
> > >         u64 mask = (1UL << (vm->page_shift - 3)) - 1;
> > >
> > >         TEST_ASSERT(vm->mmu.pgtable_levels >= 4,
> > > -                   "Mode %d does not have at least 4 page table levels",
> > > +                   "Mode %d does not have >= 4 page table levels",
> >
> > Patch 1 added this string one commit earlier. Could it go in with the
> > final wording there?
>
> Surely, will fix in v2.
>
> >
> > ...
> >
> > > @@ -298,10 +304,14 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
> > >
> > >         /* Setup mode specific traits. */
> > >         switch (vm->mode) {
> > > +       case VM_MODE_P52V52_4K:
> > > +               vm->mmu.pgtable_levels = 5;
> > > +               break;
> >
> > This is now the deepest mode, so page_fault_test.c's sizing is stale:
> >
> >    * VM_MODE_P48V48_4K is the mode with most PT pages; let's use
> >    * twice that just in case.
> >   pt_size = 26 * guest_page_size;
> >
> > The margin still covers it. Could pt_size come from vm->mmu.pgtable_levels?
>
> I'm not the author of the page_fault_test.c for arm64, but so I'm
> guessing here; per the comment in the test, I dont think total number of
> levels determines pt_size, rather by the addresses prepared for the
> test.
>
> This stress test does not require high virtual addresses, though should
> we update the comment while at it?

You're right, pgtable_levels alone wouldn't capture it: what sizes
pt_size is the granule and how much the test maps, not the depth.

So just updating the comment is enough: name VM_MODE_P52V52_4K as the
deepest mode. At 5 levels it's the deepest any 4K mode uses, so the 2x
margin holds and the constant won't need revisiting.

Cheers,
/fuad


>
> Thanks,
> Itaru.
>
> >
> > Cheers,
> > /fuad
> >
> >
> > >         case VM_MODE_P52V48_4K:
> > >                 vm->mmu.pgtable_levels = 4;
> > >                 break;
> > >         case VM_MODE_P52V48_64K:
> > > +       case VM_MODE_P52V52_64K:
> > >                 vm->mmu.pgtable_levels = 3;
> > >                 break;
> > >         case VM_MODE_P48V48_4K:
> > > @@ -322,6 +332,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
> > >         case VM_MODE_P48V48_16K:
> > >         case VM_MODE_P40V48_16K:
> > >         case VM_MODE_P36V48_16K:
> > > +       case VM_MODE_P52V52_16K:
> > >                 vm->mmu.pgtable_levels = 4;
> > >                 break;
> > >         case VM_MODE_P47V47_16K:
> > >
> > > --
> > > 2.43.0
> > >
> >
