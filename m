Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0043BB100
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770839; cv=none; b=hidvQTxaNJCXK+s+eyeaC2uUI1jlMHowJn9Oyj+8D21u00D7luDxnNwyW0QZyL4aexglz6QnugQbF54TAtFB4ualx956y7Hiey+27I7E/itpxDZwjh9B0OCdcsxADtAAk2CNndmPVqJqPneBZ068pssy2jfiZkC52j67jkqQK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770839; c=relaxed/simple;
	bh=mi2j89WwttQiiJ4V5ZnDFMr50yvWkQvf0DWQ4eOlB+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZObk6q+RTwlrflvqxrzMmUDQcJUcxUdRuXZCRlfiT2jR3+QhsevsuidEJIFo7/rBDlsgG6nFS/9ZwgUjEN9HAARUSSQMlyCe9Y28Op//xdlU6Vlxcp8bauynGE5V7mBZavzMHzGL8FdmatjW3VNpypIxYfGR9bXn+T9ohl4bRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KI5aVo06; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KI5aVo06"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e2ebeaa0a4so2748875ad.1
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790770837; x=1791375637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nyn15uH7SjzrTyQYpR4Kf4Qwo/XydgHO+DYB7E91HzI=;
        b=KI5aVo06dMUFKrpUspotOz7+tG1Sm4puPSG5Re11NDdhHqCU5iqEAzutjP+Lx68D7f
         J394eu6OW1MDfL+6LvPcrbPxfisuToTjldYm8AyiGs9vs8T5jFUDy64vjDR/Iq7oQWIY
         i/1ClDn77Jmpjhe/oTp9sjpJrJwcGaAM4JAHiu0MR80nAPJ7NiGvjnz86qTNtSNN+Cfm
         cQ+s7rnP8p4piEe1puhAb09C4IV4LdEsf51kKPnKh5JP/znMPpM8A+sl1QllYxs3Fr7Z
         NJik7qfYbjXeadKFZ/dCH+D7t/IjJKezSfEy53xjwj3k6wsn9xVLcjQJ8HR8O46AYITw
         Nmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770837; x=1791375637;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nyn15uH7SjzrTyQYpR4Kf4Qwo/XydgHO+DYB7E91HzI=;
        b=twDQrZ1JRQzhRzk0rylcADTWc7uL4ZJvHND1EDpdW2ZPKYjD41l77JrC1L20UfFc2E
         ceplyCnyArE2C3W1g9elzB7G2X59LsCHu6q8hqFpC76kEnaIqjxlBn2NJ+X1a90gPIdN
         6oUXGH2AJaoT54JIaao8OaDZMqlbF67amXlXTcPDtQ+DhZ82CjlfdteossvNx1TFJ4ut
         WETg/fHs1Y1HCRSqy8ow4OyXpCc8H7o384axjoQRJUlrVKlR1I//PfZlJ319FZ56oxYw
         b1KyI7+oEnQsVZahvUikv/6bnVHSD6RwJnmy2XX6yz0hZ9bUHpN83JS7GcfVFf3LQP9V
         /IDw==
X-Forwarded-Encrypted: i=1; AKwUvBzCQd0o1A04AesuXC2mj7TSemfLnxy2JGEfLYRPAcTVQaCDcjhCfiZ7jrnOfINf4YNPZvs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcmbJOexR1m4KBOsBew9uVTE5MkGdGST/vzKEAhEAjvKEejekZ
	iwU9QCDlER+UreZfbC+/f8mEO3hPcZYPOhnLCpJW5qi3MECPCjm14I9KkM1iQyEuN2ZN8CwKuRH
	CovueoA==
X-Received: from ploc24.prod.google.com ([2002:a17:902:8498:b0:2cf:bf3e:41f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f91:b0:2df:b5c7:d0f1
 with SMTP id d9443c01a7336-2e2e4b5b928mr8752095ad.44.1790770836724; Wed, 30
 Sep 2026 05:20:36 -0700 (PDT)
Date: Wed, 30 Sep 2026 05:20:34 -0700
In-Reply-To: <CAG48ez0zfaEgWoFiLyVLu_ZU8XtJoKVoyMrnxMcLX6e+3j0jgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810-x86-kvm-setpagedirty-v1-1-85f180892d4f@google.com>
 <ann8aPLSgLzz_6L_@google.com> <CAG48ez0zfaEgWoFiLyVLu_ZU8XtJoKVoyMrnxMcLX6e+3j0jgw@mail.gmail.com>
Message-ID: <arz-kvd4jWnEFAoq@google.com>
Subject: Re: [PATCH] KVM: SEV: Fix page dirtying in sev_gmem_post_populate()
From: Sean Christopherson <seanjc@google.com>
To: Jann Horn <jannh@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026, Jann Horn wrote:
> On Mon, Aug 10, 2026 at 6:29=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > On Mon, Aug 10, 2026, Jann Horn wrote:
> > > set_page_dirty() requires that the caller holds some kind of lock to
> > > ensure that the page's mapping does not concurrently go away.
> > > That is not the case for a random page we got from get_user_pages_fas=
t(),
> > > so use set_page_dirty_lock().
> >
> > FWIW, I verified that __kvm_gmem_populate() unlocks the destination fol=
io before
> > post_populate(), so we shouldn't run into deadlock when in-place conver=
sion comes
> > along and userspace does something odd.
> >
> > > Fixes: 97cd21d57e9b ("KVM: SEV: Mark source page dirty when writing b=
ack CPUID data on failure")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > Note that I have only convinced myself that this is a UAF bug by read=
ing
> > > the source code, and I have only compile-tested this patch; I do not
> > > have SEV-SNP hardware to actually test this.
> > >
> > > This bug was introduced in v7.2-rc1, so if we can get the fix in befo=
re
> > > the 7.2 release, this won't require a stable backport.
> >
> > Ya, that would be lovely.  Paolo?
>=20
> Ping?
> I still don't see this in mainline or in next.

Ha, I *just* pushed it to kvm-x86/fixes yesterday, it should show up in tod=
ay's
-next build.

  https://github.com/kvm-x86/linux/commit/9e389110fd668958735141af24d04ed04=
0776235

Oof, but it looks like Paolo force-pushed to kvm/master (accidentally?), so=
 I'll
probably rebase it today.  I.e. the hash is likely going to change (but I'l=
l
still send it along for 7.4).
