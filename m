Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1E49C4AA
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355838; cv=none; b=u1ifwTUnjxI7eYGcgnc7bO5b7so4OPtJEErXX/CbJr2rk23WuQ0QSxcTE5KmUqZNCk6BAKn7LwLlv4eIRBeYHPFwjDtgiGRJuhWb845R2w3hKi85JCLRDogG/4QQ/9HgbZs/VqJe8Kf8jKAUrMZU66SzsA6DMiUzuo1TK1ff4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355838; c=relaxed/simple;
	bh=MHL7rgwCnCCzQ0ALQS+vHavGvj+m/st2KmAo4YeAg84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ui3mgBomiolkjgF4OKsHhcmkU41OpGSVfH55GmzNq7WCIa/W0UKzB+CQg8J9IHdWn7GOWXB6KXJJ6ZfLTnMiNC0ZNCGpCUO4466syC2E+VE5ArUAa75F6mVODFSytiLHr+7FzE3wqSKIqQMd7AC0P0y4ltXGTnhyA08GWbLyhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDa/0Oej; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDa/0Oej"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d7151120d6so17169855ad.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788355835; x=1788960635; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjYXG96MoSl8fTQZ7UxomEUfCMCHuYclL43aTeN6TlM=;
        b=HDa/0OejXOLAo60mi/WsaiaFauY4lpsEUXD5S4ErepL7tSUt6BK+qswUsGtrZxee/k
         AMZ89vrXic2a8oIk4MUXmdYjVgcZ22N31iZpGhm6wp5bEqyvzlstVg8GIru4/ZFYzAr2
         z2ufT38pcUCxPWK5qjzBy7ZVEK8dn1yag6u5B0ZE8bax5eVnab2YxmbXblLtfaGalYs7
         hpi+q61IuH+UMrDxcLyEQcHs1kOGaHEs8S50arsWnyewMnF8WqwSfP4x89pnsj9u46Qt
         kPnJeo8nKopTl1HZzVkxmvjcGr8KP/cKkQGbpIuRrlO9PndMduKx7tHKOR7x6cSnWQGr
         M4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355835; x=1788960635;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjYXG96MoSl8fTQZ7UxomEUfCMCHuYclL43aTeN6TlM=;
        b=bePGfmlRigmIMTmgn4tHIavBc2dncsTQyPFRHoCcSKYguuoBcwcolnW7UyE8sQiqUq
         ImJD44J/6pmTqoHc+zIe1n9+wz8Bm5OwOvTLWlpA43AQn75NrTFi3bi0fYoXr5B3nkcD
         5+hpGL2DQKrOP5UfFLbYuWOTmEPT1exp4AngV4Rrk/Es1uzbfK4VLjAugSUWq4feYWM0
         dMRrNrckveKo66K9xuCegzgtIULPzHGSzAPaNqi19I5WdRbvftkfBYBdA44EsbpSoL3v
         hUhzLQEOUxX+UyeJOiepACQPMEbX2JKZp3qbiobo8nsEGJGetlRQrh55MnMbhn+LAucI
         V6ag==
X-Forwarded-Encrypted: i=1; AKwUvBz3/lZ0yG262lmr+gJdiXC07zIGavXWiP5Jr/hr6KtdwzdLyH7GGHZ7G6LUXzWN9/7juDY=@vger.kernel.org
X-Gm-Message-State: AFuF++nRFhlH2V1qwUtrQcAhelVU+5KnK+TPp0bqyfx3M2+Tsz3+vT/u
	apvL4bBl2p5EeJxoQnekcrhduNOetnFV20QYcgDmc96Fj/YjKgAHn65vDt+eHiBUDAZIlSxWOR+
	8AzrhqQ==
X-Received: from plnt11.prod.google.com ([2002:a17:903:196b:b0:2d3:7166:b1a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8b:b0:2d9:43f6:59f0
 with SMTP id d9443c01a7336-2daec7bae38mr68887665ad.22.1788355834704; Wed, 02
 Sep 2026 06:30:34 -0700 (PDT)
Date: Wed, 2 Sep 2026 06:30:34 -0700
In-Reply-To: <33431813-fc94-48fb-9042-5cfc68af05b8@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-23-85e5fd25252a@google.com>
 <CA+EHjTzALzghuG5J-LFuG5pXJ4WgEfrMHgwkMHnq1U-D6yS7Pg@mail.gmail.com>
 <apcY5b2o5k04XffH@google.com> <33431813-fc94-48fb-9042-5cfc68af05b8@linux.intel.com>
Message-ID: <apgk-nKsB31WVCWp@google.com>
Subject: Re: [PATCH v12 23/45] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, ackerleytng@google.com, aik@amd.com, 
	andrew.jones@linux.dev, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Binbin Wu wrote:
> On 9/2/2026 2:26 AM, Sean Christopherson wrote:
> > On Tue, Sep 01, 2026, Fuad Tabba wrote:
> >> Hi Sean, Ackerley,
> >>
> >> On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
> >> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >> ...
> >>> +       kvm.gmem_in_place_conversion=
> >>> +                       [KVM] Controls whether KVM enables in-place conversion
> >>> +                       support for guest_memfd and tracks the private/shared
> >>> +                       state of memory per guest_memfd instead of per VM.
> >>> +
> >>> +                       If enabled, KVM enables the KVM_SET_MEMORY_ATTRIBUTES2
> >>> +                       ioctl on guest_memfd file descriptors and disables the
> >>> +                       legacy VM-scoped KVM_SET_MEMORY_ATTRIBUTES ioctl for
> >>> +                       private memory state tracking. Only the
> >>> +                       KVM_MEMORY_ATTRIBUTE_PRIVATE attribute moves to
> >>> +                       per-guest_memfd tracking; other attributes remain
> >>> +                       per-VM.
> >>> +
> >>> +                       This parameter toggles KVM's in-place conversion
> >>> +                       capability support. Whether a VMM uses separate backends
> >>> +                       or out-of-place memory management is determined by
> >>> +                       userspace VMM design.
> >>> +
> >>> +                       Note, this parameter is only available when
> >>> +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
> >>> +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
> >>> +                       conversion is unconditionally enabled.
> >>> +
> >>> +                       Default is Y (on).
> >>
> >> The parameter is only settable when CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y, and
> >> in that config gmem_in_place_conversion initialises to
> >> !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES), i.e. N, not Y. Is the doc line
> >> wrong, or is N-by-default not what was intended here?
> > 
> > The doc is wrong.  The intent is to maintain backwards compatibility with existing
> > deployments if KVM_VM_MEMORY_ATTRIBUTES=y.
> > 
> 
> Will it result in the situation that kernel builds with CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> enabled by default for backwards compatibility, which requires users to explicitly enable 
> gmem_in_place_conversion by the kernel option? Then it effectively disables
> gmem_in_place_conversion by default.

Yes.  My intent/expectation is that the only reason to build with
CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y is for backwards compatibility, and so it makes
sense to have the existing behavior be the default.  If a deployment only wants
the new behavior, then it can simply build with CONFIG_KVM_VM_MEMORY_ATTRIBUTES=n.

Folks that want only the new behavior but are using a distro/pre-built kernel will
need to manually enable in-place conversion, but that's not too onerous, and it's
simply not feasible to provide defaults that work for every possible scenario.

> But I guess it's OK for CSPs since they know what they want.

Yep.
