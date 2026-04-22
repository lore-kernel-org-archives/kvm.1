Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF019B5B1
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896250; cv=none; b=ADoo3+2iuSD87WMTDn1LMZhiZJAU1YQf1/agu6jEcbtYUmLUSXfyo/7lfosMgBiHwxUUBFtxm1FocUAP7xNHn/Y6bJMMmrckNO/xODyTIlyApXTpudVR8NCLtOicjyB52/OXiGlbPa9B5K945vmOFbMo5Yzyr1PtfhPJPUhXlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896250; c=relaxed/simple;
	bh=Q8pYJVlie9tGKXbQFm6Tei+v1DyKhC4dvB+Vbpf3jfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ja6ggRbe+Wa6TqTxMOOo/9+4QoUbe6ubbfryHSf6mnOjwbm7i02gY0a+PMy3GtYUKXvM23ly1zusyL14/LBybXGoNNiomOIJNsadO7Jh4msVvAz7/AOHA49IPoaiNFkRSdvFc2pqFSAvoz1oqfiPM86tJf5PWxlkLbUjhnVLJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2L6tjGW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2L6tjGW"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so111596545ad.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776896249; x=1777501049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAdumgiA6yNqtL11BDiLeexIbnD5eT6zsyDy41hs+Nw=;
        b=I2L6tjGWzs5yhlWLH1o/sSzDfcdD0qUzjetX0Bs1SZ40vIu/s11IE4E58/Ckn5arw4
         MmwKd0rdDiAv3rt+ZHyzb6sSWjpzfXBi9ou4OO54nNbMAUFCSIscMEXL7SKvyQODiq2Q
         o1li8dF/7GfsL5tGO/O7w8S5QaJpB93gPfYK9BPzrtFFMtlraNYPIrEiGKk/Qp/P3xkT
         tGKS3xhZDToQvu6oYalMbrRdL9onystpOh7O1J2KSrNh1hjCQ3ErWuCNJ5bjinL74E5E
         vPlc39RlFI7zDv7jSTG1/5NVtwY8GzArdJPaxabbYQQNbLDvrift0b+sO7FNZy4AP1Dx
         ftsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776896249; x=1777501049;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sAdumgiA6yNqtL11BDiLeexIbnD5eT6zsyDy41hs+Nw=;
        b=VqtgsbCQw8kd9bi5ubSpOUT2m3HORcSfKYBalXY1Wmab3gZccu9tc5+dxA5DeFu2xC
         gt5V1VtKXx1bwq/LicMwANMMEpgoIXq7tyj3dbu+qWfJ6MQN9nSAjVeC3pnYCPwIaIWt
         M62lPLGdVttTi2BNYy0qz9gYtoYDrQAVnW4jv7p2J2AQ/L6MO9jmFxzlDQeO8dE1esf8
         Geo0e9YldwEiuuTLCjSZNwLnbVnNrHq4PvGo+iUEVthxI1OazpLl2u4W+yXOO8IsBBy+
         6UYAjsVEv/a+j7uatN1oz+U2IkMMuCK/YarkOfI0BID9ZfzM0cATbmtSrUb4IIrumkVp
         0swQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Bt6yc0B7DzsEq15XwbEbWz7hXweBN1qeDS2hK5Eg7Mrios8le6YhgDrbKg6Zby+SgNFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzecby4Z2RsmQGm4YfJO8rs5kr6/0m3CwqR8wloGIAfijbIscHX
	+UNK/+BUTacBK3UEu6d2n1LSJR8VscMIGbKNCNxD3P9hqdf91hHYpQZLl5NVnzxScaLvcOmsK8j
	apUzCzQ==
X-Received: from pffv12.prod.google.com ([2002:aa7:808c:0:b0:82f:b45c:d628])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:258c:b0:398:a33a:71c9
 with SMTP id adf61e73a8af0-3a08d8d7b4dmr29123088637.43.1776896248711; Wed, 22
 Apr 2026 15:17:28 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:17:27 -0700
In-Reply-To: <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com>
 <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
 <aegV3ELp20DlC5Ge@google.com> <aekrJrSRoclZoBo9@google.com>
 <aekw1S5Gdkyx8teC@google.com> <CAO9r8zPhxn9dUKoXwM2JHF4TwG+PeTd8GhDO_kqG+kuwRW1g=g@mail.gmail.com>
Message-ID: <aelI9_CAcZjGXj7v@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> On Wed, Apr 22, 2026 at 1:34=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, Apr 22, 2026, Yosry Ahmed wrote:
> > > > > Perhaps we just need to rename the functions (e.g.
> > > > > kvm_vcpu_map_page()), or more intrusively pass in a size and do b=
ounds
> > > > > checking.
> > > >
> > > > Definitely the latter.  Or both I guess, but probably just the latt=
er.
> > >
> > > I think both. I think renaming to kvm_vcpu_map_page() (and similar fo=
r
> > > others) would further clarify things, especially with the introductio=
n
> > > of kvm_vcpu_map_ptr() below.
> >
> > I don't like "page" it's too easy to incorrectly assume "page" means "s=
truct page".
> > There are KVM APIs that do use "page" generically, e.g. kvm_read_guest_=
page(),
> > but for this particular case I'd like to stay away from "page; there's =
a _lot_
> > of ugly history around mapping "struct page" vs. "other" memory in KVM.
>=20
> Maybe kvm_vcpu_map_guest_page()? or if you reaaaally wanna be clear
> about it kvm_vcpu_map_page_sized_chunk_of_guest_memory() :P

And rename all the extensions to .java while we're at it.

I can live with kvm_vcpu_map_guest_page().  kvm_vcpu_map_ptr() becomes a bi=
t
odd, but kvm_vcpu_map_guest_ptr() is even worse.
