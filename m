Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E445BD6B
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998282; cv=none; b=DtQMxyzcPvKFWqDGG3vWm4nLnWvUlOItziTcd2FrSCBchtJI6/5HXjrbDu4xyumflmoMTUnEqd6R3FtXIcT4I7TIQnMaFUZ3g+uY/5xf9UPGwZDPR3xO+kkVqEbiQfHGENtVWJb+Ld1gVl9nsUSgImJ7cgqtGCrd63HdvrIxNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998282; c=relaxed/simple;
	bh=pN/i0QyQE864eRZEEAl0yyK2SbJLSBPkZs34zuowLPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dPPiLXCP+m+Ook9wFovsG3GR/sm8aSv9mFdU+hOg/RlPd+BReq7L0TiM+dYS2o+Cha12HuyDGuTPvfVXrVmIp6Pg+xIBx1prSTpbNdCWYTU3TKtvXxGSkxxR4CfAJC27Y3JqYKKVAvqkCwVPwx1r89RzJ6haph9zm2GydskgdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwfV7vFy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwfV7vFy"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c70d1f56eso3795658b3a.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 16:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774998281; x=1775603081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEnbERBIDQ4MTbld4MJTDZBsNz2jmuUspcqZ6/0jR0c=;
        b=UwfV7vFy5iNtxMa3P8nxUoc3VApmSv0ffRGPpW1GMypBmFEWaDkT2vLAEBQMRHFN0a
         7lzW0xL7Y4G+bXsEyj69MIxwAJwWmoE6JyF1YiV7uDzWIRqYA71Cyd+Jp8NDne0cGtyc
         ywyEF+w9tv7CYcjzjOkh+Zi4jN/W98ghEbgBDXK29/YrjIFJE9LVOKuwiLeDOngd2JVQ
         /GgT035yI3L0+iNw8NUA4T4Hi9oTl6m/K6UHAmMSh0qGfaZi+Vu1eQePmN854GJBLKPq
         rfhxQju4zij6x+w4F/JCDjzcmT6XYai0wbhM0qVdCrWlI/K4FSUoEjlmfpf+SFq1ciWL
         FM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998281; x=1775603081;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HEnbERBIDQ4MTbld4MJTDZBsNz2jmuUspcqZ6/0jR0c=;
        b=WvXMuz+q4ekxXZNy2RtuBb4LIejHVuS+8p+GkTtGpYD8+hga6GVcWTJCpAc2vDnXwd
         yghwMSjtfoWS2J/XSBolOtoYpSswhmQvKmiFm7khf3KOYtx72PWk7scYxgutHH+vDJIa
         +FlNsxTpVZWpAFY0o48QRKTvWQ/0aAUYnadvnZw0srl/CdMrd2PHzC9383+st7V4R9ll
         6avfDxOSxx3RJKZxksJdgSpXIpl6qwkIibVMclpkYNBXdu0l5p+uRG3aFEGqrTTBgbMw
         rgF0P7pvcmBP6yVcmvqDVKK+/qcb3N918MYJx8SVi4BO29fZ6PkatShm57QKh+520elX
         3xiw==
X-Forwarded-Encrypted: i=1; AJvYcCXcfZVEoPseMH36ckXkIrLObk9Tnsxs6IygZzlCBeG81WLU4eDYil354WyEKHNKcwQS/a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5gZcd1nFX1R01wnghHUfzo0xXxcXF6xM+tY9JL876J5/2DbV
	J4kta/zM0jai0MY494v17oNlp2e4uG+Pnc4g1a96He2xz9n7ibq7QUmflvB/xWnkwyTSGTfaCbu
	2AYQPRA==
X-Received: from pfbw8.prod.google.com ([2002:a05:6a00:b488:b0:82a:128b:1d95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c86:b0:82a:190b:2225
 with SMTP id d2e1a72fcca58-82ce8992790mr1124317b3a.31.1774998280940; Tue, 31
 Mar 2026 16:04:40 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:04:39 -0700
In-Reply-To: <6ad3ff51bbab85147b716de0b1f4e8b994b1998b.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
 <acwe7kKyjfEQ0sIf@google.com> <6ad3ff51bbab85147b716de0b1f4e8b994b1998b.camel@intel.com>
Message-ID: <acxTBwaw6_xYSShf@google.com>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into arch/x86
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Vishal L Verma <vishal.l.verma@intel.com>, Kai Huang <kai.huang@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026, Rick P Edgecombe wrote:
> On Tue, 2026-03-31 at 12:22 -0700, Sean Christopherson wrote:
> > > -
> > > -#ifdef CONFIG_KEXEC_CORE
> > > -void tdx_cpu_flush_cache_for_kexec(void)
> > > -{
> > > -	lockdep_assert_preemption_disabled();
> >=20
> > Is there a pre-existing bug here that gets propagate to tdx_shutdown_cp=
u()?=C2=A0
> > When called from kvm_offline_cpu(), preemption won't be fully disabled,=
 but
> > per-CPU access are fine because the task is pinned to the target CPU.
> >=20
> > See https://lore.kernel.org/all/aUVx20ZRjOzKgKqy@google.com
>=20
> Yes. And actually it got hit during development of this series. This patc=
h will
> conflict with the fix:
> https://lore.kernel.org/lkml/20260312100009.924136-1-kai.huang@intel.com/
>=20
> Oh, you acked it actually. But I was under the impression that after this=
 patch
> here, the splat wouldn't be triggered. So it inadvertently fixes it.

Ah, that's why I was a bit confused.  I was assuming tdx_shutdown_cpu() was=
 a
cpuhp callback, but it's actually an IPI callback.

Hmm, isn't this patch wrong then?  Ah, no, the changelog says:

  However, WBINVD is already generally done at CPU offline as matter of cou=
rse.
  So don't bother adding TDX specific logic for this, and rely on the norma=
l
  WBINVD to handle it.

What's the "normal" WBINVD?  At the very least, tdx_offline_cpu() should ha=
ve a
comment that explicitly calls out where that WBVIND is.  I assume you're re=
ferring
to the wbinvd() calls in things like hlt_play_dead()?

But unless the WBINVD is actually costly, why bother getting fancy?

> But that other patch is much more backport friendly.

