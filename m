Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089541CB2E
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345949; cv=none; b=YJK6UvT1KhhIaIf6MfTfkAEqiSwF21gtzVWCCjzBHuYV3Dy4Et+bWRXpUra1b2zaB3Tz115RXG4EGR0qMEG0qn/AC/Sv4zBdH5Uy4CDcLTguiHVuqUKARVU0SZxNyq1JUsZ1E9JyBfF734lMBWVKesvYskZoxOSynJJNvoCzkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345949; c=relaxed/simple;
	bh=zenLUEcGVhY8JcgiTXOozA8PS9rKXUIINMZ/ZwsqTu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTRBq7uehH7Z0ESMS0IT4y+Zdhvy7CrnIJssmUwrn95+hk3bd9w3bdO6PlbVJ0DsIpMDgjvOBvruQzIkTezNM2mvCDvjxO0rbYiaQCVwbxBN1QryNJsA1oQr7HYtS0VGiJxJ0WFFcAqsnhOPqG9wDNsPUo0IFjDnXd0mlNrsjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOjh243H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QI5FkyVn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOjh243H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QI5FkyVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790345946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xMZ+pyLoGVyLxuRkJ9G2Dg68OEOZ9ruIkCJ9U+ONpI=;
	b=IOjh243Hsd/j/oy4TFYeC4RNxZHkdIUwH+sigOwPq+LF8B03Rqd3BfZjSamsw64bGMZnc6
	817CFK3HN+Z1CWPWAUbdR0fxGOA/pnKG8BkPp5vEZrgV96ozQt9NjGjOAigBA0OMI0gGke
	L7b3Dq+PSKjzXz7n2pE2yIoPbyB7hIk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-UAXpjpjfPgG01kXu7Mv5cw-1; Fri, 25 Sep 2026 10:19:01 -0400
X-MC-Unique: UAXpjpjfPgG01kXu7Mv5cw-1
X-Mimecast-MFC-AGG-ID: UAXpjpjfPgG01kXu7Mv5cw_1790345941
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-532dc3793easo33823241cf.0
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790345941; x=1790950741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8xMZ+pyLoGVyLxuRkJ9G2Dg68OEOZ9ruIkCJ9U+ONpI=;
        b=QI5FkyVnlKY8wchp5ynY1i8Bp09bKhnwC/FmSNlmZA6etZr1jZ3rkVE83PBp/yFOHO
         e3NiuHve7lUsrVimuZyb1w4tJzJeVE9DkM6TW6ioPq4hq4qheuA7WP+VpzFkaNUlylvc
         gcDQujeEs+dYr+c/wVlG/rjfPoFcKIzc865RsLt/XUhPtx7BvhmRSvFWumaiZUtpwC9H
         Ik/rr41DaNn9oQNm59Xtld+8kLoJkXG54wulC1ZMlci9lHTaEmM5FE1nLTq6A6PTVxyr
         G/8bnbe4UTSJt3e8I7Plu68/yYD/Jp6vBN+ElYMkRqxLbNIiM6zwnCL+Y1SL8wOsY2cw
         scgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345941; x=1790950741;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xMZ+pyLoGVyLxuRkJ9G2Dg68OEOZ9ruIkCJ9U+ONpI=;
        b=H4GwcH9Wmg4q2PaCPpP54kzI8buzOFZwSQ6w30zNnx+CkZnXXn6gpSPj0LWXa3IlJo
         qLw3MAhLD7LxoebjlQ/CLzOKYPYZtrWLh/cu9um4L4S9Ucu6zGc3euDyQAHluHtAMLUu
         NJG4Lz6NkJnXrmxm5OFU8v7M3Ov1rMWZViKzMynJKb7GBRlAufB+2G3l0lLC0+U+Bk8E
         oR5MLWAruU65fjraJshzCwBBdjFydU1S+eFAjqyC5VzhpTikLVnGubwtD+BEUrpOfGYo
         Ew3DXCtavUJrqtCMD/whNdDzj7jjEYwT7oJXxreCszmPUHt6IYQVo2Kb3wbFv4VfzdoY
         QhAA==
X-Forwarded-Encrypted: i=1; AKwUvBxTfLT1epTb+RLokE3Qm5WDcb/6ImmIRviUtbGJDw0ok6S3TVNgupEDuyAtU1aBEa0BsvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l2n8K6VvRWUNwVN82ttelvqUriMOFDWr55gIsl0WXmQsL9A39w
	RAdxxOboY10H66L2OnXSfJ6+mQl9AS9S2ni2OaA7VuadoCxI8nuPZ40GlMUtzxcUN2peqLi7Ymy
	6BwHTKQTplXJoqSyfyTVxLmbbnQHT1eO5pMlv/UPlDR4hVBrA9jEsPQ==
X-Gm-Gg: AYBFou1btX726TeaZ1gdmeEUsd645epb6mmuZ17chyOtqE6iewMUxOiF3RByKJhObMZ
	Zw0kM1mmxr2f73VlH5n7u1JuizFRtGNs71RD7rLmrMy380cQUpPjpEVXmnQFApbjyV82CIV2xot
	Q0TfPtOhlZrxgq5d5mZoRCoaYpb34aZQ/injN/HDpp1DVZh+7sQ/FwlZRv824YiiNMMFbP2AHxB
	KVje7kyDGL9ygHF+xaQy9Fb3JMHId1dN7K6pr5jDe8tyKHivvRPlZsMA3EKnyTlLk7o90JWpvCr
	UsOzHnNSHDvw2DkLF+u8lzFVaD48Mmy7pHrl4fhDn+wErRqDp4O2P2pa9MRYCjqAWZrKIG7E
X-Received: by 2002:a05:622a:17ca:b0:532:c06d:5853 with SMTP id d75a77b69052e-5330b5f4cf0mr36801471cf.10.1790345940469;
        Fri, 25 Sep 2026 07:19:00 -0700 (PDT)
X-Received: by 2002:a05:622a:17ca:b0:532:c06d:5853 with SMTP id d75a77b69052e-5330b5f4cf0mr36800901cf.10.1790345939814;
        Fri, 25 Sep 2026 07:18:59 -0700 (PDT)
Received: from localhost ([2605:8d80:6cc8:ea22:c432:5f8a:27a5:d9d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330c0b999fsm15882021cf.28.2026.09.25.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:18:59 -0700 (PDT)
Date: Fri, 25 Sep 2026 10:18:57 -0400
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
Message-ID: <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>

On Wed, Sep 23, 2026 at 09:27:52PM -0700, Kishen Maloor wrote:
> Hi Peter,

Hi, Kishen,

[...]

> > IIUC this is the fundamental reason why you hit that PAM issue: at a
> > specific GPA, QEMU/KVM can map different things, hence GPA is not yet an
> > unified identifier for a physical page that guest uses.  However, (slot_id,
> > slot_offset) will be.
> > 
> > If the migration memory access API will be using that instead of GPA, I
> > think problems will be gone because then the PAM regions (likely, pc.ram
> > underneath) will be migrated in form of KVM memslots, destination apply
> > that to the PAM's (slot_id, slot_offset), then when switchover, that PAM
> > memory region will be enabled by QEMU and it will be visible to destination
> > QEMU when VM starts on destination.
> 
> I think using slot+offset won't make the problem vanish, because the PAM window
> in the underlying pc.ram region is not addressable by KVM on the destination at
> that time. KVM's memslots come from QEMU's FlatView at any moment and QEMU
> reconfigures them on the fly. In the destination's boot-time setup, it seems
> like pc.ram's memslot is split around that window, and what covers the
> range instead is a separate, read-only memslot for the overlay, which is an
> allocation with its own backing, not the pc.ram bytes underneath.
> And since only the flattened view is ever registered, there's no slot+offset
> that refers to those bytes either. Only when the source's PAM configuration
> lands at the destination, which happens after memory migration concludes, do
> those pc.ram bytes become visible to KVM.
> 
> In the TDX case, QEMU does not create that overlay at the start, so the
> destination has a memslot corresponding to the pc.ram region that stays put.
> KVM is able to do a GFN->PFN translation to hand to TDX's IMPORT ABI.
> 
> So, it appears that a UAPI change will not address this corner case.

Yes, I think you're right, the ABI isn't the major issue. If from KVM's
perspective it's always convertable between GPA <-> slots, then it's the
same.

I believe my mindset when replying was pretty much in QEMU's perspective,
where in qemu we can have two ramblocks plugged into the same GPA range,
only one of them will be visible to KVM and guest (e.g. which one has
higher MemoryRegion priority, but it's not the only factor). What migration
module does right now is, it allows both ramblocks to be migrated with no
issue, even if one is not visible, but if it used to be touched, since that
ramblock will maintain its own dirty bitmap (GET_DIRTY_LOG on that kvm
memslot when it was visible to KVM, or maybe set within QEMU userspace
somehow).

IOW, what QEMU could do here is, after MEMORY.EXPORT, convert the GPA
address space into ramblock ranges in QEMU, migrate with that not GPA.  In
case of PAM, it's part of pc.ram.  Dest QEMU sees it is pc.ram, it should
"apply" those data to pc.ram ramblock only.

For non-CoCo, it's as easy as writting to some host HVA pointer.

Now, the question is, the new migration API only allows applying data in
GPA ranges.  I don't think with TDX there's a way to "apply" the data..
dest QEMU just booted, this specific portion of pc.ram may not be mapped at
that GPA source fetched due to reset status of PAM registers.

That (rather than the ABI interface), might be the real thing I wanted to
point out.

Maybe it means TDX just can't work with it by definition?  I think it'll be
fine, and now I wonder if it means PAM will be working for TDX only if PAM
boots too early so it was before TDX initializes, then after TDX enabled
anything like PAM will not work anymore?

So it seems TDX will "lock" the memory footprint in place when enabled,
allow accept/unaccept (or say, plug / unplug) memories, but anything like
"flipping this to that" will not work.

Then there's a very corner case question I want to double check, and I
apologize if this is stupid only due to my ignorance on TDX knowledge: can
someone migrate a VM too early so TDX is just hasn't been enabled at all?

[...]

> > I'm a bit surprised that TDX will also monitor how many times the same GPA
> > is updated per iteration.  What if below happens:
> 
> Yes, and maybe that is because it won't know the ordering if the same
> GPA were caught at different times in the same epoch and fed to different
> migration streams (which one is newer?)
> On regular VMs, I believe QEMU doesn't migrate the same GPA twice in one round.
> As I understand it, a migrated GPA is revisited only in the next round.
> I suppose TDX just makes that behavior architectural.
> 
> >   ...
> >   ITERATION sync n
> >   GET_DIRTY_LOG, see page P dirty
> >   migrate page P
> >   GET_DIRTY_LOG, see page P dirty again
> >   migrate page P again   <--------------------- [a]
> 
> QEMU shouldn't transfer P again in the same round, right?

I believe yes with current QEMU, I can't think of anything otherwise.  But
still, this is very specific impl detail.  There's definitely no issue
migrating one page twice or more in non-CoCo.

I can give one example to illustrate what could happen.

In postcopy, we support preemption mode, which is simply a separate fast
path for requested / urgent pages.  It's possible while background thread
transferring one page, the fast path saw a request on this same page.  The
current algorithm is simple, it will wait for that in progress background
send to complete.

But logically, we could do it the other way too: send the page again on
fast path, in postcopy the page content is guaranteed to be identical and
unchnaged, it means the fast path can land this page earlier, reducing
fault latency.  If so, a minimum cap we need is MEMORY.EXPORT be able to be
done twice, so the fast path can read the 2nd time.  IMPORT is more
flexible, because QEMU can maintain what has been applied, so logically
background loader should be able to skip the 2nd IMPORT.

That is not a good example, at least because it's postcopy and doesn't
happen with precopy. So far, I also don't think a major risk, but I confess
I don't understand why TDX needs to add hard requirement on "only sample
one page once per iteration": even if VMM sampled a page twice, it's still
encrypted and confidential.  I believe it has something to do with the
whole attestation logic.  I think it'll be more flexible with less
restrictions, but no issue I see either, hence please only treat that a
verbose FYI.

> 
> >   ITERATION sync n+1
> >   ...
> > 
> > Would above crash on destination TDX at step [a] applying P 2nd time?  Or
> 
> If P were migrated again, then I believe it would fail to import on the
> destination, and also abort the import session, so migration would fail.

I wonder if we can just fail the 2nd IMPORT without abort the whole
process, then if userapp wants to detect it there's a way to (similar to an
-EEXIST).  Not a request, more like a pure question.

> TDX records the current epoch against a GPA on every import, and I think
> that's how it catches a 2nd import attempt.
> 
> > does it mean GET_DIRTY_LOG can only be invoked once per iteration?
> 
> We don't touch QEMU's stock dirty logging/transfer flows so however it
> handles it currently stays.

I see, then it should be good.  Just to say, qemu may sync dirty bitmaps in
the background nowadays, can refer to cpu_throttle_dirty_sync_timer_tick().
So it can be decoupled from iteration runs.

Thanks,

-- 
Peter Xu

