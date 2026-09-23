Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F0475337
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199401; cv=none; b=uSDbC3sKb1r4n3FtskwPSPhzAv+JLpXEmqrXLn8JL25ld3NWDIS9jfAnqiSRwtZ629kZNeA3nrdTsamuXoU18n6R8vkRnC9bTzD8VJSIjUBkSXM0bInXpG9/0Yt1B+OKgvlEojdDdDYU5GEOrz/7P52l/EqBp7hTOh+fUXfrSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199401; c=relaxed/simple;
	bh=2v7xpp0V30n6l/pTJU1KpDXJXjO7sRpXKNopKA8DGxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARw3L5EIX6ZtgGzFSMDa+3vimUI0+PWZEnmJ+MPqg8W4dhGziU/2GlqvdYQfH5/QFKiFvn96paG3wGMyrl8VN7iLzly2W/6eWzJnlY8A5TMNr2DqJJvihrpEpfNb2ZpnTiGjt4psYwDJ4+Y/p/G2ZkPDbrfyfka1PdTsfr8nZ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MT/0YJkF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSZ8ezYh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MT/0YJkF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSZ8ezYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790199397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jL6cT+RcKiUtKQK8HLnjuEugj7EU5PPkjwVYFt6osI=;
	b=MT/0YJkF1B/oQ3WN8pkQtdvphBwloHOYZ/cI07tFuStaFakn3/Vcevbd38eJt0XeKKKBdB
	Vxqdq4NV/UFXm+DFbp0cGlxUBIeTXn901wxQ5/8U6216WAiO4lIi3j5WHF4amVrxewrZdJ
	Ax3Qta9nOQgV2PMOmWw8e2YASAM1cQs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-QueJX4yYOZGXx9x8h1QYSw-1; Wed, 23 Sep 2026 17:36:36 -0400
X-MC-Unique: QueJX4yYOZGXx9x8h1QYSw-1
X-Mimecast-MFC-AGG-ID: QueJX4yYOZGXx9x8h1QYSw_1790199396
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a1de6d5c3so270252585a.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790199396; x=1790804196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7jL6cT+RcKiUtKQK8HLnjuEugj7EU5PPkjwVYFt6osI=;
        b=MSZ8ezYhPJWJ9Iry9v29onraMpawSf05S3KJBIK3J0TO3lHP9000bBFCyf0aIqHRuC
         rF2bkZ2GOrVq63Xb97TCx0RZrkuH+cGYtL1B3XoMCQlChxZR0F6xtTci33qLaMTBy++8
         VLjiiK+ejZjv0mSy/6hhI+7IApcCgH5WfOX6oi+WdxEty2RXRf4xJ0zCaiwv2ZYCcR4V
         3hJd1fnHDVKla0AoYPefY5ILuKbeSBWiSbysngFOTRdafrb8qf/5gXHCpRsoX1S9fxzw
         1UmZCKfWJcbAnvZJFU88rUSQp2QedyXu7yzgYK0pgr7G+cZL1Sd4fx7//JlBtLHgyzV4
         x2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199396; x=1790804196;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jL6cT+RcKiUtKQK8HLnjuEugj7EU5PPkjwVYFt6osI=;
        b=0XIXLBcg96LmdjefI9sGpLczuVFzL2REH+2sIG7V9kB+cFNte8j1aVKvRzmHcjbmsc
         8fAzVyqK0go/vY6Lz91QWcOuqmqynLOMVrzvPJ1s42JfefyO3E43M1SqVz2w3AjmUXF4
         +nwp0rvDZzoXLJFsBn1hjTlFZme+zfNtSAFz9tXI/m2jrG/mmnx3AhHUiUHC/Ij1fjfa
         IQ+wRohacTJfkZiAdv4MMpeoTAMVBhhzXgVS/OsASuUJw5MEkEioSv939HUZ9X+h0DOr
         mZQnvWLBmdJP9Ivo7aZUuUovWEa+q0rqdJGGQZyJcXQWzJvf75m/y4vIjuPBRwbJcAsl
         3xrw==
X-Forwarded-Encrypted: i=1; AKwUvBzkEUZAnxHiXF2i1MmiFxp2ysDV9+Uuf7WCyo97ez/NYHKXxzAPmVKI+dAUooWBRwZaS1w=@vger.kernel.org
X-Gm-Message-State: AFuF++mvTj8UAvQQKX4lz1iAhfbpqBVVPauKnjwV/3KJbGZSNJbSZ58y
	Y1Vtvf12FSR6DDGyBN3bv5oEhvsLH+p5ep4VBmmv1xcQuPXns3kpAoDAaR2eKZZfHSwrjOXf5im
	FJveAx3q5t3k4cXBwokuyVFw4HeQrv0HPZx2yHlCrfH8nH293K2lnig==
X-Gm-Gg: AYBFou0Svo4l9iWtZMJxAstTMkc4xS/dPL+iCK57AWCPgdzMuiBG9CL8l+TFAG1NKXT
	AdSeruWeWxBD5tS9J1QZtCn4Mu9fEdN5f93RFKoUiSrAQzAgnC2F5cSJr35oGlfLnBETBXXJYfF
	D5jJ/g7MfcazJRw+qF2/LqnbKwQS2rwfo08HPxcVNBj3tAQlhe9pdDx/+p2iQRpuf8bWTHJcaQM
	TWSfE4Bc6B0ga6JrFN+XH50MZbOxQX65FTI5OOxqD20yEARq8U998LF+thZk0JOjBeQ9i6al/1k
	HYjzIE6z89YrXT/IicNtnwE5W/ALxmtKWtCMhHVJsYL74+hyXUF9jD//LXFS8qT2E9+Xxe4=
X-Received: by 2002:a05:620a:a2c4:10b0:939:c9e9:81a1 with SMTP id af79cd13be357-93c344f87femr54404785a.42.1790199395752;
        Wed, 23 Sep 2026 14:36:35 -0700 (PDT)
X-Received: by 2002:a05:620a:a2c4:10b0:939:c9e9:81a1 with SMTP id af79cd13be357-93c344f87femr54401985a.42.1790199395227;
        Wed, 23 Sep 2026 14:36:35 -0700 (PDT)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2f3c6fdfsm142515085a.45.2026.09.23.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:36:34 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:36:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>

On Sun, Sep 20, 2026 at 04:56:20PM -0700, Kishen Maloor wrote:
> Hi Peter,

Hi, Kishen,

> 
> Thank you for your comments. Just adding a few other details to
> complement Artem's response. 
> 
> On 9/17/26 2:27 PM, Peter Xu wrote:
> > On Fri, Sep 04, 2026 at 09:24:25PM +0300, Artem Bityutskiy wrote:
> >> On Mon, 2026-08-31 at 10:13 +0300, Tony Lindgren wrote:
> > ...
> >> - Should the same uAPIs also support traditional VMs? But the only use-case
> >>   I imagine here is "for testing purposes".
> > 
> > This is an interesting idea, I think this could be useful.  Especially, I
> > wonder if you already have it done and PoC branches you can share, so that
> > I can play with it.
> 
> I had once attempted this and hit a breaking case while migrating regular VMs.
> I didn't dig further since the primary use of this UAPI set is with CoCo VMs.
> 
> Here's what I gathered: KVM-mediated transfer needs KVM to resolve a GFN to the
> HVA where the data lands, and on x86 QEMU mutates that mapping at runtime in a
> way that is opaque to KVM. For the PAM window QEMU overlays a separate region on
> top of pc.ram, and KVM sees only the flattened view, the winning memslot, with
> no way to address what that slot shadows. On the source, firmware reprograms PAM
> and QEMU drops the overlay. On the destination the firmware never runs, so it still
> has its boot-time layout and the overlay is still in place. So importing, say, GFN 0xc0
> lands on the overlay's backing store, which is a read-only memslot, and the GFN->HVA
> translation fails. I suppose even if it were writable, the data would land there
> rather than in the pc.ram underneath where it belongs. Without mediation, QEMU is
> able to write to the HVA directly, so the problem doesn't arise.
> 
> Generally, I think KVM mediation only works if KVM's view of memory is authoritative.
> TDX skirts this issue entirely because QEMU doesn't create overlays for TDX VMs.

I see this one slightly differently, and I have a major question on the
choice of GPA for KVM's memory access API.

If reusing GET_DIRTY_LOG, it means slot_id works for CoCo like before
because that's the old interface there.

But the new KVM_EXPORT_MEM (vice versa) used GPA arrays.  Could I ask why
the change?

IIUC this is the fundamental reason why you hit that PAM issue: at a
specific GPA, QEMU/KVM can map different things, hence GPA is not yet an
unified identifier for a physical page that guest uses.  However, (slot_id,
slot_offset) will be.

If the migration memory access API will be using that instead of GPA, I
think problems will be gone because then the PAM regions (likely, pc.ram
underneath) will be migrated in form of KVM memslots, destination apply
that to the PAM's (slot_id, slot_offset), then when switchover, that PAM
memory region will be enabled by QEMU and it will be visible to destination
QEMU when VM starts on destination.

I'm actually not sure if such (e.g. PAM) will ever be supported at all in
CoCo context, but it seems to me using (slot_id, slot_offset) (for each
entry; it can also be an array) is more flexible than GPA arrays in that it
allows GPA mapping to change on the fly if needed even during migration.

I'm not sure if that's explicitly forbidden for CoCo, though.

> 
> > ...
> > Could you elaborate this ITERATION operation?  Is that something the
> > userapp must do after full scan of a round of guest memory?
> 
> Essentially, yes. TDX migration architecture delimits such pre-copy rounds as
> "migration epochs" and emits an epoch token at each round boundary that needs to be
> consumed on the destination. It allows the TDX module to verify that everything from
> the prior round has been received at the destination and that two versions of the
> same GPA aren't sent in the same epoch. It is userspace that decides where a round
> ends, but any deviation from this model and migration would fail.

I'm a bit surprised that TDX will also monitor how many times the same GPA
is updated per iteration.  What if below happens:

  ...
  ITERATION sync n
  GET_DIRTY_LOG, see page P dirty
  migrate page P
  GET_DIRTY_LOG, see page P dirty again
  migrate page P again   <--------------------- [a]
  ITERATION sync n+1
  ...

Would above crash on destination TDX at step [a] applying P 2nd time?  Or
does it mean GET_DIRTY_LOG can only be invoked once per iteration?

> 
> > 
> >>>        |    (repeat until convergence)                  |
> >>>  CMD(STOP_AND_COPY/PAUSE)                               |
> >>>  CMD(STOP_AND_COPY/TD_STATE) --- VM state ------> CMD(STOP_AND_COPY/TD_STATE)
> >>>  KVM_EXPORT_VCPU             --- vCPU state ----> KVM_IMPORT_VCPU
> >>>  KVM_EXPORT_MEMORY           -- final memory ---> KVM_IMPORT_MEMORY
> > 
> > When read/write encrypted memories, two questions:
> > 
> > - Is there an upper bound of the buffer size per-page?
> 
> Yes. For TDX a 4KB guest page produces exactly 4KB of encrypted payload plus a small
> fixed amount of ancillary data. The bound can be pre-computed and userspace 
> can size its buffers accordingly. The UAPI itself doesn't impose one. The vendor 
> implementation decides how pages and ancillary data are laid out.

Get it now.  I still think if that varies across impl, it might be good to
somehow notify the userapp on choosing the buffer size.

But nah, it's not a big deal - when there's retry, userapp can always probe
with any size then double it until it fits..

Thanks,

-- 
Peter Xu

