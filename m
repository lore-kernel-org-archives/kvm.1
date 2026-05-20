Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CEB3E7BC6
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286895; cv=none; b=qiIxxp4y9uk6WPzTFMAywW+3/a9xeOI0OGmZyqPOHZxtP/3lN2Nxd/YcWREP44TKRyk5MBPLDRphgVqETMQoIIJg5PVkGh2u9uV3+7Kq92CIUqOS+smJCY3OMJTa5ZE6fmexAIxm83Q4agk9VsSoLqbo5l78cOG9jnarSVT5hzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286895; c=relaxed/simple;
	bh=FDEy+sBoWj2hNwWR6bbG5FHmYcnImhBaSmFUYukAAec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oNZDy5NtOzKxaRsxnT05N8gK/mESPj7l55z5FIchKNAJBXtkGtOeqTe4+/mRFaGtTze5rR8INydcEoLwOrqUzK+g32jVFetfTyq1MVyEKV9K912DDxRnRsevVqa+ZUBZCF21YcQuQrqcPGgn/ujZiE3u17wRtXl2wQ2oZ3wEFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbqtltqb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbqtltqb"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c823549b1fcso8548952a12.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779286893; x=1779891693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGduY4ljPx9wbBVEnZWZe0lo89Kip5G/xMJZhZdI+Us=;
        b=lbqtltqb+9UdNCEzURki/5DYghvNraWl8f2UHMKBex6QGzzZj7CP5H0RNAZVeAY00S
         FwOCvad/2XtAIv2sSDTKBJdSGXDwgzUV+oWsR3R0SD6i/9/9+I3JCraCBUHqYgfqJ9PC
         wh2J2tBWQv/wjpLTSpGvgazGr7dVbm3ZqjRCwAb3biobWo/v8oijgM4CSKlhKMB5B9UZ
         z/2BQBaVuL5pdS8mMiudurD2Cg6sLNbosvl4MMKM8rP57kB4ke04az4n8Iuo99TZmcvZ
         6G/IdhIui/ANV2PdlqQawvCtBfiOz7TjmtlaS2CKPcuSJ7VCbBpyAvcH7bBKEQ7GefFQ
         2C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286893; x=1779891693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGduY4ljPx9wbBVEnZWZe0lo89Kip5G/xMJZhZdI+Us=;
        b=d0lNH6hnto2R0LJK/38AVxgdmCHVUxEUEzD3U62Dx6cJP/wDA4T/HAL7StdRwXlbHI
         1CVAk7QIbQc5w0HFQGhg9+kwVxeUF4hkSaRV7mOvHUWmulV/iPLJNFIU74HH5dF1bzDC
         KgbECycVRQzi9mKgdp8jukHMZjuoAFMpIKPzeHw5chusP+TpIuhFidtKTfmbeiZY3rgN
         50O/qV+wFL5jNop7y5f/8FWgbDsoqZEXjDAVTpBgLhlGhw7RWi10D3tYY0aBZ4sAK13A
         QmvUkbjIIpiBPYhkFwKfzqY3XKWvMvYFA/JG5xNoFsQ+bkI9uWJgO7Z2vT8IAeIpIukI
         JQmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UsaA+wsI5nLdsMcOxGWzaq47RFJAyLt1MjLoaWdvOt3rLcMXZdW4b5MTFbHxposXSYK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbjCt7khF8hW/u8i6EpgKb3qMbNFgAFqOjloOa7GhhCfWdoJsR
	OzEVuRR0ayw5nMpHAe+KFadHnebWEtYd8fDR3Kor+BQ1E0MjjQkQ35gfDBymTXLntSID0LZ0g39
	ZM9rypw==
X-Received: from pgdn22.prod.google.com ([2002:a63:8f16:0:b0:c82:2d14:39c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430b:b0:3a3:3d95:508e
 with SMTP id adf61e73a8af0-3b22ec9a748mr25179838637.32.1779286891879; Wed, 20
 May 2026 07:21:31 -0700 (PDT)
Date: Wed, 20 May 2026 07:21:31 -0700
In-Reply-To: <CA+EHjTxvLU4XDPXDXYXXWJES1OFQgN8VTRLMgCCNMwBE6Hk8tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com> <CA+EHjTxvLU4XDPXDXYXXWJES1OFQgN8VTRLMgCCNMwBE6Hk8tQ@mail.gmail.com>
Message-ID: <ag3DawWCcrpCkD0e@google.com>
Subject: Re: [PATCH v6 06/43] KVM: x86/mmu: Bug the VM if gmem attributes are
 queried to determine max mapping level
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 20, 2026, Fuad Tabba wrote:
> On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > When the maximum mapping level is queried, KVM's MMU lock is held, and
> > while the MMU lock is held, guest_memfd cannot take the
> > filemap_invalidate_lock() to look up the current shared/private state of
> > the gfn, for these reasons:
> >
> > + The MMU lock is a spinlock or rwlock and cannot be held while taking a
> >   lock that can sleep.
> > + In guest_memfd's code paths (such as truncate), the
> >   filemap_invalidate_lock() is held while taking the MMU lock, and taking
> >   the locks in reverse order would introduce a AB-BA deadlock.
> >
> > Currently, the maximum mapping level is only queried from guest_memfd in
> > the process of recovering huge pages, if dirty logging is disabled on a
> > memslot. Dirty logging is not currently supported for guest_memfd, and
> > guest_memfd memslots also cannot be updated.
> >
> > For now, bug the VM if guest_memfd needs to be queried to determine the
> > maximum mapping level. This guard can be removed if/when support is added.
> >
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index a80a876ab4ad6..153bcc5369985 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3357,6 +3357,15 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
> >                 max_level = fault->max_level;
> >                 is_private = fault->is_private;
> >         } else {
> > +               /*
> > +                * Memory attributes cannot be obtained from guest_memfd while
> > +                * the MMU lock is held.
> > +                */
> > +               if (KVM_BUG_ON(static_call_query(__kvm_get_memory_attributes) ==
> > +                              kvm_gmem_get_memory_attributes, kvm)) {
> > +                       return 0;
> > +               }
> > +
> 
> This directly takes the address of kvm_gmem_get_memory_attributes,
> which is only compiled if CONFIG_KVM_GUEST_MEMFD=y. This breaks
> ARCH=i386.

And this bleeds guest_memfd implementation details into places they don't belong.
The right way to deal with this is to use lockdep_assert_not_held() in whatever
code mustn't run with mmu_lock held.  E.g.

diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
index c9f155c2dc5c..3bea9c1137ef 100644
--- virt/kvm/guest_memfd.c
+++ virt/kvm/guest_memfd.c
@@ -547,6 +547,9 @@ unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
        struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
        struct inode *inode;
 
+       /* Comment goes here. */
+       lockdep_assert_not_held(&kvm->mmu_lock);
+
        /*
         * If this gfn has no associated memslot, there's no chance of the gfn
         * being backed by private memory, since guest_memfd must be used for

But I'm confused, because kvm_gmem_get_memory_attributes() doesn't actually take
filemap_invalidate_lock(), so what exactly is the problem?

> >                 max_level = PG_LEVEL_NUM;
> >                 is_private = kvm_mem_is_private(kvm, gfn);
> >         }
> >
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
> >
