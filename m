Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70941835E
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404020; cv=none; b=sFTi+J61Unisg5n1y9tjfjkARwVKbG2guhR9h/mcmUgUyeSlT1mqaIhIj582oDxLljCALM2UsJRIZllj9TPuAgz00T2qCYQCneGKKFAsKCpk4SiFjBijsuhCs5t7t1UZRmQ8ggW3ni88KNl1FIaqqhz8/ftamsAiQg5hlEhBnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404020; c=relaxed/simple;
	bh=bDPPL+xSN7wVBevHoijfjwkusUQp4WhupxbSvPfKm08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv0Qmr6Zx7cECvWzA5ZU/K1GEp8X+7vlmK4zP/L5IsD0n4eoXAXpparxxrS1RdLn6T55h3lWdXj2WDnEKSZrgEttcMo04BfMYM1DEf+FkCsEs0/9bH6K3UcStRMUaX+HsXDrdJ6nI8y6xcXcMD2gT3KT3FQO1JgfPL6NOlgnmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Co/dwFtI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4IX89F0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co/dwFtI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4IX89F0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791404018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//UQkCEcyIPeEhEWoYggzeyvma2oUE5PLsh7lydCoVs=;
	b=Co/dwFtIG9INfrgJ+iaaSQYN+XEoq8KpUnCW0G+W4JJSqMtMRUaIwBAYFb8UEthXNuobpC
	Sz49A1JVkrfglTMq+l1a/4Ap1rHDTLJpCNtNk2xWNtP3E8r8nef8Xf8bvYns+IRGCJuxPq
	4cyJI5IYm8D+38N9o3+ZGR7UHIRLrdE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-WVygRSmaNuW5ukidrEBg7w-1; Wed, 07 Oct 2026 16:13:36 -0400
X-MC-Unique: WVygRSmaNuW5ukidrEBg7w-1
X-Mimecast-MFC-AGG-ID: WVygRSmaNuW5ukidrEBg7w_1791404015
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a082c014aso90021885a.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791404015; x=1792008815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=//UQkCEcyIPeEhEWoYggzeyvma2oUE5PLsh7lydCoVs=;
        b=A4IX89F0gL1gmQy7dgDzFnoCvIBKxLM/qZyJPzvqm0MYHCT4fHS86RVD0mpN6Fkrmp
         U5Z+cdJBXD5VJKYeh06n5Rv4yFKtp1n+rQmoq7j7jHdtXziiAfy4fMCUfhDPPtXCnSlS
         4/CcBz1kZYY3b/FNKPQeVBIWR17lOzZj8qBlDn5MbOAd6YuUrTfpWc127Fzp9VTun37R
         7SdcuL1Had/wUoDIMaiP2OS/BbZcXV6zMzWq4uFYeb8/l5y/ZJmTo5N571bnqtmlFtrD
         yCU7ZQYeZWtp8bhFyaHCBdhZ8swr6Yq+FwSxiB9s3tJUCf+OvvsziazDarGBBcnA2uFX
         A+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404015; x=1792008815;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//UQkCEcyIPeEhEWoYggzeyvma2oUE5PLsh7lydCoVs=;
        b=sIIWNEm465xE1Xw8ACEYOTcxPdc9o1mS6U0BlhJhm9yAdxXx9zZse7p52bN8g98mjx
         raif+qeIZtQvSb/WAXssR/WaMqzpjL1WpMsyRlZ7LLrvEX/wv9BaWVcFgi0UIw/g1CjS
         h0TCA/0MCcdcgKHIHVl0+5bVf1Lqa6h5f5eLCEYDDnFNyrJtVtVS8Rs7KykUUlXrkozU
         OEDKWsrT9kGw2K5/1hsdNm5tKNz2xtmGwHLptA1VGnbMtHPIn+CaictEHN/PXrA5axJr
         Te8c2v1tYJpkQ4e0pPPcjD9QlrAp9b479E9tomZurmlC0hHKtILFkJyzUqVBkFOR+Uo/
         FJSw==
X-Forwarded-Encrypted: i=1; AKwUvByLBTtyLMbhHzARemlW/y2LOu59LNr7SIw3iKQbDZ1SA4F16SDiUYc2aS1qJhmcXfWi74Y=@vger.kernel.org
X-Gm-Message-State: AFuF++myEIdHm8BpdCuk/FQGJBCH/x38B5Q+26e8eLkY7BhXyTkPUiLi
	57UT2+AjKmd5fEp3JmFigwEbcstG5xH6ke9NkiumqFcRTE+zA9PJ6WHnVQ8eH+Ax6IpDzU0K96u
	v9A/aCC8AiOrnRc4MqOVXenFmx96yRmpH6xa20uAj9jSD1nMQ2sCfbg==
X-Gm-Gg: AYBFou1+5Q++LTKvHRdVx5BeXcFv9u00fM/aY3wQatVgf8O2CXTteu1BZFp69K6QUOh
	jvjEfM43QyyTmiP85dfPJhvB/EGbutYFBPb98+G+9e60EmocUS5J8Wn9VtfAJ5enFEzDgpeNxSN
	GHAryrI6zv8UVFQ1yXvh77idewmModKtmWFmgVMbtmhBFoZzpRy5IXN5pvkH2uL5hzoPeaF45PL
	G1IMqvYtlJg41pFBe6y/qhF0ItU9+zmPXwtABUtJhgB29otjZ7rJ8VJEhuIZoK6leYX/A0x97OZ
	ieDMwLuspJJyRrbGLWuSVJs9yjxsqVcT5tSnpyya0lyKcjic9o05TgDZ03cesKQ+K6FJ/wE=
X-Received: by 2002:a05:620a:2911:b0:93e:9808:2e1b with SMTP id af79cd13be357-93eab1d6bcamr49959085a.40.1791404015141;
        Wed, 07 Oct 2026 13:13:35 -0700 (PDT)
X-Received: by 2002:a05:620a:2911:b0:93e:9808:2e1b with SMTP id af79cd13be357-93eab1d6bcamr49950185a.40.1791404014547;
        Wed, 07 Oct 2026 13:13:34 -0700 (PDT)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991ef47bsm292631285a.42.2026.10.07.13.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:13:33 -0700 (PDT)
Date: Wed, 7 Oct 2026 16:13:32 -0400
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
Message-ID: <asan7ETOVEZqRehY@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
 <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>
 <ar10Ncg2-GhzgBR9@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <30006d88-6679-4274-87fe-f1ce8732577c@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30006d88-6679-4274-87fe-f1ce8732577c@intel.com>

On Tue, Oct 06, 2026 at 09:27:47PM -0700, Kishen Maloor wrote:
> Hi Peter,

Hi, Kishen,

[...]

> > Especially, MEM.IMPORT seems trickier to me: MEM.EXPORT even if described
> > in in GPA address space, can be converted to other address spaces at will,
> > as long as QEMU has full knowledge of the mappings.  MEM.IMPORT, OTOH, may
> > not trivially work in GPA terms, if memory mappings can overlap.
> 
> I can appreciate that. Working in GPA terms assumes that a GPA reference is
> unambiguous over the duration of migration, which holds true in the TDX case.
> 
> But it would break if another backend is able to point a mapped GPA at a
> different protected page while keeping both pages valid -- essentially
> the PAM case on regular VMs.
> 
> One option that comes to mind is to add a 2nd optional identifier to
> kvm_memory_transfer consisting of a guest_memfd fd and an offsets array.
> That would be at parity with QEMU's block+offset and directly reference
> specific storage units. Then QEMU and KVM backends for a platform would
> decide what identifier to use.
> 
> The value might be that a bundle could be accepted by a backend for
> storage that isn't currently mapped in a memslot.
> 
> OTOH, slot+offset as an identifier might face the same problem as GPA in
> this case when a particular RAMBlock's storage isn't mapped at the time
> on the destination.
> 
> Not sure if this idea is viable or even makes sense; this is mostly
> for discussion, but would appreciate your thoughts.

Yes, I would think (gmemfd, [array of fd offsets]) a nice interface.

If we say gmemfd is the container of data in KVM world, then if it can
provide all data accessors it feels all natural and fit.  And yes, it also
works for overlapped.

Said that, it's a matter of if, TDX or any other solution, will use GPA to
be part of attestation process when loading the data.  My intepretation is
GPA was part of TDX MEM.IMPORT workflow and required, but now since you
proposed gmem for indexing pages, maybe I was wrong.  In this case, I'd be
more than happy if I was wrong..

Thanks,

-- 
Peter Xu

