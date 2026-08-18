Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6D3290B9
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787084333; cv=none; b=WEemdZavSz5AhaZgCXNKXv5s1AXF095Byt/zPqA3ppbaq5RLLiFzxB0rReJ+NLEmgERI7dizu10QTpeFr9kg+tpxoe8fnH/AKbfPf71NjC0TB+omVFlU/JjWShI9Fzk7mWi6f4tj2Gdg+4ed+7PAqbVURjs5rgAwrjm+PHm7Aqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787084333; c=relaxed/simple;
	bh=aFdgLI/M3aEQ4R3ESMTBC/jZAtaSl6H36QPK89eRHNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AMdFqWiVSP2dZaHAlPkEVr3814wJh+QBoxJnJLaz9q93pSQhHAVDCV0t1SPolsB8Ah/KymeKT5xwARkS5HIUIlH89MpDQEeye0qcp8XoZVYNgr8ImUQ9WQ/arpD0Xk9rD2SHESshG/bRHOdPhRy3PJSA7eN88ej2jkMxKl89LLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2d0E/Ap; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2d0E/Ap"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so113381a12.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787084331; x=1787689131; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nd1e46G1OcgkU0Lw/9KLj/QTAAA1ra7omauJvV2lvM=;
        b=Y2d0E/ApojzEQgwILIZSfe4Pbq4QwM6m+Zvfr4+egBR0db/FlxjqjHxeVhTBr+ap3e
         trS6UrdUGb/UJebKIEIq9wVVwkhVSRrI5yYIUzSC1Iij5zbNu8pOr9IlJFopVOyV43sp
         i7ve0QwlaQij4m9ws1IUeUs8QTDyIQ0UmJIC3ItdqLL7iPME/jaZ6U4rXqvW8dXRwmOn
         gRyIHTnhlwv2339eL6Ag6Rhv9PBWGiYrlAjcTw0G7bBoPUliWjOLQ8eJFUkVNbiLGELT
         RH7CcclSaL8HD3UDLxjqYeTFMpzroGoUoWLdry8zgNo+Kvb0T40IGbPHJH3DcxODFZcf
         Hl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787084331; x=1787689131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6nd1e46G1OcgkU0Lw/9KLj/QTAAA1ra7omauJvV2lvM=;
        b=somJnf6Q3KvPWwfePvmQrwZ/CJHlho1ZbNTp23zF8NuK0HXpIdDo0oqdCCtb9F5emA
         c6j7QCiFAmqNQOPND3aItaJv/iVMcpJaInMwmzqTsJlz4yHTqxaozuTLSr6JUa+SIaQ9
         F6U1sfXigM8drBd1Xu/J5EfhrhMVssD1jP3Y7AnASfiu+Uh2+kvXtniHfnesAVCtcIHX
         pRUO7TnitUNxwg0sxDVivujayFjqDlcleOdLC8LqnG/FrEu0ezsuAVjmLH/z9VtRz31k
         cASfJxFONAuHqvexAtw1cE7xj7KRtIRpekYA7R53lnhF9wVmfeapcpunxiQ2aEY1OO9+
         ct1w==
X-Forwarded-Encrypted: i=1; AHgh+RpB0ioBNZT7obbgdDh2Zfb2+FkXxW7CSlTOQIupis0plfZZve7GWig4xrsIXmDh44xsFOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykgqerHv0sU4Ne1etUOiy9e0syfYN+99dwCgRnKl+3MsaiyKXl
	E8D5+zVkLlA3RIR6hXZxtD8HggrnIfiQ0IFcgQDWWrAbMwLX7i/wFYgLE5n5zNtfQKXHwgqoxoo
	BBr4Rtw==
X-Received: from pggr13.prod.google.com ([2002:a63:d90d:0:b0:cc1:5039:f21d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2446:b0:39b:bc11:9ec5
 with SMTP id adf61e73a8af0-3ccded40c3emr8553153637.13.1787084330881; Tue, 18
 Aug 2026 13:18:50 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:18:50 -0700
In-Reply-To: <8c121997-6673-4d5b-927e-be74b5779059@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812080229.2481439-4-xiaoyao.li@intel.com>
 <20260812082306.11E8B1F000E9@smtp.kernel.org> <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
 <138969948dac13369ddebd72bf523dda4dda6b85.camel@intel.com>
 <an5W5XC97HK229MX@google.com> <eddf28d4-c211-41fb-b0a3-586e5afde030@intel.com>
 <an8wUfZ9JxvEhtHS@google.com> <d67eb097-1223-4b68-92d4-1510d3d7be7c@intel.com>
 <aoNQpP-BQKiZL47O@google.com> <8c121997-6673-4d5b-927e-be74b5779059@intel.com>
Message-ID: <aoS-Kqz7lwt1baqg@google.com>
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 18, 2026, Xiaoyao Li wrote:
> On 8/18/2026 2:19 AM, Sean Christopherson wrote:
> > On Mon, Aug 17, 2026, Xiaoyao Li wrote:
> > > On 8/14/2026 11:12 PM, Sean Christopherson wrote:
> > > > > > And once we track the exit_reason separately from vp_enter_ret, IMO it all becomes
> > > > > > more logical and easier to follow.  vp_enter_ret holds the information about why
> > > > > > VP.ENTER returned/exited, while exit_reason holds information about why the _guest_
> > > > > > exited.  Obviously it's imperfect since we're still fudging EXIT_REASON_EPT_MISCONFIG,
> > > > > > but again, I think that's a better alternative than demuxing exit_reason in multiple
> > > > > > locations.
> > > > > 
> > > > > The question do we really need to swizzle EXIT_REASON_TDCALL to other exit
> > > > > reasons ahead? why cannot them just be handled in the central handler for
> > > > > EXIT_REASON_TDCALL?
> > > > 
> > > > Because as above, it's not as central as you think.  If we want to not swizzle
> > > > the exit_reason, then IMO the only sane way to do that is to not track exit_reason
> > > > for TDX vCPUs, i.e. move vcpu_vt.exit_reason back to vcpu_vmx and force TDX to
> > > > always demux vp_enter_ret every time.
> > > 
> > > How about adding a specific field to track the TDVMCALL leaf? Full diff as
> > > below (the EPT MISCONFIG part can be split into a separate one)
> > 
> > I like it even less than demuxing vp_enter_ret on demand.  It has all the same
> > flaws as demuxing vp_enter_ret, because it's effectively just a cache of the
> > result of demuxing vp_enter_ret.  And caching values on entry/exit boundaries
> > adds additional risk;  I can point you at a number of bugs in the past where KVM
> > consumed stale data, e.g. because some chunk of code got moved to run before a
> > cached field was refreshed.  That's unlikekly to be a problem here, but anytime
> > data is cached it introduces risk of consuming stale data.
> > 
> > And the cost of demuxing vp_enter_ret every time doesn't concern me, at all.
> > What I don't like is relying on call sites to know that the exit_reason needs to
> > be demuxed in the first place, because that will be brittle and error prone.
> 
> Do you mean that with my diff, the consumers of tdx_is_tdvmcall() rely on
> handle_tdcall() being called already?

That's one of my concerns, but it's not my biggest concern.  What I'm most worried
about is providing what is effectively an incomplete vcpu_vt.exit_reason, relative
to how vcpu_vt.exit_reason has been handled by KVM for years, and still is handled
by VMX.  It essentially violates the principle of least surprise: years of experience
and huge swaths of the code base will result in developers expecting exit_reason to
be _the_ source of truth.

There are obviously cases where additional state needs to be queried to handle the
exit, e.g. most visibly in handle_tdvmcall().  The big difference is that
handle_tdvmcall() only deals with "new", TDX-specific functionality, and it's
analgous to kvm_emulate_hypercall(), i.e. it behaves pretty much how the majority
of developers would expect it to behave.

> If so, I get your point.
> 
> > That's why I'd be ok if vcpu_vt.exit_reason simply didn't exist: it becomes
> > impossible to check the wrong exit field because there's only one such field.
> > 
> > I'm ok caching the fully processed vcpu_vt.exit_reason, i.e. with the code now,
> > because only the TDVMCALL path needs to be aware that it may have undergone
> > processing, *and* KVM can WARN if that processing didn't happen as expected.
> > 
> > Whereas checking the "right" exit reason requires doing so in multiple paths and
> > doesn't have a natural sanity check.
> 
> I'm OK with it.
> 
> After changing to use tdx_is_exit_reason_valid() instead of checking
> (*reason != -1u) in tdx_get_exit_info(), the only issue is trace_kvm_exit()
> prints 0x0000ffff when real EPT MISCONFIG happens. But it can be resolved by
> your suggestion below. So current implementation can still work.

Yep, that's one of the reasons why I don't want to overwrite the exit reason.
