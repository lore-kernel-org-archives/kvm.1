Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09ED3ACA40
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781653531; cv=none; b=oYf5ye6luTt0OEKFI1SngMg8/98rE/4OlzfNaURxdDX10nhqhFml0mHnNO8jVtNlG73+IJTkW5epNSIGjIs8Bv5rls8plHWOPvPg1Aus3w/9GI8+i1T5kWvC91+qxA/E+lURK+9lF0uqZU22/NyRVx3InZdF+cl6RamTvMAqS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781653531; c=relaxed/simple;
	bh=16FdF+8KRRwGkmUVfkz520e49m5ljHkYq+kCwrk0BLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rp7omSu16qYPKGBq8VswVataPmfmPKAPxcFgctARfurSvcewU7ZIZmER1mDlubOomBJBNiSEHPaCsbttemhmQcKfiCeGXB/aZ+CgmUb9xI5cS/boo7n38Z86ai3FGvZGgE9WB7vyElSQf4Zx+HivoSo13lcPQgnhdiw0ZO745lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPiPjLZx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPiPjLZx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6afd85980so5571985ad.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 16:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781653530; x=1782258330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAFI39glauqKUEgpwVMjHDY3YmqRLmF/ZzLTz3aSwtw=;
        b=hPiPjLZx7lPmCryWiYdXKqMaOq6KICxQaDgfMBQfNikCx4jZYcFCE1UnRYnna3O/ck
         u9SAn4r+Tk2c/RXLC97Kf27diQG3gN5+4ByQh3V8B2lpeBL+VTN32udgc7NJSRUeFPBW
         DXxSwzgFNw1H3BU63g1J/kom7UfsBAVAv+qG44xdolZYjvyN10unOUU2QBJidBniIQHd
         YN9Cm0/DAlgn0bo2EmCG65YitGkpZVKixF9TJV0LIYgq8lpjybGmOGN7Z08G1BQdmmc7
         Zf1p29fyfB2shVbVtD2JewC5hfRJZDLDVstHutOavpQchs5fJJMg/R6tDOCn8kv7fjl0
         qBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781653530; x=1782258330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAFI39glauqKUEgpwVMjHDY3YmqRLmF/ZzLTz3aSwtw=;
        b=lTumPAJI0zZcAXutqcaWteOKCp9m1KdYp21gI7mzDmvdQjr976QTCmeI+Ky1kRNfwr
         AUktz8hNkeILSLeNEOi/enYlsk3VqoWgrwd/k/uMEHxcZS74Ee+JdgheA4dFKi5gJqXY
         NEaLPfPa49TJFD00/5abinqjmtzsiXqqOk2dTfXW+Z3BebV2y4HNHG2hwuW5ynjJm92T
         qFKuL/bdsA5+I43+vU+Fz85xmfh9RsZ7u5nj+rxZwGKFZGTOHPCetltZ1pH0hMVrhyIl
         +JtNaEcvQv+qc9S0uJ8unL2pp3u9idaGFoIaTY4DtuGxYYYkwdm19tC7jqBeRa0WUWrU
         2G1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8FWqy6InywODCCjwY3jxHgEfnJhZeUL7xtEfd8Lw8swyyuvGbziG0j4yruHkJumhgMPFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeJSfIFpBPtWKojXzZeDckUNo0rbWCHqf/xlVAeT7GB9IMvvb
	Kfm8PX13BKnB1P9GqP9amYEYUbP4awccpHwrM9OjMz0jCn9qfHbRaEVo3+Z2CyzV964lE0erXWl
	Yy/vOrQ==
X-Received: from plmm19.prod.google.com ([2002:a17:902:c453:b0:2c6:a230:e579])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2450:b0:2b4:59bf:5728
 with SMTP id d9443c01a7336-2c6bc23c746mr10172645ad.25.1781653529670; Tue, 16
 Jun 2026 16:45:29 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:45:29 -0700
In-Reply-To: <479741e62038c0e051c0fcfb3691b13afda80d06.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-19-seanjc@google.com>
 <906e9797-08d4-4ebe-aed3-34002aa1f917@linux.intel.com> <3be528f30351ae8744276107fe1060cb222077ca.camel@intel.com>
 <144cfc22-10fb-46db-a42e-f4ea8986d353@linux.intel.com> <b6721d022187966290f8ea04766ffb1268407ca1.camel@intel.com>
 <ajF3il4nLemXBOle@google.com> <479741e62038c0e051c0fcfb3691b13afda80d06.camel@intel.com>
Message-ID: <ajHgGQllKbRqxK2b@google.com>
Subject: Re: [PATCH v4 18/30] KVM: x86: Move "struct kvm_x86_msr_filter"
 definition to msrs.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "yosry@kernel.org" <yosry@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Kai Huang wrote:
> On Tue, 2026-06-16 at 09:19 -0700, Sean Christopherson wrote:
> > On Tue, Jun 16, 2026, Kai Huang wrote:
> > Unfortunately, every RCU macro I can find does typeof(*p) somewhere in its flow.
> > But I would still strongly prefer to open code a __force to strip the __rcu than
> > expose the structures outside of msrs.c and pmu.c.
> > 
> > This makes gcc8 and gcc9 happy on my end.  I'll squash the changes into their
> > respective patches, and update the changelogs.
> 
> Fine to me (seems we are having more and more functional changes in this series
> but this particular change may not be the case).

Yeah, because KVM hardcodes a '1' to the dereference check, in practice this
isn't a functional change.

> >         kvfree(rcu_dereference_check(kvm->arch.apic_map, 1));
> 
> Btw, this made me look at apic_map too.  And seems we can also move "struct
> kvm_apic_map" to "lapic.h".  We cannot move it to lapic.c because
> kvm_sched_yield() in x86.c actually references the members of the structure.

Ya, good eyes, I'll slip in yet another patch.
