Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D573246EB
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700692; cv=none; b=sU81Qin31K4v3hAnwWhqhYSmOWvRmR0rmMz4Oo9PWkzZAdcOIiw2CNSU03MesY+1RVNyTIZB+l7fCcxGjdNvk+UnyBS4VtzcoVLWBCE2kXVrhuTgPdZBQLT80htI/nDtr6uzyepPmO81un+B711xMu7UmhmeH3oaR00xu13N+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700692; c=relaxed/simple;
	bh=D5I861o6DHnnZPcXsrQsCslUpALJ13+o3vWa7cif8IY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rWctOEfRH+EHvbkyS2+VpaOsBnSxG7jNXpj3pocqM/6RVdVWPYpt4s8+0NC7Tj7MfAXDl4aAP4vTbgoCzH5xqdCTUw7C3KKCakVqbzXf/z2niZepDRZdxZLbaTDbVacF+M/kk9nrtBeVJH1lGeL+/mCUBWib9wo/XJS+Pn6peEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ir0QRA6X; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ir0QRA6X"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38db4fa2e25so747930a91.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783700690; x=1784305490; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTZ2cJ3utRSlJiB7oiSYRPEpHkCgS+48KCpDPcXX7C8=;
        b=ir0QRA6XlIDbaFcE8Ipgz7UvP9cFPUniiHZSsoyWKWzGk86gXS3XIAmWjnGdDcskjy
         j1TdOTwB3+Vudy1OeYY+0JQdAYqOy2RrgPaoPawY2+XiOLN7CIsh8D+ncfah7ShK+O3R
         2xWvQKhkp8jMWUqAjpbWQJgbPuqn0FxKZNCtPXcu6ujQMwNO9LnfG9LXA7W60IeojO4o
         yJ7YI2u4qfoCJ1gqugiwzr5/dGAstSSKtnx6uGA5BX6l9PegGYnAC6wa+cKYPBeBztFi
         R58jS/fO8fDVTjE2GVKsyMXsPTqO8i/w5BuEeIll62OAcgSBEwmAPnFQZ42q8EVAqtJ9
         OPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783700690; x=1784305490;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTZ2cJ3utRSlJiB7oiSYRPEpHkCgS+48KCpDPcXX7C8=;
        b=jjkzSEe+IadvXpnvT6on7+6lK9fomavnL8MjXeqXfrSaE0Cim2Ef0GxOndSaGrLzQa
         U3lNagoyUceiEgfGEVyZHLnnrX8bi8Hcujyibi5fzHJUfl5QMnjdT+jOOngIoW9REtL+
         f7Vk10+rax3gwIicCJSeCRvhBxpF+hDr+KFt5ZADmoZT+HUkZIM5F29VTwGA939Nddf6
         2Nq0awPngWW/WNktH+4TSfj+0ik5mtGyBloKVjKuIRrp23a67XwIvfzR6C8uDzIzqccO
         veeJKl31NmwXRICTVC7HR2Q/ioqf9Oa2Ynj/RhGNFNoGmh8TiENxcqV3E5o7TAyVx8WL
         X4TQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSfsUXREY0X7UUv/snuqJA7qCuxpvKXgfS+MhPBoRu3fgXBvOTt7k9mjyfZeQEoOQtdUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzu+vR+KbYikYhft5CBHmhvUg7MTm714IQVv8j919z1Hk5aKVo
	ZqesPi2JUqfWh66zFhuSRJDW1d4gV2HUtj8Wi+l68SA3IMaLlmqcbib4GiWrI77JCgwO9r2kxC3
	INhuTcA==
X-Received: from plbjd24.prod.google.com ([2002:a17:903:2618:b0:2ca:5d68:247c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e842:b0:2ca:ef16:8e8
 with SMTP id d9443c01a7336-2ccea45ebb6mr135458995ad.29.1783700689935; Fri, 10
 Jul 2026 09:24:49 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:24:48 -0700
In-Reply-To: <alEZIuJhv5ZXGQac@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com> <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org>
 <ak-uER-RndpksnhR@lucifer> <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com>
 <ak_A6Yc5mBXCrtXr@lucifer> <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>
 <alDtzM28CgZJn6FF@lucifer> <62ccb0f7-a619-41b8-944e-11ae2d0ce70c@kernel.org>
 <alEUBzV1cevuPYeD@google.com> <alEZIuJhv5ZXGQac@lucifer>
Message-ID: <alEc0I0VysX1p5Nk@google.com>
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Pankaj Gupta <pankaj.gupta@amd.com>, pbonzini@redhat.com, 
	tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 10, 2026, Lorenzo Stoakes wrote:
> On Fri, Jul 10, 2026 at 08:47:19AM -0700, Sean Christopherson wrote:
> > On Fri, Jul 10, 2026, David Hildenbrand (Arm) wrote:
> > > On 7/10/26 15:05, Lorenzo Stoakes wrote:
> > > > On Fri, Jul 10, 2026 at 02:57:55PM +0200, David Hildenbrand (Arm) wrote:
> > > >> On 7/9/26 17:44, Lorenzo Stoakes wrote:
> > > >>>
> > > >>> OK as long as that's made clear in the patch, commit message, comments etc. :)
> > > >>>
> > > >>>
> > > >>> Ack yeah I assumed it was a quick proof of concept and just overlooked it :P
> > > >>>
> > > >>>
> > > >>> Thanks!
> > > >>>
> > > >>>
> > > >>> hmm but we have FOLL_LONGTERM as an adjunct to FOLL_PIN (doesn't make sense
> > > >>> without - any checks that exist for that btw should be extended to this noew
> > > >>> flag).
> > > >>>
> > > >>> Also don't we want to encode the legacy aspect here?
> > > >>>
> > > >>> Maybe FOLL_LONGTERM_LEGACY_READONLY? Naming is hard :)
> > > >>
> > > >> I'm confused about the _READONLY, well. and the FOLL_PIN_NO_GUP_WRITE.
> > > >>
> > > >> We want to longterm write-pin.
> > > >>
> > > >> @Pankaj, how come you would call this "FOLL_PIN_NO_GUP_WRITE" -- why "no GUP
> > > >> write" ?
> > > >>
> > > >> I agree that someting like FOLL_LONGTERM_LEGACY_* is the right thing to do, but
> > > >> I don't see where this is "no write" or "readonly" ?
> > > >
> > > > I based it on Gupta saying 'without kernel GUP writes, and therefore not
> > > > impacting dirty tracking'
> > > >
> > > > I mean I think we definitely need some clarification here yes :)
> > > >
> > > > Not really got the bandwidth to dig deep into GUP again :P
> > >
> > > I think the KVM gueest *will* write to these pages.
> >
> > Yes, the guest will write these pages, but through KVM's normal mechanism for
> > mapping memory into guests.  The host will NOT write this memory via the GUP
> > pins though.  KVM needs to pin the pages because the memory is (well, technically
> > may be) encrypted (by the CPU) with a key that is only used/accessible when the
> > guest is active, and the encryption is salted with the system physical address of
> > the page.  E.g. attempting to migrate the page would corrupt guest memory due to
> > copying ciphertext that would decrypt different at the new PA.
> 
> OK so it's a pinky promise that you won't write to it via GUP?

LOL, yep.

> It's still really crap to just allow drivers to ignore this, which is asking for
> abuse.

Yes, the KVM API in question is garbage, and for all intents and purposes it's
deprecated going forward, but unfortunately we're stuck with it.

> Is this something we could have a specific GUP helper for that is unexported? Or
> does a module have to use this?

Module, but we can limit to KVM modules via EXPORT_SYMBOL_FOR_KVM(), which also
discourages abuse by only providing the export if KVM is actually configured to
be built as a module.

> If not could we use some whitelisted approach or something to prevent arbitrary
> drivers from overriding this?
> 
> >
> > > By disallowing writable LONGTERM pins on FSes we broke one existing use case
> > > that was relying on that to work.
> 
> How long ago did I break this though? Why has it taken until now for this to be
> reported? :) commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast
> writing to file-backed mappings") is from May 2023 :)

The break didn't come from your changes, it came from commit 7e066cb9b71a ("KVM:
SEV: Use long-term pin when registering encrypted memory regions").  I suggested
falling back to a non-longterm pin, but David didn't like that idea :-)

https://lore.kernel.org/all/akVAnGuiuJttE5-6@google.com

> Is it vendors moving slow to update distros? Does speak to the usefulness of
> testing mainline asap in any case.
> 
> I maybe missing details about the actual motivating issue here sorry!
> 
> Thanks, Lorenzo
