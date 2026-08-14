Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A148A2DD
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723493; cv=none; b=otgC5RYEJMQ8yP/C4tkd8bci6FzGKn0HYS/fyYuiaRg30P0Oet8+Z6jzSm/AK7wZBFpx3UVMCQjzQtlb/VUvz92hrS2V8r7fWsbJjUwQq47OGP+D1IpgQ+YopeGUU+frKlyHHkd5vMVTLs+4bMK/d2VBRkbDpxxQeO2LH8xw4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723493; c=relaxed/simple;
	bh=L7+zwvJ4nASrYVbjUeFFeoHP7BESPz4/u7WlgERYTLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QOC2KIKzokGWf74bJpU0uktNf//45U7DpaA05dOQfVq41OvbF1Smi+Oz3L17fyk+076HItgIm3f1G9SP5NHu599ir+fR5rw6zlMgwvOvSIMiH9QY0Aj2A5cH/WT7C32KAsSn1enCmQxP+7E6+jflXLH+v3/v/BVxBNlvBUZo6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0DEhB9v; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0DEhB9v"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c85798977dcso1660678a12.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786723487; x=1787328287; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M45GqPAfaWkAxTNfkHv5H0q0VgCGytksnXS+eq9PrHc=;
        b=G0DEhB9vz354JHNfrGcd+POi56pUytWxa/YNaE57Ndv6yY65lIMoIHehnTNJjfsAwu
         hkC8HyA+zKIf/v8+AsHoNqSi9A+ZBSjtKOqGIVqELpXOpDrkS+zBO/I5p6FQjfmFzETq
         5rHy13VchQoa4KIaxHRfR2/qz3AP8ov2f9NF3yrmU+gyVVxpdrL8gF5UMtu7hzO06j03
         //wBzvdTTxNQFegf4vFUXWk2FBD3Wo53yOrmz2gdjOCMD5tC6PJ8KMJ5AafNH/Nmg4G+
         1bydRtYpVfr9XsA6MmggzANfd9vGAyRHnfBsbaSUzpEKMO+31a5jvbRZstaJUqMBiVqB
         prew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723487; x=1787328287;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M45GqPAfaWkAxTNfkHv5H0q0VgCGytksnXS+eq9PrHc=;
        b=AH6vfsZPf9ER3qq+hF87BmlXLgGKBs+KvdaHVome3ksTq566C7ekAQZoiRYV/GYSUl
         3UQaemM/CuuGtE7J+z+ac5f2G7xGnzMWNLyxoa+JQq2J4Zp1DtFuMK9RKoNUglImmGy1
         Ngfu4UlAgIlKi/tf7Ak41LkRl3qI5KT09bpGXase5CYY/Lue0uMcNljgxt4SrlQGEuDh
         ++bExl1AiPeZ3a4sisR1Bn2oDdLGauRyTF49Iwb5BYPhHQ46vuR3WBSIoEt9UGYaMmYW
         O4roGlQ1Bxx8sEwOTFYM1CUeJmz47iiK0iVwVUnyjNhMOc8T9X4OUS1+Iw1IXaVTSLH0
         c0PA==
X-Forwarded-Encrypted: i=1; AHgh+RoMtXZzgUzOxHMB78RRjLEOQ6s4mP76ZZlr9b3VdLS8uv3mDjbZLhBgJNvHFcdMzfuWkYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFMJF/S0UOTpxNi7q+YA/uUgw76FlowjGw/PwVVOavMRnRKyp
	dgKrkk+VPe9J3xnAli9pH5SRue5Wn+RK75sN3382fmikZBFkkgb4HbZlO+KMyCslcDsL+dNuqVQ
	aQRKxPg==
X-Received: from pgcc9.prod.google.com ([2002:a63:1c09:0:b0:c9b:2759:d240])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f8a:b0:3c4:1916:9d46
 with SMTP id adf61e73a8af0-3cc71f4a5famr9143644637.27.1786723487045; Fri, 14
 Aug 2026 09:04:47 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:04:46 -0700
In-Reply-To: <an86rPn4P2dRO1RB@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ak-EKSslAz1uqEtv@J2N7QTR9R3> <ak_wC4Q-mQe14DI8@google.com>
 <alDI1b8fC99SG4_a@J2N7QTR9R3> <a127176a-1722-460c-aa84-754e1d343f53@arm.com>
 <an3sEiQlIuGEjUur@raptor> <b6080c23-a2a8-4bc5-b3bd-982bd766c648@arm.com>
 <an5UJ4S_P1LUFmzD@google.com> <487aa57c-72ad-453b-971d-ca24a8380429@arm.com>
 <an8SOvLybeilzCEU@google.com> <an86rPn4P2dRO1RB@raptor>
Message-ID: <an88nuw0FKT87a-W@google.com>
Subject: Re: [RFC PATCH 0/3] KVM: Dirty page logging for guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: David Hildenbrand <david.hildenbrand@arm.com>, Mark Rutland <mark.rutland@arm.com>, pbonzini@redhat.com, 
	kvm@vger.kernel.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	fuad.tabba@linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Alexandru Elisei wrote:
> On Fri, Aug 14, 2026 at 06:03:54AM -0700, Sean Christopherson wrote:
> > > That would be in contrast to user space having to guess that page migration on
> > > the current hardware with the current guest_memfd implementation does not
> > > support page migration, to then disable exactly that.
> 
> If guest_memfd picks up support for another feature that might lead to
> memory being unmapped from stage 2 without userspace initiating it, would
> you be ok with that feature being gated by another guest_memfd flag?

Yes, absolutely.  FWIW, if I get my way and reclaim is driven by userspace, then
hopefully such a feature never comes along.  But if guest_memfd does gain some
feature that triggers invalidations, then yeah, at the very least it would need
to have some knowledge of whether or not the associated VM supports said feature.

> I get the feeling we're all on the same page, that guest_memfd will support
> a mode where memory isn't unmapped from stage 2, and right now the
> discussion is more about how that will be implemented.

Ya.
