Received: from mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411632937A
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301380; cv=none; b=QkOjyKuLw+ZYfmpun8ilbIO/PSpwMUMyTqURNLb3AB06wB8TsgaZBkgx17htsPu/zu2UtV1Ar79r6h9sK5Ef6JGSU07qZSOGgoHa1eChns0hl5gdajJekb0RAWt4UcJCTG7+6zXUnOjpTBbISljymLgTPfPZWdPPRw6tctvw46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301380; c=relaxed/simple;
	bh=CJv9ej77YKh7SqREZUkX1b/9RiHCVq3kJXFgGW0/pcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAtVYkkI6U3NMBVSTNOKdvRxoIp3UNgk5rySnBLQHM0JxIACwewqGWkWvEQg2Q297OaDF3OO1h+lXMvv1Ulxy0bJ7i3Z0lHehgJxEdSZg0VPiTfeVltNmMUO9VsB8Q9EpPS9vOXcvLsT+HIYXgYtIqyPY5tdt2hRPih16+lJHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xmq4EK2F; arc=none smtp.client-ip=91.218.175.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xmq4EK2F"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CJv9ej77YKh7SqREZUkX1b/9RiHCVq3kJXFgGW0/pcE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788301372; v=1; x=1788906172;
 b=xmq4EK2FVOUD+Uh2LH8jgM1hSY8bPOF0/GRZuWBf5duM+a3Sm7m6pwKSHbWn3dMRwO61uuy4
 UfobOye3g7+qm8TwlBFn+aRMvvgVqgv1GmwbqpMVR77yBkPb3jxiycg67WzMlgjL6WHYMPu/DPB
 Wndk25VIlG+pZS3TxG8sCUNw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5299d81c7f7d592b;
	Tue, 01 Sep 2026 22:22:52 +0000
X-Mizu-Trace-ID: 5299d81c7f7d592b
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b2a73da7e1so3190e87.0
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 15:22:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzaZPXM3HoatnfvBiqfR8qIWTi4VhIrpgtq4LQpJAsOOMSA/HSAA774ljWrbJ+LuRmKvuc=@vger.kernel.org
X-Gm-Message-State: AFuF++ncZdsFpVgzq5kHo870mEpYk67Jea4c+juUrcUA1SApmD5O+9Bf
	LHVMYxCXQ93x8A2dhJceJjHfuKyGx2RkK6PjWdVIZTNO0DxiOxGISW6Ztw8VHSKMYf7RHPam8df
	hnkoNV0EYhAPMYYI9Nt5q+r9Wr4kGozjPNuOrrqZC
X-Received: by 2002:a05:6512:3d0f:b0:5b6:4ad:d6ba with SMTP id
 2adb3069b0e04-5b609eeb230mr13703e87.15.1788301371454; Tue, 01 Sep 2026
 15:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-23-85e5fd25252a@google.com>
 <CA+EHjTzALzghuG5J-LFuG5pXJ4WgEfrMHgwkMHnq1U-D6yS7Pg@mail.gmail.com> <apcY5b2o5k04XffH@google.com>
In-Reply-To: <apcY5b2o5k04XffH@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 1 Sep 2026 23:22:15 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyUke815MNgCh7kEKw7JEprRG754gHi3UJ6R5RdbuUhyA@mail.gmail.com>
X-Gm-Features: AcwNN1XG2R0freerIjVIIorEq648d7QWyFSXRnqa21AMKowGv086HSc-AbV0xtQ
Message-ID: <CA+EHjTyUke815MNgCh7kEKw7JEprRG754gHi3UJ6R5RdbuUhyA@mail.gmail.com>
Subject: Re: [PATCH v12 23/45] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
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
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 19:26, Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Sep 01, 2026, Fuad Tabba wrote:
> > Hi Sean, Ackerley,
> >
> > On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
> > <devnull+ackerleytng.google.com@kernel.org> wrote:
> > ...
> > > +       kvm.gmem_in_place_conversion=
> > > +                       [KVM] Controls whether KVM enables in-place conversion
> > > +                       support for guest_memfd and tracks the private/shared
> > > +                       state of memory per guest_memfd instead of per VM.
> > > +
> > > +                       If enabled, KVM enables the KVM_SET_MEMORY_ATTRIBUTES2
> > > +                       ioctl on guest_memfd file descriptors and disables the
> > > +                       legacy VM-scoped KVM_SET_MEMORY_ATTRIBUTES ioctl for
> > > +                       private memory state tracking. Only the
> > > +                       KVM_MEMORY_ATTRIBUTE_PRIVATE attribute moves to
> > > +                       per-guest_memfd tracking; other attributes remain
> > > +                       per-VM.
> > > +
> > > +                       This parameter toggles KVM's in-place conversion
> > > +                       capability support. Whether a VMM uses separate backends
> > > +                       or out-of-place memory management is determined by
> > > +                       userspace VMM design.
> > > +
> > > +                       Note, this parameter is only available when
> > > +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
> > > +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
> > > +                       conversion is unconditionally enabled.
> > > +
> > > +                       Default is Y (on).
> >
> > The parameter is only settable when CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y, and
> > in that config gmem_in_place_conversion initialises to
> > !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES), i.e. N, not Y. Is the doc line
> > wrong, or is N-by-default not what was intended here?
>
> The doc is wrong.  The intent is to maintain backwards compatibility with existing
> deployments if KVM_VM_MEMORY_ATTRIBUTES=y.

That explains it. Thanks.
/fuad

>
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 05c518c9b8078..929fd3e1a01e6 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -103,7 +103,10 @@ static bool __ro_after_init allow_unsafe_mappings;
> > >  module_param(allow_unsafe_mappings, bool, 0444);
> > >
> > >  #ifdef kvm_arch_has_private_mem
> > > -bool __ro_after_init gmem_in_place_conversion = false;
> > > +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
> > > +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> > > +module_param(gmem_in_place_conversion, bool, 0444);
> > > +#endif
> > >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
> > >  #endif
